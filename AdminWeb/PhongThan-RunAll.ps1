param([switch]$WithClient)
# One-click start (ASCII only): database check -> server -> admin web (-> client).
$ErrorActionPreference = 'Stop'
$Root = Split-Path -Parent $PSScriptRoot
$Project = Join-Path $Root 'PhongThanSource'
$Runtime = Join-Path $Root 'PhongThanRuntime-Staging'
$ServerDir = Join-Path $Runtime 'Server'
$AdminPort = 8765

function Step([string]$m) { Write-Host ''; Write-Host "== $m" -ForegroundColor Cyan }
function Get-ServerProcs {
    @(Get-CimInstance Win32_Process | Where-Object { $_.ExecutablePath -and $_.ExecutablePath.StartsWith($ServerDir + '\', [StringComparison]::OrdinalIgnoreCase) })
}
function Test-Port([int]$p) {
    try { $c = New-Object Net.Sockets.TcpClient; $c.Connect('127.0.0.1', $p); $c.Close(); return $true } catch { return $false }
}

try {
    Step '1/3 Kiem tra SQL LocalDB va database account'
    & powershell.exe -NoProfile -ExecutionPolicy Bypass -File (Join-Path $PSScriptRoot 'PhongThan-Setup.ps1') -Step all
    if ($LASTEXITCODE -ne 0) { throw 'Cai dat database that bai (xem dong LOI o tren).' }

    & powershell.exe -NoProfile -ExecutionPolicy Bypass -File (Join-Path $PSScriptRoot 'PhongThan-ClientPatch.ps1')

    Step '2/3 Khoi dong server'
    $running = Get-ServerProcs
    if ($running.Count -gt 0) {
        Write-Host ("Server dang chay: " + (($running | ForEach-Object Name | Sort-Object -Unique) -join ', ') + ' -> bo qua.')
    } else {
        & (Join-Path $Project 'Deploy\Start-NativeServer.ps1') -ProjectRoot $Project -RuntimeRoot $Runtime
        Write-Host 'Server da khoi dong.'
    }

    Step '3/3 Mo web admin'
    if (Test-Port $AdminPort) {
        Write-Host "Web admin da chay: http://localhost:$AdminPort/"
        Start-Process "http://localhost:$AdminPort/"
    } else {
        Start-Process -FilePath 'powershell.exe' -WorkingDirectory $PSScriptRoot -ArgumentList @('-NoProfile', '-ExecutionPolicy', 'Bypass', '-File', "`"$(Join-Path $PSScriptRoot 'PhongThan-Admin.ps1')`"")
        Write-Host "Dang mo web admin (cua so rieng): http://localhost:$AdminPort/"
    }

    if ($WithClient) {
        Step 'Mo client game'
        $env:__COMPAT_LAYER = 'HIGHDPIAWARE'
        Start-Process -FilePath (Join-Path $Runtime 'Client\Game.exe') -WorkingDirectory (Join-Path $Runtime 'Client')
    }
    Write-Host ''
    Write-Host 'HOAN TAT. Vao game bang PhongThan-MoGame.cmd. Dung server bang PhongThan-BangDieuKhien.cmd.' -ForegroundColor Green
    exit 0
} catch {
    Write-Host ('LOI: ' + $_.Exception.Message) -ForegroundColor Red
    exit 1
}
