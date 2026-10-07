# NPC population and minimap update — 2026-09-06

Status: implemented/published for verified data; NOT complete NPC coverage of all maps.

## Proven causes

- All 34,048 runtime Region_S files had zero-length NPC sections. Counting region
  filenames was not a population acceptance test. The Seaweed export supplied
  world geometry but no server NPC placement records.
- Original populated files still exist in `D:\Lam game phong than\Tai nguyen VNG\Maps\maps`:
  535 populated regions, 1,221 records (1,183 monsters and 38 dialog NPCs).
  They cover runtime maps 1014 (Dong Quan / 潼关), 1016 (Tam Son Quan), 1052 (Dieu Tri).
- The expanded WOR bounds used for loading sparse world regions do not always
  equal the original minimap origin. Dieu Tri: runtime origin 88,91 versus
  original PAK 89,91. The image was therefore displaced by 512 world pixels.
- Minimap `MapLTRegionIndex` passed Y as a pointer value rather than its address;
  map switching also retained scroll offsets and symbols from the previous map.

## Published changes

- Imported original Region_S files byte-for-byte; no NPCs inferred from minimap
  icons, no Region_C converted into Region_S. Fifteen missing cells also received
  their original Region_C companions. Final inventory: 34,063 files per role.
- Original NPC payloads and companions live in `Deploy/ProjectContent/VngNpcRegions`.
  The importer applies them after the Seaweed geometry import on future rebuilds.
- Server NPC reader validates the complete section and script boundaries before
  creating entities; logs actual added/failed counts and missing dialog scripts.
- All 91 minimap metadata files and 87 images were extracted successfully from
  the configured PAK priority. Original metadata is kept separately in
  `settings/phongthan/minimap` so expanding world bounds cannot move the image.
- Four existing minimap images lack entries in the available PAKs and remain
  unchanged/unverified (10-years-before Jade Palace, 10-years-after Jade Palace,
  10-years-after Trieu Ca, Nam Kha Quan). Metadata for all four was found.
- Minimap player/NPC/route markers use GetMpsPos with the same 16/32 scale.
  Map close clears scroll state, stale image identity and symbols.

## Actual verification

- CoreServer/CoreClient Release built and native staging publication passed.
- Server population: 1014=748, 1016=447, 1052=26; total 1,221, zero add failures.
- Account 123456, diagnostic character `PhongThanNpc`, map 1052: real native
  transport received template 225 (Na Tra) with name, opened its original Lua
  dialogue, and received the close response from its `no()` callback.
- `Test-NpcMinimapContent.ps1` checks all published hashes against provenance.
- The Windows capture helper failed with `failed to write kernel assets`;
  graphical client acceptance has NOT been claimed. User can select
  `PhongThanNpc` to test beside Na Tra. `PhongThanPlay` was not changed.

## Still missing

- Original server placement records for the remaining 99 active map IDs. The
  existing 91 physical geometry/minimap sets do not supply those NPC records.
- `script\运镖\潼关镖师.lua` is missing; the other 35 unique dialog script paths
  used by the recovered records exist. Only Na Tra dialogue was tested live.
- Monster combat/AI and all other NPC business flows still need their own live
  acceptance. Loaded entities and a working single dialogue do not prove them.
- Four minimap images mentioned above still require authoritative matching data.

Next decision: obtain original server NPC placement data for the remaining maps,
or explicitly approve authored placement tables. Do not silently fabricate them.
