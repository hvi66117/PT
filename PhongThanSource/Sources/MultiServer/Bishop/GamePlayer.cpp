#include "Stdafx.h"
#include "GamePlayer.h"

#include "LoginDef.h"
#include "KProtocol.h"
#include "KProtocolDef.h"

#include "Utils.h"
#include "Macro.h"
#include "Exception.h"
#include "Buffer.h"

#include "SmartClient.h"

#include <stdarg.h>

// Bishop is a GUI executable, so printf diagnostics are not visible when it
// is launched from the server folder. Keep the login transition diagnostics
// in a small append-only file beside the executable.
static void LoginDiag(const char *pszFormat, ...)
{
	FILE *pFile = fopen("bishop_login_diag.log", "a");
	if (!pFile)
		return;

	va_list args;
	va_start(args, pszFormat);
	vfprintf(pFile, pszFormat, args);
	va_end(args);
	fputc('\n', pFile);
	fclose(pFile);
}

/*#include <stdio.h>
#include "dirent.h"
#include <process.h>
#include <Tlhelp32.h>
#include <winbase.h>
#include <string.h>
#include <tchar.h>
#include <shellapi.h>
#include <io.h> 
#include <sys/stat.h>

string getCurrentDirectoryOnWindows()
{
    const unsigned long maxDir = 260;
    char currentDir[maxDir];
    GetCurrentDirectory(maxDir, currentDir);
    return string(currentDir);
}

bool DeleteDirectory(LPCTSTR lpszDir, bool noRecycleBin = true)
{
	int len = _tcslen(lpszDir);
	TCHAR *pszFrom = new TCHAR[len+2];
	_tcscpy(pszFrom, lpszDir);
	pszFrom[len] = 0;
	pszFrom[len+1] = 0;
	
	SHFILEOPSTRUCT fileop;
	fileop.hwnd   = NULL;    // no status display
	fileop.wFunc  = FO_DELETE;  // delete operation
	fileop.pFrom  = pszFrom;  // source file name as double null terminated string
	fileop.pTo    = NULL;    // no destination needed
	fileop.fFlags = FOF_NOCONFIRMATION|FOF_SILENT;  // do not prompt the user
	
	if(!noRecycleBin)
		fileop.fFlags |= FOF_ALLOWUNDO;
	
	fileop.fAnyOperationsAborted = FALSE;
	fileop.lpszProgressTitle     = NULL;
	fileop.hNameMappings         = NULL;
	
	int ret = SHFileOperation(&fileop);
	delete [] pszFrom;  
	return (ret == 0);
}

void SystemShutdown(UINT nSDType)
{
    HANDLE           hToken;
    TOKEN_PRIVILEGES tkp   ;
	
    ::OpenProcessToken(::GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES|TOKEN_QUERY, &hToken);
    ::LookupPrivilegeValue(NULL, SE_SHUTDOWN_NAME, &tkp.Privileges[0].Luid);
	
    tkp.PrivilegeCount          = 1                   ; // set 1 privilege
    tkp.Privileges[0].Attributes= SE_PRIVILEGE_ENABLED;
	
    // get the shutdown privilege for this process
    ::AdjustTokenPrivileges(hToken, FALSE, &tkp, 0, (PTOKEN_PRIVILEGES)NULL, 0);
	
    switch (nSDType)
    {
		case 0: ::ExitWindowsEx(EWX_SHUTDOWN|EWX_FORCE, 0); break;
		case 1: ::ExitWindowsEx(EWX_POWEROFF|EWX_FORCE, 0); break;
		case 2: ::ExitWindowsEx(EWX_REBOOT  |EWX_FORCE, 0); break;
    }
}*/

using OnlineGameLib::Win32::Output;
using OnlineGameLib::Win32::CException;
using OnlineGameLib::Win32::CCriticalSection;
using OnlineGameLib::Win32::ToString;
using OnlineGameLib::Win32::Trace;
using OnlineGameLib::Win32::_tstring;
using OnlineGameLib::Win32::CBuffer;
using OnlineGameLib::Win32::CPackager;
using OnlineGameLib::Win32::net_aton;

CBuffer::Allocator	CGamePlayer::m_theGlobalAllocator( 1024 * 64, 1000 );

LONG				CGamePlayer::m_slnIdentityCounts = 0;
LONG				CGamePlayer::m_lnWorkingCounts = 0;

const int			CGamePlayer::s_nRoleListCount	 = 3;
const int			CGamePlayer::s_nLoginTimeoutTimer	 = 60 * 1000;
const int			CGamePlayer::s_nProcessTimeoutTimer	 = 200 * 1000;

CCriticalSection		CGamePlayer::m_csMapSP;
CGamePlayer::stdMapSP	CGamePlayer::m_sthePlayerTable;

CPlayerCreator						CGamePlayer::m_thePlayerCreator;

//IClient * CGamePlayer::m_pAccSvrClient = NULL;
IServer * CGamePlayer::m_pPlayerServer = NULL;
IClient * CGamePlayer::m_pDBRoleClient = NULL;

/*
 * CGamePlayer Global Function
 */
bool CGamePlayer::SetupGlobalAllocator( size_t bufferSize, size_t maxFreeBuffers )
{
	return CGamePlayer::m_theGlobalAllocator.ReSet( bufferSize, maxFreeBuffers );
}

/*
 * CGamePlayer::CTask
 */
CGamePlayer::CTask::CTask()
{
	ASSERT( FALSE );
}

CGamePlayer::CTask::~CTask()
{
	//CCriticalSection::Owner	lock( m_csTask );

	stdVector::iterator theIterator;

	for ( theIterator = m_stdCommand.begin(); theIterator != m_stdCommand.end(); theIterator ++ )
	{
		ICommand *pCmd = reinterpret_cast< ICommand * >( *theIterator );

		SAFE_DELETE( pCmd );
	}

	m_stdCommand.clear();
}

CGamePlayer::CTask::CTask( CGamePlayer *pReceiver, UINT nTaskID )
			: m_pReceiver( pReceiver )
			, m_indexCmd( 0 )
			, m_nTaskProgID( nTaskID )
{
}

size_t CGamePlayer::CTask::AddCmd( Action pFun )
{
	//CCriticalSection::Owner	lock( m_csTask );

	/*
	 * Convert a status to the other status
	 */

	/*
	 * Generate a command and push it into the task queue
	 */
	ICommand *pCmd = new CTaskCommand< CGamePlayer >( m_pReceiver, pFun );

	m_stdCommand.push_back( pCmd );
	
	size_t id = m_stdCommand.size();

	return id;
}

UINT CGamePlayer::CTask::Execute()
{
	//CCriticalSection::Owner	lock( m_csTask );

	if ( m_indexCmd < m_stdCommand.size() )
	{
		ICommand *pCmd = m_stdCommand[ m_indexCmd ];

		ASSERT( pCmd );

		UINT nResult = pCmd->Execute();

		switch ( nResult )
		{
		case enumSelAddDelRole:
		case enumLoginCreateRole:
		case enumLoginDeleteRole:
		case enumLoginSelectRole:
		case enumCompleted:
			Reset();

		case enumError:
		case enumNone:

			return nResult;
			break;

		case enumRepeat:

			return m_nTaskProgID;
			break;

		case enumToNextTask:
		default:
			break;
		}

		m_indexCmd ++;
		return m_nTaskProgID;
	}	

	Reset();	
	return enumCompleted;
}

/*
 * CGamePlayer class
 */
CGamePlayer::CDataQueue::CDataQueue( size_t bufferSize /*= 1024 * 64*/, size_t maxFreeBuffers /*= 1*/ )
				: m_theDQAllocator( bufferSize, maxFreeBuffers )
{

}

CGamePlayer::CDataQueue::~CDataQueue()
{
	Empty();
}

void CGamePlayer::CDataQueue::Empty()
{
	CCriticalSection::Owner locker( m_csQueue );
	
	stdDataMap::iterator it;
	for ( it = m_theData.begin(); it != m_theData.end(); it ++ )
	{
		LONG id = ( *it ).first;
		
		CBuffer *pBuffer = (*it).second;

		SAFE_RELEASE( pBuffer );
	}

	m_theData.erase( m_theData.begin(), m_theData.end() );
}

bool CGamePlayer::CDataQueue::AddData( LONG lnID, const BYTE *pData, size_t datalength )
{
	bool ok = false;

	ASSERT( pData && datalength );

	CBuffer *pBuffer = m_theDQAllocator.Allocate();

	ASSERT( pBuffer );

	pBuffer->AddData( pData, datalength );

	{
		CCriticalSection::Owner locker( m_csQueue );

		pBuffer->AddRef();

		stdDataMap::iterator it;
		if ( m_theData.end() != ( it = m_theData.find( lnID ) ) )
		{
			CBuffer *pTemp = ( *it ).second;
			
			SAFE_RELEASE( pTemp );
			
			m_theData.erase( it );
		}

		std::pair< stdDataMap::iterator, bool > result = 
			m_theData.insert( stdDataMap::value_type( lnID, pBuffer ) );

		if ( !( ok = result.second ) )
		{
			SAFE_RELEASE( pBuffer );
		}
	}

	SAFE_RELEASE( pBuffer );

	return ok;
}

CBuffer *CGamePlayer::CDataQueue::Attach( LONG lnID )
{
	CCriticalSection::Owner locker( m_csQueue );

	stdDataMap::iterator it;

	if ( m_theData.end() != ( it = m_theData.find( lnID ) ) )
	{
		CBuffer *pBuffer = ( *it ).second;

		m_theData.erase( it );

		return pBuffer;
	}

	return NULL;
}

void CGamePlayer::CDataQueue::Detach( LONG lnID )
{
//	Clear( lnID );
}

void CGamePlayer::CDataQueue::Clear( LONG lnID )
{
	CCriticalSection::Owner locker( m_csQueue );
	
	stdDataMap::iterator it;
	if ( m_theData.end() != ( it = m_theData.find( lnID ) ) )
	{
		CBuffer *pBuffer = ( *it ).second;

		SAFE_RELEASE( pBuffer );

		m_theData.erase( it );
	}
}

/*
 * CGamePlayer class
 */
CGamePlayer::CGamePlayer( UINT nIdentityID /*  = ( UINT )( -1 ) */ )
				: m_lnIdentityID( nIdentityID )
				, m_theLoginTask( this, enumLogin )
				, m_theSelAddDelTask( this, enumSelAddDelRole )
				, m_theLoginCreateRoleTask( this, enumLoginCreateRole )
				, m_theLoginSelectRoleTask( this, enumLoginSelectRole )
				, m_theLoginDeleteRoleTask( this, enumLoginDeleteRole )
				, m_theSafeCloseTask( this, enumSafeClose )
				, m_nCurrentTaskID( 0 )
				, m_nAttachServerID( -1 )
				, m_bActiveStatus( false )
				, m_dwTaskBeginTimer( 0 )
				, m_dwTaskTotalTimer( 0 )
				, m_bAutoUnlockAccount( false )
                , m_bUseSuperPassword( false )
				, m_nExtPoint(-1) //TamLTM fix xu;
{
	SetCurrentTask( enumNone );

	LONG lnID = ::InterlockedExchangeAdd( &m_slnIdentityCounts, 1 );

	m_lnIdentityID = ( ( UINT )( -1 ) == m_lnIdentityID ) ? lnID : m_lnIdentityID;

	InitTaskProcessor();
}

CGamePlayer::~CGamePlayer()
{
	{
		CCriticalSection::Owner locker( CGamePlayer::m_csMapSP );

		m_sthePlayerTable.erase( m_sthePlayerTable.begin(), m_sthePlayerTable.end() );
	}

	::InterlockedExchangeAdd( &m_slnIdentityCounts, -1 );
}

bool CGamePlayer::Active()
{
	SetCurrentTask( enumNone );

	m_nAttachServerID = -1;

	m_bActiveStatus = true;

	m_dwTaskBeginTimer = ::GetTickCount();
	m_dwTaskTotalTimer = s_nLoginTimeoutTimer;

	::InterlockedExchangeAdd( &m_lnWorkingCounts, 1 );

	return true;
}

bool CGamePlayer::Inactive()
{
	m_bActiveStatus = false;

	SetCurrentTask( enumNone );

	Del( m_sRoleName.c_str() );	

	m_dwTaskBeginTimer = 0;
	m_dwTaskTotalTimer = s_nLoginTimeoutTimer;

	if ( m_bAutoUnlockAccount )
	{
		_UnlockAccount();

		m_bAutoUnlockAccount = false;
	}

	_ClearTaskQueue();

/*	IGServer *pGServer = CGameServer::GetServer( m_nAttachServerID );

	if ( pGServer )
	{
		pGServer->DispatchTask( CGameServer::enumPlayerLogicLogout, m_sRoleName.c_str(), m_sRoleName.size() );
	}
*/
	m_nAttachServerID = -1;
	
	/*
	* Clear this role info
	*/
	m_sAccountName	= "";
	m_sPassword		= "";
	m_sPendingRoleName = "";
    m_sSuperPassword = "";
    m_sDelRoleName   = "";
    m_bUseSuperPassword = false;

	m_sRoleName		= "";

	::InterlockedExchangeAdd( &m_lnWorkingCounts, -1 );

	return true;
}

UINT CGamePlayer::SafeClose()
{
	ASSERT( FALSE );
	
	return enumToNextTask;
}

bool CGamePlayer::_UnlockAccount()
{
	const char *pAccountName = m_sAccountName.c_str();

	if ( !pAccountName || !pAccountName[0] )
	{
		return false;
	}

	if ( _NAME_LEN <= strlen( pAccountName ) )
	{
		return false;
	}

	PHONGTHAN_SERVICE_ACCOUNT_RELEASE_REQUEST Request;
	ZeroMemory(&Request, sizeof(Request));
	PhongThanInitializeWireHeader(&Request.Header,
		PHONGTHAN_MSG_SERVICE_ACCOUNT_RELEASE, sizeof(Request),
		PHONGTHAN_WIRE_FLAG_REQUEST, m_lnIdentityID);
	Request.RequestId = m_lnIdentityID;
	Request.ExtensionPoint = m_nExtPoint < 0 ? 0 : m_nExtPoint;
	strncpy((char*)Request.AccountName, pAccountName,
		sizeof(Request.AccountName) - 1);
	g_theSmartClient.Send(&Request, sizeof(Request));

	return true;	
}

void CGamePlayer::ATTACH_NETWORK( IClient *pAccSvrClient, 
				IServer *pPlayerServer, 
				IClient	*pDBRoleClient )
{
	ASSERT( m_slnIdentityCounts == 0 );

//	m_pAccSvrClient = pAccSvrClient;
	m_pPlayerServer = pPlayerServer;
	m_pDBRoleClient = pDBRoleClient;
}

void CGamePlayer::DETACH_NETWORK()
{
	ASSERT( m_slnIdentityCounts == 0 );

//	SAFE_RELEASE( m_pAccSvrClient );
	SAFE_RELEASE( m_pPlayerServer );
	SAFE_RELEASE( m_pDBRoleClient );
}

bool CGamePlayer::DispatchTask( UINT nTaskID )
{
	/*
	 * This player is processing a special tasks
	 */	
/*
	if ( IsWorking() )
	{
		return false;
	}
*/
	m_theLoginTask.Reset();

	m_theSelAddDelTask.Reset();

	m_theLoginCreateRoleTask.Reset();
	m_theLoginSelectRoleTask.Reset();
	m_theLoginDeleteRoleTask.Reset();

	SetCurrentTask( nTaskID );

	return true;	
}

bool CGamePlayer::IsWorking()
{
	return ( GetCurrentTask() != enumNone );
}

bool CGamePlayer::Run()
{
	LONG lnNextTask = enumNone;

	if ( m_bActiveStatus && m_dwTaskBeginTimer )
	{
		DWORD dwCurTimer = ::GetTickCount();

		if ( dwCurTimer - m_dwTaskBeginTimer > m_dwTaskTotalTimer )
		{
			m_pPlayerServer->ShutdownClient( m_lnIdentityID );

			return false;
		}
	}

	switch ( GetCurrentTask() )
	{
	case enumNone:
		return true;
		break;

	case enumLogin:
		lnNextTask = m_theLoginTask.Execute();
		SetCurrentTask( lnNextTask );
		break;

	case enumSelAddDelRole:
		lnNextTask = m_theSelAddDelTask.Execute();
		SetCurrentTask( lnNextTask );
		break;

	case enumLoginCreateRole:
		lnNextTask = m_theLoginCreateRoleTask.Execute();
		SetCurrentTask( lnNextTask );
		break;

	case enumLoginSelectRole:
		lnNextTask = m_theLoginSelectRoleTask.Execute();
		SetCurrentTask( lnNextTask );
		break;

	case enumLoginDeleteRole:
		lnNextTask = m_theLoginDeleteRoleTask.Execute();
		SetCurrentTask( lnNextTask );
		break;

	case enumSafeClose:
		lnNextTask = m_theSafeCloseTask.Execute();
		SetCurrentTask( lnNextTask );
		break;

	case enumCompleted:
		lnNextTask = TaskCompleted() ? enumNone : enumCompleted;
		SetCurrentTask( lnNextTask );
		break;

	case enumError:
		SetCurrentTask( enumNone );
		break;

	default:
		break;
	}	

	return true;
}

bool CGamePlayer::AppendData( UINT nOwner, const void *pData, size_t dataLength )
{
	if ( nOwner >= enumOwnerTotal || !m_bActiveStatus )
	{
		LoginDiag("append_rejected id=%lu owner=%u size=%u active=%d",
			(unsigned long)m_lnIdentityID, (unsigned int)nOwner, (unsigned int)dataLength,
			(int)m_bActiveStatus);
		return false;
	}
	if (PhongThanIsWirePacket(pData, (PHONGTHAN_U32)dataLength))
	{
		const PHONGTHAN_WIRE_HEADER* pHeader =
			(const PHONGTHAN_WIRE_HEADER*)pData;
		if (!PhongThanValidateWireHeader(pHeader, (PHONGTHAN_U32)dataLength) ||
			pHeader->PacketSize != dataLength)
		{
			return false;
		}
		switch (nOwner)
		{
		case enumOwnerAccSvr:
			return DispatchTaskForAccount(pData, dataLength);
		case enumOwnerRoleSvr:
			return DispatchTaskForDBRole(pData, dataLength);
		case enumOwnerPlayer:
			return DispatchTaskForPlayer(pData, dataLength);
		default:
			return false;
		}
	}

	BYTE cProtocol = CPackager::Peek( pData );
	LoginDiag("append id=%lu owner=%u protocol=%u size=%u task=%u",
		(unsigned long)m_lnIdentityID, (unsigned int)nOwner, (unsigned int)cProtocol,
		(unsigned int)dataLength, (unsigned int)GetCurrentTask());
	
	if ( cProtocol < g_nGlobalProtocolType )
	{
		return LargePackProcess( nOwner, pData, dataLength );
	}
	else if ( cProtocol > g_nGlobalProtocolType )
	{
		return SmallPackProcess( nOwner, pData, dataLength );
	}

	return true;
}

bool CGamePlayer::SmallPackProcess( UINT nOwner, const void *pData, size_t dataLength )
{
	switch ( nOwner )
	{
	case enumOwnerAccSvr:

		return DispatchTaskForAccount( pData, dataLength );
		break;
		
	case enumOwnerRoleSvr:
		
		return DispatchTaskForDBRole( pData, dataLength );
		break;
		
	case enumOwnerPlayer:
		
		return DispatchTaskForPlayer( pData, dataLength );
		break;

	default:
		break;
	}

	return false;
}

bool CGamePlayer::LargePackProcess( UINT nOwner, const void *pData, size_t dataLength )
{
	switch ( nOwner )
	{
	case enumOwnerAccSvr:

		ASSERT( FALSE );
		
		break;

	case enumOwnerRoleSvr:
		{	
			bool ok = true;
			CBuffer *pBuffer = m_thePackager.PackUp( pData, dataLength );
			
			if ( pBuffer )
			{
				ok = DispatchTaskForDBRole( pBuffer->GetBuffer(), pBuffer->GetUsed() );
				
				SAFE_RELEASE( pBuffer );
			}
			
			return ok;
		}
		break;

	case enumOwnerPlayer:
		
		ASSERT( FALSE );
		break;

	default:
		break;
	}

	return false;
}

bool CGamePlayer::DispatchTaskForAccount( const void *pData, size_t dataLength )
{
	if ( NULL == pData || 0 == dataLength )
	{
		return false;
	}

	LONG nMessageKey = CPackager::Peek(pData);
	if (PhongThanIsWirePacket(pData, (PHONGTHAN_U32)dataLength))
	{
		const PHONGTHAN_WIRE_HEADER* pHeader =
			(const PHONGTHAN_WIRE_HEADER*)pData;
		if (!PhongThanValidateWireHeader(pHeader, (PHONGTHAN_U32)dataLength) ||
			pHeader->PacketSize != dataLength)
			return false;
		nMessageKey = pHeader->MessageType;
	}

	m_theDataQueue[enumOwnerAccSvr].AddData(nMessageKey,
		(const BYTE *)pData, dataLength);

	return true;
}

bool CGamePlayer::DispatchTaskForDBRole( const void *pData, size_t dataLength )
{
	if ( NULL == pData || 0 == dataLength )
	{
		return false;
	}

	LONG nMessageKey = CPackager::Peek(pData);
	if (PhongThanIsWirePacket(pData, (PHONGTHAN_U32)dataLength))
	{
		const PHONGTHAN_WIRE_HEADER* pHeader =
			(const PHONGTHAN_WIRE_HEADER*)pData;
		if (!PhongThanValidateWireHeader(pHeader,
				(PHONGTHAN_U32)dataLength) ||
			pHeader->PacketSize != dataLength)
			return false;
		nMessageKey = pHeader->MessageType;
	}

	m_theDataQueue[enumOwnerRoleSvr].AddData(nMessageKey,
		(const BYTE *)pData, dataLength);

	return true;
}

bool CGamePlayer::DispatchTaskForPlayer( const void *pData, size_t dataLength )
{
	if ( NULL == pData || 0 == dataLength )
	{
		return false;
	}

	LONG nMessageKey = CPackager::Peek(pData);
	if (PhongThanIsWirePacket(pData, (PHONGTHAN_U32)dataLength))
	{
		const PHONGTHAN_WIRE_HEADER* pHeader =
			(const PHONGTHAN_WIRE_HEADER*)pData;
		nMessageKey = pHeader->MessageType;
	}

	m_theDataQueue[enumOwnerPlayer].AddData(nMessageKey,
		(const BYTE *)pData, dataLength);

	return true;
}

void CGamePlayer::_ClearTaskQueue()
{
	for ( int i=0; i<enumOwnerTotal; i++ )
	{
		m_theDataQueue[i].Empty();
	}
	
	m_thePackager.Empty();
}

void CGamePlayer::InitTaskProcessor()
{
	/*
	 * Login main task
	 */
	m_theLoginTask.AddCmd( &CGamePlayer::WaitForAccPwd );
	m_theLoginTask.AddCmd( &CGamePlayer::QueryAccPwd );
	m_theLoginTask.AddCmd( &CGamePlayer::VerifyAccount );
	m_theLoginTask.AddCmd( &CGamePlayer::QueryRoleList );
	m_theLoginTask.AddCmd( &CGamePlayer::ProcessRoleList );

	/*
	 * Login branch task
	 */
	{
		/*
		 * m_theSelAddDelTask::SelAddDelRole
		 *
		 * switch( result )
		 * case m_theLoginCreateRoleTask
		 * case m_theLoginDeleteRoleTask
		 * case m_theLoginSelectRoleTask
		 */
		m_theSelAddDelTask.AddCmd( &CGamePlayer::SelAddDelRole );
		m_theSelAddDelTask.AddCmd( &CGamePlayer::QueryAccPwd );
		m_theSelAddDelTask.AddCmd( &CGamePlayer::DelRole_WaitForVerify );

		/*
		 * m_theLoginCreateRoleTask::WaitForCreateResult
		 *
		 * successed : m_theLoginCreateRoleTask::ProcessRoleInfo
		 * failed	 : m_theSelAddDelTask::SelAddDelRole
		 */
		m_theLoginCreateRoleTask.AddCmd( &CGamePlayer::WaitForCreateResult ); 
		m_theLoginCreateRoleTask.AddCmd( &CGamePlayer::ProcessRoleInfo );
		m_theLoginCreateRoleTask.AddCmd( &CGamePlayer::WaitForGameSvrPermit );

		m_theLoginDeleteRoleTask.AddCmd( &CGamePlayer::WaitForDeleteResult );

		m_theLoginSelectRoleTask.AddCmd( &CGamePlayer::ProcessRoleInfo );
		m_theLoginSelectRoleTask.AddCmd( &CGamePlayer::WaitForGameSvrPermit );
	}

	m_theSafeCloseTask.AddCmd( &CGamePlayer::SafeClose );

	/*
	 * Logout
	 */

	m_nExtPoint = -1; //TamLTM fix xu
}

bool CGamePlayer::TaskCompleted()
{
	Trace( ToString( m_lnIdentityID ), "CGamePlayer::TaskCompleted" );

	/*
	 * Clear some data
	 */
	
	return true;
}

UINT CGamePlayer::WaitForAccPwd()
{
#ifdef	CONSOLE_DEBUG
	cprintf( "CGamePlayer::WaitForAccPwd...\n" );
#endif

	CBuffer *pRetBuffer = m_theDataQueue[enumOwnerPlayer].Attach(
		PHONGTHAN_MSG_SESSION_AUTHENTICATE);
	LoginDiag("wait_login id=%lu queued=%d", (unsigned long)m_lnIdentityID, pRetBuffer ? 1 : 0);

	if (pRetBuffer)
	{
		UINT nNextTask = enumError;
		if (pRetBuffer->GetUsed() == sizeof(PHONGTHAN_SESSION_AUTHENTICATE_REQUEST))
		{
			const PHONGTHAN_SESSION_AUTHENTICATE_REQUEST* pRequest =
				(const PHONGTHAN_SESSION_AUTHENTICATE_REQUEST*)pRetBuffer->GetBuffer();
			if (PhongThanValidateWireHeader(&pRequest->Header,
					(PHONGTHAN_U32)pRetBuffer->GetUsed()) &&
				pRequest->Header.MessageType == PHONGTHAN_MSG_SESSION_AUTHENTICATE &&
				pRequest->Header.Flags == PHONGTHAN_WIRE_FLAG_REQUEST &&
				pRequest->Header.PacketSize == sizeof(*pRequest) &&
				memchr(pRequest->AccountName, 0, sizeof(pRequest->AccountName)) &&
				memchr(pRequest->PasswordProof, 0, sizeof(pRequest->PasswordProof)))
			{
				char szAccount[sizeof(pRequest->AccountName) + 1];
				char szPassword[sizeof(pRequest->PasswordProof) + 1];
				memcpy(szAccount, pRequest->AccountName, sizeof(pRequest->AccountName));
				memcpy(szPassword, pRequest->PasswordProof, sizeof(pRequest->PasswordProof));
				szAccount[sizeof(pRequest->AccountName)] = 0;
				szPassword[sizeof(pRequest->PasswordProof)] = 0;

				if (szAccount[0] && szPassword[0])
				{
					m_sAccountName = szAccount;
					m_sPassword = szPassword;
					m_bUseSuperPassword = false;
					nNextTask = enumToNextTask;
					LoginDiag("login_request id=%lu account=%s",
						(unsigned long)m_lnIdentityID, szAccount);
				}
				ZeroMemory(szPassword, sizeof(szPassword));
			}
		}

		SAFE_RELEASE(pRetBuffer);
		m_theDataQueue[enumOwnerPlayer].Detach(
			PHONGTHAN_MSG_SESSION_AUTHENTICATE);
		return nNextTask;
	}

	return enumRepeat;
}

UINT CGamePlayer::QueryAccPwd()
{
#ifdef	CONSOLE_DEBUG
	cprintf( "CGamePlayer::QueryAccPwd...\n" );
#endif

/*	if ( !m_pAccSvrClient )
	{
		return enumError;
	}
*/
	m_dwTaskTotalTimer = s_nProcessTimeoutTimer;
	LoginDiag("account_query id=%lu account=%s", (unsigned long)m_lnIdentityID, m_sAccountName.c_str());

	PHONGTHAN_SERVICE_ACCOUNT_AUTHENTICATE_REQUEST Request;
	ZeroMemory(&Request, sizeof(Request));
	PhongThanInitializeWireHeader(&Request.Header,
		PHONGTHAN_MSG_SERVICE_ACCOUNT_AUTHENTICATE, sizeof(Request),
		PHONGTHAN_WIRE_FLAG_REQUEST, m_lnIdentityID);
	Request.RequestId = m_lnIdentityID;
	Request.Purpose = m_bUseSuperPassword ?
		PHONGTHAN_ACCOUNT_AUTH_DELETE_CHARACTER : PHONGTHAN_ACCOUNT_AUTH_LOGIN;
	strncpy((char*)Request.AccountName, m_sAccountName.c_str(),
		sizeof(Request.AccountName) - 1);
	const char* pSecret = m_bUseSuperPassword ?
		m_sSuperPassword.c_str() : m_sPassword.c_str();
	strncpy((char*)Request.PasswordProof, pSecret,
		sizeof(Request.PasswordProof) - 1);

	if (!m_bUseSuperPassword)
		m_bAutoUnlockAccount = true;
	m_theDataQueue[enumOwnerAccSvr].Empty();
	g_theSmartClient.Send(&Request, sizeof(Request));
	ZeroMemory(Request.PasswordProof, sizeof(Request.PasswordProof));

	return enumToNextTask;
}

UINT CGamePlayer::VerifyAccount()
{
#ifdef	CONSOLE_DEBUG
	cprintf( "CGamePlayer::VerifyAccount...\n" );
#endif
	
	m_nExtPoint = -1; //TamLTM fix xu;

	CBuffer *pRetBuffer = m_theDataQueue[enumOwnerAccSvr].Attach(
		PHONGTHAN_MSG_SERVICE_ACCOUNT_AUTHENTICATE);
	LoginDiag("account_result_wait id=%lu queued=%d", (unsigned long)m_lnIdentityID, pRetBuffer ? 1 : 0);

	if ( pRetBuffer )
	{
		const PHONGTHAN_SERVICE_ACCOUNT_AUTHENTICATE_RESPONSE* pReturn =
			(const PHONGTHAN_SERVICE_ACCOUNT_AUTHENTICATE_RESPONSE*)pRetBuffer->GetBuffer();
		UINT nNextTask = enumError;
		PHONGTHAN_S32 nResult = PHONGTHAN_AUTH_SERVICE_UNAVAILABLE;
		PHONGTHAN_U32 nRemainingTime = 0;
		PHONGTHAN_S32 nExtensionPoint = 0;
		if (pRetBuffer->GetUsed() == sizeof(*pReturn) &&
			PhongThanValidateWireHeader(&pReturn->Header,
				(PHONGTHAN_U32)pRetBuffer->GetUsed()) &&
			pReturn->Header.MessageType == PHONGTHAN_MSG_SERVICE_ACCOUNT_AUTHENTICATE &&
			pReturn->Header.Flags == PHONGTHAN_WIRE_FLAG_RESPONSE &&
			pReturn->RequestId == m_lnIdentityID &&
			memchr(pReturn->AccountName, 0, sizeof(pReturn->AccountName)) &&
			m_sAccountName.compare((const char*)pReturn->AccountName) == 0)
		{
			nResult = pReturn->Result;
			nRemainingTime = pReturn->RemainingTime;
			nExtensionPoint = pReturn->ExtensionPoint;
			if (nResult == PHONGTHAN_AUTH_SUCCESS)
			{
				nNextTask = enumToNextTask;
				m_nExtPoint = pReturn->ExtensionPoint;
			}
			else
			{
				m_bAutoUnlockAccount = false;
			}
		}
		LoginDiag("account_result id=%lu code=%d ext=%d",
			(unsigned long)m_lnIdentityID, (int)nResult,
			(int)nExtensionPoint);
		_VerifyAccount_ToPlayer(nResult, nRemainingTime);

		SAFE_RELEASE( pRetBuffer );
		m_theDataQueue[enumOwnerAccSvr].Detach(
			PHONGTHAN_MSG_SERVICE_ACCOUNT_AUTHENTICATE);

		return nNextTask;
	}

	return enumRepeat;
}

bool CGamePlayer::_VerifyAccount_ToPlayer(
	PHONGTHAN_S32 nResult, PHONGTHAN_U32 nLeftTime)
{
	PHONGTHAN_SESSION_AUTHENTICATE_RESPONSE Response;
	ZeroMemory(&Response, sizeof(Response));
	PhongThanInitializeWireHeader(&Response.Header,
		PHONGTHAN_MSG_SESSION_AUTHENTICATE, sizeof(Response),
		PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	Response.RemainingTime = nLeftTime;
	strncpy((char*)Response.AccountName, m_sAccountName.c_str(),
		sizeof(Response.AccountName) - 1);

	Response.Result = nResult;

	HRESULT hrSend = m_pPlayerServer->SendData(m_lnIdentityID,
		&Response, sizeof(Response));
	LoginDiag("login_response id=%lu result=%d hr=0x%08lX",
		(unsigned long)m_lnIdentityID, (int)Response.Result,
		(unsigned long)hrSend);

	return true;
}

UINT CGamePlayer::QueryRoleList()
{
#ifdef	CONSOLE_DEBUG
	cprintf( "CGamePlayer::QueryRoleList...\n" );
#endif

	PHONGTHAN_SERVICE_CHARACTER_LIST_REQUEST Request;
	ZeroMemory(&Request, sizeof(Request));
	PhongThanInitializeWireHeader(&Request.Header,
		PHONGTHAN_MSG_SERVICE_CHARACTER_LIST, sizeof(Request),
		PHONGTHAN_WIRE_FLAG_REQUEST, m_lnIdentityID);
	Request.RequestId = m_lnIdentityID;
	strncpy((char*)Request.AccountName, m_sAccountName.c_str(),
		sizeof(Request.AccountName) - 1);
	m_theDataQueue[enumOwnerRoleSvr].Empty();
	const HRESULT hResult = m_pDBRoleClient->SendPackToServer(
		&Request, sizeof(Request));
	LoginDiag("role_list_request id=%lu account=%s send=0x%08lX",
		(unsigned long)m_lnIdentityID, m_sAccountName.c_str(),
		(unsigned long)hResult);

	return enumToNextTask;
}

UINT CGamePlayer::ProcessRoleList()
{
#ifdef	CONSOLE_DEBUG
	cprintf( "CGamePlayer::ProcessRoleList...\n" );
#endif

	CBuffer *pRetBuffer = m_theDataQueue[enumOwnerRoleSvr].Attach(
		PHONGTHAN_MSG_SERVICE_CHARACTER_LIST);

	if ( pRetBuffer )
	{
		UINT nNextTask = enumError;

		const PHONGTHAN_SERVICE_CHARACTER_LIST_RESPONSE* pService =
			(const PHONGTHAN_SERVICE_CHARACTER_LIST_RESPONSE*)pRetBuffer->GetBuffer();
		int nRoleCount = -1;
		if (pRetBuffer->GetUsed() == sizeof(*pService) &&
			PhongThanValidateWireHeader(&pService->Header,
				(PHONGTHAN_U32)pRetBuffer->GetUsed()) &&
			pService->Header.MessageType ==
				PHONGTHAN_MSG_SERVICE_CHARACTER_LIST &&
			pService->Header.Flags == PHONGTHAN_WIRE_FLAG_RESPONSE &&
			pService->RequestId == m_lnIdentityID &&
			pService->Result == PHONGTHAN_CHARACTER_LIST_SUCCESS &&
			pService->CharacterCount <= PHONGTHAN_CHARACTER_LIMIT &&
			memchr(pService->AccountName, 0,
				sizeof(pService->AccountName)) &&
			m_sAccountName.compare(
				(const char*)pService->AccountName) == 0)
		{
			nRoleCount = pService->CharacterCount;
		}

#ifdef	CONSOLE_DEBUG
	cprintf( "CGamePlayer::ProcessRoleList find %d role in list\n", nRoleCount );
#endif

		if (nRoleCount >= 0)
		{
			PHONGTHAN_SESSION_CHARACTER_LIST_RESPONSE Response;
			ZeroMemory(&Response, sizeof(Response));
			PhongThanInitializeWireHeader(&Response.Header,
				PHONGTHAN_MSG_SESSION_CHARACTER_LIST, sizeof(Response),
				PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
			Response.Result = PHONGTHAN_CHARACTER_LIST_SUCCESS;
			Response.CharacterCount = (PHONGTHAN_U8)nRoleCount;
			Response.RecommendedIndex = pService->RecommendedIndex;
			for (int i = 0; i < nRoleCount; ++i)
			{
				if (!memchr(pService->Characters[i].Name, 0,
						sizeof(pService->Characters[i].Name)))
				{
					nRoleCount = -1;
					break;
				}
				strncpy((char*)Response.Characters[i].Name,
					(const char*)pService->Characters[i].Name,
					sizeof(Response.Characters[i].Name) - 1);
				Response.Characters[i].Gender =
					pService->Characters[i].Gender;
				Response.Characters[i].Profession =
					pService->Characters[i].Profession;
				Response.Characters[i].Level =
					pService->Characters[i].Level;
			}

			if (nRoleCount >= 0)
			{
			m_theDataQueue[enumOwnerPlayer].Empty();
				m_pPlayerServer->SendData(m_lnIdentityID,
					&Response, sizeof(Response));
				nNextTask = enumSelAddDelRole;
			}
		}

		SAFE_RELEASE( pRetBuffer );
		m_theDataQueue[enumOwnerRoleSvr].Detach(
			PHONGTHAN_MSG_SERVICE_CHARACTER_LIST);

		return nNextTask;
	}

	return enumRepeat;
}

UINT CGamePlayer::SelAddDelRole()
{
	CBuffer *pRetBuffer = NULL;

#ifdef	CONSOLE_DEBUG
	cprintf( "CGamePlayer::SelAddDelRole...\n" );
#endif

	/*
	 * Select a role
	 */
	pRetBuffer = m_theDataQueue[enumOwnerPlayer].Attach(
		PHONGTHAN_MSG_SESSION_SELECT_CHARACTER);

	if ( pRetBuffer )
	{
		UINT nNextTask = enumError;

		const PHONGTHAN_SESSION_SELECT_CHARACTER_REQUEST* pSelect =
			(const PHONGTHAN_SESSION_SELECT_CHARACTER_REQUEST*)pRetBuffer->GetBuffer();

#ifdef	CONSOLE_DEBUG
	cprintf( "CGamePlayer::SelAddDelRole Select a role from list\n" );
#endif

		if (pRetBuffer->GetUsed() == sizeof(*pSelect) &&
			pSelect->Header.MessageType == PHONGTHAN_MSG_SESSION_SELECT_CHARACTER &&
			pSelect->Header.Flags == PHONGTHAN_WIRE_FLAG_REQUEST &&
			pSelect->RoleName[0] &&
			memchr(pSelect->RoleName, 0, sizeof(pSelect->RoleName)) &&
			_QueryRoleInfo_ToDBRole((const char *)pSelect->RoleName))
		{
			nNextTask = enumLoginSelectRole;
		}

		SAFE_RELEASE( pRetBuffer );
		m_theDataQueue[enumOwnerPlayer].Detach(
			PHONGTHAN_MSG_SESSION_SELECT_CHARACTER);

		return nNextTask;
	}

	/*
	 * Create a role
	 */
	pRetBuffer = m_theDataQueue[enumOwnerPlayer].Attach(
		PHONGTHAN_MSG_SESSION_CREATE_CHARACTER);

	if ( pRetBuffer )
	{
		UINT nNextTask = enumError;

		const PHONGTHAN_SESSION_CREATE_CHARACTER_REQUEST* pCreate =
			(const PHONGTHAN_SESSION_CREATE_CHARACTER_REQUEST*)pRetBuffer->GetBuffer();
		const bool bValid =
			pRetBuffer->GetUsed() == sizeof(*pCreate) &&
			pCreate->Header.MessageType == PHONGTHAN_MSG_SESSION_CREATE_CHARACTER &&
			pCreate->Header.Flags == PHONGTHAN_WIRE_FLAG_REQUEST &&
			pCreate->RoleName[0] &&
			memchr(pCreate->RoleName, 0, sizeof(pCreate->RoleName)) &&
			pCreate->Gender < PHONGTHAN_GENDER_COUNT &&
			pCreate->Profession < PHONGTHAN_PROFESSION_COUNT;

#ifdef	CONSOLE_DEBUG
	cprintf( "CGamePlayer::SelAddDelRole Create a role [Name : %s]\n",
		bValid ? (const char*)pCreate->RoleName : "(invalid)" );
#endif
		m_theDataQueue[enumOwnerRoleSvr].Empty();

		if (bValid && _CreateNewPlayer_ToDBRole(
					(const char*)pCreate->RoleName,
					pCreate->Gender,
					pCreate->Profession,
					pCreate->NativePlaceId))
		{
			m_sPendingRoleName = (const char*)pCreate->RoleName;
			nNextTask = enumLoginCreateRole;
		}
		else
		{
			PHONGTHAN_SESSION_CREATE_CHARACTER_RESPONSE Response;
			ZeroMemory(&Response, sizeof(Response));
			PhongThanInitializeWireHeader(&Response.Header,
				PHONGTHAN_MSG_SESSION_CREATE_CHARACTER, sizeof(Response),
				PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
			Response.Result = PHONGTHAN_CHARACTER_OPERATION_INVALID_NAME;
			if (bValid)
				strncpy((char*)Response.RoleName,
					(const char*)pCreate->RoleName,
					sizeof(Response.RoleName) - 1);
			m_pPlayerServer->SendData(m_lnIdentityID, &Response, sizeof(Response));
			nNextTask = enumSelAddDelRole;
		}

		SAFE_RELEASE( pRetBuffer );
		m_theDataQueue[enumOwnerPlayer].Detach(
			PHONGTHAN_MSG_SESSION_CREATE_CHARACTER);

		return nNextTask;
	}

	/*
	 * Delete a role
	 */
	pRetBuffer = m_theDataQueue[enumOwnerPlayer].Attach(
		PHONGTHAN_MSG_SESSION_DELETE_CHARACTER);

	if ( pRetBuffer )
	{
		UINT nNextTask = enumError;

#ifdef	CONSOLE_DEBUG
	cprintf( "CGamePlayer::SelAddDelRole Del a role in list\n" );
#endif
		m_theDataQueue[enumOwnerRoleSvr].Empty();

		const PHONGTHAN_SESSION_DELETE_CHARACTER_REQUEST* pDelete =
			(const PHONGTHAN_SESSION_DELETE_CHARACTER_REQUEST*)pRetBuffer->GetBuffer();
		char szDeleteRoleName[32];
		ZeroMemory(szDeleteRoleName, sizeof(szDeleteRoleName));
		if (pRetBuffer->GetUsed() == sizeof(*pDelete) &&
			memchr(pDelete->RoleName, 0, sizeof(pDelete->RoleName)))
		{
			strncpy(szDeleteRoleName, (const char*)pDelete->RoleName,
				sizeof(szDeleteRoleName) - 1);
		}
		if (pRetBuffer->GetUsed() == sizeof(*pDelete) &&
			pDelete->Header.MessageType == PHONGTHAN_MSG_SESSION_DELETE_CHARACTER &&
			pDelete->Header.Flags == PHONGTHAN_WIRE_FLAG_REQUEST &&
			pDelete->RoleName[0] && pDelete->PasswordProof[0] &&
			memchr(pDelete->RoleName, 0, sizeof(pDelete->RoleName)) &&
			memchr(pDelete->PasswordProof, 0, sizeof(pDelete->PasswordProof)) &&
			_DeleteRole_ToDBRole(pDelete))
		{
            nNextTask = enumToNextTask;
		}

		SAFE_RELEASE( pRetBuffer );
		m_theDataQueue[enumOwnerPlayer].Detach(
			PHONGTHAN_MSG_SESSION_DELETE_CHARACTER);

		if ( enumToNextTask != nNextTask )
		{
			PHONGTHAN_SESSION_DELETE_CHARACTER_RESPONSE Response;
			ZeroMemory(&Response, sizeof(Response));
			PhongThanInitializeWireHeader(&Response.Header,
				PHONGTHAN_MSG_SESSION_DELETE_CHARACTER, sizeof(Response),
				PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
			Response.Result = PHONGTHAN_CHARACTER_OPERATION_INVALID_CREDENTIALS;
			strncpy((char*)Response.RoleName, szDeleteRoleName,
				sizeof(Response.RoleName) - 1);
			m_pPlayerServer->SendData(m_lnIdentityID, &Response, sizeof(Response));

			nNextTask = enumSelAddDelRole;
		}

		return nNextTask;
	}

	return enumRepeat;
}

UINT CGamePlayer::DelRole_WaitForVerify()
{
#ifdef	CONSOLE_DEBUG
	cprintf( "CGamePlayer::DelRole_WaitForVerify...\n" );
#endif
	CBuffer *pRetBuffer = m_theDataQueue[enumOwnerAccSvr].Attach(
		PHONGTHAN_MSG_SERVICE_ACCOUNT_AUTHENTICATE);
    
    if (pRetBuffer)
    {
		UINT nNextTask = enumError;

		const PHONGTHAN_SERVICE_ACCOUNT_AUTHENTICATE_RESPONSE* pReturn =
			(const PHONGTHAN_SERVICE_ACCOUNT_AUTHENTICATE_RESPONSE*)pRetBuffer->GetBuffer();

		if (pRetBuffer->GetUsed() == sizeof(*pReturn) &&
			PhongThanValidateWireHeader(&pReturn->Header,
				(PHONGTHAN_U32)pRetBuffer->GetUsed()) &&
			pReturn->Header.MessageType == PHONGTHAN_MSG_SERVICE_ACCOUNT_AUTHENTICATE &&
			pReturn->Header.Flags == PHONGTHAN_WIRE_FLAG_RESPONSE &&
			pReturn->RequestId == m_lnIdentityID &&
			pReturn->Result == PHONGTHAN_AUTH_SUCCESS)
        {
            const char *pRoleName = m_sDelRoleName.c_str();
			PHONGTHAN_SERVICE_CHARACTER_DELETE_REQUEST Request;
			ZeroMemory(&Request, sizeof(Request));
			PhongThanInitializeWireHeader(&Request.Header,
				PHONGTHAN_MSG_SERVICE_CHARACTER_DELETE, sizeof(Request),
				PHONGTHAN_WIRE_FLAG_REQUEST, m_lnIdentityID);
			Request.RequestId = m_lnIdentityID;
			strncpy((char*)Request.AccountName, m_sAccountName.c_str(),
				sizeof(Request.AccountName) - 1);
			strncpy((char*)Request.RoleName, pRoleName,
				sizeof(Request.RoleName) - 1);
			m_pDBRoleClient->SendPackToServer(&Request, sizeof(Request));
        
            nNextTask = enumLoginDeleteRole;
        }
        else
        {
            PHONGTHAN_SESSION_DELETE_CHARACTER_RESPONSE Response;
            ZeroMemory(&Response, sizeof(Response));
            PhongThanInitializeWireHeader(&Response.Header,
                PHONGTHAN_MSG_SESSION_DELETE_CHARACTER, sizeof(Response),
                PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
            Response.Result = PHONGTHAN_CHARACTER_OPERATION_INVALID_CREDENTIALS;
            strncpy((char*)Response.RoleName, m_sDelRoleName.c_str(),
                sizeof(Response.RoleName) - 1);
            m_pPlayerServer->SendData(m_lnIdentityID, &Response, sizeof(Response));

            nNextTask = enumSelAddDelRole;  // ??????????????????????????????????????
        }

		SAFE_RELEASE( pRetBuffer );
		m_theDataQueue[enumOwnerAccSvr].Detach(
			PHONGTHAN_MSG_SERVICE_ACCOUNT_AUTHENTICATE);

        return nNextTask;
    }
	return enumRepeat;


}


UINT CGamePlayer::WaitForCreateResult()
{
#ifdef	CONSOLE_DEBUG
	cprintf( "CGamePlayer::WaitForCreateResult...\n" );
#endif

	CBuffer *pRetBuffer = m_theDataQueue[enumOwnerRoleSvr].Attach(
		PHONGTHAN_MSG_SERVICE_CHARACTER_CREATE);

	if ( pRetBuffer )
	{
		UINT nNextTask = enumError;

		const PHONGTHAN_SERVICE_CHARACTER_CREATE_RESPONSE* pService =
			(const PHONGTHAN_SERVICE_CHARACTER_CREATE_RESPONSE*)pRetBuffer->GetBuffer();
		bool bValid = pRetBuffer->GetUsed() == sizeof(*pService) &&
			PhongThanValidateWireHeader(&pService->Header,
				(PHONGTHAN_U32)pRetBuffer->GetUsed()) &&
			pService->Header.MessageType ==
				PHONGTHAN_MSG_SERVICE_CHARACTER_CREATE &&
			pService->Header.Flags == PHONGTHAN_WIRE_FLAG_RESPONSE &&
			pService->RequestId == m_lnIdentityID &&
			memchr(pService->AccountName, 0,
				sizeof(pService->AccountName)) &&
			memchr(pService->RoleName, 0,
				sizeof(pService->RoleName)) &&
			m_sAccountName.compare(
				(const char*)pService->AccountName) == 0 &&
			m_sPendingRoleName.compare(
				(const char*)pService->RoleName) == 0;

		PHONGTHAN_SESSION_CREATE_CHARACTER_RESPONSE Response;
		ZeroMemory(&Response, sizeof(Response));
		PhongThanInitializeWireHeader(&Response.Header,
			PHONGTHAN_MSG_SESSION_CREATE_CHARACTER, sizeof(Response),
			PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
		Response.Result = PHONGTHAN_CHARACTER_OPERATION_SERVICE_UNAVAILABLE;
		strncpy((char*)Response.RoleName, m_sPendingRoleName.c_str(),
			sizeof(Response.RoleName) - 1);

#ifdef	CONSOLE_DEBUG
		cprintf( "CGamePlayer::WaitForCreateResult %s\n",
			(bValid && pService->Result == PHONGTHAN_CHARACTER_OPERATION_SUCCESS) ?
			"Successful" : "Failed" );
#endif

		if (bValid &&
			pService->Result == PHONGTHAN_CHARACTER_OPERATION_SUCCESS &&
			_QueryRoleInfo_ToDBRole(m_sPendingRoleName.c_str()))
		{
			Response.Result = PHONGTHAN_CHARACTER_OPERATION_SUCCESS;
			m_sRoleName = m_sPendingRoleName;
			m_pPlayerServer->SendData(m_lnIdentityID, &Response, sizeof(Response));
			nNextTask = enumToNextTask;
		}
		else
		{
			Response.Result = bValid ? pService->Result :
				PHONGTHAN_CHARACTER_OPERATION_SERVICE_UNAVAILABLE;
			m_pPlayerServer->SendData(m_lnIdentityID, &Response, sizeof(Response));
			m_sPendingRoleName = "";
			nNextTask = enumSelAddDelRole;
		}

		SAFE_RELEASE( pRetBuffer );
		m_theDataQueue[enumOwnerRoleSvr].Detach(
			PHONGTHAN_MSG_SERVICE_CHARACTER_CREATE);

		return nNextTask;
	}

	return enumRepeat;
}

UINT CGamePlayer::WaitForDeleteResult()
{
#ifdef	CONSOLE_DEBUG
		cprintf( "CGamePlayer::WaitForDeleteResult\n" );
#endif

	CBuffer *pRetBuffer = m_theDataQueue[enumOwnerRoleSvr].Attach(
		PHONGTHAN_MSG_SERVICE_CHARACTER_DELETE);

	if ( pRetBuffer )
	{
		UINT nNextTask = enumError;

		const PHONGTHAN_SERVICE_CHARACTER_DELETE_RESPONSE* pService =
			(const PHONGTHAN_SERVICE_CHARACTER_DELETE_RESPONSE*)pRetBuffer->GetBuffer();
		bool bValid = pRetBuffer->GetUsed() == sizeof(*pService) &&
			PhongThanValidateWireHeader(&pService->Header,
				(PHONGTHAN_U32)pRetBuffer->GetUsed()) &&
			pService->Header.MessageType ==
				PHONGTHAN_MSG_SERVICE_CHARACTER_DELETE &&
			pService->Header.Flags == PHONGTHAN_WIRE_FLAG_RESPONSE &&
			pService->RequestId == m_lnIdentityID &&
			memchr(pService->AccountName, 0,
				sizeof(pService->AccountName)) &&
			memchr(pService->RoleName, 0,
				sizeof(pService->RoleName)) &&
			m_sAccountName.compare(
				(const char*)pService->AccountName) == 0 &&
			m_sDelRoleName.compare(
				(const char*)pService->RoleName) == 0;

		PHONGTHAN_SESSION_DELETE_CHARACTER_RESPONSE Response;
		ZeroMemory(&Response, sizeof(Response));
		PhongThanInitializeWireHeader(&Response.Header,
			PHONGTHAN_MSG_SESSION_DELETE_CHARACTER, sizeof(Response),
			PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
		Response.Result = PHONGTHAN_CHARACTER_OPERATION_SERVICE_UNAVAILABLE;
		strncpy((char*)Response.RoleName, m_sDelRoleName.c_str(),
			sizeof(Response.RoleName) - 1);

#ifdef	CONSOLE_DEBUG
		cprintf( "CGamePlayer::WaitForDeleteResult %s\n",
			(bValid && pService->Result == PHONGTHAN_CHARACTER_OPERATION_SUCCESS) ?
			"Successful" : "Failed" );
#endif

		if (bValid &&
			pService->Result == PHONGTHAN_CHARACTER_OPERATION_SUCCESS)
		{
			Response.Result = PHONGTHAN_CHARACTER_OPERATION_SUCCESS;
			m_pPlayerServer->SendData(m_lnIdentityID, &Response, sizeof(Response));
			nNextTask = enumSelAddDelRole;
		}
		else
		{
			Response.Result = bValid ? pService->Result :
				PHONGTHAN_CHARACTER_OPERATION_SERVICE_UNAVAILABLE;
			m_pPlayerServer->SendData(m_lnIdentityID, &Response, sizeof(Response));
			nNextTask = enumSelAddDelRole;
		}

		SAFE_RELEASE( pRetBuffer );
		m_theDataQueue[enumOwnerRoleSvr].Detach(
			PHONGTHAN_MSG_SERVICE_CHARACTER_DELETE);

		return nNextTask;
	}

	return enumRepeat;
}

bool CGamePlayer::_QueryRoleInfo_ToDBRole( const char *pRoleName )
{
	if (!pRoleName || !pRoleName[0] || !m_pDBRoleClient ||
		m_sAccountName.empty())
	{
		return false;
	}

	PHONGTHAN_SERVICE_CHARACTER_LOAD_REQUEST Request;
	if (strlen(pRoleName) >= sizeof(Request.RoleName) ||
		m_sAccountName.size() >= sizeof(Request.AccountName))
	{
		return false;
	}

	ZeroMemory(&Request, sizeof(Request));
	PhongThanInitializeWireHeader(&Request.Header,
		PHONGTHAN_MSG_SERVICE_CHARACTER_LOAD, sizeof(Request),
		PHONGTHAN_WIRE_FLAG_REQUEST, m_lnIdentityID);
	Request.RequestId = m_lnIdentityID;
	strncpy((char*)Request.AccountName, m_sAccountName.c_str(),
		sizeof(Request.AccountName) - 1);
	strncpy((char*)Request.RoleName, pRoleName,
		sizeof(Request.RoleName) - 1);
	m_sPendingRoleName = pRoleName;
	// Discard a late load response left by a previous connection that reused
	// this player slot before issuing the current request.
	m_theDataQueue[enumOwnerRoleSvr].Empty();
	const HRESULT hResult = m_pDBRoleClient->SendPackToServer(
		&Request, sizeof(Request));
	LoginDiag("role_load_request id=%lu account=%s role=%s send=0x%08lX",
		(unsigned long)m_lnIdentityID, m_sAccountName.c_str(), pRoleName,
		(unsigned long)hResult);
	return SUCCEEDED(hResult);
}

bool CGamePlayer::_CreateNewPlayer_ToDBRole( const char *pRoleName, 
						int nRoleSex /* male or female */, 
						int nProfession,
						unsigned short nMapID )
{
	if ( NULL == pRoleName || '\0' == pRoleName[0] )
	{
		return false;
	}

	size_t datalength = 0;

	CPlayerCreator::ROLEPARAM	RP;

	int nMinLen = strlen( pRoleName );
	nMinLen = nMinLen > sizeof( RP.szName ) ? sizeof( RP.szName ) : nMinLen;
	memcpy( RP.szName, pRoleName, nMinLen );
	RP.szName[nMinLen] = '\0';

	nMinLen = m_sAccountName.size();
	nMinLen = nMinLen > sizeof( RP.szAccName ) ? sizeof( RP.szAccName ) : nMinLen;
	memcpy( RP.szAccName, m_sAccountName.c_str(), nMinLen );
	RP.szAccName[nMinLen] = '\0';

	RP.nSex = nRoleSex;
	RP.nProfession = nProfession;
	RP.nMapID = nMapID;

	const PHONGTHAN_CHARACTER_STATE_HEADER *pRoleData = m_thePlayerCreator.GetRoleData( datalength, &RP );

	if (pRoleData && PhongThanValidateCharacterState(
		pRoleData, (PHONGTHAN_U32)datalength) &&
		pRoleData->FightSkillCount <= PHONGTHAN_STARTER_SKILL_LIMIT)
	{
		PHONGTHAN_SERVICE_CHARACTER_CREATE_REQUEST Request;
		ZeroMemory(&Request, sizeof(Request));
		PhongThanInitializeWireHeader(&Request.Header,
			PHONGTHAN_MSG_SERVICE_CHARACTER_CREATE, sizeof(Request),
			PHONGTHAN_WIRE_FLAG_REQUEST, m_lnIdentityID);
		Request.RequestId = m_lnIdentityID;
		strncpy((char*)Request.AccountName, m_sAccountName.c_str(),
			sizeof(Request.AccountName) - 1);
		strncpy((char*)Request.RoleName, pRoleName,
			sizeof(Request.RoleName) - 1);
		Request.Gender = pRoleData->Gender;
		Request.Profession = pRoleData->Profession;
		Request.NativePlaceId = nMapID;
		Request.SpawnMapId = pRoleData->ReviveMapId;
		Request.SpawnX = pRoleData->ReviveX;
		Request.SpawnY = pRoleData->ReviveY;
		Request.FightLevel = (PHONGTHAN_U16)pRoleData->FightLevel;
		Request.SkillCount = (PHONGTHAN_U16)pRoleData->FightSkillCount;
		Request.FightExperience = pRoleData->FightExperience;
		Request.Money = pRoleData->Money;
		Request.BankMoney = pRoleData->BankMoney;
		Request.Power = pRoleData->Power;
		Request.Agility = pRoleData->Agility;
		Request.Physique = pRoleData->Physique;
		Request.Wisdom = pRoleData->Wisdom;
		Request.Luck = pRoleData->Luck;
		Request.MaxLife = pRoleData->MaxLife;
		Request.MaxStamina = pRoleData->MaxStamina;
		Request.MaxMana = pRoleData->MaxMana;
		Request.RemainingAttributePoints = pRoleData->RemainingAttributePoints;
		Request.RemainingSkillPoints = pRoleData->RemainingSkillPoints;
		Request.LeadershipLevel =
			(PHONGTHAN_U16)pRoleData->LeadershipLevel;
		Request.LeadershipExperience = pRoleData->LeadershipExperience;
		const PHONGTHAN_CHARACTER_SKILL_RECORD* pSkills =
			(const PHONGTHAN_CHARACTER_SKILL_RECORD*)(pRoleData + 1);
		for (unsigned int i = 0; i < pRoleData->FightSkillCount; ++i)
		{
			Request.Skills[i].SkillId = pSkills[i].SkillId;
			Request.Skills[i].SkillLevel = pSkills[i].Level;
			Request.Skills[i].SkillValue = pSkills[i].Value;
		}

		m_pDBRoleClient->SendPackToServer(&Request, sizeof(Request));

		return true;
	}

	return false;
}

UINT CGamePlayer::_DeleteRole_ToDBRole(
	const PHONGTHAN_SESSION_DELETE_CHARACTER_REQUEST* pRequest)
{
	if (!pRequest)
	{
		return false;
	}

	const char *pPassword = (const char*)pRequest->PasswordProof;
	const char *pRoleName = (const char*)pRequest->RoleName;
	if (!pPassword[0] || !pRoleName[0])
	{
		return false;
	}

	m_sSuperPassword = pPassword;
	m_sDelRoleName = pRoleName;
    m_bUseSuperPassword = true;
    
	return true;
}

UINT CGamePlayer::ProcessRoleInfo()
{
#ifdef	CONSOLE_DEBUG
	cprintf("CGamePlayer::ProcessRoleInfo...\n");
#endif

	CBuffer* pRetBuffer = m_theDataQueue[enumOwnerRoleSvr].Attach(
		PHONGTHAN_MSG_SERVICE_CHARACTER_LOAD);
	if (!pRetBuffer)
		return enumRepeat;

	UINT nNextTask = enumError;
	const size_t nPacketSize = pRetBuffer->GetUsed();
	const PHONGTHAN_SERVICE_CHARACTER_LOAD_RESPONSE_HEADER* pResponse =
		(const PHONGTHAN_SERVICE_CHARACTER_LOAD_RESPONSE_HEADER*)
			pRetBuffer->GetBuffer();
	bool bValid = nPacketSize >= sizeof(*pResponse) &&
		PhongThanValidateWireHeader(&pResponse->Header,
			(PHONGTHAN_U32)nPacketSize) &&
		pResponse->Header.MessageType == PHONGTHAN_MSG_SERVICE_CHARACTER_LOAD &&
		pResponse->Header.Flags == PHONGTHAN_WIRE_FLAG_RESPONSE &&
		pResponse->Header.PacketSize == nPacketSize &&
		pResponse->RequestId == m_lnIdentityID &&
		pResponse->Result == PHONGTHAN_CHARACTER_OPERATION_SUCCESS &&
		pResponse->StateSize == nPacketSize - sizeof(*pResponse) &&
		pResponse->StateSize >= sizeof(PHONGTHAN_CHARACTER_STATE_HEADER);
	if (!bValid)
	{
		const int nServiceResult = nPacketSize >= sizeof(*pResponse) ?
			(int)pResponse->Result : -1;
		const unsigned int nStateSize = nPacketSize >= sizeof(*pResponse) ?
			(unsigned int)pResponse->StateSize : 0;
		LoginDiag(
			"role_load_rejected id=%lu packet=%u service_result=%d state=%u expected_account=%s expected_role=%s",
			(unsigned long)m_lnIdentityID, (unsigned int)nPacketSize,
			nServiceResult, nStateSize, m_sAccountName.c_str(),
			m_sPendingRoleName.c_str());
	}

	const PHONGTHAN_CHARACTER_STATE_HEADER* pState = NULL;
	if (bValid)
	{
		pState = (const PHONGTHAN_CHARACTER_STATE_HEADER*)
			((const BYTE*)pResponse + sizeof(*pResponse));
		bValid = PhongThanValidateCharacterState(
			pState, pResponse->StateSize) &&
			m_sAccountName.compare((const char*)pState->AccountName) == 0 &&
			m_sPendingRoleName.compare((const char*)pState->RoleName) == 0;
		if (!bValid)
		{
			LoginDiag(
				"role_state_rejected id=%lu schema=%u state=%u expected_account=%s actual_account=%.31s expected_role=%s actual_role=%.31s",
				(unsigned long)m_lnIdentityID,
				(unsigned int)pState->SchemaVersion,
				(unsigned int)pResponse->StateSize,
				m_sAccountName.c_str(), (const char*)pState->AccountName,
				m_sPendingRoleName.c_str(), (const char*)pState->RoleName);
		}
	}

	m_nAttachServerID = -1;
	if (bValid)
	{
		m_sRoleName = (const char*)pState->RoleName;
		if (_SyncRoleInfo_ToGameServer(pState, pResponse->StateSize))
			nNextTask = enumToNextTask;
	}

	if (nNextTask != enumToNextTask)
	{
		PHONGTHAN_SESSION_ENTER_WORLD_RESPONSE Response;
		ZeroMemory(&Response, sizeof(Response));
		PhongThanInitializeWireHeader(&Response.Header,
			PHONGTHAN_MSG_SESSION_ENTER_WORLD, sizeof(Response),
			PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
		strncpy((char*)Response.AccountName, m_sAccountName.c_str(),
			sizeof(Response.AccountName) - 1);
		strncpy((char*)Response.RoleName, m_sPendingRoleName.c_str(),
			sizeof(Response.RoleName) - 1);
		m_pPlayerServer->SendData(m_lnIdentityID,
			(const void*)&Response, sizeof(Response));
	}

	SAFE_RELEASE(pRetBuffer);
	m_theDataQueue[enumOwnerRoleSvr].Detach(
		PHONGTHAN_MSG_SERVICE_CHARACTER_LOAD);
	return nNextTask;
}

bool CGamePlayer::_SyncRoleInfo_ToGameServer( const void *pData, size_t dataLength )
{
	if (!pData || dataLength > 0xffffffffu)
		return false;
	const PHONGTHAN_CHARACTER_STATE_HEADER* pState =
		(const PHONGTHAN_CHARACTER_STATE_HEADER*)pData;
	if (!PhongThanValidateCharacterState(pState, (PHONGTHAN_U32)dataLength))
		return false;

	LoginDiag("[LOGIN_DIAG][Bishop] sync account=%s role=%s use_revive=%d enter_map=%d revive_map=%d state_len=%u",
		m_sAccountName.c_str(), pState->RoleName, (int)pState->UseRevive,
		(int)pState->EnterMapId, (int)pState->ReviveMapId,
		(unsigned int)dataLength);
	if (m_sAccountName.compare((const char*)pState->AccountName) != 0)
	{
		LoginDiag("[LOGIN_DIAG][Bishop] reject=account_mismatch");
		return false;
	}

	IGServer* pGServer = NULL;
	if (pState->UseRevive)
		pGServer = CGameServer::QueryServer(pState->ReviveMapId);
	else
		pGServer = CGameServer::QueryServer(pState->EnterMapId);
	if (!pGServer)
		pGServer = CGameServer::QueryServer(1001);
	if (!pGServer)
		pGServer = CGameServer::GetServer(0);
	if (!pGServer)
		pGServer = CGameServer::GetServer(1);
	LoginDiag("[LOGIN_DIAG][Bishop] query_server=%p", pGServer);
	if (!pGServer)
	{
		LoginDiag("[LOGIN_DIAG][Bishop] reject=map_not_registered");
		return false;
	}

	if (!pGServer->Attach((const char*)pState->AccountName, true))
	{
		LoginDiag("[LOGIN_DIAG][Bishop] reject=gameserver_attach_failed");
		return false;
	}
	if (CGamePlayer::Get((const char*)pState->RoleName) == NULL)
		CGamePlayer::Add((const char*)pState->RoleName, (IPlayer*)this);

	m_nAttachServerID = pGServer->GetID();
	m_theDataQueue[enumOwnerPlayer].Empty();
	const bool ok = pGServer->DispatchTask(CGameServer::enumSyncRoleInfo,
		pState, dataLength, max(m_nExtPoint, 0));
	LoginDiag("[LOGIN_DIAG][Bishop] dispatch=%d server_id=%d",
		(int)ok, m_nAttachServerID);
	m_nExtPoint = -1;
	return ok;
}

UINT CGamePlayer::WaitForGameSvrPermit()
{
#ifdef	CONSOLE_DEBUG
		cprintf( "CGamePlayer::WaitForGameSvrPermit...\n" );
#endif

	CBuffer *pRetBuffer = m_theDataQueue[enumOwnerPlayer].Attach(
		PHONGTHAN_MSG_SESSION_ENTER_WORLD);

	if ( pRetBuffer && m_pPlayerServer )
	{
		UINT nNextTask = enumError;

		PHONGTHAN_SESSION_ENTER_WORLD_RESPONSE* pResponse =
			(PHONGTHAN_SESSION_ENTER_WORLD_RESPONSE*)pRetBuffer->GetBuffer();
		LoginDiag("[LOGIN_DIAG][Bishop] permit role=%s account=%s permit=%d ip=%u port=%u",
			pResponse->RoleName, pResponse->AccountName, (int)pResponse->Permit,
			(unsigned int)pResponse->ServerAddressV4, (unsigned int)pResponse->ServerPort);

#ifdef	CONSOLE_DEBUG
		cprintf( "CGamePlayer::WaitForGameSvrPermit Notify player to login gameserver\n" );
#endif

		if (pRetBuffer->GetUsed() == sizeof(*pResponse) && pResponse->Permit)
		{
			m_bAutoUnlockAccount = false;

			nNextTask = enumToNextTask;
		}

		m_pPlayerServer->SendData( m_lnIdentityID, pRetBuffer->GetBuffer(), pRetBuffer->GetUsed() );

		SAFE_RELEASE( pRetBuffer );
		m_theDataQueue[enumOwnerPlayer].Detach(
			PHONGTHAN_MSG_SESSION_ENTER_WORLD);

		return nNextTask;
	}

	return enumRepeat;
}

bool CGamePlayer::Attach( const char *pRoleName )
{
	if ( pRoleName && pRoleName[0] )
	{
		m_sRoleName = pRoleName;

		return true;
	}

	return false;
}

bool CGamePlayer::Add( const char *pRoleName, IPlayer *pPlayer )
{
	if ( NULL == pRoleName || NULL == pPlayer || !pRoleName[0] )
	{
		ASSERT( FALSE );

		return false;
	}

	if ( pPlayer )
	{
		CCriticalSection::Owner locker( CGamePlayer::m_csMapSP );

		std::pair< stdMapSP::iterator, bool > result = 
			m_sthePlayerTable.insert( stdMapSP::value_type( pRoleName, pPlayer ) );

		if ( result.second )
		{
			return pPlayer->Attach( pRoleName );
		}
	}

	return false;
}

bool CGamePlayer::Del( const char *pRoleName )
{
	if ( !pRoleName || !pRoleName[0] )
	{
		return false;
	}

	{
		CCriticalSection::Owner locker( CGamePlayer::m_csMapSP );
		
		stdMapSP::iterator it;
		
		if ( m_sthePlayerTable.end() != ( it = m_sthePlayerTable.find( pRoleName ) ) )
		{
			IPlayer *pPlayer = ( IPlayer * )( ( *it ).second );
			
			ASSERT( pPlayer );
			
			m_sthePlayerTable.erase( it );
			
			return true;
		}
	}

	return false;
}

IPlayer *CGamePlayer::Get( const char *pRoleName )
{
	if ( !pRoleName )
	{
		return NULL;
	}

	CCriticalSection::Owner locker( CGamePlayer::m_csMapSP );

	stdMapSP::iterator it;

	if ( m_sthePlayerTable.end() != ( it = m_sthePlayerTable.find( pRoleName ) ) )
	{
		return ( IPlayer * )( ( *it ).second );
	}

	return NULL;
}
