#include "Stdafx.h"
#include "GameServer.h"
#include "IPlayer.h"
#include "GamePlayer.h"

#include "msg_define.h"

#include <process.h>
#include <stdio.h>

#include "AccountLoginDef.h"

#include "Macro.h"
#include "SmartClient.h"

using OnlineGameLib::Win32::CCriticalSection;
using OnlineGameLib::Win32::CEvent;
using OnlineGameLib::Win32::CBuffer;
using OnlineGameLib::Win32::CPackager;
using OnlineGameLib::Win32::ToString;
using OnlineGameLib::Win32::_tstring;

CBuffer::Allocator						CGameServer::m_theGlobalAllocator( 1024 * 96, 200 );

CCriticalSection						CGameServer::m_csMapIDAction;
CGameServer::stdMapIDConvert			CGameServer::m_theMapIDConvert;

CEvent									CGameServer::m_shQuitEvent( NULL, true, false, NULL/*"GS_QUIT_EVENT"*/ );
CEvent									CGameServer::m_shStartupManagerThreadEvent( NULL, false, false, NULL/*"GS_MANAGER_EVENT"*/ );

HANDLE									CGameServer::m_shManagerThread = NULL;

CGameServer::stdGameSvr					CGameServer::m_theGameServers;
CCriticalSection						CGameServer::m_csGameSvrAction;

/*
 * CGamePlayer Global Function
 */
bool CGameServer::SetupGlobalAllocator( size_t bufferSize, size_t maxFreeBuffers )
{
	return CGameServer::m_theGlobalAllocator.ReSet( bufferSize, maxFreeBuffers );
}

LONG CGameServer::m_slnIdentityCounts = 0L;

static bool GeneratePhongThanSessionTicket(
	PHONGTHAN_U8 Ticket[PHONGTHAN_SESSION_TICKET_SIZE])
{
	if (!Ticket)
		return false;
	typedef BOOLEAN (APIENTRY *PFN_PHONGTHAN_RANDOM)(PVOID, ULONG);
	HMODULE hProvider = LoadLibraryA("advapi32.dll");
	if (!hProvider)
		return false;
	PFN_PHONGTHAN_RANDOM pGenerate = (PFN_PHONGTHAN_RANDOM)
		GetProcAddress(hProvider, "SystemFunction036");
	const BOOL bGenerated = pGenerate && pGenerate(Ticket,
		PHONGTHAN_SESSION_TICKET_SIZE);
	FreeLibrary(hProvider);
	return bGenerated ? true : false;
}

/*
 * class CGameServer
 */
CGameServer::CGameServer( IServer *pGameSvrServer,
						 IClient *pAccountClient,
						 UINT nIdentityID /* = -1 */ )
				: m_lnIdentityID( nIdentityID )
				, m_pGameSvrServer( pGameSvrServer )
//				, m_pAccountClient( pAccountClient )
				, m_nServerIP_Internet( 0 )
				, m_nServerIP_Intraner( 0 )
				, m_nServerPort( 0 )
				, m_dwCapability( -1 )

{
	LONG lnID = ::InterlockedExchangeAdd( &m_slnIdentityCounts, 1 );

	m_lnIdentityID = ( ( UINT )( -1 ) == m_lnIdentityID ) ? lnID : m_lnIdentityID;
}

CGameServer::~CGameServer()
{
//	SAFE_RELEASE( m_pGameSvrServer );
//	SAFE_RELEASE( m_pAccountClient );

	m_thePackager.Empty();

	::InterlockedExchangeAdd( &m_slnIdentityCounts, -1 );
}

bool CGameServer::Create()
{
	return _QueryWorldService();
}
bool CGameServer::Destroy()
{
	{
		CCriticalSection::Owner lock( m_csAITS );

		stdAccountAttachIn::iterator it;

		for ( it = m_theAccountInThisServer.begin(); it != m_theAccountInThisServer.end(); it ++ )
		{
			string sAccountName = ( *it ).first;

			FreezeMoney( sAccountName.c_str(), 0);
		}
	}

	m_dwCapability	= 0;
	m_nServerPort	= 0;
	m_nServerIP_Intraner = 0;
	m_nServerIP_Internet = 0;
	m_sServerIPAddr_Internet = "";
	m_sServerIPAddr_Intraner = "";

	{
		CCriticalSection::Owner locker( m_csMapIDAction );

		stdMapIDConvert::iterator itM2C;

		for ( itM2C = m_theMapIDConvert.begin(); itM2C != m_theMapIDConvert.end(); itM2C ++ )
		{
			stdServerList &sl = ( *itM2C ).second;

			if ( !sl.empty() )
			{
				sl.remove( this );
			}
		}
	}

	return true;
}

void __stdcall CGameServer::GameSvrEventNotify( LPVOID lpParam,
			const unsigned long &ulnID,
			const unsigned long &ulnEventType )
{
	CGameServer::LPNI pNI = reinterpret_cast< CGameServer::NI * >( lpParam );

	ASSERT( pNI );

	CCriticalSection::Owner locker( CGameServer::m_csGameSvrAction );

	switch ( ulnEventType )
	{
	case enumClientConnectCreate:
		{
			IGServer *pGServer = new CGameServer( pNI->pServer, pNI->pClient, ulnID );

			ASSERT( pGServer );

			pGServer->Create();

			std::pair< CGameServer::stdGameSvr::iterator, bool > result =
				CGameServer::m_theGameServers.insert( CGameServer::stdGameSvr::value_type( ulnID, pGServer ) );

			if ( result.second && pNI->hwndContainer && ::IsWindow( pNI->hwndContainer ) )
			{
				::PostMessage( pNI->hwndContainer, WM_GAMESERVER_EXCHANGE, ADD_GAMESERVER_ACTION, ulnID );
			}
		}
		break;

	case enumClientConnectClose:
		{
			stdGameSvr::iterator it;

			if ( CGameServer::m_theGameServers.end() !=
				( it = CGameServer::m_theGameServers.find( ulnID ) ) )
			{
				if ( pNI->hwndContainer && ::IsWindow( pNI->hwndContainer ) )
				{
					::PostMessage( pNI->hwndContainer, WM_GAMESERVER_EXCHANGE, DEL_GAMESERVER_ACTION, ulnID );
				}

				IGServer *pGServer = ( *it ).second;

				ASSERT( pGServer );

				CGameServer::m_theGameServers.erase( it );

				pGServer->Destroy();

				SAFE_DELETE( pGServer );
			}
		}
		break;
	}
}

bool CGameServer::Begin( IServer *pGameSvrServer )
{
	/*
	 * Startup a manager thread
	 */
	DWORD dwThreadID = 0;

	m_shManagerThread = ::CreateThread( NULL,
				0,
				ManagerThreadFunction,
				( void * )pGameSvrServer,
				0,
				&dwThreadID );

	if ( m_shManagerThread == INVALID_HANDLE_VALUE )
	{
		return false;
	}

	m_shStartupManagerThreadEvent.Set();

	return true;
}

void CGameServer::End()
{
	m_shQuitEvent.Set();

	m_shStartupManagerThreadEvent.Set();

	if ( WAIT_TIMEOUT == ::WaitForSingleObject( m_shManagerThread, 5000 ) )
	{
		::TerminateThread( m_shManagerThread, 0 );
	}

	SAFE_CLOSEHANDLE( m_shManagerThread );


	/*
	 * MapID & GameServer
	 */
	{
		CCriticalSection::Owner locker( m_csMapIDAction );

		stdMapIDConvert::iterator itM2C;

		for ( itM2C = m_theMapIDConvert.begin(); itM2C != m_theMapIDConvert.end(); itM2C ++ )
		{
			stdServerList &SL = ( *itM2C ).second;

			SL.clear();
		}

		m_theMapIDConvert.erase( m_theMapIDConvert.begin(), m_theMapIDConvert.end() );
	}

	/*
	 * Clear gameserver information
	 */
	{
		CCriticalSection::Owner locker( m_csGameSvrAction );

		m_theGameServers.erase( m_theGameServers.begin(), m_theGameServers.end() );
	}
}

DWORD WINAPI CGameServer::ManagerThreadFunction( void *pParam )
{
	IServer *pGameSvrServer = ( IServer * )pParam;

	ASSERT( pGameSvrServer );

	m_shStartupManagerThreadEvent.Wait();

	stdGameSvr::iterator it;

	while ( !m_shQuitEvent.Wait( 0 ) )
	{
		CCriticalSection::Owner locker( CGameServer::m_csGameSvrAction );

		for ( it = CGameServer::m_theGameServers.begin();
			it != CGameServer::m_theGameServers.end();
			it ++ )
		{
			UINT nlnID = ( *it ).first;

			size_t datalength = 0;

			const void *pData = pGameSvrServer->GetPackFromClient( nlnID, datalength );

			if ( 0 == datalength || NULL == pData )
			{
				continue;
			}

			IGServer *pGServer = ( *it ).second;

			if ( pGServer )
			{
				pGServer->AnalyzeRequire( pData, datalength );
			}
		}

		::Sleep( 1 );
	}

	SAFE_RELEASE( pGameSvrServer );

	return 0;
}

bool CGameServer::AnalyzeRequire( const void *pData, size_t datalength )
{
	if (!pData || datalength < sizeof(PHONGTHAN_WIRE_HEADER) ||
		datalength > 0xffffffffu ||
		!PhongThanIsWirePacket(pData, (PHONGTHAN_U32)datalength))
	{
		return false;
	}

	const PHONGTHAN_WIRE_HEADER* pHeader =
		(const PHONGTHAN_WIRE_HEADER*)pData;
	if (!PhongThanValidateWireHeader(pHeader,
			(PHONGTHAN_U32)datalength) ||
		pHeader->PacketSize != datalength)
	{
		return false;
	}

	switch (pHeader->MessageType)
	{
	case PHONGTHAN_MSG_SERVICE_WORLD_HELLO:
		return _UpdateWorldService(pData, datalength);
	case PHONGTHAN_MSG_SERVICE_WORLD_MAP_REGISTRY:
		return _UpdateMapRegistry(pData, datalength);
	case PHONGTHAN_MSG_SERVICE_WORLD_SESSION:
		return _UpdateWorldSession(pData, datalength);
	case PHONGTHAN_MSG_SESSION_ENTER_WORLD:
		return _NotifyPlayerLogin(pData, datalength);
	default:
		return false;
	}
}
bool CGameServer::DispatchTask( UINT nTask, const void *pData, size_t datalength, WORD nData)
{
	bool ok = true;

	switch ( nTask )
	{
	case enumSyncRoleInfo:

		ok = _SyncRoleInfo( pData, datalength, nData);

		break;

	case enumTaskProtocol:
	default:
		break;
	}

	return true;
}

bool CGameServer::_QueryWorldService()
{
	PHONGTHAN_SERVICE_WORLD_HELLO_REQUEST Request;
	ZeroMemory(&Request, sizeof(Request));
	PhongThanInitializeWireHeader(&Request.Header,
		PHONGTHAN_MSG_SERVICE_WORLD_HELLO, sizeof(Request),
		PHONGTHAN_WIRE_FLAG_REQUEST, m_lnIdentityID);
	Request.RequestId = m_lnIdentityID;
	return m_pGameSvrServer->SendData(m_lnIdentityID,
		(const void*)&Request, sizeof(Request)) ? true : false;
}

bool CGameServer::_UpdateWorldService(
	const void *pData, size_t datalength)
{
	const PHONGTHAN_SERVICE_WORLD_HELLO_RESPONSE* pResponse =
		(const PHONGTHAN_SERVICE_WORLD_HELLO_RESPONSE*)pData;
	if (!pResponse || datalength != sizeof(*pResponse) ||
		pResponse->Header.Flags != PHONGTHAN_WIRE_FLAG_RESPONSE ||
		pResponse->RequestId != (PHONGTHAN_U32)m_lnIdentityID ||
		!pResponse->ServiceId || !pResponse->Port ||
		!pResponse->Capacity ||
		!memchr(pResponse->InstanceName, 0,
			sizeof(pResponse->InstanceName)))
	{
		return false;
	}

	m_dwCapability = pResponse->Capacity;
	m_nServerPort = pResponse->Port;
	m_nServerIP_Internet = pResponse->PublicAddressV4;
	m_nServerIP_Intraner = pResponse->PrivateAddressV4;
	m_sServerIPAddr_Intraner = OnlineGameLib::Win32::net_ntoa(
		m_nServerIP_Intraner);
	m_sServerIPAddr_Internet = OnlineGameLib::Win32::net_ntoa(
		m_nServerIP_Internet);
	printf("[LOGIN_DIAG][Bishop] world_hello service=%u instance=%s public=%u private=%u port=%u capacity=%u\n",
		(unsigned int)pResponse->ServiceId, pResponse->InstanceName,
		(unsigned int)m_nServerIP_Internet,
		(unsigned int)m_nServerIP_Intraner,
		(unsigned int)m_nServerPort,
		(unsigned int)m_dwCapability);
	return true;
}

bool CGameServer::_UpdateMapRegistry(
	const void *pData, size_t datalength)
{
	const PHONGTHAN_SERVICE_WORLD_MAP_REGISTRY_HEADER* pRegistry =
		(const PHONGTHAN_SERVICE_WORLD_MAP_REGISTRY_HEADER*)pData;
	if (!pRegistry ||
		datalength < sizeof(*pRegistry) ||
		pRegistry->Header.Flags != PHONGTHAN_WIRE_FLAG_REQUEST ||
		!pRegistry->ServiceId ||
		pRegistry->MapCount == 0 ||
		pRegistry->MapCount > PHONGTHAN_WORLD_MAP_LIMIT ||
		datalength != sizeof(*pRegistry) +
			pRegistry->MapCount * sizeof(PHONGTHAN_S32))
	{
		return false;
	}

	{
		CCriticalSection::Owner locker(m_csMapIDAction);
		stdMapIDConvert::iterator it;
		for (it = m_theMapIDConvert.begin();
			it != m_theMapIDConvert.end(); ++it)
		{
			it->second.remove((IGServer*)this);
		}
	}

	const PHONGTHAN_S32* pMapIds = (const PHONGTHAN_S32*)
		((const BYTE*)pData + sizeof(*pRegistry));
	for (PHONGTHAN_U16 i = 0; i < pRegistry->MapCount; ++i)
	{
		if (pMapIds[i] <= 0 ||
			!RegisterServer((UINT)pMapIds[i], (IGServer*)this))
		{
			return false;
		}
	}
	printf("[LOGIN_DIAG][Bishop] world_maps service=%u count=%u\n",
		(unsigned int)pRegistry->ServiceId,
		(unsigned int)pRegistry->MapCount);
	// A listening game socket is not readiness: publish only after all map
	// registrations above have been accepted by the gateway in this process.
	FILE* pReady = fopen("native_world_ready.log", "ab");
	if (pReady)
	{
		fprintf(pReady, "WORLD_READY bishop_pid=%lu service=%u maps=%u\n",
			(unsigned long)GetCurrentProcessId(),
			(unsigned int)pRegistry->ServiceId,
			(unsigned int)pRegistry->MapCount);
		fflush(pReady);
		fclose(pReady);
	}
	return true;
}
bool CGameServer::_NotifyPlayerLogin( const void *pData, size_t datalength )
{
	const PHONGTHAN_SESSION_ENTER_WORLD_RESPONSE* pPermit =
		(const PHONGTHAN_SESSION_ENTER_WORLD_RESPONSE*)pData;
	if (!pPermit || datalength != sizeof(*pPermit) ||
		!PhongThanValidateWireHeader(&pPermit->Header, (PHONGTHAN_U32)datalength) ||
		pPermit->Header.MessageType != PHONGTHAN_MSG_SESSION_ENTER_WORLD ||
		pPermit->Header.Flags != PHONGTHAN_WIRE_FLAG_RESPONSE ||
		!memchr(pPermit->RoleName, 0, sizeof(pPermit->RoleName)) ||
		!memchr(pPermit->AccountName, 0, sizeof(pPermit->AccountName)))
	{
		return false;
	}

	bool ok = false;

	IPlayer *pPlayer = CGamePlayer::Get((const char *)pPermit->RoleName);
	printf("[LOGIN_DIAG][Bishop] gameserver_permit role=%s account=%s permit=%d player=%p ip=%u port=%u\\n",
		pPermit->RoleName, pPermit->AccountName, (int)pPermit->Permit, pPlayer,
		(unsigned int)m_nServerIP_Internet, (unsigned int)m_nServerPort);

	if ( pPlayer )
	{
		PHONGTHAN_SESSION_ENTER_WORLD_RESPONSE Response = *pPermit;
		Response.ServerAddressV4 = m_nServerIP_Internet;
		Response.ServerPort = m_nServerPort;
		ok = pPlayer->AppendData(CGamePlayer::enumOwnerPlayer,
			(const void *)&Response, sizeof(Response));
	}

	return ok;
}

bool CGameServer::_UpdateWorldSession(
	const void *pData, size_t datalength)
{
	const PHONGTHAN_SERVICE_WORLD_SESSION_EVENT* pEvent =
		(const PHONGTHAN_SERVICE_WORLD_SESSION_EVENT*)pData;
	if (!pEvent || datalength != sizeof(*pEvent) ||
		pEvent->Header.Flags != PHONGTHAN_WIRE_FLAG_REQUEST ||
		pEvent->Phase < PHONGTHAN_WORLD_SESSION_ENTERED ||
		pEvent->Phase > PHONGTHAN_WORLD_SESSION_TRANSFER_ABORT ||
		pEvent->ReleaseAccount > 1 ||
		!pEvent->AccountName[0] || !pEvent->RoleName[0] ||
		!memchr(pEvent->AccountName, 0,
			sizeof(pEvent->AccountName)) ||
		!memchr(pEvent->RoleName, 0, sizeof(pEvent->RoleName)))
	{
		return false;
	}

	const char* pAccount = (const char*)pEvent->AccountName;
	switch (pEvent->Phase)
	{
	case PHONGTHAN_WORLD_SESSION_ENTERED:
		if (!HaveAccountInGameServer(pAccount) &&
			!AttatchAccountToGameServer(pAccount, false))
			return false;
		return PushAccount(pAccount);

	case PHONGTHAN_WORLD_SESSION_LEAVING:
		return PopAccount(pAccount,
			pEvent->ReleaseAccount != 0,
			(WORD)pEvent->ExtensionPoint);

	case PHONGTHAN_WORLD_SESSION_TRANSFER_HOLD:
	case PHONGTHAN_WORLD_SESSION_TRANSFER_ABORT:
		if (HaveAccountInGameServer(pAccount))
			return DetachAccountFromGameServer(pAccount);
		return true;

	case PHONGTHAN_WORLD_SESSION_TRANSFER_REBIND:
		if (HaveAccountInGameServer(pAccount))
			return true;
		return AttatchAccountToGameServer(pAccount, false);
	}
	return false;
}
bool CGameServer::PushAccount( const char *pAccountName )
{
	ASSERT( pAccountName );

	return ConsumeMoney( pAccountName );
}

bool CGameServer::PopAccount( const char *pAccountName, bool bUnlockAccount, WORD nExtPoint )//TamLTM fix xu;
{
	ASSERT( pAccountName );

	if ( HaveAccountInGameServer( pAccountName ) )
	{
		if ( bUnlockAccount )
		{
			FreezeMoney( pAccountName, nExtPoint);//TamLTM fix xu;
		}

		DetachAccountFromGameServer( pAccountName );

		return true;
	}

	return false;
}

//Fix
//TamLTM Fix
bool CGameServer::Attach( const char *pAccountName, bool bCheck )
{
    return AttatchAccountToGameServer( pAccountName, bCheck);
}

/*bool CGameServer::Attach( const char *pAccountName )
{
	return AttatchAccountToGameServer( pAccountName );
}*/

/*bool CGameServer::AttatchAccountToGameServer( const char *pAccountName )
{
	if ( !pAccountName || !pAccountName[0] )
	{
		return false;
	}

	if ( _NAME_LEN > strlen( pAccountName ) )
	{
		CCriticalSection::Owner lock( m_csAITS );

		std::pair< stdAccountAttachIn::iterator, bool > result =
			m_theAccountInThisServer.insert( stdAccountAttachIn::value_type( pAccountName,
			reinterpret_cast< void * >( this ) ) );

		return result.second;
	}

	return false;
}*/

//TamLTM Fix ket sever
bool CGameServer::AttatchAccountToGameServer( const char *pAccountName, bool bCheck)
{
    if ( !pAccountName || !pAccountName[0] )
    {
        return false;
    }


    if(bCheck)
    {
        if(HaveAccountInGameServer(pAccountName))
        {
            return false;
        }
        else
        {
            return true;
        }
    }


    if ( _NAME_LEN > strlen( pAccountName ) )
    {
        CCriticalSection::Owner lock( m_csAITS );

        std::pair< stdAccountAttachIn::iterator, bool > result =
                m_theAccountInThisServer.insert( stdAccountAttachIn::value_type( pAccountName,
                                                                                 reinterpret_cast< void * >( this ) ) );

        return result.second;
    }

    return false;
}
//end code

bool CGameServer::HaveAccountInGameServer( const char *pAccountName )
{
	if ( !pAccountName || !pAccountName[0] )
	{
		return false;
	}

	if ( _NAME_LEN > strlen( pAccountName ) )
	{
		CCriticalSection::Owner lock( m_csAITS );

		stdAccountAttachIn::iterator it;

		if ( m_theAccountInThisServer.end() !=
			( it = m_theAccountInThisServer.find( pAccountName ) ) )
		{
			return true;
		}
	}

	return false;
}

bool CGameServer::DetachAccountFromGameServer( const char *pAccountName )
{
	if ( !pAccountName || !pAccountName[0] )
	{
		return false;
	}

	if ( _NAME_LEN > strlen( pAccountName ) )
	{
		CCriticalSection::Owner lock( m_csAITS );

		stdAccountAttachIn::iterator it;

		if ( m_theAccountInThisServer.end() !=
			( it = m_theAccountInThisServer.find( pAccountName ) ) )
		{
			CGameServer *pThis = reinterpret_cast< CGameServer * >( ( *it ).second );

			ASSERT( pThis && pThis == this );

			m_theAccountInThisServer.erase( it );

			return true;
		}
	}

	return false;
}

bool CGameServer::ConsumeMoney( const char *pAccountName )
{
	if (!pAccountName || !pAccountName[0] ||
		strlen(pAccountName) >= sizeof(
			((PHONGTHAN_SERVICE_ACCOUNT_ENTER_WORLD_REQUEST*)0)->AccountName))
	{
		return false;
	}

	PHONGTHAN_SERVICE_ACCOUNT_ENTER_WORLD_REQUEST Request;
	ZeroMemory(&Request, sizeof(Request));
	Request.RequestId = ((PHONGTHAN_U32)m_lnIdentityID << 16) ^
		(PHONGTHAN_U32)GetTickCount();
	PhongThanInitializeWireHeader(&Request.Header,
		PHONGTHAN_MSG_SERVICE_ACCOUNT_ENTER_WORLD, sizeof(Request),
		PHONGTHAN_WIRE_FLAG_REQUEST, Request.RequestId);
	strncpy((char*)Request.AccountName, pAccountName,
		sizeof(Request.AccountName) - 1);
	return g_theSmartClient.Send(&Request, sizeof(Request));
}

bool CGameServer::FreezeMoney( const char *pAccountName, WORD nExtPoint )
{
	if (!pAccountName || !pAccountName[0] ||
		strlen(pAccountName) >= sizeof(
			((PHONGTHAN_SERVICE_ACCOUNT_RELEASE_REQUEST*)0)->AccountName))
	{
		return false;
	}

	PHONGTHAN_SERVICE_ACCOUNT_RELEASE_REQUEST Request;
	ZeroMemory(&Request, sizeof(Request));
	Request.RequestId = ((PHONGTHAN_U32)m_lnIdentityID << 16) ^
		(PHONGTHAN_U32)GetTickCount();
	PhongThanInitializeWireHeader(&Request.Header,
		PHONGTHAN_MSG_SERVICE_ACCOUNT_RELEASE, sizeof(Request),
		PHONGTHAN_WIRE_FLAG_REQUEST, Request.RequestId);
	Request.ExtensionPoint = nExtPoint;
	strncpy((char*)Request.AccountName, pAccountName,
		sizeof(Request.AccountName) - 1);
	return g_theSmartClient.Send(&Request, sizeof(Request));
}
bool CGameServer::_SyncRoleInfo( const void *pData, size_t datalength, WORD nData)
{
	if (!m_pGameSvrServer || !pData || datalength > 0xffffffffu)
		return false;
	const PHONGTHAN_CHARACTER_STATE_HEADER* pState =
		(const PHONGTHAN_CHARACTER_STATE_HEADER*)pData;
	if (!PhongThanValidateCharacterState(pState, (PHONGTHAN_U32)datalength))
		return false;

	const PHONGTHAN_U32 nPacketSize =
		(PHONGTHAN_U32)sizeof(PHONGTHAN_WORLD_ATTACH_CHARACTER_HEADER) +
		(PHONGTHAN_U32)datalength;
	BYTE* pPacket = new BYTE[nPacketSize];
	ZeroMemory(pPacket, nPacketSize);
	PHONGTHAN_WORLD_ATTACH_CHARACTER_HEADER* pAttach =
		(PHONGTHAN_WORLD_ATTACH_CHARACTER_HEADER*)pPacket;
	PhongThanInitializeWireHeader(&pAttach->Header,
		PHONGTHAN_MSG_WORLD_ATTACH_CHARACTER, nPacketSize,
		PHONGTHAN_WIRE_FLAG_REQUEST, 0);
	if (!GeneratePhongThanSessionTicket(pAttach->SessionTicket))
	{
		delete [] pPacket;
		return false;
	}
	pAttach->ExtensionPoint = nData;
	pAttach->ChangedExtensionPoint = 0;
	pAttach->StateSize = (PHONGTHAN_U32)datalength;
	memcpy(pPacket + sizeof(*pAttach), pState, datalength);
	const bool ok = m_pGameSvrServer->SendData(
		m_lnIdentityID, pPacket, nPacketSize) ? true : false;
	delete [] pPacket;
	return ok;
}

bool CGameServer::RegisterServer( UINT nID, IGServer *pGServer )
{
	ASSERT( pGServer );

	CCriticalSection::Owner locker( m_csMapIDAction );

	stdMapIDConvert::iterator it;

	/*
	 * Append this sever information into table
	 */
	if ( m_theMapIDConvert.end() != ( it = m_theMapIDConvert.find( nID ) ) )
	{
		stdServerList& sl = ( *it ).second;

		sl.push_back( pGServer );
	}
	else
	{
		/*
		 * Insert this server information into table
		 */
		stdServerList sl;

		sl.push_back( pGServer );

		std::pair< stdMapIDConvert::iterator, bool > result =
			m_theMapIDConvert.insert( stdMapIDConvert::value_type( nID, sl ) );

		return result.second;
	}

	return true;
}

IGServer *CGameServer::QueryServer( UINT nMapID )
{
	CCriticalSection::Owner locker( m_csMapIDAction );

	stdMapIDConvert::iterator it;

	if ( m_theMapIDConvert.end() != ( it = m_theMapIDConvert.find( nMapID ) ) )
	{
		stdServerList& sl = ( *it ).second;

		/*
		 * TODO : Don't get the server when it can't carry anyone
		 */
		if ( !sl.empty() )
		{
			IGServer *pGServer = NULL;

			stdServerList::iterator it;
			for ( it = sl.begin(); it != sl.end(); it ++ )
			{
				pGServer = ( IGServer * )( *it );

				ASSERT( pGServer );

				if ( NULL == pGServer )
				{
					continue;
				}

				if ( pGServer->GetContent() < pGServer->GetCapability() )
				{
					return pGServer;
				}
			}
		}
	}

	return NULL;
}

IGServer *CGameServer::GetServer( size_t nID )
{
	CCriticalSection::Owner locker( CGameServer::m_csGameSvrAction );

	stdGameSvr::iterator it;

	if ( CGameServer::m_theGameServers.end() !=
		( it = CGameServer::m_theGameServers.find( nID ) ) )
	{
		IGServer *pGServer = ( *it ).second;

		ASSERT( pGServer );

		return pGServer;
	}

	return NULL;
}

size_t CGameServer::GetContent()
{
	CCriticalSection::Owner lock( m_csAITS );

	return m_theAccountInThisServer.size();
}

void CGameServer::SendToAll( const char *pText, int nLength, UINT uOption )
{
	stdGameSvr::iterator it;

	CCriticalSection::Owner locker( CGameServer::m_csGameSvrAction );

	for ( it = CGameServer::m_theGameServers.begin();
		it != CGameServer::m_theGameServers.end();
		it ++ )
		{
			IGServer *pGServer = ( *it ).second;

			if ( pGServer )
			{
				pGServer->SendText( pText, nLength, uOption );
			}
		}
}

//TamLTM fix kill it khong dung toi ham thi bo
/*void CGameServer::PunishAllGSV( const char *pText, int nLength, UINT uOption )
{
	stdGameSvr::iterator it;

	CCriticalSection::Owner locker( CGameServer::m_csGameSvrAction );

	for ( it = CGameServer::m_theGameServers.begin();
		it != CGameServer::m_theGameServers.end();
		it ++ )
		{
			IGServer *pGServer = ( *it ).second;

			if ( pGServer )
			{
				pGServer->PunishAccountName( pText, nLength, uOption );
			}
		}
}*/

void CGameServer::SendText( const char *pText, int nLength, UINT uOption )
{
	if ( !pText || 0 == nLength || !m_pGameSvrServer )
	{
		return;
	}

	tagGatewayBroadCast gbc;

	gbc.cProtocol = s2c_gateway_broadcast;
	gbc.uCmdType = uOption;

	int nLen = 0;
	if ( sizeof( gbc.szData ) > nLength )
	{
		strcpy( gbc.szData, pText );

		nLen = nLength;
	}

	gbc.szData[nLen] = '\0';

	m_pGameSvrServer->SendData( m_lnIdentityID, ( const void * )&gbc, sizeof( tagGatewayBroadCast ) );
}

//TamLTM fix kill it khong dung toi ham thi bo
/*void CGameServer::PunishAccountName( const char *pName, int nLength, UINT uOption )
{
	if ( !pName || 0 == nLength || !m_pGameSvrServer )
	{
		return;
	}

	tagGatewayBroadCast gbc;

	gbc.cProtocol = s2c_punish;
	gbc.uCmdType = uOption;

	int nLen = 0;
	if ( sizeof( gbc.szData ) > nLength )
	{
		strcpy( gbc.szData, pName );

		nLen = nLength;
	}

	gbc.szData[nLen] = '\0';

	m_pGameSvrServer->SendData( m_lnIdentityID, ( const void * )&gbc, sizeof( tagGatewayBroadCast ) );
}*/
