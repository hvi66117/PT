[CmdletBinding()]
param(
    [string]$SeaweedMapRoot,
    [string[]]$RuntimeRoots,
    [string]$ManifestPath = (Join-Path $PSScriptRoot 'RUNTIME_CONTENT_MANIFEST.json')
)

$ErrorActionPreference = 'Stop'
[Text.Encoding]::RegisterProvider([Text.CodePagesEncodingProvider]::Instance)
$cp936 = [Text.Encoding]::GetEncoding(
    936,
    [Text.EncoderFallback]::ExceptionFallback,
    [Text.DecoderFallback]::ExceptionFallback)
$latin1 = [Text.Encoding]::GetEncoding(28591)
$projectRoot = [IO.Path]::GetFullPath((Split-Path -Parent $PSScriptRoot)).TrimEnd('\')
$projectParent = Split-Path -Parent $projectRoot
if (-not $SeaweedMapRoot) {
    $SeaweedMapRoot = Join-Path $projectParent 'SeaweedUnpack_SprView\SeaweedUnpack_SprView\KetQua_Unpack_Maps\maps'
}
if (-not $RuntimeRoots -or -not $RuntimeRoots.Count) {
    $RuntimeRoots = @((Join-Path $projectParent 'PhongThanRuntime-Content'))
}
$SeaweedMapRoot = [IO.Path]::GetFullPath($SeaweedMapRoot).TrimEnd('\')
$ManifestPath = [IO.Path]::GetFullPath($ManifestPath)

function Resolve-SafeRoot([string]$Path, [string]$Label) {
    $resolved = [IO.Path]::GetFullPath($Path).TrimEnd('\')
    if (-not (Test-Path -LiteralPath $resolved -PathType Container)) {
        throw "$Label khong ton tai: $resolved"
    }
    if ($resolved -ieq [IO.Path]::GetPathRoot($resolved).TrimEnd('\')) {
        throw "$Label khong duoc la goc o dia."
    }
    $item = Get-Item -LiteralPath $resolved -Force
    if (($item.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
        throw "$Label khong duoc la reparse point: $resolved"
    }
    return $resolved
}

function Convert-Cp936NameToBytePreservingName([string]$Name) {
    if ($Name -notmatch '[^\x00-\x7f]') { return $Name }
    return $script:latin1.GetString($script:cp936.GetBytes($Name))
}

function Get-CanonicalRegionKeys([string]$Root, [string]$Suffix) {
    return @(Get-ChildItem -LiteralPath $Root -Recurse -File | ForEach-Object {
        $relative = $_.FullName.Substring($Root.Length + 1).Replace('/', '\')
        if (-not $relative.EndsWith($Suffix, [StringComparison]::OrdinalIgnoreCase)) {
            throw "File khong thuoc Region $Suffix trong $Root`: $relative"
        }
        $relative.Substring(0, $relative.Length - $Suffix.Length).ToLowerInvariant()
    } | Sort-Object)
}

function Copy-Directory([string]$Source, [string]$Destination) {
    New-Item -ItemType Directory -Path $Destination -Force | Out-Null
    & robocopy $Source $Destination /E /COPY:DAT /DCOPY:DAT /R:1 /W:1 /XJ /NFL /NDL /NP | Out-Null
    if ($LASTEXITCODE -gt 7) {
        throw "Robocopy map that bai ($LASTEXITCODE): $Source"
    }
}

function Clear-MapRoot([string]$MapRoot) {
    $resolved = [IO.Path]::GetFullPath($MapRoot).TrimEnd('\')
    $roleRoot = [IO.Path]::GetFullPath((Split-Path -Parent $resolved)).TrimEnd('\')
    if (-not $resolved.StartsWith($roleRoot + '\', [StringComparison]::OrdinalIgnoreCase) -or
        (Split-Path -Leaf $resolved) -ine 'maps') {
        throw "Thu muc maps khong an toan: $resolved"
    }
    foreach ($entry in Get-ChildItem -LiteralPath $resolved -Force) {
        if (-not $entry.PSIsContainer -and $entry.Name -ieq 'WorldSet.ini') { continue }
        $entryPath = [IO.Path]::GetFullPath($entry.FullName)
        if (-not $entryPath.StartsWith($resolved + '\', [StringComparison]::OrdinalIgnoreCase)) {
            throw "Tu choi xoa entry ngoai maps: $entryPath"
        }
        Remove-Item -LiteralPath $entryPath -Recurse -Force
    }
}

function Read-MapMetadata([string]$Path) {
    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
        throw "Thieu WorldSet metadata: $Path"
    }
    $result = @{}
    foreach ($line in [IO.File]::ReadAllLines($Path, $script:cp936)) {
        $match = [regex]::Match($line, '^\s*(?<id>\d+)\s*=\s*(?<name>[^;\r\n]+?)\s*$')
        if (-not $match.Success) { continue }
        $id = [int]$match.Groups['id'].Value
        $name = $match.Groups['name'].Value.Trim()
        if ($id -gt 0 -and $name) { $result[$id] = $name }
    }
    return $result
}

function Write-ActiveWorldSet([string]$Path, [int[]]$Ids) {
    $lines = [Collections.Generic.List[string]]::new()
    $lines.Add('[Init]')
    $lines.Add("Count=$($Ids.Count)")
    $lines.Add('[World]')
    for ($slot = 0; $slot -lt $Ids.Count; $slot++) {
        $lines.Add(('World{0:D3}={1}' -f $slot, $Ids[$slot]))
    }
    [IO.File]::WriteAllText($Path, (($lines -join "`r`n") + "`r`n"), $script:cp936)
}

function Update-ContentStoreManifest([string]$RuntimeRoot, [string]$SourceManifestPath) {
    $storeManifestPath = Join-Path $RuntimeRoot 'CONTENT_STORE_MANIFEST.json'
    if (-not (Test-Path -LiteralPath $storeManifestPath -PathType Leaf)) { return }
    $store = Get-Content -LiteralPath $storeManifestPath -Raw | ConvertFrom-Json
    $store.CreatedAtUtc = [DateTime]::UtcNow.ToString('o')
    $store.SourceManifest = $SourceManifestPath
    $store.SourceManifestSha256 = (Get-FileHash -LiteralPath $SourceManifestPath -Algorithm SHA256).Hash
    foreach ($group in @($store.Groups)) {
        $directory = Join-Path (Join-Path $RuntimeRoot ([string]$group.Role)) ([string]$group.Path)
        $files = @(Get-ChildItem -LiteralPath $directory -Recurse -File -Force)
        $group.FileCount = $files.Count
        $group.Bytes = [long](($files | Measure-Object Length -Sum).Sum)
    }
    foreach ($critical in @($store.CriticalFiles)) {
        $path = Join-Path (Join-Path $RuntimeRoot ([string]$critical.Role)) ([string]$critical.Path)
        if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
            throw "Content store critical file bi thieu: $path"
        }
        $critical.Length = (Get-Item -LiteralPath $path).Length
        $critical.Sha256 = (Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash
    }
    [IO.File]::WriteAllText(
        $storeManifestPath,
        ($store | ConvertTo-Json -Depth 8),
        (New-Object Text.UTF8Encoding($false)))
}

$SeaweedMapRoot = Resolve-SafeRoot $SeaweedMapRoot 'SeaweedMapRoot'
if (-not (Test-Path -LiteralPath $ManifestPath -PathType Leaf)) {
    throw "Thieu runtime manifest: $ManifestPath"
}
$manifest = Get-Content -LiteralPath $ManifestPath -Raw | ConvertFrom-Json
$mapRegistry = $manifest.DataRegistries.Gameplay.Map
if (-not $mapRegistry) { throw 'Manifest thieu DataRegistries.Gameplay.Map.' }

$expectedMapCount = [int]$mapRegistry.ExpectedPhysicalMapCount
$expectedClientRegions = [int]$mapRegistry.SeaweedBaseRegions
$expectedServerRegions = [int]$mapRegistry.SeaweedBaseRegions
$expectedWorldFiles = [int]$mapRegistry.ExpectedWorldFiles
$expectedMinimapFiles = [int]$mapRegistry.ExpectedMinimapFiles
$activeIds = @($mapRegistry.ExpectedActiveMapIds | ForEach-Object { [int]$_ })
if ($activeIds.Count -ne [int]$mapRegistry.ExpectedActiveMapCount -or
    @($activeIds | Sort-Object -Unique).Count -ne $activeIds.Count) {
    throw 'Manifest khai bao tap map active khong hop le.'
}
$excludedNames = @($mapRegistry.ExcludedSourceNames | ForEach-Object { [string]$_ })

$sourceMaps = New-Object Collections.Generic.List[object]
$targetNames = [Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
$clientRegionTotal = 0
$serverRegionTotal = 0
$clientRegionBytes = [long]0
$serverRegionBytes = [long]0
foreach ($clientSource in Get-ChildItem -LiteralPath $SeaweedMapRoot -Directory -Force |
    Where-Object { -not $_.Name.EndsWith('_S', [StringComparison]::OrdinalIgnoreCase) -and
        $excludedNames -notcontains $_.Name } | Sort-Object Name) {
    $name = $clientSource.Name
    $serverSourcePath = Join-Path $SeaweedMapRoot ($name + '_S')
    $worldPath = Join-Path $SeaweedMapRoot ($name + '.wor')
    $minimapPath = Join-Path $SeaweedMapRoot ($name + '24.jpg')
    foreach ($required in $serverSourcePath, $worldPath, $minimapPath) {
        if (-not (Test-Path -LiteralPath $required)) { throw "Map $name thieu tai nguyen: $required" }
    }

    $clientKeys = @(Get-CanonicalRegionKeys $clientSource.FullName '_region_c.dat')
    $serverKeys = @(Get-CanonicalRegionKeys $serverSourcePath '_region_s.dat')
    if (-not $clientKeys.Count -or ($clientKeys -join "`n") -ne ($serverKeys -join "`n")) {
        throw "Region_C/Region_S khong tao thanh cap dong bo: $name"
    }
    $targetName = Convert-Cp936NameToBytePreservingName $name
    if (-not $targetNames.Add($targetName)) {
        throw "Hai map nguon cung anh xa vao mot ten runtime: $targetName"
    }

    $clientFiles = @(Get-ChildItem -LiteralPath $clientSource.FullName -Recurse -File)
    $serverFiles = @(Get-ChildItem -LiteralPath $serverSourcePath -Recurse -File)
    $clientRegionTotal += $clientFiles.Count
    $serverRegionTotal += $serverFiles.Count
    $clientRegionBytes += [long](($clientFiles | Measure-Object Length -Sum).Sum)
    $serverRegionBytes += [long](($serverFiles | Measure-Object Length -Sum).Sum)
    $sourceMaps.Add([pscustomobject]@{
        Name = $name
        TargetName = $targetName
        ClientSource = $clientSource.FullName
        ServerSource = $serverSourcePath
        WorldSource = $worldPath
        MinimapSource = $minimapPath
    })
}

if ($sourceMaps.Count -ne $expectedMapCount -or
    $clientRegionTotal -ne $expectedClientRegions -or
    $serverRegionTotal -ne $expectedServerRegions) {
    throw "Seaweed inventory sai: maps=$($sourceMaps.Count)/$expectedMapCount, Region_C=$clientRegionTotal/$expectedClientRegions, Region_S=$serverRegionTotal/$expectedServerRegions."
}
if (@(Get-ChildItem -LiteralPath $SeaweedMapRoot -File -Filter '*.wor').Count -ne ($expectedWorldFiles + $excludedNames.Count) -or
    @(Get-ChildItem -LiteralPath $SeaweedMapRoot -File -Filter '*.jpg').Count -ne ($expectedMinimapFiles + $excludedNames.Count)) {
    throw 'So file WOR/JPG nguon khong khop inventory da tham dinh.'
}

$sourceNameSet = [Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
foreach ($map in $sourceMaps) { [void]$sourceNameSet.Add($map.Name) }
$results = New-Object Collections.Generic.List[object]
foreach ($runtimeRootInput in $RuntimeRoots) {
    $runtimeRoot = Resolve-SafeRoot $runtimeRootInput 'RuntimeRoot'
    $clientRoot = Join-Path $runtimeRoot 'Client'
    $serverRoot = Join-Path $runtimeRoot 'Server'
    $clientMaps = Join-Path $clientRoot 'maps'
    $serverMaps = Join-Path $serverRoot 'maps'
    foreach ($required in $clientMaps, $serverMaps) {
        if (-not (Test-Path -LiteralPath $required -PathType Container)) {
            throw "Runtime thieu thu muc maps: $required"
        }
    }

    $clientMetadataPath = Join-Path $clientRoot ([string]$mapRegistry.MetadataFile)
    $serverMetadataPath = Join-Path $serverRoot ([string]$mapRegistry.MetadataFile)
    if ((Get-FileHash -LiteralPath $clientMetadataPath -Algorithm SHA256).Hash -ne
        (Get-FileHash -LiteralPath $serverMetadataPath -Algorithm SHA256).Hash) {
        Copy-Item -LiteralPath $serverMetadataPath -Destination $clientMetadataPath -Force
    }
    if ((Get-FileHash -LiteralPath $clientMetadataPath -Algorithm SHA256).Hash -ne
        (Get-FileHash -LiteralPath $serverMetadataPath -Algorithm SHA256).Hash) {
        throw "Khong dong bo duoc WorldSet metadata tai $runtimeRoot"
    }
    $metadata = Read-MapMetadata $serverMetadataPath
    foreach ($id in $activeIds) {
        if (-not $metadata.ContainsKey($id) -or -not $sourceNameSet.Contains([string]$metadata[$id])) {
            throw "Map active $id khong co du lieu Seaweed hop le."
        }
    }

    Clear-MapRoot $clientMaps
    Clear-MapRoot $serverMaps
    foreach ($map in $sourceMaps) {
        Copy-Directory $map.ClientSource (Join-Path $clientMaps $map.TargetName)
        Copy-Directory $map.ServerSource (Join-Path $serverMaps ($map.TargetName + '_S'))
        Copy-Item -LiteralPath $map.WorldSource -Destination (Join-Path $clientMaps ($map.TargetName + '.wor')) -Force
        Copy-Item -LiteralPath $map.WorldSource -Destination (Join-Path $serverMaps ($map.TargetName + '.wor')) -Force
        Copy-Item -LiteralPath $map.MinimapSource -Destination (Join-Path $clientMaps ($map.TargetName + '24.jpg')) -Force
        Copy-Item -LiteralPath $map.MinimapSource -Destination (Join-Path $serverMaps ($map.TargetName + '24.jpg')) -Force
    }
    Write-ActiveWorldSet (Join-Path $clientMaps 'WorldSet.ini') $activeIds
    Write-ActiveWorldSet (Join-Path $serverMaps 'WorldSet.ini') $activeIds

    $clientRegions = @(Get-ChildItem -LiteralPath $clientMaps -Recurse -File -Filter '*_region_c.dat')
    $serverRegions = @(Get-ChildItem -LiteralPath $serverMaps -Recurse -File -Filter '*_region_s.dat')
    $clientWrong = @(Get-ChildItem -LiteralPath $clientMaps -Recurse -File -Filter '*_region_s.dat')
    $serverWrong = @(Get-ChildItem -LiteralPath $serverMaps -Recurse -File -Filter '*_region_c.dat')
    $clientDirectories = @(Get-ChildItem -LiteralPath $clientMaps -Directory)
    $serverDirectories = @(Get-ChildItem -LiteralPath $serverMaps -Directory)
    $clientWor = @(Get-ChildItem -LiteralPath $clientMaps -File -Filter '*.wor')
    $serverWor = @(Get-ChildItem -LiteralPath $serverMaps -File -Filter '*.wor')
    $clientJpg = @(Get-ChildItem -LiteralPath $clientMaps -File -Filter '*.jpg')
    $serverJpg = @(Get-ChildItem -LiteralPath $serverMaps -File -Filter '*.jpg')
    if ($clientRegions.Count -ne $expectedClientRegions -or
        $serverRegions.Count -ne $expectedServerRegions -or
        $clientWrong.Count -or $serverWrong.Count -or
        $clientDirectories.Count -ne $expectedMapCount -or
        $serverDirectories.Count -ne $expectedMapCount -or
        @($serverDirectories | Where-Object { -not $_.Name.EndsWith('_S', [StringComparison]::OrdinalIgnoreCase) }).Count -or
        $clientWor.Count -ne $expectedWorldFiles -or $serverWor.Count -ne $expectedWorldFiles -or
        $clientJpg.Count -ne $expectedMinimapFiles -or $serverJpg.Count -ne $expectedMinimapFiles -or
        [long](($clientRegions | Measure-Object Length -Sum).Sum) -ne $clientRegionBytes -or
        [long](($serverRegions | Measure-Object Length -Sum).Sum) -ne $serverRegionBytes) {
        throw "Runtime map validation that bai: $runtimeRoot"
    }

    $results.Add([pscustomobject]@{
        RuntimeRoot = $runtimeRoot
        PhysicalMaps = $sourceMaps.Count
        ActiveWorldIds = $activeIds.Count
        ClientRegionC = $clientRegions.Count
        ServerRegionS = $serverRegions.Count
        WorldFilesPerRole = $clientWor.Count
        MinimapFilesPerRole = $clientJpg.Count
        ExcludedSourceMaps = $excludedNames.Count
    })
    # The Seaweed geometry set contains empty NPC sections. Apply original VNG
    # populated Region_S payloads last; never erase them on a content rebuild.
    & (Join-Path $PSScriptRoot 'Import-VngNpcRegions.ps1') -ProjectRoot $projectRoot -RuntimeRoots @($runtimeRoot) -Apply | Out-Null
    $finalClientCount=@(Get-ChildItem -LiteralPath $clientMaps -Recurse -File -Filter '*_region_c.dat').Count
    $finalServerCount=@(Get-ChildItem -LiteralPath $serverMaps -Recurse -File -Filter '*_region_s.dat').Count
    if($finalClientCount -ne $mapRegistry.ExpectedClientRegions -or $finalServerCount -ne $mapRegistry.ExpectedServerRegions){throw 'Final original-NPC region inventory mismatch'}
    & (Join-Path $PSScriptRoot 'Publish-VngMinimap.ps1') -ProjectRoot $projectRoot -RoleRoot $clientRoot | Out-Null
    & (Join-Path $PSScriptRoot 'Publish-VngMinimap.ps1') -ProjectRoot $projectRoot -RoleRoot $serverRoot | Out-Null
    Update-ContentStoreManifest $runtimeRoot $ManifestPath
}

[pscustomobject]@{
    Result = 'PASS'
    Source = $SeaweedMapRoot
    Destinations = $results.ToArray()
    DeriveRegionS = $false
    MixedRoleFiles = 0
}
