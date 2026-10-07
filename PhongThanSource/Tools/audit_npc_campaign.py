"""Read-only payload audit for every unresolved NPC, with a saved batch report.

Uses actual PAK indexes/payloads. Paths in old scan manifests are discovery hints,
not proof of content. Never treats anonymous passerby rows as named identities.
"""
from __future__ import annotations
import argparse
import ctypes
import hashlib
import json
import re
import struct
from pathlib import Path
from prepare_npc_restoration import PakReader, pak_id, rows, disk_path, split_region, npc_records

PROJECT = Path(__file__).resolve().parents[1]
BASE = PROJECT.parent
OLD_SCAN = BASE / 'SourceMigration/staging/p0.3-source-search/entry-source-audit-final.json'
LISTING = BASE / 'SeaweedUnpack_SprView/SeaweedUnpack_SprView/ListPak/PhongThan/scripts_exact.txt'
DLL = BASE / 'SeaweedUnpack_SprView/SeaweedUnpack_SprView/UnpackCore.dll'


def classify(path):
    parts = {p.lower() for p in path.parts}
    if parts & {'autoupdate','vng-official-2015','vng-official-2024','tai nguyen vng'}:
        return 'VNG_PACKAGE_CANDIDATE'
    if parts & {'phongthanruntime-content','phongthanruntime-staging'}:
        return 'ACTIVE_VNG_CHAIN'
    if parts & {'tamhepc','phuchung-paks','thaptuyettran_full_v1.23','fsthoidai','origin','pt2008','ptchinhtong','tamgioipt','fstruyenky'}:
        return 'COMMUNITY_PAK'
    return 'OTHER_PAK_PROVENANCE_UNCONFIRMED'


def main():
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--write-report',action='store_true')
    args=ap.parse_args()
    current=json.loads((PROJECT/'Docs/NPC_RESTORATION_DEPLOYMENT.json').read_text('utf8'))
    pending=[n for n in current['rows'] if n['status']=='PENDING']
    reader=PakReader(BASE/'PhongThanRuntime-Content/Client',DLL)
    try:
        active=rows(reader.get('settings/Npcs.txt')[0])[1:]
        template_key=pak_id(b'\\settings\\npcs.txt')
        names={n['original_name'] for n in pending if n['original_name']}
        old=json.loads(OLD_SCAN.read_text('utf8'))
        paths={Path(s['source']) for s in old['sources'] if s.get('kind')=='local'}
        paths.update(reader.paks)
        # Name/path discovery only; every result must exist and decompress in a PAK.
        logicals={s.strip().lstrip('\\') for s in LISTING.read_text('utf-8-sig').splitlines() if s.lower().endswith('.lua')}
        logicals.update(n.get('lua_candidate','').lstrip('\\') for n in pending if n.get('lua_candidate'))
        logicals.update(n['lua']['logical'].lstrip('\\') for n in pending if n.get('lua'))
        # Common name aliases are search candidates, never automatic identity assertions.
        for scope in ['龙套','玉虚宫','西岐','朝歌','瑶池','孟津','崇城大营','蚩尤墓','不周天关','不周山','狱法山','阪泉圣地']:
            for name in names:
                logicals.add(f'script\\{scope}\\{name}.lua')
        exact_by_id={}
        for logical in logicals:
            try:key=pak_id(logical.encode('gbk'))
            except UnicodeEncodeError:continue
            exact_by_id.setdefault(key,[]).append(logical)
        # Also inspect original binary placement records as identity references.
        # Region_C is evidence only; this audit never publishes map bytes.
        world_ini=(BASE/'PhongThanRuntime-Content/Server/settings/WorldSet.ini').read_bytes().decode('gbk')
        world_names=dict(re.findall(r'^(\d+)=([^\r\n]+)',world_ini,re.M))
        region_keys={}
        for world in sorted({n['world'] for n in pending}):
            name=world_names[str(world)]
            wor=disk_path(BASE/'PhongThanRuntime-Content/Server',f'maps\\{name}.wor')
            if not wor.exists():continue
            bounds=re.search(rb'(?im)^rect\s*=\s*(\d+),(\d+),(\d+),(\d+)',wor.read_bytes())
            if not bounds:continue
            left,top,right,bottom=map(int,bounds.groups())
            for x in range(left,right+1):
                for y in range(top,bottom+1):
                    for folder,suffix in [(name,'region_s'),(name+'_S','region_s'),(name,'region_c'),(name,'npc_s')]:
                        logical=f'maps\\{folder}\\v_{y:03d}\\{x:03d}_{suffix}.dat'
                        region_keys[pak_id(logical.encode('gbk'))]=(world,logical,suffix)
        indexes=set();template_hashes=set();payload_hashes=set()
        catalog=[];identities=[];scripts=[];errors=[];source_reports=[];placement_references=[];region_hashes=set();spawn_contexts=[]
        for pak in sorted(paths,key=lambda p:(0 if p in reader.paks else 1,str(p))):
            if not pak.is_file():continue
            try:
                with pak.open('rb') as stream:
                    head=stream.read(32)
                    sig,count,off=struct.unpack_from('<4sII',head)
                    if sig!=b'PACK' or count>2000000 or off+count*16>pak.stat().st_size:continue
                    stream.seek(off);index=stream.read(count*16)
                digest=hashlib.sha256(index).hexdigest()
                if digest in indexes:continue
                indexes.add(digest)
                candidates=[(i,*rec) for i,rec in enumerate(struct.iter_unpack('<IIII',index)) if rec[0]==template_key or rec[0] in exact_by_id or rec[0] in region_keys]
                if not candidates:continue
                handle=reader.dll.CreatePak()
                if reader.dll.PakLoad(handle,str(pak).encode('mbcs'))<=0:
                    reader.dll.DestroyPak(handle);continue
                source_reports.append(dict(pak=str(pak),kind=classify(pak),index_sha256=digest,matched_entry_candidates=len(candidates)))
                try:
                    for i,key,pos,size,flags in candidates:
                        if not 0<size<8000000:continue
                        buffer=ctypes.create_string_buffer(size)
                        if reader.dll.PakReadBlock(handle,i,buffer,size)!=size:continue
                        data=buffer.raw;sha=hashlib.sha256(data).hexdigest()
                        evidence=dict(pak=str(pak),source_kind=classify(pak),entry=i,id=f'{key:08X}',sha256=sha,bytes=size)
                        if key in region_keys:
                            if sha in region_hashes:continue
                            region_hashes.add(sha)
                            world,logical,suffix=region_keys[key]
                            try:
                                payload=data if suffix=='npc_s' else split_region(data)[2]
                                records=npc_records(payload)
                            except (ValueError,struct.error):continue
                            for record in records:
                                tid,x,y=struct.unpack_from('<iii',record)
                                kind=struct.unpack_from('<h',record,54)[0]
                                name=record[16:48].split(b'\0')[0].decode('gbk','replace').strip()
                                if kind!=3 or not name or not 0<=tid<len(active):continue
                                placement_references.append(dict(world=world,name=name,template=tid,
                                    logical=logical,script=record[60:].rstrip(b'\0').decode('gbk','replace'),
                                    resource=active[tid][12].decode('gbk','replace'),evidence=evidence,
                                    coordinates_not_used=[x,y]))
                            continue
                        if key==template_key:
                            if sha in template_hashes:continue
                            template_hashes.add(sha)
                            tab=rows(data)
                            if not tab or b'NpcResType' not in tab[0]:continue
                            header=tab[0];col=header.index(b'NpcResType');kindcol=header.index(b'Kind')
                            catalog.append(dict(**evidence,template_count=len(tab)-1))
                            for tid,row in enumerate(tab[1:]):
                                if len(row)<=max(col,kindcol) or row[kindcol]!=b'3':continue
                                name=row[0].decode('gbk','replace').lstrip('#$').strip()
                                clean=re.sub(r'[（(]对话[）)]$','',name)
                                if clean not in names:continue
                                resource=row[col]
                                active_ids=[a for a,r in enumerate(active) if r[1]==b'3' and r[12]==resource]
                                identities.append(dict(name=clean,source_template=tid,resource=resource.decode('gbk','replace'),active_template_candidates=active_ids,evidence=evidence))
                            continue
                        if sha in payload_hashes:continue
                        payload_hashes.add(sha)
                        refs=exact_by_id[key]
                        decoded=data.decode('gbk','replace')
                        lines=decoded.replace('\r','').split('\n')
                        if re.search(r'(?i)addnpc|npctemplate|npcres|NpcId',decoded):
                            for line_number,line in enumerate(lines):
                                if not re.search(r'(?i)addnpc|npctemplate|npcres|NpcId',line):continue
                                context='\n'.join(lines[max(0,line_number-4):line_number+5])
                                matches=sorted(n for n in names if n in context)
                                if matches:spawn_contexts.append(dict(paths=refs,names=matches,line=line_number+1,context=context,evidence=evidence))
                        if not re.search(rb'\bfunction\s+main\s*\(',data):continue
                        # Keep matches for named NPCs or common functional NPC categories.
                        match_names=sorted(name for name in names if any(name in p for p in refs) or name in decoded[:500])
                        keywords=r'新手|生活|考古|商店|西域|奖励|转生|龟|元帅|密探|修行|vip|神秘|红娘|太上|安安|燕云|药师|导师'
                        if match_names or any(re.search(keywords,p,re.I) for p in refs):
                            includes=[m.decode('gbk','replace') for m in re.findall(rb'(?i)Include\s*\(\s*["\']([^"\']+)',data)]
                            scripts.append(dict(paths=refs,names=match_names,evidence=evidence,includes=includes,preview=decoded[:350]))
                finally:reader.dll.DestroyPak(handle)
            except (OSError,ValueError,struct.error) as e:errors.append(dict(pak=str(pak),error=str(e)))
        batch=[]
        for n in pending:
            name=n['original_name'];identity=[i for i in identities if i['name']==name] if name else []
            script=[s for s in scripts if name and name in s['names']]
            placements=[r for r in placement_references if name and r['name']==name]
            desired=(n.get('lua_candidate') or n.get('lua',{}).get('logical','')).lstrip('\\')
            exact_lua=[s for s in script if desired and desired in s['paths']]
            decision=[]
            if not identity and not placements:decision.append('NO_NAME_TEMPLATE_EVIDENCE_FOUND')
            if not exact_lua:decision.append('NO_EXACT_MAP_LUA_FOUND')
            elif not any(s['evidence']['source_kind'] in ('ACTIVE_VNG_CHAIN','VNG_PACKAGE_CANDIDATE') for s in exact_lua):
                decision.append('COMMUNITY_LUA_REQUIRES_COMPATIBILITY_REVIEW')
            if identity or placements:decision.append('IDENTITY_CANDIDATE_REQUIRES_REVIEW')
            batch.append(dict(world=n['world'],name=n['name'],original_name=name,
                              known_template=n.get('template'),identity_candidates=identity,lua_candidates=script,
                              placement_identity_candidates=placements,exact_map_lua_candidates=exact_lua,
                              previous_reasons=n['reasons'],decision=decision))
        report=dict(schema=1,scope='ALL_126_PENDING_NPCS',requested=len(pending),unique_pak_indexes=len(indexes),
                    template_payloads=catalog,source_packages=source_reports,script_payload_count=len(scripts),
                    placement_references=placement_references,region_payloads_checked=len(region_hashes),
                    spawn_contexts=spawn_contexts,
                    errors=errors,rows=batch,auto_deploy=False)
        report['batch_summary']={
            'rows_without_name_template_evidence':sum('NO_NAME_TEMPLATE_EVIDENCE_FOUND' in n['decision'] for n in batch),
            'rows_without_exact_map_lua':sum('NO_EXACT_MAP_LUA_FOUND' in n['decision'] for n in batch),
            'rows_with_community_only_exact_lua':sum('COMMUNITY_LUA_REQUIRES_COMPATIBILITY_REVIEW' in n['decision'] for n in batch),
            'runtime_modified':False,
            'all_126_deployable':False,
            'next_authority_needed':'Approve authored visual reconstruction and new NPC-specific Lua behavior where original identity/logic is unavailable; no anonymous placeholders or fake completion.'
        }
        if args.write_report:
            (PROJECT/'Docs/NPC_CAMPAIGN_126_AUDIT.json').write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n','utf8')
        print(json.dumps(dict(requested=len(pending),unique_pak_indexes=len(indexes),template_tables=len(catalog),
            named_identity_names=sorted({i['name'] for i in identities}),lua_candidates=len(scripts),
            placement_identity_names=sorted({i['name'] for i in placement_references}),
            region_payloads_checked=len(region_hashes),errors=errors),ensure_ascii=False))
    finally:reader.close()


if __name__=='__main__':
    import sys
    sys.stdout.reconfigure(encoding='utf8')
    main()
