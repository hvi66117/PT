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
$dbLoad = Read-Latin1 (Join-Path $ProjectRoot 'Sources\Core\Src\KPlayerDBFuns.cpp')
$registryPath = Join-Path $ProjectRoot 'Deploy\VNG_IBBUFF_REGISTRY.json'
$registry = Get-Content -Raw $registryPath | ConvertFrom-Json
$catalog = Get-Content -Raw (Join-Path $ProjectRoot 'Docs\LUA_API_182_CATALOG.json') | ConvertFrom-Json
$apis = @($catalog.apis | Where-Object wave -eq 4 | ForEach-Object name)

Assert-True ($apis.Count -eq 11) "Wave 4 count mismatch: $($apis.Count)"
foreach ($api in $apis) {
    Assert-Contains $source ('\{"' + [regex]::Escape($api) + '"\s*,') "Wave 4 API is not registered: $api"
    Assert-Contains $source ('int\s+Lua' + [regex]::Escape($api) + 'Compat\s*\(') "Wave 4 implementation is absent: $api"
}

Assert-Contains $dataDef 'TASKVALUE_PT_IBBUFF_BEGIN\s*=\s*4900[\s\S]*TASKVALUE_PT_IBBUFF_END\s*=\s*TASKVALUE_PT_IBBUFF_BEGIN\s*\+\s*95' 'The 48-slot IBBuff persistence range is not locked.'
Assert-Contains $source 'PHONGTHAN_MAX_IBBUFF\s*=\s*48' 'VNG player IBBuff capacity is not 48.'
Assert-Contains $source 'PHONGTHAN_IBBUFF_ID_MASK\s*=\s*0x3fff' 'IBBuff ids above the old 4095 ceiling are still rejected.'
Assert-True ($registry.EntryId -eq '0xFF0CD8FA' -and $registry.MaxBufWnd -eq 48 -and $registry.BuffInfoCount -eq 9999 -and $registry.HighestPopulatedId -eq 9325) 'Locked official VNG IBBuff registry facts changed.'
Assert-True ($registry.SourcePayloadSha256 -eq '9C0ABBD41BD3DE29D59CB6AFB849BEF3E500EDCA9F39689EF9A303BC1702F038') 'Official VNG IBBuff payload hash changed.'
Assert-Contains $source 'PackIBBuffIdentity[\s\S]{0,1300}UnpackIBBuffIdentity' 'IBBuff identity, level and charge persistence is incomplete.'
Assert-Contains $source 'PersistPlayerIBBuffStore[\s\S]{0,1600}TASKVALUE_PT_IBBUFF_BEGIN' 'Player IBBuffs do not persist through the locked task ABI.'
Assert-Contains $dbLoad 'RestorePhongThanIBBuffs\(m_nPlayerIndex\)' 'Player IBBuffs are not restored after the role task payload.'
Assert-Contains $source 'RestorePhongThanIBBuffs[\s\S]{0,1800}dwExpireTime[\s\S]{0,700}ApplyNativeIBBuffState' 'Relog restore does not reject expired buffs and reapply active state.'
Assert-Contains $source 'GetIBBuffDefaultSeconds[\s\S]{0,1000}GetStateAttribs[\s\S]{0,500}GAME_FPS' 'Default duration does not use verified VNG state-skill data.'
Assert-Contains $source 'ApplyNativeIBBuffState[\s\S]{0,1500}CastStateSkill[\s\S]{0,1000}SetStateSkillEffect' 'IBBuffs do not use the native attribute/state synchronization pipeline.'
Assert-True ($source -notmatch '\{"AddIBBuff"\s*,\s*LuaAddSkillState') 'IBBuff was incorrectly aliased to the combat skill-state API.'
Assert-Contains $source 'GetNpcIBBuffStore[\s\S]{0,1700}dwOwnerId[\s\S]{0,700}m_dwID' 'NPC IBBuff storage is not protected against recycled NPC indices.'
Assert-Contains $source 'LuaCostIBBuffCompat[\s\S]{0,1200}nTimes\s*-=\s*nCost[\s\S]{0,500}RemoveIBBuffFromStore' 'CostIBBuff does not atomically consume charges and remove exhausted buffs.'
Assert-Contains $source 'LuaGetIBBuffLeftTimesCompat[\s\S]{0,900}dwExpire[\s\S]{0,300}KSG_GetCurSec' 'Remaining IBBuff time is not derived from authoritative absolute expiry.'

$missing = @(Import-Csv -Delimiter "`t" (Join-Path $AuditRoot 'lua-missing-api.tsv'))
Assert-True (@($apis | Where-Object { $_ -in $missing.name }).Count -eq 0) 'Audit still reports one or more Wave 4 APIs.'
$summary = Get-Content -Raw (Join-Path $AuditRoot 'summary.json') | ConvertFrom-Json
Assert-True ($summary.lua.missing_api_name_count -le 97) "Wave 4 audit count regressed above 97: $($summary.lua.missing_api_name_count)"
Assert-True ($summary.integrity.invalid -eq 0 -and $summary.lua.missing_callback_group_count -eq 0) 'Integrity or callback gate regressed.'

[pscustomobject]@{ Status='PASS'; Wave=4; ImplementedApiCount=$apis.Count; RemainingApiNames=$summary.lua.missing_api_name_count }
