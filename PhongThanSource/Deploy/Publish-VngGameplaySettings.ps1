[CmdletBinding()]
param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [Parameter(Mandatory = $true)]
    [string]$RuntimeRoot
)

$ErrorActionPreference = 'Stop'
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
$RuntimeRoot = [IO.Path]::GetFullPath($RuntimeRoot).TrimEnd('\')
$catalogPath = Join-Path $ProjectRoot 'Deploy\VNG_GAMEPLAY_SETTINGS.tsv'
$catalog = @(Import-Csv -LiteralPath $catalogPath -Delimiter "`t")
if ($catalog.Count -eq 0) { throw "VNG gameplay settings catalog rong: $catalogPath" }

$records = New-Object Collections.Generic.List[object]
foreach ($entry in $catalog) {
    $relative = [string]$entry.RelativePath
    $source = Join-Path $ProjectRoot ('gameserver\' + $relative)
    if (-not (Test-Path -LiteralPath $source -PathType Leaf)) {
        throw "Thieu source-controlled VNG setting: $source"
    }
    $sourceHash = (Get-FileHash -LiteralPath $source -Algorithm SHA256).Hash
    if ($sourceHash -ne [string]$entry.SourceSha256) {
        throw "VNG gameplay setting provenance mismatch: $source"
    }
    foreach ($role in 'Client', 'Server') {
        $target = Join-Path (Join-Path $RuntimeRoot $role) $relative
        $targetDirectory = Split-Path -Parent $target
        if (-not (Test-Path -LiteralPath $targetDirectory -PathType Container)) {
            throw "Thieu runtime setting directory: $targetDirectory"
        }
        Copy-Item -LiteralPath $source -Destination $target -Force
        $targetHash = (Get-FileHash -LiteralPath $target -Algorithm SHA256).Hash
        if ($targetHash -ne $sourceHash) { throw "Publish hash mismatch: $target" }
        $records.Add([pscustomobject]@{
            Role = $role
            RelativePath = $relative
            Sha256 = $targetHash
        })
    }
}

[pscustomobject]@{
    Status = 'PASS'
    RuntimeRoot = $RuntimeRoot
    Settings = $catalog.Count
    RoleCopies = $records.Count
    Records = @($records | ForEach-Object { $_ })
}
