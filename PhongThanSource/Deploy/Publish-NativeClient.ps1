[CmdletBinding()]
param(
    [string]$ProjectRoot=(Split-Path -Parent $PSScriptRoot),
    [string]$RuntimeRoot='D:\Lam game phong than\PhongThanRuntime-Staging'
)
$ErrorActionPreference='Stop'
$ProjectRoot=[IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
$RuntimeRoot=[IO.Path]::GetFullPath($RuntimeRoot).TrimEnd('\')
if($RuntimeRoot -ine (Join-Path (Split-Path -Parent $ProjectRoot) 'PhongThanRuntime-Staging')) {
    throw 'Publish target must be the named staging runtime.'
}
$clientRoot=Join-Path $RuntimeRoot 'Client'
$running=@(Get-CimInstance Win32_Process | Where-Object {
    $_.ExecutablePath -and $_.ExecutablePath.StartsWith($clientRoot+'\',[StringComparison]::OrdinalIgnoreCase)
})
if($running){throw "Client is running: $($running.Name -join ', ')"}
$receiptPath=Join-Path $RuntimeRoot 'NATIVE_DEPLOYMENT.json'
$receipt=Get-Content -LiteralPath $receiptPath -Raw | ConvertFrom-Json
if($receipt.Schema -ne 1 -or $receipt.Scope -ne 'NATIVE_REBUILD_UAT'){throw 'Invalid native deployment receipt'}
foreach($entry in @($receipt.Artifacts | Where-Object Role -eq 'Client')) {
    $source=Join-Path $ProjectRoot ('Output\Client\'+$entry.Name)
    $destination=Join-Path $clientRoot $entry.Name
    $hash=(Get-FileHash -LiteralPath $source).Hash
    if((Get-FileHash -LiteralPath $destination).Hash -ne $hash) {
        Copy-Item -LiteralPath $source -Destination $destination -Force
        if((Get-FileHash -LiteralPath $destination).Hash -ne $hash){throw "Binary mismatch: $destination"}
        Write-Output "Updated client: $($entry.Name)"
    }
    $entry.Sha256=$hash
}
$receipt.CreatedAtUtc=[DateTime]::UtcNow.ToString('o')
& (Join-Path $PSScriptRoot 'Publish-StarterBagContent.ps1') -ProjectRoot $ProjectRoot -RuntimeRoot $RuntimeRoot
[IO.File]::WriteAllText($receiptPath,($receipt | ConvertTo-Json -Depth 6),[Text.UTF8Encoding]::new($false))
& (Join-Path $ProjectRoot 'Tests\Test-NativeRuntime.ps1') -ProjectRoot $ProjectRoot -RuntimeRoot $RuntimeRoot
