/*****************************************************************************************
//	????????????????????????????????????????????
//	Copyright : Kingsoft 2002
//	Author	:   Wooy(Wu yue)
//	CreateTime:	2002-10-6
------------------------------------------------------------------------------------------
*****************************************************************************************/
#include "KWin32.h"
#ifdef PHONGTHAN_MODERN_BUILD
#include <winsock2.h>
#endif
#include <objbase.h>
#include <initguid.h>
#include "KEngine.h"
#include "NetConnectAgent.h"
#include "NetMsgTargetObject.h"
#include "../Ui/Elem/Wnds.h"
#include "../Ui/UiCase/UiSysMsgCentre.h"
#include "../Ui/UiShell.h"
#include "../../Core/Src/CoreShell.h"
#include "../../../Headers/KProtocolDef.h"
#include "../../../Headers/PhongThanProtocol.h"
#include "../../Core/Src/ItemActionDiag.h"
#include "crtdbg.h"

#define    NETCONNECT_MODULE            "Rainbow.dll"

extern int g_bDisconnect;


void __stdcall ClientCallBack(LPVOID lpParam, const unsigned long &ulnEventType);

extern iCoreShell *g_pCoreShell;
KNetConnectAgent g_NetConnectAgent;
#ifdef _DEBUG
static int g_snBugLog;
#endif

//--------------------------------------------------------------------------
//	??????????????
//--------------------------------------------------------------------------
KNetConnectAgent::KNetConnectAgent() {
    memset(&m_MsgTargetObjs, 0, sizeof(m_MsgTargetObjs));
    m_pClient = NULL;
    m_pGameSvrClient = NULL;
    m_pPhongThanSessionTarget = NULL;
    m_hModule = NULL;
    m_bIsClientConnecting = false;
    m_bTobeDisconnect = false;
    m_uClientRequestTime = 0;

    m_pFactroyFun = NULL;
    m_pClientFactory = NULL;

}

//--------------------------------------------------------------------------
//	??????????????
//--------------------------------------------------------------------------
KNetConnectAgent::~KNetConnectAgent() {
    Exit();
}

//--------------------------------------------------------------------------
//	????????????
//--------------------------------------------------------------------------
int KNetConnectAgent::Initialize() {
    m_hModule = ::LoadLibrary(NETCONNECT_MODULE);

    if (m_hModule) {
        m_pFactroyFun = (pfnCreateClientInterface) GetProcAddress(m_hModule, "CreateInterface");
        if (m_pFactroyFun) {
            if (SUCCEEDED(m_pFactroyFun(IID_IClientFactory, reinterpret_cast< void ** >( &m_pClientFactory)))) {
                m_pClientFactory->SetEnvironment(1024 * 512);
            }
        }
    }

    if (!m_pFactroyFun || !m_pClientFactory)
        return false;

    m_bIsClientConnecting = false;
    return true;
}

//--------------------------------------------------------------------------
//	??????????
//--------------------------------------------------------------------------
void KNetConnectAgent::Exit() {
    memset(&m_MsgTargetObjs, 0, sizeof(m_MsgTargetObjs));
    m_pPhongThanSessionTarget = NULL;

    DisconnectClient();
    DisconnectGameSvr();

    if (m_pClientFactory) {
        m_pClientFactory->Release();
        m_pClientFactory = NULL;
    }

    m_pFactroyFun = NULL;

    if (m_hModule) {
        ::FreeLibrary(m_hModule);
        m_hModule = NULL;
    }
}

//--------------------------------------------------------------------------
//	??????????????
//--------------------------------------------------------------------------
int KNetConnectAgent::ClientConnectByNumericIp(const unsigned char *pIpAddress, unsigned short nPort) {
    DisconnectClient();

    if (!pIpAddress || !nPort)
        return false;

    if (!m_pClientFactory)
        return false;

    m_pClientFactory->CreateClientInterface(IID_IESClient, reinterpret_cast< void ** >(&m_pClient));

    if (!m_pClient)
        return false;

    if (FAILED(m_pClient->Startup()))
        return false;

    m_pClient->RegisterMsgFilter((void *) false, ClientCallBack);

    m_bIsClientConnecting = false;

    char Address[128];
    sprintf(Address, "%d.%d.%d.%d", pIpAddress[0], pIpAddress[1],
            pIpAddress[2], pIpAddress[3]);

    HRESULT hr = m_pClient->ConnectTo(Address, nPort);
    FILE* fl = fopen("client_login_trace.log", "a");
    if (fl) {
        fprintf(fl, "[ClientNet] ConnectTo(%s, %u) result = 0x%08X (SUCCEEDED=%d)\n", Address, nPort, hr, SUCCEEDED(hr));
        fclose(fl);
    }
    if (SUCCEEDED(hr)) {
        g_DebugLog("[Gateway] connectted.");
        m_bIsClientConnecting = true;
        return true;
    }

    return false;
}

//--------------------------------------------------------------------------
//	??????????????
//--------------------------------------------------------------------------
void KNetConnectAgent::DisconnectClient() {
    if (m_bIsGameServConnecting == false)
        m_uClientRequestTime = 0;

    if (m_pClient && m_bIsClientConnecting) {
        g_DebugLog("[Gateway] connection closed.");
        m_bIsClientConnecting = false;
        m_pClient->Shutdown();
    }

    if (m_pClient) {
        m_pClient->Cleanup();
        m_pClient->Release();
        m_pClient = NULL;
    }

}

int KNetConnectAgent::ConnectToGameSvr(const unsigned char *pIpAddress,
                                       unsigned short uPort,
                                       const PHONGTHAN_U8 *pSessionTicket) {

    DisconnectGameSvr();
    if (pSessionTicket == NULL)
        return false;

    if (!m_pClientFactory)
        return false;

    m_pClientFactory->CreateClientInterface(IID_IESClient, reinterpret_cast< void ** >(&m_pGameSvrClient));

    if (!m_pGameSvrClient)
        return false;

    if (FAILED(m_pGameSvrClient->Startup()))
        return false;

    m_pGameSvrClient->RegisterMsgFilter((void *) true, ClientCallBack);


    char Address[128];
    sprintf(Address, "%d.%d.%d.%d", pIpAddress[0], pIpAddress[1],
            pIpAddress[2], pIpAddress[3]);

    if (FAILED(m_pGameSvrClient->ConnectTo(Address, uPort)))
        return false;

    m_bIsGameServConnecting = true;
    PHONGTHAN_SESSION_ENTER_WORLD_REQUEST Request;
    ZeroMemory(&Request, sizeof(Request));
    PhongThanInitializeWireHeader(&Request.Header,
            PHONGTHAN_MSG_SESSION_ENTER_WORLD, sizeof(Request),
            PHONGTHAN_WIRE_FLAG_REQUEST, 0);
    memcpy(Request.SessionTicket, pSessionTicket,
           PHONGTHAN_SESSION_TICKET_SIZE);

    /////////
    char szServerName[60] = "";
    unsigned long stServerNameLen = 60;
    GetComputerName(szServerName, &stServerNameLen);

    char szHostName[255];
    gethostname(szHostName, 255);
    struct hostent *host_entry;
    host_entry = gethostbyname(szHostName);
    if (host_entry != NULL) {
        char *szLocalIP;
        szLocalIP = inet_ntoa(*(struct in_addr *) *host_entry->h_addr_list);
        _snprintf((char *)Request.ClientName, PHONGTHAN_CLIENT_NAME_SIZE - 1,
                "%s %s", szServerName, szLocalIP);
    } else {
        _snprintf((char *)Request.ClientName, PHONGTHAN_CLIENT_NAME_SIZE - 1,
                "%s", szServerName);
    }
    Request.ClientName[PHONGTHAN_CLIENT_NAME_SIZE - 1] = 0;
    /////////

    strncpy(m_szNameConnect, (const char *)Request.ClientName,
            sizeof(m_szNameConnect) - 1);
    m_szNameConnect[sizeof(m_szNameConnect) - 1] = 0;

    if (FAILED(m_pGameSvrClient->SendPackToServer(&Request, sizeof(Request))))
        return false;

    if (g_pCoreShell)
        g_pCoreShell->SetClient(m_pGameSvrClient);

    return true;
}

void KNetConnectAgent::DisconnectGameSvr() {
    if (m_bIsClientConnecting == false)
        m_uClientRequestTime = 0;

    if (m_pGameSvrClient && m_bIsGameServConnecting) {
        if (g_pCoreShell)
            g_pCoreShell->SetClient(NULL);

        m_bIsGameServConnecting = false;
        m_pGameSvrClient->Shutdown();
    }

    if (m_pGameSvrClient) {
        m_pGameSvrClient->Cleanup();
        m_pGameSvrClient->Release();
        m_pGameSvrClient = NULL;
    }

}

//--------------------------------------------------------------------------
//	??????????????
//--------------------------------------------------------------------------
int KNetConnectAgent::SendMsg(const void *pBuffer, int nSize) {
    if (m_pClient) {
        m_pClient->SendPackToServer((BYTE *) pBuffer, nSize);
        return true;
    }
    return false;
}

//--------------------------------------------------------------------------
//	????????????????
//--------------------------------------------------------------------------
void KNetConnectAgent::Breathe() {
    //----????????----
    if (m_uClientRequestTime &&
        GetTickCount() - m_uClientRequestTime >= m_uClientTimeoutLimit) {
        g_bDisconnect = true;
        m_bTobeDisconnect = true;
    }

    //----????????----
    if (m_bTobeDisconnect) {
        m_bTobeDisconnect = false;
//		m_bIsClientConnecting = false;//to be check
//		m_bIsGameServConnecting = false;
        DisconnectClient();
        DisconnectGameSvr();
        return;
    }

    unsigned int nSize;
    const char *pBuffer = NULL;

    //----??????????????????----
    if (m_bIsClientConnecting) {
        while (true) {
            if (!m_pClient)
                break;

            pBuffer = (const char *) m_pClient->GetPackFromServer(nSize);
            if (!(pBuffer && nSize >= PROTOCOL_MSG_SIZE))
                break;

            if (nSize >= sizeof(PHONGTHAN_WIRE_HEADER)) {
                PHONGTHAN_WIRE_HEADER Header;
                memcpy(&Header, pBuffer, sizeof(Header));
                if (Header.Magic == PHONGTHAN_WIRE_MAGIC) {
                    if (PhongThanValidateWireHeader(&Header, nSize) &&
                        Header.PacketSize == nSize && m_pPhongThanSessionTarget) {
                        m_pPhongThanSessionTarget->AcceptNetMsg((void *)pBuffer);
                    }
                    continue;
                }
            }

            PROTOCOL_MSG_TYPE *pMsg = (PROTOCOL_MSG_TYPE *) pBuffer;
            PROTOCOL_MSG_TYPE Msg = *pMsg;

            if (Msg <= s2c_multiserverbegin || Msg >= s2c_end)
                continue;

            if (m_MsgTargetObjs[Msg])
                (m_MsgTargetObjs[Msg])->AcceptNetMsg(pMsg);
        }
    }
    //----????????????????????????----
    if (m_bIsGameServConnecting && m_pGameSvrClient) {
        //////
        //	if ((nGameCounter % 8) == 0)
        //	{

        char szNameConnect[64] = "";
        char szServerName[60] = "";
        unsigned long stServerNameLen = 60;
        GetComputerName(szServerName, &stServerNameLen);
        char szHostName[255];
        gethostname(szHostName, 255);
        struct hostent *host_entry;
        host_entry = gethostbyname(szHostName);
        if (host_entry != NULL) {
            char *szLocalIP;
            szLocalIP = inet_ntoa(*(struct in_addr *) *host_entry->h_addr_list);
            sprintf(szNameConnect, "%s %s", szServerName, szLocalIP);
        } else {
            sprintf(szNameConnect, "%s", szServerName);
        }
        if (strcmp(m_szNameConnect, szNameConnect) != 0) {
            g_bDisconnect = true;
            m_bTobeDisconnect = false;
            DisconnectClient();
            DisconnectGameSvr();
            return;
        }


        //	}
        ///////

        while (true) {
            if (!m_pGameSvrClient)
                break;

            pBuffer = (const char *) m_pGameSvrClient->GetPackFromServer(nSize);

            if (!(pBuffer && nSize))
                break;


            const char *pCurrent = pBuffer;
            const char *pEnd = pBuffer + nSize;
            while (pCurrent < pEnd) {
                unsigned int nRemaining = (unsigned int)(pEnd - pCurrent);
                if (!g_pCoreShell)
                    break;

                // Phong Than packets are self-describing and are validated
                // before Core sees the payload. During the rebuild, legacy
                // messages that have not been migrated continue below; this
                // branch is the authoritative path for migrated families.
                if (nRemaining >= sizeof(PHONGTHAN_WIRE_HEADER)) {
                    PHONGTHAN_WIRE_HEADER Header;
                    memcpy(&Header, pCurrent, sizeof(Header));
                    if (Header.Magic == PHONGTHAN_WIRE_MAGIC) {
                        if (!PhongThanValidateWireHeader(&Header, nRemaining))
                            break;
                        if (Header.MessageType == PHONGTHAN_MSG_WORLD_TRANSFER &&
                            Header.PacketSize ==
                                sizeof(PHONGTHAN_WORLD_TRANSFER_RESPONSE)) {
                            ProcessSwitchGameSvrMsg((void*)pCurrent);
                            break;
                        }
                        if (Header.MessageType == PHONGTHAN_MSG_INVENTORY_ITEM_MOVE ||
                            Header.MessageType == PHONGTHAN_MSG_INVENTORY_ITEM_AUTO_MOVE) {
                            SO_ItemActionDiag("Move_CLIENT_RECEIVE", 0, 0,
                                              Header.PacketSize, nRemaining,
                                              Header.MessageType, Header.Flags,
                                              0, 0);
                        }
                        g_pCoreShell->NetMsgCallbackFunc((void*)pCurrent, Header.PacketSize);
                        pCurrent += Header.PacketSize;
                        continue;
                    }
                }

                if (nRemaining < PROTOCOL_MSG_SIZE)
                    break;

                PROTOCOL_MSG_TYPE *pMsg = (PROTOCOL_MSG_TYPE *) pCurrent;
                PROTOCOL_MSG_TYPE Msg = *pMsg;

                if (Msg <= s2c_clientbegin || Msg >= s2c_end)
                    break;

                int nDeclaredSize = g_pCoreShell->GetProtocolSize(Msg);
                if (nDeclaredSize == 0)
                    break;

                unsigned int nPacketSize = 0;
                if (nDeclaredSize > 0) {
                    nPacketSize = (unsigned int)nDeclaredSize;
                } else {
                    const unsigned int nVariableHeader = PROTOCOL_MSG_SIZE + sizeof(unsigned short);
                    if (nRemaining < nVariableHeader)
                        break;
                    unsigned short nPayloadSize = 0;
                    memcpy(&nPayloadSize, pCurrent + PROTOCOL_MSG_SIZE, sizeof(nPayloadSize));
                    nPacketSize = PROTOCOL_MSG_SIZE + (unsigned int)nPayloadSize;
                    if (nPacketSize < nVariableHeader)
                        break;
                }
                if (nPacketSize > nRemaining)
                    break;

                g_pCoreShell->NetMsgCallbackFunc(pMsg, nPacketSize);
                pCurrent += nPacketSize;
            }
        }
    }
}

//--------------------------------------------------------------------------
//	??????????????????????????
//--------------------------------------------------------------------------
void KNetConnectAgent::RegisterMsgTargetObject(PROTOCOL_MSG_TYPE Msg, iKNetMsgTargetObject *pObject) {
    if (Msg >= 0 && Msg < MAX_MSG_COUNT)
        m_MsgTargetObjs[Msg] = pObject;
}

void KNetConnectAgent::RegisterPhongThanSessionTarget(iKNetMsgTargetObject *pObject) {
    m_pPhongThanSessionTarget = pObject;
}

void KNetConnectAgent::TobeDisconnect() {
    m_bTobeDisconnect = true;
}

void KNetConnectAgent::UpdateClientRequestTime(bool bCancel, unsigned int uTimeLimit) {
    if (m_bIsClientConnecting || m_bIsGameServConnecting) {
        if (bCancel == false) {
            m_uClientRequestTime = GetTickCount();
            if (m_uClientRequestTime == 0)
                m_uClientRequestTime = 1;
            m_uClientTimeoutLimit = uTimeLimit;
        } else
            m_uClientRequestTime = 0;
    }
}

int KNetConnectAgent::IsConnecting(int bGameServ) {
    if (bGameServ)
        return m_bIsGameServConnecting;
    else
        return m_bIsClientConnecting;
}

void __stdcall ClientCallBack(LPVOID lpParam, const unsigned long &ulnEventType) {
    switch (ulnEventType) {
        case enumServerConnectCreate:
            break;
        case enumServerConnectClose: {
            int bGameServ = (int) lpParam;
            if (g_NetConnectAgent.IsConnecting(bGameServ)) {
                g_bDisconnect = true;
                g_NetConnectAgent.TobeDisconnect();
            }
        }
            break;
    }
}

//????????????????????????????
bool KNetConnectAgent::ProcessSwitchGameSvrMsg(void *pMsgData) {
    if (!pMsgData)
        return false;
    PHONGTHAN_WORLD_TRANSFER_RESPONSE *pInfo =
            (PHONGTHAN_WORLD_TRANSFER_RESPONSE *)pMsgData;
    if (!PhongThanValidateWireHeader(&pInfo->Header, sizeof(*pInfo)) ||
        pInfo->Header.MessageType != PHONGTHAN_MSG_WORLD_TRANSFER ||
        pInfo->Header.PacketSize != sizeof(*pInfo) ||
        pInfo->Header.Flags & PHONGTHAN_WIRE_FLAG_REQUEST)
        return false;

    if (pInfo->Result == PHONGTHAN_WORLD_TRANSFER_SUCCESS &&
        pInfo->ServerAddressV4 && pInfo->ServerPort) {
        // ??????GameSvr????????
        g_pCoreShell->OperationRequest(GOI_EXIT_GAME, 0, 0);
        if (ConnectToGameSvr(
                (const unsigned char *)&pInfo->ServerAddressV4,
                pInfo->ServerPort, pInfo->SessionTicket)) {
            Wnd_GameSpaceHandleInput(false);
            UpdateClientRequestTime(false);
            UiOnGameServerConnected();
            return true;
        }
    } else {
        KSystemMessage Msg;
        Msg.byConfirmType = SMCT_CLICK;
        Msg.byParamSize = 0;
        Msg.byPriority = 0;
        Msg.eType = SMT_SYSTEM;

        strcpy(Msg.szMessage, MSG_SUBWORLD_NOT_OPEN);
        KUiSysMsgCentre::AMessageArrival(&Msg, 0);
        g_bDisconnect = false;
        return false;

    }
    g_bDisconnect = true;
    g_NetConnectAgent.TobeDisconnect();
    return false;
}

