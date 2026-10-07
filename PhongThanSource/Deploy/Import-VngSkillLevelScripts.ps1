[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$SourceClientRoot,
    [Parameter(Mandatory = $true)]
    [string]$SourceServerRoot,
    [Parameter(Mandatory = $true)]
    [string]$DestinationClientRoot,
    [Parameter(Mandatory = $true)]
    [string]$DestinationServerRoot,
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$BulkExtractTool,
    [string]$ReportPath
)

$ErrorActionPreference = 'Stop'
[Text.Encoding]::RegisterProvider([Text.CodePagesEncodingProvider]::Instance)
$cp936 = [Text.Encoding]::GetEncoding(936)
$latin1 = [Text.Encoding]::GetEncoding(28591)
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
$SourceClientRoot = [IO.Path]::GetFullPath($SourceClientRoot).TrimEnd('\')
$SourceServerRoot = [IO.Path]::GetFullPath($SourceServerRoot).TrimEnd('\')
$DestinationClientRoot = [IO.Path]::GetFullPath($DestinationClientRoot).TrimEnd('\')
$DestinationServerRoot = [IO.Path]::GetFullPath($DestinationServerRoot).TrimEnd('\')
if (-not $BulkExtractTool) { $BulkExtractTool = Join-Path $ProjectRoot 'Output\Tools\PakEntryBulkExtract.exe' }
if (-not $ReportPath) { $ReportPath = Join-Path $ProjectRoot 'Output\VngSkillLuaImport.report.json' }
$BulkExtractTool = [IO.Path]::GetFullPath($BulkExtractTool)
$ReportPath = [IO.Path]::GetFullPath($ReportPath)

foreach ($required in @(
    $SourceClientRoot,
    $SourceServerRoot,
    (Join-Path $SourceClientRoot 'settings\Skills.txt'),
    (Join-Path $SourceClientRoot 'package.ini')
)) {
    if (-not (Test-Path -LiteralPath $required)) { throw "Thieu dependency skill import: $required" }
}
if (-not (Test-Path -LiteralPath $BulkExtractTool -PathType Leaf)) {
    & (Join-Path $ProjectRoot 'Build\Build-PakEntryBulkExtract.ps1') -ProjectRoot $ProjectRoot | Out-Null
}

function ConvertTo-DiskRelativePath([string]$Path) {
    $normalized = $Path.Trim().Trim([char]'"').Replace('/', '\').TrimStart('\')
    $segments = foreach ($segment in $normalized.Split([char]'\')) {
        if ($segment -match '[^\x00-\x7f]') { $script:latin1.GetString($script:cp936.GetBytes($segment)) }
        else { $segment }
    }
    return $segments -join '\'
}

function Get-TableReferences([string]$Path, [string[]]$ColumnNames) {
    $lines = [IO.File]::ReadAllLines($Path, $script:cp936)
    if ($lines.Count -lt 2) { throw "Bang skill rong: $Path" }
    $header = $lines[0].Split([char]9)
    $indexes = foreach ($columnName in $ColumnNames) {
        $index = [Array]::IndexOf($header, $columnName)
        if ($index -lt 0) { throw "Skills.txt thieu cot runtime: $columnName" }
        $index
    }
    $references = [Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
    for ($row = 1; $row -lt $lines.Count; $row++) {
        $columns = $lines[$row].Split([char]9)
        foreach ($index in $indexes) {
            if ($index -ge $columns.Count) { continue }
            $value = $columns[$index].Trim().Replace('/', '\')
            if (-not $value -or $value -notmatch '(?i)\.lua$') { continue }
            if (-not $value.StartsWith('\')) { $value = '\' + $value }
            [void]$references.Add($value.ToLowerInvariant())
        }
    }
    return @($references | Sort-Object)
}

function Copy-ExactFile([string]$Source, [string]$Relative, [string[]]$DestinationRoots) {
    $sourceHash = (Get-FileHash -LiteralPath $Source -Algorithm SHA256).Hash
    foreach ($root in $DestinationRoots) {
        $target = Join-Path $root $Relative
        New-Item -ItemType Directory -Path (Split-Path -Parent $target) -Force | Out-Null
        Copy-Item -LiteralPath $Source -Destination $target -Force
        if ((Get-FileHash -LiteralPath $target -Algorithm SHA256).Hash -ne $sourceHash) {
            throw "Skill Lua copy khac hash: $target"
        }
    }
    return $sourceHash
}

$references = @(Get-TableReferences (Join-Path $SourceClientRoot 'settings\Skills.txt') @('LvlSetScript'))
$results = New-Object System.Collections.Generic.List[object]
$destinationRoots = @($DestinationClientRoot, $DestinationServerRoot)
New-Item -ItemType Directory -Path $destinationRoots -Force | Out-Null
$workingRoot = Join-Path $ProjectRoot 'Output\VngSkillLuaImport'
$cacheRoot = Join-Path $workingRoot 'PakOriginals'
$catalogPath = Join-Path $workingRoot 'references.txt'
$resolvedCatalog = Join-Path $workingRoot 'pak-resolved.txt'
$missingCatalog = Join-Path $workingRoot 'pak-missing.txt'
New-Item -ItemType Directory -Path $cacheRoot -Force | Out-Null
[IO.File]::WriteAllLines($catalogPath, $references, $cp936)

Push-Location $SourceClientRoot
try {
    & $BulkExtractTool (Join-Path $SourceClientRoot 'package.ini') $catalogPath `
        $cacheRoot $resolvedCatalog $missingCatalog 2>$null | Out-Null
    if ($LASTEXITCODE -notin @(0, 1)) { throw "PakEntryBulkExtract loi $LASTEXITCODE." }
}
finally {
    Pop-Location
}
$pakResolved = [Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
foreach ($path in [IO.File]::ReadAllLines($resolvedCatalog, $cp936)) {
    if ($path) { [void]$pakResolved.Add($path) }
}

foreach ($virtualPath in $references) {
    $diskRelative = ConvertTo-DiskRelativePath $virtualPath
    $provenance = ''
    $source = ''
    if ($pakResolved.Contains($virtualPath)) {
        $source = Join-Path $cacheRoot $diskRelative
        $provenance = 'VNG_CLIENT_PAK'
        if (-not (Test-Path -LiteralPath $source -PathType Leaf)) {
            throw "Bulk extract catalog co entry nhung thieu file: $virtualPath"
        }
    }
    else {
        $clientLoose = Join-Path $SourceClientRoot $diskRelative
        $serverLoose = Join-Path $SourceServerRoot $diskRelative
        $loose = @(@($clientLoose, $serverLoose) |
            Where-Object { Test-Path -LiteralPath $_ -PathType Leaf })
        if ($loose.Count -gt 1 -and
            (Get-FileHash -LiteralPath $loose[0] -Algorithm SHA256).Hash -ne
            (Get-FileHash -LiteralPath $loose[1] -Algorithm SHA256).Hash) {
            throw "Client/server skill Lua loose khac hash: $virtualPath"
        }
        if ($loose.Count) {
            $source = $loose[0]
            $provenance = if ($source -ieq $clientLoose) { 'SOURCE_CLIENT_LOOSE' } else { 'SOURCE_SERVER_LOOSE' }
        }
    }

    if ($source) {
        $hash = Copy-ExactFile $source $diskRelative $destinationRoots
        $results.Add([pscustomobject]@{
            VirtualPath = $virtualPath
            DiskRelativePath = $diskRelative
            Status = 'RESOLVED'
            Provenance = $provenance
            Sha256 = $hash
        })
    }
    else {
        $results.Add([pscustomobject]@{
            VirtualPath = $virtualPath
            DiskRelativePath = $diskRelative
            Status = 'MISSING_SOURCE'
            Provenance = 'NONE'
            Sha256 = ''
        })
    }
}

$resolved = @($results | Where-Object Status -eq 'RESOLVED')
$missing = @($results | Where-Object Status -eq 'MISSING_SOURCE')
$report = [ordered]@{
    Schema = 1
    Policy = 'ORIGINAL_PAK_FIRST_THEN_EXISTING_PROVENANCED_LOOSE_NO_SYNTHETIC_LUA'
    SourceClientRoot = $SourceClientRoot
    SourceServerRoot = $SourceServerRoot
    References = $references.Count
    Resolved = $resolved.Count
    MissingBacklog = $missing.Count
    PakOriginals = @($resolved | Where-Object Provenance -eq 'VNG_CLIENT_PAK').Count
    ExistingClientLoose = @($resolved | Where-Object Provenance -eq 'SOURCE_CLIENT_LOOSE').Count
    ExistingServerLoose = @($resolved | Where-Object Provenance -eq 'SOURCE_SERVER_LOOSE').Count
    Entries = @($results | ForEach-Object { $_ })
}
New-Item -ItemType Directory -Path (Split-Path -Parent $ReportPath) -Force | Out-Null
[IO.File]::WriteAllText($ReportPath, ($report | ConvertTo-Json -Depth 6), (New-Object Text.UTF8Encoding($false)))

[pscustomobject]@{
    Result = 'PASS'
    References = $references.Count
    Resolved = $resolved.Count
    MissingBacklog = $missing.Count
    PakOriginals = $report.PakOriginals
    ExistingLoose = $report.ExistingClientLoose + $report.ExistingServerLoose
    Report = $ReportPath
}
