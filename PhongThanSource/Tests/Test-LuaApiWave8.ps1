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
$wave = Get-Content -Raw (Join-Path $ProjectRoot 'Sources\Core\Src\PhongThanLuaWave8.h')
$catalog = Get-Content -Raw (Join-Path $ProjectRoot 'Docs\LUA_API_182_CATALOG.json') | ConvertFrom-Json
$apis = @($catalog.apis | Where-Object wave -eq 8 | ForEach-Object name)

Assert-True ($apis.Count -eq 30) "Wave 8 count mismatch: $($apis.Count)"
foreach ($api in $apis) {
    Assert-Contains $source ('\{"' + [regex]::Escape($api) + '"\s*,\s*Lua' + [regex]::Escape($api) + 'Compat\}') "Wave 8 API is not registered: $api"
    Assert-Contains $wave ('int\s+Lua' + [regex]::Escape($api) + 'Compat\s*\(') "Wave 8 implementation is absent: $api"
}

Assert-Contains $source '#include\s+"PhongThanLuaWave8\.h"' 'Wave 8 server implementation is not included by ScriptFuns.cpp.'
Assert-Contains $wave 'LuaIsTongMemberCompat[\s\S]{0,900}m_cTong\.m_nFlag[\s\S]{0,500}TASKVALUE_PT_POSTERITY_TYPE' 'Tong membership does not use authoritative membership and optional union type.'
Assert-Contains $wave 'PhongThanSendTongMessage[\s\S]{0,1300}m_dwTongNameID[\s\S]{0,600}KPlayerChat::SendSystemInfo' 'Tong messages are not routed to online members of the authoritative Tong id.'
Assert-Contains $wave 'LuaIsOwnerCityCompat[\s\S]{0,1100}m_dwTongNameID[\s\S]{0,500}m_dwTongName' 'City ownership does not compare real Tong and SubWorld ownership ids.'
Assert-Contains $wave 'PhongThanPushCityInfo[\s\S]{0,1500}m_bCheckTong[\s\S]{0,800}m_nTongT[\s\S]{0,500}m_nTongVG[\s\S]{0,800}m_szTongName' 'City info is disconnected from authoritative SubWorld state.'
Assert-Contains $wave 'LuaNewSiegeWeaponCompat[\s\S]{0,2400}PhongThanSpawnNpc[\s\S]{0,1400}dwNpcId' 'NewSiegeWeapon does not create a guarded real NPC record.'
Assert-Contains $wave 'PhongThanValidSiege[\s\S]{0,700}m_dwID\s*!=\s*pRecord->dwNpcId[\s\S]{0,300}ZeroMemory' 'Siege records are not invalidated when an NPC slot is recycled.'
Assert-Contains $wave 'PhongThanAttachPlayerToSiege[\s\S]{0,2000}dwPlayerUuid[\s\S]{0,800}TASKVALUE_PT_INSIDE_WEAPON' 'TGuard attachment does not retain player identity and persistent inside-weapon state.'
Assert-Contains $wave 'LuaGetTGuardInfoCompat[\s\S]{0,1500}szPlayerName[\s\S]{0,900}nCarriageIndex[\s\S]{0,700}return 7' 'GetTGuardInfo does not preserve the audited seven-value tuple.'
Assert-Contains $wave 'LuaDeleteSiegeWeaponCompat[\s\S]{0,1400}PhongThanDetachGuard[\s\S]{0,500}PhongThanRemoveNpc' 'Siege deletion does not detach players and remove the real NPC.'
Assert-Contains $wave 'PhongThanPersistentGroup[\s\S]{0,2400}GameData\.FindDataId[\s\S]{0,1500}GameData\.AddDataGr' 'Tong/city state is not backed by the persistent GameData registry.'
Assert-Contains $wave 'PhongThanSetPersistentValue[\s\S]{0,700}GameData\.Save\(\)' 'Tong/city task updates are not durable across server restart.'
Assert-Contains $wave 'LuaSetCityTaskByIDCompat[\s\S]{0,700}pt_persist_city_task' 'City tasks are not keyed by city id and task id.'
Assert-Contains $wave 'LuaSetTongTaskCompat[\s\S]{0,1400}pt_persist_tong_task[\s\S]{0,500}m_dwTongNameID' 'Tong tasks are not keyed by the current authoritative Tong id.'
Assert-Contains $wave 'LuaAddTongResCompat[\s\S]{0,2200}pt_persist_tong_resource[\s\S]{0,1200}m_dwMoney[\s\S]{0,400}m_dwTotalEff' 'Tong resources are not persisted and reflected into online Tong state.'
Assert-Contains $wave 'LuaGetUnionTongNameByPosterityTypeCompat[\s\S]{0,1100}PhongThanFindOnlineUnionPlayer[\s\S]{0,500}szName1' 'Posterity union lookup has no online binding or persisted Tong name.'
Assert-Contains $wave 'LuaGetCityGateNpcIdxByNpcCompat[\s\S]{0,2300}dwGateNpcId[\s\S]{0,900}KNpcSet::GetDistance' 'City gate lookup does not retain a guarded live-NPC mapping.'
Assert-Contains $wave 'LuaGetCityTotemNpcIdxByNpcCompat[\s\S]{0,1400}dwTotemNpcId' 'City totem lookup is not guarded by NPC identity.'
Assert-Contains $wave 'LuaIsInMonsterAttackDayCompat[\s\S]{0,900}localtime[\s\S]{0,500}tm_wday' 'Monster attack day is a constant instead of calendar-derived state.'

$missing = @(Import-Csv -Delimiter "`t" (Join-Path $AuditRoot 'lua-missing-api.tsv'))
Assert-True (@($apis | Where-Object { $_ -in $missing.name }).Count -eq 0) 'Audit still reports one or more Wave 8 APIs.'
$summary = Get-Content -Raw (Join-Path $AuditRoot 'summary.json') | ConvertFrom-Json
Assert-True ($summary.lua.missing_api_name_count -le 16) "Wave 8 audit count regressed above 16: $($summary.lua.missing_api_name_count)"
Assert-True ($summary.integrity.valid -eq 3680 -and $summary.integrity.invalid -eq 0 -and $summary.lua.missing_callback_group_count -eq 0) 'Integrity or callback gate regressed.'

[pscustomobject]@{ Status='PASS'; Wave=8; ImplementedApiCount=$apis.Count; RemainingApiNames=$summary.lua.missing_api_name_count }
