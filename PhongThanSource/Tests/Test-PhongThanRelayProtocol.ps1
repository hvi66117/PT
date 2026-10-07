[CmdletBinding()]
param([string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot))

$ErrorActionPreference = 'Stop'
$path = Join-Path $ProjectRoot 'Headers\PhongThanRelayProtocol.h'
if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
    throw "Thieu relay protocol Phong Than: $path"
}
$source = [IO.File]::ReadAllText($path, [Text.Encoding]::GetEncoding(28591))
$code = [regex]::Replace($source, '(?s)/\*.*?\*/', '')
$code = [regex]::Replace($code, '(?m)//.*$', '')
$relaySourcePath = Join-Path $ProjectRoot 'Sources\MultiServer\PhongThanRelay\PhongThanRelay.cpp'
$relayProjectPath = Join-Path $ProjectRoot 'Sources\MultiServer\PhongThanRelay\PhongThanRelay.dsp'
$relaySource = if (Test-Path -LiteralPath $relaySourcePath) {
    [IO.File]::ReadAllText($relaySourcePath, [Text.Encoding]::GetEncoding(28591))
} else { '' }
$relayProject = if (Test-Path -LiteralPath $relayProjectPath) {
    [IO.File]::ReadAllText($relayProjectPath, [Text.Encoding]::GetEncoding(28591))
} else { '' }
$gameRelayClientPath = Join-Path $ProjectRoot 'Sources\MultiServer\GameServer\PhongThanRelayClient.cpp'
$gameRelayClient = if (Test-Path -LiteralPath $gameRelayClientPath) {
    [IO.File]::ReadAllText($gameRelayClientPath, [Text.Encoding]::GetEncoding(28591))
} else { '' }
$gameServerSourcePath = Join-Path $ProjectRoot 'Sources\MultiServer\GameServer\KSOServer.cpp'
$gameServerSource = if (Test-Path -LiteralPath $gameServerSourcePath) {
    [IO.File]::ReadAllText($gameServerSourcePath, [Text.Encoding]::GetEncoding(28591))
} else { '' }
$gameServerInit = [regex]::Match(
    $gameServerSource,
    '(?s)BOOL\s+KSwordOnLineSever::Init\(\).*?\n\}\s*\n\s*void\s+KSwordOnLineSever::Release').Value
$gameServerMessageLoop = [regex]::Match(
    $gameServerSource,
    '(?s)void\s+KSwordOnLineSever::MessageLoop\(\).*?\n\}\s*\n\s*BOOL\s+KSwordOnLineSever::RegisterRelayMaps').Value
$gameServerWorldEntry = [regex]::Match(
    $gameServerSource,
    '(?s)case\s+enumPlayerSyncEnd:.*?case\s+enumPlayerBegin:').Value
$gameServerTransferLoop = [regex]::Match(
    $gameServerSource,
    '(?s)void\s+KSwordOnLineSever::PlayerExchangeServer\(\).*?\n\}\s*\n\s*void\s+KSwordOnLineSever::PlayerLogoutGateway').Value
$gameClientNetPath = Join-Path $ProjectRoot 'Sources\GameClient\NetConnect\NetConnectAgent.cpp'
$gameClientNet = if (Test-Path -LiteralPath $gameClientNetPath) {
    [IO.File]::ReadAllText($gameClientNetPath, [Text.Encoding]::GetEncoding(28591))
} else { '' }
$coreServerShellPath = Join-Path $ProjectRoot 'Sources\Core\Src\CoreServerShell.cpp'
$coreServerShell = if (Test-Path -LiteralPath $coreServerShellPath) {
    [IO.File]::ReadAllText($coreServerShellPath, [Text.Encoding]::GetEncoding(28591))
} else { '' }
$buildScript = [IO.File]::ReadAllText(
    (Join-Path $ProjectRoot 'Build\Build-PhongThan.ps1'),
    [Text.Encoding]::UTF8)

$checks = [ordered]@{
    UsesCanonicalWireHeader = $source -match '#include\s+"PhongThanProtocol\.h"' -and
                              $source -match 'PHONGTHAN_WIRE_HEADER\s+Header;'
    OwnMessageFamily = $source -match 'PHONGTHAN_MSG_RELAY_REGISTER\s*=\s*0x6001' -and
                       $source -match 'PHONGTHAN_MSG_RELAY_FRIEND_EVENT\s*=\s*0x6051'
    CoversServiceRegistration = $source -match 'PHONGTHAN_RELAY_REGISTER_REQUEST' -and
                                $source -match 'PHONGTHAN_RELAY_HEARTBEAT'
    CoversRouteIndexes = $source -match 'PHONGTHAN_RELAY_SESSION_BIND' -and
                         $source -match 'PHONGTHAN_RELAY_MAP_BIND' -and
                         $source -match 'PHONGTHAN_RELAY_ROUTE_ACCOUNT' -and
                         $source -match 'PHONGTHAN_RELAY_ROUTE_ROLE' -and
                         $source -match 'PHONGTHAN_RELAY_ROUTE_MAP'
    CoversCharacterTransfer = $source -match 'PHONGTHAN_RELAY_TRANSFER_PREPARE_HEADER' -and
                              $source -match 'PHONGTHAN_RELAY_TRANSFER_RESULT' -and
                              $source -match 'PHONGTHAN_RELAY_TRANSFER_COMMIT' -and
                              $source -match 'PHONGTHAN_S32 ExtensionPoint;' -and
                              $source -match 'PHONGTHAN_S32 ChangedExtensionPoint;'
    CoversDomainTraffic = $source -match 'PHONGTHAN_RELAY_CHAT_HEADER' -and
                          $source -match 'PHONGTHAN_RELAY_CLAN_HEADER' -and
                          $source -match 'PHONGTHAN_RELAY_FRIEND_HEADER'
    CountsVariablePayloads = $source -match 'PHONGTHAN_U32 PayloadSize;' -and
                             $source -match 'PHONGTHAN_U32 StateSize;' -and
                             $source -match 'PHONGTHAN_U16 TextSize;'
    ValidatesExactPacketSizes = $source -match 'PhongThanValidateRelayRoutePacket' -and
                                $source -match 'pRoute->Header\.PacketSize != nAvailableSize' -and
                                $source -match 'PhongThanValidateRelayTransferPacket' -and
                                $source -match 'PhongThanValidateRelayChatPacket'
    HasNoLegacyRelayContract = $code -notmatch '\b(?:KRelayProtocol|RELAY_DATA|RELAY_ASKWAY_DATA|EXTEND_HEADER|TProcessData|tagSearchWay|tagPermitPlayerExchange|pf_relay|rm_map_id)\b'
    HasNoDatabaseOrRuntimeClass = $code -notmatch '\b(?:ADO|Berkeley|DBTable|S3PDB|IClient|IServer|KPlayer|KNpc|KItem)\b'
    NativeRelayExecutableExists = $relaySource -match 'class\s+PhongThanRelay' -and
                                  $relayProject -match 'Release\\PhongThanRelay\.exe'
    NativeRelayValidatesCharacterState = $relaySource -match 'PhongThanValidateCharacterState\(state, message->StateSize\)'
    NativeRelayHasNoLegacyOrDbLayer = $relaySource -notmatch '\b(?:KRelayProtocol|RELAY_DATA|RELAY_ASKWAY_DATA|EXTEND_HEADER|TProcessData|S3PDB|DBTable|msado15|libdb41s)\b' -and
                                      $relayProject -notmatch '\b(?:KRelayProtocol|S3PDB|DBTable|msado15|libdb41s|odbc32|odbccp32)\b'
    GameServerHasNativeRelayTransport = $gameRelayClient -match 'class\s+CPhongThanRelayClient|CPhongThanRelayClient::Connect' -and
                                        $gameRelayClient -match 'PhongThanValidateWireHeader' -and
                                        $gameRelayClient -match 'PHONGTHAN_MSG_RELAY_SESSION_BIND' -and
                                        $gameRelayClient -match 'PHONGTHAN_MSG_RELAY_MAP_BIND'
    GameRelayTransportHasNoLegacyEnvelope = $gameRelayClient -notmatch '\b(?:KRelayProtocol|RELAY_DATA|RELAY_ASKWAY_DATA|EXTEND_HEADER|TProcessData|tagEnterGame2|tagLeaveGame2)\b'
    GameServerInitializesNativeRelay = $gameServerInit -match 'm_RelayClient\.Connect\s*\(' -and
                                       $gameServerInit -match 'RegisterRelayMaps\s*\(\s*\)' -and
                                       $gameServerInit -notmatch 'CreateClientInterface\s*\([^\r\n]*&m_p(?:Transfer|Chat|Tong)Client'
    GameServerPumpsNativeRelayOnly = $gameServerMessageLoop -match 'm_RelayClient\.Pump\s*\(' -and
                                     $gameServerMessageLoop -match 'm_RelayClient\.PopPacket\s*\(' -and
                                     $gameServerMessageLoop -notmatch 'SendNetMsgTo(?:Transfer|Chat|Tong)|GetPackFromServer\(uSize\).*?(?:Transfer|Chat|Tong)MessageProcess'
    GameServerBindsNativeSession = $gameServerSource -match 'RememberPhongThanRelaySession\s*\(' -and
                                   $gameServerWorldEntry -match 'BindPhongThanRelaySession\s*\(' -and
                                   $gameServerWorldEntry -notmatch '\btagEnterGame2\b'
    GameServerUnbindsNativeSession = $gameServerSource -match 'UnbindPhongThanRelaySession\s*\(' -and
                                     $gameServerSource -match 'PHONGTHAN_RELAY_SESSION_END_DISCONNECTED' -and
                                     $source -match 'PHONGTHAN_RELAY_SESSION_END_SERVER_SHUTDOWN'
    GameServerUsesNativeCharacterTransfer = $gameServerTransferLoop -match 'PHONGTHAN_RELAY_TRANSFER_PREPARE_HEADER' -and
                                            $gameServerTransferLoop -match 'PreparePlayerForExchange' -and
                                            $gameServerTransferLoop -match 'PhongThanValidateCharacterState' -and
                                            $gameServerTransferLoop -notmatch '\b(?:RELAY_DATA|RELAY_ASKWAY_DATA|tagSearchWay|m_pTransferClient|PHONGTHAN_TRANSFER_PACK_KEY)\b' -and
                                            $gameServerSource -match 'case\s+PHONGTHAN_MSG_RELAY_TRANSFER_RESULT:' -and
                                            $gameServerSource -match 'PHONGTHAN_RELAY_TRANSFER_COMMIT\s+Commit'
    GameClientUsesNativeWorldTransfer = $gameClientNet -match 'PHONGTHAN_MSG_WORLD_TRANSFER' -and
                                        $gameClientNet -match 'PHONGTHAN_WORLD_TRANSFER_RESPONSE' -and
                                        $gameClientNet -notmatch 'Msg\s*==\s*s2c_notifyplayerexchange'
    LoadedMapEnumerationIsBounded = $coreServerShell -match 'int\s+nMax\s*=\s*nParam\s*/\s*\(int\)sizeof\(short\)' -and
                                    $coreServerShell -match 'if\s*\(nMax\s*>\s*MAX_SUBWORLD\)'
    DefaultBuildUsesNativeRelay = $buildScript -match "'PhongThanRelay'" -and
                                  $buildScript -match "Sources\\MultiServer\\PhongThanRelay\\PhongThanRelay\.dsp" -and
                                  $buildScript -notmatch "'RelayServer'.*'S3Relay'"
}

$failed = @($checks.GetEnumerator() | Where-Object { -not $_.Value } | ForEach-Object Key)
if ($failed.Count) {
    throw "Phong Than relay protocol gate FAIL: $($failed -join ', ')"
}

[pscustomobject]@{
    Result = 'PASS'
    Checks = $checks.Count
    LegacyRelaySymbols = 0
}
