[CmdletBinding()]
param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$RuntimeRoot,
    [int]$HealthWaitSeconds = 10
)

$ErrorActionPreference = 'Stop'
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
if (-not $RuntimeRoot) { $RuntimeRoot = Join-Path (Split-Path -Parent $ProjectRoot) 'PhongThanRuntime-Staging' }
$RuntimeRoot = [IO.Path]::GetFullPath($RuntimeRoot).TrimEnd('\')
$serverRoot = Join-Path $RuntimeRoot 'Server'
$expected = @('Goddess.exe','PhongThanAccountServer.exe','PhongThanRelayServer.exe','Bishop.exe','S3Relay.exe','GameServer.exe')
function Assert-True([bool]$Condition, [string]$Message) { if (-not $Condition) { throw $Message } }
function Get-StagingProcesses {
    @(Get-CimInstance Win32_Process | Where-Object {
        $_.ExecutablePath -and ([IO.Path]::GetFullPath($_.ExecutablePath)).StartsWith($script:RuntimeRoot + '\', [StringComparison]::OrdinalIgnoreCase)
    })
}

Assert-True (Test-Path -LiteralPath $serverRoot -PathType Container) "Thieu staging server: $serverRoot"
$gameplay = & (Join-Path $ProjectRoot 'Tests\Test-GameplayDataRegistry.ps1') `
    -DataRoot $RuntimeRoot -ProjectRoot $ProjectRoot
Assert-True ($gameplay.Result -eq 'PASS') 'Full gameplay map gate khong PASS.'
Assert-True ((Get-FileHash -LiteralPath (Join-Path $serverRoot 'CoreServer.dll') -Algorithm SHA256).Hash -eq
    (Get-FileHash -LiteralPath (Join-Path $ProjectRoot 'Output\Server\CoreServer.dll') -Algorithm SHA256).Hash) 'Staging CoreServer khong khop Release Output.'
$initial = @(Get-StagingProcesses)
Assert-True ($initial.Count -eq 0) "Staging da co process truoc soak: $($initial.Name -join ', ')."
$cycleEvidence = New-Object System.Collections.Generic.List[object]
try {
    foreach ($cycle in 1..2) {
        $startedAt = [DateTime]::UtcNow
        $startResult = & (Join-Path $ProjectRoot 'Deploy\Start-StagingServer.ps1') `
            -ProjectRoot $ProjectRoot -RuntimeRoot $RuntimeRoot -ServiceWaitSeconds 1 -LuaApiCampaignScope
        Assert-True ($startResult.ValidationScope -eq 'LUA_API_182_CAMPAIGN_ONLY') 'Server start khong dung explicit campaign scope.'
        Start-Sleep -Seconds $HealthWaitSeconds
        $running = @(Get-StagingProcesses)
        $runningNames = @($running.Name | Sort-Object)
        foreach ($name in $expected) {
            Assert-True ($name -in $runningNames) "Restart cycle $cycle thieu process $name."
        }
        Assert-True ($running.Count -eq $expected.Count) "Restart cycle $cycle co process count=$($running.Count), yeu cau $($expected.Count)."
        $scriptRegistryDiag = Join-Path $serverRoot 'script_registry_diag.log'
        Assert-True (Test-Path -LiteralPath $scriptRegistryDiag -PathType Leaf) "Restart cycle $cycle thieu script_registry_diag.log."
        $scriptRegistryText = [IO.File]::ReadAllText($scriptRegistryDiag, [Text.Encoding]::ASCII).Trim()
        $scriptRegistryMatch = [regex]::Match($scriptRegistryText, '^loaded=(\d+) failed=(\d+) capacity=(\d+)$')
        Assert-True $scriptRegistryMatch.Success "Restart cycle $cycle script registry diag sai schema: $scriptRegistryText"
        Assert-True ([int]$scriptRegistryMatch.Groups[1].Value -gt 0) "Restart cycle $cycle script registry loaded=0."
        Assert-True ([int]$scriptRegistryMatch.Groups[2].Value -eq 0) "Restart cycle $cycle script registry con failure: $scriptRegistryText"
        $freshLogs = @(Get-ChildItem -LiteralPath $serverRoot -Recurse -File -ErrorAction SilentlyContinue |
            Where-Object { $_.LastWriteTimeUtc -ge $startedAt -and $_.Length -le 16MB -and $_.Extension -in @('.log','.txt') })
        $fatalMatches = New-Object System.Collections.Generic.List[string]
        foreach ($file in $freshLogs) {
            $stream = [IO.File]::Open($file.FullName, [IO.FileMode]::Open,
                [IO.FileAccess]::Read, [IO.FileShare]::ReadWrite)
            try {
                $reader = New-Object IO.StreamReader($stream, [Text.Encoding]::Default, $true)
                try { $text = $reader.ReadToEnd() }
                finally { $reader.Dispose() }
            }
            finally { $stream.Dispose() }
            foreach ($pattern in @('Load ServerScript failed','Load ServerTimerScript failed','\[ExecuteScript\] failed','Lua API campaign fatal')) {
                if ($text -match $pattern) { $fatalMatches.Add("$($file.FullName):$pattern") }
            }
        }
        Assert-True ($fatalMatches.Count -eq 0) "Restart cycle $cycle co fatal log: $($fatalMatches -join '; ')"
        $cycleEvidence.Add([pscustomobject]@{
            Cycle = $cycle
            ServicesAlive = $running.Count
            ProcessIds = @($running.ProcessId | Sort-Object)
            FreshLogsScanned = $freshLogs.Count
            FatalLogMatches = 0
            ScriptRegistry = $scriptRegistryText
        })
        & (Join-Path $ProjectRoot 'Deploy\Stop-StagingRuntime.ps1') -ProjectRoot $ProjectRoot -RuntimeRoot $RuntimeRoot | Out-Null
        Assert-True (@(Get-StagingProcesses).Count -eq 0) "Restart cycle $cycle khong dung het process."
    }
}
finally {
    if (@(Get-StagingProcesses).Count) {
        & (Join-Path $ProjectRoot 'Deploy\Stop-StagingRuntime.ps1') -ProjectRoot $ProjectRoot -RuntimeRoot $RuntimeRoot | Out-Null
    }
}

[pscustomobject]@{
    Status = 'PASS'
    Scope = 'LUA_API_182_CAMPAIGN_ONLY'
    RestartCycles = $cycleEvidence.Count
    ServiceStarts = $cycleEvidence.Count * $expected.Count
    CoreServerSha256 = (Get-FileHash -LiteralPath (Join-Path $serverRoot 'CoreServer.dll') -Algorithm SHA256).Hash
    Cycles = @($cycleEvidence | ForEach-Object { $_ })
    FullGameplayMapGate = $gameplay.Result
    ActiveMaps = $gameplay.ActiveMaps
    PhysicalMaps = $gameplay.PhysicalMaps
    ClientRegions = $gameplay.ClientRegions
    ServerRegions = $gameplay.ServerRegions
}
