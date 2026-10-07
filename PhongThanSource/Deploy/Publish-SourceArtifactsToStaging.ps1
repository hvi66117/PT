[CmdletBinding()]
param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$RuntimeRoot
)

$ErrorActionPreference = 'Stop'
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
if (-not $RuntimeRoot) { $RuntimeRoot = Join-Path (Split-Path -Parent $ProjectRoot) 'PhongThanRuntime-Staging' }
$RuntimeRoot = [IO.Path]::GetFullPath($RuntimeRoot).TrimEnd('\')
$manifestPath = Join-Path $ProjectRoot 'Deploy\RUNTIME_CONTENT_MANIFEST.json'
$deploymentPath = Join-Path $RuntimeRoot 'DEPLOYMENT_MANIFEST.json'
foreach ($required in $manifestPath, $deploymentPath, (Join-Path $RuntimeRoot 'Client'), (Join-Path $RuntimeRoot 'Server')) {
    if (-not (Test-Path -LiteralPath $required)) { throw "Thieu staging dependency: $required" }
}
$running = @(Get-CimInstance Win32_Process | Where-Object {
    $_.ExecutablePath -and ([IO.Path]::GetFullPath($_.ExecutablePath)).StartsWith($RuntimeRoot + '\', [StringComparison]::OrdinalIgnoreCase)
})
if ($running) { throw "Khong publish khi staging dang chay: $($running.Name -join ', ')" }

$manifest = Get-Content -Raw -LiteralPath $manifestPath | ConvertFrom-Json
$deployment = Get-Content -Raw -LiteralPath $deploymentPath | ConvertFrom-Json
$published = New-Object System.Collections.Generic.List[object]
foreach ($role in 'Client', 'Server') {
    $outputRoot = Join-Path $ProjectRoot "Output\$role"
    $runtimeRole = Join-Path $RuntimeRoot $role
    foreach ($name in @($manifest.Roles.$role.ArtifactFiles)) {
        $source = Join-Path $outputRoot ([string]$name)
        $target = Join-Path $runtimeRole ([string]$name)
        if (-not (Test-Path -LiteralPath $source -PathType Leaf)) { throw "Output thieu $role artifact: $name" }
        Copy-Item -LiteralPath $source -Destination $target -Force
        $sourceHash = (Get-FileHash -LiteralPath $source -Algorithm SHA256).Hash
        $targetHash = (Get-FileHash -LiteralPath $target -Algorithm SHA256).Hash
        if ($sourceHash -ne $targetHash) { throw "Publish hash mismatch: $role\$name" }
        $published.Add([pscustomobject]@{
            Role = $role
            Name = [string]$name
            Length = (Get-Item -LiteralPath $target).Length
            Sha256 = $targetHash
        })
    }
}
$deployment.Artifacts = @($published | ForEach-Object { $_ })
$deployment.CreatedAtUtc = [DateTime]::UtcNow.ToString('o')
[IO.File]::WriteAllText(
    $deploymentPath,
    ($deployment | ConvertTo-Json -Depth 8),
    (New-Object Text.UTF8Encoding($false)))

& (Join-Path $ProjectRoot 'Deploy\Publish-VngGameplaySettings.ps1') -ProjectRoot $ProjectRoot -RuntimeRoot $RuntimeRoot | Out-Null
& (Join-Path $ProjectRoot 'Deploy\Normalize-VngScriptPaths.ps1') -RuntimeRoot $RuntimeRoot | Out-Null
& (Join-Path $ProjectRoot 'Tests\Test-DataRegistry.ps1') -DataRoot $RuntimeRoot -ProjectRoot $ProjectRoot | Out-Null
$gameplay = & (Join-Path $ProjectRoot 'Tests\Test-GameplayDataRegistry.ps1') -DataRoot $RuntimeRoot -ProjectRoot $ProjectRoot
& (Join-Path $ProjectRoot 'Tests\Test-VngGameplaySettings.ps1') -RuntimeRoot $RuntimeRoot -ProjectRoot $ProjectRoot | Out-Null
& (Join-Path $ProjectRoot 'Tests\Test-LuaRequireModules.ps1') -DataRoot $RuntimeRoot -ProjectRoot $ProjectRoot | Out-Null
& (Join-Path $ProjectRoot 'Tests\Test-VngScriptPathNormalization.ps1') -RuntimeRoot $RuntimeRoot -ProjectRoot $ProjectRoot | Out-Null
$binary = & (Join-Path $ProjectRoot 'Tests\Test-LuaApiBinaryRegistry.ps1') -ProjectRoot $ProjectRoot
$smoke = & (Join-Path $ProjectRoot 'Tests\Test-LuaApiBinarySmoke.ps1') -ProjectRoot $ProjectRoot `
    -ServerRoot (Join-Path $RuntimeRoot 'Server')

[pscustomobject]@{
    Status = 'PASS'
    RuntimeRoot = $RuntimeRoot
    PublishedArtifacts = $published.Count
    CoreServerSha256 = $binary.BinarySha256
    DynamicLuaApiCalls = $smoke.DynamicAbiCalls
    FullGameplayMapGate = $gameplay.Result
    ActiveMaps = $gameplay.ActiveMaps
    PhysicalMaps = $gameplay.PhysicalMaps
    ClientRegions = $gameplay.ClientRegions
    ServerRegions = $gameplay.ServerRegions
}
