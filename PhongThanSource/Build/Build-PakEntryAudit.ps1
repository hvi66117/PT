[CmdletBinding()]
param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$CompilerPath,
    [string]$OutputPath
)

$ErrorActionPreference = 'Stop'
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
if (-not $OutputPath) { $OutputPath = Join-Path $ProjectRoot 'Output\Tools\PakEntryAudit.exe' }
$OutputPath = [IO.Path]::GetFullPath($OutputPath)
$source = Join-Path $ProjectRoot 'Tests\Native\PakEntryAudit.cpp'
$engineSrc = Join-Path $ProjectRoot 'Sources\Engine\Src'
$engineLib = Join-Path $ProjectRoot 'Sources\Engine\Release\Engine.lib'
if (-not $CompilerPath) {
    $CompilerPath = @(
        $env:PHONGTHAN_CL,
        'D:\VisualStudio6\VisualStudio6portable-langman.congdongcviet\Microsoft Visual Studio\VC98\Bin\CL.EXE',
        'C:\Program Files (x86)\Microsoft Visual Studio\VC98\Bin\CL.EXE',
        'C:\Program Files\Microsoft Visual Studio\VC98\Bin\CL.EXE'
    ) | Where-Object { $_ -and (Test-Path -LiteralPath $_ -PathType Leaf) } | Select-Object -First 1
}
if (-not $CompilerPath) { throw 'Khong tim thay VC6 CL.EXE.' }
$CompilerPath = [IO.Path]::GetFullPath([string]$CompilerPath)
$vcRoot = Split-Path -Parent (Split-Path -Parent $CompilerPath)
$visualStudioRoot = Split-Path -Parent $vcRoot
$compilerBin = Split-Path -Parent $CompilerPath
$commonBin = Join-Path $visualStudioRoot 'Common\MSDev98\Bin'
$vcInclude = Join-Path $vcRoot 'Include'
$vcLib = Join-Path $vcRoot 'Lib'
foreach ($required in $source, $engineLib, (Join-Path $vcInclude 'windows.h')) {
    if (-not (Test-Path -LiteralPath $required -PathType Leaf)) { throw "Thieu dependency: $required" }
}
New-Item -ItemType Directory -Path (Split-Path -Parent $OutputPath) -Force | Out-Null
$objectPath = [IO.Path]::ChangeExtension($OutputPath, '.obj')
$oldInclude, $oldLib, $oldPath = $env:INCLUDE, $env:LIB, $env:PATH
try {
    $env:INCLUDE = "$vcInclude;$engineSrc;$oldInclude"
    $env:LIB = "$vcLib;$oldLib"
    $env:PATH = "$compilerBin;$commonBin;$oldPath"
    & $CompilerPath /nologo /MT /W3 /O2 /D "WIN32" /D "NDEBUG" `
        /Fo"$objectPath" /Fe"$OutputPath" $source $engineLib `
        /link /subsystem:console /machine:I386
    if ($LASTEXITCODE -ne 0) { throw "Build PakEntryAudit that bai: $LASTEXITCODE" }
}
finally {
    $env:INCLUDE, $env:LIB, $env:PATH = $oldInclude, $oldLib, $oldPath
}
[pscustomobject]@{
    Status = 'PASS'
    Output = $OutputPath
    Sha256 = (Get-FileHash -LiteralPath $OutputPath -Algorithm SHA256).Hash
}
