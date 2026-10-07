# Appearance investigation — 2026-09-09

Requested `Test-PhongThanCharacterVisualPipeline.ps1` does not exist; closest existing gate is `Test-VngCharacterVisualPipeline.ps1`.

## Proven issues fixed

1. `KPhongThanAppearance::ResolveHorse` subtracted 0 from VNG's one-based part number. `KNpcResNode` loads data row `j+2` into CRESINFO index j. Horse tables begin with mount 1 (jsx01), so part 7 must select index 6 / jsx07, not index 7 / jsx08. Changed offset to 1; no resource names or PAK data changed.
2. Native mount-event consumer called `KNpc::SwitchRideHorse`, which requires an equipped item in `Player[m_nPlayerIdx]` before setting mounted state. Remote actors do not own local inventory. Consumer now sets canonical m_bRideHorse like SyncPlayer; existing per-frame SetRideHorse/SetHorse handles resources. No wire layout or renderer changes.

## Shared pipeline trace

- KItemGenerator -> KItem template row -> KItemList::Equip -> existing VNG part tables -> m_Appearance.
- SendEquippedAppearanceNow and BuildPhongThanPlayerSnapshot include all five visual parts. Native SyncPlayer decodes them for both local and remote EntityId.
- KNpc frame update calls SetRideHorse, SetAction and all part setters. No missing visual fields proved.
- KInventory handles occupied cells, not visual selection; KMagicDesc builds tooltips, not world sprites.
- Weapon/armor currently use one-based item row lookup and offset 1. No speculative change to those mappings was made.
- PhiPhong resolver still uses an arithmetic selector rather than a verified VNG part-table relation; unsupported mapping not expanded in this pass.

## Validation / limits

CoreClient/CoreServer build succeeded. New Test-AppearanceMountIndex checks conversion and event-consumer wiring. Existing broad gate fails four checks: EquipPipelinePassesVngEquipmentId, VngHumanCompositeUsesOneReferenceSpot, ProtocolRejectsMountedSit, GoldEquipmentUsesOnlyVngPartTables. These include stale source-pattern assumptions and unresolved cloak mapping; gate was not rewritten to force green.

No Game.exe process was running during initial inspection. Mounted motion/direction/action, relog, equipment replacement and another client's visual observation are NOT verified. Off-by-one proves incorrect mount selection, not that it alone explains every invisible mount. Equipment invisibility root cause is still unproven. Build output has not been deployed by this pass.
