[CmdletBinding()]
param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = 'Stop'
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
$coreRoot = Join-Path $ProjectRoot 'Sources\Core\Src'
$failures = New-Object System.Collections.Generic.List[string]

function Read-Source([string]$Relative) {
    $path = Join-Path $coreRoot $Relative
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        throw "Thieu source: $path"
    }
    return [Text.Encoding]::GetEncoding(1252).GetString([IO.File]::ReadAllBytes($path))
}

$bpt = Read-Source 'KBasPropTbl.CPP'
$core = Read-Source 'KCore.cpp'
$clientShell = Read-Source 'CoreShell.cpp'
$serverShell = Read-Source 'CoreServerShell.cpp'
$player = Read-Source 'KPlayer.cpp'
$names = Read-Source 'CoreUseNameDef.h'

if ($bpt -notmatch 'nVersion\s*==\s*ITEM_VERSION') {
    $failures.Add('Loader khong khoa itemversion.ini vao ITEM_VERSION.')
}
if ($bpt -match 'g_UnitePathAndName\s*\(\s*TABFILE_PATH') {
    $failures.Add('Loader con fallback sang settings\item flat path.')
}
if ($bpt -match 'return\s*\(\s*nLoadedTables\s*>\s*0\s*\)') {
    $failures.Add('KLibOfBPT con chap nhan mot phan item registry.')
}
if ($bpt -notmatch 'required tables loaded') {
    $failures.Add('KLibOfBPT khong co gate bang item bat buoc.')
}
if ($core -notmatch 'if\s*\(\s*!ItemGen\.Init\(\)\s*\)') {
    $failures.Add('Core khong chan loi ItemGen.Init().')
}
if ($clientShell -notmatch 'if\s*\(\s*!g_InitCore\(\)\s*\)\s*return NULL') {
    $failures.Add('CoreGetShell khong fail-closed.')
}
if ($serverShell -notmatch 'if\s*\(\s*!g_InitCore\(\)\s*\)\s*return NULL') {
    $failures.Add('CoreGetServerShell khong fail-closed.')
}
if ($player -match 'MAGICSCRIPT_TABFILE|GuideTable\.Load|MagicTable\.Load') {
    $failures.Add('KPlayer con tu parse/fallback MagicScript ngoai ItemGen.')
}
if ($names -match '(EVENTITEM|QUESTITEM|TOWNPORTAL|MAGICSCRIPT)_TABFILE') {
    $failures.Add('CoreUseNameDef con khai bao item flat path cu.')
}

if ($failures.Count) {
    $failures | ForEach-Object { Write-Error $_ }
    exit 1
}

[pscustomobject]@{
    Result = 'PASS'
    Policy = 'Item registry fail-closed'
    ActiveVersion = 'ITEM_VERSION'
    FlatPathFallbacks = 0
    PlayerMagicScriptFallbacks = 0
    PartialCoreShells = 0
}
