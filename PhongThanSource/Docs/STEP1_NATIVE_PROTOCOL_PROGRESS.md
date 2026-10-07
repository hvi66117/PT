# Step 1: native world, combat and Lua interaction protocol

Checkpoint: 2026-09-05. IN PROGRESS, not an acceptance/cutover record.
The full rebuild contract and all nine project workstreams remain in scope.

## Implemented and built in this increment

- GameServer/Core ingress recognizes a native request envelope before the
  single-byte dispatcher. Invalid/truncated frames and invalid connection slots
  are rejected; native playing packets cannot be misread as ping/tong commands.
- Native player snapshot serializes each appearance selector/palette/visibility,
  title, clan label and shop field explicitly. No PLAYERTRADE/KExpandRank/runtime
  appearance object is transmitted. Full/heartbeat snapshots share one contract.
- Native full NPC and NPC-update packets carry MapId and EntityId. TemplateId,
  Level, NameLength and Name are separate fields, not packed template words or
  lengths inferred from legacy byte offsets. Runtime actions are explicitly
  encoded/decoded; their C++ enum ordinals are not network values.
- Native walk/run requests and walk/run/jump broadcasts use map-pixel positions.
  Server checks current map, region and authenticated player's entity.
- Native NPC request/not-found/remove flow is implemented. Requests are scoped
  to the player's nearby entities. Old movement/request/remove/full-NPC/player
  snapshot structs and handlers were removed or their table slots retired.
- Native skill requests and normal/direct skill effects use a separate target
  kind and entity ID (no -1 coordinate sentinel on the wire). Server checks
  learned skill and nearby target. Unused client-provided caster/radius fields
  were removed. Cost/cooldown remain enforced by the existing skill execution.
- Native click-NPC requests reach the server-side action script with the existing
  relation/distance rules. Lua dialog replies/events are NOT migrated yet.
- Every migrated world event is filtered against the client's current MapId.

## Evidence for this increment (not a live game acceptance)

- Release logs: CoreServer, CoreClient, GameServer and GameClient: zero errors.
- Test-PhongThanWorldProtocol.ps1 compiles/runs the native C++ validators:
  43 assertions PASS, including guarded-page truncated-buffer checks (132 sizes).
- Updated item baseline gate: 19 checks PASS. The appearance requirement now
  checks the new scalar wire fields and both serializer directions.
- No staging publication, cutover, database reset or commit was performed.

## Second increment: implemented and built

- Native map snapshot, current-player base/vitals and end-of-sync fence. The
  server compares the returned fence ticket with the authenticated session.
- Base attributes/level fields no longer truncate to the former BYTE/WORD size.
  Current-player Series is distinct from Profession; PlayerId is server-owned.
- Skill lists use counted scalar entries; state effects serialize each attribute
  type/value instead of transmitting KMagicAttrib objects. Skill-point requests,
  skill-level updates, attribute-point requests/updates and state-clear packets
  now have native handlers on both sides.
- Lua UI has a separate local rendering model and a counted native wire schema.
  Dialog tokens bind selections to the current map/prompt; negative/out-of-range,
  stale and replayed selections are rejected. Callback names are copied and the
  old prompt consumed before Lua runs. Closing/cancelling clears the wait state.
- Native position reconciliation/stand/teleport/track, sit/mount/revive requests,
  death/hurt/revive and camp events. Position offsets are derived from absolute
  coordinates, not sent as a second incompatible position representation.
- Native object snapshot/state/direction/remove/request/interaction flow.
  Object requests are checked against adjacent regions; server-local item-array
  indexes are no longer exposed in object packets.
- Four Release targets rebuilt successfully: CoreServer, CoreClient, GameServer,
  GameClient. Native C++ packet/model tests now PASS 89 checks plus the original
  132 guarded-page short-buffer cases. This is not a visual or live-login test.
- Native GameServer configuration is prepared at Deploy/Config/ServerCfg.ini.
  Existing staging still uses older binaries and Transfer/Chat/Tong config;
  no runtime publication/start, database reset or commit has occurred.

## Required before step 1 can be marked complete

1. Finish remaining player event packets: experience/level-up, title/expanded
   title, horse-sync notification and the generic S2C_PLAYER_SYNC value/UI events.
   Audit the remaining producers for the step-1 flows, not just declarations.
2. Route global Lua UI/system notifications through the native relay. The local
   UI transport is native, but the global broadcast helper still reaches the
   retired KNewProtocolProcess transfer queue and is not end-to-end functional.
3. Align affected visual/Lua source gates with the new production entry points;
   do not retain tests that require removed legacy structs or old function names.
4. Assemble a native protocol UAT runtime with five services: Goddess,
   PhongThanAccountServer, PhongThanRelay, Bishop and GameServer. Keep approved
   VNG content intact. Reconcile launcher, artifact allowlist and deployment
   identities; do not reimport older content or start the retired relay binaries.
5. Validate real login/create/select, sync fence, movement, NPC/object interaction,
   skill/effects and dialog replies against the running native services. Only
   after the requested acceptance should the server be left up for user testing.
   Successful compilation and header tests alone do not satisfy this requirement.

Map-data scope remains 102 active map IDs backed by 91 physical map sets.
No collection/reimport of already-validated Region_C/Region_S is part of step 1.

## Live native UAT update (2026-09-05 22:03)

- Fixed the world-entry activation defect: `KPlayerSet::Init` used to load
  optional tables before assigning each `Player`/region-node identity. A missing
  table therefore left active region nodes pointing to `Player[0]`, so the
  authenticated player never emitted live vitals after the sync fence.
- Player slot identity is now initialized before data loading and asserted again
  when a session occupies a free slot.
- Imported the exact VNG player progression, five-series growth, leadership,
  initial-attribute and PK-punishment tables into both content roles and the
  source-controlled project overlay. `level_add.txt` now uses its actual 14-column
  Phong Than schema instead of the former SwordOnline column layout.
- Release CoreServer/CoreClient build passed and the native runtime was
  republished. Real Rainbow transport UAT authenticated account `123456`, selected
  `PhongThanPlay`, entered map 1001, acknowledged the session fence, received the
  self-vitals packet and completed a native run request/response at
  `(49472,104352)`: `PASS REAL_NATIVE_LOGIN_MOVE`.
- Five staging services were left running for manual client testing. Remaining
  unmigrated frames and the NPC/object/dialog/skill acceptance items above still
  prevent declaring the whole step complete.

## GUI character-selection identity fix (2026-09-05 22:38)

- The user's GUI attempt was denied before GameServer attachment, independently
  of the earlier PlayerSet defect. `login_connect_diag.log` showed
  `role=PhongThanPl expected=PhongThanPl permit=0` although the stored role is
  `PhongThanPlay`. `KRoleChiefInfo::Name[12]` held at most 11 name bytes.
- Separated the role-list storage model from the new-name input length policy.
  Its name capacity now matches `PHONGTHAN_CHARACTER_SUMMARY::Name` (32 bytes).
  Production list decoding uses `PhongThanReadLoginRole` and rejects malformed
  names rather than shortening an identity.
- Added executable regression coverage for 11/12/13/31-byte names and malformed
  names. Updated the real-login probe to use the production GUI role decoder;
  the live attempt now returns `PERMIT=1` and
  `PASS REAL_NATIVE_LOGIN_UI_ROLE` after receiving map/self/fence/vitals.
- GameClient Release build and client-only publication passed; only Game.exe
  changed in staging. The server processes did not need restarting. This test
  does not claim the graphical world/rendering acceptance has passed.

## NPC/minimap checkpoint (2026-09-06)

See `Docs/NPC_MINIMAP_FIX_20260906.md` for exact scope and remaining gaps.
Original server population recovered/published: 1,221 records on maps 1014,
1016 and 1052. The previous 34,048-file Seaweed Region_S set had empty NPC
sections throughout and was not evidence of full NPC coverage. Fifteen original
client/server companion cells now bring the geometry inventory to 34,063 per
role. Na Tra's native snapshot/name, Lua open dialogue and close callback passed
a real-session test with diagnostic character PhongThanNpc; the other gameplay
flows are not claimed passed. Minimap uses 91 original PAK metadata files,
87 verified PAK images and the shared world-coordinate projection. The remaining
99 active maps lack verified NPC placement data; four images remain unverified.
