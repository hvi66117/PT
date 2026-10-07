/************************************************ *****************************************
//	????--login????
//	Copyright : Kingsoft 2002
//	Author	:   Wooy(Wu yue)
//	CreateTime:	2002-8-13
------------------------------------------------------------------------------------------
*****************************************************************************************/
#include "KWin32.h"
#include "KEngine.h"
#include "LoginDef.h"
#include "Login.h"
#include "../NetConnect/NetConnectAgent.h"
#include "KProtocol.h"
#include "crtdbg.h"
#include "../Ui/UiBase.h"
#include "../Ui/UiShell.h"
#include "../../Engine/Src/Cryptography/EDOneTimePad.h"
#include "time.h"

#pragma comment(lib, "Ws2_32.lib")    // anti 3 acc by veg

#include "inoutmac.h"        //veg

#define    SERVER_LIST_FILE                "\\serverlist.ini"

KLogin g_LoginLogic;


bool GetIpAddress(const char *szAddress, unsigned char *pcAddress) {
    _ASSERT(pcAddress);
    int nValue[4];
    int nRet = sscanf(szAddress, "%d.%d.%d.%d", &nValue[0], &nValue[1], &nValue[2], &nValue[3]);
    if (nRet == 4 &&
        nValue[0] >= 0 && nValue[0] < 256 &&
        nValue[1] >= 0 && nValue[1] < 256 &&
        nValue[2] >= 0 && nValue[2] < 256 &&
        nValue[3] >= 0 && nValue[3] < 256) {
        pcAddress[0] = nValue[0];
        pcAddress[1] = nValue[1];
        pcAddress[2] = nValue[2];
        pcAddress[3] = nValue[3];
        return true;
    }
    return false;
}

static unsigned gs_holdrand = time(NULL);

static inline unsigned _Rand() {
    gs_holdrand = gs_holdrand * 244213L + 1541021L;

    return gs_holdrand;
}

void RandMemSet(int nSize, unsigned char *pbyBuffer) {
    _ASSERT(nSize);
    _ASSERT(pbyBuffer);

    while (nSize--) {
        *pbyBuffer++ = (unsigned char) _Rand();
    }
}

//--------------------------------------------------------------------------
//	??????????????
//--------------------------------------------------------------------------
KLogin::KLogin() {
    m_Status = LL_S_IDLE;
    m_Result = LL_R_NOTHING;
    m_bInAutoProgress = false;
    m_nNumRole = 0;
    memset(&m_Choices, 0, sizeof(LOGIN_CHOICE));
    ClearAccountPassword(true, true);
    m_LeftTime = 0;
    m_LeftLockTime = 0;
}

void KLogin::ClearAccountPassword(bool bAccount, bool bPassword) {
    if (bAccount)
        memset(m_Choices.Account, 0xff, sizeof(m_Choices.Account));
    if (bPassword)
        memset(&m_Choices.Password, 0xff, sizeof(m_Choices.Password));
}

//--------------------------------------------------------------------------
//	??????????????
//--------------------------------------------------------------------------
KLogin::~KLogin() {
    _ASSERT(m_Status == LL_S_IDLE);
}

//--------------------------------------------------------------------------
//	??????????????????????????????
//	?????????????? LL_S_IDLE -> LL_S_WAIT_INPUT_ACCOUNT
//			  ???? ????????
//--------------------------------------------------------------------------
int KLogin::CreateConnection(const unsigned char *pAddress) {
    if (m_bInAutoProgress && m_Status != LL_S_IDLE)
        return true;

    int nRet;
    if (m_Status == LL_S_IDLE && pAddress &&
        ConnectAccountServer(pAddress)) {
        RegistNetAgent();
        m_Status = LL_S_WAIT_INPUT_ACCOUNT;
        m_Result = LL_R_NOTHING;

        if (m_bInAutoProgress) {
            char szAccount[32];
            KSG_PASSWORD Password;
            GetAccountPassword(szAccount, &Password);
            AccountLogin(szAccount, Password, false);
            memset(szAccount, 0, sizeof(szAccount));
            memset(&Password, 0, sizeof(Password));
        }
        nRet = true;
    } else {
        if (m_bInAutoProgress)
            m_bInAutoProgress = false;
        m_Result = LL_R_CONNECT_FAILED;
        nRet = false;
    }
    FILE *pAutoLog = fopen("client_autologin_diag.log", "a+t");
    if (pAutoLog) {
        fprintf(pAutoLog, "CreateConnection result=%d status=%d auto=%d address=%u.%u.%u.%u\n",
                nRet, (int)m_Status, (int)m_bInAutoProgress,
                pAddress ? pAddress[0] : 0, pAddress ? pAddress[1] : 0,
                pAddress ? pAddress[2] : 0, pAddress ? pAddress[3] : 0);
        fclose(pAutoLog);
    }
    return nRet;
}

//--------------------------------------------------------------------------
//	????????????????????????????
//	?????????????? LL_S_WAIT_INPUT_ACCOUNT -> LL_S_ACCOUNT_CONFIRMING
//			  ???? ????????
//--------------------------------------------------------------------------
int KLogin::AccountLogin(const char *pszAccount, const KSG_PASSWORD &crPassword, bool bOrignPassword) {
    int nRet;
    if (m_Status == LL_S_WAIT_INPUT_ACCOUNT &&
        pszAccount &&
        Request(pszAccount, &crPassword)) {
        if (bOrignPassword) {
            SetAccountPassword(pszAccount, &crPassword);
        }
        m_Status = LL_S_ACCOUNT_CONFIRMING;
        m_Result = LL_R_NOTHING;
        nRet = true;
    } else {
        if (m_bInAutoProgress)
            m_bInAutoProgress = false;
        m_Result = LL_R_CONNECT_FAILED;
        nRet = false;
    }
    FILE *pAutoLog = fopen("client_autologin_diag.log", "a+t");
    if (pAutoLog) {
        fprintf(pAutoLog, "AccountLogin account=%s result=%d status=%d auto=%d\n",
                pszAccount ? pszAccount : "(null)", nRet, (int)m_Status, (int)m_bInAutoProgress);
        fclose(pAutoLog);
    }
    return nRet;
}

//--------------------------------------------------------------------------
//	??????????????????
//	?????????????? LL_S_ROLE_LIST_READY -> LL_S_WAIT_TO_LOGIN_GAMESERVER
//			  ???? ????????
//--------------------------------------------------------------------------
int KLogin::SelectRole(int nIndex) {
    int nRet;
    if (m_Status == LL_S_ROLE_LIST_READY && nIndex >= 0 && nIndex < m_nNumRole) {
        PHONGTHAN_SESSION_SELECT_CHARACTER_REQUEST NetCommand;
        ZeroMemory(&NetCommand, sizeof(NetCommand));
        PhongThanInitializeWireHeader(&NetCommand.Header,
                PHONGTHAN_MSG_SESSION_SELECT_CHARACTER, sizeof(NetCommand),
                PHONGTHAN_WIRE_FLAG_REQUEST, 0);
        strncpy((char *)NetCommand.RoleName, m_RoleList[nIndex].Name,
                sizeof(NetCommand.RoleName) - 1);
        g_NetConnectAgent.SendMsg(&NetCommand, sizeof(NetCommand));
        g_NetConnectAgent.UpdateClientRequestTime(false);
        strcpy(m_Choices.szProcessingRoleName, (const char *)NetCommand.RoleName);
        m_Status = LL_S_WAIT_TO_LOGIN_GAMESERVER;
        m_Result = LL_R_NOTHING;
        nRet = true;
    } else {
        if (m_bInAutoProgress)
            m_bInAutoProgress = false;
        m_Result = LL_R_CONNECT_FAILED;
        nRet = false;
    }
    return nRet;
}

//--------------------------------------------------------------------------
//	??????????????????????
//	?????????????? LL_S_ROLE_LIST_READY -> LL_S_CREATING_ROLE
//			  ???? ????????
//--------------------------------------------------------------------------
int KLogin::CreateRole(KRoleChiefInfo *pCreateInfo) {
    int nRet = false;
    m_Result = LL_R_CONNECT_FAILED;

    if (m_Status == LL_S_ROLE_LIST_READY && pCreateInfo && m_nNumRole < MAX_PLAYER_PER_ACCOUNT &&
        pCreateInfo->Profession < PHONGTHAN_PROFESSION_COUNT) {
        int nNameLen = strlen(pCreateInfo->Name);
        if (nNameLen >= LOGIN_ROLE_NAME_MIN_LEN && nNameLen <= LOGIN_ROLE_NAME_MAX_LEN) {
            PHONGTHAN_SESSION_CREATE_CHARACTER_REQUEST Request;
            ZeroMemory(&Request, sizeof(Request));
            PhongThanInitializeWireHeader(&Request.Header,
                    PHONGTHAN_MSG_SESSION_CREATE_CHARACTER, sizeof(Request),
                    PHONGTHAN_WIRE_FLAG_REQUEST, 0);
            memcpy(Request.RoleName, pCreateInfo->Name, nNameLen);
            Request.Gender = pCreateInfo->Gender;
            Request.Profession = pCreateInfo->Profession;
            Request.NativePlaceId = pCreateInfo->NativePlaceId;

            if (!g_NetConnectAgent.SendMsg(&Request, sizeof(Request)))
                return false;
            g_NetConnectAgent.UpdateClientRequestTime(false);

            memcpy(m_Choices.szProcessingRoleName, pCreateInfo->Name, nNameLen);
            m_Choices.szProcessingRoleName[nNameLen] = 0;

            m_Status = LL_S_CREATING_ROLE;
            m_Result = LL_R_NOTHING;
            nRet = true;
        }
    }
    return nRet;
}

//--------------------------------------------------------------------------
//	??????????????????????
//	?????????????? LL_S_ROLE_LIST_READY -> LL_S_DELETING_ROLE
//			  ???? ????????
//--------------------------------------------------------------------------
int KLogin::DeleteRole(int nIndex, const KSG_PASSWORD &crSupperPassword) {
    //return FALSE;
    int nRet;

    if (m_Status == LL_S_ROLE_LIST_READY && nIndex >= 0 && nIndex < m_nNumRole) {
        PHONGTHAN_SESSION_DELETE_CHARACTER_REQUEST Request;
        ZeroMemory(&Request, sizeof(Request));
        PhongThanInitializeWireHeader(&Request.Header,
                PHONGTHAN_MSG_SESSION_DELETE_CHARACTER, sizeof(Request),
                PHONGTHAN_WIRE_FLAG_REQUEST, 0);
        strncpy((char *)Request.RoleName, m_RoleList[nIndex].Name,
                sizeof(Request.RoleName) - 1);
        strncpy((char *)Request.PasswordProof, crSupperPassword.szPassword,
                sizeof(Request.PasswordProof) - 1);

        int nSent = g_NetConnectAgent.SendMsg(&Request, sizeof(Request));
        ZeroMemory(Request.PasswordProof, sizeof(Request.PasswordProof));
        if (!nSent)
            return false;
        g_NetConnectAgent.UpdateClientRequestTime(false);

        strcpy(m_Choices.szProcessingRoleName, m_RoleList[nIndex].Name);

        m_Status = LL_S_DELETING_ROLE;
        m_Result = LL_R_NOTHING;
        nRet = true;
    } else {
        nRet = false;
        m_Result = LL_R_CONNECT_FAILED;
    }
    return nRet;
}

//--------------------------------------------------------------------------
//	????????????????????????????
//	?????????????? LL_S_??? -> LL_S_IDLE
//--------------------------------------------------------------------------
void KLogin::NotifyTimeout() {
    if (m_Status != LL_S_IDLE) {
        ReturnToIdle();
        m_Result = LL_R_CONNECT_TIMEOUT;
    }
}

//??????????????????????????
void KLogin::NotifyDisconnect() {
    if (m_Status != LL_S_IDLE) {
        ReturnToIdle();
        m_Result = LL_R_CONNECT_FAILED;
    }
}

//--------------------------------------------------------------------------
//	??????????????????????
//	?????????????? LL_S_ENTERING_GAME -> LL_S_IN_GAME
//--------------------------------------------------------------------------
void KLogin::NotifyToStartGame() {
    FILE *fGameStartDiag = fopen("client_game_start_diag.log", "a+");
    if (fGameStartDiag) {
        fprintf(fGameStartDiag, "NotifyToStartGame enter status=%d result=%d\\r\\n", (int)m_Status, (int)m_Result);
        fclose(fGameStartDiag);
    }
    if (m_Status == LL_S_ENTERING_GAME) {
        g_NetConnectAgent.UpdateClientRequestTime(true);

        char szAccount[32];
        GetAccountPassword(szAccount, NULL);
        g_UiBase.SetUserAccount(szAccount, m_Choices.szProcessingRoleName);

        m_Status = LL_S_IN_GAME;
        m_Result = LL_R_NOTHING;
        if (m_bInAutoProgress)
            m_bInAutoProgress = false;
        UiOnGameServerStartSyncEnd();
        // The sync-end notification is raised from the core network path.
        // Start the UI immediately so the connecting overlay cannot remain
        // visible while the player is already in the game world.
        UiStartGame();
        fGameStartDiag = fopen("client_game_start_diag.log", "a+");
        if (fGameStartDiag) {
            fprintf(fGameStartDiag, "NotifyToStartGame ui_started status=%d\\r\\n", (int)m_Status);
            fclose(fGameStartDiag);
        }
    }
}

//--------------------------------------------------------------------------
//	??????????????????
//	??????????LL_S_??? -> LL_S_IN_GAME
//--------------------------------------------------------------------------
void KLogin::ReturnToIdle() {
    if (m_Status != LL_S_IDLE) {
        UnRegistNetAgent();
        g_NetConnectAgent.DisconnectGameSvr();
        g_NetConnectAgent.DisconnectClient();
        m_Status = LL_S_IDLE;
    }
    m_Choices.bIsRoleNewCreated = false;
    m_Result = LL_R_NOTHING;
    m_bInAutoProgress = false;
}

//--------------------------------------------------------------------------
//	??????????????????
//--------------------------------------------------------------------------
void KLogin::AutoLogin() {
    ReturnToIdle();
    if (IsAutoLoginEnable()) {
        m_bInAutoProgress = true;
        if (m_Choices.AccountServer.Address[0] == 0 &&
            m_Choices.AccountServer.Address[1] == 0 &&
            m_Choices.AccountServer.Address[2] == 0 &&
            m_Choices.AccountServer.Address[3] == 0) {
            int nCount, nSel;
            KLoginServer *pList = GetServerList(-1, nCount, nSel);
            if (pList) {
                free(pList);
                pList = NULL;
            }
        }
        int nConnectResult = CreateConnection(m_Choices.AccountServer.Address);
        FILE *pAutoLog = fopen("client_autologin_diag.log", "a+t");
        if (pAutoLog) {
            fprintf(pAutoLog, "AutoLogin connect=%d status=%d address=%u.%u.%u.%u\n",
                    nConnectResult, (int)m_Status,
                    m_Choices.AccountServer.Address[0], m_Choices.AccountServer.Address[1],
                    m_Choices.AccountServer.Address[2], m_Choices.AccountServer.Address[3]);
            fclose(pAutoLog);
        }
    }
}

//--------------------------------------------------------------------------
//	??????????????????????????????????
//--------------------------------------------------------------------------
int KLogin::IsAutoLoginEnable() {
    return ((~m_Choices.Account[0]) &&
            (~m_Choices.Password.szPassword[0]) &&
            m_Choices.AccountServer.Title[0]);
}

void KLogin::SetLastInvisibleFlag(int nEnable) {
    m_Choices.nLastInvisible = nEnable;
}

//????????????
void KLogin::SetRememberAccountFlag(bool bEnable) {
    m_Choices.bRememberAccount = bEnable;
    if (bEnable == false)
        m_Choices.bRememberAll = false;
}

//????????????
void KLogin::SetRememberAllFlag(bool bEnable) {
    m_Choices.bRememberAll = bEnable;
    if (bEnable)
        m_Choices.bRememberAccount = true;
}

void KLogin::SetVirtualKeyboardFlag(bool bEnable) {
    m_Choices.bVirtualKeyboard = bEnable;
}

//--------------------------------------------------------------------------
//	????????????????????????
//--------------------------------------------------------------------------
int KLogin::GetRoleInfo(int nIndex, KRoleChiefInfo *pInfo) {
    if (nIndex >= 0 && nIndex < m_nNumRole) {
        if (pInfo)
            *pInfo = m_RoleList[nIndex];
        return true;
    }
    return false;
}


//--------------------------------------------------------------------------
//	????????????????????????
//	?????????????? LL_S_ACCOUNT_CONFIRMING -> LL_S_WAIT_ROLE_LIST
//			  ???? LL_S_ACCOUNT_CONFIRMING -> LL_S_IDLE
//--------------------------------------------------------------------------
void KLogin::ProcessAccountLoginResponse(
        PHONGTHAN_SESSION_AUTHENTICATE_RESPONSE *pResponse) {
    if (!pResponse ||
        pResponse->Header.MessageType != PHONGTHAN_MSG_SESSION_AUTHENTICATE ||
        pResponse->Header.Flags != PHONGTHAN_WIRE_FLAG_RESPONSE ||
        pResponse->Header.PacketSize != sizeof(*pResponse)) {
        return;
    }

    char szAccount[32];
    GetAccountPassword(szAccount, NULL);
    if (strncmp((const char *)pResponse->AccountName, szAccount,
                sizeof(pResponse->AccountName)) != 0) {
        memset(szAccount, 0, sizeof(szAccount));
        ReturnToIdle();
        m_Result = LL_R_CONNECT_FAILED;
        return;
    }
    memset(szAccount, 0, sizeof(szAccount));

    if (pResponse->Result == PHONGTHAN_AUTH_SUCCESS) {
        g_NetConnectAgent.UpdateClientRequestTime(false);
        m_Status = LL_S_WAIT_ROLE_LIST;
        m_Result = LL_R_ACCOUNT_CONFIRM_SUCCESS;
        m_LeftTime = pResponse->RemainingTime;
        return;
    }

    LOGIN_LOGIC_RESULT_INFO eResult = LL_R_CONNECT_FAILED;
    switch (pResponse->Result) {
        case PHONGTHAN_AUTH_INVALID_CREDENTIALS:
            eResult = LL_R_ACCOUNT_PWD_ERROR;
            break;
        case PHONGTHAN_AUTH_ACCOUNT_IN_USE:
            eResult = LL_R_ACCOUNT_LOCKED;
            break;
        case PHONGTHAN_AUTH_ACCOUNT_FROZEN:
            m_LeftLockTime = pResponse->RemainingTime;
            eResult = LL_R_ACCOUNT_FREEZE;
            break;
        case PHONGTHAN_AUTH_TIME_EXPIRED:
            eResult = LL_R_ACCOUNT_NOT_ENOUGH_POINT;
            break;
        case PHONGTHAN_AUTH_INCOMPATIBLE_VERSION:
            eResult = LL_R_INVALID_PROTOCOLVERSION;
            break;
        case PHONGTHAN_AUTH_SERVICE_UNAVAILABLE:
            eResult = LL_R_CONNECT_SERV_BUSY;
            break;
    }
    ReturnToIdle();
    m_Result = eResult;
}

//--------------------------------------------------------------------------
//	??????????????????
//	?????????????? LL_S_WAIT_ROLE_LIST -> LL_S_ROLE_LIST_READY
//			  ???? ????????
//--------------------------------------------------------------------------
void KLogin::ProcessRoleListResponse(
        PHONGTHAN_SESSION_CHARACTER_LIST_RESPONSE *pResponse) {
    if (!pResponse ||
        pResponse->Header.MessageType != PHONGTHAN_MSG_SESSION_CHARACTER_LIST ||
        pResponse->Header.Flags != PHONGTHAN_WIRE_FLAG_RESPONSE ||
        pResponse->Header.PacketSize != sizeof(*pResponse) ||
        pResponse->Result != PHONGTHAN_CHARACTER_LIST_SUCCESS ||
        pResponse->CharacterCount > PHONGTHAN_CHARACTER_LIMIT ||
        pResponse->CharacterCount > MAX_PLAYER_PER_ACCOUNT) {
        ReturnToIdle();
        m_Result = LL_R_CONNECT_FAILED;
        return;
    }

    m_nNumRole = pResponse->CharacterCount;
    memset(m_RoleList, 0, sizeof(m_RoleList));
    for (int i = 0; i < m_nNumRole; ++i) {
        const PHONGTHAN_CHARACTER_SUMMARY *pRole = &pResponse->Characters[i];
        if (!PhongThanReadLoginRole(*pRole, m_RoleList[i])) {
            ReturnToIdle();
            m_Result = LL_R_CONNECT_FAILED;
            return;
        }
    }

    g_NetConnectAgent.UpdateClientRequestTime(true);
    m_Status = LL_S_ROLE_LIST_READY;
    m_Result = LL_R_NOTHING;

    if (m_bInAutoProgress) {
        int nAdviceChoice = pResponse->RecommendedIndex;
        if (nAdviceChoice < 0 || nAdviceChoice >= m_nNumRole)
            nAdviceChoice = 0;
        SelectRole(nAdviceChoice);
    }
}

//--------------------------------------------------------------------------
//	????????????????????????
//	??????????LL_S_CREATING_ROLE -> LL_S_ROLE_LIST_READY
//--------------------------------------------------------------------------
void KLogin::ProcessCreateRoleResponse(
        PHONGTHAN_SESSION_CREATE_CHARACTER_RESPONSE *pResponse) {
    if (!pResponse ||
        pResponse->Header.MessageType != PHONGTHAN_MSG_SESSION_CREATE_CHARACTER ||
        pResponse->Header.Flags != PHONGTHAN_WIRE_FLAG_RESPONSE ||
        pResponse->Header.PacketSize != sizeof(*pResponse) ||
        strncmp((const char*)pResponse->RoleName,
                m_Choices.szProcessingRoleName,
                sizeof(pResponse->RoleName)) != 0) {
        ReturnToIdle();
        m_Result = LL_R_CONNECT_FAILED;
        return;
    }

    if (pResponse->Result == PHONGTHAN_CHARACTER_OPERATION_SUCCESS) {
        g_NetConnectAgent.UpdateClientRequestTime(false);
        m_Choices.bIsRoleNewCreated = true;
        m_Status = LL_S_WAIT_TO_LOGIN_GAMESERVER;
        m_Result = LL_R_CREATE_ROLE_SUCCESS;
    } else {
        g_NetConnectAgent.UpdateClientRequestTime(true);
        m_Status = LL_S_ROLE_LIST_READY;
        m_Result = LL_R_INVALID_ROLENAME;
    }
}

//--------------------------------------------------------------------------
//	????????????????????????
//	??????????LL_S_DELETING_ROLE -> LL_S_ROLE_LIST_READY
//--------------------------------------------------------------------------
void KLogin::ProcessDeleteRoleResponse(
        PHONGTHAN_SESSION_DELETE_CHARACTER_RESPONSE *pResponse) {
    if (!pResponse ||
        pResponse->Header.MessageType != PHONGTHAN_MSG_SESSION_DELETE_CHARACTER ||
        pResponse->Header.Flags != PHONGTHAN_WIRE_FLAG_RESPONSE ||
        pResponse->Header.PacketSize != sizeof(*pResponse) ||
        strncmp((const char*)pResponse->RoleName,
                m_Choices.szProcessingRoleName,
                sizeof(pResponse->RoleName)) != 0) {
        ReturnToIdle();
        m_Result = LL_R_CONNECT_FAILED;
        return;
    }

    g_NetConnectAgent.UpdateClientRequestTime(true);
    m_Status = LL_S_ROLE_LIST_READY;
    if (pResponse->Result == PHONGTHAN_CHARACTER_OPERATION_SUCCESS) {
                char szAccount[32];
                GetAccountPassword(szAccount, NULL);
                g_UiBase.SetUserAccount(szAccount, m_Choices.szProcessingRoleName);
                g_UiBase.CleanPrivateDataFolder();

                for (int i = 0; i < m_nNumRole; i++) {
                    if (strcmp(m_RoleList[i].Name, m_Choices.szProcessingRoleName) == 0) {
                        m_nNumRole--;
                        for (; i < m_nNumRole; i++)
                            m_RoleList[i] = m_RoleList[i + 1];
                        break;
                    }
                }
        m_Result = LL_R_NOTHING;
    } else if (pResponse->Result == PHONGTHAN_CHARACTER_OPERATION_INVALID_CREDENTIALS) {
        m_Result = LL_R_INVALID_PASSWORD;
    } else {
        m_Result = LL_R_CONNECT_SERV_BUSY;
    }
}

//--------------------------------------------------------------------------
//	??????????????????????????????
//	??????????LL_S_WAIT_TO_LOGIN_GAMESERVER -> LL_S_ENTERING_GAME
//--------------------------------------------------------------------------
void KLogin::ProcessToLoginGameServResponse(PHONGTHAN_SESSION_ENTER_WORLD_RESPONSE *pResponse) {
    //_ASSERT(m_Status == LL_S_WAIT_TO_LOGIN_GAMESERVER && pResponse != NULL);
    if (pResponse &&
        pResponse->Header.MessageType == PHONGTHAN_MSG_SESSION_ENTER_WORLD &&
        pResponse->Header.Flags == PHONGTHAN_WIRE_FLAG_RESPONSE &&
        pResponse->Header.PacketSize == sizeof(*pResponse)) {
        if (strcmp((const char *) pResponse->RoleName, m_Choices.szProcessingRoleName) == 0) {
            g_NetConnectAgent.UpdateClientRequestTime(true);

            // ??????GameSvr????????
            FILE *fLoginDiag = fopen("login_connect_diag.log", "a+b");
            if (fLoginDiag) {
                const unsigned char *pLoginIp =
                        (const unsigned char *)&pResponse->ServerAddressV4;
                fprintf(fLoginDiag, "role=%s expected=%s permit=%d ip_uint=%u ip=%u.%u.%u.%u port=%u\r\n",
                    pResponse->RoleName, m_Choices.szProcessingRoleName, (int)pResponse->Permit,
                    (unsigned int)pResponse->ServerAddressV4, (unsigned int)pLoginIp[0], (unsigned int)pLoginIp[1],
                    (unsigned int)pLoginIp[2], (unsigned int)pLoginIp[3], (unsigned int)pResponse->ServerPort);
                fclose(fLoginDiag);
            }
            if (pResponse->Permit && g_NetConnectAgent.ConnectToGameSvr(
                    (const unsigned char *) &pResponse->ServerAddressV4,
                    pResponse->ServerPort, pResponse->SessionTicket)) {
                m_Status = LL_S_ENTERING_GAME;
                m_Result = LL_R_NOTHING;
            } else {
                ReturnToIdle();
                m_Result = LL_R_CONNECT_FAILED;
            }

            // ????????????????
            g_NetConnectAgent.DisconnectClient();
        } else {
            ReturnToIdle();
            m_Result = LL_R_SERVER_SHUTDOWN;
        }
    }
}

//--------------------------------------------------------------------------
//	??????????????????
//--------------------------------------------------------------------------
void KLogin::AcceptNetMsg(void *pMsgData) {
    if (pMsgData == NULL)
        return;

    PHONGTHAN_WIRE_HEADER *pHeader = (PHONGTHAN_WIRE_HEADER *)pMsgData;
    if (pHeader->Magic == PHONGTHAN_WIRE_MAGIC) {
        if (pHeader->MessageType == PHONGTHAN_MSG_SESSION_AUTHENTICATE &&
            pHeader->Flags == PHONGTHAN_WIRE_FLAG_RESPONSE &&
            pHeader->PacketSize == sizeof(PHONGTHAN_SESSION_AUTHENTICATE_RESPONSE) &&
            m_Status == LL_S_ACCOUNT_CONFIRMING) {
            ProcessAccountLoginResponse(
                    (PHONGTHAN_SESSION_AUTHENTICATE_RESPONSE *)pMsgData);
        } else if (pHeader->MessageType == PHONGTHAN_MSG_SESSION_CREATE_CHARACTER &&
            pHeader->Flags == PHONGTHAN_WIRE_FLAG_RESPONSE &&
            pHeader->PacketSize == sizeof(PHONGTHAN_SESSION_CREATE_CHARACTER_RESPONSE) &&
            m_Status == LL_S_CREATING_ROLE) {
            ProcessCreateRoleResponse(
                    (PHONGTHAN_SESSION_CREATE_CHARACTER_RESPONSE *)pMsgData);
        } else if (pHeader->MessageType == PHONGTHAN_MSG_SESSION_DELETE_CHARACTER &&
            pHeader->Flags == PHONGTHAN_WIRE_FLAG_RESPONSE &&
            pHeader->PacketSize == sizeof(PHONGTHAN_SESSION_DELETE_CHARACTER_RESPONSE) &&
            m_Status == LL_S_DELETING_ROLE) {
            ProcessDeleteRoleResponse(
                    (PHONGTHAN_SESSION_DELETE_CHARACTER_RESPONSE *)pMsgData);
        } else if (pHeader->MessageType == PHONGTHAN_MSG_SESSION_CHARACTER_LIST &&
            pHeader->Flags == PHONGTHAN_WIRE_FLAG_RESPONSE &&
            pHeader->PacketSize == sizeof(PHONGTHAN_SESSION_CHARACTER_LIST_RESPONSE) &&
            m_Status == LL_S_WAIT_ROLE_LIST) {
            ProcessRoleListResponse(
                    (PHONGTHAN_SESSION_CHARACTER_LIST_RESPONSE *)pMsgData);
        } else if (pHeader->MessageType == PHONGTHAN_MSG_SESSION_ENTER_WORLD &&
            pHeader->PacketSize == sizeof(PHONGTHAN_SESSION_ENTER_WORLD_RESPONSE) &&
            m_Status == LL_S_WAIT_TO_LOGIN_GAMESERVER) {
            ProcessToLoginGameServResponse(
                    (PHONGTHAN_SESSION_ENTER_WORLD_RESPONSE *)pMsgData);
        }
        return;
    }

    switch (m_Status) {
    }
}

//??????????????????
LOGIN_LOGIC_RESULT_INFO KLogin::GetResult() {
    LOGIN_LOGIC_RESULT_INFO eReturn = m_Result;
    m_Result = LL_R_NOTHING;
    return eReturn;
}


//??????????????
int KLogin::GetRoleCount(int &nAdviceChoice) {
    nAdviceChoice = 0;
    if (m_Choices.szProcessingRoleName[0]) {
        for (int i = 0; i < m_nNumRole; i++) {
            if (strcmp(m_Choices.szProcessingRoleName, m_RoleList[i].Name) == 0) {
                nAdviceChoice = i;
                break;
            }
        }
    }
    return m_nNumRole;
}

//--------------------------------------------------------------------------
//	??????????????????????????????
//--------------------------------------------------------------------------
bool KLogin::GetLoginAccount(char *pszAccount) {
    if (pszAccount)
        GetAccountPassword(pszAccount, NULL);
    return m_Choices.bRememberAccount;
}

bool KLogin::GetLoginVirtualKeyboard() {
    return m_Choices.bVirtualKeyboard;
}


#define    $LOGIN                    "Login"
#define    $LAST_ACCOUNT            "LastAccount"
#define    $LAST_PASSWORD            "LastPassword"

//--------------------------------------------------------------------------
//	??????????????????????????
//--------------------------------------------------------------------------
void KLogin::LoadLoginChoice() {
    if (m_Choices.bLoaded)
        return;
    memset(&m_Choices, 0, sizeof(m_Choices));
    ClearAccountPassword(true, true);

    m_Choices.bLoaded = true;

    KIniFile *pSetting = g_UiBase.GetCommSettingFile();
    char szAccount[32];
    KSG_PASSWORD Password;
    if (pSetting) {
        int nValue;
        pSetting->GetString($LOGIN, "LastRegionName", "", m_Choices.RegionName, sizeof(m_Choices.RegionName));
        pSetting->GetString($LOGIN, "LastGameServer", "", m_Choices.AccountServer.Title,
                            sizeof(m_Choices.AccountServer.Title));
        pSetting->GetInteger($LOGIN, "VirtualKeyboard", 0, &nValue);
        pSetting->GetInteger($LOGIN, "LastInvisible", 0, &m_Choices.nLastInvisible);
        m_Choices.bVirtualKeyboard = nValue > 0;

        szAccount[0] = 0;
        pSetting->GetStruct($LOGIN, $LAST_ACCOUNT, szAccount, sizeof(szAccount));
        if (szAccount[0]) {
            EDOneTimePad_Decipher(szAccount, strlen(szAccount));
            m_Choices.bRememberAccount = true;
            SetAccountPassword(szAccount, NULL);

            Password.szPassword[0] = '\0';
            pSetting->GetStruct($LOGIN, $LAST_PASSWORD, Password.szPassword, sizeof(Password.szPassword));
            if (Password.szPassword[0]) {
                EDOneTimePad_Decipher(Password.szPassword, strlen(Password.szPassword));
                m_Choices.bRememberAll = true;
                SetAccountPassword(NULL, &Password);
                memset(&Password, 0, sizeof(Password));
            }
        }

        if (szAccount[0]) {
            KIniFile *pPrivate = g_UiBase.GetPrivateSettingFile();
            if (pPrivate) {
                if (pPrivate->GetString("Main", "LastSelCharacter", "",
                                        m_Choices.szProcessingRoleName, sizeof(m_Choices.szProcessingRoleName))) {
                    EDOneTimePad_Decipher(m_Choices.szProcessingRoleName, strlen(m_Choices.szProcessingRoleName));
                }
            }
            g_UiBase.ClosePrivateSettingFile(false);
        }

        g_UiBase.CloseCommSettingFile(false);
    }

    char szAutoLogin[8] = {0};
    int nHasAutoLoginEnv = GetEnvironmentVariable("PHONGTHAN_AUTO_LOGIN", szAutoLogin, sizeof(szAutoLogin));
    FILE *pAutoLog = fopen("client_autologin_diag.log", "a+t");
    if (pAutoLog) {
        fprintf(pAutoLog, "env=%d value=%s enabled=%d account=%02X password=%02X server=%s\n",
                nHasAutoLoginEnv, szAutoLogin, IsAutoLoginEnable(),
                (unsigned char)m_Choices.Account[0],
                (unsigned char)m_Choices.Password.szPassword[0],
                m_Choices.AccountServer.Title);
        fclose(pAutoLog);
    }
    if (nHasAutoLoginEnv && szAutoLogin[0] == '1' && IsAutoLoginEnable()) {
        AutoLogin();
    }
}

//--------------------------------------------------------------------------
//	??????????????????????
//--------------------------------------------------------------------------
void KLogin::SaveLoginChoice() {

    KIniFile *pSetting = g_UiBase.GetCommSettingFile();
    int i;
    if (pSetting) {
        if (m_Choices.RegionName[0]) {
            pSetting->WriteString($LOGIN, "LastRegionName", m_Choices.RegionName);
        }
        if (m_Choices.AccountServer.Title[0]) {
            pSetting->WriteString($LOGIN, "LastGameServer", m_Choices.AccountServer.Title);
        }
        pSetting->WriteInteger($LOGIN, "VirtualKeyboard", m_Choices.bVirtualKeyboard);
        pSetting->GetInteger($LOGIN, "LastInvisible", 0, &m_Choices.nLastInvisible);

        char szBuffer[32];
        //----????????????????????----
        pSetting->EraseKey($LOGIN, $LAST_ACCOUNT);

        if (m_Choices.bRememberAccount) {
            GetAccountPassword(szBuffer, NULL);
            i = strlen(szBuffer);
            EDOneTimePad_Encipher(szBuffer, i);
            pSetting->WriteStruct($LOGIN, $LAST_ACCOUNT, szBuffer, sizeof(szBuffer));
            int j = 0, k = 0;
            char szKeyName[32], szAccountName[32], szSaveBuffer[$MAX_ACCOUNT_LIST][32];
            szAccountName[0] = 0;
            memset(szSaveBuffer, 0, sizeof(szSaveBuffer));
            pSetting->GetStruct($ACCOUNT_LIST, $RECENT_FIRST_ACCOUNT, szAccountName, sizeof(szAccountName));
            if (strcmp(szAccountName, szBuffer) != 0) {
                for (j = 1; j < $MAX_ACCOUNT_LIST; j++) {
                    sprintf(szKeyName, $RECENT_ACCOUNT, j);
                    pSetting->GetStruct($ACCOUNT_LIST, szKeyName, szAccountName, sizeof(szAccountName));
                    if (strcmp(szAccountName, szBuffer) == 0) {
                        memset(szAccountName, 0, sizeof(szAccountName));
                        pSetting->WriteStruct($ACCOUNT_LIST, szKeyName, szAccountName, sizeof(szAccountName));
                    }
                }
                for (j = 0; j < $MAX_ACCOUNT_LIST; j++) {
                    sprintf(szKeyName, $RECENT_ACCOUNT, j);
                    pSetting->GetStruct($ACCOUNT_LIST, szKeyName, szSaveBuffer[j], sizeof(szSaveBuffer[j]));
                }
                pSetting->WriteStruct($ACCOUNT_LIST, $RECENT_FIRST_ACCOUNT, szBuffer, sizeof(szBuffer));
                for (j = 1; j < $MAX_ACCOUNT_LIST; j++) {
                    sprintf(szKeyName, $RECENT_ACCOUNT, j);
                    while (k < $MAX_ACCOUNT_LIST) {
                        if (szSaveBuffer[k]) {
                            pSetting->WriteStruct($ACCOUNT_LIST, szKeyName, szSaveBuffer[k], sizeof(szSaveBuffer[k]));
                            k++;
                            break;
                        }
                        k++;
                    }
                }
            }
            if (m_Choices.bRememberAll) {
                KSG_PASSWORD Password;
                GetAccountPassword(NULL, &Password);
                i = strlen(Password.szPassword);
                EDOneTimePad_Encipher(Password.szPassword, i);
                pSetting->WriteStruct($LOGIN, $LAST_PASSWORD, Password.szPassword, sizeof(Password.szPassword));
            }

            KIniFile *pPrivate = g_UiBase.GetPrivateSettingFile();
            if (pPrivate) {
                if (m_Choices.szProcessingRoleName[0]) {
                    i = strlen(m_Choices.szProcessingRoleName);
                    memcpy(szBuffer, m_Choices.szProcessingRoleName, i);
                    szBuffer[i] = 0;
                    EDOneTimePad_Encipher(szBuffer, i);
                    //pPrivate->WriteString("Main", "LastSelCharacter", szBuffer);
                    pPrivate->WriteString("Main", "LastSelCharacter", m_Choices.szProcessingRoleName);
                }
                g_UiBase.ClosePrivateSettingFile(true);
            }
        }

        g_UiBase.CloseCommSettingFile(true);
    }
}


void KLogin::GetRegionServer(char *pszRegion, char *pszServer) {
    strcpy(pszRegion, m_Choices.RegionName);
    strcpy(pszServer, m_Choices.AccountServer.Title);
}

//--------------------------------------------------------------------------
//	??????????????????????????
//--------------------------------------------------------------------------
KLoginServer *KLogin::GetServerRegionList(int &nCount, int &nAdviceChoice) {
    KLoginServer *pServers = NULL;
    nCount = 0;
    nAdviceChoice = 0;

    KIniFile File;
    int i;
    if (File.Load(SERVER_LIST_FILE)) {
        int nReadCount = 0;
        char szKey[32];
        File.GetInteger("List", "RegionCount", 0, &nReadCount);
        if (nReadCount > 0) {
            pServers = (KLoginServer *) malloc(sizeof(KLoginServer) * nReadCount);
            if (pServers) {
                for (i = 0; i < nReadCount; i++) {
                    sprintf(szKey, "Region_%d", i);
                    if (File.GetString("List", szKey, "", pServers[nCount].Title,
                                       sizeof(pServers[nCount].Title)) &&
                        pServers[nCount].Title[0]) {
                        nCount++;
                    }
                }
                if (nCount == 0) {
                    free(pServers);
                    pServers = NULL;
                }
            }
        }
    }
    if (nCount) {
        for (i = 0; i < nCount; i++) {
            if (strcmp(pServers[i].Title, m_Choices.RegionName) == 0) {
                nAdviceChoice = i;
                break;
            }
        }
        strcpy(m_Choices.RegionName, pServers[nAdviceChoice].Title);
    }
    return pServers;
}

//--------------------------------------------------------------------------
//	????????????????????????
//--------------------------------------------------------------------------
KLoginServer *KLogin::GetServerList(int nRegion, int &nCount, int &nAdviceChoice) {
    KLoginServer *pServers = NULL;
    nCount = 0;
    nAdviceChoice = 0;

    KIniFile File;
    int i;
    if (File.Load(SERVER_LIST_FILE)) {
        int nReadCount = 0;
        char szSection[32], szKey[32], szBuffer[32];

        File.GetInteger("List", "RegionCount", 0, &nReadCount);    //??????????

        if (nRegion < 0 || nRegion >= nReadCount) {
            nRegion = 0;
        }
        sprintf(szSection, "Region_%d", nRegion);
        File.GetString("List", szSection, "", m_Choices.RegionName, sizeof(m_Choices.RegionName));
        File.GetInteger(szSection, "Count", 0, &nReadCount);    //??????????????????
        if (nReadCount > 0) {
            pServers = (KLoginServer *) malloc(sizeof(KLoginServer) * nReadCount);
            if (pServers) {
                for (i = 0; i < nReadCount; i++) {
                    sprintf(szKey, "%d_Address", i);
                    if (!File.GetString(szSection, szKey, "", szBuffer, sizeof(szBuffer)) ||
                        GetIpAddress(szBuffer, pServers[nCount].Address) == false) {
                        continue;
                    }
                    sprintf(szKey, "%d_Title", i);
                    if (File.GetString(szSection, szKey, "", pServers[nCount].Title,
                                       sizeof(pServers[nCount].Title)) &&
                        pServers[nCount].Title[0]) {
                        nCount++;
                    }
                }
                if (nCount == 0) {
                    free(pServers);
                    pServers = NULL;
                }
            }
        }
    }

    if (nCount) {
        for (i = 0; i < nCount; i++) {
            if (strcmp(pServers[i].Title, m_Choices.AccountServer.Title) == 0) {
                nAdviceChoice = i;
                break;
            }
        }
        strcpy(m_Choices.AccountServer.Title, pServers[nAdviceChoice].Title);
        m_Choices.AccountServer.Address[0] = pServers[nAdviceChoice].Address[0];
        m_Choices.AccountServer.Address[1] = pServers[nAdviceChoice].Address[1];
        m_Choices.AccountServer.Address[2] = pServers[nAdviceChoice].Address[2];
        m_Choices.AccountServer.Address[3] = pServers[nAdviceChoice].Address[3];
    }
    return pServers;
}

int KLogin::SetAccountServer(const KLoginServer &rcSelectServer) {
    m_Choices.AccountServer = rcSelectServer;
    return true;
}


extern void RandMemSet(int nSize, unsigned char *pbyBuffer);

//--------------------------------------------------------------------------
//	??????????????
//--------------------------------------------------------------------------
int KLogin::Request(const char *pszAccount, const KSG_PASSWORD *pcPassword) {
    if (pszAccount && pcPassword && pszAccount[0] && pcPassword->szPassword[0]) {
        PHONGTHAN_SESSION_AUTHENTICATE_REQUEST Request;
        ZeroMemory(&Request, sizeof(Request));
        PhongThanInitializeWireHeader(&Request.Header,
                PHONGTHAN_MSG_SESSION_AUTHENTICATE, sizeof(Request),
                PHONGTHAN_WIRE_FLAG_REQUEST, 0);
        strncpy((char *)Request.AccountName, pszAccount,
                sizeof(Request.AccountName) - 1);
        strncpy((char *)Request.PasswordProof, pcPassword->szPassword,
                sizeof(Request.PasswordProof) - 1);
        int nSent = g_NetConnectAgent.SendMsg(&Request, sizeof(Request));
        ZeroMemory(Request.PasswordProof, sizeof(Request.PasswordProof));
        if (nSent) {
            g_NetConnectAgent.UpdateClientRequestTime(false);
            return true;
        }
    }
    return false;
}

//--------------------------------------------------------------------------
//	??????????????????
//--------------------------------------------------------------------------
int KLogin::ConnectAccountServer(const unsigned char *pIpAddress) {
    KIniFile IniFile;
    int nPort = 5622;
    if (IniFile.Load("\\Config.ini")) {
        IniFile.GetInteger("Server", "GameServPort", 5622, &nPort);
    }
    FILE* fl = fopen("client_login_trace.log", "a");
    if (fl) {
        if (pIpAddress)
            fprintf(fl, "[Client] ConnectAccountServer to %d.%d.%d.%d:%d\n", pIpAddress[0], pIpAddress[1], pIpAddress[2], pIpAddress[3], nPort);
        else
            fprintf(fl, "[Client] ConnectAccountServer pIpAddress is NULL!\n");
        fclose(fl);
    }
    if (pIpAddress) {
        int nRet = g_NetConnectAgent.ClientConnectByNumericIp(pIpAddress, nPort);
        fl = fopen("client_login_trace.log", "a");
        if (fl) {
            fprintf(fl, "[Client] ClientConnectByNumericIp returned %d\n", nRet);
            fclose(fl);
        }
        return nRet;
    }
    return false;
}

void KLogin::RegistNetAgent() {
    g_NetConnectAgent.RegisterPhongThanSessionTarget(this);
}

void KLogin::UnRegistNetAgent() {
    g_NetConnectAgent.RegisterPhongThanSessionTarget(NULL);
}

void KLogin::SetAccountPassword(const char *pszAccount, const KSG_PASSWORD *pcPassword) {
    int i;
    if (pszAccount) {
        strncpy(m_Choices.Account, pszAccount, sizeof(m_Choices.Account));
        for (i = 0; i < 32; i++)
            m_Choices.Account[i] = ~m_Choices.Account[i];
    }
    if (pcPassword) {
        m_Choices.Password = *pcPassword;
        for (i = 0; i < KSG_PASSWORD_MAX_SIZE; i++)
            m_Choices.Password.szPassword[i] = ~m_Choices.Password.szPassword[i];
    }
}

void KLogin::GetAccountPassword(char *pszAccount, KSG_PASSWORD *pPassword) {
    int i;
    if (pszAccount) {
        memcpy(pszAccount, m_Choices.Account, sizeof(m_Choices.Account));
        for (i = 0; i < 32; i++)
            pszAccount[i] = ~pszAccount[i];
    }
    if (pPassword) {
        *pPassword = m_Choices.Password;
        for (i = 0; i < KSG_PASSWORD_MAX_SIZE; i++)
            pPassword->szPassword[i] = ~pPassword->szPassword[i];
    }
}

int KLogin::GetLoginLastInvisible() {
    return m_Choices.nLastInvisible;
}

