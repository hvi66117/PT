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
$AuditRoot = [IO.Path]::GetFullPath($AuditRoot)

function Assert-True([bool]$Condition, [string]$Message) {
    if (-not $Condition) { throw $Message }
}

function Read-Latin1([string]$Path) {
    [Text.Encoding]::GetEncoding(28591).GetString([IO.File]::ReadAllBytes($Path))
}

function Assert-Contains([string]$Text, [string]$Pattern, [string]$Message) {
    if ($Text -notmatch $Pattern) { throw $Message }
}

$scriptFuns = Read-Latin1 (Join-Path $ProjectRoot 'Sources\Core\Src\ScriptFuns.cpp')
$playerDef = Read-Latin1 (Join-Path $ProjectRoot 'Sources\Core\Src\KPlayerDef.h')
$playerHeader = Read-Latin1 (Join-Path $ProjectRoot 'Sources\Core\Src\KPlayer.h')
$coreShell = Read-Latin1 (Join-Path $ProjectRoot 'Sources\Core\Src\CoreShell.h')
$player = Read-Latin1 (Join-Path $ProjectRoot 'Sources\Core\Src\KPlayer.cpp')
$uiNotify = Read-Latin1 (Join-Path $ProjectRoot 'Sources\GameClient\Ui\GameSpaceChangedNotify.cpp')

$implemented = @(
    'TopMessage', 'ScrollMessage', 'CloseDialog', 'AddGlobalNews',
    'AddGlobalCountNews', 'WriteLog', 'LocalSystemTime', 'SystemTime',
    'GetGlobalValue', 'SetGlobalValue'
)
foreach ($api in $implemented) {
    Assert-Contains $scriptFuns ('\{"' + [regex]::Escape($api) + '"\s*,') "Lua API is not registered: $api"
}

Assert-Contains $scriptFuns 'int\s+LuaTopMessage[\s\S]{0,180}UI_TOPMESSAGE' 'TopMessage is not routed to its dedicated top channel.'
Assert-Contains $scriptFuns 'int\s+LuaScrollMessage[\s\S]{0,180}UI_SCROLLMESSAGE' 'ScrollMessage is not routed to the scrolling-news channel.'
Assert-Contains $scriptFuns '\{"AddGlobalNews"\s*,\s*LuaAddGlobalNews\}' 'AddGlobalNews does not use the existing global broadcaster.'
Assert-Contains $scriptFuns '\{"AddGlobalCountNews"\s*,\s*LuaAddGlobalCountNews\}' 'AddGlobalCountNews does not use the existing counted broadcaster.'
Assert-Contains $scriptFuns 'LuaAddGlobalNews[\s\S]{0,180}ZeroMemory\(&UiInfo' 'AddGlobalNews packet is not zero-initialized.'
Assert-Contains $scriptFuns 'LuaAddGlobalCountNews[\s\S]{0,180}ZeroMemory\(&UiInfo' 'AddGlobalCountNews packet is not zero-initialized.'

Assert-Contains $playerDef 'SCRIPTACTION_UISHOW[\s\S]{0,180}SCRIPTACTION_EXESCRIPT[\s\S]{0,180}SCRIPTACTION_CLOSEDIALOG' 'CloseDialog changed or bypassed the append-only script-action order.'
Assert-Contains $playerHeader 'UI_OPENTONGUI[\s\S]{0,180}UI_TOPMESSAGE[\s\S]{0,100}UI_SCROLLMESSAGE' 'Phong Than UI IDs are not append-only.'
Assert-Contains $coreShell 'GDCNI_PROGRESS_BAR[\s\S]{0,240}GDCNI_CLOSE_DIALOG[\s\S]{0,100}GDCNI_TOP_MESSAGE' 'Phong Than UI callback IDs are not append-only.'
Assert-Contains $player 'case\s+SCRIPTACTION_CLOSEDIALOG[\s\S]{0,300}GDCNI_CLOSE_DIALOG' 'Client core does not decode CloseDialog.'
Assert-Contains $player 'case\s+UI_TOPMESSAGE[\s\S]{0,1800}GDCNI_TOP_MESSAGE' 'Client core does not decode TopMessage.'
Assert-Contains $player 'case\s+UI_SCROLLMESSAGE[\s\S]{0,1800}GDCNI_NEWS_MESSAGE' 'Client core does not decode ScrollMessage as scrolling news.'
Assert-Contains $uiNotify 'case\s+GDCNI_CLOSE_DIALOG[\s\S]{0,300}KUiMsgSel::CloseWindow[\s\S]{0,300}g_UiInformation2\.Close' 'UI layer does not close every NPC dialog surface.'
Assert-Contains $uiNotify 'case\s+GDCNI_TOP_MESSAGE[\s\S]{0,500}KUiNewsSysMsg::OpenWindow[\s\S]{0,300}MessageArrival' 'UI layer does not display the dedicated top message.'

Assert-Contains $scriptFuns 'int\s+LuaSystemTime[\s\S]{0,180}time\(&rawtime\)[\s\S]{0,120}Lua_PushNumber' 'SystemTime is not Unix epoch seconds.'
Assert-Contains $scriptFuns 'int\s+LuaLocalSystemTime[\s\S]{0,900}localtime\(&rawtime\)[\s\S]{0,900}gmtime\(&rawtime\)[\s\S]{0,900}difftime\(' 'LocalSystemTime does not apply the local UTC offset.'
Assert-Contains $scriptFuns 'LuaGetGlobalValue[\s\S]{0,300}nIndex\s*>=\s*0\s*&&\s*nIndex\s*<\s*TASKGLOBALVALUENUM[\s\S]{0,120}g_TaskGlobalValue\[nIndex\]' 'GetGlobalValue has no bounded global registry access.'
Assert-Contains $scriptFuns 'LuaSetGlobalValue[\s\S]{0,300}nIndex\s*>=\s*0\s*&&\s*nIndex\s*<\s*TASKGLOBALVALUENUM[\s\S]{0,120}g_TaskGlobalValue\[nIndex\]' 'SetGlobalValue has no bounded global registry access.'
Assert-Contains $scriptFuns 'fopen\("script_runtime\.log",\s*"a\+b"\)[\s\S]{0,700}fprintf\(pLog,\s*"[^\"]*%s' 'WriteLog is not an append-only fixed-format log sink.'
Assert-True ($scriptFuns -notmatch 'fprintf\(pLog,\s*pszMessage') 'WriteLog uses script text as a format string.'

$summaryPath = Join-Path $AuditRoot 'summary.json'
$missingPath = Join-Path $AuditRoot 'lua-missing-api.tsv'
Assert-True (Test-Path -LiteralPath $summaryPath) "Missing Lua audit summary: $summaryPath"
Assert-True (Test-Path -LiteralPath $missingPath) "Missing Lua API gap report: $missingPath"
$summary = Get-Content -Raw -LiteralPath $summaryPath | ConvertFrom-Json
$missing = @(Import-Csv -Delimiter "`t" -LiteralPath $missingPath)
$missingNames = @($missing | ForEach-Object name)

Assert-True ($summary.integrity.invalid -eq 0) 'Validated Lua payload integrity failed.'
Assert-True ($summary.lua.missing_callback_group_count -eq 0) 'Lua callback compatibility regressed.'
Assert-True ($summary.lua.engine_api_count -ge 528) "Engine API registry did not reach 528: $($summary.lua.engine_api_count)"
Assert-True ($summary.lua.missing_api_name_count -le 186) "P0.3.3 API gap count did not fall to 186 or lower: $($summary.lua.missing_api_name_count)"
foreach ($api in $implemented) {
    Assert-True ($missingNames -notcontains $api) "Audit still reports implemented API as missing: $api"
}
Assert-True ($missingNames -notcontains 'TaskNote') 'TaskNote Wave 5 port regressed.'

[pscustomobject]@{
    Status = 'PASS'
    ImplementedApiCount = $implemented.Count
    CoveredEntryReferences = 647
    EngineApiCount = $summary.lua.engine_api_count
    RemainingApiNames = $summary.lua.missing_api_name_count
    CallbackGaps = $summary.lua.missing_callback_group_count
    TaskNote = 'ported-ui-noteinfo-contract'
}
