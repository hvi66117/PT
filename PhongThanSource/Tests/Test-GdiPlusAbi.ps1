[CmdletBinding()]
param(
    [string[]]$DllPath = @(
        (Join-Path (Split-Path -Parent $PSScriptRoot) 'Output\Client\Represent2.dll'),
        (Join-Path (Split-Path -Parent $PSScriptRoot) 'Output\Client\Represent3.dll')
    ),
    [string]$VcBin = 'D:\VisualStudio6\VisualStudio6portable-langman.congdongcviet\Microsoft Visual Studio\VC98\Bin',
    [string]$VsCommonBin = 'D:\VisualStudio6\VisualStudio6portable-langman.congdongcviet\Microsoft Visual Studio\COMMON\MSDev98\Bin'
)

$ErrorActionPreference = 'Stop'
$dumpbin = Join-Path $VcBin 'DUMPBIN.EXE'
if (-not (Test-Path -LiteralPath $dumpbin)) { throw "Thieu: $dumpbin" }
$env:PATH = "$VsCommonBin;$VcBin;$($env:PATH)"
$required = @(
    'GdiplusStartup', 'GdiplusShutdown',
    'GdipGetImageEncodersSize', 'GdipGetImageEncoders',
    'GdipSaveImageToFile', 'GdipLoadImageFromStream',
    'GdipAlloc', 'GdipFree', 'GdipDisposeImage', 'GdipCloneImage'
)

$results = New-Object System.Collections.Generic.List[object]
foreach ($path in $DllPath) {
    if (-not (Test-Path -LiteralPath $path)) { throw "Thieu DLL: $path" }
    $lines = @(& $dumpbin /nologo /imports $path 2>&1)
    if ($LASTEXITCODE -ne 0) { throw "DUMPBIN khong doc duoc: $path" }
    $text = $lines -join "`n"
    if ($text -notmatch '(?im)^\s*gdiplus\.dll\s*$') {
        throw "DLL khong import gdiplus.dll: $path"
    }
    $bad = @($lines | Select-String -Pattern '\bGdip(?:lus)?\w*@\d+\b')
    if ($bad.Count) {
        throw "DLL con import GDI+ sai ten co hau to @N: $path"
    }
    foreach ($name in $required) {
        if ($text -notmatch "(?m)^\s+[0-9A-F]+\s+$([regex]::Escape($name))\s*$") {
            throw "DLL thieu import GDI+ bat buoc $name`: $path"
        }
    }
    $results.Add([pscustomobject]@{
        Dll = $path
        ValidImportCount = $required.Count
        DecoratedImportCount = $bad.Count
        Sha256 = (Get-FileHash -LiteralPath $path -Algorithm SHA256).Hash
    })
}
$results
