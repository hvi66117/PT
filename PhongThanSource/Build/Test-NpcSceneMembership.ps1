$ErrorActionPreference = 'Stop'
$root = Split-Path -Parent $PSScriptRoot
$vc = 'D:\VisualStudio6\VisualStudio6portable-langman.congdongcviet\Microsoft Visual Studio\VC98'
$output = Join-Path $root 'Output\NpcSceneMembershipTests'
New-Item -ItemType Directory -Path $output -Force | Out-Null
$previousPath = $env:PATH
$previousLib = $env:LIB
Push-Location -LiteralPath $root
try {
    $runtimeClient = Join-Path (Split-Path -Parent $root) 'PhongThanRuntime-Staging\Client'
    $env:PATH = "$vc\Bin;$(Split-Path -Parent $vc)\Common\MSDev98\Bin;$root\Sources\Engine\Release;$runtimeClient;$previousPath"
    $env:LIB = "$vc\Lib;$previousLib"
    $sources = @(
        "$root\Tests\Native\NpcSceneMembershipTests.cpp",
        "$root\Sources\Core\Src\Scene\KIpotBranch.cpp",
        "$root\Sources\Core\Src\Scene\KIpotLeaf.cpp",
        "$root\Sources\Core\Src\Scene\SceneMath.cpp"
    )
    & "$vc\Bin\cl.exe" /nologo /W3 /GX /MT /O2 /Gy /DWIN32 /D_STANDALONE `
        "/I$vc\Include" "/I$root\Headers" "/I$root\Sources" "/I$root\Sources\Core" `
        "/I$root\Sources\Core\Src" "/I$root\Sources\Engine\Src" "/I$root\Sources\Engine\Include" `
        "/Fo$output\\" "/Fe$output\NpcSceneMembershipTests.exe" @sources `
        /link /OPT:REF Lib\release\engine.lib kernel32.lib user32.lib
    if ($LASTEXITCODE) { throw 'NPC scene membership regression compile failed' }
    & "$output\NpcSceneMembershipTests.exe"
    if ($LASTEXITCODE) { throw "NPC scene membership regression failed: $LASTEXITCODE" }
}
finally {
    Pop-Location
    $env:PATH = $previousPath
    $env:LIB = $previousLib
}
