[CmdletBinding()]
param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$RuntimeRoot,
    [int]$StartupWaitSeconds = 6
)

$ErrorActionPreference = 'Stop'
if (-not $RuntimeRoot) {
    $RuntimeRoot = Join-Path (Split-Path -Parent $ProjectRoot) 'PhongThanRuntime-Staging'
}
$clientRoot = Join-Path $RuntimeRoot 'Client'
$gamePath = Join-Path $clientRoot 'Game.exe'
$renderers = @(
    (Join-Path $clientRoot 'Represent2.dll'),
    (Join-Path $clientRoot 'Represent3.dll')
)
foreach ($path in @($gamePath) + $renderers) {
    if (-not (Test-Path -LiteralPath $path)) { throw "Thieu: $path" }
}

# Remove stale executables whose name only differs from Game.exe by an
# invisible trailing NBSP/space.  Such a hidden copy bypasses the artifact
# allowlist and can launch an older client even though Game.exe was updated.
$canonicalGameName = [IO.Path]::GetFileName($gamePath)
foreach ($candidate in Get-ChildItem -LiteralPath $clientRoot -File -Force) {
    $visibleName = $candidate.Name.TrimEnd([char]0x20, [char]0xA0)
    if ($candidate.Name -cne $canonicalGameName -and
        $visibleName -ieq $canonicalGameName) {
        $candidatePath = [IO.Path]::GetFullPath($candidate.FullName)
        if (-not $candidatePath.StartsWith(
                [IO.Path]::GetFullPath($clientRoot).TrimEnd('\') + '\',
                [StringComparison]::OrdinalIgnoreCase)) {
            throw "Executable ten an nam ngoai client root: $candidatePath"
        }
        [IO.File]::Delete($candidatePath)
    }
}

# Refuse to launch a runtime containing files outside the P0.1 allowlist.
if (Test-Path -LiteralPath (Join-Path $RuntimeRoot 'NATIVE_DEPLOYMENT.json')) {
    & (Join-Path $ProjectRoot 'Tests\Test-NativeRuntime.ps1') -ProjectRoot $ProjectRoot -RuntimeRoot $RuntimeRoot | Out-Null
} else {
    & (Join-Path $ProjectRoot 'Tests\Test-CleanRuntime.ps1') -RuntimeRoot $RuntimeRoot | Out-Null
}

# Fail before launch if a renderer can reproduce the GDI+ @N entry-point bug.
# The ABI probe needs the VC6 DUMPBIN from the build machine. On a play-only
# machine without VC6 the renderers were already verified by artifact hash in
# Test-NativeRuntime above, so the probe is skipped instead of blocking launch.
$gdiPlusTest = Join-Path $ProjectRoot 'Tests\Test-GdiPlusAbi.ps1'
$defaultVcBin = 'D:\VisualStudio6\VisualStudio6portable-langman.congdongcviet\Microsoft Visual Studio\VC98\Bin'
if (Test-Path -LiteralPath (Join-Path $defaultVcBin 'DUMPBIN.EXE')) {
    & $gdiPlusTest -DllPath $renderers | Out-Null
} else {
    Write-Warning 'Khong co VC6 DUMPBIN; bo qua Test-GdiPlusAbi (renderer da kiem tra bang hash).'
}

$running = Get-CimInstance Win32_Process -Filter "Name='Game.exe'" |
    Where-Object { $_.ExecutablePath -and
        ([IO.Path]::GetFullPath($_.ExecutablePath) -ieq [IO.Path]::GetFullPath($gamePath)) }
if ($running) {
    throw "Client staging da chay. PID: $($running.ProcessId -join ', ')"
}

# The renderer now owns its RGB565 work surfaces and lets DirectDraw convert
# them to the native desktop format. Keep only the non-colour compatibility
# flags required by the legacy window/input code.
$previousLayer = $env:__COMPAT_LAYER
try {
    $env:__COMPAT_LAYER = 'HIGHDPIAWARE'
    $process = Start-Process -FilePath $gamePath -WorkingDirectory $clientRoot -PassThru
} finally {
    $env:__COMPAT_LAYER = $previousLayer
}

Start-Sleep -Seconds $StartupWaitSeconds
$process.Refresh()
if ($process.HasExited) {
    throw "Client staging tu thoat. ExitCode=$($process.ExitCode)"
}
if (-not $process.Responding) {
    throw "Client staging khong phan hoi. PID=$($process.Id)"
}

[pscustomobject]@{
    Pid = $process.Id
    Path = $gamePath
    WindowTitle = $process.MainWindowTitle
    Responding = $process.Responding
    CompatibilityLayer = 'HIGHDPIAWARE'
}
