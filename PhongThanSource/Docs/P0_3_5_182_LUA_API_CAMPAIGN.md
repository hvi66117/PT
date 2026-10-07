# P0.3.5 - Complete the 182 Lua API backlog

Baseline source commit: `40ebc31`.

The campaign processes the complete `lua-missing-api.tsv` inventory. It does
not reduce the audit count with empty functions, unrelated Vo Lam aliases or
registration-only shims.

## Wave layout

| Wave | Scope | API count | Audited Lua-file references |
|---|---|---:|---:|
| 1 | Runtime/time/global, message/dialog/UI, player lookup/session | 26 | 200 |
| 2 | Item/inventory/equipment/EventItem/Treasure | 16 | 280 |
| 3 | Player progression/relation/title and team | 32 | 195 |
| 4 | Player and NPC IBBuff | 11 | 325 |
| 5 | Task/quest/TaskNote | 12 | 231 |
| 6 | Skill/combat/action | 8 | 15 |
| 7 | NPC/AI/creature/trap/totem | 31 | 195 |
| 8 | Tong/city/siege | 30 | 89 |
| 9 | Instance/world event/map | 16 | 77 |
| **Total** | | **182** | **1,607** |

Wave 0 is the contract and dependency gate. Wave 10 is the zero-gap build,
integration and soak gate.

`Tools\New-LuaApiCompletionCatalog.ps1` regenerates the authoritative JSON and
TSV catalog from the validated audit set. It records every call form, source
tier, state owner, persistence requirement and client synchronization boundary.

## Per-API completion contract

An API is complete only after its signature, source data, server state,
persistence, protocol/UI boundary and functional tests are verified. Existing
packet fields remain frozen; new protocol is append-only. Server state is
authoritative.

Known data-contract blockers remain quarantined until their VNG registries are
recovered: EventItem, HardNpc attributes, event-skill, trap/totem ownership and
AI lifecycle. Wave 4 recovered IBBuff; Wave 5 recovered the task-note call
contract, official NPC collection registry and JE completion persistence.

## Completed checkpoints

| Wave | Commit/gate | Remaining API names |
|---|---|---:|
| 0 | catalog and dependency lock | 182 |
| 1 | runtime/time/global/UI/player lookup | 156 |
| 2 | item/inventory | 140 |
| 3 | progression/relation/title/team | 108 |
| 4 | IBBuff | 97 |
| 5 | task/journal | 85 |
| 6 | skill/combat/action | 77 |
| 7 | NPC/AI/creature/trap/totem | 46 |
| 8 | Tong/city/siege | 16 |
| 9 | Instance/world event/map | 0 |
| 10 | zero-gap source/build/hash/persistence gate | 0 |

Each implementation wave follows this gate:

1. Contract fixture fails before implementation.
2. Verified data loader and bounds checks pass.
3. Server state and persistence tests pass.
4. Protocol/client tests pass when the client consumes the state.
5. All prior regression tests and Release Core builds pass.
6. The semantic audit is regenerated and the wave is committed atomically.

## Final gate

- `missing_api_name_count = 0`.
- `review_api = 0` for deployable validated Lua.
- payload integrity remains `3680/3680` and callback gap remains zero.
- no registered API is a constant-return or no-op stub.
- client/server shared registry hashes match.
- Release CoreServer and CoreClient build successfully.
- relog/restart persistence and staging soak tests pass.

## Wave 10 verification

The final source/API gate was executed on 2026-09-01. The 182 campaign APIs
have 182 unique native implementations and one server registration each.
Static body inspection found zero constant-return/no-op stubs. Three short
equivalence wrappers remain and are explicitly locked to their verified
semantic targets (`NpcSay`, `InfoBox` and `GetHeavenCityUnion`).

The regenerated semantic audit reports zero missing API names, zero
`review_api`, zero callback gaps and payload integrity `3680/3680`. Release
CoreServer/CoreClient builds pass. The staging data gate also verifies 43
shared registry files, 4,234 MagicScript Lua payloads, the canonical
`settings\phongthan\Npcs.txt` payload and all six external persistent-state
junctions. The deterministic Wave 10 hashes are:

- API implementation registry:
  `1E958C303FE41223CAC3098889AADA7009CEF5F494B88CB719890A257FD144E9`.
- shared gameplay/item registry:
  `8DC8D5EA71EE27410048125A5922F03A19E97E164A2A591382E18E5815748136`.
- shared MagicScript Lua set:
  `B635CBDABD266D76B5CDDC2FD1C2CAD81ACB7A36C76D967CD8F75FB96ED26CE6`.
- canonical NPC table:
  `12363EB119D4F0F41876154196C908248DF77D541CC5133B71D2D01C1E9F70E5`.

Runtime cutover remains fail-closed and was not performed at this historical
checkpoint. The map-data blocker recorded here was subsequently resolved by
the imported Seaweed/VNG map set. The current authoritative gameplay gate
requires and verifies 102 active maps, 91 physical map sets, 34,048 client
`Region_C` entries and 34,048 server `Region_S` entries. No `Region_C` to
`Region_S` derivation is accepted.
