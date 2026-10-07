$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$encoding = [Text.Encoding]::GetEncoding(28591)
$res = [IO.File]::ReadAllText((Join-Path $root 'Sources/Core/Src/KNpcRes.cpp'), $encoding)
$ctor = [regex]::Match($res, 'KNpcRes::KNpcRes\(\)([\s\S]*?)BOOL\s+KNpcRes::Init').Value
foreach ($pattern in @('ZeroMemory\(m_cDrawFile', 'nType = ISI_T_SPR', 'nISPosition = IMAGE_IS_POSITION_INIT', 'bRenderFlag = RUIMAGE_RENDER_FLAG_REF_SPOT', 'm_ulAdjustColorId = 0')) {
    if ($ctor -notmatch $pattern) { throw "Missing constructor invariant: $pattern" }
}
$draw = [IO.File]::ReadAllText((Join-Path $root 'Sources/Core/Src/CoreDrawGameObj.cpp'), $encoding)
if ($draw -notmatch 'if \(bForcePhongThanPlayerInfo\)\s*\{[^}]*PaintChat\(nPate\);\s*break;') { throw 'Player legacy name pass is not bypassed' }
$scene = [IO.File]::ReadAllText((Join-Path $root 'Sources/Core/Src/Scene/KScenePlaceC.cpp'), $encoding)
if ($scene -notmatch 'nFontSize \+ \(NpcObj.m_Kind == kind_player \? 9 : 2\)') { throw 'Missing player name/bar spacing' }
'PASS: draw descriptor initialization, single player name pass, name/bar spacing (source checks only).'
