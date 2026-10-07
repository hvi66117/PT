param(
    [ValidateSet('check', 'all', 'localdb', 'database', 'backup')][string]$Step = 'check',
    [string]$LogPath = '',
    [switch]$Json
)
# Phong Than server setup (ASCII only). Installs SQL Server LocalDB, starts the
# MSSQLLocalDB instance and makes sure database [account] is available:
#   1. already attached            -> nothing to do
#   2. data files in State\sql     -> attach them (keeps existing accounts)
#   3. otherwise                   -> restore Server\database\account.bak into State\sql
# Used by the admin web ("Cai dat server" tab) and by PhongThan-CaiDat.cmd.
$ErrorActionPreference = 'Stop'
$Root = Split-Path -Parent $PSScriptRoot
$Instance = 'MSSQLLocalDB'
$ServerDir = Join-Path $Root 'PhongThanRuntime-Staging\Server'
$BakPath = Join-Path $ServerDir 'database\account.bak'
$SqlDir = Join-Path $Root 'PhongThanRuntime-State\sql'
$Mdf = Join-Path $SqlDir 'account_account_Data.mdf'
$Ldf = Join-Path $SqlDir 'account_account_Log.ldf'
$SetupDir = Join-Path $Root 'Setup'
$Msi = Join-Path $SetupDir 'SqlLocalDB.msi'
$Ssei = Join-Path $SetupDir 'SQL2022-SSEI-Expr.exe'
$DbIni = Join-Path $ServerDir 'DataBase.ini'

function Write-Log([string]$m) {
    $line = '{0} {1}' -f (Get-Date -Format 'HH:mm:ss'), $m
    Write-Host $line
    if ($LogPath) { Add-Content -LiteralPath $LogPath -Value $line -Encoding UTF8 }
}

function Find-SqlLocalDb {
    $c = Get-Command SqlLocalDB.exe -ErrorAction SilentlyContinue
    if ($c) { return $c.Source }
    $base = Join-Path $env:ProgramFiles 'Microsoft SQL Server'
    if (Test-Path -LiteralPath $base) {
        $f = Get-ChildItem -LiteralPath $base -Filter SqlLocalDB.exe -Recurse -File -ErrorAction SilentlyContinue |
            Sort-Object FullName -Descending | Select-Object -First 1
        if ($f) { return $f.FullName }
    }
    return $null
}

function Get-Pipe {
    $exe = Find-SqlLocalDb
    if (-not $exe) { return $null }
    $info = (& $exe info $Instance 2>&1) -join "`n"
    $m = [regex]::Match($info, 'np:\\\\\.\\pipe\\[^\r\n]+')
    if ($m.Success) { return $m.Value.Trim() }
    return $null
}

function Invoke-Q([string]$sql, [switch]$Scalar) {
    $cn = New-Object System.Data.SqlClient.SqlConnection "Server=(localdb)\$Instance;Integrated Security=true;Connect Timeout=60"
    $cn.Open()
    try {
        $cmd = $cn.CreateCommand(); $cmd.CommandTimeout = 600; $cmd.CommandText = $sql
        if ($Scalar) { return $cmd.ExecuteScalar() }
        $t = New-Object System.Data.DataTable
        $t.Load($cmd.ExecuteReader())
        return , $t
    } finally { $cn.Close() }
}

function Get-SetupStatus {
    $exe = Find-SqlLocalDb
    $st = [ordered]@{
        localdbInstalled = [bool]$exe
        localdbExe = "$exe"
        instanceRunning = $false
        pipe = ''
        accountAttached = $false
        accountCount = -1
        bakExists = (Test-Path -LiteralPath $BakPath)
        bakPath = $BakPath
        mdfExists = (Test-Path -LiteralPath $Mdf)
        sqlDir = $SqlDir
        msiExists = (Test-Path -LiteralPath $Msi)
        sseiExists = (Test-Path -LiteralPath $Ssei)
        databaseIniPipe = ''
    }
    if (Test-Path -LiteralPath $DbIni) {
        $m = [regex]::Match([IO.File]::ReadAllText($DbIni), '(?m)^Server=([^;\r\n]+)')
        if ($m.Success) { $st.databaseIniPipe = $m.Groups[1].Value }
    }
    if ($exe) {
        $info = (& $exe info $Instance 2>&1) -join "`n"
        $st.instanceRunning = $info -match 'State:\s+Running'
        $p = [regex]::Match($info, 'np:\\\\\.\\pipe\\[^\r\n]+')
        if ($p.Success) { $st.pipe = $p.Value.Trim() }
        if ($st.instanceRunning) {
            try {
                $st.accountAttached = [int](Invoke-Q "SELECT COUNT(*) FROM sys.databases WHERE name = N'account' AND state_desc = N'ONLINE'" -Scalar) -gt 0
                if ($st.accountAttached) { $st.accountCount = [int](Invoke-Q 'SELECT COUNT(*) FROM account.dbo.Account_Info' -Scalar) }
            } catch { }
        }
    }
    return [pscustomobject]$st
}

function Install-LocalDb {
    if (Find-SqlLocalDb) { Write-Log 'SQL LocalDB da co san, bo qua buoc cai dat.'; return }
    $msi = $Msi
    if (-not (Test-Path -LiteralPath $msi)) {
        if (-not (Test-Path -LiteralPath $Ssei)) { throw "Thieu bo cai: dat SqlLocalDB.msi vao $SetupDir" }
        $media = Join-Path $env:TEMP 'pt_localdb_media'
        Write-Log 'Dang tai SQL LocalDB tu Microsoft (SQL2022-SSEI-Expr.exe)...'
        $p = Start-Process -FilePath $Ssei -ArgumentList '/ACTION=Download', "/MEDIAPATH=`"$media`"", '/MEDIATYPE=LocalDB', '/QUIET' -Wait -PassThru
        $found = Get-ChildItem -LiteralPath $media -Filter SqlLocalDB.msi -Recurse -File -ErrorAction SilentlyContinue | Select-Object -First 1
        if (-not $found) { throw "Tai SQL LocalDB that bai (ma thoat $($p.ExitCode))." }
        $msi = $found.FullName
    }
    $log = Join-Path $env:TEMP 'pt_localdb_install.log'
    Write-Log "Dang cai SQL LocalDB tu $msi (Windows se hoi quyen quan tri)..."
    $p = Start-Process -FilePath 'msiexec.exe' -ArgumentList '/i', "`"$msi`"", '/qn', 'IACCEPTSQLLOCALDBLICENSETERMS=YES', '/l*v', "`"$log`"" -Verb RunAs -Wait -PassThru
    if ($p.ExitCode -ne 0 -and $p.ExitCode -ne 3010) { throw "Cai SQL LocalDB that bai, ma thoat $($p.ExitCode). Log: $log" }
    if (-not (Find-SqlLocalDb)) { throw "Da chay bo cai nhung khong thay SqlLocalDB.exe. Log: $log" }
    Write-Log 'Da cai xong SQL LocalDB.'
}

function Start-Instance {
    $exe = Find-SqlLocalDb
    if (-not $exe) { throw 'Chua cai SQL LocalDB.' }
    $info = (& $exe info $Instance 2>&1) -join "`n"
    if ($info -match 'doesn''t exist|does not exist|not exist') {
        Write-Log "Tao instance $Instance..."
        & $exe create $Instance | Out-Null
    }
    & $exe start $Instance | Out-Null
    $pipe = Get-Pipe
    if (-not $pipe) { throw "Khong khoi dong duoc LocalDB $Instance." }
    Write-Log "LocalDB $Instance dang chay: $pipe"
    return $pipe
}

function Update-DbIni([string]$pipe) {
    if (-not (Test-Path -LiteralPath $DbIni)) { Write-Log "Khong co $DbIni, bo qua."; return }
    $t = [IO.File]::ReadAllText($DbIni)
    $n = [regex]::Replace($t, '(?m)^Server=.*$', "Server=$pipe;Trusted_Connection=Yes")
    if ($n -ne $t) { [IO.File]::WriteAllText($DbIni, $n, [Text.Encoding]::ASCII); Write-Log 'Da cap nhat DataBase.ini.' }
}

function Initialize-AccountDb {
    [void](Start-Instance)
    $exists = [int](Invoke-Q "SELECT COUNT(*) FROM sys.databases WHERE name = N'account'" -Scalar)
    if ($exists -gt 0) { Write-Log 'Database account da san sang, khong can khoi phuc.'; return }
    New-Item -ItemType Directory -Force -Path $SqlDir | Out-Null
    if (Test-Path -LiteralPath $Mdf) {
        # Keep the live data: attach instead of restoring over it.
        $files = "(FILENAME=N'$Mdf')"
        if (Test-Path -LiteralPath $Ldf) { $files += ",(FILENAME=N'$Ldf')" }
        Write-Log "Gan lai database account tu $SqlDir..."
        [void](Invoke-Q "CREATE DATABASE [account] ON $files FOR ATTACH" -Scalar)
        Write-Log 'Da gan lai database account.'
        return
    }
    if (-not (Test-Path -LiteralPath $BakPath)) { throw "Khong tim thay file backup: $BakPath" }
    Write-Log "Khoi phuc database account tu $BakPath..."
    $list = Invoke-Q "RESTORE FILELISTONLY FROM DISK = N'$BakPath'"
    $moves = @()
    foreach ($r in $list.Rows) {
        $target = $(if ("$($r.Type)" -eq 'L') { $Ldf } else { $Mdf })
        $moves += "MOVE N'$($r.LogicalName)' TO N'$target'"
    }
    [void](Invoke-Q ("RESTORE DATABASE [account] FROM DISK = N'$BakPath' WITH " + ($moves -join ', ') + ', RECOVERY') -Scalar)
    $n = [int](Invoke-Q 'SELECT COUNT(*) FROM account.dbo.Account_Info' -Scalar)
    Write-Log "Da khoi phuc database account ($n tai khoan)."
}

function Backup-AccountDb {
    [void](Start-Instance)
    if ([int](Invoke-Q "SELECT COUNT(*) FROM sys.databases WHERE name = N'account'" -Scalar) -eq 0) { throw 'Chua co database account de sao luu.' }
    New-Item -ItemType Directory -Force -Path (Split-Path -Parent $BakPath) | Out-Null
    if (Test-Path -LiteralPath $BakPath) {
        $old = Join-Path $Root ('_backup\account-bak-' + (Get-Date -Format 'yyyyMMdd-HHmmss'))
        New-Item -ItemType Directory -Force -Path $old | Out-Null
        Copy-Item -LiteralPath $BakPath -Destination $old
        Write-Log "Da giu ban account.bak cu tai $old"
    }
    $tmp = "$BakPath.new"
    if (Test-Path -LiteralPath $tmp) { Remove-Item -LiteralPath $tmp -Force }
    [void](Invoke-Q "BACKUP DATABASE [account] TO DISK = N'$tmp' WITH INIT, FORMAT, COPY_ONLY" -Scalar)
    Move-Item -LiteralPath $tmp -Destination $BakPath -Force
    $n = [int](Invoke-Q 'SELECT COUNT(*) FROM account.dbo.Account_Info' -Scalar)
    Write-Log "Da sao luu database account ($n tai khoan) vao $BakPath"
}

try {
    switch ($Step) {
        'backup' { Backup-AccountDb }
        'check' { }
        'localdb' { Install-LocalDb; Update-DbIni (Start-Instance) }
        'database' { Initialize-AccountDb; Update-DbIni (Get-Pipe) }
        'all' { Install-LocalDb; Initialize-AccountDb; Update-DbIni (Get-Pipe); Write-Log 'HOAN TAT: co the khoi dong server bang PhongThan-BangDieuKhien.cmd.' }
    }
    $status = Get-SetupStatus
    if ($Json) { $status | ConvertTo-Json -Compress } elseif ($Step -eq 'check') { $status | Format-List }
    exit 0
} catch {
    Write-Log ('LOI: ' + $_.Exception.Message)
    exit 1
}
