[CmdletBinding()]
param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = 'Stop'
$sourcesRoot = [IO.Path]::GetFullPath((Join-Path $ProjectRoot 'Sources')).TrimEnd('\')
$extensions = '.scc', '.vspscc', '.stt', '.rar', '.exe', '.dll'
$targets = Get-ChildItem -LiteralPath $sourcesRoot -Recurse -File |
    Where-Object { $_.Extension -in $extensions }

foreach ($item in $targets) {
    $resolved = [IO.Path]::GetFullPath($item.FullName)
    if (-not $resolved.StartsWith($sourcesRoot + '\', [StringComparison]::OrdinalIgnoreCase)) {
        throw "Tu choi xoa ngoai Sources: $resolved"
    }
    Remove-Item -LiteralPath $resolved -Force
}

[pscustomobject]@{
    SourcesRoot = $sourcesRoot
    RemovedCount = @($targets).Count
}
