[CmdletBinding()]
param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$AuditRoot
)

$ErrorActionPreference = 'Stop'
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot)
if (-not $AuditRoot) {
    $AuditRoot = Join-Path (Split-Path -Parent $ProjectRoot) 'SourceMigration\staging\p0.3-validated-entry-sets\audit'
}

function Assert-True([bool]$Condition, [string]$Message) {
    if (-not $Condition) { throw $Message }
}
function Read-Latin1([string]$Path) {
    [Text.Encoding]::GetEncoding(28591).GetString([IO.File]::ReadAllBytes($Path))
}
function Assert-Contains([string]$Text, [string]$Pattern, [string]$Message) {
    if ($Text -notmatch $Pattern) { throw $Message }
}

$source = Read-Latin1 (Join-Path $ProjectRoot 'Sources\Core\Src\ScriptFuns.cpp')
$dataDef = Read-Latin1 (Join-Path $ProjectRoot 'Sources\Core\Src\GameDataDef.h')
$dbLoad = Read-Latin1 (Join-Path $ProjectRoot 'Sources\Core\Src\KPlayerDBFuns.cpp')
$catalog = Get-Content -Raw (Join-Path $ProjectRoot 'Docs\LUA_API_182_CATALOG.json') | ConvertFrom-Json
$apis = @($catalog.apis | Where-Object wave -eq 3 | ForEach-Object name)

Assert-True ($apis.Count -eq 32) "Wave 3 count mismatch: $($apis.Count)"
foreach ($api in $apis) {
    Assert-Contains $source ('\{"' + [regex]::Escape($api) + '"\s*,') "Wave 3 API is not registered: $api"
    Assert-Contains $source ('int\s+Lua' + [regex]::Escape($api) + 'Compat\s*\(') "Wave 3 implementation is absent: $api"
}

Assert-Contains $dataDef 'TASKVALUE_PT_JUSTICE_EVIL\s*=\s*4800[\s\S]*TASKVALUE_PT_ENGINE_END\s*=\s*4899' 'Engine-owned task range 4800-4899 is not locked.'
Assert-Contains $source 'GetPersistentMasterName[\s\S]{0,1800}FindOnlinePlayerByExactName' 'Mentor relation does not resolve persisted names to online players.'
Assert-Contains $source 'GetCurrentTeamTaskState[\s\S]{0,1300}dwCaptainId[\s\S]{0,800}ZeroMemory' 'Team task state is not invalidated when team ownership changes.'
Assert-Contains $source 'LuaTeamActionCompat[\s\S]{0,1900}m_nCaptain[\s\S]{0,900}m_nMember' 'TeamAction does not run over the authoritative team roster.'
Assert-Contains $source 'LuaAddOwnExtendExpCompat[\s\S]{0,900}DirectAddExp' 'Extended experience bypasses the server experience pipeline.'
Assert-Contains $source 'LuaActiveTitleQualifyCompat[\s\S]{0,1000}SetSaveVal[\s\S]{0,1100}LuaSetCurTitleCompat[\s\S]{0,800}SetRank' 'Title qualification/selection is not persisted and synchronized.'
Assert-Contains $dbLoad 'TASKVALUE_PT_TITLE_FUNCTION[\s\S]{0,300}TASKVALUE_PT_CURRENT_TITLE[\s\S]{0,400}SetRank' 'Persisted title is not restored after task loading.'
Assert-Contains $source 'LuaApplyAssignedAttribCompat[\s\S]{0,1500}SetBaseStrength[\s\S]{0,500}SetBaseDexterity[\s\S]{0,500}SetBaseVitality[\s\S]{0,500}SetBaseEngergy' 'Assigned attributes do not use the authoritative synced setters.'
Assert-Contains $source 'LuaPetGetTypeCompat[\s\S]{0,1000}TASKVALUE_PT_PET_TYPE[\s\S]{0,600}m_nPetIdx' 'Pet type has neither persistent nor active-pet resolution.'
Assert-Contains $source 'LuaGetExploitLevelCompat[\s\S]{0,600}exploit_level\.txt[\s\S]{0,500}NeedExploit' 'Exploit level is not data-driven and fail-closed.'

$missing = @(Import-Csv -Delimiter "`t" (Join-Path $AuditRoot 'lua-missing-api.tsv'))
Assert-True (@($apis | Where-Object { $_ -in $missing.name }).Count -eq 0) 'Audit still reports one or more Wave 3 APIs.'
$summary = Get-Content -Raw (Join-Path $AuditRoot 'summary.json') | ConvertFrom-Json
Assert-True ($summary.lua.missing_api_name_count -le 108) "Wave 3 gap regressed above 108: $($summary.lua.missing_api_name_count)"
Assert-True ($summary.integrity.invalid -eq 0 -and $summary.lua.missing_callback_group_count -eq 0) 'Integrity or callback gate regressed.'

[pscustomobject]@{
    Status = 'PASS'
    Wave = 3
    ImplementedApiCount = $apis.Count
    RemainingApiNames = $summary.lua.missing_api_name_count
}
