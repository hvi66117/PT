[CmdletBinding()]
param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$AuditRoot
)

$ErrorActionPreference = 'Stop'
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
if (-not $AuditRoot) {
    $AuditRoot = Join-Path (Split-Path -Parent $ProjectRoot) 'SourceMigration\staging\p0.3-validated-entry-sets\audit'
}
$AuditRoot = [IO.Path]::GetFullPath($AuditRoot).TrimEnd('\')

function Write-Utf8([string]$Path, [string]$Text) {
    [IO.File]::WriteAllText($Path, $Text, [Text.UTF8Encoding]::new($false))
}

$sourceFiles = @(
    Get-Item (Join-Path $ProjectRoot 'Sources\Core\Src\ScriptFuns.cpp')
    Get-Item (Join-Path $ProjectRoot 'Sources\Core\Src\LuaFuns.cpp')
)
$engineApi = @{}
foreach ($file in $sourceFiles) {
    $text = [Text.Encoding]::GetEncoding(28591).GetString([IO.File]::ReadAllBytes($file.FullName))
    foreach ($match in [regex]::Matches($text, '\{\s*"([A-Za-z_][A-Za-z0-9_]*)"\s*,\s*[A-Za-z_][A-Za-z0-9_]*\s*\}')) {
        $name = $match.Groups[1].Value
        if (-not $engineApi.ContainsKey($name)) { $engineApi[$name] = [Collections.Generic.List[string]]::new() }
        if (-not $engineApi[$name].Contains($file.FullName)) { $engineApi[$name].Add($file.FullName) }
    }
}

$engineDocument = [ordered]@{ schema = 1; engine_api_count = $engineApi.Count; engine_api = [ordered]@{} }
foreach ($name in @($engineApi.Keys | Sort-Object)) { $engineDocument.engine_api[$name] = @($engineApi[$name]) }
Write-Utf8 (Join-Path $AuditRoot 'engine-lua-api.json') (($engineDocument | ConvertTo-Json -Depth 6) + "`r`n")

$detailsPath = Join-Path $AuditRoot 'lua-semantic-details.json'
$details = @(Get-Content -Raw -LiteralPath $detailsPath | ConvertFrom-Json)
foreach ($entry in $details) {
    $entry.unresolved_calls = @($entry.unresolved_calls | Where-Object { -not $engineApi.ContainsKey($_) })
    $entry.possible_project_globals = @($entry.possible_project_globals | Where-Object { -not $engineApi.ContainsKey($_) })
    $entry.definitely_unresolved_calls = @($entry.definitely_unresolved_calls | Where-Object { -not $engineApi.ContainsKey($_) })
    $entry.unresolved_call_count = @($entry.unresolved_calls).Count
    $entry.possible_project_global_count = @($entry.possible_project_globals).Count
    $entry.definitely_unresolved_count = @($entry.definitely_unresolved_calls).Count
    $entry.static_status = if ($entry.unresolved_call_count -gt 0 -or $entry.possible_project_global_count -gt 0) { 'review_api' } else { 'static_candidate' }
}
Write-Utf8 $detailsPath (($details | ConvertTo-Json -Depth 10) + "`r`n")

$semanticColumns = 'bucket','category','logical_path','source_tier','encoding','reference_fields','definition_count','call_count','callback_missing_count','unresolved_call_count','definitely_unresolved_count','possible_project_global_count','static_status','sha256','output'
$semanticCsv = $details | Select-Object $semanticColumns | ConvertTo-Csv -Delimiter "`t" -NoTypeInformation
Write-Utf8 (Join-Path $AuditRoot 'lua-semantic.tsv') (($semanticCsv -join "`r`n") + "`r`n")

$nameIndex = @{}
foreach ($entry in $details) {
    foreach ($name in @($entry.unresolved_calls) + @($entry.possible_project_globals)) {
        if (-not $nameIndex.ContainsKey($name)) { $nameIndex[$name] = [ordered]@{ paths = @{}; unresolved = $false } }
        $nameIndex[$name].paths[$entry.logical_path] = $true
        if ($entry.unresolved_calls -contains $name) { $nameIndex[$name].unresolved = $true }
    }
}
$missingRows = foreach ($name in $nameIndex.Keys) {
    [pscustomobject]@{
        name = $name
        entry_count = $nameIndex[$name].paths.Count
        status = if ($nameIndex[$name].unresolved) { 'not_in_current_engine_or_project' } else { 'project_global_candidate' }
    }
}
$missingRows = @($missingRows | Sort-Object @{Expression='entry_count';Descending=$true}, name)
$missingCsv = $missingRows | ConvertTo-Csv -Delimiter "`t" -NoTypeInformation
Write-Utf8 (Join-Path $AuditRoot 'lua-missing-api.tsv') (($missingCsv -join "`r`n") + "`r`n")

$summaryPath = Join-Path $AuditRoot 'summary.json'
$summary = Get-Content -Raw -LiteralPath $summaryPath | ConvertFrom-Json
$summary.lua.engine_api_count = $engineApi.Count
$summary.lua.missing_api_name_count = $missingRows.Count
$statusGroups = @($details | Group-Object static_status)
foreach ($property in @($summary.lua.status.PSObject.Properties)) { $summary.lua.status.PSObject.Properties.Remove($property.Name) }
foreach ($group in $statusGroups) { $summary.lua.status | Add-Member -NotePropertyName $group.Name -NotePropertyValue $group.Count }
foreach ($bucket in @($details.bucket | Sort-Object -Unique)) {
    $target = $summary.lua.bucket_status.$bucket
    if (-not $target) { $summary.lua.bucket_status | Add-Member -NotePropertyName $bucket -NotePropertyValue ([pscustomobject]@{}); $target = $summary.lua.bucket_status.$bucket }
    foreach ($property in @($target.PSObject.Properties)) { $target.PSObject.Properties.Remove($property.Name) }
    foreach ($group in @($details | Where-Object bucket -eq $bucket | Group-Object static_status)) {
        $target | Add-Member -NotePropertyName $group.Name -NotePropertyValue $group.Count
    }
}
Write-Utf8 $summaryPath (($summary | ConvertTo-Json -Depth 8) + "`r`n")

[pscustomobject]@{
    Status = 'PASS'
    EngineApiCount = $engineApi.Count
    MissingApiNameCount = $missingRows.Count
    ReviewEntries = @($details | Where-Object static_status -eq 'review_api').Count
    CallbackGapCount = $summary.lua.missing_callback_group_count
}
