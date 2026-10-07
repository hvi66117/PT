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
$player = Read-Latin1 (Join-Path $ProjectRoot 'Sources\Core\Src\KPlayer.cpp')
$protocol = Read-Latin1 (Join-Path $ProjectRoot 'Sources\Core\Src\KProtocolProcess.cpp')
$protocolDef = Read-Latin1 (Join-Path $ProjectRoot 'Headers\KProtocolDef.h')
$catalog = Get-Content -Raw (Join-Path $ProjectRoot 'Docs\LUA_API_182_CATALOG.json') | ConvertFrom-Json
$apis = @($catalog.apis | Where-Object wave -eq 6 | ForEach-Object name)

Assert-True ($apis.Count -eq 8) "Wave 6 count mismatch: $($apis.Count)"
foreach ($api in $apis) {
    Assert-Contains $source ('\{"' + [regex]::Escape($api) + '"\s*,') "Wave 6 API is not registered: $api"
    Assert-Contains $source ('int\s+Lua' + [regex]::Escape($api) + 'Compat\s*\(') "Wave 6 implementation is absent: $api"
}

Assert-Contains $source 'LuaGetLiveSkillLevelCompat[\s\S]{0,700}GetCurrentLevel' 'Live skill level is not read from the authoritative player NPC skill list.'
Assert-Contains $source 'LuaBeginLvSkillCompat[\s\S]{0,1800}g_GetScript[\s\S]{0,700}m_dwTaskExcuteScriptId[\s\S]{0,700}m_nPaceBarTimeMax' 'BeginLvSkill does not validate and schedule its VNG script callback.'
Assert-Contains $source 'LuaDoSkillActionCompat[\s\S]{0,900}SendCommand\(do_stand' 'DoSkillAction does not establish the movement/action boundary.'
Assert-Contains $source 'LuaGetskill_eventskilllevelCompat[\s\S]{0,600}"%d,0,0"' 'Event-skill level does not return the VNG skill-data tuple.'
Assert-Contains $source 'LuaRemoveSpecialSkillCompat[\s\S]{0,1500}m_StateSkillList[\s\S]{0,700}m_LeftTime\s*=\s*0[\s\S]{0,800}SendSyncData_Skill' 'Special-skill removal does not expire state and synchronize learned skills.'
Assert-Contains $source 'LuaPlayerCastSkillCompat[\s\S]{0,900}Lua_ValueToNumber\(L, 2\)[\s\S]{0,400}Lua_ValueToNumber\(L, 3\)[\s\S]{0,500}\.Cast\(' 'PlayerCastSkill does not preserve the audited mode, skill-id and level call form.'
Assert-Contains $protocolDef 'enumS2C_PLAYERSYNC_ID_MASKFEATURE,[\s\S]{0,300}enumS2C_PLAYERSYNC_ID_LEFTSKILL,[\s\S]{0,100}enumS2C_PLAYERSYNC_ID_RIGHTSKILL' 'Skill shortcut sync ids were not appended after the locked legacy ids.'
Assert-Contains $protocol 'enumS2C_PLAYERSYNC_ID_LEFTSKILL[\s\S]{0,180}SetLeftSkill[\s\S]{0,300}enumS2C_PLAYERSYNC_ID_RIGHTSKILL[\s\S]{0,180}SetRightSkill' 'Client does not consume the shortcut synchronization boundary.'
Assert-Contains $player 'SetLeftSkill\(int nSkillID\)[\s\S]{0,300}nSkillID\s*>\s*0[\s\S]{0,500}SetRightSkill\(int nSkillID\)[\s\S]{0,500}nSkillID\s*==\s*0' 'Client shortcut setters cannot safely clear a VNG special skill.'

$missing = @(Import-Csv -Delimiter "`t" (Join-Path $AuditRoot 'lua-missing-api.tsv'))
Assert-True (@($apis | Where-Object { $_ -in $missing.name }).Count -eq 0) 'Audit still reports one or more Wave 6 APIs.'
$summary = Get-Content -Raw (Join-Path $AuditRoot 'summary.json') | ConvertFrom-Json
Assert-True ($summary.lua.missing_api_name_count -le 77) "Wave 6 audit count regressed above 77: $($summary.lua.missing_api_name_count)"
Assert-True ($summary.integrity.invalid -eq 0 -and $summary.lua.missing_callback_group_count -eq 0) 'Integrity or callback gate regressed.'

[pscustomobject]@{ Status='PASS'; Wave=6; ImplementedApiCount=$apis.Count; RemainingApiNames=$summary.lua.missing_api_name_count }
