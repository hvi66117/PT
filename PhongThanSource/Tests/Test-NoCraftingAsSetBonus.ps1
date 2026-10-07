$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$source = [IO.File]::ReadAllText((Join-Path $root 'Sources/Core/Src/KItemGenerator.CPP'))
$start = $source.IndexOf('BOOL KItemGenerator::ApplyPhongThanSetAttrib(')
$end = $source.IndexOf('KItemGenerator::KItemGenerator()', $start)
$body = $source.Substring($start, $end-$start)
if ($body -match 'ApplyVngSetAttrib\(pItem\)') { throw 'Crafting group still attached as equipment set bonus' }
if (!$body.Contains('ZeroMemory(pItem->m_aryMagicAttrib')) { throw 'Stale bonus slots not cleared during regeneration' }
'PASS: equipment reconstruction does not attach crafting GroupID as SetID.'
