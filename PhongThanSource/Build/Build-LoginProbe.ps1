$ErrorActionPreference='Stop'
$root=Split-Path -Parent $PSScriptRoot
$vc='D:\VisualStudio6\VisualStudio6portable-langman.congdongcviet\Microsoft Visual Studio\VC98'
$env:PATH="$vc\Bin;$(Split-Path -Parent $vc)\Common\MSDev98\Bin;$env:PATH"
$env:LIB="$vc\Lib;$env:LIB"
& "$vc\Bin\cl.exe" /nologo /W3 /GX /MT /O2 /DWIN32 "/I$vc\Include" "/I$root\Headers" "/I$root\Sources\Core\Src" "/I$root\Sources\Engine\Src" `
    "/Fo$root\Output\Tools\PhongThanLoginProbe.obj" "/Fe$root\Output\Tools\PhongThanLoginProbe.exe" `
    "$root\Tests\Native\PhongThanLoginProbe.cpp" /link kernel32.lib ole32.lib uuid.lib
if($LASTEXITCODE){throw 'Login probe compile failed'}
