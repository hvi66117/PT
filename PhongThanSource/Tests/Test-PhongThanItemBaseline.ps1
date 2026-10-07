[CmdletBinding()]
param([string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot))

$ErrorActionPreference = 'Stop'
$latin1 = [Text.Encoding]::GetEncoding(28591)

function Read-Source([string]$RelativePath) {
    [IO.File]::ReadAllText((Join-Path $ProjectRoot $RelativePath), $latin1)
}

$itemList = Read-Source 'Sources\Core\Src\KItemList.cpp'
$generator = Read-Source 'Sources\Core\Src\KItemGenerator.CPP'
$playerDb = Read-Source 'Sources\Core\Src\KPlayerDBFuns.cpp'
$protocolProcess = Read-Source 'Sources\Core\Src\KProtocolProcess.cpp'
$viewItem = Read-Source 'Sources\Core\Src\KViewItem.cpp'
$sellItem = Read-Source 'Sources\Core\Src\KSellItem.cpp'
$protocol = Read-Source 'Headers\KProtocol.h'
$wireProtocol = Read-Source 'Headers\PhongThanProtocol.h'
$worldProtocol = Read-Source 'Headers\PhongThanWorldProtocol.h'
$playerSnapshot = Read-Source 'Sources\Core\Src\PhongThanPlayerSnapshot.inl'
$appearanceResolver = Read-Source 'Sources\Core\Src\KPhongThanAppearance.cpp'
$npcRenderer = Read-Source 'Sources\Core\Src\KNpcRes.cpp'
$coreSources = @(
    Get-ChildItem -LiteralPath (Join-Path $ProjectRoot 'Sources\Core\Src') -File |
        Where-Object Extension -Match '^\.(?:c|cpp|h)$' |
        ForEach-Object { [IO.File]::ReadAllText($_.FullName, $latin1) }
) -join "`n"

$checks = [ordered]@{
    EquipWritesSelectedSlot = $itemList -match '(?m)^\s*m_EquipItem\[nEquipPlace\]\s*=\s*nIdx;'
    PendantUsesVngEquipId = $itemList -match 'ResolvePhiPhong\(Item\[nIdx\]\.GetEquipId\(\)'
    ProtocolCarriesAppearanceModel = $worldProtocol -match 'PHONGTHAN_VISUAL_PART_WIRE Helm, Armor, Weapon, PhiPhong, Horse;' -and
                                     $worldProtocol -match 'PHONGTHAN_U8 Mounted;' -and
                                     $worldProtocol -notmatch '\b(?:PHONGTHAN_APPEARANCE|KExpandRank|PLAYERTRADE)\b' -and
                                     $playerSnapshot -match 'PhongThanEncodeVisualPart\(snapshot->Horse, m_Appearance.Horse\)' -and
                                     $protocolProcess -match 'PhongThanDecodeVisualPart\(Npc\[nIdx\].m_Appearance.Horse, pPlaySync->Horse\)'
    ResolvesVngPaletteColumn = $appearanceResolver -match 'GetInteger\(nRow, 3, 0, &nPaletteId\)' -and
                               $appearanceResolver -match 'pVisual->nPaletteId = nPaletteId'
    UsesPhongThanAppearanceSubsystem = $appearanceResolver -match 'KPhongThanAppearance::ResolveTablePart' -and
                                       -not (Test-Path -LiteralPath (Join-Path $ProjectRoot 'Sources\Core\Src\KItemChangeRes.cpp')) -and
                                       -not (Test-Path -LiteralPath (Join-Path $ProjectRoot 'Sources\Core\Src\KItemChangeRes.h'))
    RendererAppliesPartPalette = $npcRenderer -match 'm_nPartPalette\[m_nSortTable\[i\]\]' -and
                                 $npcRenderer -match 'IMAGE_RENDER_STYLE_ALPHA_COLOR_ADJUST'
    RestoreUsesTemplateRow = $playerDb -match 'Gen_ExistEquipmentByTemplateRow'
    ClientSyncUsesTemplateRow = $protocolProcess -match 'pItem->TemplateRow'
    ViewUsesTemplateRow = $viewItem -match 'm_nTemplateRow'
    TradeUsesTemplateRow = $sellItem -match 'm_nTemplateRow'
    GeneratorAssignsTemplateRow = $generator -match 'Gen_EquipmentByTemplateRow' -and
                                  $generator -match 'SetRow\(nTemplateRow\)'
    RemovesTupleRowFormula = $coreSources -notmatch '(?i)(particular|GetParticular\(\)).{0,24}\*\s*10.{0,24}(level|GetLevel\(\))'
    RemovesLegacyMantleItemState = $coreSources -notmatch '\b(?:nMantle|m_MantleType|GetMantle|SetMantle|SetMantleItem|GetMantleItem)\b'
    RemovesLegacyPendantVisualState = $coreSources -notmatch '\b(?:m_PenDType|GetPenDRes|SetPenD)\b'
    RemovesSplitLegacyAppearanceState = $coreSources -notmatch '\b(?:m_HelmType|m_ArmorType|m_WeaponType|m_HorseType|m_PhiPhongType)\b'
    RemovesLegacyChangerTables = $coreSources -notmatch '(?:CloakRes|GoldEquipRes|HoodsRes)\.txt'
    ItemUsesSelfDescribingWirePacket = $wireProtocol -match 'PHONGTHAN_WIRE_HEADER\s+Header;' -and
                                       $wireProtocol -match 'PHONGTHAN_MSG_INVENTORY_ITEM_SNAPSHOT' -and
                                       $itemList -match 'PhongThanInitializeWireHeader\(&sItem\.Header'
    ItemWireDoesNotExposeRuntimeClasses = $wireProtocol -notmatch '\b(?:PlayerItem|KLockItem|KMagicAttrib|KItem)\b'
    LegacyItemSyncStructRemoved = $protocol -notmatch '\bPHONGTHAN_ITEM_SYNC\b'
}

$failed = @($checks.GetEnumerator() | Where-Object { -not $_.Value } | ForEach-Object Key)
if ($failed.Count) { throw "Phong Than item baseline gate FAIL: $($failed -join ', ')" }

[pscustomobject]@{
    Result = 'PASS'
    Checks = $checks.Count
}
