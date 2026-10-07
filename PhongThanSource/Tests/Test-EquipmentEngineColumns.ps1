param([string]$RuntimeRoot='D:\Lam game phong than\PhongThanRuntime-Staging\Server')
$ErrorActionPreference='Stop'
$root=Split-Path -Parent $PSScriptRoot
$vc='D:\VisualStudio6\VisualStudio6portable-langman.congdongcviet\Microsoft Visual Studio\VC98'
$oldPath=$env:PATH;$oldInclude=$env:INCLUDE;$oldLib=$env:LIB
try {
 $env:PATH="$vc\Bin;$(Split-Path $vc)\Common\MSDev98\Bin;$oldPath"
 $env:INCLUDE="$vc\Include;$root\Sources\Engine\Src"
 $env:LIB="$vc\Lib"
 & "$vc\Bin\CL.EXE" /nologo /MT /GX /W0 /DREAL_ENGINE_TABLE "/Fo$root\Output\Tools\EquipmentEngineTests.obj" "/Fe$root\Output\Tools\EquipmentEngineTests.exe" "$root\Tests\Native\EquipmentColumnTests.cpp" "$root\Sources\Engine\Release\Engine.lib" /link kernel32.lib user32.lib
 if($LASTEXITCODE -ne 0){throw 'Engine column test build failed'}
 Push-Location $RuntimeRoot
 try {
  & "$root\Output\Tools\EquipmentEngineTests.exe" package.ini
  if($LASTEXITCODE -ne 0){throw 'Engine column integration failed'}
 } finally {Pop-Location}
} finally {$env:PATH=$oldPath;$env:INCLUDE=$oldInclude;$env:LIB=$oldLib}
