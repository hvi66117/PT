[CmdletBinding()]
param(
    [string]$SourceRoot,
    [string]$ProjectRoot=(Split-Path -Parent $PSScriptRoot),
    [string[]]$RuntimeRoots=@('D:\Lam game phong than\PhongThanRuntime-Content','D:\Lam game phong than\PhongThanRuntime-Staging'),
    [switch]$Apply
)
$ErrorActionPreference='Stop'
$latin=[Text.Encoding]::GetEncoding(28591)
if(-not $SourceRoot){$SourceRoot=Join-Path $ProjectRoot 'Deploy\ProjectContent\VngNpcRegions\maps'}
$SourceRoot=[IO.Path]::GetFullPath($SourceRoot).TrimEnd('\')
$rows=[Collections.Generic.List[object]]::new()
$npcs=[Collections.Generic.List[object]]::new()
$metadata=$latin.GetString([IO.File]::ReadAllBytes((Join-Path $RuntimeRoots[0] 'Server\settings\WorldSet.ini')))
$mapIds=@{}
foreach($m in [regex]::Matches($metadata,'(?m)^(\d+)=([^\r\n]+)\r?$')) {
    $name=$m.Groups[2].Value
    if(-not $mapIds.ContainsKey($name)){$mapIds[$name]=[Collections.Generic.List[int]]::new()}
    $mapIds[$name].Add([int]$m.Groups[1].Value)
}
foreach($f in Get-ChildItem -LiteralPath $SourceRoot -Recurse -File -Force -Filter '*_region_s.dat') {
    $b=[IO.File]::ReadAllBytes($f.FullName)
    if($b.Length -lt 52){throw "Short Region_S: $($f.FullName)"}
    $sections=[BitConverter]::ToUInt32($b,0)
    $head=4+8L*$sections
    if($sections -lt 6 -or $head -gt $b.Length){throw "Invalid region header: $($f.FullName)"}
    $length=[BitConverter]::ToUInt32($b,24)
    if(-not $length){continue}
    $offset=$head+[BitConverter]::ToUInt32($b,20)
    if($length -lt 12 -or $offset+$length -gt $b.Length){throw "Invalid NPC section: $($f.FullName)"}
    $count=[BitConverter]::ToUInt32($b,$offset)
    if(-not $count){continue}
    $relative=$f.FullName.Substring($SourceRoot.Length+1)
    $name=$relative.Split('\')[0]
    if(-not $mapIds.ContainsKey($name)){throw "Unmapped VNG region: $relative"}
    $runtimeRelative='maps\'+$name+'_S\'+$relative.Substring($name.Length+1)
    $originalCompanion=$f.FullName -replace '_region_s.dat$','_region_c.dat'
    $pos=$offset+12
    for($i=0;$i -lt $count;$i++) {
        if($pos+60 -gt $offset+$length){throw "Truncated NPC record: $relative"}
        $scriptLen=[BitConverter]::ToUInt16($b,$pos+58)
        if($pos+60+$scriptLen -gt $offset+$length){throw "Truncated NPC script: $relative"}
        $npcName=$latin.GetString($b,$pos+16,32).Split([char]0)[0]
        $script=$latin.GetString($b,$pos+60,$scriptLen).TrimEnd([char]0)
        $npcs.Add([pscustomobject]@{MapIds=@($mapIds[$name]);Template=[BitConverter]::ToInt32($b,$pos);X=[BitConverter]::ToInt32($b,$pos+4);Y=[BitConverter]::ToInt32($b,$pos+8);NameBytes=$npcName;Level=[BitConverter]::ToInt16($b,$pos+48);Kind=[BitConverter]::ToInt16($b,$pos+54);Script=$script;Region=$runtimeRelative})
        $pos+=60+$scriptLen
    }
    if($pos -ne $offset+$length){throw "Unconsumed NPC section: $relative"}
    $companion=''
    # The 15 cells absent from the Seaweed base have original client payloads
    # in the project overlay. Retain this identity on repeated publication.
    if($SourceRoot.StartsWith((Join-Path $ProjectRoot 'Deploy\ProjectContent'),[StringComparison]::OrdinalIgnoreCase) -and
       (Test-Path -LiteralPath $originalCompanion)){$companion=$originalCompanion}
    foreach($root in $RuntimeRoots) {
        $target=Join-Path $root ('Server\'+$runtimeRelative)
        if(-not(Test-Path -LiteralPath $target -PathType Leaf)){
            $companion=$f.FullName -replace '_region_s.dat$','_region_c.dat'
            if(-not(Test-Path -LiteralPath $companion -PathType Leaf)){throw "Missing original Region_C companion: $companion"}
        }
    }
    $rows.Add([pscustomobject]@{Source=$f.FullName;RelativePath=$runtimeRelative;Sha256=(Get-FileHash -LiteralPath $f.FullName).Hash;NpcCount=$count;MapIds=@($mapIds[$name]);MissingCellClientSource=$companion;ClientRelativePath=('maps\'+($relative -replace '_region_s.dat$','_region_c.dat'))})
}
if($Apply) {
    foreach($root in $RuntimeRoots) {
        $serverRoot=[IO.Path]::GetFullPath((Join-Path $root 'Server')).TrimEnd('\')
        $running=@(Get-CimInstance Win32_Process | Where-Object {$_.ExecutablePath -and $_.ExecutablePath.StartsWith($serverRoot+'\',[StringComparison]::OrdinalIgnoreCase)})
        if($running){throw "Stop server before importing NPC regions: $serverRoot"}
    }
    foreach($row in $rows) {
        foreach($root in $RuntimeRoots) {
            $target=Join-Path $root ('Server\'+$row.RelativePath)
            New-Item -ItemType Directory -Path (Split-Path -Parent $target) -Force | Out-Null
            Copy-Item -LiteralPath $row.Source -Destination $target -Force
            if((Get-FileHash -LiteralPath $target).Hash -ne $row.Sha256){throw "NPC region hash mismatch: $target"}
            if($row.MissingCellClientSource){
                $clientTarget=Join-Path $root ('Client\'+$row.ClientRelativePath)
                if(Test-Path -LiteralPath $clientTarget){
                    if((Get-FileHash -LiteralPath $clientTarget).Hash -ne (Get-FileHash -LiteralPath $row.MissingCellClientSource).Hash){throw "Different client companion: $clientTarget"}
                    continue
                }
                New-Item -ItemType Directory -Path (Split-Path -Parent $clientTarget) -Force | Out-Null
                Copy-Item -LiteralPath $row.MissingCellClientSource -Destination $clientTarget
            }
        }
    }
}
$report=[pscustomobject]@{Schema=1;SourceRoot=$SourceRoot;Applied=[bool]$Apply;RegionCount=$rows.Count;NpcCount=$npcs.Count;MapIds=@($rows | ForEach-Object MapIds | Sort-Object -Unique);Regions=@($rows);Npcs=@($npcs)}
$path=Join-Path $ProjectRoot 'Docs\VNG_NPC_REGION_IMPORT.json'
[IO.File]::WriteAllText($path,($report | ConvertTo-Json -Depth 8),[Text.UTF8Encoding]::new($false))
[pscustomobject]@{Applied=[bool]$Apply;Regions=$rows.Count;NpcRecords=$npcs.Count;MapIds=($report.MapIds -join ',');Report=$path}
