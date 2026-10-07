[CmdletBinding()]
param([string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot))

$ErrorActionPreference = 'Stop'
$latin1 = [Text.Encoding]::GetEncoding(28591)

function Read-Source([string]$RelativePath) {
    [IO.File]::ReadAllText((Join-Path $ProjectRoot $RelativePath), $latin1)
}

$wire = Read-Source 'Headers\PhongThanProtocol.h'
$characterState = Read-Source 'Headers\PhongThanCharacter.h'
$legacyProtocol = Read-Source 'Headers\KProtocol.h'
$protocolSizes = Read-Source 'Sources\Core\Src\KProtocol.cpp'
$dispatcher = Read-Source 'Sources\Core\Src\KProtocolProcess.cpp'
$dispatcherHeader = Read-Source 'Sources\Core\Src\KProtocolProcess.h'
$itemList = Read-Source 'Sources\Core\Src\KItemList.cpp'
$player = Read-Source 'Sources\Core\Src\KPlayer.cpp'
$coreShell = Read-Source 'Sources\Core\Src\CoreShell.cpp'
$coreShellHeader = Read-Source 'Sources\Core\Src\CoreShell.h'
$playerSet = Read-Source 'Sources\Core\Src\KPlayerSet.cpp'
$netClient = Read-Source 'Sources\GameClient\NetConnect\NetConnectAgent.cpp'
$netClientHeader = Read-Source 'Sources\GameClient\NetConnect\NetConnectAgent.h'
$gameServer = Read-Source 'Sources\MultiServer\GameServer\KSOServer.cpp'
$gameServerProject = Read-Source 'Sources\MultiServer\GameServer\GameServer.dsp'
$gameClientLogin = Read-Source 'Sources\GameClient\Login\Login.cpp'
$bishopServer = Read-Source 'Sources\MultiServer\Bishop\GameServer.cpp'
$bishopPlayer = Read-Source 'Sources\MultiServer\Bishop\GamePlayer.cpp'
$bishopIntercessor = Read-Source 'Sources\MultiServer\Bishop\Intercessor.cpp'
$bishopSmartClient = Read-Source 'Sources\MultiServer\Bishop\SmartClient.cpp'
$accountServer = Read-Source 'Sources\AccountServices\AccountServer\S3PDBSocketPool.cpp'
$goddessClient = Read-Source 'Sources\MultiServer\Goddess\ClientNode.cpp'
$characterStore = Read-Source 'Sources\MultiServer\Goddess\PhongThanCharacterStore.cpp'
$playerCreator = Read-Source 'Sources\MultiServer\Bishop\PlayerCreator.cpp'
$goddessMain = Read-Source 'Sources\MultiServer\Goddess\Goddess.cpp'
$goddessHeader = Read-Source 'Sources\MultiServer\Goddess\ClientNode.h'
$goddessProject = Read-Source 'Sources\MultiServer\Goddess\Goddess.dsp'
$coreServerShell = Read-Source 'Sources\Core\Src\CoreServerShell.cpp'
$coreServerShellHeader = Read-Source 'Sources\Core\Src\CoreServerShell.h'
$playerHeader = Read-Source 'Sources\Core\Src\KPlayer.h'
$playerDatabase = Read-Source 'Sources\Core\Src\KPlayerDBFuns.cpp'
$skillList = Read-Source 'Sources\Core\Src\KSkillList.cpp'
$npc = Read-Source 'Sources\Core\Src\KNpc.cpp'

$checks = [ordered]@{
    DedicatedWireContractExists = $wire -match 'PHONGTHAN_WIRE_MAGIC\s*=\s*0x4e485450' -and
                                  $wire -match 'PHONGTHAN_WIRE_VERSION\s*=\s*1'
    WireContractHasNoProjectIncludes = $wire -notmatch '(?m)^\s*#include\s*[<"]'
    WireUsesFixedSizeScalarAliases = $wire -match 'typedef unsigned char\s+PHONGTHAN_U8;' -and
                                     $wire -match 'typedef unsigned short\s+PHONGTHAN_U16;' -and
                                     $wire -match 'typedef unsigned int\s+PHONGTHAN_U32;' -and
                                     $wire -match 'MUST_BE_4_BYTES'
    WireHeaderIsSelfDescribing = $wire -match 'PHONGTHAN_U16 MessageType;' -and
                                 $wire -match 'PHONGTHAN_U32 PacketSize;' -and
                                 $wire -match 'PHONGTHAN_U32 Sequence;' -and
                                 $wire -match 'PHONGTHAN_HEADER_SIZE_MUST_BE_20'
    SessionEnterWorldUsesOpaqueTicket = $wire -match 'PHONGTHAN_SESSION_ENTER_WORLD_REQUEST' -and
                                        $wire -match 'SessionTicket\[PHONGTHAN_SESSION_TICKET_SIZE\]' -and
                                        $wire -notmatch '\bGUID\b' -and
                                        $netClient -match 'PHONGTHAN_MSG_SESSION_ENTER_WORLD' -and
                                        $gameServer -match 'PHONGTHAN_SESSION_ENTER_WORLD_REQUEST' -and
                                        $gameServer -match 'PhongThanValidateWireHeader\(&pRequest->Header'
    SessionTicketIsNativeEndToEnd = $bishopServer -match 'GeneratePhongThanSessionTicket' -and
                                    $bishopServer -notmatch '\b(?:GUID|GenGuid|CoCreateGuid)\b' -and
                                    $gameServer -notmatch '\bGUID\b' -and
                                    $netClient -notmatch '\bGUID\b' -and
                                    $netClientHeader -notmatch '\bGUID\b' -and
                                    $coreServerShell -match 'GetPlayerIndexBySessionTicket' -and
                                    $coreServerShellHeader -notmatch '\bGUID\b' -and
                                    $playerSet -match 'GetPlayerIndexBySessionTicket' -and
                                    $playerHeader -match 'm_SessionTicket\[PHONGTHAN_SESSION_TICKET_SIZE\]' -and
                                    $playerHeader -notmatch '\bGUID\b'
    SessionAuthenticationUsesNewWire = $wire -match 'PHONGTHAN_SESSION_AUTHENTICATE_REQUEST' -and
                                        $wire -match 'PHONGTHAN_SESSION_AUTHENTICATE_RESPONSE' -and
                                        $gameClientLogin -match 'PHONGTHAN_MSG_SESSION_AUTHENTICATE' -and
                                        $gameClientLogin -match 'PHONGTHAN_SESSION_AUTHENTICATE_REQUEST\s+Request' -and
                                        $bishopPlayer -match 'Attach\(\s*\r?\n?\s*PHONGTHAN_MSG_SESSION_AUTHENTICATE' -and
                                        $bishopPlayer -match 'PHONGTHAN_SESSION_AUTHENTICATE_RESPONSE\s+Response' -and
                                        $gameClientLogin -notmatch 'RegisterMsgTargetObject\(s2c_login' -and
                                        $gameClientLogin -notmatch '\(\*\(PROTOCOL_MSG_TYPE \*\) Buff\) = c2s_login' -and
                                        $bishopPlayer -notmatch 'Attach\(\s*c2s_login\s*\)' -and
                                        $bishopPlayer -notmatch '\bKLoginAccountInfo\s+lai\b' -and
                                        $protocolSizes -match '0,\s*//\s*s2c_login' -and
                                        $protocolSizes -match '0,\s*//\s*c2s_login'
    AccountServiceAuthenticationUsesNewWire = $wire -match 'PHONGTHAN_SERVICE_ACCOUNT_AUTHENTICATE_REQUEST' -and
                                               $wire -match 'PHONGTHAN_SERVICE_ACCOUNT_AUTHENTICATE_RESPONSE' -and
                                               $wire -match 'PHONGTHAN_SERVICE_ACCOUNT_RELEASE_REQUEST' -and
                                               $bishopPlayer -match 'PHONGTHAN_SERVICE_ACCOUNT_AUTHENTICATE_REQUEST\s+Request' -and
                                               $bishopPlayer -match 'PHONGTHAN_SERVICE_ACCOUNT_RELEASE_REQUEST\s+Request' -and
                                               $bishopIntercessor -match 'PHONGTHAN_SERVICE_ACCOUNT_AUTHENTICATE_RESPONSE' -and
                                               $accountServer -match 'ProPhongThanAccountAuthenticate' -and
                                               $accountServer -match 'ProPhongThanAccountRelease' -and
                                               $accountServer -match 'PhongThanValidateWireHeader\(pHeader' -and
                                               $accountServer -match 'pHeader->PacketSize != dwDataSize' -and
                                               $accountServer -match 'S3PAccount::Login\(pConn, szAccount' -and
                                               $accountServer -match 'S3PAccount::Logout\(pConn, m_nGameID' -and
                                               $accountServer -notmatch 'ProcessFunc\[c2s_accountlogin' -and
                                               $accountServer -notmatch 'ProAccountLogin\('
    GatewayServiceHelloUsesNewWire = $wire -match 'PHONGTHAN_MSG_SERVICE_GATEWAY_HELLO\s*=\s*0x1000' -and
                                      $wire -match 'PHONGTHAN_SERVICE_GATEWAY_HELLO_REQUEST' -and
                                      $wire -match 'PHONGTHAN_SERVICE_GATEWAY_HELLO_RESPONSE' -and
                                      $bishopSmartClient -match 'PHONGTHAN_SERVICE_GATEWAY_HELLO_REQUEST\s+Request' -and
                                      $bishopSmartClient -match 'PHONGTHAN_SERVICE_GATEWAY_HELLO_RESPONSE' -and
                                      $accountServer -match 'ProPhongThanGatewayHello' -and
                                      $accountServer -match 'S3PAccount::ServerLogin\(pConn, szGateway' -and
                                      $accountServer -notmatch '\b(?:ProGetwayVerify|c2s_gatewayverify|s2c_gatewayverify|KServerAccountUserLoginInfo)\b' -and
                                      $bishopSmartClient -notmatch '\b(?:c2s_gatewayverify|s2c_gatewayverify|KServerAccountUserLoginInfo|KAccountUserReturn)\b'
    BishopAccountWireHasNoLegacyPayload = $bishopPlayer -notmatch '\b(?:KAccountUserLoginInfo|KAccountUserReturnExt|KAccountUserLogout)\b' -and
                                           $bishopPlayer -notmatch '\b(?:c2s_accountlogin|s2c_accountlogin|c2s_accountlogout)\b' -and
                                           $bishopIntercessor -notmatch '\b(?:s2c_accountlogin|KAccountHead)\b'
    SessionCharacterListUsesNewWire = $wire -match 'PHONGTHAN_CHARACTER_SUMMARY' -and
                                      $wire -match 'PHONGTHAN_SESSION_CHARACTER_LIST_RESPONSE' -and
                                      $bishopPlayer -match 'PHONGTHAN_SESSION_CHARACTER_LIST_RESPONSE\s+Response' -and
                                      $bishopPlayer -notmatch 'SendData\(\s*m_lnIdentityID,\s*pRetBuffer->GetBuffer\(\),\s*pRetBuffer->GetUsed\(\)\s*\);\s*\r?\n\s*nNextTask = enumSelAddDelRole' -and
                                      $gameClientLogin -match 'ProcessRoleListResponse\(\s*\r?\n?\s*PHONGTHAN_SESSION_CHARACTER_LIST_RESPONSE' -and
                                      $gameClientLogin -notmatch 'ProcessRoleListResponse\(TProcessData' -and
                                      $gameClientLogin -notmatch 'RegisterMsgTargetObject\(s2c_roleserver_getrolelist_result'
    CharacterListServiceUsesNewWire = $wire -match 'PHONGTHAN_SERVICE_CHARACTER_LIST_REQUEST' -and
                                      $wire -match 'PHONGTHAN_SERVICE_CHARACTER_LIST_RESPONSE' -and
                                      $bishopPlayer -match 'PHONGTHAN_SERVICE_CHARACTER_LIST_REQUEST\s+Request' -and
                                      $bishopPlayer -match 'Attach\(\s*\r?\n?\s*PHONGTHAN_MSG_SERVICE_CHARACTER_LIST' -and
                                      $goddessClient -match 'PHONGTHAN_SERVICE_CHARACTER_LIST_RESPONSE\s+Response' -and
                                      $goddessClient -match 'PHONGTHAN_MSG_SERVICE_CHARACTER_LIST' -and
                                      $bishopPlayer -notmatch 'nProtoId\s*=\s*c2s_roleserver_getrolelist' -and
                                      $bishopPlayer -notmatch 'Attach\(\s*s2c_roleserver_getrolelist_result' -and
                                      $goddessClient -notmatch 'm_theProcessArray\[c2s_roleserver_getrolelist\]'
    SessionCharacterMutationUsesNewWire = $wire -match 'PHONGTHAN_SESSION_CREATE_CHARACTER_REQUEST' -and
                                          $wire -match 'PHONGTHAN_SESSION_DELETE_CHARACTER_REQUEST' -and
                                          $gameClientLogin -match 'PHONGTHAN_SESSION_CREATE_CHARACTER_REQUEST\s+Request' -and
                                          $gameClientLogin -match 'PHONGTHAN_SESSION_DELETE_CHARACTER_REQUEST\s+Request' -and
                                          $gameClientLogin -notmatch '\b(?:TProcessData|tagDBDelPlayer|tagNewDelRoleResponse)\b' -and
                                          $bishopPlayer -match 'Attach\(\s*\r?\n?\s*PHONGTHAN_MSG_SESSION_CREATE_CHARACTER' -and
                                          $bishopPlayer -match 'Attach\(\s*\r?\n?\s*PHONGTHAN_MSG_SESSION_DELETE_CHARACTER' -and
                                          $bishopPlayer -notmatch 'Attach\(\s*c2s_newplayer\s*\)' -and
                                          $bishopPlayer -notmatch 'Attach\(\s*c2s_roleserver_deleteplayer\s*\)' -and
                                          $protocolSizes -match '0,\s*//\s*s2c_rolenewdelresponse' -and
                                          $protocolSizes -match '0,\s*//\s*c2s_newplayer'
    CharacterDeleteServiceUsesNewWire = $wire -match 'PHONGTHAN_SERVICE_CHARACTER_DELETE_REQUEST' -and
                                        $wire -match 'PHONGTHAN_SERVICE_CHARACTER_DELETE_RESPONSE' -and
                                        $bishopPlayer -match 'PHONGTHAN_SERVICE_CHARACTER_DELETE_REQUEST\s+Request' -and
                                        $bishopPlayer -match 'Attach\(\s*\r?\n?\s*PHONGTHAN_MSG_SERVICE_CHARACTER_DELETE' -and
                                        $goddessClient -match 'PHONGTHAN_SERVICE_CHARACTER_DELETE_RESPONSE\s+Response' -and
                                        $goddessClient -match 'g_PhongThanCharacterStore\.Delete' -and
                                        $bishopPlayer -notmatch 'nProtoId\s*=\s*c2s_roleserver_deleteplayer' -and
                                        $bishopPlayer -notmatch 'Attach\(\s*s2c_roleserver_deleterole_result' -and
                                        $goddessClient -notmatch 'm_theProcessArray\[c2s_roleserver_deleteplayer\]'
    CharacterCreateServiceUsesNewWire = $wire -match 'PHONGTHAN_SERVICE_CHARACTER_CREATE_REQUEST' -and
                                        $wire -match 'PHONGTHAN_SERVICE_CHARACTER_CREATE_RESPONSE' -and
                                        $wire -match 'PHONGTHAN_STARTER_SKILL_LIMIT\s*=\s*64' -and
                                        $bishopPlayer -match 'PHONGTHAN_SERVICE_CHARACTER_CREATE_REQUEST\s+Request' -and
                                        $bishopPlayer -match 'Request\.Skills\[i\]\.SkillId' -and
                                        $bishopPlayer -match 'Attach\(\s*\r?\n?\s*PHONGTHAN_MSG_SERVICE_CHARACTER_CREATE' -and
                                        $goddessClient -match 'PHONGTHAN_SERVICE_CHARACTER_CREATE_RESPONSE\s+Response' -and
                                        $goddessClient -match 'pRequest->Skills\[i\]\.SkillId' -and
                                        $bishopPlayer -notmatch 'nProtoId\s*=\s*c2s_roleserver_createroleinfo' -and
                                        $bishopPlayer -notmatch 'Attach\(\s*s2c_roleserver_createrole_result' -and
                                        $goddessClient -notmatch 'm_theProcessArray\[c2s_roleserver_createroleinfo\]'
    CharacterStateHasIndependentSchema = $characterState -match 'PHONGTHAN_CHARACTER_SCHEMA_VERSION\s*=\s*1' -and
                                         $characterState -match 'PHONGTHAN_CHARACTER_STATE_HEADER' -and
                                         $characterState -match 'PhongThanValidateCharacterState' -and
                                         $characterState -notmatch '\b(?:TRoleData|TProcessData|KMagicAttrib|S3DBI_)\b'
    CharacterLoadServiceUsesNewWire = $wire -match 'PHONGTHAN_SERVICE_CHARACTER_LOAD_REQUEST' -and
                                      $wire -match 'PHONGTHAN_SERVICE_CHARACTER_LOAD_RESPONSE_HEADER' -and
                                      $bishopPlayer -match 'PHONGTHAN_SERVICE_CHARACTER_LOAD_REQUEST\s+Request' -and
                                      $bishopPlayer -match 'Attach\(\s*\r?\n?\s*PHONGTHAN_MSG_SERVICE_CHARACTER_LOAD' -and
                                      $bishopPlayer -match 'PhongThanValidateCharacterState' -and
                                      $bishopPlayer -notmatch 'nProtoId\s*=\s*c2s_roleserver_getroleinfo' -and
                                      $bishopPlayer -notmatch 'Attach\(\s*s2c_roleserver_getroleinfo_result' -and
                                      $bishopIntercessor -match 'PhongThanExtractRoleServiceRequestId' -and
                                      $goddessClient -match 'PHONGTHAN_SERVICE_CHARACTER_LOAD_RESPONSE_HEADER\s+Response' -and
                                      $goddessClient -match 'g_PhongThanCharacterStore\.Load' -and
                                      $goddessClient -notmatch '\b(?:TRoleData|S3DBI_GetRoleInfo|GetRoleInfo\()\b' -and
                                      $goddessClient -notmatch 'm_theProcessArray\[c2s_roleserver_getroleinfo\]'
    CharacterSaveServiceUsesNewWire = $wire -match 'PHONGTHAN_SERVICE_CHARACTER_SAVE_REQUEST_HEADER' -and
                                      $wire -match 'PHONGTHAN_SERVICE_CHARACTER_SAVE_RESPONSE' -and
                                      $gameServer -match 'PHONGTHAN_SERVICE_CHARACTER_SAVE_REQUEST_HEADER\* pRequest' -and
                                      $gameServer -match 'm_pCoreServerShell->SavePlayerDataAtOnce\(nIndex\)' -and
                                      $gameServer -match 'PhongThanValidateCharacterState\(pState, pState->StateSize\)' -and
                                      $gameServer -notmatch 'PhongThanCharacterFromLegacy' -and
                                      $gameServer -match 'PHONGTHAN_MSG_SERVICE_CHARACTER_SAVE' -and
                                      $goddessClient -match 'PHONGTHAN_SERVICE_CHARACTER_SAVE_REQUEST_HEADER\* pRequest' -and
                                      $goddessClient -match 'g_PhongThanCharacterStore\.Save' -and
                                      $goddessClient -match 'PHONGTHAN_SERVICE_CHARACTER_SAVE_RESPONSE\s+Response' -and
                                      $goddessClient -notmatch 'm_theProcessArray\[c2s_roleserver_saveroleinfo\]' -and
                                      $goddessClient -notmatch 'nProtoId\s*=\s*c2s_roleserver_saveroleinfo' -and
                                      $goddessClient -notmatch '\bTRoleData\b'
    CharacterLockServiceUsesNewWire = $wire -match 'PHONGTHAN_MSG_SERVICE_CHARACTER_LOCK\s*=\s*0x1106' -and
                                      $wire -match 'PHONGTHAN_SERVICE_CHARACTER_LOCK_REQUEST' -and
                                      $gameServer -match 'SendPhongThanCharacterLock' -and
                                      $gameServer -notmatch '\b(?:tagRoleEnterGame|c2s_roleserver_lock)\b' -and
                                      $goddessClient -match 'case PHONGTHAN_MSG_SERVICE_CHARACTER_LOCK:' -and
                                      $goddessClient -match 'PHONGTHAN_SERVICE_CHARACTER_LOCK_REQUEST \*pRequest' -and
                                      $goddessClient -notmatch '\b(?:tagRoleEnterGame|c2s_roleserver_lock)\b'
    CharacterPersistenceIsPhongThanNative = $characterStore -match 'PHONGTHAN_CHARACTER_FILE_MAGIC' -and
                                             $characterStore -match 'PhongThanValidateCharacterState' -and
                                             $characterStore -match 'MOVEFILE_REPLACE_EXISTING' -and
                                             $characterStore -match 'FlushFileBuffers' -and
                                             $characterStore -notmatch '\b(?:TRoleData|TProcessData|S3DBI_|ZDBTable)\b' -and
                                             $goddessClient -match 'g_PhongThanCharacterStore\.Create' -and
                                             $goddessClient -match 'g_PhongThanCharacterStore\.List'
    GoddessBuildUsesOnlyNativeStore = $goddessProject -match 'PhongThanCharacterStore\.cpp' -and
                                      $goddessProject -notmatch '\b(?:DBBackup|DBDumpLoad|DBTable|IDBRoleServer|libdb41s|db\.h)\b' -and
                                      $goddessMain -notmatch '\b(?:InitDBInterface|ReleaseDBInterface|StartBackupTimer|CDBBackup|ZDBTable)\b' -and
                                      $goddessClient -notmatch '\b(?:IDBRoleServer|GetRoleInfoForGM|SetRoleInfoForGM|TProcessData|GetGameStat)\b' -and
                                      $goddessHeader -notmatch '\b(?:m_theProcessArray|_RelayExtend|_GetGameStat)\b'
    CharacterCreationUsesCanonicalState = $playerCreator -match 'PHONGTHAN_CHARACTER_STATE_HEADER' -and
                                          $playerCreator -match 'PhongThanCharacterExpectedStateSize' -and
                                          $playerCreator -match 'PhongThanValidateCharacterState' -and
                                          $playerCreator -notmatch '\b(?:TRoleData|TDBSkillData|PhongThanDB)\b' -and
                                          $bishopPlayer -match 'const PHONGTHAN_CHARACTER_STATE_HEADER \*pRoleData' -and
                                          $bishopPlayer -notmatch '\bTRoleData\b'
    CoreCharacterPipelineUsesCanonicalState = $coreServerShell -match 'PhongThanValidateCharacterState\(pState, nBufferSize\)' -and
                                              $coreServerShell -match 'Player\[nIdx\]\.m_pStatusLoadPlayerInfo = Player\[nIdx\]\.m_SaveBuffer' -and
                                              $coreServerShell -notmatch '\b(?:TRoleData|TDBSkillData)\b' -and
                                              $playerDatabase -match 'LoadCharacterState\(const PHONGTHAN_CHARACTER_STATE_HEADER\* pState' -and
                                              $playerDatabase -match 'UpdateCharacterState\(PHONGTHAN_CHARACTER_STATE_HEADER\* pState' -and
                                              $playerDatabase -notmatch '\b(?:TRoleData|TDBSkillData)\b' -and
                                              $skillList -match 'PHONGTHAN_CHARACTER_SKILL_RECORD\* pSkillData' -and
                                              $skillList -notmatch '\bTDBSkillData\b' -and
                                              $npc -match 'PHONGTHAN_CHARACTER_SKILL_RECORD\* pStateData' -and
                                              $npc -notmatch '\bTDBSkillData\b'
    WorldAttachUsesCanonicalCharacterState = $wire -match 'PHONGTHAN_MSG_WORLD_ATTACH_CHARACTER\s*=\s*0x2005' -and
                                             $wire -match 'PHONGTHAN_WORLD_ATTACH_CHARACTER_HEADER' -and
                                             $bishopPlayer -match '_SyncRoleInfo_ToGameServer\(pState, pResponse->StateSize\)' -and
                                             $bishopServer -match 'PHONGTHAN_WORLD_ATTACH_CHARACTER_HEADER\* pAttach' -and
                                             $bishopServer -match 'PHONGTHAN_MSG_WORLD_ATTACH_CHARACTER' -and
                                             $gameServer -match 'PHONGTHAN_WORLD_ATTACH_CHARACTER_HEADER\* pAttach' -and
                                             $gameServer -match 'PhongThanValidateCharacterState\(pState, pAttach->StateSize\)' -and
                                             $gameServer -notmatch 'PhongThanCharacterToLegacy'
    WorldTransferUsesCanonicalState = $wire -match 'PHONGTHAN_MSG_WORLD_TRANSFER\s*=\s*0x2006' -and
                                      $wire -match 'PHONGTHAN_WORLD_TRANSFER_RESPONSE' -and
                                      $gameServer -match 'PHONGTHAN_RELAY_TRANSFER_PREPARE_HEADER\* pTransfer' -and
                                      $gameServer -match 'PhongThanValidateCharacterState\(pState, pState->StateSize\)' -and
                                      $gameServer -match 'PHONGTHAN_RELAY_TRANSFER_COMMIT\s+Commit' -and
                                      $netClient -match 'PHONGTHAN_MSG_WORLD_TRANSFER' -and
                                      $netClient -match 'PHONGTHAN_WORLD_TRANSFER_RESPONSE' -and
                                      $netClient -notmatch 'Msg\s*==\s*s2c_notifyplayerexchange'
    WorldServiceControlPlaneUsesNewWire = $wire -match 'PHONGTHAN_MSG_SERVICE_WORLD_HELLO\s*=\s*0x1201' -and
                                            $wire -match 'PHONGTHAN_MSG_SERVICE_WORLD_MAP_REGISTRY\s*=\s*0x1202' -and
                                            $wire -match 'PHONGTHAN_MSG_SERVICE_WORLD_SESSION\s*=\s*0x1203' -and
                                            $wire -match 'PHONGTHAN_SERVICE_WORLD_SESSION_EVENT' -and
                                            $gameServer -match 'RegisterGatewayWorldService' -and
                                            $gameServer -match 'NotifyGatewayWorldSession' -and
                                            $bishopServer -match '_QueryWorldService' -and
                                            $bishopServer -match '_UpdateMapRegistry' -and
                                            $bishopServer -match '_UpdateWorldSession'
    LegacyWorldControlPlaneRemoved = $gameServer -notmatch '\b(?:tagEnterGame|tagLeaveGame|tagRegisterAccount|tagQueryMapInfo|RELAY_DATA|RELAY_ASKWAY_DATA|KTransferUnit|m_pTransferClient)\b' -and
                                      $bishopServer -notmatch '\b(?:tagEnterGame|tagLeaveGame|tagRegisterAccount|tagQueryMapInfo|c2s_registeraccount|c2s_entergame|c2s_leavegame)\b' -and
                                      $gameServerProject -notmatch '\b(?:KTransferUnit|KRelayProtocol)\b'
    AccountWorldLifecycleUsesNewWire = $wire -match 'PHONGTHAN_MSG_SERVICE_ACCOUNT_ENTER_WORLD\s*=\s*0x1003' -and
                                        $wire -match 'PHONGTHAN_MSG_SERVICE_GATEWAY_HEARTBEAT\s*=\s*0x1004' -and
                                        $bishopServer -match 'PHONGTHAN_SERVICE_ACCOUNT_ENTER_WORLD_REQUEST' -and
                                        $bishopIntercessor -match 'PHONGTHAN_SERVICE_GATEWAY_HEARTBEAT' -and
                                        $accountServer -match 'ProcessPhongThanAccountEnterWorld' -and
                                        $accountServer -notmatch '\b(?:ProGameLogin|ProAccountLogout|c2s_gamelogin|c2s_accountlogout|KAccountUser)\b' -and
                                        $bishopIntercessor -notmatch '\b(?:PING_COMMAND|c2s_ping|s2c_ping)\b'
    SessionCharacterSelectionUsesNewWire = $wire -match 'PHONGTHAN_SESSION_SELECT_CHARACTER_REQUEST' -and
                                           $gameClientLogin -match 'PHONGTHAN_MSG_SESSION_SELECT_CHARACTER' -and
                                           $bishopPlayer -match 'Attach\(\s*PHONGTHAN_MSG_SESSION_SELECT_CHARACTER' -and
                                           $legacyProtocol -notmatch '\btagDBSelPlayer\b' -and
                                           $protocolSizes -match '0,\s*//\s*c2s_dbplayerselect'
    SessionRouteResponseUsesNewWire = $wire -match 'PHONGTHAN_SESSION_ENTER_WORLD_RESPONSE' -and
                                      $gameServer -match 'PHONGTHAN_SESSION_ENTER_WORLD_RESPONSE\s+Permit' -and
                                      $bishopServer -match 'PHONGTHAN_SESSION_ENTER_WORLD_RESPONSE' -and
                                      $bishopPlayer -match 'PHONGTHAN_MSG_SESSION_ENTER_WORLD' -and
                                      $gameClientLogin -match 'PHONGTHAN_SESSION_ENTER_WORLD_RESPONSE' -and
                                      $legacyProtocol -notmatch '\b(?:tagPermitPlayerLogin|tagNotifyPlayerLogin)\b'
    MessageIdsAreExplicit = $wire -match 'PHONGTHAN_MSG_SESSION_HELLO\s*=\s*0x0101' -and
                            $wire -match 'PHONGTHAN_MSG_WORLD_PLAYER_SNAPSHOT\s*=\s*0x2001' -and
                            $wire -match 'PHONGTHAN_MSG_INVENTORY_ITEM_SNAPSHOT\s*=\s*0x3001' -and
                            $wire -match 'PHONGTHAN_MSG_INVENTORY_ITEM_MOVE\s*=\s*0x3003' -and
                            $wire -match 'PHONGTHAN_MSG_INVENTORY_ITEM_DURABILITY\s*=\s*0x3004' -and
                            $wire -match 'PHONGTHAN_MSG_INVENTORY_ITEM_PROPERTIES\s*=\s*0x3005' -and
                            $wire -match 'PHONGTHAN_MSG_INVENTORY_ITEM_AUTO_MOVE\s*=\s*0x3006'
    ItemPayloadContainsOnlyWireScalars = $wire -match 'PHONGTHAN_ITEM_SNAPSHOT' -and
                                         $wire -notmatch '\b(?:PlayerItem|KLockItem|KMagicAttrib|KItemGeneratorParam)\b'
    ItemProducerInitializesEnvelope = $itemList -match 'PHONGTHAN_ITEM_SNAPSHOT\s+sItem' -and
                                      $itemList -match 'PhongThanInitializeWireHeader\(&sItem\.Header' -and
                                      $itemList -match 'PHONGTHAN_MSG_INVENTORY_ITEM_SNAPSHOT'
    ItemProducerDoesNotSendRuntimeObjects = $itemList -notmatch 'sItem\.m_(?:BackLocal|LockItem)' -and
                                            $itemList -match 'sItem\.BackContainer = pBack->nPlace'
    ItemRemoveAndDurabilityUseNewEnvelope = $itemList -match 'PHONGTHAN_ITEM_REMOVE_MESSAGE\s+Message' -and
                                             $itemList -match 'PHONGTHAN_ITEM_DURABILITY_MESSAGE\s+Message' -and
                                             $itemList -match 'Message\.Durability = nDurability'
    ItemPropertiesUseScalarWireAttributes = $wire -match 'PHONGTHAN_ATTRIBUTE_WIRE' -and
                                            $itemList -match 'PHONGTHAN_ITEM_PROPERTIES_MESSAGE\s+Message' -and
                                            $itemList -match 'Message\.Attributes\[j\]\.Type'
    ItemMovementUsesNewEnvelope = $wire -match 'PHONGTHAN_ITEM_MOVE_MESSAGE' -and
                                  $itemList -match 'PHONGTHAN_MSG_INVENTORY_ITEM_MOVE' -and
                                  $itemList -match 'PHONGTHAN_MSG_INVENTORY_ITEM_AUTO_MOVE' -and
                                  $dispatcher -match 'case PHONGTHAN_MSG_INVENTORY_ITEM_MOVE:' -and
                                  $dispatcher -match 'case PHONGTHAN_MSG_INVENTORY_ITEM_AUTO_MOVE:'
    ClientItemRequestsUseNewEnvelope = $wire -match 'PHONGTHAN_ITEM_USE_REQUEST' -and
                                       $wire -match 'PHONGTHAN_ITEM_PICKUP_REQUEST' -and
                                       $wire -match 'PHONGTHAN_ITEM_MOVE_REQUEST' -and
                                       $wire -match 'PHONGTHAN_ITEM_DROP_REQUEST' -and
                                       $wire -match 'PHONGTHAN_NPC_SHOP_SELL_REQUEST' -and
                                       $wire -match 'PHONGTHAN_NPC_SHOP_BUY_REQUEST' -and
                                       $player -match 'PHONGTHAN_MSG_INVENTORY_USE_REQUEST' -and
                                       $player -match 'PHONGTHAN_MSG_INVENTORY_PICKUP_REQUEST' -and
                                       $protocolSizes -match 'PHONGTHAN_MSG_NPC_SHOP_BUY_REQUEST'
    ServerDispatchesNewItemRequests = $dispatcher -match 'case PHONGTHAN_MSG_INVENTORY_USE_REQUEST:' -and
                                      $dispatcher -match 'case PHONGTHAN_MSG_INVENTORY_PICKUP_REQUEST:' -and
                                      $dispatcher -match 'case PHONGTHAN_MSG_INVENTORY_MOVE_REQUEST:' -and
                                      $dispatcher -match 'case PHONGTHAN_MSG_INVENTORY_DROP_REQUEST:' -and
                                      $dispatcher -match 'case PHONGTHAN_MSG_NPC_SHOP_SELL_REQUEST:' -and
                                      $dispatcher -match 'case PHONGTHAN_MSG_NPC_SHOP_BUY_REQUEST:'
    ClientFramerValidatesBeforeDispatch = $netClient -match 'PhongThanValidateWireHeader\(&Header, nRemaining\)' -and
                                          $netClient -match 'NetMsgCallbackFunc\(\(void\*\)pCurrent, Header\.PacketSize\)'
    CoreCallbackCarriesPacketSize = $coreShellHeader -match 'NetMsgCallbackFunc\(void\* pMsgData, unsigned int nMsgSize\)' -and
                                    $coreShell -match 'ProcessNetMsg\(\(BYTE \*\)pMsgData, nMsgSize\)'
    ServerDispatcherCarriesPacketSize = $dispatcherHeader -match 'ProcessNetMsg\(int nIndex, BYTE\* pMsg, unsigned int nMsgSize\)' -and
                                        $playerSet -match 'ProcessNetMsg\(nIndex, \(BYTE\*\)pChar, \(unsigned int\)nSize\)'
    CoreValidatesExactEnvelope = $dispatcher -match 'PhongThanValidateWireHeader\(pHeader, nMsgSize\)' -and
                                 $dispatcher -match 'pHeader->PacketSize != nMsgSize'
    CoreDispatchesItemByNewMessageId = $dispatcher -match 'case PHONGTHAN_MSG_INVENTORY_ITEM_SNAPSHOT:' -and
                                       $dispatcher -match 's2cSyncItem\(pMsg\);' -and
                                       $dispatcher -match 'case PHONGTHAN_MSG_INVENTORY_ITEM_REMOVE:' -and
                                       $dispatcher -match 'case PHONGTHAN_MSG_INVENTORY_ITEM_DURABILITY:' -and
                                       $dispatcher -match 'case PHONGTHAN_MSG_INVENTORY_ITEM_PROPERTIES:'
    ItemConsumerValidatesExactPayload = $dispatcher -match 'pItem->Header\.PacketSize != sizeof\(PHONGTHAN_ITEM_SNAPSHOT\)' -and
                                        $dispatcher -match 'pItem->TemplateRow'
    LegacyItemStructsRemoved = $legacyProtocol -notmatch '\b(?:PHONGTHAN_ITEM_SYNC|ITEM_SYNC_MAGIC|ITEM_REMOVE_SYNC|ITEM_DURABILITY_CHANGE|PLAYER_MOVE_ITEM_SYNC|ITEM_AUTO_MOVE_SYNC|PLAYER_EAT_ITEM_COMMAND|PLAYER_PICKUP_ITEM_COMMAND|PLAYER_MOVE_ITEM_COMMAND|PLAYER_SELL_ITEM_COMMAND|PLAYER_BUY_ITEM_COMMAND|PLAYER_THROW_AWAY_ITEM_COMMAND)\b'
    LegacyItemDispatchersRetired = $dispatcher -match 'ProcessFunc\[s2c_syncitem\]\s*=\s*NULL;' -and
                                   $dispatcher -match 'ProcessFunc\[s2c_syncmagic\]\s*=\s*NULL;' -and
                                   $dispatcher -match 'ProcessFunc\[s2c_removeitem\]\s*=\s*NULL;' -and
                                   $dispatcher -match 'ProcessFunc\[s2c_itemdurabilitychange\]\s*=\s*NULL;' -and
                                   $dispatcher -match 'ProcessFunc\[s2c_playermoveitem\]\s*=\s*NULL;' -and
                                   $dispatcher -match 'ProcessFunc\[s2c_ItemAutoMove\]\s*=\s*NULL;' -and
                                   $dispatcher -match 'ProcessFunc\[c2s_playereatitem\]\s*=\s*NULL;' -and
                                   $dispatcher -match 'ProcessFunc\[c2s_playerpickupitem\]\s*=\s*NULL;' -and
                                   $dispatcher -match 'ProcessFunc\[c2s_playermoveitem\]\s*=\s*NULL;' -and
                                   $dispatcher -match 'ProcessFunc\[c2s_playersellitem\]\s*=\s*NULL;' -and
                                   $dispatcher -match 'ProcessFunc\[c2s_playerbuyitem\]\s*=\s*NULL;' -and
                                   $dispatcher -match 'ProcessFunc\[c2s_playerthrowawayitem\]\s*=\s*NULL;'
    LegacyItemSizeEntriesRetired = $protocolSizes -match '0,\s*//\s*s2c_syncitem' -and
                                   $protocolSizes -match '0,\s*//\s*s2c_syncmagic' -and
                                   $protocolSizes -match '0,\s*//\s*s2c_removeitem' -and
                                   $protocolSizes -match '0,\s*//\s*s2c_itemdurabilitychange' -and
                                   $protocolSizes -match '0,\s*//\s*s2c_playermoveitem' -and
                                   $protocolSizes -match '0,\s*//\s*s2c_ItemAutoMove' -and
                                   $protocolSizes -match '0,\s*//\s*c2s_playereatitem' -and
                                   $protocolSizes -match '0,\s*//\s*c2s_playerpickupitem' -and
                                   $protocolSizes -match '0,\s*//\s*c2s_playermoveitem' -and
                                   $protocolSizes -match '0,\s*//\s*c2s_playersellitem' -and
                                   $protocolSizes -match '0,\s*//\s*c2s_playerbuyitem' -and
                                   $protocolSizes -match '0,\s*//\s*c2s_playerthrowawayitem'
    LegacyLogicLoginRetired = $legacyProtocol -notmatch '\btagLogicLogin\b' -and
                              $protocolSizes -match '0,\s*//\s*c2s_logicLogin'
}

$failed = @($checks.GetEnumerator() | Where-Object { -not $_.Value } | ForEach-Object Key)
if ($failed.Count) {
    throw "Phong Than protocol baseline gate FAIL: $($failed -join ', ')"
}

[pscustomobject]@{
    Result = 'PASS'
    Checks = $checks.Count
    MigratedMessageFamilies = 13
}
