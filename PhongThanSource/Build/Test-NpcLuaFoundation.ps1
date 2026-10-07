$ErrorActionPreference='Stop'
$root=Split-Path -Parent $PSScriptRoot
$vc='D:\VisualStudio6\VisualStudio6portable-langman.congdongcviet\Microsoft Visual Studio\VC98'
$python='C:\Users\UCT\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe'
$oldPath=$env:PATH;$oldLib=$env:LIB
Push-Location $root
try {
    $env:PATH="$vc\Bin;$(Split-Path -Parent $vc)\Common\MSDev98\Bin;$root\Output\Client;$env:PATH"
    $env:LIB="$vc\Lib;$env:LIB"
    & $python Tests/test_npc_lua_library.py
    if($LASTEXITCODE){throw 'Lua library test failed'}
    & $python Tests/test_npc_lua_library.py --fixture
    if($LASTEXITCODE){throw 'Include fixture failed'}
    foreach($spec in @(@('Include','NpcLuaIncludeTests'),@('Compose','NpcComposeRecipeTests'),@('Transaction','NpcComposeTransactionTests'))){
        $name=$spec[0];$src=$spec[1]
        & "$vc\Bin\cl.exe" /nologo /W3 /GX /MT /O2 /DWIN32 "/I$vc\Include" /ISources/Engine/Src /ISources/Engine/Include `
            "/FoOutput/NpcLuaIncludeTests/$name.obj" "/FeOutput/NpcLuaIncludeTests/$name.exe" "Tests/Native/$src.cpp" Lib/release/engine.lib Lib/LuaLibDll.lib /link kernel32.lib user32.lib
        if($LASTEXITCODE){throw "Compile failed: $src"}
        $data=if($name -eq 'Include'){Join-Path $root 'Output/NpcLuaIncludeTests/fixture'}else{Join-Path (Split-Path -Parent $root) 'PhongThanRuntime-Staging/Client'}
        & ".\Output\NpcLuaIncludeTests\$name.exe" $data
        if($LASTEXITCODE){throw "Test failed: $src"}
    }
} finally {Pop-Location;$env:PATH=$oldPath;$env:LIB=$oldLib}
