[CmdletBinding()]
param([string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot))

$ErrorActionPreference = 'Stop'
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
$coreRoot = Join-Path $ProjectRoot 'Sources\Core\Src'
$failures = New-Object System.Collections.Generic.List[string]
function Read-Source([string]$Name) {
    return [Text.Encoding]::GetEncoding(28591).GetString(
        [IO.File]::ReadAllBytes((Join-Path $script:coreRoot $Name)))
}
function Require-Text([string]$Text, [string]$Pattern, [string]$Message) {
    if ($Text.IndexOf($Pattern, [StringComparison]::Ordinal) -lt 0) { $script:failures.Add($Message) }
}
function Forbid-Text([string]$Text, [string]$Pattern, [string]$Message) {
    if ($Text.IndexOf($Pattern, [StringComparison]::Ordinal) -ge 0) { $script:failures.Add($Message) }
}

$names = Read-Source 'CoreUseNameDef.h'
$core = Read-Source 'KCore.cpp'
$region = Read-Source 'KRegion.cpp'
$worldSet = Read-Source 'KSubWorldSet.cpp'
$sortScript = Read-Source 'KSortScript.cpp'

Require-Text $names '"\\settings\\phongthan\\Npcs.txt"' 'NPC loader khong tro settings\phongthan\Npcs.txt.'
Forbid-Text $names 'NpcS.txt' 'CoreUseNameDef con alias NpcS.txt.'
Require-Text $core 'g_OrdinSkillsSetting.Load(SKILL_SETTING_FILE)' 'Skill loader chua dung logical path PAK-first.'
Require-Text $core 'g_NpcSetting.Load(NPC_SETTING_FILE)' 'NPC loader chua dung logical path PAK-first.'
Forbid-Text $core 'GetLooseRuntimeFilePath("settings\\Npcs.txt"' 'NPC loader con flat-path chi khac alias o chu hoa/thuong.'
Require-Text $core 'g_OrdinSkillsSetting.GetWidth() < 99' 'Skill loader khong gate schema 99 cot.'
Require-Text $core 'g_NpcSetting.GetWidth() < 122' 'NPC loader khong gate schema 122 cot.'
Require-Text $core 'if (!g_SubWorldSet.Load("\\maps\\WorldSet.ini"))' 'Core bo qua loi server WorldSet.'
Require-Text $core 'if (!g_SubWorldSet.LoadFile())' 'Core bo qua loi world metadata.'

$serverStart = $region.IndexOf('BOOL KRegion::LoadObject(int nSubWorld, int nX, int nY)', [StringComparison]::Ordinal)
$serverEnd = $region.IndexOf('#endif', $serverStart, [StringComparison]::Ordinal)
if ($serverStart -lt 0 -or $serverEnd -le $serverStart) {
    $failures.Add('Khong tach duoc server KRegion::LoadObject.')
}
else {
    $serverRegionLoader = $region.Substring($serverStart, $serverEnd - $serverStart)
    Require-Text $serverRegionLoader '"\\%s_S\\v_%03d"' 'Server loader thieu layout <map>_S.'
    Require-Text $serverRegionLoader '"\\%s\\v_%03d"' 'Server loader thieu layout VNG cung thu muc.'
    Forbid-Text $serverRegionLoader 'REGION_COMBIN_FILE_NAME_CLIENT' 'Server con fallback Region_S sang Region_C.'
}
Require-Text $worldSet 'return FALSE;' 'WorldSet loader khong the bao loi.'
Require-Text $sortScript 'script_registry_diag.log' 'Lua loader chua thong ke registry.'
Require-Text $sortScript 'g_nScriptLoadFailures++' 'Lua loader chua dem loi nap.'

$deploy = Get-Content -LiteralPath (Join-Path $ProjectRoot 'Deploy\New-RuntimeContentStore.ps1') -Raw
Require-Text $deploy 'Remove-LegacyGameplayContent' 'Deploy chua loai gameplay alias/PAK cu.'
$pakFile = [Text.Encoding]::GetEncoding(28591).GetString(
    [IO.File]::ReadAllBytes((Join-Path $ProjectRoot 'Sources\Engine\Src\KPakFile.cpp')))
Require-Text $pakFile 'g_pPakList->FindElemFile' 'KPakFile chua ho tro PAK cho server.'
Require-Text $core 'g_PakList.Open("\\package.ini")' 'CoreServer chua mo VNG package.ini.'
Require-Text $core 'g_SetPakFileMode(1)' 'CoreServer chua bat PAK-first.'

if ($failures.Count) {
    $failures | ForEach-Object { Write-Error $_ }
    exit 1
}
[pscustomobject]@{
    Result = 'PASS'
    NpcPath = 'settings\phongthan\Npcs.txt'
    SkillFallback = 0
    NpcFallback = 0
    RegionCFallback = 0
    ServerRegionLayouts = 2
    MapErrorsIgnored = 0
    LuaDiagnostics = 1
}
