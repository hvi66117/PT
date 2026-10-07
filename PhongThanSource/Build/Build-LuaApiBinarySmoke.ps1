[CmdletBinding()]
param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$CompilerPath,
    [string]$OutputPath
)

$ErrorActionPreference = 'Stop'
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
if (-not $OutputPath) { $OutputPath = Join-Path $ProjectRoot 'Output\Tools\LuaApiBinarySmoke.exe' }
$OutputPath = [IO.Path]::GetFullPath($OutputPath)
$source = Join-Path $ProjectRoot 'Tests\Native\LuaApiBinarySmoke.cpp'

if (-not $CompilerPath) {
    $candidates = @(
        $env:PHONGTHAN_CL,
        'D:\VisualStudio6\VisualStudio6portable-langman.congdongcviet\Microsoft Visual Studio\VC98\Bin\CL.EXE',
        'C:\Program Files (x86)\Microsoft Visual Studio\VC98\Bin\CL.EXE',
        'C:\Program Files\Microsoft Visual Studio\VC98\Bin\CL.EXE'
    ) | Where-Object { $_ }
    $CompilerPath = @($candidates | Where-Object { Test-Path -LiteralPath $_ -PathType Leaf } | Select-Object -First 1)
}
if (-not $CompilerPath -or -not (Test-Path -LiteralPath $CompilerPath -PathType Leaf)) {
    throw 'Khong tim thay VC6 CL.EXE.'
}
$CompilerPath = [IO.Path]::GetFullPath([string]$CompilerPath)
$vcRoot = Split-Path -Parent (Split-Path -Parent $CompilerPath)
$visualStudioRoot = Split-Path -Parent $vcRoot
$commonBin = Join-Path $visualStudioRoot 'Common\MSDev98\Bin'
$compilerBin = Split-Path -Parent $CompilerPath
$include = Join-Path $vcRoot 'Include'
$lib = Join-Path $vcRoot 'Lib'
foreach ($required in $source, (Join-Path $include 'windows.h'), (Join-Path $lib 'kernel32.lib')) {
    if (-not (Test-Path -LiteralPath $required -PathType Leaf)) { throw "Thieu native smoke dependency: $required" }
}
New-Item -ItemType Directory -Path (Split-Path -Parent $OutputPath) -Force | Out-Null
$objectPath = [IO.Path]::ChangeExtension($OutputPath, '.obj')
$oldInclude = $env:INCLUDE
$oldLib = $env:LIB
$oldPath = $env:PATH
try {
    $env:INCLUDE = "$include;$oldInclude"
    $env:LIB = "$lib;$oldLib"
    $env:PATH = "$compilerBin;$commonBin;$oldPath"
    & $CompilerPath /nologo /MT /W3 /O2 /D "WIN32" /D "NDEBUG" /Fo"$objectPath" /Fe"$OutputPath" $source /link /subsystem:console /machine:I386
    if ($LASTEXITCODE -ne 0) { throw "Build LuaApiBinarySmoke that bai: $LASTEXITCODE" }
}
finally {
    $env:INCLUDE = $oldInclude
    $env:LIB = $oldLib
    $env:PATH = $oldPath
}
if (-not (Test-Path -LiteralPath $OutputPath -PathType Leaf)) { throw "Build khong tao $OutputPath" }
[pscustomobject]@{
    Status = 'PASS'
    Output = $OutputPath
    Sha256 = (Get-FileHash -LiteralPath $OutputPath -Algorithm SHA256).Hash
}
