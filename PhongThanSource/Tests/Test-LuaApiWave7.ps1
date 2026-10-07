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
$wave = Get-Content -Raw (Join-Path $ProjectRoot 'Sources\Core\Src\PhongThanLuaWave7.h')
$catalog = Get-Content -Raw (Join-Path $ProjectRoot 'Docs\LUA_API_182_CATALOG.json') | ConvertFrom-Json
$apis = @($catalog.apis | Where-Object wave -eq 7 | ForEach-Object name)

Assert-True ($apis.Count -eq 31) "Wave 7 count mismatch: $($apis.Count)"
foreach ($api in $apis) {
    Assert-Contains $source ('\{"' + [regex]::Escape($api) + '"\s*,\s*Lua' + [regex]::Escape($api) + 'Compat\}') "Wave 7 API is not registered: $api"
    Assert-Contains $wave ('int\s+Lua' + [regex]::Escape($api) + 'Compat\s*\(') "Wave 7 implementation is absent: $api"
}

Assert-Contains $source '#include\s+"PhongThanLuaWave7\.h"' 'Wave 7 server implementation is not included by ScriptFuns.cpp.'
Assert-Contains $wave 'dwNpcId\s*!=\s*Npc\[nNpcIndex\]\.m_dwID[\s\S]{0,250}ZeroMemory' 'NPC extension state is not protected against recycled engine slots.'
Assert-Contains $wave 'LuaNpcPolyMorphCompat[\s\S]{0,1200}m_NpcSettingIdx[\s\S]{0,300}SendSyncData\(0, TRUE\)' 'NPC morph does not update and synchronize the authoritative template.'
Assert-Contains $wave 'LuaPolyMorphCompat[\s\S]{0,1200}nOriginalTemplate[\s\S]{0,500}SendSyncData\(0, TRUE\)' 'Player morph cannot restore and synchronize the original template.'
Assert-Contains $wave 'LuaSetAIScriptCompat[\s\S]{0,900}g_GetScript[\s\S]{0,500}dwAiScriptId[\s\S]{0,500}ExecuteScript' 'AI script is not validated, retained and initialized.'
Assert-Contains $wave 'LuaAddTotemNpcCompat[\s\S]{0,1000}PhongThanSpawnNpc[\s\S]{0,500}PhongThanSetNpcOwner' 'Totem creation is not a real owned NPC spawn.'
Assert-Contains $wave 'LuaAddMyTrapCompat[\s\S]{0,2200}GetMpsPos[\s\S]{0,900}m_dwNpcTimerDeadline' 'Player trap creation does not use player position and bounded lifetime.'
Assert-Contains $wave 'LuaDelNpcTimerCompat[\s\S]{0,600}m_TimerScriptID\s*=\s*0[\s\S]{0,200}m_nNpcTimerValue\s*=\s*0[\s\S]{0,200}m_dwNpcTimerDeadline\s*=\s*0' 'NPC timer deletion leaves timer state behind.'
Assert-Contains $wave 'LuaBeginMotionCompat[\s\S]{0,1800}g_GetScript[\s\S]{0,700}m_dwTaskExcuteScriptId[\s\S]{0,900}m_nPaceBarTimeMax[\s\S]{0,900}dwMotionTargetId' 'Motion does not schedule a validated callback with guarded target identity.'
Assert-Contains $wave 'LuaSetEffectNpcCompat[\s\S]{0,2400}PhongThanSpawnNpc[\s\S]{0,1400}SendSyncData[\s\S]{0,900}dwNpcId' 'Effect NPCs are not real synchronized NPC records.'
Assert-Contains $wave 'LuaClearEffectNpcCompat[\s\S]{0,1100}dwNpcId[\s\S]{0,400}PhongThanRemoveNpc' 'Effect cleanup does not validate NPC identity before removal.'
Assert-Contains $wave 'LuaCaptureNpcCompat[\s\S]{0,1300}PhongThanSetNpcOwner[\s\S]{0,500}SetCamp' 'CaptureNpc does not transfer ownership and camp.'
Assert-Contains $wave 'LuaCallMonsterAttackerCompat[\s\S]{0,2600}PhongThanSpawnNpc[\s\S]{0,900}m_TimerScriptID[\s\S]{0,1000}m_ActionScriptID[\s\S]{0,700}m_btSpecial' 'Monster attacker creation drops timer, death-script or hard-monster semantics.'
Assert-Contains $wave 'LuaGetNpcEnmityItemCompat[\s\S]{0,1200}m_nLastDamageIdx[\s\S]{0,600}m_dwID[\s\S]{0,300}return 3' 'Enmity item does not return a validated NPC index/id/value tuple.'
Assert-Contains $wave 'LuaGetNpcOwerCompat[\s\S]{0,600}m_dwID' 'GetNpcOwer does not return the owning player UUID.'

$missing = @(Import-Csv -Delimiter "`t" (Join-Path $AuditRoot 'lua-missing-api.tsv'))
Assert-True (@($apis | Where-Object { $_ -in $missing.name }).Count -eq 0) 'Audit still reports one or more Wave 7 APIs.'
$summary = Get-Content -Raw (Join-Path $AuditRoot 'summary.json') | ConvertFrom-Json
Assert-True ($summary.lua.missing_api_name_count -le 46) "Wave 7 audit count regressed above 46: $($summary.lua.missing_api_name_count)"
Assert-True ($summary.integrity.valid -eq 3680 -and $summary.integrity.invalid -eq 0 -and $summary.lua.missing_callback_group_count -eq 0) 'Integrity or callback gate regressed.'

[pscustomobject]@{ Status='PASS'; Wave=7; ImplementedApiCount=$apis.Count; RemainingApiNames=$summary.lua.missing_api_name_count }
