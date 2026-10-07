$ErrorActionPreference='Stop'
$root=Split-Path -Parent $PSScriptRoot
Push-Location $root
try {
    $vc='D:\VisualStudio6\VisualStudio6portable-langman.congdongcviet\Microsoft Visual Studio\VC98'
    $env:PATH="$vc\Bin;$(Split-Path $vc)\Common\MSDev98\Bin;$root\Output\Client;$env:PATH"
    $env:LIB="$vc\Lib;$env:LIB"
    & "$vc\Bin\cl.exe" /nologo /W3 /MT /O2 "/I$vc\Include" /FoOutput/NpcRestorationTests/Visibility.obj /FeOutput/NpcRestorationTests/Visibility.exe Tests/Native/NpcVisibilityTests.cpp
    if($LASTEXITCODE){throw 'Visibility test build failed'}
    & .\Output\NpcRestorationTests\Visibility.exe
    if($LASTEXITCODE){throw 'Visibility assertions failed'}
    & "$vc\Bin\cl.exe" /nologo /W3 /GX /MT /O2 /Gy /DWIN32 /D_STANDALONE "/I$vc\Include" /IHeaders /ISources/Core/Src /ISources/Engine/Src /ISources/Engine/Include /FoOutput/NpcRestorationTests/ /FeOutput/NpcRestorationTests/ResourcePipeline.exe Tests/Native/NpcResourcePipeline.cpp Sources/Core/Src/KNpcResNode.cpp Lib/release/engine.lib /link /OPT:REF kernel32.lib user32.lib
    if($LASTEXITCODE){throw 'Resource pipeline test build failed'}
    $report=Get-Content Docs/NPC_RESTORATION_DEPLOYMENT.json -Raw | ConvertFrom-Json
    $ids=@($report.rows | Where-Object {$_.status -eq 'READY'} | Select-Object -ExpandProperty template -Unique)
    & .\Output\NpcRestorationTests\ResourcePipeline.exe 'D:\Lam game phong than\PhongThanRuntime-Staging\Client' @ids
    if($LASTEXITCODE){throw 'Actual NPC resource pipeline failed'}
} finally { Pop-Location }
