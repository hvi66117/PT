[CmdletBinding()]
param(
    [string]$DataRoot,
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$ManifestPath = (Join-Path (Split-Path -Parent $PSScriptRoot) 'Deploy\RUNTIME_CONTENT_MANIFEST.json')
)

$ErrorActionPreference = 'Stop'
[Text.Encoding]::RegisterProvider([Text.CodePagesEncodingProvider]::Instance)
$cp936 = [Text.Encoding]::GetEncoding(936)
$latin1 = [Text.Encoding]::GetEncoding(28591)
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
if (-not $DataRoot) { $DataRoot = Join-Path (Split-Path -Parent $ProjectRoot) 'PhongThanRuntime-Content' }
$DataRoot = [IO.Path]::GetFullPath($DataRoot).TrimEnd('\')
$ManifestPath = [IO.Path]::GetFullPath($ManifestPath)

if (-not (Test-Path -LiteralPath $ManifestPath -PathType Leaf)) { throw "Thieu runtime manifest: $ManifestPath" }
$manifest = Get-Content -LiteralPath $ManifestPath -Raw | ConvertFrom-Json
$registry = $manifest.DataRegistries.Gameplay
if (-not $registry) { throw 'Manifest thieu DataRegistries.Gameplay.' }

function Read-Cp936Lines([string]$Path) {
    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) { throw "Thieu file: $Path" }
    return [IO.File]::ReadAllLines($Path, $script:cp936)
}

function Get-TableShape([string]$Path) {
    $lines = @(Read-Cp936Lines $Path)
    $columns = if ($lines.Count) { $lines[0].Split([char]"`t").Count } else { 0 }
    return [pscustomobject]@{ Rows = $lines.Count; Columns = $columns; Lines = $lines }
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

function Get-LuaReferences([string[]]$Lines) {
    $references = New-Object 'System.Collections.Generic.HashSet[string]' ([StringComparer]::OrdinalIgnoreCase)
    foreach ($line in $Lines) {
        foreach ($match in [regex]::Matches($line, '(?i)([^\t"]+?\.lua)')) {
            $value = $match.Groups[1].Value.Trim()
            $scriptIndex = $value.IndexOf('\script\', [StringComparison]::OrdinalIgnoreCase)
            if ($scriptIndex -ge 0) { $value = $value.Substring($scriptIndex) }
            [void]$references.Add((ConvertTo-DiskRelativePath $value))
        }
    }
    return @($references | Sort-Object)
}

function Read-ServerWorldIds([string]$Path) {
    $lines = @(Read-Cp936Lines $Path)
    $countLine = @($lines | Where-Object { $_ -match '^\s*Count\s*=\s*(\d+)\s*$' })
    if ($countLine.Count -ne 1) { throw "Server WorldSet phai co dung mot Count: $Path" }
    $count = [int]([regex]::Match($countLine[0], '(\d+)').Groups[1].Value)
    $slots = New-Object 'System.Collections.Generic.SortedDictionary[int,int]'
    foreach ($line in $lines) {
        $match = [regex]::Match($line, '^\s*World(?<slot>\d{3})\s*=\s*(?<id>\d+)(?:\s+(?:--|;|#).*)?\s*$')
        if ($match.Success) { $slots.Add([int]$match.Groups['slot'].Value, [int]$match.Groups['id'].Value) }
    }
    if ($slots.Count -ne $count) {
        throw "WorldSet Count=$count nhung co $($slots.Count) slot; khong chap nhan entry ngoai tap active."
    }
    $ids = for ($slot = 0; $slot -lt $count; $slot++) {
        if (-not $slots.ContainsKey($slot)) { throw "Server WorldSet thieu World$('{0:D3}' -f $slot)." }
        $slots[$slot]
    }
    if (@($ids | Sort-Object -Unique).Count -ne $ids.Count) { throw 'Server WorldSet co map id trung lap.' }
    return [pscustomobject]@{ Count = $count; Ids = @($ids) }
}

function Read-MapNames([string]$Path) {
    $names = @{}
    foreach ($line in Read-Cp936Lines $Path) {
        $match = [regex]::Match($line, '^\s*(?<id>\d+)\s*=\s*(?<name>[^;\r\n]+?)\s*$')
        if (-not $match.Success) { continue }
        $id = [int]$match.Groups['id'].Value
        if ($id -le 0) { continue }
        $name = $match.Groups['name'].Value.Trim()
        if ($name) { $names[$id] = $name }
    }
    return $names
}

$roles = @('Client', 'Server')
$tables = @{
    Npc = $registry.Npc
    Skill = $registry.Skill
}
$npcCanonicalRelative = [string]$registry.Npc.Table
foreach ($relative in @($registry.Npc.ForbiddenAliases)) {
    if ($npcCanonicalRelative.Equals([string]$relative, [StringComparison]::OrdinalIgnoreCase)) {
        throw "NPC canonical path trung alias tren Windows: $npcCanonicalRelative"
    }
}
$tablePaths = @{}
foreach ($tableName in $tables.Keys) {
    $table = $tables[$tableName]
    $tablePaths[$tableName] = @{}
    foreach ($role in $roles) {
        $path = Join-Path (Join-Path $DataRoot $role) ([string]$table.Table)
        $shape = Get-TableShape $path
        if ($shape.Columns -lt [int]$table.MinimumColumns -or $shape.Rows -lt [int]$table.MinimumRows) {
            throw "$tableName registry $role sai schema: $($shape.Columns) cot/$($shape.Rows) dong."
        }
        $tablePaths[$tableName][$role] = $path
    }
    if ((Get-FileHash -LiteralPath $tablePaths[$tableName].Client -Algorithm SHA256).Hash -ne
        (Get-FileHash -LiteralPath $tablePaths[$tableName].Server -Algorithm SHA256).Hash) {
        throw "$tableName registry client/server khac byte."
    }
}
foreach ($role in $roles) {
    foreach ($relative in @($registry.Npc.ForbiddenAliases)) {
        $alias = Join-Path (Join-Path $DataRoot $role) ([string]$relative)
        if (Test-Path -LiteralPath $alias) { throw "Con NPC alias cu: $alias" }
    }
}

$magicScriptPath = Join-Path (Join-Path $DataRoot 'Server') ([string]$registry.Lua.MagicScriptTable)
$magicReferences = @(Get-LuaReferences (Read-Cp936Lines $magicScriptPath))
if ($magicReferences.Count -ne [int]$registry.Lua.ExpectedMagicScriptReferences) {
    throw "MagicScript co $($magicReferences.Count) Lua duy nhat, yeu cau $($registry.Lua.ExpectedMagicScriptReferences)."
}
$missingMagic = New-Object System.Collections.Generic.List[string]
foreach ($role in $roles) {
    $roleRoot = Join-Path $DataRoot $role
    foreach ($relative in $magicReferences) {
        if (-not (Test-Path -LiteralPath (Join-Path $roleRoot $relative) -PathType Leaf)) {
            $missingMagic.Add("$role\$relative")
        }
    }
}
if ($missingMagic.Count) { throw "Lua MagicScript chua resolve: $($missingMagic.Count); $(@($missingMagic | Select-Object -First 10) -join ', ')" }

foreach ($role in $roles) {
    $required = if ($role -eq 'Client') { $registry.Lua.RequiredClientFiles } else { $registry.Lua.RequiredServerFiles }
    foreach ($relative in @($required)) {
        $path = Join-Path (Join-Path $DataRoot $role) (ConvertTo-DiskRelativePath ([string]$relative))
        if (-not (Test-Path -LiteralPath $path -PathType Leaf)) { throw "Thieu Lua loi ${role}: $relative" }
    }
}

$serverRoot = Join-Path $DataRoot 'Server'
$clientRoot = Join-Path $DataRoot 'Client'
$activation = Read-ServerWorldIds (Join-Path $serverRoot ([string]$registry.Map.ServerActivationFile))
if ($activation.Count -ne [int]$registry.Map.ExpectedActiveMapCount) {
    throw "So map server dang bat=$($activation.Count), yeu cau=$($registry.Map.ExpectedActiveMapCount)."
}
$expectedMapIds = @($registry.Map.ExpectedActiveMapIds | ForEach-Object { [int]$_ })
if ($expectedMapIds.Count -ne [int]$registry.Map.ExpectedActiveMapCount) {
    throw 'Manifest ExpectedActiveMapIds khong khop ExpectedActiveMapCount.'
}
if ((@($activation.Ids) -join ',') -ne ($expectedMapIds -join ',')) {
    throw "Tap map active sai. Thuc te=$(@($activation.Ids) -join ','); yeu cau=$($expectedMapIds -join ',')."
}
$clientActivation = Read-ServerWorldIds (Join-Path $clientRoot ([string]$registry.Map.ServerActivationFile))
if ((@($clientActivation.Ids) -join ',') -ne ($expectedMapIds -join ',')) {
    throw "WorldSet client khong dong bo tap map active: $(@($clientActivation.Ids) -join ',')."
}
$mapNames = Read-MapNames (Join-Path $serverRoot ([string]$registry.Map.MetadataFile))
$missingWorld = New-Object System.Collections.Generic.List[string]
$missingClientRegion = New-Object System.Collections.Generic.List[string]
$missingServerRegion = New-Object System.Collections.Generic.List[string]
$serverRegionCount = 0
$clientRegionCount = 0
foreach ($mapId in $activation.Ids) {
    if (-not $mapNames.ContainsKey($mapId)) { throw "World metadata thieu map id $mapId." }
    $diskName = ConvertTo-DiskRelativePath ([string]$mapNames[$mapId])
    $worldFile = $diskName + [string]$registry.Map.WorldFileSuffix
    foreach ($roleRoot in @($clientRoot, $serverRoot)) {
        if (-not (Test-Path -LiteralPath (Join-Path (Join-Path $roleRoot 'maps') $worldFile) -PathType Leaf)) {
            $missingWorld.Add("$mapId@$roleRoot")
        }
    }
    $clientMap = Join-Path (Join-Path $clientRoot 'maps') $diskName
    $clientRegions = if (Test-Path -LiteralPath $clientMap -PathType Container) {
        @(Get-ChildItem -LiteralPath $clientMap -Recurse -File -Filter "*$($registry.Map.ClientRegionSuffix)")
    } else { @() }
    if (-not $clientRegions.Count) { $missingClientRegion.Add("$mapId=$($mapNames[$mapId])") }
    $clientRegionCount += $clientRegions.Count

    $serverMaps = @(
        (Join-Path (Join-Path $serverRoot 'maps') $diskName),
        (Join-Path (Join-Path $serverRoot 'maps') ($diskName + '_S'))
    )
    $serverRegions = @($serverMaps | Where-Object { Test-Path -LiteralPath $_ -PathType Container } |
        ForEach-Object { Get-ChildItem -LiteralPath $_ -Recurse -File -Filter "*$($registry.Map.ServerRegionSuffix)" })
    if (-not $serverRegions.Count) { $missingServerRegion.Add("$mapId=$($mapNames[$mapId])") }
    $serverRegionCount += $serverRegions.Count
}
if ($missingWorld.Count) { throw "Map active thieu WOR: $($missingWorld -join ', ')" }
if ($missingClientRegion.Count) { throw "Map active thieu Region_C: $($missingClientRegion -join ', ')" }
if ($registry.Map.RequireOriginalServerRegionForEveryActiveMap -and $missingServerRegion.Count) {
    throw "Map active thieu Region_S VNG goc ($($missingServerRegion.Count)/$($activation.Count)): $($missingServerRegion -join ', ')"
}

$expectedPhysicalMaps = [int]$registry.Map.ExpectedPhysicalMapCount
$allClientRegions = @(Get-ChildItem -LiteralPath (Join-Path $clientRoot 'maps') -Recurse -File -Filter "*$($registry.Map.ClientRegionSuffix)")
$allServerRegions = @(Get-ChildItem -LiteralPath (Join-Path $serverRoot 'maps') -Recurse -File -Filter "*$($registry.Map.ServerRegionSuffix)")
$wrongClientRegions = @(Get-ChildItem -LiteralPath (Join-Path $clientRoot 'maps') -Recurse -File -Filter "*$($registry.Map.ServerRegionSuffix)")
$wrongServerRegions = @(Get-ChildItem -LiteralPath (Join-Path $serverRoot 'maps') -Recurse -File -Filter "*$($registry.Map.ClientRegionSuffix)")
$clientMapDirectories = @(Get-ChildItem -LiteralPath (Join-Path $clientRoot 'maps') -Directory)
$serverMapDirectories = @(Get-ChildItem -LiteralPath (Join-Path $serverRoot 'maps') -Directory)
if ($allClientRegions.Count -ne [int]$registry.Map.ExpectedClientRegions -or
    $allServerRegions.Count -ne [int]$registry.Map.ExpectedServerRegions) {
    throw "Inventory Region sai: C=$($allClientRegions.Count)/$($registry.Map.ExpectedClientRegions), S=$($allServerRegions.Count)/$($registry.Map.ExpectedServerRegions)."
}
if ($wrongClientRegions.Count -or $wrongServerRegions.Count) {
    throw 'Region_C/Region_S bi tron giua client va server.'
}
if ($clientMapDirectories.Count -ne $expectedPhysicalMaps -or
    $serverMapDirectories.Count -ne $expectedPhysicalMaps -or
    @($serverMapDirectories | Where-Object { -not $_.Name.EndsWith('_S', [StringComparison]::OrdinalIgnoreCase) }).Count) {
    throw "Inventory thu muc map sai: client=$($clientMapDirectories.Count), server=$($serverMapDirectories.Count), yeu cau=$expectedPhysicalMaps."
}
foreach ($roleRoot in $clientRoot, $serverRoot) {
    $mapRoot = Join-Path $roleRoot 'maps'
    $worldCount = @(Get-ChildItem -LiteralPath $mapRoot -File -Filter "*$($registry.Map.WorldFileSuffix)").Count
    $minimapCount = @(Get-ChildItem -LiteralPath $mapRoot -File -Filter '*.jpg').Count
    if ($worldCount -ne [int]$registry.Map.ExpectedWorldFiles -or
        $minimapCount -ne [int]$registry.Map.ExpectedMinimapFiles) {
        throw "Inventory WOR/JPG sai tai $roleRoot`: WOR=$worldCount, JPG=$minimapCount."
    }
}

$pakParity = & (Join-Path $ProjectRoot 'Tests\Test-ServerPakParity.ps1') `
    -ProjectRoot $ProjectRoot -RuntimeRoot $DataRoot
if ($pakParity.Mode -ne 'PAK_FIRST_LOOSE_FALLBACK' -or
    $pakParity.Packages -ne [int]$registry.Map.ExpectedServerPackageCount) {
    throw 'Server VNG PAK chain does not match the gameplay registry.'
}

$npcReferences = @(Get-LuaReferences (Read-Cp936Lines $tablePaths.Npc.Server))
$npcMissing = @($npcReferences | Where-Object {
    -not (Test-Path -LiteralPath (Join-Path $serverRoot $_) -PathType Leaf)
})

[pscustomobject]@{
    Result = 'PASS'
    DataRoot = $DataRoot
    NpcRows = (Get-TableShape $tablePaths.Npc.Server).Rows
    NpcColumns = (Get-TableShape $tablePaths.Npc.Server).Columns
    SkillRows = (Get-TableShape $tablePaths.Skill.Server).Rows
    SkillColumns = (Get-TableShape $tablePaths.Skill.Server).Columns
    ActiveMaps = $activation.Count
    ClientRegions = $allClientRegions.Count
    ServerRegions = $allServerRegions.Count
    PhysicalMaps = $expectedPhysicalMaps
    MagicScriptLua = $magicReferences.Count
    MagicScriptMissing = 0
    NpcLuaReferences = $npcReferences.Count
    NpcLuaBacklog = $npcMissing.Count
    LegacyServerPakFiles = 0
}
