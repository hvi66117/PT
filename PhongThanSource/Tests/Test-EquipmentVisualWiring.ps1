$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$enc = [Text.Encoding]::GetEncoding(28591)
function ReadSource($p) { [IO.File]::ReadAllText((Join-Path $root $p), $enc) }
$node = ReadSource 'Sources/Core/Src/KNpcResNode.cpp'
foreach ($column in 2,3,4,5,6,7) {
    if ($node -notmatch "KindFile.GetString\(nFindNo, $column,") { throw "Missing VNG field $column" }
}
$res = ReadSource 'Sources/Core/Src/KNpcRes.cpp'
if ($res -notmatch 'if \(bPhongThanPlayer && !m_pcResNode\)') { throw 'Direct body fallback overrides the VNG tables' }
$ui = ReadSource 'Sources/GameClient/Ui/Elem/WndObjContainer.cpp'
if ($ui -notmatch 'm_nContainerId == UOC_EQUIPTMENT \? 1 : 0') { throw 'Equipment size not forwarded' }
if ([regex]::Matches($ui,'Shadow.Color.Color_dw == l_BgColors\[0\]').Count -ne 2) { throw 'Normal green fill still enabled' }
$core = ReadSource 'Sources/Core/Src/CoreDrawGameObj.cpp'
if ($core -notmatch 'PaintEquipmentSlot\(x, y, Width, Height\)') { throw 'Equipment renderer not connected' }
$render = ReadSource 'Sources/Represent/Represent2/KRepresentShell2.cpp'
$stretch = $render.Substring($render.IndexOf('case RU_T_IMAGE_STRETCH:'))
if ($stretch -notmatch 'pTemp->nType == ISI_T_SPR' -or $stretch -notmatch 'width \* height \* 3') { throw 'SPR scaling unavailable' }
'PASS: equipment visual source wiring (not a live visual acceptance test).'
