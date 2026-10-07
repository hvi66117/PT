# All-126 NPC campaign — blocked on content identity, not loader capacity

Superseded by user authorization and `NPC_AUTHORED_126_RESULT.md`.
The content below is the historical pre-authorization audit, not current runtime status.

2026-09-13. User requested one complete deployment, no incremental batches.
No live source binaries, runtime map/spawn data, PAKs or character data changed
in this campaign. The preceding 49 loaded NPCs remain the published result.

The batch audit covered all 126 pending rows against 124 distinct local PAK
indexes, 23 unique NPC table payloads and 10,282 candidate map/placement payloads.
It retained 496 candidate NPC/functional Lua payloads and 147 binary placement
references. Actual payload hashes/entry IDs are in `NPC_CAMPAIGN_126_AUDIT.json`.
This is not proof that every candidate is compatible or authoritative VNG.

Current overlapping blockers:

- 83 rows have neither a named NPC-template table match nor a same-name binary
  placement reference in the audited data. Anonymous passerby templates are not
  counted as identities. Names extracted from other maps are candidates only.
- 74 rows have no exact current map/name Lua path in the audited data; different
  spellings or function names might exist, so this is not an Internet-wide
  absence claim.
- 17 exact map Lua matches exist only in community PAKs. They need deliberate
  source selection and a behavior/dependency review, not automatic promotion to
  authoritative VNG scripts.
- 56 rows lack the original logical name in the accepted input catalog.

New evidence includes named placements in Thap Tuyet Tran maps.pak (e.g. Su Ho,
Sung Hau Ho, Nam Cuc Tien Ong) and functional Lua in Phuc Hung/Tam He packages.
These are kept as community references; their template indexes require checking
against their own settings and the active VNG resource table before adoption.
No community region file was copied to runtime.

The compiler now supports `--require-complete`; the focused publisher supports
`-RequireComplete`. Both refuse a partial batch before writes. Six compiler
tests pass, including complete-batch refusal. The gate does not pretend to solve
missing data and has not been used to relabel unresolved NPCs as complete.

Required user decision: approve authored reconstruction using suitable existing
VNG sprites and newly written, NPC-specific Lua behavior where original identity
or logic is unavailable. Alternatively provide the missing authoritative mappings.
Generic placeholder sprites/dialogue, death scripts standing in for interaction,
and copying another map's business logic are not accepted implementations.
