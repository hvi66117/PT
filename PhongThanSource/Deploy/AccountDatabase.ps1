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
