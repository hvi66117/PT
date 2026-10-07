$ErrorActionPreference = 'Stop'

$sourceRoot = Split-Path -Parent $PSScriptRoot
$vcRoot = 'D:\VisualStudio6\VisualStudio6portable-langman.congdongcviet\Microsoft Visual Studio\VC98'
$python = 'C:\Users\UCT\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe'
$compiler = Join-Path $vcRoot 'Bin\cl.exe'
$linker = Join-Path $vcRoot 'Bin\link.exe'
$luaOutput = Join-Path $sourceRoot 'Output\NpcLuaIncludeTests'
$questOutput = Join-Path $sourceRoot 'Output\NpcRestorationTests'
$stagingRoot = Split-Path -Parent $sourceRoot
$oldPath = $env:PATH
$oldLib = $env:LIB

function Assert-LastExitCode([string]$operation) {
    if ($LASTEXITCODE -ne 0) {
        throw "$operation failed with exit code $LASTEXITCODE"
    }
}

Push-Location $sourceRoot
try {
    New-Item -ItemType Directory -Force -Path $luaOutput, $questOutput | Out-Null
    $env:PATH = "$vcRoot\Bin;$(Split-Path $vcRoot)\Common\MSDev98\Bin;$sourceRoot\Output\Client;$env:PATH"
    $env:LIB = "$vcRoot\Lib;$env:LIB"

    & $python 'Tools/prepare_original_npc_quest_tests.py'
    Assert-LastExitCode 'Original NPC quest provenance verification'
    & $python 'Tools/build_npc_quest_death.py'
    Assert-LastExitCode 'NPC death-script provenance verification'

    $nativeCommon = @(
        '/nologo', '/W3', '/GX', '/MT', '/O2', '/DWIN32',
        "/I$vcRoot\Include", '/ISources/Engine/Src', '/ISources/Engine/Include'
    )

    foreach ($test in @(
        @('Context', 'QuestLuaContextTests', $luaOutput),
        @('Exchange', 'QuestExchangeTests', $luaOutput),
        @('OriginalNpcQuestTests', 'OriginalNpcQuestTests', $questOutput),
        @('QuestDeathProgressTests', 'QuestDeathProgressTests', $questOutput)
    )) {
        $exeName = $test[0]
        $sourceName = $test[1]
        $outputRoot = $test[2]
        $compileArgs = $nativeCommon + @(
            "/Fo$outputRoot\$exeName.obj",
            "/Fe$outputRoot\$exeName.exe",
            "Tests/Native/$sourceName.cpp",
            'Lib/release/engine.lib', 'Lib/LuaLibDll.lib',
            '/link', 'kernel32.lib', 'user32.lib'
        )
        & $compiler @compileArgs
        Assert-LastExitCode "Compile $sourceName"
    }

    & "$luaOutput\Context.exe"
    Assert-LastExitCode 'Quest Lua context test'
    & "$luaOutput\Exchange.exe"
    Assert-LastExitCode 'Quest exchange test'
    & "$questOutput\OriginalNpcQuestTests.exe" "$sourceRoot\Tests\fixtures\NpcQuestOriginal"
    Assert-LastExitCode 'Original NPC quest-chain test'
    & "$questOutput\QuestDeathProgressTests.exe" "$sourceRoot\Deploy\ProjectContent\NpcQuests\compiled"
    Assert-LastExitCode 'NPC death-progress test'

    $tableCommon = $nativeCommon + @(
        '/D_SERVER', '/D_STANDALONE', '/FIIClient.h',
        '/IHeaders', '/ISources/Core/Src'
    )
    & $compiler @tableCommon "/Fo$luaOutput\KBasPropTbl.obj" /c 'Sources/Core/Src/KBasPropTbl.CPP'
    Assert-LastExitCode 'Compile item table registry'
    & $compiler @tableCommon "/Fo$luaOutput\QuestItemTupleTests.obj" /c 'Tests/Native/QuestItemTupleTests.cpp'
    Assert-LastExitCode 'Compile quest item tuple test'
    & $linker /nologo "/OUT:$luaOutput\QuestItemTuple.exe" `
        "$luaOutput\QuestItemTupleTests.obj" "$luaOutput\KBasPropTbl.obj" `
        'Lib/release/engine.lib' 'Lib/release/common.lib' 'kernel32.lib' 'user32.lib'
    Assert-LastExitCode 'Link quest item tuple test'

    foreach ($runtimeSide in @('Client', 'Server')) {
        & "$luaOutput\QuestItemTuple.exe" "$stagingRoot\PhongThanRuntime-Staging\$runtimeSide"
        Assert-LastExitCode "Quest item tables ($runtimeSide)"
    }

    Write-Host 'PASS NPC QUEST FOUNDATION: context, exchange, five original chains, death progress, VNG medicine and skill-book tables.'
}
finally {
    Pop-Location
    $env:PATH = $oldPath
    $env:LIB = $oldLib
}
