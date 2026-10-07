[CmdletBinding()]
param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$DataRoot,
    [string]$AuditTool,
    [string]$OutputDirectory
)

$ErrorActionPreference = 'Stop'
[Text.Encoding]::RegisterProvider([Text.CodePagesEncodingProvider]::Instance)
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
if (-not $DataRoot) { $DataRoot = Join-Path (Split-Path -Parent $ProjectRoot) 'PhongThanRuntime-Staging' }
if (-not $AuditTool) { $AuditTool = Join-Path $ProjectRoot 'Output\Tools\PakEntryAudit.exe' }
if (-not $OutputDirectory) { $OutputDirectory = Join-Path $ProjectRoot 'Output\ItemIconPolicy' }
$DataRoot = [IO.Path]::GetFullPath($DataRoot).TrimEnd('\')
$OutputDirectory = [IO.Path]::GetFullPath($OutputDirectory)

$manifestPath = Join-Path $ProjectRoot 'Deploy\RUNTIME_CONTENT_MANIFEST.json'
$manifest = Get-Content -LiteralPath $manifestPath -Raw | ConvertFrom-Json
$tableRules = @($manifest.DataRegistries.Item.RequiredTables)
$clientRoot = Join-Path $DataRoot 'Client'
$itemRoot = Join-Path $clientRoot 'settings\item\001'
$packageIni = Join-Path $clientRoot 'package.ini'

foreach ($required in $manifestPath, $itemRoot, $packageIni) {
    if (-not (Test-Path -LiteralPath $required)) { throw "Thieu dependency: $required" }
}
if (-not (Test-Path -LiteralPath $AuditTool -PathType Leaf)) {
    & (Join-Path $ProjectRoot 'Build\Build-PakEntryAudit.ps1') -ProjectRoot $ProjectRoot | Out-Null
}

$encoding = [Text.Encoding]::GetEncoding(936)
$pathTables = @{}
$tableRows = @{}
foreach ($rule in $tableRules) {
    $name = ([string]$rule.Name).ToLowerInvariant()
    $path = Join-Path $itemRoot $name
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) { throw "Thieu bang item: $path" }
    $lines = [IO.File]::ReadAllLines($path, $encoding)
    if ($lines.Count -lt 2) { throw "Bang item rong: $path" }

    $rows = New-Object System.Collections.ArrayList
    for ($row = 1; $row -lt $lines.Count; ++$row) {
        if (-not $lines[$row]) { continue }
        $columns = $lines[$row].Split("`t")
        # Mot so bang VNG luoc cot DetailedType o tung dong, vi vay vi tri
        # icon co the dich trai mot cot. Chon gia tri SPR dau tien trong nhom
        # metadata dau dong thay vi sua payload nguon.
        $icon = @($columns[0..([Math]::Min(7, $columns.Count - 1))] |
            Where-Object { $_ -match '(?i)\.spr$' } | Select-Object -First 1)
        if ($icon.Count -ne 1) { continue }
        $icon = ([string]$icon[0]).Trim().Replace('/', '\')
        if (-not $icon.StartsWith('\')) { $icon = "\$icon" }
        $icon = $icon.ToLowerInvariant()
        [void]$rows.Add($icon)
        if (-not $pathTables.ContainsKey($icon)) {
            $pathTables[$icon] = New-Object System.Collections.ArrayList
        }
        if (-not $pathTables[$icon].Contains($name)) { [void]$pathTables[$icon].Add($name) }
    }
    $tableRows[$name] = @($rows)
}

$allPaths = @($pathTables.Keys | Sort-Object)
New-Item -ItemType Directory -Path $OutputDirectory -Force | Out-Null
$catalogPath = Join-Path $OutputDirectory 'VngItemIcon.paths.txt'
$failurePath = Join-Path $OutputDirectory 'VngItemIcon.missing.txt'
$stderrPath = Join-Path $OutputDirectory 'VngItemIcon.audit.log'
$reportPath = Join-Path $OutputDirectory 'VngItemIcon.report.json'
[IO.File]::WriteAllLines($catalogPath, $allPaths, $encoding)

Push-Location $clientRoot
try {
    $auditOutput = @(& $AuditTool $packageIni $catalogPath $failurePath 2> $stderrPath)
    $auditExit = $LASTEXITCODE
}
finally {
    Pop-Location
}
if ($auditExit -notin @(0, 1)) { throw "PakEntryAudit loi $auditExit. Xem $stderrPath" }

$auditValues = @{}
foreach ($line in $auditOutput) {
    if ($line -match '^([A-Z_]+)=(\d+)$') { $auditValues[$matches[1]] = [int]$matches[2] }
}
foreach ($key in 'ENTRY_FILES', 'ENTRY_PAK', 'ENTRY_LOOSE', 'ENTRY_FAILURES') {
    if (-not $auditValues.ContainsKey($key)) { throw "PakEntryAudit khong tra ve $key." }
}

$missing = @()
if (Test-Path -LiteralPath $failurePath -PathType Leaf) {
    $missing = @([IO.File]::ReadAllLines($failurePath, $encoding) |
        Where-Object { $_ } | ForEach-Object { $_.ToLowerInvariant() } | Sort-Object -Unique)
}
$missingSet = @{}
foreach ($path in $missing) { $missingSet[$path] = $true }

$expected = @{
    'meleeweapon.txt' = @{ MissingRows = 20; MissingUnique = 2 }
    'rangeweapon.txt' = @{ MissingRows = 30; MissingUnique = 12 }
    'armor.txt'       = @{ MissingRows = 0;  MissingUnique = 0 }
    'helm.txt'        = @{ MissingRows = 0;  MissingUnique = 0 }
    'boot.txt'        = @{ MissingRows = 0;  MissingUnique = 0 }
    'belt.txt'        = @{ MissingRows = 0;  MissingUnique = 0 }
    'amulet.txt'      = @{ MissingRows = 0;  MissingUnique = 0 }
    'ring.txt'        = @{ MissingRows = 10; MissingUnique = 10 }
    'cuff.txt'        = @{ MissingRows = 20; MissingUnique = 20 }
    'pendant.txt'     = @{ MissingRows = 0;  MissingUnique = 0 }
    'horse.txt'       = @{ MissingRows = 0;  MissingUnique = 0 }
    'magicscript.txt' = @{ MissingRows = 429; MissingUnique = 387 }
    'ibitem.txt'      = @{ MissingRows = 11; MissingUnique = 11 }
    'material.txt'    = @{ MissingRows = 70; MissingUnique = 54 }
    'questkey.txt'    = @{ MissingRows = 9;  MissingUnique = 9 }
}

$tableReport = @()
foreach ($name in @($expected.Keys | Sort-Object)) {
    $missingRows = @($tableRows[$name] | Where-Object { $missingSet.ContainsKey($_) }).Count
    $missingUnique = @($tableRows[$name] | Where-Object { $missingSet.ContainsKey($_) } | Sort-Object -Unique).Count
    if ($missingRows -ne $expected[$name].MissingRows -or
        $missingUnique -ne $expected[$name].MissingUnique) {
        throw "Icon VNG thay doi tai ${name}: missingRows=$missingRows, missingUnique=$missingUnique."
    }
    $tableReport += [ordered]@{
        Table = $name
        ReferencedRows = @($tableRows[$name]).Count
        ReferencedUnique = @($tableRows[$name] | Sort-Object -Unique).Count
        MissingRows = $missingRows
        MissingUnique = $missingUnique
    }
}

if ($allPaths.Count -ne 3974) { throw "Sai tong icon duy nhat: $($allPaths.Count), can 3974." }
if ($auditValues.ENTRY_FILES -ne 3974 -or $auditValues.ENTRY_PAK -ne 3470 -or
    $auditValues.ENTRY_LOOSE -ne 0 -or $auditValues.ENTRY_FAILURES -ne 504 -or
    $missing.Count -ne 504) {
    throw "Sai ket qua PAK: files=$($auditValues.ENTRY_FILES), pak=$($auditValues.ENTRY_PAK), loose=$($auditValues.ENTRY_LOOSE), missing=$($auditValues.ENTRY_FAILURES)."
}

$criticalTables = @('armor.txt', 'helm.txt', 'boot.txt', 'belt.txt', 'amulet.txt', 'pendant.txt', 'horse.txt')
foreach ($name in $criticalTables) {
    $row = @($tableReport | Where-Object { $_.Table -eq $name })[0]
    if ($row.MissingUnique -ne 0) { throw "Bang trang bi cot loi thieu icon: $name" }
}

$report = [ordered]@{
    Result = 'PASS'
    Policy = 'VNG_PAK_ONLY_NO_SYNTHETIC_FALLBACK'
    DataRoot = $DataRoot
    UniqueReferences = $allPaths.Count
    PakEntries = $auditValues.ENTRY_PAK
    LooseEntries = $auditValues.ENTRY_LOOSE
    MissingBacklog = $missing.Count
    CriticalEquipmentTablesComplete = $criticalTables
    Tables = $tableReport
    Catalog = $catalogPath
    MissingCatalog = $failurePath
}
[IO.File]::WriteAllText($reportPath, ($report | ConvertTo-Json -Depth 8), [Text.Encoding]::UTF8)
[pscustomobject]$report
