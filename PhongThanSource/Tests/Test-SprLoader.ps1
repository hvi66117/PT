[CmdletBinding()]
param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$RuntimeRoot,
    [string]$ManifestPath = (Join-Path (Split-Path -Parent $PSScriptRoot) 'Deploy\RUNTIME_CONTENT_MANIFEST.json')
)

$ErrorActionPreference = 'Stop'
[Text.Encoding]::RegisterProvider([Text.CodePagesEncodingProvider]::Instance)
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
if (-not $RuntimeRoot) { $RuntimeRoot = Join-Path (Split-Path -Parent $ProjectRoot) 'PhongThanRuntime-Staging\Client' }
$RuntimeRoot = [IO.Path]::GetFullPath($RuntimeRoot).TrimEnd('\')
$packageIni = Join-Path $RuntimeRoot 'package.ini'
$manifest = Get-Content -LiteralPath $ManifestPath -Raw | ConvertFrom-Json
$registry = $manifest.DataRegistries.Gameplay.Sprite
if (-not $registry) { throw 'Manifest thieu DataRegistries.Gameplay.Sprite.' }
$catalogPath = Join-Path $ProjectRoot ([string]$registry.AuditCatalog)
foreach ($required in $packageIni, $catalogPath) {
    if (-not (Test-Path -LiteralPath $required)) { throw "Thieu SPR audit dependency: $required" }
}

$catalogPaths = @([IO.File]::ReadAllLines($catalogPath, [Text.Encoding]::GetEncoding(28591)) | Where-Object { $_ })
$expectedFiles = [int]$registry.ExpectedAuditedLooseFiles
if ($catalogPaths.Count -ne $expectedFiles) {
    throw "SPR audit catalog co $($catalogPaths.Count) entry, yeu cau $expectedFiles."
}
$duplicatePaths = @($catalogPaths | Group-Object | Where-Object Count -gt 1)
if ($duplicatePaths.Count) { throw "SPR audit catalog trung $($duplicatePaths.Count) duong dan." }

$runner = Join-Path $ProjectRoot 'Output\Tools\SprLoaderAudit.exe'
& (Join-Path $ProjectRoot 'Build\Build-SprLoaderAudit.ps1') -ProjectRoot $ProjectRoot -OutputPath $runner | Out-Null
Copy-Item -LiteralPath (Join-Path $ProjectRoot 'Output\Client\Engine.dll') `
    -Destination (Split-Path -Parent $runner) -Force

Push-Location $RuntimeRoot
try {
    $output = @(& $runner $packageIni $catalogPath 2>&1)
    $exitCode = $LASTEXITCODE
}
finally { Pop-Location }
$output | ForEach-Object { Write-Output $_ }

$summary = @{}
$actualFailurePaths = @()
foreach ($line in $output) {
    $text = [string]$line
    if ($text -match '^SPR_(FILES|FRAMES|FAILURES)=(\d+)$') {
        $summary[$Matches[1]] = [int64]$Matches[2]
    }
    elseif ($text -match '^(?:HEADER_FAIL|FRAME_FAIL(?:\t\d+)?)\t(.+)$') {
        $actualFailurePaths += $Matches[1].ToLowerInvariant()
    }
}
foreach ($key in 'FILES', 'FRAMES', 'FAILURES') {
    if (-not $summary.ContainsKey($key)) { throw "SPR loader audit thieu summary $key." }
}

$expectedFailurePaths = @($registry.LooseFallbacks | ForEach-Object {
    ('\' + ([string]$_).TrimStart('\').Replace('/', '\')).ToLowerInvariant()
})
$unexpectedFailures = @($actualFailurePaths | Where-Object { $expectedFailurePaths -notcontains $_ })
$missingExpectedFailures = @($expectedFailurePaths | Where-Object { $actualFailurePaths -notcontains $_ })
if ($unexpectedFailures.Count -or $missingExpectedFailures.Count) {
    throw "SPR failure set sai: unexpected=$($unexpectedFailures -join ','); missing=$($missingExpectedFailures -join ',')"
}
if ($summary.FILES -ne $expectedFiles) { throw "SPR_FILES=$($summary.FILES), yeu cau $expectedFiles." }
if ($summary.FRAMES -ne [int64]$registry.ExpectedAuditedFrames) {
    throw "SPR_FRAMES=$($summary.FRAMES), yeu cau $($registry.ExpectedAuditedFrames)."
}
if ($summary.FAILURES -ne $expectedFailurePaths.Count -or $actualFailurePaths.Count -ne $expectedFailurePaths.Count) {
    throw "SPR_FAILURES=$($summary.FAILURES), yeu cau $($expectedFailurePaths.Count)."
}
if (($exitCode -ne 0) -and ($exitCode -ne 1 -or $summary.FAILURES -eq 0)) {
    throw "SPR loader audit that bai: $exitCode"
}

[pscustomobject]@{
    Result = 'PASS'
    AuditCatalog = $catalogPath
    AuditedSprFiles = $summary.FILES
    AuditedFrames = $summary.FRAMES
    ExpectedPakFailures = $summary.FAILURES
    Mode = 'PAK_PRIORITY'
}
