"""Index recovered source candidates against every NPC without enabling them."""
import hashlib,json
from pathlib import Path

ROOT=Path(__file__).resolve().parents[1]
LIBRARY=ROOT/'SourceMigration/NpcLuaLibrary'

def main():
    library=json.loads((ROOT/'Docs/NPC_LUA_LIBRARY.json').read_text('utf8'))
    deployment=json.loads((ROOT/'Docs/NPC_RESTORATION_DEPLOYMENT.json').read_text('utf8'))
    audit=json.loads((ROOT/'Docs/NPC_CAMPAIGN_126_AUDIT.json').read_text('utf8'))
    by_identity={(n['world'],n['name']):n for n in audit['rows']}
    work=[]
    for npc in deployment['rows']:
        old=by_identity.get((npc['world'],npc['name']),{})
        hashes={c['evidence']['sha256'] for c in old.get('lua_candidates',[])}
        original=npc.get('lua_original') or (npc.get('lua') if not npc.get('authored') else None)
        path=original.get('logical','') if original else ''
        original_name=npc.get('original_name','')
        candidates=[e for e in library['entries'] if e['evidence']['sha256'] in hashes or
                    (path and e['path'].lower()==path.lower()) or
                    (original_name and e['path'].rsplit('\\',1)[-1]==original_name+'.lua')]
        candidates=list({(e['path'],e['evidence']['sha256']):e for e in candidates}.values())
        work.append(dict(world=npc['world'],name=npc['name'],template=npc.get('template'),
            current_script=npc.get('lua',{}).get('logical'),current_status=npc.get('lua_status','ORIGINAL_OR_EXISTING'),
            rule_source=npc.get('rule_source'),candidates=candidates,
            next_action='REVIEW_SOURCE_AND_DATA_CONTRACT' if candidates else ('RETRIEVE_EXISTING_ORIGINAL_PATH' if path or npc['status']=='EXISTING_PAK' else 'RECONSTRUCT_FROM_VERIFIED_RULES'),
            functional_acceptance=False))
    (ROOT/'Docs/NPC_LUA_IMPLEMENTATION_WORKLIST.json').write_text(json.dumps(work,ensure_ascii=False,indent=2)+'\n','utf8')
    lines=['# NPC Lua — danh sách triển khai theo nguồn','',
           'Các ứng viên chưa được bật tự động. Có file không đồng nghĩa chức năng đã được nghiệm thu.', '',
           '| Map | NPC | Lua hiện tại | Số phiên bản ứng viên | Việc tiếp theo |',
           '|---|---|---|---:|---|']
    for row in work:
        status={'AUTHORED_GUIDE_RULES_NOT_TRANSACTIONAL':'Chỉ hướng dẫn','AUTHORED_GUIDE_WITH_ORIGINAL_BRANCH':'Có nhánh gốc; chưa nghiệm thu'}.get(row['current_status'],'Gốc/đã có')
        action='Rà mã + ID/API + giao dịch' if row['candidates'] else ('Lấy lại Lua theo bản ghi gốc' if row['next_action']=='RETRIEVE_EXISTING_ORIGINAL_PATH' else 'Phục dựng từ luật đã xác minh')
        lines.append(f"| {row['world']} | {row['name']} | {status} | {len(row['candidates'])} | {action} |")
    (ROOT/'Docs/NPC_LUA_IMPLEMENTATION_WORKLIST.md').write_text('\n'.join(lines)+'\n','utf8')
    print(json.dumps(dict(npcs=len(work),with_candidates=sum(bool(n['candidates']) for n in work),without_candidates=sum(not n['candidates'] for n in work))))

if __name__=='__main__':main()
