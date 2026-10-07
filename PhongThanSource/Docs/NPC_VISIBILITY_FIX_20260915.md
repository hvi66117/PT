# NPC visibility — 2026-09-15

## Evidence and changes

The latest GUI logs did NOT show a complete absence of NPC data: Sinh Hoat Su,
Xich Tinh Tu, Chuyen Sinh Lao Lao and Van Trung Tu were received on map 1003,
with `res=1`, `body=1` and the expected original PAK sprite paths. Do not replace
Region_S, templates or SPR assets to address this issue.

Confirmed source defects corrected:

- `KRegion::SendNpcSyncDataNear` used an 800-MPS Euclidean circle. The client
  projects Y at half scale: visible corners and lower-screen sprites can be
  outside this circle. `PhongThanNpcVisibility.h` now covers +/-768 X and
  +/-1280 Y within the existing nine-region interest list.
- `KNpc::ChangeWorld` (destination/self snapshot sequence) did not immediately
  republish static NPCs after transfer. It now invokes the existing
  `SyncNpcNearPlayer`; no additional spawns or parallel system.
- `KProtocolProcess::SyncNpc` now rejects a mismatched MapId, refreshes physical
  region identity on reattachment and sets direction for new as well as existing
  NPCs. Existing persistent-NPC lifetime rules remain unchanged.

## Validation performed

- CoreServer and CoreClient Release builds succeeded.
- Ten existing restoration tests passed; new viewport boundary assertions passed.
- New native test compiles the actual `KNpcResNode.cpp`, loads runtime PAK
  configuration and resolves the standing sprite of all **59 unique READY
  templates** through the real classification/action/resource tables. All passed.
  This is stronger than testing a manually assembled list of sprite paths, but
  does not by itself prove final GUI pixels.
- Live Diêu Trì test: Thái Thượng Lão Quân, template 194, MPS (48256,102656);
  menu/about/routes/status/back/close/reopen passed.
- Live Ngọc Hư Cung regression: diagnostic player at (54400,99616) received
  Chuyển Sinh Lão Lão at (54400,100608), delta Y=992. This exact case is excluded
  by the old 800-MPS circle and passes with the new interest rectangle.
- Only diagnostic character `PhongThanNpc` was repositioned for testing.
  User character `test123`, inventories, progression, accepted NPC positions and
  original PAKs were not edited.

Published CoreServer SHA256:
`099C421BF082A1BF731E51177C97C9F6F38ED48CBDEFE2E662E40592A1F5BFC4`

Published CoreClient SHA256:
`AD20F51FD1B76CC4E66CED2B9244E5B6CE95B278243EAB4CFE8DFA3A98924FB2`

Reproducible resource/interest checks: `Build/Test-NpcVisibility.ps1`.

## Limits still explicit

- Windows screenshot/input helper fails during initialization with
  `failed to write kernel assets ... os error 3`. No current GUI screenshot was
  obtained; do not label all visual/map-transition combinations accepted.
- An independent GameServer crash was recorded at 09:14 in Rainbow.dll+0x24C6,
  exception C0000005. The available WER record has no retained stack dump.
  It maps to a std::string copy routine; this alone does not identify its cause.
  No speculative Rainbow patch was deployed. Fresh-server live tests succeeded;
  recurrence still requires a stack dump.
- This does not complete the guide-only NPC business logic or the previously
  documented out-of-bounds Bia Than spawn. Population scope remains 174 NPCs and
  1,183 monsters, not an assertion of NPC coverage on every one of 102 world IDs.

## Final operational blocker

After the Ngoc Hu viewport probe passed, safe shutdown timed out after 180s.
GameServer PID 12300 remains alive in teardown, NOT ready for gameplay. Supporting
DB/relay services were deliberately retained and no force termination performed.
The x86 hang dump is `Output/NpcRestorationTests/GameServer-hang-12300-092813.dmp`.
Main thread stack contains Rainbow `Cleanup` -> `WaitForShutdownToComplete` ->
`CThread::Wait`; another thread is in CRT `__endthreadex` -> `__freeptd` ->
`_free` -> `__lock`. This establishes a networking/CRT teardown hang but is not
enough evidence to label a specific heap-corruption cause repaired.
NPC fixes are published; final GUI acceptance and safe server restart remain
unfinished. Do not report this turn as a complete fix of the independent crash.
