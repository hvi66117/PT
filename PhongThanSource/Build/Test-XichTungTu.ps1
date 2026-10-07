$ErrorActionPreference='Stop'
$sourceRoot=Split-Path -Parent $PSScriptRoot
$vcRoot='D:\VisualStudio6\VisualStudio6portable-langman.congdongcviet\Microsoft Visual Studio\VC98'
$python='C:\Users\UCT\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe'
$oldPath=$env:PATH;$oldLib=$env:LIB
Push-Location $sourceRoot
try {
    $env:PATH="$vcRoot\Bin;$(Split-Path $vcRoot)\Common\MSDev98\Bin;$sourceRoot\Output\Client;$env:PATH"
    $env:LIB="$vcRoot\Lib;$env:LIB"
    & $python Tools/build_xich_tung_tu.py
    if($LASTEXITCODE){throw 'Xich Tung Tu provenance/artifact check failed'}
    $outputRoot=Join-Path $sourceRoot 'Output\NpcLuaIncludeTests'
    New-Item -ItemType Directory -Force -Path $outputRoot | Out-Null
    foreach($name in @('XichTungTuTests','NpcComposeRecipeTests','NpcComposeTransactionTests')){
        & "$vcRoot\Bin\cl.exe" /nologo /W3 /GX /MT /O2 /DWIN32 "/I$vcRoot\Include" `
            /ISources/Engine/Src /ISources/Engine/Include "/Fo$outputRoot\$name.obj" "/Fe$outputRoot\$name.exe" `
            "Tests/Native/$name.cpp" Lib/release/engine.lib Lib/LuaLibDll.lib /link kernel32.lib user32.lib
        if($LASTEXITCODE){throw "Compile failed: $name"}
        $data=if($name -eq 'XichTungTuTests'){"$sourceRoot\Tests\fixtures\XichTungTu"}else{
            Join-Path (Split-Path $sourceRoot) 'PhongThanRuntime-Staging\Server'
        }
        & "$outputRoot\$name.exe" $data
        if($LASTEXITCODE){throw "Test failed: $name"}
    }
    # Use the actual persistence implementation, in an isolated directory only.
    & "$vcRoot\Bin\cl.exe" /nologo /W3 /GX /MT /O2 /DWIN32 "/I$vcRoot\Include" /IHeaders `
        "/Fo$outputRoot\UpgradeStore.obj" "/Fe$outputRoot\UpgradeStore.exe" `
        Tests/Native/EquipmentStoreRoundTrip.cpp Output/NpcRestorationTests/PhongThanCharacterStore.obj /link kernel32.lib user32.lib
    if($LASTEXITCODE){throw 'Compile failed: UpgradeStore'}
    $storeRoot=Join-Path $outputRoot ('Store-'+[Guid]::NewGuid().ToString('N'))
    New-Item -ItemType Directory -Path $storeRoot | Out-Null
    & "$outputRoot\UpgradeStore.exe" $storeRoot
    if($LASTEXITCODE){throw 'CharacterStore upgrade roundtrip failed'}
    foreach($name in @('ItemUpgradeStateTests','EquipmentComposeTests')){
        & "$vcRoot\Bin\cl.exe" /nologo /W3 /GX /MT /O2 /DWIN32 /D_SERVER /D_STANDALONE /FIIClient.h `
            "/I$vcRoot\Include" /IHeaders /ISources/Core/Src /ISources/Engine/Src /ISources/Engine/Include `
            "/Fo$outputRoot\$name.obj" "/Fe$outputRoot\$name.exe" "Tests/Native/$name.cpp" `
            Lib/release/engine.lib Lib/release/common.lib /link kernel32.lib user32.lib
        if($LASTEXITCODE){throw "Compile failed: $name"}
        & "$outputRoot\$name.exe" (Join-Path (Split-Path $sourceRoot) 'PhongThanRuntime-Staging\Server')
        if($LASTEXITCODE){throw "Test failed: $name"}
    }
} finally {Pop-Location;$env:PATH=$oldPath;$env:LIB=$oldLib}
