$ErrorActionPreference='Stop'
$sourceRoot=Split-Path -Parent $PSScriptRoot
$vcRoot='D:\VisualStudio6\VisualStudio6portable-langman.congdongcviet\Microsoft Visual Studio\VC98'
$oldPath=$env:PATH;$oldLib=$env:LIB
Push-Location $sourceRoot
try {
    $env:PATH="$vcRoot\Bin;$(Split-Path $vcRoot)\Common\MSDev98\Bin;$sourceRoot\Output\Client;$oldPath"
    $env:LIB="$vcRoot\Lib;$oldLib"
    $out=Join-Path $sourceRoot 'Output\EquipmentPresentation'
    New-Item -ItemType Directory -Path $out -Force | Out-Null
    & "$vcRoot\Bin\cl.exe" /nologo /W3 /GX /MT /O2 /DWIN32 "/I$vcRoot\Include" /ISources/Engine/Src /ISources/Engine/Include `
        "/Fo$out\EquipmentPresentationTests.obj" "/Fe$out\EquipmentPresentationTests.exe" `
        Tests/Native/EquipmentPresentationTests.cpp Lib/release/engine.lib /link kernel32.lib user32.lib
    if($LASTEXITCODE){throw 'Equipment presentation test build failed'}
    & "$out\EquipmentPresentationTests.exe" (Join-Path (Split-Path $sourceRoot) 'PhongThanRuntime-Staging\Client')
    if($LASTEXITCODE){throw 'Equipment presentation tests failed'}
} finally {Pop-Location;$env:PATH=$oldPath;$env:LIB=$oldLib}
