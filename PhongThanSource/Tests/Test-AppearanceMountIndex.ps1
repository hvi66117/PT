$ErrorActionPreference='Stop'
$root=Split-Path -Parent $PSScriptRoot
$enc=[Text.Encoding]::GetEncoding(28591)
$appearance=[IO.File]::ReadAllText((Join-Path $root 'Sources/Core/Src/KPhongThanAppearance.cpp'),$enc)
if($appearance -notmatch 'ResolveTablePart\(m_Horse, nEquipId, 1, pVisual\)'){throw 'Horse selector is not converted to zero-based resource slot'}
$dispatch=[IO.File]::ReadAllText((Join-Path $root 'Sources/Core/Src/PhongThanWorldDispatch.inl'),$enc)
if($dispatch -match 'SwitchRideHorse\(\(\(const PHONGTHAN_MOUNT_EVENT'){throw 'Mount event incorrectly requires local inventory'}
if(!$dispatch.Contains('Npc[index].m_bRideHorse = ((const PHONGTHAN_MOUNT_EVENT*)data)->Mounted')){throw 'Mount event does not update canonical state'}
$res=[IO.File]::ReadAllText((Join-Path $root 'Sources/Core/Src/KNpcResNode.cpp'),$enc)
if($res -notmatch 'SectFile.GetString\(\s*j \+ 2,'){throw 'Resource row origin changed; re-audit index conversion'}
$npc=[IO.File]::ReadAllText((Join-Path $root 'Sources/Core/Src/KNpc.cpp'),$enc)
if(!$npc.Contains('m_DataRes.SetRideHorse(bRenderRideHorse)') -or !$npc.Contains('m_DataRes.SetHorse(m_Appearance.Horse)')){throw 'Existing render refresh missing'}
'PASS: zero-based horse selection and inventory-independent mount event wiring (source checks, not visual acceptance).'
