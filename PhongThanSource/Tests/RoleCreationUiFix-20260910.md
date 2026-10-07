# Character creation UI — 2026-09-10

Observed source/data causes:

- `UiSelPlayer::OnNew` hid the role list and opened `UiSelNativePlace`.
  Its scheme is absent from the active runtime/PAK lookups. That left only
  the login background, before the profession screen was reached.
- VNG new-player entry `0xB705E9D8` uses `Gold`, `Wood`, `Water` for the
  three profession buttons, `EditBG` for the name/description background,
  and a `ButtonGroup` final position of `(215,0)`. The client had been
  requesting `GiapSi`, `DaoSi`, `DiNhan`, `Container` instead.
- VNG `Nativeplace` values `2,3,4` must become runtime maps `1002,1003,1004`;
  the current Bishop spawn resolver subtracts RuntimeIdOffset=1000.

Changes:

- New opens `KUiNewPlayer` directly; Cancel returns to the role list.
- Only hide the previous window after successful initialization. Failure
  displays an explicit error rather than leaving an empty background.
- Shared `PhongThanRoleCreationLayout.h` binds the original PAK sections,
  the selectors' parent offset, and an unscaled 1024x768 canvas. `EditBG`
  is non-interactive and placed behind name/description controls.
- Profession changes also update the birthplace. No PAK/artwork was replaced.
- `PakEntryExtract` now accepts `id:<hex>` for unnamed PAK entries.

Verification:

- `Build/Build-PhongThan.ps1 -Targets GameClient -NoRebuild`: passed.
- `Tests/Test-RoleCreationUi.ps1`: passed with the actual Engine and active
  client PAK chain. Checked 6 control/background SPRs, 18 male/female
  idle/select/unselect SPRs, three runtime map entries, native coordinates,
  and rejection of an absent schema.
- Published Game.exe; every Client artifact matches Output and its receipt.
- Full publish validation still flags the pre-existing pending Server
  GameServer.exe build. No server executable was changed or restarted.
- Client PID 6472 started from canonical `Client/Game.exe`, responding.
  Actual interactive profession selection/character creation is pending user test.
- The previous client ran as `game.exe` followed by U+00A0 (PID 18940).
  That process was stopped. Its duplicate file was NOT deleted; use the
  canonical executable. No player/account/save data was changed.
