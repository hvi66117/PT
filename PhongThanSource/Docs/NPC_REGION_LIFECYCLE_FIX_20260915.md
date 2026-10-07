# NPCs disappear on camera movement — 2026-09-15

## Reproduced state

Read-only inspection of the user's actual running client, PID 15496:

- Player `test123`: region slot 7, physical region `00620061`, MPS
  `(50043,100874)`, valid scene leaf.
- Seven cached server NPCs: `m_RegionIndex=-1`, `m_SceneID=0`.
- `Nguoi Quang Ba`: physical region `00630060`, MPS `(49320,101799)`;
  a neighbouring region, still cached but detached and not rendered.
- Old Ngoc Hu NPCs remained cached after travelling to Dieu Tri.

Thus PAK resources and spawn creation were not the cause of this reproduction.
The earlier viewport-only fix did not repair the region-cache lifecycle.

## Implemented fix

1. `PhongThanClientNpcReattach.inl`, used by `KNpcSet::InsertNpcToRegion`:
   reattach server NPCs/monsters by real region ID when the cell is loaded again.
   Require detached node + valid cell; add collision reference once. Preserve
   server action, identity and sync age. No re-spawning or duplicate KNpc.
2. `PhongThanClientNpcChangeRegion.inl`, used by client `KSubWorld`:
   detach before cache recycling, retain the actual destination region ID when
   not loaded, load the player's destination before attaching to the final slot.
3. `KSubWorld::LoadMap`: discard other entities on actual world changes only;
   preserve self and same-map cached NPCs. Packed region XY alone has no world ID.
4. `KProtocolProcess::SyncNpcMin`: reject updates from the previous map, matching
   the full-snapshot guard already present.
5. `KScenePlaceC::MoveObject`: a nonzero owned render leaf can be detached by
   camera preprocessing. Reattach if it has no tree parent, even if its world
   coordinates have not moved. Check and mutation share the scene critical section.

## Validation

- Actual `KIpotBranch.cpp`, `KIpotLeaf.cpp`, `SceneMath.cpp`: 100 scene rebuilds,
  three stationary NPCs, body/name draw callbacks once each, leave/return,
  removal/recreation, branch/leaf ownership: PASS.
- Production region `.inl` implementations: cache eviction/reentry, duplicate
  and collision guards, preserved action, missing destination, player slot
  recycling: PASS.
- Three world-transition/snapshot source-contract checks: PASS.
- CoreClient Release build: zero errors, zero warnings.
- Published `CoreClient.dll` SHA256:
  `5CBFB35F855A7DB3F770DF7B95D274C3928B51253ED10283505B20305E44C838`.

The tests check real scene traversal and shared region implementation, not GUI
pixel capture. Final user-controlled movement in the new client is still needed
for visual acceptance; no claim of completed NPC business/quest logic.

## Commands and diagnostics

- `Build/Test-NpcSceneMembership.ps1`
- `Tests/Native/NpcRegionLifecycleTests.cpp`
- `Tests/test_npc_region_lifecycle.py`
- `Tests/Native/InspectNpcMembership.cpp` is read-only and requires a matching
  build's NPC symbol RVA and class layout; it never writes process memory.

During deployment, an independent GameServer disconnect crash repeated in
Rainbow.dll+0x24C6. Further investigation found a 1024-byte outgoing buffer used
for multi-kilobyte character saves; that defect is handled separately from the
NPC region/render fixes above.

## Network/persistence blocker fixed in the same deployment

`Rainbow/PhongThanClientSend.inl`, called by `CGameClient::SendPackToServer`,
uses the existing configured packet allocator instead of the 1024-byte socket
chunk pool. It checks WORD framing capacity before encryption, serializes send
order/rolling cipher and contains exceptions within the COM boundary with buffer
cleanup. It does not change the wire protocol or character schema.

- Shared implementation tests: 7908-byte save payload, max WORD payload,
  oversized rejection without cipher change, allocation/add/write exception
  cleanup and send lock: PASS.
- Live native login/Ngoc Hu NPC test after publication: PASS.
- Goddess log now records `role=PhongThanNpc ... saved=1` for 7860-byte state.
  The old path failed to send that state because it exceeded 1024 bytes.
- Subsequent safe server stop completed with exit 0, without force termination.
- Rainbow SHA256, same bytes in client/server:
  `629D0C6079DCE6BE2AC8D87DCD23AD636E3AC0F393D65CD7CD06159331175B1C`.

The observed oversized-send/persistence defect is fixed and live tested. This
does not prove that no other unrelated Rainbow heap/socket defect can exist.
