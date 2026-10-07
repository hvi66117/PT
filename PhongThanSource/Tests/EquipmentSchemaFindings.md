# Equipment schema audit (all categories)

Generated evidence: `Output/EquipmentSchemaAudit/report.json`; reproduce with `Tests/Audit-EquipmentTables.ps1`. Reads the current server PAK chain, not loose fallback tables.

## Confirmed structural problems

1. `KBasPropTbl.CPP` now uses `PhongThanEquipmentColumns.h` to resolve basic attributes, complete requirement pairs and tail fields by header. Cuff's unpaired requirement cells are not misread as types. Correction: the earlier 117 omitted-detail count was a CP936-decoding artifact; byte-preserving parsing finds ZERO such rows in the current PAK. Long extension rows remain.
2. `KTabFile::GetInteger` uses atoi. Melee power cells such as `*2,5*` therefore become zero. These belong to power calculation, not direct permission to generate random hidden effects.
3. `KItemGenerator::ApplyPhongThanSetAttrib` only separates white/blue fields for positive SetID. All sampled melee rows have no positive SetID; SetID is not a general quality classifier.
4. Crafting GroupID is not established as equipment SetID. Its table includes probabilities, prefixes and expansion references. The erroneous attachment has been disabled.
5. Existing code does not establish a data-driven relation for fixed set effects/activation thresholds. Website examples must be used as acceptance examples, not hardcoded per-item replacements.
6. Upgrade value/rule tables exist in the PAK; a source search found no references to their logical names in the current Core equipment code. Presence in PAK alone is not implementation.

## Current verification

CoreClient/CoreServer build succeeds. `Tests/Native/EquipmentColumnTests.cpp` exercises the production header reader on 27,471 raw-byte records, including exact armor/weapon field assertions. The REAL_ENGINE_TABLE build also passed against actual KTabFile/Engine.lib and the server PAK chain. Reproduce with `Tests/Test-EquipmentEngineColumns.ps1`. This is not runtime item/gameplay acceptance. Invalid/expression numeric cells now produce bounded diagnostics; their mathematical semantics are NOT yet implemented. Integer overflow is rejected. This build has not been deployed pending that work.

The unused ApplyVngSetAttrib function that equated SetID with crafting GroupID was removed, not merely disconnected. The generic crafting-table reader is retained for future correctly keyed crafting rules. All per-set/per-name overrides remain removed.

## Required implementation order

## Newly recovered original set tables

Direct PAK lookup (not loose fallback), reproduced by `Tests/Native/AuditSetEntries.cpp`:

- Entry 771097478: 5129 bytes, 62 set IDs / 356 effects. ID 5 has 182=20,126=20,179=60 in source slots 1..3 and 114=20,113=30,115=20 in slots 6..8.
- Entry 884177972: 1280 bytes, 15 IDs / 78 effects. ID 5 differs: defense 80, all resistance 10, recovery 50.
- Both use the header `绿装名称, ID, 附加属性1类型, 附加属性1值, ...` (10 pairs), unlike the crafting GroupID schema. Holes must not be discarded before tier mapping is established.
- `Headers/PhongThanSetTable.h` parses both byte-exact schemas, rejects crafting headers and duplicate IDs, and retains all ten slots. `Tests/Native/SetTableTests.cpp` passed for both PAK exports.
- Logical filenames remain unresolved. Current armor uses SetIDs 30 and 36, absent from the 15-row table and present in the 62-row table. Core now reads PAK entry 771097478 by verified ID (direct PAK access; no block-file fallback). Selection is based on current registry coverage plus reference agreement, not a claim about the unknown original filename.
- All ten source slots are loaded; present effects are projected into the available item bonus slots in source order. Full five-piece sets activate their actual effect count; 3/4-piece rules retain the requested 3/4 count. ReCalcEquip applies shared set effects once instead of once per piece. Build succeeds; this integration is NOT deployed or accepted in gameplay yet.

## Required implementation order (remaining)

### Power-table evidence recovered from PAK

### Typed power-input preservation

### Reconstruction correctness

### Activation and package parity

The production `PhongThanActiveSetEffectCount` helper is now shared by KItemList and native set-table tests. All 62 parsed sets pass 0/2/3/4/5-piece cases, including full-set effect counts larger than five. This verifies the counter, not a live character's final calculated stats. Both original set entries were separately extracted through the client package chain under `Output/EquipmentSchemaAudit/ClientParity`; their SHA256s match the server exports. Thus package disagreement is ruled out for these two current entries only.

`PhongThanEquipmentProjection.h` now provides a shared modifier projection for all equipment, not only SetID-positive items. It moves registered normal modifiers from source slots 6+ while retaining primary/damage and unsupported IDs in the base payload. It copies values exactly and leaves overflow in place. All new/reload generator paths call this projection; only the subsequent set-effect lookup requires SetID. `EquipmentProjectionTests` verifies production helper values/order/no-loss/capacity behavior. Classification follows the existing registry boundary and source-slot convention; in-game appearance/tooltip acceptance remains pending. This supersedes the earlier SetID-only classification noted above.

### Equipment metadata synchronization

The item snapshot now carries UpgradeLevel, PhysicalValue and MagicValue; `KItemList::SyncItem` writes them and `KProtocolProcess::s2cSyncItem` restores them. Previously CharacterStore saved these fields but the wire layout omitted them. `PhongThanValidateItemSnapshot` checks actual received size/type/response flags before dispatch reads the fields. Both Core builds passed. Old shorter snapshots are incompatible and rejected; deployment must update client/server together.

`EquipmentMetadataWireTests` passes valid/truncated/wrong-type/wrong-flags cases using the production validator. `EquipmentStoreRoundTrip` passes actual CharacterStore create/load for three fixture items, then validates transfer of metadata into the new wire layout. Output is isolated under `Output/EquipmentStoreTest-41105710b0314f99b70264045851eb84`, not the user's runtime state. This does not test KItemGenerator or a running network session and does not establish the missing power formula.

`KItem::SetAttrib_CBR` now clears old magic/set slots before assigning a new template. Previously the non-set path could retain the preceding item's modifiers when reusing an object. New-template and existing-template routes both enter this function and then the shared set projection. `Tests/Test-EquipmentReconstruction.ps1` checks this wiring only; it is not proof of runtime snapshot/save round-trip equivalence. Native set parser tests additionally cover duplicate IDs, negative values, holes and capacity failures.

Power getters currently have no callers in Core beyond their declarations. `KPlayerDBFuns.cpp` restores saved PhysicalValue/MagicValue after template generation. These facts mean a completed power pipeline must explicitly define derived versus persisted values and add its consumers; retaining raw pair inputs alone does not complete power calculation or tooltip display.

`Headers/PhongThanPowerExpression.h` now distinguishes scalar, pair, empty and invalid values without guessing how a pair is evaluated. `KBASICPROP_EQUIPMENT` retains kind/first/second; legacy scalar output remains zero for unevaluated pairs, so runtime power calculation is still incomplete. Overflow, malformed expressions and trailing garbage are rejected. Some active PAK rows contain `*40,88*"""`; these are reported rather than silently accepted. `PowerExpressionTests` passed.

The shared integer reader accepts the observed numeric percent suffix (`90%` -> 90, unit owned by attribute type) and still rejects trailing non-unit text. Full engine traversal passed again after this change. Generator grouping no longer erases out-of-registry attributes while failing to project them. None of these changes establishes star/upgrade semantics or completed power display.

The original-name to transliterated-name catalog in `Tai nguyen VNG/vng00/block_3543_id3049984218.txt` identified two paths. Only the original CP936 paths resolve in the current package chain:

- `\settings\powervalue\装备升级功力表.txt`: equipment ID plus enhancement levels 1..12. Equipment ID 6 has values 13,16,19,24,29,33,40,49,60,72,85,100. These are enhancement power, not the raw item's `*min,max*` scalar.
- `\settings\powervalue\装备激活属性评分表.txt`: set ID plus per-active-effect scores. Set ID 5 contains 39,39,39,43,43,43. These are scores, NOT the effect values to apply to the character.
- Both recovered directly from PAK index 14. Reproduce with `Tests/Audit-EquipmentPowerTables.ps1` (raw CP936 path-file mechanism). Do not substitute transliterated paths without verifying their PAK entry.
- Property slots 6..10 across all item tables include normal modifiers as well as damage/base IDs 45,58,60; therefore blanket reclassification of all tail properties by slot alone requires more validation. No new blanket conversion was applied.

1. Resolve each field by audited header/schema, preserving per-row offsets and reporting unmapped extensions. Test all category records before deployment.
2. Decode numeric, interval and expression fields by their specific semantics; do not silently atoi expressions.
3. Identify authoritative quality/star/upgrade and set membership/effect references. Keep these separate from crafting probability groups.
4. Generate a canonical attribute payload used by server calculations, client tooltip, new-item generation and save reload.
5. Compare representative normal, gold weapon, set, upgraded, quest-bound and accessory rows against published examples and PAK values. Do not extrapolate one set's six effect values to other sets.

Per-set Chandan/Tram Kim source special cases were removed before runtime publication. `GoldEquipmentSources.md` retains research evidence only. The all-equipment conversion is not complete.
