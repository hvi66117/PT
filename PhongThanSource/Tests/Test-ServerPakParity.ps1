[CmdletBinding()]
param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$RuntimeRoot = 'D:\Lam game phong than\PhongThanRuntime-Staging',
    [switch]$FullHash
)

$ErrorActionPreference = 'Stop'
$RuntimeRoot = [IO.Path]::GetFullPath($RuntimeRoot).TrimEnd('\')
$clientRoot = Join-Path $RuntimeRoot 'Client'
$serverRoot = Join-Path $RuntimeRoot 'Server'
$clientPackageIni = Join-Path $clientRoot 'package.ini'
$serverPackageIni = Join-Path $serverRoot 'package.ini'
foreach ($required in $clientPackageIni, $serverPackageIni) {
    if (-not (Test-Path -LiteralPath $required -PathType Leaf)) { throw "Missing package registry: $required" }
}
if ((Get-FileHash -LiteralPath $clientPackageIni).Hash -ne
    (Get-FileHash -LiteralPath $serverPackageIni).Hash) {
    throw 'Client and server package.ini are not byte-identical.'
}
$text = [IO.File]::ReadAllText($serverPackageIni, [Text.Encoding]::GetEncoding(936))
if ($text -notmatch '(?im)^\s*Path\s*=\s*\\data\s*$') { throw 'Server package.ini is not bound to \data.' }
$entries = @([regex]::Matches($text, '(?im)^\s*(\d+)\s*=\s*([^\r\n;]+?)\s*$') | ForEach-Object {
    [pscustomobject]@{ Priority = [int]$_.Groups[1].Value; Name = $_.Groups[2].Value.Trim() }
} | Sort-Object Priority)
if (-not $entries.Count) { throw 'Server PAK chain is empty.' }

$receiptPath = Join-Path $RuntimeRoot 'NATIVE_DEPLOYMENT.json'
$receipt = if (Test-Path -LiteralPath $receiptPath) {
    Get-Content -LiteralPath $receiptPath -Raw | ConvertFrom-Json
} else { $null }
$receiptEntries = @{}
if ($receipt -and $receipt.PakChain) {
    foreach ($entry in @($receipt.PakChain.Entries)) { $receiptEntries[[string]$entry.Name] = $entry }
}

$total = 0L
foreach ($entry in $entries) {
    $clientPak = Join-Path $clientRoot ('data\' + $entry.Name)
    $serverPak = Join-Path $serverRoot ('data\' + $entry.Name)
    foreach ($required in $clientPak, $serverPak) {
        if (-not (Test-Path -LiteralPath $required -PathType Leaf)) { throw "Missing synchronized PAK: $required" }
    }
    $clientInfo = Get-Item -LiteralPath $clientPak
    $serverInfo = Get-Item -LiteralPath $serverPak
    if ($clientInfo.Length -ne $serverInfo.Length) { throw "PAK length mismatch: $($entry.Name)" }
    $total += $clientInfo.Length
    if ($receiptEntries.Count) {
        $record = $receiptEntries[$entry.Name]
        if (-not $record -or [long]$record.Length -ne $clientInfo.Length -or
            [int]$record.Priority -ne $entry.Priority) {
            throw "Deployment receipt mismatch: $($entry.Name)"
        }
    }
    if ($FullHash) {
        $clientHash = (Get-FileHash -LiteralPath $clientPak -Algorithm SHA256).Hash
        $serverHash = (Get-FileHash -LiteralPath $serverPak -Algorithm SHA256).Hash
        if ($clientHash -ne $serverHash) { throw "PAK hash mismatch: $($entry.Name)" }
        if ($receiptEntries.Count -and $receiptEntries[$entry.Name].Sha256 -ne $clientHash) {
            throw "PAK receipt hash mismatch: $($entry.Name)"
        }
    }
}

[pscustomobject]@{
    Result = 'PASS'
    Mode = 'PAK_FIRST_LOOSE_FALLBACK'
    Packages = $entries.Count
    TotalBytes = $total
    FullHash = [bool]$FullHash
}
