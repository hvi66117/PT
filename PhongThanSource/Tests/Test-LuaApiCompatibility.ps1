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
$gameData = Read-Latin1 (Join-Path $ProjectRoot 'Sources\Core\Src\GameDataDef.h')
$taskFuns = Read-Latin1 (Join-Path $ProjectRoot 'Sources\Core\Src\KTaskFuns.h')
$playerDb = Read-Latin1 (Join-Path $ProjectRoot 'Sources\Core\Src\KPlayerDBFuns.cpp')

$implemented = @(
    'GetTaskByte', 'SetTaskByte', 'GetTaskWord', 'SetTaskWord',
    'GetTaskBit', 'SetTaskBit', 'GetTeamMember', 'GetNpcWorldPos',
    'GetPlayerID', 'GetNpcTask', 'SetNpcTask'
)
foreach ($api in $implemented) {
    Assert-Contains $scriptFuns ('\{"' + [regex]::Escape($api) + '"\s*,') "Lua API is not registered: $api"
}

Assert-Contains $gameData '#define\s+MAX_TASK\s+5000\b' 'Phong Than sparse task ID range is not enabled.'
Assert-Contains $taskFuns '#define\s+MAX_TASK_SCRIPTFUNC\s+5000\b' 'Lua task gate still rejects VNG task IDs.'
Assert-Contains $gameData '#define\s+MAX_NPCPARAM\s+16\b' 'NPC task slots do not cover the audited VNG range 0..10.'
Assert-Contains $scriptFuns 'nOrdinal\s*==\s*1[\s\S]{0,120}m_nCaptain' 'GetTeamMember(1) does not resolve the captain.'
Assert-Contains $scriptFuns 'nOrdinal\s*-\s*2[\s\S]{0,100}m_nMember\[nOrdinal\s*-\s*2\]' 'GetTeamMember does not map VNG member ordinals.'
Assert-Contains $scriptFuns 'nByteNo\s*>=\s*1\s*&&\s*nByteNo\s*<=\s*4' 'Task byte bounds are missing.'
Assert-Contains $scriptFuns 'nWordNo\s*>=\s*1\s*&&\s*nWordNo\s*<=\s*2' 'Task word bounds are missing.'
Assert-Contains $scriptFuns 'nBitNo\s*>=\s*1\s*&&\s*nBitNo\s*<=\s*32' 'Task bit bounds are missing.'
Assert-Contains $scriptFuns 'nParamIndex\s*<\s*0\s*\|\|\s*nParamIndex\s*>=\s*MAX_NPCPARAM' 'NPC task slot bounds are missing.'
Assert-Contains $playerDb 'nTaskCount\s*>=\s*255' 'Database task-count ABI overflow guard is missing.'

$summaryPath = Join-Path $AuditRoot 'summary.json'
$missingPath = Join-Path $AuditRoot 'lua-missing-api.tsv'
Assert-True (Test-Path -LiteralPath $summaryPath) "Missing Lua audit summary: $summaryPath"
Assert-True (Test-Path -LiteralPath $missingPath) "Missing Lua API gap report: $missingPath"
$summary = Get-Content -Raw -LiteralPath $summaryPath | ConvertFrom-Json
$missing = @(Import-Csv -Delimiter "`t" -LiteralPath $missingPath)
$missingNames = @($missing | ForEach-Object name)

Assert-True ($summary.integrity.invalid -eq 0) 'Validated Lua payload integrity failed.'
Assert-True ($summary.lua.missing_callback_group_count -eq 0) 'Lua callback compatibility regressed.'
Assert-True ($summary.lua.missing_api_name_count -le 196) "P0 API gap count did not fall to 196 or lower: $($summary.lua.missing_api_name_count)"
foreach ($api in $implemented) {
    Assert-True ($missingNames -notcontains $api) "Audit still reports implemented API as missing: $api"
}

# Wave 5 recovered the call contract and projects it through UI_NOTEINFO while
# preserving the task id, step and dynamic template arguments.
Assert-True ($missingNames -notcontains 'TaskNote') 'TaskNote is still missing after the Wave 5 contract port.'
Assert-True (Test-Path (Join-Path $ProjectRoot 'Deploy\VNG_TASK_NOTE_CONTRACT.json')) 'TaskNote contract manifest is absent.'

[pscustomobject]@{
    Status = 'PASS'
    ImplementedApiCount = $implemented.Count
    CoveredEntryReferences = 815
    RemainingApiNames = $summary.lua.missing_api_name_count
    CallbackGaps = $summary.lua.missing_callback_group_count
    TaskNote = 'ported-ui-noteinfo-contract'
}
