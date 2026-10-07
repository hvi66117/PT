[CmdletBinding()]
param(
    [string]$ContentRoot,
    [string]$StateRoot,
    [string]$StagingRuntime,
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$ManifestPath = (Join-Path $PSScriptRoot 'RUNTIME_CONTENT_MANIFEST.json')
)

$ErrorActionPreference = 'Stop'
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
$projectParent = Split-Path -Parent $ProjectRoot
if (-not $ContentRoot) { $ContentRoot = Join-Path $projectParent 'PhongThanRuntime-Content' }
if (-not $StateRoot) { $StateRoot = Join-Path $projectParent 'PhongThanRuntime-State' }
if (-not $StagingRuntime) { $StagingRuntime = Join-Path $projectParent 'PhongThanRuntime-Staging' }
$ContentRoot = [IO.Path]::GetFullPath($ContentRoot).TrimEnd('\')
$StateRoot = [IO.Path]::GetFullPath($StateRoot).TrimEnd('\')
$StagingRuntime = [IO.Path]::GetFullPath($StagingRuntime).TrimEnd('\')
$ManifestPath = [IO.Path]::GetFullPath($ManifestPath)

function Assert-SafeDirectory([string]$Path, [string]$Label) {
    $root = [IO.Path]::GetPathRoot($Path).TrimEnd('\')
    if (-not $Path -or $Path.TrimEnd('\') -ieq $root) {
        throw "$Label khong duoc la thu muc goc o dia: $Path"
    }
}

function Copy-AllowlistedDirectory([string]$Source, [string]$Destination) {
    if (-not (Test-Path -LiteralPath $Source -PathType Container)) {
        throw "Thieu thu muc trong content store: $Source"
    }
    New-Item -ItemType Directory -Path $Destination -Force | Out-Null
    & robocopy $Source $Destination /E /COPY:DAT /DCOPY:DAT /R:1 /W:1 /XJ /NFL /NDL /NP | Out-Null
    if ($LASTEXITCODE -gt 7) { throw "Robocopy that bai ($LASTEXITCODE): $Source" }
}

Assert-SafeDirectory $ContentRoot 'ContentRoot'
Assert-SafeDirectory $StateRoot 'StateRoot'
Assert-SafeDirectory $StagingRuntime 'StagingRuntime'
if ($ContentRoot -ieq $StateRoot -or $ContentRoot -ieq $StagingRuntime -or $StateRoot -ieq $StagingRuntime) {
    throw 'ContentRoot, StateRoot va StagingRuntime phai la ba thu muc rieng.'
}
if ($StagingRuntime.StartsWith($ContentRoot + '\', [StringComparison]::OrdinalIgnoreCase) -or
    $ContentRoot.StartsWith($StagingRuntime + '\', [StringComparison]::OrdinalIgnoreCase) -or
    $StagingRuntime.StartsWith($StateRoot + '\', [StringComparison]::OrdinalIgnoreCase) -or
    $StateRoot.StartsWith($StagingRuntime + '\', [StringComparison]::OrdinalIgnoreCase) -or
    $ContentRoot.StartsWith($StateRoot + '\', [StringComparison]::OrdinalIgnoreCase) -or
    $StateRoot.StartsWith($ContentRoot + '\', [StringComparison]::OrdinalIgnoreCase)) {
    throw 'ContentRoot, StateRoot va StagingRuntime khong duoc nam long nhau.'
}
if ($StagingRuntime.StartsWith($ProjectRoot + '\', [StringComparison]::OrdinalIgnoreCase)) {
    throw 'StagingRuntime khong duoc nam ben trong source repository.'
}
foreach ($required in $ManifestPath, (Join-Path $ContentRoot 'CONTENT_STORE_MANIFEST.json')) {
    if (-not (Test-Path -LiteralPath $required -PathType Leaf)) { throw "Thieu: $required" }
}
$manifest = Get-Content -LiteralPath $ManifestPath -Raw | ConvertFrom-Json
if ($manifest.Schema -ne 1) { throw "Runtime manifest schema khong ho tro: $($manifest.Schema)" }
$storeManifestPath = Join-Path $ContentRoot 'CONTENT_STORE_MANIFEST.json'
$store = Get-Content -LiteralPath $storeManifestPath -Raw | ConvertFrom-Json
$manifestHash = (Get-FileHash -LiteralPath $ManifestPath -Algorithm SHA256).Hash
if ($store.SourceManifestSha256 -ne $manifestHash) {
    throw 'Content store duoc tao tu manifest cu. Chay lai New-RuntimeContentStore.ps1.'
}
& (Join-Path $ProjectRoot 'Tests\Test-DataRegistry.ps1') `
    -DataRoot $ContentRoot -ProjectRoot $ProjectRoot -ManifestPath $ManifestPath | Out-Null
& (Join-Path $ProjectRoot 'Tests\Test-GameplayDataRegistry.ps1') `
    -DataRoot $ContentRoot -ProjectRoot $ProjectRoot -ManifestPath $ManifestPath | Out-Null
& (Join-Path $ProjectRoot 'Tests\Test-ServiceTopology.ps1') `
    -RuntimeRoot $ContentRoot -ProjectRoot $ProjectRoot -ManifestPath $ManifestPath | Out-Null

if (Test-Path -LiteralPath $StagingRuntime) {
    $running = @(Get-CimInstance Win32_Process | Where-Object {
        $_.ExecutablePath -and
        ([IO.Path]::GetFullPath($_.ExecutablePath)).StartsWith($StagingRuntime + '\', [StringComparison]::OrdinalIgnoreCase)
    })
    if ($running) {
        throw "Khong the tao lai staging khi tien trinh con dang chay: $($running.Name -join ', ')"
    }
    $resolvedStaging = [IO.Path]::GetFullPath($StagingRuntime).TrimEnd('\')
    if ($resolvedStaging -ne $StagingRuntime) { throw "StagingRuntime khong on dinh: $StagingRuntime" }
    Remove-Item -LiteralPath $StagingRuntime -Recurse -Force
}
New-Item -ItemType Directory -Path $StagingRuntime -Force | Out-Null

$deployed = New-Object System.Collections.Generic.List[object]
$contentGroups = New-Object System.Collections.Generic.List[object]
foreach ($role in 'Client', 'Server') {
    $roleConfig = $manifest.Roles.$role
    $contentRole = Join-Path $ContentRoot $role
    $destinationRole = Join-Path $StagingRuntime $role
    New-Item -ItemType Directory -Path $destinationRole -Force | Out-Null

    foreach ($relative in $roleConfig.ContentDirectories) {
        $source = Join-Path $contentRole $relative
        $destination = Join-Path $destinationRole $relative
        Copy-AllowlistedDirectory $source $destination
        $files = @(Get-ChildItem -LiteralPath $destination -Recurse -File -Force)
        $contentGroups.Add([pscustomobject]@{
            Role = $role
            Path = $relative
            FileCount = $files.Count
            Bytes = [long](($files | Measure-Object Length -Sum).Sum)
        })
    }

    $contentFiles = @(@($roleConfig.ContentFiles) + @($roleConfig.MutableContentFiles) |
        Where-Object { $_ })
    foreach ($relative in $contentFiles) {
        $source = Join-Path $contentRole $relative
        if (-not (Test-Path -LiteralPath $source -PathType Leaf)) {
            throw "Content store thieu file: $role\$relative"
        }
        Copy-Item -LiteralPath $source -Destination (Join-Path $destinationRole $relative) -Force
    }

    foreach ($relative in $roleConfig.MutableDirectories) {
        New-Item -ItemType Directory -Path (Join-Path $destinationRole $relative) -Force | Out-Null
    }

    foreach ($relative in $roleConfig.StateDirectories) {
        $statePath = Join-Path (Join-Path $StateRoot $role) $relative
        if (-not (Test-Path -LiteralPath $statePath -PathType Container)) {
            New-Item -ItemType Directory -Path $statePath -Force | Out-Null
        }
        New-Item -ItemType Junction -Path (Join-Path $destinationRole $relative) -Target $statePath | Out-Null
    }

    $output = Join-Path $ProjectRoot "Output\$role"
    foreach ($name in $roleConfig.ArtifactFiles) {
        $source = Join-Path $output $name
        if (-not (Test-Path -LiteralPath $source -PathType Leaf)) {
            throw "Thieu artifact $role trong Output: $name"
        }
        $sourceItem = Get-Item -LiteralPath $source
        $target = Join-Path $destinationRole $name
        Copy-Item -LiteralPath $sourceItem.FullName -Destination $target -Force
        $deployed.Add([pscustomobject]@{
            Role = $role
            Name = $name
            Length = $sourceItem.Length
            Sha256 = (Get-FileHash -LiteralPath $target -Algorithm SHA256).Hash
        })
    }
}

& (Join-Path $ProjectRoot 'Deploy\New-ClientVersionManifest.ps1') `
    -ClientRoot (Join-Path $StagingRuntime 'Client') | Out-Null

$deploymentManifest = Join-Path $StagingRuntime 'DEPLOYMENT_MANIFEST.json'
$deployment = [ordered]@{
    Schema = 2
    CreatedAtUtc = [DateTime]::UtcNow.ToString('o')
    ProjectRoot = $ProjectRoot
    ContentRoot = $ContentRoot
    StateRoot = $StateRoot
    StagingRuntime = $StagingRuntime
    RuntimeManifestSha256 = $manifestHash
    ContentStoreManifestSha256 = (Get-FileHash -LiteralPath $storeManifestPath -Algorithm SHA256).Hash
    Artifacts = @($deployed | ForEach-Object { $_ })
    ContentGroups = @($contentGroups | ForEach-Object { $_ })
}
[IO.File]::WriteAllText(
    $deploymentManifest,
    ($deployment | ConvertTo-Json -Depth 6),
    (New-Object Text.UTF8Encoding($false))
)

& (Join-Path $ProjectRoot 'Tests\Test-VngSkillResourcePolicy.ps1') `
    -DataRoot $StagingRuntime -ProjectRoot $ProjectRoot -ManifestPath $ManifestPath | Out-Null
& (Join-Path $ProjectRoot 'Tests\Test-CleanRuntime.ps1') `
    -RuntimeRoot $StagingRuntime -ContentRoot $ContentRoot -StateRoot $StateRoot `
    -ManifestPath $ManifestPath | Out-Null
& (Join-Path $ProjectRoot 'Tests\Test-VngHudUi.ps1') `
    -DataRoot $StagingRuntime -ProjectRoot $ProjectRoot | Out-Null
& (Join-Path $ProjectRoot 'Tests\Test-NoVoLamRuntime.ps1') `
    -RuntimeRoot $StagingRuntime -ProjectRoot $ProjectRoot | Out-Null

[pscustomobject]@{
    StagingRuntime = $StagingRuntime
    Client = Join-Path $StagingRuntime 'Client'
    Server = Join-Path $StagingRuntime 'Server'
    ArtifactCount = $deployed.Count
    ContentGroupCount = $contentGroups.Count
    DeploymentManifest = $deploymentManifest
    Validation = 'PASS'
}
