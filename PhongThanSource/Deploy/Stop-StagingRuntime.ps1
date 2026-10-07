[CmdletBinding()]
param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$RuntimeRoot,
    [int]$WaitSeconds = 10
)

$ErrorActionPreference = 'Stop'
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
if (-not $RuntimeRoot) { $RuntimeRoot = Join-Path (Split-Path -Parent $ProjectRoot) 'PhongThanRuntime-Staging' }
$RuntimeRoot = [IO.Path]::GetFullPath($RuntimeRoot).TrimEnd('\')
$running = @(Get-CimInstance Win32_Process | Where-Object {
    $_.ExecutablePath -and
    ([IO.Path]::GetFullPath($_.ExecutablePath)).StartsWith($RuntimeRoot + '\', [StringComparison]::OrdinalIgnoreCase)
})
foreach ($item in $running | Sort-Object ProcessId -Descending) {
    Stop-Process -Id $item.ProcessId -ErrorAction SilentlyContinue
}
$deadline = [DateTime]::UtcNow.AddSeconds($WaitSeconds)
do {
    $remaining = @(Get-CimInstance Win32_Process | Where-Object {
        $_.ExecutablePath -and
        ([IO.Path]::GetFullPath($_.ExecutablePath)).StartsWith($RuntimeRoot + '\', [StringComparison]::OrdinalIgnoreCase)
    })
    if (-not $remaining) { break }
    Start-Sleep -Milliseconds 250
} while ([DateTime]::UtcNow -lt $deadline)
foreach ($item in $remaining) {
    Stop-Process -Id $item.ProcessId -Force -ErrorAction SilentlyContinue
}
[pscustomobject]@{
    RuntimeRoot = $RuntimeRoot
    Stopped = $running.Count
    Forced = $remaining.Count
}
