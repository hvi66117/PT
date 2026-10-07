$ErrorActionPreference='Stop'
$root=Split-Path -Parent $PSScriptRoot
$enc=[Text.Encoding]::GetEncoding(28591)
$item=[IO.File]::ReadAllText((Join-Path $root 'Sources/Core/Src/KItem.cpp'),$enc)
$start=$item.IndexOf('BOOL KItem::SetAttrib_CBR(')
$end=$item.IndexOf('BOOL KItem::SetAttrib_Base(', $start)
$body=$item.Substring($start,$end-$start)
$clear=$body.IndexOf('ZeroMemory(m_aryMagicAttrib, sizeof(m_aryMagicAttrib))')
if($clear -lt 0 -or $clear -gt $body.IndexOf('SetAttrib_Base(')){throw 'Template reconstruction leaves stale magic effects'}
$gen=[IO.File]::ReadAllText((Join-Path $root 'Sources/Core/Src/KItemGenerator.CPP'))
foreach($name in 'Gen_EquipmentByTemplateRow','Gen_ExistEquipmentByTemplateRow'){
 $a=$gen.IndexOf('BOOL KItemGenerator::'+$name+'(')
 $b=$gen.IndexOf('BOOL KItemGenerator::',$a+5)
 $fn=$gen.Substring($a,$b-$a)
 if(!$fn.Contains('SetAttrib_CBR(pEqu)') -or !$fn.Contains('ApplyPhongThanSetAttrib(pItem, pEqu)')){throw "Divergent template reconstruction: $name"}
}
'PASS: shared new/reload reconstruction wiring and stale-effect reset (source checks only).'
