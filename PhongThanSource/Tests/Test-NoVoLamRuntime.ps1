[CmdletBinding()]
param(
    [string]$RuntimeRoot,
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = 'Stop'
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
if (-not $RuntimeRoot) {
    $RuntimeRoot = Join-Path (Split-Path -Parent $ProjectRoot) 'PhongThanRuntime-Staging'
}
$RuntimeRoot = [IO.Path]::GetFullPath($RuntimeRoot).TrimEnd('\')
$failures = [Collections.Generic.List[string]]::new()
$clientRoot = Join-Path $RuntimeRoot 'Client'
$serverRoot = Join-Path $RuntimeRoot 'Server'
$cp936 = [Text.Encoding]::GetEncoding(936)

foreach ($obsolete in @(
    (Join-Path $serverRoot 'Skills.txt'),
    (Join-Path $serverRoot 'copyright.jpg'),
    (Join-Path $ProjectRoot 'Sources\GameClient\VLTK.ICO'),
    (Join-Path $ProjectRoot 'Sources\S3Client')
)) {
    if (Test-Path -LiteralPath $obsolete) { $failures.Add("Con file Vo Lam: $obsolete") }
}

$legacyPattern = '(?i)volamviet|vltk|jxonline|swordonline|anhvietdongnai|tongkim|shaolin|wudang|gaibang|tangmen'
foreach ($roleRoot in $clientRoot, $serverRoot) {
    foreach ($relative in @(
        'script\gmscript.lua',
        'script\serverscript.lua',
        'script\servertimer.lua',
        'script\global\script_protocol.lua'
    )) {
        $bootstrap = Join-Path $roleRoot $relative
        if (-not (Test-Path -LiteralPath $bootstrap -PathType Leaf)) {
            $failures.Add("Thieu Phong Than Lua bootstrap: $bootstrap")
            continue
        }
        $bootstrapText = [IO.File]::ReadAllText($bootstrap, $cp936)
        if ($bootstrapText -match $legacyPattern) {
            $failures.Add("Lua bootstrap con noi dung Vo Lam: $bootstrap")
        }
        if ($relative -ne 'script\global\script_protocol.lua' -and
            $bootstrapText -notmatch '(?m)^function\s+main\s*\(\s*\)') {
            $failures.Add("Lua bootstrap thieu main(): $bootstrap")
        }
    }
}

$clientSkills = Join-Path $clientRoot 'settings\Skills.txt'
$serverSkills = Join-Path $serverRoot 'settings\Skills.txt'
foreach ($skills in $clientSkills, $serverSkills) {
    if (-not (Test-Path -LiteralPath $skills -PathType Leaf)) {
        $failures.Add("Thieu Skills Phong Than: $skills")
        continue
    }
    $skillsText = [IO.File]::ReadAllText($skills, $cp936)
    if ($skillsText -match '(?i)script\\skill\\(cuiyan|emei|gaibang|huashan|kunlun|shaolin|tangmen|tianren|tianwang|wudang|wudu)\.lua') {
        $failures.Add("Bang Skills active con he phai Vo Lam: $skills")
    }
}
if ((Test-Path -LiteralPath $clientSkills) -and (Test-Path -LiteralPath $serverSkills) -and
    (Get-FileHash -LiteralPath $clientSkills -Algorithm SHA256).Hash -ne
    (Get-FileHash -LiteralPath $serverSkills -Algorithm SHA256).Hash) {
    $failures.Add('Skills Phong Than client/server khong dong bo byte-for-byte.')
}

$versionPath = Join-Path $clientRoot 'version.xml'
if (-not (Test-Path -LiteralPath $versionPath -PathType Leaf)) {
    $failures.Add("Thieu version.xml moi: $versionPath")
}
else {
    [xml]$version = Get-Content -LiteralPath $versionPath -Raw
    $items = @($version.Autoupdate.Item)
    if (-not $items.Count) { $failures.Add('version.xml khong co entry.') }
    foreach ($item in $items) {
        $relative = [string]$item.Path
        if ($relative -match $legacyPattern -or $relative -match '(?i)script[\\/]skill[\\/](cuiyan|emei|gaibang|huashan|kunlun|shaolin|tangmen|tianren|tianwang|wudang|wudu)\.lua') {
            $failures.Add("version.xml con tham chieu Vo Lam: $relative")
            continue
        }
        if ([IO.Path]::IsPathRooted($relative) -or $relative -match '(^|[\\/])\.\.([\\/]|$)') {
            $failures.Add("version.xml co duong dan khong an toan: $relative")
            continue
        }
        $fullPath = [IO.Path]::GetFullPath((Join-Path $clientRoot $relative))
        if (-not $fullPath.StartsWith($clientRoot + '\', [StringComparison]::OrdinalIgnoreCase) -or
            -not (Test-Path -LiteralPath $fullPath -PathType Leaf)) {
            $failures.Add("version.xml tro toi file khong ton tai: $relative")
            continue
        }
        $file = Get-Item -LiteralPath $fullPath
        if ([long]$item.Size -ne $file.Length) { $failures.Add("version.xml sai size: $relative") }
        if ([string]$item.Hash -ne (Get-FileHash -LiteralPath $fullPath -Algorithm MD5).Hash) {
            $failures.Add("version.xml sai MD5: $relative")
        }
    }
}

$buildProject = Join-Path $ProjectRoot 'Sources\GameClient\PhongThanClient.dsp'
if ((Test-Path -LiteralPath $buildProject) -and
    [IO.File]::ReadAllText($buildProject) -match '(?i)VLTK\.ICO') {
    $failures.Add("Project client con tham chieu VLTK.ICO: $buildProject")
}

if ($failures.Count) {
    $failures | Select-Object -Unique | ForEach-Object { Write-Error $_ }
    exit 1
}

[pscustomobject]@{
    Result = 'PASS'
    RuntimeRoot = $RuntimeRoot
    VersionEntries = @($version.Autoupdate.Item).Count
    LegacyRuntimeFiles = 0
    LegacyGameplayReferences = 0
}
