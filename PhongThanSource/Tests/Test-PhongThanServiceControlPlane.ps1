[CmdletBinding()]
param([string]$ProjectRoot)

$ErrorActionPreference = 'Stop'
if (-not $ProjectRoot) {
    if ($PSScriptRoot) {
        $ProjectRoot = Split-Path -Parent $PSScriptRoot
    } else {
        $ProjectRoot = (Get-Location).Path
    }
}
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')

function Read-Source([string]$RelativePath) {
    $path = Join-Path $ProjectRoot $RelativePath
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        throw "Thieu source control-plane: $path"
    }
    return [IO.File]::ReadAllText($path, [Text.Encoding]::GetEncoding(1252))
}

function Assert-Match([string]$Text, [string]$Pattern, [string]$Message) {
    if ($Text -notmatch $Pattern) { throw $Message }
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
        if ($read -le 0) {
            throw "Socket dong khi con thieu $($Size - $offset) byte."
        }
        $offset += $read
    }
    return $result
}

function Read-UInt16([byte[]]$Bytes, [int]$Offset) {
    return [BitConverter]::ToUInt16($Bytes, $Offset)
}

function Read-UInt32([byte[]]$Bytes, [int]$Offset) {
    return [BitConverter]::ToUInt32($Bytes, $Offset)
}

function Read-Int32([byte[]]$Bytes, [int]$Offset) {
    return [BitConverter]::ToInt32($Bytes, $Offset)
}

function Assert-Header(
    [byte[]]$Packet,
    [uint16]$MessageType,
    [uint16]$Flags,
    [int]$PacketSize
) {
    if ($Packet.Count -ne $PacketSize -or
        (Read-UInt32 $Packet 0) -ne [uint32]0x4e485450 -or
        (Read-UInt16 $Packet 4) -ne 1 -or
        (Read-UInt16 $Packet 6) -ne 20 -or
        (Read-UInt16 $Packet 8) -ne $MessageType -or
        (Read-UInt16 $Packet 10) -ne $Flags -or
        (Read-UInt32 $Packet 12) -ne $PacketSize) {
        throw ("Wire header sai: type=0x{0:X4}, flags={1}, size={2}." -f
            (Read-UInt16 $Packet 8), (Read-UInt16 $Packet 10),
            (Read-UInt32 $Packet 12))
    }
}

function New-LoopbackPair {
    $listener = [Net.Sockets.TcpListener]::new([Net.IPAddress]::Loopback, 0)
    $listener.Start()
    $port = ([Net.IPEndPoint]$listener.LocalEndpoint).Port
    $client = New-Object Net.Sockets.TcpClient
    $client.ReceiveTimeout = 3000
    $client.SendTimeout = 3000
    $client.Connect('127.0.0.1', $port)
    $server = $listener.AcceptTcpClient()
    $server.ReceiveTimeout = 3000
    $server.SendTimeout = 3000
    return [pscustomobject]@{
        Listener = $listener
        Client = $client
        Server = $server
        Port = $port
    }
}

$wire = Read-Source 'Headers\PhongThanProtocol.h'
$gameServer = Read-Source 'Sources\MultiServer\GameServer\KSOServer.cpp'
$bishop = Read-Source 'Sources\MultiServer\Bishop\GameServer.cpp'
$intercessor = Read-Source 'Sources\MultiServer\Bishop\Intercessor.cpp'
$accountServer = Read-Source 'Sources\AccountServices\AccountServer\S3PDBSocketPool.cpp'

Assert-Match $wire 'PHONGTHAN_SERVICE_WORLD_HELLO_REQUEST_SIZE_MUST_BE_24' 'Hello request khong khoa kich thuoc 24 byte.'
Assert-Match $wire 'PHONGTHAN_SERVICE_WORLD_HELLO_RESPONSE_SIZE_MUST_BE_72' 'Hello response khong khoa kich thuoc 72 byte.'
Assert-Match $wire 'PHONGTHAN_SERVICE_WORLD_MAP_REGISTRY_HEADER_SIZE_MUST_BE_28' 'Map registry khong khoa header 28 byte.'
Assert-Match $wire 'PHONGTHAN_SERVICE_WORLD_SESSION_EVENT_SIZE_MUST_BE_116' 'World session khong khoa kich thuoc 116 byte.'
Assert-Match $gameServer 'RegisterGatewayWorldService[\s\S]{0,3600}PHONGTHAN_MSG_SERVICE_WORLD_MAP_REGISTRY' 'GameServer khong phat hello va map registry native.'
Assert-Match $gameServer 'NotifyGatewayWorldSession[\s\S]{0,2200}PHONGTHAN_MSG_SERVICE_WORLD_SESSION' 'GameServer khong phat world-session native.'
Assert-Match $bishop '_QueryWorldService[\s\S]{0,1400}PHONGTHAN_MSG_SERVICE_WORLD_HELLO' 'Bishop khong khoi tao world hello native.'
Assert-Match $bishop '_UpdateMapRegistry[\s\S]{0,3000}RegisterServer' 'Bishop khong nap map registry native.'
Assert-Match $bishop '_UpdateWorldSession[\s\S]{0,2600}PHONGTHAN_WORLD_SESSION_TRANSFER_REBIND' 'Bishop khong xu ly du cac pha world-session.'
Assert-Match $bishop 'PHONGTHAN_MSG_SERVICE_ACCOUNT_ENTER_WORLD' 'Bishop khong gui account enter-world native.'
Assert-Match $intercessor 'PHONGTHAN_MSG_SERVICE_GATEWAY_HEARTBEAT' 'Bishop khong gui heartbeat native.'
Assert-Match $accountServer 'ProcessPhongThanAccountEnterWorld[\s\S]{0,1600}S3PAccount::LoginGame' 'AccountServer khong xu ly enter-world native.'
Assert-Match $accountServer 'PHONGTHAN_MSG_SERVICE_GATEWAY_HEARTBEAT[\s\S]{0,900}PHONGTHAN_WIRE_FLAG_RESPONSE' 'AccountServer khong phan hoi heartbeat native.'

$ascii = [Text.Encoding]::ASCII
$worldPair = $null
$accountPair = $null
try {
    $worldPair = New-LoopbackPair
    $requestId = [uint32]77
    $helloRequest = New-Packet {
        param($writer)
        Write-Header $writer 0x1201 1 24 $requestId
        $writer.Write($requestId)
    }
    Send-Packet $worldPair.Client $helloRequest
    $receivedHelloRequest = Read-Exact $worldPair.Server 24
    Assert-Header $receivedHelloRequest 0x1201 1 24
    if ((Read-UInt32 $receivedHelloRequest 16) -ne $requestId -or
        (Read-UInt32 $receivedHelloRequest 20) -ne $requestId) {
        throw 'World hello request khong bao toan request id.'
    }

    $serviceId = [uint32]42
    $helloResponse = New-Packet {
        param($writer)
        Write-Header $writer 0x1201 2 72 $requestId
        $writer.Write($requestId)
        $writer.Write($serviceId)
        $writer.Write([uint32]0x0100007f)
        $writer.Write([uint32]0x0100007f)
        $writer.Write([uint16]6666)
        $writer.Write([uint16]1200)
        Write-Fixed $writer $ascii.GetBytes('phongthan-world-01') 32
    }
    Send-Packet $worldPair.Server $helloResponse
    $receivedHelloResponse = Read-Exact $worldPair.Client 72
    Assert-Header $receivedHelloResponse 0x1201 2 72
    if ((Read-UInt32 $receivedHelloResponse 20) -ne $requestId -or
        (Read-UInt32 $receivedHelloResponse 24) -ne $serviceId -or
        (Read-UInt16 $receivedHelloResponse 36) -ne 6666 -or
        (Read-UInt16 $receivedHelloResponse 38) -ne 1200) {
        throw 'World hello response sai service/address/capacity.'
    }

    $mapIds = @([int32]1001, [int32]1002, [int32]1003)
    $mapPacketSize = 28 + 4 * $mapIds.Count
    $mapRegistry = New-Packet {
        param($writer)
        Write-Header $writer 0x1202 1 $mapPacketSize 78
        $writer.Write($serviceId)
        $writer.Write([uint16]$mapIds.Count)
        $writer.Write([uint16]0)
        foreach ($mapId in $mapIds) { $writer.Write($mapId) }
    }
    Send-Packet $worldPair.Server $mapRegistry
    $receivedMapRegistry = Read-Exact $worldPair.Client $mapPacketSize
    Assert-Header $receivedMapRegistry 0x1202 1 $mapPacketSize
    if ((Read-UInt32 $receivedMapRegistry 20) -ne $serviceId -or
        (Read-UInt16 $receivedMapRegistry 24) -ne $mapIds.Count) {
        throw 'Map registry sai service/count.'
    }
    for ($i = 0; $i -lt $mapIds.Count; ++$i) {
        if ((Read-Int32 $receivedMapRegistry (28 + 4 * $i)) -ne $mapIds[$i]) {
            throw "Map registry sai map tai slot $i."
        }
    }

    $ticket = [byte[]](1..16)
    $phases = @(1, 3, 4, 5, 1, 2)
    $attached = $false
    $released = $false
    foreach ($phase in $phases) {
        $transferId = if ($phase -ge 3 -and $phase -le 5) { [uint32]9001 } else { [uint32]0 }
        $reason = if ($transferId) { [byte]4 } else { [byte]0 }
        $release = if ($phase -eq 2) { [byte]1 } else { [byte]0 }
        $session = New-Packet {
            param($writer)
            Write-Header $writer 0x1203 1 116 ([uint32](100 + $phase))
            $writer.Write($ticket)
            $writer.Write($transferId)
            $writer.Write([int32]1002)
            $writer.Write([int32]19)
            $writer.Write([byte]$phase)
            $writer.Write($reason)
            $writer.Write($release)
            $writer.Write([byte]0)
            Write-Fixed $writer $ascii.GetBytes('123456') 32
            Write-Fixed $writer $ascii.GetBytes('PhongThanHero') 32
        }
        Send-Packet $worldPair.Server $session
        $receivedSession = Read-Exact $worldPair.Client 116
        Assert-Header $receivedSession 0x1203 1 116
        if ($receivedSession[48] -ne $phase -or
            (Read-UInt32 $receivedSession 36) -ne $transferId -or
            (Read-Int32 $receivedSession 40) -ne 1002) {
            throw "World session phase $phase sai layout."
        }
        switch ($phase) {
            1 { $attached = $true }
            2 { $attached = $false; $released = ($receivedSession[50] -eq 1) }
            3 { $attached = $false }
            4 { $attached = $true }
            5 { $attached = $false }
        }
    }
    if ($attached -or -not $released) {
        throw 'State machine world-session khong ket thuc o trang thai released.'
    }

    $accountPair = New-LoopbackPair
    $enterRequest = New-Packet {
        param($writer)
        Write-Header $writer 0x1003 1 56 201
        $writer.Write([uint32]201)
        Write-Fixed $writer $ascii.GetBytes('123456') 32
    }
    Send-Packet $accountPair.Client $enterRequest
    $receivedEnterRequest = Read-Exact $accountPair.Server 56
    Assert-Header $receivedEnterRequest 0x1003 1 56

    $enterResponse = New-Packet {
        param($writer)
        Write-Header $writer 0x1003 2 60 201
        $writer.Write([uint32]201)
        $writer.Write([int32]0)
        Write-Fixed $writer $ascii.GetBytes('123456') 32
    }
    Send-Packet $accountPair.Server $enterResponse
    $receivedEnterResponse = Read-Exact $accountPair.Client 60
    Assert-Header $receivedEnterResponse 0x1003 2 60
    if ((Read-Int32 $receivedEnterResponse 24) -ne 0) {
        throw 'Account enter-world khong tra thanh cong.'
    }

    $timestamp = [uint32]123456789
    $heartbeat = New-Packet {
        param($writer)
        Write-Header $writer 0x1004 1 24 202
        $writer.Write($timestamp)
    }
    Send-Packet $accountPair.Client $heartbeat
    $receivedHeartbeat = Read-Exact $accountPair.Server 24
    Assert-Header $receivedHeartbeat 0x1004 1 24
    $heartbeatResponse = [byte[]]$receivedHeartbeat.Clone()
    [BitConverter]::GetBytes([uint16]2).CopyTo($heartbeatResponse, 10)
    Send-Packet $accountPair.Server $heartbeatResponse
    $receivedHeartbeatResponse = Read-Exact $accountPair.Client 24
    Assert-Header $receivedHeartbeatResponse 0x1004 2 24
    if ((Read-UInt32 $receivedHeartbeatResponse 20) -ne $timestamp) {
        throw 'Heartbeat response khong bao toan timestamp.'
    }

    [pscustomobject]@{
        Result = 'PASS'
        SourceChecks = 13
        WorldSocketPort = $worldPair.Port
        WorldServiceId = $serviceId
        RegisteredMaps = $mapIds.Count
        SessionEvents = $phases.Count
        TransferHoldRebindAbort = $true
        AccountEnterWorld = $true
        AccountHeartbeat = $true
    }
} finally {
    foreach ($pair in @($worldPair, $accountPair)) {
        if ($pair) {
            if ($pair.Client) { $pair.Client.Dispose() }
            if ($pair.Server) { $pair.Server.Dispose() }
            if ($pair.Listener) { $pair.Listener.Stop() }
        }
    }
}
