[CmdletBinding()]
param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$DataRoot,
    [string]$ManifestPath,
    [string]$ProvenancePath
)

$ErrorActionPreference = 'Stop'
[Text.Encoding]::RegisterProvider([Text.CodePagesEncodingProvider]::Instance)
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
if (-not $DataRoot) { $DataRoot = Join-Path (Split-Path -Parent $ProjectRoot) 'PhongThanRuntime-Staging' }
if (-not $ManifestPath) { $ManifestPath = Join-Path $ProjectRoot 'Deploy\RUNTIME_CONTENT_MANIFEST.json' }
if (-not $ProvenancePath) { $ProvenancePath = Join-Path $ProjectRoot 'Docs\VNG_WEAPON_TABLE_PROVENANCE.json' }
$DataRoot = [IO.Path]::GetFullPath($DataRoot).TrimEnd('\')
$manifest = Get-Content -LiteralPath $ManifestPath -Raw | ConvertFrom-Json
$provenance = Get-Content -LiteralPath $ProvenancePath -Raw | ConvertFrom-Json
$required = @($manifest.DataRegistries.Item.RequiredTables)
$checked = 0

foreach ($entry in $provenance.Files) {
    $rule = @($required | Where-Object { ([string]$_.Name).ToLowerInvariant() -eq ([string]$entry.Name).ToLowerInvariant() })
    if ($rule.Count -ne 1 -or [int]$rule[0].MinimumColumns -ne [int]$entry.HeaderColumns) {
        throw "Manifest chua khoa dung schema $($entry.Name)."
    }
    $roleHashes = @()
    foreach ($role in 'Client', 'Server') {
        $versioned = Join-Path $DataRoot "$role\settings\item\001\$($entry.Name)"
        $flat = Join-Path $DataRoot "$role\settings\item\$($entry.Name)"
        if (-not (Test-Path -LiteralPath $versioned -PathType Leaf)) { throw "Thieu: $versioned" }
        if (Test-Path -LiteralPath $flat) { throw "Con bang weapon flat: $flat" }
        $hash = (Get-FileHash -LiteralPath $versioned -Algorithm SHA256).Hash
        if ($hash -ne [string]$entry.EntrySha256) { throw "Sai hash VNG: $versioned" }
        $lines = [IO.File]::ReadAllLines($versioned, [Text.Encoding]::GetEncoding(936))
        if ($lines.Count - 1 -ne [int]$entry.Rows -or
            $lines[0].Split("`t").Count -ne [int]$entry.HeaderColumns) {
            throw "Sai rows/schema: $versioned"
        }
        $roleHashes += $hash
        ++$checked
    }
    if ($roleHashes[0] -ne $roleHashes[1]) { throw "Client/server weapon khong dong bo: $($entry.Name)" }
}

$source = Get-Content -LiteralPath (Join-Path $ProjectRoot 'Sources\Core\Src\KBasPropTbl.cpp') -Raw
if ($source -notmatch 'i\s*>=\s*0\s*&&\s*i\s*<=\s*10') { throw 'Core chua bat buoc nap hai bang weapon.' }
if ($source -notmatch 'bVngMeleeShortRow[\s\S]{0,1000}nColumnShift\s*=\s*-1') {
    throw 'Core chua xu ly 117 short-row cua MeleeWeapon VNG.'
}

[pscustomobject]@{
    Result = 'PASS'
    DataRoot = $DataRoot
    VngWeaponTables = $provenance.Files.Count
    RoleFilesChecked = $checked
    ByteExact = $true
}
