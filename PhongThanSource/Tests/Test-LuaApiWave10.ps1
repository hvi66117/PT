[CmdletBinding()]
param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$AuditRoot,
    [string]$RuntimeRoot
)

$ErrorActionPreference = 'Stop'
[Text.Encoding]::RegisterProvider([Text.CodePagesEncodingProvider]::Instance)
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
$projectParent = Split-Path -Parent $ProjectRoot
if (-not $AuditRoot) {
    $AuditRoot = Join-Path $projectParent 'SourceMigration\staging\p0.3-validated-entry-sets\audit'
}
if (-not $RuntimeRoot) { $RuntimeRoot = Join-Path $projectParent 'PhongThanRuntime-Staging' }
$AuditRoot = [IO.Path]::GetFullPath($AuditRoot).TrimEnd('\')
$RuntimeRoot = [IO.Path]::GetFullPath($RuntimeRoot).TrimEnd('\')
$latin1 = [Text.Encoding]::GetEncoding(28591)
$cp936 = [Text.Encoding]::GetEncoding(936)

function Assert-True([bool]$Condition, [string]$Message) {
    if (-not $Condition) { throw $Message }
}

function Get-Sha256Text([string]$Text) {
    $sha = [Security.Cryptography.SHA256]::Create()
    try {
        return ([BitConverter]::ToString($sha.ComputeHash([Text.Encoding]::UTF8.GetBytes($Text)))).Replace('-', '')
    }
    finally { $sha.Dispose() }
}

function ConvertTo-DiskRelativePath([string]$Path) {
    $normalized = $Path.Trim().Trim([char]'"').Replace('/', '\').TrimStart('\')
    if ($normalized.StartsWith('root\', [StringComparison]::OrdinalIgnoreCase)) {
        $normalized = $normalized.Substring(5)
    }
    $segments = foreach ($segment in $normalized.Split([char]'\')) {
        if ($segment -match '[^\x00-\x7f]') {
            $script:latin1.GetString($script:cp936.GetBytes($segment))
        }
        else { $segment }
    }
    return $segments -join '\'
}

function Get-LuaReferences([string]$Path) {
    $references = New-Object 'System.Collections.Generic.HashSet[string]' ([StringComparer]::OrdinalIgnoreCase)
    foreach ($line in [IO.File]::ReadAllLines($Path, $script:cp936)) {
        foreach ($match in [regex]::Matches($line, '(?i)([^\t"]+?\.lua)')) {
            $value = $match.Groups[1].Value.Trim()
            $scriptIndex = $value.IndexOf('\script\', [StringComparison]::OrdinalIgnoreCase)
            if ($scriptIndex -ge 0) { $value = $value.Substring($scriptIndex) }
            [void]$references.Add((ConvertTo-DiskRelativePath $value))
        }
    }
    return @($references | Sort-Object)
}

function Get-FunctionBody([string]$FunctionName, [hashtable]$SourceTexts) {
    $pattern = '(?m)\b(?:static\s+)?int\s+' + [regex]::Escape($FunctionName) +
        '\s*\(\s*Lua_State\s*\*\s*\w+\s*\)\s*\{'
    foreach ($path in $SourceTexts.Keys) {
        $text = $SourceTexts[$path]
        $match = [regex]::Match($text, $pattern)
        if (-not $match.Success) { continue }
        $open = $match.Index + $match.Length - 1
        $depth = 0
        $state = 'code'
        for ($index = $open; $index -lt $text.Length; $index++) {
            $character = $text[$index]
            $next = if ($index + 1 -lt $text.Length) { $text[$index + 1] } else { [char]0 }
            if ($state -eq 'line') {
                if ($character -eq "`n") { $state = 'code' }
                continue
            }
            if ($state -eq 'block') {
                if ($character -eq '*' -and $next -eq '/') { $index++; $state = 'code' }
                continue
            }
            if ($state -eq 'string') {
                if ($character -eq '\') { $index++; continue }
                if ($character -eq '"') { $state = 'code' }
                continue
            }
            if ($state -eq 'char') {
                if ($character -eq '\') { $index++; continue }
                if ($character -eq "'") { $state = 'code' }
                continue
            }
            if ($character -eq '/' -and $next -eq '/') { $index++; $state = 'line'; continue }
            if ($character -eq '/' -and $next -eq '*') { $index++; $state = 'block'; continue }
            if ($character -eq '"') { $state = 'string'; continue }
            if ($character -eq "'") { $state = 'char'; continue }
            if ($character -eq '{') { $depth++ }
            elseif ($character -eq '}') {
                $depth--
                if ($depth -eq 0) {
                    return [pscustomobject]@{
                        Path = $path
                        Body = $text.Substring($open + 1, $index - $open - 1)
                    }
                }
            }
        }
        throw "Khong tim thay dau ket thuc cua ham $FunctionName trong $path."
    }
    return $null
}

$catalogPath = Join-Path $ProjectRoot 'Docs\LUA_API_182_CATALOG.json'
$catalogDocument = Get-Content -Raw -LiteralPath $catalogPath | ConvertFrom-Json
$catalog = @($catalogDocument.apis)
Assert-True ($catalog.Count -eq 182) "Wave 10 khong nhan du 182 API: $($catalog.Count)."
Assert-True (@($catalog.name | Sort-Object -Unique).Count -eq 182) 'Wave 10 phat hien API trung ten.'
Assert-True (@($catalog.wave | Sort-Object -Unique) -join ',' -eq '1,2,3,4,5,6,7,8,9') 'Wave 1..9 khong lien tuc.'
Assert-True (@($catalog | Where-Object contract_status -eq 'data-contract-recovery-required').Count -eq 0) 'Catalog van con data contract chua phuc hoi.'
Assert-True (@($catalog | Where-Object contract_status -eq 'data-contract-recovered').Count -eq 22) 'So data contract da phuc hoi khong con la 22.'

$summary = Get-Content -Raw -LiteralPath (Join-Path $AuditRoot 'summary.json') | ConvertFrom-Json
$missing = @(Import-Csv -Delimiter "`t" -LiteralPath (Join-Path $AuditRoot 'lua-missing-api.tsv') |
    Where-Object { $_ -and $_.name })
Assert-True ($summary.lua.missing_api_name_count -eq 0 -and $missing.Count -eq 0) 'Semantic audit van con API thieu.'
Assert-True (-not $summary.lua.status.PSObject.Properties['review_api']) 'Semantic audit van con review_api.'
Assert-True ($summary.integrity.valid -eq 3680 -and $summary.integrity.invalid -eq 0) 'Payload integrity khong con 3680/3680.'
Assert-True ($summary.lua.missing_callback_group_count -eq 0) 'Semantic audit van con callback gap.'

foreach ($wave in 1..9) {
    $test = Join-Path $ProjectRoot "Tests\Test-LuaApiWave$wave.ps1"
    Assert-True (Test-Path -LiteralPath $test -PathType Leaf) "Thieu regression test Wave $wave."
    & $test -ProjectRoot $ProjectRoot -AuditRoot $AuditRoot | Out-Null
}

$scriptFunsPath = Join-Path $ProjectRoot 'Sources\Core\Src\ScriptFuns.cpp'
$sourceFiles = @($scriptFunsPath) + @(Get-ChildItem -LiteralPath (Join-Path $ProjectRoot 'Sources\Core\Src') `
    -Filter 'PhongThanLuaWave*.h' -File | Sort-Object Name | ForEach-Object FullName)
$sourceTexts = @{}
foreach ($path in $sourceFiles) { $sourceTexts[$path] = $latin1.GetString([IO.File]::ReadAllBytes($path)) }
$registrationSource = $sourceTexts[$scriptFunsPath]
$allowedExactWrappers = @{
    LuaNpcSayCompat = 'LuaNpcChat'
    LuaInfoBoxCompat = 'LuaSendMessageInfo'
    LuaGetHeavenCityUnionCompat = 'LuaGetUnionTongIDByPosterityTypeCompat'
}
$functions = New-Object 'System.Collections.Generic.HashSet[string]' ([StringComparer]::Ordinal)
$bodyEvidence = New-Object System.Collections.Generic.List[string]
$exactWrapperCount = 0
foreach ($api in $catalog) {
    $registrationPattern = '\{"' + [regex]::Escape([string]$api.name) +
        '"\s*,\s*(?<function>\w+)\s*\}'
    $registrations = [regex]::Matches($registrationSource, $registrationPattern)
    Assert-True ($registrations.Count -eq 1) "API $($api.name) co $($registrations.Count) registration, yeu cau dung 1."
    $functionName = $registrations[0].Groups['function'].Value
    Assert-True ($functions.Add($functionName)) "Hai API dung chung implementation khong duoc audit: $functionName."
    $definition = Get-FunctionBody $functionName $sourceTexts
    Assert-True ($null -ne $definition) "Khong tim thay implementation: $functionName."
    $withoutComments = [regex]::Replace($definition.Body, '(?s)/\*.*?\*/|//[^\r\n]*', '')
    $normalized = [regex]::Replace($withoutComments, '\s+', '')
    Assert-True ($normalized.Length -ge 20) "Implementation qua ngan/co nguy co stub: $($api.name) -> $functionName."
    Assert-True ($normalized -notmatch '^(?:\(void\)L;)?return(?:0|1|TRUE|FALSE|NULL);$') "Constant/no-op stub: $($api.name) -> $functionName."
    Assert-True ($normalized -notmatch '^Lua_Push(?:Number|String|Boolean)\(L,(?:0|1|NULL|""|FALSE|TRUE)\);return1;$') "Constant push stub: $($api.name) -> $functionName."
    Assert-True ($definition.Body -notmatch '(?i)\b(?:TODO|STUB|NOT[ _-]?IMPLEMENTED|IMPLEMENT[ _-]?ME)\b') "Marker stub con trong $functionName."
    $wrapper = [regex]::Match($normalized, '^return(?<target>\w+)\(L\);$')
    if ($wrapper.Success) {
        $exactWrapperCount++
        Assert-True ($allowedExactWrappers.ContainsKey($functionName)) "Alias chua duoc semantic audit: $($api.name) -> $functionName."
        Assert-True ($allowedExactWrappers[$functionName] -eq $wrapper.Groups['target'].Value) "Alias $functionName doi target ngoai hop dong."
    }
    $bodyEvidence.Add("$($api.name)`t$functionName`t$(Get-Sha256Text $normalized)")
}
Assert-True ($functions.Count -eq 182) "Chi co $($functions.Count)/182 implementation rieng."
Assert-True ($exactWrapperCount -eq $allowedExactWrappers.Count) 'So alias semantic da audit thay doi.'
$apiRegistryHash = Get-Sha256Text (($bodyEvidence | Sort-Object) -join "`n")

& (Join-Path $ProjectRoot 'Tests\Test-DataRegistry.ps1') -DataRoot $RuntimeRoot -ProjectRoot $ProjectRoot | Out-Null
$manifest = Get-Content -Raw -LiteralPath (Join-Path $ProjectRoot 'Deploy\RUNTIME_CONTENT_MANIFEST.json') | ConvertFrom-Json
$clientRoot = Join-Path $RuntimeRoot 'Client'
$serverRoot = Join-Path $RuntimeRoot 'Server'
$sharedRegistryFiles = @(
    [string]$manifest.DataRegistries.Gameplay.Npc.Table,
    [string]$manifest.DataRegistries.Gameplay.Skill.Table,
    [string]$manifest.DataRegistries.Item.VersionFile
)
$sharedRegistryFiles += @(Get-ChildItem -LiteralPath (Join-Path $clientRoot ([string]$manifest.DataRegistries.Item.ActiveDirectory)) `
    -File | Sort-Object Name | ForEach-Object {
        ([string]$manifest.DataRegistries.Item.ActiveDirectory) + '\' + $_.Name
    })
$registryEvidence = New-Object System.Collections.Generic.List[string]
foreach ($relative in $sharedRegistryFiles) {
    $clientPath = Join-Path $clientRoot $relative
    $serverPath = Join-Path $serverRoot $relative
    Assert-True (Test-Path -LiteralPath $clientPath -PathType Leaf) "Client thieu shared registry: $relative."
    Assert-True (Test-Path -LiteralPath $serverPath -PathType Leaf) "Server thieu shared registry: $relative."
    $clientHash = (Get-FileHash -LiteralPath $clientPath -Algorithm SHA256).Hash
    $serverHash = (Get-FileHash -LiteralPath $serverPath -Algorithm SHA256).Hash
    Assert-True ($clientHash -eq $serverHash) "Shared registry client/server khac hash: $relative."
    $registryEvidence.Add("$relative`t$clientHash")
}
$sharedRegistryHash = Get-Sha256Text (($registryEvidence | Sort-Object) -join "`n")

$magicScript = Join-Path $serverRoot ([string]$manifest.DataRegistries.Gameplay.Lua.MagicScriptTable)
$luaReferences = @(Get-LuaReferences $magicScript)
Assert-True ($luaReferences.Count -eq [int]$manifest.DataRegistries.Gameplay.Lua.ExpectedMagicScriptReferences) `
    "MagicScript reference count=$($luaReferences.Count)."
$luaEvidence = New-Object System.Collections.Generic.List[string]
foreach ($relative in $luaReferences) {
    $clientPath = Join-Path $clientRoot $relative
    $serverPath = Join-Path $serverRoot $relative
    Assert-True (Test-Path -LiteralPath $clientPath -PathType Leaf) "Client thieu Lua MagicScript: $relative."
    Assert-True (Test-Path -LiteralPath $serverPath -PathType Leaf) "Server thieu Lua MagicScript: $relative."
    $clientHash = (Get-FileHash -LiteralPath $clientPath -Algorithm SHA256).Hash
    $serverHash = (Get-FileHash -LiteralPath $serverPath -Algorithm SHA256).Hash
    Assert-True ($clientHash -eq $serverHash) "Lua MagicScript client/server khac hash: $relative."
    $luaEvidence.Add("$relative`t$clientHash")
}
$sharedLuaHash = Get-Sha256Text (($luaEvidence | Sort-Object) -join "`n")

$deploymentPath = Join-Path $RuntimeRoot 'DEPLOYMENT_MANIFEST.json'
Assert-True (Test-Path -LiteralPath $deploymentPath -PathType Leaf) 'Staging thieu DEPLOYMENT_MANIFEST.json.'
$deployment = Get-Content -Raw -LiteralPath $deploymentPath | ConvertFrom-Json
$stateRoot = [IO.Path]::GetFullPath([string]$deployment.StateRoot).TrimEnd('\')
$stateJunctions = 0
foreach ($relative in @($manifest.Roles.Server.StateDirectories)) {
    $junctionPath = Join-Path $serverRoot ([string]$relative)
    $expectedTarget = [IO.Path]::GetFullPath((Join-Path (Join-Path $stateRoot 'Server') ([string]$relative))).TrimEnd('\')
    Assert-True (Test-Path -LiteralPath $junctionPath -PathType Container) "Staging thieu state: $relative."
    $junction = Get-Item -LiteralPath $junctionPath -Force
    Assert-True (($junction.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) "State khong phai junction: $relative."
    $targets = @($junction.Target | ForEach-Object { [IO.Path]::GetFullPath($_).TrimEnd('\') })
    Assert-True ($expectedTarget -in $targets) "State junction sai target: $relative."
    $stateJunctions++
}

$contentRoot = [IO.Path]::GetFullPath([string]$deployment.ContentRoot).TrimEnd('\')
$npcRelative = [string]$manifest.DataRegistries.Gameplay.Npc.Table
$npcHashes = foreach ($root in @($clientRoot, $serverRoot, (Join-Path $contentRoot 'Client'), (Join-Path $contentRoot 'Server'))) {
    $path = Join-Path $root $npcRelative
    Assert-True (Test-Path -LiteralPath $path -PathType Leaf) "Content regression: thieu $path."
    (Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash
}
Assert-True (@($npcHashes | Sort-Object -Unique).Count -eq 1) 'Npcs.txt runtime/content/client/server khac hash.'

[pscustomobject]@{
    Status = 'PASS'
    Wave = 10
    ApiCount = $catalog.Count
    MissingApiNames = $summary.lua.missing_api_name_count
    ReviewApi = 0
    Integrity = "$($summary.integrity.valid)/$($summary.integrity.entry_count)"
    CallbackGaps = $summary.lua.missing_callback_group_count
    ConstantOrNoOpStubs = 0
    DataContractsRecovered = 22
    AuditedExactWrappers = $exactWrapperCount
    ApiRegistryHash = $apiRegistryHash
    SharedRegistryFiles = $sharedRegistryFiles.Count
    SharedRegistryHash = $sharedRegistryHash
    SharedMagicScriptLua = $luaReferences.Count
    SharedMagicScriptLuaHash = $sharedLuaHash
    PersistentStateJunctions = $stateJunctions
    NpcContentHash = $npcHashes[0]
}
