# User-approved 126-NPC reconstruction — 2026-09-13

Status: population/dialogue reconstruction published with one geometric blocker.
NOT full VNG quest/economy/event parity.

## Actual result

- 126 individual authored Lua files, all load in the runtime Lua 4 engine.
- 125 of the requested 126 NPCs placed and loaded; 11 previously published
  additions and 38 original NPCs retained: 174 NPCs total, plus 1,183 monsters.
- 42 of the 126 scripts include an exact original VNG PAK Lua source payload
  before an explicitly authored menu wrapper. The original branch can be
  selected; it is not a claim that every original quest/API is end-to-end tested.
- 84 scripts provide NPC-specific role guidance, nearby-NPC directions, status,
  back/close/reopen. They do NOT yet implement reward, purchase, skill-learning,
  reincarnation, adoption, VIP, event or battle transactions. The dialogue tells
  the player this explicitly. These are not counted as completed business logic.
- Resource selection is deliberate and recorded as a named-template/reference
  reconstruction or an authored VNG archetype. No new SPR artwork was generated.
- Names known in the source remain original for script identity; the wire
  display registry translates them. Camp-specific authored NPCs have distinct names.

## Coordinates

The accepted display coordinates remain unchanged. Twelve records use a nearby
walkable subcell INSIDE the same displayed coordinate to avoid a blocking half
cell or another NPC. Exact before/after positions are in the deployment report.
No collision/terrain/Region_C bytes were changed.

One blocker: `1001 Bia Than phe Chu (212/215)` requires region `(106,107)`;
the authoritative WOR rectangle ends at region Y=106 and current PAK has no
client or server geometry for `(106,107)`. Its Lua is prepared but its spawn is
not written. Resolving it requires a different approved position or actual map
geometry. No invisible/out-of-bounds spawn was fabricated to reach 126.

## Validation

- Compiler tests: six baseline tests plus four authored-batch tests passed.
- Runtime Engine/Lua test: 126 scripts, 630 authored callback calls and 504
  wrong-map guards passed. Only menu callbacks are exercised in isolation;
  original transaction callbacks are intentionally not executed against fake APIs.
- Client Engine: all frames decoded for 46 selected PAK SPR paths.
- Startup population log: 1,357 total entities = 174 NPCs + 1,183 monsters;
  all authored records added without failures or missing dialogue scripts.
- The one pre-existing missing original escort Lua in map 1014 is unchanged.
- Live native-protocol test with diagnostic character `PhongThanNpc`: exact
  Thái Thượng Lão Quân name/template/position received, then role/routes/status,
  back, close and reopen all passed.
- This live test exposed missing initial static-NPC synchronization. Added
  `SyncNpcNearPlayer` after login in `KPlayer::LaunchPlayer`, using the player's
  current world after the login script. No new protocol or spawn system.
- Actual GUI pixel-level rendering, all NPC transactions, all quest chains and
  all map-transition combinations have NOT been accepted.

CoreServer SHA256:
`A8B1EEC3920277832B24FABA6B22D8A089F394D63C3D265FB707B8B0C1624978`.

## Saved source of truth

- `Deploy/ProjectContent/NpcRestoration/coordinates.json`: accepted coordinates.
- `Deploy/ProjectContent/NpcRestoration/authored_profiles.json`: per-NPC role,
  deliberate sprite archetype/aliases and official reference URLs.
- `Tools/build_authored_npcs.py`: reproducible compilation, protected old entries,
  original Lua provenance, record identity, collision/subcell checks.
- `Docs/NPC_RESTORATION_DEPLOYMENT.json`: every NPC, source, template, SPR, Lua,
  position, output hash and unresolved feature/geometric status.
- `Deploy/ProjectContent/NpcRestoration/compiled`: 126 Lua files, 121 scoped NPC
  section artifacts and display-name registry. Original VNG PAK/maps untouched.
- `Deploy/Publish-NpcRestoration.ps1`: publishes authored Lua server-side and
  display names to both roles. Standard content publication includes this step.
- `prepare_npc_restoration.py --write` now refuses to replace an active authored
  campaign with the older verified-only subset.

Server was restarted using its save-and-stop control path and remains running.
The diagnostic character only was positioned in Diêu Trì for the live test;
ordinary player inventories, progression and character records were not edited.

## Remaining work (not disguised as complete)

Implement transaction/state-machine rules for the 84 guide-only entries from
VNG pages AND the matching item/skill/quest identifiers. Verify original 42
branches against real gameplay. Choose a safe placement for the one outside-map
marker. This is follow-on functional work, not another request to rediscover the
accepted coordinates or to populate a few arbitrary NPCs at a time.

Reference examples used for role/rule separation:

- https://phongthan.zing.vn/cam-nang/nhiem-vu/tay-ky.html
- https://phongthan.zing.vn/cam-nang/nhiem-vu/trieu-ca.html
- https://phongthan.zing.vn/cam-nang/gioi-thieu/tam-gioi-dao-si.html
- https://phongthan.zing.vn/cam-nang/nhiem-vu/do-kiep-cap-30.html
- https://phongthan.zing.vn/cam-nang/nhiem-vu/do-kiep-cap-50.html
- https://phongthan.zing.vn/cam-nang/tinh-nang/chuyen-sinh.html
- https://phongthan.zing.vn/cam-nang/tinh-nang/tan-trung-lai.html
- https://phongthan.zing.vn/su-kien/trang-bi-va-vu-khi-tinh-quan/trang-bi-tinh-quan-cap-1.html
