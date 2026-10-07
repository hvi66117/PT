#include "stdafx.h"
#include "ClientNode.h"

#include <process.h>
#include <iostream>
#include <stdarg.h>

#include "PhongThanCharacterStore.h"

#include "Macro.h"

#include "RoleNameFilter.h"

using OnlineGameLib::Win32::CCriticalSection;
using OnlineGameLib::Win32::CPackager;
using OnlineGameLib::Win32::CEvent;
using OnlineGameLib::Win32::CBuffer;

static void PhongThanCharacterServiceDiag(const char* pFormat, ...)
{
	FILE* pFile = fopen("goddess_character_diag.log", "a+b");
	if (!pFile)
		return;
	va_list Arguments;
	va_start(Arguments, pFormat);
	vfprintf(pFile, pFormat, Arguments);
	va_end(Arguments);
	fputc('\n', pFile);
	fclose(pFile);
}

HANDLE CClientNode::m_hThread = NULL;
CEvent CClientNode::m_hQuitEvent( NULL, true, false );

extern UINT g_nDBEngineLoop;

CCriticalSection	CClientNode::m_csCL;

CClientNode::stdMap	CClientNode::m_theClientMap;


CClientNode::CDataQueue::CDataQueue( size_t bufferSize /*= 1024 * 64*/, size_t maxFreeBuffers /*= 160*/ )
						: m_theDQAllocator( bufferSize, maxFreeBuffers )
{
}

CClientNode::CDataQueue::~CDataQueue()
{
}

bool CClientNode::CDataQueue::AddData( const BYTE *pData, size_t datalength )
{
	CBuffer *pBuffer = m_theDQAllocator.Allocate();

	pBuffer->AddData( pData, datalength );

	{
		CCriticalSection::Owner lock( m_csQueue );

		m_theData.push_back( pBuffer );
	}

	return true;
}

CBuffer *CClientNode::CDataQueue::Get()
{
	{
		CCriticalSection::Owner lock( m_csQueue );

		if ( !m_theData.empty() )
		{
			CBuffer *pBuffer = m_theData.front();

			pBuffer->AddRef();

			m_theData.pop_front();

			pBuffer->Release();

			return pBuffer;
		}
	}

	return NULL;
}

CClientNode::CClientNode(IServer *pServer, size_t id)
    : m_nIndentity(id), m_pServer(pServer)
{
}

CClientNode::~CClientNode()
{
	UnlockAllRole(m_nIndentity);
	SAFE_RELEASE( m_pServer );
}

CClientNode *CClientNode::AddNode( IServer *pServer, size_t id )
{
	CCriticalSection::Owner lock( CClientNode::m_csCL );

	IServer *pCloneServer = NULL;
	pServer->QueryInterface( IID_IIOCPServer, ( void ** )&pCloneServer );

	CClientNode *pNode = new CClientNode( pCloneServer, id );
		
	CClientNode::m_theClientMap.insert( stdMap::value_type( id, pNode ) );

	return pNode;
}

void CClientNode::DelNode( size_t id )
{
	stdMap::iterator it;

	if ( CClientNode::m_theClientMap.end() != ( it = CClientNode::m_theClientMap.find( id ) ) )
	{
		CCriticalSection::Owner lock( CClientNode::m_csCL );

		CClientNode *pNode = ( *it ).second;
	
		CClientNode::m_theClientMap.erase( id );

		SAFE_DELETE( pNode );
	}
}

bool CClientNode::Start( IServer *pServer )
{
	if ( CClientNode::m_hThread == NULL )
	{
		unsigned int threadID = 0;
		CClientNode::m_hQuitEvent.Reset();		
		CClientNode::m_hThread = (HANDLE)::_beginthreadex(0,
			0,
			ThreadFunction,
			( void * )pServer,
			0,
			&threadID );
		
		if ( CClientNode::m_hThread == NULL )
		{
			return false;
		}
	}

	return true;
}

void CClientNode::End()
{
	CClientNode::m_hQuitEvent.Set();

	if ( CClientNode::m_hThread != NULL )
	{
		DWORD result = ::WaitForSingleObject( CClientNode::m_hThread, 50000 );
		
		if ( result == WAIT_TIMEOUT )
		{
			::TerminateThread( CClientNode::m_hThread, ( DWORD )( -2 ) );
		}
		
		if ( CClientNode::m_hThread != NULL )
		{
			::CloseHandle( CClientNode::m_hThread );
			CClientNode::m_hThread = NULL;
		}
	}

	/*
	 * Save all
	 */
}

unsigned int __stdcall CClientNode::ThreadFunction( void *pV )
{
	IServer *pServer = reinterpret_cast< IServer * >( pV );

	ASSERT( pServer );

	try
	{
		while ( !CClientNode::m_hQuitEvent.Wait( 0 ) )
		{
			{
				CCriticalSection::Owner lock( CClientNode::m_csCL );

				CClientNode::stdMap::iterator it;

				for ( it = CClientNode::m_theClientMap.begin();
					it != CClientNode::m_theClientMap.end();
					it ++ )
					{
						CClientNode *pNode = ( CClientNode * )( ( *it ).second );

						ASSERT( pNode );

						pNode->Process();
					}
			}

			if ( ++ g_nDBEngineLoop & 0x80000000 )
			{
				g_nDBEngineLoop = 0;
			}

			if ( g_nDBEngineLoop & 0x1 )
			{
				::Sleep( 1 );
			}
		}
	}
	catch(...)
	{
		::MessageBox( NULL, "CClientNode::ThreadFunction was error!", "Warning", MB_OK );
	}

	return 0L;
}

void CClientNode::AppendData(const void *pData, size_t dataLength)
{
    if (!pData ||
        dataLength < sizeof(PHONGTHAN_WIRE_HEADER) ||
        dataLength > PHONGTHAN_CHARACTER_MAX_STATE_SIZE +
            sizeof(PHONGTHAN_SERVICE_CHARACTER_SAVE_REQUEST_HEADER))
    {
        return;
    }
    if (!PhongThanIsWirePacket(pData, (PHONGTHAN_U32)dataLength))
        return;
    const PHONGTHAN_WIRE_HEADER *pHeader =
        (const PHONGTHAN_WIRE_HEADER*)pData;
    if (!PhongThanValidateWireHeader(
            pHeader, (PHONGTHAN_U32)dataLength) ||
        pHeader->PacketSize != dataLength ||
        pHeader->Flags != PHONGTHAN_WIRE_FLAG_REQUEST)
    {
        return;
    }
    m_theDataQueue.AddData((const BYTE*)pData, dataLength);
}

void CClientNode::Process()
{
    CBuffer *pBuffer = m_theDataQueue.Get();
    if (!pBuffer)
        return;

    const BYTE *pData = pBuffer->GetBuffer();
    const size_t dataLength = pBuffer->GetUsed();
    const PHONGTHAN_WIRE_HEADER *pHeader =
        (const PHONGTHAN_WIRE_HEADER*)pData;
    if (PhongThanValidateWireHeader(
            pHeader, (PHONGTHAN_U32)dataLength) &&
        pHeader->PacketSize == dataLength)
    {
        switch (pHeader->MessageType)
        {
        case PHONGTHAN_MSG_SERVICE_CHARACTER_LIST:
            _QueryRoleList(pData, dataLength);
            break;
        case PHONGTHAN_MSG_SERVICE_CHARACTER_DELETE:
            _DelRole(pData, dataLength);
            break;
        case PHONGTHAN_MSG_SERVICE_CHARACTER_CREATE:
            _CreateRole(pData, dataLength);
            break;
        case PHONGTHAN_MSG_SERVICE_CHARACTER_SAVE:
            _SaveRoleInfo(pData, dataLength);
            break;
        case PHONGTHAN_MSG_SERVICE_CHARACTER_LOAD:
            _GetRoleInfo(pData, dataLength);
            break;
        case PHONGTHAN_MSG_SERVICE_CHARACTER_LOCK:
            _LockOrUnlockRole(pData, dataLength);
            break;
        default:
            break;
        }
    }
    SAFE_RELEASE(pBuffer);
}
void CClientNode::_QueryRoleList( const void *pData, size_t dataLength )
{
	ASSERT(m_pServer && pData && dataLength);
	if (dataLength != sizeof(PHONGTHAN_SERVICE_CHARACTER_LIST_REQUEST))
		return;
	const PHONGTHAN_SERVICE_CHARACTER_LIST_REQUEST* pRequest =
		(const PHONGTHAN_SERVICE_CHARACTER_LIST_REQUEST*)pData;
	if (!PhongThanValidateWireHeader(&pRequest->Header,
			(PHONGTHAN_U32)dataLength) ||
		pRequest->Header.MessageType != PHONGTHAN_MSG_SERVICE_CHARACTER_LIST ||
		pRequest->Header.Flags != PHONGTHAN_WIRE_FLAG_REQUEST ||
		!pRequest->AccountName[0] ||
		!memchr(pRequest->AccountName, 0, sizeof(pRequest->AccountName)))
		return;

	PHONGTHAN_SERVICE_CHARACTER_LIST_RESPONSE Response;
	ZeroMemory(&Response, sizeof(Response));
	PhongThanInitializeWireHeader(&Response.Header,
		PHONGTHAN_MSG_SERVICE_CHARACTER_LIST, sizeof(Response),
		PHONGTHAN_WIRE_FLAG_RESPONSE, pRequest->Header.Sequence);
	Response.RequestId = pRequest->RequestId;
	Response.Result = PHONGTHAN_CHARACTER_LIST_SERVICE_UNAVAILABLE;
	strncpy((char*)Response.AccountName,
		(const char*)pRequest->AccountName,
		sizeof(Response.AccountName) - 1);
	const int nCount = g_PhongThanCharacterStore.List(
		(const char*)pRequest->AccountName, Response.Characters,
		PHONGTHAN_CHARACTER_LIMIT);
	if (nCount >= 0 && nCount <= PHONGTHAN_CHARACTER_LIMIT)
	{
		Response.Result = PHONGTHAN_CHARACTER_LIST_SUCCESS;
		Response.CharacterCount = (PHONGTHAN_U8)nCount;
		Response.RecommendedIndex = 0;
	}
	const HRESULT hResult = m_pServer->SendData(
		m_nIndentity, &Response, sizeof(Response));
	PhongThanCharacterServiceDiag(
		"list client=%u request=%u account=%s count=%d result=%d send=0x%08lx",
		(unsigned int)m_nIndentity, (unsigned int)pRequest->RequestId,
		(const char*)pRequest->AccountName, nCount, (int)Response.Result,
		(unsigned long)hResult);
}

void CClientNode::_CreateRole( const void *pData, size_t dataLength )
{
	ASSERT(m_pServer && pData && dataLength);
	if (dataLength != sizeof(PHONGTHAN_SERVICE_CHARACTER_CREATE_REQUEST))
		return;
	const PHONGTHAN_SERVICE_CHARACTER_CREATE_REQUEST* pRequest =
		(const PHONGTHAN_SERVICE_CHARACTER_CREATE_REQUEST*)pData;
	if (!PhongThanValidateWireHeader(&pRequest->Header,
			(PHONGTHAN_U32)dataLength) ||
		pRequest->Header.MessageType != PHONGTHAN_MSG_SERVICE_CHARACTER_CREATE ||
		pRequest->Header.Flags != PHONGTHAN_WIRE_FLAG_REQUEST ||
		!pRequest->AccountName[0] || !pRequest->RoleName[0] ||
		!memchr(pRequest->AccountName, 0, sizeof(pRequest->AccountName)) ||
		!memchr(pRequest->RoleName, 0, sizeof(pRequest->RoleName)) ||
		pRequest->Gender >= PHONGTHAN_GENDER_COUNT ||
		pRequest->Profession >= PHONGTHAN_PROFESSION_COUNT ||
		pRequest->SkillCount > PHONGTHAN_STARTER_SKILL_LIMIT)
		return;

	PHONGTHAN_S32 nResult = PHONGTHAN_CHARACTER_OPERATION_INVALID_NAME;
	extern CRoleNameFilter g_fltRoleName;
	if (g_fltRoleName.IsTextPass((const char*)pRequest->RoleName))
	{
		PHONGTHAN_CHARACTER_STATE_HEADER SizeProbe;
		ZeroMemory(&SizeProbe, sizeof(SizeProbe));
		SizeProbe.FightSkillCount = pRequest->SkillCount;
		const PHONGTHAN_U32 nStateSize =
			PhongThanCharacterExpectedStateSize(&SizeProbe);
		BYTE* pStateBuffer = new BYTE[nStateSize];
		ZeroMemory(pStateBuffer, nStateSize);
		PHONGTHAN_CHARACTER_STATE_HEADER* pState =
			(PHONGTHAN_CHARACTER_STATE_HEADER*)pStateBuffer;
		pState->SchemaVersion = PHONGTHAN_CHARACTER_SCHEMA_VERSION;
		pState->StateSize = nStateSize;
		pState->Revision = 1;
		strncpy((char*)pState->AccountName,
			(const char*)pRequest->AccountName,
			sizeof(pState->AccountName) - 1);
		strncpy((char*)pState->RoleName,
			(const char*)pRequest->RoleName,
			sizeof(pState->RoleName) - 1);
		pState->Gender = pRequest->Gender;
		pState->Profession = pRequest->Profession;
		pState->UseRevive = 1;
		pState->ReviveMapId = pRequest->SpawnMapId;
		pState->ReviveX = pRequest->SpawnX;
		pState->ReviveY = pRequest->SpawnY;
		pState->EnterMapId = pRequest->SpawnMapId;
		pState->EnterX = pRequest->SpawnX;
		pState->EnterY = pRequest->SpawnY;
		pState->FightLevel = pRequest->FightLevel;
		pState->FightExperience = pRequest->FightExperience;
		pState->Money = pRequest->Money;
		pState->BankMoney = pRequest->BankMoney;
		pState->Power = pRequest->Power;
		pState->Agility = pRequest->Agility;
		pState->Physique = pRequest->Physique;
		pState->Wisdom = pRequest->Wisdom;
		pState->Luck = pRequest->Luck;
		pState->MaxLife = pRequest->MaxLife;
		pState->MaxStamina = pRequest->MaxStamina;
		pState->MaxMana = pRequest->MaxMana;
		pState->CurrentLife = pRequest->MaxLife;
		pState->CurrentStamina = pRequest->MaxStamina;
		pState->CurrentMana = pRequest->MaxMana;
		pState->RemainingAttributePoints =
			pRequest->RemainingAttributePoints;
		pState->RemainingSkillPoints = pRequest->RemainingSkillPoints;
		pState->LeadershipLevel = pRequest->LeadershipLevel;
		pState->LeadershipExperience = pRequest->LeadershipExperience;
		pState->FightSkillCount = pRequest->SkillCount;
		PHONGTHAN_CHARACTER_SKILL_RECORD* pSkills =
			(PHONGTHAN_CHARACTER_SKILL_RECORD*)(pState + 1);
		for (PHONGTHAN_U32 i = 0; i < pState->FightSkillCount; ++i)
		{
			pSkills[i].SkillId = pRequest->Skills[i].SkillId;
			pSkills[i].Level = pRequest->Skills[i].SkillLevel;
			pSkills[i].Value = pRequest->Skills[i].SkillValue;
		}
		if (PhongThanValidateCharacterState(pState, nStateSize) &&
			g_PhongThanCharacterStore.Create(pState, nStateSize))
		{
			nResult = PHONGTHAN_CHARACTER_OPERATION_SUCCESS;
		}
		else
		{
			nResult = PHONGTHAN_CHARACTER_OPERATION_NAME_IN_USE;
		}
		delete [] pStateBuffer;
	}

	PHONGTHAN_SERVICE_CHARACTER_CREATE_RESPONSE Response;
	ZeroMemory(&Response, sizeof(Response));
	PhongThanInitializeWireHeader(&Response.Header,
		PHONGTHAN_MSG_SERVICE_CHARACTER_CREATE, sizeof(Response),
		PHONGTHAN_WIRE_FLAG_RESPONSE, pRequest->Header.Sequence);
	Response.RequestId = pRequest->RequestId;
	Response.Result = nResult;
	strncpy((char*)Response.AccountName,
		(const char*)pRequest->AccountName,
		sizeof(Response.AccountName) - 1);
	strncpy((char*)Response.RoleName,
		(const char*)pRequest->RoleName,
		sizeof(Response.RoleName) - 1);
	m_pServer->SendData(m_nIndentity, &Response, sizeof(Response));
}

void CClientNode::_SaveRoleInfo( const void *pData, size_t dataLength )
{
	ASSERT(m_pServer && pData && dataLength);
	if (dataLength < sizeof(PHONGTHAN_SERVICE_CHARACTER_SAVE_REQUEST_HEADER))
		return;
	const PHONGTHAN_SERVICE_CHARACTER_SAVE_REQUEST_HEADER* pRequest =
		(const PHONGTHAN_SERVICE_CHARACTER_SAVE_REQUEST_HEADER*)pData;
	if (!PhongThanValidateWireHeader(&pRequest->Header,
			(PHONGTHAN_U32)dataLength) ||
		pRequest->Header.MessageType != PHONGTHAN_MSG_SERVICE_CHARACTER_SAVE ||
		pRequest->Header.Flags != PHONGTHAN_WIRE_FLAG_REQUEST ||
		pRequest->Header.PacketSize != dataLength ||
		pRequest->StateSize != dataLength - sizeof(*pRequest) ||
		pRequest->StateSize < sizeof(PHONGTHAN_CHARACTER_STATE_HEADER))
		return;

	const PHONGTHAN_CHARACTER_STATE_HEADER* pState =
		(const PHONGTHAN_CHARACTER_STATE_HEADER*)
			((const BYTE*)pData + sizeof(*pRequest));
	if (!PhongThanValidateCharacterState(pState, pRequest->StateSize))
		return;

	PHONGTHAN_SERVICE_CHARACTER_SAVE_RESPONSE Response;
	ZeroMemory(&Response, sizeof(Response));
	PhongThanInitializeWireHeader(&Response.Header,
		PHONGTHAN_MSG_SERVICE_CHARACTER_SAVE, sizeof(Response),
		PHONGTHAN_WIRE_FLAG_RESPONSE, pRequest->Header.Sequence);
	Response.RequestId = pRequest->RequestId;
	Response.Result = PHONGTHAN_CHARACTER_OPERATION_SERVICE_UNAVAILABLE;
	strncpy((char*)Response.RoleName, (const char*)pState->RoleName,
		sizeof(Response.RoleName) - 1);
	const bool bLockedBySelf =
		IsRoleLockBySelf((char*)pState->RoleName);
	const bool bLockedByOther =
		IsRoleLock((char*)pState->RoleName) && !bLockedBySelf;
	const bool bSaved = !bLockedByOther &&
		g_PhongThanCharacterStore.Save(pState, pRequest->StateSize);
	if (bSaved)
	{
		Response.Result = PHONGTHAN_CHARACTER_OPERATION_SUCCESS;
	}
	// A failed final write must not leave a permanent role lock. The caller
	// keeps retrying the save, while a later authenticated login can reload
	// the last valid on-disk revision instead of being reported as maintenance.
	if (pRequest->LeaveWorld && bLockedBySelf)
		UnlockRoleSelf((char*)pState->RoleName);
	const HRESULT hResult = m_pServer->SendData(
		m_nIndentity, &Response, sizeof(Response));
	PhongThanCharacterServiceDiag(
		"save client=%u request=%u role=%s leave=%u self=%d other=%d saved=%d result=%d send=0x%08lx",
		(unsigned int)m_nIndentity, (unsigned int)pRequest->RequestId,
		(const char*)pState->RoleName, (unsigned int)pRequest->LeaveWorld,
		(int)bLockedBySelf, (int)bLockedByOther, (int)bSaved,
		(int)Response.Result, (unsigned long)hResult);
}

void CClientNode::_DelRole( const void *pData, size_t dataLength )
{
	ASSERT(m_pServer && pData && dataLength);
	if (dataLength != sizeof(PHONGTHAN_SERVICE_CHARACTER_DELETE_REQUEST))
		return;
	const PHONGTHAN_SERVICE_CHARACTER_DELETE_REQUEST* pRequest =
		(const PHONGTHAN_SERVICE_CHARACTER_DELETE_REQUEST*)pData;
	if (!PhongThanValidateWireHeader(&pRequest->Header,
			(PHONGTHAN_U32)dataLength) ||
		pRequest->Header.MessageType != PHONGTHAN_MSG_SERVICE_CHARACTER_DELETE ||
		pRequest->Header.Flags != PHONGTHAN_WIRE_FLAG_REQUEST ||
		!pRequest->AccountName[0] || !pRequest->RoleName[0] ||
		!memchr(pRequest->AccountName, 0, sizeof(pRequest->AccountName)) ||
		!memchr(pRequest->RoleName, 0, sizeof(pRequest->RoleName)))
		return;

	PHONGTHAN_SERVICE_CHARACTER_DELETE_RESPONSE Response;
	ZeroMemory(&Response, sizeof(Response));
	PhongThanInitializeWireHeader(&Response.Header,
		PHONGTHAN_MSG_SERVICE_CHARACTER_DELETE, sizeof(Response),
		PHONGTHAN_WIRE_FLAG_RESPONSE, pRequest->Header.Sequence);
	Response.RequestId = pRequest->RequestId;
	Response.Result = g_PhongThanCharacterStore.Delete(
		(const char*)pRequest->AccountName,
		(const char*)pRequest->RoleName) ?
		PHONGTHAN_CHARACTER_OPERATION_SUCCESS :
		PHONGTHAN_CHARACTER_OPERATION_INVALID_CREDENTIALS;
	strncpy((char*)Response.AccountName,
		(const char*)pRequest->AccountName,
		sizeof(Response.AccountName) - 1);
	strncpy((char*)Response.RoleName,
		(const char*)pRequest->RoleName,
		sizeof(Response.RoleName) - 1);
	m_pServer->SendData(m_nIndentity, &Response, sizeof(Response));
}

//for Relay System and GM
void CClientNode::_GetRoleInfo( const void *pData, size_t dataLength )
{
	ASSERT(m_pServer && pData && dataLength);
	if (dataLength != sizeof(PHONGTHAN_SERVICE_CHARACTER_LOAD_REQUEST))
		return;
	const PHONGTHAN_SERVICE_CHARACTER_LOAD_REQUEST* pRequest =
		(const PHONGTHAN_SERVICE_CHARACTER_LOAD_REQUEST*)pData;
	if (!PhongThanValidateWireHeader(&pRequest->Header,
			(PHONGTHAN_U32)dataLength) ||
		pRequest->Header.MessageType != PHONGTHAN_MSG_SERVICE_CHARACTER_LOAD ||
		pRequest->Header.Flags != PHONGTHAN_WIRE_FLAG_REQUEST ||
		pRequest->Header.PacketSize != dataLength ||
		!pRequest->AccountName[0] || !pRequest->RoleName[0] ||
		!memchr(pRequest->AccountName, 0, sizeof(pRequest->AccountName)) ||
		!memchr(pRequest->RoleName, 0, sizeof(pRequest->RoleName)))
		return;

	PHONGTHAN_SERVICE_CHARACTER_LOAD_RESPONSE_HEADER Response;
	ZeroMemory(&Response, sizeof(Response));
	Response.RequestId = pRequest->RequestId;
	Response.Result = PHONGTHAN_CHARACTER_OPERATION_SERVICE_UNAVAILABLE;
	BYTE* pStateBuffer = new BYTE[PHONGTHAN_CHARACTER_MAX_STATE_SIZE];
	PHONGTHAN_U32 nStateSize = 0;
	const bool bWasLocked = IsRoleLock((char*)pRequest->RoleName);
	const bool bLoaded = g_PhongThanCharacterStore.Load(
		(const char*)pRequest->RoleName, pStateBuffer,
		PHONGTHAN_CHARACTER_MAX_STATE_SIZE, &nStateSize);
	// Account authentication is the admission gate. A role lock belongs to
	// the world write path and may outlive a crashed client, so it must not
	// turn a valid character-load request into the generic maintenance error.
	if (bLoaded)
	{
		const PHONGTHAN_CHARACTER_STATE_HEADER* pState =
			(const PHONGTHAN_CHARACTER_STATE_HEADER*)pStateBuffer;
		if (stricmp((const char*)pState->AccountName,
				(const char*)pRequest->AccountName) == 0)
		{
			Response.Result = PHONGTHAN_CHARACTER_OPERATION_SUCCESS;
			Response.StateSize = nStateSize;
		}
		else
		{
			Response.Result =
				PHONGTHAN_CHARACTER_OPERATION_INVALID_CREDENTIALS;
		}
	}

	const PHONGTHAN_U32 nPacketSize = (PHONGTHAN_U32)sizeof(Response) +
		Response.StateSize;
	PhongThanInitializeWireHeader(&Response.Header,
		PHONGTHAN_MSG_SERVICE_CHARACTER_LOAD, nPacketSize,
		PHONGTHAN_WIRE_FLAG_RESPONSE, pRequest->Header.Sequence);
	BYTE* pPacket = new BYTE[nPacketSize];
	memcpy(pPacket, &Response, sizeof(Response));
	if (Response.StateSize)
		memcpy(pPacket + sizeof(Response), pStateBuffer, Response.StateSize);
	const HRESULT hResult = m_pServer->SendData(
		m_nIndentity, pPacket, nPacketSize);
	PhongThanCharacterServiceDiag(
		"load client=%u request=%u account=%s role=%s was_locked=%d loaded=%d state=%u result=%d send=0x%08lx",
		(unsigned int)m_nIndentity, (unsigned int)pRequest->RequestId,
		(const char*)pRequest->AccountName, (const char*)pRequest->RoleName,
		(int)bWasLocked, (int)bLoaded, (unsigned int)Response.StateSize,
		(int)Response.Result, (unsigned long)hResult);
	delete [] pPacket;
	delete [] pStateBuffer;
}

/////////////////////////////////////////////////////////////////////////////////

CClientNode::stdRoleLockMap CClientNode::m_csRoleLock;
CCriticalSection	CClientNode::m_csCR;

void CClientNode::_LockOrUnlockRole(
    const void *pData, size_t dataLength)
{
    if (!pData ||
        dataLength != sizeof(PHONGTHAN_SERVICE_CHARACTER_LOCK_REQUEST))
    {
        return;
    }
    const PHONGTHAN_SERVICE_CHARACTER_LOCK_REQUEST *pRequest =
        (const PHONGTHAN_SERVICE_CHARACTER_LOCK_REQUEST*)pData;
    if (!PhongThanValidateWireHeader(
            &pRequest->Header, (PHONGTHAN_U32)dataLength) ||
        pRequest->Header.MessageType !=
            PHONGTHAN_MSG_SERVICE_CHARACTER_LOCK ||
        pRequest->Header.Flags != PHONGTHAN_WIRE_FLAG_REQUEST ||
        !pRequest->RoleName[0] ||
        !memchr(pRequest->RoleName, 0, sizeof(pRequest->RoleName)))
    {
        return;
    }

    CCriticalSection::Owner lock(CClientNode::m_csCR);
    const char *pRoleName = (const char*)pRequest->RoleName;
    if (pRequest->Lock)
    {
        m_csRoleLock[pRoleName] = m_nIndentity;
		PhongThanCharacterServiceDiag(
			"lock client=%u role=%s", (unsigned int)m_nIndentity,
			pRoleName);
        return;
    }
    stdRoleLockMap::iterator it = m_csRoleLock.find(pRoleName);
    if (it != m_csRoleLock.end() && it->second == m_nIndentity)
	{
        m_csRoleLock.erase(it);
		PhongThanCharacterServiceDiag(
			"unlock client=%u role=%s", (unsigned int)m_nIndentity,
			pRoleName);
	}
}

bool CClientNode::IsRoleLock(char* szRole)
{
	CCriticalSection::Owner lock( CClientNode::m_csCR );
	if (szRole && szRole[0] != 0)
	{
		stdRoleLockMap::iterator it = m_csRoleLock.find(szRole);
		if (it != m_csRoleLock.end() && it->second != -1)
			return true;
	}
	return false;
}

bool CClientNode::IsRoleLockBySelf(char* szRole)
{
	CCriticalSection::Owner lock( CClientNode::m_csCR );
	if (szRole && szRole[0] != 0)
	{
		stdRoleLockMap::iterator it = m_csRoleLock.find(szRole);
		if (it != m_csRoleLock.end() && it->second == m_nIndentity)
			return true;
	}
	return false;
}

bool CClientNode::UnlockRoleSelf(char* szRole)
{
	CCriticalSection::Owner lock( CClientNode::m_csCR );
	if (szRole && szRole[0] != 0)
	{
		stdRoleLockMap::iterator it = m_csRoleLock.find(szRole);
		if (it != m_csRoleLock.end() && it->second == m_nIndentity)
		{
			m_csRoleLock.erase(it);
			return true;
		}
	}
	return false;
}

void CClientNode::UnlockAllRole(size_t ID)
{
	CCriticalSection::Owner lock( CClientNode::m_csCR );
	stdRoleLockMap::iterator it = m_csRoleLock.begin();
	while (it != m_csRoleLock.end())
	{
		if (it->second == ID)
		{
			PhongThanCharacterServiceDiag(
				"disconnect_unlock client=%u role=%s", (unsigned int)ID,
				it->first.c_str());
			stdRoleLockMap::iterator eraseIt = it++;
			m_csRoleLock.erase(eraseIt);
		}
		else
		{
			++it;
		}
	}
}

/////////////////////////////////////////////////////////////////////////////////
