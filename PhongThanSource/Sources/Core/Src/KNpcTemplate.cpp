#include "KCore.h"

#include "KNpcTemplate.h"

#ifdef _SERVER
static void LoadNpcTemplateScript(int nRow, const char* pszColumn,
	char* pszScript, int nScriptSize, DWORD* pdwScriptId)
{
	char szSource[MAX_NPC_SCRIPT_FILE_NAME];
	char szNormalized[MAX_NPC_SCRIPT_FILE_NAME];
	const char* pszSource;
	int nSource = 0;
	int nOutput = 0;

	pszScript[0] = 0;
	*pdwScriptId = 0;
	szSource[0] = 0;
	g_NpcSetting.GetString(nRow, (char*)pszColumn, "", szSource, sizeof(szSource));
	if (!szSource[0] || strcmp(szSource, "0") == 0)
		return;

	for (nSource = 0; szSource[nSource]; ++nSource)
	{
		if (szSource[nSource] == '/')
			szSource[nSource] = '\\';
	}

	pszSource = szSource;
	while (*pszSource == '.')
		++pszSource;
	if (_strnicmp(pszSource, "\\root\\script\\", 13) == 0)
		pszSource += 5;

	if (*pszSource != '\\' && nOutput < sizeof(szNormalized) - 1)
		szNormalized[nOutput++] = '\\';
	while (*pszSource && nOutput < sizeof(szNormalized) - 1)
		szNormalized[nOutput++] = *pszSource++;
	szNormalized[nOutput] = 0;

	g_StrLower(szNormalized);
	if(strcmp(pszColumn,"DeathScript")==0 &&
		strcmp(szNormalized,"\\script\\npcdeath\\normal.lua")==0)
		g_StrCpyLen(szNormalized,"\\script\\phongthan\\npc_quests\\normal.lua",sizeof(szNormalized));
	g_StrCpyLen(pszScript, szNormalized, nScriptSize);
	*pdwScriptId = g_FileName2Id(pszScript);
}
#endif

void	KNpcTemplate::Init(int nNpcTemplateId)
{
	if (nNpcTemplateId < 0 ) return;
	int nNpcTempRow = nNpcTemplateId + 2;

	m_NpcSettingIdx = nNpcTemplateId;

	g_NpcSetting.GetString(nNpcTempRow, "Name", "", Name, sizeof(Name));
	g_NpcSetting.GetInteger(nNpcTempRow, "Kind", 0, (int *)&m_Kind);
	// Phong Than 2026-10-03 cppbatch:H6 VNG rows carry Kind 7..15 (mines, carriages 8, city buildings 9,
	// pets 10, traps 11...), outside KNpcSet::m_RelationTable[kind_num][kind_num]: never index past it.
	if (m_Kind >= kind_num)
		m_Kind = kind_normal;
	g_NpcSetting.GetInteger(nNpcTempRow, "Camp", 0, &m_Camp);
	g_NpcSetting.GetInteger(nNpcTempRow, "Series", 0, &m_Series);
	
	
	g_NpcSetting.GetInteger(nNpcTempRow, "HeadImage",	0, &m_HeadImage);
	g_NpcSetting.GetInteger(nNpcTempRow, "ClientOnly",	0, &m_bClientOnly);
	g_NpcSetting.GetInteger(nNpcTempRow, "CorpseIdx",	0, &m_CorpseSettingIdx);
	
	g_NpcSetting.GetInteger(nNpcTempRow, "DeathFrame",	12, &m_DeathFrame);
	g_NpcSetting.GetInteger(nNpcTempRow, "WalkFrame",	15, &m_WalkFrame);
	g_NpcSetting.GetInteger(nNpcTempRow, "RunFrame",	15, &m_RunFrame);
	g_NpcSetting.GetInteger(nNpcTempRow, "HurtFrame",	10, &m_HurtFrame);
	g_NpcSetting.GetInteger(nNpcTempRow, "WalkSpeed",	5, &m_WalkSpeed);
	g_NpcSetting.GetInteger(nNpcTempRow, "AttackSpeed",	20, &m_AttackFrame);
	g_NpcSetting.GetInteger(nNpcTempRow, "CastSpeed",	20, &m_CastFrame);
	g_NpcSetting.GetInteger(nNpcTempRow, "RunSpeed",	10, &m_RunSpeed);
	g_NpcSetting.GetInteger(nNpcTempRow, "StandFrame",	15, &m_StandFrame);
	g_NpcSetting.GetInteger(nNpcTempRow, "StandFrame1", 15, &m_StandFrame1);
	g_NpcSetting.GetInteger(nNpcTempRow, "Stature",		0,  &m_nStature);
	
#ifdef _SERVER	
	g_NpcSetting.GetInteger(nNpcTempRow, "AIMode",	0, &m_AiMode);
	g_NpcSetting.GetInteger(nNpcTempRow, "AIParam1",	0, &m_AiParam[0]);
	g_NpcSetting.GetInteger(nNpcTempRow, "AIParam2",	0, &m_AiParam[1]);
	g_NpcSetting.GetInteger(nNpcTempRow, "AIParam3",	0, &m_AiParam[2]);
	g_NpcSetting.GetInteger(nNpcTempRow, "AIParam4",	0, &m_AiParam[3]);
	g_NpcSetting.GetInteger(nNpcTempRow, "AIParam5",	0, &m_AiParam[4]);
	g_NpcSetting.GetInteger(nNpcTempRow, "AIParam6",	0, &m_AiParam[5]);
	g_NpcSetting.GetInteger(nNpcTempRow, "AIParam7",	0, &m_AiParam[6]);
	g_NpcSetting.GetInteger(nNpcTempRow, "AIParam8",	0, &m_AiParam[7]);
	g_NpcSetting.GetInteger(nNpcTempRow, "AIParam9",	0, &m_AiParam[8]);
	g_NpcSetting.GetInteger(nNpcTempRow, "AIParam10",	5, &m_AiParam[9]);

	g_NpcSetting.GetInteger(nNpcTempRow, "FireResistMax",	0, &m_FireResistMax);
	g_NpcSetting.GetInteger(nNpcTempRow, "ColdResistMax",	0, &m_ColdResistMax);
	g_NpcSetting.GetInteger(nNpcTempRow, "LightResistMax",	0, &m_LightResistMax);
	g_NpcSetting.GetInteger(nNpcTempRow, "EarthResistMax",	0, &m_EarthResistMax);
	g_NpcSetting.GetInteger(nNpcTempRow, "PoisonResistMax",	0, &m_PoisonResistMax);
	g_NpcSetting.GetInteger(nNpcTempRow, "PhysicsResistMax",	0, &m_PhysicsResistMax);
	g_NpcSetting.GetInteger(nNpcTempRow, "ActiveRadius", 30, &m_ActiveRadius);
	g_NpcSetting.GetInteger(nNpcTempRow, "VisionRadius", 40, &m_VisionRadius);
	
	int nAIMaxTime = 0;
	g_NpcSetting.GetInteger(nNpcTempRow, "AIMaxTime", 25, (int*)&nAIMaxTime);
	m_AIMAXTime = (BYTE)nAIMaxTime;
	
	g_NpcSetting.GetInteger(nNpcTempRow, "HitRecover", 0, &m_HitRecover);
	g_NpcSetting.GetInteger(nNpcTempRow, "ReviveFrame", 2400, &m_ReviveFrame);
	LoadNpcTemplateScript(nNpcTempRow, "ActionScript", m_ActionScript,
		sizeof(m_ActionScript), &m_ActionScriptID);
	LoadNpcTemplateScript(nNpcTempRow, "DeathScript", m_DeathScript,
		sizeof(m_DeathScript), &m_DeathScriptID);
	LoadNpcTemplateScript(nNpcTempRow, "TimerScript", m_TimerScript,
		sizeof(m_TimerScript), &m_TimerScriptID);
	LoadNpcTemplateScript(nNpcTempRow, "LevelScript", m_LevelScript,
		sizeof(m_LevelScript), &m_LevelScriptID);
	g_NpcSetting.GetInteger(nNpcTempRow, "TimerValue", 0, &m_TimerValue);
#else
	g_NpcSetting.GetInteger(nNpcTempRow, "ArmorType", 0, &m_ArmorResourceId);
	g_NpcSetting.GetInteger(nNpcTempRow, "HelmType", 0, &m_HelmResourceId);
	g_NpcSetting.GetInteger(nNpcTempRow, "WeaponType", 0, &m_WeaponResourceId);
	g_NpcSetting.GetInteger(nNpcTempRow, "HorseType", -1, &m_HorseResourceId);
	g_NpcSetting.GetInteger(nNpcTempRow, "RideHorse",0, &m_bRideHorse);
#endif


#ifdef _SERVER	
int nParam;
int nParam2;
	g_NpcSetting.GetInteger(nNpcTempRow, "Skill1",	0, &nParam);
	g_NpcSetting.GetInteger(nNpcTempRow, "Level1", 0, &nParam2);
	if (nParam && nParam2)
		m_SkillList.SetNpcSkill(1, nParam, nParam2);

	g_NpcSetting.GetInteger(nNpcTempRow, "Skill2",	0, &nParam);
	g_NpcSetting.GetInteger(nNpcTempRow, "Level2", 0, &nParam2);
	if (nParam && nParam2)
		m_SkillList.SetNpcSkill(2, nParam, nParam2);

	g_NpcSetting.GetInteger(nNpcTempRow, "Skill3",	0, &nParam);
	g_NpcSetting.GetInteger(nNpcTempRow, "Level3", 0, &nParam2);
	if (nParam && nParam2)
		m_SkillList.SetNpcSkill(3, nParam, nParam2);

	g_NpcSetting.GetInteger(nNpcTempRow, "Skill4",	0, &nParam);
	g_NpcSetting.GetInteger(nNpcTempRow, "Level4", 0, &nParam2);
	if (nParam && nParam2)
		m_SkillList.SetNpcSkill(4, nParam, nParam2);

	g_NpcSetting.GetInteger(nNpcTempRow, "ExpParam", 1, &nParam);
	m_Experience = nParam;

	g_NpcSetting.GetInteger(nNpcTempRow, "LifeParam", 100, &nParam);
	m_LifeMax = nParam;

	g_NpcSetting.GetInteger(nNpcTempRow, "LifeReplenish", 0, &nParam);
	m_LifeReplenish = nParam;

	g_NpcSetting.GetInteger(nNpcTempRow, "ARParam", 1, &nParam);	
	m_AttackRating = nParam;
	if (m_AttackRating == 0) 
		m_AttackRating = 100;

	g_NpcSetting.GetInteger(nNpcTempRow, "DefenseParam", 1, &nParam);
	m_Defend = nParam;

	g_NpcSetting.GetInteger(nNpcTempRow, "ExDefenseParam", 0, &nParam);
	m_ExDefend = nParam;

	g_NpcSetting.GetInteger(nNpcTempRow, "MinDamageParam", 1, &nParam);
	m_PhysicsDamage.nValue[0] = nParam;

	g_NpcSetting.GetInteger(nNpcTempRow, "MaxDamageParam", 1, &nParam);
	m_PhysicsDamage.nValue[2] = nParam;

	
	g_NpcSetting.GetInteger(nNpcTempRow, "RedLum", 0, &nParam);
	m_RedLum = nParam;
	
	g_NpcSetting.GetInteger(nNpcTempRow, "GreenLum", 0, &nParam);
	m_GreenLum = nParam;
	
	g_NpcSetting.GetInteger(nNpcTempRow, "BlueLum", 0, &nParam);
	m_BlueLum = nParam;

	g_NpcSetting.GetInteger(nNpcTempRow, "FireResist", 0, &nParam);
	m_FireResist = nParam;

	g_NpcSetting.GetInteger(nNpcTempRow, "ColdResist", 0, &nParam);
	m_ColdResist = nParam;

	g_NpcSetting.GetInteger(nNpcTempRow, "LightResist", 0, &nParam);
	m_LightResist = nParam;

	g_NpcSetting.GetInteger(nNpcTempRow, "EarthResist", 0, &nParam);
	m_EarthResist = nParam;

	g_NpcSetting.GetInteger(nNpcTempRow, "PoisonResist", 0, &nParam);
	m_PoisonResist = nParam;

	g_NpcSetting.GetInteger(nNpcTempRow, "PhysicsResist", 0, &nParam);
	m_PhysicsResist = nParam;
#endif
}
