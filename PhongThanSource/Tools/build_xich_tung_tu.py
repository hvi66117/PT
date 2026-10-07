"""Build the reviewed Xich Tung Tu derivative without changing any VNG PAK/map."""
import argparse
import hashlib
import json
from pathlib import Path
from prepare_npc_restoration import PakReader, rows, split_region, npc_records

ROOT = Path(__file__).resolve().parents[1]
CONTENT = ROOT / 'Deploy/ProjectContent/NpcQuests'
SOURCE = r'\script\瑶池\赤松子.lua'
REGION = r'\maps\瑶池_S\v_098\097_region_s.dat'
TARGET = 'script/phongthan/npc_services/xich_tung_tu.lua'
PIN = '9256ed9983f95ddb163564be7889171a0e60f54837f17c9e6bdef67016c06a49'

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--write', action='store_true')
    args = parser.parse_args()
    reader = PakReader(ROOT.parent / 'PhongThanRuntime-Content/Client',
        ROOT.parent / 'SeaweedUnpack_SprView/SeaweedUnpack_SprView/UnpackCore.dll')
    try:
        source, proof = reader.get(SOURCE)
        if proof['sha256'] != PIN:
            raise ValueError('Original Xich Tung Tu script changed; review required')
        # Original PAK uses the unsuffixed map directory on this chain;
        # _S is only the server deployment directory, never substitute Region_C.
        region_result = reader.get(REGION) or reader.get(REGION.replace('瑶池_S', '瑶池'))
        if not region_result:
            raise ValueError('Original PAK Region_S missing')
        region, region_proof = region_result
        records = npc_records(split_region(region)[2])
        import struct
        identities = []
        for record in records:
            if record[60:].rstrip(b'\x00') != SOURCE.encode('gbk'):
                continue
            template, x, y = struct.unpack_from('<iii', record)
            identities.append(dict(template=template, world=1052, x=x, y=y))
        if identities != [dict(template=206, world=1052, x=49965, y=100773)]:
            raise ValueError('Unexpected original NPC binding: ' + repr(identities))
        material, material_proof = reader.get(r'\settings\item\001\material.txt')
        matches = [row for row in rows(material)[1:] if row[1:3] == [b'3', b'82']]
        if len(matches) != 1 or not reader.get(matches[0][3].decode('gbk')):
            raise ValueError('Tha Son Thach table/SPR missing or ambiguous')
        appendix = (CONTENT / 'xich_tung_tu_patch.lua').read_bytes()
        derived = source + b'\r\n' + appendix
        outputs = {
            CONTENT / 'compiled' / TARGET: derived,
            ROOT / 'Tests/fixtures/XichTungTu/original.lua': source,
            ROOT / 'Tests/fixtures/XichTungTu/patched.lua': derived,
        }
        manifest = dict(schema=1, logical='\\' + TARGET.replace('/', '\\'),
            source=proof, region=region_proof, npc=identities[0], material=material_proof,
            item_spr=reader.get(matches[0][3].decode('gbk'))[1],
            original_sha256=PIN, sha256=hashlib.sha256(derived).hexdigest(),
            appendix_sha256=hashlib.sha256(appendix).hexdigest(),
            original_pak_modified=False, original_map_modified=False,
            rules=dict(credit=10, reward=dict(genre=3, detail=82, particular=0, count=1)),
            equipment=dict(max_upgrade=12, recipe_types=[1,7], exact_pak_rule_and_rate=True,
                preserves_item_id_and_base_roll=True, persisted_rule=True),
            remaining='Bracket-qualified recipes, non-equipment probabilistic composition, and upgrades 13..15 require further rules; not enabled')
        if args.write:
            for path, data in outputs.items():
                path.parent.mkdir(parents=True, exist_ok=True)
                path.write_bytes(data)
            (CONTENT / 'xich_tung_tu_provenance.json').write_text(
                json.dumps(manifest, ensure_ascii=False, indent=2) + '\n', 'utf8')
        else:
            for path, data in outputs.items():
                if not path.is_file() or path.read_bytes() != data:
                    raise ValueError('Stale derived artifact: ' + str(path))
        print(json.dumps(manifest, ensure_ascii=False, indent=2))
    finally:
        reader.close()

if __name__ == '__main__':
    import sys
    sys.stdout.reconfigure(encoding='utf8')
    main()
