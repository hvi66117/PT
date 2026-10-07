[CmdletBinding()]
param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [Parameter(Mandatory = $true)]
    [string]$CharacterStore,
    [string]$RoleName = 'PhongThanNpc'
)

$ErrorActionPreference = 'Stop'
$vcRoot = 'D:\VisualStudio6\VisualStudio6portable-langman.congdongcviet\Microsoft Visual Studio\VC98'
$compiler = Join-Path $vcRoot 'Bin\cl.exe'
if (-not (Test-Path -LiteralPath $compiler -PathType Leaf)) {
    throw "Compiler missing: $compiler"
}
if (-not (Test-Path -LiteralPath $CharacterStore -PathType Container)) {
    throw "Character store missing: $CharacterStore"
}
$running = @(Get-CimInstance Win32_Process | Where-Object {
    $_.ExecutablePath -like '*\PhongThanRuntime-Staging\Server\*'
})
if ($running) {
    throw "Stop staging services before updating character state: $($running.Name -join ', ')"
}

$output = Join-Path $ProjectRoot 'Output\Tools'
New-Item -ItemType Directory -Path $output -Force | Out-Null
$exe = Join-Path $output 'GrantTestGiapSi.exe'
$objRoot = Join-Path $output 'GrantTestGiapSi'
New-Item -ItemType Directory -Path $objRoot -Force | Out-Null
$oldPath = $env:PATH
$oldLib = $env:LIB
try {
    $env:PATH = (Join-Path $vcRoot 'Bin') + ';' +
        (Join-Path (Split-Path -Parent $vcRoot) 'Common\MSDev98\Bin') + ';' + $oldPath
    $env:LIB = (Join-Path $vcRoot 'Lib') + ';' + $oldLib
    & $compiler /nologo /W3 /GX /MT /O2 `
        "/I$(Join-Path $vcRoot 'Include')" `
        "/I$(Join-Path $ProjectRoot 'Headers')" `
        "/Fo$objRoot\" "/Fe$exe" `
        (Join-Path $PSScriptRoot 'Native\GrantTestGiapSi.cpp') `
        (Join-Path $ProjectRoot 'Sources\MultiServer\Goddess\PhongThanCharacterStore.cpp') `
        /link kernel32.lib
    if ($LASTEXITCODE -ne 0) {
        throw 'GrantTestGiapSi compilation failed.'
    }
    & $exe ([IO.Path]::GetFullPath($CharacterStore)) $RoleName
    if ($LASTEXITCODE -ne 0) {
        throw "GrantTestGiapSi failed with exit code $LASTEXITCODE."
    }
} finally {
    $env:PATH = $oldPath
    $env:LIB = $oldLib
}
