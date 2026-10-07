#include "StdAfx.h"
#ifdef _STANDALONE
#ifndef __linux
#include <winsock2.h>
#include <malloc.h>
#else
#include <unistd.h>
#include <netdb.h>
#include <sys/time.h>
#endif
#include "KWin32.h"
#include "package.h"
#endif

#include "CRC32.h"
#ifdef _STANDALONE
#include "KCore.h"
#include "KPlayerSet.h"
#include "CRC32.c"
#endif

#ifndef WIN32
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <netinet/in.h>
#include <net/if.h>
#include <arpa/inet.h>
#include <stdio.h>
#include <string.h>
#endif

#define _SERVER

#ifdef _STANDALONE
//	#ifdef WIN32
//		#define FAILED(x) ((x) != S_OK)
//	#else
	#undef FAILED`r`n#undef SUCCEEDED`r`n#define FAILED(hr) (((HRESULT)(hr)) < 0)`r`n#define SUCCEEDED(hr) (((HRESULT)(hr)) >= 0)
//	#endif
#endif

#ifndef _STANDALONE
#include <crtdbg.h>
#include <objbase.h>
#include <initguid.h>
#include "Library.h"
#include "inoutmac.h"
#endif

#include <iostream>
//#include <strstream>
#include <stdarg.h>
#include <stddef.h>

#include "PhongThanCharacter.h"
#include "PhongThanWorldProtocol.h"
#include "PhongThanUiProtocol.h"
#include "PhongThanRelayProtocol.h"
#include "KProtocolDef.h"
#include "KProtocol.h"
#include "KTongProtocol.h"

#include "KSOServer.h"
#include "KSG_StringProcess.h"
#include "KStrBase.h"
#include "KSG_MD5_String.h"
#include "time.h"
//-----------------

#ifndef _STANDALONE
using OnlineGameLib::Win32::CBuffer;
using OnlineGameLib::Win32::CLibrary;
using OnlineGameLib::Win32::CCriticalSection;

CLibrary g_theHeavenLibrary( "heaven.dll" );
CLibrary g_theRainbowLibrary( "rainbow.dll" );

OnlineGameLib::Win32::CUsesWinsock	 g_SocketInit;
CCriticalSection g_csFlow;

#else

ZMutex g_mutexFlow;

#endif

CPackager			m_theRecv;

#define				GAME_FPS		18
using namespace std;

// Persistent diagnostics for the client -> GameServer login handoff.  The
// server is normally launched in its own console, so stdout is not reliable
// when diagnosing a stalled login.  Keep this deliberately small and VC6
// compatible.
static void GameServerLoginDiag(const char *format, ...)
{
	FILE *pFile = fopen("gameserver_login_diag.log", "a+b");
	if (!pFile)
		return;
	va_list args;
	va_start(args, format);
	vfprintf(pFile, format, args);
	va_end(args);
	fputc('\n', pFile);
	fclose(pFile);
}

//const int KSwordOnLineSever::m_snMaxPlayerCount = 500;
//const int KSwordOnLineSever::m_snPrecision = 10;
const int KSwordOnLineSever::m_snMaxBuffer = 10;
const int KSwordOnLineSever::m_snBufferSize = 1024 * 16;
static void SendPhongThanCharacterLock(
    IClient *pDatabaseClient, const char *pRoleName, BOOL bLock)
{
    if (!pDatabaseClient || !pRoleName || !pRoleName[0])
        return;
    PHONGTHAN_SERVICE_CHARACTER_LOCK_REQUEST Request;
    ZeroMemory(&Request, sizeof(Request));
    PhongThanInitializeWireHeader(
        &Request.Header,
        PHONGTHAN_MSG_SERVICE_CHARACTER_LOCK,
        sizeof(Request),
        PHONGTHAN_WIRE_FLAG_REQUEST,
        0);
    strncpy((char*)Request.RoleName, pRoleName,
        sizeof(Request.RoleName) - 1);
    Request.Lock = bLock ? 1 : 0;
    pDatabaseClient->SendPackToServer(&Request, sizeof(Request));
}

struct PHONGTHAN_GAME_SESSION_ROUTE
{
	PHONGTHAN_U8 SessionTicket[PHONGTHAN_SESSION_TICKET_SIZE];
	char AccountName[PHONGTHAN_RELAY_ACCOUNT_NAME_SIZE];
	char RoleName[PHONGTHAN_RELAY_ROLE_NAME_SIZE];
	PHONGTHAN_U32 MapId;
};

typedef std::map<int, PHONGTHAN_GAME_SESSION_ROUTE>
	PHONGTHAN_GAME_SESSION_ROUTE_MAP;
static PHONGTHAN_GAME_SESSION_ROUTE_MAP g_PhongThanRelaySessions;
// A leaving character remains owned until Goddess acknowledges the final
// save (which also releases its role lock). Do not free/reuse its index early.
static std::map<int, DWORD> g_PhongThanLeavingSaves;

struct PHONGTHAN_OUTBOUND_TRANSFER
{
	PHONGTHAN_U32 TransferId;
	unsigned long ConnectionId;
	int PlayerIndex;
	PHONGTHAN_U32 DestinationMapId;
	PHONGTHAN_S32 DestinationX;
	PHONGTHAN_S32 DestinationY;
	PHONGTHAN_U8 SessionTicket[PHONGTHAN_SESSION_TICKET_SIZE];
	char RoleName[PHONGTHAN_RELAY_ROLE_NAME_SIZE];
	DWORD StartedAt;
};

struct PHONGTHAN_INBOUND_TRANSFER
{
	int PlayerIndex;
	DWORD StartedAt;
};

typedef std::map<PHONGTHAN_U32, PHONGTHAN_OUTBOUND_TRANSFER>
	PHONGTHAN_OUTBOUND_TRANSFER_MAP;
typedef std::map<PHONGTHAN_U32, PHONGTHAN_INBOUND_TRANSFER>
	PHONGTHAN_INBOUND_TRANSFER_MAP;
static PHONGTHAN_OUTBOUND_TRANSFER_MAP g_PhongThanOutboundTransfers;
static PHONGTHAN_INBOUND_TRANSFER_MAP g_PhongThanInboundTransfers;

static void RememberPhongThanRelaySession(
	int nPlayerIndex,
	const PHONGTHAN_U8* pSessionTicket,
	const PHONGTHAN_CHARACTER_STATE_HEADER* pState)
{
	if (nPlayerIndex <= 0 || !pSessionTicket || !pState)
		return;
	PHONGTHAN_GAME_SESSION_ROUTE Route;
	ZeroMemory(&Route, sizeof(Route));
	memcpy(Route.SessionTicket, pSessionTicket,
		PHONGTHAN_SESSION_TICKET_SIZE);
	strncpy(Route.AccountName, (const char*)pState->AccountName,
		sizeof(Route.AccountName) - 1);
	strncpy(Route.RoleName, (const char*)pState->RoleName,
		sizeof(Route.RoleName) - 1);
	Route.MapId = pState->EnterMapId > 0 ?
		(PHONGTHAN_U32)pState->EnterMapId :
		(PHONGTHAN_U32)pState->ReviveMapId;
	g_PhongThanRelaySessions[nPlayerIndex] = Route;
}

static bool BindPhongThanRelaySession(
	CPhongThanRelayClient& RelayClient,
	unsigned long lnID,
	int nPlayerIndex)
{
	PHONGTHAN_GAME_SESSION_ROUTE_MAP::iterator it =
		g_PhongThanRelaySessions.find(nPlayerIndex);
	if (it == g_PhongThanRelaySessions.end() || !it->second.MapId)
		return false;
	return RelayClient.BindSession(
		it->second.SessionTicket,
		it->second.AccountName,
		it->second.RoleName,
		it->second.MapId,
		(PHONGTHAN_U32)lnID);
}

static void UnbindPhongThanRelaySession(
	CPhongThanRelayClient& RelayClient,
	int nPlayerIndex,
	PHONGTHAN_S32 nReason)
{
	PHONGTHAN_GAME_SESSION_ROUTE_MAP::iterator it =
		g_PhongThanRelaySessions.find(nPlayerIndex);
	if (it == g_PhongThanRelaySessions.end())
		return;
	if (RelayClient.IsRegistered())
		RelayClient.UnbindSession(it->second.SessionTicket, nReason);
	g_PhongThanRelaySessions.erase(it);
}

KSwordOnLineSever g_SOServer;

enum PLAYER_GAME_STATUS
{
	enumPlayerBegin = 0,
	enumPlayerSyncEnd,
	enumPlayerPlaying,
	enumPlayerExchangingServer,
};

enum PLAYER_EXCHANGE_STATUS
{
	enumExchangeBegin = 0,
	enumExchangeSearchingWay,
	enumExchangeWaitForGameSvrRespone,
	enumExchangeCleaning,
};


int	g_nTongPCSize[defTONG_PROTOCOL_CLIENT_NUM] =
{
	-1,										// enumS2C_TONG_CREATE_SUCCESS
	sizeof(STONG_CREATE_FAIL_SYNC),			// enumS2C_TONG_CREATE_FAIL
	sizeof(STONG_ADD_MEMBER_SUCCESS_SYNC),	// enumS2C_TONG_ADD_MEMBER_SUCCESS
	sizeof(STONG_ADD_MEMBER_FAIL_SYNC),		// enumS2C_TONG_ADD_MEMBER_FAIL
	-1,										// enumS2C_TONG_HEAD_INFO
	-1,										// enumS2C_TONG_MANAGER_INFO
	-1,										// enumS2C_TONG_MEMBER_INFO
	sizeof(STONG_BE_INSTATED_SYNC),			// enumS2C_TONG_BE_INSTATED
	sizeof(STONG_INSTATE_SYNC),				// enumS2C_TONG_INSTATE
	sizeof(STONG_KICK_SYNC),				// enumS2C_TONG_KICK
	sizeof(STONG_BE_KICKED_SYNC),			// enumS2C_TONG_BE_KICKED
	sizeof(STONG_LEAVE_SYNC),				// enumS2C_TONG_LEAVE
	sizeof(STONG_CHECK_GET_MASTER_POWER_SYNC),	// enumS2C_TONG_CHECK_CHANGE_MASTER_POWER
	sizeof(STONG_CHANGE_MASTER_FAIL_SYNC),	// enumS2C_TONG_CHANGE_MASTER_FAIL
	sizeof(STONG_CHANGE_AS_SYNC),			// enumS2C_TONG_CHANGE_AS
	sizeof(STONG_CHANGE_MASTER_SYNC),		// enumS2C_TONG_CHANGE_MASTER
	sizeof(STONG_LOGIN_DATA_SYNC),			// enumS2C_TONG_LOGIN_DATA
	//Code o day
	sizeof(STONG_MONEY_SYNC),				//enumS2C_TONG_MONEY_SAVE
	sizeof(STONG_MONEY_SYNC),				//enumS2C_TONG_MONEY_GET
	sizeof(STONG_CHANGE_AGNAME_FAIL_SYNC),	// enumS2C_TONG_CHANGE_AGNAME_FAIL
	sizeof(STONG_CHECK_GET_AGNAME_POWER_SYNC),// enumS2C_TONG_CHECK_CHANGE_AGNAME_POWER
	sizeof(STONG_BE_CHANGED_AGNAME_SYNC),	// enumS2C_TONG_BE_CHANGED_AGNAME
	sizeof(STONG_BE_CHANGED_CAMP_SYNC),	// enumS2C_TONG_BE_CHANGED_CAMP
	sizeof(STONG_CHANGE_TONG_INFO_SYNC),	// enumS2C_TONG_BE_CHANGED_LEVEL
	sizeof(STONG_CHANGE_TONG_INFO_SYNC),	// enumS2C_TONG_BE_CHANGED_MONEY
	sizeof(STONG_CHANGE_TONG_INFO_SYNC),	// enumS2C_TONG_BE_CHANGED_EFF
	sizeof(STONG_CHANGE_TONG_INFO_SYNC),	// enumS2C_TONG_BE_CHANGED_RECRUIT
	sizeof(STONG_CHANGE_TONG_INFO_SYNC),	// enumS2C_TONG_BE_CHANGED_TONGPARAM
	sizeof(STONG_CHANGE_TONG_INFO_SYNC),	// enumS2C_TONG_BE_CHANGED_JIYU
	sizeof(STONG_CHANGE_TONG_MEMBEREFF_SYNC),// enumS2C_TONG_BE_CHANGED_MEMBEREFF
	sizeof(STONG_GET_EXTPOINT_SYNC),		// enumS2C_SET_EXTPOINT	 TamLTM fix xu;
};



#ifndef _STANDALONE
typedef HRESULT ( __stdcall * pfnCreateClientInterface )(
			REFIID riid,
			void **ppv
		);

typedef HRESULT ( __stdcall * pfnCreateServerInterface )(
			REFIID	riid,
			void	**ppv
		);
#endif

#ifndef _STANDALONE
void __stdcall ServerEventNotify(
#else
void ServerEventNotify(
#endif
			LPVOID lpParam,
			const unsigned long &ulnID,
			const unsigned long &ulnEventType )
{
#ifndef _STANDALONE
	CCriticalSection::Owner locker( g_csFlow );
#else
	g_mutexFlow.lock();
#endif
	switch( ulnEventType )
	{
	case enumClientConnectCreate:
		g_SOServer.SetNetStatus(ulnID, enumNetConnected);
		break;
	case enumClientConnectClose:
		g_SOServer.SetNetStatus(ulnID, enumNetUnconnect);
		break;
	}
#ifdef _STANDALONE
	g_mutexFlow.unlock();
#endif
}

#ifndef _STANDALONE
void __stdcall GatewayClientEventNotify(
#else
void GatewayClientEventNotify(
#endif
			LPVOID lpParam,
			const unsigned long &ulnEventType )
{
	switch( ulnEventType )
	{
	case enumServerConnectCreate:
		break;
	case enumServerConnectClose:
		printf("GateWay lost\n");
		g_SOServer.SetRunningStatus(FALSE);
		break;
	}
}

#ifndef _STANDALONE
void __stdcall ChatClientEventNotify(
#else
void ChatClientEventNotify(
#endif
			LPVOID	lpParam,
			const unsigned long &ulnEventType )
{
	switch( ulnEventType )
	{
	case enumServerConnectCreate:
		break;
	case enumServerConnectClose:
		printf("Chat disconnect\n");
		break;
	}
}

#ifndef _STANDALONE
void __stdcall TongClientEventNotify(
#else
void TongClientEventNotify(
#endif
			LPVOID	lpParam,
			const unsigned long &ulnEventType )
{
	switch( ulnEventType )
	{
	case enumServerConnectCreate:	// ??????????????????
		break;
	case enumServerConnectClose:	// ??????????????????
		printf("Tong disconnect\n");
		break;
	}
}

#ifndef _STANDALONE
void __stdcall DatabaseClientEventNotify(
#else
void DatabaseClientEventNotify(
#endif
			LPVOID lpParam,
			const unsigned long &ulnEventType )
{
	switch( ulnEventType )
	{
	case enumServerConnectCreate:
		break;
	case enumServerConnectClose:
		printf("DataBase lost\n");
		g_SOServer.SetRunningStatus(FALSE);
		break;
	}
}

#ifndef _STANDALONE
void __stdcall TransferClientEventNotify(
#else
void TransferClientEventNotify(
#endif
			LPVOID lpParam,
			const unsigned long &ulnEventType )
{
	switch( ulnEventType )
	{
	case enumServerConnectCreate:
		break;
	case enumServerConnectClose:
///		g_SOServer.SetRunningStatus(FALSE);
		break;
	}
}


KSwordOnLineSever::KSwordOnLineSever()
{
	m_nGameLoop = 0;
	m_bIsRunning = TRUE;
	m_nServerPort = 6666;
	m_nGatewayPort = 5632;
	m_nDatabasePort = 5001;
	m_nChatPort	= 5004;
	m_nTongPort	= 5005;
	m_nRelayPort = 5003;
	m_nRelayServiceId = 1001;
	ZeroMemory(m_szGatewayIP, sizeof(m_szGatewayIP));
	ZeroMemory(m_szDatabaseIP, sizeof(m_szDatabaseIP));
	ZeroMemory(m_szChatIP, sizeof(m_szChatIP));
	ZeroMemory(m_szTongIP, sizeof(m_szTongIP));
	ZeroMemory(m_szRelayIP, sizeof(m_szRelayIP));
	ZeroMemory(m_szRelaySecret, sizeof(m_szRelaySecret));
	ZeroMemory(m_szRelayInstance, sizeof(m_szRelayInstance));
	m_pServer = NULL;
	m_pGatewayClient = NULL;
	m_pDatabaseClient = NULL;
	m_pChatClient = NULL;
	m_pTongClient = NULL;
	m_pCoreServerShell = NULL;
	m_pGameStatus = NULL;
}

KSwordOnLineSever::~KSwordOnLineSever()
{
}

BOOL KSwordOnLineSever::Init()
{
	m_bIsRunning = TRUE;
	g_SetRootPath(NULL);
 //   system("color 1E");
	g_SetFilePath("\\");
	KIniFile iniFile;

	/*
	g_SetFilePath("\\");
	KIniFile iniFile;

	iniFile.Load("ServerCfg.ini");
	iniFile.GetInteger("GameServer", "Port", 6666, &m_nServerPort);
	extern int g_nPort;
	if (g_nPort)
		m_nServerPort = g_nPort;
	iniFile.GetString("Gateway", "Ip", "192.168.26.1", m_szGatewayIP, sizeof(m_szGatewayIP));
	iniFile.GetInteger("Gateway", "Port", 5632, &m_nGatewayPort);
	iniFile.GetString("Database", "Ip", "192.168.22.104", m_szDatabaseIP, sizeof(m_szDatabaseIP));
	iniFile.GetInteger("Database", "Port", 5001, &m_nDatabasePort);
	iniFile.GetString("Chat", "Ip", "192.168.22.105", m_szChatIP, sizeof(m_szChatIP));
	iniFile.GetInteger("Chat", "Port", 5004, &m_nChatPort);
	iniFile.GetString("Tong", "Ip", "192.168.22.105", m_szTongIP, sizeof(m_szTongIP));
	iniFile.GetInteger("Tong", "Port", 5005, &m_nTongPort);
	*/

	iniFile.Load("ServerCfg.ini");
	//TamLTM bo ko dung Gamerver
//	iniFile.GetString("GameServer", "Ip", "222.189.237.112", m_szGameServerIP, sizeof(m_szGameServerIP)); // Co them Ip GameServer o day
	iniFile.GetInteger("GameServer", "Port", 6666, &m_nServerPort);
	extern int g_nPort;
	if (g_nPort)
		m_nServerPort = g_nPort;
	iniFile.GetString("Gateway", "Ip", "192.168.26.1", m_szGatewayIP, sizeof(m_szGatewayIP));
	iniFile.GetInteger("Gateway", "Port", 5632, &m_nGatewayPort);
	iniFile.GetString("Database", "Ip", "192.168.22.104", m_szDatabaseIP, sizeof(m_szDatabaseIP));
	iniFile.GetInteger("Database", "Port", 5001, &m_nDatabasePort);
	iniFile.GetString("Chat", "Ip", "192.168.22.105", m_szChatIP, sizeof(m_szChatIP));
	iniFile.GetInteger("Chat", "Port", 5004, &m_nChatPort);
	iniFile.GetString("Tong", "Ip", "192.168.22.105", m_szTongIP, sizeof(m_szTongIP));
	iniFile.GetInteger("Tong", "Port", 5005, &m_nTongPort);
	iniFile.GetString("Relay", "Ip", "127.0.0.1", m_szRelayIP,
		sizeof(m_szRelayIP));
	iniFile.GetInteger("Relay", "Port", 5003, &m_nRelayPort);
	iniFile.GetInteger("Relay", "ServiceId", 1001, &m_nRelayServiceId);
	iniFile.GetString("Relay", "ServiceSecret", "", m_szRelaySecret,
		sizeof(m_szRelaySecret));
	iniFile.GetString("Relay", "InstanceName", "game-1", m_szRelayInstance,
		sizeof(m_szRelayInstance));
#ifdef WIN32
	iniFile.GetInteger("Overload", "MaxPlayer", 450, &m_nMaxPlayerCount);
	iniFile.GetInteger("Overload", "Precision", 20, &m_nPrecision);
#else
	iniFile.GetInteger("Overload", "MaxPlayer", 1000, &m_nMaxPlayerCount);
	iniFile.GetInteger("Overload", "Precision", 200, &m_nPrecision);
#endif

// Muntyserver

	/*char				m_szIntranetIp[16];
	char				m_szInternetIp[16];

	char				m_szFowardServerIp1[16];
	char				m_szFowardServerIp2[16];
	char				m_szFowardServerIp3[16];

	iniFile.GetString("Network", "IntranetIp", "222.189.237.112", m_szIntranetIp, sizeof(m_szIntranetIp));
	iniFile.GetString("Network", "InternetIp", "222.189.237.112", m_szInternetIp, sizeof(m_szInternetIp));
//	if (strcmpi(m_szInternetIp,"103.200.20.121") != 0 && strcmpi(m_szInternetIp,"103.200.20.232") != 0 && strcmpi(m_szInternetIp,"192.168.100.200") != 0  && strcmpi(m_szInternetIp,"103.200.20.149") != 0)
//	{
//		return FALSE;
//	}
	iniFile.GetString("FowardServer", "Ip1", "222.189.237.112", m_szFowardServerIp1, sizeof(m_szFowardServerIp1));
	iniFile.GetInteger("FowardServer", "Port1", 22277, &m_nFowardServerPort1);
	iniFile.GetString("FowardServer", "Ip2", "222.189.237.112", m_szFowardServerIp2, sizeof(m_szFowardServerIp2));
	iniFile.GetInteger("FowardServer", "Port2", 22277, &m_nFowardServerPort2);
	iniFile.GetString("FowardServer", "Ip3", "222.189.237.112", m_szFowardServerIp3, sizeof(m_szFowardServerIp3));
	iniFile.GetInteger("FowardServer", "Port3", 22277, &m_nFowardServerPort3);


	cout <<"Server " <<m_szIntranetIp <<" | " <<m_szInternetIp <<" : " <<m_nServerPort <<" | " <<m_nServerPort1 << endl;

	cout <<"Foward " <<m_szFowardServerIp1 <<":" <<m_nFowardServerPort1 <<" | " <<m_szFowardServerIp2 <<":" <<m_nFowardServerPort2 <<" | " <<m_szFowardServerIp3 <<":" <<m_nFowardServerPort3 << endl;
    */
// Muntyserver
	//Cho phep server su dung 1 IP duy nhat
/*	if(CHECK_IPADDRESS)
	{
		KSG_PASSWORD Password;
		char PassLic[256];
		sprintf(PassLic,"%s",IPADDRESS);
		KSG_StringToMD5String(Password.szPassword, m_szGatewayIP);
		if (!g_StrCmp(Password.szPassword, PassLic))
			return 0;
		sprintf(PassLic,"%s",IPADDRESS);
		KSG_StringToMD5String(Password.szPassword, m_szDatabaseIP);
		if (!g_StrCmp(Password.szPassword, PassLic))
			return 0;
		sprintf(PassLic,"%s",IPADDRESS);
		KSG_StringToMD5String(Password.szPassword, m_szChatIP);
		if (!g_StrCmp(Password.szPassword, PassLic))
			return 0;
		sprintf(PassLic,"%s",IPADDRESS);
		KSG_StringToMD5String(Password.szPassword, m_szTongIP);
		if (!g_StrCmp(Password.szPassword, PassLic))
			return 0;
	} // */
/////////////////////////////////////////////

	m_nMaxPlayer = m_nMaxPlayerCount + m_nPrecision;

	if (m_nMaxPlayer <= 0)
	{
		cout << "Maximal player number <= 0!" << endl;
		return FALSE;
	}

	if (!m_pGameStatus)
	{
		m_pGameStatus = new GameStatus[m_nMaxPlayer];
	}

//	strcpy(m_szGameSvrIP, OnlineGameLib::Win32::net_ntoa(dwIp));

	/*
	 * Open this server to player
	 */
#ifndef _STANDALONE
	pfnCreateServerInterface pFactroyFun = ( pfnCreateServerInterface )( g_theHeavenLibrary.GetProcAddress( "CreateInterface" ) );

	IServerFactory *pServerFactory = NULL;

	if ( pFactroyFun && SUCCEEDED( pFactroyFun( IID_IServerFactory, reinterpret_cast< void ** >( &pServerFactory ) ) ) )
	{
		pServerFactory->SetEnvironment( m_nMaxPlayer, m_nPrecision, m_snMaxBuffer, m_snBufferSize  );

		pServerFactory->CreateServerInterface( IID_IIOCPServer, reinterpret_cast< void ** >( &m_pServer ) );

		pServerFactory->Release();
	}
	else
	{
		return FALSE;
	}
#else
	m_pServer = new IServer(m_nMaxPlayer, 4, 200 * 1024);
#endif

	if (!m_pServer)
	{
		cout << "Initialization failed! Don't find a correct heaven.dll" << endl;
		return FALSE;
	}

	m_pServer->Startup();

	m_pServer->RegisterMsgFilter( reinterpret_cast< void * >( m_pServer ), ServerEventNotify );

	if ( FAILED( m_pServer->OpenService( INADDR_ANY, m_nServerPort ) ) )
	{
		return FALSE;
	}

	// Resolve the advertised addresses from ServerCfg.ini first. Automatic
	// detection may leave the Internet address at 0 on a LAN-only host.
	printf("[KSOServer Step 1] Socket opened on port %d\n", m_nServerPort);
	m_dwIntranetIp = 0;
	m_dwInternetIp = 0;
	GetLocalIpAddress(&m_dwIntranetIp, &m_dwInternetIp);

	char szConfiguredIntranetIp[16];
	char szConfiguredInternetIp[16];
	iniFile.GetString("Network", "IntranetIp", "", szConfiguredIntranetIp, sizeof(szConfiguredIntranetIp));
	iniFile.GetString("Network", "InternetIp", "", szConfiguredInternetIp, sizeof(szConfiguredInternetIp));

	DWORD dwConfiguredIp = inet_addr(szConfiguredIntranetIp);
	if (dwConfiguredIp != INADDR_NONE && dwConfiguredIp != 0)
		m_dwIntranetIp = dwConfiguredIp;

	dwConfiguredIp = inet_addr(szConfiguredInternetIp);
	if (dwConfiguredIp != INADDR_NONE && dwConfiguredIp != 0)
		m_dwInternetIp = dwConfiguredIp;

	if (m_dwInternetIp == 0)
		m_dwInternetIp = m_dwIntranetIp;
	if (m_dwIntranetIp == 0)
		m_dwIntranetIp = m_dwInternetIp;
	if (m_dwIntranetIp == 0 || m_dwInternetIp == 0)
	{
		cout << "Can't get server ip" << endl;
		return FALSE;
	}

// Muntyserver


	/*m_dwIntranetIp = inet_addr(m_szIntranetIp);
	m_dwInternetIp = inet_addr(m_szInternetIp);

	m_dwFowardServerIp1 = inet_addr(m_szFowardServerIp1);
	m_dwFowardServerIp2 = inet_addr(m_szFowardServerIp2);
	m_dwFowardServerIp3 = inet_addr(m_szFowardServerIp3);*/

// Muntyserver
	cout << m_dwIntranetIp << " : " << m_dwInternetIp << endl;
	cout << "" << endl;

#ifndef _STANDALONE
	IServer *pCloneServer = NULL;
	m_pServer->QueryInterface( IID_IIOCPServer, ( void ** )&pCloneServer );
#else
	IServer *pCloneServer = m_pServer;
#endif
	/*
	 * Init GameWorld
	 */
	printf("[KSOServer Step 2] Calling CoreGetServerShell...\n");
	if (m_pCoreServerShell == NULL)
		m_pCoreServerShell = ::CoreGetServerShell();

	if (m_pCoreServerShell == NULL)
	{
		cout << "Failed to Create CoreShell." << endl;
		return FALSE;
	}

	printf("[KSOServer Step 3] Calling OperationRequest SSOI_LAUNCH...\n");
	m_pCoreServerShell->OperationRequest(SSOI_LAUNCH, (unsigned int)pCloneServer, 0);
	printf("[KSOServer Step 4] SSOI_LAUNCH Finished!\n");

	/*
	 * Connect database
	 */
#ifndef _STANDALONE
	pfnCreateClientInterface pClientFactroyFun = ( pfnCreateClientInterface )( g_theRainbowLibrary.GetProcAddress( "CreateInterface" ) );

	IClientFactory *pClientFactory = NULL;

	if ( pClientFactroyFun && SUCCEEDED( pClientFactroyFun( IID_IClientFactory, reinterpret_cast< void ** >( &pClientFactory ) ) ) )
	{
		pClientFactory->SetEnvironment( 1024 * 128 );

		pClientFactory->CreateClientInterface( IID_IESClient, reinterpret_cast< void ** >( &m_pDatabaseClient ) );

		pClientFactory->Release();
	}
	else
	{
		return FALSE;
	}
#else
//	net_buffer = new ZBuffer(20240000, 400);
	m_pDatabaseClient = new IClient(6000*1024, 6000*1024);
#endif
	if ( !m_pDatabaseClient )
	{
		cout << "Initialization failed! Don't find a correct rainbow.dll" << endl;

		return FALSE;
	}
	if (FAILED(m_pDatabaseClient->Startup()))
	{
		cout << "Can't not startup database client service!" << endl;
		return FALSE;
	}
	cout << "Database IP: " << m_szDatabaseIP << " - Port: " << m_nDatabasePort << endl;

	m_pDatabaseClient->RegisterMsgFilter( reinterpret_cast< void * >( m_pDatabaseClient ), DatabaseClientEventNotify );

	if ( FAILED( m_pDatabaseClient->ConnectTo( m_szDatabaseIP, m_nDatabasePort ) ) )
	{
		cout << "Connect Database failed!" << endl;
		return FALSE;
	}

	cout << "Connect Database successful!" << endl;

	/*
	 * Connect the native Phong Than relay. Transfer, chat and clan traffic
	 * share this self-describing transport; the three SwordOnline relay
	 * sockets are deliberately not created.
	 */
	cout << "PhongThan relay IP: " << m_szRelayIP
		 << " - Port: " << m_nRelayPort << endl;
	if (!m_RelayClient.Connect(
		m_szRelayIP,
		(unsigned short)m_nRelayPort,
		m_szRelaySecret,
		(PHONGTHAN_U32)m_nRelayServiceId,
		m_szRelayInstance,
		PHONGTHAN_RELAY_CAPABILITY_SESSION |
			PHONGTHAN_RELAY_CAPABILITY_MAP |
			PHONGTHAN_RELAY_CAPABILITY_TRANSFER |
			PHONGTHAN_RELAY_CAPABILITY_CHAT |
			PHONGTHAN_RELAY_CAPABILITY_CLAN |
			PHONGTHAN_RELAY_CAPABILITY_FRIEND,
		(PHONGTHAN_U32)m_dwInternetIp,
		(unsigned short)m_nServerPort))
	{
		cout << "Connect PhongThan relay failed!" << endl;
		return FALSE;
	}

	const DWORD nRelayRegisterStart = GetTickCount();
	while (!m_RelayClient.IsRegistered())
	{
		if (!m_RelayClient.Pump() ||
			GetTickCount() - nRelayRegisterStart >= 5000)
		{
			cout << "Register PhongThan relay failed!" << endl;
			m_RelayClient.Disconnect();
			return FALSE;
		}
#ifdef WIN32
		Sleep(10);
#endif
	}
	if (!RegisterRelayMaps())
	{
		cout << "Register PhongThan relay maps failed!" << endl;
		m_RelayClient.Disconnect();
		return FALSE;
	}
	cout << "Connect PhongThan relay successful! ServiceId="
		 << m_RelayClient.GetServiceId() << endl;

	/*
	 * Connect gateway
	 */
#ifndef _STANDALONE
	pClientFactroyFun = ( pfnCreateClientInterface )( g_theRainbowLibrary.GetProcAddress( "CreateInterface" ) );

	pClientFactory = NULL;

	if ( pClientFactroyFun && SUCCEEDED( pClientFactroyFun( IID_IClientFactory, reinterpret_cast< void ** >( &pClientFactory ) ) ) )
	{
		pClientFactory->SetEnvironment( 1024 * 1024 );

		pClientFactory->CreateClientInterface( IID_IESClient, reinterpret_cast< void ** >( &m_pGatewayClient ) );

		pClientFactory->Release();
	}
	else
	{
		return FALSE;
	}
#else
	m_pGatewayClient = new IClient(6000*1024, 6000*1024);
#endif
	if ( !m_pGatewayClient )
	{
		cout << "Initialization failed! Don't find a correct rainbow.dll" << endl;

		return FALSE;
	}

	if ( FAILED(m_pGatewayClient->Startup()))
	{
		cout << "Can't not startup gateway client service!" << endl;
		return FALSE;
	}

	cout << "Gateway IP: " << m_szGatewayIP << " - Port: " << m_nGatewayPort << endl;

	m_pGatewayClient->RegisterMsgFilter( reinterpret_cast< void * >( m_pGatewayClient ), GatewayClientEventNotify );

	if ( FAILED( m_pGatewayClient->ConnectTo( m_szGatewayIP, m_nGatewayPort ) ) )
	{
		cout << "Connect Gateway failed!" << endl;
		return FALSE;
	}

	cout << "Connect Gateway successful!" << endl;
	/*
	 * Game timer start
	 */
	m_Timer.Start();
	m_nGameLoop = 0;
	if (m_pDatabaseClient)
	{
		TProcessData	ProcessData;

		ProcessData.nProtoId = c2s_gamestatistic;
		ProcessData.nDataLen = 1;
		ProcessData.ulIdentity = -1;
		ProcessData.pDataBuffer[0] = 0;
		m_pDatabaseClient->SendPackToServer(&ProcessData, sizeof(TProcessData));
	}
	return TRUE;
}

void KSwordOnLineSever::Release()
{
#ifndef _STANDALONE
	CCriticalSection::Owner locker( g_csFlow );
#else
	g_mutexFlow.lock();
#endif
	if (m_pServer)
	{
		// Close service for no one can login again
		m_pServer->CloseService();
		// Regist callback function to null
		m_pServer->RegisterMsgFilter( reinterpret_cast< void * >( m_pServer ), NULL );
		// Shut down all client and save their data.
		const char *pChar = NULL;

		ExitAllPlayer();
	}
	m_RelayClient.Disconnect();
	g_PhongThanRelaySessions.clear();

	if (m_pCoreServerShell)
	{
		m_pCoreServerShell->Release();
		m_pCoreServerShell = NULL;
	}

	if (m_pGameStatus)
	{
		delete [] m_pGameStatus;
		m_pGameStatus = NULL;
	}

	if (m_pServer)
	{
		m_pServer->Cleanup();
		m_pServer->Release();
#ifndef _STANDALONE
		m_pServer = NULL;
#else
		delete m_pServer;			m_pServer = NULL;
#endif
	}

	if (m_pGatewayClient)
	{
		m_pGatewayClient->Shutdown();
		m_pGatewayClient->Cleanup();
		m_pGatewayClient->Release();
		m_pGatewayClient = NULL;
	}

	if (m_pDatabaseClient)
	{
		m_pDatabaseClient->Shutdown();
		m_pDatabaseClient->Cleanup();
		m_pDatabaseClient->Release();
		m_pDatabaseClient = NULL;
	}

	if (m_pChatClient)
	{
		m_pChatClient->Shutdown();
		m_pChatClient->Cleanup();
		m_pChatClient->Release();
		m_pChatClient = NULL;
	}

	if (m_pTongClient)
	{
		m_pTongClient->Shutdown();
		m_pTongClient->Cleanup();
		m_pTongClient->Release();
		m_pTongClient = NULL;
	}

#ifdef _STANDALONE
//	delete net_buffer;
	delete m_pDatabaseClient;	m_pDatabaseClient = NULL;
	delete m_pGatewayClient;	m_pGatewayClient = NULL;
#endif
#ifdef _STANDALONE
	g_mutexFlow.unlock();
#endif
}

BOOL KSwordOnLineSever::Breathe()
{
	if (m_pCoreServerShell && m_bIsRunning)
	{
		MessageLoop();
		/*if (m_nGameLoop % (GAME_FPS * 60 * 1) == 0)
		{
			AutoSave();
		}*/
		if (m_nGameLoop * 1000 <= m_Timer.GetElapse() * GAME_FPS)
		{
			MainLoop();
#ifdef WIN32
			Sleep(0);
#else
			usleep(0);
#endif

#ifdef _STANDALONE
			if (m_nGameLoop % (GAME_FPS * 60) == 0)	//??????????
			{
extern ZPerf g_sendPerf;
extern ZPerf g_recvPerf;
				DWORD dwElapse = m_Timer.GetElapse();
				printf("GameLoop= %06d, Time= %02d:%02d:%02d, Svr(S: %dK R: %dK), Clt(S: %dK R: %dK), Online= %d\n",
									m_nGameLoop,
									dwElapse / (1000 * 3600),
									(dwElapse / (1000 * 60)) % 60,
									(dwElapse / 1000) % 60,
									m_pServer->sendPerf.total_size / 1024,
									m_pServer->recvPerf.total_size / 1024,
									g_sendPerf.total_size / 1024,
									g_recvPerf.total_size / 1024,
									PlayerSet.GetOnlinePlayerCount());
			}
#endif
		}
		else
		{
#ifndef __linux			//SwitchToThread();
			Sleep(1);
#else
			usleep(1000);
#endif
#ifdef _STANDALONE
			void DoEveryThing(IServer* pIServer);
			DoEveryThing(m_pServer);
#endif
		}
		return TRUE;
	}
	printf("main thread exit\n");
	return FALSE;
}

void KSwordOnLineSever::AutoSave()
{
	int lnID;
	for (lnID = 0; lnID < m_nMaxPlayer; lnID++)
	{
		int nIndex = m_pGameStatus[lnID].nPlayerIndex;
		if (nIndex == 0)
			continue;
		m_pCoreServerShell->SetSaveStatus(nIndex, SAVE_REQUEST);
	}
	m_pCoreServerShell->SaveData();
}

void KSwordOnLineSever::MessageLoop()
{
	int i;
	const char*		pChar = NULL;
	unsigned int	uSize = 0;
	std::vector<PHONGTHAN_U8> RelayPacket;

#ifndef _STANDALONE
	CCriticalSection::Owner locker( g_csFlow );
#else
	g_mutexFlow.lock();
#endif

	while(m_pGatewayClient)
	{
		pChar = (const char*)m_pGatewayClient->GetPackFromServer(uSize);
		if (!pChar || 0 == uSize)
			break;
		GatewayMessageProcess(pChar, uSize);
	}

	while(m_pDatabaseClient)
	{
		pChar = (const char*)m_pDatabaseClient->GetPackFromServer(uSize);
		if (!pChar || 0 == uSize)
			break;
		DatabaseMessageProcess(pChar, uSize);
	}

	if (!m_RelayClient.Pump())
	{
		GameServerLoginDiag("native_relay_disconnected");
		m_RelayClient.Disconnect();
		m_bIsRunning = FALSE;
	}
	if (m_RelayClient.IsRegistered())
	{
		PHONGTHAN_U8 packet[16384];
		PHONGTHAN_RELAY_ROUTE_HEADER* route = (PHONGTHAN_RELAY_ROUTE_HEADER*)packet;
		for (int count = 0; count < 128; ++count)
		{
			const int payloadSize = m_pCoreServerShell->PopNativeBroadcast(route + 1, sizeof(packet) - sizeof(*route));
			if (payloadSize <= 0) break;
			ZeroMemory(route, sizeof(*route));
			PhongThanInitializeWireHeader(&route->Header, PHONGTHAN_MSG_RELAY_ROUTE,
				sizeof(*route) + payloadSize, PHONGTHAN_WIRE_FLAG_REQUEST, m_RelayClient.NextSequence());
			route->RouteId = route->Header.Sequence;
			route->SourceServiceId = m_RelayClient.GetServiceId();
			route->KeyType = PHONGTHAN_RELAY_ROUTE_DIRECT_SERVICE;
			route->RouteFlags = PHONGTHAN_RELAY_ROUTE_FLAG_BROADCAST;
			route->PayloadSize = payloadSize;
			if (!m_RelayClient.Send(packet, route->Header.PacketSize))
			{
				GameServerLoginDiag("native_broadcast_send_failed");
				m_bIsRunning = FALSE;
				break;
			}
		}
	}
	while (m_RelayClient.PopPacket(RelayPacket))
	{
		if (!RelayPacket.empty())
			RelayMessageProcess((const char*)&RelayPacket[0], RelayPacket.size());
		RelayPacket.clear();
	}

	pChar = NULL;
	uSize = 0;
	for (i = 0; i < m_nMaxPlayer; i++)
	{
		if (enumNetUnconnect == GetNetStatus(i))
			continue;

		while(m_pServer)
		{
			pChar = (const char*)m_pServer->GetPackFromClient(i, uSize);
			if (!pChar || 0 == uSize)
				break;

			//printf("player msg..\n");
			PlayerMessageProcess(i, pChar, uSize);
		}
	}
#ifdef _STANDALONE
	g_mutexFlow.unlock();
#endif
}

void KSwordOnLineSever::ChatMessageProcess(const char *pChar, size_t nSize)
{
	_ASSERT( pChar && nSize);
#ifndef _STANDALONE
	BYTE cProtocol = CPackager::Peek( pChar );
#else
	BYTE cProtocol = *(BYTE *)pChar;
#endif
	switch (cProtocol)
	{
	case chat_relegate:
		{
			CHAT_RELEGATE* pCR = (CHAT_RELEGATE*)pChar;

			DWORD	theID = 0;
			switch (pCR->TargetCls)
			{
			case tgtcls_team:
			case tgtcls_profession:
			case tgtcls_msgr:
			case tgtcls_cr:
				theID = pCR->TargetID;
				break;
			case tgtcls_scrn:
				theID = m_pGameStatus[pCR->TargetID].nPlayerIndex;
				break;
			default:
				return;
			}
			m_pCoreServerShell->GroupChat(
				m_pChatClient,
				pCR->nFromIP,
				pCR->nFromRelayID,
				pCR->channelid,
				pCR->TargetCls,
				theID,
				pCR + 1,
				pCR->routeDateLength);
		}
		break;
	case chat_groupman:
		ChatGroupMan(pChar, nSize);
		break;
	case chat_specman:
		ChatSpecMan(pChar, nSize);
		break;
	case chat_everyone:
		{
			CHAT_EVERYONE* pCeo = (CHAT_EVERYONE*)pChar;
			m_pCoreServerShell->OperationRequest(SSOI_BROADCASTING, (unsigned int)(pCeo + 1), pCeo->wChatLength);
		}
		break;
	default:
		break;
	}

}

void KSwordOnLineSever::TongMessageProcess(const char *pChar, size_t nSize)
{
	if (!pChar)
		return;

	EXTEND_HEADER* pHeader = (EXTEND_HEADER*)pChar;

	if (pHeader->ProtocolFamily == pf_extend)
	{
		if (pHeader->ProtocolID == extend_s2c_passtosomeone)
		{
			EXTEND_PASSTOSOMEONE* pEps = (EXTEND_PASSTOSOMEONE*)pChar;

			if (CheckPlayerID(pEps->lnID ,pEps->nameid))
			{
				_ASSERT(sizeof(tagExtendProtoHeader) <= sizeof(EXTEND_PASSTOSOMEONE));
				unsigned long lnID = pEps->lnID;
				size_t pckgsize = sizeof(tagExtendProtoHeader) + pEps->datasize;
				tagExtendProtoHeader* pExHdr = (tagExtendProtoHeader*)(pEps + 1) - 1;
				pExHdr->ProtocolType = s2c_extendfriend;
				pExHdr->wLength = pckgsize - 1;

				m_pServer->PackDataToClient(lnID, pExHdr, pckgsize);
			}
		}
		else if (pHeader->ProtocolID == extend_s2c_passtobevy)
		{
			EXTEND_PASSTOBEVY* pEpb = (EXTEND_PASSTOBEVY*)pChar;

			if (pEpb->playercount > 0)
			{
				_ASSERT(sizeof(tagExtendProtoHeader) <= sizeof(EXTEND_PASSTOBEVY));
				void* pExPckg = pEpb + 1;
				WORD playercount = pEpb->playercount;
				tagPlusSrcInfo* pPlayers = (tagPlusSrcInfo*)((BYTE*)pExPckg + pEpb->datasize);
				size_t pckgsize = sizeof(tagExtendProtoHeader) + pEpb->datasize;
				tagExtendProtoHeader* pExHdr = (tagExtendProtoHeader*)pExPckg - 1;
				pExHdr->ProtocolType = s2c_extendfriend;
				pExHdr->wLength = pckgsize - 1;

				for (WORD i = 0; i < playercount; i++)
				{
					if (CheckPlayerID(pPlayers[i].lnID, pPlayers[i].nameid))
						m_pServer->PackDataToClient(pPlayers[i].lnID, pExHdr, pckgsize);
				}
			}
		}
	}
	else if (pHeader->ProtocolFamily == pf_tong)
	{
		// ????????????
		if (nSize < sizeof(EXTEND_HEADER))
			return;
		if (pHeader->ProtocolID >= enumS2C_TONG_NUM)
			return;
		if (g_nTongPCSize[pHeader->ProtocolID] < 0)
		{
			if (nSize <= sizeof(EXTEND_HEADER) + 2)
				return;
			WORD	wLength = *((WORD*)((BYTE*)pChar + sizeof(EXTEND_HEADER)));
			if (wLength != nSize)
				return;
		}
		else if (g_nTongPCSize[pHeader->ProtocolID] != nSize)
		{
			return;
		}
		switch (pHeader->ProtocolID)
		{
		case enumS2C_TONG_CREATE_SUCCESS:
			{
				STONG_CREATE_SUCCESS_SYNC	*pSync = (STONG_CREATE_SUCCESS_SYNC*)pChar;
				STONG_SERVER_TO_CORE_CREATE_SUCCESS sSuccess;

				sSuccess.m_nCamp = pSync->m_btCamp;
				sSuccess.m_dwPlayerNameID = pSync->m_dwPlayerNameID;
				sSuccess.m_nPlayerIdx = pSync->m_dwParam;
				memcpy(sSuccess.m_szTongName, pSync->m_szTongName, pSync->m_btTongNameLength);
				sSuccess.m_szTongName[pSync->m_btTongNameLength] = 0;

				if (m_pCoreServerShell->OperationRequest(SSOI_TONG_CREATE, (unsigned int)&sSuccess, 0))
				{
				}
				else
				{
				}
			}
			break;
		case enumS2C_TONG_CREATE_FAIL:
			{
				STONG_CREATE_FAIL_SYNC	*pFail = (STONG_CREATE_FAIL_SYNC*)pChar;
				int		nNetID;
				TONG_CREATE_FAIL_SYNC	sFail;

				sFail.ProtocolType = s2c_extendtong;
				sFail.m_btMsgId = enumTONG_SYNC_ID_CREATE_FAIL;
				sFail.m_btFailId = pFail->m_btFailID;
				sFail.m_wLength = sizeof(sFail) - 1;
				nNetID = m_pCoreServerShell->GetGameData(SGDI_CHARACTER_NETID, pFail->m_dwParam, 0);
				if (m_pServer)
					m_pServer->PackDataToClient(nNetID, &sFail, sFail.m_wLength + 1);
			}
			break;
		case enumS2C_TONG_ADD_MEMBER_SUCCESS:
			{
				STONG_ADD_MEMBER_SUCCESS_SYNC	*pSync = (STONG_ADD_MEMBER_SUCCESS_SYNC*)pChar;
				STONG_SERVER_TO_CORE_ADD_SUCCESS	sAdd;
				sAdd.m_dwPlayerNameID = pSync->m_dwPlayerNameID;
				sAdd.m_nPlayerIdx = pSync->m_dwParam;
				sAdd.m_btCamp = pSync->m_btCamp;
				sAdd.m_dwMoney = pSync->m_dwMoney;
				sAdd.m_btLevel = pSync->m_btLevel;
				sAdd.m_dwTotalEff = pSync->m_dwTotalEff;
				sAdd.m_bRecruit = pSync->m_bRecruit;
				sAdd.m_nMemberNum = pSync->m_nMemberNum;
				sAdd.m_nTongParam = pSync->m_nTongParam;
				sAdd.m_nTongJiyuParam = pSync->m_nTongJiyuParam;
				memcpy(sAdd.m_szMasterName, pSync->m_szMasterName, sizeof(sAdd.m_szMasterName));
				memcpy(sAdd.m_szAgname, pSync->m_szAgname, sizeof(sAdd.m_szAgname));
				memcpy(sAdd.m_szTongName, pSync->m_szTongName, sizeof(sAdd.m_szTongName));
				if (m_pCoreServerShell->OperationRequest(SSOI_TONG_ADD, (unsigned int)&sAdd, 0))
				{
				}
				else
				{
				}
			}
			break;
		case enumS2C_TONG_ADD_MEMBER_FAIL:
			{
				STONG_ADD_MEMBER_FAIL_SYNC	*pSync = (STONG_ADD_MEMBER_FAIL_SYNC*)pChar;
			}
			break;

		case enumS2C_TONG_HEAD_INFO:
			{
				STONG_HEAD_INFO_SYNC	*pInfo = (STONG_HEAD_INFO_SYNC*)pChar;
				if ((int)pInfo->m_dwParam <= 0 || (int)pInfo->m_dwParam >= MAX_PLAYER)
					break;

				int nNetID = m_pCoreServerShell->GetGameData(SGDI_CHARACTER_NETID, pInfo->m_dwParam, 0);
				if (nNetID < 0)
					break;

				TONG_HEAD_INFO_SYNC	sInfo;
				sInfo.ProtocolType		= s2c_extendtong;
				sInfo.m_btMsgId			= enumTONG_SYNC_ID_HEAD_INFO;
				sInfo.m_dwNpcID			= pInfo->m_dwNpcID;
				sInfo.m_dwMoney			= pInfo->m_dwMoney;
				sInfo.m_nCredit			= pInfo->m_nCredit;
				sInfo.m_btCamp			= pInfo->m_btCamp;
				sInfo.m_btLevel			= pInfo->m_btLevel;
				sInfo.m_btDirectorNum	= pInfo->m_btDirectorNum;
				sInfo.m_btManagerNum	= pInfo->m_btManagerNum;
				sInfo.m_dwMemberNum		= pInfo->m_dwMemberNum;
				sInfo.m_nSaveEff		= pInfo->m_nSaveEff;
				sInfo.m_dwTotalEff	= pInfo->m_dwTotalEff;
				sInfo.m_bRecruit		= pInfo->m_bRecruit;
				sInfo.m_nTongParam		= pInfo->m_nTongParam;
				memcpy(sInfo.m_szTongName, pInfo->m_szTongName, sizeof(pInfo->m_szTongName));
				sInfo.m_nTongJiyuParam 		= pInfo->m_nTongJiyuParam;
				memcpy(sInfo.m_szTongJiyuNotify, pInfo->m_szTongJiyuNotify, sizeof(pInfo->m_szTongJiyuNotify));
				memset(sInfo.m_sMember, 0, sizeof(sInfo.m_sMember));
				memcpy(sInfo.m_sMember, pInfo->m_sMember, sizeof(TONG_ONE_LEADER_INFO) * (1 + sInfo.m_btDirectorNum));
				sInfo.m_wLength = sizeof(sInfo) - 1 - sizeof(sInfo.m_sMember) + sizeof(TONG_ONE_LEADER_INFO) * (1 + sInfo.m_btDirectorNum);
				if (m_pServer)
					m_pServer->PackDataToClient(nNetID, &sInfo, sInfo.m_wLength + 1);
			}
			break;

		case enumS2C_TONG_MANAGER_INFO:
			{
				STONG_MANAGER_INFO_SYNC	*pInfo = (STONG_MANAGER_INFO_SYNC*)pChar;
				if ((int)pInfo->m_dwParam <= 0 || (int)pInfo->m_dwParam >= MAX_PLAYER)
					break;

				int nNetID = m_pCoreServerShell->GetGameData(SGDI_CHARACTER_NETID, pInfo->m_dwParam, 0);
				if (nNetID < 0)
					break;

				TONG_MANAGER_INFO_SYNC	sInfo;
				sInfo.ProtocolType		= s2c_extendtong;
				sInfo.m_btMsgId			= enumTONG_SYNC_ID_MANAGER_INFO;
				sInfo.m_dwMoney			= pInfo->m_dwMoney;
				sInfo.m_nCredit			= pInfo->m_nCredit;
				sInfo.m_btCamp			= pInfo->m_btCamp;
				sInfo.m_btLevel			= pInfo->m_btLevel;
				sInfo.m_btDirectorNum	= pInfo->m_btDirectorNum;
				sInfo.m_btManagerNum	= pInfo->m_btManagerNum;
				sInfo.m_dwMemberNum		= pInfo->m_dwMemberNum;
				sInfo.m_btStateNo		= pInfo->m_btStartNo;
				sInfo.m_btCurNum		= pInfo->m_btCurNum;
				memcpy(sInfo.m_szTongName, pInfo->m_szTongName, sizeof(pInfo->m_szTongName));
				memset(sInfo.m_sMember, 0, sizeof(sInfo.m_sMember));
				memcpy(sInfo.m_sMember, pInfo->m_sMember, sizeof(TONG_ONE_LEADER_INFO) * sInfo.m_btCurNum);
				sInfo.m_wLength = sizeof(sInfo) - 1 - sizeof(TONG_ONE_LEADER_INFO) * (defTONG_ONE_PAGE_MAX_NUM - sInfo.m_btCurNum);
				if (m_pServer)
					m_pServer->PackDataToClient(nNetID, &sInfo, sInfo.m_wLength + 1);
			}
			break;

		case enumS2C_TONG_MEMBER_INFO:
			{
				STONG_MEMBER_INFO_SYNC	*pInfo = (STONG_MEMBER_INFO_SYNC*)pChar;
				if ((int)pInfo->m_dwParam <= 0 || (int)pInfo->m_dwParam >= MAX_PLAYER)
					break;

				int nNetID = m_pCoreServerShell->GetGameData(SGDI_CHARACTER_NETID, pInfo->m_dwParam, 0);
				if (nNetID < 0)
					break;

				TONG_MEMBER_INFO_SYNC	sInfo;
				sInfo.ProtocolType		= s2c_extendtong;
				sInfo.m_btMsgId			= enumTONG_SYNC_ID_MEMBER_INFO;
				sInfo.m_dwMoney			= pInfo->m_dwMoney;
				sInfo.m_nCredit			= pInfo->m_nCredit;
				sInfo.m_btCamp			= pInfo->m_btCamp;
				sInfo.m_btLevel			= pInfo->m_btLevel;
				sInfo.m_btDirectorNum	= pInfo->m_btDirectorNum;
				sInfo.m_btManagerNum	= pInfo->m_btManagerNum;
				sInfo.m_dwMemberNum		= pInfo->m_dwMemberNum;
				sInfo.m_btStateNo		= pInfo->m_btStartNo;
				sInfo.m_btCurNum		= pInfo->m_btCurNum;
				memcpy(sInfo.m_szAgname, pInfo->m_szAgname, sizeof(pInfo->m_szAgname));
				memcpy(sInfo.m_szTongName, pInfo->m_szTongName, sizeof(pInfo->m_szTongName));
				memcpy(sInfo.m_szMaleAgname, pInfo->m_szMaleAgname, sizeof(pInfo->m_szMaleAgname));
				memcpy(sInfo.m_szFemaleAgname, pInfo->m_szFemaleAgname, sizeof(pInfo->m_szFemaleAgname));
				memset(sInfo.m_sMember, 0, sizeof(sInfo.m_sMember));
				/*for (int i=0; i<sInfo.m_btCurNum;i++)
					printf("%s\n",sInfo.m_sMember[i].m_szName);*/
				memcpy(sInfo.m_sMember, pInfo->m_sMember, sizeof(TONG_ONE_MEMBER_INFO) * sInfo.m_btCurNum);
				sInfo.m_wLength = sizeof(sInfo) - 1 - sizeof(TONG_ONE_MEMBER_INFO) * (defTONG_ONE_PAGE_MAX_NUM - sInfo.m_btCurNum);
				if (m_pServer)
					m_pServer->PackDataToClient(nNetID, &sInfo, sInfo.m_wLength + 1);
			}
			break;

		case enumS2C_TONG_BE_INSTATED:
			{
				STONG_BE_INSTATED_SYNC	*pSync = (STONG_BE_INSTATED_SYNC*)pChar;
				if (m_pGameStatus[pSync->m_dwParam].nPlayerIndex <= 0)
					break;
				STONG_SERVER_TO_CORE_BE_INSTATED	sInstated;
				sInstated.m_nPlayerIdx = m_pGameStatus[pSync->m_dwParam].nPlayerIndex;
				sInstated.m_btFigure = pSync->m_btFigure;
				sInstated.m_btPos = pSync->m_btPos;
				memcpy(sInstated.m_szName, pSync->m_szName, sizeof(pSync->m_szName));
				memcpy(sInstated.m_szAgname, pSync->m_szAgname, sizeof(pSync->m_szAgname));
				m_pCoreServerShell->GetGameData(SGDI_TONG_BE_INSTATED, (unsigned int)&sInstated, 0);
			}
			break;

		case enumS2C_TONG_INSTATE:
			{
				STONG_INSTATE_SYNC	*pSync = (STONG_INSTATE_SYNC*)pChar;
				TONG_INSTATE_SYNC	sInstate;

				if ((int)pSync->m_dwParam <= 0 || (int)pSync->m_dwParam >= MAX_PLAYER)
					break;

				int nNetID = m_pCoreServerShell->GetGameData(SGDI_CHARACTER_NETID, pSync->m_dwParam, 0);
				if (nNetID < 0)
					break;

				sInstate.ProtocolType		= s2c_extendtong;
				sInstate.m_btMsgId			= enumTONG_SYNC_ID_INSTATE;
				sInstate.m_wLength			= sizeof(sInstate) - 1;
				sInstate.m_dwTongNameID		= pSync->m_dwTongNameID;
				sInstate.m_btSuccessFlag	= pSync->m_btSuccessFlag;
				sInstate.m_btOldFigure		= pSync->m_btOldFigure;
				sInstate.m_btOldPos			= pSync->m_btOldPos;
				sInstate.m_btNewFigure		= pSync->m_btNewFigure;
				sInstate.m_btNewPos			= pSync->m_btNewPos;
				memcpy(sInstate.m_szAgname, pSync->m_szAgname, sizeof(pSync->m_szAgname));
				memcpy(sInstate.m_szName, pSync->m_szName, sizeof(pSync->m_szName));

				if (m_pServer)
					m_pServer->PackDataToClient(nNetID, &sInstate, sInstate.m_wLength + 1);
			}
			break;
		case enumS2C_TONG_KICK:
			{
				STONG_KICK_SYNC	*pSync = (STONG_KICK_SYNC*)pChar;
				TONG_KICK_SYNC	sKick;

				if ((int)pSync->m_dwParam <= 0 || (int)pSync->m_dwParam >= MAX_PLAYER)
					break;

				int nNetID = m_pCoreServerShell->GetGameData(SGDI_CHARACTER_NETID, pSync->m_dwParam, 0);
				if (nNetID < 0)
					break;

				sKick.ProtocolType		= s2c_extendtong;
				sKick.m_btMsgId			= enumTONG_SYNC_ID_KICK;
				sKick.m_wLength			= sizeof(sKick) - 1;
				sKick.m_dwTongNameID	= pSync->m_dwTongNameID;
				sKick.m_btSuccessFlag	= pSync->m_btSuccessFlag;
				sKick.m_btFigure		= pSync->m_btFigure;
				sKick.m_btPos			= pSync->m_btPos;
				memcpy(sKick.m_szName, pSync->m_szName, sizeof(pSync->m_szName));

				if (m_pServer)
					m_pServer->PackDataToClient(nNetID, &sKick, sKick.m_wLength + 1);
			}
			break;
		case enumS2C_TONG_BE_KICKED:
			{
				STONG_BE_KICKED_SYNC	*pSync = (STONG_BE_KICKED_SYNC*)pChar;
				if (m_pGameStatus[pSync->m_dwParam].nPlayerIndex <= 0)
					break;
				STONG_SERVER_TO_CORE_BE_KICKED	sKicked;
				sKicked.m_nPlayerIdx = m_pGameStatus[pSync->m_dwParam].nPlayerIndex;
				sKicked.m_btFigure = pSync->m_btFigure;
				sKicked.m_btPos = pSync->m_btPos;
				memcpy(sKicked.m_szName, pSync->m_szName, sizeof(pSync->m_szName));
				m_pCoreServerShell->GetGameData(SGDI_TONG_BE_KICKED, (unsigned int)&sKicked, 0);
			}
			break;
		case enumS2C_TONG_LEAVE:
			{
				STONG_LEAVE_SYNC	*pSync = (STONG_LEAVE_SYNC*)pChar;
				STONG_SERVER_TO_CORE_LEAVE	sLeave;
				sLeave.m_nPlayerIdx = pSync->m_dwParam;
				sLeave.m_bSuccessFlag = pSync->m_btSuccessFlag;
				memcpy(sLeave.m_szName, pSync->m_szName, sizeof(pSync->m_szName));
				m_pCoreServerShell->GetGameData(SGDI_TONG_LEAVE, (unsigned int)&sLeave, 0);
			}
			break;
		case enumS2C_TONG_CHECK_CHANGE_MASTER_POWER:
			{
				STONG_CHECK_GET_MASTER_POWER_SYNC	*pSync = (STONG_CHECK_GET_MASTER_POWER_SYNC*)pChar;
				if (m_pGameStatus[pSync->m_dwParam].nPlayerIndex <= 0)
					break;
				STONG_SERVER_TO_CORE_CHECK_GET_MASTER_POWER	sCheck;
				sCheck.m_dwTongNameID	= pSync->m_dwTongNameID;
				sCheck.m_btFigure		= pSync->m_btFigure;
				sCheck.m_btPos			= pSync->m_btPos;
				sCheck.m_nPlayerIdx		= m_pGameStatus[pSync->m_dwParam].nPlayerIndex;
				memcpy(sCheck.m_szName, pSync->m_szName, sizeof(pSync->m_szName));

				int nRet = 0;
				if (m_pCoreServerShell)
					nRet = m_pCoreServerShell->GetGameData(SGDI_TONG_GET_MASTER_POWER, (unsigned int)&sCheck, 0);

				STONG_ACCEPT_MASTER_COMMAND	sAccept;

				sAccept.ProtocolFamily	= pf_tong;
				sAccept.ProtocolID		= enumC2S_TONG_ACCEPT_MASTER;
				sAccept.m_dwParam		= m_pGameStatus[pSync->m_dwParam].nPlayerIndex;
				sAccept.m_dwTongNameID	= pSync->m_dwTongNameID;
				sAccept.m_btFigure		= pSync->m_btFigure;
				sAccept.m_btPos			= pSync->m_btPos;
				if (nRet)
					sAccept.m_btAcceptFalg = 1;
				else
					sAccept.m_btAcceptFalg = 0;
				memcpy(sAccept.m_szName, pSync->m_szName, sizeof(pSync->m_szName));

				if (m_pTongClient)
					m_pTongClient->SendPackToServer((const void*)&sAccept, sizeof(sAccept));
			}
			break;
		case enumS2C_TONG_CHANGE_MASTER_FAIL:
			{
				STONG_CHANGE_MASTER_FAIL_SYNC	*pFail = (STONG_CHANGE_MASTER_FAIL_SYNC*)pChar;
				int nPlayer = pFail->m_dwParam;
				switch (pFail->m_btFailID)
				{
				case 0:
					break;
				case 1:
					nPlayer = m_pGameStatus[pFail->m_dwParam].nPlayerIndex;
					break;
				default:
					break;
				}

				if (nPlayer <= 0 || nPlayer >= MAX_PLAYER)
					break;
				int nNetID = m_pCoreServerShell->GetGameData(SGDI_CHARACTER_NETID, nPlayer, 0);
				if (nNetID < 0)
					break;

				TONG_CHANGE_MASTER_FAIL_SYNC	sFail;
				sFail.ProtocolType		= s2c_extendtong;
				sFail.m_btMsgId			= enumTONG_SYNC_ID_CHANGE_MASTER_FAIL;
				sFail.m_wLength			= sizeof(sFail) - 1;
				sFail.m_dwTongNameID	= pFail->m_dwTongNameID;
				sFail.m_btFailID		= pFail->m_btFailID;
				memcpy(sFail.m_szName, pFail->m_szName, sizeof(pFail->m_szName));
				if (m_pServer)
					m_pServer->PackDataToClient(nNetID, &sFail, sFail.m_wLength + 1);
			}
			break;
		case enumS2C_TONG_CHANGE_AS:
			{
				STONG_CHANGE_AS_SYNC	*pAs = (STONG_CHANGE_AS_SYNC*)pChar;
				if (m_pGameStatus[pAs->m_dwParam].nPlayerIndex <= 0)
					break;
				STONG_SERVER_TO_CORE_CHANGE_AS	sChange;
				sChange.m_nPlayerIdx = m_pGameStatus[pAs->m_dwParam].nPlayerIndex;
				sChange.m_dwTongNameID = pAs->m_dwTongNameID;
				sChange.m_btFigure = pAs->m_btFigure;
				sChange.m_btPos = pAs->m_btPos;
				// ????????????
				memcpy(sChange.m_szAgname, pAs->m_szAgname, sizeof(pAs->m_szAgname));
				// ????????????
				memcpy(sChange.m_szName, pAs->m_szName, sizeof(pAs->m_szName));
				m_pCoreServerShell->GetGameData(SGDI_TONG_CHANGE_AS, (unsigned int)&sChange, 0);
			}
			break;
		case enumS2C_TONG_CHANGE_MASTER:
			{
				STONG_CHANGE_MASTER_SYNC	*pMaster = (STONG_CHANGE_MASTER_SYNC*)pChar;
				STONG_SERVER_TO_CORE_CHANGE_MASTER	sChange;
				sChange.m_dwTongNameID = pMaster->m_dwTongNameID;
				memcpy(sChange.m_szName, pMaster->m_szName, sizeof(pMaster->m_szName));
				m_pCoreServerShell->GetGameData(SGDI_TONG_CHANGE_MASTER, (unsigned int)&sChange, 0);
			}
			break;
		case enumS2C_TONG_MONEY_SAVE:
			{
				STONG_MONEY_SYNC	*pMoney = (STONG_MONEY_SYNC*)pChar;
				STONG_SERVER_TO_CORE_MONEY pChange;
				pChange.m_dwTongNameID = pMoney->m_dwTongNameID;
				pChange.m_dwMoney = pMoney->m_dwMoney;
				pChange.m_nMoney = pMoney->m_nMoney;
				pChange.nType = 0;
				pChange.m_nPlayerIdx = pMoney->m_dwParam;
				if (pChange.m_nPlayerIdx <= 0)
					break;
				m_pCoreServerShell->GetGameData(SGDI_TONG_CHANGE_MONEY, (unsigned int)&pChange, 0);
			}
			break;
		case enumS2C_TONG_MONEY_GET:
			{
				STONG_MONEY_SYNC	*pMoney = (STONG_MONEY_SYNC*)pChar;
				STONG_SERVER_TO_CORE_MONEY pChange;
				pChange.m_dwTongNameID = pMoney->m_dwTongNameID;
				pChange.m_dwMoney = pMoney->m_dwMoney;
				pChange.m_nMoney = pMoney->m_nMoney;
				pChange.nType = 1;
				pChange.m_nPlayerIdx = pMoney->m_dwParam;
				if (pChange.m_nPlayerIdx <= 0)
					break;
				m_pCoreServerShell->GetGameData(SGDI_TONG_CHANGE_MONEY, (unsigned int)&pChange, 0);
			}
			break;
		case enumS2C_TONG_LOGIN_DATA:
			{
				STONG_LOGIN_DATA_SYNC	*pLogin = (STONG_LOGIN_DATA_SYNC*)pChar;
				STONG_SERVER_TO_CORE_LOGIN	sLogin;
				sLogin.m_dwParam	= pLogin->m_dwParam;
				sLogin.m_nFlag		= pLogin->m_btFlag;
				sLogin.m_nCamp		= pLogin->m_btCamp;
				sLogin.m_nFigure	= pLogin->m_btFigure;
				sLogin.m_nPos		= pLogin->m_btPos;
				sLogin.m_dwMemberNum	= pLogin->m_dwMemberNum;
				sLogin.m_btManagerNum	= pLogin->m_btManagerNum;
				sLogin.m_btDirectorNum	= pLogin->m_btDirectorNum;
				sLogin.m_nMoney		= pLogin->m_nMoney;
				sLogin.m_btLevel	= pLogin->m_btLevel;
				sLogin.m_nSaveEff = pLogin->m_nSaveEff;
				sLogin.m_dwTotalEff = pLogin->m_dwTotalEff;
				sLogin.m_bRecruit = pLogin->m_bRecruit;
				sLogin.m_nTongParam = pLogin->m_nTongParam;
				sLogin.m_nJoinTm = pLogin->m_nJoinTm;
				memcpy(sLogin.m_szTongName, pLogin->m_szTongName, sizeof(pLogin->m_szTongName));
				memcpy(sLogin.m_szAgname, pLogin->m_szAgname, sizeof(pLogin->m_szAgname));
				memcpy(sLogin.m_szMaster, pLogin->m_szMaster, sizeof(pLogin->m_szMaster));
				memcpy(sLogin.m_szName, pLogin->m_szName, sizeof(pLogin->m_szName));
				sLogin.m_nTongJiyuParam = pLogin->m_nTongJiyuParam;
				memcpy(sLogin.m_szTongJiyuNotify, pLogin->m_szTongJiyuNotify, sizeof(pLogin->m_szTongJiyuNotify));
				m_pCoreServerShell->GetGameData(SGDI_TONG_LOGIN, (unsigned int)&sLogin, 0);
			}
			break;
		case enumS2C_TONG_CHANGE_AGNAME_FAIL:
			{
				STONG_CHANGE_AGNAME_FAIL_SYNC	*pFail = (STONG_CHANGE_AGNAME_FAIL_SYNC*)pChar;
				int nPlayer = pFail->m_dwParam;
				switch (pFail->m_btFailID)
				{
				case 0:
					break;
				case 1:
					nPlayer = m_pGameStatus[pFail->m_dwParam].nPlayerIndex;
					break;
				default:
					break;
				}

				if (nPlayer <= 0 || nPlayer >= MAX_PLAYER)
					break;
				int nNetID = m_pCoreServerShell->GetGameData(SGDI_CHARACTER_NETID, nPlayer, 0);
				if (nNetID < 0)
					break;

				TONG_CHANGE_AGNAME_FAIL_SYNC	sFail;
				sFail.ProtocolType		= s2c_extendtong;
				sFail.m_btMsgId			= enumTONG_SYNC_ID_CHANGE_AGNAME_FAIL;
				sFail.m_wLength			= sizeof(sFail) - 1;
				sFail.m_dwTongNameID	= pFail->m_dwTongNameID;
				sFail.m_btFailID		= pFail->m_btFailID;
				memcpy(sFail.m_szName, pFail->m_szName, sizeof(pFail->m_szName));
				if (m_pServer)
					m_pServer->PackDataToClient(nNetID, &sFail, sFail.m_wLength + 1);
			}
			break;
		case enumS2C_TONG_CHECK_CHANGE_AGNAME_POWER:
			{
				STONG_CHECK_GET_AGNAME_POWER_SYNC	*pSync = (STONG_CHECK_GET_AGNAME_POWER_SYNC*)pChar;
				if (m_pGameStatus[pSync->m_dwParam].nPlayerIndex <= 0)
					break;
				STONG_SERVER_TO_CORE_CHECK_GET_AGNAME_POWER	sCheck;
				sCheck.m_dwTongNameID	= pSync->m_dwTongNameID;
				sCheck.m_btFigure		= pSync->m_btFigure;
				sCheck.m_btPos			= pSync->m_btPos;
				sCheck.m_nPlayerIdx		= m_pGameStatus[pSync->m_dwParam].nPlayerIndex;
				memcpy(sCheck.m_szName, pSync->m_szName, sizeof(pSync->m_szName));
				memcpy(sCheck.m_szAgname, pSync->m_szAgname, sizeof(pSync->m_szAgname));

				int nRet = 0;
				if (m_pCoreServerShell)
					nRet = m_pCoreServerShell->GetGameData(SGDI_TONG_GET_AGNAME_POWER, (unsigned int)&sCheck, 0);
				STONG_ACCEPT_AGNAME_COMMAND	sAccept;
				sAccept.ProtocolFamily	= pf_tong;
				sAccept.ProtocolID		= enumC2S_TONG_ACCEPT_AGNAME;
				sAccept.m_dwParam		= m_pGameStatus[pSync->m_dwParam].nPlayerIndex;
				sAccept.m_dwTongNameID	= pSync->m_dwTongNameID;
				sAccept.m_btFigure		= pSync->m_btFigure;
				sAccept.m_btPos			= pSync->m_btPos;
				if (nRet)
					sAccept.m_btAcceptFalg = 1;
				else
					sAccept.m_btAcceptFalg = 0;
				memcpy(sAccept.m_szName, pSync->m_szName, sizeof(pSync->m_szName));
				memcpy(sAccept.m_szAgname, pSync->m_szAgname, sizeof(pSync->m_szAgname));

				if (m_pTongClient)
					m_pTongClient->SendPackToServer((const void*)&sAccept, sizeof(sAccept));
			}
			break;
		case enumS2C_TONG_BE_CHANGED_AGNAME:
			{
				STONG_BE_CHANGED_AGNAME_SYNC	*pSync = (STONG_BE_CHANGED_AGNAME_SYNC*)pChar;
				if (m_pGameStatus[pSync->m_dwParam].nPlayerIndex <= 0)
					break;
				STONG_SERVER_TO_CORE_BE_CHANGED_AGNAME	sSync;
				sSync.m_nPlayerIdx = m_pGameStatus[pSync->m_dwParam].nPlayerIndex;
				memcpy(sSync.m_szAgname, pSync->m_szAgname, sizeof(pSync->m_szAgname));
				m_pCoreServerShell->GetGameData(SGDI_TONG_BE_CHANGED_AGNAME, (unsigned int)&sSync, 0);
			}
			break;
		case enumS2C_TONG_BE_CHANGED_CAMP:
			{
				STONG_BE_CHANGED_CAMP_SYNC	*pSync = (STONG_BE_CHANGED_CAMP_SYNC*)pChar;
				if (pSync->m_dwParam <= 0)
					break;
				STONG_SERVER_TO_CORE_BE_CHANGED_CAMP	sSync;
				sSync.m_dwTongNameID = pSync->m_dwTongNameID;
				sSync.m_nMoney = pSync->m_nMoney;
				sSync.m_nCamp = pSync->m_btCamp;
				m_pCoreServerShell->GetGameData(SGDI_TONG_BE_CHANGED_CAMP, (unsigned int)&sSync, 0);
			}
			break;
		case enumS2C_TONG_BE_CHANGED_LEVEL:
			{
				STONG_CHANGE_TONG_INFO_SYNC	*pSync = (STONG_CHANGE_TONG_INFO_SYNC*)pChar;
				if (pSync->m_dwParam <= 0)
					break;
				STONG_SERVER_TO_CORE_BE_CHANGED_LEVEL	sSync;
				sSync.m_dwTongNameID = pSync->m_dwTongNameID;
				sSync.m_btLevel = pSync->m_nValue;
				m_pCoreServerShell->GetGameData(SGDI_TONG_BE_CHANGED_LEVEL, (unsigned int)&sSync, 0);
			}
			break;
		case enumS2C_TONG_BE_CHANGED_MONEY:
			{
				STONG_CHANGE_TONG_INFO_SYNC	*pSync = (STONG_CHANGE_TONG_INFO_SYNC*)pChar;
				if (pSync->m_dwParam <= 0)
					break;
				STONG_SERVER_TO_CORE_BE_CHANGED_MONEY	sSync;
				sSync.m_dwTongNameID = pSync->m_dwTongNameID;
				sSync.m_nMoney = pSync->m_nValue;
				m_pCoreServerShell->GetGameData(SGDI_TONG_BE_CHANGED_MONEY, (unsigned int)&sSync, 0);
			}
			break;
		case enumS2C_TONG_BE_CHANGED_EFF:
			{
				STONG_CHANGE_TONG_INFO_SYNC	*pSync = (STONG_CHANGE_TONG_INFO_SYNC*)pChar;
				if (pSync->m_dwParam <= 0)
					break;
				STONG_SERVER_TO_CORE_BE_CHANGED_TONG_EFF	sSync;
				sSync.m_dwTongNameID = pSync->m_dwTongNameID;
				sSync.m_nEff = pSync->m_nValue;
				m_pCoreServerShell->GetGameData(SGDI_TONG_BE_CHANGED_TONG_EFF, (unsigned int)&sSync, 0);
			}
			break;
		case enumS2C_TONG_BE_CHANGED_RECRUIT:
			{
				STONG_CHANGE_TONG_INFO_SYNC	*pSync = (STONG_CHANGE_TONG_INFO_SYNC*)pChar;
				STONG_SERVER_TO_CORE_BE_CHANGED_RECRUIT	sSync;
				sSync.m_dwTongNameID = pSync->m_dwTongNameID;
				sSync.m_bRecruit = pSync->m_nValue;
				m_pCoreServerShell->GetGameData(SGDI_TONG_BE_CHANGED_RECRUIT, (unsigned int)&sSync, 0);
			}
			break;
		case enumS2C_TONG_BE_CHANGED_TONGPARAM:
			{
				STONG_CHANGE_TONG_INFO_SYNC	*pSync = (STONG_CHANGE_TONG_INFO_SYNC*)pChar;
				STONG_SERVER_TO_CORE_BE_CHANGED_TONGPARAM	sSync;
				sSync.m_dwTongNameID = pSync->m_dwTongNameID;
				sSync.m_nTongParam = pSync->m_nValue;
				m_pCoreServerShell->GetGameData(SGDI_TONG_BE_CHANGED_TONGPARAM, (unsigned int)&sSync, 0);
			}
			break;
		case enumS2C_TONG_BE_CHANGED_JIYU:
			{
				STONG_CHANGE_TONG_INFO_SYNC	*pSync = (STONG_CHANGE_TONG_INFO_SYNC*)pChar;

				STONG_SERVER_TO_CORE_BE_CHANGED_JIYU	sSync;
				sSync.m_dwTongNameID = pSync->m_dwTongNameID;
				sSync.m_nMoney = pSync->m_nValue;
				sSync.m_nTongJiyuParam = pSync->m_nTongJiyuParam;
				strcpy(sSync.m_szTongJiyuNotify, pSync->m_szTongJiyuNotify);
				m_pCoreServerShell->GetGameData(SGDI_TONG_BE_CHANGED_JIYU, (unsigned int)&sSync, 0);
			}
			break;
		case enumS2C_TONG_BE_CHANGED_MEMBEREFF:
			{
				STONG_CHANGE_TONG_MEMBEREFF_SYNC	*pSync = (STONG_CHANGE_TONG_MEMBEREFF_SYNC*)pChar;
				STONG_SERVER_TO_CORE_BE_CHANGED_EFF	sSync;
				sSync.m_dwTongNameID = pSync->m_dwTongNameID;
				sSync.m_nPlayerIdx = pSync->m_dwParam;
				sSync.m_nTotalEff = pSync->m_nTotalEff;
				sSync.m_dwTotalEff = pSync->m_dwTotalEff;
				if (sSync.m_nPlayerIdx <= 0)
					break;
				m_pCoreServerShell->GetGameData(SGDI_TONG_BE_CHANGED_EFF, (unsigned int)&sSync, 0);
			}
			break;
		case enumS2C_SET_EXTPOINT://TamLTM fix xu;
			{
				STONG_GET_EXTPOINT_SYNC* pExt = (STONG_GET_EXTPOINT_SYNC*)pChar;
				int nIndex = pExt->m_dwParam;
				int nExtPoint = pExt->m_nExtPoint;
				if (nIndex <= 0 || nIndex >= MAX_PLAYER)
					break;
				m_pCoreServerShell->SetExtPoint(nIndex, nExtPoint);
			}
			break;
		default:
			break;
		}
	}
	else if (pHeader->ProtocolFamily == pf_friend)
	{
	}
}

BOOL KSwordOnLineSever::RegisterRelayMaps()
{
	if (!m_pCoreServerShell || !m_RelayClient.IsRegistered())
		return FALSE;

	short MapIds[255];
	ZeroMemory(MapIds, sizeof(MapIds));
	const int nMapCount = m_pCoreServerShell->GetGameData(
		SGDI_LOADEDMAP_ID, (unsigned int)MapIds, sizeof(MapIds));
	if (nMapCount <= 0 || nMapCount > 255)
		return FALSE;

	for (int i = 0; i < nMapCount; ++i)
	{
		if (MapIds[i] <= 0 ||
			!m_RelayClient.BindMap(
				(PHONGTHAN_U32)MapIds[i],
				(PHONGTHAN_U32)MapIds[i],
				(PHONGTHAN_U32)m_dwInternetIp,
				(unsigned short)m_nServerPort,
				true))
		{
			return FALSE;
		}
	}
	return m_RelayClient.Pump() ? TRUE : FALSE;
}

void KSwordOnLineSever::RelayMessageProcess(
	const char* pChar, size_t nSize)
{
	if (!pChar || nSize < sizeof(PHONGTHAN_WIRE_HEADER) ||
		nSize > PHONGTHAN_WIRE_MAX_PACKET_SIZE)
	{
		GameServerLoginDiag("native_relay_packet_rejected size=%u",
			(unsigned int)nSize);
		return;
	}

	const PHONGTHAN_WIRE_HEADER* pHeader =
		(const PHONGTHAN_WIRE_HEADER*)pChar;
	if (!PhongThanValidateWireHeader(
			pHeader, (PHONGTHAN_U32)nSize) ||
		pHeader->PacketSize != nSize)
	{
		GameServerLoginDiag("native_relay_packet_rejected invalid_header");
		return;
	}

	switch (pHeader->MessageType)
	{
	case PHONGTHAN_MSG_RELAY_ROUTE_RESULT:
		if (!PhongThanValidateRelayFixedPacket(
			pHeader, (PHONGTHAN_U32)nSize,
			PHONGTHAN_MSG_RELAY_ROUTE_RESULT,
			sizeof(PHONGTHAN_RELAY_ROUTE_RESULT)))
		{
			GameServerLoginDiag(
				"native_relay_route_result_rejected invalid_size");
		}
		break;

	case PHONGTHAN_MSG_RELAY_TRANSFER_PREPARE:
		{
			const PHONGTHAN_RELAY_TRANSFER_PREPARE_HEADER* pTransfer =
				(const PHONGTHAN_RELAY_TRANSFER_PREPARE_HEADER*)pChar;
			PHONGTHAN_RELAY_TRANSFER_RESULT Result;
			ZeroMemory(&Result, sizeof(Result));
			Result.TargetServiceId = m_RelayClient.GetServiceId();
			Result.Result = PHONGTHAN_RELAY_INVALID_PACKET;

			int nAddedIndex = 0;
			if (PhongThanValidateRelayTransferPacket(
					pTransfer, (PHONGTHAN_U32)nSize) &&
				pTransfer->TargetServiceId == m_RelayClient.GetServiceId())
			{
				Result.TransferId = pTransfer->TransferId;
				const PHONGTHAN_CHARACTER_STATE_HEADER* pState =
					(const PHONGTHAN_CHARACTER_STATE_HEADER*)
						((const PHONGTHAN_U8*)pChar + sizeof(*pTransfer));
				KCoreConnectInfo Info;
				ZeroMemory(&Info, sizeof(Info));
				m_pCoreServerShell->GetConnectInfo(&Info);
				if (strncmp((const char*)pTransfer->RoleName,
						(const char*)pState->RoleName,
						PHONGTHAN_RELAY_ROLE_NAME_SIZE) != 0 ||
					pState->EnterMapId !=
						(PHONGTHAN_S32)pTransfer->DestinationMapId)
				{
					Result.Result = PHONGTHAN_RELAY_INVALID_PACKET;
				}
				else if (Info.nNumPlayer >= m_nMaxPlayer)
				{
					Result.Result = PHONGTHAN_RELAY_CAPACITY_EXCEEDED;
				}
				else
				{
					nAddedIndex = m_pCoreServerShell->AddCharacter(
						 pTransfer->ExtensionPoint,
						 pTransfer->ChangedExtensionPoint,
						 (void*)pState, pTransfer->StateSize,
						 pTransfer->SessionTicket);
					Result.Result = nAddedIndex > 0 ?
						PHONGTHAN_RELAY_SUCCESS :
						PHONGTHAN_RELAY_STATE_CONFLICT;
					if (nAddedIndex > 0)
					{
						RememberPhongThanRelaySession(
							nAddedIndex,
							pTransfer->SessionTicket,
							pState);
						if (!NotifyGatewayWorldSession(nAddedIndex,
								PHONGTHAN_WORLD_SESSION_TRANSFER_REBIND,
								PHONGTHAN_WORLD_SESSION_REASON_TRANSFER,
								FALSE, pTransfer->TransferId,
								(PHONGTHAN_S32)pTransfer->DestinationMapId))
						{
							m_pCoreServerShell->PreparePlayerForLoginFailed(
								nAddedIndex);
							g_PhongThanRelaySessions.erase(nAddedIndex);
							nAddedIndex = 0;
							Result.Result = PHONGTHAN_RELAY_STATE_CONFLICT;
						}
						else
						{
							PHONGTHAN_INBOUND_TRANSFER Pending;
							Pending.PlayerIndex = nAddedIndex;
							Pending.StartedAt = GetTickCount();
							g_PhongThanInboundTransfers[
								pTransfer->TransferId] = Pending;
						}
					}
				}
			}

			PhongThanInitializeWireHeader(&Result.Header,
				PHONGTHAN_MSG_RELAY_TRANSFER_RESULT, sizeof(Result),
				Result.Result == PHONGTHAN_RELAY_SUCCESS ?
					PHONGTHAN_WIRE_FLAG_RESPONSE :
					(PHONGTHAN_WIRE_FLAG_RESPONSE |
					 PHONGTHAN_WIRE_FLAG_ERROR),
				pHeader->Sequence);
			if (Result.Result == PHONGTHAN_RELAY_SUCCESS)
			{
				Result.AddressV4 = (PHONGTHAN_U32)m_dwInternetIp;
				Result.Port = (PHONGTHAN_U16)m_nServerPort;
				memcpy(Result.SessionTicket,
					pTransfer->SessionTicket,
					PHONGTHAN_SESSION_TICKET_SIZE);
			}
			if (!m_RelayClient.Send(&Result, sizeof(Result)) &&
				nAddedIndex > 0)
			{
				NotifyGatewayWorldSession(nAddedIndex,
					PHONGTHAN_WORLD_SESSION_TRANSFER_ABORT,
					PHONGTHAN_WORLD_SESSION_REASON_TRANSFER,
					FALSE, pTransfer->TransferId,
					(PHONGTHAN_S32)pTransfer->DestinationMapId);
				m_pCoreServerShell->PreparePlayerForLoginFailed(
					nAddedIndex);
				g_PhongThanInboundTransfers.erase(
					pTransfer->TransferId);
				g_PhongThanRelaySessions.erase(nAddedIndex);
			}
		}
		break;

	case PHONGTHAN_MSG_RELAY_TRANSFER_RESULT:
		{
			const PHONGTHAN_RELAY_TRANSFER_RESULT* pResult =
				(const PHONGTHAN_RELAY_TRANSFER_RESULT*)pChar;
			if (!PhongThanValidateRelayFixedPacket(
					&pResult->Header, (PHONGTHAN_U32)nSize,
					PHONGTHAN_MSG_RELAY_TRANSFER_RESULT,
					sizeof(*pResult)))
			{
				GameServerLoginDiag(
					"native_transfer_result_rejected invalid_size");
				break;
			}
			PHONGTHAN_OUTBOUND_TRANSFER_MAP::iterator PendingIt =
				g_PhongThanOutboundTransfers.find(pResult->TransferId);
			if (PendingIt == g_PhongThanOutboundTransfers.end())
				break;
			PHONGTHAN_OUTBOUND_TRANSFER Pending = PendingIt->second;
			bool bSuccess = pResult->Result == PHONGTHAN_RELAY_SUCCESS &&
				pResult->AddressV4 && pResult->Port &&
				memcmp(pResult->SessionTicket, Pending.SessionTicket,
					PHONGTHAN_SESSION_TICKET_SIZE) == 0;

			if (bSuccess)
			{
				bSuccess = NotifyGatewayWorldSession(Pending.PlayerIndex,
					PHONGTHAN_WORLD_SESSION_TRANSFER_HOLD,
					PHONGTHAN_WORLD_SESSION_REASON_TRANSFER,
					FALSE, Pending.TransferId,
					(PHONGTHAN_S32)Pending.DestinationMapId) != FALSE;
			}
			if (bSuccess)
			{
				PHONGTHAN_RELAY_TRANSFER_COMMIT Commit;
				ZeroMemory(&Commit, sizeof(Commit));
				PhongThanInitializeWireHeader(&Commit.Header,
					PHONGTHAN_MSG_RELAY_TRANSFER_COMMIT,
					sizeof(Commit), PHONGTHAN_WIRE_FLAG_REQUEST,
					m_RelayClient.NextSequence());
				Commit.TransferId = Pending.TransferId;
				Commit.SourceServiceId = m_RelayClient.GetServiceId();
				Commit.TargetServiceId = pResult->TargetServiceId;
				memcpy(Commit.SessionTicket, Pending.SessionTicket,
					PHONGTHAN_SESSION_TICKET_SIZE);
				strncpy((char*)Commit.RoleName, Pending.RoleName,
					sizeof(Commit.RoleName) - 1);
				bSuccess = m_RelayClient.Send(&Commit, sizeof(Commit));
			}

			PHONGTHAN_WORLD_TRANSFER_RESPONSE Response;
			ZeroMemory(&Response, sizeof(Response));
			PhongThanInitializeWireHeader(&Response.Header,
				PHONGTHAN_MSG_WORLD_TRANSFER, sizeof(Response),
				bSuccess ? PHONGTHAN_WIRE_FLAG_RESPONSE :
					(PHONGTHAN_WIRE_FLAG_RESPONSE |
					 PHONGTHAN_WIRE_FLAG_ERROR),
				Pending.TransferId);
			Response.TransferId = Pending.TransferId;
			memcpy(Response.SessionTicket, Pending.SessionTicket,
				PHONGTHAN_SESSION_TICKET_SIZE);
			Response.Result = bSuccess ? PHONGTHAN_WORLD_TRANSFER_SUCCESS :
				PHONGTHAN_WORLD_TRANSFER_DESTINATION_UNAVAILABLE;
			Response.DestinationMapId = Pending.DestinationMapId;
			Response.DestinationX = Pending.DestinationX;
			Response.DestinationY = Pending.DestinationY;
			if (bSuccess)
			{
				Response.ServerAddressV4 = pResult->AddressV4;
				Response.ServerPort = pResult->Port;
				m_pCoreServerShell->RemovePlayerForExchange(
					Pending.PlayerIndex);
				UnbindPhongThanRelaySession(
					m_RelayClient, Pending.PlayerIndex,
					PHONGTHAN_RELAY_SESSION_END_TRANSFERRED);
				m_pGameStatus[Pending.ConnectionId].nExchangeStatus =
					enumExchangeCleaning;
				m_pGameStatus[Pending.ConnectionId].nPlayerIndex = 0;
			}
			else
			{
				m_pCoreServerShell->RecoverPlayerExchange(
					Pending.PlayerIndex);
				NotifyGatewayWorldSession(Pending.PlayerIndex,
					PHONGTHAN_WORLD_SESSION_TRANSFER_REBIND,
					PHONGTHAN_WORLD_SESSION_REASON_TRANSFER,
					FALSE, Pending.TransferId, 0);
				SendPhongThanCharacterLock(
					m_pDatabaseClient, Pending.RoleName, TRUE);
				m_pGameStatus[Pending.ConnectionId].nGameStatus =
					enumPlayerPlaying;
				m_pGameStatus[Pending.ConnectionId].nExchangeStatus =
					enumExchangeBegin;
			}
			m_pServer->SendData(Pending.ConnectionId,
				&Response, sizeof(Response));
			g_PhongThanOutboundTransfers.erase(PendingIt);
		}
		break;

	case PHONGTHAN_MSG_RELAY_TRANSFER_COMMIT:
		{
			const PHONGTHAN_RELAY_TRANSFER_COMMIT* pCommit =
				(const PHONGTHAN_RELAY_TRANSFER_COMMIT*)pChar;
			if (!PhongThanValidateRelayFixedPacket(
					&pCommit->Header, (PHONGTHAN_U32)nSize,
					PHONGTHAN_MSG_RELAY_TRANSFER_COMMIT,
					sizeof(*pCommit)) ||
				pCommit->TargetServiceId != m_RelayClient.GetServiceId())
			{
				GameServerLoginDiag(
					"native_transfer_commit_rejected");
				break;
			}
			g_PhongThanInboundTransfers.erase(pCommit->TransferId);
		}
		break;

	case PHONGTHAN_MSG_RELAY_ROUTE:
		{
			const PHONGTHAN_RELAY_ROUTE_HEADER* route = (const PHONGTHAN_RELAY_ROUTE_HEADER*)pChar;
			if (!PhongThanValidateRelayRoutePacket(route, nSize) || route->TargetServiceId != m_RelayClient.GetServiceId() ||
				!(route->RouteFlags & PHONGTHAN_RELAY_ROUTE_FLAG_BROADCAST) || route->KeySize) break;
			const void* payload = route + 1;
			if (!PhongThanValidateUiAction(payload, route->PayloadSize)) break;
			for (int connection = 0; connection < m_nMaxPlayer; ++connection)
				if (m_pGameStatus[connection].nGameStatus == enumPlayerPlaying)
					m_pServer->PackDataToClient(connection, payload, route->PayloadSize);
		}
		break;
	case PHONGTHAN_MSG_RELAY_CHAT_DELIVER:
	case PHONGTHAN_MSG_RELAY_CLAN_EVENT:
	case PHONGTHAN_MSG_RELAY_FRIEND_EVENT:
		GameServerLoginDiag(
			"native_relay_domain_packet_pending type=0x%04X size=%u",
			(unsigned int)pHeader->MessageType,
			(unsigned int)nSize);
		break;

	default:
		GameServerLoginDiag(
			"native_relay_packet_rejected unsupported_type=0x%04X",
			(unsigned int)pHeader->MessageType);
		break;
	}
}

void KSwordOnLineSever::ChatGroupMan(const void *pData, size_t dataLength)
{
	_ASSERT(pData && dataLength);

	CHAT_GROUPMAN*	pCgc = (CHAT_GROUPMAN *)pData;
	_ASSERT(pCgc->wSize + 1 == dataLength);

	_ASSERT(sizeof(tagExtendProtoHeader) <= sizeof(CHAT_GROUPMAN));
	void* pExPckg = pCgc + 1;
	BYTE hasIdentify = pCgc->byHasIdentify;
	WORD playercount = pCgc->wPlayerCount;
	void* pPlayersData = (tagPlusSrcInfo*)((BYTE*)pExPckg + pCgc->wChatLength);
	size_t pckgsize = sizeof(tagExtendProtoHeader) + pCgc->wChatLength;
	tagExtendProtoHeader* pExHdr = (tagExtendProtoHeader*)pExPckg - 1;
	pExHdr->ProtocolType = s2c_extendchat;
	pExHdr->wLength = pckgsize - 1;

	if (hasIdentify)
	{
		tagPlusSrcInfo* pPlayers = (tagPlusSrcInfo*)pPlayersData;
		for (int i = 0; i < playercount; i++)
		{
			//TODO: ????????NameID??lnID????????
			if (CheckPlayerID(pPlayers[i].lnID, pPlayers[i].nameid))
				m_pServer->PackDataToClient(pPlayers[i].lnID, pExHdr, pckgsize);
		}
	}
	else
	{
		WORD* pPlayers = (WORD*)pPlayersData;
		for (int i = 0; i < playercount; i++)
		{
			//TODO: ????????????NameID??lnID????????
			//if (pPlayers[i] >= 0)
				m_pServer->PackDataToClient((unsigned long)pPlayers[i], pExHdr, pckgsize);
		}
	}
}

void KSwordOnLineSever::ChatSpecMan(const void *pData, size_t dataLength)
{
	_ASSERT(pData && dataLength);

	CHAT_SPECMAN*	pCsm = (CHAT_SPECMAN *)pData;
	_ASSERT(pCsm->wSize + 1 == dataLength);

	if (!CheckPlayerID(pCsm->lnID, pCsm->nameid))
		return;

	_ASSERT(sizeof(tagExtendProtoHeader) <= sizeof(CHAT_SPECMAN));
	void* pExPckg = pCsm + 1;

	unsigned long lnID = pCsm->lnID;
	size_t pckgsize = sizeof(tagExtendProtoHeader) + pCsm->wChatLength;

	tagExtendProtoHeader* pExHeader = (tagExtendProtoHeader*)(pCsm + 1) - 1;
	pExHeader->ProtocolType = s2c_extendchat;
	pExHeader->wLength = pckgsize - 1;

	m_pServer->PackDataToClient(lnID, pExHeader, pckgsize);
}


void KSwordOnLineSever::DatabaseMessageProcess(const char* pData, size_t dataLength)
{
	_ASSERT( pData && dataLength );
	if (!pData || dataLength < sizeof(BYTE))
		return;

	if (PhongThanIsWirePacket(pData, (PHONGTHAN_U32)dataLength))
	{
		const PHONGTHAN_WIRE_HEADER* pHeader =
			(const PHONGTHAN_WIRE_HEADER*)pData;
		if (!PhongThanValidateWireHeader(pHeader,
				(PHONGTHAN_U32)dataLength) ||
			pHeader->PacketSize != dataLength ||
			pHeader->Flags != PHONGTHAN_WIRE_FLAG_RESPONSE ||
			pHeader->MessageType != PHONGTHAN_MSG_SERVICE_CHARACTER_SAVE ||
			dataLength != sizeof(PHONGTHAN_SERVICE_CHARACTER_SAVE_RESPONSE))
		{
			GameServerLoginDiag("save_response_rejected invalid envelope");
			return;
		}
		const PHONGTHAN_SERVICE_CHARACTER_SAVE_RESPONSE* pResponse =
			(const PHONGTHAN_SERVICE_CHARACTER_SAVE_RESPONSE*)pData;
		const int nIndex = (int)pResponse->RequestId;
		if (nIndex <= 0 || nIndex > m_nMaxPlayer)
			return;
		const BOOL bSaveOk = pResponse->Result ==
			PHONGTHAN_CHARACTER_OPERATION_SUCCESS;
		std::map<int, DWORD>::iterator leaving = g_PhongThanLeavingSaves.find(nIndex);
		if (leaving != g_PhongThanLeavingSaves.end() && bSaveOk &&
			pHeader->Sequence == (0x80000000u | (PHONGTHAN_U32)nIndex))
		{
			GameServerLoginDiag("logout_save_ack index=%d role=%s", nIndex, pResponse->RoleName);
			NotifyGatewayWorldSession(nIndex, PHONGTHAN_WORLD_SESSION_LEAVING,
				PHONGTHAN_WORLD_SESSION_REASON_DISCONNECTED, TRUE, 0, 0);
			UnbindPhongThanRelaySession(m_RelayClient, nIndex,
				PHONGTHAN_RELAY_SESSION_END_LOGOUT);
			m_pCoreServerShell->RemoveQuitingPlayer(nIndex);
			g_PhongThanLeavingSaves.erase(leaving);
			return;
		}
		m_pCoreServerShell->SetSaveStatus(nIndex,
			bSaveOk ? SAVE_IDLE : SAVE_REQUEST);
		if (!bSaveOk)
			GameServerLoginDiag("save_role_failed index=%d result=%d",
				nIndex, (int)pResponse->Result);
		return;
	}

	GameServerLoginDiag("database_packet_rejected non-PhongThan protocol");
}

void KSwordOnLineSever::DatabaseLargePackProcess(const char* pData, size_t dataLength)
{
	_ASSERT( pData && dataLength );

#ifndef _STANDALONE
	CBuffer *pBuffer = m_theRecv.PackUp( pData, dataLength );
#else
	char *pBuffer = m_theRecv.PackUp( pData, dataLength );
#endif

	if ( pBuffer )
	{
#ifndef _STANDALONE
	BYTE cProtocol = CPackager::Peek( pBuffer->GetBuffer() );
#else
	BYTE cProtocol = *(BYTE *)pBuffer;
#endif
//		BYTE cProtocol = CPackager::Peek( pBuffer->GetBuffer() );

		switch ( cProtocol )
		{
		case s2c_gamestatistic:
			{
#ifndef _STANDALONE
				TProcessData*	pRD	= (TProcessData *)pBuffer->GetBuffer();
#else
				TProcessData*	pRD	= (TProcessData *)pBuffer;
#endif
				_ASSERT( pRD->nDataLen == sizeof(TGAME_STAT_DATA) );

				if (m_pCoreServerShell)
				{
					m_pCoreServerShell->SetLadder((void *)pRD->pDataBuffer, pRD->nDataLen);
				}
			}
			break;

		default:
			break;
		}

#ifndef _STANDALONE
		try
		{
			if( pBuffer != NULL )
			{
				pBuffer->Release();
				pBuffer = NULL;
			}
		}
		catch(...)
		{
			//TRACE("SAFE_RELEASE error\n");
		}
#endif
	}
}

void KSwordOnLineSever::PlayerMessageProcess(const unsigned long lnID, const char* pData, size_t dataLength)
{
	if (!pData || !dataLength || dataLength > PHONGTHAN_WIRE_MAX_PACKET_SIZE ||
		!m_pGameStatus || lnID >= (unsigned long)m_nMaxPlayer)
		return;
//#ifndef _STANDALONE
	_ASSERT(pData && dataLength);

#ifndef _STANDALONE
	BYTE cProtocol = CPackager::Peek( pData );
#else
	BYTE cProtocol = *(BYTE *)pData;
#endif
	try{

	int nGameStatus = m_pGameStatus[lnID].nGameStatus;
	int nIndex = m_pGameStatus[lnID].nPlayerIndex;
	if (PhongThanIsWirePacket(pData, (PHONGTHAN_U32)dataLength))
	{
		if (!m_pCoreServerShell->CheckProtocolSize(pData, (int)dataLength))
			return;
		if (nGameStatus == enumPlayerPlaying)
		{
			if (nIndex > 0)
				m_pCoreServerShell->ProcessClientMessage(nIndex, pData, (int)dataLength);
			return;
		}
		if (nGameStatus != enumPlayerBegin && nGameStatus != enumPlayerSyncEnd)
			return;
	}

	BYTE protocoltype = *(BYTE*)pData;
	GameServerLoginDiag("player_packet id=%lu protocol=%u size=%u status=%d index=%d",
		(unsigned long)lnID, (unsigned int)protocoltype, (unsigned int)dataLength,
		nGameStatus, nIndex);
	if (protocoltype >= _c2s_begin_relay && protocoltype <= _c2s_end_relay)
	{
		IClient* pClient = NULL;
		switch (protocoltype)
		{
		case c2s_extendchat: pClient = m_pChatClient; break;
		case c2s_extendfriend: pClient = m_pTongClient; break;
		default:
			return;
		};

		if (pClient && nIndex && dataLength > sizeof(tagExtendProtoHeader))
		{
			size_t exsize = dataLength - sizeof(tagExtendProtoHeader);
			const void* pExPckg = pData + sizeof(tagExtendProtoHeader);

			if (protocoltype == c2s_extendchat)
			{
				CHAT_CHANNELCHAT_CMD* pEh = (CHAT_CHANNELCHAT_CMD*)pExPckg;
				if (pEh->ProtocolType == chat_channelchat && pEh->channelid != 0)	//??GM????????????????
				{
					if (!m_pCoreServerShell->PayForSpeech(nIndex, pEh->cost))
						return;
				}
			}

			size_t pckgsize = exsize + sizeof(tagPlusSrcInfo);
#ifdef WIN32
			void* pPckg2 = _alloca(pckgsize);
#else
			void* pPckg2 = (new char[pckgsize]);
#endif
			memcpy(pPckg2, pExPckg, exsize);
			tagPlusSrcInfo* pSrcInfo = (tagPlusSrcInfo*)((BYTE*)pPckg2 + exsize);
			pSrcInfo->nameid = m_pCoreServerShell->GetGameData(SGDI_CHARACTER_ID, nIndex, 0);
			pSrcInfo->lnID = lnID;
			pClient->SendPackToServer(pPckg2, pckgsize);
#ifndef WIN32
			delete (char*)pPckg2;
#endif
		}
		return;
	}
	if (!m_pCoreServerShell->CheckProtocolSize(pData, dataLength))
	{
		GameServerLoginDiag("player_packet_rejected id=%lu protocol=%u size=%u",
			(unsigned long)lnID, (unsigned int)protocoltype, (unsigned int)dataLength);
		return;
	}

	//printf("player msg arrived...%d\n", nGameStatus); //[wxb 2003-7-28]
	switch(nGameStatus)
	{
	case enumPlayerPlaying:
		if (nIndex)
		{
			if (*(BYTE*)pData == c2s_ping)
			{
				ProcessPingReply(lnID, pData, dataLength);
			}
			else if (*(BYTE*)pData == c2s_extendtong)
			{
				ProcessPlayerTongMsg(nIndex, pData, dataLength);
			}
			else
			{
				m_pCoreServerShell->ProcessClientMessage(nIndex, pData, dataLength);
			}
		}
		break;
	case enumPlayerExchangingServer:
		break;
	case enumPlayerSyncEnd:
		if (ProcessSyncReplyProtocol(lnID, pData, dataLength))
		{
			m_pCoreServerShell->AddPlayerToWorld(nIndex);
			if (!BindPhongThanRelaySession(m_RelayClient, lnID, nIndex))
			{
				GameServerLoginDiag(
					"native_relay_session_bind_failed id=%lu index=%d",
					(unsigned long)lnID, nIndex);
				m_pCoreServerShell->ClientDisconnect(nIndex);
				m_pServer->ShutdownClient(lnID);
				return;
			}
			if (!NotifyGatewayWorldSession(nIndex,
					PHONGTHAN_WORLD_SESSION_ENTERED,
					PHONGTHAN_WORLD_SESSION_REASON_NORMAL,
					FALSE, 0, 0))
			{
				GameServerLoginDiag(
					"world_session_enter_failed id=%lu index=%d",
					(unsigned long)lnID, nIndex);
				UnbindPhongThanRelaySession(m_RelayClient, nIndex,
					PHONGTHAN_RELAY_SESSION_END_DISCONNECTED);
				m_pCoreServerShell->ClientDisconnect(nIndex);
				m_pServer->ShutdownClient(lnID);
				return;
			}
			m_pGameStatus[lnID].nGameStatus = enumPlayerPlaying;
			PingClient(lnID);

			//??????????????
                char szRoleName[32];
                ZeroMemory(szRoleName, sizeof(szRoleName));
                m_pCoreServerShell->GetGameData(
                    SGDI_CHARACTER_NAME,
                    (unsigned int)szRoleName,
                    nIndex);
                SendPhongThanCharacterLock(
                    m_pDatabaseClient, szRoleName, TRUE);

			// ????????????
			int		nPlayerIdx = m_pGameStatus[lnID].nPlayerIndex;
			if (nPlayerIdx > 0 && nPlayerIdx < MAX_PLAYER)
			{
				DWORD	dwTongNameID = m_pCoreServerShell->GetGameData(SGDI_TONG_GET_TONG_NAMEID, 0, nPlayerIdx);
				char	szName[32];
				szName[0] = 0;
				m_pCoreServerShell->GetGameData(SGDI_CHARACTER_NAME, (unsigned int)szName, nPlayerIdx);
				if (dwTongNameID > 0 && szName[0])
				{
					int PlayerSex = m_pCoreServerShell->GetGameData(SGDI_CHARACTER_SEX, 0, nPlayerIdx); //Co them get name data TamLTM check code
					STONG_GET_LOGIN_DATA_COMMAND	sLogin;
					sLogin.ProtocolFamily	= pf_tong;
					sLogin.ProtocolID		= enumC2S_TONG_GET_LOGIN_DATA;
					sLogin.m_dwParam		= nPlayerIdx;
					sLogin.m_dwTongNameID	= dwTongNameID;
					strcpy(sLogin.m_szName, szName);
					sLogin.m_nSex = PlayerSex;
					if (m_pTongClient)
						m_pTongClient->SendPackToServer((const void*)&sLogin, sizeof(sLogin));
				}
				m_pCoreServerShell->GetGameData(SGDI_TONG_SEND_SELF_INFO, 0, nPlayerIdx);
				// TamLTM fix xu;
				int nExtPoint = m_pCoreServerShell->GetGameData(SGDI_CHARACTER_EXTPOINT, nIndex, 0);
				char	szAccountName[32];
				m_pCoreServerShell->GetGameData(SGDI_CHARACTER_ACCOUNT, (unsigned int)szAccountName, nPlayerIdx);
				if (nExtPoint <= 0 && szAccountName[0])
				{
					STONG_GET_EXTPOINT_COMMAND	nExt;
					nExt.ProtocolFamily = pf_tong;
					nExt.ProtocolID = enumC2S_GET_EXTPOINT;
					strcpy(nExt.m_szAccountName, szAccountName);
					nExt.m_dwParam = nPlayerIdx;
					if (m_pTongClient)
						m_pTongClient->SendPackToServer((const void*)&nExt, sizeof(nExt));
				}
			}
		}
		break;
	case enumPlayerBegin:
		{
			int nIndex = ProcessLoginProtocol(lnID, pData, dataLength);
			GameServerLoginDiag("login_protocol_result id=%lu index=%d", (unsigned long)lnID, nIndex);
			//printf("process login %d...\n", nIndex);
			if (nIndex)
			{
				if (SendGameDataToClient(lnID, nIndex))
				{
					GameServerLoginDiag("login_data_sent id=%lu index=%d", (unsigned long)lnID, nIndex);
					//printf("process login %d ok...\n", nIndex);
					m_pGameStatus[lnID].nGameStatus = enumPlayerSyncEnd;
					m_pGameStatus[lnID].nPlayerIndex = nIndex;
				}

				else
				{
					GameServerLoginDiag("login_data_failed id=%lu index=%d", (unsigned long)lnID, nIndex);
					//printf("process login %d fail...\n", nIndex);
					m_pGameStatus[lnID].nGameStatus = enumPlayerBegin;
					m_pGameStatus[lnID].nPlayerIndex = nIndex;
#ifndef _STANDALONE
					m_pServer->ShutdownClient(lnID);
#endif
				}
			}
		}
		break;
	}

		}
	catch (...)
	{
		TRACE("Core PlayerMessageProcess Error\n");
	}
	//printf("player msg over..\n");
//#endif
}

BOOL KSwordOnLineSever::RegisterGatewayWorldService(unsigned int nRequestId)
{
	if (!m_pGatewayClient || !m_pCoreServerShell ||
		!m_RelayClient.IsRegistered())
	{
		return FALSE;
	}

	PHONGTHAN_SERVICE_WORLD_HELLO_RESPONSE Response;
	ZeroMemory(&Response, sizeof(Response));
	PhongThanInitializeWireHeader(&Response.Header,
		PHONGTHAN_MSG_SERVICE_WORLD_HELLO, sizeof(Response),
		PHONGTHAN_WIRE_FLAG_RESPONSE, nRequestId);
	Response.RequestId = nRequestId;
	Response.ServiceId = m_RelayClient.GetServiceId();
	Response.PublicAddressV4 = (PHONGTHAN_U32)m_dwInternetIp;
	Response.PrivateAddressV4 = (PHONGTHAN_U32)m_dwIntranetIp;
	Response.Port = (PHONGTHAN_U16)m_nServerPort;
	Response.Capacity = (PHONGTHAN_U16)m_nMaxPlayerCount;
	strncpy((char*)Response.InstanceName, m_szRelayInstance,
		sizeof(Response.InstanceName) - 1);
	if (FAILED(m_pGatewayClient->SendPackToServer(
			&Response, sizeof(Response))))
	{
		return FALSE;
	}

	short MapIds[PHONGTHAN_WORLD_MAP_LIMIT];
	ZeroMemory(MapIds, sizeof(MapIds));
	const int nMapCount = m_pCoreServerShell->GetGameData(
		SGDI_LOADEDMAP_ID, (unsigned int)MapIds, sizeof(MapIds));
	if (nMapCount <= 0 || nMapCount > PHONGTHAN_WORLD_MAP_LIMIT)
		return FALSE;

	const PHONGTHAN_U32 nPacketSize =
		(PHONGTHAN_U32)sizeof(PHONGTHAN_SERVICE_WORLD_MAP_REGISTRY_HEADER) +
		(PHONGTHAN_U32)nMapCount * sizeof(PHONGTHAN_S32);
	BYTE* pPacket = new BYTE[nPacketSize];
	ZeroMemory(pPacket, nPacketSize);
	PHONGTHAN_SERVICE_WORLD_MAP_REGISTRY_HEADER* pRegistry =
		(PHONGTHAN_SERVICE_WORLD_MAP_REGISTRY_HEADER*)pPacket;
	PhongThanInitializeWireHeader(&pRegistry->Header,
		PHONGTHAN_MSG_SERVICE_WORLD_MAP_REGISTRY, nPacketSize,
		PHONGTHAN_WIRE_FLAG_REQUEST, nRequestId);
	pRegistry->ServiceId = m_RelayClient.GetServiceId();
	pRegistry->MapCount = (PHONGTHAN_U16)nMapCount;
	PHONGTHAN_S32* pWireMapIds = (PHONGTHAN_S32*)(pPacket +
		sizeof(PHONGTHAN_SERVICE_WORLD_MAP_REGISTRY_HEADER));
	for (int i = 0; i < nMapCount; ++i)
		pWireMapIds[i] = MapIds[i];
	const HRESULT hr = m_pGatewayClient->SendPackToServer(
		pPacket, nPacketSize);
	delete [] pPacket;
	return FAILED(hr) ? FALSE : TRUE;
}

BOOL KSwordOnLineSever::NotifyGatewayWorldSession(
	int nPlayerIndex, unsigned char nPhase, unsigned char nReason,
	BOOL bReleaseAccount, unsigned int nTransferId, int nMapId)
{
	if (!m_pGatewayClient || nPlayerIndex <= 0)
		return FALSE;
	PHONGTHAN_GAME_SESSION_ROUTE_MAP::iterator it =
		g_PhongThanRelaySessions.find(nPlayerIndex);
	if (it == g_PhongThanRelaySessions.end())
		return FALSE;

	PHONGTHAN_SERVICE_WORLD_SESSION_EVENT Event;
	ZeroMemory(&Event, sizeof(Event));
	const PHONGTHAN_U32 nSequence = nTransferId ? nTransferId :
		(PHONGTHAN_U32)GetTickCount();
	PhongThanInitializeWireHeader(&Event.Header,
		PHONGTHAN_MSG_SERVICE_WORLD_SESSION, sizeof(Event),
		PHONGTHAN_WIRE_FLAG_REQUEST, nSequence);
	memcpy(Event.SessionTicket, it->second.SessionTicket,
		PHONGTHAN_SESSION_TICKET_SIZE);
	Event.TransferId = nTransferId;
	Event.MapId = nMapId > 0 ? nMapId : (PHONGTHAN_S32)it->second.MapId;
	Event.ExtensionPoint = m_pCoreServerShell ?
		m_pCoreServerShell->GetGameData(
			SGDI_CHARACTER_EXTPOINTCHANGED, nPlayerIndex, 0) : 0;
	Event.Phase = nPhase;
	Event.Reason = nReason;
	Event.ReleaseAccount = bReleaseAccount ? 1 : 0;
	strncpy((char*)Event.AccountName, it->second.AccountName,
		sizeof(Event.AccountName) - 1);
	strncpy((char*)Event.RoleName, it->second.RoleName,
		sizeof(Event.RoleName) - 1);
	return FAILED(m_pGatewayClient->SendPackToServer(
		&Event, sizeof(Event))) ? FALSE : TRUE;
}

void KSwordOnLineSever::GatewayMessageProcess(const char* pData, size_t dataLength)
{
	if (!pData || dataLength < sizeof(PHONGTHAN_WIRE_HEADER) ||
		dataLength > 0xffffffffu ||
		!PhongThanIsWirePacket(pData, (PHONGTHAN_U32)dataLength))
	{
		GameServerLoginDiag(
			"gateway_packet_rejected non_phongthan size=%u",
			(unsigned int)dataLength);
		return;
	}

	const PHONGTHAN_WIRE_HEADER* pHeader =
		(const PHONGTHAN_WIRE_HEADER*)pData;
	if (!PhongThanValidateWireHeader(pHeader,
			(PHONGTHAN_U32)dataLength) ||
		pHeader->PacketSize != dataLength)
	{
		GameServerLoginDiag("gateway_packet_rejected invalid_envelope");
		return;
	}

	if (pHeader->MessageType == PHONGTHAN_MSG_SERVICE_WORLD_HELLO)
	{
		const PHONGTHAN_SERVICE_WORLD_HELLO_REQUEST* pRequest =
			(const PHONGTHAN_SERVICE_WORLD_HELLO_REQUEST*)pData;
		if (dataLength != sizeof(*pRequest) ||
			pHeader->Flags != PHONGTHAN_WIRE_FLAG_REQUEST ||
			pRequest->RequestId != pHeader->Sequence ||
			!RegisterGatewayWorldService(pRequest->RequestId))
		{
			GameServerLoginDiag("world_service_registration_failed");
			m_bIsRunning = FALSE;
		}
		return;
	}

	if (pHeader->MessageType != PHONGTHAN_MSG_WORLD_ATTACH_CHARACTER ||
		pHeader->Flags != PHONGTHAN_WIRE_FLAG_REQUEST ||
		dataLength < sizeof(PHONGTHAN_WORLD_ATTACH_CHARACTER_HEADER))
	{
		GameServerLoginDiag(
			"gateway_packet_rejected unknown_type=0x%04X",
			(unsigned int)pHeader->MessageType);
		return;
	}

	const PHONGTHAN_WORLD_ATTACH_CHARACTER_HEADER* pAttach =
		(const PHONGTHAN_WORLD_ATTACH_CHARACTER_HEADER*)pData;
	if (pAttach->StateSize != dataLength - sizeof(*pAttach) ||
		pAttach->StateSize < sizeof(PHONGTHAN_CHARACTER_STATE_HEADER))
	{
		GameServerLoginDiag("world_attach_rejected invalid_state_size");
		return;
	}
	const PHONGTHAN_CHARACTER_STATE_HEADER* pState =
		(const PHONGTHAN_CHARACTER_STATE_HEADER*)
			((const BYTE*)pData + sizeof(*pAttach));
	if (!PhongThanValidateCharacterState(pState, pAttach->StateSize))
	{
		GameServerLoginDiag("world_attach_rejected invalid_character_state");
		return;
	}

	PHONGTHAN_SESSION_ENTER_WORLD_RESPONSE Permit;
	ZeroMemory(&Permit, sizeof(Permit));
	PhongThanInitializeWireHeader(&Permit.Header,
		PHONGTHAN_MSG_SESSION_ENTER_WORLD, sizeof(Permit),
		PHONGTHAN_WIRE_FLAG_RESPONSE, pHeader->Sequence);
	memcpy(Permit.SessionTicket, pAttach->SessionTicket,
		PHONGTHAN_SESSION_TICKET_SIZE);
	strncpy((char*)Permit.RoleName, (const char*)pState->RoleName,
		sizeof(Permit.RoleName) - 1);
	strncpy((char*)Permit.AccountName, (const char*)pState->AccountName,
		sizeof(Permit.AccountName) - 1);

	KCoreConnectInfo Info;
	ZeroMemory(&Info, sizeof(Info));
	m_pCoreServerShell->GetConnectInfo(&Info);
	int nAddedIndex = 0;
	if (Info.nNumPlayer < m_nMaxPlayer)
	{
		nAddedIndex = m_pCoreServerShell->AddCharacter(
			pAttach->ExtensionPoint, pAttach->ChangedExtensionPoint,
			(void*)pState, pAttach->StateSize, pAttach->SessionTicket);
	}
	if (nAddedIndex > 0)
	{
		RememberPhongThanRelaySession(
			nAddedIndex, pAttach->SessionTicket, pState);
	}
	Permit.Permit = nAddedIndex > 0 ? 1 : 0;
	GameServerLoginDiag(
		"world_attach role=%s account=%s state_len=%u added_index=%d permit=%d",
		pState->RoleName, pState->AccountName,
		(unsigned int)pAttach->StateSize, nAddedIndex, (int)Permit.Permit);
	m_pGatewayClient->SendPackToServer(&Permit, sizeof(Permit));
}
void KSwordOnLineSever::MainLoop()
{
#ifndef _STANDALONE
	CCriticalSection::Owner locker( g_csFlow );
#else
	g_mutexFlow.lock();
#endif
//Fix try catch
	try
	{
		SavePlayerData();
		PlayerLogoutGateway();
		PlayerExchangeServer();
	//	m_pServer->PreparePackSink();	??????????????????????
		m_pCoreServerShell->Breathe();

// ????????????????????????
/*/TamLTM Fix lai nhu cu
#define	defMAX_STAT_QUERY_TIME		18000 * 20		// lay du lieu xep hang ne

		if ( 0 == ( m_nGameLoop % defMAX_STAT_QUERY_TIME ) )
		{
			if (m_pDatabaseClient)
			{
				TProcessData	ProcessData;

				ProcessData.nProtoId = c2s_gamestatistic; // thong ke tro choi
				ProcessData.nDataLen = 1;
				ProcessData.ulIdentity = -1;
				ProcessData.pDataBuffer[0] = 0;
				m_pDatabaseClient->SendPackToServer(&ProcessData, sizeof(TProcessData));
			}
		}
//end code*/

// ??????????????????????????PING??????1min??
		int lnID = m_nGameLoop % m_nMaxPlayer;
		int nIndex = m_pGameStatus[lnID].nPlayerIndex;

		//debug ket acc
		char	szName[32];
		m_pCoreServerShell->GetGameData(SGDI_CHARACTER_ACCOUNT, (unsigned int)szName, nIndex);
		//end code

		if (nIndex > 0 && nIndex <= m_nMaxPlayer && m_pGameStatus[lnID].nGameStatus == enumPlayerPlaying)
		{
#define	defMAX_PING_TIMEOUT		60 * 20		// 60sec
#define	defMAX_PING_INTERVAL	5 * 20

			if (m_pGameStatus[lnID].nReplyPingTime != 0)
			{
				if (m_nGameLoop - m_pGameStatus[lnID].nSendPingTime > defMAX_PING_INTERVAL)
				{
//					printf("Send ping to client....\n"); // TamLTM debug send ping to client for server
					PingClient(lnID);
				}
			}
			else if (m_nGameLoop - m_pGameStatus[lnID].nSendPingTime > defMAX_PING_TIMEOUT)
			{
				printf("no response from client(%d, %d), kill it...\n", m_nGameLoop, m_pGameStatus[lnID].nSendPingTime);
				m_pServer->ShutdownClient(lnID);
				printf("Ping Player Acc Ket [id: %d] - acc: %s\n", nIndex, szName);
			//	m_pCoreServerShell->RemoveQuitingPlayer(nIndex);
			}
		}

		if (m_nGameLoop & 0x01)
		{
			m_pServer->SendPackToClient(-1);
		}
		m_nGameLoop++;
	}
	catch (...)
	{
		TRACE("Core MainLoop Error\n");
	}
#ifdef _STANDALONE
	g_mutexFlow.unlock();
#endif
}

void KSwordOnLineSever::PingClient(const unsigned long lnID)
{
	//Fix kill it
	_ASSERT(lnID < m_nMaxPlayer);
	_ASSERT(m_pGameStatus[lnID].nPlayerIndex > 0 && m_pGameStatus[lnID].nPlayerIndex <= m_nMaxPlayer);
	//end code

	//printf("PingClient(%d) called\n", lnID);
	PING_COMMAND	pc;
	pc.m_dwTime = m_nGameLoop;
	pc.ProtocolType = s2c_ping;
	m_pServer->PackDataToClient(lnID, &pc, sizeof(PING_COMMAND));
	m_pGameStatus[lnID].nReplyPingTime = 0;
	m_pGameStatus[lnID].nSendPingTime = m_nGameLoop;
}

void KSwordOnLineSever::ProcessPingReply(const unsigned long lnID, const char* pData, size_t dataLength)
{
	_ASSERT(lnID < m_nMaxPlayer);
	_ASSERT(m_pGameStatus[lnID].nPlayerIndex > 0 && m_pGameStatus[lnID].nPlayerIndex <= m_nMaxPlayer);

	//printf("receive ping from client...\n");
	if (dataLength != sizeof(PING_CLIENTREPLY_COMMAND))
	{
		printf("ping cmd size not correct, may be Non-offical Client...\n");
		m_pServer->ShutdownClient(lnID);
		return;
	}

	PING_CLIENTREPLY_COMMAND*	pPC = (PING_CLIENTREPLY_COMMAND *)pData;
	if (pPC->m_dwReplyServerTime != m_pGameStatus[lnID].nSendPingTime)
	{
		printf("wrong time in ping cmd content, kill it...\n");
		m_pServer->ShutdownClient(lnID);
		return;
	}
	m_pGameStatus[lnID].nReplyPingTime = m_nGameLoop;
	// reply client ping to client to announce ping interval;
	PING_COMMAND	pc;
	pc.ProtocolType = s2c_replyclientping;
	pc.m_dwTime = pPC->m_dwClientTime;
	m_pServer->PackDataToClient(lnID, &pc, sizeof(PING_COMMAND));
}

// ??????????????????????
void KSwordOnLineSever::SavePlayerData()
{
	if (!m_pDatabaseClient)
		return;

	int i = 0;


	// ????????????
	for (i = 0; i < m_nMaxPlayer; i++)
	{
		if (GetNetStatus(i) == enumNetUnconnect)
			continue;

		int nIndex = m_pGameStatus[i].nPlayerIndex;

		if (nIndex <= 0 ||nIndex > m_nMaxPlayer)
			continue;

		// Canonical character state is saved by SavePlayerData().
		if (m_pCoreServerShell->GetSaveStatus(nIndex) == SAVE_REQUEST)
		{
			SavePlayerData(nIndex, false);
		}
	}
}

BOOL KSwordOnLineSever::SavePlayerData(int nIndex, bool bUnLock)
{
	if (!m_pDatabaseClient || !m_pCoreServerShell || nIndex <= 0 || nIndex > m_nMaxPlayer)
		return FALSE;

	const PHONGTHAN_CHARACTER_STATE_HEADER* pState =
		(const PHONGTHAN_CHARACTER_STATE_HEADER*)
			m_pCoreServerShell->SavePlayerDataAtOnce(nIndex);
	if (!pState || !PhongThanValidateCharacterState(pState, pState->StateSize))
	{
		GameServerLoginDiag("save_role_rejected index=%d invalid core state", nIndex);
		return FALSE;
	}
	const PHONGTHAN_U32 nStateSize = pState->StateSize;

	const PHONGTHAN_U32 nPacketSize =
		(PHONGTHAN_U32)sizeof(PHONGTHAN_SERVICE_CHARACTER_SAVE_REQUEST_HEADER) +
		nStateSize;
	// State is bounded to 64 KiB by PhongThanValidateCharacterState. The
	// shutdown path must not dereference an unchecked heap allocation:
	// crash 2026-09-11 at SavePlayerData+0x164 was ZeroMemory(NULL,...).
	BYTE pPacket[sizeof(PHONGTHAN_SERVICE_CHARACTER_SAVE_REQUEST_HEADER) + PHONGTHAN_CHARACTER_MAX_STATE_SIZE];
	ZeroMemory(pPacket, nPacketSize);
	PHONGTHAN_SERVICE_CHARACTER_SAVE_REQUEST_HEADER* pRequest =
		(PHONGTHAN_SERVICE_CHARACTER_SAVE_REQUEST_HEADER*)pPacket;
	PhongThanInitializeWireHeader(&pRequest->Header,
		PHONGTHAN_MSG_SERVICE_CHARACTER_SAVE, nPacketSize,
		PHONGTHAN_WIRE_FLAG_REQUEST,
		(bUnLock ? 0x80000000u : 0) | (PHONGTHAN_U32)nIndex);
	pRequest->RequestId = (PHONGTHAN_U32)nIndex;
	pRequest->LeaveWorld = bUnLock ? 1 : 0;
	pRequest->StateSize = nStateSize;
	memcpy(pPacket + sizeof(*pRequest), pState, nStateSize);
	const HRESULT hr = m_pDatabaseClient->SendPackToServer(pPacket, nPacketSize);
	if (FAILED(hr))
	{
		GameServerLoginDiag("save_role_send_failed index=%d hr=0x%08lX",
			nIndex, (unsigned long)hr);
		return FALSE;
	}
	m_pCoreServerShell->SetSaveStatus(nIndex, SAVE_DOING);
	return TRUE;
}

void KSwordOnLineSever::PlayerExchangeServer()
{
	if (!m_pCoreServerShell || !m_pServer)
		return;

	PHONGTHAN_OUTBOUND_TRANSFER_MAP::iterator PendingIt =
		g_PhongThanOutboundTransfers.begin();
	while (PendingIt != g_PhongThanOutboundTransfers.end())
	{
		if (GetTickCount() - PendingIt->second.StartedAt < 10000)
		{
			++PendingIt;
			continue;
		}
		PHONGTHAN_OUTBOUND_TRANSFER TimedOut = PendingIt->second;
		PHONGTHAN_OUTBOUND_TRANSFER_MAP::iterator EraseIt = PendingIt++;
		g_PhongThanOutboundTransfers.erase(EraseIt);
		PHONGTHAN_WORLD_TRANSFER_RESPONSE Response;
		ZeroMemory(&Response, sizeof(Response));
		PhongThanInitializeWireHeader(&Response.Header,
			PHONGTHAN_MSG_WORLD_TRANSFER, sizeof(Response),
			PHONGTHAN_WIRE_FLAG_RESPONSE |
				PHONGTHAN_WIRE_FLAG_ERROR,
			TimedOut.TransferId);
		Response.TransferId = TimedOut.TransferId;
		Response.Result = PHONGTHAN_WORLD_TRANSFER_DESTINATION_UNAVAILABLE;
		Response.DestinationMapId = TimedOut.DestinationMapId;
		Response.DestinationX = TimedOut.DestinationX;
		Response.DestinationY = TimedOut.DestinationY;
		m_pServer->SendData(TimedOut.ConnectionId,
			&Response, sizeof(Response));
		m_pCoreServerShell->RecoverPlayerExchange(TimedOut.PlayerIndex);
		SendPhongThanCharacterLock(
			m_pDatabaseClient, TimedOut.RoleName, TRUE);
		m_pGameStatus[TimedOut.ConnectionId].nGameStatus = enumPlayerPlaying;
		m_pGameStatus[TimedOut.ConnectionId].nExchangeStatus =
			enumExchangeBegin;
		GameServerLoginDiag("native_transfer_timeout id=%u player=%d",
			(unsigned int)TimedOut.TransferId, TimedOut.PlayerIndex);
	}

	for (int i = 0; i < m_nMaxPlayer; ++i)
	{
		int nIndex = m_pGameStatus[i].nPlayerIndex;
		if (nIndex <= 0 || nIndex > m_nMaxPlayer)
			continue;
		if (!m_pCoreServerShell->IsPlayerExchangingServer(nIndex))
			continue;

		m_pGameStatus[i].nGameStatus = enumPlayerExchangingServer;
		if (m_pGameStatus[i].nExchangeStatus != enumExchangeBegin)
			continue;

		PHONGTHAN_GAME_SESSION_ROUTE_MAP::iterator Session =
			g_PhongThanRelaySessions.find(nIndex);
		const PHONGTHAN_CHARACTER_STATE_HEADER* pState =
			(const PHONGTHAN_CHARACTER_STATE_HEADER*)
				m_pCoreServerShell->PreparePlayerForExchange(nIndex);
		if (!m_RelayClient.IsRegistered() ||
			Session == g_PhongThanRelaySessions.end() || !pState ||
			!PhongThanValidateCharacterState(pState, pState->StateSize) ||
			pState->EnterMapId <= 0)
		{
			PHONGTHAN_WORLD_TRANSFER_RESPONSE Response;
			ZeroMemory(&Response, sizeof(Response));
			PhongThanInitializeWireHeader(&Response.Header,
				PHONGTHAN_MSG_WORLD_TRANSFER, sizeof(Response),
				PHONGTHAN_WIRE_FLAG_RESPONSE |
					PHONGTHAN_WIRE_FLAG_ERROR, 0);
			Response.Result = PHONGTHAN_WORLD_TRANSFER_INVALID_STATE;
			m_pServer->SendData(i, &Response, sizeof(Response));
			m_pCoreServerShell->RecoverPlayerExchange(nIndex);
			m_pGameStatus[i].nGameStatus = enumPlayerPlaying;
			m_pGameStatus[i].nExchangeStatus = enumExchangeBegin;
			continue;
		}

		const PHONGTHAN_U32 nPacketSize =
			(PHONGTHAN_U32)sizeof(PHONGTHAN_RELAY_TRANSFER_PREPARE_HEADER) +
			pState->StateSize;
		PHONGTHAN_U8* pPacket = new PHONGTHAN_U8[nPacketSize];
		ZeroMemory(pPacket, nPacketSize);
		PHONGTHAN_RELAY_TRANSFER_PREPARE_HEADER* pTransfer =
			(PHONGTHAN_RELAY_TRANSFER_PREPARE_HEADER*)pPacket;
		const PHONGTHAN_U32 nTransferId = m_RelayClient.NextSequence();
		PhongThanInitializeWireHeader(&pTransfer->Header,
			PHONGTHAN_MSG_RELAY_TRANSFER_PREPARE, nPacketSize,
			PHONGTHAN_WIRE_FLAG_REQUEST, nTransferId);
		pTransfer->TransferId = nTransferId;
		pTransfer->SourceServiceId = m_RelayClient.GetServiceId();
		pTransfer->TargetServiceId = 0;
		pTransfer->DestinationMapId = (PHONGTHAN_U32)pState->EnterMapId;
		pTransfer->DestinationX = pState->EnterX;
		pTransfer->DestinationY = pState->EnterY;
		memcpy(pTransfer->SessionTicket, Session->second.SessionTicket,
			PHONGTHAN_SESSION_TICKET_SIZE);
		strncpy((char*)pTransfer->RoleName, Session->second.RoleName,
			sizeof(pTransfer->RoleName) - 1);
		pTransfer->ExtensionPoint = m_pCoreServerShell->GetGameData(
			SGDI_CHARACTER_EXTPOINT, nIndex, 0);
		pTransfer->ChangedExtensionPoint =
			m_pCoreServerShell->GetGameData(
				SGDI_CHARACTER_EXTPOINTCHANGED, nIndex, 0);
		pTransfer->StateSize = pState->StateSize;
		memcpy(pPacket + sizeof(*pTransfer), pState, pState->StateSize);

		const bool bSent = m_RelayClient.Send(pPacket, nPacketSize);
		delete [] pPacket;
		if (!bSent)
		{
			m_pCoreServerShell->RecoverPlayerExchange(nIndex);
			m_pGameStatus[i].nGameStatus = enumPlayerPlaying;
			continue;
		}

		PHONGTHAN_OUTBOUND_TRANSFER Pending;
		ZeroMemory(&Pending, sizeof(Pending));
		Pending.TransferId = nTransferId;
		Pending.ConnectionId = i;
		Pending.PlayerIndex = nIndex;
		Pending.DestinationMapId = (PHONGTHAN_U32)pState->EnterMapId;
		Pending.DestinationX = pState->EnterX;
		Pending.DestinationY = pState->EnterY;
		memcpy(Pending.SessionTicket, Session->second.SessionTicket,
			PHONGTHAN_SESSION_TICKET_SIZE);
		strncpy(Pending.RoleName, Session->second.RoleName,
			sizeof(Pending.RoleName) - 1);
		Pending.StartedAt = GetTickCount();
		g_PhongThanOutboundTransfers[nTransferId] = Pending;
		m_pGameStatus[i].nExchangeStatus =
			enumExchangeWaitForGameSvrRespone;
		GameServerLoginDiag(
			"native_transfer_prepare id=%u player=%d map=%u",
			(unsigned int)nTransferId, nIndex,
			(unsigned int)Pending.DestinationMapId);
	}
}

void KSwordOnLineSever::PlayerLogoutGateway()
{
	if (!m_pGatewayClient || !m_pCoreServerShell)
		return;

	for (int nIndex = 1; nIndex < MAX_PLAYER; ++nIndex)
	{
		if (m_pCoreServerShell->IsPlayerLoginTimeOut(nIndex))
		{
			if (!NotifyGatewayWorldSession(nIndex,
					PHONGTHAN_WORLD_SESSION_LEAVING,
					PHONGTHAN_WORLD_SESSION_REASON_TIMEOUT,
					TRUE, 0, 0))
			{
				GameServerLoginDiag(
					"world_session_timeout_notify_failed index=%d",
					nIndex);
			}
			UnbindPhongThanRelaySession(m_RelayClient, nIndex,
				PHONGTHAN_RELAY_SESSION_END_LOGOUT);
			m_pCoreServerShell->RemovePlayerLoginTimeOut(nIndex);
		}
		else if (m_pCoreServerShell->IsCharacterQuiting(nIndex))
		{
			std::map<int, DWORD>::iterator pending = g_PhongThanLeavingSaves.find(nIndex);
			if (pending == g_PhongThanLeavingSaves.end() ||
				GetTickCount() - pending->second >= 5000)
			{
				if (SavePlayerData(nIndex, true))
				{
					g_PhongThanLeavingSaves[nIndex] = GetTickCount();
					GameServerLoginDiag("logout_save_pending index=%d", nIndex);
				}
			}
		}
	}
}
int KSwordOnLineSever::GetNetStatus(const unsigned long lnID)
{
	if (lnID >= m_nMaxPlayer)
		return enumNetUnconnect;

	return m_pGameStatus[lnID].nNetStatus;
}

void KSwordOnLineSever::SetNetStatus(const unsigned long lnID, NetStatus nStatus)
{
	if (lnID >= m_nMaxPlayer)
		return;

	if (nStatus == enumNetUnconnect)
	{
		const int nSessionPlayerIndex =
			m_pGameStatus[lnID].nPlayerIndex;
		if (nSessionPlayerIndex > 0 &&
			m_pGameStatus[lnID].nGameStatus != enumPlayerPlaying &&
			m_pGameStatus[lnID].nGameStatus != enumPlayerExchangingServer)
		{
			NotifyGatewayWorldSession(nSessionPlayerIndex,
				PHONGTHAN_WORLD_SESSION_LEAVING,
				PHONGTHAN_WORLD_SESSION_REASON_DISCONNECTED,
				TRUE, 0, 0);
			UnbindPhongThanRelaySession(
				m_RelayClient,
				nSessionPlayerIndex,
				PHONGTHAN_RELAY_SESSION_END_DISCONNECTED);
		}
		if (m_pGameStatus[lnID].nGameStatus == enumPlayerPlaying
			|| (m_pGameStatus[lnID].nGameStatus == enumPlayerExchangingServer
			&& m_pGameStatus[lnID].nExchangeStatus != enumExchangeCleaning))	// ??????????????????
		{
			int nIndex = m_pGameStatus[lnID].nPlayerIndex;
			m_pCoreServerShell->ClientDisconnect(nIndex);
		}
		else
		{
			int nIndex = m_pGameStatus[lnID].nPlayerIndex;
			m_pCoreServerShell->PreparePlayerForLoginFailed(nIndex);
		}
		m_pGameStatus[lnID].nGameStatus = enumPlayerBegin;
		m_pGameStatus[lnID].nPlayerIndex = 0;
		m_pGameStatus[lnID].nExchangeStatus = enumExchangeBegin;
		m_pGameStatus[lnID].nReplyPingTime = 0;
		m_pGameStatus[lnID].nSendPingTime = 0;
	}
	if (nStatus == enumNetConnected)
	{
		m_pGameStatus[lnID].nGameStatus = enumPlayerBegin;
		m_pGameStatus[lnID].nPlayerIndex = 0;
		m_pGameStatus[lnID].nExchangeStatus = enumExchangeBegin;
		m_pGameStatus[lnID].nReplyPingTime = 0;
		m_pGameStatus[lnID].nSendPingTime = 0;
	}
	m_pGameStatus[lnID].nNetStatus = nStatus;
}

int KSwordOnLineSever::ProcessLoginProtocol(const unsigned long lnID, const char* pData, size_t dataLength)
{
	if (!pData || dataLength != sizeof(PHONGTHAN_SESSION_ENTER_WORLD_REQUEST))
	{
		GameServerLoginDiag("process_login_wrong_size id=%lu size=%u",
			(unsigned long)lnID, (unsigned int)dataLength);
		return 0;
	}

	const PHONGTHAN_SESSION_ENTER_WORLD_REQUEST* pRequest =
		(const PHONGTHAN_SESSION_ENTER_WORLD_REQUEST*)pData;
	if (!PhongThanValidateWireHeader(&pRequest->Header, (PHONGTHAN_U32)dataLength) ||
		pRequest->Header.PacketSize != dataLength ||
		pRequest->Header.MessageType != PHONGTHAN_MSG_SESSION_ENTER_WORLD ||
		pRequest->Header.Flags != PHONGTHAN_WIRE_FLAG_REQUEST)
	{
		GameServerLoginDiag("process_login_invalid_wire id=%lu type=%u flags=%u",
			(unsigned long)lnID, (unsigned int)pRequest->Header.MessageType,
			(unsigned int)pRequest->Header.Flags);
		return 0;
	}

	PHONGTHAN_U32 nTicketPrefix = 0;
	memcpy(&nTicketPrefix, pRequest->SessionTicket, sizeof(nTicketPrefix));
	char szClientName[PHONGTHAN_CLIENT_NAME_SIZE + 1];
	memcpy(szClientName, pRequest->ClientName, PHONGTHAN_CLIENT_NAME_SIZE);
	szClientName[PHONGTHAN_CLIENT_NAME_SIZE] = 0;
	GameServerLoginDiag("process_login_start id=%lu size=%u ticket=%08lX name=%s",
		(unsigned long)lnID, (unsigned int)dataLength,
		(unsigned long)nTicketPrefix, szClientName);

	int nIdx = m_pCoreServerShell->AttachPlayer(lnID, pRequest->SessionTicket);
	GameServerLoginDiag("process_login_attach id=%lu index=%d", (unsigned long)lnID, nIdx);
	return nIdx > 0 ? nIdx : 0;
}

BOOL KSwordOnLineSever::SendGameDataToClient(const unsigned long lnID, const int nPlayerIndex)
{
	BOOL			bRet = FALSE;
//#ifndef _STANDALONE
	_ASSERT(m_pServer);

	int				nStep = 0;
	unsigned int	nParam = 0;
	int				bSyncEnd = 0;

	m_pServer->PreparePackSink();
	GameServerLoginDiag("send_game_data_start id=%lu index=%d", (unsigned long)lnID, nPlayerIndex);
	while(true)
	{
		bSyncEnd = (nStep == STEP_SYNC_END);
		bRet = m_pCoreServerShell->PlayerDbLoading(nPlayerIndex, bSyncEnd, nStep, nParam);
		GameServerLoginDiag("send_game_data_step id=%lu index=%d step=%d param=%u sync_end=%d ret=%d",
			(unsigned long)lnID, nPlayerIndex, nStep, nParam, bSyncEnd, (int)bRet);
		if (!bRet)
		{
			GameServerLoginDiag("send_game_data_failed_closed id=%lu index=%d step=%d param=%u",
				(unsigned long)lnID, nPlayerIndex, nStep, nParam);
			m_pCoreServerShell->PreparePlayerForLoginFailed(nPlayerIndex);
			printf("PlayerDbLoading failed.\n");	//[wxb 2003-7-28]
			break;
		}
		if (bSyncEnd)
		{
			m_pGameStatus[lnID].nGameStatus = enumPlayerSyncEnd;

			PHONGTHAN_WORLD_SYNC_FENCE SyncEnd;
			ZeroMemory(&SyncEnd, sizeof(SyncEnd));
			PhongThanInitializeWireHeader(&SyncEnd.Header, PHONGTHAN_MSG_WORLD_SYNC_COMPLETE,
				sizeof(SyncEnd), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
			m_pCoreServerShell->GetSessionTicket(nPlayerIndex, SyncEnd.SessionTicket);
#ifndef _STANDALONE
			if (FAILED(m_pServer->PackDataToClient(lnID, &SyncEnd, sizeof(SyncEnd))))
#else
			if (!SUCCEEDED(m_pServer->PackDataToClient(lnID, &SyncEnd, sizeof(SyncEnd))))
#endif
			{
				printf("Packing failed. %d, %d, %d\n", lnID);	//[wxb 2003-7-28]
				bRet = FALSE;
				break;
			}
			GameServerLoginDiag("send_game_data_syncend_packed id=%lu", (unsigned long)lnID);
			g_DebugLog("[TRACE]SyncEnd:%d", lnID);
			break;
		}
	}

#ifdef WIN32
	{
		HRESULT hrSend = m_pServer->SendPackToClient(lnID);
		GameServerLoginDiag("send_game_data_flush id=%lu hr=0x%08lX ret=%d", (unsigned long)lnID, (unsigned long)hrSend, (int)bRet);
		if (FAILED(hrSend))
	{
		bRet = FALSE;
	}
	}
#else
	if (m_pServer->SendPackToClient(lnID) <= 0)
		bRet = FALSE;
#endif
	return bRet;
}

BOOL KSwordOnLineSever::ProcessSyncReplyProtocol(const unsigned long lnID, const char* pData, size_t dataLength)
{
	if (!PhongThanWorldFixedPacket(pData, (PHONGTHAN_U32)dataLength,
		PHONGTHAN_MSG_WORLD_SYNC_COMPLETE, PHONGTHAN_WIRE_FLAG_REQUEST,
		sizeof(PHONGTHAN_WORLD_SYNC_FENCE))) return FALSE;
	const int index = m_pGameStatus[lnID].nPlayerIndex;
	if (index <= 0) return FALSE;
	PHONGTHAN_U8 ticket[PHONGTHAN_SESSION_TICKET_SIZE];
	ZeroMemory(ticket, sizeof(ticket));
	m_pCoreServerShell->GetSessionTicket(index, ticket);
	return memcmp(ticket, ((const PHONGTHAN_WORLD_SYNC_FENCE*)pData)->SessionTicket, sizeof(ticket)) == 0;
}

void KSwordOnLineSever::ExitAllPlayer()
{
	extern bool g_PhongThanShutdownSaved;
	g_PhongThanShutdownSaved = true;
	for (int lnID = 0; lnID < m_nMaxPlayer; ++lnID)
	{
		const int nIndex = m_pGameStatus[lnID].nPlayerIndex;
		if (nIndex <= 0)
			continue;

		NotifyGatewayWorldSession(nIndex,
			PHONGTHAN_WORLD_SESSION_LEAVING,
			PHONGTHAN_WORLD_SESSION_REASON_SERVER_SHUTDOWN,
			TRUE, 0, 0);
		UnbindPhongThanRelaySession(m_RelayClient, nIndex,
			PHONGTHAN_RELAY_SESSION_END_SERVER_SHUTDOWN);

		BOOL bSaving = SavePlayerData(nIndex, true);
		bool acknowledged = false;
		int nCount = 0;
		while (bSaving && nCount++ <= 30000)
		{
			unsigned int uSize = 0;
			const char* pData = (const char*)
				m_pDatabaseClient->GetPackFromServer(uSize);
			if (pData && uSize)
			{
				DatabaseMessageProcess(pData, uSize);
				if (m_pCoreServerShell->GetSaveStatus(nIndex) == SAVE_IDLE)
				{
					acknowledged = true;
					break;
				}
			}
#ifdef WIN32
			Sleep(1);
#else
			usleep(1000);
#endif
		}

		if (!acknowledged) g_PhongThanShutdownSaved = false;
		GameServerLoginDiag("shutdown_save index=%d sent=%d acknowledged=%d", nIndex, bSaving, acknowledged);
		m_pCoreServerShell->ClientDisconnect(nIndex);
		if (m_pCoreServerShell->IsCharacterQuiting(nIndex))
			m_pCoreServerShell->RemoveQuitingPlayer(nIndex);
	}
}
void KSwordOnLineSever::SetRunningStatus(BOOL bStatus)
{
	m_bIsRunning = bStatus;
}

BOOL KSwordOnLineSever::GetLocalIpAddress(DWORD *pIntranetAddr, DWORD *pInternetAddr)
{
#ifndef _STANDALONE
	return gGetMacAndIPAddress(NULL, pIntranetAddr, NULL, pInternetAddr);
#else
	char	szIp[16];
	DWORD	dwAddr1, dwAddr2;
	dwAddr1 = dwAddr2 = 0;

	char strHost[MAX_PATH];
	strHost[0] = 0;
	if(SOCKET_ERROR != gethostname(strHost, sizeof(strHost))) {
		struct hostent* hp;
		hp = gethostbyname( strHost );
#ifndef WIN32
		if (!hp ||
			hp && hp->h_addr_list[0] && *(unsigned long *)hp->h_addr_list[0] == 0x0100007f)
		{
			int sock;
			struct ifreq ifr;
			char* ip = NULL;
			int err = -1;

			sock = socket(PF_INET, SOCK_DGRAM, IPPROTO_IP);
			if (sock >= 0) {
				strcpy(ifr.ifr_name, "eth0");
				ifr.ifr_addr.sa_family = AF_INET;

				err = ioctl(sock, SIOCGIFADDR, &ifr);
				if (err == 0) {
					dwAddr1 = (((struct sockaddr_in*) &(ifr.ifr_addr))->sin_addr).s_addr;
					ip =  inet_ntoa(((struct sockaddr_in*) &(ifr.ifr_addr))->sin_addr);
					printf("IP-addr1: %s\n", ip);
				}

				strcpy(ifr.ifr_name, "eth1");
				ifr.ifr_addr.sa_family = AF_INET;

				err = ioctl(sock, SIOCGIFADDR, &ifr);
				if (err == 0) {
					dwAddr2 = (((struct sockaddr_in*) &(ifr.ifr_addr))->sin_addr).s_addr;
					ip =  inet_ntoa(((struct sockaddr_in*) &(ifr.ifr_addr))->sin_addr);
					printf("IP-addr2: %s\n", ip);
				}
				else
					dwAddr2 = dwAddr1;
				closesocket(sock);
			}
		}
		else
#endif
		{
		if(hp && hp->h_addr_list[0]) {
			dwAddr1 = *(unsigned long *)hp->h_addr_list[0];
			if (!dwAddr1)
				dwAddr1 = *(unsigned long *)hp->h_addr_list[1];
/*			*((char *)&dwAddr1) = hp->h_addr_list[0][3];
			*((char *)&dwAddr1 + 1) = hp->h_addr_list[0][2];
			*((char *)&dwAddr1 + 2) = hp->h_addr_list[0][1];
			*((char *)&dwAddr1 + 3) = hp->h_addr_list[0][0];*/
//			dwAddr1 = hp->h_addr_list[0];
		}
		if(hp && hp->h_addr_list[1]) {
			dwAddr2 = *(unsigned long *)hp->h_addr_list[1];
			if (!dwAddr2)
				dwAddr2 = *(unsigned long *)hp->h_addr_list[0];
//			dwAddr2 = hp->h_addr_list[1];
/*			*((char *)&dwAddr2) = hp->h_addr_list[1][3];
			*((char *)&dwAddr2 + 1) = hp->h_addr_list[1][2];
			*((char *)&dwAddr2 + 2) = hp->h_addr_list[1][1];
			*((char *)&dwAddr2 + 3) = hp->h_addr_list[1][0];*/
		}
		else
			dwAddr2 = dwAddr1;
		}
	}

	if ((dwAddr1 & 0x0000FFFF) == 0x0000a8c0)	// intranet
	{
		*pIntranetAddr = dwAddr1;
		*pInternetAddr = dwAddr2;
	}
	else
	{
		*pIntranetAddr = dwAddr2;
		*pInternetAddr = dwAddr1;
	}
	return TRUE;
#endif
}

void KSwordOnLineSever::ProcessPlayerTongMsg(const unsigned long nPlayerIdx, const char* pData, size_t dataLength)
{
	if (nPlayerIdx <= 0 || nPlayerIdx >= MAX_PLAYER)
		return;
	if (!pData)
		return;
	if (dataLength < sizeof(STONG_PROTOCOL_HEAD))
		return;
	int	nPLength = ((STONG_PROTOCOL_HEAD*)pData)->m_wLength;
	if (nPLength + 1 > dataLength)
		return;

	switch (((STONG_PROTOCOL_HEAD*)pData)->m_btMsgId)
	{
	// ????????????
	case enumTONG_COMMAND_ID_APPLY_CREATE:
		{
			TONG_APPLY_CREATE_COMMAND	*pApply = (TONG_APPLY_CREATE_COMMAND*)pData;
			STONG_SERVER_TO_CORE_APPLY_CREATE	sApply;

			sApply.m_nCamp = pApply->m_btCamp;
			sApply.m_nPlayerIdx = nPlayerIdx;
			memcpy(sApply.m_szTongName, pApply->m_szName, sizeof(pApply->m_szName));

			// ????????????????
			int nRet = 0xff;
			if (m_pCoreServerShell)
				nRet = m_pCoreServerShell->GetGameData(SGDI_TONG_APPLY_CREATE, (unsigned int)&sApply, 0);
			// ????????????????
			if (nRet == 0)
			{
				char	szPlayerName[32];
				STONG_CREATE_COMMAND	sCreate;

				m_pCoreServerShell->GetGameData(SGDI_CHARACTER_NAME, (unsigned int)szPlayerName, nPlayerIdx);
				sCreate.ProtocolFamily = pf_tong;
				sCreate.ProtocolID = enumC2S_TONG_CREATE;
				sCreate.m_btCamp = pApply->m_btCamp;
				sCreate.m_dwParam = nPlayerIdx;
				sCreate.m_btSex = pApply->m_btSex;
				sCreate.m_nMasterJoinTm = KSG_GetCurSec();
				sCreate.m_btLevel = pApply->m_btLevel;
				sCreate.m_dwPlayerNameID = g_FileName2Id(szPlayerName);
				sCreate.m_btPlayerNameLength = strlen(szPlayerName);
				sCreate.m_btTongNameLength = strlen(sApply.m_szTongName);
				memcpy(sCreate.m_szBuffer, sApply.m_szTongName, sCreate.m_btTongNameLength);
				memcpy(&sCreate.m_szBuffer[sCreate.m_btTongNameLength], szPlayerName, sCreate.m_btPlayerNameLength);
				sCreate.m_wLength = sizeof(STONG_CREATE_COMMAND) - sizeof(sCreate.m_szBuffer) + sCreate.m_btTongNameLength + sCreate.m_btPlayerNameLength;
				if (m_pTongClient)
					m_pTongClient->SendPackToServer((const void*)&sCreate, sCreate.m_wLength);
				break;
			}
			// ??????????????????
			else
			{
				int		nNetID;
				TONG_CREATE_FAIL_SYNC	sFail;
				sFail.ProtocolType = s2c_extendtong;
				sFail.m_btMsgId = enumTONG_SYNC_ID_CREATE_FAIL;
				sFail.m_btFailId = nRet;
				sFail.m_wLength = sizeof(sFail) - 1;
				nNetID = m_pCoreServerShell->GetGameData(SGDI_CHARACTER_NETID, nPlayerIdx, 0);
				if (m_pServer)
					m_pServer->PackDataToClient(nNetID, &sFail, sFail.m_wLength + 1);

				break;
			}
		}
		break;
	case enumTONG_COMMAND_ID_FORCE_CREATE:
		{
			TONG_APPLY_CREATE_COMMAND	*pApply = (TONG_APPLY_CREATE_COMMAND*)pData;
			STONG_SERVER_TO_CORE_APPLY_CREATE	sApply;

			sApply.m_nCamp = pApply->m_btCamp;
			sApply.m_nPlayerIdx = nPlayerIdx;
			memcpy(sApply.m_szTongName, pApply->m_szName, sizeof(pApply->m_szName));

			char	szPlayerName[32];
			STONG_CREATE_COMMAND	sCreate;

			m_pCoreServerShell->GetGameData(SGDI_CHARACTER_NAME, (unsigned int)szPlayerName, nPlayerIdx);
			sCreate.ProtocolFamily = pf_tong;
			sCreate.ProtocolID = enumC2S_TONG_CREATE;
			sCreate.m_btCamp = pApply->m_btCamp;
			sCreate.m_dwParam = nPlayerIdx;
			sCreate.m_btSex = pApply->m_btSex;
			sCreate.m_nMasterJoinTm = KSG_GetCurSec();
			sCreate.m_btLevel = pApply->m_btLevel;
			sCreate.m_dwPlayerNameID = g_FileName2Id(szPlayerName);
			sCreate.m_btPlayerNameLength = strlen(szPlayerName);
			sCreate.m_btTongNameLength = strlen(sApply.m_szTongName);
			memcpy(sCreate.m_szBuffer, sApply.m_szTongName, sCreate.m_btTongNameLength);
			memcpy(&sCreate.m_szBuffer[sCreate.m_btTongNameLength], szPlayerName, sCreate.m_btPlayerNameLength);
			sCreate.m_wLength = sizeof(STONG_CREATE_COMMAND) - sizeof(sCreate.m_szBuffer) + sCreate.m_btTongNameLength + sCreate.m_btPlayerNameLength;
			if (m_pTongClient)
				m_pTongClient->SendPackToServer((const void*)&sCreate, sCreate.m_wLength);
			break;
		}
		break;
	case enumTONG_COMMAND_ID_APPLY_ADD:
		{
			TONG_APPLY_ADD_COMMAND	*pApply = (TONG_APPLY_ADD_COMMAND*)pData;
			if (pApply->m_wLength != sizeof(TONG_APPLY_ADD_COMMAND) - 1)
				break;
			STONG_SERVER_TO_CORE_APPLY_ADD	sAdd;
			sAdd.m_nPlayerIdx = nPlayerIdx;
			sAdd.m_dwNpcID = pApply->m_dwNpcID;
			if (m_pCoreServerShell)
				m_pCoreServerShell->GetGameData(SGDI_TONG_APPLY_ADD, (unsigned int)&sAdd, 0);
		}
		break;
	case enumTONG_COMMAND_ID_JOIN_TONG:
		{
			JOIN_TONG_SYNC	*pJoin = (JOIN_TONG_SYNC*)pData;
			if (pJoin->m_wLength != sizeof(JOIN_TONG_SYNC) - 1)
				break;
			int		nRet = FALSE;
			if (m_pCoreServerShell)
				nRet = m_pCoreServerShell->GetGameData(SGDI_TONG_CHECK_JOIN, nPlayerIdx, 0);
			// ?? relay ????????????
			if (nRet)
			{
				char	szPlayerName[32];
				STONG_ADD_MEMBER_COMMAND	sTong;

				szPlayerName[0] = 0;
				m_pCoreServerShell->GetGameData(SGDI_CHARACTER_NAME, (unsigned int)szPlayerName, nPlayerIdx);

				int PlayerSex = m_pCoreServerShell->GetGameData(SGDI_CHARACTER_SEX, 0, nPlayerIdx);

				sTong.ProtocolFamily = pf_tong;
				sTong.ProtocolID = enumC2S_TONG_ADD_MEMBER;
				sTong.m_dwParam = nPlayerIdx;
				sTong.m_dwPlayerNameID = g_FileName2Id(szPlayerName);
				sTong.m_btPlayerNameLength = strlen(szPlayerName);
				sTong.m_btTongNameLength = strlen(pJoin->m_cTongName);
				sTong.m_nSex = PlayerSex;
				sTong.m_nJoinTm = KSG_GetCurSec();
				memcpy(sTong.m_szBuffer, pJoin->m_cTongName, sTong.m_btTongNameLength);
				memcpy(&sTong.m_szBuffer[sTong.m_btTongNameLength], szPlayerName, sTong.m_btPlayerNameLength);
				sTong.m_wLength = sizeof(STONG_ADD_MEMBER_COMMAND) - sizeof(sTong.m_szBuffer) + sTong.m_btTongNameLength + sTong.m_btPlayerNameLength;
				if (m_pTongClient)
					m_pTongClient->SendPackToServer((const void*)&sTong, sTong.m_wLength);
			}
			else
			{
				break;
			}
		}
		break;
	case enumTONG_COMMAND_ID_ACCEPT_ADD:
		{
			TONG_ACCEPT_MEMBER_COMMAND	*pAccept = (TONG_ACCEPT_MEMBER_COMMAND*)pData;
			if (pAccept->m_wLength != sizeof(TONG_ACCEPT_MEMBER_COMMAND) - 1)
				break;
			if (pAccept->m_btFlag == 0)
			{
				STONG_SERVER_TO_CORE_REFUSE_ADD	sRefuse;
				sRefuse.m_nSelfIdx = nPlayerIdx;
				sRefuse.m_nTargetIdx = pAccept->m_nPlayerIdx;
				sRefuse.m_dwNameID = pAccept->m_dwNameID;
				m_pCoreServerShell->OperationRequest(SSOI_TONG_REFUSE_ADD, (unsigned int)&sRefuse, 0);
				break;
			}
			else
			{
				char	szTongName[16];
				STONG_SERVER_TO_CORE_CHECK_ADD_CONDITION	sAdd;
				sAdd.m_nSelfIdx = nPlayerIdx;
				sAdd.m_nTargetIdx = pAccept->m_nPlayerIdx;
				sAdd.m_dwNameID = pAccept->m_dwNameID;

				int		nRet = FALSE;
				if (m_pCoreServerShell)
					nRet = m_pCoreServerShell->GetGameData(SGDI_TONG_CHECK_ADD_CONDITION, (unsigned int)szTongName, (unsigned int)&sAdd);
				// ?? relay ????????????
				if (nRet)
				{
					char	szPlayerName[16];
					STONG_ADD_MEMBER_COMMAND	sTong;

					szPlayerName[0] = 0;
					m_pCoreServerShell->GetGameData(SGDI_CHARACTER_NAME, (unsigned int)szPlayerName, sAdd.m_nTargetIdx);

					int PlayerSex = m_pCoreServerShell->GetGameData(SGDI_CHARACTER_SEX, 0, sAdd.m_nTargetIdx);

					sTong.ProtocolFamily = pf_tong;
					sTong.ProtocolID = enumC2S_TONG_ADD_MEMBER;
					sTong.m_dwParam = sAdd.m_nTargetIdx;
					sTong.m_dwPlayerNameID = sAdd.m_dwNameID;
					sTong.m_btPlayerNameLength = strlen(szPlayerName);
					sTong.m_btTongNameLength = strlen(szTongName);
					sTong.m_nSex = PlayerSex;
					sTong.m_nJoinTm = KSG_GetCurSec();
					memcpy(sTong.m_szBuffer, szTongName, sTong.m_btTongNameLength);
					memcpy(&sTong.m_szBuffer[sTong.m_btTongNameLength], szPlayerName, sTong.m_btPlayerNameLength);
					sTong.m_wLength = sizeof(STONG_ADD_MEMBER_COMMAND) - sizeof(sTong.m_szBuffer) + sTong.m_btTongNameLength + sTong.m_btPlayerNameLength;
					if (m_pTongClient)
						m_pTongClient->SendPackToServer((const void*)&sTong, sTong.m_wLength);

				}
				else
				{
					break;
				}
			}
		}
		break;
	case enumTONG_COMMAND_ID_ACCEPT_REPLY_ADD:
		{
			TONG_ACCEPT_MEMBER_COMMAND	*pAccept = (TONG_ACCEPT_MEMBER_COMMAND*)pData;
			if (pAccept->m_wLength != sizeof(TONG_ACCEPT_MEMBER_COMMAND) - 1)
				break;
			if (pAccept->m_btFlag == 0)
			{
				STONG_SERVER_TO_CORE_REFUSE_ADD	sRefuse;
				sRefuse.m_nSelfIdx = nPlayerIdx;
				sRefuse.m_nTargetIdx = pAccept->m_nPlayerIdx;
				sRefuse.m_dwNameID = pAccept->m_dwNameID;
				m_pCoreServerShell->OperationRequest(SSOI_TONG_REFUSE_ADD, (unsigned int)&sRefuse, 0);
				break;
			}
			else
			{
				char	szTongName[32];
				STONG_SERVER_TO_CORE_CHECK_ADD_CONDITION	sAdd;
				sAdd.m_nSelfIdx = nPlayerIdx;
				sAdd.m_nTargetIdx = pAccept->m_nPlayerIdx;
				sAdd.m_dwNameID = pAccept->m_dwNameID;

				int		nRet = FALSE;
				if (m_pCoreServerShell)
					nRet = m_pCoreServerShell->GetGameData(SGDI_TONG_CHECK_ADD_CONDITION_REPLY, (unsigned int)szTongName, (unsigned int)&sAdd);
				// ?? relay ????????????
				if (nRet)
				{
					char	szPlayerName[32];
					STONG_ADD_MEMBER_COMMAND	sTong;

					szPlayerName[0] = 0;
					m_pCoreServerShell->GetGameData(SGDI_CHARACTER_NAME, (unsigned int)szPlayerName, sAdd.m_nSelfIdx);

					int PlayerSex = m_pCoreServerShell->GetGameData(SGDI_CHARACTER_SEX, 0, sAdd.m_nSelfIdx);

					sTong.ProtocolFamily = pf_tong;
					sTong.ProtocolID = enumC2S_TONG_ADD_MEMBER;
					sTong.m_dwParam = sAdd.m_nSelfIdx;
					sTong.m_dwPlayerNameID = g_FileName2Id(szPlayerName);
					sTong.m_btPlayerNameLength = strlen(szPlayerName);
					sTong.m_btTongNameLength = strlen(szTongName);
					sTong.m_nSex = PlayerSex;
					sTong.m_nJoinTm = KSG_GetCurSec();
					memcpy(sTong.m_szBuffer, szTongName, sTong.m_btTongNameLength);
					memcpy(&sTong.m_szBuffer[sTong.m_btTongNameLength], szPlayerName, sTong.m_btPlayerNameLength);
					sTong.m_wLength = sizeof(STONG_ADD_MEMBER_COMMAND) - sizeof(sTong.m_szBuffer) + sTong.m_btTongNameLength + sTong.m_btPlayerNameLength;
					if (m_pTongClient)
						m_pTongClient->SendPackToServer((const void*)&sTong, sTong.m_wLength);

				}
				else
				{
					break;
				}
			}
		}
		break;
	case enumTONG_COMMAND_ID_APPLY_INFO:
		{
			TONG_APPLY_INFO_COMMAND	*pInfo = (TONG_APPLY_INFO_COMMAND*)pData;
			if (pInfo->m_wLength < sizeof(TONG_APPLY_INFO_COMMAND) - 1 - sizeof(pInfo->m_szBuf))
				break;
			STONG_SERVER_TO_CORE_GET_INFO	sGet;
			switch (pInfo->m_btInfoID)
			{
			case enumTONG_APPLY_INFO_ID_SELF:
				sGet.m_nSelfIdx = nPlayerIdx;
				sGet.m_nInfoID = pInfo->m_btInfoID;
				sGet.m_nParam1 = pInfo->m_nParam1;
				sGet.m_nParam2 = pInfo->m_nParam2;
				sGet.m_nParam3 = pInfo->m_nParam3;
				sGet.m_szName[0] = 0;
				if (m_pCoreServerShell)
					m_pCoreServerShell->GetGameData(SGDI_TONG_GET_INFO, (unsigned int)&sGet, 0);
				break;
			case enumTONG_APPLY_INFO_ID_MASTER:
				break;
			case enumTONG_APPLY_INFO_ID_DIRECTOR:
				break;
			case enumTONG_APPLY_INFO_ID_MANAGER:
				{
					int nRet = 0;
					sGet.m_nSelfIdx = nPlayerIdx;
					sGet.m_nInfoID = pInfo->m_btInfoID;
					sGet.m_nParam1 = pInfo->m_nParam1;
					sGet.m_nParam2 = pInfo->m_nParam2;
					sGet.m_nParam3 = pInfo->m_nParam3;
					sGet.m_szName[0] = 0;
					if (m_pCoreServerShell)
						nRet = m_pCoreServerShell->GetGameData(SGDI_TONG_GET_INFO, (unsigned int)&sGet, 0);
					if (nRet == 0)
						break;

					STONG_GET_MANAGER_INFO_COMMAND	sGet;
					sGet.ProtocolFamily = pf_tong;
					sGet.ProtocolID = enumC2S_TONG_GET_MANAGER_INFO;
					sGet.m_dwParam = nPlayerIdx;
					sGet.m_nParam1 = pInfo->m_nParam1;
					sGet.m_nParam2 = pInfo->m_nParam2;
					sGet.m_nParam3 = pInfo->m_nParam3;
					if (m_pTongClient)
						m_pTongClient->SendPackToServer((const void*)&sGet, sizeof(sGet));
				}
				break;
			case enumTONG_APPLY_INFO_ID_MEMBER:
				{
					int nRet = 0;
					sGet.m_nSelfIdx = nPlayerIdx;
					sGet.m_nInfoID = pInfo->m_btInfoID;
					sGet.m_nParam1 = pInfo->m_nParam1;
					sGet.m_nParam2 = pInfo->m_nParam2;
					sGet.m_nParam3 = pInfo->m_nParam3;
					sGet.m_szName[0] = 0;
					if (m_pCoreServerShell)
						nRet = m_pCoreServerShell->GetGameData(SGDI_TONG_GET_INFO, (unsigned int)&sGet, 0);
					if (nRet == 0)
						break;

					STONG_GET_MEMBER_INFO_COMMAND	sGet;
					sGet.ProtocolFamily = pf_tong;
					sGet.ProtocolID = enumC2S_TONG_GET_MEMBER_INFO;
					sGet.m_dwParam = nPlayerIdx;
					sGet.m_nParam1 = pInfo->m_nParam1;
					sGet.m_nParam2 = pInfo->m_nParam2;
					sGet.m_nParam3 = pInfo->m_nParam3;
					if (m_pTongClient)
						m_pTongClient->SendPackToServer((const void*)&sGet, sizeof(sGet));
				}
				break;
			case enumTONG_APPLY_INFO_ID_ONE:
				break;
			case enumTONG_APPLY_INFO_ID_TONG_HEAD:
				{
					DWORD	dwTongNameID = 0;

					sGet.m_nSelfIdx = nPlayerIdx;
					sGet.m_nInfoID = pInfo->m_btInfoID;
					sGet.m_nParam1 = pInfo->m_nParam1;
					sGet.m_nParam2 = pInfo->m_nParam2;
					sGet.m_nParam3 = pInfo->m_nParam3;
					sGet.m_szName[0] = 0;

					if (m_pCoreServerShell)
						dwTongNameID = m_pCoreServerShell->GetGameData(SGDI_TONG_GET_INFO, (unsigned int)&sGet, 0);
					if (dwTongNameID == 0)
						break;

					STONG_GET_TONG_HEAD_INFO_COMMAND	sGet;
					sGet.ProtocolFamily	= pf_tong;
					sGet.ProtocolID		= enumC2S_TONG_GET_HEAD_INFO;
					sGet.m_dwParam		= nPlayerIdx;
					sGet.m_dwNpcID		= pInfo->m_nParam1;
					sGet.m_dwTongNameID	= dwTongNameID;
					if (m_pTongClient)
						m_pTongClient->SendPackToServer((const void*)&sGet, sizeof(sGet));
				}
				break;
			}
		}
		break;
	case enumTONG_COMMAND_ID_APPLY_INSTATE:
		{
			TONG_APPLY_INSTATE_COMMAND	*pApply = (TONG_APPLY_INSTATE_COMMAND*)pData;
			if (pApply->m_wLength + 1 != sizeof(TONG_APPLY_INSTATE_COMMAND))
				break;
			int nRet = 0;
			if (m_pCoreServerShell)
				nRet = m_pCoreServerShell->GetGameData(SGDI_TONG_INSTATE_POWER, (unsigned int)pApply, nPlayerIdx);
			if (nRet == 0)
				break;

			STONG_INSTATE_COMMAND	sInstate;
			sInstate.ProtocolFamily	= pf_tong;
			sInstate.ProtocolID		= enumC2S_TONG_INSTATE;
			sInstate.m_btCurFigure	= pApply->m_btCurFigure;
			sInstate.m_btCurPos		= pApply->m_btCurPos;
			sInstate.m_btNewFigure	= pApply->m_btNewFigure;
			sInstate.m_btNewPos		= pApply->m_btNewPos;
			sInstate.m_dwParam		= nPlayerIdx;
			sInstate.m_dwTongNameID	= pApply->m_dwTongNameID;
			memset(sInstate.m_szName, 0, sizeof(sInstate.m_szName));
			memcpy(sInstate.m_szName, pApply->m_szName, pApply->m_wLength + 1 + sizeof(pApply->m_szName) - sizeof(TONG_APPLY_INSTATE_COMMAND));

			if (m_pTongClient)
				m_pTongClient->SendPackToServer((const void*)&sInstate, sizeof(sInstate));
		}
		break;

	case enumTONG_COMMAND_ID_APPLY_KICK:
		{
			TONG_APPLY_KICK_COMMAND	*pKick = (TONG_APPLY_KICK_COMMAND*)pData;
			if (pKick->m_wLength + 1 != sizeof(TONG_APPLY_KICK_COMMAND))
				break;
			int nRet = 0;
			if (m_pCoreServerShell)
				nRet = m_pCoreServerShell->GetGameData(SGDI_TONG_KICK_POWER, (unsigned int)pKick, nPlayerIdx);
			if (nRet == 0)
				break;

			STONG_KICK_COMMAND	sKick;
			sKick.ProtocolFamily	= pf_tong;
			sKick.ProtocolID		= enumC2S_TONG_KICK;
			sKick.m_dwParam			= nPlayerIdx;
			sKick.m_dwTongNameID	= pKick->m_dwTongNameID;
			sKick.m_btFigure		= pKick->m_btFigure;
			sKick.m_btPos			= pKick->m_btPos;
			memcpy(sKick.m_szName, pKick->m_szName, sizeof(pKick->m_szName));

			if (m_pTongClient)
				m_pTongClient->SendPackToServer((const void*)&sKick, sizeof(sKick));
		}
		break;
	case enumTONG_COMMAND_ID_APPLY_LEAVE:
		{
			TONG_APPLY_LEAVE_COMMAND	*pLeave = (TONG_APPLY_LEAVE_COMMAND*)pData;
			if (pLeave->m_wLength + 1 != sizeof(TONG_APPLY_LEAVE_COMMAND))
				break;
			int nRet = 0;
			if (m_pCoreServerShell)
				nRet = m_pCoreServerShell->GetGameData(SGDI_TONG_LEAVE_POWER, (unsigned int)pLeave, nPlayerIdx);
			if (nRet == 0)
				break;

			STONG_LEAVE_COMMAND	sLeave;
			sLeave.ProtocolFamily	= pf_tong;
			sLeave.ProtocolID		= enumC2S_TONG_LEAVE;
			sLeave.m_dwParam		= nPlayerIdx;
			sLeave.m_dwTongNameID	= pLeave->m_dwTongNameID;
			sLeave.m_btFigure		= pLeave->m_btFigure;
			sLeave.m_btPos			= pLeave->m_btPos;
			memcpy(sLeave.m_szName, pLeave->m_szName, sizeof(pLeave->m_szName));

			if (m_pTongClient)
				m_pTongClient->SendPackToServer((const void*)&sLeave, sizeof(sLeave));
		}
		break;
	case enumTONG_COMMAND_ID_APPLY_CHANGE_MASTER:
		{
			TONG_APPLY_CHANGE_MASTER_COMMAND	*pChange = (TONG_APPLY_CHANGE_MASTER_COMMAND*)pData;
			if (pChange->m_wLength + 1 != sizeof(TONG_APPLY_CHANGE_MASTER_COMMAND))
				break;
			int nRet = 0;
			if (m_pCoreServerShell)
				nRet = m_pCoreServerShell->GetGameData(SGDI_TONG_CHANGE_MASTER_POWER, (unsigned int)pChange, nPlayerIdx);
			if (nRet == 0)
				break;
			STONG_CHANGE_MASTER_COMMAND	sChange;
			sChange.ProtocolFamily	= pf_tong;
			sChange.ProtocolID		= enumC2S_TONG_CHANGE_MASTER;
			sChange.m_btFigure		= pChange->m_btFigure;
			sChange.m_btPos			= pChange->m_btPos;
			sChange.m_dwParam		= nPlayerIdx;
			sChange.m_dwTongNameID	= pChange->m_dwTongNameID;
			memcpy(sChange.m_szName, pChange->m_szName, sizeof(pChange->m_szName));
			if (m_pTongClient)
				m_pTongClient->SendPackToServer((const void*)&sChange, sizeof(sChange));
		}
		break;
	case enumTONG_COMMAND_ID_APPLY_SAVE:
	case enumTONG_COMMAND_ID_APPLY_GET:
		{
			TONG_APPLY_SAVE_COMMAND	*pChange = (TONG_APPLY_SAVE_COMMAND*)pData;
			if (pChange->m_wLength + 1 != sizeof(TONG_APPLY_SAVE_COMMAND))
				break;
			int nRet = 0;
			if (m_pCoreServerShell)
				nRet = m_pCoreServerShell->GetGameData(SGDI_TONG_MONEY_POWER, (unsigned int)pChange, nPlayerIdx);
			if (nRet == 0)
				break;

			STONG_MONEY_COMMAND	sChange;
			sChange.ProtocolFamily	= pf_tong;
			if (pChange->m_btMsgId == enumTONG_COMMAND_ID_APPLY_SAVE)
				sChange.ProtocolID		= enumC2S_TONG_MONEY_SAVE;
			else if (pChange->m_btMsgId == enumTONG_COMMAND_ID_APPLY_GET)
				sChange.ProtocolID		= enumC2S_TONG_MONEY_GET;
			sChange.m_dwMoney		= pChange->m_dwMoney;
			sChange.m_dwParam		= nPlayerIdx;
			sChange.m_dwTongNameID	= pChange->m_dwTongNameID;
			memcpy(sChange.m_szName, pChange->m_szName, sizeof(pChange->m_szName));
			if (m_pTongClient)
					m_pTongClient->SendPackToServer((const void*)&sChange, sizeof(sChange));
		}
		break;
	case enumTONG_COMMAND_ID_APPLY_CHANGE_AGNAME:
		{
			TONG_APPLY_CHANGE_AGNAME_COMMAND	*pChange = (TONG_APPLY_CHANGE_AGNAME_COMMAND*)pData;
			if (pChange->m_wLength + 1 != sizeof(TONG_APPLY_CHANGE_AGNAME_COMMAND))
				break;

			int nRet = 0;
			if (m_pCoreServerShell)
				nRet = m_pCoreServerShell->GetGameData(SGDI_TONG_CHANGE_AGNAME_POWER, (unsigned int)pChange, nPlayerIdx);
			if (nRet == 0)
				break;

			STONG_CHANGE_AGNAME_COMMAND	sChange;
			sChange.ProtocolFamily	= pf_tong;
			sChange.ProtocolID		= enumC2S_TONG_CHANGE_AGNAME;
			sChange.m_btFigure		= pChange->m_btFigure;
			sChange.m_btPos			= pChange->m_btPos;
			sChange.m_dwParam		= nPlayerIdx;
			sChange.m_dwTongNameID	= pChange->m_dwTongNameID;
			memcpy(sChange.m_szName, pChange->m_szName, sizeof(pChange->m_szName));
			memcpy(sChange.m_szAgname, pChange->m_szAgname, sizeof(pChange->m_szAgname));
			if (m_pTongClient)
				m_pTongClient->SendPackToServer((const void*)&sChange, sizeof(sChange));
		}
		break;
	case enumTONG_COMMAND_ID_APPLY_CHANGE_SEX_AGNAME:
		{
			TONG_APPLY_CHANGE_SEX_AGNAME_COMMAND	*pChange = (TONG_APPLY_CHANGE_SEX_AGNAME_COMMAND*)pData;
			if (pChange->m_wLength + 1 != sizeof(TONG_APPLY_CHANGE_SEX_AGNAME_COMMAND))
				break;

			int nRet = 0;
			if (m_pCoreServerShell)
				nRet = m_pCoreServerShell->GetGameData(SGDI_TONG_CHANGE_SEX_AGNAME_POWER, (unsigned int)pChange, nPlayerIdx);
			if (nRet == 0)
				break;

			STONG_ACCEPT_SEX_AGNAME_COMMAND	sChange;
			sChange.ProtocolFamily	= pf_tong;
			sChange.ProtocolID		= enumC2S_TONG_ACCEPT_SEX_AGNAME;
			sChange.m_btSex			= pChange->m_btSex;
			sChange.m_dwParam		= nPlayerIdx;
			sChange.m_dwTongNameID	= pChange->m_dwTongNameID;
			memcpy(sChange.m_szAgname, pChange->m_szAgname, sizeof(pChange->m_szAgname));
			if (m_pTongClient)
				m_pTongClient->SendPackToServer((const void*)&sChange, sizeof(sChange));
		}
		break;
	case enumTONG_COMMAND_ID_APPLY_CHANGE_CAMP:
		{
			TONG_APPLY_CHANGE_CAMP_COMMAND	*pChange = (TONG_APPLY_CHANGE_CAMP_COMMAND*)pData;
			if (pChange->m_wLength + 1 != sizeof(TONG_APPLY_CHANGE_CAMP_COMMAND))
				break;

			int nRet = 0xff;
			if (m_pCoreServerShell)
				nRet = m_pCoreServerShell->GetGameData(SGDI_TONG_APPLY_CHANGE_CAMP, (unsigned int)&pChange, 0);

			if (nRet == 0)
			{
				STONG_CHANGE_CAMP_COMMAND	sChange;

				sChange.ProtocolFamily = pf_tong;
				sChange.ProtocolID = enumC2S_TONG_CHANGE_CAMP;
				sChange.m_btCamp = pChange->m_btCamp;
				sChange.m_nMoney = pChange->m_nMoney;
				sChange.m_dwParam = nPlayerIdx;
				sChange.m_dwTongNameID	= pChange->m_dwTongNameID;
				if (m_pTongClient)
					m_pTongClient->SendPackToServer((const void*)&sChange, sizeof(sChange));
				break;
			}
			else
			{
				int		nNetID;
				TONG_CHANGE_CAMP_FAIL_SYNC	sFail;
				sFail.ProtocolType = s2c_extendtong;
				sFail.m_btMsgId = enumTONG_SYNC_ID_CHANGE_CAMP_FAIL;
				sFail.m_btFailID = nRet;
				sFail.m_wLength = sizeof(sFail) - 1;
				nNetID = m_pCoreServerShell->GetGameData(SGDI_CHARACTER_NETID, nPlayerIdx, 0);
				if (m_pServer)
					m_pServer->PackDataToClient(nNetID, &sFail, sFail.m_wLength + 1);

				break;
			}
		}
		break;
	case enumTONG_COMMAND_ID_APPLY_CHANGE_JIYU:
		{
			TONG_APPLY_CHANGE_INFO_COMMAND	*pInfo = (TONG_APPLY_CHANGE_INFO_COMMAND*)pData;
			if (pInfo->m_wLength + 1 != sizeof(TONG_APPLY_CHANGE_INFO_COMMAND))
				break;

			int nRet = 0;
			if (m_pCoreServerShell)
				nRet = m_pCoreServerShell->GetGameData(SGDI_TONG_CHANGE_INFO_TONG, (unsigned int)pInfo, nPlayerIdx);
			if (nRet == 0)
				break;

			STONG_CHANGE_TONG_INFO_COMMAND	sChange;
			sChange.ProtocolFamily	= pf_tong;
			sChange.ProtocolID = enumC2S_TONG_CHANGE_JIYU;
			sChange.m_nTongJiyuParam = pInfo->m_nTongJiyuParam;
			memcpy(sChange.m_szTongJiyuNotify, pInfo->m_szTongJiyuNotify, sizeof(pInfo->m_szTongJiyuNotify));
			sChange.m_dwParam		= nPlayerIdx;
			sChange.m_dwTongNameID	= pInfo->m_dwTongNameID;
			sChange.m_nValue		= pInfo->m_nMoney;
			memcpy(sChange.m_szName, pInfo->m_szName, sizeof(pInfo->m_szName));
			if (m_pTongClient)
				m_pTongClient->SendPackToServer((const void*)&sChange, sizeof(sChange));
		}
		break;
	case enumTONG_COMMAND_ID_APPLY_CHANGE_RECRUIT:
		{
			TONG_CHANGE_RECRUIT_COMMAND	*pInfo = (TONG_CHANGE_RECRUIT_COMMAND*)pData;
			if (pInfo->m_wLength + 1 != sizeof(TONG_CHANGE_RECRUIT_COMMAND))
				break;

			int nRet = 0;
			if (m_pCoreServerShell)
				nRet = m_pCoreServerShell->GetGameData(SGDI_TONG_CHANGE_RECRUIT, (unsigned int)pInfo, nPlayerIdx);
			if (nRet == 0)
				break;

			STONG_CHANGE_TONG_INFO_COMMAND	sChange;
			sChange.ProtocolFamily	= pf_tong;
			sChange.ProtocolID = enumC2S_CHANGE_TONG_RECRUIT;
			sChange.m_dwParam		= nPlayerIdx;
			sChange.m_dwTongNameID	= pInfo->m_dwTongNameID;
			sChange.m_nValue 		= pInfo->m_bRecruit;
			if (m_pTongClient)
				m_pTongClient->SendPackToServer((const void*)&sChange, sizeof(sChange));
		}
		break;
	case enumCOMMAND_UPDATE_EXTPOINT: //TamLTM fix xu;
		{
			APPLY_GET_EXTPOINT_COMMAND* pExt = (APPLY_GET_EXTPOINT_COMMAND*)pData;
			if (pExt->m_wLength + 1 != sizeof(APPLY_GET_EXTPOINT_COMMAND))
				break;

			STONG_UPDATE_EXTPOINT_COMMAND	nExtCmd;
			char	szName[32];
			m_pCoreServerShell->GetGameData(SGDI_CHARACTER_ACCOUNT, (unsigned int)szName, nPlayerIdx);
			nExtCmd.ProtocolFamily = pf_tong;
			nExtCmd.ProtocolID = enumC2S_UPDATE_EXTPOINT;
			strcpy(nExtCmd.m_szAccountName, (char*)szName);
			nExtCmd.m_nExtPoint = pExt->m_nExtPoint;
			nExtCmd.m_dwParam = nPlayerIdx;
			if (m_pTongClient)
				m_pTongClient->SendPackToServer((const void*)&nExtCmd, sizeof(nExtCmd));
		}
		break;
	}
}

BOOL KSwordOnLineSever::CheckPlayerID(unsigned long netidx, DWORD nameid)
{
	if (netidx < 0 || netidx >= m_nMaxPlayer)
		return FALSE;

	int idx = m_pGameStatus[netidx].nPlayerIndex;
	if (idx <= 0 || idx >= MAX_PLAYER)
		return FALSE;

	if (nameid != m_pCoreServerShell->GetGameData(SGDI_CHARACTER_ID, idx, 0))
		return FALSE;

	return TRUE;
}

void WriteFile(const char* szLinks,const char* szStr)
{
	/*FILE* FileHwnd1;
	FileHwnd1 = fopen(szLinks,"a+");
	fprintf(FileHwnd1,"%s\n",szStr);
	fclose(FileHwnd1);*/
}
