[CmdletBinding()]
param(
    [string]$SourceRuntime,
    [string]$ContentRoot,
    [string]$StateRoot,
    [string]$ManifestPath = (Join-Path $PSScriptRoot 'RUNTIME_CONTENT_MANIFEST.json'),
    [switch]$ReplaceState
)

$ErrorActionPreference = 'Stop'
$projectRoot = [IO.Path]::GetFullPath((Split-Path -Parent $PSScriptRoot)).TrimEnd('\')
$projectParent = Split-Path -Parent $projectRoot
if (-not $SourceRuntime) { $SourceRuntime = Join-Path $projectParent 'PhongThanRuntime-Staging' }
if (-not $ContentRoot) { $ContentRoot = Join-Path $projectParent 'PhongThanRuntime-Content' }
if (-not $StateRoot) { $StateRoot = Join-Path $projectParent 'PhongThanRuntime-State' }
$SourceRuntime = [IO.Path]::GetFullPath($SourceRuntime).TrimEnd('\')
$ContentRoot = [IO.Path]::GetFullPath($ContentRoot).TrimEnd('\')
$StateRoot = [IO.Path]::GetFullPath($StateRoot).TrimEnd('\')
$ManifestPath = [IO.Path]::GetFullPath($ManifestPath)

function Assert-SafeDirectory([string]$Path, [string]$Label) {
    $root = [IO.Path]::GetPathRoot($Path).TrimEnd('\')
    if (-not $Path -or $Path.TrimEnd('\') -ieq $root) {
        throw "$Label khong duoc la thu muc goc o dia: $Path"
    }
}

function Test-ForbiddenName([string]$Name, $Manifest) {
    foreach ($pattern in $Manifest.ForbiddenFilePatterns) {
        if ($Name -match $pattern) { return $true }
    }
    return $false
}

function Copy-CleanDirectory([string]$Source, [string]$Destination, $Manifest) {
    if (-not (Test-Path -LiteralPath $Source -PathType Container)) {
        throw "Thieu thu muc noi dung bat buoc: $Source"
    }
    New-Item -ItemType Directory -Path $Destination -Force | Out-Null
    & robocopy $Source $Destination /E /COPY:DAT /DCOPY:DAT /R:1 /W:1 /XJ /NFL /NDL /NP | Out-Null
    if ($LASTEXITCODE -gt 7) { throw "Robocopy that bai ($LASTEXITCODE): $Source" }
    $junk = @(Get-ChildItem -LiteralPath $Destination -Recurse -File -Force |
        Where-Object { Test-ForbiddenName $_.Name $Manifest })
    foreach ($file in $junk) {
        Remove-Item -LiteralPath $file.FullName -Force
    }
}

function Copy-StateDirectory([string]$Source, [string]$Destination, $Manifest) {
    New-Item -ItemType Directory -Path $Destination -Force | Out-Null
    if (-not (Test-Path -LiteralPath $Source -PathType Container)) { return }
    # Berkeley DB state is stored directly in each named directory. Do not
    # promote dated backup subdirectories into the canonical live state.
    foreach ($file in Get-ChildItem -LiteralPath $Source -File -Force) {
        if (-not (Test-ForbiddenName $file.Name $Manifest)) {
            Copy-Item -LiteralPath $file.FullName -Destination (Join-Path $Destination $file.Name) -Force
        }
    }
}

function Remove-InactiveDataVersions([string]$SettingsRoot, $Registry) {
    if (-not $Registry) { throw 'Manifest thieu DataRegistries.Item.' }
    $itemRoot = [IO.Path]::GetFullPath((Join-Path $SettingsRoot 'item')).TrimEnd('\')
    if (-not (Test-Path -LiteralPath $itemRoot -PathType Container)) { return }
    $activeName = Split-Path -Leaf ([string]$Registry.ActiveDirectory)
    foreach ($directory in Get-ChildItem -LiteralPath $itemRoot -Directory -Force) {
        if ($directory.Name -notmatch '^\d{3}$' -or $directory.Name -eq $activeName) { continue }
        $resolved = [IO.Path]::GetFullPath($directory.FullName).TrimEnd('\')
        if (-not $resolved.StartsWith($itemRoot + '\', [StringComparison]::OrdinalIgnoreCase) -or
            (Split-Path -Parent $resolved) -ine $itemRoot) {
            throw "Tu choi xoa item version ngoai item root: $resolved"
        }
        Remove-Item -LiteralPath $resolved -Recurse -Force
    }
}

function Remove-PakShadowedSprites([string]$ClientRoot, $SpriteRegistry) {
    if (-not $SpriteRegistry) { throw 'Manifest thieu DataRegistries.Gameplay.Sprite.' }
    $shadowRoot = [IO.Path]::GetFullPath((Join-Path $ClientRoot ([string]$SpriteRegistry.PakShadowRoot))).TrimEnd('\')
    if (-not $shadowRoot.StartsWith($ClientRoot + '\', [StringComparison]::OrdinalIgnoreCase)) {
        throw "SPR shadow root nam ngoai client root: $shadowRoot"
    }
    if (-not (Test-Path -LiteralPath $shadowRoot -PathType Container)) {
        throw "Thieu SPR shadow root: $shadowRoot"
    }

    $fallbacks = @($SpriteRegistry.LooseFallbacks | ForEach-Object {
        [IO.Path]::GetFullPath((Join-Path $ClientRoot ([string]$_)))
    })
    foreach ($fallback in $fallbacks) {
        if (-not $fallback.StartsWith($shadowRoot + '\', [StringComparison]::OrdinalIgnoreCase) -or
            -not (Test-Path -LiteralPath $fallback -PathType Leaf)) {
            throw "SPR fallback khong hop le: $fallback"
        }
    }

    $looseFiles = @(Get-ChildItem -LiteralPath $shadowRoot -Recurse -File -Filter *.spr)
    $expectedSourceCounts = @([int]$SpriteRegistry.ExpectedAuditedLooseFiles, $fallbacks.Count)
    if ($looseFiles.Count -notin $expectedSourceCounts) {
        throw "So SPR loose human bat ngo: $($looseFiles.Count); yeu cau $($expectedSourceCounts -join ' hoac ')."
    }
    foreach ($file in $looseFiles) {
        if ($fallbacks -notcontains [IO.Path]::GetFullPath($file.FullName)) {
            Remove-Item -LiteralPath $file.FullName -Force
        }
    }

    $remaining = @(Get-ChildItem -LiteralPath $shadowRoot -Recurse -File -Filter *.spr)
    if ($remaining.Count -ne $fallbacks.Count) {
        throw "SPR loose human sau loc con $($remaining.Count), yeu cau $($fallbacks.Count)."
    }
}

function Set-ActiveWorldSet([string]$RoleRoot, $MapRegistry) {
    if (-not $MapRegistry) { throw 'Manifest thieu DataRegistries.Gameplay.Map.' }
    $expectedIds = @($MapRegistry.ExpectedActiveMapIds | ForEach-Object { [int]$_ })
    if ($expectedIds.Count -ne [int]$MapRegistry.ExpectedActiveMapCount) {
        throw "ExpectedActiveMapIds khong khop ExpectedActiveMapCount=$($MapRegistry.ExpectedActiveMapCount)."
    }
    if (@($expectedIds | Sort-Object -Unique).Count -ne $expectedIds.Count) {
        throw 'ExpectedActiveMapIds co map id trung lap.'
    }
    $relative = [string]$MapRegistry.ServerActivationFile
    $target = [IO.Path]::GetFullPath((Join-Path $RoleRoot $relative))
    if (-not $target.StartsWith($RoleRoot + '\', [StringComparison]::OrdinalIgnoreCase)) {
        throw "WorldSet activation nam ngoai role root: $target"
    }
    New-Item -ItemType Directory -Path (Split-Path -Parent $target) -Force | Out-Null
    $lines = New-Object System.Collections.Generic.List[string]
    $lines.Add('[Init]')
    $lines.Add("Count=$($expectedIds.Count)")
    $lines.Add('[World]')
    for ($slot = 0; $slot -lt $expectedIds.Count; $slot++) {
        $lines.Add(('World{0:D3}={1}' -f $slot, $expectedIds[$slot]))
    }
    [IO.File]::WriteAllText(
        $target,
        (($lines -join "`r`n") + "`r`n"),
        [Text.Encoding]::GetEncoding(936)
    )
}

function Set-LocalServiceTopology([string]$ServerRoot, $RuntimeSettings) {
    $address = [string]$RuntimeSettings.LocalServiceAddress
    if (-not $address) { throw 'Manifest thieu RuntimeSettings.LocalServiceAddress.' }
    $targets = @(
        @{ File = 'Bishop.cfg'; Pattern = '(?im)^(AccSvrIP|RoleSvrIP|GameSvrIP)\s*=.*$'; Replacement = "`$1=$address"; Minimum = 3 },
        @{ File = 'relay_config.ini'; Pattern = '(?im)^address\s*=.*$'; Replacement = "address=$address"; Minimum = 4 },
        @{ File = 'ServerCfg.ini'; Pattern = '(?im)^(Ip|IntranetIp|InternetIp)\s*=.*$'; Replacement = "`$1=$address"; Minimum = 8 },
        @{ File = 'server.ini'; Pattern = '(?im)^IP\s*=.*$'; Replacement = "IP=$address"; Minimum = 1 }
    )
    foreach ($target in $targets) {
        $path = Join-Path $ServerRoot ([string]$target.File)
        if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
            throw "Thieu topology config: $path"
        }
        $text = [IO.File]::ReadAllText($path, [Text.Encoding]::GetEncoding(936))
        $matches = [regex]::Matches($text, [string]$target.Pattern).Count
        if ($matches -lt [int]$target.Minimum) {
            throw "Topology config $($target.File) chi co $matches key, yeu cau $($target.Minimum)."
        }
        $text = [regex]::Replace($text, [string]$target.Pattern, [string]$target.Replacement)
        [IO.File]::WriteAllText($path, $text, [Text.Encoding]::GetEncoding(936))
    }
}

function Remove-LegacyGameplayContent([string]$RoleRoot, [string]$Role, $GameplayRegistry) {
    if (-not $GameplayRegistry) { throw 'Manifest thieu DataRegistries.Gameplay.' }
    $canonicalNpc = [IO.Path]::GetFullPath((Join-Path $RoleRoot ([string]$GameplayRegistry.Npc.Table)))
    if (-not $canonicalNpc.StartsWith($RoleRoot + '\', [StringComparison]::OrdinalIgnoreCase)) {
        throw "NPC registry chuan nam ngoai role root: $canonicalNpc"
    }
    $aliasPaths = @($GameplayRegistry.Npc.ForbiddenAliases | ForEach-Object {
        [IO.Path]::GetFullPath((Join-Path $RoleRoot ([string]$_)))
    })
    foreach ($path in $aliasPaths) {
        if (-not $path.StartsWith($RoleRoot + '\', [StringComparison]::OrdinalIgnoreCase)) {
            throw "Tu choi xoa NPC alias ngoai role root: $path"
        }
    }
    if (-not (Test-Path -LiteralPath $canonicalNpc -PathType Leaf)) {
        $sourceAlias = @($aliasPaths | Where-Object { Test-Path -LiteralPath $_ -PathType Leaf } | Select-Object -First 1)
        if (-not $sourceAlias.Count) {
            throw "Khong co bang NPC VNG de chuyen vao registry chuan: $canonicalNpc"
        }
        New-Item -ItemType Directory -Path (Split-Path -Parent $canonicalNpc) -Force | Out-Null
        Copy-Item -LiteralPath $sourceAlias[0] -Destination $canonicalNpc -Force
    }
    $canonicalHash = (Get-FileHash -LiteralPath $canonicalNpc -Algorithm SHA256).Hash
    foreach ($path in $aliasPaths) {
        if (Test-Path -LiteralPath $path -PathType Leaf) {
            if ((Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash -ne $canonicalHash) {
                throw "NPC alias khac byte registry chuan: $path"
            }
            Remove-Item -LiteralPath $path -Force
        }
    }
}

Assert-SafeDirectory $SourceRuntime 'SourceRuntime'
Assert-SafeDirectory $ContentRoot 'ContentRoot'
Assert-SafeDirectory $StateRoot 'StateRoot'
if ($SourceRuntime -ieq $ContentRoot -or $SourceRuntime -ieq $StateRoot -or $ContentRoot -ieq $StateRoot) {
    throw 'SourceRuntime, ContentRoot va StateRoot phai la ba thu muc rieng.'
}
if ($SourceRuntime.StartsWith($ContentRoot + '\', [StringComparison]::OrdinalIgnoreCase) -or
    $ContentRoot.StartsWith($SourceRuntime + '\', [StringComparison]::OrdinalIgnoreCase) -or
    $SourceRuntime.StartsWith($StateRoot + '\', [StringComparison]::OrdinalIgnoreCase) -or
    $StateRoot.StartsWith($SourceRuntime + '\', [StringComparison]::OrdinalIgnoreCase) -or
    $ContentRoot.StartsWith($StateRoot + '\', [StringComparison]::OrdinalIgnoreCase) -or
    $StateRoot.StartsWith($ContentRoot + '\', [StringComparison]::OrdinalIgnoreCase)) {
    throw 'SourceRuntime, ContentRoot va StateRoot khong duoc nam long nhau.'
}
if (-not (Test-Path -LiteralPath $ManifestPath -PathType Leaf)) {
    throw "Thieu runtime manifest: $ManifestPath"
}
$manifest = Get-Content -LiteralPath $ManifestPath -Raw | ConvertFrom-Json
if ($manifest.Schema -ne 1) { throw "Runtime manifest schema khong ho tro: $($manifest.Schema)" }
foreach ($role in 'Client', 'Server') {
    if (-not (Test-Path -LiteralPath (Join-Path $SourceRuntime $role) -PathType Container)) {
        throw "SourceRuntime thieu role: $role"
    }
}

if (Test-Path -LiteralPath $ContentRoot) {
    $resolvedContent = [IO.Path]::GetFullPath($ContentRoot).TrimEnd('\')
    if ($resolvedContent -ne $ContentRoot) { throw "ContentRoot khong on dinh: $ContentRoot" }
    Remove-Item -LiteralPath $ContentRoot -Recurse -Force
}
New-Item -ItemType Directory -Path $ContentRoot, $StateRoot -Force | Out-Null

$groups = New-Object System.Collections.Generic.List[object]
$critical = New-Object System.Collections.Generic.List[object]
foreach ($role in 'Client', 'Server') {
    $roleConfig = $manifest.Roles.$role
    $sourceRole = Join-Path $SourceRuntime $role
    $contentRole = Join-Path $ContentRoot $role
    New-Item -ItemType Directory -Path $contentRole -Force | Out-Null

    foreach ($relative in $roleConfig.ContentDirectories) {
        $source = Join-Path $sourceRole $relative
        $destination = Join-Path $contentRole $relative
        Copy-CleanDirectory $source $destination $manifest
        if ($relative -ieq 'settings') {
            Remove-InactiveDataVersions $destination $manifest.DataRegistries.Item
        }
        if ($role -eq 'Client' -and $relative -ieq 'Spr') {
            Remove-PakShadowedSprites $contentRole $manifest.DataRegistries.Gameplay.Sprite
        }
        $files = @(Get-ChildItem -LiteralPath $destination -Recurse -File -Force)
        $groups.Add([pscustomobject]@{
            Role = $role
            Path = $relative
            FileCount = $files.Count
            Bytes = [long](($files | Measure-Object Length -Sum).Sum)
        })
        if ($relative -ieq 'data' -or $relative -ieq 'pak') {
            foreach ($file in Get-ChildItem -LiteralPath $destination -File -Force) {
                $critical.Add([pscustomobject]@{
                    Role = $role
                    Path = "$relative\$($file.Name)"
                    Length = $file.Length
                    Sha256 = (Get-FileHash -LiteralPath $file.FullName -Algorithm SHA256).Hash
                })
            }
        }
    }

    $contentFiles = @(@($roleConfig.ContentFiles) + @($roleConfig.MutableContentFiles) |
        Where-Object { $_ })
    foreach ($relative in $contentFiles) {
        $source = Join-Path $sourceRole $relative
        if (-not (Test-Path -LiteralPath $source -PathType Leaf)) {
            throw "Thieu file noi dung bat buoc: $source"
        }
        if (Test-ForbiddenName ([IO.Path]::GetFileName($relative)) $manifest) {
            throw "Manifest cho phep mot file bi cam: $role\$relative"
        }
        $destination = Join-Path $contentRole $relative
        $parent = Split-Path -Parent $destination
        if ($parent) { New-Item -ItemType Directory -Path $parent -Force | Out-Null }
        Copy-Item -LiteralPath $source -Destination $destination -Force
        $item = Get-Item -LiteralPath $destination
        if ($roleConfig.MutableContentFiles -notcontains $relative) {
            $critical.Add([pscustomobject]@{
                Role = $role
                Path = $relative
                Length = $item.Length
                Sha256 = (Get-FileHash -LiteralPath $item.FullName -Algorithm SHA256).Hash
            })
        }
    }

    & (Join-Path $projectRoot 'Deploy\Apply-ProjectGameplayExtensions.ps1') `
        -RoleRoot $contentRole -ProjectRoot $projectRoot | Out-Null

    # Client va server dung cung mot tap kich hoat. Metadata WorldSet trong
    # settings van giu day du de mo rong khi Region_S VNG goc duoc bo sung.
    Set-ActiveWorldSet $contentRole $manifest.DataRegistries.Gameplay.Map
    if ($role -eq 'Server') {
        Set-LocalServiceTopology $contentRole $manifest.RuntimeSettings
    }

    Remove-LegacyGameplayContent $contentRole $role $manifest.DataRegistries.Gameplay

    foreach ($relative in $roleConfig.StateDirectories) {
        $sourceState = Join-Path $sourceRole $relative
        $destination = Join-Path (Join-Path $StateRoot $role) $relative
        if ($ReplaceState -and (Test-Path -LiteralPath $destination)) {
            if (Test-Path -LiteralPath $sourceState) {
                $sourceItem = Get-Item -LiteralPath $sourceState -Force
                if (($sourceItem.Attributes -band [IO.FileAttributes]::ReparsePoint) -ne 0) {
                    foreach ($target in @($sourceItem.Target)) {
                        if ($target -and ([IO.Path]::GetFullPath($target).TrimEnd('\') -ieq $destination)) {
                            throw "Khong the ReplaceState tu junction tro ve chinh no: $sourceState"
                        }
                    }
                }
            }
            Remove-Item -LiteralPath $destination -Recurse -Force
        }
        if (-not (Test-Path -LiteralPath $destination)) {
            Copy-StateDirectory $sourceState $destination $manifest
        }
    }
}

& (Join-Path $projectRoot 'Deploy\Import-VngSkillLevelScripts.ps1') `
    -SourceClientRoot (Join-Path $SourceRuntime 'Client') `
    -SourceServerRoot (Join-Path $SourceRuntime 'Server') `
    -DestinationClientRoot (Join-Path $ContentRoot 'Client') `
    -DestinationServerRoot (Join-Path $ContentRoot 'Server') `
    -ProjectRoot $projectRoot | Out-Null

& (Join-Path $projectRoot 'Deploy\Import-VngGameplayMaps.ps1') `
    -SeaweedMapRoot (Join-Path $projectParent 'SeaweedUnpack_SprView\SeaweedUnpack_SprView\KetQua_Unpack_Maps\maps') `
    -RuntimeRoots @($ContentRoot) `
    -ManifestPath $ManifestPath | Out-Null

foreach ($role in 'Client', 'Server') {
    $mapRoot = Join-Path (Join-Path $ContentRoot $role) 'maps'
    $mapFiles = @(Get-ChildItem -LiteralPath $mapRoot -Recurse -File -Force)
    $mapGroup = @($groups | Where-Object { $_.Role -eq $role -and $_.Path -ieq 'maps' })
    if ($mapGroup.Count -ne 1) { throw "Khong tim thay map group duy nhat cho $role." }
    $mapGroup[0].FileCount = $mapFiles.Count
    $mapGroup[0].Bytes = [long](($mapFiles | Measure-Object Length -Sum).Sum)
}

& (Join-Path $projectRoot 'Tests\Test-DataRegistry.ps1') `
    -DataRoot $ContentRoot -ProjectRoot $projectRoot -ManifestPath $ManifestPath | Out-Null
& (Join-Path $projectRoot 'Tests\Test-GameplayDataRegistry.ps1') `
    -DataRoot $ContentRoot -ProjectRoot $projectRoot -ManifestPath $ManifestPath | Out-Null
& (Join-Path $projectRoot 'Tests\Test-VngHudUi.ps1') `
    -DataRoot $ContentRoot -ProjectRoot $projectRoot | Out-Null

$storeManifest = [ordered]@{
    Schema = 1
    CreatedAtUtc = [DateTime]::UtcNow.ToString('o')
    SourceManifest = $ManifestPath
    SourceManifestSha256 = (Get-FileHash -LiteralPath $ManifestPath -Algorithm SHA256).Hash
    ContentRoot = $ContentRoot
    StateRoot = $StateRoot
    Groups = @($groups | ForEach-Object { $_ })
    CriticalFiles = @($critical | ForEach-Object { $_ })
}
$storeManifestPath = Join-Path $ContentRoot 'CONTENT_STORE_MANIFEST.json'
[IO.File]::WriteAllText(
    $storeManifestPath,
    ($storeManifest | ConvertTo-Json -Depth 6),
    (New-Object Text.UTF8Encoding($false))
)

[pscustomobject]@{
    ContentRoot = $ContentRoot
    StateRoot = $StateRoot
    ContentGroups = $groups.Count
    CriticalFiles = $critical.Count
    StoreManifest = $storeManifestPath
}
