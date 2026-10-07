[CmdletBinding()]
param([string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot))
$ErrorActionPreference = 'Stop'
$vcRoot = 'D:\VisualStudio6\VisualStudio6portable-langman.congdongcviet\Microsoft Visual Studio\VC98'
$compiler = Join-Path $vcRoot 'Bin\cl.exe'
if (-not (Test-Path -LiteralPath $compiler)) { throw "Compiler missing: $compiler" }
$output = Join-Path $ProjectRoot 'Output\Tools'
New-Item -ItemType Directory -Path $output -Force | Out-Null
$exe = Join-Path $output 'PhongThanWorldProtocolTests.exe'
$obj = Join-Path $output 'PhongThanWorldProtocolTests.obj'
$oldPath = $env:PATH
$oldLib = $env:LIB
try {
    $env:PATH = (Join-Path $vcRoot 'Bin') + ';' +
        (Join-Path (Split-Path -Parent $vcRoot) 'Common\MSDev98\Bin') + ';' + $oldPath
    $env:LIB = (Join-Path $vcRoot 'Lib') + ';' + $oldLib
    & $compiler /nologo /W3 /GX /MT /O2 "/I$(Join-Path $vcRoot 'Include')" `
        "/I$(Join-Path $ProjectRoot 'Headers')" "/I$(Join-Path $ProjectRoot 'Sources\Core\Src')" "/Fo$obj" "/Fe$exe" `
        (Join-Path $PSScriptRoot 'PhongThanWorldProtocolTests.cpp') /link kernel32.lib
    if ($LASTEXITCODE -ne 0) { throw 'Native world protocol test compilation failed.' }
    & $exe
    if ($LASTEXITCODE -ne 0) { throw 'Native world protocol tests failed.' }
} finally {
    $env:PATH = $oldPath
    $env:LIB = $oldLib
}
