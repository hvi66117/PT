$ErrorActionPreference='Stop'
$root=Split-Path -Parent $PSScriptRoot
$out=Join-Path $root 'Output/EquipmentSchemaAudit'
$enc=[Text.Encoding]::GetEncoding(28591)
$ids=@{}
foreach($line in [IO.File]::ReadAllLines((Join-Path $out 'set_771097478.txt'),$enc)|Select-Object -Skip 1){
 $c=$line.Split("`t");if($c.Length -gt 1 -and $c[1] -match '^\d+$'){$ids[$c[1]]=$true}
}
$rows=0;$matched=0
foreach($table in 'armor','helm','belt','boot','pendant','meleeweapon','rangeweapon','horse','amulet','ring','cuff'){
 $lines=[IO.File]::ReadAllLines((Join-Path $out "$table.txt"),$enc)
 $header=[Text.Encoding]::GetEncoding(936).GetString($enc.GetBytes($lines[0])).TrimEnd("`r").Split("`t")
 $column=[Array]::IndexOf($header,'套装id')
 foreach($line in $lines|Select-Object -Skip 1){
  if(!$line.Trim()){continue};++$rows
  $c=$line.TrimEnd("`r").Split("`t")
  if($column -lt 0 -or $column -ge $c.Length){continue}
  $id=$c[$column]
  if($id -match '^\d+$' -and [int]$id -gt 0){
   if(!$ids.ContainsKey($id)){throw "Missing set ID $id in $table"};++$matched
  }
 }
}
"PASS: $rows equipment rows; all $matched positive SetID references resolve in PAK entry 771097478 ($($ids.Count) IDs)."
