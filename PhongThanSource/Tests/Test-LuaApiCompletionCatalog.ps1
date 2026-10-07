[CmdletBinding()]
param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$AuditRoot,
    [switch]$Regenerate
)

$ErrorActionPreference = 'Stop'
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot)
if (-not $AuditRoot) {
    $AuditRoot = Join-Path (Split-Path -Parent $ProjectRoot) 'SourceMigration\staging\p0.3-validated-entry-sets\audit'
}

function Assert-True([bool]$Condition, [string]$Message) {
    if (-not $Condition) { throw $Message }
}

$generator = Join-Path $ProjectRoot 'Tools\New-LuaApiCompletionCatalog.ps1'
if ($Regenerate) {
    & $generator -ProjectRoot $ProjectRoot -AuditRoot $AuditRoot | Out-Null
}
$jsonPath = Join-Path $ProjectRoot 'Docs\LUA_API_182_CATALOG.json'
$tsvPath = Join-Path $ProjectRoot 'Docs\LUA_API_182_CATALOG.tsv'
$missingPath = Join-Path $AuditRoot 'lua-missing-api.tsv'
$catalog = Get-Content -Raw -LiteralPath $jsonPath | ConvertFrom-Json
$missing = @(Import-Csv -Delimiter "`t" -LiteralPath $missingPath | Where-Object { $_ -and $_.name })
$apis = @($catalog.apis)

Assert-True ($catalog.api_count -eq 182) "Catalog does not cover 182 APIs: $($catalog.api_count)"
Assert-True ($apis.Count -eq 182) "Catalog API array mismatch: $($apis.Count)"
Assert-True (@($apis.name | Sort-Object -Unique).Count -eq 182) 'Catalog contains duplicate API names.'
Assert-True (@($missing | Where-Object { $_.name -notin $apis.name }).Count -eq 0) 'Catalog omitted audited API names.'
Assert-True (@($apis | Where-Object { -not $_.subsystem -or -not $_.wave }).Count -eq 0) 'Catalog has unclassified API entries.'
Assert-True (($apis | Measure-Object audited_file_references -Sum).Sum -eq 1607) 'Catalog reference total is not 1607.'
Assert-True (@($catalog.wave_counts).Count -eq 9) 'Implementation waves 1..9 are not fully represented.'
Assert-True (@($apis | Where-Object extracted_call_count -eq 0).Count -eq 0) 'At least one API has no extracted call contract.'
Assert-True (@($apis | Where-Object { $_.name -in @('pcall','ipairs') -and $_.implementation_kind -ne 'lua4-runtime-helper' }).Count -eq 0) 'Lua 4 helpers were classified as gameplay APIs.'
Assert-True (@($apis | Where-Object { $_.name -in @('TaskNote','AddIBBuff','AddEventItem','GetHardNpcAttrib','AddMyTrap','AddTotemNpc','SetAIScript') -and $_.contract_status -ne 'data-contract-recovered' }).Count -eq 0) 'Recovered VNG data contracts lost their completion status.'
Assert-True (@($apis | Where-Object contract_status -eq 'data-contract-recovery-required').Count -eq 0) 'Catalog still contains an unresolved data-contract blocker.'
Assert-True (Test-Path -LiteralPath $tsvPath) 'TSV catalog was not generated.'

[pscustomobject]@{
    Status = 'PASS'
    ApiCount = $apis.Count
    FileReferences = ($apis | Measure-Object audited_file_references -Sum).Sum
    ExtractedCalls = ($apis | Measure-Object extracted_call_count -Sum).Sum
    Waves = @($catalog.wave_counts).Count
    RecoveryRequired = @($apis | Where-Object contract_status -eq 'data-contract-recovery-required').Count
    DataContractsRecovered = @($apis | Where-Object contract_status -eq 'data-contract-recovered').Count
}
