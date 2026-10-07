//-----------------------------------------//
//                                         //
//  File		: S3PDBSocketPool.cpp	   //
//	Author		: Yang Xiaodong            //
//	Modified	: 8/26/2002                //
//                                         //
//-----------------------------------------//
#pragma warning(disable: 4786)

#include "S3PDBSocketPool.h"
#include "S3PAccount.h"
#include "GlobalFun.h"
#include "S3PDBConnectionPool.h"

#include "../../Multiserver/Heaven/Interface/IServer.h"
#include "KProtocolDef.h"

#include "string.h"

#define LEFT_TIME		60000	//允许断线后的等待时间
#define PING_TIME		20000	//允许等待客户端Ping的时间
#define SENDPING_TIME	0x7fffffff	//向客户端发送Ping的时间

static PHONGTHAN_S32 PhongThanMapAccountResult(int nResult)
{
	switch (nResult)
	{
	case ACTION_SUCCESS:
		return PHONGTHAN_AUTH_SUCCESS;
	case E_ACCOUNT_OR_PASSWORD:
		return PHONGTHAN_AUTH_INVALID_CREDENTIALS;
	case E_ACCOUNT_EXIST:
		return PHONGTHAN_AUTH_ACCOUNT_IN_USE;
	case E_ACCOUNT_FREEZE:
		return PHONGTHAN_AUTH_ACCOUNT_FROZEN;
	case E_ACCOUNT_NODEPOSIT:
		return PHONGTHAN_AUTH_TIME_EXPIRED;
	default:
		return PHONGTHAN_AUTH_SERVICE_UNAVAILABLE;
	}
}
S3PDBSocketPool* S3PDBSocketPool::m_pInstance = NULL;

S3PDBSocketPool::S3PDBSocketPool()
{
	m_pServer = NULL;
}

S3PDBSocketPool::~S3PDBSocketPool()
{
	assert(m_pServer == NULL);
	assert(m_clientIDs.size() == 0);
}

S3PDBSocketPool* S3PDBSocketPool::Instance()
{
	if ( NULL == m_pInstance )
	{
		m_pInstance = new S3PDBSocketPool;
	}
	return m_pInstance;
}

void S3PDBSocketPool::ReleaseInstance()
{
	delete m_pInstance;
	m_pInstance = NULL;
}

HANDLE S3PDBSocketPool::Start(IServer* pServer, int nMax)
{
	assert(pServer);
	if (NULL == m_pServer)
	{
		m_pServer = pServer;
		pServer->AddRef();
		Lock();
		DWORD nNow = GetTickCount();
		for (int i = 0; i < nMax; i++)
		{
			KGatewayDataProcess* p = new KGatewayDataProcess();
			p->Start(m_pServer, nNow);
			m_clientIDs.push_back(p);
		}
		Unlock();
	}

	return 0;
}

BOOL S3PDBSocketPool::Stop()
{
	BOOL bRet = TRUE;
	if (bRet && m_pServer)
	{
		Lock();
		GatewayArray::iterator i = m_clientIDs.begin();
		while (i != m_clientIDs.end())
		{
			(*i)->Stop();
			delete (*i);
			i++;
		}
		Unlock();
		m_clientIDs.clear();

		m_pServer->Release();
		m_pServer = NULL;
	}

	return bRet;
}

BOOL S3PDBSocketPool::SendData(unsigned long uID, const void * const pData, const size_t &datalength)
{
	if (m_pServer == NULL || pData == NULL || datalength <= 0)
		return FALSE;

	BOOL bRet = FALSE;
	try
	{
		m_pServer->SendData(uID, pData, datalength);
		bRet = TRUE;
	}
	catch(...)
	{
		gTrace("Failed to feed back( S3PDBSocketPool::SendData )");
		bRet = FALSE;
	}
	return bRet;
}

//#include "../../MultiServer/Common/Macro.h"
//#include "../../MultiServer/Common/Buffer.h"
//
//using OnlineGameLib::Win32::CBuffer;
//CBuffer::Allocator	m_theGlobalAllocator( 1024 * 64, 10 );

BOOL S3PDBSocketPool::CustomSend(unsigned long uID, char nProtocol, KAccountHead* pSend)
{
	if (m_pServer == NULL)
		return FALSE;

	BOOL bRet = FALSE;
	try
	{
		assert(pSend);
		pSend->Version = ACCOUNT_CURRENT_VERSION;
		char send[MAX_PATH + 1];
		assert(pSend->Size < MAX_PATH);
		send[0] = nProtocol;
		memcpy(send + 1, pSend, pSend->Size);

		m_pServer->SendData(uID, send, pSend->Size + 1);
					
//		CBuffer *pBuffer = m_theGlobalAllocator.Allocate();
//		
//		BYTE *pData = const_cast< BYTE * >(pBuffer->GetBuffer());
//		*pData = nProtocol;
//		memcpy(pData + 1, pSend, pSend->Size);
//		pBuffer->Use(pSend->Size + 1);
//		
//		m_pServer->PreparePackSink();
//		m_pServer->PackDataToClient(uID, pData, pSend->Size + 1);
//		m_pServer->SendPackToClient();
//
//		SAFE_RELEASE(pBuffer);

		bRet = TRUE;
	}
	catch(...)
	{
		gTrace("Failed to feed back( S3PDBSocketPool::CustomSend )");
		bRet = FALSE;
	}
	return bRet;
}

BOOL S3PDBSocketPool::AddUserClientID(unsigned long uID)
{
	assert(m_pServer);
	const char* pInfo = m_pServer->GetClientInfo(uID);
	unsigned long Address = inet_addr(pInfo);
	int offset = 0;
	while(*(pInfo + offset) != ':')
		offset++;
	offset += 2;	//skip : and blank
	short Port = atoi(pInfo + offset);

	bool bError = false;

	GatewayArray::iterator i = m_clientIDs.begin();
	int n = 0;
	while (i != m_clientIDs.end())
	{
		if ((*i)->ConnectErrorWork(uID, Address, Port))
		{
			bError = true;
			break;
		}
		i++;
		n++;
	}

	if (bError)
	{
		i = m_clientIDs.begin();
		n = 0;
		while (i != m_clientIDs.end())
		{
			if ((*i)->ConnectFreeForErrorWork(uID, Address, Port))
			{
				gTrace("ErrorAdd Gateway(%s) Client %d ! -- At %d", pInfo, uID, n);
				return TRUE;	
			}
			i++;
			n++;
		}
	}
	else
	{
		i = m_clientIDs.begin();
		n = 0;
		while (i != m_clientIDs.end())
		{
			if ((*i)->ConnectAgainWork(uID, Address, Port))
			{
				gTrace("ReAdd Gateway(%s) Client %d ! -- At %d", pInfo, uID, n);
				return TRUE;	
			}
			i++;
			n++;
		}

		i = m_clientIDs.begin();
		n = 0;
		while (i != m_clientIDs.end())
		{
			if ((*i)->ConnectFreeWork(uID, Address, Port))
			{
				gTrace("Add Gateway(%s) Client %d ! -- At %d", pInfo, uID, n);
				return TRUE;	
			}
			i++;
			n++;
		}
	}

	return TRUE;
}

BOOL S3PDBSocketPool::RemoveUserClientID(unsigned long uID)
{
	GatewayArray::iterator i = m_clientIDs.begin();
	int n = 0;
	while (i != m_clientIDs.end ())
	{
		if ((*i)->OutofWork(uID))
		{
			gTrace("Remove Gateway Client %d ! -- At %d", uID, n);
			break;
		}
		i++;
		n++;
	}
	return TRUE;
}

BOOL S3PDBSocketPool::ShowAllClientInfo()
{
	if (IsLocked())
		return FALSE;
	Lock();
	BOOL b = FALSE;
	GatewayArray::iterator i = m_clientIDs.begin();
	int n = 0;
	while (i != m_clientIDs.end())
	{
		if (*i)
		{
			int nStatus = (*i)->GetStatus();
			switch (nStatus)
			{
			case KGatewayDataProcess::gdp_work:
				{
					in_addr add;
					add.s_addr = (*i)->m_Address;
					gTrace("Game %d: %s(%s:%d) is working", (*i)->m_nGameID, (*i)->m_ServerName, inet_ntoa(in_addr(add)), (*i)->m_Port);
				}
				break;
			case KGatewayDataProcess::gdp_again:
				{
					in_addr add;
					add.s_addr = (*i)->m_Address;
					gTrace("Game %d: %s(%s:%d) is waiting", (*i)->m_nGameID, (*i)->m_ServerName, inet_ntoa(in_addr(add)), (*i)->m_Port);
				}
				break;
			case KGatewayDataProcess::gdp_free:
				{
					gTrace("Game is free at %d", n);
				}
			break;
			case KGatewayDataProcess::gdp_verify:
				{
					gTrace("Game is verify at %d", n);
				}
			break;
			case KGatewayDataProcess::gdp_verifyagain:
				{
					gTrace("Game is verifyagain at %d", n);
				}
			break;
			case KGatewayDataProcess::gdp_errorconnect:
				{
					gTrace("Game is error at %d", n);
				}
			break;
			default:
				{
					gTrace("Game is unknown at %d", n);
				}
			break;
			}
		}
		i++;
		n++;
	}
	b = TRUE;
	Unlock();
	return b;
}

//////////////////////////////////////////////////////////////////////////////////////

KGatewayDataProcess::KGatewayDataProcess()
{
	m_nGameID = 0;
	m_ServerName[0] = 0;

	m_pServer = NULL;

	m_pConn = NULL;


	
	m_Status = gdp_free;
	m_nStatusTime = 0;
	m_nLeftStatusTime = 0;

	m_LastPingTime = 0;
	m_nLeftPingTime = 0;
}

KGatewayDataProcess::~KGatewayDataProcess()
{
	assert(m_pServer == NULL);
}

void KGatewayDataProcess::AutoTime()
{
	if (IsError())
	{
		m_pServer->ShutdownClient(m_nConnectID);
		return;
	}

	DWORD nNow = GetTickCount();

	BLACKLIST::iterator i = m_UserNames.begin();
	while (i != m_UserNames.end())
	{
		if ((nNow - i->second) / 1000 >= 1)	//每次循环处理1个已经超时的用户
		{
			m_UserNames.erase(i);
			break;
		}
		i++;
	}

	if (m_nLeftStatusTime > 0 && (nNow - m_nStatusTime > m_nLeftStatusTime) && IsWorkAgain())
	{
		S3PDBConVBC* pConn = GetDB(0);
		if (pConn)
		{
			S3PAccount::ElapseAll(pConn, m_nGameID);	//只扣钱,不解锁
			SetStatus(gdp_free);
			return;
		}
	}

	if (m_nLeftPingTime > 0 && (nNow - m_LastPingTime) >= m_nLeftPingTime && IsWork())
	{
		m_pServer->ShutdownClient(m_nConnectID);
	}

}

BOOL KGatewayDataProcess::CheckConnectAddress(DWORD Address)
{
	S3PDBConVBC* pConn = GetDB(0);
	if (pConn)
		return S3PAccount::CheckAddress(pConn, Address, m_Port) == ACTION_SUCCESS;
	return FALSE;
}

void KGatewayDataProcess::ProcessClientData(
	const void *pData, DWORD dwDataSize)
{
	if (!pData || !dwDataSize)
		return;

	if (PhongThanIsWirePacket(pData, (PHONGTHAN_U32)dwDataSize))
	{
		const PHONGTHAN_WIRE_HEADER* pHeader =
			(const PHONGTHAN_WIRE_HEADER*)pData;
		if (PhongThanValidateWireHeader(pHeader,
				(PHONGTHAN_U32)dwDataSize) &&
			pHeader->PacketSize == dwDataSize &&
			pHeader->MessageType ==
				PHONGTHAN_MSG_SERVICE_GATEWAY_HEARTBEAT &&
			pHeader->Flags == PHONGTHAN_WIRE_FLAG_REQUEST &&
			dwDataSize == sizeof(PHONGTHAN_SERVICE_GATEWAY_HEARTBEAT))
		{
			m_LastPingTime = GetTickCount();
			PHONGTHAN_SERVICE_GATEWAY_HEARTBEAT Response =
				*(const PHONGTHAN_SERVICE_GATEWAY_HEARTBEAT*)pData;
			PhongThanInitializeWireHeader(&Response.Header,
				PHONGTHAN_MSG_SERVICE_GATEWAY_HEARTBEAT,
				sizeof(Response), PHONGTHAN_WIRE_FLAG_RESPONSE,
				pHeader->Sequence);
			S3PDBSocketPool::Instance()->SendData(
				m_nConnectID, &Response, sizeof(Response));
			return;
		}
	}

	S3PDBConVBC* pConn = GetDB(10);
	ProcessData(pConn, pData, dwDataSize);
}

static BOOL ProcessPhongThanAccountEnterWorld(
	S3PDBConVBC* pConn, DWORD nConnectId, DWORD nGameId,
	const void* pData, DWORD dwDataSize)
{
	if (!pConn || !pData ||
		dwDataSize != sizeof(PHONGTHAN_SERVICE_ACCOUNT_ENTER_WORLD_REQUEST))
		return FALSE;

	const PHONGTHAN_SERVICE_ACCOUNT_ENTER_WORLD_REQUEST* pRequest =
		(const PHONGTHAN_SERVICE_ACCOUNT_ENTER_WORLD_REQUEST*)pData;
	if (pRequest->Header.MessageType !=
			PHONGTHAN_MSG_SERVICE_ACCOUNT_ENTER_WORLD ||
		pRequest->Header.Flags != PHONGTHAN_WIRE_FLAG_REQUEST ||
		!pRequest->AccountName[0] ||
		!memchr(pRequest->AccountName, 0,
			sizeof(pRequest->AccountName)))
	{
		return FALSE;
	}

	char szAccount[sizeof(pRequest->AccountName) + 1];
	memcpy(szAccount, pRequest->AccountName,
		sizeof(pRequest->AccountName));
	szAccount[sizeof(pRequest->AccountName)] = 0;
	const int nBackendResult = S3PAccount::LoginGame(
		pConn, nGameId, szAccount);

	PHONGTHAN_SERVICE_ACCOUNT_ENTER_WORLD_RESPONSE Response;
	memset(&Response, 0, sizeof(Response));
	PhongThanInitializeWireHeader(&Response.Header,
		PHONGTHAN_MSG_SERVICE_ACCOUNT_ENTER_WORLD, sizeof(Response),
		PHONGTHAN_WIRE_FLAG_RESPONSE, pRequest->Header.Sequence);
	Response.RequestId = pRequest->RequestId;
	Response.Result = PhongThanMapAccountResult(nBackendResult);
	strncpy((char*)Response.AccountName, szAccount,
		sizeof(Response.AccountName) - 1);

	gTrace("Phong Than account enter world: account=%s result=%d",
		szAccount, (int)Response.Result);
	return S3PDBSocketPool::Instance()->SendData(nConnectId,
		&Response, sizeof(Response));
}
DWORD KGatewayDataProcess::ProcessData(S3PDBConVBC* pConn, const void* pData, DWORD dwDataSize)
{
	BOOL bRet = FALSE;
	if (pConn == NULL || pData == NULL || dwDataSize <= 0)
	{
		return bRet;
	}

	if (PhongThanIsWirePacket(pData, (PHONGTHAN_U32)dwDataSize))
	{
		const PHONGTHAN_WIRE_HEADER* pHeader =
			(const PHONGTHAN_WIRE_HEADER*)pData;
		if (!PhongThanValidateWireHeader(pHeader,
				(PHONGTHAN_U32)dwDataSize) ||
			pHeader->PacketSize != dwDataSize ||
			pHeader->Flags != PHONGTHAN_WIRE_FLAG_REQUEST)
		{
			gTrace("Rejected invalid Phong Than account-service packet");
			return FALSE;
		}

		if (pHeader->MessageType == PHONGTHAN_MSG_SERVICE_GATEWAY_HELLO)
			return ProPhongThanGatewayHello(pConn, pData, dwDataSize);

		if (GetStatus() != gdp_work)
		{
			gTrace("Rejected Phong Than account request before gateway hello");
			return FALSE;
		}

		switch (pHeader->MessageType)
		{
		case PHONGTHAN_MSG_SERVICE_ACCOUNT_AUTHENTICATE:
			return ProPhongThanAccountAuthenticate(pConn, pData,
				dwDataSize);
		case PHONGTHAN_MSG_SERVICE_ACCOUNT_RELEASE:
			return ProPhongThanAccountRelease(pConn, pData,
				dwDataSize);
		case PHONGTHAN_MSG_SERVICE_ACCOUNT_ENTER_WORLD:
			return ProcessPhongThanAccountEnterWorld(pConn,
				m_nConnectID, m_nGameID, pData, dwDataSize);
		default:
			gTrace("Rejected unknown Phong Than account-service message %u",
				(unsigned int)pHeader->MessageType);
			return FALSE;
		}
	}

	return FALSE;
}

BOOL KGatewayDataProcess::ProPhongThanGatewayHello(
	S3PDBConVBC* pConn, const void* pData, DWORD dwDataSize)
{
	if (!pConn || !pData ||
		dwDataSize != sizeof(PHONGTHAN_SERVICE_GATEWAY_HELLO_REQUEST))
		return FALSE;

	const PHONGTHAN_SERVICE_GATEWAY_HELLO_REQUEST* pRequest =
		(const PHONGTHAN_SERVICE_GATEWAY_HELLO_REQUEST*)pData;
	const int nStatus = GetStatus();
	const bool bExpectedState =
		(!pRequest->Reconnect && nStatus == gdp_verify) ||
		(pRequest->Reconnect == 1 && nStatus == gdp_verifyagain);
	if (pRequest->Header.MessageType !=
			PHONGTHAN_MSG_SERVICE_GATEWAY_HELLO ||
		pRequest->Header.Flags != PHONGTHAN_WIRE_FLAG_REQUEST ||
		pRequest->Reconnect > 1 || !bExpectedState ||
		(pRequest->Reconnect && IsVerifyTimeout()) ||
		!pRequest->GatewayName[0] || !pRequest->CredentialProof[0] ||
		!memchr(pRequest->GatewayName, 0,
			sizeof(pRequest->GatewayName)) ||
		!memchr(pRequest->CredentialProof, 0,
			sizeof(pRequest->CredentialProof)))
		return FALSE;

	char szGateway[sizeof(pRequest->GatewayName) + 1];
	char szCredential[sizeof(pRequest->CredentialProof) + 1];
	memcpy(szGateway, pRequest->GatewayName,
		sizeof(pRequest->GatewayName));
	memcpy(szCredential, pRequest->CredentialProof,
		sizeof(pRequest->CredentialProof));
	szGateway[sizeof(pRequest->GatewayName)] = 0;
	szCredential[sizeof(pRequest->CredentialProof)] = 0;

	unsigned long nGameServiceId = 0;
	int nBackendResult = S3PAccount::ServerLogin(pConn, szGateway,
		szCredential, m_Address, m_Port, pRequest->AdapterAddress,
		nGameServiceId);
	PHONGTHAN_S32 nResult = PhongThanMapAccountResult(nBackendResult);

	if (nResult == PHONGTHAN_AUTH_SUCCESS)
	{
		memset(m_ServerName, 0, sizeof(m_ServerName));
		strncpy(m_ServerName, szGateway, sizeof(m_ServerName) - 1);
		m_nGameID = nGameServiceId;
		if (!pRequest->Reconnect)
		{
			S3PAccount::UnlockAll(pConn, m_nGameID);
			gTrace("Phong Than gateway cleared stale account locks");
		}
		if (SetStatus(gdp_work))
		{
			m_nLeftStatusTime = 0;
			m_nStatusTime = 0;
			m_LastPingTime = GetTickCount();
			m_nLeftPingTime = PING_TIME;
		}
	}

	PHONGTHAN_SERVICE_GATEWAY_HELLO_RESPONSE Response;
	memset(&Response, 0, sizeof(Response));
	PhongThanInitializeWireHeader(&Response.Header,
		PHONGTHAN_MSG_SERVICE_GATEWAY_HELLO, sizeof(Response),
		PHONGTHAN_WIRE_FLAG_RESPONSE, pRequest->Header.Sequence);
	Response.RequestId = pRequest->RequestId;
	Response.Result = nResult;
	Response.GameServiceId = nGameServiceId;
	strncpy((char*)Response.GatewayName, szGateway,
		sizeof(Response.GatewayName) - 1);

	gTrace("Phong Than gateway hello: gateway=%s reconnect=%u result=%d game=%lu",
		szGateway, (unsigned int)pRequest->Reconnect, (int)nResult,
		nGameServiceId);
	memset(szCredential, 0, sizeof(szCredential));
	return S3PDBSocketPool::Instance()->SendData(m_nConnectID,
		&Response, sizeof(Response));
}

BOOL KGatewayDataProcess::ProPhongThanAccountAuthenticate(
	S3PDBConVBC* pConn, const void* pData, DWORD dwDataSize)
{
	if (!pConn || !pData ||
		dwDataSize != sizeof(PHONGTHAN_SERVICE_ACCOUNT_AUTHENTICATE_REQUEST))
		return FALSE;

	const PHONGTHAN_SERVICE_ACCOUNT_AUTHENTICATE_REQUEST* pRequest =
		(const PHONGTHAN_SERVICE_ACCOUNT_AUTHENTICATE_REQUEST*)pData;
	if (pRequest->Header.MessageType !=
			PHONGTHAN_MSG_SERVICE_ACCOUNT_AUTHENTICATE ||
		pRequest->Header.Flags != PHONGTHAN_WIRE_FLAG_REQUEST ||
		(pRequest->Purpose != PHONGTHAN_ACCOUNT_AUTH_LOGIN &&
		 pRequest->Purpose != PHONGTHAN_ACCOUNT_AUTH_DELETE_CHARACTER) ||
		!pRequest->AccountName[0] || !pRequest->PasswordProof[0] ||
		!memchr(pRequest->AccountName, 0,
			sizeof(pRequest->AccountName)) ||
		!memchr(pRequest->PasswordProof, 0,
			sizeof(pRequest->PasswordProof)))
		return FALSE;

	char szAccount[sizeof(pRequest->AccountName) + 1];
	char szPassword[sizeof(pRequest->PasswordProof) + 1];
	memcpy(szAccount, pRequest->AccountName,
		sizeof(pRequest->AccountName));
	memcpy(szPassword, pRequest->PasswordProof,
		sizeof(pRequest->PasswordProof));
	szAccount[sizeof(pRequest->AccountName)] = 0;
	szPassword[sizeof(pRequest->PasswordProof)] = 0;

	UserName userName;
	memset(&userName, 0, sizeof(userName));
	strncpy(userName.m_szName, szAccount,
		sizeof(userName.m_szName) - 1);

	WORD nExtensionPoint = 0;
	DWORD nRemainingTime = 0;
	int nBackendResult = E_ACCOUNT_OR_PASSWORD;
	if (m_UserNames.find(userName) == m_UserNames.end())
	{
		if (pRequest->Purpose == PHONGTHAN_ACCOUNT_AUTH_LOGIN)
			nBackendResult = S3PAccount::Login(pConn, szAccount,
				szPassword, m_nGameID, nExtensionPoint,
				nRemainingTime);
		else
			nBackendResult = S3PAccount::VerifyUserModifyPassword(
				pConn, m_nGameID, szAccount, szPassword);
	}

	PHONGTHAN_S32 nResult = PhongThanMapAccountResult(nBackendResult);
	if (nResult == PHONGTHAN_AUTH_SUCCESS)
		m_UserNames.erase(userName);
	else if (nResult == PHONGTHAN_AUTH_INVALID_CREDENTIALS)
		m_UserNames[userName] = GetTickCount();

	PHONGTHAN_SERVICE_ACCOUNT_AUTHENTICATE_RESPONSE Response;
	memset(&Response, 0, sizeof(Response));
	PhongThanInitializeWireHeader(&Response.Header,
		PHONGTHAN_MSG_SERVICE_ACCOUNT_AUTHENTICATE,
		sizeof(Response), PHONGTHAN_WIRE_FLAG_RESPONSE,
		pRequest->Header.Sequence);
	Response.RequestId = pRequest->RequestId;
	Response.Result = nResult;
	Response.RemainingTime = nRemainingTime;
	Response.ExtensionPoint = nExtensionPoint;
	strncpy((char*)Response.AccountName, szAccount,
		sizeof(Response.AccountName) - 1);

	gTrace("Phong Than account authentication: account=%s purpose=%u result=%d",
		szAccount, (unsigned int)pRequest->Purpose, (int)nResult);
	memset(szPassword, 0, sizeof(szPassword));
	return S3PDBSocketPool::Instance()->SendData(m_nConnectID,
		&Response, sizeof(Response));
}

BOOL KGatewayDataProcess::ProPhongThanAccountRelease(
	S3PDBConVBC* pConn, const void* pData, DWORD dwDataSize)
{
	if (!pConn || !pData ||
		dwDataSize != sizeof(PHONGTHAN_SERVICE_ACCOUNT_RELEASE_REQUEST))
		return FALSE;

	const PHONGTHAN_SERVICE_ACCOUNT_RELEASE_REQUEST* pRequest =
		(const PHONGTHAN_SERVICE_ACCOUNT_RELEASE_REQUEST*)pData;
	if (pRequest->Header.MessageType !=
			PHONGTHAN_MSG_SERVICE_ACCOUNT_RELEASE ||
		pRequest->Header.Flags != PHONGTHAN_WIRE_FLAG_REQUEST ||
		!pRequest->AccountName[0] ||
		!memchr(pRequest->AccountName, 0,
			sizeof(pRequest->AccountName)) ||
		pRequest->ExtensionPoint < 0 ||
		pRequest->ExtensionPoint > 0xffff)
		return FALSE;

	char szAccount[sizeof(pRequest->AccountName) + 1];
	memcpy(szAccount, pRequest->AccountName,
		sizeof(pRequest->AccountName));
	szAccount[sizeof(pRequest->AccountName)] = 0;
	int nBackendResult = S3PAccount::Logout(pConn, m_nGameID,
		szAccount, (WORD)pRequest->ExtensionPoint);

	PHONGTHAN_SERVICE_ACCOUNT_RELEASE_RESPONSE Response;
	memset(&Response, 0, sizeof(Response));
	PhongThanInitializeWireHeader(&Response.Header,
		PHONGTHAN_MSG_SERVICE_ACCOUNT_RELEASE, sizeof(Response),
		PHONGTHAN_WIRE_FLAG_RESPONSE, pRequest->Header.Sequence);
	Response.RequestId = pRequest->RequestId;
	Response.Result = PhongThanMapAccountResult(nBackendResult);
	strncpy((char*)Response.AccountName, szAccount,
		sizeof(Response.AccountName) - 1);

	gTrace("Phong Than account release: account=%s result=%d",
		szAccount, (int)Response.Result);
	return S3PDBSocketPool::Instance()->SendData(m_nConnectID,
		&Response, sizeof(Response));
}
S3PDBConVBC* KGatewayDataProcess::GetDB(DWORD nSleep)
{
	if (!m_pConn)
	{
		S3PDBConnectionPool* pDB = S3PDBConnectionPool::Instance();
		if (nSleep)
		{
			while (m_pConn == NULL)
			{
				pDB->RemoveDBCon(&m_pConn);
				Sleep(nSleep);
			}
		}
		else
			pDB->RemoveDBCon(&m_pConn);
	}

	return m_pConn;
}

DWORD KGatewayDataProcess::Main(LPVOID lpParam)
{
	assert(m_hStop);
	assert(m_pServer);
	DWORD dwRet = 0;
	DWORD LastTime = GetTickCount();
	
	S3PDBConnectionPool* pDB = S3PDBConnectionPool::Instance();

	while (1)
	{
		DWORD dwResult =
			KPIWaitForSingleObject(m_hStop, 0);
		if (dwResult == 1)
			break;
		else if (dwResult == 2)
		{
			AutoTime();

			size_t datalength = 0;

			const void *pData = NULL;

			if (IsWantData())
				pData = m_pServer->GetPackFromClient(m_nConnectID, datalength);

			if (pData && 0 != datalength)
			{
				ProcessClientData(pData, datalength);
				LastTime = GetTickCount();
			}
			else
			{
				if (GetTickCount() - LastTime >= 1000)
				{
					if (m_pConn)
					{
						if (pDB->ReturnDBCon(m_pConn))
							m_pConn = NULL;
					}
				}
				Sleep(1);
			}
		}
	}

	if ((IsWork() || IsWorkAgain()) && GetDB(0))
	{
		S3PAccount::ElapseAll(m_pConn, m_nGameID);	//只扣钱,不解锁
	}

	if (m_pConn)
	{
		if (pDB->ReturnDBCon(m_pConn))
			m_pConn = NULL;
	}

	return dwRet;
}

HANDLE KGatewayDataProcess::Start(IServer* pServer, DWORD nNow)
{
	assert(pServer);
	if (NULL == m_pServer)
	{
		m_pServer = pServer;
		pServer->AddRef();
	}

	m_Status = gdp_free;
	m_nStatusTime = nNow;
	m_nLeftStatusTime = LEFT_TIME;

	return KThread::Start();
}

BOOL KGatewayDataProcess::Stop()
{
	BOOL bRet = KThread::Stop();
	if (bRet)
	{
		if (m_pServer)
		{
			m_pServer->Release();
			m_pServer = NULL;
		}
	}

	return bRet;
}

BOOL KGatewayDataProcess::ConnectErrorWork(unsigned long nID, unsigned long Address, short Port)
{
	BOOL bRet = FALSE;
	Lock();

	if (m_Status == gdp_verify ||	//只有这几个状态下的m_Address有效
		m_Status == gdp_work ||
		m_Status == gdp_verifyagain ||
		m_Status == gdp_errorconnect
		)
	{
		if (m_Address == Address)	//有已经连接的Address
		{
			bRet = TRUE;
		}
		goto exit0;
	}

exit0:
	Unlock();
	return bRet;
}


BOOL KGatewayDataProcess::ConnectFreeWork(unsigned long nID, unsigned long Address, short Port)
{
	BOOL bRet = FALSE;
	Lock();

	if (m_Status == gdp_free)
	{
		if (CheckConnectAddress(Address))
		{
			m_nConnectID = nID;
			m_Address = Address;
			m_Port = Port;
			m_Status = gdp_verify;
			bRet = TRUE;
		}
		goto exit0;
	}

exit0:
	Unlock();
	return bRet;
}

BOOL KGatewayDataProcess::ConnectAgainWork(unsigned long nID, unsigned long Address, short Port)
{
	BOOL bRet = FALSE;
	Lock();

	if (m_Status == gdp_again)
	{
		if (m_Address == Address && CheckConnectAddress(Address))
		{
			m_nConnectID = nID;
			m_Address = Address;
			m_Port = Port;
			m_Status = gdp_verifyagain;
			bRet = TRUE;
		}
		goto exit0;
	}

exit0:
	Unlock();
	return bRet;
}

BOOL KGatewayDataProcess::ConnectFreeForErrorWork(unsigned long nID, unsigned long Address, short Port)
{
	BOOL bRet = FALSE;
	Lock();

	if (m_Status == gdp_free)
	{
		m_nConnectID = nID;
		m_Address = Address;
		m_Port = Port;
		m_Status = gdp_errorconnect;
		bRet = TRUE;
		goto exit0;
	}

exit0:
	Unlock();
	return bRet;
}

BOOL KGatewayDataProcess::OutofWork(unsigned long nID)
{
	BOOL bRet = FALSE;
	Lock();
	if (m_nConnectID == nID)
	{
		m_nConnectID = -1;

		if (m_Status == gdp_work)
		{
			m_Status = gdp_again;
			m_nLeftStatusTime = LEFT_TIME;
			m_nStatusTime = GetTickCount();	//将剩余时间设上,为了客户端能重连上
			
			m_LastPingTime = 0;
			m_nLeftPingTime = 0;
					bRet = TRUE;
			goto exit0;
		}

		if (m_Status == gdp_verifyagain)
		{
			m_Status = gdp_again;
			//不改剩余时间,以继续计时
			bRet = TRUE;
			goto exit0;
		}

		if (m_Status == gdp_verify)
		{
			m_Status = gdp_free;
			//不改剩余时间,以继续计时
			bRet = TRUE;
			goto exit0;
		}

		if (m_Status == gdp_errorconnect)
		{
			m_Status = gdp_free;
			m_nLeftStatusTime = 0;
			m_nStatusTime = 0;
			m_LastPingTime = 0;
			m_nLeftPingTime = 0;
					bRet = TRUE;
			goto exit0;
		}
	}

exit0:
	Unlock();
	return bRet;
}

BOOL KGatewayDataProcess::IsWork()
{
	BOOL bRet = FALSE;
	Lock();
	if (m_Status == gdp_work)
	{
		bRet = TRUE;
	}
	Unlock();
	return bRet;
}

BOOL KGatewayDataProcess::IsWorkAgain()
{
	BOOL bRet = FALSE;
	Lock();
	if (m_Status == gdp_again)
	{
		bRet = TRUE;
	}
	Unlock();
	return bRet;
}

BOOL KGatewayDataProcess::IsWantData()
{
	BOOL bRet = FALSE;
	Lock();
	if (m_Status == gdp_work ||
		m_Status == gdp_again ||
		m_Status == gdp_verify ||
		m_Status == gdp_verifyagain)
	{
		bRet = TRUE;
	}
	Unlock();
	return bRet;
}

BOOL KGatewayDataProcess::IsError()
{
	BOOL bRet = FALSE;
	Lock();
	if (m_Status == gdp_errorconnect)
	{
		bRet = TRUE;
	}
	Unlock();
	return bRet;
}

int KGatewayDataProcess::GetStatus()
{
	int nStatus = -1;
	Lock();
	nStatus = m_Status;
	Unlock();
	return nStatus;
}

bool KGatewayDataProcess::SetStatus(int nNews)
{
	bool bRet = false;
	Lock();
	if (m_Status == gdp_free &&
		nNews == gdp_verify)
	{
		m_Status = nNews;
		bRet = true;
	}
	else if (m_Status == gdp_verify &&
		(nNews == gdp_work ||
		 nNews == gdp_free))
	{
		m_Status = nNews;
		bRet = true;
	}
	else if (m_Status == gdp_work &&
		nNews == gdp_again)
	{
		m_Status = nNews;
		bRet = true;
	}
	else if (m_Status == gdp_again &&
		(nNews == gdp_verifyagain ||
		 nNews == gdp_free))
	{
		m_Status = nNews;
		bRet = true;
	}
	else if (m_Status == gdp_verifyagain &&
		(nNews == gdp_work ||
		 nNews == gdp_again))
	{
		m_Status = nNews;
		bRet = true;
	}
	else if (m_Status == gdp_errorconnect &&
		nNews == gdp_free)
	{
		m_Status = nNews;
		bRet = true;
	}
	Unlock();

	return bRet;
}

bool KGatewayDataProcess::IsVerifyTimeout()
{
	bool bRet = true;
	Lock();
	if (m_Status == gdp_verify || m_Status == gdp_verifyagain)
	{
		if ((GetTickCount() - m_nStatusTime) <= m_nLeftStatusTime)
		{	//正确状态的有限时间内,才叫不超时
			bRet = false;
		}
	}
	Unlock();
	return bRet;
}