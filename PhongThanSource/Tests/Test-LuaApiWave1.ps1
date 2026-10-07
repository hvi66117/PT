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

$scriptFuns = Read-Latin1 (Join-Path $ProjectRoot 'Sources\Core\Src\ScriptFuns.cpp')
$playerSetH = Read-Latin1 (Join-Path $ProjectRoot 'Sources\Core\Src\KPlayerSet.h')
$playerSetCpp = Read-Latin1 (Join-Path $ProjectRoot 'Sources\Core\Src\KPlayerSet.cpp')
$playerH = Read-Latin1 (Join-Path $ProjectRoot 'Sources\Core\Src\KPlayer.h')
$playerCpp = Read-Latin1 (Join-Path $ProjectRoot 'Sources\Core\Src\KPlayer.cpp')
$catalog = Get-Content -Raw (Join-Path $ProjectRoot 'Docs\LUA_API_182_CATALOG.json') | ConvertFrom-Json
$waveApis = @($catalog.apis | Where-Object wave -eq 1 | ForEach-Object name)
Assert-True ($waveApis.Count -eq 26) "Wave 1 catalog count is not 26: $($waveApis.Count)"
foreach ($api in $waveApis) {
    Assert-Contains $scriptFuns ('\{"' + [regex]::Escape($api) + '"\s*,') "Wave 1 API is not registered: $api"
}

Assert-Contains $scriptFuns 'GetGlobalValueSlot[\s\S]{0,500}nOrdinal\s*<\s*1[\s\S]{0,100}nOrdinal\s*>\s*nOrdinalMax' 'Global byte/word ordinal bounds are missing.'
Assert-Contains $scriptFuns 'LuaGetGlobalValueByteCompat[\s\S]{0,500}&\s*0xff' 'GetGlobalValueByte does not mask one byte.'
Assert-Contains $scriptFuns 'LuaSetGlobalValueWordCompat[\s\S]{0,700}0xffffU\s*<<\s*nShift' 'SetGlobalValueWord does not replace a bounded word.'
Assert-Contains $scriptFuns 'LuaPCallCompat[\s\S]{0,900}Lua_Call\(L,\s*nArgs,\s*LUA_MULTRET\)[\s\S]{0,400}Lua_InsertValue\(L,\s*1\)' 'pcall is not a protected multi-result wrapper.'
Assert-Contains $scriptFuns 'LuaIPairsIteratorCompat[\s\S]{0,700}Lua_RawGetI\(L,\s*1,\s*nOrdinal\)[\s\S]{0,300}return\s+2' 'ipairs does not implement sequential raw iteration.'
Assert-Contains $scriptFuns 'LuaIPairsCompat[\s\S]{0,400}Lua_PushCFunction[\s\S]{0,200}Lua_PushValue\(L,\s*1\)[\s\S]{0,200}Lua_PushNumber\(L,\s*0\)' 'ipairs does not return iterator, table and initial cursor.'
Assert-Contains $playerSetH 'GetNextPlayerFrom\(int nCursor\)' 'Re-entrant player cursor is missing from KPlayerSet.'
Assert-Contains $playerSetCpp 'GetNextPlayerFrom[\s\S]{0,260}m_UseIdx\.GetNext\(nCursor\)' 'Player cursor does not use the authoritative active-player set.'
Assert-Contains $scriptFuns 'LuaSearchPlayerByIdCompat[\s\S]{0,280}PlayerSet\.FindSame\(dwPlayerId\)' 'SearchPlayerById does not search player IDs.'
Assert-Contains $scriptFuns 'LuaGetSubWorldPlayerCountCompat[\s\S]{0,900}Npc\[nNpcIndex\]\.m_SubWorldIndex\s*==\s*nSubWorldIndex' 'Subworld player enumeration is not map-scoped.'
Assert-Contains $scriptFuns 'LuaGetSessionNextPlayerCompat[\s\S]{0,1400}PlayerSet\.GetNextPlayerFrom\(nCursor\)' 'Session enumeration does not advance from its cursor.'
Assert-Contains $scriptFuns 'SendMapAnnouncement[\s\S]{0,1000}MESSAGE_BROADCAST_ANNOUCE_HEAD' 'Map announcements do not use the announcement channel.'
Assert-Contains $scriptFuns 'LuaMsgBoxCompat[\s\S]{0,1700}OK/%s[\s\S]{0,300}Cancel/%s[\s\S]{0,300}LuaSelectUI' 'MsgBox callbacks are not routed through the real select-dialog path.'
Assert-Contains $scriptFuns 'LuaNpcChat[\s\S]{0,450}nNpcIndex\s*>\s*0\s*&&\s*nNpcIndex\s*<\s*MAX_NPC' 'NpcSay/NpcChat keeps the invalid OR bounds bug.'
Assert-Contains $playerH 'm_nLastNpcIndex[\s\S]{0,200}Last dialog NPC on both server and client' 'Dialog NPC identity is not shared by client and server builds.'
Assert-Contains $playerCpp 'KPlayer::DialogNpc\(BYTE \* pProtocol\)[\s\S]{0,500}m_nLastNpcIndex\s*=\s*nIdx' 'Server does not retain the dialog NPC before executing Lua.'

$missing = @(Import-Csv -Delimiter "`t" (Join-Path $AuditRoot 'lua-missing-api.tsv'))
$remainingWave1 = @($waveApis | Where-Object { $_ -in $missing.name })
Assert-True ($remainingWave1.Count -eq 0) "Audit still reports Wave 1 APIs: $($remainingWave1 -join ', ')"
$summary = Get-Content -Raw (Join-Path $AuditRoot 'summary.json') | ConvertFrom-Json
Assert-True ($summary.integrity.invalid -eq 0) 'Payload integrity regressed.'
Assert-True ($summary.lua.missing_callback_group_count -eq 0) 'Callback gap regressed.'
Assert-True ($summary.lua.missing_api_name_count -le 156) "Wave 1 gap regressed above 156: $($summary.lua.missing_api_name_count)"

[pscustomobject]@{
    Status = 'PASS'
    Wave = 1
    ImplementedApiCount = $waveApis.Count
    RemainingApiNames = $summary.lua.missing_api_name_count
    CallbackGaps = $summary.lua.missing_callback_group_count
}
