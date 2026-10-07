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
$wave7 = Get-Content -Raw (Join-Path $ProjectRoot 'Sources\Core\Src\PhongThanLuaWave7.h')
$wave8 = Get-Content -Raw (Join-Path $ProjectRoot 'Sources\Core\Src\PhongThanLuaWave8.h')
$wave = Get-Content -Raw (Join-Path $ProjectRoot 'Sources\Core\Src\PhongThanLuaWave9.h')
$catalog = Get-Content -Raw (Join-Path $ProjectRoot 'Docs\LUA_API_182_CATALOG.json') | ConvertFrom-Json
$apis = @($catalog.apis | Where-Object wave -eq 9 | ForEach-Object name)

Assert-True ($apis.Count -eq 16) "Wave 9 count mismatch: $($apis.Count)"
foreach ($api in $apis) {
    Assert-Contains $source ('\{"' + [regex]::Escape($api) + '"\s*,\s*Lua' + [regex]::Escape($api) + 'Compat\}') "Wave 9 API is not registered: $api"
    Assert-Contains $wave ('int\s+Lua' + [regex]::Escape($api) + 'Compat\s*\(') "Wave 9 implementation is absent: $api"
}

Assert-Contains $source '#include\s+"PhongThanLuaWave9\.h"' 'Wave 9 server implementation is not included by ScriptFuns.cpp.'
Assert-Contains $wave 'PhongThanFindInstanceMission[\s\S]{0,1800}m_MissionArray\.GetData' 'Instance lookup bypasses the engine mission array.'
Assert-Contains $wave 'PhongThanEnsureInstanceMission[\s\S]{0,2600}m_MissionArray\.Add[\s\S]{0,700}SetMissionId[\s\S]{0,1200}PHONGTHAN_INSTANCE_FIRST_TIME_SLOT' 'Instance creation does not initialize a real KMission lifecycle.'
Assert-Contains $wave 'LuaSetInstanceTempValueCompat[\s\S]{0,1800}PhongThanEnsureInstanceMission[\s\S]{0,500}SetMission' 'Instance temporary values are not stored in the current instance mission.'
Assert-Contains $wave 'LuaGetInstanceTempValueCompat[\s\S]{0,1200}GetMissionValue' 'Instance temporary values are not read from the mission owner.'
Assert-Contains $wave 'LuaInstanceMsg2AllCompat[\s\S]{0,1700}PhongThanFindInstanceMission[\s\S]{0,900}Msg2All' 'Instance messages are not delivered through KMission membership.'
Assert-Contains $wave 'PhongThanPushInstanceInfo[\s\S]{0,1700}GetPlayerCount[\s\S]{0,500}bIncludeSubWorld' 'Instance info does not expose real mission population and subworld.'
Assert-Contains $wave 'LuaSetMissionVCompat[\s\S]{0,1700}nMissionId[\s\S]{0,500}nStoreId[\s\S]{0,700}SetMission' 'SetMissionV collapsed the audited three-argument mission/store/value schema.'
Assert-Contains $wave 'LuaPlayerInOrOutCompat[\s\S]{0,2200}PhongThanRegisterExistingSiege[\s\S]{0,600}PhongThanAttachPlayerToSiege[\s\S]{0,900}PhongThanDetachGuard' 'PlayerInOrOut does not connect the Wave 8 siege and TGuard lifecycle.'
Assert-Contains $wave8 'PhongThanRegisterExistingSiege[\s\S]{0,1400}dwNpcId' 'Existing VNG carriage NPCs cannot enter the guarded siege registry.'
Assert-Contains $wave 'LuaAddEventCompat[\s\S]{0,1900}strstr\(pszFormat, "%s"\)[\s\S]{0,900}Player\[nPlayerIndex\]\.Name[\s\S]{0,1000}SendSystemInfo' 'AddEvent does not safely expand the player placeholder and publish the event.'
Assert-Contains $wave 'LuaWorldBossDeathCompat[\s\S]{0,1900}pt_persist_world_boss_death[\s\S]{0,900}m_nLastDamageIdx[\s\S]{0,700}dwOwnerUuid' 'World boss death does not persist lifecycle state and verified contributor ownership.'
Assert-Contains $wave 'LuaMonsterOnDeathCompat[\s\S]{0,1800}PHONGTHAN_INSTANCE_KILL_SLOT[\s\S]{0,900}m_nLastDamageIdx' 'Monster death does not update current mission state and contributor ownership.'
Assert-Contains $wave 'LuaSetWorldEventValueCompat[\s\S]{0,700}pt_persist_world_event_value' 'World event values are not persistent.'
Assert-Contains $wave 'LuaSetWorldEventProgressCompat[\s\S]{0,700}pt_persist_world_event_progress' 'World event progress is not stored separately and persistently.'
Assert-Contains $wave 'LuaDeleteSubWorldKindNpcsCompat[\s\S]{0,1400}m_SubWorldIndex\s*==\s*nSubWorld[\s\S]{0,500}m_Kind\s*==\s*nKind[\s\S]{0,500}PhongThanRemoveNpc' 'Subworld kind deletion does not apply exact world/kind filtering and real removal.'
Assert-Contains $wave7 'nBarrierState' 'Wave 7 NPC extension state has no barrier transition guard.'
Assert-Contains $wave 'LuaSetBarrierStateCompat[\s\S]{0,1900}nBarrierState\s*!=\s*nState[\s\S]{0,700}AddRef[\s\S]{0,500}DecRef[\s\S]{0,700}m_nNpcParam\[MAX_NPCPARAM - 1\]' 'Barrier state does not make idempotent collision-reference transitions on the real gate NPC.'

$missing = @(Import-Csv -Delimiter "`t" (Join-Path $AuditRoot 'lua-missing-api.tsv'))
Assert-True (@($apis | Where-Object { $_ -in $missing.name }).Count -eq 0) 'Audit still reports one or more Wave 9 APIs.'
$summary = Get-Content -Raw (Join-Path $AuditRoot 'summary.json') | ConvertFrom-Json
Assert-True ($summary.lua.missing_api_name_count -eq 0) "Wave 9 did not close the API gap: $($summary.lua.missing_api_name_count)"
Assert-True (-not $summary.lua.status.PSObject.Properties['review_api']) 'Validated Lua still contains review_api entries.'
Assert-True ($summary.integrity.valid -eq 3680 -and $summary.integrity.invalid -eq 0 -and $summary.lua.missing_callback_group_count -eq 0) 'Integrity or callback gate regressed.'

[pscustomobject]@{ Status='PASS'; Wave=9; ImplementedApiCount=$apis.Count; RemainingApiNames=$summary.lua.missing_api_name_count; ReviewApi=0 }
