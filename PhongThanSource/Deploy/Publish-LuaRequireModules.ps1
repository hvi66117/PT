[CmdletBinding()]
param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$ContentRoot,
    [string]$RuntimeRoot
)

$ErrorActionPreference = 'Stop'
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
$projectParent = Split-Path -Parent $ProjectRoot
if (-not $ContentRoot) { $ContentRoot = Join-Path $projectParent 'PhongThanRuntime-Content' }
if (-not $RuntimeRoot) { $RuntimeRoot = Join-Path $projectParent 'PhongThanRuntime-Staging' }
$ContentRoot = [IO.Path]::GetFullPath($ContentRoot).TrimEnd('\')
$RuntimeRoot = [IO.Path]::GetFullPath($RuntimeRoot).TrimEnd('\')
$sourceRoot = Join-Path $ProjectRoot 'gameserver\script\common'
$runtimeManifestPath = Join-Path $ProjectRoot 'Deploy\RUNTIME_CONTENT_MANIFEST.json'
$storeManifestPath = Join-Path $ContentRoot 'CONTENT_STORE_MANIFEST.json'
$deploymentPath = Join-Path $RuntimeRoot 'DEPLOYMENT_MANIFEST.json'
foreach ($required in $sourceRoot, $runtimeManifestPath, $storeManifestPath, $deploymentPath) {
    if (-not (Test-Path -LiteralPath $required)) { throw "Thieu publish dependency: $required" }
}
foreach ($root in $ContentRoot, $RuntimeRoot) {
    if ($root -ieq [IO.Path]::GetPathRoot($root).TrimEnd('\')) {
        throw "Tu choi publish vao thu muc goc: $root"
    }
}
$running = @(Get-CimInstance Win32_Process | Where-Object {
    $_.ExecutablePath -and
    ([IO.Path]::GetFullPath($_.ExecutablePath)).StartsWith($RuntimeRoot + '\', [StringComparison]::OrdinalIgnoreCase)
})
if ($running) { throw "Khong publish khi staging dang chay: $($running.Name -join ', ')" }

$sourceFiles = @(Get-ChildItem -LiteralPath $sourceRoot -Recurse -File -Filter '*.luax')
if ($sourceFiles.Count -ne 41) { throw "Source phai co dung 41 .luax, hien co $($sourceFiles.Count)." }
foreach ($role in 'Client', 'Server') {
    foreach ($root in $ContentRoot, $RuntimeRoot) {
        $moduleRoot = [IO.Path]::GetFullPath((Join-Path (Join-Path $root $role) 'script\common')).TrimEnd('\')
        $roleRoot = [IO.Path]::GetFullPath((Join-Path $root $role)).TrimEnd('\')
        if (-not $moduleRoot.StartsWith($roleRoot + '\', [StringComparison]::OrdinalIgnoreCase)) {
            throw "Module root nam ngoai role root: $moduleRoot"
        }
        [IO.Directory]::CreateDirectory($moduleRoot) | Out-Null
        foreach ($stale in Get-ChildItem -LiteralPath $moduleRoot -Recurse -File -Filter '*.luax') {
            if (-not ([IO.Path]::GetFullPath($stale.FullName)).StartsWith($moduleRoot + '\', [StringComparison]::OrdinalIgnoreCase)) {
                throw "Tu choi xoa module ngoai root: $($stale.FullName)"
            }
            Remove-Item -LiteralPath $stale.FullName -Force
        }
        foreach ($source in $sourceFiles) {
            $relative = $source.FullName.Substring($sourceRoot.Length + 1)
            $target = Join-Path $moduleRoot $relative
            [IO.Directory]::CreateDirectory((Split-Path -Parent $target)) | Out-Null
            Copy-Item -LiteralPath $source.FullName -Destination $target -Force
        }
    }
}

$manifestHash = (Get-FileHash -LiteralPath $runtimeManifestPath -Algorithm SHA256).Hash
$store = Get-Content -LiteralPath $storeManifestPath -Raw | ConvertFrom-Json
$store.SourceManifestSha256 = $manifestHash
$store.CreatedAtUtc = [DateTime]::UtcNow.ToString('o')
foreach ($role in 'Client', 'Server') {
    $group = @($store.Groups | Where-Object { $_.Role -eq $role -and $_.Path -eq 'script' })
    if ($group.Count -ne 1) { throw "Content store thieu script group duy nhat cho $role." }
    $files = @(Get-ChildItem -LiteralPath (Join-Path (Join-Path $ContentRoot $role) 'script') -Recurse -File -Force)
    $group[0].FileCount = $files.Count
    $group[0].Bytes = [long](($files | Measure-Object Length -Sum).Sum)
}
[IO.File]::WriteAllText(
    $storeManifestPath,
    ($store | ConvertTo-Json -Depth 8),
    [Text.UTF8Encoding]::new($false))

$deployment = Get-Content -LiteralPath $deploymentPath -Raw | ConvertFrom-Json
$deployment.CreatedAtUtc = [DateTime]::UtcNow.ToString('o')
$deployment.RuntimeManifestSha256 = $manifestHash
$deployment.ContentStoreManifestSha256 = (Get-FileHash -LiteralPath $storeManifestPath -Algorithm SHA256).Hash
foreach ($role in 'Client', 'Server') {
    $group = @($deployment.ContentGroups | Where-Object { $_.Role -eq $role -and $_.Path -eq 'script' })
    if ($group.Count -ne 1) { throw "Deployment thieu script group duy nhat cho $role." }
    $files = @(Get-ChildItem -LiteralPath (Join-Path (Join-Path $RuntimeRoot $role) 'script') -Recurse -File -Force)
    $group[0].FileCount = $files.Count
    $group[0].Bytes = [long](($files | Measure-Object Length -Sum).Sum)
}
[IO.File]::WriteAllText(
    $deploymentPath,
    ($deployment | ConvertTo-Json -Depth 8),
    [Text.UTF8Encoding]::new($false))

$contentGate = & (Join-Path $ProjectRoot 'Tests\Test-LuaRequireModules.ps1') `
    -ProjectRoot $ProjectRoot -DataRoot $ContentRoot
$runtimeGate = & (Join-Path $ProjectRoot 'Tests\Test-LuaRequireModules.ps1') `
    -ProjectRoot $ProjectRoot -DataRoot $RuntimeRoot

[pscustomobject]@{
    Result = 'PASS'
    Modules = $sourceFiles.Count
    Roles = 2
    ContentGate = $contentGate.Result
    RuntimeGate = $runtimeGate.Result
    RuntimeManifestSha256 = $manifestHash
    ContentStoreManifestSha256 = $deployment.ContentStoreManifestSha256
}
