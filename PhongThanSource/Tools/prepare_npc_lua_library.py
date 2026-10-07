"""Recover NPC Lua candidates and dependency closures; never deploy candidates.

Inputs are saved audit evidence and real PAK bytes. Each version is retained by
SHA256, rather than choosing a community implementation by filename alone.
"""
from __future__ import annotations
import argparse, ctypes, hashlib, json, re, struct, sys
from collections import Counter, deque
from pathlib import Path
from prepare_npc_restoration import PakReader, pak_id, rows

ROOT = Path(__file__).resolve().parents[1]
BASE = ROOT.parent
LIBRARY = ROOT / 'SourceMigration/NpcLuaLibrary'
DLL = BASE / 'SeaweedUnpack_SprView/SeaweedUnpack_SprView/UnpackCore.dll'
TOKEN = re.compile(r'--\[\[.*?\]\]|--[^\r\n]*|\[\[.*?\]\]|"(?:\\.|[^"\\])*"|\'(?:\\.|[^\'\\])*\'|[A-Za-z_]\w*|[^\s]', re.S)


def logical_path(value):
    value = value.replace('\\\\', '\\').replace('/', '\\').lstrip('\\')
    if not value or ':' in value or '\0' in value or len(value.encode('gbk')) >= 240:
        raise ValueError('unsafe logical path')
    parts = value.split('\\')
    if any(p in ('', '.', '..') for p in parts):
        raise ValueError('unsafe path component')
    if parts[0].lower() != 'script' or not value.lower().endswith(('.lua', '.luax')):
        raise ValueError('not a script dependency')
    return '\\' + value


def dependencies(data):
    # Strings are tokens: function names inside dialogue/comments are not calls.
    tokens = [t for t in TOKEN.findall(data.decode('gbk', 'replace')) if not t.startswith('--')]
    result = []; dynamic = []
    for i, token in enumerate(tokens):
        if token not in ('Include', 'require'): continue
        if i and tokens[i-1] in ('function', '.', ':'): continue
        j = i + 1
        if j < len(tokens) and tokens[j] == '(': j += 1
        if j >= len(tokens) or tokens[j][:1] not in ('"', "'"):
            dynamic.append(token); continue
        # A literal prefix concatenated with an expression is not a full path.
        if j+1 < len(tokens) and tokens[j+1] == '.':
            dynamic.append(token); continue
        value = tokens[j][1:-1]
        try:
            if token == 'require':
                if not value.lower().endswith('.luax'): value += '.luax'
                value = 'script\\common\\' + value
            result.append({'call':token, 'path':logical_path(value)})
        except (ValueError, UnicodeEncodeError):
            dynamic.append(token + ':' + value)
    return result, dynamic


class Packages:
    def __init__(self, reader, sources):
        self.reader=reader; self.packages={}; self.handles={}; self.payloads={}; self.rejected=[]
        for item in sources:
            path=Path(item['pak'])
            if not path.is_file():
                self.rejected.append(dict(pak=str(path),reason='MISSING_PACKAGE'));continue
            with path.open('rb') as f:
                header=f.read(32); sig,count,offset=struct.unpack_from('<4sII',header)
                if sig!=b'PACK' or count>2000000 or offset+count*16>path.stat().st_size:
                    raise ValueError(f'Invalid PAK: {path}')
                f.seek(offset); index=f.read(count*16)
            digest=hashlib.sha256(index).hexdigest()
            if digest!=item['index_sha256']:
                self.rejected.append(dict(pak=str(path),reason='INDEX_CHANGED_SINCE_AUDIT',expected=item['index_sha256'],actual=digest));continue
            self.packages[str(path)]={'kind':item['kind'],'index_sha256':digest,
                'index':{rec[0]:(n,*rec) for n,rec in enumerate(struct.iter_unpack('<IIII',index))}}

    def get(self, pak, logical):
        pack=self.packages.get(pak)
        if not pack:return None
        entry=pack['index'].get(pak_id(logical.encode('gbk')))
        if not entry:return None
        n,key,offset,size,flags=entry
        if not 0<size<8*1024*1024:return None
        if (pak,n) not in self.payloads:
            if pak not in self.handles:
                handle=self.reader.dll.CreatePak()
                if self.reader.dll.PakLoad(handle,pak.encode('mbcs'))<=0:
                    self.reader.dll.DestroyPak(handle);raise ValueError(f'Cannot open {pak}')
                self.handles[pak]=handle
            buffer=ctypes.create_string_buffer(size)
            if self.reader.dll.PakReadBlock(self.handles[pak],n,buffer,size)!=size:
                raise ValueError(f'Incomplete payload {pak}:{n}')
            data=buffer.raw
            self.payloads[pak,n]=(data,dict(pak=pak,source_kind=pack['kind'],entry=n,
                id=f'{key:08X}',sha256=hashlib.sha256(data).hexdigest(),bytes=size,
                index_sha256=pack['index_sha256']))
        return self.payloads[pak,n]

    def dependency(self, pak, logical):
        # Keep a candidate's own family together; do not silently mix scripts
        # from unrelated private servers. Record ambiguity instead.
        own=self.get(pak,logical)
        if own:return own,'SAME_PACKAGE'
        siblings=[]
        for other in self.packages:
            if other!=pak and Path(other).parent==Path(pak).parent:
                found=self.get(other,logical)
                if found:siblings.append(found)
        hashes={f[1]['sha256'] for f in siblings}
        if len(hashes)==1:return siblings[0],'SAME_FAMILY'
        if len(hashes)>1:return None,'AMBIGUOUS_FAMILY_VERSIONS'
        active=self.reader.get(logical)
        if active:
            proof=dict(active[1],pak=str(BASE/'PhongThanRuntime-Content/Client/data'/active[1]['pak']),
                       source_kind='ACTIVE_VNG_CHAIN')
            return (active[0],proof),'ACTIVE_VNG_DEPENDENCY_CANDIDATE'
        return None,'MISSING'

    def close(self):
        for h in self.handles.values():self.reader.dll.DestroyPak(h)


def main():
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--write',action='store_true')
    args=parser.parse_args()
    audit=json.loads((ROOT/'Docs/NPC_CAMPAIGN_126_AUDIT.json').read_text('utf8'))
    deployed=json.loads((ROOT/'Docs/NPC_RESTORATION_DEPLOYMENT.json').read_text('utf8'))
    reader=PakReader(BASE/'PhongThanRuntime-Content/Client',DLL)
    packages=Packages(reader,audit['source_packages'])
    try:
        seeds={}; verified=0; blobs={}; entries={}; queue=deque(); edges=[]
        names={n['original_name'] for n in audit['rows'] if n['original_name']}
        for row in audit['rows']:
            for candidate in row['lua_candidates']:
                e=candidate['evidence']
                for path in candidate['paths']:seeds[e['pak'],logical_path(path)]=e
        # 496 was an in-memory audit count. The saved report serialized only
        # per-NPC matches. Revisit known logical IDs in its recorded packages
        # to recover the category scripts omitted from those per-NPC rows.
        listing=BASE/'SeaweedUnpack_SprView/SeaweedUnpack_SprView/ListPak/PhongThan/scripts_exact.txt'
        paths=set(); rejected_paths=[]
        for p in listing.read_text('utf-8-sig').splitlines():
            if not p.strip().lower().endswith(('.lua','.luax')):continue
            try:paths.add(logical_path(p.strip()))
            except (ValueError,UnicodeError):rejected_paths.append(p)
        for _,path in seeds:paths.add(path)
        deployed_roots=set()
        for row in deployed['rows']:
            for field in ('lua','lua_original'):
                e=row.get(field)
                if e and e.get('logical') and 'phongthan\\npc_restore' not in e['logical']:
                    path=logical_path(e['logical']);paths.add(path);deployed_roots.add(path)
        template_data=reader.get('settings/Npcs.txt')[0]
        template_roots=[]
        for tid,row in enumerate(rows(template_data)[1:]):
            for cell in row:
                if cell.lower().endswith(b'.lua'):
                    try:path=logical_path(cell.decode('gbk'));paths.add(path)
                    except (ValueError,UnicodeError):continue
                    template_roots.append(dict(template=tid,kind=int(row[1] or 0),path=path))
        keywords=re.compile(r'新手|生活|考古|商店|西域|奖励|转生|龟|元帅|密探|修行|vip|神秘|红娘|太上|安安|燕云|药师|导师|赤松|合成|强化|升级',re.I)
        root_paths={r['path'] for r in template_roots}
        for pak in packages.packages:
            for path in sorted(paths):
                found=packages.get(pak,path)
                if not found:continue
                data,e=found
                named=any(n in path or n in data[:500].decode('gbk','replace') for n in names)
                if (pak,path) not in seeds and path not in root_paths and path not in deployed_roots and not (named or keywords.search(path)):
                    continue
                expected=seeds.get((pak,path))
                if expected and (e['sha256']!=expected['sha256'] or e['entry']!=expected['entry']):
                    raise ValueError(f'Historical evidence mismatch: {pak}:{path}')
                if expected:verified+=1
                queue.append((path,data,e,True))
        def add(path,data,e,is_root):
            key=(path,e['pak'],e['sha256'])
            if key in entries:
                entries[key]['root'] |= is_root; return key,False
            deps,dynamic=dependencies(data)
            blobs[e['sha256']]=data
            entries[key]=dict(path=path,evidence=e,root=is_root,
                object=f"objects/{e['sha256']}.lua",dependencies=deps,dynamic_dependencies=dynamic,
                runtime_enabled=False,review='NOT_FUNCTIONALLY_REVIEWED')
            return key,True
        while queue:
            path,data,e,is_root=queue.popleft();key,new=add(path,data,e,is_root)
            if not new:continue
            if len(entries)>12000:raise ValueError('Dependency graph limit exceeded')
            for dep in entries[key]['dependencies']:
                found,status=packages.dependency(e['pak'],dep['path'])
                edge=dict(parent=list(key),dependency=dep,status=status)
                if found:
                    payload,proof=found
                    edge['target']=[dep['path'],proof['pak'],proof['sha256']]
                    queue.append((dep['path'],payload,proof,False))
                edges.append(edge)
        report=dict(schema=1,scope='SOURCE_VERIFIED_CANDIDATES_NOT_RUNTIME',historical_in_memory_count=496,
            verified_saved_references=verified,unique_payloads=len(blobs),entries=list(entries.values()),
            template_references=template_roots,edges=edges,
            source_tiers=dict(Counter(e['evidence']['source_kind'] for e in entries.values())),
            unresolved_edges=sum('target' not in e for e in edges),
            dynamic_dependency_files=sum(bool(e['dynamic_dependencies']) for e in entries.values()),
            rejected_sources=packages.rejected,rejected_discovery_paths=rejected_paths,runtime_modified=False)
        if args.write:
            (LIBRARY/'objects').mkdir(parents=True,exist_ok=True)
            for sha,data in blobs.items():
                target=LIBRARY/'objects'/f'{sha}.lua'
                if target.exists() and target.read_bytes()!=data:raise ValueError('Object hash conflict')
                if not target.exists():target.write_bytes(data)
            (ROOT/'Docs/NPC_LUA_LIBRARY.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n','utf8')
        print(json.dumps({k:v for k,v in report.items() if k not in ('entries','edges','template_references','rejected_discovery_paths')},ensure_ascii=False))
    finally:packages.close();reader.close()


if __name__=='__main__':
    sys.stdout.reconfigure(encoding='utf8');main()
