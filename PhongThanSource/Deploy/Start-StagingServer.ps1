[CmdletBinding()]
param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$RuntimeRoot,
    [int]$ServiceWaitSeconds = 2,
    [int]$ReadinessTimeoutSeconds = 45,
    [switch]$LuaApiCampaignScope
)

$ErrorActionPreference = 'Stop'
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
if (-not $RuntimeRoot) { $RuntimeRoot = Join-Path (Split-Path -Parent $ProjectRoot) 'PhongThanRuntime-Staging' }
$RuntimeRoot = [IO.Path]::GetFullPath($RuntimeRoot).TrimEnd('\')
$serverRoot = Join-Path $RuntimeRoot 'Server'
$manifestPath = Join-Path $PSScriptRoot 'RUNTIME_CONTENT_MANIFEST.json'
if (Test-Path -LiteralPath (Join-Path $RuntimeRoot 'NATIVE_DEPLOYMENT.json')) {
    & (Join-Path $PSScriptRoot 'Start-NativeServer.ps1') -ProjectRoot $ProjectRoot -RuntimeRoot $RuntimeRoot
    return
}

& (Join-Path $ProjectRoot 'Deploy\Normalize-VngScriptPaths.ps1') `
    -RuntimeRoot $RuntimeRoot | Out-Null
& (Join-Path $ProjectRoot 'Tests\Test-VngScriptPathNormalization.ps1') `
    -ProjectRoot $ProjectRoot -RuntimeRoot $RuntimeRoot | Out-Null
& (Join-Path $ProjectRoot 'Tests\Test-VngGameplaySettings.ps1') `
    -ProjectRoot $ProjectRoot -RuntimeRoot $RuntimeRoot | Out-Null

function Resolve-SqlLocalDbExecutable {
    $candidates = New-Object System.Collections.Generic.List[string]
    $command = Get-Command SqlLocalDB.exe -ErrorAction SilentlyContinue
    if ($command) { $candidates.Add($command.Source) }
    foreach ($root in @($env:ProgramFiles, ${env:ProgramFiles(x86)})) {
        if (-not $root) { continue }
        $sqlRoot = Join-Path $root 'Microsoft SQL Server'
        if (-not (Test-Path -LiteralPath $sqlRoot -PathType Container)) { continue }
        foreach ($item in Get-ChildItem -LiteralPath $sqlRoot -Filter SqlLocalDB.exe -Recurse -File -ErrorAction SilentlyContinue |
            Sort-Object FullName -Descending) {
            $candidates.Add($item.FullName)
        }
    }
    foreach ($candidate in $candidates) {
        if (Test-Path -LiteralPath $candidate -PathType Leaf) {
            return [IO.Path]::GetFullPath($candidate)
        }
    }
    throw 'Khong tim thay SqlLocalDB.exe.'
}

function Start-AccountLocalDb([string]$InstanceName) {
    $sqlLocalDb = Resolve-SqlLocalDbExecutable
    $startOutput = @(& $sqlLocalDb start $InstanceName 2>&1)
    if ($LASTEXITCODE -ne 0) {
        throw "Khong khoi dong duoc LocalDB '$InstanceName': $($startOutput -join ' ')"
    }
    $infoOutput = @(& $sqlLocalDb info $InstanceName 2>&1)
    if ($LASTEXITCODE -ne 0) {
        throw "Khong doc duoc LocalDB '$InstanceName': $($infoOutput -join ' ')"
    }
    $match = [regex]::Match(($infoOutput -join "`n"), 'np:\\\\.\\pipe\\[^\r\n]+')
    if (-not $match.Success) {
        throw "LocalDB '$InstanceName' khong tra ve instance pipe dang chay."
    }
    return $match.Value.Trim()
}

function Set-AccountDatabaseIni([string]$Path, [string]$PipeName) {
    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
        throw "Thieu DataBase.ini: $Path"
    }
    $text = [IO.File]::ReadAllText($Path)
    $serverValue = "$PipeName;Trusted_Connection=Yes"
    if ($text -notmatch '(?im)^Server=.*$') {
        throw "DataBase.ini khong co khoa Server: $Path"
    }
    $text = [regex]::Replace($text, '(?im)^Server=.*$', "Server=$serverValue", 1)
    [IO.File]::WriteAllText($Path, $text, [Text.Encoding]::ASCII)
    return $serverValue
}

function Test-AccountDatabase32([string]$ServerValue, [string]$DatabaseName) {
    $powerShell32 = Join-Path $env:WINDIR 'SysWOW64\WindowsPowerShell\v1.0\powershell.exe'
    if (-not (Test-Path -LiteralPath $powerShell32 -PathType Leaf)) {
        throw "Thieu Windows PowerShell 32-bit: $powerShell32"
    }
    $probe = @'
$ErrorActionPreference = 'Stop'
$connection = New-Object -ComObject ADODB.Connection
try {
    $connection.ConnectionTimeout = 5
    $connection.Open(
        ('driver={{SQL Server}};Server={0};Database={1};' -f $env:PHONGTHAN_DB_SERVER, $env:PHONGTHAN_DB_NAME),
        '',
        '')
    $recordset = $connection.Execute('SELECT DB_NAME()')
    if ($recordset.EOF -or [string]$recordset.Fields.Item(0).Value -ne $env:PHONGTHAN_DB_NAME) {
        throw 'Database probe returned an unexpected catalog.'
    }
    $recordset.Close()
} finally {
    if ($connection.State -ne 0) { $connection.Close() }
}
'@
    $encoded = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($probe))
    $oldServer = $env:PHONGTHAN_DB_SERVER
    $oldDatabase = $env:PHONGTHAN_DB_NAME
    try {
        $env:PHONGTHAN_DB_SERVER = $ServerValue
        $env:PHONGTHAN_DB_NAME = $DatabaseName
        $output = @(& $powerShell32 -NoLogo -NoProfile -NonInteractive -EncodedCommand $encoded 2>&1)
        if ($LASTEXITCODE -ne 0) {
            throw "Khong ket noi duoc database '$DatabaseName' bang ADO 32-bit: $($output -join ' ')"
        }
    } finally {
        $env:PHONGTHAN_DB_SERVER = $oldServer
        $env:PHONGTHAN_DB_NAME = $oldDatabase
    }
}

function Get-ListeningPorts {
    return @([Net.NetworkInformation.IPGlobalProperties]::GetIPGlobalProperties().GetActiveTcpListeners() |
        ForEach-Object { [int]$_.Port } | Sort-Object -Unique)
}

function Wait-ServiceReady($Process, [string]$Name, [int[]]$Ports, [int]$TimeoutSeconds) {
    $deadline = [DateTime]::UtcNow.AddSeconds($TimeoutSeconds)
    do {
        $Process.Refresh()
        if ($Process.HasExited) { throw "$Name tu thoat. ExitCode=$($Process.ExitCode)" }
        if (-not $Ports.Count) {
            Start-Sleep -Seconds $ServiceWaitSeconds
            $Process.Refresh()
            if ($Process.HasExited) { throw "$Name tu thoat. ExitCode=$($Process.ExitCode)" }
            return
        }
        $listening = @(Get-ListeningPorts)
        $missing = @($Ports | Where-Object { $listening -notcontains $_ })
        if (-not $missing.Count) { return }
        Start-Sleep -Milliseconds 250
    } while ([DateTime]::UtcNow -lt $deadline)
    throw "$Name chua gameplay-ready sau ${TimeoutSeconds}s; port chua listen: $($missing -join ', ')."
}

if ($LuaApiCampaignScope) {
    # This explicit scope is only for the 182-API integration campaign.  It
    # does not weaken or replace Test-CleanRuntime's production/full-map gate.
    & (Join-Path $ProjectRoot 'Tests\Test-DataRegistry.ps1') -DataRoot $RuntimeRoot -ProjectRoot $ProjectRoot | Out-Null
    & (Join-Path $ProjectRoot 'Tests\Test-LuaApiBinarySmoke.ps1') -ProjectRoot $ProjectRoot `
        -ServerRoot $serverRoot | Out-Null
    & (Join-Path $ProjectRoot 'Tests\Test-LuaApiPersistenceBoundaries.ps1') -ProjectRoot $ProjectRoot `
        -RuntimeRoot $RuntimeRoot | Out-Null
    & (Join-Path $ProjectRoot 'Tests\Test-LuaRequireModules.ps1') -ProjectRoot $ProjectRoot `
        -DataRoot $RuntimeRoot | Out-Null
}
else {
    & (Join-Path $ProjectRoot 'Tests\Test-CleanRuntime.ps1') -RuntimeRoot $RuntimeRoot | Out-Null
}

if (-not (Test-Path -LiteralPath $manifestPath -PathType Leaf)) {
    throw "Thieu runtime manifest: $manifestPath"
}
$manifest = Get-Content -LiteralPath $manifestPath -Raw | ConvertFrom-Json
$localDbInstance = [string]$manifest.RuntimeSettings.AccountLocalDbInstance
if (-not $localDbInstance) { throw 'Manifest thieu RuntimeSettings.AccountLocalDbInstance.' }
& (Join-Path $ProjectRoot 'Tests\Test-ServiceTopology.ps1') `
    -RuntimeRoot $RuntimeRoot -ProjectRoot $ProjectRoot -ManifestPath $manifestPath | Out-Null
$databaseIni = Join-Path $serverRoot 'DataBase.ini'
$pipeName = Start-AccountLocalDb $localDbInstance
$serverValue = Set-AccountDatabaseIni $databaseIni $pipeName
# LocalDB can come back without the account database registered (new master after
# an instance restart); the data files stay in PhongThanRuntime-State\sql.
$accountSqlDir = Join-Path (Split-Path -Parent $RuntimeRoot) 'PhongThanRuntime-State\sql'
$accountMdf = Join-Path $accountSqlDir 'account_account_Data.mdf'
$accountLdf = Join-Path $accountSqlDir 'account_account_Log.ldf'
if (Test-Path -LiteralPath $accountMdf -PathType Leaf) {
    $attachConn = New-Object System.Data.SqlClient.SqlConnection "Server=$pipeName;Integrated Security=true;Connect Timeout=30"
    try {
        $attachConn.Open()
        $attachCmd = $attachConn.CreateCommand()
        $attachCmd.CommandTimeout = 120
        $attachCmd.CommandText = "SELECT COUNT(*) FROM sys.databases WHERE name = N'account'"
        if ([int]$attachCmd.ExecuteScalar() -eq 0) {
            $files = "(FILENAME=N'$accountMdf')"
            if (Test-Path -LiteralPath $accountLdf -PathType Leaf) { $files += ",(FILENAME=N'$accountLdf')" }
            $attachCmd.CommandText = "CREATE DATABASE [account] ON $files FOR ATTACH"
            [void]$attachCmd.ExecuteNonQuery()
            Write-Output "Da gan lai database account tu $accountSqlDir"
        }
    } finally {
        $attachConn.Close()
    }
}
Test-AccountDatabase32 $serverValue 'account'

$services = @(
    'Goddess.exe',
    'PhongThanAccountServer.exe',
    'PhongThanRelayServer.exe',
    'Bishop.exe',
    'S3Relay.exe',
    'GameServer.exe'
)
$existing = @(Get-CimInstance Win32_Process | Where-Object {
    $_.ExecutablePath -and
    ([IO.Path]::GetFullPath($_.ExecutablePath)).StartsWith($serverRoot + '\', [StringComparison]::OrdinalIgnoreCase)
})
if ($existing) { throw "Server staging da chay: $($existing.Name -join ', ')" }

$started = New-Object System.Collections.Generic.List[object]
foreach ($name in $services) {
    $path = Join-Path $serverRoot $name
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) { throw "Thieu service: $path" }
    $process = Start-Process -FilePath $path -WorkingDirectory $serverRoot -WindowStyle Hidden -PassThru
    $portProperty = $manifest.RuntimeSettings.ExpectedListeningPorts.PSObject.Properties[$name]
    $ports = if ($portProperty) { @($portProperty.Value | ForEach-Object { [int]$_ }) } else { @() }
    Wait-ServiceReady $process $name $ports $ReadinessTimeoutSeconds
    $started.Add([pscustomobject]@{ Name=$name; Pid=$process.Id; Path=$path; ReadyPorts=@($ports) })
}

$finalListening = @(Get-ListeningPorts)
$missingFinalPorts = New-Object System.Collections.Generic.List[int]
foreach ($property in $manifest.RuntimeSettings.ExpectedListeningPorts.PSObject.Properties) {
    foreach ($port in @($property.Value)) {
        if ($finalListening -notcontains [int]$port) { $missingFinalPorts.Add([int]$port) }
    }
}
if ($missingFinalPorts.Count) {
    throw "Topology chua ready sau khi start day du; port thieu: $(@($missingFinalPorts | Sort-Object -Unique) -join ', ')."
}
[pscustomobject]@{
    LocalDbInstance = $localDbInstance
    LocalDbPipe = $pipeName
    Database = 'account'
    DatabaseProbe = 'ADO32 OK'
    ServiceTopology = 'LOOPBACK_READY'
    ValidationScope = if ($LuaApiCampaignScope) { 'LUA_API_182_CAMPAIGN_ONLY' } else { 'FULL_GAMEPLAY_RUNTIME' }
    Services = $started
}
