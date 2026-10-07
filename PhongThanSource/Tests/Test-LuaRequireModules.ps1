[CmdletBinding()]
param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$DataRoot
)

$ErrorActionPreference = 'Stop'
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
if (-not $DataRoot) {
    $DataRoot = Join-Path (Split-Path -Parent $ProjectRoot) 'PhongThanRuntime-Content'
}
$DataRoot = [IO.Path]::GetFullPath($DataRoot).TrimEnd('\')
$catalogPath = Join-Path $ProjectRoot 'Deploy\LUA_REQUIRE_MODULES.tsv'
$provenancePath = Join-Path $ProjectRoot 'Docs\LUA_REQUIRE_MODULE_PROVENANCE.json'
$sourceRoot = Join-Path $ProjectRoot 'gameserver\script\common'
$engineSource = Join-Path $ProjectRoot 'Sources\Engine\Src\KLuaScript.cpp'
foreach ($required in $catalogPath, $provenancePath, $sourceRoot, $engineSource) {
    if (-not (Test-Path -LiteralPath $required)) { throw "Thieu Lua require dependency: $required" }
}

[Text.Encoding]::RegisterProvider([Text.CodePagesEncodingProvider]::Instance)
$gbk = [Text.Encoding]::GetEncoding(936)
$runtimeEncoding = [Text.Encoding]::GetEncoding(1252)
function Convert-ToRuntimeSegment([string]$Value) {
    return $runtimeEncoding.GetString($gbk.GetBytes($Value))
}
function Convert-ToRuntimeRelative([string]$Value) {
    return (($Value.Replace('/', '\') -split '\\' | ForEach-Object {
        Convert-ToRuntimeSegment $_
    }) -join '\')
}

$catalog = @(Import-Csv -LiteralPath $catalogPath -Delimiter "`t")
if ($catalog.Count -ne 41) { throw "Lua require catalog phai co 41 module, hien co $($catalog.Count)." }
$logicalSet = [Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
foreach ($row in $catalog) {
    if (-not $logicalSet.Add([string]$row.logical_path)) {
        throw "Lua require catalog trung path: $($row.logical_path)"
    }
    if ([string]$row.policy -ne 'vng-original') {
        throw "Lua require module khong co policy vng-original: $($row.logical_path)"
    }
}

$provenance = Get-Content -LiteralPath $provenancePath -Raw | ConvertFrom-Json
if (@($provenance.failures).Count -ne 0 -or @($provenance.files).Count -ne 41) {
    throw 'Lua require provenance khong chung minh du 41/41 payload.'
}
$hashByLogical = @{}
foreach ($record in @($provenance.files)) {
    $logical = [string]$record.logical_path
    if (-not $logicalSet.Contains($logical)) { throw "Provenance ngoai catalog: $logical" }
    if ([string]$record.provenance -ne 'pak_entry' -or
        [string]$record.validation_status -ne 'pass') {
        throw "Provenance khong hop le: $logical"
    }
    $hashByLogical[$logical] = [string]$record.output_sha256
}
if ($hashByLogical.Count -ne 41) { throw 'Lua require provenance bi trung hoac thieu logical path.' }

$expectedRuntimeFiles = [Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
foreach ($row in $catalog) {
    $logical = ([string]$row.logical_path).Replace('/', '\')
    $prefix = 'script\common\'
    if (-not $logical.StartsWith($prefix, [StringComparison]::OrdinalIgnoreCase)) {
        throw "Module nam ngoai script\\common: $logical"
    }
    $relative = Convert-ToRuntimeRelative $logical.Substring($prefix.Length)
    [void]$expectedRuntimeFiles.Add($relative)
    $source = Join-Path $sourceRoot $relative
    if (-not (Test-Path -LiteralPath $source -PathType Leaf)) { throw "Source thieu module: $relative" }
    if ((Get-FileHash -LiteralPath $source -Algorithm SHA256).Hash -ne $hashByLogical[$logical]) {
        throw "Source module sai hash PAK: $relative"
    }
}
$actualSource = @(Get-ChildItem -LiteralPath $sourceRoot -Recurse -File -Filter '*.luax')
if ($actualSource.Count -ne 41) { throw "Source module tree phai co dung 41 file, hien co $($actualSource.Count)." }

$requireRegex = [regex]'(?i)require\s*\(\s*["'']([^"'']+\.luax)["'']\s*\)'
$directModules = [Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
$roleCalls = @{}
foreach ($role in 'Client', 'Server') {
    $roleRoot = Join-Path $DataRoot $role
    $scriptRoot = Join-Path $roleRoot 'script'
    $moduleRoot = Join-Path $scriptRoot 'common'
    if (-not (Test-Path -LiteralPath $scriptRoot -PathType Container)) {
        throw "Data root thieu script role $role`: $scriptRoot"
    }
    foreach ($relative in $expectedRuntimeFiles) {
        $deployed = Join-Path $moduleRoot $relative
        if (-not (Test-Path -LiteralPath $deployed -PathType Leaf)) {
            throw "Runtime $role thieu module: $relative"
        }
        $logical = 'script\common\' + (($relative -split '\\' | ForEach-Object {
            $gbk.GetString($runtimeEncoding.GetBytes($_))
        }) -join '\')
        if ((Get-FileHash -LiteralPath $deployed -Algorithm SHA256).Hash -ne $hashByLogical[$logical]) {
            throw "Runtime $role module sai hash: $relative"
        }
    }
    $actualModules = @(Get-ChildItem -LiteralPath $moduleRoot -Recurse -File -Filter '*.luax')
    if ($actualModules.Count -ne 41) {
        throw "Runtime $role phai co dung 41 module, hien co $($actualModules.Count)."
    }
    $calls = 0
    foreach ($file in Get-ChildItem -LiteralPath $scriptRoot -Recurse -File -Filter '*.lua') {
        $text = $gbk.GetString([IO.File]::ReadAllBytes($file.FullName))
        foreach ($match in $requireRegex.Matches($text)) {
            $calls++
            [void]$directModules.Add($match.Groups[1].Value.Replace('/', '\'))
        }
    }
    if ($calls -ne 420) { throw "Runtime $role co $calls require call, yeu cau 420." }
    $roleCalls[$role] = $calls
}

$visited = [Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
$queue = [Collections.Generic.Queue[string]]::new()
foreach ($name in $directModules) { $queue.Enqueue($name) }
while ($queue.Count) {
    $name = $queue.Dequeue().Replace('/', '\')
    if (-not $visited.Add($name)) { continue }
    $relative = Convert-ToRuntimeRelative $name
    $path = Join-Path $sourceRoot $relative
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        throw "Dependency closure thieu module: $name"
    }
    $text = $gbk.GetString([IO.File]::ReadAllBytes($path))
    foreach ($match in $requireRegex.Matches($text)) {
        $queue.Enqueue($match.Groups[1].Value.Replace('/', '\'))
    }
}
if ($visited.Count -ne 41) {
    throw "Dependency closure dat $($visited.Count)/41 module. Catalog co module thua hoac closure bi thieu."
}

$engine = Get-Content -LiteralPath $engineSource -Raw
foreach ($pattern in @(
    'LuaVngRequire', 'LuaVngModule', 'Lua_ExecuteBuffer',
    'm_LoadedModules', 'm_LoadingModules', 'circular .luax dependency detected'
)) {
    if ($engine -notmatch [regex]::Escape($pattern)) { throw "Engine require gate thieu: $pattern" }
}

[pscustomobject]@{
    Result = 'PASS'
    CatalogModules = $catalog.Count
    ProvenancePayloads = @($provenance.files).Count
    DependencyClosure = $visited.Count
    DirectModules = $directModules.Count
    ClientRequireCalls = $roleCalls.Client
    ServerRequireCalls = $roleCalls.Server
    SameLuaStateLoader = $true
}
