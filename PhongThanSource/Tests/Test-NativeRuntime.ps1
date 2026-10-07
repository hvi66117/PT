[CmdletBinding()]
param([string]$ProjectRoot=(Split-Path -Parent $PSScriptRoot),[string]$RuntimeRoot='D:\Lam game phong than\PhongThanRuntime-Staging')
$ErrorActionPreference='Stop'
$receipt=Get-Content -LiteralPath (Join-Path $RuntimeRoot 'NATIVE_DEPLOYMENT.json') -Raw | ConvertFrom-Json
if($receipt.Schema -ne 1 -or $receipt.Scope -ne 'NATIVE_REBUILD_UAT'){throw 'Invalid native deployment receipt'}
foreach($entry in $receipt.Artifacts){
    $runtime=Join-Path $RuntimeRoot "$($entry.Role)\$($entry.Name)"
    $source=Join-Path $ProjectRoot "Output\$($entry.Role)\$($entry.Name)"
    if((Get-FileHash -LiteralPath $runtime).Hash -ne $entry.Sha256 -or (Get-FileHash -LiteralPath $source).Hash -ne $entry.Sha256){throw "Stale binary: $runtime"}
}
foreach($entry in $receipt.Configs){
    if((Get-FileHash -LiteralPath (Join-Path $RuntimeRoot "Server\$($entry.Name)")).Hash -ne $entry.Sha256){throw "Stale native config: $($entry.Name)"}
}
foreach($name in 'S3Relay.exe','S3RelayServer.exe','PhongThanRelayServer.exe','Sword3PaySys.exe','S3DBInterface.dll'){
    if(Test-Path -LiteralPath (Join-Path $RuntimeRoot "Server\$name")){throw "Obsolete binary: $name"}
}
if(-not $receipt.PakChain -or $receipt.PakChain.Mode -ne 'PAK_FIRST_LOOSE_FALLBACK'){throw 'Missing server PAK-first deployment receipt'}
& (Join-Path $ProjectRoot 'Tests\Test-ServerPakParity.ps1') -ProjectRoot $ProjectRoot -RuntimeRoot $RuntimeRoot | Out-Null
$serverCfg=Get-Content -LiteralPath (Join-Path $RuntimeRoot 'Server\ServerCfg.ini') -Raw
if($serverCfg -match '(?im)^\[(Transfer|Chat|Tong)\]' -or $serverCfg -notmatch '(?im)^\[Relay\]'){throw 'GameServer relay config is not native.'}
$maps=Get-Content -LiteralPath (Join-Path $RuntimeRoot 'Server\maps\WorldSet.ini') -Raw
$expected=(Get-Content (Join-Path $ProjectRoot 'Deploy\RUNTIME_CONTENT_MANIFEST.json') -Raw | ConvertFrom-Json).DataRegistries.Gameplay.Map.ExpectedActiveMapCount
if($maps -notmatch "(?im)^Count=$expected\s*$"){throw 'Active map count changed.'}
[pscustomobject]@{Result='PASS';Scope='NATIVE_REBUILD_UAT_ARTIFACTS';Artifacts=$receipt.Artifacts.Count;ActiveMaps=$expected;FullProjectAcceptance=$false}
