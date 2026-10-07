[CmdletBinding()]
param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$RuntimeRoot
)

$ErrorActionPreference = 'Stop'
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
if (-not $RuntimeRoot) {
    $RuntimeRoot = Join-Path (Split-Path -Parent $ProjectRoot) 'PhongThanRuntime-Staging'
}
$RuntimeRoot = [IO.Path]::GetFullPath($RuntimeRoot).TrimEnd('\')
$catalog = @(Import-Csv -LiteralPath (Join-Path $ProjectRoot 'Deploy\VNG_GAMEPLAY_SETTINGS.tsv') -Delimiter "`t")
$verified = 0
foreach ($entry in $catalog) {
    $source = Join-Path $ProjectRoot ('gameserver\' + [string]$entry.RelativePath)
    $expectedHash = [string]$entry.SourceSha256
    if ((Get-FileHash -LiteralPath $source -Algorithm SHA256).Hash -ne $expectedHash) {
        throw "Source VNG setting hash mismatch: $source"
    }
    foreach ($role in 'Client', 'Server') {
        $target = Join-Path (Join-Path $RuntimeRoot $role) ([string]$entry.RelativePath)
        if (-not (Test-Path -LiteralPath $target -PathType Leaf)) {
            throw "Runtime thieu VNG setting: $target"
        }
        if ((Get-FileHash -LiteralPath $target -Algorithm SHA256).Hash -ne $expectedHash) {
            throw "Runtime VNG setting hash mismatch: $target"
        }
        $verified++
    }
}

[pscustomobject]@{
    Status = 'PASS'
    RuntimeRoot = $RuntimeRoot
    CatalogSettings = $catalog.Count
    VerifiedRoleCopies = $verified
}
