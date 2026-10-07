[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [string]$RoleRoot,
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = 'Stop'
[Text.Encoding]::RegisterProvider([Text.CodePagesEncodingProvider]::Instance)
$cp936 = [Text.Encoding]::GetEncoding(936)
$RoleRoot = [IO.Path]::GetFullPath($RoleRoot).TrimEnd('\')
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')

if (-not (Test-Path -LiteralPath $RoleRoot -PathType Container)) {
    throw "Role root khong ton tai: $RoleRoot"
}

# Canonical player growth/base tables extracted from the VNG settings set.
# Keep this as an exact byte-for-byte project overlay so rebuilding the content
# store cannot silently restore the old SwordOnline tables or omit PlayerSet.
$playerSettingsSource = Join-Path $ProjectRoot 'Deploy\ProjectContent\settings\npc\player'
$playerSettingsTarget = Join-Path $RoleRoot 'settings\npc\player'
$playerSettings = @(
    'level_exp.txt',
    'level_add.txt',
    'level_lead_exp.txt',
    'newplayerbaseattribute.ini',
    'pkpunish.txt'
)
New-Item -ItemType Directory -Path $playerSettingsTarget -Force | Out-Null
foreach ($name in $playerSettings) {
    $source = Join-Path $playerSettingsSource $name
    if (-not (Test-Path -LiteralPath $source -PathType Leaf)) {
        throw "Thieu bang player VNG: $source"
    }
    Copy-Item -LiteralPath $source -Destination (Join-Path $playerSettingsTarget $name) -Force
}

# Keep creation profiles aligned with the canonical VNG profession skill ids.
& (Join-Path $ProjectRoot 'Deploy\Set-PhongThanProfessionSkills.ps1') `
    -RoleRoot $RoleRoot | Out-Null

# CoreServer requires these Lua entry points. Always replace the imported
# SwordOnline/private-server bootstraps with project-owned Phong Than files.
# Static entities continue to load through Region_S -> NpcSet.
$bootstrapFiles = @(
    'script\gmscript.lua',
    'script\serverscript.lua',
    'script\servertimer.lua',
    'script\global\script_protocol.lua'
)
foreach ($relative in $bootstrapFiles) {
    $source = Join-Path (Join-Path $ProjectRoot 'Deploy\ProjectContent') $relative
    $target = Join-Path $RoleRoot $relative
    if (-not (Test-Path -LiteralPath $source -PathType Leaf)) {
        throw "Thieu Phong Than Lua bootstrap: $source"
    }
    $text = [IO.File]::ReadAllText($source, [Text.Encoding]::ASCII)
    if ($text -match '(?i)volam|vltk|tongkim|shaolin|wudang|anhvietdongnai') {
        throw "Lua bootstrap con noi dung Vo Lam: $source"
    }
    [IO.Directory]::CreateDirectory((Split-Path -Parent $target)) | Out-Null
    [IO.File]::WriteAllText($target, $text, $cp936)
}
$timerTarget = Join-Path $RoleRoot 'script\servertimer.lua'

# Build the talisman menu from real map metadata and real Region files. The
# first active ID for each physical map is used so duplicate aliases are hidden.
$wildSuperTemplatePath = Join-Path $ProjectRoot 'Deploy\ProjectContent\script\item\ibitem\di_ngoai_phu.lua.template'
$worldMetadataPath = Join-Path $RoleRoot 'settings\WorldSet.ini'
$activeWorldPath = Join-Path $RoleRoot 'maps\WorldSet.ini'
foreach ($requiredPath in $wildSuperTemplatePath, $worldMetadataPath, $activeWorldPath) {
    if (-not (Test-Path -LiteralPath $requiredPath -PathType Leaf)) {
        throw "Thieu du lieu tao Di Ngoai Phu: $requiredPath"
    }
}

$metadataNames = @{}
$displayNames = @{}
foreach ($metadataLine in [IO.File]::ReadAllLines($worldMetadataPath, $cp936)) {
    $nameMatch = [regex]::Match($metadataLine, '^\s*(?<id>\d+)\s*=\s*(?<value>[^;\r\n]+?)\s*$')
    if ($nameMatch.Success) {
        $metadataNames[[int]$nameMatch.Groups['id'].Value] = $nameMatch.Groups['value'].Value.Trim()
        continue
    }
    $displayMatch = [regex]::Match($metadataLine, '^\s*(?<id>\d+)_name\s*=\s*(?<value>[^;\r\n]+?)\s*$')
    if ($displayMatch.Success) {
        $displayNames[[int]$displayMatch.Groups['id'].Value] = $displayMatch.Groups['value'].Value.Trim()
    }
}

$activeWorldIds = @([IO.File]::ReadAllLines($activeWorldPath, $cp936) | ForEach-Object {
    $match = [regex]::Match($_, '^\s*World\d+\s*=\s*(?<id>\d+)\s*$')
    if ($match.Success) { [int]$match.Groups['id'].Value }
})
if (-not $activeWorldIds.Count) { throw "Khong tim thay map active: $activeWorldPath" }

$latin1 = [Text.Encoding]::GetEncoding(28591)
$physicalNames = [Collections.Generic.HashSet[string]]::new([StringComparer]::OrdinalIgnoreCase)
$mapRows = [Collections.Generic.List[string]]::new()
$isServerRole = (Split-Path -Leaf $RoleRoot) -ieq 'Server'
$regionSuffix = if ($isServerRole) { '_region_s.dat' } else { '_region_c.dat' }
foreach ($worldId in $activeWorldIds) {
    if (-not $metadataNames.ContainsKey($worldId)) {
        throw "WorldSet metadata thieu map $worldId"
    }
    $physicalName = [string]$metadataNames[$worldId]
    if (-not $physicalNames.Add($physicalName)) { continue }

    $runtimeName = if ($physicalName -match '[^\x00-\x7f]') {
        $latin1.GetString($cp936.GetBytes($physicalName))
    } else { $physicalName }
    $mapDirectoryName = $runtimeName + $(if ($isServerRole) { '_S' } else { '' })
    $mapDirectory = Join-Path (Join-Path $RoleRoot 'maps') $mapDirectoryName
    if (-not (Test-Path -LiteralPath $mapDirectory -PathType Container)) {
        throw "Khong tim thay thu muc map $worldId`: $mapDirectory"
    }

    $regions = @(
        Get-ChildItem -LiteralPath $mapDirectory -Recurse -File -Filter "*$regionSuffix" | ForEach-Object {
            $xMatch = [regex]::Match($_.Directory.Name, '^v_(?<x>\d+)$')
            $yMatch = [regex]::Match($_.Name, '^(?<y>\d+)_region_[cs]\.dat$', [Text.RegularExpressions.RegexOptions]::IgnoreCase)
            if ($xMatch.Success -and $yMatch.Success) {
                [pscustomobject]@{ X = [int]$xMatch.Groups['x'].Value; Y = [int]$yMatch.Groups['y'].Value }
            }
        }
    )
    if (-not $regions.Count) { throw "Map $worldId khong co Region hop le: $mapDirectory" }
    $averageX = ($regions | Measure-Object X -Average).Average
    $averageY = ($regions | Measure-Object Y -Average).Average
    $centerRegion = $regions | Sort-Object `
        @{ Expression = { ($_.X - $averageX) * ($_.X - $averageX) + ($_.Y - $averageY) * ($_.Y - $averageY) } }, `
        X, Y | Select-Object -First 1
    $mapX = $centerRegion.X * 16 + 8
    $mapY = $centerRegion.Y * 32 + 16
    $label = if ($displayNames.ContainsKey($worldId)) { [string]$displayNames[$worldId] } else { "Phong Than $worldId" }
    $label = $label.Replace('"', "'").Replace('\', '/')
    $mapRows.Add(('    {{{0},{1},{2},"{3}"}},' -f $worldId, $mapX, $mapY, $label))
}
if ($mapRows.Count -ne 91) {
    throw "Di Ngoai Phu can 91 map vat ly, tim thay $($mapRows.Count)."
}

$wildSuperTemplate = [IO.File]::ReadAllText($wildSuperTemplatePath, [Text.Encoding]::ASCII)
$wildSuperSpecs = @(
    @{ RelativePath = 'script\item\ibitem\wildsuper.lua'; Detail = 35; Prefix = 'Wild' },
    @{ RelativePath = 'script\item\ibitem\bigwildsuper.lua'; Detail = 159; Prefix = 'BigWild' }
)
foreach ($spec in $wildSuperSpecs) {
    $wildSuperPath = Join-Path $RoleRoot $spec.RelativePath
    New-Item -ItemType Directory -Path (Split-Path -Parent $wildSuperPath) -Force | Out-Null
    $wildSuperText = $wildSuperTemplate.Replace('__MAP_ROWS__', ($mapRows -join "`r`n"))
    $wildSuperText = $wildSuperText.Replace('__ITEM_DETAIL__', [string]$spec.Detail)
    $wildSuperText = $wildSuperText.Replace('__FUNCTION_PREFIX__', [string]$spec.Prefix)
    if ($wildSuperText -match '__[A-Z_]+__' -or
        ([regex]::Matches($wildSuperText, '(?m)^\s*\{\d+,\d+,\d+,"')).Count -ne 91) {
        throw "Khong tao duoc Lua Di Ngoai Phu day du: $wildSuperPath"
    }
    [IO.File]::WriteAllText($wildSuperPath, $wildSuperText, $cp936)
}

if ((Split-Path -Leaf $RoleRoot) -ieq 'Client') {
    # ProjectContent is the authoritative loose UI overlay.  These files are
    # exact VNG/Seaweed payloads (kept byte-for-byte, including CP936 paths),
    # so a future content-store rebuild cannot restore the reduced Vo Lam HUD.
    $uiSourceRoot = Join-Path $ProjectRoot 'Deploy\ProjectContent\Ui\ui3'
    $uiTargetRoot = Join-Path $RoleRoot 'Ui\ui3'
    if (-not (Test-Path -LiteralPath $uiSourceRoot -PathType Container)) {
        throw "Thieu ProjectContent UI3: $uiSourceRoot"
    }
    New-Item -ItemType Directory -Path $uiTargetRoot -Force | Out-Null
    foreach ($uiSource in Get-ChildItem -LiteralPath $uiSourceRoot -File -Force) {
        Copy-Item -LiteralPath $uiSource.FullName `
            -Destination (Join-Path $uiTargetRoot $uiSource.Name) -Force
    }
    $obsoleteToolbar = Join-Path $uiTargetRoot 'UiToolsControlBar.ini'
    if (Test-Path -LiteralPath $obsoleteToolbar -PathType Leaf) {
        Remove-Item -LiteralPath $obsoleteToolbar -Force
    }
}

& (Join-Path $PSScriptRoot 'Publish-NpcRestoration.ps1') -ProjectRoot $ProjectRoot -RoleRoot $RoleRoot

# Remove the obsolete Vo Lam guide grant without modifying any other login logic.
$playerLogin = Join-Path $RoleRoot 'script\player\playerlogin.lua'
if (Test-Path -LiteralPath $playerLogin -PathType Leaf) {
    $loginText = [IO.File]::ReadAllText($playerLogin, $cp936)
    $legacyPattern = '(?ms)^if\s+GetItemCount\(0,6,4813\)\s*<\s*1\s*then.*?^end;\s*\r?\n'
    $loginText = [regex]::Replace($loginText, $legacyPattern, '')
    if ($loginText -match 'GetItemCount\(0,6,4813\)') {
        throw "Khong loai bo duoc block cap cam nang Vo Lam 4813: $playerLogin"
    }
    [IO.File]::WriteAllText($playerLogin, $loginText, $cp936)
}

[pscustomobject]@{
    Result = 'PASS'
    RoleRoot = $RoleRoot
    MagicScriptKey = [int]$item.Key
    Lua = $luaTarget
    ServerTimer = $timerTarget
    Provenance = [string]$item.Provenance
}
