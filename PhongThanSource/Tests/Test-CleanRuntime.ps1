[CmdletBinding()]
param(
    [string]$RuntimeRoot,
    [string]$ContentRoot,
    [string]$StateRoot,
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$ManifestPath
)

$ErrorActionPreference = 'Stop'
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
$projectParent = Split-Path -Parent $ProjectRoot
if (-not $RuntimeRoot) { $RuntimeRoot = Join-Path $projectParent 'PhongThanRuntime-Staging' }
if (-not $ContentRoot) { $ContentRoot = Join-Path $projectParent 'PhongThanRuntime-Content' }
if (-not $StateRoot) { $StateRoot = Join-Path $projectParent 'PhongThanRuntime-State' }
if (-not $ManifestPath) { $ManifestPath = Join-Path $ProjectRoot 'Deploy\RUNTIME_CONTENT_MANIFEST.json' }
$RuntimeRoot = [IO.Path]::GetFullPath($RuntimeRoot).TrimEnd('\')
$ContentRoot = [IO.Path]::GetFullPath($ContentRoot).TrimEnd('\')
$StateRoot = [IO.Path]::GetFullPath($StateRoot).TrimEnd('\')
$ManifestPath = [IO.Path]::GetFullPath($ManifestPath)
$failures = New-Object System.Collections.Generic.List[string]

foreach ($required in $RuntimeRoot, $ContentRoot, $StateRoot, $ManifestPath) {
    if (-not (Test-Path -LiteralPath $required)) { $failures.Add("Thieu: $required") }
}
if ($failures.Count) {
    $failures | ForEach-Object { Write-Error $_ }
    exit 1
}

& (Join-Path $ProjectRoot 'Tests\Test-DataRegistry.ps1') `
    -DataRoot $RuntimeRoot -ProjectRoot $ProjectRoot -ManifestPath $ManifestPath | Out-Null
& (Join-Path $ProjectRoot 'Tests\Test-GameplayDataRegistry.ps1') `
    -DataRoot $RuntimeRoot -ProjectRoot $ProjectRoot -ManifestPath $ManifestPath | Out-Null
& (Join-Path $ProjectRoot 'Tests\Test-ServiceTopology.ps1') `
    -RuntimeRoot $RuntimeRoot -ProjectRoot $ProjectRoot -ManifestPath $ManifestPath | Out-Null
& (Join-Path $ProjectRoot 'Tests\Test-SprContentPolicy.ps1') `
    -DataRoot $RuntimeRoot -ProjectRoot $ProjectRoot -ManifestPath $ManifestPath | Out-Null

$manifest = Get-Content -LiteralPath $ManifestPath -Raw | ConvertFrom-Json
$deploymentPath = Join-Path $RuntimeRoot 'DEPLOYMENT_MANIFEST.json'
$storeManifestPath = Join-Path $ContentRoot 'CONTENT_STORE_MANIFEST.json'
if (-not (Test-Path -LiteralPath $deploymentPath -PathType Leaf)) { $failures.Add("Thieu: $deploymentPath") }
if (-not (Test-Path -LiteralPath $storeManifestPath -PathType Leaf)) { $failures.Add("Thieu: $storeManifestPath") }
if ($failures.Count) {
    $failures | ForEach-Object { Write-Error $_ }
    exit 1
}
$deployment = Get-Content -LiteralPath $deploymentPath -Raw | ConvertFrom-Json
$store = Get-Content -LiteralPath $storeManifestPath -Raw | ConvertFrom-Json

if ($manifest.Schema -ne 1) { $failures.Add("Runtime manifest schema sai: $($manifest.Schema)") }
if ($deployment.Schema -ne 2) { $failures.Add("Deployment manifest schema sai: $($deployment.Schema)") }
if ($deployment.PSObject.Properties.Name -contains 'BaselineRuntime') {
    $failures.Add('Deployment manifest con phu thuoc BaselineRuntime.')
}
$runtimeManifestHash = (Get-FileHash -LiteralPath $ManifestPath -Algorithm SHA256).Hash
$storeManifestHash = (Get-FileHash -LiteralPath $storeManifestPath -Algorithm SHA256).Hash
if ($deployment.RuntimeManifestSha256 -ne $runtimeManifestHash) { $failures.Add('Runtime manifest hash khong khop.') }
if ($deployment.ContentStoreManifestSha256 -ne $storeManifestHash) { $failures.Add('Content store manifest hash khong khop.') }
if ($store.SourceManifestSha256 -ne $runtimeManifestHash) { $failures.Add('Content store duoc tao tu runtime manifest khac.') }
if ((Get-Content -LiteralPath $deploymentPath -Raw) -match '(?i)DEV AG v1|SwordOnline') {
    $failures.Add('Deployment manifest con tham chieu runtime/source cu.')
}

$artifactCount = 0
$contentFileCount = 0
foreach ($role in 'Client', 'Server') {
    $roleConfig = $manifest.Roles.$role
    $runtimeRole = Join-Path $RuntimeRoot $role
    $contentRole = Join-Path $ContentRoot $role
    if (-not (Test-Path -LiteralPath $runtimeRole -PathType Container)) {
        $failures.Add("Runtime thieu role: $role")
        continue
    }
    $allowedTop = @($roleConfig.ArtifactFiles) + @($roleConfig.ContentDirectories) +
        @($roleConfig.ContentFiles) + @($roleConfig.MutableContentFiles) +
        @($roleConfig.MutableDirectories) + @($roleConfig.StateDirectories)
    foreach ($entry in Get-ChildItem -LiteralPath $runtimeRole -Force) {
        $isGeneratedFile = $false
        if (-not $entry.PSIsContainer) {
            foreach ($pattern in $roleConfig.GeneratedFilePatterns) {
                if ($entry.Name -match $pattern) { $isGeneratedFile = $true; break }
            }
        }
        if ($allowedTop -notcontains $entry.Name -and -not $isGeneratedFile) {
            $failures.Add("Ngoai allowlist: $role\$($entry.Name)")
        }
    }

    foreach ($name in $roleConfig.ArtifactFiles) {
        $artifactCount++
        $runtimeFile = Join-Path $runtimeRole $name
        $outputFile = Join-Path (Join-Path $ProjectRoot "Output\$role") $name
        if (-not (Test-Path -LiteralPath $runtimeFile -PathType Leaf)) {
            $failures.Add("Thieu artifact runtime: $role\$name")
            continue
        }
        if (-not (Test-Path -LiteralPath $outputFile -PathType Leaf)) {
            $failures.Add("Thieu artifact Output: $role\$name")
            continue
        }
        if ((Get-FileHash -LiteralPath $runtimeFile -Algorithm SHA256).Hash -ne
            (Get-FileHash -LiteralPath $outputFile -Algorithm SHA256).Hash) {
            $failures.Add("Artifact khong khop Output: $role\$name")
        }
    }

    foreach ($name in $roleConfig.ContentFiles) {
        $runtimeFile = Join-Path $runtimeRole $name
        $contentFile = Join-Path $contentRole $name
        if (-not (Test-Path -LiteralPath $runtimeFile -PathType Leaf)) {
            $failures.Add("Thieu content file runtime: $role\$name")
            continue
        }
        if (-not (Test-Path -LiteralPath $contentFile -PathType Leaf)) {
            $failures.Add("Thieu content file store: $role\$name")
            continue
        }
        if ((Get-FileHash -LiteralPath $runtimeFile -Algorithm SHA256).Hash -ne
            (Get-FileHash -LiteralPath $contentFile -Algorithm SHA256).Hash) {
            $failures.Add("Content file khong khop store: $role\$name")
        }
    }

    foreach ($name in @($roleConfig.MutableContentFiles | Where-Object { $_ })) {
        $runtimeFile = Join-Path $runtimeRole $name
        $contentFile = Join-Path $contentRole $name
        if (-not (Test-Path -LiteralPath $runtimeFile -PathType Leaf)) {
            $failures.Add("Thieu mutable content file runtime: $role\$name")
        }
        if (-not (Test-Path -LiteralPath $contentFile -PathType Leaf)) {
            $failures.Add("Thieu mutable content file store: $role\$name")
        }
    }

    foreach ($name in $roleConfig.ContentDirectories) {
        $runtimeDirectory = Join-Path $runtimeRole $name
        $contentDirectory = Join-Path $contentRole $name
        if (-not (Test-Path -LiteralPath $runtimeDirectory -PathType Container)) {
            $failures.Add("Thieu content directory runtime: $role\$name")
            continue
        }
        $runtimeFiles = @(Get-ChildItem -LiteralPath $runtimeDirectory -Recurse -File -Force)
        $contentFiles = @(Get-ChildItem -LiteralPath $contentDirectory -Recurse -File -Force)
        $contentFileCount += $runtimeFiles.Count
        $runtimeBytes = [long](($runtimeFiles | Measure-Object Length -Sum).Sum)
        $contentBytes = [long](($contentFiles | Measure-Object Length -Sum).Sum)
        if ($runtimeFiles.Count -ne $contentFiles.Count -or $runtimeBytes -ne $contentBytes) {
            $failures.Add("Content group khong khop store: $role\$name")
        }
    }

    foreach ($name in $roleConfig.MutableDirectories) {
        if (-not (Test-Path -LiteralPath (Join-Path $runtimeRole $name) -PathType Container)) {
            $failures.Add("Thieu mutable directory: $role\$name")
        }
    }

    foreach ($name in $roleConfig.StateDirectories) {
        $link = Join-Path $runtimeRole $name
        $target = Join-Path (Join-Path $StateRoot $role) $name
        if (-not (Test-Path -LiteralPath $link -PathType Container)) {
            $failures.Add("Thieu state junction: $role\$name")
            continue
        }
        $item = Get-Item -LiteralPath $link -Force
        if (($item.Attributes -band [IO.FileAttributes]::ReparsePoint) -eq 0) {
            $failures.Add("State khong phai junction: $role\$name")
        }
        if (-not (Test-Path -LiteralPath $target -PathType Container)) {
            $failures.Add("Thieu state target: $target")
        }
    }

    foreach ($file in Get-ChildItem -LiteralPath $runtimeRole -Recurse -File -Force) {
        $relativeFile = $file.FullName.Substring($runtimeRole.Length + 1)
        $topDirectory = $relativeFile.Split('\')[0]
        if ($roleConfig.MutableDirectories -contains $topDirectory) { continue }
        $isGeneratedFile = $false
        foreach ($generatedPattern in $roleConfig.GeneratedFilePatterns) {
            if ($file.Name -match $generatedPattern) { $isGeneratedFile = $true; break }
        }
        if ($isGeneratedFile) { continue }
        foreach ($pattern in $manifest.ForbiddenFilePatterns) {
            if ($file.Name -match $pattern) {
                $failures.Add("File bi cam: $($file.FullName.Substring($RuntimeRoot.Length + 1))")
                break
            }
        }
    }
}

if ($failures.Count) {
    $failures | Select-Object -Unique | ForEach-Object { Write-Error $_ }
    exit 1
}

[pscustomobject]@{
    Result = 'PASS'
    RuntimeRoot = $RuntimeRoot
    ArtifactCount = $artifactCount
    ContentFileCount = $contentFileCount
    ForbiddenFiles = 0
    ExtraTopLevelEntries = 0
    BaselineDependency = 0
}
