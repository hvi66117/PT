param([string]$RuntimeRoot='D:\Lam game phong than\PhongThanRuntime-Staging\Server')
$ErrorActionPreference='Stop'
$root=Split-Path -Parent $PSScriptRoot
$out=Join-Path $root 'Output\EquipmentSchemaAudit'
New-Item -ItemType Directory -Path $out -Force | Out-Null
$extract=Join-Path $root 'Output\Tools\PakEntryExtract.exe'
$enc=[Text.Encoding]::GetEncoding(936)
$names=@('armor','helm','belt','boot','pendant','meleeweapon','rangeweapon','horse','amulet','ring','cuff',
 'zhuang_bei_dian_lan_fu_jia_shu_xing_biao','zhuang_bei_dian_lan_fu_jia_kuo_zhan_shu_xing_biao',
 'zhuang_bei_he_cheng_gui_ze_biao','zhuang_bei_sheng_ji_ji_shuai_biao',
 'jia_shi_kui_jia_sheng_ji_shu_zhi_biao','jia_shi_wu_qi_sheng_ji_shu_zhi_biao')
$report=@()
Push-Location $RuntimeRoot
try {
 foreach($name in $names) {
  $dest=Join-Path $out "$name.txt"
  $extractLog=& $extract package.ini "\settings\item\001\$name.txt" $dest 2>&1
  if($LASTEXITCODE -ne 0){$report += [pscustomobject]@{Table=$name;Status='MISSING';Evidence=($extractLog -join ' ')};continue}
  $rawEncoding=[Text.Encoding]::GetEncoding(28591)
  $lines=$rawEncoding.GetString([IO.File]::ReadAllBytes($dest)) -split '\r?\n' | Where-Object { $_.Trim().Length }
  $headers=$enc.GetString($rawEncoding.GetBytes($lines[0].TrimEnd("`r"))).Split("`t")
  $widths=@{}; $expr=@();$shifts=0;$sets=@{}
  for($r=1;$r -lt $lines.Count;$r++){
   $cols=$lines[$r].TrimEnd("`r").Split("`t")
   $key=[string]$cols.Length;$widths[$key]=1+$widths[$key]
   $shift=0
   if($name -eq 'meleeweapon' -and $cols.Length -gt 3 -and $cols[3] -match '^[\\/]'){$shift=-1;$shifts++}
   for($c=1;$c -lt $cols.Length;$c++){
    if($cols[$c] -match '^\*.*\*$' -and $expr.Count -lt 12){$expr += [pscustomobject]@{TemplateRow=$r-1;Column=$c+1;Header=$headers[$c-$shift];Value=$cols[$c]}}
   }
   $setCol=[Array]::IndexOf($headers,'套装id')
   if($setCol -ge 0 -and $setCol+$shift -lt $cols.Length){$id=$cols[$setCol+$shift];if($id -match '^\d+$' -and [int]$id -gt 0){$sets[$id]=1+$sets[$id]}}
  }
  $report += [pscustomobject]@{Table=$name;Status='PAK';Rows=$lines.Count-1;Headers=$headers;RowWidths=$widths;ShiftedRows=$shifts;SetIds=$sets;ExpressionSamples=$expr;Evidence=($extractLog -join ' ')}
 }
} finally {Pop-Location}
$report | ConvertTo-Json -Depth 8 | Set-Content (Join-Path $out 'report.json') -Encoding utf8
$report | Select-Object Table,Status,Rows,ShiftedRows,@{n='SetGroups';e={$_.SetIds.Count}},@{n='ExpressionSamples';e={$_.ExpressionSamples.Count}} | Format-Table -AutoSize
