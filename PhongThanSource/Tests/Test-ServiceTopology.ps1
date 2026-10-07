[CmdletBinding()]
param(
    [string]$RuntimeRoot,
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$ManifestPath = (Join-Path (Split-Path -Parent $PSScriptRoot) 'Deploy\RUNTIME_CONTENT_MANIFEST.json')
)

$ErrorActionPreference = 'Stop'
$ProjectRoot = [IO.Path]::GetFullPath($ProjectRoot).TrimEnd('\')
if (-not $RuntimeRoot) { $RuntimeRoot = Join-Path (Split-Path -Parent $ProjectRoot) 'PhongThanRuntime-Staging' }
$RuntimeRoot = [IO.Path]::GetFullPath($RuntimeRoot).TrimEnd('\')
$serverRoot = Join-Path $RuntimeRoot 'Server'
$manifest = Get-Content -LiteralPath $ManifestPath -Raw | ConvertFrom-Json
$address = [string]$manifest.RuntimeSettings.LocalServiceAddress
if (-not $address) { throw 'Manifest thieu LocalServiceAddress.' }

function Read-Config([string]$Name) {
    $path = Join-Path $serverRoot $Name
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) { throw "Thieu topology config: $path" }
    return [IO.File]::ReadAllText($path, [Text.Encoding]::GetEncoding(936))
}

function Require-KeyValue([string]$Text, [string]$Key, [string]$Value, [string]$File) {
    $pattern = '(?im)^\s*' + [regex]::Escape($Key) + '\s*=\s*' + [regex]::Escape($Value) + '\s*$'
    if ($Text -notmatch $pattern) { throw "$File sai $Key, yeu cau $Value." }
}

$bishop = Read-Config 'Bishop.cfg'
foreach ($key in 'AccSvrIP', 'RoleSvrIP', 'GameSvrIP') { Require-KeyValue $bishop $key $address 'Bishop.cfg' }
Require-KeyValue $bishop 'AccSvrPort' '5002' 'Bishop.cfg'
Require-KeyValue $bishop 'RoleSvrPort' '5001' 'Bishop.cfg'
Require-KeyValue $bishop 'ClientOpenPort' '5622' 'Bishop.cfg'
Require-KeyValue $bishop 'GameSvrOpenPort' '5632' 'Bishop.cfg'

$relay = Read-Config 'relay_config.ini'
$relayAddresses = @([regex]::Matches($relay, '(?im)^\s*address\s*=\s*(?<value>[^\r\n]+)') |
    ForEach-Object { $_.Groups['value'].Value.Trim() })
if ($relayAddresses.Count -lt 4 -or @($relayAddresses | Where-Object { $_ -ne $address }).Count) {
    throw "relay_config.ini con dia chi ngoai topology local: $($relayAddresses -join ', ')."
}

$game = Read-Config 'ServerCfg.ini'
foreach ($key in 'Ip', 'IntranetIp', 'InternetIp') {
    $values = @([regex]::Matches($game, '(?im)^\s*' + $key + '\s*=\s*(?<value>[^\r\n]+)') |
        ForEach-Object { $_.Groups['value'].Value.Trim() })
    if (-not $values.Count -or @($values | Where-Object { $_ -ne $address }).Count) {
        throw "ServerCfg.ini sai ${key}: $($values -join ', ')."
    }
}
foreach ($port in 5001, 5003, 5004, 5005, 5632, 6666) {
    if ($game -notmatch ('(?im)^\s*Port\s*=\s*' + $port + '\s*$')) {
        throw "ServerCfg.ini thieu port $port."
    }
}

$account = Read-Config 'server.ini'
Require-KeyValue $account 'IP' $address 'server.ini'

[pscustomobject]@{
    Result = 'PASS'
    RuntimeRoot = $RuntimeRoot
    Address = $address
    ExpectedListeningServices = @($manifest.RuntimeSettings.ExpectedListeningPorts.PSObject.Properties).Count
    MixedAddressEntries = 0
}
