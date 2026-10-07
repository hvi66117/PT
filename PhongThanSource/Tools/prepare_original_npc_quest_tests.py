"""Read original starter quest scripts from the active VNG PAK into test fixtures.

No runtime or PAK writes. The expected hashes came from the prior PAK candidate
audit; changing content fails closed rather than silently changing test inputs.
"""
from __future__ import annotations
import argparse
import hashlib
import json
from pathlib import Path
from prepare_npc_restoration import PakReader

ROOT = Path(__file__).resolve().parents[1]
BASE = ROOT.parent
FIXTURES = ROOT / 'Tests/fixtures/NpcQuestOriginal'
SCRIPTS = [
    ('to_ho', '崇城大营/苏护', 'c44b9f6b28692d77a4a4c6f51d35ebb6a509241e0be102d7b7c78eb4b026460c'),
    ('thu_kho', '崇城大营/仓库管理员', 'dde542e8bc01c5b40f13f745b8618fbde527e1220f078474ba29a1de5fbccc6b'),
    ('sung_ung_loan', '崇城大营/崇应鸾', '250af754a2eaeda76691306f72cf55c5560b15519814ca2637ba9877dceffc7d'),
    ('trieu_loi', '崇城大营/晁雷', '03e37d97ede7cb5aa6619d69dfd05e74894a92f79ec5b7c18d7d98382d0c3608'),
    ('trieu_dien', '崇城大营/晁田', '2559782be5f4ec96c9bdabc0fd4bce014108a9d0e57090abff88b23e90aeb453'),
    ('nam_cuc', '玉虚宫/南极仙翁', '26209860b2a07437a5bc357ca4e704a3afaf619a9d5d82a6f4c33a91d6ccaefc'),
    ('hoang_long', '玉虚宫/黄龙真人', 'c23fd7c3e0408431d1c3fa06e50bf172b78d3a690ea26c97a95a55896ce9edd9'),
    ('nhien_dang', '玉虚宫/燃灯道人', '11cd7b389ac66d1193fd0ec0ad5f018747199c2bd0744624718a580fa6e51f18'),
    ('hau_tho', '蚩尤墓/后土图腾', 'fd1c827a45a1c8c51beac848546da9df44533a9e9a3f0de85b097ec7a4515bd2'),
    ('cao_giac', '蚩尤墓/高觉', '34b949ffe3af63562451290b92def36cef0f60a757616973eaec544a72d24312'),
    ('cao_minh', '蚩尤墓/高明', '648a274ff21001f7ab3ab8e32f55b6f2637805bbb6fd2f0875fbff522c4c718e'),
    ('hinh_thien', '蚩尤墓/刑天', '36270790f2c28c515e234be6a65aa5f9d4a42024c64fc27e31bba9214e935ca5'),
]

def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--write', action='store_true')
    args = parser.parse_args()
    client = BASE / 'PhongThanRuntime-Content/Client'
    reader = PakReader(client, BASE / 'SeaweedUnpack_SprView/SeaweedUnpack_SprView/UnpackCore.dll')
    outputs = {}
    records = []
    try:
        for name, path, expected in SCRIPTS:
            logical = '/script/' + path + '.lua'
            result = reader.get(logical)
            if not result:
                raise ValueError('Missing original PAK resource: ' + logical)
            payload, proof = result
            if proof['sha256'] != expected:
                raise ValueError('Original PAK hash changed: ' + logical)
            outputs[name + '.lua'] = payload
            records.append(dict(fixture=name + '.lua', **proof,
                                source_pak=str(client / 'data' / proof['pak'])))
        appendix = ROOT / 'Deploy/ProjectContent/NpcRestoration/quest_overrides/to_ho_task20.lua'
        appendix_bytes = appendix.read_bytes()
        # Original byte prefix remains exact, including original text encoding.
        outputs['to_ho_transactional.lua'] = outputs['to_ho.lua'] + b'\r\n' + appendix_bytes
        manifest = dict(scope='ORIGINAL_LUA4_STATE_API_TESTS_NOT_RUNTIME_VALIDATION',
                        originals=records,
                        derived=dict(fixture='to_ho_transactional.lua',
                            original='to_ho.lua', appendix=str(appendix.relative_to(ROOT)),
                            appendix_sha256=hashlib.sha256(appendix_bytes).hexdigest(),
                            sha256=hashlib.sha256(outputs['to_ho_transactional.lua']).hexdigest()),
                        chains=[dict(world=1002, task=20, states=[0, 1, 10, 17, 18, 19],
                                     note='Between 10 and 17, notify bits 1/2/4 in any order.'),
                                dict(world=1003, task=11, states=[0, 1, 2, 3, 4, 5]),
                                dict(world=1004, task=31, states=[0, 1, 2, 3, 4, 5, 6]),
                                dict(world=1002, task=23, states=[0, 1, 2]),
                                dict(world=1002, task=26, states=[0, 10, 0],
                                     note='Repeatable collect10: deterministic event39 reward branch exercised.')])
        if args.write:
            FIXTURES.mkdir(parents=True, exist_ok=True)
            for name, payload in outputs.items():
                (FIXTURES / name).write_bytes(payload)
            (FIXTURES / 'provenance.json').write_text(json.dumps(manifest, ensure_ascii=False, indent=2) + '\n', 'utf8')
        print(json.dumps(dict(original_scripts=len(records), derivative=1, fixtures_written=args.write)))
    finally:
        reader.close()

if __name__ == '__main__':
    main()
