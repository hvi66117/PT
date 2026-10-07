[CmdletBinding()]
param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$RuntimeRoot = 'D:\Lam game phong than\PhongThanRuntime-Staging',
    [string]$OutputPath = (Join-Path (Split-Path -Parent $PSScriptRoot) 'Docs\BASELINE_MANIFEST.json')
)

$ErrorActionPreference = 'Stop'
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
$trackedRoots = 'Sources', 'Headers', 'Lib', 'ThirdParty'
$relativeFiles = @(& git -C $ProjectRoot ls-files --cached --others --exclude-standard -- $trackedRoots)
if ($LASTEXITCODE -ne 0) { throw 'Khong doc duoc danh sach file Git de tao manifest.' }
$files = foreach ($relative in $relativeFiles) {
    $path = Join-Path $ProjectRoot $relative
    if (Test-Path -LiteralPath $path -PathType Leaf) {
        $item = Get-Item -LiteralPath $path
        [pscustomobject]@{
            Path = $relative.Replace('\', '/')
            Length = $item.Length
            Sha256 = (Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash
        }
    }
}

$runtimeFiles = @(
    'client\Game.exe', 'client\CoreClient.dll', 'client\Engine.dll',
    'client\LuaLibDll.dll', 'client\ExpandPackage.dll', 'client\FilterText.dll',
    'client\heaven.dll', 'client\Rainbow.dll', 'client\Represent2.dll',
    'client\Represent3.dll',
    'server\CoreServer.dll', 'server\Engine.dll', 'server\LuaLibDll.dll',
    'server\ExpandPackage.dll', 'server\FilterText.dll', 'server\heaven.dll',
    'server\Rainbow.dll', 'server\GameServer.exe', 'server\Bishop.exe',
    'server\Goddess.exe', 'server\S3Relay.exe', 'server\PhongThanAccountServer.exe',
    'server\PhongThanRelayServer.exe'
)
$runtime = foreach ($relative in $runtimeFiles) {
    $path = Join-Path $RuntimeRoot $relative
    if (Test-Path -LiteralPath $path) {
        $item = Get-Item -LiteralPath $path
        [pscustomobject]@{
            Path = $relative.Replace('\', '/')
            Length = $item.Length
            LastWriteTimeUtc = $item.LastWriteTimeUtc.ToString('o')
            Sha256 = (Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash
        }
    }
}

$manifest = [ordered]@{
    Schema = 3
    CreatedAtUtc = [DateTime]::UtcNow.ToString('o')
    ProjectRoot = $ProjectRoot
    RuntimeRoot = $RuntimeRoot
    TrackedRoots = $trackedRoots
    SourceFileCount = @($files).Count
    SourceFiles = @($files | Sort-Object Path)
    RuntimeBinaries = @($runtime)
}
$json = $manifest | ConvertTo-Json -Depth 6
[IO.File]::WriteAllText($OutputPath, $json, (New-Object Text.UTF8Encoding($false)))
Get-Item -LiteralPath $OutputPath
