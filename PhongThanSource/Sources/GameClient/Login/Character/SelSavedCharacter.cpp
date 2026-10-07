/*****************************************************************************************
//	´æµµ½ÇÉ«Ñ¡Ôñ
//	Copyright : Kingsoft 2002
//	Author	:   Wooy(Wu yue)
//	CreateTime:	2002-9-12
------------------------------------------------------------------------------------------
*****************************************************************************************/
#include <Winsock2.h>
#include <time.h>
#include <crtdbg.h>
#include "KEngine.h"
#include "SelSavedCharacter.h"
#include "../../Core/Src/CoreShell.h"
#include "../../Core/Src/KNpcRes.h"

#pragma comment (lib, "Ws2_32.lib")

extern iCoreShell *g_pCoreShell;

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
//	¹¦ÄÜ£º¹¹Ôìº¯Êý
//--------------------------------------------------------------------------
KSelSavedCharacter::KSelSavedCharacter() {
    m_AccountName[0] = 0;
    m_szProcessingRoleName[0] = 0;
    m_Status = SSC_S_IDLE;
    m_nNumCharacter = 0;
    m_nRequestTime = 0;
    m_nLastOperResult = SSC_R_NOTHING;
}

KSelSavedCharacter::~KSelSavedCharacter() {
    FreeData();
}

//--------------------------------------------------------------------------
//	¹¦ÄÜ£º¿ªÊ¼ÔØÈë½ÇÉ«Êý¾Ý
//--------------------------------------------------------------------------
int KSelSavedCharacter::LoadData() {
    if (m_Status != SSC_S_IDLE)
        return false;
    g_NetConnectAgent.UpdateClientRequestTime(false);
    m_Status = SSC_S_LOADING_DATA;
    return true;
}

//--------------------------------------------------------------------------
//	¹¦ÄÜ£º·µ»ØÖµÎªÃ·¾ÙSSC_STATUSµÄÈ¡ÖµÖ®Ò»£¬·µ»ØÖµº¬ÒåÇë¿´Ïà¹ØµÄÖµÉùÃ÷
//--------------------------------------------------------------------------
int KSelSavedCharacter::GetStatus() {
    return ((int) m_Status);
}

//--------------------------------------------------------------------------
//	¹¦ÄÜ£ºÉèÖÃ×îºóÒ»´Î²Ù×÷µÄ·µ»Ø½á¹û
//--------------------------------------------------------------------------
void KSelSavedCharacter::SetLastActionResult(int nResult) {
    m_nLastOperResult = nResult;
}

//--------------------------------------------------------------------------
//	¹¦ÄÜ£ºµÃµ½×îºóÒ»´Î²Ù×÷µÄ·µ»Ø½á¹û
//--------------------------------------------------------------------------
int KSelSavedCharacter::GetLastActionResult() {
    int nRet = m_nLastOperResult;
    m_nLastOperResult = SSC_R_NOTHING;
    return nRet;
}

//--------------------------------------------------------------------------
//	¹¦ÄÜ£º»ñÈ¡½ÇÉ«µÄÊýÄ¿
//--------------------------------------------------------------------------
int KSelSavedCharacter::GetCharacterNum() {
    return m_nNumCharacter;
}

//--------------------------------------------------------------------------
//	¹¦ÄÜ£º»ñÈ¡Ä³¸ö½ÇÉ«µÄÐÅÏ¢
//--------------------------------------------------------------------------
int KSelSavedCharacter::GetCharacterInfo(int nIndex, KNewCharacterInfo *pInfo) {
    if (nIndex >= 0 && nIndex < m_nNumCharacter) {
        if (pInfo) {
            strcpy(pInfo->Name, m_BaseInfo[nIndex].szName);
            pInfo->Gender = m_BaseInfo[nIndex].Gender;
            pInfo->Profession = m_BaseInfo[nIndex].Profession;
            pInfo->nLevel = m_BaseInfo[nIndex].Level;
        }
        return true;
    }
    return false;
}

//--------------------------------------------------------------------------
//	¹¦ÄÜ£ºÇëÇóÐÂ½¨Ò»¸ö½ÇÉ«
//--------------------------------------------------------------------------
int KSelSavedCharacter::NewCharacter(KNewCharacterInfo *pData) {
    if (!pData)
        return false;
    if (pData->Gender >= ROLE_NO || pData->Profession >= PHONGTHAN_PROFESSION_COUNT)
        return false;
    int nNameLen = strlen(pData->Name);
    if (nNameLen < 1)
        return false;

    char Data[sizeof(TProcessData) + sizeof(NEW_PLAYER_COMMAND)];
    TProcessData *pNetCommand = (TProcessData *) &Data;
    NEW_PLAYER_COMMAND *pInfo = (NEW_PLAYER_COMMAND *) pNetCommand->pDataBuffer;
    pInfo->m_btGender = pData->Gender;
    pInfo->m_btProfession = pData->Profession;
    pInfo->m_NativePlaceId = pData->NativePlaceId;
    memcpy(pInfo->m_szName, pData->Name, nNameLen);
    pInfo->m_szName[nNameLen] = '\0';

    strcpy(m_szProcessingRoleName, pData->Name);

    pNetCommand->nProtoId = c2s_newplayer;
    pNetCommand->nDataLen = sizeof(NEW_PLAYER_COMMAND) - sizeof(pInfo->m_szName) + nNameLen + 1/* sizeof( '\0' ) */;
    pNetCommand->ulIdentity = 0;

    g_NetConnectAgent.SendMsg(&Data, sizeof(TProcessData) - sizeof(pNetCommand->pDataBuffer) + pNetCommand->nDataLen);
    g_NetConnectAgent.UpdateClientRequestTime(false);

    m_Status = SSC_S_CREATING_CHARACTER;
    m_nLastOperResult = SSC_R_NOTHING;
    return true;
}

//--------------------------------------------------------------------------
//	¹¦ÄÜ£ºÇëÇóÉ¾³ýÒ»¸ö½ÇÉ«
//--------------------------------------------------------------------------
int KSelSavedCharacter::DeleteCharacter(int nIndex, const char *pszPassword) {
    if (m_Status != SSC_S_STANDBY || nIndex < 0 || nIndex >= m_nNumCharacter || pszPassword == NULL)
        return false;

    tagDBDelPlayer NetCommand;

    RandMemSet(sizeof(tagDBDelPlayer), (BYTE * ) & NetCommand);    // random memory for make a cipher

    NetCommand.cProtocol = c2s_roleserver_deleteplayer;
    strcpy(NetCommand.szAccountName, m_AccountName);
    strcpy(NetCommand.szPassword, pszPassword);
    strncpy(NetCommand.szRoleName, m_BaseInfo[nIndex].szName, sizeof(NetCommand.szRoleName));
    g_NetConnectAgent.SendMsg(&NetCommand, sizeof(tagDBDelPlayer));
    memset(&NetCommand.szPassword, 0, sizeof(NetCommand.szPassword));
    g_NetConnectAgent.UpdateClientRequestTime(false);
    strcpy(m_szProcessingRoleName, m_BaseInfo[nIndex].szName);

    m_Status = SSC_S_DELETING_CHARACTER;
    m_nLastOperResult = SSC_R_NOTHING;
    return true;
}

//--------------------------------------------------------------------------
//	¹¦ÄÜ£ºÑ¡ÔñÄ³¸ö½ÇÉ«
//--------------------------------------------------------------------------
int KSelSavedCharacter::SelCharacter(int nIndex) {
    if (m_Status != SSC_S_STANDBY || nIndex < 0 || nIndex >= m_nNumCharacter)
        return false;

    PHONGTHAN_SESSION_SELECT_CHARACTER_REQUEST NetCommand;
    ZeroMemory(&NetCommand, sizeof(NetCommand));
    PhongThanInitializeWireHeader(&NetCommand.Header,
            PHONGTHAN_MSG_SESSION_SELECT_CHARACTER, sizeof(NetCommand),
            PHONGTHAN_WIRE_FLAG_REQUEST, 0);
    strncpy((char *)NetCommand.RoleName, m_BaseInfo[nIndex].szName,
            sizeof(NetCommand.RoleName) - 1);
    g_NetConnectAgent.SendMsg(&NetCommand, sizeof(NetCommand));
    g_NetConnectAgent.UpdateClientRequestTime(false);
    strcpy(m_szProcessingRoleName, m_BaseInfo[nIndex].szName);
    m_Status = SSC_S_LOADING_CHARACTER;
    m_nLastOperResult = SSC_R_NOTHING;
    return true;
}

//--------------------------------------------------------------------------
//	¹¦ÄÜ£ºÊÍ·Å½ÇÉ«Êý¾Ý
//--------------------------------------------------------------------------
void KSelSavedCharacter::FreeData() {
    m_Status = SSC_S_IDLE;
    m_nNumCharacter = 0;
    m_nRequestTime = 0;
    m_nLastOperResult = SSC_R_NOTHING;
}

void KSelSavedCharacter::SetCharacterBaseInfo(int nNum, const RoleBaseInfo *pInfo) {
    if (nNum > MAX_PLAYER_PER_ACCOUNT)
        nNum = MAX_PLAYER_PER_ACCOUNT;

    m_nNumCharacter = 0;
    for (int i = 0; i < nNum; i++) {
        if (pInfo[i].szName[0])
            m_nNumCharacter++;
        else
            break;
    }

    if (m_nNumCharacter > 0)
        memcpy(m_BaseInfo, pInfo, sizeof(RoleBaseInfo) * m_nNumCharacter);
    m_Status = SSC_S_STANDBY;
    m_nLastOperResult = SSC_R_UPDATE;
}

// -------------------------------------------------------------------------
// º¯Êý		: KUiSelPlayer::AcceptNetMsg
// ¹¦ÄÜ		: ´¦ÀíÍøÂçÏûÏ¢
// -------------------------------------------------------------------------
void KSelSavedCharacter::AcceptNetMsg(void *pMsgData) {
    if (!pMsgData)
        return;
    PHONGTHAN_WIRE_HEADER *pHeader = (PHONGTHAN_WIRE_HEADER *)pMsgData;
    if (pHeader->Magic == PHONGTHAN_WIRE_MAGIC) {
        if (m_Status == SSC_S_LOADING_CHARACTER &&
            pHeader->MessageType == PHONGTHAN_MSG_SESSION_ENTER_WORLD &&
            pHeader->Flags == PHONGTHAN_WIRE_FLAG_RESPONSE &&
            pHeader->PacketSize == sizeof(PHONGTHAN_SESSION_ENTER_WORLD_RESPONSE)) {
            PHONGTHAN_SESSION_ENTER_WORLD_RESPONSE *pResponse =
                    (PHONGTHAN_SESSION_ENTER_WORLD_RESPONSE *)pMsgData;
            if (pResponse->Permit &&
                strcmp((const char *)pResponse->RoleName,
                       m_szProcessingRoleName) == 0 &&
                g_NetConnectAgent.ConnectToGameSvr(
                        (const unsigned char *)&pResponse->ServerAddressV4,
                        pResponse->ServerPort, pResponse->SessionTicket)) {
                g_NetConnectAgent.UpdateClientRequestTime(false);
                m_nLastOperResult = SSC_R_IN_PROGRESS;
            } else {
                m_nLastOperResult = SSC_R_SVR_DOWN;
                m_Status = SSC_S_STANDBY;
            }
            g_NetConnectAgent.DisconnectClient();
            g_NetConnectAgent.UpdateClientRequestTime(true);
        }
        return;
    }
    if (m_Status != SSC_S_STANDBY && m_Status != SSC_S_IDLE) {
        PROTOCOL_MSG_TYPE eProtoId = *(PROTOCOL_MSG_TYPE *) pMsgData;
        switch (eProtoId) {
            case s2c_roleserver_getrolelist_result:
                if (m_Status == SSC_S_LOADING_DATA) {
                    TProcessData *pProtocol = (TProcessData *) pMsgData;
                    SetCharacterBaseInfo(pProtocol->pDataBuffer[0], (RoleBaseInfo *) &pProtocol->pDataBuffer[1]);
                    g_NetConnectAgent.UpdateClientRequestTime(true);
                }
                break;
            case s2c_rolenewdelresponse:
                tagNewDelRoleResponse *pResponse = (tagNewDelRoleResponse *) pMsgData;
//			if (strcmp(pResponse->szRoleName, m_szProcessingRoleName) == 0)	/* ÁõÅôµ÷ÊÔ°æ */
                {
                    if (m_Status == SSC_S_CREATING_CHARACTER) {
                        if (pResponse->bSucceeded) {
                            g_NetConnectAgent.UpdateClientRequestTime(false);
                            m_nLastOperResult = SSC_R_CREATE_ROLE_SUCCEED;
                            m_Status = SSC_S_LOADING_CHARACTER;
                        } else {
                            g_NetConnectAgent.UpdateClientRequestTime(true);
                            m_nLastOperResult = SSC_R_INVALID_ROLENAME;
                            m_Status = SSC_S_STANDBY;
                        }
                    } else if (m_Status == SSC_S_DELETING_CHARACTER) {
                        g_NetConnectAgent.UpdateClientRequestTime(true);
                        if (pResponse->bSucceeded) {
                            m_nLastOperResult = SSC_R_UPDATE;

                            for (int i = 0; i < m_nNumCharacter; i++) {
                                if (strcmp(m_BaseInfo[i].szName, m_szProcessingRoleName) == 0) {
                                    m_nNumCharacter--;
                                    for (; i < m_nNumCharacter; i++)
                                        m_BaseInfo[i] = m_BaseInfo[i + 1];
                                    break;
                                }
                            }
                        } else {
                            m_nLastOperResult = SSC_R_FAILED;
                        }
                        m_Status = SSC_S_STANDBY;
                    }
                }
                break;
        }
    }
}

void KSelSavedCharacter::SetAccountName(const char *pAccount) {
    if (pAccount)
        strcpy(m_AccountName, pAccount);
}
