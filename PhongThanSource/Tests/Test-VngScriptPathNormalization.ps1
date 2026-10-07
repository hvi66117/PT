[CmdletBinding()]
param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$RuntimeRoot
)

$ErrorActionPreference = 'Stop'
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
if (-not $RuntimeRoot) {
    $RuntimeRoot = Join-Path (Split-Path -Parent $ProjectRoot) 'PhongThanRuntime-Staging'
}
$RuntimeRoot = [IO.Path]::GetFullPath($RuntimeRoot).TrimEnd('\')
$badBytes = [byte[]](0x97, 0x83, 0xE8, 0xBB)
$latin1 = [Text.Encoding]::GetEncoding(28591)
$badText = $latin1.GetString($badBytes)
$hashes = @{}

foreach ($role in 'Client', 'Server') {
    $roleRoot = Join-Path $RuntimeRoot $role
    $controlNames = @(Get-ChildItem -LiteralPath (Join-Path $roleRoot 'script') -Recurse -File |
        Where-Object {
            @($_.Name.ToCharArray() | Where-Object {
                [int]$_ -ge 0x80 -and [int]$_ -le 0x9f
            }).Count -gt 0
        })
    if ($controlNames.Count) {
        throw "Runtime con C1-control script path in $role`: $($controlNames.FullName -join '; ')"
    }

    $scriptPaths = @(
        (Join-Path $roleRoot 'script\bossË¢ÐÂ\taowu.lua'),
        (Join-Path $roleRoot 'script\item\±äÉí·û\taowu.lua')
    )
    foreach ($path in $scriptPaths) {
        if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
            throw "Thieu normalized Taowu script: $path"
        }
        $relative = $path.Substring($roleRoot.Length + 1)
        $hashes["$role|$relative"] = (Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash
    }

    foreach ($relative in 'settings\systemtimetask.txt', 'settings\item\001\magicscript.txt') {
        $path = Join-Path $roleRoot $relative
        $text = $latin1.GetString([IO.File]::ReadAllBytes($path))
        if ($text.Contains($badText)) {
            throw "VNG setting con unopenable Taowu bytes: $path"
        }
        if ($text -notmatch '(?i)\\taowu\.lua') {
            throw "VNG setting thieu taowu.lua alias: $path"
        }
        $hashes["$role|$relative"] = (Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash
    }
}

foreach ($relative in @(
    'script\bossË¢ÐÂ\taowu.lua',
    'script\item\±äÉí·û\taowu.lua',
    'settings\systemtimetask.txt',
    'settings\item\001\magicscript.txt'
)) {
    if ($hashes["Client|$relative"] -ne $hashes["Server|$relative"]) {
        throw "Client/server Taowu hash mismatch: $relative"
    }
}

[pscustomobject]@{
    Status = 'PASS'
    RuntimeRoot = $RuntimeRoot
    NormalizedScripts = 4
    PatchedSettings = 4
    ClientServerHashPairs = 4
}
