[CmdletBinding()]
param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$PackageCache = 'D:\Lam game phong than\SDKCache'
)

$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.IO.Compression.FileSystem

$common = Join-Path $PackageCache 'microsoft.windows.sdk.cpp.10.0.22000.194.nupkg'
$x86 = Join-Path $PackageCache 'microsoft.windows.sdk.cpp.x86.10.0.22000.194.nupkg'
$expected = @{
    $common = '77AF7CF5E7BA2D5EA56B48BC8154EFCE635AC85C4ACAE4F91C101242DBB5DB9E'
    $x86 = '17778D703AC6FC9FE9D289CC870C6323F675604157AB50636BF1762F065A4A46'
}
foreach ($package in $expected.Keys) {
    if (-not (Test-Path -LiteralPath $package)) { throw "Thieu SDK package: $package" }
    $actual = (Get-FileHash -LiteralPath $package -Algorithm SHA256).Hash
    if ($actual -ne $expected[$package]) { throw "Sai SHA-256: $package" }
}

$sdkRoot = Join-Path $ProjectRoot 'ThirdParty\WindowsSDK\GDIPlus'
$include = Join-Path $sdkRoot 'Include'
$lib = Join-Path $sdkRoot 'Lib\x86'
New-Item -ItemType Directory -Path $include, $lib -Force | Out-Null

$zip = [IO.Compression.ZipFile]::OpenRead($common)
try {
    $headers = $zip.Entries | Where-Object { $_.FullName -match '(?i)^c/Include/10\.0\.22000\.0/um/gdiplus[^/]*\.h$' }
    foreach ($entry in $headers) {
        [IO.Compression.ZipFileExtensions]::ExtractToFile($entry, (Join-Path $include $entry.Name), $true)
    }
    foreach ($sharedName in 'winapifamily.h', 'winpackagefamily.h') {
        $entry = $zip.Entries |
            Where-Object { $_.FullName -ieq "c/Include/10.0.22000.0/shared/$sharedName" } |
            Select-Object -First 1
        if (-not $entry) { throw "Khong tim thay $sharedName." }
        [IO.Compression.ZipFileExtensions]::ExtractToFile($entry, (Join-Path $include $entry.Name), $true)
    }
} finally { $zip.Dispose() }

$zip = [IO.Compression.ZipFile]::OpenRead($x86)
try {
    $entry = $zip.Entries | Where-Object { $_.FullName -ieq 'c/um/x86/gdiplus.lib' } | Select-Object -First 1
    if (-not $entry) { throw 'Khong tim thay gdiplus.lib x86.' }
    [IO.Compression.ZipFileExtensions]::ExtractToFile($entry, (Join-Path $lib 'GdiPlus.WinSdk.lib'), $true)
} finally { $zip.Dispose() }

[pscustomobject]@{
    HeaderCount = @(Get-ChildItem -LiteralPath $include -Filter '*.h').Count
    WinSdkImportLibrary = Join-Path $lib 'GdiPlus.WinSdk.lib'
}
