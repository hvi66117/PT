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

function Assert-True([bool]$Condition, [string]$Message) {
    if (-not $Condition) { throw $Message }
}

function Read-Latin1([string]$Path) {
    [Text.Encoding]::GetEncoding(28591).GetString([IO.File]::ReadAllBytes($Path))
}

function Assert-Contains([string]$Text, [string]$Pattern, [string]$Message) {
    if ($Text -notmatch $Pattern) { throw $Message }
}

$manifestPath = Join-Path $ProjectRoot 'Deploy\RUNTIME_CONTENT_MANIFEST.json'
$quarantinePath = Join-Path $ProjectRoot 'Deploy\LUA_P0_3_4_QUARANTINE.json'
$importerPath = Join-Path $ProjectRoot 'Deploy\Import-VngQuestKey.ps1'
$scriptFunsPath = Join-Path $ProjectRoot 'Sources\Core\Src\ScriptFuns.cpp'
$wave7Path = Join-Path $ProjectRoot 'Sources\Core\Src\PhongThanLuaWave7.h'
$basicTablePath = Join-Path $ProjectRoot 'Sources\Core\Src\KBasPropTbl.CPP'

$manifest = Get-Content -LiteralPath $manifestPath -Raw | ConvertFrom-Json
$quarantine = Get-Content -LiteralPath $quarantinePath -Raw | ConvertFrom-Json
$scriptFuns = Read-Latin1 $scriptFunsPath
$wave7 = Get-Content -LiteralPath $wave7Path -Raw
$basicTable = Read-Latin1 $basicTablePath
$importer = Get-Content -LiteralPath $importerPath -Raw

$questTable = @($manifest.DataRegistries.Item.RequiredTables |
    Where-Object { $_.Name -ieq 'questkey.txt' })
Assert-True ($questTable.Count -eq 1) 'questkey.txt is not a unique required item table.'
Assert-True ([int]$questTable[0].MinimumColumns -eq 19) 'questkey.txt schema is not locked to 19 columns.'
Assert-Contains $basicTable 'i\s*==\s*22' 'KBPT_Quest is not a required runtime table.'
Assert-Contains $basicTable 'nRequiredTables\s*!=\s*12' 'Item loader required-table count is not 12.'
Assert-Contains $basicTable 'GetQuestRecord[\s\S]{0,180}m_BPTQuest\.FindRecord' 'Quest item generation still looks up sparse VNG keys by row.'
Assert-Contains $importer '2A6069B05472F817A0BC4948CFDE932D9B9BC4219C9BCCA1E8048261F3D3E26D' 'QuestKey importer does not pin the verified VNG payload hash.'

$implemented = @('AddNormalItem', 'IsExistItem', 'GetNpcLevel', 'ThrowItem')
foreach ($api in $implemented) {
    Assert-Contains $scriptFuns ('\{"' + [regex]::Escape($api) + '"\s*,') "Lua API is not registered: $api"
}
Assert-Contains $scriptFuns 'MapVngNormalItemTuple[\s\S]{0,1100}item_materials[\s\S]{0,1100}item_task[\s\S]{0,1100}item_magicscript' 'VNG item tuple allowlist is incomplete.'
Assert-True ($scriptFuns -notmatch 'nGenre\s*==\s*item_mine') 'Unverified VNG IBItem genre 8 was mapped into legacy item_mine.'
Assert-Contains $scriptFuns 'CreateVngNormalItem[\s\S]{0,1800}ItemSet\.Remove\(nIndex\)' 'Invalid generated VNG items are not released.'
Assert-Contains $scriptFuns 'LuaAddNormalItem[\s\S]{0,1800}m_ItemList\.Add[\s\S]{0,500}ItemSet\.Remove\(nIndex\)' 'AddNormalItem does not roll back when inventory insertion fails.'
Assert-Contains $scriptFuns 'LuaGetNpcLevel[\s\S]{0,350}nNpcIndex\s*>=\s*MAX_NPC' 'GetNpcLevel has no upper-bound guard.'

$summaryPath = Join-Path $AuditRoot 'summary.json'
$detailsPath = Join-Path $AuditRoot 'lua-semantic-details.json'
$missingPath = Join-Path $AuditRoot 'lua-missing-api.tsv'
Assert-True (Test-Path -LiteralPath $summaryPath) "Missing audit summary: $summaryPath"
Assert-True (Test-Path -LiteralPath $detailsPath) "Missing audit details: $detailsPath"
Assert-True (Test-Path -LiteralPath $missingPath) "Missing API report: $missingPath"
$summary = Get-Content -LiteralPath $summaryPath -Raw | ConvertFrom-Json
$details = @(Get-Content -LiteralPath $detailsPath -Raw | ConvertFrom-Json)
$missing = @(Import-Csv -LiteralPath $missingPath -Delimiter "`t")
$missingNames = @($missing | ForEach-Object name)

Assert-True ($summary.integrity.invalid -eq 0) 'Validated payload integrity regressed.'
Assert-True ($summary.lua.missing_callback_group_count -eq 0) 'Lua callback compatibility regressed.'
Assert-True ($summary.lua.engine_api_count -ge 532) "Engine API count did not reach 532: $($summary.lua.engine_api_count)"
Assert-True ($summary.lua.missing_api_name_count -le 182) "P0.3.4 API gap did not fall to 182: $($summary.lua.missing_api_name_count)"
foreach ($api in $implemented) {
    Assert-True ($missingNames -notcontains $api) "Audit still reports implemented API: $api"
}
Assert-True ($missingNames -notcontains 'TaskNote') 'TaskNote Wave 5 port regressed.'
Assert-True ($missingNames -notcontains 'AddMyTrap') 'AddMyTrap Wave 7 port regressed.'
Assert-Contains $wave7 'LuaAddMyTrapCompat[\s\S]{0,1500}GetMpsPos[\s\S]{0,500}PhongThanSetNpcOwner[\s\S]{0,500}m_dwNpcTimerDeadline' 'AddMyTrap left quarantine without player position, ownership and lifetime semantics.'

$officialReview = @($details | Where-Object {
    $_.bucket -eq 'vng-official-baseline' -and $_.static_status -eq 'review_api'
} | ForEach-Object logical_path)
$declared = @($quarantine.OfficialRuntimeQuarantine)
foreach ($path in $officialReview) {
    Assert-True ($declared -contains $path) "Official review script is missing from runtime quarantine: $path"
}
Assert-True ($declared -contains '\script\怪物\不义侯.lua') 'The official genre-8 IBItem script must remain quarantined.'
Assert-True ($declared.Count -eq 15) "Unexpected official runtime quarantine count: $($declared.Count)"

[pscustomobject]@{
    Result = 'PASS'
    Stage = 'P0.3.4'
    ImplementedApiCount = $implemented.Count
    EngineApiCount = $summary.lua.engine_api_count
    RemainingApiNames = $summary.lua.missing_api_name_count
    OfficialStaticReview = $officialReview.Count
    OfficialRuntimeQuarantine = $declared.Count
    QuestKey = 'verified-original-vng'
}
