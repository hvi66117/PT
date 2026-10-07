[CmdletBinding()]
param([string]$ProjectRoot=(Split-Path -Parent $PSScriptRoot))
$ErrorActionPreference='Stop'
$ProjectRoot=[IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
$runtime=Join-Path (Split-Path -Parent $ProjectRoot) 'PhongThanRuntime-Staging'
$consumers=@(Get-CimInstance Win32_Process | Where-Object {
    $_.Name -in 'Game.exe','GameServer.exe' -and $_.ExecutablePath -and
    $_.ExecutablePath.StartsWith($runtime+'\',[StringComparison]::OrdinalIgnoreCase)
})
if($consumers){throw 'Close/save Game and GameServer before publishing NPC Lua runtime.'}
$receiptPath=Join-Path $runtime 'NATIVE_DEPLOYMENT.json'
$receipt=Get-Content -LiteralPath $receiptPath -Raw | ConvertFrom-Json
if($receipt.Schema -ne 1 -or $receipt.Scope -ne 'NATIVE_REBUILD_UAT'){throw 'Unexpected native receipt'}
$targets=@(@{Role='Server';Name='CoreServer.dll'},@{Role='Client';Name='CoreClient.dll'},@{Role='Client';Name='Game.exe'})
$checked=@()
foreach($target in $targets){
    $entry=@($receipt.Artifacts | Where-Object {$_.Role -eq $target.Role -and $_.Name -eq $target.Name})
    if($entry.Count -ne 1){throw 'Non-unique deployment identity'}
    $source=Join-Path $ProjectRoot "Output\$($target.Role)\$($target.Name)"
    $destination=Join-Path $runtime "$($target.Role)\$($target.Name)"
    if(-not (Test-Path -LiteralPath $destination -PathType Leaf)){throw "Missing installed artifact: $destination"}
    $checked+=@{Source=$source;Destination=$destination;Entry=$entry[0];Hash=(Get-FileHash -LiteralPath $source).Hash}
}
foreach($target in $checked){
    Copy-Item -LiteralPath $target.Source -Destination $target.Destination -Force
    if((Get-FileHash -LiteralPath $target.Destination).Hash -ne $target.Hash){throw 'Published hash mismatch'}
    $target.Entry.Sha256=$target.Hash
    [pscustomobject]@{Artifact=$target.Destination;Sha256=$target.Hash}
}
$receipt.CreatedAtUtc=[DateTime]::UtcNow.ToString('o')
[IO.File]::WriteAllText($receiptPath,($receipt | ConvertTo-Json -Depth 12),[Text.UTF8Encoding]::new($false))
'Published only Lua/compose CoreServer, CoreClient and Game.exe. No service restarts, map/PAK/character/candidate writes.'
