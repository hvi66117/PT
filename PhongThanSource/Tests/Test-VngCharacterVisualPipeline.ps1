[CmdletBinding()]
param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$RuntimeRoot = 'D:\Lam game phong than\PhongThanRuntime-Staging'
)

$ErrorActionPreference = 'Stop'
$latin1 = [Text.Encoding]::GetEncoding(28591)
function Read-Source([string]$RelativePath) {
    [IO.File]::ReadAllText((Join-Path $ProjectRoot $RelativePath), $latin1)
}

$protocol = Read-Source 'Sources\Core\Src\KProtocolProcess.cpp'
$npcRes = Read-Source 'Sources\Core\Src\KNpcRes.cpp'
$npcResNode = Read-Source 'Sources\Core\Src\KNpcResNode.cpp'
$npcSource = Read-Source 'Sources\Core\Src\KNpc.cpp'
$itemHeader = Read-Source 'Sources\Core\Src\KItem.h'
$itemSource = Read-Source 'Sources\Core\Src\KItem.cpp'
$appearanceHeader = Read-Source 'Sources\Core\Src\KPhongThanAppearance.h'
$appearanceSource = Read-Source 'Sources\Core\Src\KPhongThanAppearance.cpp'
$itemList = Read-Source 'Sources\Core\Src\KItemList.cpp'
$scene = Read-Source 'Sources\Core\Src\Scene\KScenePlaceC.cpp'
$draw = Read-Source 'Sources\Core\Src\CoreDrawGameObj.cpp'
$represent2 = Read-Source 'Sources\Represent\Represent2\KRepresentShell2.cpp'

$minSync = [regex]::Match(
    $protocol,
    'void KProtocolProcess::SyncPlayer\(BYTE\* pMsg\)(?<body>[\s\S]*?)void KProtocolProcess::SyncScriptAction').Groups['body'].Value
if (-not $minSync) { throw 'Cannot locate native player snapshot consumer.' }

$checks = [ordered]@{
    HeartbeatDoesNotResetNpcResources = $minSync -match 'if \(pPlaySync->FullSnapshot\) Npc\[nIdx\]\.ResetNpcTypeName\(1\);' -and
                                        ([regex]::Matches($minSync, 'ResetNpcTypeName').Count -eq 1)
    HelmSkipsUnchangedSelector = $npcRes -match 'SameVisualPart\(m_HelmVisual, Visual\)'
    PendantSkipsUnchangedSelector = $npcRes -match 'SameVisualPart\(m_PhiPhongVisual, Visual\)'
    ArmorSkipsUnchangedSelector = $npcRes -match 'SameVisualPart\(m_ArmorVisual, Visual\)'
    WeaponSkipsUnchangedSelector = $npcRes -match 'SameVisualPart\(m_WeaponVisual, Visual\)'
    ItemStoresVngEquipmentId = $itemHeader -match 'nEquipId' -and $itemSource -match 'nEquipId\s*=\s*sData\.m_nEquipId'
    EquipPipelinePassesVngEquipmentId = $itemList -match 'ResolveArmor\(Item\[nIdx\]\.GetEquipId\(\)' -and
                                          $itemList -match 'ResolveWeapon\([^;]*Item\[nIdx\]\.GetEquipId\(\)' -and
                                          $itemList -match 'ResolveHorse\(Item\[nIdx\]\.GetEquipId\(\)'
    PartLookupUsesAuthoritativeIdColumn = $appearanceSource -match 'GetInteger\(nRow, 1, 0, &nTableEquipId\)' -and
                                           $appearanceSource -match 'nTableEquipId != nEquipId'
    PublicPartApiAcceptsEquipmentId = $appearanceHeader -match 'ResolveWeapon\(int nDetail, int nEquipId,' -and
                                      $appearanceHeader -match 'ResolveArmor\(int nEquipId,'
    FinalOverlayUsesVngHealthBar = $scene -match 'PaintPhongThanLifeBarOverlay' -and
                                   $scene -match '\\\\spr\\\\ui4\\\\barback\.spr'
    LegacyLifePassSkippedForOverlayObjects = $draw -match '!bForcePhongThanNpcInfo && !bForcePhongThanPlayerInfo && NpcSet\.CheckShowLife\(\)'
    CharacterBodyUsesOriginalWorldAnchor = $npcRes -notmatch 'nScreenX\s*[+\-]=' -and
                                           $npcRes -notmatch 'nScreenY\s*[+\-]='
    CharacterPartsHaveNoFilenameOffsets = $npcRes -notmatch 'strstr\(m_cDrawFile\[nPos\]\.szImage,\s*"(?:human|circle-11)"\)' -and
                                          $npcRes -notmatch 'm_n[XY]pos\s*-=\s*(?:95|225)'
    VngHumanCompositeUsesOneReferenceSpot = $represent2 -match 'IsPhongThanHumanComposite' -and
                                            $represent2 -match 'pSprHeader->Width == 510 && pSprHeader->Height == 510' -and
                                            $represent2 -match 'nX -= 255;\s*nY -= 293;'
    BlurUsesSameWorldAnchor = $npcRes -match 'm_cNpcBlur\.SetMapPos\(nScreenX, nScreenY, nScreenZ, nNpcIdx\)'
    OverlayUsesRepresentProjection = $scene -match 'static void ProjectPhongThanWorldAnchor' -and
                                      $scene -match 'ProjectPhongThanWorldAnchor\(\s*nMpsX, nMpsY, nNameHeight'
    MountedFallbackUsesResolvedVngAction = $npcRes -match 'GetPhongThanPlayerActionSpr\(m_nAction\)' -and
                                           $npcRes -match '"rs0", "rs1", "rs2"' -and
                                           $npcRes -match '"rr0", "rr1", "rr2"'
    RideStateResolvedBeforeAnimation = $npcSource -match 'SetRideHorse\(bRenderRideHorse\);\s*m_DataRes\.SetAction\(nRenderDoing\);'
    MountedSitNormalizedForRendering = $npcSource -match 'bRenderRideHorse && nRenderDoing == cdo_sit' -and
                                       $npcSource -match 'nRenderDoing = cdo_stand'
    ResourceInitResolvesRideBeforeAction = ([regex]::Matches(
        $npcSource,
        'SetRideHorse\(bRenderRideHorse\);\s*m_DataRes\.SetAction\(nRenderDoing\);').Count -ge 3)
    ActionCacheIncludesResolvedVngAction = $npcRes -match 'm_nDoing == nDoing && m_nAction == nResolvedAction' -and
                                           $npcRes -match 'm_bRideHorse == bRideHorse && m_nAction == nResolvedAction'
    GameplayRejectsMountedSit = $npcSource -match 'void KNpc::DoSit\(\)[\s\S]*?if \(m_bRideHorse\)[\s\S]*?DoStand\(\);'
    ProtocolRejectsMountedSit = $protocol -match 'm_btSitFlag && !Npc\[Player\[nIndex\]\.m_nIndex\]\.m_bRideHorse'
    HorseEquipClearsSavedSit = $itemList -match 'm_bRideHorse = TRUE;[\s\S]*?m_Doing == do_sit[\s\S]*?SendCommand\(do_stand\);'
    VngActionTableUsesEightStyleColumns = $npcResNode -match 'GetPhongThanStyleColumn\(nDoing\)' -and
                                          $npcResNode -match 'GetValue\(nEquipNo, nStyle\)'
    MountedFallbackUsesRideActionFamily = $npcResNode -match 'case 3: return 19;[\s\S]*?case 4: return 22;[\s\S]*?case 5: return 25;[\s\S]*?case 6: return 28;' -and
                                           $npcResNode -match 'default: return 16;'
    MountedSitNeverSelectsNormalSit = $npcResNode -match 'case cdo_sit:[\s\S]*?return 1;' -and
                                       $npcResNode -match 'GetPhongThanFallbackAction\(nStyle, bRideHorse\)'
    VngMountDirectionMetadataNormalized = $npcRes -match 'GetPhongThanPlayerSpriteDirs' -and
                                           $npcRes -match 'nFrames % 8' -and
                                           $npcResNode -match '\*pnFrames % 8'
    VngEquipmentIdHasNoLegacyLevelGate = $appearanceSource -notmatch '\bnLevel\b' -and
                                         ([regex]::Matches($appearanceSource, 'nEquipId <= 0').Count -ge 2)
    GoldEquipmentUsesOnlyVngPartTables = $appearanceSource -notmatch 'm_Gold\.(?:Load|GetString)' -and
                                         $appearanceSource -notmatch '(?:CHANGERES|APPEARANCE)_GOLD_FILE' -and
                                         $appearanceHeader -notmatch 'm_Gold|m_bGoldLoaded' -and
                                         $appearanceSource -match 'ResolveTablePart\(m_Horse, nEquipId, 0, pVisual\)' -and
                                         $appearanceSource -match 'ResolveTablePart\(m_Armor, nEquipId, 2, pVisual\)'
    LegacyItemChangeResolverRemoved = -not (Test-Path -LiteralPath (Join-Path $ProjectRoot 'Sources\Core\Src\KItemChangeRes.cpp')) -and
                                      -not (Test-Path -LiteralPath (Join-Path $ProjectRoot 'Sources\Core\Src\KItemChangeRes.h'))
}

$failed = @($checks.GetEnumerator() | Where-Object { -not $_.Value } | ForEach-Object Key)
if ($failed.Count) { throw "VNG character visual gate FAIL: $($failed -join ', ')" }

$sprList = Join-Path $ProjectRoot 'Tests\VngHpSprAudit.txt'
$sprAudit = Join-Path $ProjectRoot 'Output\Tools\SprLoaderAudit.exe'
$clientRoot = Join-Path $RuntimeRoot 'Client'
foreach ($required in $sprList, $sprAudit, (Join-Path $clientRoot 'package.ini')) {
    if (-not (Test-Path -LiteralPath $required -PathType Leaf)) { throw "Missing dependency: $required" }
}
$oldLocation = Get-Location
try {
    Set-Location -LiteralPath $clientRoot
    $sprOutput = & $sprAudit 'package.ini' $sprList 2>&1
    $sprExitCode = $LASTEXITCODE
}
finally {
    Set-Location -LiteralPath $oldLocation
}
$sprText = $sprOutput -join '; '
if ($sprExitCode -ne 0 -or $sprText -notmatch 'SPR_FAILURES=0') {
    throw "VNG health SPR gate FAIL: $($sprOutput -join '; ')"
}

[pscustomobject]@{
    Result = 'PASS'
    Checks = $checks.Count
    SprAudit = $sprText
}
