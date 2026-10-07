param([string]$ProjectRoot=(Split-Path -Parent $PSScriptRoot),[string]$ServerRoot='D:\Lam game phong than\PhongThanRuntime-Staging\Server')
$ErrorActionPreference='Stop'
$out=Join-Path $ProjectRoot 'Output\ExperienceItem1355Test'
New-Item -ItemType Directory -Path $out -Force | Out-Null
$source=Get-Content -LiteralPath (Join-Path $ProjectRoot 'Sources\Core\Src\ScriptFuns.cpp') -Raw
$parts=foreach($name in 'GetPlayerIndex','MapVngNormalItemTuple','GetVngNormalTuple','LuaHaveNormalItemCompat','LuaDelNormalItemCompat') {
    $pattern='(?ms)^(?:static )?(?:int|BOOL)\s+'+[regex]::Escape($name)+'\([^;]*?\)\s*\{.*?^\}'
    $match=[regex]::Match($source,$pattern)
    if(-not $match.Success){throw "Cannot extract native function: $name"}
    $match.Value
}
# Generated test translation unit, not a second implementation of the APIs.
[IO.File]::WriteAllText((Join-Path $out 'ExperienceItem1355Native.inc'),($parts -join "`r`n"),[Text.UTF8Encoding]::new($false))
foreach($dll in 'Engine.dll','LuaLibDll.dll'){Copy-Item -LiteralPath (Join-Path $ServerRoot $dll) -Destination $out -Force}
$vc='D:\VisualStudio6\VisualStudio6portable-langman.congdongcviet\Microsoft Visual Studio\VC98'
$savedPath=$env:PATH;$savedLib=$env:LIB
try {
    $env:PATH="$vc\Bin;$(Split-Path -Parent $vc)\Common\MSDev98\Bin;$savedPath";$env:LIB="$vc\Lib;$savedLib"
    & "$vc\Bin\cl.exe" /nologo /W3 /GX /MT /O2 /DWIN32 "/I$vc\Include" "/I$out" "/I$ProjectRoot\Sources\Engine\Src" `
      "/Fo$out\ExperienceItem1355Tests.obj" "/Fe$out\ExperienceItem1355Tests.exe" `
      "$ProjectRoot\Tests\Native\ExperienceItem1355Tests.cpp" "$ProjectRoot\Lib\release\engine.lib" "$ProjectRoot\Lib\LuaLibDll.lib" /link kernel32.lib user32.lib
    if($LASTEXITCODE){throw '1355 regression test compile failed'}
    & "$out\ExperienceItem1355Tests.exe" $ServerRoot
    if($LASTEXITCODE){throw '1355 regression test failed'}
} finally {$env:PATH=$savedPath;$env:LIB=$savedLib}
