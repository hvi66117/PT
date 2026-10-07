# NPC restoration — 2026-09-13

Status: PARTIAL, not complete game NPC restoration.

Latest authored-campaign result: see `NPC_AUTHORED_126_RESULT.md` and
`NPC_RESTORATION_DEPLOYMENT.json`. The 11-NPC figures below are historical.

## Latest follow-up: sparse map cells

Nine more NPCs were published after the initial two; 11 authored NPCs are now
loaded in addition to 38 original NPCs. The accepted catalog remains 143 rows:
11 READY, 6 EXISTING_PAK, 126 PENDING. Coordinate inputs have not been changed.

| World | New NPCs in this follow-up | Templates | Accepted display coordinates |
| --- | --- | --- | --- |
| 1002 Sung Thanh Doanh | Thu Kho; Tap Hoa Thuong Nhan | 151; 158 | 202/198; 207/198 |
| 1003 Ngoc Hu Cung | Tu Hang Dao Nhan; Xich Tinh Tu; Hoang Long Chan Nhan; Van Trung Tu | 1864; 764; 846; 845 | 206/196; 213/197; 204/195; 215/194 |
| 1004 Xi Vuu Mo | Cao Giac | 774 | 205/197 |
| 1020 Tay Ky | Khuong Tu Nha; Loi Chan Tu | 301; 224 | 158/189; 163/187 |

These nine cells have no existing server Region_S geometry. Rather than
manufacture Region_S/obstacle/trap data, the compiler emits the original
standalone Npc_S structure: 12-byte KNpcFileHead, 60-byte KSPNpc prefixes and
counted script names. Files are explicitly authored project content under
`settings/phongthan/npc_regions/<WorldId>/v_YYY/XXX_npc_s.dat`.

Sparse cells now call the same `LoadServerNpc` used for combined Region_S.
Standalone content is only used when the base has no NPC section. Original
PAK NPC sections retain priority, with one spawn pass. Authored record world
positions must belong to the named region or the entire section is rejected.

Client Region_C is READ ONLY for confirming the map cell exists in PAK and
checking collision at accepted positions. No bytes are copied/converted to
server geometry. The server's pre-existing empty-geometry behavior is unchanged;
this update does not claim to restore missing server collision data.

Verification of the follow-up:

- CoreServer Release: build success, existing large-image warning unchanged.
- Five compiler tests and native loader tests pass, including standalone
  record format, wrong region, truncation and base-over-standalone priority.
- Client Engine decoded all 40 frames of each of 11 selected SPRs (440 frames).
- Content/Staging publication hashes checked. Only CoreServer.dll plus NPC
  content/display registry updated; other binaries, original PAKs and character
  stores unchanged.
- Fresh server log from byte offset 3923002: authored counts 1002=2, 1003=5,
  1004=1, 1015=1, 1020=2; all `failed=0 missing_dialog_script=0`.
- Original populations still load: 1014=748, 1016=447, 1052=26. Their one known
  missing escort Lua in 1014 is unchanged.
- Server remains running after a save-and-stop restart. Visual appearance and
  actual player dialogue/quest behavior have not been accepted in the GUI.

Publish the focused update with `Deploy/Publish-NpcRestorationUpdate.ps1` after
stopping the server using the control program. This avoids republishing unrelated
artifacts or hashing/copying the PAK chain again.

Next: resolve the remaining name/resource identities, especially Phong Lam,
Ngo Long and Thuong Hao in Manh Tan (their actual PAK Lua paths exist but a
proven template identity is still absent), then the 126 pending catalog rows.

## Initial batch (historical)

- 143 accepted named-position rows retained in
  `Deploy/ProjectContent/NpcRestoration/coordinates.json` (16 world IDs).
- Six rows refer to NPC identities already present in original PAK placement.
- Two additional NPCs have a proven name/template match, actual PAK dialogue,
  PAK sprite and an existing, structurally valid runtime Region_S cell:

| World | NPC | Template | NpcResType | MPS | Display coordinate |
| --- | --- | --- | --- | --- | --- |
| 1003 | Nhien Dang Dao Nhan / 燃灯道人 | 1863 | passerby059 | 52864,98560 | 206,192 |
| 1015 | Dai Phu / 医生 | 149 | passerby001 | 49280,108800 | 192,212 |

The doctor's accepted web coordinate is used. The previously inferred minimap
point 49264,109216 is retained in the input notes but lies in a full-obstacle
cell (17) in current runtime geometry. No obstacle was removed or changed.

Server now resolves explicitly authored NPC-section replacements in
`settings/phongthan/npc_regions/<WorldId>/v_YYY/XXX_region_s.dat` through
`KRegion::LoadServerNpc`. Only the NPC section is used. Original geometry,
traps, objects, Region_C, PAKs and source VNG data remain unchanged. There is
one `NpcSet.Add` pass, not a second spawn implementation.

The NPC scripts are loaded from their actual logical PAK paths through the
existing `ReLoadScript` loader when they are not in the script registry. This
fixes the discovery gap caused by enumerating loose `script` directories only.
No dummy dialogue or unrelated Lua was supplied.

Original names remain GBK for server script identity. `NpcDisplayNames.txt`
changes only names sent to the client (current single-byte font page).
SPR rendering and NPC synchronization use the existing client pipeline.

## Verification

- CoreServer and CoreClient Release build: success. CoreServer retains the
  pre-existing large-image linker warning; running server started normally.
- Three compiler tests: geometry preservation, duplicate-record suppression,
  invalid script length/invalid section boundaries.
- Native source-loader test: original section, authored section, invalid bounds.
- Actual client Engine.dll: both selected PAK SPRs decoded all 40 frames;
  display-name registry resolved the original GBK name correctly.
- Publication hashes checked for Content and Staging, Client and Server.
- Original-content test passed: 535 original NPC-region hashes, 91 minimap
  metadata files and 87 verified minimap images unchanged.
- Fresh server log:
  - `map=1003 region=00600067 declared=1 added=1 failed=0 missing_dialog_script=0`
  - `map=1015 region=006A0060 declared=1 added=1 failed=0 missing_dialog_script=0`
- Server restarted through the control program's save-and-stop path.
- Graphical in-game appearance, player interaction and map re-entry have NOT
  been accepted visually. Loading Lua does not prove all its business functions.

## Remaining blockers

135 rows are explicitly pending in `NPC_RESTORATION_DEPLOYMENT.json`.
Each records the missing identity, script, or exact server geometry cell.
The earlier broad inventory counted template Lua paths (including generic
death/level/timer scripts) and names in `scripts_exact.txt`; those are NOT
proof of a unique NPC's map dialogue or actual availability in current PAKs.

Many original template names are only `passerbyNNN`. A proven NPC name to
template/resource mapping is still needed before those NPCs can be placed
without assigning arbitrary appearances. Shared templates do not imply shared
dialogue. NPCs lacking coordinates are not assigned random coordinates.

Existing unresolved Lua is still reported for the original escort NPC in
1014: `script/运镖/潼关镖师.lua`. Do not substitute another escort script by name.

## Reproduce

Use bundled Python with `Tools/prepare_npc_restoration.py` for read-only planning
or `--write` to compile reviewed rows. It never writes authoritative inputs.
Run `Tests/test_npc_restoration.py` for compiler tests. Publish reviewed output
with `Deploy/Publish-NpcRestoration.ps1 -RoleRoot <Content-or-Staging/Server>`
and the Client role for display names. Ordinary content and native publication
include this step, so subsequent publication does not discard the work.

Next: resolve pending NPC identity using an original named placement record,
an authoritative name/resource table, or user-confirmed sprite identification;
locate and verify the corresponding map-specific Lua. Compile only resolved
rows, keeping the remainder visible instead of reporting full completion.
