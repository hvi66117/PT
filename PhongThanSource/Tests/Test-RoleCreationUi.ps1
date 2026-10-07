[CmdletBinding()]
param([string]$ProjectRoot,[string]$RuntimeRoot='D:\Lam game phong than\PhongThanRuntime-Staging')
$ErrorActionPreference='Stop'
if(-not $ProjectRoot){$ProjectRoot=Split-Path -Parent $PSScriptRoot}
$vc='D:\VisualStudio6\VisualStudio6portable-langman.congdongcviet\Microsoft Visual Studio\VC98'
$oldPath,$oldInclude,$oldLib=$env:PATH,$env:INCLUDE,$env:LIB
try {
    $env:PATH="$vc\Bin;$(Split-Path -Parent $vc)\Common\MSDev98\Bin;$oldPath"
    $env:INCLUDE="$vc\Include;$ProjectRoot\Sources\Engine\Src;$oldInclude"
    $env:LIB="$vc\Lib;$oldLib"
    $exe=Join-Path $ProjectRoot 'Output\Tools\RoleCreationUiTests.exe'
    & "$vc\Bin\cl.exe" /nologo /MT /W3 /O2 /DWIN32 /DNDEBUG "/Fo$ProjectRoot\Output\Tools\RoleCreationUiTests.obj" "/Fe$exe" `
        "$ProjectRoot\Tests\Native\RoleCreationUiTests.cpp" "$ProjectRoot\Sources\Engine\Release\Engine.lib" /link /subsystem:console /machine:I386
    if($LASTEXITCODE){throw 'RoleCreationUiTests compile failed'}
    Push-Location (Join-Path $RuntimeRoot 'Client')
    try { & $exe; if($LASTEXITCODE){throw 'Role creation UI validation failed'} }
    finally {Pop-Location}
} finally {$env:PATH,$env:INCLUDE,$env:LIB=$oldPath,$oldInclude,$oldLib}
