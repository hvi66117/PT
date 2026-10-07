param([string]$RuntimeRoot='D:\Lam game phong than\PhongThanRuntime-Staging\Server')
$ErrorActionPreference='Stop'
$root=Split-Path -Parent $PSScriptRoot
$out=Join-Path $root 'Output/EquipmentSchemaAudit'
$cp936=[Text.Encoding]::GetEncoding(936)
$definitions=@(
 @{Name='upgrade_power';Path='\settings\powervalue\装备升级功力表.txt'},
 @{Name='activation_power';Path='\settings\powervalue\装备激活属性评分表.txt'}
)
Push-Location $RuntimeRoot
try {
 foreach($entry in $definitions){
  $pathFile=Join-Path $out ($entry.Name+'.path')
  [IO.File]::WriteAllBytes($pathFile,$cp936.GetBytes($entry.Path))
  $output=Join-Path $out ($entry.Name+'.txt')
  & "$root\Output\Tools\PakEntryExtract.exe" package.ini "@$pathFile" $output
  if($LASTEXITCODE -ne 0){throw "Missing original power table: $($entry.Path)"}
  $lines=$cp936.GetString([IO.File]::ReadAllBytes($output)) -split '\r?\n' | Where-Object {$_.Trim()}
  [pscustomobject]@{Table=$entry.Path;Rows=$lines.Count-1;Columns=$lines[0].Split("`t").Count;Sha256=(Get-FileHash $output).Hash}
 }
} finally {Pop-Location}
