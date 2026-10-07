[CmdletBinding()]
param([string]$ProjectRoot=(Split-Path -Parent $PSScriptRoot),[string]$RuntimeRoot='D:\Lam game phong than\PhongThanRuntime-Staging')
$ErrorActionPreference='Stop'
$ProjectRoot=[IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
$RuntimeRoot=[IO.Path]::GetFullPath($RuntimeRoot).TrimEnd('\')
if($RuntimeRoot -ine (Join-Path (Split-Path -Parent $ProjectRoot) 'PhongThanRuntime-Staging')){throw 'Publish target must be the named staging runtime.'}
$running=@(Get-CimInstance Win32_Process | Where-Object {$_.ExecutablePath -and $_.ExecutablePath.StartsWith($RuntimeRoot+'\',[StringComparison]::OrdinalIgnoreCase)})
if($running){throw "Runtime is running: $($running.Name -join ', ')"}
$manifest=Get-Content (Join-Path $PSScriptRoot 'RUNTIME_CONTENT_MANIFEST.json') -Raw | ConvertFrom-Json
$artifacts=[Collections.Generic.List[object]]::new()
foreach($role in 'Client','Server'){
    $target=Join-Path $RuntimeRoot $role
    if(-not(Test-Path -LiteralPath (Join-Path $target 'settings'))){throw "Missing existing VNG content: $target"}
    $names=@($manifest.Roles.$role.ArtifactFiles)
    if($role -eq 'Server'){$names=@($names | Where-Object {$_ -notin @('S3Relay.exe','PhongThanRelayServer.exe')})+@('PhongThanRelay.exe')}
    foreach($name in $names){
        $source=Join-Path $ProjectRoot "Output\$role\$name"
        if(-not(Test-Path -LiteralPath $source)){throw "Missing build: $source"}
        $destination=Join-Path $target $name
        Copy-Item -LiteralPath $source -Destination $destination -Force
        $hash=(Get-FileHash -LiteralPath $source).Hash
        if((Get-FileHash -LiteralPath $destination).Hash -ne $hash){throw "Binary mismatch: $destination"}
        $artifacts.Add([pscustomobject]@{Role=$role;Name=$name;Sha256=$hash})
    }
}
$configs=[Collections.Generic.List[object]]::new()
foreach($role in 'Client','Server') {
    Copy-Item -LiteralPath (Join-Path $PSScriptRoot 'ProjectContent\settings\item\PhongThanHorseVisual.txt') -Destination (Join-Path $RuntimeRoot "$role\settings\item\PhongThanHorseVisual.txt") -Force
}
foreach($name in 'ServerCfg.ini','PhongThanRelay.ini'){
    $source=Join-Path $PSScriptRoot "Config\$name"
    Copy-Item -LiteralPath $source -Destination (Join-Path $RuntimeRoot "Server\$name") -Force
    $configs.Add([pscustomobject]@{Name=$name;Sha256=(Get-FileHash -LiteralPath $source).Hash})
}
$pakChain=& (Join-Path $PSScriptRoot 'Sync-VngPakChain.ps1') -ProjectRoot $ProjectRoot -RuntimeRoot $RuntimeRoot
& (Join-Path $PSScriptRoot 'Publish-StarterBagContent.ps1') -ProjectRoot $ProjectRoot -RuntimeRoot $RuntimeRoot
foreach($role in 'Client','Server') {
    & (Join-Path $PSScriptRoot 'Publish-NpcRestoration.ps1') -ProjectRoot $ProjectRoot -RoleRoot (Join-Path $RuntimeRoot $role)
}
$removed=[Collections.Generic.List[string]]::new()
foreach($name in 'S3Relay.exe','S3RelayServer.exe','PhongThanRelayServer.exe','Sword3PaySys.exe','S3DBInterface.dll'){
    $path=[IO.Path]::GetFullPath((Join-Path $RuntimeRoot "Server\$name"))
    if(-not $path.StartsWith($RuntimeRoot+'\Server\',[StringComparison]::OrdinalIgnoreCase)){throw 'Unsafe obsolete artifact path'}
    if(Test-Path -LiteralPath $path -PathType Leaf){Remove-Item -LiteralPath $path -Force;$removed.Add($name)}
}
$state=Join-Path (Split-Path -Parent $ProjectRoot) 'PhongThanRuntime-State\Server\CharacterStore'
New-Item -ItemType Directory -Path $state -Force | Out-Null
$link=Join-Path $RuntimeRoot 'Server\CharacterStore'
if(-not(Test-Path -LiteralPath $link)){New-Item -ItemType Junction -Path $link -Target $state | Out-Null}
else{if((Get-Item -LiteralPath $link).Target -ine $state){throw 'CharacterStore must point to native persistent state.'}}
$receipt=[pscustomobject]@{Schema=1;Scope='NATIVE_REBUILD_UAT';CreatedAtUtc=[DateTime]::UtcNow.ToString('o');Artifacts=@($artifacts | ForEach-Object { $_ });Configs=@($configs | ForEach-Object { $_ });PakChain=$pakChain;RemovedObsoleteArtifacts=@($removed | ForEach-Object { $_ });CharacterStore=$state;ContentPolicy='VNG PAK first by package.ini priority; loose files are whole-file fallback only';FullProjectAcceptance=$false}
[IO.File]::WriteAllText((Join-Path $RuntimeRoot 'NATIVE_DEPLOYMENT.json'),($receipt | ConvertTo-Json -Depth 6),[Text.UTF8Encoding]::new($false))
& (Join-Path $ProjectRoot 'Tests\Test-NativeRuntime.ps1') -ProjectRoot $ProjectRoot -RuntimeRoot $RuntimeRoot
"Removed obsolete runtime binaries: $($removed -join ', ')"
