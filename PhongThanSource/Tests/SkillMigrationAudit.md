# Skill migration audit — 2026-09-08

## Confirmed changes

- `Sources/Core/Src/KSkillList.cpp`: IncreaseLevel validates the registered Skills.txt MaxLevel and effective-level array bound, loads the target skill, then commits. Previously a failed load left incremented levels behind.
- `Sources/Core/Src/KPlayer.cpp`: AddSkillPoint rejects nonpositive/invalid requests and another profession's registered skills.
- `Sources/Core/Src/KSkills.cpp`: profession skill descriptions use the canonical profession registry instead of five-element suffixes; plain names remove VNG display prefixes/color tags without recoding Vietnamese bytes.

## Evidence and remaining work

- PAK `settings/skills.txt` has SkillId, SkillStyle, MaxLevel, LvlSetScript and CastScript; no Series column. Sample profession rows 3,27,28,42,43,51 have MaxLevel=10. `KPhongThanProfessionSkills.h` currently scopes ownership to IDs 3..51; advanced skills outside that range require their own data audit.
- `KSkillList::SeriesSkillV` and five callers in `KNpcAttribModify.cpp` still implement elemental skill bonuses. Do not equate element IDs with profession IDs without identifying the VNG attribute definitions.
- `KSkills.cpp` still has weapon-limit description branches and shared missile/state dispatch. These require comparison with skill requirements, missile tables and level Lua before replacing behavior.
- `Output/SkillResourcePolicy/skill-level-lua.server-backlog.txt` and `Output/VngSkillLuaImport.report.json` are prior collection reports, not fresh completeness verification.
- This pass does not certify skill damage, summons, statuses, cooldowns or every level Lua in gameplay. Build and source-guard tests are not runtime combat acceptance.
