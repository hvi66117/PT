$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$items = [IO.File]::ReadAllText((Join-Path $root 'Sources/Core/Src/KItemList.cpp'), [Text.Encoding]::GetEncoding(28591))
if ($items -notmatch 'nAppearanceRecord = Item\[nIdx\]\.GetRow\(\) \+ 1') { throw 'Appearance must use the one-based template record' }
foreach ($part in 'Armor','Helm','Horse') {
    if ($items -notmatch "Resolve$part\(nAppearanceRecord, &Visual\)") { throw "Incorrect item lookup key: $part" }
}
if ($items -notmatch 'ResolveWeapon\(Item\[nIdx\]\.GetDetailType\(\),\s*nAppearanceRecord, &Visual\)') { throw 'Incorrect weapon lookup key' }
$source = [IO.File]::ReadAllText((Join-Path $root 'Sources/Core/Src/KPhongThanAppearance.cpp'))
foreach ($part in 'Armor','Helm','MeleeWeapon','RangeWeapon') {
    if ($source -notmatch "ResolveTablePart\(m_$part, nEquipId, 1, pVisual\)") { throw "Invalid one-based part mapping: $part" }
}
$res = [IO.File]::ReadAllText((Join-Path $root 'Sources/Core/Src/KNpcRes.cpp'), [Text.Encoding]::GetEncoding(28591))
if ($res -match 'GetImageParam\(m_cNpcImage\[i\]') { throw 'Body metadata is reloaded inside the frame loop' }
if ($res -notmatch 'SetCurFrame\(dir \* frames \+ phase\)') { throw 'Missing per-component animation phase' }
'PASS: one-based equipment mapping and per-component frame wiring (source regression).'
