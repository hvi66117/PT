"""Produce the project-owned derivative of VNG normal.lua; never edit the PAK.

The original payload remains immutable in the content-addressed Lua library.
All substitutions below are count-checked against its pinned SHA256.
"""
from __future__ import annotations
import argparse
import hashlib
import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
SOURCE_SHA = '44655595cd21f0748a44cf58270376d68d2b0e5cad3a709f0273d395d07ce438'
PROJECT = ROOT / 'Deploy/ProjectContent/NpcQuests'
LOGICAL = r'\script\phongthan\npc_quests\normal.lua'


def replace_once(data: bytes, old: bytes, new: bytes) -> bytes:
    if data.count(old) != 1:
        raise ValueError('VNG source context changed: ' + repr(old))
    return data.replace(old, new, 1)


def build() -> tuple[bytes, dict]:
    library = json.loads((ROOT / 'Docs/NPC_LUA_LIBRARY.json').read_text('utf-8'))
    matches = [e for e in library['entries']
               if e['path'].lower() == r'\script\npcdeath\normal.lua'
               and e['evidence']['source_kind'] == 'ACTIVE_VNG_CHAIN'
               and e['evidence']['sha256'].lower() == SOURCE_SHA]
    if not matches:
        raise ValueError('Pinned active-VNG normal.lua provenance not found')
    entry = matches[0]
    source = ROOT / 'SourceMigration/NpcLuaLibrary' / entry['object']
    data = source.read_bytes()
    if hashlib.sha256(data).hexdigest() != SOURCE_SHA:
        raise ValueError('Immutable VNG Lua object hash mismatch')

    data = replace_once(data, b'local\tcount=GetTask(898)\r\n\tlocal\tmark=',
        b'local\tcount=GetTask(898)\r\n\tif count <= 0 then return end\r\n\tlocal\tmark=')
    data = replace_once(data, b'if(GetTeam()~=0)then\t\t\t',
        b'if(GetTeamSize()>0)then\t\t\t')
    data = replace_once(data, b'local mark=0\r\n',
        b'local mark=0\r\n\tlocal n=0\r\n')
    data = replace_once(data, b'SetTask(889,SetByte(task_val, i, c))',
        b'SetTask(889,SetByte(GetTask(889), i, c))')
    data = replace_once(data, b'local count2= GetByte(task_val,4)\r\n',
        b'local count2= GetByte(task_val,4)\r\n'
        b'\t\t\tif count1 == 0 and count2 == 0 then return end\r\n')
    # Compatibility messaging only; no target or counter substitutions.
    data, names = re.subn(rb'npc_name\[(kindID|type1|type2|t)\]',
                         rb'PTQuestNpcName(\1)', data)
    if names != 12:
        raise ValueError(f'Unexpected NPC-name replacement count: {names}')
    patch = (PROJECT / 'normal_patch.lua').read_bytes()
    data += b'\r\n' + patch
    evidence = dict(schema=1, logical=LOGICAL, source=entry,
                    source_sha256=SOURCE_SHA,
                    patch_sha256=hashlib.sha256(patch).hexdigest(),
                    bytes=len(data), sha256=hashlib.sha256(data).hexdigest(),
                    edits=['solo/team-zero context', 'snapshot live team',
                           'per-member target and map', 'capped/repeat progress',
                           'atomic byte updates', 'template-name fallback'],
                    original_pak_modified=False, quest_rules_changed=False)
    return data, evidence


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--write', action='store_true')
    args = parser.parse_args()
    data, evidence = build()
    if args.write:
        output = PROJECT / 'compiled' / LOGICAL.lstrip('\\').replace('\\', '/')
        output.parent.mkdir(parents=True, exist_ok=True)
        output.write_bytes(data)
        (PROJECT / 'normal_provenance.json').write_text(
            json.dumps(evidence, ensure_ascii=False, indent=2) + '\n', 'utf-8')
    print(json.dumps(evidence, ensure_ascii=False, indent=2))


if __name__ == '__main__':
    main()
