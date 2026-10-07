[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$VngClientRoot,
    [string]$DataRoot,
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$ProvenancePath = (Join-Path (Split-Path -Parent $PSScriptRoot) 'Docs\VNG_WEAPON_TABLE_PROVENANCE.json')
)

$ErrorActionPreference = 'Stop'
[Text.Encoding]::RegisterProvider([Text.CodePagesEncodingProvider]::Instance)
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
$VngClientRoot = [IO.Path]::GetFullPath($VngClientRoot).TrimEnd('\')
if (-not $DataRoot) { $DataRoot = Join-Path (Split-Path -Parent $ProjectRoot) 'PhongThanRuntime-Staging' }
$DataRoot = [IO.Path]::GetFullPath($DataRoot).TrimEnd('\')
$packageIni = Join-Path $VngClientRoot 'package.ini'
$provenance = Get-Content -LiteralPath $ProvenancePath -Raw | ConvertFrom-Json
foreach ($required in $VngClientRoot, $DataRoot, $packageIni, $ProvenancePath) {
    if (-not (Test-Path -LiteralPath $required)) { throw "Thieu VNG weapon import dependency: $required" }
}
foreach ($role in 'Client', 'Server') {
    if (-not (Test-Path -LiteralPath (Join-Path $DataRoot $role) -PathType Container)) {
        throw "DataRoot thieu role ${role}: $DataRoot"
    }
}

$runner = Join-Path $ProjectRoot 'Output\Tools\PakEntryExtract.exe'
& (Join-Path $ProjectRoot 'Build\Build-PakEntryExtract.ps1') `
    -ProjectRoot $ProjectRoot -OutputPath $runner | Out-Null
Copy-Item -LiteralPath (Join-Path $ProjectRoot 'Output\Client\Engine.dll') `
    -Destination (Split-Path -Parent $runner) -Force
$extractRoot = Join-Path $ProjectRoot 'Output\VngWeaponImport'
New-Item -ItemType Directory -Path $extractRoot -Force | Out-Null

$results = New-Object System.Collections.Generic.List[object]
foreach ($entry in $provenance.Files) {
    $packagePath = Join-Path $VngClientRoot ("data\{0}" -f [string]$entry.PackageName)
    if (-not (Test-Path -LiteralPath $packagePath -PathType Leaf)) {
        throw "Thieu PAK VNG goc: $packagePath"
    }
    $packageHash = (Get-FileHash -LiteralPath $packagePath -Algorithm SHA256).Hash
    if ($packageHash -ne [string]$entry.PackageSha256) {
        throw "PAK VNG sai hash: $($entry.PackageName)"
    }

    $virtualPath = "\settings\item\001\$($entry.Name)"
    $outputPath = Join-Path $extractRoot ([string]$entry.Name)
    Push-Location $VngClientRoot
    try {
        $extractOutput = @(& $runner $packageIni $virtualPath $outputPath 2>&1)
        $extractExit = $LASTEXITCODE
    }
    finally { Pop-Location }
    if ($extractExit -ne 0) {
        throw "Khong trich xuat duoc $virtualPath (exit=$extractExit): $($extractOutput -join ' ')"
    }
    $pakIndexLine = @($extractOutput | Where-Object { [string]$_ -match '^PAK_INDEX=(\d+)$' })
    if ($pakIndexLine.Count -ne 1 -or [int]($pakIndexLine[0] -replace '^PAK_INDEX=', '') -ne [int]$entry.PackageIndex) {
        throw "Thu tu package.ini khong con tro $($entry.Name) toi PAK index $($entry.PackageIndex)."
    }
    $item = Get-Item -LiteralPath $outputPath
    if ($item.Length -ne [int64]$entry.Bytes -or
        (Get-FileHash -LiteralPath $outputPath -Algorithm SHA256).Hash -ne [string]$entry.EntrySha256) {
        throw "Payload VNG sai byte/hash: $($entry.Name)"
    }
    $lines = [IO.File]::ReadAllLines($outputPath, [Text.Encoding]::GetEncoding(936))
    if ($lines.Count - 1 -ne [int]$entry.Rows -or
        ($lines[0].Split("`t")).Count -ne [int]$entry.HeaderColumns) {
        throw "Schema VNG sai: $($entry.Name)"
    }

    foreach ($role in 'Client', 'Server') {
        $targetRoot = Join-Path $DataRoot "$role\settings\item\001"
        if (-not (Test-Path -LiteralPath $targetRoot -PathType Container)) {
            throw "Thieu item registry: $targetRoot"
        }
        $target = Join-Path $targetRoot ([string]$entry.Name)
        Copy-Item -LiteralPath $outputPath -Destination $target -Force
        if ((Get-FileHash -LiteralPath $target -Algorithm SHA256).Hash -ne [string]$entry.EntrySha256) {
            throw "Copy VNG weapon mismatch: $target"
        }
    }
    $results.Add([pscustomobject]@{
        Name = [string]$entry.Name
        Package = [string]$entry.PackageName
        PackageIndex = [int]$entry.PackageIndex
        Rows = [int]$entry.Rows
        Columns = [int]$entry.HeaderColumns
        Sha256 = [string]$entry.EntrySha256
    })
}

[pscustomobject]@{
    Result = 'PASS'
    Source = $VngClientRoot
    DataRoot = $DataRoot
    Files = @($results | ForEach-Object { $_ })
}
