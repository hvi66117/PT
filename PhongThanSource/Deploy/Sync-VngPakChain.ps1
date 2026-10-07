[CmdletBinding()]
param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$RuntimeRoot = 'D:\Lam game phong than\PhongThanRuntime-Staging'
)

$ErrorActionPreference = 'Stop'
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
$RuntimeRoot = [IO.Path]::GetFullPath($RuntimeRoot).TrimEnd('\')
$clientRoot = Join-Path $RuntimeRoot 'Client'
$serverRoot = Join-Path $RuntimeRoot 'Server'
$clientPackageIni = Join-Path $clientRoot 'package.ini'
$serverPackageIni = Join-Path $serverRoot 'package.ini'
$clientData = [IO.Path]::GetFullPath((Join-Path $clientRoot 'data')).TrimEnd('\')
$serverData = [IO.Path]::GetFullPath((Join-Path $serverRoot 'data')).TrimEnd('\')

foreach ($required in $clientRoot, $serverRoot, $clientPackageIni, $clientData) {
    if (-not (Test-Path -LiteralPath $required)) { throw "Missing VNG PAK dependency: $required" }
}
$running = @(Get-CimInstance Win32_Process | Where-Object {
    $_.ExecutablePath -and
    ([IO.Path]::GetFullPath($_.ExecutablePath)).StartsWith($serverRoot + '\', [StringComparison]::OrdinalIgnoreCase)
})
if ($running) { throw "Stop server before synchronizing PAK files: $($running.Name -join ', ')" }

$cp936 = [Text.Encoding]::GetEncoding(936)
$packageText = [IO.File]::ReadAllText($clientPackageIni, $cp936)
if ($packageText -notmatch '(?im)^\s*Path\s*=\s*\\data\s*$') {
    throw 'Client package.ini must use Path=\data.'
}
$entries = @([regex]::Matches($packageText, '(?im)^\s*(\d+)\s*=\s*([^\r\n;]+?)\s*$') | ForEach-Object {
    [pscustomobject]@{ Priority = [int]$_.Groups[1].Value; Name = $_.Groups[2].Value.Trim() }
} | Sort-Object Priority)
if (-not $entries.Count) { throw 'Client package.ini has no numeric PAK entries.' }
for ($index = 0; $index -lt $entries.Count; $index++) {
    if ($entries[$index].Priority -ne $index) { throw "PAK priority is not contiguous at index $index." }
    if ([IO.Path]::GetFileName($entries[$index].Name) -cne $entries[$index].Name -or
        [IO.Path]::GetExtension($entries[$index].Name) -ine '.pak') {
        throw "Unsafe PAK registry value: $($entries[$index].Name)"
    }
}

New-Item -ItemType Directory -Path $serverData -Force | Out-Null
$declared = @{}
$synced = New-Object System.Collections.Generic.List[object]
foreach ($entry in $entries) {
    $declared[$entry.Name.ToLowerInvariant()] = $true
    $source = [IO.Path]::GetFullPath((Join-Path $clientData $entry.Name))
    $target = [IO.Path]::GetFullPath((Join-Path $serverData $entry.Name))
    if (-not $source.StartsWith($clientData + '\', [StringComparison]::OrdinalIgnoreCase) -or
        -not $target.StartsWith($serverData + '\', [StringComparison]::OrdinalIgnoreCase)) {
        throw "PAK path escaped its role directory: $($entry.Name)"
    }
    if (-not (Test-Path -LiteralPath $source -PathType Leaf)) { throw "Missing client PAK: $source" }
    $sourceInfo = Get-Item -LiteralPath $source
    $sha256 = (Get-FileHash -LiteralPath $source -Algorithm SHA256).Hash
    $reuse = $false
    if (Test-Path -LiteralPath $target -PathType Leaf) {
        $targetInfo = Get-Item -LiteralPath $target
        if ($targetInfo.Length -eq $sourceInfo.Length -and
            (Get-FileHash -LiteralPath $target -Algorithm SHA256).Hash -eq $sha256) {
            $reuse = $true
        } else {
            Remove-Item -LiteralPath $target -Force
        }
    }
    if (-not $reuse) {
        New-Item -ItemType HardLink -Path $target -Target $source | Out-Null
    }
    if ((Get-Item -LiteralPath $target).Length -ne $sourceInfo.Length) {
        throw "Server PAK length mismatch: $target"
    }
    $synced.Add([pscustomobject]@{
        Priority = $entry.Priority
        Name = $entry.Name
        Length = [long]$sourceInfo.Length
        Sha256 = $sha256
        Storage = 'NTFS hardlink to Client\data'
    })
}
foreach ($stale in Get-ChildItem -LiteralPath $serverData -File -Filter '*.pak' -Force) {
    if (-not $declared.ContainsKey($stale.Name.ToLowerInvariant())) {
        $resolved = [IO.Path]::GetFullPath($stale.FullName)
        if (-not $resolved.StartsWith($serverData + '\', [StringComparison]::OrdinalIgnoreCase)) {
            throw "Unsafe stale PAK path: $resolved"
        }
        Remove-Item -LiteralPath $resolved -Force
    }
}
Copy-Item -LiteralPath $clientPackageIni -Destination $serverPackageIni -Force
if ((Get-FileHash -LiteralPath $clientPackageIni).Hash -ne
    (Get-FileHash -LiteralPath $serverPackageIni).Hash) {
    throw 'Client/server package.ini mismatch after synchronization.'
}

$obsoletePakRoot = Join-Path $serverRoot 'pak'
if (Test-Path -LiteralPath $obsoletePakRoot -PathType Container) {
    $obsoleteEntries = @(Get-ChildItem -LiteralPath $obsoletePakRoot -Force)
    if (-not $obsoleteEntries.Count) { Remove-Item -LiteralPath $obsoletePakRoot -Force }
}

[pscustomobject]@{
    Mode = 'PAK_FIRST_LOOSE_FALLBACK'
    PackageCount = $synced.Count
    TotalBytes = [long](($synced | Measure-Object Length -Sum).Sum)
    PackageIniSha256 = (Get-FileHash -LiteralPath $clientPackageIni -Algorithm SHA256).Hash
    Entries = $synced.ToArray()
}
