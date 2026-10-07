#include "stdafx.h"
#include "PlayerCreator.h"
#include "inifile.h"
#include "utils.h"
#include "tstring.h"
#include "Macro.h"
#include "GameDatadef.h"
#include "PhongThanSpawn.h"

using OnlineGameLib::Win32::CIniFile;
using OnlineGameLib::Win32::GetAppFullPath;
using OnlineGameLib::Win32::_tstring;
using OnlineGameLib::Win32::ToBool;


CPlayerCreator::CPlayerCreator()
{
	for (int i = 0; i < MAX_PLAYERTYPE_VALUE; i++)
	{
		m_pRoleData[i] = NULL;
	}
	
	Init();
}

CPlayerCreator::~CPlayerCreator()
{
	for (int i = 0; i < MAX_PLAYERTYPE_VALUE; i++)
	{
		if (m_pRoleData[i])
		{
			delete [] m_pRoleData[i];
			m_pRoleData[i] = NULL;
		}
	}

	stdMapID2RID::iterator it;	
	for ( it = m_theMapID2RID.begin(); it != m_theMapID2RID.end(); it ++ )
	{
		stdRevivalID &SL = ( *it ).second;
		
		SL.clear();
	}
	
	m_theMapID2RID.erase( m_theMapID2RID.begin(), m_theMapID2RID.end() );
}

bool CPlayerCreator::Init()
{
	CIniFile theIniFile;

	_tstring sIniFilePathName;

	sIniFilePathName = GetAppFullPath( NULL );

	char	szFileName[MAX_PATH];

	for (int i = 0; i < MAX_PLAYERTYPE_VALUE; i++)
	{
		sprintf(szFileName, PLAYERCREATOR_FILE, i);
		_tstring sIniFileName = sIniFilePathName + szFileName;

		if (!m_pRoleData[i])
			m_pRoleData[i] = new BYTE[MAX_NEWPLAYER_BUFFER];
		ZeroMemory(m_pRoleData[i], MAX_NEWPLAYER_BUFFER * sizeof(BYTE));
		GetRoleDataFromIni(m_pRoleData[i], sIniFileName.c_str());
	}
	
	_tstring sRevivalFileName = sIniFilePathName + REVIVALID_FILENAME;

	CIniFile	cFile;
	cFile.SetFile( sRevivalFileName.c_str() );

	CIniFile::_VETSTR theIniVetstr;
	cFile.ReadSections( theIniVetstr );

	char szBuffer[64];

	CIniFile::_VETSTR::iterator it;
	for ( it = theIniVetstr.begin(); it != theIniVetstr.end(); it ++ )
	{
		_tstring info = ( *it );

		if ( info.empty() )
		{
			continue;
		}

		int nSection = atoi( info.c_str() );
		int nCount = cFile.ReadInteger( info.c_str(), "Count", 0 );

		if ( nCount > 0 )
		{
			stdRevivalID rid;
			
			for ( int i=0; i<nCount; i++ )
			{
				sprintf( szBuffer, "RevivalId%2.2d", i );
				
				int nID = cFile.ReadInteger( info.c_str(), szBuffer, 0 );
				
				rid.push_back( nID );
			}
			
			m_theMapID2RID.insert( stdMapID2RID::value_type( nSection, rid ) );
		}
	}

	return false;
}

unsigned CPlayerCreator::GetRevivalID( size_t nMapID, UINT nType /*= enumRandom*/ )
{
	stdMapID2RID::iterator it;
	
	if ( m_theMapID2RID.end() != ( it = m_theMapID2RID.find( nMapID ) ) )
	{
		stdRevivalID& sl = ( *it ).second;

		/*
		 * TODO : Don't get the server when it can't carry anyone
		 */
		if ( !sl.empty() )
		{
			int nCount = sl.size();

			ASSERT( nCount > 0 );

			int nIndex = rand() % nCount;
			nIndex = ( nIndex >= 0 && nIndex < nCount ) ? nIndex : 0;

			return sl[nIndex];
		}
	}

	return 0;
}

const PHONGTHAN_CHARACTER_STATE_HEADER* CPlayerCreator::GetRoleData(
	unsigned int &uDataLength, LPROLEPARAM lpParam)
{
	if (!lpParam)
	{
		uDataLength = 0;
		return NULL;
	}
	const int nIndex = lpParam->nProfession * PHONGTHAN_GENDER_COUNT + lpParam->nSex;
	if (nIndex < 0 || nIndex >= MAX_PLAYERTYPE_VALUE || !m_pRoleData[nIndex])
	{
		uDataLength = 0;
		return NULL;
	}

	PHONGTHAN_CHARACTER_STATE_HEADER* pState =
		(PHONGTHAN_CHARACTER_STATE_HEADER*)m_pRoleData[nIndex];
	ZeroMemory(pState->RoleName, sizeof(pState->RoleName));
	ZeroMemory(pState->AccountName, sizeof(pState->AccountName));
	strncpy((char*)pState->RoleName, lpParam->szName,
		sizeof(pState->RoleName) - 1);
	strncpy((char*)pState->AccountName, lpParam->szAccName,
		sizeof(pState->AccountName) - 1);
	pState->Gender = (PHONGTHAN_U8)lpParam->nSex;
	pState->Profession = (PHONGTHAN_U8)lpParam->nProfession;
	pState->ReviveMapId = lpParam->nMapID;
	POINT spawn;
	if (!PhongThanResolveRevivalPoint(lpParam->nMapID, 0, &spawn))
	{
		uDataLength = 0;
		return NULL;
	}
	pState->ReviveX = spawn.x;
	pState->ReviveY = spawn.y;
	pState->EnterMapId = pState->ReviveMapId;
	pState->EnterX = pState->ReviveX;
	pState->EnterY = pState->ReviveY;

	uDataLength = pState->StateSize;
	return PhongThanValidateCharacterState(pState, pState->StateSize) ?
		pState : NULL;
}

bool CPlayerCreator::GetRoleDataFromIni(BYTE* pData, const char* szFileName)
{
	if (!pData || !szFileName)
		return false;
	CIniFile cFile;
	cFile.SetFile(szFileName);
	ZeroMemory(pData, MAX_NEWPLAYER_BUFFER);

	int nSkillCount = cFile.ReadInteger("FSKILLS", "COUNT", 0);
	if (nSkillCount < 0)
		nSkillCount = 0;
	if (nSkillCount > PHONGTHAN_STARTER_SKILL_LIMIT)
		nSkillCount = PHONGTHAN_STARTER_SKILL_LIMIT;
	PHONGTHAN_CHARACTER_STATE_HEADER SizeProbe;
	ZeroMemory(&SizeProbe, sizeof(SizeProbe));
	SizeProbe.FightSkillCount = nSkillCount;
	const PHONGTHAN_U32 nStateSize =
		PhongThanCharacterExpectedStateSize(&SizeProbe);
	if (!nStateSize || nStateSize > MAX_NEWPLAYER_BUFFER)
		return false;

	PHONGTHAN_CHARACTER_STATE_HEADER* pState =
		(PHONGTHAN_CHARACTER_STATE_HEADER*)pData;
	pState->SchemaVersion = PHONGTHAN_CHARACTER_SCHEMA_VERSION;
	pState->StateSize = nStateSize;
	pState->Revision = 1;
	pState->UseRevive = 1;
	pState->RemainingAttributePoints =
		cFile.ReadInteger("ROLE", "ileftprop", 0);
	pState->RemainingSkillPoints =
		cFile.ReadInteger("ROLE", "ileftfight", 0);
	pState->Power = cFile.ReadInteger("ROLE", "ipower", 0);
	pState->Agility = cFile.ReadInteger("ROLE", "iagility", 0);
	pState->Physique = cFile.ReadInteger("ROLE", "iouter", 0);
	pState->Wisdom = cFile.ReadInteger("ROLE", "iinside", 0);
	pState->Luck = cFile.ReadInteger("ROLE", "iluck", 0);
	pState->FightExperience = cFile.ReadInteger("ROLE", "ifightexp", 0);
	pState->FightLevel = cFile.ReadInteger("ROLE", "ifightlevel", 0);
	pState->LeadershipLevel = cFile.ReadInteger("ROLE", "ileadlevel", 0);
	pState->LeadershipExperience = cFile.ReadInteger("ROLE", "ileadexp", 0);
	pState->Money = cFile.ReadInteger("ROLE", "imoney", 0);
	pState->BankMoney = cFile.ReadInteger("ROLE", "isavemoney", 0);
	pState->TeamId = cFile.ReadInteger("ROLE", "iteam", 0);
	pState->Gender = (PHONGTHAN_U8)cFile.ReadInteger("ROLE", "bsex", 0);
	pState->Profession = PHONGTHAN_PROFESSION_INVALID;
	pState->MaxLife = cFile.ReadInteger("ROLE", "imaxlife", 0);
	pState->MaxStamina = cFile.ReadInteger("ROLE", "imaxstamina", 0);
	pState->MaxMana = cFile.ReadInteger("ROLE", "imaxinner", 0);
	pState->CurrentLife = pState->MaxLife;
	pState->CurrentStamina = pState->MaxStamina;
	pState->CurrentMana = pState->MaxMana;
	pState->ReviveMapId = cFile.ReadInteger("ROLE", "irevivalid", 0);
	pState->ReviveX = cFile.ReadInteger("ROLE", "irevivalx", 0);
	pState->ReviveY = cFile.ReadInteger("ROLE", "irevivaly", 0);
	pState->EnterMapId = pState->ReviveMapId;
	pState->EnterX = pState->ReviveX;
	pState->EnterY = pState->ReviveY;
	pState->FightSkillCount = nSkillCount;

	PHONGTHAN_CHARACTER_SKILL_RECORD* pSkills =
		(PHONGTHAN_CHARACTER_SKILL_RECORD*)(pState + 1);
	char szSkillId[32];
	char szSkillLevel[32];
	for (int i = 0; i < nSkillCount; ++i)
	{
		sprintf(szSkillId, "S%d", i + 1);
		sprintf(szSkillLevel, "L%d", i + 1);
		pSkills[i].SkillId = cFile.ReadInteger("FSKILLS", szSkillId, 0);
		pSkills[i].Level = cFile.ReadInteger("FSKILLS", szSkillLevel, 0);
		pSkills[i].Value = 0;
	}
	return true;
}
