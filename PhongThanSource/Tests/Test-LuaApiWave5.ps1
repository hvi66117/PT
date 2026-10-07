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
function Assert-True([bool]$Condition, [string]$Message) { if (-not $Condition) { throw $Message } }
function Read-Latin1([string]$Path) { [Text.Encoding]::GetEncoding(28591).GetString([IO.File]::ReadAllBytes($Path)) }
function Assert-Contains([string]$Text, [string]$Pattern, [string]$Message) { if ($Text -notmatch $Pattern) { throw $Message } }

$source = Read-Latin1 (Join-Path $ProjectRoot 'Sources\Core\Src\ScriptFuns.cpp')
$dataDef = Read-Latin1 (Join-Path $ProjectRoot 'Sources\Core\Src\GameDataDef.h')
$playerHeader = Read-Latin1 (Join-Path $ProjectRoot 'Sources\Core\Src\KPlayer.h')
$playerSource = Read-Latin1 (Join-Path $ProjectRoot 'Sources\Core\Src\KPlayer.cpp')
$dbLoad = Read-Latin1 (Join-Path $ProjectRoot 'Sources\Core\Src\KPlayerDBFuns.cpp')
$catalog = Get-Content -Raw (Join-Path $ProjectRoot 'Docs\LUA_API_182_CATALOG.json') | ConvertFrom-Json
$apis = @($catalog.apis | Where-Object wave -eq 5 | ForEach-Object name)
$registry = Get-Content -Raw (Join-Path $ProjectRoot 'Deploy\VNG_TASK_NOTE_CONTRACT.json') | ConvertFrom-Json
$quarantine = Get-Content -Raw (Join-Path $ProjectRoot 'Deploy\LUA_P0_3_4_QUARANTINE.json') | ConvertFrom-Json

Assert-True ($apis.Count -eq 12) "Wave 5 count mismatch: $($apis.Count)"
foreach ($api in $apis) {
    Assert-Contains $source ('\{"' + [regex]::Escape($api) + '"\s*,') "Wave 5 API is not registered: $api"
    Assert-Contains $source ('int\s+Lua' + [regex]::Escape($api) + 'Compat\s*\(') "Wave 5 implementation is absent: $api"
}

Assert-Contains $source 'LuaTaskNoteCompat[\s\S]{0,900}BuildPhongThanTaskText[\s\S]{0,500}SendPhongThanTaskRecord' 'TaskNote drops the VNG task id, step or template arguments.'
Assert-Contains $source 'SendPhongThanTaskRecord[\s\S]{0,1400}UI_NOTEINFO' 'TaskNote does not use the locked task-journal protocol.'
Assert-Contains $source 'LuaSayTaskCompat[\s\S]{0,2600}Lua_GetN\(L, 2\)[\s\S]{0,1000}Lua_GetTable[\s\S]{0,1000}show[\s\S]{0,1700}m_szTaskAnswerFun' 'SayTask does not parse nested VNG show/label/callback rows.'
Assert-Contains $source 'LuaFinishNpcCollectionCompat[\s\S]{0,1400}\\\\settings\\\\npccollection\.txt[\s\S]{0,1200}GetString\(nRow, 3' 'NPC collection does not read the official VNG registry.'
Assert-True ($registry.NpcCollection.EntryId -eq '0x170570FA' -and $registry.NpcCollection.DataRowCount -eq 30) 'NPC collection registry facts changed.'
Assert-True ($registry.NpcCollection.PayloadSha256 -eq '13DCA1784C896DE6E71C46CAB2CAA075751DCFCC6FFB77A048EBAA1FE22C2C6E') 'NPC collection payload hash changed.'
Assert-True (-not $quarantine.BlockedDataContracts.PSObject.Properties['TaskNote']) 'TaskNote remains in data-contract quarantine.'

Assert-Contains $playerHeader 'm_nPhongThanTaskState[\s\S]{0,160}m_nPhongThanTaskSubState[\s\S]{0,160}m_dwPhongThanTaskRevision' 'Player task-marker state is incomplete.'
Assert-Contains $playerSource 'm_nPhongThanTaskState\s*=\s*0[\s\S]{0,160}m_nPhongThanTaskSubState\s*=\s*0[\s\S]{0,160}m_dwPhongThanTaskRevision\s*=\s*0' 'Player task-marker state is not reset.'
Assert-Contains $dataDef 'TASKVALUE_PT_TASK_STATE[\s\S]{0,120}TASKVALUE_PT_TASK_SUB_STATE[\s\S]{0,120}TASKVALUE_PT_TASK_REVISION' 'Task-marker persistence slots are not locked.'
Assert-Contains $source 'LuaSetPlayerTaskStateCompat[\s\S]{0,1500}TASKVALUE_PT_TASK_STATE[\s\S]{0,500}TASKVALUE_PT_TASK_SUB_STATE[\s\S]{0,500}TASKVALUE_PT_TASK_REVISION' 'SetPlayerTaskState is not persisted through the role task ABI.'
Assert-Contains $dbLoad 'TASKVALUE_PT_TASK_STATE[\s\S]{0,300}TASKVALUE_PT_TASK_SUB_STATE[\s\S]{0,300}TASKVALUE_PT_TASK_REVISION' 'Relog does not restore Phong Than task state and revision.'
Assert-Contains $source 'LuaSetMateTaskCompat[\s\S]{0,1500}TASKVALUE_BASEDATA_MATENAME[\s\S]{0,1000}SetSaveVal\(nTaskId[\s\S]{0,200}TRUE' 'SetMateTask does not update and sync the online spouse.'
Assert-Contains $source 'LuaIsNewBirthCompleteCompat[\s\S]{0,500}m_byTranslife\s*>\s*0' 'New-birth completion is not derived from authoritative role state.'
Assert-Contains $dataDef 'TASKVALUE_PT_JE_MAIN_TASK_BEGIN\s*=\s*4996[\s\S]{0,200}TASKVALUE_PT_JE_MAIN_TASK_END\s*=\s*4999' 'JE main-task persistence range is not locked.'
Assert-Contains $source 'SetJEMainTaskBit[\s\S]{0,1000}1U\s*<<[\s\S]{0,600}SetSaveVal\(nTask, \(int\)nValue, TRUE\)' 'JE main-task completion is not persisted and synced as a bitset.'
Assert-Contains $source 'LuaTaskCheckCompat[\s\S]{0,500}SetJEMainTaskBit[\s\S]{0,500}SendPhongThanTaskRecord' 'TaskCheck neither records nor persists completion.'

$missing = @(Import-Csv -Delimiter "`t" (Join-Path $AuditRoot 'lua-missing-api.tsv'))
Assert-True (@($apis | Where-Object { $_ -in $missing.name }).Count -eq 0) 'Audit still reports one or more Wave 5 APIs.'
$summary = Get-Content -Raw (Join-Path $AuditRoot 'summary.json') | ConvertFrom-Json
Assert-True ($summary.lua.missing_api_name_count -le 85) "Wave 5 audit count regressed above 85: $($summary.lua.missing_api_name_count)"
Assert-True ($summary.integrity.invalid -eq 0 -and $summary.lua.missing_callback_group_count -eq 0) 'Integrity or callback gate regressed.'

[pscustomobject]@{ Status='PASS'; Wave=5; ImplementedApiCount=$apis.Count; RemainingApiNames=$summary.lua.missing_api_name_count }
