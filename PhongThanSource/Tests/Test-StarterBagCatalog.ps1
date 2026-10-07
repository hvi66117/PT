[CmdletBinding()]
param([string]$ProjectRoot,[string]$RuntimeRoot='D:\Lam game phong than\PhongThanRuntime-Staging')
$ErrorActionPreference='Stop'
if(-not $ProjectRoot){$ProjectRoot=Split-Path -Parent $PSScriptRoot}
$vc='D:\VisualStudio6\VisualStudio6portable-langman.congdongcviet\Microsoft Visual Studio\VC98'
$oldPath,$oldInclude,$oldLib=$env:PATH,$env:INCLUDE,$env:LIB
try {
    $env:PATH="$vc\Bin;$(Split-Path -Parent $vc)\Common\MSDev98\Bin;$oldPath"
    $env:INCLUDE="$vc\Include;$ProjectRoot\Headers;$ProjectRoot\Sources\Engine\Src;$ProjectRoot\Sources\Core\Src;$oldInclude"
    $env:LIB="$vc\Lib;$oldLib"
    $out=Join-Path $ProjectRoot 'Output\Tools';$exe=Join-Path $out 'StarterBagCatalogTests.exe'
    & "$vc\Bin\cl.exe" /nologo /MT /W3 /O2 /DWIN32 /DNDEBUG "/Fo$out\\" "/Fe$exe" `
        "$ProjectRoot\Tests\Native\StarterBagCatalogTests.cpp" "$ProjectRoot\Sources\Core\Src\KBasPropTbl.CPP" "$ProjectRoot\Sources\Engine\Release\Engine.lib" /link /subsystem:console /machine:I386
    if($LASTEXITCODE){throw 'StarterBagCatalogTests compile failed'}
    Push-Location (Join-Path $RuntimeRoot 'Server')
    try { & $exe (Join-Path $out 'StarterBagCatalog-raw.txt'); if($LASTEXITCODE){throw 'Starter bag catalog validation failed'} }
    finally {Pop-Location}
} finally {$env:PATH,$env:INCLUDE,$env:LIB=$oldPath,$oldInclude,$oldLib}
