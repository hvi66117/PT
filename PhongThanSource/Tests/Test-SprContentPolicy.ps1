[CmdletBinding()]
param(
    [string]$DataRoot,
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$ManifestPath = (Join-Path (Split-Path -Parent $PSScriptRoot) 'Deploy\RUNTIME_CONTENT_MANIFEST.json')
)

$ErrorActionPreference = 'Stop'
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
if (-not $DataRoot) { $DataRoot = Join-Path (Split-Path -Parent $ProjectRoot) 'PhongThanRuntime-Content' }
$DataRoot = [IO.Path]::GetFullPath($DataRoot).TrimEnd('\')
$manifest = Get-Content -LiteralPath $ManifestPath -Raw | ConvertFrom-Json
$registry = $manifest.DataRegistries.Gameplay.Sprite
if (-not $registry) { throw 'Manifest thieu DataRegistries.Gameplay.Sprite.' }

$clientRoot = if (Test-Path -LiteralPath (Join-Path $DataRoot 'Client')) {
    Join-Path $DataRoot 'Client'
} else { $DataRoot }
$shadowRoot = [IO.Path]::GetFullPath((Join-Path $clientRoot ([string]$registry.PakShadowRoot))).TrimEnd('\')
if (-not $shadowRoot.StartsWith($clientRoot + '\', [StringComparison]::OrdinalIgnoreCase)) {
    throw "SPR shadow root nam ngoai client root: $shadowRoot"
}
$actual = @(Get-ChildItem -LiteralPath $shadowRoot -Recurse -File -Filter *.spr)
$expected = @($registry.LooseFallbacks | ForEach-Object {
    [IO.Path]::GetFullPath((Join-Path $clientRoot ([string]$_)))
})
if ($actual.Count -ne $expected.Count) {
    throw "SPR loose human con $($actual.Count), yeu cau $($expected.Count)."
}
foreach ($path in $expected) {
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) { throw "Thieu SPR fallback: $path" }
}
foreach ($file in $actual) {
    if ($expected -notcontains [IO.Path]::GetFullPath($file.FullName)) {
        throw "SPR loose khong nam trong fallback: $($file.FullName)"
    }
}

[pscustomobject]@{
    Result = 'PASS'
    ShadowRoot = $shadowRoot
    LooseFallbacks = $actual.Count
    PakValidated = [int]$registry.ExpectedValidPakFiles
}
