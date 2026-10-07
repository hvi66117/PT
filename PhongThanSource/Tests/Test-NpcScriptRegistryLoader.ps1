[CmdletBinding()]
param(
    [string]$SourceRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$NpcTable
)

$ErrorActionPreference = 'Stop'
$SourceRoot = [IO.Path]::GetFullPath($SourceRoot)
if (-not $NpcTable) {
    $projectRoot = Split-Path -Parent $SourceRoot
    $NpcTable = Join-Path $projectRoot 'PhongThanRuntime-Staging\Server\settings\phongthan\Npcs.txt'
}
$NpcTable = [IO.Path]::GetFullPath($NpcTable)

function Assert-True([bool]$Condition, [string]$Message) {
    if (-not $Condition) { throw $Message }
}

function Assert-Contains([string]$Path, [string]$Pattern, [string]$Message) {
    $text = [IO.File]::ReadAllText($Path, [Text.Encoding]::GetEncoding(1252))
    if ($text -notmatch $Pattern) { throw $Message }
}

Assert-True (Test-Path -LiteralPath $NpcTable) "Missing VNG NPC registry: $NpcTable"
$header = [IO.File]::ReadLines($NpcTable) | Select-Object -First 1
$columns = $header.Split([char]9)
$requiredColumns = @(
    'ActionScript', 'LevelScript', 'DeathScript', 'TimerScript', 'TimerValue',
    'ExpParam', 'ExpParam1', 'ExpParam2', 'ExpParam3',
    'LifeParam', 'LifeParam1', 'LifeParam2', 'LifeParam3'
)
Assert-True ($columns.Count -ge 122) "VNG Npcs.txt must expose at least 122 columns; found $($columns.Count)."
foreach ($column in $requiredColumns) {
    Assert-True ($columns -contains $column) "VNG Npcs.txt is missing column: $column"
}

$template = Join-Path $SourceRoot 'Sources\Core\Src\KNpcTemplate.cpp'
$npc = Join-Path $SourceRoot 'Sources\Core\Src\KNpc.cpp'
$npcSet = Join-Path $SourceRoot 'Sources\Core\Src\KNpcSet.cpp'
$scriptFuns = Join-Path $SourceRoot 'Sources\Core\Src\ScriptFuns.cpp'

foreach ($column in 'ActionScript', 'LevelScript', 'DeathScript', 'TimerScript', 'TimerValue') {
    Assert-Contains $template ('"' + [regex]::Escape($column) + '"') "KNpcTemplate does not load $column."
}
Assert-Contains $npc 'GetNpcKeyData' 'NPC key data is not evaluated through LevelScript.'
Assert-Contains $npc 'GetNpcLevelData' 'NPC skill levels are not evaluated through LevelScript.'
Assert-Contains $npc 'ResolveNpcSkillId' 'VNG symbolic Skill1..Skill4 names are not resolved through Skills.txt.'
Assert-Contains $npc '"OnDeath"' 'DeathScript is not dispatched through OnDeath.'
Assert-Contains $npc '"OnTimer"' 'TimerScript is not dispatched through OnTimer.'
Assert-Contains $npc 'kind_dialoger[\s\S]{0,300}NpcScriptDefinesFunction' 'Kind=3 DeathScript/main compatibility is absent.'
Assert-Contains $npcSet 'm_nNpcTimerValue \* GAME_FPS' 'TimerValue is not converted from VNG seconds to engine ticks.'
Assert-Contains $npcSet 'empty Region_S action script' 'Region_S empty action scripts can erase the template script.'
Assert-Contains $scriptFuns '\{"SetNpcTimer"' 'SetNpcTimer is not registered in the Lua API.'

[pscustomobject]@{
    Status = 'PASS'
    NpcTable = $NpcTable
    ColumnCount = $columns.Count
    Loader = 'Action/Level/Death/Timer'
    Callbacks = 'main/OnDeath/OnTimer'
}
