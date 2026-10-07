import hashlib
import importlib.util
import json
import struct
import sys
import unittest
from pathlib import Path

ROOT=Path(__file__).parents[1]
sys.path.insert(0,str(ROOT/'Tools'))
from prepare_npc_lua_library import dependencies,logical_path
from prepare_npc_restoration import pak_id

class LibraryTests(unittest.TestCase):
    def test_dependencies_not_dialog_or_comment(self):
        data=b'-- Include("fake.lua")\nSay("Include bad")\nInclude("\\\\script\\\\lib.lua")\nrequire("tools.luax")'
        deps,dynamic=dependencies(data)
        self.assertEqual([x['path'] for x in deps],['\\script\\lib.lua','\\script\\common\\tools.luax'])
        self.assertEqual(dynamic,[])

    def test_dynamic_and_unsafe_paths_are_not_complete(self):
        self.assertTrue(dependencies(b'Include(prefix .. "x.lua")')[1])
        self.assertTrue(dependencies(b'Include("\\\\script\\\\" .. name)')[1])
        for path in ('../x.lua','script/../x.lua','C:/script/x.lua','script/a.txt'):
            with self.assertRaises(ValueError):logical_path(path)

    def test_every_saved_payload_matches_evidence(self):
        report=json.loads((ROOT/'Docs/NPC_LUA_LIBRARY.json').read_text('utf8'))
        seen=set()
        for entry in report['entries']:
            self.assertFalse(entry['runtime_enabled'])
            if entry['object'] in seen:continue
            seen.add(entry['object'])
            data=(ROOT/'SourceMigration/NpcLuaLibrary'/entry['object']).read_bytes()
            self.assertEqual(hashlib.sha256(data).hexdigest(),entry['evidence']['sha256'])
            self.assertEqual(len(data),entry['evidence']['bytes'])
        self.assertEqual(len(seen),report['unique_payloads'])

def write_include_fixture():
    # A test-owned uncompressed PAK; never a VNG/runtime PAK.
    root=ROOT/'Output/NpcLuaIncludeTests/fixture';(root/'data').mkdir(parents=True,exist_ok=True)
    scripts={
        'script/caller.lua':b'function main() Include("\\\\script\\\\child.lua"); Include("script/fallback.lua"); end\nfunction missing() Include("script/missing.lua") end\nfunction cycle() Include("script/cycle.lua") end\nfunction unsafe() Include("../outside.lua") end',
        'script/child.lua':b'pak_value=37\nfunction child_callback() return pak_value end',
        'script/cycle.lua':b'Include("script/cycle.lua")',
    }
    chunks=sorted((pak_id(k.encode()),v) for k,v in scripts.items());offset=32+16*len(chunks)
    index=[];body=b''
    for key,data in chunks:index.append(struct.pack('<IIII',key,offset,len(data),len(data)));body+=data;offset+=len(data)
    (root/'data/fixture.pak').write_bytes(struct.pack('<4sIIII12x',b'PACK',len(chunks),32,32+16*len(chunks),0)+b''.join(index)+body)
    (root/'package.ini').write_bytes(b'[Package]\nPath=\\data\n0=fixture.pak\n')
    (root/'script').mkdir(exist_ok=True)
    (root/'script/child.lua').write_bytes(b'pak_value=99') # must lose to the PAK
    (root/'script/fallback.lua').write_bytes(b'fallback_value=11')

if __name__=='__main__':
    if '--fixture' in sys.argv:write_include_fixture()
    else:unittest.main()
