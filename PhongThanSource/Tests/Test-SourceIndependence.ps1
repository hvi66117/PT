[CmdletBinding()]
param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = 'Stop'
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
$failures = New-Object System.Collections.Generic.List[string]

foreach ($required in @(
    'Sources\Core\Src', 'Sources\Engine\Src', 'Sources\GameClient',
    'Sources\MultiServer', 'Sources\Represent', 'Headers', 'Lib',
    'Build', 'Deploy', 'Output\Client', 'Output\Server',
    'Deploy\RUNTIME_CONTENT_MANIFEST.json',
    'Deploy\New-RuntimeContentStore.ps1',
    'Deploy\New-StagingRuntime.ps1',
    'Deploy\Start-StagingServer.ps1',
    'Deploy\Stop-StagingRuntime.ps1',
    'Tests\Test-CleanRuntime.ps1',
    'Tests\Test-DataRegistry.ps1',
    'Tests\Test-ItemRegistryLoader.ps1',
    'ThirdParty\WindowsSDK\GDIPlus\Include\Gdiplus.h',
    'ThirdParty\WindowsSDK\GDIPlus\Lib\x86\GdiPlus.lib',
    'ThirdParty\dx9csdk\Include\d3d9types.h',
    'ThirdParty\dx9csdk\Include\d3dx9.h',
    'ThirdParty\dx9csdk\Lib\d3d9.lib',
    'ThirdParty\dx9csdk\Lib\d3dx9dt.lib',
    'ThirdParty\dx9csdk\Lib\dxguid.lib',
    'ThirdParty\dx9csdk\Lib\ddraw.lib',
    'ThirdParty\dx9csdk\SHA256SUMS.txt',
    'ThirdParty\dx9csdk\PROVENANCE.md'
)) {
    if (-not (Test-Path -LiteralPath (Join-Path $ProjectRoot $required))) {
        $failures.Add("Thieu: $required")
    }
}

$projectFiles = Get-ChildItem -LiteralPath (Join-Path $ProjectRoot 'Sources') -Recurse -File |
    Where-Object { $_.Extension -in '.dsp', '.dsw', '.vcproj', '.sln', '.mak' }
foreach ($file in $projectFiles) {
    $text = [Text.Encoding]::GetEncoding(28591).GetString([IO.File]::ReadAllBytes($file.FullName))
    $relative = $file.FullName.Substring($ProjectRoot.Length + 1)
    if ($text -match '(?i)DEV AG v1\\SwordOnline|SwordOnline\\SwordOnline|\$/SwordOnline') {
        $failures.Add("Tham chieu source cu: $relative")
    }
    if ($text -match '(?i)(?:\.\.[\\/])+bin[\\/](?:client|server|multiserver)') {
        $failures.Add("Post-build con ghi ra bin cu: $relative")
    }
    if ($text -match '(?i)(?<![A-Za-z0-9_])[a-z]:[\\/]') {
        $failures.Add("Duong dan o dia tuyet doi: $relative")
    }
    if ($text -match '(?i)OutputFile="[\\/]|/out:"[\\/]') {
        $failures.Add("Duong dan output tuyet doi: $relative")
    }
    if ($text -match '(?i)# PROP Scc_|Scc(?:ProjectName|AuxPath|LocalPath|Provider)=') {
        $failures.Add("Metadata source-control cu: $relative")
    }
}

$deploymentFiles = Get-ChildItem -LiteralPath (Join-Path $ProjectRoot 'Deploy') -File |
    Where-Object { $_.Extension -in '.ps1', '.json' }
foreach ($file in $deploymentFiles) {
    $text = [Text.Encoding]::UTF8.GetString([IO.File]::ReadAllBytes($file.FullName))
    $relative = $file.FullName.Substring($ProjectRoot.Length + 1)
    if ($text -match '(?i)DEV AG v1|SwordOnline|BaselineRuntime') {
        $failures.Add("Deploy con phu thuoc baseline cu: $relative")
    }
}

$trackedSourceFiles = @(& git -C $ProjectRoot ls-files -- Sources)
if ($LASTEXITCODE -ne 0) { throw 'Khong doc duoc danh sach file Git de kiem tra artifact.' }
$junk = foreach ($relative in $trackedSourceFiles) {
    $path = Join-Path $ProjectRoot $relative
    if (-not (Test-Path -LiteralPath $path)) { continue }
    $item = Get-Item -LiteralPath $path -Force
    if ($item.Name -in '.vs', '.idea' -or
        $item.Extension -in '.ncb', '.opt', '.plg', '.obj', '.pch', '.idb',
            '.scc', '.vspscc', '.stt', '.rar', '.exe', '.dll') {
        $item
    }
}
foreach ($item in $junk) {
    $failures.Add("Build/IDE artifact trong source: $($item.FullName.Substring($ProjectRoot.Length + 1))")
}

if ($failures.Count) {
    $failures | ForEach-Object { Write-Error $_ }
    exit 1
}

[pscustomobject]@{
    Result = 'PASS'
    ProjectRoot = $ProjectRoot
    ProjectFilesChecked = @($projectFiles).Count
    DeploymentFilesChecked = @($deploymentFiles).Count
    ForbiddenReferences = 0
    JunkArtifacts = 0
}
