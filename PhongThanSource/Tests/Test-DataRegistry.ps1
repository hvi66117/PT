[CmdletBinding()]
param(
    [string]$DataRoot,
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$ManifestPath = (Join-Path (Split-Path -Parent $PSScriptRoot) 'Deploy\RUNTIME_CONTENT_MANIFEST.json')
)

$ErrorActionPreference = 'Stop'
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
if (-not $DataRoot) {
    $DataRoot = Join-Path (Split-Path -Parent $ProjectRoot) 'PhongThanRuntime-Content'
}
$DataRoot = [IO.Path]::GetFullPath($DataRoot).TrimEnd('\')
$ManifestPath = [IO.Path]::GetFullPath($ManifestPath)

if (-not (Test-Path -LiteralPath $ManifestPath -PathType Leaf)) {
    throw "Thieu runtime manifest: $ManifestPath"
}
$manifest = Get-Content -LiteralPath $ManifestPath -Raw | ConvertFrom-Json
$registry = $manifest.DataRegistries.Item
if (-not $registry) { throw 'Manifest thieu DataRegistries.Item.' }

function Get-IniInteger([string]$Path, [string]$Section, [string]$Key) {
    $text = [IO.File]::ReadAllText($Path)
    $sectionMatch = [regex]::Match(
        $text,
        '(?ms)^\s*\[' + [regex]::Escape($Section) + '\]\s*(?<body>.*?)(?=^\s*\[|\z)')
    if (-not $sectionMatch.Success) { throw "Thieu section [$Section]: $Path" }
    $keyMatch = [regex]::Match(
        $sectionMatch.Groups['body'].Value,
        '(?im)^\s*' + [regex]::Escape($Key) + '\s*=\s*(?<value>\d+)\s*$')
    if (-not $keyMatch.Success) { throw "Thieu khoa $Key trong [$Section]: $Path" }
    return [int]$keyMatch.Groups['value'].Value
}

function Get-HeaderColumnCount([string]$Path) {
    $bytes = [IO.File]::ReadAllBytes($Path)
    if ($bytes.Length -eq 0) { return 0 }
    $lineEnd = [Array]::IndexOf($bytes, [byte]10)
    if ($lineEnd -lt 0) { return 0 }
    $columns = 1
    for ($i = 0; $i -lt $lineEnd; $i++) {
        if ($bytes[$i] -eq 9) { $columns++ }
    }
    return $columns
}

$roles = @('Client', 'Server')
$versionFiles = @{}
$activeDirectories = @{}
foreach ($role in $roles) {
    $roleRoot = Join-Path $DataRoot $role
    if (-not (Test-Path -LiteralPath $roleRoot -PathType Container)) {
        throw "Data registry thieu role: $roleRoot"
    }
    $versionFile = Join-Path $roleRoot ([string]$registry.VersionFile)
    if (-not (Test-Path -LiteralPath $versionFile -PathType Leaf)) {
        throw "Thieu itemversion.ini: $versionFile"
    }
    $version = Get-IniInteger $versionFile $registry.VersionSection $registry.VersionKey
    if ($version -ne [int]$registry.ExpectedVersion) {
        throw "Item version $role=$version, yeu cau=$($registry.ExpectedVersion)."
    }
    $activeDirectory = Join-Path $roleRoot ([string]$registry.ActiveDirectory)
    if (-not (Test-Path -LiteralPath $activeDirectory -PathType Container)) {
        throw "Thieu active item directory: $activeDirectory"
    }
    $itemRoot = Split-Path -Parent $activeDirectory
    $expectedDirectoryName = '{0:D3}' -f [int]$registry.ExpectedVersion
    foreach ($directory in Get-ChildItem -LiteralPath $itemRoot -Directory -Force) {
        if ($directory.Name -match '^\d{3}$' -and $directory.Name -ne $expectedDirectoryName) {
            throw "Phat hien item version khong hoat dong: $($directory.FullName)"
        }
    }
    foreach ($legacyName in $registry.LegacyFlatTables) {
        $legacyPath = Join-Path $itemRoot ([string]$legacyName)
        if (Test-Path -LiteralPath $legacyPath -PathType Leaf) {
            throw "Phat hien bang item flat Vo Lam: $legacyPath"
        }
    }
    foreach ($table in $registry.RequiredTables) {
        $tablePath = Join-Path $activeDirectory ([string]$table.Name)
        if (-not (Test-Path -LiteralPath $tablePath -PathType Leaf)) {
            throw "Thieu bang item bat buoc: $tablePath"
        }
        $columns = Get-HeaderColumnCount $tablePath
        if ($columns -lt [int]$table.MinimumColumns) {
            throw "Schema $role\$($table.Name) chi co $columns cot, yeu cau toi thieu $($table.MinimumColumns)."
        }
    }
    $versionFiles[$role] = $versionFile
    $activeDirectories[$role] = $activeDirectory
}

if ((Get-FileHash -LiteralPath $versionFiles.Client -Algorithm SHA256).Hash -ne
    (Get-FileHash -LiteralPath $versionFiles.Server -Algorithm SHA256).Hash) {
    throw 'itemversion.ini client/server khong dong bo byte-for-byte.'
}

$clientFiles = @(Get-ChildItem -LiteralPath $activeDirectories.Client -File -Force | Sort-Object Name)
$serverFiles = @(Get-ChildItem -LiteralPath $activeDirectories.Server -File -Force | Sort-Object Name)
$nameDifference = @(Compare-Object $clientFiles.Name $serverFiles.Name)
if ($nameDifference.Count) {
    throw "Danh sach item table client/server khac nhau: $($nameDifference.InputObject -join ', ')"
}
foreach ($clientFile in $clientFiles) {
    $serverFile = Join-Path $activeDirectories.Server $clientFile.Name
    if ((Get-FileHash -LiteralPath $clientFile.FullName -Algorithm SHA256).Hash -ne
        (Get-FileHash -LiteralPath $serverFile -Algorithm SHA256).Hash) {
        throw "Item table client/server khac hash: $($clientFile.Name)"
    }
}

[pscustomobject]@{
    Result = 'PASS'
    DataRoot = $DataRoot
    Registry = 'Item'
    Version = [int]$registry.ExpectedVersion
    ActiveDirectory = [string]$registry.ActiveDirectory
    RequiredTables = @($registry.RequiredTables).Count
    SynchronizedTables = $clientFiles.Count
    LegacyFlatTables = 0
    InactiveVersions = 0
}
