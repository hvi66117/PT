[CmdletBinding()]
param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$RelayExecutable
)

$ErrorActionPreference = 'Stop'
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
if (-not $RelayExecutable) {
    $RelayExecutable = Join-Path $ProjectRoot 'Output\Server\PhongThanRelay.exe'
}
$RelayExecutable = [IO.Path]::GetFullPath($RelayExecutable)
if (-not (Test-Path -LiteralPath $RelayExecutable -PathType Leaf)) {
    throw "Thieu relay executable: $RelayExecutable"
}

function Write-Fixed([IO.BinaryWriter]$Writer, [byte[]]$Bytes, [int]$Size) {
    if ($Bytes.Count -ge $Size) { throw "Fixed field vuot $Size byte." }
    $Writer.Write($Bytes)
    $Writer.Write((New-Object byte[] ($Size - $Bytes.Count)))
}

function Write-Header(
    [IO.BinaryWriter]$Writer,
    [uint16]$MessageType,
    [uint16]$Flags,
    [uint32]$PacketSize,
    [uint32]$Sequence
) {
    $Writer.Write([uint32]0x4e485450)
    $Writer.Write([uint16]1)
    $Writer.Write([uint16]20)
    $Writer.Write($MessageType)
    $Writer.Write($Flags)
    $Writer.Write($PacketSize)
    $Writer.Write($Sequence)
}

function New-Packet([scriptblock]$Body) {
    $memory = New-Object IO.MemoryStream
    $writer = New-Object IO.BinaryWriter($memory)
    try {
        & $Body $writer
        return $memory.ToArray()
    } finally {
        $writer.Dispose()
        $memory.Dispose()
    }
}

function New-RegisterPacket(
    [uint32]$ServiceId,
    [string]$Name,
    [uint32]$Capabilities,
    [uint32]$Sequence
) {
    $ascii = [Text.Encoding]::ASCII
    New-Packet {
        param($writer)
        Write-Header $writer 0x6001 1 140 $Sequence
        $writer.Write([uint32]$Sequence)
        $writer.Write([uint16]3)
        $writer.Write([uint16]0)
        $writer.Write($ServiceId)
        $writer.Write($Capabilities)
        $writer.Write([uint32]0x0100007f)
        $writer.Write([uint16]6666)
        $writer.Write([uint16]6666)
        Write-Fixed $writer $ascii.GetBytes($Name) 32
        Write-Fixed $writer $ascii.GetBytes('phongthan-local-service') 64
    }
}

function Send-Packet([Net.Sockets.TcpClient]$Client, [byte[]]$Packet) {
    $stream = $Client.GetStream()
    $stream.Write($Packet, 0, $Packet.Count)
    $stream.Flush()
}

function Read-Exact([Net.Sockets.TcpClient]$Client, [int]$Size) {
    $result = New-Object byte[] $Size
    $offset = 0
    $stream = $Client.GetStream()
    while ($offset -lt $Size) {
        $read = $stream.Read($result, $offset, $Size - $offset)
        if ($read -le 0) { throw "Relay dong ket noi khi con thieu $($Size - $offset) byte." }
        $offset += $read
    }
    return $result
}

function Read-UInt16([byte[]]$Bytes, [int]$Offset) {
    [BitConverter]::ToUInt16($Bytes, $Offset)
}

function Read-UInt32([byte[]]$Bytes, [int]$Offset) {
    [BitConverter]::ToUInt32($Bytes, $Offset)
}

$probe = [Net.Sockets.TcpListener]::new([Net.IPAddress]::Loopback, 0)
$probe.Start()
$port = ([Net.IPEndPoint]$probe.LocalEndpoint).Port
$probe.Stop()

$testRoot = Join-Path ([IO.Path]::GetTempPath()) ("phongthan-relay-test-" + [Guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $testRoot -Force | Out-Null
$config = Join-Path $testRoot 'PhongThanRelay.ini'
[IO.File]::WriteAllText(
    $config,
    "[Network]`r`nListenAddress=127.0.0.1`r`nPort=$port`r`nMaxConnections=16`r`n`r`n[Security]`r`nServiceSecret=phongthan-local-service`r`n",
    [Text.Encoding]::ASCII)

$process = $null
$source = $null
$target = $null
try {
    $process = Start-Process -FilePath $RelayExecutable -ArgumentList ('"' + $config + '"') `
        -WorkingDirectory $testRoot -WindowStyle Hidden -PassThru
    $deadline = [DateTime]::UtcNow.AddSeconds(10)
    do {
        $process.Refresh()
        if ($process.HasExited) { throw "Relay tu thoat: $($process.ExitCode)" }
        try {
            $source = New-Object Net.Sockets.TcpClient
            $source.ReceiveTimeout = 3000
            $source.SendTimeout = 3000
            $source.Connect('127.0.0.1', $port)
        } catch {
            if ($source) { $source.Dispose(); $source = $null }
            Start-Sleep -Milliseconds 100
        }
    } while (-not $source -and [DateTime]::UtcNow -lt $deadline)
    if (-not $source) { throw "Relay khong listen port $port." }

    $target = New-Object Net.Sockets.TcpClient
    $target.ReceiveTimeout = 3000
    $target.SendTimeout = 3000
    $target.Connect('127.0.0.1', $port)

    Send-Packet $source (New-RegisterPacket 100 'game-source' 15 1)
    Send-Packet $target (New-RegisterPacket 200 'game-target' 15 2)
    $sourceRegister = Read-Exact $source 36
    $targetRegister = Read-Exact $target 36
    foreach ($response in $sourceRegister, $targetRegister) {
        if ((Read-UInt32 $response 0) -ne 0x4e485450 -or
            (Read-UInt16 $response 8) -ne 0x6001 -or
            (Read-UInt32 $response 12) -ne 36 -or
            (Read-UInt32 $response 24) -ne 0) {
            throw 'Dang ky service khong tra response thanh cong.'
        }
    }

    $mapBind = New-Packet {
        param($writer)
        Write-Header $writer 0x6005 1 40 3
        $writer.Write([uint32]200)
        $writer.Write([uint32]1002)
        $writer.Write([uint32]1)
        $writer.Write([uint32]0x0100007f)
        $writer.Write([uint16]6667)
        $writer.Write([uint16]0)
    }
    Send-Packet $target $mapBind

    $ticket = [byte[]](1..16)
    $ascii = [Text.Encoding]::ASCII
    $session = New-Packet {
        param($writer)
        Write-Header $writer 0x6003 1 112 4
        $writer.Write([uint32]200)
        $writer.Write($ticket)
        Write-Fixed $writer $ascii.GetBytes('account-test') 32
        Write-Fixed $writer $ascii.GetBytes('Hero') 32
        $writer.Write([uint32]1002)
        $writer.Write([uint32]9)
    }
    Send-Packet $target $session

    $key = $ascii.GetBytes('Hero')
    $payload = $ascii.GetBytes('native-route-payload')
    $routeSize = 44 + $key.Count + $payload.Count
    $route = New-Packet {
        param($writer)
        Write-Header $writer 0x6010 1 $routeSize 5
        $writer.Write([uint32]77)
        $writer.Write([uint32]100)
        $writer.Write([uint32]0)
        $writer.Write([uint16]3)
        $writer.Write([uint16]1)
        $writer.Write([uint16]$key.Count)
        $writer.Write([uint16]0)
        $writer.Write([uint32]$payload.Count)
        $writer.Write($key)
        $writer.Write($payload)
    }
    Send-Packet $source $route
    $routeResult = Read-Exact $source 32
    $forwarded = Read-Exact $target $routeSize
    if ((Read-UInt16 $routeResult 8) -ne 0x6011 -or
        (Read-UInt32 $routeResult 20) -ne 77 -or
        (Read-UInt32 $routeResult 24) -ne 0 -or
        (Read-UInt32 $routeResult 28) -ne 200) {
        throw 'Route result khong dung dich vu dich.'
    }
    if ((Read-UInt16 $forwarded 8) -ne 0x6010 -or
        (Read-UInt32 $forwarded 24) -ne 100 -or
        (Read-UInt32 $forwarded 28) -ne 200) {
        throw 'Relay khong forward envelope canonical dung source/target.'
    }
    $forwardedPayload = [Text.Encoding]::ASCII.GetString(
        $forwarded, 44 + $key.Count, $payload.Count)
    if ($forwardedPayload -ne 'native-route-payload') {
        throw 'Relay lam bien doi payload nghiep vu.'
    }

    $state = New-Packet {
        param($writer)
        $writer.Write([uint32]1)
        $writer.Write([uint32]408)
        $writer.Write([uint32]1)
        $writer.Write([uint32]0)
        Write-Fixed $writer $ascii.GetBytes('TransferHero') 32
        Write-Fixed $writer $ascii.GetBytes('account-test') 32
        $writer.Write((New-Object byte[] 12))
        $writer.Write([int32]0)
        $writer.Write((New-Object byte[] 64))
        $writer.Write([uint32]0)
        $writer.Write([int32]0)
        $writer.Write([uint32]0)
        for ($i = 0; $i -lt 33; $i++) {
            if ($i -eq 3) { $writer.Write([int32]1002) }
            elseif ($i -eq 4) { $writer.Write([int32]320) }
            elseif ($i -eq 5) { $writer.Write([int32]640) }
            else { $writer.Write([int32]0) }
        }
        $writer.Write((New-Object byte[] 32))
        for ($i = 0; $i -lt 4; $i++) { $writer.Write([int32]0) }
        for ($i = 0; $i -lt 10; $i++) { $writer.Write([int32]0) }
        for ($i = 0; $i -lt 4; $i++) { $writer.Write([uint32]0) }
    }
    if ($state.Count -ne 408) {
        throw "Character state test sai kich thuoc: $($state.Count)."
    }
    $transferId = [uint32]88
    $prepare = New-Packet {
        param($writer)
        Write-Header $writer 0x6020 1 (104 + $state.Count) 6
        $writer.Write($transferId)
        $writer.Write([uint32]100)
        $writer.Write([uint32]0)
        $writer.Write([uint32]1002)
        $writer.Write([int32]320)
        $writer.Write([int32]640)
        $writer.Write($ticket)
        Write-Fixed $writer $ascii.GetBytes('TransferHero') 32
        $writer.Write([int32]0)
        $writer.Write([int32]0)
        $writer.Write([uint32]$state.Count)
        $writer.Write([byte[]]$state)
    }
    if ($prepare.Count -ne 512 -or
        (Read-UInt32 $prepare 12) -ne $prepare.Count -or
        (Read-UInt32 $prepare 24) -ne 100 -or
        (Read-UInt32 $prepare 32) -ne 1002 -or
        (Read-UInt32 $prepare 100) -ne 408 -or
        (Read-UInt32 $prepare 104) -ne 1 -or
        (Read-UInt32 $prepare 108) -ne 408) {
        throw ("Transfer prepare test sai layout: count={0}, packet={1}, source={2}, map={3}, stateSize={4}, schema={5}, embeddedSize={6}." -f
            $prepare.Count, (Read-UInt32 $prepare 12),
            (Read-UInt32 $prepare 24), (Read-UInt32 $prepare 32),
            (Read-UInt32 $prepare 100), (Read-UInt32 $prepare 104),
            (Read-UInt32 $prepare 108))
    }
    Send-Packet $source $prepare
    Start-Sleep -Milliseconds 100
    if ($source.GetStream().DataAvailable) {
        $earlyTransferResult = Read-Exact $source 56
        throw ("Relay tu choi transfer prepare: type=0x{0:X4}, result={1}." -f
            (Read-UInt16 $earlyTransferResult 8),
            ([BitConverter]::ToInt32($earlyTransferResult, 24)))
    }
    $forwardedPrepare = Read-Exact $target $prepare.Count
    if ((Read-UInt16 $forwardedPrepare 8) -ne 0x6020 -or
        (Read-UInt32 $forwardedPrepare 20) -ne $transferId -or
        (Read-UInt32 $forwardedPrepare 28) -ne 200 -or
        (Read-UInt32 $forwardedPrepare 100) -ne 408) {
        throw 'Relay khong route transfer prepare canonical den map dich.'
    }

    $transferResult = New-Packet {
        param($writer)
        Write-Header $writer 0x6021 2 56 7
        $writer.Write($transferId)
        $writer.Write([int32]0)
        $writer.Write([uint32]200)
        $writer.Write([uint32]0x0100007f)
        $writer.Write([uint16]6667)
        $writer.Write([uint16]0)
        $writer.Write($ticket)
    }
    Send-Packet $target $transferResult
    $forwardedResult = Read-Exact $source 56
    if ((Read-UInt16 $forwardedResult 8) -ne 0x6021 -or
        (Read-UInt32 $forwardedResult 20) -ne $transferId -or
        (Read-UInt32 $forwardedResult 28) -ne 200) {
        throw 'Relay khong tra transfer result ve game service nguon.'
    }

    $commit = New-Packet {
        param($writer)
        Write-Header $writer 0x6022 1 80 8
        $writer.Write($transferId)
        $writer.Write([uint32]100)
        $writer.Write([uint32]200)
        $writer.Write($ticket)
        Write-Fixed $writer $ascii.GetBytes('TransferHero') 32
    }
    Send-Packet $source $commit
    $forwardedCommit = Read-Exact $target 80
    if ((Read-UInt16 $forwardedCommit 8) -ne 0x6022 -or
        (Read-UInt32 $forwardedCommit 20) -ne $transferId -or
        (Read-UInt32 $forwardedCommit 28) -ne 200) {
        throw 'Relay khong hoan tat transfer commit den game service dich.'
    }

    [pscustomobject]@{
        Result = 'PASS'
        ListeningPort = $port
        RegisteredServices = 2
        RoleRouteTarget = 200
        ForwardedPayloadBytes = $payload.Count
        CharacterTransferBytes = $prepare.Count
        CharacterTransferCommitted = $true
    }
} catch {
    $relayLogPath = Join-Path $testRoot 'phongthan_relay.log'
    $relayLog = if (Test-Path -LiteralPath $relayLogPath) {
        (Get-Content -LiteralPath $relayLogPath -Raw).Trim()
    } else { '<khong co relay log>' }
    throw "$($_.Exception.Message)`nRelay log:`n$relayLog"
} finally {
    if ($source) { $source.Dispose() }
    if ($target) { $target.Dispose() }
    if ($process) {
        $process.Refresh()
        if (-not $process.HasExited) { $process.Kill(); $process.WaitForExit(3000) | Out-Null }
        $process.Dispose()
    }
    if (Test-Path -LiteralPath $testRoot) {
        Remove-Item -LiteralPath $testRoot -Recurse -Force
    }
}
