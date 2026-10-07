//-----------------------------------------------------------------------
//	Sword3 KNpc.cpp
//-----------------------------------------------------------------------
#include "KCore.h"
#include "PhongThanPlayerProtocol.h"
#include "PhongThanWorldProtocol.h"
#include "PhongThanWorldRuntime.h"
#include "PhongThanGameplayProtocol.h"
//#include <crtdbg.h>
#include "KNpcAI.h"
#include "KSkills.h"
#include "KObj.h"
#include "KObjSet.h"
#include "KMath.h"
#include "KPlayer.h"
#include "KPlayerSet.h"
#include "KNpc.h"
#include "GameDataDef.h"
#include "KSubWorldSet.h"
#include "KRegion.h"
#include "KTaskFuns.h"
#include "KNpcTemplate.h"
#include "KNpcRes.h"
#include "KItemSet.h"
#include "KPhongThanAppearance.h"
#include "KTongData.h"
#include "KPlayerPK.h"
#ifdef _SERVER
//#include "KNetServer.h"
//#include "../MultiServer/Heaven/Interface/iServer.h"
#include "KPlayerSet.h"
#include "KSkillManager.h"
#else
#include "../../Headers/IClient.h"
#include "CoreShell.h"
#include "Scene/KScenePlaceC.h"
#include "KIme.h"
#include "../../Represent/iRepresent/iRepresentshell.h"
#include "ImgRef.h"
#include "Text.h"
#include "KOption.h"
#endif
#include "KNpcAttribModify.h"
#include "CoreUseNameDef.h"
#include "KSubWorld.h"
#include "Scene/ObstacleDef.h"
#include "KThiefSkill.h"
#ifdef _STANDALONE
#include "KThiefSkill.cpp"
#endif

#ifndef max
#define max(a,b)    (((a) > (b)) ? (a) : (b))
#endif

#define	ATTACKACTION_EFFECT_PERCENT		60	// �����ܶ�����ɰٷ�֮���ٲ����������???
#define	MIN_DOMELEE_RANGE				20
#define	MIN_BLURMOVE_SPEED				1
#define	ACCELERATION_OF_GRAVITY			10

#define		SHOW_CHAT_WIDTH				24
#define		SHOW_CHAT_COLOR				0xffffffff
//Son fix loi ket map
#define		defMAX_SHOW_BLOOD_TIME		200
//end code

#define		BLOOD_EVENTTIME				400
#define		BLOOD_MOVESPEED				1
//#define		BLOOD_EVENTTIME				160 //TamLTM Fix
//#define		BLOOD_MOVESPEED				3 //TamLTM Fix
#define		BLOOD_FONTSIZE				16

#define		SHOW_LIFE_WIDTH				40
#define		SHOW_LIFE_HEIGHT			3

#define		SHOW_SPACE_HEIGHT			5
//-----------------------------------------------------------------------
#ifdef _SERVER
// Region_S stores original NPC names as CP936/GBK. The VNG bitmap fonts in
// this runtime contain the single-byte Vietnamese page, so those GBK bytes
// cannot be drawn. Keep KNpc::Name unchanged for server script lookup and
// translate only the display name sent in s2c_syncnpc.
#include "PhongThanNpcDisplayNames.inl"
#include "PhongThanQuestDeathContext.inl"
static const char* GetNpcNetworkDisplayName(const char* pName)
{
	const char* restoredName = PhongThanRestoredNpcDisplayName(pName);
	if (restoredName) return restoredName;
	struct NPC_DISPLAY_NAME
	{
		const char* pSource;
		const char* pDisplay;
	};
	static const NPC_DISPLAY_NAME s_Names[] =
	{
		{ "<color=green>" "\xBD" "\xF0" "\xCF" "\xBC" "\xCA" "\xDE" "<color>", "<color=green>Kim Ha Thu<color>" },
		{ "<color=yellow>" "\xBE" "\xC5" "\xD3" "\xA4" "<color>", "<color=yellow>Cuu Anh<color>" },
		{ "\xB6" "\xFE" "\xC0" "\xC9" "\xC9" "\xF1", "Nhi Lang Than" },
		{ "\xD4" "\xC6" "\xCF" "\xF6" "\xC4" "\xEF" "\xC4" "\xEF", "Van Tieu Nuong Nuong" },
		{ "\xB2" "\xD6" "\xBF" "\xE2" "\xB9" "\xDC" "\xC0" "\xED" "\xD4" "\xB1" "\x09", "Quan Ly Kho" },
		{ "\xBA" "\xAF" "\xD6" "\xA5" "\xCF" "\xC9" "\xD7" "\xD3", "Ham Chi Tien Tu" },
		{ "\xD2" "\xBD" "\xC9" "\xFA", "Y Sinh" },
		{ "\xC4" "\xC4" "\xDF" "\xB8", "Na Tra" },
		{ "\xC9" "\xCC" "\xBE" "\xFC" "\xC6" "\xEF" "\xB1" "\xF8", "Ky Binh Nha Thuong" },
		{ "\xC9" "\xCC" "\xB3" "\xAF" "\xB8" "\xEA" "\xB1" "\xF8", "Qua Binh Nha Thuong" },
		{ "\xC9" "\xCC" "\xB3" "\xAF" "\xC6" "\xEF" "\xB1" "\xF8", "Ky Binh Trieu Thuong" },
		{ "\xCF" "\xC4" "\xB8" "\xFB" "\xCA" "\xAC", "Ha Canh Thi" },
		{ "\xCA" "\xD9" "\xD0" "\xC7", "Tho Tinh" },
		{ "\xB2" "\xCA" "\xD4" "\xC6" "\xCF" "\xC9" "\xD7" "\xD3", "Thai Van Tien Tu" },
		{ "\xCD" "\xC6" "\xB9" "\xE3" "\xD4" "\xB1", "Nguoi Quang Ba" },
		{ "\xBD" "\xCC" "\xCA" "\xA6", "Giao Su" },
		{ "\xD4" "\xC2" "\xC0" "\xCF", "Nguyet Lao" },
		{ "\xD4" "\xD3" "\xBB" "\xF5" "\xC9" "\xCC", "Tap Hoa Thuong" },
		{ "\xC7" "\xED" "\xCF" "\xF6" "\xC4" "\xEF" "\xC4" "\xEF", "Quynh Tieu Nuong Nuong" },
		{ "\xC9" "\xEA" "\xB9" "\xAB" "\xB1" "\xAA", "Than Cong Bao" },
		{ "\xB1" "\xCC" "\xCF" "\xF6" "\xC4" "\xEF" "\xC4" "\xEF", "Bich Tieu Nuong Nuong" },
		{ "\xC0" "\xF1" "\xB9" "\xD9", "Le Quan" },
		{ "\xC2" "\xBB" "\xD0" "\xC7", "Loc Tinh" },
		{ "\xB8" "\xA3" "\xD0" "\xC7", "Phuc Tinh" },
		{ "\xBA" "\xEC" "\xC9" "\xB7", "Hong Sat" },
		{ "\xC2" "\xCC" "\xC1" "\xD6" "\xBA" "\xC3" "\xBA" "\xBA", "Luc Lam Hao Han" },
		{ "\xB9" "\xC6" "\xB5" "\xF1", "Co Dieu" },
		{ "\xCE" "\xF7" "\xCD" "\xF5" "\xC4" "\xB8", "Tay Vuong Mau" },
		{ "\xB3" "\xE0" "\xCB" "\xC9" "\xD7" "\xD3", "Xich Tung Tu" },
		{ "\xD5" "\xD4" "\xB9" "\xAB" "\xC3" "\xF7", "Trieu Cong Minh" },
		{ "\xB5" "\xCB" "\xBE" "\xC5" "\xB9" "\xAB", "Dang Cuu Cong" },
		{ "\xB5" "\xCB" "\xE6" "\xBF" "\xD3" "\xF1", "Dang Thien Ngoc" },
		{ "\xCD" "\xAD" "\xBD" "\xB3", "Tho Dong" },
		{ "\xD5" "\xF2" "\xD4" "\xAA" "\xB4" "\xF3" "\xCF" "\xC9", "Tran Nguyen Dai Tien" },
		{ "\xEF" "\xDA" "\xCA" "\xA6", "Tieu Su" },
		{ "\xCE" "\xC5" "\xCC" "\xAB" "\xCA" "\xA6", "Van Thai Su" },
		{ "\xC0" "\xD7" "\xD5" "\xF0" "\xD7" "\xD3", "Loi Chan Tu" },
		{ "\xB9" "\xED" "\xD4" "\xA6", "Quy Ngu" },
		{ "\xBA" "\xDA" "\xC9" "\xB7" "\xB7" "\xE4", "Hac Sat Phong" },
		{ "\xC1" "\xFA" "\xBC" "\xAA" "\xB9" "\xAB" "\xD6" "\xF7", "Long Cat Cong Chua" }
	};

	if (!pName)
		return "";
	for (int i = 0; i < (int)(sizeof(s_Names) / sizeof(s_Names[0])); ++i)
	{
		if (strcmp(pName, s_Names[i].pSource) == 0)
			return s_Names[i].pDisplay;
	}
	return pName;
}
#endif
#define	STAMINA_RECOVER_SCALE	4
// ����Ŀ��ߣ����ӵ�λ�???
#define	REGIONWIDTH			SubWorld[m_SubWorldIndex].m_nRegionWidth
#define	REGIONHEIGHT		SubWorld[m_SubWorldIndex].m_nRegionHeight
// ���ӵĿ��ߣ����ص�λ���Ŵ���1024����
#define	CELLWIDTH			(SubWorld[m_SubWorldIndex].m_nCellWidth << 10)
#define	CELLHEIGHT			(SubWorld[m_SubWorldIndex].m_nCellHeight << 10)
// ��ǰ����
#define	CURREGION			SubWorld[m_SubWorldIndex].m_Region[m_RegionIndex]
// ������������???
#define	LEFTREGIONIDX		CURREGION.m_nConnectRegion[2]
#define	RIGHTREGIONIDX		CURREGION.m_nConnectRegion[6]
#define	UPREGIONIDX			CURREGION.m_nConnectRegion[4]
#define	DOWNREGIONIDX		CURREGION.m_nConnectRegion[0]
#define	LEFTUPREGIONIDX		CURREGION.m_nConnectRegion[3]
#define	LEFTDOWNREGIONIDX	CURREGION.m_nConnectRegion[1]
#define	RIGHTUPREGIONIDX	CURREGION.m_nConnectRegion[5]
#define	RIGHTDOWNREGIONIDX	CURREGION.m_nConnectRegion[7]

#define	LEFTREGION			SubWorld[m_SubWorldIndex].m_Region[LEFTREGIONIDX]
#define	RIGHTREGION			SubWorld[m_SubWorldIndex].m_Region[RIGHTREGIONIDX]
#define	UPREGION			SubWorld[m_SubWorldIndex].m_Region[UPREGIONIDX]
#define	DOWNREGION			SubWorld[m_SubWorldIndex].m_Region[DOWNREGIONIDX]
#define	LEFTUPREGION		SubWorld[m_SubWorldIndex].m_Region[LEFTUPREGIONIDX]
#define	LEFTDOWNREGION		SubWorld[m_SubWorldIndex].m_Region[LEFTDOWNREGIONIDX]
#define	RIGHTUPREGION		SubWorld[m_SubWorldIndex].m_Region[RIGHTUPREGIONIDX]
#define	RIGHTDOWNREGION		SubWorld[m_SubWorldIndex].m_Region[RIGHTDOWNREGIONIDX]

#define	CONREGION(x)		SubWorld[m_SubWorldIndex].m_Region[CURREGION.m_nConnectRegion[x]]
#define	CONREGIONIDX(x)		CURREGION.m_nConnectRegion[x]
// ��ǰ����
#define BROADCAST_REGION(pBuff,uSize,uMaxCount)	 if(m_SubWorldIndex >= 0 && m_SubWorldIndex < MAX_SUBWORLD && SubWorld[m_SubWorldIndex].m_SubWorldID != -1) SubWorld[m_SubWorldIndex].BroadCastRegion((pBuff), (uSize), (uMaxCount), m_RegionIndex, m_MapX, m_MapY);
//-----------------------------------------------------------------------
// Npc[0]������Ϸ������ʹ�ã���Ϊһ��NpcSet���������µ�NPC��
KNpc	Npc[MAX_NPC];


KNpcTemplate	* g_pNpcTemplate[MAX_NPCSTYLE]; //0,0Ϊ��???
//-----------------------------------------------------------------------

#ifdef _SERVER
static BOOL NpcScriptDefinesFunction(DWORD dwScriptID, const char* pszFunction)
{
	KLuaScript* pScript = (KLuaScript*)g_GetScript(dwScriptID);
	int nTopIndex;
	BOOL bResult;

	if (!pScript || !pszFunction || !pszFunction[0])
		return FALSE;
	nTopIndex = Lua_GetTopIndex(pScript->m_LuaState);
	Lua_GetGlobal(pScript->m_LuaState, pszFunction);
	bResult = lua_type(pScript->m_LuaState,
		Lua_GetTopIndex(pScript->m_LuaState)) == LUA_TFUNCTION;
	Lua_SetTopIndex(pScript->m_LuaState, nTopIndex);
	return bResult;
}

static int GetNpcLevelFallback(const char* pszParam, int nLevel)
{
	int nBase = 0;
	int nSlope = 0;
	const char* pszSeparator;

	if (!pszParam || !pszParam[0])
		return 0;
	nBase = atoi(pszParam);
	pszSeparator = strchr(pszParam, '|');
	if (pszSeparator)
		nSlope = atoi(pszSeparator + 1);
	return nBase + nSlope * nLevel;
}

static BOOL CallNpcLevelNumber(KLuaScript* pScript, const char* pszFunction,
	int nLevel, const char* pszStyle, int nParam1, int nParam2, int nParam3,
	int* pnResult)
{
	int nSafeIndex = 0;
	BOOL bResult = FALSE;

	if (!pScript || !pszFunction || !pszStyle || !pnResult)
		return FALSE;
	pScript->SafeCallBegin(&nSafeIndex);
	if (pScript->CallFunction((char*)pszFunction, 1, "dsddd", nLevel,
		(char*)pszStyle, nParam1, nParam2, nParam3) &&
		Lua_IsNumber(pScript->m_LuaState,
			Lua_GetTopIndex(pScript->m_LuaState)) == 1)
	{
		*pnResult = (int)Lua_ValueToNumber(pScript->m_LuaState,
			Lua_GetTopIndex(pScript->m_LuaState));
		bResult = TRUE;
	}
	pScript->SafeCallEnd(nSafeIndex);
	return bResult;
}

static BOOL CallNpcLevelString(KLuaScript* pScript, int nLevel,
	const char* pszStyle, const char* pszParam, int* pnResult)
{
	int nSafeIndex = 0;
	BOOL bResult = FALSE;

	if (!pScript || !pszStyle || !pszParam || !pnResult)
		return FALSE;
	pScript->SafeCallBegin(&nSafeIndex);
	if (pScript->CallFunction("GetNpcLevelData", 1, "dss", nLevel,
		(char*)pszStyle, (char*)pszParam) &&
		Lua_IsNumber(pScript->m_LuaState,
			Lua_GetTopIndex(pScript->m_LuaState)) == 1)
	{
		*pnResult = (int)Lua_ValueToNumber(pScript->m_LuaState,
			Lua_GetTopIndex(pScript->m_LuaState));
		bResult = TRUE;
	}
	pScript->SafeCallEnd(nSafeIndex);
	return bResult;
}

static int GetNpcKeyData(KLuaScript* pScript, int nRow, int nLevel,
	const char* pszStyle, const char* pszColumn)
{
	char szColumn[64];
	int nScale = 100;
	int nParam1 = 0;
	int nParam2 = 0;
	int nParam3 = 0;
	int nValue;

	g_NpcSetting.GetInteger(nRow, (char*)pszColumn, 100, &nScale);
	sprintf(szColumn, "%s1", pszColumn);
	g_NpcSetting.GetInteger(nRow, szColumn, 0, &nParam1);
	sprintf(szColumn, "%s2", pszColumn);
	g_NpcSetting.GetInteger(nRow, szColumn, 0, &nParam2);
	sprintf(szColumn, "%s3", pszColumn);
	g_NpcSetting.GetInteger(nRow, szColumn, 0, &nParam3);

	nValue = nParam1 + nParam2 * nLevel;
	CallNpcLevelNumber(pScript, "GetNpcKeyData", nLevel, pszStyle,
		nParam1, nParam2, nParam3, &nValue);
	return nValue * nScale / 100;
}

static int ResolveNpcSkillId(int nRow, const char* pszSkillColumn)
{
	char szSkillName[128];
	int nSkillRow;
	int nSkillId = 0;

	szSkillName[0] = 0;
	g_NpcSetting.GetString(nRow, (char*)pszSkillColumn, "", szSkillName,
		sizeof(szSkillName));
	if (!szSkillName[0] || strcmp(szSkillName, "0") == 0)
		return 0;
	if ((szSkillName[0] >= '0' && szSkillName[0] <= '9') ||
		szSkillName[0] == '-')
		return atoi(szSkillName);

	nSkillRow = g_OrdinSkillsSetting.FindRow(szSkillName);
	if (nSkillRow > 1)
		g_OrdinSkillsSetting.GetInteger(nSkillRow, "SkillId", 0, &nSkillId);
	return nSkillId;
}

static void ApplyPhongThanNpcLevelData(KNpc* pNpc, KNpcTemplate* pTemplate)
{
	KLuaScript* pScript;
	int nRow;
	int i;

	if (!pNpc || !pTemplate)
		return;
	nRow = pNpc->m_NpcSettingIdx + 2;
	pScript = (KLuaScript*)g_GetScript(pTemplate->m_LevelScriptID);
	if (pTemplate->m_LevelScriptID && !pScript)
		g_DebugLog("[NpcRegistry] missing LevelScript template=%d script=%s",
			pNpc->m_NpcSettingIdx, pTemplate->m_LevelScript);

	pNpc->m_Experience = GetNpcKeyData(pScript, nRow, pNpc->m_Level,
		"Exp", "ExpParam");
	pNpc->m_LifeMax = GetNpcKeyData(pScript, nRow, pNpc->m_Level,
		"Life", "LifeParam");
	pNpc->m_AttackRating = GetNpcKeyData(pScript, nRow, pNpc->m_Level,
		"AR", "ARParam");
	pNpc->m_Defend = GetNpcKeyData(pScript, nRow, pNpc->m_Level,
		"Defense", "DefenseParam");
	pNpc->m_ExDefend = GetNpcKeyData(pScript, nRow, pNpc->m_Level,
		"ExDefense", "ExDefenseParam");
	pNpc->m_PhysicsDamage.nValue[0] = GetNpcKeyData(pScript, nRow,
		pNpc->m_Level, "MinDamage", "MinDamageParam");
	pNpc->m_PhysicsDamage.nValue[2] = GetNpcKeyData(pScript, nRow,
		pNpc->m_Level, "MaxDamage", "MaxDamageParam");

	pNpc->m_SkillList.Clear();
	for (i = 1; i <= MAX_NPC_USE_SKILL; ++i)
	{
		char szSkillColumn[16];
		char szLevelColumn[16];
		char szLevelParam[64];
		int nSkillId;
		int nSkillLevel;

		sprintf(szSkillColumn, "Skill%d", i);
		sprintf(szLevelColumn, "Level%d", i);
		nSkillId = ResolveNpcSkillId(nRow, szSkillColumn);
		szLevelParam[0] = 0;
		g_NpcSetting.GetString(nRow, szLevelColumn, "", szLevelParam,
			sizeof(szLevelParam));
		nSkillLevel = GetNpcLevelFallback(szLevelParam, pNpc->m_Level);
		CallNpcLevelString(pScript, pNpc->m_Level, szLevelColumn,
			szLevelParam, &nSkillLevel);
		if (nSkillId > 0 && nSkillLevel > 0)
			pNpc->m_SkillList.SetNpcSkill(i, nSkillId, nSkillLevel);
	}
}
#endif

KNpc::KNpc()
{
#ifdef _SERVER
	m_AiSkillRadiusLoadFlag = 0;	// ֻ��Ҫ�ڹ����ʱ���ʼ��һ��
#endif
	Init();
}

void KNpc::Init()
{
	memset(m_btStateInfo, 0, sizeof(m_btStateInfo));
	m_dwID = 0;
	m_Index = 0;
	m_nPlayerIdx = 0;
	m_ProcessAI = 1;
	m_Kind = kind_normal;
	m_Series = series_metal;
	m_btSpecial = npc_normal;
	m_Camp = camp_free;
	m_CurrentCamp = camp_free;
	m_Doing = do_stand;
	m_Height = 0;
	m_Frames.nCurrentFrame = 0;
	m_Frames.nTotalFrame = 0;
	m_SubWorldIndex = 0;
	m_RegionIndex = -1;
	m_Experience = 0;
	m_ActiveSkillID = 0;
	m_SkillParam1 = 0;
	m_SkillParam2 = 0;

	m_bNpcRemoveDeath = FALSE;
	m_nNpcTimeout = 0;
	m_dwNpcTimerDeadline = 0;
	m_nNpcTimerValue = 0;
	m_nDeathScriptPlayerIdx = 0;
	m_dwDeathScriptPlayerID = 0;
	ZeroMemory(m_nNpcParam, sizeof(m_nNpcParam));
	m_bNpcFollowFindPath = FALSE;
	m_uFindPathTime = 0;
	m_uFindPathMaxTime = 0;
	m_uLastFindPathTime = 0;

#ifndef _SERVER
	m_ClientDoing = cdo_stand;
	m_nChatContentLen = 0;
	m_nCurChatTime = 0;
	m_nChatNumLine = 0;
	m_nChatFontWidth = 0;
	m_nStature = 0;
	m_dwTongNameID = 0;
	ZeroMemory(m_szTongName,sizeof(m_szTongName));
	ZeroMemory(m_szTongAgname,sizeof(m_szTongAgname));
	m_nTongNationalEmblem = 0;
	m_nFigure = -1;
	m_nTeamServerID = -1;
	m_nCheckAutoMoveBarrier = 0; // TamLTM check auto move barrier
	m_nMoveToFlagMiniMapX = 0; // TamLTM check auto move barrier
	m_nMoveToFlagMiniMapY = 0; // TamLTM check auto move barrier
	memset(&m_sSyncPos, 0, sizeof(m_sSyncPos)); //giai phong

#endif

	m_CurrentLife = 100;			// Npc�ĵ�ǰ����
	m_CurrentLifeMax = 100;		// Npc�ĵ�ǰ�������??
	m_CurrentLifeReplenish = 0;	// Npc�ĵ�ǰ�����ظ��ٶ�
	m_CurrentLifeReplenishPercent = 0;
	m_CurrentMana = 100;			// Npc�ĵ�ǰ����
	m_CurrentManaMax = 100;		// Npc�ĵ�ǰ������???
	m_CurrentManaReplenish = 0;	// Npc�ĵ�ǰ�����ظ��ٶ�
	m_CurrentStamina = 100;		// Npc�ĵ�ǰ����
	m_CurrentStaminaMax = 100;	// Npc�ĵ�ǰ������???
	m_CurrentStaminaGain = 0;	// Npc�ĵ�ǰ�����ظ��ٶ�
	m_CurrentStaminaLoss = 0;	// Npc�ĵ�ǰ�����½��ٶ�
	m_CurrentAttackRating = 100;	// Npc�ĵ�ǰ������
	m_CurrentDefend = 10;		// Npc�ĵ�ǰ����
	m_CurrentWalkSpeed = 5;		// Npc�ĵ�ǰ�߶��ٶ�
	m_CurrentRunSpeed = 10;		// Npc�ĵ�ǰ�ܶ��ٶ�
	m_CurrentJumpSpeed = 12;	// Npc�ĵ�ǰ��Ծ�ٶ�
	m_CurrentJumpFrame = 40;	// Npc�ĵ�ǰ��Ծʱ��
	m_CurrentAttackSpeed = 0;	// Npc�ĵ�ǰ�����ٶ�
	m_CurrentCastSpeed = 0;		// Npc�ĵ�ǰʩ���ٶ�
	m_CurrentVisionRadius = 40;	// Npc�ĵ�ǰ��Ұ��Χ
	m_CurrentAttackRadius = 30;	// Npc�ĵ�ǰ������Χ
	m_CurrentHitRecover = 0;	// Npc�ĵ�ǰ�ܻ��ظ��ٶ�
	m_CurrentAddPhysicsDamage = 0;	// Npc�ĵ�ǰ�����˺�ֱ�Ӽӵĵ���
	m_CurrentAddPhysicsMagic = 0;
	m_CurrentExDefend = 0;
	m_CurrentIgnoreDefensePercent = 0;
	m_CurrentIgnoreExDefence = 0;
	m_CurrentIgnoreFireResist = 0;
	m_CurrentIgnoreColdResist = 0;
	m_CurrentIgnoreLightResist = 0;
	m_CurrentIgnoreEarthResist = 0;
	m_CurrentColdDamageMinPercent = 0;
	m_CurrentColdDamageMaxPercent = 0;
	m_CurrentAllMagicDeadlyStrike = 0;
	m_CurrentFireDeadlyStrike = 0;
	m_CurrentColdDeadlyStrike = 0;
	m_CurrentLightDeadlyStrike = 0;
	m_CurrentEarthDeadlyStrike = 0;
	m_CurrentReducePhysicsDeadlyStrike = 0;
	m_CurrentReduceMagicDeadlyStrike = 0;
	m_CurrentDamageReduce = 0;

	m_Dir = 0;					// Npc�ķ���
	m_JumpStep = 0;
	m_JumpDir = 0;
	m_MapZ = 0;					// Npc�ĸ߶�
	g_PhongThanAppearance.SetDefault(&m_Appearance);
	m_bRideHorse = FALSE;		// Npc�Ƿ�����
	m_dwNextSwitchHorseTime = 0;
	m_MaskType = 0;					// Npc ��߹��???
	m_bMaskFeature = FALSE;
	m_nPKFlag = enumPKNormal;
	m_nMissionGroup = -1;

	ZeroMemory(Name, sizeof(Name));		// Npc������
	ZeroMemory(Owner, sizeof(Owner));		// Npc������
	ZeroMemory(MateName, sizeof(MateName));		// Npc������

	m_NpcSettingIdx = 0;		// Npc���趨�ļ�����
	m_CorpseSettingIdx = 0;		// Body���趨�ļ�����
	ZeroMemory(ActionScript, sizeof(ActionScript));
	m_ActionScriptID = 0;
	m_DeathScriptID = 0;
	m_TimerScriptID = 0;
	m_LevelScriptID = 0;
	m_DropScriptID = 0;
	m_TrapScriptID = 0;

	m_RankID					= 0;
	m_ExpandRank.Release();
	m_CurExpandRank.Release();
	m_byTranslife				= 0;
	m_byViprank					= 0;
	m_nRepute					= 0;
	m_nFuYuan					= 0;
	m_nPKValue					= 0;
	m_ImagePlayer				= 0;
	m_byFortuneRankLevel		= 0;
	m_nProfession			= -1;

	m_LifeMax					= 100;		// Npc��������???
	m_LifeReplenish				= 0;		// Npc�������ظ��ٶ�
	m_ManaMax					= 100;		// Npc��������???
	m_ManaReplenish				= 0;		// Npc�������ظ��ٶ�
	m_StaminaMax				= 100;		// Npc��������???
	m_StaminaGain				= 0;		// Npc�������ظ��ٶ�
	m_StaminaLoss				= 0;		// Npc�������½��ٶ�
	m_AttackRating				= 100;		// Npc��������
	m_Defend					= 10;		// Npc�ķ���
	m_ExDefend					= 0;
	m_WalkSpeed					= 6;		// Npc�������ٶ�
	m_RunSpeed					= 10;		// Npc���ܶ��ٶ�
	m_JumpSpeed					= 12;		// Npc����Ծ�ٶ�
	m_AttackSpeed				= 0;		// Npc�Ĺ����ٶ�
	m_CastSpeed					= 0;		// Npc��ʩ���ٶ�
	m_VisionRadius				= 40;		// Npc����Ұ��Χ
	m_DialogRadius				= 124;		// Npc�ĶԻ���Χ
	m_HitRecover				= 12;		// Npc���ܻ��ظ��ٶ�
	m_nOwnerIdx				= 0;
	m_nPetIdx					= 0;
	m_nPeopleIdx				= 0;

	m_LoopFrames				= 0;
	m_WalkFrame					= 12;
	m_RunFrame					= 15;
	m_StandFrame				= 15;
	m_DeathFrame				= 15;
	m_HurtFrame					= 10;
	m_AttackFrame				= 20;
	m_CastFrame					= 20;
	m_SitFrame					= 15;
	m_JumpFrame					= 40;
	m_AIMAXTime					= 25;
	m_NextAITime				= 0;
	m_ProcessState				= 1;
	m_ReviveFrame				= 100;
	m_bExchangeServer			= FALSE;
	m_bActivateFlag				= FALSE;
	m_FightMode					= enumFightNone;
	m_OldFightMode				= enumFightNone;

	//TamLTM
	m_bActivateAutoMoveBarrier1 = FALSE;
	m_bActivateAutoMoveBarrier2 = FALSE;
	m_bActivateAutoMoveBarrier3 = FALSE;
	m_bActivateAutoMoveBarrier4 = FALSE;

	isCheckNotBarrierPlayer		= false;
	//end code

#ifdef _SERVER
	m_nCurPKPunishState			= 0;
	m_bReviveNow				= FALSE;
#else
	m_SyncSignal				= 0;
	m_sClientNpcID.m_dwRegionID	= 0;
	m_sClientNpcID.m_nNo		= -1;
	m_ResDir					= 0;
	m_nSleepFlag				= 0;

	m_btCurBlood = 0;
	memset(m_nBlood, 0, sizeof(m_nBlood));
	memset(m_szBlood, 0, sizeof(m_szBlood));

	m_nHurtHeight = 0;
	m_nHurtDesX = 0;
	m_nHurtDesY = 0;

	m_nPacePercent = 0;

	m_bTongFlag					= 0;
	m_MarkMask = 0;
	m_PTrade.Release();
#endif

	m_nLastPoisonDamageIdx = 0;
	m_nLastDamageIdx = 0;
	m_bHaveLoadedFromTemplate = FALSE;
	m_bClientOnly = FALSE;
}

ISkill* KNpc::GetActiveSkill()
{
	_ASSERT(m_ActiveSkillID < MAX_SKILL);
	if (m_SkillList.GetLevel(m_ActiveSkillID) > 0)
		return g_SkillManager.GetSkill(m_ActiveSkillID, m_SkillList.GetCurrentLevel(m_ActiveSkillID));
	else
		return NULL;
};

#ifdef _SERVER
void KNpc::SetTempCurrentCamp(int nCamp)
{
	if (Player[m_nPlayerIdx].m_cTeam.m_nFlag)
	{
		if (Player[m_nPlayerIdx].m_cTeam.m_nFigure == TEAM_CAPTAIN)
		{
			Npc[Player[m_nPlayerIdx].m_nIndex].ChangeCurrentCamp(nCamp);
			for (int i = 0; i < g_Team[Player[m_nPlayerIdx].m_cTeam.m_nID].m_nMemNum; i++)
			{
				if (g_Team[Player[m_nPlayerIdx].m_cTeam.m_nID].m_nMember[i] > 0)
					Npc[Player[g_Team[Player[m_nPlayerIdx].m_cTeam.m_nID].m_nMember[i]].m_nIndex].ChangeCurrentCamp(nCamp);
			}
		}
		else
			Npc[Player[m_nPlayerIdx].m_nIndex].ChangeCurrentCamp(
			Npc[Player[g_Team[Player[m_nPlayerIdx].m_cTeam.m_nID].m_nCaptain].m_nIndex].m_CurrentCamp);
	}
}
#endif

void KNpc::SetCurrentCamp(int nCamp)
{
	if (IsPlayer())
	{
#ifdef _SERVER
		if (Player[m_nPlayerIdx].m_bForbidCamp)
			return;
#endif
		if (Player[m_nPlayerIdx].m_cTeam.m_nFlag)
		{
#ifdef _SERVER
			SetTempCurrentCamp(nCamp);
#endif
			return;
		}
		else
			m_CurrentCamp = nCamp;
	}
	else
		m_CurrentCamp = nCamp;

#ifdef _SERVER
	POINT	POff[8] =
	{
		{0, 32},
		{-16, 32},
		{-16, 0},
		{-16, -32},
		{0, -32},
		{16, -32},
		{16, 0},
		{16, 32},
	};

	if (m_RegionIndex < 0)
		return;

	PHONGTHAN_ENTITY_STATUS	NetCommand;
	ZeroMemory(&NetCommand, sizeof(NetCommand));
	PhongThanInitializeWireHeader(&NetCommand.Header, PHONGTHAN_MSG_WORLD_ENTITY_STATUS, sizeof(NetCommand), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	NetCommand.MapId = SubWorld[m_SubWorldIndex].m_SubWorldID;
	NetCommand.Kind = PHONGTHAN_STATUS_CURRENT_CAMP;
	NetCommand.EntityId = m_dwID;
	NetCommand.Value = (BYTE)m_CurrentCamp;

	int	nMaxCount = MAX_BROADCAST_COUNT;
	CURREGION.BroadCast(&NetCommand, sizeof(NetCommand), nMaxCount, m_MapX, m_MapY);
	int i;
	for (i = 0; i < 8; i++)
	{
		if (CONREGIONIDX(i) == -1)
			continue;
		CONREGION(i).BroadCast(&NetCommand, sizeof(NetCommand), nMaxCount, m_MapX - POff[i].x, m_MapY - POff[i].y);
	}
#endif
}
//Thay doi bang phai
void KNpc::ChangeCurrentCamp(int nCamp)
{
	m_CurrentCamp = nCamp;

#ifdef _SERVER
	POINT	POff[8] =
	{
		{0, 32},
		{-16, 32},
		{-16, 0},
		{-16, -32},
		{0, -32},
		{16, -32},
		{16, 0},
		{16, 32},
	};

	if (m_RegionIndex < 0)
		return;

	PHONGTHAN_ENTITY_STATUS	NetCommand;
	ZeroMemory(&NetCommand, sizeof(NetCommand));
	PhongThanInitializeWireHeader(&NetCommand.Header, PHONGTHAN_MSG_WORLD_ENTITY_STATUS, sizeof(NetCommand), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	NetCommand.MapId = SubWorld[m_SubWorldIndex].m_SubWorldID;
	NetCommand.Kind = PHONGTHAN_STATUS_CURRENT_CAMP;
	NetCommand.EntityId = m_dwID;
	NetCommand.Value = (BYTE)m_CurrentCamp;

	int	nMaxCount = MAX_BROADCAST_COUNT;
	CURREGION.BroadCast(&NetCommand, sizeof(NetCommand), nMaxCount, m_MapX, m_MapY);
	int i;
	for (i = 0; i < 8; i++)
	{
		if (CONREGIONIDX(i) == -1)
			continue;
		CONREGION(i).BroadCast(&NetCommand, sizeof(NetCommand), nMaxCount, m_MapX - POff[i].x, m_MapY - POff[i].y);
	}
#endif
}

//Bang Phai
void KNpc::SetCamp(int nCamp)
{
	m_Camp = nCamp;
#ifdef _SERVER
	POINT	POff[8] =
	{
		{0, 32},
		{-16, 32},
		{-16, 0},
		{-16, -32},
		{0, -32},
		{16, -32},
		{16, 0},
		{16, 32},
	};
	if (m_RegionIndex < 0)
		return;

	PHONGTHAN_ENTITY_STATUS	NetCommand;

	ZeroMemory(&NetCommand, sizeof(NetCommand));
	PhongThanInitializeWireHeader(&NetCommand.Header, PHONGTHAN_MSG_WORLD_ENTITY_STATUS, sizeof(NetCommand), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	NetCommand.MapId = SubWorld[m_SubWorldIndex].m_SubWorldID;
	NetCommand.Kind = PHONGTHAN_STATUS_BASE_CAMP;
	NetCommand.EntityId = m_dwID;
	NetCommand.Value = (BYTE)m_Camp;

	int nMaxCount = MAX_BROADCAST_COUNT;
	CURREGION.BroadCast(&NetCommand, sizeof(NetCommand), nMaxCount, m_MapX, m_MapY);
	int i;
	for (i = 0; i < 8; i++)
	{
		if (CONREGIONIDX(i) == -1)
			continue;
		CONREGION(i).BroadCast(&NetCommand, sizeof(NetCommand), nMaxCount, m_MapX - POff[i].x, m_MapY - POff[i].y);
	}
#endif
}

void KNpc::RestoreCurrentCamp()
{
#ifdef _SERVER
	if (IsPlayer() && Player[m_nPlayerIdx].m_bForbidCamp)
		return;
#endif
	m_CurrentCamp = m_Camp;
#ifdef _SERVER
	POINT	POff[8] =
	{
		{0, 32},
		{-16, 32},
		{-16, 0},
		{-16, -32},
		{0, -32},
		{16, -32},
		{16, 0},
		{16, 32},
	};
	if (m_RegionIndex < 0)
		return;

	PHONGTHAN_ENTITY_STATUS	NetCommand;

	ZeroMemory(&NetCommand, sizeof(NetCommand));
	PhongThanInitializeWireHeader(&NetCommand.Header, PHONGTHAN_MSG_WORLD_ENTITY_STATUS, sizeof(NetCommand), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	NetCommand.MapId = SubWorld[m_SubWorldIndex].m_SubWorldID;
	NetCommand.Kind = PHONGTHAN_STATUS_CURRENT_CAMP;
	NetCommand.EntityId = m_dwID;
	NetCommand.Value = (BYTE)m_CurrentCamp;
	int nMaxCount = MAX_BROADCAST_COUNT;
	CURREGION.BroadCast(&NetCommand, sizeof(NetCommand), nMaxCount, m_MapX, m_MapY);
	int i;
	for (i = 0; i < 8; i++)
	{
		if (CONREGIONIDX(i) == -1)
			continue;
		CONREGION(i).BroadCast(&NetCommand, sizeof(NetCommand), nMaxCount, m_MapX - POff[i].x, m_MapY - POff[i].y);
	}
#endif
}

#define		NPC_SHOW_CHAT_TIME		15000

//TamLTM Check fix
int	timerCountAutoFixXY = 1;
//end code

int		IR_IsTimePassed(unsigned int uInterval, unsigned int& uLastTimer);

void KNpc::Activate()
{
	// ���������NPC
	if (!m_Index)
	{
		//g_DebugLog("[DEATH] No Index: %d", m_Index);
		return;
	}

	// �л���ͼ�У�������
	if (m_bExchangeServer)
	{
		//g_DebugLog("[DEATH] Change Server: %d", m_bExchangeServer);
		return;
	}
	// Check here
	if (m_bActivateFlag)
	{
		m_bActivateFlag = FALSE;	// restore flag
		return;
	}
//	m_bActivateFlag = TRUE;

	m_LoopFrames++;
	// Process npc special state, such as curse, etc.
	//g_DebugLog("[DEATH] m_ProcessState: %d", m_ProcessState);
#ifdef _SERVER
	// Refresh Region_S NPCs periodically so walking away and returning inside
	// the same map cannot leave the client with an empty static-NPC list.
	if (m_Kind == kind_player && m_nPlayerIdx > 0 &&
		m_SubWorldIndex >= 0 && m_SubWorldIndex < MAX_SUBWORLD &&
		m_RegionIndex >= 0 && !(m_LoopFrames % (GAME_UPDATE_TIME * 2)))
	{
		SubWorld[m_SubWorldIndex].SyncNpcNearPlayer(m_nPlayerIdx);
	}

	this->CheckTrap(m_MapX, m_MapY);

	if (m_nNpcTimeout && g_SubWorldSet.GetGameTime() >= m_nNpcTimeout)
	{
//	    g_DebugLog("den gio xoa");
		m_nNpcTimeout = 0;
		if (m_ActionScriptID)
		{
			NpcSet.ExecuteScript(m_Index, m_ActionScriptID, "Timeout", m_Index);
			//g_DebugLog("den gio xoa Timeout");
		}
	}

	if (m_dwNpcTimerDeadline &&
		g_SubWorldSet.GetGameTime() >= (int)m_dwNpcTimerDeadline)
	{
		DWORD dwTimerScriptID = m_TimerScriptID;
		m_dwNpcTimerDeadline = 0;
		if (dwTimerScriptID)
			NpcSet.ExecuteScript(m_Index, dwTimerScriptID, "OnTimer", m_Index);
		return;
	}

	this->m_cDeathCalcExp.Active();
	// Phong Than 2026-10-04 petdebug: TEMPORARY, trace an owned attacking pet whose AI is switched off or
	// whose special state runs instead of the AI.
	if (m_AiMode == 11 && m_nOwnerIdx > 0 && !m_ProcessAI)	// petdebug2
	{
		extern void PhongThanPetDebug(int, const char *, int, int, int, const int *, int, int);
		PhongThanPetDebug(m_Index, m_ProcessAI ? "state" : "noai", m_nOwnerIdx, 0, 0, NULL, m_ProcessState, m_ProcessAI);
	}
#endif

	if (m_ProcessState)
	{
		if (ProcessState())
		{
#ifdef _SERVER
			if (m_AiMode == 11 && m_nOwnerIdx > 0)	// petdebug2: special state ran instead of the AI
			{
				extern void PhongThanPetDebug(int, const char *, int, int, int, const int *, int, int);
				PhongThanPetDebug(m_Index, "state", m_nOwnerIdx, 0, 0, NULL, m_ProcessState, m_ProcessAI);
			}
#endif
			return;
		}
	}
	if (m_ProcessAI)
	{
		NpcAI.Activate(m_Index);
	}
	ProcCommand(m_ProcessAI);
	ProcStatus();

#ifndef _SERVER

	if (m_RegionIndex == -1)
		return;

	//TamLTM check timer auto fix xy
//	if (timerCountAutoFixXY)
//		timerCountAutoFixXY++;
//	if (timerCountAutoFixXY >= 20)
//	{
		AutoFixXY();
		HurtAutoMove();

//		if (timerCountAutoFixXY == 80)
//			timerCountAutoFixXY = 1;
//	}
	//end code

	int		nMpsX, nMpsY;

	if (m_MarkMask)
		GetNpcCopyFromTemplate(m_MaskType);


	BOOL bRenderRideHorse = m_bRideHorse && m_ClientDoing != cdo_jump;
	int nRenderDoing = m_ClientDoing;
	// VNG has no mounted-sit action. A stale sit packet/database state must
	// render as mounted stand instead of mixing sit body with horse rs0 parts.
	if (bRenderRideHorse && nRenderDoing == cdo_sit)
		nRenderDoing = cdo_stand;
	// Resolve ride state first so GetActNo selects rs/rr/ra/rb consistently
	// for every body, equipment and horse component in this same frame.
	m_DataRes.SetRideHorse(bRenderRideHorse);
	m_DataRes.SetAction(nRenderDoing);
	m_DataRes.SetArmor(m_Appearance.Armor);
	m_DataRes.SetHelm(m_Appearance.Helm);
	m_DataRes.SetPhiPhong(m_Appearance.PhiPhong);
	m_DataRes.SetHorse(m_Appearance.Horse);
	m_DataRes.SetWeapon(m_Appearance.Weapon);

	// �������ܲ�����״̬����Ч
	m_DataRes.SetState(m_btStateInfo, &g_NpcResList);

	if (Player[CLIENT_PLAYER_INDEX].m_nIndex == m_Index)
	{
		SubWorld[0].Map2Mps(m_RegionIndex, m_MapX, m_MapY, m_OffX, m_OffY, &nMpsX, &nMpsY);
		m_DataRes.SetPos(m_Index, nMpsX, nMpsY, m_Height, TRUE);
		//g_DebugLog("m_DataRes.SetPos(m_Index, nMpsX, nMpsY, m_Height, TRUE);");
	}
	else
	{
		SubWorld[0].Map2Mps(m_RegionIndex, m_MapX, m_MapY, m_OffX, m_OffY, &nMpsX, &nMpsY);
		m_DataRes.SetPos(m_Index, nMpsX, nMpsY, m_Height, FALSE);

		//TamLTM fix call fix xy npc
	//	AutoFixXY();
	//	HurtAutoMove();
		//end code

		//g_DebugLog("m_DataRes.SetPos(m_Index, nMpsX, nMpsY, m_Height, FALSE);");
	}

	// client npc ʱ������������������???
	if (m_Kind == kind_bird || m_Kind == kind_mouse)
		m_SyncSignal = SubWorld[0].m_dwCurrentTime;

	if (m_nChatContentLen > 0)
	{
		if (IR_GetCurrentTime() - m_nCurChatTime > NPC_SHOW_CHAT_TIME)
		{
			m_nChatContentLen = 0;
			m_nChatNumLine = 0;
			m_nChatFontWidth = 0;
			m_nCurChatTime = 0;
		}
	}

	if(IsPlayer())
	{
		if(m_PTrade.nTrade)
		{
			if(m_Doing != do_sit)
				SendClientCmdSit(true);
		}
	}
#endif
}

void KNpc::ProcStatus()
{
	//g_DebugLog("[DEATH] m_bExchangeServer: %d", m_bExchangeServer);
	if (m_bExchangeServer)
		return;

	switch(m_Doing)
	{
	case do_stand:
		OnStand();
		break;
	case do_run:
		OnRun();
		break;
	case do_walk:
		OnWalk();
		break;
	case do_attack:
	case do_magic:
		OnSkill();
		break;
	case do_sit:
		OnSit();
		break;
	case do_jump:
		OnJump();
		break;
	case do_hurt:
		OnHurt();
		break;
	case do_revive:
		OnRevive();
		break;
	case do_death:
		OnDeath();
		break;
	case do_defense:
		OnDefense();
		break;
	case do_special1:
		OnSpecial1();
		break;
	case do_special2:
		OnSpecial2();
		break;
	case do_special3:
		OnSpecial3();
		break;
	case do_blurmove:
		OnBlurMove();
		break;
	case do_manyattack:
		OnManyAttack();
		break;
	case do_runattack:
		OnRunAttack();
		break;
	//TamLTM fix auto xy map
	case do_goattack:
		OnGoAttack();
		break;
	//end code
	case do_jumpattack:
		OnJumpAttack();
		break;
	case do_idle:
		OnIdle();
	default:
		break;
	}

#ifndef _SERVER
	if (m_MaskType)
	{
		if(m_MarkMask)
		{
			if(m_MarkMask != m_MaskType)
			{
				ResetNpcTypeName(1);
				m_MarkMask = 0;
			}
		}
		else
		{
			ResetNpcTypeName(0);
			m_MarkMask = m_MaskType;
		}
	}
	else
	{
		if(m_MarkMask)
		{
			ResetNpcTypeName(1);
			m_MarkMask = 0;
		}
	}
#endif
}
#ifndef _SERVER
void	KNpc::RunWalkStopCmd()  // loi phu ve ko tu di chuyen
{
	int nMovePox_X, nMovePox_Y; //#dung lai
	GetMpsPos(&nMovePox_X,&nMovePox_Y);
	SendCommand(do_run, nMovePox_X,nMovePox_Y);
	SendClientCmdRun(nMovePox_X,nMovePox_Y);
}
#endif

// Phong Than 2026-10-04 daosi:Q1 one-slot skill order buffer for player NPCs (server and client).
// A do_skill order that arrives while the player is still in a cast / attack / hurt animation
// (m_ProcessAI == 0) used to be thrown away at the end of ProcCommand, so alternating skills needed a
// second click timed after the animation, and the server dropped a client order that arrived one frame
// before its own copy of the animation ended. Now the order waits up to PTSQ_KEEP_FRAMES and starts as
// soon as the animation ends. Animation length (CastSpeed / AttackSpeed) and the per-skill TimePerCast
// cooldown are unchanged: DoSkill re-checks CanCast, cost and range when the order runs.
#define PTSQ_KEEP_FRAMES	24
static NPC_COMMAND	s_PTSQCmd[MAX_NPC];
static int			s_PTSQAt[MAX_NPC];
static DWORD		s_PTSQNpcID[MAX_NPC];
static DWORD		s_PTSQTargetID[MAX_NPC];

static BOOL PTSQ_IsBusy(int nDoing)
{
	return nDoing == do_magic || nDoing == do_attack || nDoing == do_special1 || nDoing == do_hurt;
}

void KNpc::ProcCommand(int nAI)
{
	if (m_Kind == kind_player && m_Index > 0 && m_Index < MAX_NPC)	// daosi:Q1
	{
		NPC_COMMAND &rQ = s_PTSQCmd[m_Index];
		if (!nAI && m_Command.CmdKind == do_skill && PTSQ_IsBusy(m_Doing))
		{
			rQ = m_Command;
			s_PTSQAt[m_Index] = m_LoopFrames;
			s_PTSQNpcID[m_Index] = m_dwID;
			s_PTSQTargetID[m_Index] = (rQ.Param_Y == -1 && rQ.Param_Z > 0 && rQ.Param_Z < MAX_NPC) ? Npc[rQ.Param_Z].m_dwID : 0;
			m_Command.CmdKind = do_none;
			return;
		}
		if (!nAI && (m_Command.CmdKind == do_walk || m_Command.CmdKind == do_run || m_Command.CmdKind == do_jump ||
			m_Command.CmdKind == do_stand || m_Command.CmdKind == do_sit))
			rQ.CmdKind = do_none;	// a newer move order cancels the buffered skill
		if (nAI && rQ.CmdKind == do_skill)
		{
			BOOL bFresh = s_PTSQNpcID[m_Index] == m_dwID && m_LoopFrames - s_PTSQAt[m_Index] <= PTSQ_KEEP_FRAMES;
			if (bFresh && rQ.Param_Y == -1)
				bFresh = rQ.Param_Z > 0 && rQ.Param_Z < MAX_NPC && Npc[rQ.Param_Z].m_dwID != 0 &&
					Npc[rQ.Param_Z].m_dwID == s_PTSQTargetID[m_Index];
			if (bFresh && m_Command.CmdKind == do_none)
				m_Command = rQ;
			rQ.CmdKind = do_none;
		}
	}
	// CmdKind < 0 ʾûָ	ͼҲ
	if (m_Command.CmdKind == do_none || m_bExchangeServer)
		return;

	if (nAI)
	{
		if (m_RegionIndex < 0)
			return;
		switch (m_Command.CmdKind)
		{
		case do_stand:
			DoStand();
			break;
		case do_walk:
			Goto(m_Command.Param_X, m_Command.Param_Y);
			break;
		case do_run:
			RunTo(m_Command.Param_X, m_Command.Param_Y);
			break;
		case do_jump:
			JumpTo(m_Command.Param_X, m_Command.Param_Y);
			break;
		case do_skill:
			if (int nSkillIdx = m_SkillList.FindSame(m_Command.Param_X))
			{
				SetActiveSkill(nSkillIdx);
				DoSkill(m_Command.Param_Y, m_Command.Param_Z);
			}
			else
			{
				DoStand();
			}
			break;
		case do_sit:
			DoSit();
			break;
		case do_defense:
			DoDefense();
			break;
		case do_idle:
			DoIdle();
			break;
		case do_hurt:
			DoHurt(m_Command.Param_X, m_Command.Param_Y, m_Command.Param_Z);
			break;
			// ��Ϊ���ͼ�ܰ�ai��Ϊ1
		case do_revive:
			DoStand();
			m_ProcessAI = 1;
			m_ProcessState = 1;
#ifndef _SERVER
			this->SetInstantSpr(enumINSTANT_STATE_REVIVE);
#endif
			break;
		}
	}
	else
	{
		switch(m_Command.CmdKind)
		{
		case do_hurt:
			if (m_RegionIndex >= 0)
				DoHurt(m_Command.Param_X, m_Command.Param_Y, m_Command.Param_Z);
			break;
		case do_revive:
			DoStand();
			m_ProcessAI = 1;
			m_ProcessState = 1;
#ifndef _SERVER
			this->SetInstantSpr(enumINSTANT_STATE_REVIVE);
#endif
			break;
		//	break;
		case do_walk:
			if(m_RandMove.nTime > 0)
			Goto(m_Command.Param_X, m_Command.Param_Y);
			break;
		default:
			break;
		}
	}
	m_Command.CmdKind = do_none;
}

BOOL KNpc::ProcessState()
{
	int nRet = FALSE;
	if (m_RegionIndex < 0)
		return FALSE;

	if (!(m_LoopFrames % GAME_UPDATE_TIME))
	{
// �����������������仯ֻ�ɷ���������
#ifdef _SERVER
		// ������
		if (m_Doing == do_sit)
		{
			int nLifeAdd = m_CurrentLifeMax * 3 / 1000;
			if (nLifeAdd <= 0)
				nLifeAdd = 1;
			m_CurrentLife += nLifeAdd;
			if (m_CurrentLife > m_CurrentLifeMax)
				m_CurrentLife = m_CurrentLifeMax;

			int nManaAdd = m_CurrentManaMax * 3 / 1000;
			if (nManaAdd <= 0)
				nManaAdd = 1;
			m_CurrentMana += nManaAdd;
			if (m_CurrentMana > m_CurrentManaMax)
				m_CurrentMana = m_CurrentManaMax;

			m_CurrentStamina += PlayerSet.m_cPlayerStamina.m_nSitAdd;
			if (m_CurrentStamina > m_CurrentStaminaMax)
				m_CurrentStamina = m_CurrentStaminaMax;
		}
		// ������Ȼ�ظ�
		if (m_StunState.nTime <= 0)
		{
			m_CurrentLife += m_CurrentLifeReplenish + (m_CurrentLifeReplenish * m_CurrentLifeReplenishPercent / MAX_PERCENT);
			if (m_CurrentLife > m_CurrentLifeMax)
				m_CurrentLife = m_CurrentLifeMax;
			// ������Ȼ�ظ�
			m_CurrentMana += m_CurrentManaReplenish;
			if (m_CurrentMana > m_CurrentManaMax)
				m_CurrentMana = m_CurrentManaMax;

			// ������Ȼ�ظ�
			if (m_Doing == do_stand)
			{
				m_CurrentStamina += m_CurrentStaminaGain;
			}
			else
			{
				if (m_nPKFlag < enumPKMurder)
					m_CurrentStamina += m_CurrentStaminaGain / STAMINA_RECOVER_SCALE;
			}
			if (m_CurrentStamina > m_CurrentStaminaMax)
				m_CurrentStamina = m_CurrentStaminaMax;
		}
#endif
		// �⻷����

		if (m_ActiveAuraID)
		{
			if (m_SkillList.GetLevel(m_ActiveAuraID) > 0)
			{
				int nCurLevel = m_SkillList.GetCurrentLevel(m_ActiveAuraID);

				int nMpsX, nMpsY;
				SubWorld[m_SubWorldIndex].Map2Mps(m_RegionIndex, m_MapX, m_MapY, m_OffX, m_OffY, &nMpsX, &nMpsY);

			//	if (m_ActiveAuraID < MAX_SKILL && nCurLevel < MAX_SKILLLEVEL) //TamLTM fix

				KSkill * pOrdinSkill = (KSkill *) g_SkillManager.GetSkill(m_ActiveAuraID, nCurLevel);
#ifdef _SERVER
PHONGTHAN_SKILL_CAST SkillCmd;
				ZeroMemory(&SkillCmd, sizeof(SkillCmd));
				PhongThanInitializeWireHeader(&SkillCmd.Header, PHONGTHAN_MSG_GAMEPLAY_SKILL_CAST,
					sizeof(SkillCmd), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
				SkillCmd.MapId = SubWorld[m_SubWorldIndex].m_SubWorldID;
				SkillCmd.EntityId = this->m_dwID;
				if (pOrdinSkill)
				{
			//		if (pOrdinSkill->GetSkillStyle() == SKILL_SS_Missles)
					SkillCmd.SkillId = pOrdinSkill->GetChildSkillId();
				}
				else
				{
					SkillCmd.SkillId = 0;
				}

				SkillCmd.SkillLevel = nCurLevel;
				SkillCmd.TargetKind = PHONGTHAN_SKILL_TARGET_ENTITY;
				SkillCmd.TargetId = m_dwID;
				SkillCmd.DirectEffect = 1;
				POINT	POff[8] =
				{
					{0, 32},
					{-16, 32},
					{-16, 0},
					{-16, -32},
					{0, -32},
					{16, -32},
					{16, 0},
					{16, 32},
				};

				int nMaxCount = MAX_BROADCAST_COUNT;
				CURREGION.BroadCast(&SkillCmd, sizeof(SkillCmd), nMaxCount, m_MapX, m_MapY);
				int i;
				for (i = 0; i < 8; i++)
				{
					if (CONREGIONIDX(i) == -1)
						continue;
					CONREGION(i).BroadCast(&SkillCmd, sizeof(SkillCmd), nMaxCount, m_MapX - POff[i].x, m_MapY - POff[i].y);
				}
#endif
				//TamLTM Fix cu~
			/*	KSkill * pOrdinSkill2 = (KSkill *) g_SkillManager.GetSkill(nAppendId, nAppendLv);
				int nChildSkillId = 0;
				if (pOrdinSkill2)
				{
					nChildSkillId = pOrdinSkill2->GetChildSkillId();

					KSkill * pOrdinSkill3 = (KSkill *) g_SkillManager.GetSkill(nChildSkillId, nAppendLv);
					if (pOrdinSkill3)
					{
						pOrdinSkill3->Cast(m_Index, nMpsX, nMpsY);
					}
				}*/
				KSkill* pOrdinSkill1 = (KSkill*)g_SkillManager.GetSkill(m_ActiveAuraID, nCurLevel);
				int nChildSkillId = 0;
				if (pOrdinSkill1)
				{
					nChildSkillId = pOrdinSkill1->GetChildSkillId();

					KSkill* pOrdinSkill2 = (KSkill*)g_SkillManager.GetSkill(nChildSkillId, nCurLevel);
					if (pOrdinSkill2)
					{
						pOrdinSkill2->Cast(m_Index, nMpsX, nMpsY);
					}
				}
			}
		}
		//TamLTM Fix active aura id new.
		if (m_ActiveAuraID)
		{
			if (m_SkillList.GetLevel(m_ActiveAuraID) > 0)
			{
				int nCurLevel = m_SkillList.GetCurrentLevel(m_ActiveAuraID);

				int nMpsX, nMpsY;
				SubWorld[m_SubWorldIndex].Map2Mps(m_RegionIndex, m_MapX, m_MapY, m_OffX, m_OffY, &nMpsX, &nMpsY);

				//TamLTM Add Check skill cua nhan vat .
				KSkill* pOrdinSkill1 = (KSkill*)g_SkillManager.GetSkill(m_ActiveAuraID, nCurLevel);
				int nChildSkillId = 0;
				if (pOrdinSkill1)
				{
					nChildSkillId = pOrdinSkill1->GetChildSkillId();

					KSkill* pOrdinSkill2 = (KSkill*)g_SkillManager.GetSkill(nChildSkillId, nCurLevel);
					if (pOrdinSkill2)
					{
						pOrdinSkill2->Cast(m_Index, nMpsX, nMpsY);
					}
				}
				if (pOrdinSkill1->GetAppendSkillNum())
				{
					for (int j = 0; j < pOrdinSkill1->GetAppendSkillNum(); j++)
					{
						int nAppendId = pOrdinSkill1->GetAppendSkillId(j);
						int nAppendLv = m_SkillList.GetCurrentLevel(nAppendId);
						if (nAppendLv > nCurLevel)
							nAppendLv = nCurLevel;

						if (nAppendId < MAX_SKILL && nAppendLv > 0 && nAppendLv < MAX_SKILLLEVEL)
						{
#ifdef _SERVER
PHONGTHAN_SKILL_CAST SkillCmd;
				ZeroMemory(&SkillCmd, sizeof(SkillCmd));
				PhongThanInitializeWireHeader(&SkillCmd.Header, PHONGTHAN_MSG_GAMEPLAY_SKILL_CAST,
					sizeof(SkillCmd), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
				SkillCmd.MapId = SubWorld[m_SubWorldIndex].m_SubWorldID;
							SkillCmd.EntityId = this->m_dwID;
							KSkill* pOrdinSkill1 = (KSkill*)g_SkillManager.GetSkill(nAppendId, nAppendLv);
							if (pOrdinSkill1)
							{
								SkillCmd.SkillId = pOrdinSkill1->GetChildSkillId();
							}
							else
							{
								SkillCmd.SkillId = 0;
							}
							SkillCmd.SkillLevel = nAppendLv;
							SkillCmd.TargetKind = PHONGTHAN_SKILL_TARGET_ENTITY;
							SkillCmd.TargetId = m_dwID;
							SkillCmd.DirectEffect = 1;

							POINT	POff[8] =
							{
								{0, 32},
								{-16, 32},
								{-16, 0},
								{-16, -32},
								{0, -32},
								{16, -32},
								{16, 0},
								{16, 32},
							};

							int nMaxCount = MAX_BROADCAST_COUNT;
							CURREGION.BroadCast(&SkillCmd, sizeof(SkillCmd), nMaxCount, m_MapX, m_MapY);
							int i;
							for (i = 0; i < 8; i++)
							{
								if (CONREGIONIDX(i) == -1)
									continue;
								CONREGION(i).BroadCast(&SkillCmd, sizeof(SkillCmd), nMaxCount, m_MapX - POff[i].x, m_MapY - POff[i].y);
							}
#endif					}

						KSkill* pOrdinSkill2 = (KSkill*)g_SkillManager.GetSkill(nAppendId, nAppendLv);
						int nChildSkillId = 0;

						if (pOrdinSkill2)
						{
							nChildSkillId = pOrdinSkill2->GetChildSkillId();

							KSkill* pOrdinSkill3 = (KSkill*)g_SkillManager.GetSkill(nChildSkillId, nAppendLv);
							if (pOrdinSkill3)
							{
								pOrdinSkill3->Cast(m_Index, nMpsX, nMpsY);
							}
						}
					}
				}
			}
			//End code
		}
	}
}

#ifdef _SERVER
	if (m_PoisonState.nTime > 0)
	{
		m_PoisonState.nTime--;
		if (m_PoisonState.nValue[1] == 0)
		{
			m_PoisonState.nValue[1] = 1;
		}
		if (!(m_PoisonState.nTime % m_PoisonState.nValue[1]))
		{
			CalcDamage(m_nLastPoisonDamageIdx, -1, m_PoisonState.nValue[0], m_PoisonState.nValue[0], damage_poison, FALSE, 0, TRUE);
		}
		if(m_PoisonState.nTime == 0)
		{
			m_PoisonState.nValue[0] = 0;
			m_PoisonState.nValue[1] = 0;
			m_PoisonState.nValue[2] = 0;
		}
	}
	// ����״̬
	if (m_FreezeState.nTime > 0)
	{
		m_FreezeState.nTime--;
		if (m_FreezeState.nTime & 1)
		{
			nRet = TRUE;
		}
	}
	// ȼ��״̬
	if (m_BurnState.nTime > 0)
	{
		m_BurnState.nTime--;
		if (m_BurnState.nValue[1] == 0)
		{
			m_BurnState.nValue[1] = 1;
		}
		if (!(m_BurnState.nTime % m_BurnState.nValue[1]))
		{
			CalcDamage(m_Index, -1, m_BurnState.nValue[0], m_BurnState.nValue[0], damage_fire, TRUE, 0);
		}
	}

	if (m_FrozenAction.nTime > 0)
	{
		m_FrozenAction.nTime--;
	}
	// ����״̬
	if (m_RandMove.nTime > 0)
	{
		m_ProcessAI	= 0;
		if (!(g_SubWorldSet.GetGameTime() % GAME_UPDATE_TIME))
		{
			int nDesX, nDesY;
			GetMpsPos(&nDesX, &nDesY);
			int nRan = ::GetRandomNumber(0,1);
			if (nRan)
				nDesX -= g_Random(100);
			else
				nDesX += g_Random(100);

			nRan = ::GetRandomNumber(0,1);
			if (nRan)
				nDesY -= g_Random(100);
			else
				nDesY += g_Random(100);
			SendCommand(do_walk, nDesX, nDesY);
		}
		m_RandMove.nTime--;
		if(m_RandMove.nTime == 0)
		m_ProcessAI	= 1;
	}

	// ѣ��״̬
	if (m_StunState.nTime > 0)
	{
		m_StunState.nTime--;
		nRet = TRUE;
	}

	// ��Ѫ״̬
	if (m_LifeState.nTime > 0)
	{
		m_LifeState.nTime--;
		if (!(m_LifeState.nTime % GAME_UPDATE_TIME))
		{
			m_CurrentLife += m_LifeState.nValue[0];
			if (m_CurrentLife > m_CurrentLifeMax)
			{
				m_CurrentLife = m_CurrentLifeMax;
			}
		}
	}
	// ��MANA״̬
	if (m_ManaState.nTime > 0)
	{
		m_ManaState.nTime--;
		if (!(m_ManaState.nTime % GAME_UPDATE_TIME))
		{
			m_CurrentMana += m_ManaState.nValue[0];
			if (m_CurrentMana > m_CurrentManaMax)
			{
				m_CurrentMana = m_CurrentManaMax;
			}
		}
	}
	// ����״̬
	if (m_LoseMana.nTime > 0)
	{
		m_LoseMana.nTime--;
		if (!(m_LoseMana.nTime % GAME_FPS))
		{
			m_CurrentMana -= m_LoseMana.nValue[0];
			if (m_CurrentMana < 0)
				m_CurrentMana = 0;
		}
	}
	if (m_HideState.nTime > 0)
	{
		m_HideState.nTime --;
	}
	if (m_SilentState.nTime > 0)
	{
		m_SilentState.nTime --;
	}
	if (m_WalkRun.nTime > 0)
	{
		m_WalkRun.nTime --;
	}
#endif

#ifndef _SERVER
	bool bAdjustColorId = false;

	if (m_FreezeState.nTime > 0)
	{
		if (SubWorld[0].m_dwCurrentTime & 1)
			nRet = TRUE;
		m_DataRes.SetAdjustColorId(KNpcRes::adjustcolor_freeze);
		bAdjustColorId = true;
	}

	if(m_Index == Player[CLIENT_PLAYER_INDEX].m_nIndex)
	{
	if (m_RandMove.nTime > 0)
	{
		m_ProcessAI	= 0;
		if (!(g_SubWorldSet.GetGameTime() % GAME_UPDATE_TIME))
		{
			int nDesX, nDesY;
			GetMpsPos(&nDesX, &nDesY);
			int nRan = ::GetRandomNumber(0,1);
			if (nRan)
				nDesX -= g_Random(100);
			else
				nDesX += g_Random(100);

			nRan = ::GetRandomNumber(0,1);
			if (nRan)
				nDesY -= g_Random(100);
			else
				nDesY += g_Random(100);
			SendCommand(do_walk, nDesX, nDesY);
		}
		m_RandMove.nTime--;
		if(m_RandMove.nTime == 0)
		m_ProcessAI	= 1;
	}
	}
	if (m_StunState.nTime > 0)
	{
		m_DataRes.SetSpecialSpr("\\spr\\skill\\����\\mag_spe_ѣ��.spr");
		nRet = TRUE;
	}

	if (m_PoisonState.nTime > 0)
	{
		m_DataRes.SetAdjustColorId(KNpcRes::adjustcolor_poison);
		bAdjustColorId = true;
	}

	if (m_BurnState.nTime > 0)
	{
		m_DataRes.SetAdjustColorId(KNpcRes::adjustcolor_burn);
		bAdjustColorId = true;
	}

	if (!bAdjustColorId)
		m_DataRes.SetAdjustColorId(KNpcRes::adjustcolor_physics);
#endif

	KStateNode* pNode;
	pNode = (KStateNode *)m_StateSkillList.GetHead();
	while(pNode)
	{
		KStateNode* pTempNode = pNode;
		pNode = (KStateNode *)pNode->GetNext();

		if (pTempNode->m_LeftTime == -1)	// ��������
			continue;

		if (pTempNode->m_LeftTime == 0)
		{
			int i;
			for (i = 0; i < MAX_SKILL_STATE; i++)
			{
				if (pTempNode->m_State[i].nAttribType)
				{
					ModifyAttrib(m_Index, &pTempNode->m_State[i]);
				}
			}
			_ASSERT(pTempNode != NULL);
			pTempNode->Remove();
			delete pTempNode;

			pTempNode = NULL;

#ifdef _SERVER
			UpdateNpcStateInfo();

#endif
			continue;
		}
		else
			pTempNode->m_LeftTime --;
	}
	return nRet;

}

#ifdef _SERVER
int KNpc::UpdateDBStateList(
    PHONGTHAN_CHARACTER_SKILL_RECORD* pStateData)
{
    if (!pStateData)
        return -1;

    int nCount = 0;
    KStateNode* pNode = (KStateNode*)m_StateSkillList.GetHead();
    while (pNode)
    {
        KStateNode* pTempNode = pNode;
        pNode = (KStateNode*)pNode->GetNext();

        if (pTempNode->m_SkillID > 0 &&
            pTempNode->m_SkillID < MAX_SKILL &&
            pTempNode->m_Level > 0 &&
            pTempNode->m_Level < MAX_SKILLLEVEL &&
            pTempNode->m_bOverLook)
        {
            pStateData->SkillId = pTempNode->m_SkillID;
            pStateData->Level = pTempNode->m_Level;
            pStateData->Value = pTempNode->m_LeftTime;
            if (IS_TU_CHAN_SEAL_SKILL(pTempNode->m_SkillID) &&
                (pStateData->Value <= 0 ||
                 pStateData->Value > TU_CHAN_SEAL_DURATION_TICKS))
            {
                pStateData->Value = TU_CHAN_SEAL_DURATION_TICKS;
            }
            ++pStateData;
            ++nCount;
        }
    }
    return nCount;
}
#endif
//void KNpc::DoDeath(int nMode/* = 0*/) //Son fix exp party
void KNpc::DoDeath(int nMode,int nAttacker) //Son fix exp party
{
	_ASSERT(m_RegionIndex >= -1);
	if (m_RegionIndex < 0)
		return;

	if (m_Doing == do_death)
		return;

	if (IsPlayer() && !m_FightMode)	// �����ڲ�������
	{
		m_CurrentLife = 1;
		return;
	}

#ifndef _SERVER
	if (this->m_Kind == kind_normal)
		this->AddBlood(this->m_CurrentLife);
#endif
    m_Doing = do_death;
	m_ProcessAI	= 0;
	m_ProcessState = 0;

	m_Frames.nTotalFrame = m_DeathFrame;
	m_Frames.nCurrentFrame = 0;

	m_Height = 0;

#ifdef _SERVER
	int nPlayer = 0;
	//Son fix exp party
	if (this->m_Kind != kind_player && nAttacker > 0 && nAttacker < MAX_NPC)
	{
		nPlayer = m_cDeathCalcExp.CalcExp(nAttacker);
	}
	if (nPlayer <= 0 && nAttacker > 0 && nAttacker < MAX_NPC &&
		Npc[nAttacker].IsPlayer())
		nPlayer = Npc[nAttacker].GetPlayerIdx();
	m_nDeathScriptPlayerIdx = nPlayer;
	m_dwDeathScriptPlayerID = nPlayer>0 && nPlayer<MAX_PLAYER?Player[nPlayer].m_dwID:0;
	//end

	//����Ʒ
	DeathPunish(nMode, nPlayer);

	if (this->m_Kind == kind_normal)
	{
		if (m_DropScriptID && nPlayer)
			Player[nPlayer].ExecuteScript(m_DropScriptID, "DropRate", m_Index);

		if (m_ActionScriptID)
		{
			if (nPlayer)
				Player[nPlayer].ExecuteScript(m_ActionScriptID, "LastDamage", m_Index);
		}
	}

	if (IsPlayer())
	{
		if (m_nPlayerIdx > 0 && m_nPlayerIdx < MAX_PLAYER)
		{

			if (Player[m_nPlayerIdx].CanSave())
			{
				if (Player[m_nPlayerIdx].Save())
				{
					Player[m_nPlayerIdx].m_uMustSave = SAVE_REQUEST;
				}
			}
		}
	}
	if (this->m_Kind == kind_player)
	{
		if (Player[m_nPlayerIdx].m_dwDeathScriptId)
			Player[m_nPlayerIdx].ExecuteScript(Player[m_nPlayerIdx].m_dwDeathScriptId, "OnDeath", m_nLastDamageIdx);
	}

	PHONGTHAN_ENTITY_STATUS	NetCommand;
	ZeroMemory(&NetCommand, sizeof(NetCommand));
	PhongThanInitializeWireHeader(&NetCommand.Header, PHONGTHAN_MSG_WORLD_ENTITY_STATUS, sizeof(NetCommand), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	NetCommand.MapId = SubWorld[m_SubWorldIndex].m_SubWorldID;
	NetCommand.Kind = PHONGTHAN_STATUS_DEATH;
	NetCommand.EntityId = m_dwID;

	POINT	POff[8] =
	{
		{0, 32},
		{-16, 32},
		{-16, 0},
		{-16, -32},
		{0, -32},
		{16, -32},
		{16, 0},
		{16, 32},
	};

	int nMaxCount = MAX_BROADCAST_COUNT;
	CURREGION.BroadCast(&NetCommand, sizeof(NetCommand), nMaxCount, m_MapX, m_MapY);
	int i;
	for (i = 0; i < 8; i++)
	{
		if (CONREGIONIDX(i) == -1)
			continue;
		CONREGION(i).BroadCast(&NetCommand, sizeof(NetCommand), nMaxCount, m_MapX - POff[i].x, m_MapY - POff[i].y);
	}
#endif
#ifndef _SERVER
	m_ClientDoing = cdo_death;
	if (Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_nPeopleIdx == m_Index)
	{
		Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_nPeopleIdx = 0;
	}
#else
	if(this->m_Kind == kind_player)
	{
		if(Npc[Player[m_nPlayerIdx].m_nIndex].m_bReviveNow)
			return;

		SHOW_MSG_SYNC	sMsg;
		sMsg.ProtocolType = s2c_msgshow;
		if (m_nLastDamageIdx && Npc[m_nLastDamageIdx].m_Kind == kind_player)
		{
			sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1;
//			sMsg.m_lpBuf = (LPVOID)Npc[m_nLastDamageIdx].m_dwID; //TamLTM Fix loi PK Killer
			sMsg.m_wMsgID = enumMSG_ID_NPC_RENASCENCE_SOMEONE;
		}
		else
		{
			sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
			sMsg.m_wMsgID = enumMSG_ID_NPC_RENASCENCE;
		}
		g_pServer->PackDataToClient(Player[m_nPlayerIdx].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
	}
#endif
    //Son fix out pt
    if (IsPlayer())
    {
#ifdef _SERVER
        if (!Npc[nAttacker].IsPlayer())
{
	if (Player[m_nPlayerIdx].m_cTeam.m_nFlag && Player[m_nPlayerIdx].m_cTeam.m_nID >= 0)
	{
	PLAYER_APPLY_LEAVE_TEAM	sLeaveTeam;
	sLeaveTeam.ProtocolType = c2s_teamapplyleave;
	Player[m_nPlayerIdx].LeaveTeam((BYTE*)&sLeaveTeam);
	}
}
#endif
    }
    //end code
}

void KNpc::OnDeath()
{
    if (WaitForFrame()){
        m_Frames.nCurrentFrame = m_Frames.nTotalFrame - 1;		// ��֤�������ػص�һ֡����???
#ifndef _SERVER
        if (!IsPlayer()){
            int		nTempX, nTempY;
            KObjItemInfo	sInfo;

            SubWorld[m_SubWorldIndex].Map2Mps(m_RegionIndex, m_MapX, m_MapY, m_OffX, m_OffY, &nTempX, &nTempY);
            sInfo.m_nItemID = 0;
            sInfo.m_nItemWidth = 0;
            sInfo.m_nItemHeight = 0;
            sInfo.m_nMoneyNum = 0;
            sInfo.m_nColorID = 0;
            sInfo.m_nGenre = 0;
            sInfo.m_nDetailType = 0;
            sInfo.m_nMovieFlag = 0;
            sInfo.m_nSoundFlag = 0;
            sInfo.m_bOverLook = FALSE;
            sInfo.m_szName[0] = 0;
            ObjSet.ClientAdd(0, m_CorpseSettingIdx, 0, m_Dir, 0, nTempX, nTempY, sInfo);
            m_ProcessAI = 1;
        }
#endif
//Son fix out pt
#ifdef _SERVER
        if (IsPlayer() && Npc[m_nLastDamageIdx].IsPlayer())
        {
		char szMessageDeath[64];
		if (m_nPlayerIdx > 0)
        {
		sprintf(szMessageDeath,"B�n �� b?<color=yellow>%s<color> ��nh tr�ng th��ng !",Npc[m_nLastDamageIdx].Name);
		KPlayerChat::SendSystemInfo(1, m_nPlayerIdx, MESSAGE_SYSTEM_ANNOUCE_HEAD, szMessageDeath,strlen(szMessageDeath) );
					if (Player[m_nPlayerIdx].m_cTeam.m_nFlag && Player[m_nPlayerIdx].m_cTeam.m_nID >= 0)
					{
					PLAYER_APPLY_LEAVE_TEAM	sLeaveTeam;
					sLeaveTeam.ProtocolType = c2s_teamapplyleave;
					Player[m_nPlayerIdx].LeaveTeam((BYTE*)&sLeaveTeam);
					}
		}
		if (Npc[m_nLastDamageIdx].m_nPlayerIdx > 0)
		{
		sprintf(szMessageDeath,"B�n �� ��nh tr�ng th��ng <color=yellow>%s<color>",Name);
		KPlayerChat::SendSystemInfo(1, Npc[m_nLastDamageIdx].m_nPlayerIdx, MESSAGE_SYSTEM_ANNOUCE_HEAD, szMessageDeath, strlen(szMessageDeath) );
		}
		}
        //end code
#endif
        // ������
#ifdef _SERVER
		// Phong Than 2026-10-03 botparty:P3 an owned attacking pet (AiMode 11 with an owner: Di Nhan de tu,
		// summon-skill pet, to doi bot) has no revive / death-script path below, so it stayed as a corpse
		// forever (AI off, never removed). Remove it once the death animation is over, like
		// KNpcAI::ProcessAIType11 does when the owner leaves; clear the owner's pet slot if it points here.
		if (m_Kind != kind_player && m_AiMode == 11 && m_nOwnerIdx > 0)
		{
			if (m_nOwnerIdx < MAX_NPC && Npc[m_nOwnerIdx].m_nPetIdx == m_Index)
				Npc[m_nOwnerIdx].m_nPetIdx = 0;
			if (m_SubWorldIndex >= 0 && m_RegionIndex >= 0)
			{
				SubWorld[m_SubWorldIndex].m_Region[m_RegionIndex].RemoveNpc(m_Index);
				SubWorld[m_SubWorldIndex].m_Region[m_RegionIndex].DecRef(m_MapX, m_MapY, obj_npc);
			}
			NpcSet.Remove(m_Index);
			return;
		}
#endif
		if (m_Kind != kind_partner && m_AiMode != 11)//ս��Npcʱ
		{
#ifdef _SERVER
			if (!IsPlayer() && m_DeathScriptID)
			{
				DWORD dwDeathScriptID = m_DeathScriptID;
				int nDeathPlayer = m_nDeathScriptPlayerIdx;
				DWORD dwDeathPlayerID=m_dwDeathScriptPlayerID;
				DWORD dwDyingNpcID=m_dwID;
				m_nDeathScriptPlayerIdx = 0;
				m_dwDeathScriptPlayerID=0;
				PhongThanRunNpcDeathScript(m_Index,dwDeathScriptID,nDeathPlayer,dwDeathPlayerID);
				if(m_dwID==dwDyingNpcID && m_Index>0 && m_RegionIndex>=0 && m_Doing==do_death)
					DoRevive();
				return;
			}
			DoRevive();
			if (!IsPlayer() && m_ActionScriptID)
				NpcSet.ExecuteScript(m_Index, m_ActionScriptID, "DeathSelf", m_Index);
			else if(this->m_Kind == kind_player && Npc[Player[m_nPlayerIdx].m_nIndex].m_bReviveNow)
				Player[m_nPlayerIdx].Revive(REMOTE_REVIVE_TYPE);
#else
            DoRevive();
            // �ͻ��˰�NPCɾ��
            if (m_Kind != kind_player && m_AiMode != 11)
            {
                SubWorld[0].m_WorldMessage.Send(GWM_NPC_DEL, m_Index);
                return;
            }
#endif
        }
        else	// ͬ���ࣿ�Ժ���˵��
        {
            // �Ժ���˵Not Finish
        }
    }
    else
    {
    }
}

void KNpc::DoDefense()
{
	m_ProcessAI = 0;
}

void KNpc::OnDefense()
{
}

void KNpc::DoIdle()
{
	if (m_Doing == do_idle)
		return;
	m_Doing = do_idle;
}

void KNpc::OnIdle()
{
}

void KNpc::DoHurt(int nHurtFrames, int nX, int nY, int nHurtI)
{
	//_ASSERT(m_RegionIndex >= 0);
#ifndef _SERVER
	m_DataRes.SetBlur(FALSE);
#endif

	if (m_RegionIndex < 0)
		return;

	if ((m_Doing == do_hurt && nHurtI <= 100) || m_Doing == do_death || m_Doing == do_runattack || m_Doing == do_goattack)
		return;

	// �ܻ��ظ��ٶ��Ѿ��ﵽ100%�ˣ��������˶���
#ifdef _SERVER


int giam_tho_thuong = 0;
if (m_CurrentHitRecover <= 80)
{
giam_tho_thuong = (m_CurrentHitRecover/10) * 10;
}
else
{
giam_tho_thuong = 80;
}



if (!g_RandPercent(nHurtI/2+50-giam_tho_thuong/2))
{
return;
}



#endif
	m_Doing = do_hurt;
	m_ProcessAI	= 0;

#ifdef _SERVER
	m_Frames.nTotalFrame = 18 * m_HurtFrame * nHurtI *(100 - giam_tho_thuong)/ 100000;
#else





	m_ClientDoing = cdo_hurt;
	m_Frames.nTotalFrame = nHurtFrames;
	m_nHurtDesX = nX;
	m_nHurtDesY = nY;
	if (m_Height > 0)
	{
		// ��ʱ��¼������Ϊ�߶ȱ仯����OnHurt��ʹ��
		m_nHurtHeight = m_Height;
	}
	else
	{
		m_nHurtHeight = 0;
	}
#endif
	if (m_Frames.nTotalFrame == 0)
		m_Frames.nTotalFrame = 1;
	m_Frames.nCurrentFrame = 0;

#ifdef _SERVER	// ����Χ9��Region�㲥������
	PHONGTHAN_ENTITY_STATUS	NetCommand;
	ZeroMemory(&NetCommand, sizeof(NetCommand));
	PhongThanInitializeWireHeader(&NetCommand.Header, PHONGTHAN_MSG_WORLD_ENTITY_STATUS, sizeof(NetCommand), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	NetCommand.MapId = SubWorld[m_SubWorldIndex].m_SubWorldID;
	NetCommand.Kind = PHONGTHAN_STATUS_HURT;
	NetCommand.EntityId = m_dwID;
	NetCommand.Value = m_Frames.nTotalFrame;
	GetMpsPos(&NetCommand.X, &NetCommand.Y);

	POINT	POff[8] =
	{
		{0, 32},
		{-16, 32},
		{-16, 0},
		{-16, -32},
		{0, -32},
		{16, -32},
		{16, 0},
		{16, 32},
	};

	int nMaxCount = MAX_BROADCAST_COUNT;
	CURREGION.BroadCast(&NetCommand, sizeof(NetCommand), nMaxCount, m_MapX, m_MapY);
	int i;
	for (i = 0; i < 8; i++)
	{
		if (CONREGIONIDX(i) == -1)
			continue;
		CONREGION(i).BroadCast(&NetCommand, sizeof(NetCommand), nMaxCount, m_MapX - POff[i].x, m_MapY - POff[i].y);
	}
#endif
}

// Danh quai' mat % mau'
void KNpc::OnHurt()
{
	if (m_RegionIndex < 0)
	{
		g_DebugLog("[error]%s Region Index < 0 when hurt", Name);
		return;
	}
	int nX, nY;
	GetMpsPos(&nX, &nY);

#ifdef _SERVER
	m_Height = 0;
#endif


#ifndef _SERVER
	if(m_Frames.nTotalFrame > 0)
	{
		//TamLTM check delay neu truong hop player ben canh thoat bat ngo
		if (m_Doing == do_stand)
			return;
		//end code

		m_Height = m_nHurtHeight * (m_Frames.nTotalFrame - m_Frames.nCurrentFrame - 1) / m_Frames.nTotalFrame;
		nX = nX + (m_nHurtDesX - nX) * m_Frames.nCurrentFrame / m_Frames.nTotalFrame;
		nY = nY + (m_nHurtDesY - nY) * m_Frames.nCurrentFrame / m_Frames.nTotalFrame;

		int nOldRegion = m_RegionIndex;

	//	g_DebugLog("[DEATH]On Hurt nOldRegion");

		// fix
		//SubWorld[0].m_Region[m_RegionIndex].DecRef(m_MapX, m_MapY, obj_npc);
		CURREGION.DecRef(m_MapX, m_MapY, obj_npc); //TamTLM fix add them dong nay, vung hien tai cua map x y obj npc

		int nRegion, nMapX, nMapY, nOffX, nOffY;
		nRegion = -1;
		nMapX = nMapY = nOffX = nOffY = 0;
		SubWorld[m_SubWorldIndex].Mps2Map(nX, nY, &nRegion, &nMapX, &nMapY, &nOffX, &nOffY);
		if (nRegion == -1)
		{
			SubWorld[0].m_Region[nOldRegion].RemoveNpc(m_Index);
			m_dwRegionID = 0;
		}
		else if (nOldRegion != nRegion)
		{
			m_RegionIndex = nRegion;
			m_MapX = nMapX;
			m_MapY = nMapY;
			m_OffX = nOffX;
			m_OffY = nOffY;
			SubWorld[0].NpcChangeRegion(SubWorld[0].m_Region[nOldRegion].m_RegionID, SubWorld[0].m_Region[m_RegionIndex].m_RegionID, m_Index);
			m_dwRegionID = SubWorld[0].m_Region[m_RegionIndex].m_RegionID;
		}
		if (nRegion >= 0)
			CURREGION.AddRef(m_MapX, m_MapY, obj_npc);

		if (m_bClientOnly && m_RegionIndex >= 0 && nRegion >= 0) //TamTLM fix m_bClientOnly
		{
			SubWorld[0].m_Region[m_RegionIndex].DecRef(m_MapX, m_MapY, obj_npc);
			m_RegionIndex = nRegion;
			m_MapX = nMapX;
			m_MapY = nMapY;
			m_OffX = nOffX;
			m_OffY = nOffY;
			SubWorld[0].m_Region[m_RegionIndex].AddRef(m_MapX, m_MapY, obj_npc);
		}
	}
#endif
	if (WaitForFrame())
	{
	//	g_DebugLog("[DEATH]On Hurt Finished");
		DoStand();
		m_ProcessAI = 1;
	}
}

void KNpc::DoSpecial1()
{
	DoBlurAttack();
}

void KNpc::OnSpecial1()
{
	if (WaitForFrame() &&m_Frames.nTotalFrame != 0)
	{
#ifndef _SERVER
		m_DataRes.SetBlur(FALSE);
#endif
		DoStand();
		m_ProcessAI = 1;
	}
	else if (IsReachFrame(ATTACKACTION_EFFECT_PERCENT))
	{
		KSkill * pSkill = (KSkill*)GetActiveSkill();
		if (pSkill)
		{
			int nChildSkill = pSkill->GetChildSkillId();
			int nChildSkillLevel = pSkill->m_ulLevel;

			if (nChildSkill > 0)
			{
				KSkill * pChildSkill = (KSkill*)g_SkillManager.GetSkill(nChildSkill, nChildSkillLevel);
				if (pChildSkill)
				{
					pChildSkill->Cast(m_Index, m_SkillParam1, m_SkillParam2);
				}
			}
		}

		if (m_Frames.nTotalFrame <= 0)
		{
			m_ProcessAI = 1;
		}
	}
}

void KNpc::DoSpecial2()
{
}

void KNpc::OnSpecial2()
{
	if (WaitForFrame() &&m_Frames.nTotalFrame != 0)
	{
#ifndef _SERVER
		m_DataRes.SetBlur(FALSE);
#endif
		DoStand();
		m_ProcessAI = 1;
	}
	else if (IsReachFrame(ATTACKACTION_EFFECT_PERCENT))
	{
		ISkill * pSkill = GetActiveSkill();
		eSkillStyle eStyle = (eSkillStyle)pSkill->GetSkillStyle();
		switch(eStyle)
		{
		case SKILL_SS_Thief:
			{
				( (KThiefSkill*)pSkill )->OnSkill(this);
			}
			break;
		}

		if (m_Frames.nTotalFrame <= 0)
		{
			m_ProcessAI = 1;
		}
	}

}

void KNpc::DoSpecial3()
{
}

void KNpc::OnSpecial3()
{
}

// Nhan vat dang dung (Stop move)
void KNpc::DoStand()
{
//	if (m_Doing == do_run) //TamLTM fix
//		return;

	/*m_Frames.nTotalFrame = m_StandFrame;
	if (m_Doing == do_stand)
	{
		return; // Fix not return update pos player
	}
	else
	{
		m_Doing = do_stand;
		m_Frames.nCurrentFrame = 0;
		GetMpsPos(&m_DesX, &m_DesY);
#ifdef _SERVER
		//Get pos
		PHONGTHAN_ENTITY_POSITION  NetCommand;
		ZeroMemory(&NetCommand, sizeof(NetCommand));
	PhongThanInitializeWireHeader(&NetCommand.Header, PHONGTHAN_MSG_WORLD_ENTITY_POSITION, sizeof(NetCommand), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	NetCommand.MapId = SubWorld[m_SubWorldIndex].m_SubWorldID;
	NetCommand.Mode = PHONGTHAN_POSITION_STAND;
	NetCommand.Action = PhongThanEncodeEntityAction(m_Doing);
		NetCommand.EntityId = m_dwID;
		GetMpsPos(&NetCommand.X, &NetCommand.Y);

		//TamLTM Debug
	//	g_DebugLog("do_stand %d + %d", NetCommand.X, NetCommand.Y);

		POINT  POff[8] =
		{
		  {0, 32},
		  {-16, 32},
		  {-16, 0},
		  {-16, -32},
		  {0, -32},
		  {16, -32},
		  {16, 0},
		  {16, 32},
		};

		int nMaxCount = MAX_BROADCAST_COUNT;
		CURREGION.BroadCast(&NetCommand, sizeof(NetCommand), nMaxCount, m_MapX, m_MapY);
		int i;
		for (i = 0; i < 8; i++)
		{
		  if (CONREGIONIDX(i) == -1)
			continue;
		  CONREGION(i).BroadCast(&NetCommand, sizeof(NetCommand), nMaxCount, m_MapX - POff[i].x, m_MapY - POff[i].y);
		}
	#else
		if (m_FightMode)
		  m_ClientDoing = cdo_fightstand;
		else if (g_Random(6) != 1)
		  m_ClientDoing = cdo_stand;
		else
		  m_ClientDoing = cdo_stand1;

		m_DataRes.StopSound();
#endif
	} */

	//TamLTM Fix Goc ggg
	m_Frames.nTotalFrame = m_StandFrame;
	if (m_Doing == do_stand)
	{
#ifndef _SERVER
		// Repair a stale client-only sit animation even if gameplay state is
		// already stand (the old early return left cdo_sit active forever).
		if (m_ClientDoing == cdo_sit)
			m_ClientDoing = cdo_stand;
#endif
		return;
	}
	else
	{
		m_Doing = do_stand;
		m_Frames.nCurrentFrame = 0;
		GetMpsPos(&m_DesX, &m_DesY);
#ifndef _SERVER
		if (m_FightMode)
			m_ClientDoing = cdo_fightstand;
		else if (g_Random(6) != 1)
		{
			m_ClientDoing = cdo_stand;
		}
		else
		{
			m_ClientDoing = cdo_stand1;
		}
		//m_DataRes.SetBlur(FALSE);//son check code NPC
		m_DataRes.StopSound();
#endif
	}
	//end code goc */
}

void KNpc::OnStand()
{
	if (WaitForFrame())
	{
#ifndef _SERVER
		if (m_FightMode)
		{
			m_ClientDoing = cdo_fightstand;
		}
		else if (g_Random(6) != 1)
		{
			m_ClientDoing = cdo_stand;
		}
		else
		{
			m_ClientDoing = cdo_stand1;
		}
#endif
	}
}

// Hoi sinh monster
void KNpc::DoRevive()
{
	if (m_RegionIndex < 0)
	{
		g_DebugLog("[error]%s Region Index < 0 when dorevive", Name);
		return;
	}
#ifndef _SERVER
	m_DataRes.SetBlur(FALSE);
#endif
	if (m_Doing == do_revive)
	{
		return;
	}
	else
	{
		m_Doing = do_revive;
		m_ProcessAI = 0;
		m_ProcessState = 0;

		ClearStateSkillEffect();
		ClearNormalState();

#ifdef _SERVER
		if (IsPlayer() || m_AiMode == 11)
		{
			return;
		}
		m_Frames.nTotalFrame = m_ReviveFrame;
		SubWorld[m_SubWorldIndex].m_Region[m_RegionIndex].DecRef(m_MapX, m_MapY, obj_npc);
		SubWorld[m_SubWorldIndex].NpcChangeRegion(m_RegionIndex, VOID_REGION, m_Index);	// spe 03/06/28
		m_Frames.nCurrentFrame = 0;
#else
        /*/ ????? Son check code
        if (IsPlayer())
        {
            KSystemMessage Msg;

            Msg.byConfirmType = SMCT_UI_RENASCENCE;
            Msg.byParamSize = 0;
            Msg.byPriority = 255;
            Msg.eType = SMT_PLAYER;
            sprintf(Msg.szMessage, MSG_NPC_DEATH, Name);
            CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&Msg, NULL);
        }*/
		m_Frames.nTotalFrame = m_DeathFrame;
		m_ClientDoing = cdo_death;
#endif
	}
}

void KNpc::OnRevive()
{
#ifdef _SERVER
	if (!IsPlayer() && WaitForFrame())
	{
		Revive();
	}
#else	// �ͻ���
	m_Frames.nCurrentFrame = m_Frames.nTotalFrame - 1;
#endif
}

//TamLTM Player dang chay
void KNpc::DoRun()
{
//	if (m_Doing == do_skill) //TamLTM fix
//		return;

/*	POINT getPos;
	GetCursorPos(&getPos);
	m_nMovePosX = getPos.x;
	m_nMovePosY = getPos.y;
	g_DebugLog("DoRun: %d %d", getPos.x, getPos.y);*/

//	_ASSERT(m_RegionIndex >= 0);
    if (m_RegionIndex < 0)
	{
		return;
	}

	if (m_CurrentRunSpeed)
	{
		m_Frames.nTotalFrame = (m_RunFrame * m_RunSpeed) / m_CurrentRunSpeed;
	//	g_DebugLog("adasdasddddasasasas");
	}
	else
		m_Frames.nTotalFrame = m_RunFrame;

#ifndef _SERVER

	if (m_FightMode)
	{
		m_ClientDoing = cdo_fightrun;
	}
	else
	{
		m_ClientDoing = cdo_run;
	}

#endif

#ifdef _SERVER

	PHONGTHAN_ENTITY_MOVE NetCommand;
	ZeroMemory(&NetCommand, sizeof(NetCommand));
	PhongThanInitializeWireHeader(&NetCommand.Header, PHONGTHAN_MSG_WORLD_ENTITY_MOVE,
		sizeof(NetCommand), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	NetCommand.MapId = SubWorld[m_SubWorldIndex].m_SubWorldID;
	NetCommand.EntityId = m_dwID;
	NetCommand.Mode = PHONGTHAN_MOVE_RUN;
	NetCommand.X = m_DesX;
	NetCommand.Y = m_DesY;

//	g_DebugLog("do_run %d + %d", NetCommand.nMpsX, NetCommand.nMpsY);

	POINT	POff[8] =
	{
		{0, 32},
		{-16, 32},
		{-16, 0},
		{-16, -32},
		{0, -32},
		{16, -32},
		{16, 0},
		{16, 32},
	};

	int nMaxCount = MAX_BROADCAST_COUNT;
	CURREGION.BroadCast(&NetCommand, sizeof(NetCommand), nMaxCount, m_MapX, m_MapY);
	int i;
	for (i = 0; i < 8; i++)
	{
		if (CONREGIONIDX(i) == -1)
			continue;
		CONREGION(i).BroadCast(&NetCommand, sizeof(NetCommand), nMaxCount, m_MapX - POff[i].x, m_MapY - POff[i].y);
	}
#endif

	if (m_Doing == do_run)
	{
		return;
	}

	m_Doing = do_run;

	m_Frames.nCurrentFrame = 0;
}

void KNpc::OnRun(int nAddSpeed) //TamLTM add int nAddSpeed fix auto xy map
{
	if (m_Doing == do_hurt || m_Doing == do_death || m_Doing == do_revive)
		DoStand();
	WaitForFrame();

#ifndef _SERVER
	if (m_WalkRun.nTime)
		m_DataRes.SetBlur(TRUE);
#endif

#ifdef _SERVER
	if (!(m_LoopFrames % GAME_UPDATE_TIME))
	{
		if(Npc[Player[m_nPlayerIdx].m_nIndex].m_nCurPKPunishState == enumDEATH_MODE_TOURNAMENTS_PUNISH)
		{
		}
		else
		{
			switch (m_nPKFlag)
			{
				case enumPKMurder:
					m_CurrentStamina -= PlayerSet.m_cPlayerStamina.m_nKillRunSub;
				break;
				case enumPKTongWar:
					m_CurrentStamina -= PlayerSet.m_cPlayerStamina.m_nTongWarRunSub;
				break;
			}
		}
		if (m_CurrentStamina <= 0)
			m_CurrentStamina = 0;
	}
#endif
	if(m_Doing == do_runattack)
	{
		m_CurrentRunSpeed += 50;
		ServerMove(m_CurrentRunSpeed);
		m_CurrentRunSpeed -= 50;
	}
	else
	{
		ServerMove(m_CurrentRunSpeed);
	}
}

void KNpc::DoSit()
{
//	_ASSERT(m_RegionIndex >= 0);
	if (m_RegionIndex < 0)
	{
		return;
	}
	// Original VNG mounted tables intentionally have no sit mapping. Keep the
	// authoritative state valid instead of producing a detached sit sprite.
	if (m_bRideHorse)
	{
		DoStand();
		return;
	}

	if (m_Doing == do_sit)
		return;

	m_Doing = do_sit;

#ifdef _SERVER	// ����Χ9��Region�㲥������
	PHONGTHAN_ENTITY_STATUS	NetCommand;
	ZeroMemory(&NetCommand, sizeof(NetCommand));
	PhongThanInitializeWireHeader(&NetCommand.Header, PHONGTHAN_MSG_WORLD_ENTITY_STATUS, sizeof(NetCommand), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	NetCommand.MapId = SubWorld[m_SubWorldIndex].m_SubWorldID;
	NetCommand.Kind = PHONGTHAN_STATUS_SIT;
	NetCommand.EntityId = m_dwID;

	POINT	POff[8] =
	{
		{0, 32},
		{-16, 32},
		{-16, 0},
		{-16, -32},
		{0, -32},
		{16, -32},
		{16, 0},
		{16, 32},
	};

	int nMaxCount = MAX_BROADCAST_COUNT;
	CURREGION.BroadCast(&NetCommand, sizeof(NetCommand), nMaxCount, m_MapX, m_MapY);
	int i;
	for (i = 0; i < 8; i++)
	{
		if (CONREGIONIDX(i) == -1)
			continue;
		CONREGION(i).BroadCast(&NetCommand, sizeof(NetCommand), nMaxCount, m_MapX - POff[i].x, m_MapY - POff[i].y);
	}
#endif

#ifndef _SERVER
			m_ClientDoing = cdo_sit;
#endif


	m_Frames.nTotalFrame = m_SitFrame;
	m_Frames.nCurrentFrame = 0;

}

void KNpc::OnSit()
{
	// ������������û���趨��
	if (WaitForFrame())
	{
		m_Frames.nCurrentFrame = m_Frames.nTotalFrame - 1;
	}
}

void KNpc::DoSkill(int nX, int nY)
{
	//_ASSERT(m_RegionIndex >= 0);
    if (m_RegionIndex < 0)
	{
		return;
	}


	if (Player[m_nPlayerIdx].CheckTrading())
		return;
	if (m_Doing == do_skill)
		return;

	// ��ս��״̬���ܷ�����
	ISkill * pSkill = GetActiveSkill();
	
	if(pSkill)
	{
		eSkillStyle eStyle = (eSkillStyle)pSkill->GetSkillStyle();
		
if (IsPlayer())
	{
		if (!m_FightMode)
			return;
#ifdef _SERVER
		if (m_nPlayerIdx > 0)
			Player[m_nPlayerIdx].m_ItemList.Abrade(enumAbradeAttack);
#endif
	}


		if (m_SkillList.CanCast(m_ActiveSkillID, SubWorld[m_SubWorldIndex].m_dwCurrentTime))
		{
			switch (pSkill->CanCastSkill(m_Index, nX, nY))
			{
			case -1:
#ifdef _SERVER
				if(nX == -1)
				{
					int nDesX, nDesY;
					Npc[nY].GetMpsPos(&nDesX, &nDesY);
					SendCommand(do_run, nDesX, nDesY);
					return;
				}
#endif
				break;
			case 0:
				goto Exit;
				break;
			case 1:
				if( m_Kind != kind_player || Cost(pSkill->GetSkillCostType(), pSkill->GetSkillCost(this)))
				{
		/*------------------------------------------------------------------------------------
		������ʱ������ָ��Ŀ�����ʱ������Skill.Cast������������һ������Ϊ-1,�ڶ���ΪNpc index
		��S2Cʱ���ڶ�������������Server��NpcIndexתΪNpcdwID�γ�ȥ��
		��C�յ���ָ��ʱ����NpcdwIDתΪ������NpcIndex
			-------------------------------------------------------------------------------------*/
#ifdef _SERVER	// ����Χ9��Region�㲥������
PHONGTHAN_SKILL_CAST NetCommand;
					ZeroMemory(&NetCommand, sizeof(NetCommand));
					PhongThanInitializeWireHeader(&NetCommand.Header, PHONGTHAN_MSG_GAMEPLAY_SKILL_CAST,
						sizeof(NetCommand), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
					NetCommand.MapId = SubWorld[m_SubWorldIndex].m_SubWorldID;
					NetCommand.EntityId = m_dwID;
					NetCommand.SkillId = m_ActiveSkillID;
					NetCommand.SkillLevel = m_SkillList.GetCurrentLevel(m_ActiveSkillID);
					if (nX == -1)
					{
						if (nY <= 0 || nY >= MAX_NPC || !Npc[nY].m_dwID ||
							Npc[nY].m_SubWorldIndex != m_SubWorldIndex) return;
						NetCommand.TargetKind = PHONGTHAN_SKILL_TARGET_ENTITY;
						NetCommand.TargetId = Npc[nY].m_dwID;
					}
					else
					{
						if (!PhongThanWorldPositionValid(nX, nY)) return;
						NetCommand.TargetKind = PHONGTHAN_SKILL_TARGET_POSITION;
						NetCommand.X = nX;
						NetCommand.Y = nY;
					}


					m_SkillParam1 = nX;
					m_SkillParam2 = nY;
					m_DesX = nX;
					m_DesY = nY;

					POINT	POff[8] =
					{
						{0, 32},
						{-16, 32},
						{-16, 0},
						{-16, -32},
						{0, -32},
						{16, -32},
						{16, 0},
						{16, 32},
					};
					int nMaxCount = MAX_BROADCAST_COUNT;
					CURREGION.BroadCast(&NetCommand, sizeof(NetCommand), nMaxCount, m_MapX, m_MapY);
					int i;
					for (i = 0; i < 8; i++)
					{
						if (CONREGIONIDX(i) == -1)
							continue;
						CONREGION(i).BroadCast(&NetCommand, sizeof(NetCommand), nMaxCount, m_MapX - POff[i].x, m_MapY - POff[i].y);
					}
#endif
					if (eStyle == SKILL_SS_Missles
						|| eStyle == SKILL_SS_Melee
						|| eStyle == SKILL_SS_InitiativeNpcState
						|| eStyle == SKILL_SS_PassivityNpcState
						|| eStyle == SKILL_SS_CreateNpc
						|| eStyle == SKILL_SS_PhongThanAttack
						|| eStyle == SKILL_SS_PhongThanProduce
						|| eStyle == SKILL_SS_PhongThanAwaken)
					{
						DoOrdinSkill((KSkill *) pSkill, nX, nY);
					}
					else
					{
						switch(eStyle)
						{
						case SKILL_SS_Thief:
							{
								((KThiefSkill*)pSkill)->DoSkill(this, nX, nY);

							}break;
						default:
							return;
						}
					}
					if (m_HideState.nTime > 0 )
						m_HideState.nTime = 0;
					return;
				}
			}
		}
	}
	else
	{
		_ASSERT(pSkill);
		return;
	}
Exit:
	m_nPeopleIdx = 0;
	m_nObjectIdx = 0;
	DoStand();
}

int KNpc::DoOrdinSkill(KSkill * pSkill, int nX, int nY)
{
	_ASSERT(pSkill);

#ifndef _SERVER
	m_DataRes.StopSound();
	int x, y, tx, ty;
	SubWorld[m_SubWorldIndex].Map2Mps(m_RegionIndex, m_MapX, m_MapY, m_OffX, m_OffY, &x, &y);

	if (nY < 0)
		return 0;

	if (nX < 0)
	{
		if (nX != -1)
			return 0;

		if (nY >= MAX_NPC || Npc[nY].m_dwID == 0 || Npc[nY].m_SubWorldIndex != m_SubWorldIndex)
			return 0;
		Npc[nY].GetMpsPos(&tx, &ty);
	}
	else
	{
		tx = nX;
		ty = nY;
	}

	m_SkillParam1 = nX;
	m_SkillParam2 = nY;
	m_DesX = nX;
	m_DesY = nY;

	m_Dir = g_GetDirIndex(x, y, tx, ty);
	if (pSkill->GetPreCastEffectFile()[0])
		m_DataRes.SetSpecialSpr((char *)pSkill->GetPreCastEffectFile());

	if (IsPlayer())
		pSkill->PlayPreCastSound(m_nSex,x, y);

	if (pSkill->IsNeedShadow())
		m_DataRes.SetBlur(TRUE);
	else
		m_DataRes.SetBlur(FALSE);
#endif

	CLIENTACTION ClientDoing = pSkill->GetActionType();

#ifndef _SERVER
	if (ClientDoing >= cdo_count)
		m_ClientDoing = cdo_magic;
	else if (ClientDoing != cdo_none)
		m_ClientDoing = ClientDoing;
#endif
	if (pSkill->GetSkillStyle() == SKILL_SS_Melee)
	{
		if (CastMeleeSkill(pSkill) == FALSE)
		{
			m_nPeopleIdx = 0;
			m_nObjectIdx = 0;
			m_ProcessAI = 1;
			DoStand();

			return 1 ;
		}
		if(!pSkill->IsAura())
		{
			DWORD dwCastTime = 0;
			eSkillStyle eStyle = (eSkillStyle)pSkill->GetSkillStyle();
			if (eStyle == SKILL_SS_Missles
				|| eStyle == SKILL_SS_Melee
				|| eStyle == SKILL_SS_InitiativeNpcState
				|| eStyle == SKILL_SS_PassivityNpcState
				|| eStyle == SKILL_SS_CreateNpc
				|| eStyle == SKILL_SS_PhongThanAttack
				|| eStyle == SKILL_SS_PhongThanProduce
				|| eStyle == SKILL_SS_PhongThanAwaken)
			{
				dwCastTime = pSkill->GetDelayPerCast(m_bRideHorse);
			}
			else
			{
				switch(eStyle)
				{
				case SKILL_SS_Thief:
					{
						dwCastTime = ((KThiefSkill*)pSkill)->GetDelayPerCast();
					}break;
				}
			}
			m_SkillList.SetNextCastTime(m_ActiveSkillID, SubWorld[m_SubWorldIndex].m_dwCurrentTime, SubWorld[m_SubWorldIndex].m_dwCurrentTime + dwCastTime);
		}
	}
	//�������ܵļ����ͷ�ʱ������ͨ���ܲ�ͬ��һ����AttackFrame,һ����CastFrame
	else if (pSkill->IsPhysical())
	{
		if (ClientDoing == cdo_none)
			m_Frames.nTotalFrame = 0;
		else
		{
			//Code cu
			int nTotalFrame = m_AttackFrame * MAX_PERCENT / ((m_CurrentAttackSpeed + MAX_PERCENT) != 0 ? (m_CurrentAttackSpeed + MAX_PERCENT) : 1);	// cppbatch:G4
			m_Frames.nTotalFrame = nTotalFrame - nTotalFrame % 2;
			if (m_Frames.nTotalFrame <= 0)
				m_Frames.nTotalFrame = 1;
			//end

		/*	//TamLTM fix toc do danh 2 ben client
			//	m_Frames.nTotalFrame = m_CastFrame * 100 / (m_CurrentCastSpeed + 100); // toc do danh 2 ben client
			int SoDu = m_AttackFrame * MAX_PERCENT / (MAX_PERCENT + m_CurrentCastSpeed);
			if (SoDu % 2 == 1)
				m_Frames.nTotalFrame = m_CastFrame * MAX_PERCENT / (m_CurrentCastSpeed + MAX_PERCENT) + 1;
			//end code */
		}

#ifndef _SERVER
		if (g_Random(3))
			m_ClientDoing = cdo_attack;
		else
			m_ClientDoing = cdo_attack1;
#endif
		m_Doing = do_attack;
	}
	else
	{
		if (ClientDoing == cdo_none)
			m_Frames.nTotalFrame = 0;
		else
		{
			//Code cu
			int nTotalFrame = m_CastFrame * MAX_PERCENT / ((m_CurrentCastSpeed + MAX_PERCENT) != 0 ? (m_CurrentCastSpeed + MAX_PERCENT) : 1);	// cppbatch:G5
			m_Frames.nTotalFrame = nTotalFrame - nTotalFrame % 2;
			if (m_Frames.nTotalFrame <= 0)
				m_Frames.nTotalFrame = 1;
			//end

		/*	//TamLTM fix toc do danh 2 ben client
			//	m_Frames.nTotalFrame = m_CastFrame * 100 / (m_CurrentCastSpeed + 100); // toc do danh 2 ben client
			int SoDu = m_CastFrame * MAX_PERCENT / (MAX_PERCENT + m_CurrentCastSpeed);
			if (SoDu % 2 == 1)
				m_Frames.nTotalFrame = m_CastFrame * MAX_PERCENT / (m_CurrentCastSpeed + MAX_PERCENT) + 1;
			//end code */
		}
		m_Doing  = do_magic;
	}
	m_ProcessAI = 0;
	m_Frames.nCurrentFrame = 0;
	return 1;
}

BOOL	KNpc::CastMeleeSkill(KSkill * pSkill)
{
	BOOL bSuceess = FALSE;
	_ASSERT(pSkill);

	switch(pSkill->GetMeleeType())
	{
	case Melee_AttackWithBlur:
		{
			bSuceess = DoBlurAttack();
		}break;
	case Melee_Jump:
		{
			if (NewJump(m_DesX, m_DesY))
			{
				DoJump();
				bSuceess = TRUE;
			}

		}break;
	case Melee_JumpAndAttack:
		{
			if (m_DesX < 0 && m_DesY > 0)
			{
				int x, y;
				SubWorld[m_SubWorldIndex].Map2Mps
					(
					Npc[m_DesY].m_RegionIndex,
					Npc[m_DesY].m_MapX,
					Npc[m_DesY].m_MapY,
					Npc[m_DesY].m_OffX,
					Npc[m_DesY].m_OffY,
					&x,
					&y
					);

				m_DesX = x + 1;
				m_DesY = y;
			}

			if (NewJump(m_DesX, m_DesY))
			{
				DoJumpAttack();
				bSuceess = TRUE;
			}

		}break;
	case Melee_RunAndAttack:
		{
			bSuceess = DoRunAttack();

		}break;
	case Melee_ManyAttack:
		{
			bSuceess = DoManyAttack();
		}break;
	case Melee_MoveWithBlur:
		{
			m_SkillParam1 = pSkill->GetParam1();
			bSuceess = DoBlurMove();
		}break;
	//TamLTM fix auto xy map
	case Melee_Go:
		{
			bSuceess = DoGoAttack();
		}
		break;
	//end code
	default:
		m_ProcessAI = 1;
		break;
	}
	return bSuceess;

}

//TamLTM add fix auto xy map
void	KNpc::OnGoAttack()
{

	if (m_SpecialSkillStep == 0)
	{
		KSkill * pSkill = (KSkill*)GetActiveSkill();
		if (!pSkill)
            return ;


	OnRun(52);

        if (m_Doing == do_stand || (DWORD)m_nCurrentMeleeTime > pSkill->GetMissleGenerateTime(0))
		{
			m_SpecialSkillStep ++;
			m_nCurrentMeleeTime = 0;

			DoGoAttack();

		}
		else
			m_nCurrentMeleeTime ++;

		m_ProcessAI = 0;
	}
	else if (m_SpecialSkillStep == 1)
	{
			m_ProcessAI = 0;

			KSkill * pSkill = (KSkill*)GetActiveSkill();
			if (!pSkill)
                return ;

            int nCurPhySkillId = pSkill->GetChildSkillId();//GetCurActiveWeaponSkill();
			if (nCurPhySkillId > 0)
			{
				KSkill * pOrdinSkill = (KSkill *) g_SkillManager.GetSkill(nCurPhySkillId, pSkill->m_ulLevel, SKILL_SS_Missles);
				if (pOrdinSkill)
                {
				    pOrdinSkill->Cast(m_Index, m_SkillParam1, m_SkillParam2);
                }
			}
			DoStand();
			m_ProcessAI = 1;
			m_SpecialSkillStep = 0;

#ifndef _SERVER
		m_DataRes.SetBlur(FALSE);
#endif
	}
	else
	{
#ifndef _SERVER
		m_DataRes.SetBlur(FALSE);
#endif
		DoStand();
		m_ProcessAI = 1;
		m_SpecialSkillStep = 0;
	}
}

BOOL KNpc::DoGoAttack()
{

	m_ProcessAI = 0;

	switch(m_SpecialSkillStep)
	{
	case 0:
		m_Frames.nTotalFrame = 20;
		m_ProcessAI = 0;

#ifndef _SERVER
		m_DataRes.SetBlur(TRUE);

		if (m_FightMode)
		{
			m_ClientDoing = cdo_fightrun;
		}
		else
		{
			m_ClientDoing = cdo_run;
		}
#endif

		if (m_DesX < 0 && m_DesY > 0)
		{
			int x, y;
			SubWorld[m_SubWorldIndex].Map2Mps
				(
				Npc[m_DesY].m_RegionIndex,
				Npc[m_DesY].m_MapX,
				Npc[m_DesY].m_MapY,
				Npc[m_DesY].m_OffX,
				Npc[m_DesY].m_OffY,
				&x,
				&y
				);

		m_DesX = x;
		m_DesY = y;
		}

		m_Frames.nCurrentFrame = 0;
		m_Doing = do_goattack;
		break;

	case 1:
#ifndef _SERVER

		if (m_FightMode)
			m_ClientDoing = cdo_fightstand;
		else if (g_Random(6) != 1)
		{
			m_ClientDoing = cdo_stand;
		}
		else
		{
			m_ClientDoing = cdo_stand1;
		}

		int x, y, tx, ty;
		SubWorld[m_SubWorldIndex].Map2Mps(m_RegionIndex, m_MapX, m_MapY, m_OffX, m_OffY, &x, &y);
		if (m_SkillParam1 == -1)
		{
			Npc[m_SkillParam2].GetMpsPos(&tx, &ty);
		}
		else
		{
			tx = m_SkillParam1;
			ty = m_SkillParam2;
		}
		m_Dir = g_GetDirIndex(x, y, tx, ty);
#endif
		m_Frames.nTotalFrame = 0;
		m_Frames.nCurrentFrame = 0;
		m_Doing = do_goattack;
		break;

	case 2:
	case 3:
#ifndef _SERVER
		m_DataRes.SetBlur(FALSE);
#endif
		DoStand();
		m_ProcessAI = 1;
		m_SpecialSkillStep = 0;
		return FALSE;
		break;
	}

	m_Frames.nCurrentFrame = 0;

	return TRUE;
}
//end code

BOOL KNpc::DoBlurAttack()// DoSpecail1
{
	if (m_Doing == do_special1)
		return FALSE;

	KSkill * pSkill = (KSkill*) GetActiveSkill();
	if (!pSkill)
        return FALSE;

	_ASSERT(pSkill->GetSkillStyle() == SKILL_SS_Melee);

#ifndef _SERVER
		m_ClientDoing = pSkill->GetActionType();
		m_DataRes.SetBlur(TRUE);
#endif

	m_Frames.nTotalFrame = m_AttackFrame * MAX_PERCENT / ((m_CurrentAttackSpeed + MAX_PERCENT) != 0 ? (m_CurrentAttackSpeed + MAX_PERCENT) : 1);	// cppbatch:G6
	m_Frames.nCurrentFrame = 0;
	m_Doing = do_special1;
	return TRUE;
}

void KNpc::OnSkill()
{
	if (WaitForFrame() && m_Frames.nTotalFrame != 0)
	{
		DoStand();
		m_ProcessAI = 1;
	}
	else if (IsReachFrame(ATTACKACTION_EFFECT_PERCENT))
	{
		KSkill * pSkill = NULL;
#ifndef _SERVER
		m_DataRes.SetBlur(FALSE);
#endif

		if (m_DesX == -1)
		{
			if (m_DesY <= 0)
				goto Label_ProcessAI;

			//��ʱ�ý�ɫ�Ѿ���Чʱ
			if (Npc[m_DesY].m_RegionIndex < 0)
				goto Label_ProcessAI;
		}

		pSkill =(KSkill*) GetActiveSkill();

		if (pSkill)
		{
			pSkill->Cast(m_Index, m_DesX, m_DesY);

			DWORD dwCastTime = 0;
			eSkillStyle eStyle = (eSkillStyle)pSkill->GetSkillStyle();
			if (eStyle == SKILL_SS_Missles
				|| eStyle == SKILL_SS_Melee
				|| eStyle == SKILL_SS_InitiativeNpcState
				|| eStyle == SKILL_SS_PassivityNpcState
				|| eStyle == SKILL_SS_PhongThanAttack
				|| eStyle == SKILL_SS_PhongThanProduce
				|| eStyle == SKILL_SS_PhongThanAwaken)
			{
				dwCastTime = pSkill->GetDelayPerCast(m_bRideHorse);
			}
			else if (eStyle == SKILL_SS_Thief)
				dwCastTime = ((KThiefSkill*)pSkill)->GetDelayPerCast();

			m_SkillList.SetNextCastTime(m_ActiveSkillID, SubWorld[m_SubWorldIndex].m_dwCurrentTime, SubWorld[m_SubWorldIndex].m_dwCurrentTime + dwCastTime);
		}

Label_ProcessAI:
		if (m_Frames.nTotalFrame <= 0)
		{

			m_ProcessAI = 1;
		}
	}
}

void KNpc::JumpTo(int nMpsX, int nMpsY)
{
	if (NewJump(nMpsX, nMpsY))
		DoJump();
	else
	{
		RunTo(nMpsX, nMpsY);
	}
}

void KNpc::RunTo(int nMpsX, int nMpsY)
{
	if (NewPath(nMpsX, nMpsY))
		DoRun();
}

void KNpc::Goto(int nMpsX, int nMpsY)
{
	if (NewPath(nMpsX, nMpsY))
		DoWalk();
}

void KNpc::Madnessto(int nMpsX, int nMpsY)
{
Goto(nMpsX,nMpsY);
}


void KNpc::DoWalk()
{
	_ASSERT(m_RegionIndex >= 0);

	if (m_CurrentWalkSpeed)
		m_Frames.nTotalFrame = (m_WalkFrame * m_WalkSpeed) / m_CurrentWalkSpeed + 1;
	else
		m_Frames.nTotalFrame = m_WalkFrame;

#ifdef _SERVER		// Server�˵Ĵ���
	PHONGTHAN_ENTITY_MOVE NetCommand;
	ZeroMemory(&NetCommand, sizeof(NetCommand));
	PhongThanInitializeWireHeader(&NetCommand.Header, PHONGTHAN_MSG_WORLD_ENTITY_MOVE,
		sizeof(NetCommand), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	NetCommand.MapId = SubWorld[m_SubWorldIndex].m_SubWorldID;
	NetCommand.EntityId = m_dwID;
	NetCommand.Mode = PHONGTHAN_MOVE_WALK;
	NetCommand.X = m_DesX;
	NetCommand.Y = m_DesY;

	POINT	POff[8] =
	{
		{0, 32},
		{-16, 32},
		{-16, 0},
		{-16, -32},
		{0, -32},
		{16, -32},
		{16, 0},
		{16, 32},
	};
	int nMaxCount = MAX_BROADCAST_COUNT;
	CURREGION.BroadCast(&NetCommand, sizeof(NetCommand), nMaxCount, m_MapX, m_MapY);
	int i;
	for (i = 0; i < 8; i++)
	{
		if (CONREGIONIDX(i) == -1)
			continue;
		CONREGION(i).BroadCast(&NetCommand, sizeof(NetCommand), nMaxCount, m_MapX - POff[i].x, m_MapY - POff[i].y);
	}
#endif

	if (m_Doing == do_walk)
	{
		return;
	}
	m_Doing = do_walk;
	m_Frames.nCurrentFrame = 0;

#ifndef _SERVER
	if (m_FightMode)
	{
		m_ClientDoing = cdo_fightwalk;
		Goto(m_DesX, m_DesY); //TamLTM Fix update move client server toa do xy
	}
	else
	{
		m_ClientDoing = cdo_walk;
	}
#endif

}

void KNpc::OnWalk()
{
#ifndef	_SERVER
	if (m_WalkRun.nTime)
		m_DataRes.SetBlur(TRUE);
#endif
	WaitForFrame();
	ServerMove(m_CurrentWalkSpeed);
}

void KNpc::ModifyAttrib(int nAttacker, void* pData)
{
	if (pData != NULL)
	{
		g_NpcAttribModify.ModifyAttrib(this, pData);
	}
}

#ifdef _SERVER
BOOL KNpc::CalcDamage(int nAttacker, int nMissleSeries, int nMin, int nMax, DAMAGE_TYPE nType, BOOL bIsMelee, BOOL bReturn /* = FALSE */, int nFiveElements_DamageP /*0*/, int nStolen_Life/*0*/, int nStolen_Mana/*0*/, int nStolen_Stamina/*0*/, BOOL bIsDS /*= FALSE*/, BOOL bIsFS /*= FALSE*/)
{
	if (m_Doing == do_death || m_Doing == do_revive || m_RegionIndex < 0)
		return FALSE;

	if (nMin + nMax <= 0)
		return FALSE;

	int nDamage = 0, nCurDamage = 0;


//	g_DebugLog("m_Series %d - %d", m_Series, nMissleSeries);

	if (m_Series == series_minus)
	{
		nDamage = 1;
	}
	else
	{
		int	nRes = 0;
		int nDamageRange = nMax - nMin;

		if (nDamageRange < 0)
		{
			nDamage = nMax + g_Random(-nDamageRange);
		}
		else
		{
			nDamage = nMin + g_Random(nMax - nMin);
		}

		if (bIsDS)
		{
			nDamage = nDamage * MAX_DEATLY_STRIKE_ENHANCEP / MAX_PERCENT;
			int nFocusedReduce = (nType == damage_physics) ?
				m_CurrentReducePhysicsDeadlyStrike : m_CurrentReduceMagicDeadlyStrike;
			if (nFocusedReduce < 0)
				nFocusedReduce = 0;
			else if (nFocusedReduce > MAX_PERCENT)
				nFocusedReduce = MAX_PERCENT;
			nDamage = nDamage * (MAX_PERCENT - nFocusedReduce) / MAX_PERCENT;
		}

		if(bReturn)
		{
			if (bIsFS)
				nDamage = m_CurrentLife / MAX_PERCENT * GetRandomNumber(MIN_FATALLY_STRIKE_ENHANCEP, MAX_FATALLY_STRIKE_ENHANCEP);

			if(this->m_Kind == kind_normal)
			{
				if(this->m_btSpecial)
					nDamage = nDamage * NpcSet.m_nNpcSpecialDamageRate / MAX_PERCENT;
			}
		}
		else
		{
			if(m_Level >= LEVEL_EXPLOSIVE)
			{
				ReplySkill();

				if (m_CurrentLife < (m_CurrentLifeMax * LIFE_EXPLOSIVE / MAX_PERCENT))
					RescueSkill();
			}

			if(Npc[nAttacker].m_Level >= LEVEL_EXPLOSIVE)
				Npc[nAttacker].AttackSkill(m_Index);
		}

		int nFiveElement_total = 0;

		//Damage ki he
		if ((nMissleSeries == series_metal && m_Series == series_wood) ||
			(nMissleSeries == series_water && m_Series == series_fire) ||
			(nMissleSeries == series_wood && m_Series == series_earth) ||
			(nMissleSeries == series_fire && m_Series == series_metal) ||
			(nMissleSeries == series_earth && m_Series == series_water))
		{
			nFiveElement_total -= nFiveElements_DamageP;
			nDamage -= (Npc[nAttacker].m_CurrentFiveElementsEnhance - m_CurrentFiveElementsResist);
		}
		else if ((nMissleSeries == series_metal && m_Series == series_fire) ||
			(nMissleSeries == series_water && m_Series == series_earth) ||
			(nMissleSeries == series_wood && m_Series == series_metal) ||
			(nMissleSeries == series_fire && m_Series == series_water) ||
			(nMissleSeries == series_earth && m_Series == series_wood))
		{
			nFiveElement_total += nFiveElements_DamageP;
			nDamage -= (m_CurrentFiveElementsResist - Npc[nAttacker].m_CurrentFiveElementsEnhance);
		}



		//TamLTM check khang cu cua cac phai
		int AddMaxResistCs = 0;

		if (IsPlayer())
		{
		/*	if (m_Series == 0)
			{
				AddMaxResistCs += 1;
			}
			else if (m_Series == 1)
			{
				AddMaxResistCs += 2;
			}
			else if (m_Series == 2)
			{
				AddMaxResistCs += 4;
			}
			else if (m_Series == 3)
			{
				AddMaxResistCs += 6;
			}
			else if (m_Series == 4)
			{
				AddMaxResistCs += 8;
			}
			*/
		}
		//end code

	//	g_DebugLog("m_CurrentColdResistMax %d", m_CurrentColdResistMax);

		switch(nType)
		{
		case damage_physics:
			nRes = m_CurrentPhysicsResist + nFiveElement_total;
			{
				int nExDefense = m_CurrentExDefend - Npc[nAttacker].m_CurrentIgnoreExDefence;
				if (nExDefense > 0)
					nDamage -= nExDefense;
			}
			if (nRes > (m_CurrentPhysicsResistMax + AddMaxResistCs)) //+ AddMaxResistCs khang cu vat ly
			{
				nRes = m_CurrentPhysicsResistMax + AddMaxResistCs; //+ AddMaxResistCs khang cu vat ly
			}
		//	g_DebugLog("nRes %d", nRes); //nRes = 0% -> 75% khang vat ly phong thu

			//Fix damge ngu hanh
			if (nRes > MAX_RESIST)
			{
				nRes = MAX_RESIST;
			}
			else if(nRes < -m_CurrentPhysicsResistMax) //TamLTM fix khang'
			{
				nRes = -m_CurrentPhysicsResistMax;
			}

			m_PhysicsArmor.nValue[0] -= nDamage;
			if (m_PhysicsArmor.nValue[0] < 0)
			{
				nDamage = -m_PhysicsArmor.nValue[0];
				m_PhysicsArmor.nValue[0] = 0;
				m_PhysicsArmor.nTime = 0;
			}
			else
			{
				nDamage = 0;
			}
			if (bIsMelee)
			{
				nMax = m_CurrentMeleeDmgRetPercent;
			}
			else
			{
				nMax = m_CurrentRangeDmgRetPercent;
			}
			break;
		case damage_cold:
			nRes = m_CurrentColdResist + nFiveElement_total - Npc[nAttacker].m_CurrentIgnoreColdResist;
			if (nRes > (m_CurrentColdResistMax + AddMaxResistCs)) //+ AddMaxResistCs khang cu bang gia
			{
				nRes = m_CurrentColdResistMax + AddMaxResistCs; //+ AddMaxResistCs khang cu cu bang gia
			}
			else if(nRes < -m_CurrentColdResistMax) //TamLTM fix khang
			{
				nRes = -m_CurrentColdResistMax;
			}

			//Fix damge ngu hanh
			if (nRes > MAX_RESIST)
			{
				nRes = MAX_RESIST;
			}
			m_ColdArmor.nValue[0] -= nDamage;

			if (m_ColdArmor.nValue[0] < 0)
			{
				nDamage = -m_ColdArmor.nValue[0];
				m_ColdArmor.nValue[0] = 0;
				m_ColdArmor.nTime = 0;
			}
			else
			{
				nDamage = 0;
			}
			nMax = m_CurrentRangeDmgRetPercent;
			break;
		case damage_fire:
			nRes = m_CurrentFireResist + nFiveElement_total - Npc[nAttacker].m_CurrentIgnoreFireResist;
			if (nRes > (m_CurrentFireResistMax + AddMaxResistCs)) //+ AddMaxResistCs khang cu hoa
			{
				nRes = m_CurrentFireResistMax + AddMaxResistCs; //+ AddMaxResistCs khang cu hoa
			}
			else if(nRes < -m_CurrentFireResistMax) //TamLTM fix khang
			{
				nRes = -m_CurrentFireResistMax;
			}

			//Fix damge ngu hanh
			if (nRes > MAX_RESIST)
			{
				nRes = MAX_RESIST;
			}

			m_FireArmor.nValue[0] -= nDamage;

			if (m_FireArmor.nValue[0] < 0)
			{
				nDamage = -m_FireArmor.nValue[0];
				m_FireArmor.nValue[0] = 0;
				m_FireArmor.nTime = 0;
			}
			else
			{
				nDamage = 0;
			}
			nMax = m_CurrentRangeDmgRetPercent;
			break;
		case damage_light:
			nRes = m_CurrentLightResist + nFiveElement_total - Npc[nAttacker].m_CurrentIgnoreLightResist;
			if (nRes > (m_CurrentLightResistMax + AddMaxResistCs)) //+ AddMaxResistCs khang cu loi
			{
				nRes = m_CurrentLightResistMax + AddMaxResistCs; //+ AddMaxResistCs khang cu loi
			}
			else if(nRes < -m_CurrentLightResistMax) //TamLTM fix khang
			{
				nRes = -m_CurrentLightResistMax;
			}

			//Fix damge ngu hanh
			if (nRes > MAX_RESIST)
			{
				nRes = MAX_RESIST;
			}

			m_LightArmor.nValue[0] -= nDamage;
			if (m_LightArmor.nValue[0] < 0)
			{
				nDamage = -m_LightArmor.nValue[0];
				m_LightArmor.nValue[0] = 0;
				m_LightArmor.nTime = 0;
			}
			else
			{
				nDamage = 0;
			}
			nMax = m_CurrentRangeDmgRetPercent;
			break;
		////////////////
		case damage_earth:
			nRes = m_CurrentEarthResist + nFiveElement_total - Npc[nAttacker].m_CurrentIgnoreEarthResist;
			if (nRes > (m_CurrentEarthResistMax + AddMaxResistCs)) //+ AddMaxResistCs khang cu dat
			{
				nRes = m_CurrentEarthResistMax + AddMaxResistCs; //+ AddMaxResistCs khang cu dat
			}
			else if(nRes < -m_CurrentEarthResistMax) //TamLTM fix khang
			{
				nRes = -m_CurrentEarthResistMax;
			}


			//Fix damge ngu hanh
			if (nRes > MAX_RESIST)
			{
				nRes = MAX_RESIST;
			}

			m_EarthArmor.nValue[0] -= nDamage;
			if (m_EarthArmor.nValue[0] < 0)
			{
				nDamage = -m_EarthArmor.nValue[0];
				m_EarthArmor.nValue[0] = 0;
				m_EarthArmor.nTime = 0;
			}
			else
			{
				nDamage = 0;
			}
			nMax = m_CurrentRangeDmgRetPercent;
			break;
		////////////////
		case damage_poison:
			nRes = m_CurrentPoisonResist + nFiveElement_total;
			if (nRes > (m_CurrentPoisonResistMax + AddMaxResistCs)) //+ AddMaxResistCs khang cu doc
			{
				nRes = m_CurrentPoisonResistMax + AddMaxResistCs; //+ AddMaxResistCs khang cu doc
			}
			else if(nRes < -m_CurrentPoisonResistMax) //TamLTM fix khang
			{
				nRes = -m_CurrentPoisonResistMax;
			}

			//Fix damge ngu hanh
			if (nRes > MAX_RESIST)
			{
				nRes = MAX_RESIST;
			}

			m_PoisonArmor.nValue[0] -= nDamage;
			if (m_PoisonArmor.nValue[0] < 0)
			{
				nDamage = -m_PoisonArmor.nValue[0];
				m_PoisonArmor.nValue[0] = 0;
				m_PoisonArmor.nTime = 0;
			}
			else
			{
				nDamage = 0;
			}
			nMax = m_CurrentRangeDmgRetPercent;
			m_nLastPoisonDamageIdx = nAttacker;
			break;
		case damage_magic:
			nRes = 0;
			break;
		default:
			nRes = 0;
			break;
		}

		//TamLTM fix
		if (nDamage <= 0)
			return FALSE;

	//	nDamage -= nDamage * nRes / MAX_PERCENT;
		nDamage = nDamage * (MAX_PERCENT - nRes) / MAX_PERCENT; //TamLTM Fix Damage
		if (nType == damage_physics && m_CurrentDamageReduce > 0)
		{
			int nPhysicsReduce = m_CurrentDamageReduce;
			if (nPhysicsReduce > MAX_PERCENT)
				nPhysicsReduce = MAX_PERCENT;
			nDamage = nDamage * (MAX_PERCENT - nPhysicsReduce) / MAX_PERCENT;
		}

		//fix new TamLTM
		try
		{
			KSkill *pSkill = (KSkill *)Npc[nAttacker].GetActiveSkill();
			if (pSkill)
			{
				if(Npc[nAttacker].IsNpcSkillExist(pSkill->GetSkillId()))
				{
					int levelSkill = (int)pSkill->GetSkillLevel();
					int m_nChildSkillNum = (int)pSkill->GetChildSkillNum(levelSkill);

					if (m_nChildSkillNum > 1 )
					{
						nDamage = nDamage / m_nChildSkillNum;
						// g_DebugLog("MISS LESS:%d",m_nChildSkillNum);
						// g_DebugLog("MISS LESS DAME :%d",nDamage);
					}
					else
					{
						// g_DebugLog("NO MISS LE = 1");
						// g_DebugLog("NO MISS LE = 1",nDamage);
					}

				}
				else
				{
					// g_DebugLog("pSkill = null - nDamage : %d", nDamage);
				}
			}
		}
		catch (...)
		{

		}

		if (this->m_Kind == kind_player && nType != damage_magic)
		{
			if (Npc[nAttacker].m_Kind == kind_player)
			{
				nDamage = nDamage * NpcSet.m_nPKDamageRate / MAX_PERCENT;
			}
		}
		///end fix TamLTM

		if (nRes > MAX_RESIST)
		{
			nRes = MAX_RESIST;
		}

		if (nType != damage_poison &&m_ManaShield.nValue[0] > 0)
		{
			int nManaDamage = nDamage * m_ManaShield.nValue[0] / MAX_PERCENT;
			m_CurrentMana -= nManaDamage;
			nCurDamage += nManaDamage;
			if (m_CurrentMana < 0)
			{
				nDamage -= m_CurrentMana;
				nCurDamage += m_CurrentMana;
				m_CurrentMana = 0;
			}
			else
			{
				nDamage -= nManaDamage;
			}
		}

		if (m_CurrentManaShield > 0) //TamLTM fix dame huyen thien vo cuc;
			//nDamage -= m_CurrentManaShield;
		{
			/*int nManaDamage = nDamage * m_CurrentManaShield / MAX_PERCENT;
			m_CurrentMana -= nManaDamage;
			nCurDamage += nManaDamage;
			if (m_CurrentMana < 0)
			{
				nDamage -= m_CurrentMana;
				nCurDamage += m_CurrentMana;
				m_CurrentMana = 0;
			}
			else
			{
				nDamage -= nManaDamage;
			}*/

			if (m_CurrentManaShield > nDamage)
			{
				nDamage = 0;
				m_CurrentManaShield -= nDamage;
			}
			else
			{
				nDamage -= m_CurrentManaShield;
				m_CurrentManaShield = 0;
			}
		}

		//TamLTM Fix
	//	if (nDamage <= 0)
	//		return FALSE;

		/*KSkill *pSkill = (KSkill *)Npc[nAttacker].GetActiveSkill();
		if (pSkill)
		{
			int levelSkill = (int)pSkill->GetSkillLevel();
			int m_nChildSkillNum = (int)pSkill->GetChildSkillNum(levelSkill);
			nDamage = nDamage / m_nChildSkillNum;
		}*/

	/*	if (this->m_Kind == kind_player && nType != damage_magic)
		{
			if (Npc[nAttacker].m_Kind == kind_player)
			{
				nDamage = nDamage * NpcSet.m_nPKDamageRate / MAX_PERCENT;
			}
		}*/

		if (nAttacker > 0)
		{
			if (bReturn) // Phan damage thieu lam
			{
				if (nDamage > 0 && nType == damage_poison)
				{
					if (m_CurrentPoisonDamageReturnPercent)
					{
						if (m_PoisonState.nTime)
						{
							nMin = nDamage * m_CurrentPoisonDamageReturnPercent / MAX_PERCENT;
							if (nMin > 0)
							{
								Npc[nAttacker].CalcDamage(m_Index, -1, nMin, nMin, damage_magic, FALSE, FALSE, TRUE);
							}
						}
					}
				}
			}
			else
			{
				if (nDamage > 0 && nType != damage_magic)
				{
					if (bIsMelee)
					{
						nMin = m_CurrentMeleeDmgRet;
						nMin += nDamage * nMax / MAX_PERCENT;
						if (nMin > 0)
						{
							if (Npc[nAttacker].m_CurrentReturnResPercent > 0)
								nMin -= nMin *  Npc[nAttacker].m_CurrentReturnResPercent  / MAX_PERCENT;
							Npc[nAttacker].CalcDamage(m_Index, -1, nMin, nMin, damage_magic, FALSE, FALSE, TRUE);
						}
					}
					else
					{
						nMin = m_CurrentRangeDmgRet;
						nMin += nDamage * nMax / MAX_PERCENT;
						if (nMin > 0)
						{
							if (Npc[nAttacker].m_CurrentReturnResPercent)
								nMin -= nMin * - Npc[nAttacker].m_CurrentReturnResPercent   / MAX_PERCENT;
							Npc[nAttacker].CalcDamage(m_Index, -1, nMin, nMin, damage_magic, FALSE, FALSE, TRUE);
						}
					}
				}
			}
		}
		// Phong Than 2026-10-04 dinhanbot: follow the owner chain (de tu of a Di Nhan party bot -> bot -> player, at
		// most 3 hops). One hop booked the de tu's hits on the bot (an NPC): no EXP share, drops and LastDamage for
		// nobody, and the player's EXP share of the monster shrank by the de tu's damage.
		for (int nPtHop = 0; nPtHop < 3 && Npc[nAttacker].m_nOwnerIdx > 0 && Npc[nAttacker].m_nOwnerIdx < MAX_NPC &&
			Npc[nAttacker].m_Kind != kind_player && Npc[nAttacker].m_AiMode == 11; nPtHop++)
			nAttacker = Npc[nAttacker].m_nOwnerIdx;
		///KILL normal;
		if (m_Kind != kind_player && Npc[nAttacker].m_Kind == kind_player && Npc[nAttacker].m_nPlayerIdx > 0)
		{
			m_cDeathCalcExp.AddDamage(Npc[nAttacker].m_nPlayerIdx, (m_CurrentLife - nDamage > 0 ? nDamage : m_CurrentLife));
		}
		//end code
		m_nLastDamageIdx = nAttacker;

	//	g_DebugLog("nAttacker %d", nAttacker);

		if (m_CurrentStaticMagicShieldP > 0)
		{
			if (m_CurrentStaticMagicShieldP > nDamage)
			{
				nDamage = 0;
				m_CurrentStaticMagicShieldP -= nDamage;
			}
			else
			{
				nDamage -= m_CurrentStaticMagicShieldP;
				m_CurrentStaticMagicShieldP = 0;
			}
		}

		if (nDamage > 0)
		{
			Npc[nAttacker].m_CurrentLife += nDamage * nStolen_Life / MAX_PERCENT;
			if (Npc[nAttacker].m_CurrentLife > Npc[nAttacker].m_CurrentLifeMax)
				Npc[nAttacker].m_CurrentLife = Npc[nAttacker].m_CurrentLifeMax;

			Npc[nAttacker].m_CurrentMana += nDamage * nStolen_Mana / MAX_PERCENT;
			if (Npc[nAttacker].m_CurrentMana > Npc[nAttacker].m_CurrentManaMax)
				Npc[nAttacker].m_CurrentMana = Npc[nAttacker].m_CurrentManaMax;

			Npc[nAttacker].m_CurrentStamina += nDamage * nStolen_Stamina / MAX_PERCENT;
			if (Npc[nAttacker].m_CurrentStamina > Npc[nAttacker].m_CurrentStaminaMax)
				Npc[nAttacker].m_CurrentStamina = Npc[nAttacker].m_CurrentStaminaMax;

			m_CurrentMana += nDamage * m_CurrentDamage2Mana / MAX_PERCENT;
			if (m_CurrentMana > m_CurrentManaMax)
				m_CurrentMana = m_CurrentManaMax;
		}

		m_CurrentLife -= nDamage;
		nCurDamage += nDamage;

		if (m_CurrentLife <= 0)
		{
			nCurDamage += m_CurrentLife;

			if (m_Doing != do_death &&
				m_Doing != do_revive)
			{
				if((m_DeathSkill[0].nSkillId > 0 && m_DeathSkill[0].nSkillId < MAX_SKILL) && m_Level >= LEVEL_EXPLOSIVE)
					DeathSkill();

				int nMode = DeathCalcPKValue(m_nLastDamageIdx);
				//DoDeath(nMode);
				DoDeath(nMode, nAttacker); //TamLTM fix exp

				if (m_Kind == kind_player)
					Player[m_nPlayerIdx].m_cPK.CloseAll();
			}
		}
		if (nCurDamage > 0 && (this->m_Kind == kind_player) &&
			(Npc[nAttacker].m_Kind == kind_player))
		{
			if (Player[Npc[nAttacker].m_nPlayerIdx].m_dwDamageScriptId)
				Player[m_nPlayerIdx].ExecuteScript(Player[m_nPlayerIdx].m_dwDamageScriptId, "OnDamage", nCurDamage);
		}
	}
	return TRUE;
}


void KNpc::ReplySkill()
{
	if (!m_Index)
		return;

	if (m_Doing == do_death || m_Doing == do_revive)
		return;

	for (int i = 0; i < MAX_AUTOSKILL; i ++)
	{
		if (m_ReplySkill[i].nSkillId > 0 && m_ReplySkill[i].nSkillId < MAX_SKILL &&
			m_ReplySkill[i].nSkillLevel > 0 && m_ReplySkill[i].nSkillLevel < MAX_SKILLLEVEL)
		{
			if (m_ReplySkill[i].dwNextCastTime < SubWorld[m_SubWorldIndex].m_dwCurrentTime)
			{
				if (g_RandPercent(m_ReplySkill[i].nRate))
				{
					this->Cast(m_ReplySkill[i].nSkillId, m_ReplySkill[i].nSkillLevel);
					m_ReplySkill[i].dwNextCastTime = SubWorld[m_SubWorldIndex].m_dwCurrentTime + m_ReplySkill[i].nWaitCastTime;
				}
			}
		}
	}
}

void KNpc::RescueSkill()
{
	if (!m_Index)
		return;

	if (m_Doing == do_death || m_Doing == do_revive)
		return;

	for (int i = 0; i < MAX_AUTOSKILL; i ++)
	{
		if (m_RescueSkill[i].nSkillId > 0 && m_RescueSkill[i].nSkillId < MAX_SKILL &&
			m_RescueSkill[i].nSkillLevel > 0 && m_RescueSkill[i].nSkillLevel < MAX_SKILLLEVEL)
		{
			if (m_RescueSkill[i].dwNextCastTime < SubWorld[m_SubWorldIndex].m_dwCurrentTime)
			{
				if (g_RandPercent(m_RescueSkill[i].nRate))
				{
					this->Cast(m_RescueSkill[i].nSkillId, m_RescueSkill[i].nSkillLevel);
					m_RescueSkill[i].dwNextCastTime = SubWorld[m_SubWorldIndex].m_dwCurrentTime + m_RescueSkill[i].nWaitCastTime;
				}
			}
		}
	}
}

void KNpc::AttackSkill(int nLauncher)
{
	if (!m_Index || !Npc[nLauncher].m_Index)
		return;

	if (m_Doing == do_death || m_Doing == do_revive)
		return;

	if (Npc[nLauncher].m_Doing == do_death || Npc[nLauncher].m_Doing == do_revive)
		return;

	for (int i = 0; i < MAX_AUTOSKILL; i ++)
	{
		if (m_AttackSkill[i].nSkillId > 0 && m_AttackSkill[i].nSkillId < MAX_SKILL &&
			m_AttackSkill[i].nSkillLevel > 0 && m_AttackSkill[i].nSkillLevel < MAX_SKILLLEVEL)
		{
			if (m_AttackSkill[i].dwNextCastTime < SubWorld[m_SubWorldIndex].m_dwCurrentTime)
			{
				if (g_RandPercent(m_AttackSkill[i].nRate))
				{
					KSkill * pSkill = (KSkill *) g_SkillManager.GetSkill(m_AttackSkill[i].nSkillId, m_AttackSkill[i].nSkillLevel);
					if(pSkill)
						pSkill->Cast(m_Index, -1, nLauncher);
					m_AttackSkill[i].dwNextCastTime = SubWorld[m_SubWorldIndex].m_dwCurrentTime + m_AttackSkill[i].nWaitCastTime;
				}
			}
		}
	}
}

void KNpc::DeathSkill()
{
	if (!m_Index)
		return;

	if (m_Doing == do_death || m_Doing == do_revive)
		return;

	for (int i = 0; i < MAX_AUTOSKILL; i ++)
	{
		if (m_DeathSkill[i].nSkillId > 0 && m_ReplySkill[i].nSkillId < MAX_SKILL &&
			m_DeathSkill[i].nSkillLevel > 0 && m_DeathSkill[i].nSkillLevel < MAX_SKILLLEVEL)
		{
			if (m_DeathSkill[i].dwNextCastTime < SubWorld[m_SubWorldIndex].m_dwCurrentTime)
			{
				if (g_RandPercent(m_DeathSkill[i].nRate))
				{
					this->Cast(m_DeathSkill[i].nSkillId, m_DeathSkill[i].nSkillLevel);
					m_DeathSkill[i].dwNextCastTime = SubWorld[m_SubWorldIndex].m_dwCurrentTime + m_DeathSkill[i].nWaitCastTime;
				}
			}
		}
	}
}
#endif


#ifdef _SERVER
// engine2:BEGIN D3 2026-10-04 VNG npcs.txt column DeadlyStrikeResist (col 105; 94 templates 100 = immune, 37 more
// 50-95, the 200/300 rows count as 100): an NPC (not a player) shrugs a deadly strike (deadlystrike_p, "Danh tap
// trung") off with this chance, the same way FatallyStrikeResist is read below.
// enhance_fatallystrike_p (magic 295, MagicDesc "Tang hieu qua chi mang di nhan: +X%"): a fatal strike that goes
// through takes X % more than its 1/4 of the current life (m_CurrentFatallyStrikeLifeP of the launcher, set by
// KNpcAttribModify::EnhanceFatallyStrikeP); it still never kills.
int PhongThanNpcDeadlyStrikeResist(int nNpcSettingIdx)
{
	static short s_nDsResist[MAX_NPCSTYLE];
	static unsigned char s_bDsRead[MAX_NPCSTYLE];
	if (nNpcSettingIdx < 0 || nNpcSettingIdx >= MAX_NPCSTYLE)
		return 0;
	if (!s_bDsRead[nNpcSettingIdx])
	{
		int nValue = 0;
		if (nNpcSettingIdx + 2 <= g_NpcSetting.GetHeight())
			g_NpcSetting.GetInteger(nNpcSettingIdx + 2, "DeadlyStrikeResist", 0, &nValue);
		if (nValue < 0)
			nValue = 0;
		if (nValue > MAX_PERCENT)
			nValue = MAX_PERCENT;
		s_nDsResist[nNpcSettingIdx] = (short)nValue;
		s_bDsRead[nNpcSettingIdx] = 1;
	}
	return s_nDsResist[nNpcSettingIdx];
}

int PhongThanFatallyStrikeEnhance(int nLife, int nEnhanceP, int nCurrentLife)
{
	if (nLife <= 0 || nEnhanceP == 0)
		return nLife;
	if (nEnhanceP < -MAX_PERCENT)
		nEnhanceP = -MAX_PERCENT;
	if (nEnhanceP > 10 * MAX_PERCENT)
		nEnhanceP = 10 * MAX_PERCENT;
	__int64 nNew = (__int64)nLife * (MAX_PERCENT + nEnhanceP) / MAX_PERCENT;
	if (nNew >= nCurrentLife)
		nNew = nCurrentLife - 1;
	return nNew > 0 ? (int)nNew : 0;
}
// engine2:END

// vancot:BEGIN Phong Than 2026-10-04 vancot: fatal strike (fatallystrike_p, "Danh chi mang" in MagicDesc.ini).
// Van Cot Toan Kho (Di Nhan level-90 skill 51, dungeon NPC copy 921) carries ONLY fatallystrike_p (16 + 2 * level %,
// \script\skill\yiren\<wan gu quan ku>.lua) and no damage, so CalcDamage left at once (min + max = 0) and bIsFS only
// fed the damage-return branch (bReturn): the skill never took any life. VNG skills.txt SkillDesc of 51/921:
// "Giam 1/4 sinh luc ... cua doi phuong" -> a fatal strike that goes through takes 1/4 of the CURRENT life (never kills).
// Limits (VNG data, no invented boss list): the template column FatallyStrikeResist of \settings\npcs.txt (vng00.pak,
// col 105; 100 = immune: Giao/Ly/Di Long world bosses 97-99 and 303 other templates, 30-99 on 79 more) is a chance
// to shrug the strike off; magic_heart_damage_resistance_p (m_CurrentFatallyStrikeResP) still lowers the chance;
// gold/blue/pink specials (kind_normal, m_btSpecial) take NpcSet.m_nNpcSpecialDamageRate % of it, like the original
// fatal-strike formula of the return branch. The life loss goes through CalcDamage(damage_magic): mana shields, kill
// credit (owner chain), EXP share and death handling stay the engine's.
#define PT_FATALLY_STRIKE_LIFE_P	25

int PhongThanNpcFatallyStrikeResist(int nNpcSettingIdx)
{
	static short s_nResist[MAX_NPCSTYLE];
	static unsigned char s_bRead[MAX_NPCSTYLE];
	if (nNpcSettingIdx < 0 || nNpcSettingIdx >= MAX_NPCSTYLE)
		return 0;
	if (!s_bRead[nNpcSettingIdx])
	{
		int nValue = 0;
		if (nNpcSettingIdx + 2 <= g_NpcSetting.GetHeight())
			g_NpcSetting.GetInteger(nNpcSettingIdx + 2, "FatallyStrikeResist", 0, &nValue);
		if (nValue < 0)
			nValue = 0;
		if (nValue > MAX_PERCENT)
			nValue = MAX_PERCENT;
		s_nResist[nNpcSettingIdx] = (short)nValue;
		s_bRead[nNpcSettingIdx] = 1;
	}
	return s_nResist[nNpcSettingIdx];
}

// life taken by a fatal strike that went through (no int overflow on 130 000 000-life bosses)
int PhongThanFatallyStrikeLife(int nCurrentLife, BOOL bSpecialNpc, int nSpecialRate)
{
	if (nCurrentLife <= 1)
		return 0;
	int nLife = nCurrentLife / MAX_PERCENT * PT_FATALLY_STRIKE_LIFE_P +
		nCurrentLife % MAX_PERCENT * PT_FATALLY_STRIKE_LIFE_P / MAX_PERCENT;
	if (bSpecialNpc)
	{
		if (nSpecialRate < 0)
			nSpecialRate = 0;
		if (nSpecialRate > MAX_PERCENT)
			nSpecialRate = MAX_PERCENT;
		nLife = nLife / MAX_PERCENT * nSpecialRate + nLife % MAX_PERCENT * nSpecialRate / MAX_PERCENT;
	}
	if (nLife >= nCurrentLife)
		nLife = nCurrentLife - 1;
	return nLife > 0 ? nLife : 0;
}

static void PhongThanFatallyStrike(int nTarget, int nLauncher)
{
	if (nTarget <= 0 || nTarget >= MAX_NPC || nLauncher <= 0 || nLauncher >= MAX_NPC)
		return;
	KNpc &rNpc = Npc[nTarget];
	if (rNpc.m_Doing == do_death || rNpc.m_Doing == do_revive || rNpc.m_CurrentLife <= 1)
		return;
	if (!rNpc.IsPlayer() && g_RandPercent(PhongThanNpcFatallyStrikeResist(rNpc.m_NpcSettingIdx)))
		return;
	int nLife = PhongThanFatallyStrikeLife(rNpc.m_CurrentLife,
		rNpc.m_Kind == kind_normal && rNpc.m_btSpecial != npc_normal, NpcSet.m_nNpcSpecialDamageRate);
	nLife = PhongThanFatallyStrikeEnhance(nLife, Npc[nLauncher].m_CurrentFatallyStrikeLifeP, rNpc.m_CurrentLife);	// engine2:D3e
	if (nLife > 0)
		rNpc.CalcDamage(nLauncher, -1, nLife, nLife, damage_magic, FALSE);
}
// vancot:END
#endif

#ifdef _SERVER
BOOL KNpc::ReceiveDamage(int nLauncher, int nMissleSeries, BOOL bIsMelee, void *pData, BOOL bUseAR, int nDoHurtP, int nMissRate)
{
	if (!m_Index || !Npc[nLauncher].m_Index)
		return FALSE;

	if (!pData)
		return FALSE;

	if (m_Doing == do_death || m_Doing == do_revive)
		return TRUE;

	if (Npc[nLauncher].m_Doing == do_death || Npc[nLauncher].m_Doing == do_revive)
		return TRUE;

	int nRdc;
	KMagicAttrib *pTemp = NULL;

	pTemp = (KMagicAttrib *)pData;

	int nAr = pTemp->nValue[0];
	pTemp++;
	int nIgnoreAr = pTemp->nValue[0];

	if (bUseAR)
	{
		if (!CheckHitTarget(nAr, m_CurrentDefend, nIgnoreAr))
			return FALSE;
	}

	//Luyen skill
	if (Npc[nLauncher].IsPlayer() && Npc[nLauncher].m_FightMode)
	{
		if (Npc[nLauncher].m_ActiveSkillID > 0 && Npc[nLauncher].m_ActiveSkillID < MAX_SKILL)
		{
			if (Npc[nLauncher].m_SkillList.GetLevel(Npc[nLauncher].m_ActiveSkillID) < MAX_TRAIN_SKILLEXPLEVEL)
			{
				KSkill * pSkill = (KSkill *) g_SkillManager.GetSkill(Npc[nLauncher].m_ActiveSkillID, 1);
				if (pSkill->IsExp() && pSkill->IsTargetEnemy())
				{
					if (Npc[nLauncher].m_SkillList.IncreaseExp(Npc[nLauncher].m_SkillList.GetSkillIdx(Npc[nLauncher].m_ActiveSkillID), Npc[nLauncher].m_CurrentExpSkillsEnchance * g_SkillExpRate)) //m_bIsTempExpSkills == nhan doi kinh nghiem  luyen skills.
						Player[Npc[nLauncher].m_nPlayerIdx].UpdataCurData();
					//g_DebugLog("nhan doi exp: %d",Npc[nLauncher].m_CurrentExpSkillsEnchance * g_SkillExpRate);
					//Get exp Luyen skill
					PHONGTHAN_SKILL_LEVEL_UPDATE NewSkill;
					ZeroMemory(&NewSkill, sizeof(NewSkill));
	PhongThanInitializeWireHeader(&NewSkill.Header, PHONGTHAN_MSG_GAMEPLAY_SKILL_LEVEL_UPDATE, sizeof(NewSkill), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	NewSkill.MapId = SubWorld[Npc[nLauncher].m_SubWorldIndex].m_SubWorldID;
	NewSkill.EntityId = Npc[nLauncher].m_dwID;
					NewSkill.SkillId = Npc[nLauncher].m_ActiveSkillID;
					NewSkill.Level = Npc[nLauncher].m_SkillList.GetLevel(Npc[nLauncher].m_ActiveSkillID);
					NewSkill.BonusLevel = Npc[nLauncher].m_SkillList.GetAddLevel(Npc[nLauncher].m_ActiveSkillID);
					NewSkill.Experience = Npc[nLauncher].m_SkillList.GetExp(Npc[nLauncher].m_ActiveSkillID);
					NewSkill.Temporary = (Npc[nLauncher].m_SkillList.IsTempSkill(Npc[nLauncher].m_ActiveSkillID)) ? 1 : 0;
					NewSkill.RemainingPoints = Player[Npc[nLauncher].m_nPlayerIdx].m_nSkillPoint;
					g_pServer->PackDataToClient(Player[Npc[nLauncher].m_nPlayerIdx].m_nNetConnectIdx, (BYTE*)&NewSkill, sizeof(NewSkill));
				}
			}
		}
	}

	pTemp++;
	int nMagicDamage = pTemp->nValue[0];

	pTemp++;
	int nFiveElementsDamageP = pTemp->nValue[0];

	pTemp++;
	BOOL bIsDS = FALSE;
	if (g_RandPercent(pTemp->nValue[0]))
		bIsDS = TRUE;
	// engine2:D3d template DeadlyStrikeResist (VNG npcs.txt): an NPC target may shrug the deadly strike off
	if (bIsDS && !IsPlayer() && g_RandPercent(PhongThanNpcDeadlyStrikeResist(m_NpcSettingIdx)))
		bIsDS = FALSE;

	pTemp++;
	BOOL bIsFS = FALSE;
	if (g_RandPercent(pTemp->nValue[0] - m_CurrentFatallyStrikeResP))
		bIsFS = TRUE;
	// Phong Than 2026-10-04 vancot: only a skill that carries fatallystrike_p itself (51/921 Van Cot Toan Kho, 1369 Pha
	// Quan Chu-Tuy Hon) applies the fatal strike; m_CurrentFatallyStrikeEnhanceP alone (1488, items) only raises its chance.
	BOOL bPtFsSkill = (pTemp->nAttribType == magic_fatallystrike_p);

	pTemp++;
	int nStolenLifeP = pTemp->nValue[0];

	pTemp++;
	int nStolenManaP = pTemp->nValue[0];

	pTemp++;
	int nStolenStaminaP = pTemp->nValue[0];

	int getDamageCritical = 1;
	int nColdFocusedChance = Npc[nLauncher].m_CurrentAllMagicDeadlyStrike + Npc[nLauncher].m_CurrentColdDeadlyStrike;
	int nFireFocusedChance = Npc[nLauncher].m_CurrentAllMagicDeadlyStrike + Npc[nLauncher].m_CurrentFireDeadlyStrike;
	int nLightFocusedChance = Npc[nLauncher].m_CurrentAllMagicDeadlyStrike + Npc[nLauncher].m_CurrentLightDeadlyStrike;
	int nEarthFocusedChance = Npc[nLauncher].m_CurrentAllMagicDeadlyStrike + Npc[nLauncher].m_CurrentEarthDeadlyStrike;
	int nPoisonFocusedChance = Npc[nLauncher].m_CurrentAllMagicDeadlyStrike;
	if (nColdFocusedChance > MAX_PERCENT) nColdFocusedChance = MAX_PERCENT;
	if (nFireFocusedChance > MAX_PERCENT) nFireFocusedChance = MAX_PERCENT;
	if (nLightFocusedChance > MAX_PERCENT) nLightFocusedChance = MAX_PERCENT;
	if (nEarthFocusedChance > MAX_PERCENT) nEarthFocusedChance = MAX_PERCENT;
	if (nPoisonFocusedChance > MAX_PERCENT) nPoisonFocusedChance = MAX_PERCENT;
	BOOL bColdFocused = nColdFocusedChance > 0 && g_RandPercent(nColdFocusedChance);
	BOOL bFireFocused = nFireFocusedChance > 0 && g_RandPercent(nFireFocusedChance);
	BOOL bLightFocused = nLightFocusedChance > 0 && g_RandPercent(nLightFocusedChance);
	BOOL bEarthFocused = nEarthFocusedChance > 0 && g_RandPercent(nEarthFocusedChance);
	BOOL bPoisonFocused = nPoisonFocusedChance > 0 && g_RandPercent(nPoisonFocusedChance);

	//g_DebugLog("nMissleSeries %d, %d", nMissleSeries, nFiveElementsDamageP); //  chinh dame skill
	//1 Damage sat thuong vat ly
	pTemp++;
	CalcDamage(nLauncher, nMissleSeries,
		pTemp->nValue[0] * (500 + getDamageCritical)/100,
		pTemp->nValue[2] * (500 + getDamageCritical)/100,
		damage_physics, bIsMelee, FALSE,
		nFiveElementsDamageP, nStolenLifeP, nStolenManaP, nStolenStaminaP, bIsDS);


	//end code

//	g_DebugLog("bUseAR %d", bUseAR);

	//2 Damage bang sat
	int  totalDamageCold1 = rand() % 5 + 5;
	int  totalDamageCold2;
//	g_DebugLog("Npc[nLauncher].m_ActiveSkillID %d", Npc[nLauncher].m_ActiveSkillID);
	//357 Phi long tai thien
	if (nMissleSeries == 3) //0=kim - 1=moc - 2=thuy - 3=hoa - 4=tho
	{
		totalDamageCold2 = 7; // ky he tang dang
	}
	else if (nMissleSeries == 0  || nMissleSeries == 3)
	{
		totalDamageCold2 = 7;  // gap he ko ky tang damage
	}
	else if (nMissleSeries == 4 || nMissleSeries == 2) // ky he tho
	{
		totalDamageCold2 = rand() % 10 + 5; //Xac xuat tang damge ngau nhien
	}
	else
	{
		totalDamageCold2 = 0;
	}

	pTemp++;
	if (CalcDamage(nLauncher, nMissleSeries,
		pTemp->nValue[0] * (getDamageCritical + totalDamageCold1)/5,
		pTemp->nValue[2] * (getDamageCritical + totalDamageCold2)/5,
		damage_cold, bIsMelee, FALSE,
		nFiveElementsDamageP, 0, 0, 0, bColdFocused, bIsFS))
	{
		nRdc = m_CurrentFreezeTimeReducePercent; //TamLTM bang sat hien tai thoi gian giam? %
		if(nRdc >= MAX_PERCENT)
			nRdc = MAX_RESIST;
		if (m_FreezeState.nTime <= 0)
				m_FreezeState.nTime = pTemp->nValue[1] - (pTemp->nValue[1] * nRdc / MAX_PERCENT);
	}
	//end code

	//3 Damage hoa
	int  totalDamageFire1 = rand() % 7 + 5;
	int  totalDamageFire2;

	if (nMissleSeries == 0) //0=kim - 1=moc - 2=thuy - 3=hoa - 4=tho
	{
		totalDamageFire2 = 7; // ky he tang dang
	}
	else if (nMissleSeries == 1  || nMissleSeries == 4)
	{
		totalDamageFire2 = 7; // gap he ko ky tang damage
	}
	else if (nMissleSeries == 2 || nMissleSeries == 3) // ky he thuy
	{
		totalDamageFire2 = rand() % 10 + 5; //Xac xuat tang damge ngau nhien
	}
	else
	{
		totalDamageFire2 = 0;
	}

	pTemp++;
	if (CalcDamage(nLauncher,
		nMissleSeries,
		pTemp->nValue[0] * (getDamageCritical + totalDamageFire1)/5,
		pTemp->nValue[2] * (getDamageCritical + totalDamageFire2)/5,
		damage_fire, bIsMelee, FALSE,
		nFiveElementsDamageP, 0, 0, 0, bFireFocused, bIsFS))
	{
		nRdc = m_CurrentFreezeTimeReducePercent; //TamLTM bang sat hien tai thoi gian giam? %
			if (nRdc >= MAX_PERCENT)
				nRdc = MAX_RESIST;
	}



	//end code

	//4 Damage loi
	int  totalDamageLight1 = rand() % 7 + 5;
	int  totalDamageLight2;
	//g_DebugLog("Npc[nLauncher].m_ActiveSkillID %d", Npc[nLauncher].m_ActiveSkillID);
	//Skll: 153 - 1x noi, 164 - 3x noi
	if (nMissleSeries == 2) //0=kim - 1=moc - 2=thuy - 3=hoa - 4=tho
	{
		totalDamageLight2 = 7;
	}
	else if (nMissleSeries == 0 || nMissleSeries == 3 || nMissleSeries == 4)
	{
		totalDamageLight2 = 7;
	}
	else if (nMissleSeries == 1 || nMissleSeries == 4) // ky he moc
	{
		totalDamageLight2 = rand() % 10 + 5;
	}
	else
	{
		totalDamageLight2 = 0;
	}

	if (Npc[nLauncher].m_ActiveSkillID == 153 ||
		Npc[nLauncher].m_ActiveSkillID == 164) //1x 3x vo dang noi cong
	{
		totalDamageLight2 = 4;
	}

	pTemp++;
	if (CalcDamage(nLauncher,
		nMissleSeries,
		pTemp->nValue[0] * (getDamageCritical + totalDamageLight1)/10,
		pTemp->nValue[2] * (getDamageCritical + totalDamageLight2)/10,
		damage_light, bIsMelee, FALSE,
		nFiveElementsDamageP, 0, 0, 0, bLightFocused, bIsFS))
	{
		nRdc = m_CurrentFreezeTimeReducePercent; //TamLTM bang sat hien tai thoi gian giam? %
		if (nRdc >= MAX_PERCENT)
			nRdc = MAX_RESIST;
	}
	//end code
	//4 Damage tho
	int  totalDamageEarth1 = rand() % 7 + 5;
	int  totalDamageEarth2;
	//g_DebugLog("Npc[nLauncher].m_ActiveSkillID %d", Npc[nLauncher].m_ActiveSkillID);
	//Skll: 153 - 1x noi, 164 - 3x noi
	if (nMissleSeries == 2) //0=kim - 1=moc - 2=thuy - 3=hoa - 4=tho
	{
		totalDamageEarth2 = 7;
	}
	else if (nMissleSeries == 0 || nMissleSeries == 3 || nMissleSeries == 4)
	{
		totalDamageEarth2 = 7;
	}
	else if (nMissleSeries == 1 || nMissleSeries == 4) // ky he moc
	{
		totalDamageEarth2 = rand() % 10 + 5;
	}
	else
	{
		totalDamageEarth2 = 0;
	}

	pTemp++;
	if (CalcDamage(nLauncher,
		nMissleSeries,
		pTemp->nValue[0] * (getDamageCritical + totalDamageEarth1)/10,
		pTemp->nValue[2] * (getDamageCritical + totalDamageEarth2)/10,
		damage_earth, bIsMelee, FALSE,
		nFiveElementsDamageP, 0, 0, 0, bEarthFocused, bIsFS))
	{
		nRdc = m_CurrentFreezeTimeReducePercent; //TamLTM bang sat hien tai thoi gian giam? %
		if (nRdc >= MAX_PERCENT)
			nRdc = MAX_RESIST;
	}
	//end code
	//5 Damage doc sat

	pTemp++;
	if (CalcDamage(nLauncher, nMissleSeries,
		pTemp->nValue[0] /* (getDamageCritical + totalDamagePoison1)*/,
		pTemp->nValue[2] /* (getDamageCritical + totalDamagePoison2)*/,
		damage_poison, bIsMelee, FALSE,
		nFiveElementsDamageP, 0, 0, 0, bPoisonFocused, bIsFS))
	{
		nRdc = (m_CurrentPoisonTimeReducePercent / 20) * 10; // TamLTM thoi gian trung doc khi npc danh 2
		if(nRdc >= MAX_PERCENT)
			nRdc = MAX_RESIST;
		if (m_PoisonState.nTime <= 0)
		{
			m_PoisonState.nTime = pTemp->nValue[1] - (pTemp->nValue[1] * nRdc / MAX_PERCENT);
			m_PoisonState.nValue[0] = pTemp->nValue[0];
			m_PoisonState.nValue[1] = pTemp->nValue[2];
		}
		else
		{
			int d1, d2, t1, t2, c1, c2;
			d1 = m_PoisonState.nValue[0];
			d2 = pTemp->nValue[0] - (pTemp->nValue[1] * nRdc / MAX_PERCENT);
			t1 = m_PoisonState.nTime;
			t2 = pTemp->nValue[1] - (pTemp->nValue[1] * nRdc / MAX_PERCENT);
			c1 = m_PoisonState.nValue[1];
			c2 = pTemp->nValue[2];
			if (c1 > 0 && c2 > 0 && d1 > 0 && d2 > 0)
			{
				m_PoisonState.nValue[0] = ((c1 + c2) * d1 / c1 + (c1 + c2) * d2 / c2) / 2;
				m_PoisonState.nTime = (t1 * d1 * c2 + t2 * d2 * c1) / (d1 * c2 + d2 * c1);
				m_PoisonState.nValue[1] = (c1 + c2) / 2;
			}
		}
	}

	// Phong Than 2026-10-04 vancot: fatal strike (see PhongThanFatallyStrike above)
	if (bIsFS && bPtFsSkill)
		PhongThanFatallyStrike(m_Index, nLauncher);

	//3
	pTemp++;
	if (m_StunState.nTime <= 0)
	{
		if (g_RandPercent(pTemp->nValue[0]))
		{
			nRdc = m_CurrentStunTimeReducePercent; //TamLTM thoi gian lam choan 3
			if(nRdc >= MAX_PERCENT)
				nRdc = MAX_RESIST;

			m_StunState.nTime = pTemp->nValue[1] - (pTemp->nValue[1] * nRdc / MAX_PERCENT);
		}
	}
	pTemp++;
	if (g_RandPercent(nMissRate))
	{
		this->ClearNormalState();
		this->IgnoreState(TRUE);
	}

	pTemp++;
	if(pTemp->nValue[0] && pTemp->nValue[1] && g_RandPercent(nMissRate))
		return FALSE;

//	if (g_RandPercent(nDoHurtP))
	//	DoHurt();

	m_nPeopleIdx = nLauncher;

	//TamLTM giai phong
	// Focused-strike values use stack locals; no heap allocation is required.
	//end code
	return TRUE;
}
#endif
void KNpc::SetImmediatelySkillEffect(int nLauncher, void *pData, int nDataNum)
{
	if (!pData || !nDataNum)
		return;

	KMagicAttrib*	pTemp = (KMagicAttrib *)pData;
	_ASSERT(nDataNum <= MAX_SKILL_STATE);
	for (int i = 0; i < nDataNum; i++)
	{
		ModifyAttrib(nLauncher, pTemp);
		pTemp++;
	}
}

void KNpc::AppendSkillEffect(int nSkillID, BOOL bIsPhysical, BOOL bIsMelee, void *pSrcData, void *pDesData)
{
	//TamLTM fix damage
	int DamePecentToLevel = 0;
	if (IsPlayer())
	{
		if (m_Level > 100 && m_Level <= 200)
		{
			DamePecentToLevel = (m_Level - 100) / 5;
		}
	}
	//end code

	int nMinDamage = m_PhysicsDamage.nValue[0] + m_CurrentAddPhysicsDamage;
	int	nMaxDamage = m_PhysicsDamage.nValue[2] + m_CurrentAddPhysicsDamage;
	int nAddDamageP = this->m_SkillList.GetAddSkillDamage(nSkillID) + this->m_CurrentSkillEnhancePercent; //Ho tro ky nang khac

	if(m_CurrentMana == m_CurrentManaMax)
		nAddDamageP += m_CurrentManaToSkillEnhanceP;

	KMagicAttrib* pTemp = (KMagicAttrib *)pSrcData;
	KMagicAttrib* pDes = (KMagicAttrib *)pDesData;
	if (pTemp->nAttribType == magic_attackrating_p)
	{
		pDes->nAttribType = magic_attackrating_v;
		pDes->nValue[0] = m_CurrentAttackRating + m_AttackRating * pTemp->nValue[0] / MAX_PERCENT;
	}
	else
	{
		pDes->nAttribType = magic_attackrating_v;
		pDes->nValue[0] = m_CurrentAttackRating;
	}
	pTemp++;
	pDes++;
	if (pTemp->nAttribType == magic_ignoredefense_p)
	{
		pDes->nAttribType = magic_ignoredefense_p;
		pDes->nValue[0] = pTemp->nValue[0];
	}
	pDes->nValue[0] += m_CurrentIgnoreDefensePercent;
	pTemp++;
	pDes++;
	if (pTemp->nAttribType == magic_magicdamage_v)
	{
		pDes->nAttribType = magic_magicdamage_v;
		pDes->nValue[0] = pTemp->nValue[0] + (pTemp->nValue[0] * nAddDamageP / MAX_PERCENT);
		pDes->nValue[2] = pTemp->nValue[2] + (pTemp->nValue[2] * nAddDamageP / MAX_PERCENT);
	}
	pTemp++;
	pDes++;
	if (pTemp->nAttribType == magic_seriesdamage_p)
	{
		pDes->nAttribType = magic_seriesdamage_p;
		pDes->nValue[0] = pTemp->nValue[0];
		pDes->nValue[1] = pTemp->nValue[1];
		pDes->nValue[2] = pTemp->nValue[2];
	}
	pTemp++;
	pDes++;
	if (pTemp->nAttribType == magic_deadlystrike_p)
	{
		pDes->nAttribType = magic_deadlystrike_p;
		pDes->nValue[0] = pTemp->nValue[0];
		pDes->nValue[1] = pTemp->nValue[1];
		pDes->nValue[2] = pTemp->nValue[2];
	}
	if (bIsPhysical)
		pDes->nValue[0] += m_CurrentDeadlyStrikeEnhanceP;
	pTemp++;
	pDes++;
	if (pTemp->nAttribType == magic_fatallystrike_p)
	{
		pDes->nAttribType = magic_fatallystrike_p;
		pDes->nValue[0] = pTemp->nValue[0];
		pDes->nValue[1] = pTemp->nValue[1];
		pDes->nValue[2] = pTemp->nValue[2];
	}
	pDes->nValue[0] += m_CurrentFatallyStrikeEnhanceP;
	pTemp++;
	pDes++;
	if (pTemp->nAttribType == magic_steallife_p)
	{
		pDes->nAttribType = magic_steallife_p;
		pDes->nValue[0] = pTemp->nValue[0];
		pDes->nValue[1] = pTemp->nValue[1];
		pDes->nValue[2] = pTemp->nValue[2];

	}
	if (bIsPhysical)
		pDes->nValue[0] += m_CurrentLifeStolen;
	pTemp++;
	pDes++;
	if (pTemp->nAttribType == magic_stealmana_p)
	{
		pDes->nAttribType = magic_stealmana_p;
		pDes->nValue[0] = pTemp->nValue[0];
		pDes->nValue[1] = pTemp->nValue[1];
		pDes->nValue[2] = pTemp->nValue[2];

	}
	if (bIsPhysical)
		pDes->nValue[0] += m_CurrentManaStolen;
	pTemp++;
	pDes++;
	if (pTemp->nAttribType == magic_stealstamina_p)
	{
		pDes->nAttribType = magic_stealstamina_p;
		pDes->nValue[0] = pTemp->nValue[0];
		pDes->nValue[1] = pTemp->nValue[1];
		pDes->nValue[2] = pTemp->nValue[2];

	}
	if (bIsPhysical)
		pDes->nValue[0] += m_CurrentStaminaStolen;
	pTemp++;
	pDes++;
	if (pTemp->nAttribType == magic_physicsenhance_p)
	{
		pDes->nAttribType = magic_physicsdamage_v;
		pDes->nValue[0] = nMinDamage * (MAX_PERCENT + (pTemp->nValue[0] + (pTemp->nValue[0] * nAddDamageP / MAX_PERCENT))) / MAX_PERCENT;
		pDes->nValue[2] = nMaxDamage * (MAX_PERCENT + (pTemp->nValue[0] + (pTemp->nValue[0] * nAddDamageP / MAX_PERCENT))) / MAX_PERCENT;
		if (IsPlayer())
		{
			//Fix damage
			if (m_nPlayerIdx <= 0 || m_nPlayerIdx >= MAX_PLAYER)
			{
				printf("Loi tinh dame pidx xuat chieu !\n");
				return;
			}
			if (Player[m_nPlayerIdx].m_ItemList.GetWeaponType() == equip_meleeweapon)
			{
				if (Player[m_nPlayerIdx].m_ItemList.GetWeaponParticular() >= MAX_MELEE_WEAPON || Player[m_nPlayerIdx].m_ItemList.GetWeaponParticular() < 0)
				{
					printf("Loi tinh dame vu khi xuat chieu !\n");
					return;
				}


				pDes->nValue[0] += nMinDamage * m_CurrentMeleeEnhance[Player[m_nPlayerIdx].m_ItemList.GetWeaponParticular()] / MAX_PERCENT;
				pDes->nValue[2] += nMaxDamage * m_CurrentMeleeEnhance[Player[m_nPlayerIdx].m_ItemList.GetWeaponParticular()] / MAX_PERCENT;
			}
			else if (Player[m_nPlayerIdx].m_ItemList.GetWeaponType() == equip_rangeweapon)
			{
				pDes->nValue[0] += nMinDamage * m_CurrentRangeEnhance / MAX_PERCENT;
				pDes->nValue[2] += nMaxDamage * m_CurrentRangeEnhance / MAX_PERCENT;
			}
			else	// ����
			{
				pDes->nValue[0] += nMinDamage * m_CurrentHandEnhance / MAX_PERCENT;
				pDes->nValue[2] += nMaxDamage * m_CurrentHandEnhance / MAX_PERCENT;
			}
			//End code
		}
	}
	else if (pTemp->nAttribType == magic_physicsdamage_v)
	{
		pDes->nAttribType = magic_physicsdamage_v;
		pDes->nValue[0] = pTemp->nValue[0] + (pTemp->nValue[0] * nAddDamageP / MAX_PERCENT);
		pDes->nValue[2] = pTemp->nValue[2] + (pTemp->nValue[2] * nAddDamageP / MAX_PERCENT);

		if (!bIsPhysical)
	    {
			pDes->nValue[0] += m_PhysicsMagic.nValue[0] + m_CurrentAddPhysicsMagic;
			pDes->nValue[2] += m_PhysicsMagic.nValue[2] + m_CurrentAddPhysicsMagic;

         pDes->nValue[0] += (pDes->nValue[0] * DamePecentToLevel)/MAX_PERCENT;
		 pDes->nValue[2] += (pDes->nValue[2] * DamePecentToLevel)/MAX_PERCENT;
	    }
	}
	pTemp++;
	pDes++;
	//Damage bang
	if (pTemp->nAttribType == magic_colddamage_v)
	{
		//Fix damage
		pDes->nAttribType = magic_colddamage_v;
		pDes->nValue[0] = pTemp->nValue[0] * (MAX_PERCENT + nAddDamageP) / MAX_PERCENT;
		pDes->nValue[1] = pTemp->nValue[1] + m_CurrentColdEnhance;
		pDes->nValue[2] = pTemp->nValue[2] * (MAX_PERCENT + nAddDamageP) / MAX_PERCENT;

		if (!bIsPhysical)
		{
			pDes->nValue[0] += m_CurrentColdMagic.nValue[0];
			pDes->nValue[1] = max(pDes->nValue[1], m_CurrentColdMagic.nValue[1] + m_CurrentColdEnhance);
			pDes->nValue[2] += m_CurrentColdMagic.nValue[2];

			pDes->nValue[0] += (pDes->nValue[0] * DamePecentToLevel) / MAX_PERCENT;
			pDes->nValue[2] += (pDes->nValue[2] * DamePecentToLevel) / MAX_PERCENT;
		}
		//end code
	}
	if (bIsPhysical)
	{
		pDes->nValue[0] += m_CurrentColdDamage.nValue[0];
		pDes->nValue[1] = max(pDes->nValue[1], m_CurrentColdDamage.nValue[1] + m_CurrentColdEnhance);
		pDes->nValue[2] += m_CurrentColdDamage.nValue[2];
	}
	pDes->nValue[0] += pDes->nValue[0] * m_CurrentColdDamageMinPercent / MAX_PERCENT;
	pDes->nValue[2] += pDes->nValue[2] * m_CurrentColdDamageMaxPercent / MAX_PERCENT;
	pTemp++;
	pDes++;
	//Damage Hoa
	if (pTemp->nAttribType == magic_firedamage_v)
	{
		//Fix damage
		pDes->nAttribType = magic_firedamage_v;
		pDes->nValue[0] = pTemp->nValue[0] * (MAX_PERCENT + nAddDamageP) / MAX_PERCENT + pTemp->nValue[0] * (MAX_PERCENT + nAddDamageP - 100) / MAX_PERCENT * m_CurrentFireEnhance / MAX_PERCENT;
		pDes->nValue[2] = pTemp->nValue[2] * (MAX_PERCENT + nAddDamageP) / MAX_PERCENT + pTemp->nValue[2] * (MAX_PERCENT + nAddDamageP - 100) / MAX_PERCENT * m_CurrentFireEnhance / MAX_PERCENT;

		if (!bIsPhysical)
		{
			pDes->nValue[0] += m_CurrentFireDamage.nValue[0] + m_CurrentFireDamage.nValue[0] * m_CurrentFireEnhance / MAX_PERCENT;
			pDes->nValue[2] += m_CurrentFireDamage.nValue[2] + m_CurrentFireDamage.nValue[2] * m_CurrentFireEnhance / MAX_PERCENT;

			pDes->nValue[0] += (pDes->nValue[0] * DamePecentToLevel) / MAX_PERCENT;
			pDes->nValue[2] += (pDes->nValue[2] * DamePecentToLevel) / MAX_PERCENT;
		}
		//end code
	}
	if (bIsPhysical)
	{
		pDes->nValue[0] += m_CurrentFireDamage.nValue[0] + m_CurrentFireDamage.nValue[0] * m_CurrentFireEnhance /MAX_PERCENT;
		pDes->nValue[2] += m_CurrentFireDamage.nValue[2] + m_CurrentFireDamage.nValue[2] * m_CurrentFireEnhance /MAX_PERCENT;
	}
	pTemp++;
	pDes++;
	//Damage Loi
	if (pTemp->nAttribType == magic_lightingdamage_v)
	{
		//Fix damage
		pDes->nAttribType = magic_lightingdamage_v;
		pDes->nValue[0] = pTemp->nValue[0] * (MAX_PERCENT + nAddDamageP) / MAX_PERCENT + (pTemp->nValue[2] * (MAX_PERCENT + nAddDamageP) / MAX_PERCENT - pTemp->nValue[0] * (MAX_PERCENT + nAddDamageP) / MAX_PERCENT) * m_CurrentLightEnhance / MAX_PERCENT;
		pDes->nValue[2] = pTemp->nValue[2] * (MAX_PERCENT + nAddDamageP) / MAX_PERCENT;

		if (!bIsPhysical)
		{
			pDes->nValue[0] += m_CurrentLightDamage.nValue[0];
			pDes->nValue[2] += m_CurrentLightDamage.nValue[2];

			pDes->nValue[0] += (pDes->nValue[0] * DamePecentToLevel) / MAX_PERCENT;
			pDes->nValue[2] += (pDes->nValue[2] * DamePecentToLevel) / MAX_PERCENT;
		}
		//end code*/

	}
	if (bIsPhysical)
	{
		pDes->nValue[0] += m_CurrentLightDamage.nValue[0];
		pDes->nValue[2] += m_CurrentLightDamage.nValue[2];
	}
	pTemp++;
	pDes++;
	//Damage tho
	if (pTemp->nAttribType == magic_earthdamage_v)
	{
		//Fix damage
		pDes->nAttribType = magic_earthdamage_v;
		pDes->nValue[0] = pTemp->nValue[0] * (MAX_PERCENT + nAddDamageP) / MAX_PERCENT + (pTemp->nValue[2] * (MAX_PERCENT + nAddDamageP) / MAX_PERCENT - pTemp->nValue[0] * (MAX_PERCENT + nAddDamageP) / MAX_PERCENT) * m_CurrentEarthEnhance / MAX_PERCENT;
		pDes->nValue[2] = pTemp->nValue[2] * (MAX_PERCENT + nAddDamageP) / MAX_PERCENT;

		if (!bIsPhysical)
		{
			pDes->nValue[0] += m_CurrentEarthDamage.nValue[0];
			pDes->nValue[2] += m_CurrentEarthDamage.nValue[2];

			pDes->nValue[0] += (pDes->nValue[0] * DamePecentToLevel) / MAX_PERCENT;
			pDes->nValue[2] += (pDes->nValue[2] * DamePecentToLevel) / MAX_PERCENT;
		}
		//end code*/

	}
	if (bIsPhysical)
	{
		pDes->nValue[0] += m_CurrentEarthDamage.nValue[0];
		pDes->nValue[2] += m_CurrentEarthDamage.nValue[2];
	}
	pTemp++;
	pDes++;
	// TamLTM Fix damage doc
	// if (pTemp->nAttribType == magic_poisondamage_v)
	// {
	// 	pDes->nAttribType = magic_poisondamage_v;
	// 	pDes->nValue[0] = pTemp->nValue[0] + (pTemp->nValue[0] * nAddDamageP / MAX_PERCENT) / MAX_PERCENT;
	// 	pDes->nValue[1] = pTemp->nValue[1];
	// 	pDes->nValue[2] = pTemp->nValue[2] * (MAX_PERCENT - m_CurrentPoisonEnhance) / MAX_PERCENT;
	// 	if (pDes->nValue[2] <= 0)
	// 		pDes->nValue[2] = 1;

	// 	if (!bIsPhysical) //!bIsPhysical phu dinh Damage noi ngoai cong
	// 	{
	// 		g_NpcAttribModify.MixPoisonDamage(pDes, &m_CurrentPoisonMagic);
	// 		pDes->nValue[0] = m_PhysicsMagic.nValue[0] + pTemp->nValue[0] * (MAX_PERCENT - m_CurrentPoisonEnhance) / MAX_PERCENT;
	// 		pDes->nValue[2] = m_PhysicsMagic.nValue[2] + pTemp->nValue[2] * (MAX_PERCENT - m_CurrentPoisonEnhance) / MAX_PERCENT;


	// 		pDes->nValue[0] += pDes->nValue[0];
	// 		pDes->nValue[2] += pDes->nValue[2];

	// 	}
	// }
	// if (bIsPhysical)
	// 	g_NpcAttribModify.MixPoisonDamage(pDes, &m_CurrentPoisonDamage);
	// //End code

	// pTemp++;
	// pDes++;
	if (pTemp->nAttribType == magic_stun_p)
	{
		pDes->nAttribType = magic_stun_p;
		pDes->nValue[0] = pTemp->nValue[0];
		pDes->nValue[1] = pTemp->nValue[1];
		pDes->nValue[2] = pTemp->nValue[2];
	}
	pTemp++;
	pDes++;
	if (pTemp->nAttribType == magic_ignorenegativestate_p)
	{
		pDes->nAttribType = magic_ignorenegativestate_p;
		pDes->nValue[0] = pTemp->nValue[0];
		pDes->nValue[1] = pTemp->nValue[1];
		pDes->nValue[2] = pTemp->nValue[2];
	}
	pTemp++;
	pDes++;
	if (pTemp->nAttribType == magic_randmove)
	{
		pDes->nAttribType = magic_randmove;
		pDes->nValue[0] = pTemp->nValue[0];
		pDes->nValue[1] = pTemp->nValue[1];
		pDes->nValue[2] = pTemp->nValue[2];
	}
}

void KNpc::ServerMove(int MoveSpeed)
{
	//TamLTM Debug
//	g_DebugLog("ServerMove(int MoveSpeed)");

//	if (m_Doing != do_walk && m_Doing != do_run && m_Doing != do_hurt && m_Doing != do_runattack)
//		return;
	//TamLTM fix
	if (m_Doing != do_walk && m_Doing != do_run && m_Doing != do_hurt && m_Doing != do_runattack && m_Doing != do_goattack)
		return;
	//end code

	if (MoveSpeed <= 0)
		return;

	if (MoveSpeed >= SubWorld[m_SubWorldIndex].m_nCellWidth)
	{
		MoveSpeed = SubWorld[m_SubWorldIndex].m_nCellWidth - 1;
	}

#ifndef _SERVER
	if (m_RegionIndex < 0 || m_RegionIndex >= 9)
	{
		g_DebugLog("Npc (%d) ServerMove RegionIdx = %d", m_Index, m_RegionIndex);
		//_ASSERT(0);
		DoStand();
		return;
	}
#else
	_ASSERT(m_RegionIndex >= 0);
	if (m_RegionIndex < 0)
		return;
#endif
	int x, y;

	SubWorld[m_SubWorldIndex].Map2Mps(m_RegionIndex, m_MapX, m_MapY, 0, 0, &x, &y);
	x = (x << 10) + m_OffX;
	y = (y << 10) + m_OffY;

	int nRet = m_PathFinder.GetDir(x, y, m_Dir, m_DesX, m_DesY, MoveSpeed, &m_Dir);

#ifndef _SERVER
	if(nRet == 1)
	{
		x = g_DirCos(m_Dir, 64) * MoveSpeed;
		y = g_DirSin(m_Dir, 64) * MoveSpeed;
	}
	else if (nRet == 0)
	{
		DoStand();
		return;
	}
	else if (nRet == -1)
	{
		SubWorld[0].m_Region[m_RegionIndex].RemoveNpc(m_Index);
		SubWorld[0].m_Region[m_RegionIndex].DecRef(m_MapX, m_MapY, obj_npc);
		m_RegionIndex = -1;
		return;
	}
	else
	{
		return;
	}
#endif
#ifdef _SERVER
	if(nRet == 1)
	{
		x = g_DirCos(m_Dir, 64) * MoveSpeed;
		y = g_DirSin(m_Dir, 64) * MoveSpeed;
	}
	else
	{
		DoStand();
		return;
	}
#endif

	int nOldRegion = m_RegionIndex;
	int nOldMapX = m_MapX;
	int nOldMapY = m_MapY;
	int nOldOffX = m_OffX;
	int nOldOffY = m_OffY;

	m_OffX += x;
	m_OffY += y;

	if (!m_bClientOnly)
		CURREGION.DecRef(m_MapX, m_MapY, obj_npc);

	if (m_OffX < 0)
	{
		m_MapX--;
		m_OffX += CELLWIDTH;
	}
	else if (m_OffX > CELLWIDTH)
	{
		m_MapX++;
		m_OffX -= CELLWIDTH;
	}

	if (m_OffY < 0)
	{
		m_MapY--;
		m_OffY += CELLHEIGHT;
	}
	else if (m_OffY > CELLHEIGHT)
	{
		m_MapY++;
		m_OffY -= CELLHEIGHT;
	}

	if (m_MapX < 0)
	{
		m_RegionIndex = LEFTREGIONIDX;
		m_MapX += REGIONWIDTH;
	}
	else if (m_MapX >= REGIONWIDTH)
	{
		m_RegionIndex = RIGHTREGIONIDX;
		m_MapX -= REGIONWIDTH;
	}

	if (m_RegionIndex >= 0)
	{
		if (m_MapY < 0)
		{
			m_RegionIndex = UPREGIONIDX;
			m_MapY += REGIONHEIGHT;
		}
		else if (m_MapY >= REGIONHEIGHT)
		{
			m_RegionIndex = DOWNREGIONIDX;
			m_MapY -= REGIONHEIGHT;
		}
		if (!m_bClientOnly && m_RegionIndex >= 0)
			CURREGION.AddRef(m_MapX, m_MapY, obj_npc);
	}

	if (m_RegionIndex == -1)
	{
		m_RegionIndex = nOldRegion;
		m_MapX = nOldMapX;
		m_MapY = nOldMapY;
		m_OffX = nOldOffX;
		m_OffY = nOldOffY;
		CURREGION.AddRef(m_MapX, m_MapY, obj_npc);
		return;
	}

	if (nOldRegion != m_RegionIndex)
	{
#ifdef _SERVER
		SubWorld[m_SubWorldIndex].NpcChangeRegion(nOldRegion, m_RegionIndex, m_Index);
		if (IsPlayer())
		{
			SubWorld[m_SubWorldIndex].PlayerChangeRegion(nOldRegion, m_RegionIndex, m_nPlayerIdx);
			if (m_nPlayerIdx > 0)
			{
				Player[m_nPlayerIdx].m_ItemList.Abrade(enumAbradeMove);
			}
		}
#else
		SubWorld[0].NpcChangeRegion(SubWorld[0].m_Region[nOldRegion].m_RegionID, SubWorld[0].m_Region[m_RegionIndex].m_RegionID, m_Index);
		m_dwRegionID = SubWorld[0].m_Region[m_RegionIndex].m_RegionID;
#endif
	}
}

void KNpc::ServerJump(int nSpeed)
{
	//TamLTM Debug
//	g_DebugLog("ServerJump(int nSpeed)");

	_ASSERT(m_RegionIndex >= 0);
	if (m_RegionIndex < 0)
		return;

	if (!(m_Doing == do_jump || m_Doing == do_jumpattack))
		return;

	if (nSpeed <= 0)
		return;

	if (nSpeed >= SubWorld[m_SubWorldIndex].m_nCellWidth)
	{
		nSpeed = SubWorld[m_SubWorldIndex].m_nCellWidth - 1;
	}

	m_OffX += g_DirCos(m_JumpDir, 64) * nSpeed;
	m_OffY += g_DirSin(m_JumpDir, 64) * nSpeed;

	// s = vt - a * t * t / 2
	m_Height = (m_JumpFirstSpeed * m_Frames.nCurrentFrame - ACCELERATION_OF_GRAVITY * m_Frames.nCurrentFrame * m_Frames.nCurrentFrame / 2) / 8;
	if (m_Height < 0)
		m_Height = 0;

	int nOldRegion = m_RegionIndex;
	int nOldMapX = m_MapX;
	int nOldMapY = m_MapY;
	int nOldOffX = m_OffX;
	int nOldOffY = m_OffY;
	CURREGION.DecRef(m_MapX, m_MapY, obj_npc);

	if (m_OffX < 0)
	{
		m_MapX--;
		m_OffX += CELLWIDTH;
	}
	else if (m_OffX > CELLWIDTH)
	{
		m_MapX++;
		m_OffX -= CELLWIDTH;
	}

	if (m_OffY < 0)
	{
		m_MapY--;
		m_OffY += CELLHEIGHT;
	}
	else if (m_OffY > CELLHEIGHT)
	{
		m_MapY++;
		m_OffY -= CELLHEIGHT;
	}

	if (m_MapX < 0)
	{
		m_RegionIndex = LEFTREGIONIDX;
		m_MapX += REGIONWIDTH;
	}
	else if (m_MapX >= REGIONWIDTH)
	{
		m_RegionIndex = RIGHTREGIONIDX;
		m_MapX -= REGIONWIDTH;
	}

	if (m_RegionIndex >= 0)
	{
		if (m_MapY < 0)
		{
			m_RegionIndex = UPREGIONIDX;
			m_MapY += REGIONHEIGHT;
		}
		else if (m_MapY >= REGIONHEIGHT)
		{
			m_RegionIndex = DOWNREGIONIDX;
			m_MapY -= REGIONHEIGHT;
		}
		if (m_RegionIndex >= 0)
			CURREGION.AddRef(m_MapX, m_MapY, obj_npc);
	}

	if (m_RegionIndex == -1)	// �������ƶ���-1 Region�������������������ָ�ԭ����
	{
		m_RegionIndex = nOldRegion;
		m_MapX = nOldMapX;
		m_MapY = nOldMapY;
		m_OffX = nOldOffX;
		m_OffY = nOldOffY;
		CURREGION.AddRef(m_MapX, m_MapY, obj_npc);
		return;
	}

	if (nOldRegion != m_RegionIndex)
	{
#ifdef _SERVER
		SubWorld[m_SubWorldIndex].NpcChangeRegion(nOldRegion, m_RegionIndex, m_Index);
		if (IsPlayer())
		{
			SubWorld[m_SubWorldIndex].PlayerChangeRegion(nOldRegion, m_RegionIndex, m_nPlayerIdx);
			if (m_nPlayerIdx > 0)
			{
				Player[m_nPlayerIdx].m_ItemList.Abrade(enumAbradeMove);
			}
		}
#else
		if (m_RegionIndex >= 0)
		{
			SubWorld[0].NpcChangeRegion(SubWorld[0].m_Region[nOldRegion].m_RegionID, SubWorld[0].m_Region[m_RegionIndex].m_RegionID, m_Index);
			m_dwRegionID = SubWorld[0].m_Region[m_RegionIndex].m_RegionID;
		}
#endif
	}
}
/*
void KNpc::SendCommand(NPCCMD cmd,int x,int y, int z)
{
	m_Command.CmdKind = cmd;
	m_Command.Param_X = x;
	m_Command.Param_Y = y;
	m_Command.Param_Z = z;
}
*/
void KNpc::SendCommand(NPCCMD cmd,int x,int y, int z)
{
	if (cmd == do_run)
	{
		if ((m_CurrentStamina < PlayerSet.m_cPlayerStamina.m_nKillRunSub &&
			m_nPKFlag == enumPKMurder) ||
			(m_CurrentStamina < PlayerSet.m_cPlayerStamina.m_nTongWarRunSub &&
				m_nPKFlag == enumPKTongWar))
		{
			cmd = do_walk;
		}
	}

//	g_DebugLog("CmdKind");
	//TamLTM fix hot
	if (m_FrozenAction.nTime > 0)
	{
		if (cmd == do_walk ||
			cmd == do_run ||
			cmd == do_runattack ||
			cmd == do_jump ||
			cmd == do_jumpattack ||
			cmd == do_skill ||
			cmd == do_magic ||
			cmd == do_attack ||
			cmd == do_blurmove)
		{
			return;
		}
	}

	if (m_RandMove.nTime > 0)
	{
		if (cmd == do_run ||
			cmd == do_runattack ||
			cmd == do_jump ||
			cmd == do_jumpattack ||
			cmd == do_skill ||
			cmd == do_magic ||
			cmd == do_attack ||
			cmd == do_blurmove)
		{
			return;
		}
	} //*/
	m_Command.CmdKind = cmd;
	m_Command.Param_X = x;
	m_Command.Param_Y = y;
	m_Command.Param_Z = z;
}

BOOL KNpc::NewPath(int nMpsX, int nMpsY)
{
	m_DesX = nMpsX;
	m_DesY = nMpsY;
	return TRUE;
}

// Rao chan nBarrier
BOOL KNpc::NewJump(int nMpsX, int nMpsY)
{
	//TamLTM Debug
//	g_DebugLog("NewJump(int nMpsX, int nMpsY)");

//	_ASSERT(m_CurrentJumpSpeed > 0);
	if (m_CurrentJumpSpeed <= 0)
		return FALSE;

	int nX, nY;
	GetMpsPos(&nX, &nY);

	if (nX == nMpsX && nY == nMpsY)
		return FALSE;


	int nRangeCheckL = (nX - nMpsX) * (nX - nMpsX) + (nY - nMpsY) * (nY - nMpsY);

	if (nRangeCheckL <= 32 * 32)
		return FALSE;


	int nDir = g_GetDirIndex(nX, nY, nMpsX, nMpsY);
	int	nMaxLength = m_CurrentJumpSpeed * m_CurrentJumpFrame;
	int	nWantLength = g_GetDistance(nX, nY, nMpsX, nMpsY);
	int	nSin = g_DirSin(nDir, 64);
	int	nCos = g_DirCos(nDir, 64);

	if (nWantLength > nMaxLength)
	{
		m_DesX = nX + ((nMaxLength * nCos) >> 10);
		m_DesY = nY + ((nMaxLength * nSin) >> 10);
		nWantLength = nMaxLength;
	}
	else if (nWantLength <= MIN_DOMELEE_RANGE)
	{
		m_DesX = nMpsX;
		m_DesY = nMpsY;
		return FALSE;
	}

	m_JumpStep = nWantLength / m_CurrentJumpSpeed;

	int nTestX = 0;
	int nTestY = 0;
	int nSuccessStep = 0;

	for (int i = 1; i < m_JumpStep + 1; i++)
	{
		nTestX = nX + ((m_CurrentJumpSpeed * nCos * i) >> 10);
		nTestY = nY + ((m_CurrentJumpSpeed * nSin * i) >> 10);
		int nBarrier = SubWorld[m_SubWorldIndex].GetBarrier(nTestX, nTestY);
		DWORD	dwTrap = SubWorld[m_SubWorldIndex].GetTrap(nTestX, nTestY);
		if (Obstacle_NULL == nBarrier && dwTrap == 0)
		{
			nSuccessStep = i;
		}
		if (Obstacle_Normal == nBarrier || Obstacle_Fly == nBarrier || dwTrap)
		{
			if (nSuccessStep <= MIN_DOMELEE_RANGE / m_CurrentJumpSpeed)
			{
				return FALSE;
			}
			m_DesX = nX + ((m_CurrentJumpSpeed * nCos * nSuccessStep) >> 10);
			m_DesY = nY + ((m_CurrentJumpSpeed * nSin * nSuccessStep) >> 10);
			m_JumpStep = nSuccessStep;
			break;
		}
	}
	m_JumpDir = nDir;
	return TRUE;
}

BOOL KNpc::Cost(NPCATTRIB nType, int nCost, BOOL bIsAudit, BOOL bNotShowMessage)
{
	if (!IsPlayer())
		return TRUE;

	int *pSource = NULL;
	int nCurCost = nCost;
	switch(nType)
	{
	case attrib_mana_v:
		pSource = &m_CurrentMana;
		break;
	case attrib_mana_p:
		pSource = &m_CurrentMana;
		nCurCost = m_CurrentManaMax * nCost / MAX_PERCENT;
		break;
	case attrib_life_v:
		pSource = &m_CurrentLife;
		break;
	case attrib_life_p:
		pSource = &m_CurrentLife;
		nCurCost = m_CurrentLifeMax * nCost / MAX_PERCENT;
		break;
	case attrib_stamina_v:
		pSource = &m_CurrentStamina;
		break;
	case attrib_stamina_p:
		pSource = &m_CurrentStamina;
		nCurCost = m_CurrentStaminaMax * nCost / MAX_PERCENT;
		break;
	default:
		break;
	}

	if (pSource)
	{
		if ((nType== attrib_life_v || nType== attrib_life_p)? ((*pSource-1) < nCurCost):(*pSource < nCurCost))
		{
			if (!bNotShowMessage)
			{
#ifndef _SERVER
				KSystemMessage Msg;

				Msg.byConfirmType = SMCT_NONE;
				Msg.byParamSize = 0;
				Msg.byPriority = 1;
				Msg.eType = SMT_NORMAL;
				switch(nType)
				{
				case attrib_mana_v:
				case attrib_mana_p:
					g_StrCpyLen(Msg.szMessage, MSG_NPC_NO_MANA, sizeof(Msg.szMessage));
					break;
				case attrib_life_v:
				case attrib_life_p:
					g_StrCpyLen(Msg.szMessage, MSG_NPC_NO_LIFE, sizeof(Msg.szMessage));
					break;
				case attrib_stamina_v:
				case attrib_stamina_p:
					g_StrCpyLen(Msg.szMessage, MSG_NPC_NO_STAMINA, sizeof(Msg.szMessage));
					break;
				default:
					break;
				}
				CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&Msg, NULL);
#endif
			}
			return FALSE;
		}
		else
		{
#ifdef _SERVER
			if (!bIsAudit)
				*pSource -= nCurCost;
#endif
			return TRUE;
		}
	}
	return FALSE;
}

#ifdef _SERVER
void KNpc::Cast(int nSkillId, int nSkillLevel)
{
	if (nSkillId < MAX_SKILL && nSkillLevel < MAX_SKILLLEVEL)
	{
		int nMpsX, nMpsY;
		SubWorld[m_SubWorldIndex].Map2Mps(m_RegionIndex, m_MapX, m_MapY, m_OffX, m_OffY, &nMpsX, &nMpsY);
		_ASSERT(nSkillId < MAX_SKILL && nSkillLevel < MAX_SKILLLEVEL);

PHONGTHAN_SKILL_CAST SkillCmd;
				ZeroMemory(&SkillCmd, sizeof(SkillCmd));
				PhongThanInitializeWireHeader(&SkillCmd.Header, PHONGTHAN_MSG_GAMEPLAY_SKILL_CAST,
					sizeof(SkillCmd), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
				SkillCmd.MapId = SubWorld[m_SubWorldIndex].m_SubWorldID;
		SkillCmd.EntityId = this->m_dwID;
		SkillCmd.SkillId = nSkillId;
		SkillCmd.SkillLevel = nSkillLevel;
		SkillCmd.TargetKind = PHONGTHAN_SKILL_TARGET_ENTITY;
		SkillCmd.TargetId = m_dwID;
		SkillCmd.DirectEffect = 1;

		POINT	POff[8] =
		{
			{0, 32},
			{-16, 32},
			{-16, 0},
			{-16, -32},
			{0, -32},
			{16, -32},
			{16, 0},
			{16, 32},
		};

		int nMaxCount = MAX_BROADCAST_COUNT;
		CURREGION.BroadCast(&SkillCmd, sizeof(SkillCmd), nMaxCount, m_MapX, m_MapY);
		int i;
		for (i = 0; i < 8; i++)
		{
			if (CONREGIONIDX(i) == -1)
				continue;
			CONREGION(i).BroadCast(&SkillCmd, sizeof(SkillCmd), nMaxCount, m_MapX - POff[i].x, m_MapY - POff[i].y);
		}

		KSkill * pOrdinSkill = (KSkill *) g_SkillManager.GetSkill(nSkillId, nSkillLevel);
		pOrdinSkill->Cast(m_Index, nMpsX, nMpsY);

		if(!pOrdinSkill->IsAura())
		{
			DWORD dwCastTime = 0;
			eSkillStyle eStyle = (eSkillStyle)pOrdinSkill->GetSkillStyle();
			if (eStyle == SKILL_SS_Missles
				|| eStyle == SKILL_SS_Melee
				|| eStyle == SKILL_SS_InitiativeNpcState
				|| eStyle == SKILL_SS_PassivityNpcState
				|| eStyle == SKILL_SS_PhongThanAttack
				|| eStyle == SKILL_SS_PhongThanProduce
				|| eStyle == SKILL_SS_PhongThanAwaken)
			{
				dwCastTime = pOrdinSkill->GetDelayPerCast(m_bRideHorse);
			}
			else
			{
				switch(eStyle)
				{
				case SKILL_SS_Thief:
					{
						dwCastTime = ((KThiefSkill*)pOrdinSkill)->GetDelayPerCast();
					}break;
				}
			}
			m_SkillList.SetNextCastTime(nSkillId, SubWorld[m_SubWorldIndex].m_dwCurrentTime, SubWorld[m_SubWorldIndex].m_dwCurrentTime + dwCastTime);
		}
	}
}
#endif

//Nhay
void KNpc::DoJump()
{

	//_ASSERT(m_RegionIndex >= 0);
	if (m_RegionIndex < 0)
		return;

	if (m_Doing == do_jump)
		return;
#ifndef _SERVER
	if(m_WalkRun.nTime)
		m_DataRes.SetBlur(TRUE);
#endif
	m_Doing = do_jump;
	m_Dir = m_JumpDir;
	m_ProcessAI	= 0;
	m_JumpFirstSpeed = ACCELERATION_OF_GRAVITY * (m_JumpStep - 1) / 2 ;
#ifdef _SERVER	// ����Χ9��Region�㲥������
	PHONGTHAN_ENTITY_MOVE NetCommand;
	ZeroMemory(&NetCommand, sizeof(NetCommand));
	PhongThanInitializeWireHeader(&NetCommand.Header, PHONGTHAN_MSG_WORLD_ENTITY_MOVE,
		sizeof(NetCommand), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	NetCommand.MapId = SubWorld[m_SubWorldIndex].m_SubWorldID;
	NetCommand.EntityId = m_dwID;
	NetCommand.Mode = PHONGTHAN_MOVE_JUMP;
	NetCommand.X = m_DesX;
	NetCommand.Y = m_DesY;

	POINT	POff[8] =
	{
		{0, 32},
		{-16, 32},
		{-16, 0},
		{-16, -32},
		{0, -32},
		{16, -32},
		{16, 0},
		{16, 32},
	};
	int nMaxCount = MAX_BROADCAST_COUNT;
	CURREGION.BroadCast(&NetCommand, sizeof(NetCommand), nMaxCount, m_MapX, m_MapY);
	for (int i= 0; i < 8; i++)
	{
		if (CONREGIONIDX(i) == -1)
			continue;
		CONREGION(i).BroadCast(&NetCommand, sizeof(NetCommand), nMaxCount, m_MapX - POff[i].x, m_MapY - POff[i].y);
	}
#endif

#ifndef _SERVER
		m_ClientDoing = cdo_jump;
#endif

	m_Frames.nTotalFrame = m_JumpStep;
	m_Frames.nCurrentFrame = 0;
}

BOOL KNpc::OnJump()
{
	ServerJump(m_CurrentJumpSpeed);
	if (WaitForFrame())
	{
		DoStand();
		m_ProcessAI	= 1;
//#ifndef _SERVER
//		m_DataRes.SetBlur(FALSE);
//#endif
		return FALSE;
	}
	return TRUE;
}

BOOL KNpc::WaitForFrame()
{
	m_Frames.nCurrentFrame++;
	if (m_Frames.nCurrentFrame < m_Frames.nTotalFrame)
	{
		return FALSE;
	}
	m_Frames.nCurrentFrame = 0;
	return TRUE;
}

BOOL KNpc::IsReachFrame(int nPercent)
{
	if (m_Frames.nCurrentFrame == m_Frames.nTotalFrame * nPercent / MAX_PERCENT)
	{
		return TRUE;
	}
	return FALSE;
}

//�ͻ��˴�����õ���NpcSettingIdx�ǰ�����16λNpc��ģ������16λΪ�ȼ�
#ifndef _SERVER
// VNG Phong Than uses its original GBK character row keys. Keep this mapping
// in client logic so the authoritative VNG resource tables remain untouched.
static void GetPhongThanPlayerResTypeName(int nNpcSettingIdx, int nSeries, char *pszNpcTypeName)
{
	if (!pszNpcTypeName)
		return;

	pszNpcTypeName[0] = 0;
	const BOOL bFemale = (nNpcSettingIdx == PLAYER_FEMALE_NPCTEMPLATEID);
	switch (nSeries)
	{
	case 1:
		strcpy(pszNpcTypeName, bFemale ? "\xC5\xAE\xCA\xF5\xCA\xBF" : "\xC4\xD0\xCA\xF5\xCA\xBF");
		break;
	case 2:
		strcpy(pszNpcTypeName, bFemale ? "\xC5\xAE\xD2\xEC\xC8\xCB" : "\xC4\xD0\xD2\xEC\xC8\xCB");
		break;
	case 3:
		strcpy(pszNpcTypeName, bFemale ? "\xC5\xAE\xD3\xF0\xCA\xBF" : "\xC4\xD0\xD3\xF0\xCA\xBF");
		break;
	case 0:
	default:
		// Series arrives after the initial add packet in some login sequences.
		// Use a valid VNG warrior body until the authoritative series is synced.
		strcpy(pszNpcTypeName, bFemale ? "\xC5\xAE\xBC\xD7\xCA\xBF" : "\xC4\xD0\xBC\xD7\xCA\xBF");
		break;
	}
}
#endif

void KNpc::Load(int nNpcSettingIdx, int nLevel)
{
	m_PathFinder.Init(m_Index);
	ZeroMemory(ActionScript, sizeof(ActionScript));
	m_ActionScriptID = 0;
	m_DeathScriptID = 0;
	m_TimerScriptID = 0;
	m_LevelScriptID = 0;
	m_dwNpcTimerDeadline = 0;
	m_nNpcTimerValue = 0;
	m_nDeathScriptPlayerIdx = 0;
	m_dwDeathScriptPlayerID = 0;
	if (nLevel <= 0)
	{
		nLevel = 1;
	}
	m_NpcSettingIdx = nNpcSettingIdx;
	m_Level = nLevel;

#ifndef _SERVER
	char	szNpcTypeName[32];
	szNpcTypeName[0] = 0;
#endif
	if (nNpcSettingIdx == PLAYER_MALE_NPCTEMPLATEID || nNpcSettingIdx == PLAYER_FEMALE_NPCTEMPLATEID)
	{
#ifndef _SERVER
		if (nNpcSettingIdx == PLAYER_MALE_NPCTEMPLATEID)
		{			
			g_DebugLog("m_Series %d",Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_Series);
			GetPhongThanPlayerResTypeName(m_NpcSettingIdx, m_Series, szNpcTypeName);
			m_StandFrame = NpcSet.GetPlayerStandFrame(TRUE);
			m_WalkFrame = NpcSet.GetPlayerWalkFrame(TRUE);
			m_RunFrame = NpcSet.GetPlayerRunFrame(TRUE);
		}
		else
		{
			GetPhongThanPlayerResTypeName(m_NpcSettingIdx, m_Series, szNpcTypeName);
			m_StandFrame = NpcSet.GetPlayerStandFrame(FALSE);
			m_WalkFrame = NpcSet.GetPlayerWalkFrame(FALSE);
			m_RunFrame = NpcSet.GetPlayerRunFrame(FALSE);
		}
#endif
		//		TODO: Load Player Data;
		m_WalkSpeed = NpcSet.GetPlayerWalkSpeed();
		m_RunSpeed = NpcSet.GetPlayerRunSpeed();
		m_AttackFrame = NpcSet.GetPlayerAttackFrame();
		m_HurtFrame	= NpcSet.GetPlayerHurtFrame();
	}
	else
	{
		GetNpcCopyFromTemplate(nNpcSettingIdx);

#ifndef _SERVER
		g_NpcSetting.GetString(nNpcSettingIdx + 2, "NpcResType", "", szNpcTypeName, sizeof(szNpcTypeName));
		if (!szNpcTypeName[0])
		{
			g_NpcKindFile.GetString(2, "CharacterName", "", szNpcTypeName, sizeof(szNpcTypeName));//���û�ҵ����õ�һ��npc����
		}
		g_NpcSetting.GetInteger(nNpcSettingIdx + 2, "AIMode", 12, &m_AiMode);
		g_NpcSetting.GetInteger(nNpcSettingIdx + 2, "AIParam1", 12, &m_AiParam[0]);
		g_NpcSetting.GetInteger(nNpcSettingIdx + 2, "AIParam2", 12, &m_AiParam[1]);
		g_NpcSetting.GetInteger(nNpcSettingIdx + 2, "AIParam3", 12, &m_AiParam[2]);
		g_NpcSetting.GetInteger(nNpcSettingIdx + 2, "AIParam4", 12, &m_AiParam[3]);
		g_NpcSetting.GetInteger(nNpcSettingIdx + 2, "AIParam5", 12, &m_AiParam[4]);
		g_NpcSetting.GetInteger(nNpcSettingIdx + 2, "AIParam6", 12, &m_AiParam[5]);
		g_NpcSetting.GetInteger(nNpcSettingIdx + 2, "AIParam7", 12, &m_AiParam[6]);
		g_NpcSetting.GetInteger(nNpcSettingIdx + 2, "ActiveRadius", 12, &m_ActiveRadius);
		g_NpcSetting.GetInteger(nNpcSettingIdx + 2, "ClientOnly", 0, &m_bClientOnly);
		// �����࣬11��12��17����AiParam[6]����߻��趨�߶???
		// add by flying
		if (m_AiMode == 11 || m_AiMode == 12 || m_AiMode == 17)
			m_AiParam[6] = m_AiMode;
#endif
	}
#ifndef _SERVER
	this->RemoveRes();
	m_DataRes.Init(szNpcTypeName, &g_NpcResList);

	BOOL bRenderRideHorse = m_bRideHorse && m_ClientDoing != cdo_jump;
	int nRenderDoing = m_ClientDoing;
	if (bRenderRideHorse && nRenderDoing == cdo_sit)
		nRenderDoing = cdo_stand;
	// Resolve the ride selector before the action so every component starts
	// from the same mounted action family.
	m_DataRes.SetRideHorse(bRenderRideHorse);
	m_DataRes.SetAction(nRenderDoing);
	m_DataRes.SetArmor(m_Appearance.Armor);
	m_DataRes.SetHelm(m_Appearance.Helm);
	m_DataRes.SetPhiPhong(m_Appearance.PhiPhong);

	m_DataRes.SetHorse(m_Appearance.Horse);
	m_DataRes.SetWeapon(m_Appearance.Weapon);
#endif
	m_CurrentCamp = m_Camp;
}

void KNpc::GetMpsPos(int *pPosX, int *pPosY)
{
#ifdef _SERVER
	SubWorld[m_SubWorldIndex].Map2Mps(m_RegionIndex, m_MapX, m_MapY, m_OffX, m_OffY, pPosX, pPosY);
	//g_DebugLog("1 %d + %d", pPosX, pPosY);
#else
	SubWorld[m_SubWorldIndex].Map2Mps(m_RegionIndex, m_MapX, m_MapY, m_OffX, m_OffY, pPosX, pPosY);
	//g_DebugLog("2 %d + %d", pPosX, pPosY);
#endif
}

BOOL	KNpc::SetActiveSkill(int nSkillIdx)
{
	if (nSkillIdx <= 0 || nSkillIdx >= MAX_NPCSKILL)
		return FALSE;

	if (m_SkillList.m_Skills[nSkillIdx].SkillId <= 0 || m_SkillList.m_Skills[nSkillIdx].CurrentSkillLevel <= 0)
		return FALSE;

	m_ActiveSkillID = m_SkillList.m_Skills[nSkillIdx].SkillId;

	int nCurLevel = m_SkillList.m_Skills[nSkillIdx].CurrentSkillLevel;

	_ASSERT(m_ActiveSkillID < MAX_SKILL && nCurLevel < MAX_SKILLLEVEL && nCurLevel > 0);

	ISkill * pISkill =  g_SkillManager.GetSkill(m_ActiveSkillID, nCurLevel);
	if (pISkill)
    {
		m_CurrentAttackRadius = pISkill->GetAttackRadius();
    }
	return TRUE;
}

void KNpc::SetAuraSkill(int nSkillID)
{
	if (nSkillID <= 0 || nSkillID >= MAX_SKILL)
    {
        nSkillID = 0;
    }
	else
	{
		if (m_SkillList.GetLevel(nSkillID) <= 0)
        {
            nSkillID = 0;
        }
		else
		{
			int nCurLevel = m_SkillList.GetCurrentLevel(m_ActiveAuraID); //Debug
			_ASSERT(nSkillID < MAX_SKILL && nCurLevel < MAX_SKILLLEVEL);

			KSkill * pOrdinSkill = (KSkill *)g_SkillManager.GetSkill(nSkillID, m_SkillList.GetCurrentLevel(nSkillID));
            if (!pOrdinSkill || !pOrdinSkill->IsAura())
			{
				nSkillID  = 0;
			}
		}
	}
	m_ActiveAuraID = nSkillID;

#ifndef _SERVER
	SKILL_CHANGEAURASKILL_COMMAND ChangeAuraMsg;
	ChangeAuraMsg.ProtocolType = c2s_changeauraskill;
	ChangeAuraMsg.m_nAuraSkill = m_ActiveAuraID;
	if (g_pClient)
		g_pClient->SendPackToServer(&ChangeAuraMsg, sizeof(SKILL_CHANGEAURASKILL_COMMAND));
#else
	UpdateNpcStateInfo();

#endif
}

BOOL KNpc::SetPlayerIdx(int nIdx)
{
	if (nIdx <= 0 || nIdx >= MAX_PLAYER)
		return FALSE;

	if (m_Kind != kind_player)
		return FALSE;

	m_nPlayerIdx = nIdx;
	return TRUE;
}

void KNpc::SwitchMaskFeature()
{
	m_bMaskFeature = !m_bMaskFeature;
///Dong bo player
#ifdef _SERVER
	PHONGTHAN_PLAYER_EVENT	sMsg;
	ZeroMemory(&sMsg, sizeof(sMsg));
	PhongThanInitializeWireHeader(&sMsg.Header, PHONGTHAN_MSG_UI_PLAYER_EVENT,
		sizeof(sMsg), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	sMsg.MapId = SubWorld[Npc[m_Index].m_SubWorldIndex].m_SubWorldID;
	sMsg.EntityId = Npc[m_Index].m_dwID;
	sMsg.Value = 0;
	sMsg.Operation = PHONGTHAN_PLAYER_MASK;

//	g_DebugLog("s2c_playersync %d", s2c_playersync); //TamLTM Debug error packet
	g_pServer->PackDataToClient(Player[m_nPlayerIdx].m_nNetConnectIdx, &sMsg, sizeof(sMsg));
#endif
/*//TamLTM fix send packet
#ifdef _SERVER
	S2C_PLAYER_SYNC_MASK_FEATURE	sMsg;
	sMsg.ProtocolType = s2c_playersyncmaskfeature;
	sMsg.m_wLength = sizeof(S2C_PLAYER_SYNC_MASK_FEATURE) - 1;
	sMsg.m_lpBuf = 0;
	sMsg.m_wMsgID = enumS2C_PLAYERSYNC_ID_MASKFEATURE;

	//	g_DebugLog("s2c_playersync %d", s2c_playersync); //TamLTM Debug error packet
	g_pServer->PackDataToClient(Player[m_nPlayerIdx].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
#endif */
}
//end code

#ifdef _SERVER
#include "PhongThanPlayerSnapshot.inl"
BOOL KNpc::SendSyncData(int nClient, BOOL bBroadCast/* = FALSE*/)
{
	BOOL	bRet = FALSE;
	if (m_SubWorldIndex < 0 || m_SubWorldIndex >= MAX_SUBWORLD ||
		SubWorld[m_SubWorldIndex].m_SubWorldID <= 0) return FALSE;
	PHONGTHAN_NPC_SNAPSHOT NpcSync;
	ZeroMemory(&NpcSync, sizeof(NpcSync));

	PhongThanInitializeWireHeader(&NpcSync.Header, PHONGTHAN_MSG_WORLD_NPC_SNAPSHOT,
		sizeof(NpcSync), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	NpcSync.MapId = SubWorld[m_SubWorldIndex].m_SubWorldID;
	NpcSync.Kind			= (BYTE)m_Kind;
	NpcSync.Camp				= (BYTE)m_Camp;
	NpcSync.CurrentCamp			= (BYTE)m_CurrentCamp;
	NpcSync.Series			= (BYTE)m_Series;
	NpcSync.Action = PhongThanEncodeEntityAction(m_Doing);

	NpcSync.MaxLife		= (int)m_CurrentLifeMax;
	if (m_CurrentLifeMax > 0)
		NpcSync.Life		= (int)m_CurrentLife;
	else
		NpcSync.Life		= 0;

	if (this->IsPlayer())
		NpcSync.MenuState	= (BYTE)Player[this->m_nPlayerIdx].m_cMenuState.m_nState;
	else
		NpcSync.MenuState	= 0;
	NpcSync.Direction = m_Dir;
	GetMpsPos((int *)&NpcSync.X, (int *)&NpcSync.Y);
	NpcSync.EntityId					= m_dwID;
	NpcSync.TemplateId = m_NpcSettingIdx;
	NpcSync.Level = (PHONGTHAN_U16)m_Level;

	NpcSync.Special				= (BYTE)m_btSpecial;
	NpcSync.MissionGroup		= (int)m_nMissionGroup;
	const char* pNetworkName = m_Kind == kind_player ?
		(Player[m_nPlayerIdx].m_bForbidName ? "" : Name) : GetNpcNetworkDisplayName(Name);
	strncpy((char*)NpcSync.Name, pNetworkName, sizeof(NpcSync.Name) - 1);
	NpcSync.Name[sizeof(NpcSync.Name) - 1] = 0;
	NpcSync.NameLength = (PHONGTHAN_U16)strlen((const char*)NpcSync.Name);

	if (bBroadCast)
	{
		this->SendDataToNearRegion((BYTE*)&NpcSync, sizeof(NpcSync));
	}
	else
	{
		if (SUCCEEDED(g_pServer->PackDataToClient(nClient, (BYTE*)&NpcSync, sizeof(NpcSync))))
		{
			//printf("Packing sync data ok...\n");
			bRet = TRUE;
		}
		else
		{
			printf("Packing sync data failed...\n");
			return FALSE;
		}
	}

//	g_DebugLog("[Sync]%d:%s<%d> request to %d. size:%d", SubWorld[m_SubWorldIndex].m_dwCurrentTime, Name, m_Kind, nClient, sizeof(NpcSync));
#ifdef _DEBUG
	g_DebugLog("[Sync]%d:%s<%d> request to %d. size:%d", SubWorld[m_SubWorldIndex].m_dwCurrentTime, Name, m_Kind, nClient, sizeof(NpcSync));
#endif
	if (IsPlayer())
	{
		PHONGTHAN_PLAYER_SNAPSHOT PlayerSync;
		BuildPhongThanPlayerSnapshot(&PlayerSync, true);

		if (bBroadCast)
		{
			this->SendDataToNearRegion((BYTE*)&PlayerSync, sizeof(PlayerSync));
		}
		else
		{
			if (SUCCEEDED(g_pServer->PackDataToClient(nClient, (BYTE*)&PlayerSync, sizeof(PlayerSync))))
			{
				//printf("Packing player sync data ok...\n");
				bRet = TRUE;
			}
			else
			{
				printf("Packing player sync data failed...\n");
				return FALSE;
			}
		}
	}
	return bRet;
}

// ƽʱ���ݵ�ͬ��
void KNpc::NormalSync()
{
	if (m_Doing == do_revive || m_Doing == do_death || !m_Index || m_RegionIndex < 0)
		return;

	//g_DebugLog("KNpc::NormalSync()");

	PHONGTHAN_NPC_UPDATE NpcSync;
	ZeroMemory(&NpcSync, sizeof(NpcSync));
	int nMpsX, nMpsY;
	GetMpsPos(&nMpsX, &nMpsY);

	PhongThanInitializeWireHeader(&NpcSync.Header, PHONGTHAN_MSG_WORLD_NPC_UPDATE,
		sizeof(NpcSync), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	NpcSync.MapId = SubWorld[m_SubWorldIndex].m_SubWorldID;
	NpcSync.EntityId = m_dwID;

	memcpy(NpcSync.Effects, m_btStateInfo ,sizeof(BYTE) * MAX_SKILL_STATE);

	NpcSync.MaxLife		= (int)m_CurrentLifeMax;
	if (m_CurrentLifeMax > 0)
		NpcSync.Life			= (int)m_CurrentLife;
	else
		NpcSync.Life			= 0;

	NpcSync.X = nMpsX;
	NpcSync.Y = nMpsY;

	NpcSync.RunSpeed		= m_CurrentRunSpeed;
	NpcSync.WalkSpeed		= m_CurrentWalkSpeed;
	NpcSync.AttackSpeed		= m_CurrentAttackSpeed;
	NpcSync.CastSpeed		= m_CurrentCastSpeed;

	NpcSync.Camp = (BYTE)m_CurrentCamp;
	NpcSync.StateFlags = 0;

	if (m_FreezeState.nTime > 0)
		NpcSync.StateFlags |= STATE_FREEZE;
	if (m_PoisonState.nTime > 0)
		NpcSync.StateFlags |= STATE_POISON;
	if (m_StunState.nTime > 0)
		NpcSync.StateFlags |= STATE_STUN;
	if (m_HideState.nTime > 0)
		NpcSync.StateFlags |= STATE_HIDE;
	if (m_FrozenAction.nTime > 0)
		NpcSync.StateFlags |= STATE_FROZEN;
	if (m_WalkRun.nTime > 0)
		NpcSync.StateFlags |= STATE_WALKRUN;
	NpcSync.Action = PhongThanEncodeEntityAction(m_Doing);

	POINT	POff[8] =
	{
		{0, 32},
		{-16, 32},
		{-16, 0},
		{-16, -32},
		{0, -32},
		{16, -32},
		{16, 0},
		{16, 32},
	};
	int nMaxCount = MAX_PLAYER;//MAX_BROADCAST_COUNT;
	CURREGION.BroadCast(&NpcSync, sizeof(NpcSync), nMaxCount, m_MapX, m_MapY);
	int j;
	for (j = 0; j < 8; j++)
	{
		int nConRegion = CURREGION.m_nConnectRegion[j];
		if (nConRegion == -1)
			continue;
		_ASSERT(m_SubWorldIndex >= 0 && nConRegion >= 0);
		SubWorld[m_SubWorldIndex].m_Region[nConRegion].BroadCast((BYTE*)&NpcSync, sizeof(NpcSync), nMaxCount, m_MapX - POff[j].x, m_MapY - POff[j].y);
	}

	if (IsPlayer())
	{
		PHONGTHAN_PLAYER_SNAPSHOT PlayerSync;
		BuildPhongThanPlayerSnapshot(&PlayerSync, false);

		int nMaxCount = MAX_PLAYER;//MAX_BROADCAST_COUNT;
		CURREGION.BroadCast(&PlayerSync, sizeof(PlayerSync), nMaxCount, m_MapX, m_MapY);
		for (j = 0; j < 8; j++)
		{
			int nConRegion = CURREGION.m_nConnectRegion[j];
			if (nConRegion == -1)
				continue;
			SubWorld[m_SubWorldIndex].m_Region[nConRegion].BroadCast((BYTE*)&PlayerSync, sizeof(PlayerSync), nMaxCount, m_MapX - POff[j].x, m_MapY - POff[j].y);
		}
		//TamLTM
		PHONGTHAN_ENTITY_POSITION	sSync;
		ZeroMemory(&sSync, sizeof(sSync));
	PhongThanInitializeWireHeader(&sSync.Header, PHONGTHAN_MSG_WORLD_ENTITY_POSITION, sizeof(sSync), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	sSync.MapId = SubWorld[m_SubWorldIndex].m_SubWorldID;
	sSync.Mode = PHONGTHAN_POSITION_RECONCILE;
	sSync.Action = PhongThanEncodeEntityAction(m_Doing);
		sSync.EntityId = m_dwID;
		sSync.X = nMpsX;
		sSync.Y = nMpsY;
		g_pServer->PackDataToClient(Player[m_nPlayerIdx].m_nNetConnectIdx, (BYTE*)&sSync, sizeof(sSync));
		//end code

	//	g_DebugLog("s2c_syncnpcminplayer");
	}
}

void KNpc::BroadCastRevive(int nType)
{
	if (!IsPlayer())
		return;

	if (m_RegionIndex < 0)
		return;

	PHONGTHAN_ENTITY_STATUS	NpcReviveSync;
	ZeroMemory(&NpcReviveSync, sizeof(NpcReviveSync));
	PhongThanInitializeWireHeader(&NpcReviveSync.Header, PHONGTHAN_MSG_WORLD_ENTITY_STATUS, sizeof(NpcReviveSync), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	NpcReviveSync.MapId = SubWorld[m_SubWorldIndex].m_SubWorldID;
	NpcReviveSync.Kind = PHONGTHAN_STATUS_REVIVE;
	NpcReviveSync.EntityId = m_dwID;
	NpcReviveSync.Value = (BYTE)nType;

	POINT	POff[8] =
	{
		{0, 32},
		{-16, 32},
		{-16, 0},
		{-16, -32},
		{0, -32},
		{16, -32},
		{16, 0},
		{16, 32},
	};
	int nMaxCount = MAX_BROADCAST_COUNT;
	CURREGION.BroadCast((BYTE*)&NpcReviveSync, sizeof(NpcReviveSync), nMaxCount, m_MapX, m_MapY);
	int j;
	for (j = 0; j < 8; j++)
	{
		int nConRegion = CURREGION.m_nConnectRegion[j];
		if (nConRegion == -1)
			continue;
		SubWorld[m_SubWorldIndex].m_Region[nConRegion].BroadCast((BYTE*)&NpcReviveSync, sizeof(PHONGTHAN_ENTITY_STATUS), nMaxCount, m_MapX - POff[j].x, m_MapY - POff[j].y);
	}
}

int	KNpc::GetPlayerIdx()
{
	if (m_Kind != kind_player)
		return 0;
	return m_nPlayerIdx;
}

#endif

#ifndef _SERVER
#include "scene/KScenePlaceC.h"

int KNpc::PaintInfo(int nHeightOffset, int nFontSize, DWORD dwBorderColor)
{
	if (m_Index != Player[CLIENT_PLAYER_INDEX].m_nIndex &&
		m_HideState.nTime > 0 &&
		m_Kind != kind_normal && m_Kind != kind_dialoger)
	{
		return 0;
	}

	int nMpsX, nMpsY, nXX, nYY;
	GetMpsPos(&nMpsX, &nMpsY);

	DWORD	dwColor = 0xffffffff;
	int nHeightOff = nHeightOffset + nFontSize + 1;

	char pszTemp[128];

	switch (m_Kind)
	{
	case kind_player:
		switch(m_CurrentCamp)
		{
		case camp_begin:
			dwColor = 0xffffffff;
			break;
		case camp_justice:
			dwColor = 0xff000000 | (255 << 16) | (168 << 8) | 94;
			break;
		case camp_evil:
			dwColor = 0xff000000 | (255 << 16) | (146 << 8) | 255;
			break;
		case camp_balance:
			dwColor = 0xff000000 | (85 << 16) | (255 << 8) | 145;
			break;
		case camp_free:
			dwColor = 0xff000000 | (255 << 16);
			break;
		case camp_animal:
			dwColor = 0xffffffff;
			break;
		case camp_event:
			dwColor = 0xff000000 | (238 << 16) | (18 << 8) | 137;
			break;
		case camp_audience:
			dwColor = 0xffffffff;
			break;
		case camp_tongwar:
			dwColor = 0xff000000 | (104 << 16) | (38 << 8) | 174;
			break;
		}

		//Ve damage bang doc choang.
		strcpy(pszTemp, Name);
		if (m_FreezeState.nTime || m_PoisonState.nTime || m_StunState.nTime)
		{
		    strcat(pszTemp, "(");
			if (m_FreezeState.nTime)
				strcat(pszTemp, "B¨ng");
			if (m_PoisonState.nTime)
				strcat(pszTemp, "§éc");
			if (m_StunState.nTime)
				strcat(pszTemp, "Cho¸ng"); // loi font me gi roi` kaka, Met or moi
			if (m_FrozenAction.nTime)
				strcat(pszTemp, "§ãng B¨ng");
			strcat(pszTemp, ")");
		}
		nXX = nMpsX - nFontSize * g_StrLen(pszTemp) / 4 + ((m_byFortuneRankLevel > 0 && m_byFortuneRankLevel <= MAX_ITEM_LEVEL) ? 40 : 0);
		nYY = nMpsY;

		g_pRepresent->OutputText(nFontSize, pszTemp, KRF_ZERO_END, nXX, nYY, dwColor, 0, nHeightOff, dwBorderColor);

		if (m_byViprank>0 && (m_byViprank <= MAX_VIPRANK_VALUE))
			nXX = PaintViprank(nHeightOff, nFontSize, nXX, nYY);
		if (m_byFortuneRankLevel > 0 && m_byFortuneRankLevel <= MAX_ITEM_LEVEL)
			nXX = PaintFortuneRank(nHeightOff, nFontSize, nXX, nYY);
		if (m_byTranslife>0 && (m_byTranslife <= MAX_TRANSLIFE_VALUE))
			nXX = PaintTranslife(nHeightOff, nFontSize, nXX, nYY);

		nHeightOffset += nFontSize + 1;
		if (m_dwTongNameID)
		{
			if (m_szTongAgname[0])
				sprintf(pszTemp, "%s %s", m_szTongName, m_szTongAgname);
			else
			{
				switch (m_nFigure)
				{
				case enumTONG_FIGURE_MEMBER:
					sprintf(pszTemp, "%s %s", m_szTongName, defTONG_MEMBER_AGNAME);
					break;
				case enumTONG_FIGURE_MANAGER:
					sprintf(pszTemp, "%s %s", m_szTongName, defTONG_MANAGER_AGNAME);
					break;
				case enumTONG_FIGURE_DIRECTOR:
					sprintf(pszTemp, "%s %s", m_szTongName, defTONG_DIRECTOR_AGNAME);
					break;
				case enumTONG_FIGURE_MASTER:
					sprintf(pszTemp, "%s %s", m_szTongName, defTONG_MASTER_AGNAME);
					break;
				default:
					sprintf(pszTemp, "%s", m_szTongName);
					break;
				}
			}
			nXX = nMpsX - nFontSize * g_StrLen(pszTemp) / 4;
			nYY -= (nFontSize + 4)*2;
			g_pRepresent->OutputText(nFontSize, pszTemp, KRF_ZERO_END, nXX, nYY, dwColor, 0, nHeightOff, dwBorderColor);

			if(m_nTongNationalEmblem)
			{
				KRUImage RUIconImage;
				RUIconImage.nType = ISI_T_SPR;
				RUIconImage.Color.Color_b.a = 255;
				RUIconImage.bRenderFlag = RUIMAGE_RENDER_FLAG_REF_SPOT;
				RUIconImage.bRenderStyle = IMAGE_RENDER_STYLE_ALPHA;
				RUIconImage.uImage = 0;
				RUIconImage.nISPosition = IMAGE_IS_POSITION_INIT;
				strcpy(RUIconImage.szImage, PlayerSet.m_szNationalEmblemPic[m_nTongNationalEmblem]);
				RUIconImage.oPosition.nX = nXX-18;
				RUIconImage.oPosition.nY = nYY-12;
				RUIconImage.oPosition.nZ = nHeightOff;
				RUIconImage.nFrame = 0;
				g_pRepresent->DrawPrimitives(1, &RUIconImage, RU_T_IMAGE, FALSE);
			}
			nHeightOffset += nFontSize + 1;
		}

		if (m_CurExpandRank.szName[0])
		{
			nYY -= (nFontSize + 4)*2;

			g_pRepresent->OutputText(nFontSize, m_CurExpandRank.szName, KRF_ZERO_END,
				nMpsX - nFontSize * g_StrLen(m_CurExpandRank.szName) / 4, nYY,
				m_CurExpandRank.dwColor, 0, nHeightOff, dwBorderColor);
			nHeightOffset += nFontSize + 1;
		}

		if (m_MaskType)
		{
			pszTemp[0] = 0;

			if (m_bRideHorse)
			{
				g_GameSetting.GetString("Actions", "0", "", pszTemp, sizeof(pszTemp));
			}
			else if (m_Doing == do_sit)
			{
				g_GameSetting.GetString("Actions", "1", "", pszTemp, sizeof(pszTemp));
			}

			if (pszTemp[0])
			{
				KRUImage RUIconImage;
				RUIconImage.nType = ISI_T_SPR;
				RUIconImage.Color.Color_b.a = 255;
				RUIconImage.bRenderFlag = RUIMAGE_RENDER_FLAG_REF_SPOT;
				RUIconImage.bRenderStyle = IMAGE_RENDER_STYLE_ALPHA;
				RUIconImage.uImage = 0;
				RUIconImage.nISPosition = IMAGE_IS_POSITION_INIT;
				strcpy(RUIconImage.szImage, pszTemp);
				RUIconImage.oPosition.nX = nMpsX + (nFontSize * g_StrLen(Name) / 4) + 10 + (m_byFortuneRankLevel > 0 ? 40 : 0);
				RUIconImage.oPosition.nY = nMpsY + 20;
				RUIconImage.oPosition.nZ = nHeightOff;
				RUIconImage.nFrame = 0;
				g_pRepresent->DrawPrimitives(1, &RUIconImage, RU_T_IMAGE, FALSE);
			}
		}
		break;
	case kind_dialoger:
		g_pRepresent->OutputText(nFontSize, Name, KRF_ZERO_END, nMpsX - nFontSize * g_StrLen(Name) / 4, nMpsY, dwColor, 0, nHeightOff, dwBorderColor);
		nHeightOffset += nFontSize + 1;
		break;
	case kind_normal:
		g_GameSetting.GetString("Series", "Image", "", pszTemp, sizeof(pszTemp));

		KRUImage RUIconImageR;
		RUIconImageR.nType = ISI_T_SPR;
		RUIconImageR.Color.Color_b.a = 255;
		RUIconImageR.bRenderStyle = IMAGE_RENDER_STYLE_ALPHA;
		RUIconImageR.uImage = 0;
		RUIconImageR.nISPosition = IMAGE_IS_POSITION_INIT;
		RUIconImageR.bRenderFlag = RUIMAGE_RENDER_FLAG_REF_SPOT;
		sprintf(RUIconImageR.szImage, pszTemp, m_Series);
		char szDisplayName[128];
		if (Name[0] == '#')
			g_StrCpyLen(szDisplayName, Name + 1, sizeof(szDisplayName));
		else
			g_StrCpyLen(szDisplayName, Name, sizeof(szDisplayName));

		RUIconImageR.oPosition.nX = nMpsX + nFontSize * g_StrLen(szDisplayName) / 4 + 5;
		RUIconImageR.oPosition.nY = nMpsY;
		RUIconImageR.oPosition.nZ = nHeightOff;
		RUIconImageR.nFrame = 0;
		g_pRepresent->DrawPrimitives(1, &RUIconImageR, RU_T_IMAGE, FALSE);
		switch (m_btSpecial)
		{
			case npc_normal:
				dwColor = 0xffffffff;
			break;
			case npc_blue:
				dwColor = 0xff6569d7;
			break;
			case npc_gold:
				dwColor = 0xffffd94e;
			break;
			default:
				dwColor = 0xff000000;
			break;
		}

#ifdef _DEBUG
		char szDebuger[80];
		sprintf(szDebuger, "%s[%d][%d][%d]", szDisplayName, m_Level, m_CurrentLife, m_Experience * 2);
		g_pRepresent->OutputText(nFontSize, szDebuger, KRF_ZERO_END, nMpsX - nFontSize * g_StrLen(szDebuger) / 4, nMpsY, dwColor, 0, nHeightOff, dwBorderColor);
#else
		g_pRepresent->OutputText(nFontSize, szDisplayName, KRF_ZERO_END, nMpsX - nFontSize * g_StrLen(szDisplayName) / 4, nMpsY, dwColor, 0, nHeightOff, dwBorderColor);
#endif
		break;
	}


//Debug
#ifdef SWORDONLINE_SHOW_DBUG_INFO
	if(Player[CLIENT_PLAYER_INDEX].m_bDebugMode)
	{
		char szNameID[50];
		sprintf(szNameID,"[%d]-[%d]", m_dwID, m_Level);
		g_pRepresent->OutputText(12, szNameID, KRF_ZERO_END, nMpsX, nMpsY + 20, 0xfff0fff0, 0, m_Height, dwBorderColor);

		if (Player[CLIENT_PLAYER_INDEX].m_nIndex == m_Index && Player[CLIENT_PLAYER_INDEX].m_bDebugMode)
		{
			char	szMsg[256];
			int nCount[9];
			for (int i = 0; i < 9; i++)
				nCount[i] = 0;
			if (LEFTUPREGIONIDX >= 0)
				nCount[0] = LEFTUPREGION.m_NpcList.GetNodeCount();
			if (UPREGIONIDX >= 0)
				nCount[1] = UPREGION.m_NpcList.GetNodeCount();
			if (RIGHTUPREGIONIDX >= 0)
				nCount[2] = RIGHTUPREGION.m_NpcList.GetNodeCount();
			if (LEFTREGIONIDX >= 0)
				nCount[3] = LEFTREGION.m_NpcList.GetNodeCount();
			if (m_RegionIndex >= 0)
				nCount[4] = CURREGION.m_NpcList.GetNodeCount();
			if (RIGHTREGIONIDX >= 0)
				nCount[5] = RIGHTREGION.m_NpcList.GetNodeCount();
			if (LEFTDOWNREGIONIDX >= 0)
				nCount[6] = LEFTDOWNREGION.m_NpcList.GetNodeCount();
			if (DOWNREGIONIDX >= 0)
				nCount[7] = DOWNREGION.m_NpcList.GetNodeCount();
			if (RIGHTDOWNREGIONIDX >= 0)
				nCount[8] = RIGHTDOWNREGION.m_NpcList.GetNodeCount();

			int nPosX, nPosY;
			GetMpsPos(&nPosX, &nPosY);
			sprintf(szMsg,
				"NpcID:%d  Life:%d\nRegionIndex:%d Pos:%d,%d\nPlayerNumber:%d\n"
				"NpcNumber:\n%02d,%02d,%02d\n%02d,%02d,%02d\n%02d,%02d,%02d",
				m_dwID,
				m_CurrentLife,
				m_RegionIndex,
				m_MapX,
				m_MapY,
				CURREGION.m_PlayerList.GetNodeCount(),
				nCount[0], nCount[1], nCount[2],
				nCount[3], nCount[4], nCount[5],
				nCount[6], nCount[7], nCount[8]
				);

			g_pRepresent->OutputText(12, szMsg, -1, 320, 40, 0xffffffff);

		}
	}
#endif
//end code

	return nHeightOffset;
}

int KNpc::PaintViprank(int nHeightOff, int nFontSize, int nMpsX, int nMpsY)
{
	KRUImage RUIconImage;
	RUIconImage.nType = ISI_T_SPR;
	RUIconImage.Color.Color_b.a = 255;
	RUIconImage.bRenderStyle = IMAGE_RENDER_STYLE_ALPHA;
	RUIconImage.uImage = 0;
	RUIconImage.nISPosition = IMAGE_IS_POSITION_INIT;
	RUIconImage.bRenderFlag = RUIMAGE_RENDER_FLAG_REF_SPOT;
	strcpy(RUIconImage.szImage, PlayerSet.m_szViprankPic[m_byViprank]);
	KImageParam	Param;
	g_pRepresent->GetImageParam(RUIconImage.szImage, &Param, ISI_T_SPR);
	RUIconImage.oPosition.nX = nMpsX - Param.nWidth/4 - 2;
	RUIconImage.oPosition.nY = nMpsY - Param.nHeight*5;
	RUIconImage.oPosition.nZ = nHeightOff;
	RUIconImage.nFrame = g_SubWorldSet.GetGameTime() % Param.nNumFrames;
	g_pRepresent->DrawPrimitives(1, &RUIconImage, RU_T_IMAGE, 0);

	return RUIconImage.oPosition.nX - Param.nWidth;
}

int KNpc::PaintFortuneRank(int nHeightOff, int nFontSize, int nMpsX, int nMpsY)
{
	KRUImage RUIconImage;
	RUIconImage.nType = ISI_T_SPR;
	RUIconImage.Color.Color_b.a = 255;
	RUIconImage.bRenderStyle = IMAGE_RENDER_STYLE_ALPHA;
	RUIconImage.uImage = 0;
	RUIconImage.nISPosition = IMAGE_IS_POSITION_INIT;
	RUIconImage.bRenderFlag = RUIMAGE_RENDER_FLAG_REF_SPOT;
	strcpy(RUIconImage.szImage, PlayerSet.m_szFortuneRankPic[m_byFortuneRankLevel]);
	KImageParam	Param;
	g_pRepresent->GetImageParam(RUIconImage.szImage, &Param, ISI_T_SPR);
	RUIconImage.oPosition.nX = nMpsX - Param.nWidth;
	RUIconImage.oPosition.nY = nMpsY - Param.nHeight/2 - 4;
	RUIconImage.oPosition.nZ = nHeightOff;
	RUIconImage.nFrame = g_SubWorldSet.GetGameTime() % Param.nNumFrames;
	g_pRepresent->DrawPrimitives(1, &RUIconImage, RU_T_IMAGE, 0);

	return RUIconImage.oPosition.nX;
}

int KNpc::PaintTranslife(int nHeightOff, int nFontSize, int nMpsX, int nMpsY)
{
	KRUImage RUIconImage;
	RUIconImage.nType = ISI_T_SPR;
	RUIconImage.Color.Color_b.a = 255;
	RUIconImage.bRenderStyle = IMAGE_RENDER_STYLE_ALPHA;
	RUIconImage.uImage = 0;
	RUIconImage.nISPosition = IMAGE_IS_POSITION_INIT;
	RUIconImage.bRenderFlag = RUIMAGE_RENDER_FLAG_REF_SPOT;
	strcpy(RUIconImage.szImage, PlayerSet.m_szTranlifePic[m_byTranslife]);
	KImageParam	Param;
	g_pRepresent->GetImageParam(RUIconImage.szImage, &Param, ISI_T_SPR);
	RUIconImage.oPosition.nX = nMpsX - (Param.nWidth/4)-2;
	RUIconImage.oPosition.nY = nMpsY + Param.nHeight/2;
	RUIconImage.oPosition.nZ = nHeightOff;
	RUIconImage.nFrame = g_SubWorldSet.GetGameTime() % Param.nNumFrames;
	g_pRepresent->DrawPrimitives(1, &RUIconImage, RU_T_IMAGE, 0);

	return RUIconImage.oPosition.nX;
}

void KNpc::PaintTop(int nHeightOffset, int nnHeightOffset, int nFontSize, DWORD dwBorderColor)
{
	if(m_Kind != kind_player)
		return;

	int	nMpsX, nMpsY;
	GetMpsPos(&nMpsX, &nMpsY);
	if (m_PTrade.nTrade)
	{
		int nWid = nFontSize * g_StrLen(m_PTrade.cName) / 2 + 10;
		int nHei = nFontSize + 12;

		KRUImage RUIconImageR;
		RUIconImageR.nType = ISI_T_SPR;
		RUIconImageR.Color.Color_b.a = 150;
		RUIconImageR.bRenderStyle = IMAGE_RENDER_STYLE_ALPHA;
		RUIconImageR.uImage = 0;
		RUIconImageR.nISPosition = IMAGE_IS_POSITION_INIT;
		RUIconImageR.bRenderFlag = RUIMAGE_RENDER_FLAG_REF_SPOT;
		strcpy(RUIconImageR.szImage, "\\spr\\Ui3\\��̯\\��̯ͷ��������.spr");
		RUIconImageR.oPosition.nX = nMpsX - nWid / 2;
		RUIconImageR.oPosition.nY = nMpsY - 40;
		RUIconImageR.oPosition.nZ = nHeightOffset + 10;
		RUIconImageR.nFrame = 0;
		for (int i = 0; i < nWid;i++)
		{
			RUIconImageR.oPosition.nX = nMpsX - nWid / 2 + i;
			g_pRepresent->DrawPrimitives(1, &RUIconImageR, RU_T_IMAGE, FALSE);
		}

		DWORD dwColor = 0x00eed66a;
		g_pRepresent->OutputText(nFontSize, m_PTrade.cName, KRF_ZERO_END, nMpsX - nFontSize * g_StrLen(m_PTrade.cName) / 4, RUIconImageR.oPosition.nY + nFontSize * 2, dwColor, 0, RUIconImageR.oPosition.nZ + nFontSize - 1, dwBorderColor);

		strcpy(RUIconImageR.szImage, "\\spr\\Ui3\\��̯\\��̯ͷ��������.spr");
		RUIconImageR.nType = ISI_T_SPR;
		RUIconImageR.Color.Color_b.a = 255;
		RUIconImageR.bRenderStyle = IMAGE_RENDER_STYLE_ALPHA;
		RUIconImageR.uImage = 0;
		RUIconImageR.nISPosition = IMAGE_IS_POSITION_INIT;
		RUIconImageR.bRenderFlag = RUIMAGE_RENDER_FLAG_REF_SPOT;
		RUIconImageR.oPosition.nX = nMpsX + nWid / 2;
		RUIconImageR.oPosition.nY = nMpsY;
		RUIconImageR.oPosition.nZ += 23;
		g_pRepresent->DrawPrimitives(1, &RUIconImageR, RU_T_IMAGE, FALSE);

		strcpy(RUIconImageR.szImage, "\\spr\\Ui3\\��̯\\��̯ͷ��������.spr");
		RUIconImageR.nType = ISI_T_SPR;
		RUIconImageR.Color.Color_b.a = 255;
		RUIconImageR.bRenderStyle = IMAGE_RENDER_STYLE_ALPHA;
		RUIconImageR.uImage = 0;
		RUIconImageR.nISPosition = IMAGE_IS_POSITION_INIT;
		RUIconImageR.bRenderFlag = RUIMAGE_RENDER_FLAG_REF_SPOT;
		RUIconImageR.oPosition.nX = nMpsX - nWid / 2 - 18;
		RUIconImageR.oPosition.nY = nMpsY;
		g_pRepresent->DrawPrimitives(1, &RUIconImageR, RU_T_IMAGE, FALSE);
	}
	if(m_nPacePercent)// thanh process core
	{
		int nPercent = MAX_PERCENT - m_nPacePercent;
		if (nPercent < 0)
			nPercent = 0;
		PaintPaceBar(nPercent,m_nPacePercent);	//fix paint bar

	/*	int nPercent = MAX_PERCENT - m_nPacePercent;
		if (nPercent < 0)
			nPercent = 0;
		KRUShadow Shadow;
		Shadow.Color.Color_b.a = 0;
		Shadow.Color.Color_b.r = 238;
		Shadow.Color.Color_b.g = 18;
		Shadow.Color.Color_b.b = 137;
		Shadow.oPosition.nX = nMpsX - SHOW_LIFE_WIDTH / 2;
		Shadow.oPosition.nY = nMpsY;
		Shadow.oPosition.nZ = nnHeightOffset + SHOW_LIFE_HEIGHT - 3;
		Shadow.oEndPos.nX = Shadow.oPosition.nX + SHOW_LIFE_WIDTH * nPercent / MAX_PERCENT;
		Shadow.oEndPos.nY = nMpsY - 2;
		Shadow.oEndPos.nZ = nnHeightOffset - 4;
		g_pRepresent->DrawPrimitives(1, &Shadow, RU_T_SHADOW, FALSE);

		Shadow.Color.Color_dw = 0x16000000;
		Shadow.oPosition.nX = Shadow.oEndPos.nX;
		Shadow.oEndPos.nX = nMpsX + SHOW_LIFE_WIDTH / 2;
		g_pRepresent->DrawPrimitives(1, &Shadow, RU_T_SHADOW, FALSE);*/
	}

	ShowPKNamePlayer(Player[CLIENT_PLAYER_INDEX].m_cPK.GetPKNamePlayer());
}

bool isCheckCloseProBar = false;
void KNpc::PaintPaceBar(int nPercent, int nPacePercent)
{
/*	if (m_Doing == do_stand)
	{
		Sleep(2);
		isCheckCloseProBar = false;
	}

	if (m_Doing == do_run || m_Doing == do_walk || isCheckCloseProBar)
	{
		isCheckCloseProBar = true;
		return;
	}*/


	int	nMpsX, nMpsY;
	GetMpsPos(&nMpsX, &nMpsY);
	KRUImage RUIconImage;
	strcpy(RUIconImage.szImage, "\\spr\\Ui3\\loading\\mainBar.spr");
	RUIconImage.nType = ISI_T_SPR;
	RUIconImage.Color.Color_b.a = 255;
	RUIconImage.bRenderStyle = IMAGE_RENDER_STYLE_ALPHA;
	RUIconImage.uImage = 0;
	RUIconImage.nISPosition = IMAGE_IS_POSITION_INIT;
	RUIconImage.bRenderFlag = RUIMAGE_RENDER_FLAG_REF_SPOT;
	RUIconImage.oPosition.nX =  nMpsX + 80;

	if (m_bRideHorse)
		RUIconImage.oPosition.nY = nMpsY+761;
	else
		RUIconImage.oPosition.nY = nMpsY+819;

	g_pRepresent->DrawPrimitives(1, &RUIconImage, RU_T_IMAGE, FALSE);


	strcpy(RUIconImage.szImage, "\\spr\\Ui3\\loading\\loading.spr");
	RUIconImage.nType = ISI_T_SPR;
	RUIconImage.Color.Color_b.a = 255;
	RUIconImage.bRenderStyle = IMAGE_RENDER_STYLE_ALPHA;
	RUIconImage.uImage = 0;
	RUIconImage.nISPosition = IMAGE_IS_POSITION_INIT;
	RUIconImage.bRenderFlag = RUIMAGE_RENDER_FLAG_REF_SPOT;
	int inSHOW_LIFE_WIDTH = SHOW_LIFE_WIDTH * 3;
	RUIconImage.oPosition.nX =  nMpsX + 80  ;
	RUIconImage.oPosition.nY =	nMpsY+430;

	RUIconImage.oPosition.nZ = 0;
	KImageParam	Param;
	g_pRepresent->GetImageParam(RUIconImage.szImage, &Param, ISI_T_SPR);

	for ( int i = 0; i < (130 * nPercent / MAX_PERCENT); i++) // 130  la frame spr loading;
	{
		RUIconImage.nFrame = i++;
	}

	g_pRepresent->DrawPrimitives(1, &RUIconImage, RU_T_IMAGE, FALSE);


	KRUImage RUIconImageR;
	RUIconImageR.oPosition.nX = nMpsX;
	RUIconImageR.oPosition.nY = nMpsY+110;
	char Processing[3];
	char title[64];
	char Phantram[1] ;
	strcpy(Phantram,"%");
	int CalCu = 100 - nPacePercent;
	DWORD dwColor = 0x00eed66a;
	sprintf(Processing,"%d%s",CalCu,Phantram);
	int	 nFontSize = 12;
	g_pRepresent->OutputText(nFontSize, Processing, KRF_ZERO_END, RUIconImageR.oPosition.nX, RUIconImageR.oPosition.nY, dwColor, 0, 10);
	strcpy(title,"�ang ti�n tr�nh...");
	RUIconImageR.oPosition.nX = nMpsX - 45;
	RUIconImageR.oPosition.nY = nMpsY+75;
	g_pRepresent->OutputText(nFontSize, title, KRF_ZERO_END, RUIconImageR.oPosition.nX, RUIconImageR.oPosition.nY, dwColor, 0, 10);
}


void KNpc::ShowPKNamePlayer(char* m_nNamePK)
{
	int len;
	// gets(m_nNamePK); (removed: no stdin in the GUI client; VC6 gets returned NULL immediately)
	len = strlen(m_nNamePK);

	int	nMpsX, nMpsY;
	Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].GetMpsPos(&nMpsX, &nMpsY);
	KRUImage RUIconImageR;
	RUIconImageR.oPosition.nX = (nMpsX - SHOW_LIFE_WIDTH * 2) - 15; // dong 1
//	RUIconImageR.oPosition.nX = nMpsX - 50;
	RUIconImageR.oPosition.nY = nMpsY - 300;
	char Processing[128];
	DWORD dwColor = 0xff0000;
	if (len != 0)
	{
		sprintf(Processing, "%s �ang c�u s�t ��i hi�p", m_nNamePK);
		int	 nFontSize = 12;

		g_pRepresent->OutputText(nFontSize, Processing, KRF_ZERO_END, RUIconImageR.oPosition.nX, RUIconImageR.oPosition.nY, dwColor, 0, 10);

		KRUImage RUIconImage;
		RUIconImage.nType = ISI_T_SPR;
		RUIconImage.Color.Color_b.a = 255;
		RUIconImage.bRenderStyle = IMAGE_RENDER_STYLE_ALPHA;
		RUIconImage.uImage = 0;
		RUIconImage.nISPosition = IMAGE_IS_POSITION_INIT;
		RUIconImage.bRenderFlag = RUIMAGE_RENDER_FLAG_REF_SPOT;
		strcpy(RUIconImage.szImage, "\\spr\\Ui3\\auto\\pk.spr");
		RUIconImage.oPosition.nX = (nMpsX - SHOW_LIFE_WIDTH * 2) - 40; // dong 2
	//	RUIconImage.oPosition.nX = nMpsX - 70;
		RUIconImage.oPosition.nY = nMpsY - 320;
		RUIconImage.oPosition.nZ = 0;
		RUIconImage.nFrame = 0;
		g_pRepresent->DrawPrimitives(1, &RUIconImage, RU_T_IMAGE, FALSE);
		return;
	}
	else
	{
		return;
	}
}

int	KNpc::PaintChat(int nHeightOffset)
{
	if (m_Kind != kind_player && m_Kind != kind_dialoger && m_Kind != kind_normal)
		return nHeightOffset;
	if (m_nChatContentLen <= 0)
		return nHeightOffset;
	if (m_nChatNumLine <= 0)
		return nHeightOffset;
	if (m_Index != Player[CLIENT_PLAYER_INDEX].m_nIndex &&
		m_HideState.nTime > 0)
		return 0;

	int nFontSize = 12;
	int					nWidth, nHeight;
	int					nMpsX, nMpsY;
	KOutputTextParam	sParam;
	sParam.BorderColor = 0;

	sParam.nNumLine = m_nChatNumLine;

	nWidth = m_nChatFontWidth * nFontSize / 2;
	nHeight = sParam.nNumLine * (nFontSize + 1);

	nWidth += 6;	//Ϊ�˺ÿ�
	nHeight += 10;	//Ϊ�˺ÿ�

	GetMpsPos(&nMpsX, &nMpsY);
	sParam.nX = nMpsX - nWidth / 2;
	sParam.nY = nMpsY;
	sParam.nZ = nHeightOffset + nHeight;
	sParam.Color = SHOW_CHAT_COLOR;
	sParam.nSkipLine = 0;
	sParam.nVertAlign = 0;

	sParam.bPicPackInSingleLine = true;
	g_pRepresent->OutputRichText(nFontSize, &sParam, m_szChatBuffer, m_nChatContentLen, nWidth);

	return sParam.nZ;
}

#include "../../Engine/Src/Text.h"
int	KNpc::SetChatInfo(const char* Name, const char* pMsgBuff, unsigned short nMsgLength)
{
	int nFontSize = 12;

	char szChatBuffer[MAX_SENTENCE_LENGTH];

	memset(szChatBuffer, 0, sizeof(szChatBuffer));

	if (nMsgLength)
	{
		int nOffset = 0;
		if (pMsgBuff[0] != KTC_TAB)
		{
			szChatBuffer[nOffset] = (char)KTC_COLOR;
			nOffset++;
			szChatBuffer[nOffset] = (char)0xFF;
			nOffset++;
			szChatBuffer[nOffset] = (char)0xFF;
			nOffset++;
			szChatBuffer[nOffset] = (char)0x00;
			nOffset++;
			strncpy(szChatBuffer + nOffset, Name, 32);
			nOffset += strlen(Name);
			szChatBuffer[nOffset] = ':';
			nOffset++;
			szChatBuffer[nOffset] = (char)0x20;
			nOffset++;
			szChatBuffer[nOffset] = (char)KTC_COLOR_RESTORE;
			nOffset++;
		}
		else
		{
			pMsgBuff ++;
			nMsgLength --;
		}

		if (nMsgLength)
		{
			memcpy(szChatBuffer + nOffset, pMsgBuff, nMsgLength);
			nOffset += nMsgLength;

			memset(m_szChatBuffer, 0, sizeof(m_szChatBuffer));
			m_nChatContentLen = MAX_SENTENCE_LENGTH;
			TGetLimitLenEncodedString(szChatBuffer, nOffset, nFontSize, SHOW_CHAT_WIDTH,
				m_szChatBuffer, m_nChatContentLen, m_Kind == kind_player ? 2 : 6, true);

			m_nChatNumLine = TGetEncodedTextLineCount(m_szChatBuffer, m_nChatContentLen, SHOW_CHAT_WIDTH, m_nChatFontWidth, nFontSize, 0, 0, true);
			if (m_Kind == kind_player && m_nChatNumLine >= 2)
				m_nChatNumLine = 2;
			m_nCurChatTime = IR_GetCurrentTime();
			return true;
		}
	}
	return false;
}

int KNpc::PaintLife(int nHeightOffset, bool bSelect)
{
    // 1. Kiểm tra điều kiện hiển th???
    if (!bSelect && (m_Kind != kind_player && m_Kind != kind_partner))
        return nHeightOffset;

    if (m_CurrentLifeMax <= 0)
        return nHeightOffset;

    if (m_Index != Player[CLIENT_PLAYER_INDEX].m_nIndex && m_HideState.nTime > 0)
        return nHeightOffset;

    int nMpsX, nMpsY;
    GetMpsPos(&nMpsX, &nMpsY);

    // 2. Tính phần trăm máu
    int nPercent = m_CurrentLife * MAX_PERCENT / m_CurrentLifeMax;
    if (nPercent > MAX_PERCENT) 
        nPercent = MAX_PERCENT;
    else if (nPercent < 0) 
        return nHeightOffset;

    // -------------------------------------------------------------
    // 3. V???KHUNG NỀN (bar.spr)
    // -------------------------------------------------------------
    KRUImage RUBackground;
    RUBackground.nType = ISI_T_SPR;
    RUBackground.Color.Color_b.a = 255;
    RUBackground.bRenderStyle = IMAGE_RENDER_STYLE_ALPHA;
    RUBackground.uImage = 0;
    RUBackground.nISPosition = IMAGE_IS_POSITION_INIT;
    RUBackground.bRenderFlag = RUIMAGE_RENDER_FLAG_REF_SPOT;
    
    strcpy(RUBackground.szImage, "\\spr\\ui3\\bar.spr"); 

    KImageParam ParamBg;
    g_pRepresent->GetImageParam(RUBackground.szImage, &ParamBg, ISI_T_SPR);

    RUBackground.oPosition.nX = nMpsX - (ParamBg.nWidth / 2);
    RUBackground.oPosition.nY = nMpsY;
    RUBackground.oPosition.nZ = nHeightOffset + ParamBg.nHeight;
    RUBackground.nFrame = 0;

    g_pRepresent->DrawPrimitives(1, &RUBackground, RU_T_IMAGE, 0);

    // Thông s???Căn l???Lòng thanh HP
    int nPaddingX = 25; // Viền cách l???trái/phải
    int nPaddingZ = 6;  // Viền cách l???trên/dưới

    // -------------------------------------------------------------
    // 4. V???THANH HP XANH (hp.spr)
    // -------------------------------------------------------------
    KRUImage RULifeBar;
    RULifeBar.nType = ISI_T_SPR;
    RULifeBar.Color.Color_b.a = 255;
    RULifeBar.bRenderStyle = IMAGE_RENDER_STYLE_ALPHA;
    RULifeBar.uImage = 0;
    RULifeBar.nISPosition = IMAGE_IS_POSITION_INIT;
    RULifeBar.bRenderFlag = RUIMAGE_RENDER_FLAG_REF_SPOT;

    strcpy(RULifeBar.szImage, "\\spr\\ui3\\hp.spr");

    KImageParam ParamLife;
    g_pRepresent->GetImageParam(RULifeBar.szImage, &ParamLife, ISI_T_SPR);

    RULifeBar.oPosition.nX = nMpsX - (ParamBg.nWidth / 2) + nPaddingX;
    RULifeBar.oPosition.nY = nMpsY;
    RULifeBar.oPosition.nZ = nHeightOffset + ParamBg.nHeight - nPaddingZ;
    RULifeBar.nFrame = 0;

    g_pRepresent->DrawPrimitives(1, &RULifeBar, RU_T_IMAGE, 0);

    // -------------------------------------------------------------
    // 5. V???THANH ĐEN CHE MÁU MẤT (Đã h???thấp xuống 1px)
    // -------------------------------------------------------------
    if (nPercent < MAX_PERCENT)
    {
        KRUShadow BlackMask;
        
        BlackMask.Color.Color_b.r = 128;
        BlackMask.Color.Color_b.g = 128;
        BlackMask.Color.Color_b.b = 128;
        BlackMask.Color.Color_b.a = 0;

        int nStartX = RULifeBar.oPosition.nX + (ParamLife.nWidth * nPercent / MAX_PERCENT);
        int nEndX   = RULifeBar.oPosition.nX + ParamLife.nWidth;

        BlackMask.oPosition.nX = nStartX;
        BlackMask.oPosition.nY = nMpsY;
        
        // Đỉnh trên h???thấp 1px so với trước (t???+2 xuống +1)
        BlackMask.oPosition.nZ = RULifeBar.oPosition.nZ + 1; 
        
        BlackMask.oEndPos.nX = nEndX;
        BlackMask.oEndPos.nY = nMpsY;
        // Đáy dưới h???thấp thêm 1px đ???che kín cạnh dưới (t???-2 thành -3)
        BlackMask.oEndPos.nZ = RULifeBar.oPosition.nZ - ParamLife.nHeight - 1; 

        g_pRepresent->DrawPrimitives(1, &BlackMask, RU_T_SHADOW, FALSE);
    }

    // -------------------------------------------------------------
    // 6. HIỂN TH???LEVEL NẰM BÊN TRÁI THANH HP
    // -------------------------------------------------------------
    char szLevelStr[16];
    sprintf(szLevelStr, "%d", m_Level);

    // Đặt tọa đ???X nằm sát l???trái của Khung nền (lùi sang trái thêm 4px làm khoảng cách)
    int nTextX = RUBackground.oPosition.nX + 2 ; 
	if (m_Level < 100)
	{
		nTextX += 2; // Di chuyển thêm 20px sang phải đ???hiển th???level > 100
	}
    // Đ???cao Z nằm ngang bằng với chiều cao của thanh HP
    int nTextZ = RULifeBar.oPosition.nZ - (ParamLife.nHeight / 2);

    g_pRepresent->OutputText(
        12,                     // nFontId
        szLevelStr,             // psText
        -1,                     // nCount (KRF_ZERO_END: t???đếm đ???dài)
        nTextX,                 // nX
        nMpsY-12,                  // nY
        0xFFFFFFFF,             // Color (Màu TRẮNG: Alpha=255, R=255, G=255, B=255)
        0,                      // nLineWidth
        nTextZ,                 // nZ
        0xFF000000              // BorderColor (Viền ĐEN đ???ch???trắng nổi bật, d???nhìn)
    );

    return nHeightOffset + ParamBg.nHeight;
}

void KNpc::Paint()
{
	// All authoritative NPCs/monsters must use the same rendering path on
	// every map.  Restricting this to a temporary map-id range caused the
	// same Region_S object to be hidden after travelling to another map.
	BOOL bForcePhongThanNpcBody =
		(m_Kind == kind_normal || m_Kind == kind_dialoger);
	static BYTE s_bPhongThanNpcLogged[MAX_NPC] = {0};
	static DWORD s_dwPhongThanNpcFirstPaint[MAX_NPC] = {0};
	if (m_Index > 0 && m_Index < MAX_NPC && !s_bPhongThanNpcLogged[m_Index])
	{
		s_bPhongThanNpcLogged[m_Index] = 1;
		s_dwPhongThanNpcFirstPaint[m_Index] =
			(m_SubWorldIndex >= 0 && m_SubWorldIndex < MAX_SUBWORLD) ?
			SubWorld[m_SubWorldIndex].m_dwCurrentTime : 0;
		FILE *pNpcLog = fopen("client_npc_render_diag.log", "a");
		if (pNpcLog)
		{
			fprintf(pNpcLog, "map=%d index=%d template=%d kind=%d force=%d res=%d name=%s\n",
				(m_SubWorldIndex >= 0 && m_SubWorldIndex < MAX_SUBWORLD) ?
				SubWorld[m_SubWorldIndex].m_SubWorldID : -1,
				m_Index, m_NpcSettingIdx, m_Kind, bForcePhongThanNpcBody,
				m_DataRes.m_pcResNode != NULL, Name);
			fclose(pNpcLog);
		}
	}
	else if (bForcePhongThanNpcBody && m_Index > 0 && m_Index < MAX_NPC &&
		s_bPhongThanNpcLogged[m_Index] == 1 &&
		m_SubWorldIndex >= 0 && m_SubWorldIndex < MAX_SUBWORLD &&
		SubWorld[m_SubWorldIndex].m_dwCurrentTime - s_dwPhongThanNpcFirstPaint[m_Index] > 7 * 18)
	{
		s_bPhongThanNpcLogged[m_Index] = 2;
		FILE *pNpcLog = fopen("client_npc_render_diag.log", "a");
		if (pNpcLog)
		{
			fprintf(pNpcLog, "persist=1 map=%d index=%d template=%d kind=%d res=%d name=%s\n",
				SubWorld[m_SubWorldIndex].m_SubWorldID, m_Index, m_NpcSettingIdx,
				m_Kind, m_DataRes.m_pcResNode != NULL, Name);
			fclose(pNpcLog);
		}
	}

	if (!bForcePhongThanNpcBody &&
		m_Index != Player[CLIENT_PLAYER_INDEX].m_nIndex &&
		(m_CurrentCamp == camp_audience ||
		m_HideState.nTime > 0))
	{
		return;
	}

	//TamLTM hide nguoi choi hoac npc
	if (!bForcePhongThanNpcBody &&
		Player[CLIENT_PLAYER_INDEX].m_bIsHideNpc && Player[CLIENT_PLAYER_INDEX].m_bIsHidePlayer)
	{
		if (m_Kind == kind_normal || m_Kind == kind_dialoger || m_Kind == kind_player)
		{
			if (m_Index != Player[CLIENT_PLAYER_INDEX].m_nIndex)
			{
				return;
			}
		}
	}
	else if (!bForcePhongThanNpcBody && Player[CLIENT_PLAYER_INDEX].m_bIsHideNpc)
	{
		if (m_Kind == kind_normal || m_Kind == kind_dialoger)
		{
			if (m_Index != Player[CLIENT_PLAYER_INDEX].m_nIndex)
			{
				return;
			}
		}
	}
	else if (!bForcePhongThanNpcBody && Player[CLIENT_PLAYER_INDEX].m_bIsHidePlayer)
	{
		if (m_Kind == kind_player)
		{
			if (m_Index != Player[CLIENT_PLAYER_INDEX].m_nIndex)
			{
				return;
			}
		}
	}
	// end code

	BOOL bPaintBody = TRUE;

	if (!bForcePhongThanNpcBody && Option.GetLow(LowNpc))
	{
		if (m_Kind == kind_normal || m_Kind == kind_dialoger)
		{
			if (m_Index != Player[CLIENT_PLAYER_INDEX].m_nIndex)
			{
				bPaintBody = FALSE;
			}
		}
	}

	if (m_ResDir != m_Dir)
	{
		int nDirOff = m_Dir - m_ResDir;
		if (nDirOff > 32)
			nDirOff -= 64;
		else if (nDirOff < - 32)
			nDirOff += 64;
		m_ResDir += nDirOff / 2;
		if (m_ResDir >= 64)
			m_ResDir -= 64;
		if (m_ResDir < 0)
			m_ResDir += 64;
	}
	m_DataRes.Draw(m_Index, m_ResDir, m_Frames.nTotalFrame, m_Frames.nCurrentFrame, FALSE, bPaintBody);

	int nHeight = GetNpcPate() + GetNpcPatePeopleInfo();
	if (m_CurExpandRank.szName[0])
		nHeight += NORMAL_FONTSIZE+1;
	if (m_dwTongNameID)
		nHeight += NORMAL_FONTSIZE+1;
	DrawMenuState(nHeight);
}
#endif

//--------------------------------------------------------------------------
//	���ܣ����ӻ�����������???
//--------------------------------------------------------------------------
void	KNpc::AddBaseLifeMax(int nLife)
{
	m_LifeMax += nLife;
	m_CurrentLifeMax = m_LifeMax;
}

void	KNpc::SetBaseLifeMax(int nLifeMax)
{
	m_LifeMax = nLifeMax;
	m_CurrentLifeMax = m_LifeMax;
}
//--------------------------------------------------------------------------
//	���ܣ����ӵ�ǰ��������???
//--------------------------------------------------------------------------
void	KNpc::AddCurLifeMax(int nLife)
{
	m_CurrentLifeMax += nLife;
}


//--------------------------------------------------------------------------
//	���ܣ����ӻ�����������???
//--------------------------------------------------------------------------
void	KNpc::AddBaseStaminaMax(int nStamina)
{
	m_StaminaMax += nStamina;
	m_CurrentStaminaMax = m_StaminaMax;
}

void	KNpc::SetBaseStaminaMax(int nStamina)
{
	m_StaminaMax = nStamina;
	m_CurrentStaminaMax = m_StaminaMax;
}
//--------------------------------------------------------------------------
//	���ܣ����ӵ�ǰ��������???
//--------------------------------------------------------------------------
void	KNpc::AddCurStaminaMax(int nStamina)
{
	m_CurrentStaminaMax += nStamina;
}

//--------------------------------------------------------------------------
//	���ܣ����ӻ�����������???
//--------------------------------------------------------------------------
void	KNpc::AddBaseManaMax(int nMana)
{
	m_ManaMax += nMana;
	m_CurrentManaMax = m_ManaMax;
}

void	KNpc::SetBaseManaMax(int nMana)
{
	m_ManaMax = nMana;
	m_CurrentManaMax = m_ManaMax;
}

//--------------------------------------------------------------------------
//	���ܣ����ӵ�ǰ��������???
//--------------------------------------------------------------------------
void	KNpc::AddCurManaMax(int nMana)
{
	m_CurrentManaMax += nMana;
}

/*
//--------------------------------------------------------------------------
//	���ܣ����¼��������ظ��ٶ�
//--------------------------------------------------------------------------
void	KNpc::ResetLifeReplenish()
{
	m_LifeReplenish = (m_Level + 5) / 6;
	m_CurrentLifeReplenish = m_LifeReplenish;
}
*/

/*
//--------------------------------------------------------------------------
//	���ܣ����㵱ǰ��������???
//--------------------------------------------------------------------------
void	KNpc::CalcCurLifeMax()
{
}
*/

/*
//--------------------------------------------------------------------------
//	���ܣ����㵱ǰ��������???
//--------------------------------------------------------------------------
void	KNpc::CalcCurStaminaMax()
{
	m_CurrentStaminaMax = m_StaminaMax;		// ����Ҫ���� װ�������ܡ�ҩ���ʱ���ȵ�Ӱ��
}
*/

/*
//--------------------------------------------------------------------------
//	���ܣ����㵱ǰ��������???
//--------------------------------------------------------------------------
void	KNpc::CalcCurManaMax()
{
	m_CurrentManaMax = m_ManaMax;			// ����Ҫ���� װ�������ܡ�ҩ���ʱ���ȵ�Ӱ��
}
*/

//--------------------------------------------------------------------------
//	���ܣ����㵱ǰ�����ظ��ٶ�
//--------------------------------------------------------------------------
void	KNpc::CalcCurLifeReplenish()
{
	m_CurrentLifeReplenish = m_LifeReplenish;	// ���ɫϵ�𡢽�ɫ�ȼ����Ƿ�ʹ��ҩ�������ܺ�ħ��װ���й???
}

void	KNpc::CalcCurLucky()
{
	m_CurrentLucky = Player[m_nPlayerIdx].m_nLucky;	// ���ɫϵ�𡢽�ɫ�ȼ����Ƿ�ʹ��ҩ�������ܺ�ħ��װ���й???
}

void	KNpc::Remove()
{
/*	m_LoopFrames = 0;
	m_Index = 0;
	m_PlayerIdx = -1;
	m_Kind = 0;
	m_dwID = 0;
	Name[0] = 0;*/
	Init();
#ifndef _SERVER
	m_DataRes.Remove(m_Index);
#endif
}

#ifndef _SERVER
void	KNpc::RemoveRes()
{
	m_DataRes.Remove(m_Index);
}
#endif
//--------------------------------------------------------------------------
//	���ܣ��趨�� npc ���������ԣ����ݻ�û��ɣ�not end
//--------------------------------------------------------------------------
void	KNpc::SetSeries(int nSeries)
{
	m_Series = nSeries;
}
/*!*****************************************************************************
// Function		: KNpc::SetStateSkill
// Purpose		:
// Return		: void
// Argumant		: int nSkillID
// Argumant		: int nLevel
// Argumant		: void *pData
// Argumant		: int nDataNum
// Argumant		: int nTime -1��ʾ�������ܣ�ʱ������
// Comments		:
// Author		: Spe
*****************************************************************************/
void KNpc::SetStateSkillEffect(int nLauncher, int nSkillID, int nLevel, void *pData, int nDataNum, int nTime/* = -1*/, BOOL bOverLook/* = FALSE*/)
{
//	g_DebugLog("SetStateSkillEffect");

	if (nLevel <= 0 || nLevel >= MAX_SKILLLEVEL ||
		nSkillID <= 0 || nSkillID >= MAX_SKILL)
		return;

	if (IS_TU_CHAN_SEAL_SKILL(nSkillID))
	{
		if (nTime <= 0 || nTime > TU_CHAN_SEAL_DURATION_TICKS)
			nTime = TU_CHAN_SEAL_DURATION_TICKS;
		bOverLook = TRUE;
	}

	_ASSERT(nSkillID < MAX_SKILL && nLevel < MAX_SKILLLEVEL);
	KSkill * pOrdinSkill = (KSkill *)g_SkillManager.GetSkill(nSkillID, nLevel);

	_ASSERT(nDataNum <= MAX_SKILL_STATE);
	if (nDataNum < 0 || !pData)
		nDataNum = 0;
	else if (nDataNum > MAX_SKILL_STATE)
		nDataNum = MAX_SKILL_STATE;
#ifdef _SERVER
	if (pData && nDataNum >= 0)
	{
		PHONGTHAN_U8 buffer[sizeof(PHONGTHAN_STATE_EFFECT_HEADER) + MAX_SKILL_STATE * sizeof(PHONGTHAN_ATTRIBUTE_WIRE)];
		ZeroMemory(buffer, sizeof(buffer));
		PHONGTHAN_STATE_EFFECT_HEADER* state = (PHONGTHAN_STATE_EFFECT_HEADER*)buffer;
		state->MapId = SubWorld[m_SubWorldIndex].m_SubWorldID;
		state->EntityId = m_dwID;
		state->SkillId = nSkillID;
		state->Level = nLevel;
		state->DurationTicks = nTime;
		state->AttributeCount = nDataNum;
		state->ReplaceExisting = bOverLook ? 1 : 0;
		PHONGTHAN_ATTRIBUTE_WIRE* attributes = (PHONGTHAN_ATTRIBUTE_WIRE*)(state + 1);
		const KMagicAttrib* sourceAttributes = (const KMagicAttrib*)pData;
		for (int i = 0; i < nDataNum; ++i)
		{
			attributes[i].Type = sourceAttributes[i].nAttribType;
			for (int j = 0; j < 3; ++j) attributes[i].Value[j] = sourceAttributes[i].nValue[j];
		}
		const unsigned int size = sizeof(*state) + nDataNum * sizeof(*attributes);
		PhongThanInitializeWireHeader(&state->Header, PHONGTHAN_MSG_GAMEPLAY_STATE_EFFECT,
			size, PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
		g_pServer->PackDataToClient(Player[m_nPlayerIdx].m_nNetConnectIdx, buffer, size);
	}
#endif

	KStateNode* pNode;
	KMagicAttrib* pTemp = NULL;

	pNode = (KStateNode *)m_StateSkillList.GetHead();
	while(pNode)
	{
		if (pNode->m_SkillID == nSkillID)
		{
			if (IS_TU_CHAN_SEAL_SKILL(nSkillID))
			{
				for (int i = 0; i < MAX_SKILL_STATE; i++)
				{
					if (pNode->m_State[i].nAttribType > 0 &&
						pNode->m_State[i].nAttribType < magic_normal_end)
						ModifyAttrib(nLauncher, &pNode->m_State[i]);
				}
				pNode->Remove();
				delete pNode;
				pNode = NULL;
				break;
			}
			if (pNode->m_Level == nLevel)
			{
				pNode->m_LeftTime = nTime;
				pNode->m_bOverLook = bOverLook;
				pNode->m_bTempStateGraphics = FALSE;
			}
			else if (pNode->m_Level < nLevel)
			{
				pTemp = (KMagicAttrib *)pData;
				for (int i = 0; i < nDataNum; i++)
				{
					// ���ԭ���ܵ�Ӱ�???
					ModifyAttrib(nLauncher, &pNode->m_State[i]);
					// ���µȼ��¼��ܵ�Ӱ����㵽NPC����
					ModifyAttrib(nLauncher, pTemp);
					pNode->m_State[i].nAttribType = pTemp->nAttribType;
					pNode->m_State[i].nValue[0] = -pTemp->nValue[0];
					pNode->m_State[i].nValue[1] = -pTemp->nValue[1];
					pNode->m_State[i].nValue[2] = -pTemp->nValue[2];
					pTemp++;
				}
			}
			return;
		}
		pNode = (KStateNode *)pNode->GetNext();
	}
	// û����ѭ���з��أ�˵�����¼���
	pNode = new KStateNode;
	ZeroMemory(pNode->m_State, sizeof(pNode->m_State));
	pNode->m_SkillID = nSkillID;
	
	pNode->m_Level = nLevel;
	pNode->m_LeftTime = nTime;
	pNode->m_bOverLook = bOverLook;
	pNode->m_bTempStateGraphics = FALSE;
	if (pOrdinSkill)
	{
		pNode->m_StateGraphics = pOrdinSkill->GetStateSpecailId();
	}
	else
		pNode->m_StateGraphics = 0;
	pTemp = (KMagicAttrib *)pData;
	for (int i = 0; i < nDataNum; i++)
	{
		// ����NPC����
		ModifyAttrib(nLauncher, pTemp);
		// ���෴ֵ�����������Թ��Ƴ�ʱʹ��
		pNode->m_State[i].nAttribType = pTemp->nAttribType;
		pNode->m_State[i].nValue[0] = -pTemp->nValue[0];
		pNode->m_State[i].nValue[1] = -pTemp->nValue[1];
		pNode->m_State[i].nValue[2] = -pTemp->nValue[2];
		pTemp++;
	}
	m_StateSkillList.AddTail(pNode);
#ifdef _SERVER
	UpdateNpcStateInfo();
#endif
}

/*!*****************************************************************************
// Function		: KNpc::ModifyMissleCollsion
// Purpose		:
// Return		: BOOL
// Argumant		: BOOL bCollsion
// Comments		:
// Author		: Spe
*****************************************************************************/
BOOL KNpc::ModifyMissleCollsion(BOOL bCollsion)
{
	if (bCollsion)
		return TRUE;

	if (g_RandPercent(m_CurrentPiercePercent))
		return TRUE;
	else
		return FALSE;
}

int KNpc::ModifyMissleLifeTime(int nLifeTime)
{
	if (IsPlayer())
	{
		//return Player[m_PlayerIdx].GetWeapon().GetRange();
		return nLifeTime;
	}
	else
	{
		return nLifeTime;
	}
}

int	KNpc::ModifyMissleSpeed(int nSpeed)
{
	if (m_CurrentSlowMissle)
	{
		return nSpeed / 2;
	}
	return nSpeed;
}

BOOL KNpc::DoBlurMove()
{
//	if(m_Doing == do_hurt || m_Doing == do_death)
//		return FALSE;
	//TamLTM fix
	if ((m_Doing == do_hurt) || m_Doing == do_death || m_Doing == do_runattack || m_Doing == do_goattack)
		return FALSE;
	//end code

	if (m_SkillParam1 <= 0)
		return FALSE;

#ifndef _SERVER
	if (m_RegionIndex < 0 || m_RegionIndex >= 9)
	{
		_ASSERT(0);
		DoStand();
		return FALSE;
	}
#else
	_ASSERT(m_RegionIndex >= 0);
	if (m_RegionIndex < 0)
		return FALSE;
#endif

	KSkill * pSkill =(KSkill*) GetActiveSkill();
	if (!pSkill)
        return FALSE;

	m_ProcessAI = 0;

	switch(m_SpecialSkillStep)
	{
	case 0:
		{
		int nX, nY;
		GetMpsPos(&nX, &nY);

		if (nX == m_DesX && nY == m_DesY)
		{
			DoStand();
			m_ProcessAI = 1;
			m_SpecialSkillStep = 0;
			return FALSE;
		}

		int nDir = g_GetDirIndex(nX, nY, m_DesX, m_DesY);
		int	nMaxLength = m_SkillParam1;
		int	nWantLength = SubWorld[m_SubWorldIndex].GetDistance(nX, nY, m_DesX, m_DesY);
		int	nSin = g_DirSin(nDir, 64);
		int	nCos = g_DirCos(nDir, 64);

		if (nWantLength > nMaxLength)
		{
			m_DesX = nX + ((nMaxLength * nCos) >> 10);
			m_DesY = nY + ((nMaxLength * nSin) >> 10);
			nWantLength = nMaxLength;
		}
		else if (nWantLength <= MIN_DOMELEE_RANGE)
		{
			return FALSE;
		}

		int nStep = nWantLength / MIN_BLURMOVE_SPEED;

		int nTestX = 0;
		int nTestY = 0;
		int nSuccessStep = 0;

		for (int i = 1; i < nStep + 1; i++)
		{
			nTestX = nX + ((MIN_BLURMOVE_SPEED * nCos * i) >> 10);
			nTestY = nY + ((MIN_BLURMOVE_SPEED * nSin * i) >> 10);
			int nBarrier = SubWorld[m_SubWorldIndex].GetBarrier(nTestX, nTestY);
			DWORD dwTrap = SubWorld[m_SubWorldIndex].GetTrap(nTestX, nTestY);
			if (Obstacle_NULL == nBarrier && dwTrap == 0)
			{
				nSuccessStep = i;
			}
			if (Obstacle_Normal == nBarrier || Obstacle_Fly == nBarrier || dwTrap)
			{
				if (nSuccessStep <= MIN_DOMELEE_RANGE / MIN_BLURMOVE_SPEED)
				{
					DoStand();
					m_ProcessAI = 1;
					m_SpecialSkillStep = 0;
					return FALSE;
				}
				m_DesX = nX + ((MIN_BLURMOVE_SPEED * nCos * nSuccessStep) >> 10);
				m_DesY = nY + ((MIN_BLURMOVE_SPEED * nSin * nSuccessStep) >> 10);
				nStep = nSuccessStep;
				break;
			}
		}
		}
		m_Doing = do_blurmove;
		break;
	case 1:
		m_ProcessAI = 0;
		m_Frames.nTotalFrame = pSkill->GetMissleGenerateTime(0);
		m_Frames.nCurrentFrame = 0;
		m_Doing = do_blurmove;
		break;
	case 2:
		{
#ifndef _SERVER
		int nX, nY;
		GetMpsPos(&nX, &nY);
#endif
		int nOldRegion = m_RegionIndex;
		int nOldMapX = m_MapX;
		int nOldMapY = m_MapY;
		int nOldOffX = m_OffX;
		int nOldOffY = m_OffY;

		if (!m_bClientOnly)
			CURREGION.DecRef(m_MapX, m_MapY, obj_npc);

		SubWorld[m_SubWorldIndex].Mps2Map(m_DesX, m_DesY, &m_RegionIndex,&m_MapX, &m_MapY, &m_OffX, &m_OffY);

		if (!m_bClientOnly && m_RegionIndex >= 0)
			CURREGION.AddRef(m_MapX, m_MapY, obj_npc);


		if (m_RegionIndex == -1)
		{
			m_RegionIndex = nOldRegion;
			m_MapX = nOldMapX;
			m_MapY = nOldMapY;
			m_OffX = nOldOffX;
			m_OffY = nOldOffY;
			CURREGION.AddRef(m_MapX, m_MapY, obj_npc);
			return FALSE;
		}

		if (nOldRegion != m_RegionIndex)
		{
#ifdef _SERVER
			SubWorld[m_SubWorldIndex].NpcChangeRegion(nOldRegion, m_RegionIndex, m_Index);
			if (IsPlayer())
			{
				SubWorld[m_SubWorldIndex].PlayerChangeRegion(nOldRegion, m_RegionIndex, m_nPlayerIdx);
			}
#else
			SubWorld[0].NpcChangeRegion(SubWorld[0].m_Region[nOldRegion].m_RegionID, SubWorld[0].m_Region[m_RegionIndex].m_RegionID, m_Index);
			m_dwRegionID = SubWorld[0].m_Region[m_RegionIndex].m_RegionID;
#endif
		}
#ifndef _SERVER
		m_DataRes.CreateBlur(m_Index, g_GetDistance(nX, nY, m_DesX, m_DesY), m_Dir);
#endif
		}
		break;
	}
	return TRUE;
}

void KNpc::OnBlurMove()
{
	if (m_SpecialSkillStep == 0)
	{
		m_SpecialSkillStep ++;
		DoBlurMove();
	}
	else if (m_SpecialSkillStep == 1)
	{
		if (WaitForFrame())
		{
			m_SpecialSkillStep ++;
			DoBlurMove();
		}
	}
	else
	{
		DoStand();
		m_ProcessAI = 1;
		m_SpecialSkillStep = 0;
	}
}

BOOL KNpc::DoManyAttack()
{
	m_ProcessAI = 0;

	KSkill * pSkill =(KSkill*) GetActiveSkill();
	if (!pSkill)
        return FALSE;

	if (pSkill->GetChildSkillNum() <= m_SpecialSkillStep)
        goto ExitManyAttack;
#ifndef _SERVER
        m_DataRes.SetBlur(TRUE);
#endif

	m_Frames.nTotalFrame = pSkill->GetMissleGenerateTime(m_SpecialSkillStep);

	int x, y;
	SubWorld[m_SubWorldIndex].Map2Mps(m_RegionIndex, m_MapX, m_MapY, m_OffX, m_OffY, &x, &y);
//	m_DesX = x;
//	m_DesY = y;


#ifndef _SERVER
	if (m_nPlayerIdx > 0)
		pSkill->PlayPreCastSound(m_nSex, x ,y);
	if (g_Random(2))
		m_ClientDoing = cdo_attack;
	else
		m_ClientDoing = cdo_attack1;
#endif


	m_Doing = do_manyattack;

	m_Frames.nCurrentFrame = 0;

	return TRUE;

ExitManyAttack:

#ifndef _SERVER
		m_DataRes.SetBlur(FALSE);
#endif
	DoStand();
	m_ProcessAI = 1;
	m_SpecialSkillStep = 0;

	return TRUE;
}

void KNpc::OnManyAttack()
{
	if (WaitForFrame())
	{
#ifndef _SERVER
		m_DataRes.SetBlur(FALSE);
#endif
		KSkill * pSkill = (KSkill*)GetActiveSkill();
		if (!pSkill)
            return ;

		int nPhySkillId =  pSkill->GetChildSkillId();//GetCurActiveWeaponSkill(); Changed
		
		if (nPhySkillId > 0)
		{
			KSkill * pOrdinSkill = (KSkill *) g_SkillManager.GetSkill(nPhySkillId, pSkill->m_ulLevel, SKILL_SS_Missles);
			if (pOrdinSkill)
            {
				pOrdinSkill->Cast(m_Index, m_SkillParam1, m_SkillParam2);
            }
		}
		m_SpecialSkillStep ++;
		DoManyAttack();

	}
}

BOOL	KNpc::DoRunAttack()
{
	m_ProcessAI = 0;

	switch(m_SpecialSkillStep)
	{
	case 0:
		m_Frames.nTotalFrame = m_RunSpeed;
		m_ProcessAI = 0;

#ifndef _SERVER
		m_DataRes.SetBlur(TRUE);

		if (m_FightMode)
		{
			m_ClientDoing = cdo_fightrun;
		}
		else
		{
			m_ClientDoing = cdo_run;
		}
#endif

		if (m_DesX < 0 && m_DesY > 0)
		{
			int x, y;
			SubWorld[m_SubWorldIndex].Map2Mps
				(
				Npc[m_DesY].m_RegionIndex,
				Npc[m_DesY].m_MapX,
				Npc[m_DesY].m_MapY,
				Npc[m_DesY].m_OffX,
				Npc[m_DesY].m_OffY,
				&x,
				&y
				);

		m_DesX = x;
		m_DesY = y;
		}

		m_Frames.nCurrentFrame = 0;
		m_Doing = do_runattack;
		break;

	case 1:
#ifndef _SERVER
		if (g_Random(2))
			m_ClientDoing = cdo_attack;
		else
			m_ClientDoing = cdo_attack1;

		int x, y, tx, ty;
		SubWorld[m_SubWorldIndex].Map2Mps(m_RegionIndex, m_MapX, m_MapY, m_OffX, m_OffY, &x, &y);
		if (m_SkillParam1 == -1)
		{
			Npc[m_SkillParam2].GetMpsPos(&tx, &ty);
		}
		else
		{
			tx = m_SkillParam1;
			ty = m_SkillParam2;
		}
		m_Dir = g_GetDirIndex(x, y, tx, ty);
#endif
		m_Frames.nTotalFrame = 0;
		m_Frames.nCurrentFrame = 0;
		m_Doing = do_runattack;
		break;

	case 2:
	case 3:
#ifndef _SERVER
		m_DataRes.SetBlur(FALSE);
#endif
		DoStand();
		m_ProcessAI = 1;
		m_SpecialSkillStep = 0;
		return FALSE;
		break;
	}

	m_Frames.nCurrentFrame = 0;

	return TRUE;

}

void	KNpc::OnRunAttack()
{
	if (m_SpecialSkillStep == 0)
	{
		OnRun();
		KSkill * pSkill = (KSkill*)GetActiveSkill();
		if (!pSkill)
            return ;

        if (m_Doing == do_stand || (DWORD)m_nCurrentMeleeTime > pSkill->GetMissleGenerateTime(0))
		{
			m_SpecialSkillStep ++;
			m_nCurrentMeleeTime = 0;

			DoRunAttack();

		}
		else
		{
			KSkill * pSkill = (KSkill*)GetActiveSkill();
			if (!pSkill)
                return ;

            int nCurPhySkillId = pSkill->GetChildSkillId();//GetCurActiveWeaponSkill();
			if (nCurPhySkillId > 0)
			{
				KSkill * pOrdinSkill = (KSkill *) g_SkillManager.GetSkill(nCurPhySkillId, pSkill->m_ulLevel, SKILL_SS_Missles);
				if (pOrdinSkill)
                {
				    pOrdinSkill->Cast(m_Index, m_SkillParam1, m_SkillParam2);
                }
			}
			m_nCurrentMeleeTime ++;
		}

		m_ProcessAI = 0;
	}
	else if (m_SpecialSkillStep == 1)
	{
		if (WaitForFrame() &&m_Frames.nTotalFrame != 0)
		{
			DoStand();
			m_ProcessAI = 1;
		}
		else if (IsReachFrame(ATTACKACTION_EFFECT_PERCENT))
		{
			KSkill * pSkill = (KSkill*)GetActiveSkill();
			if (!pSkill)
                return ;

            int nCurPhySkillId = pSkill->GetChildSkillId();//GetCurActiveWeaponSkill();
			if (nCurPhySkillId > 0)
			{
				KSkill * pOrdinSkill = (KSkill *) g_SkillManager.GetSkill(nCurPhySkillId, pSkill->m_ulLevel, SKILL_SS_Missles);
				if (pOrdinSkill)
                {
				    pOrdinSkill->Cast(m_Index, m_SkillParam1, m_SkillParam2);
                }
			}
			DoStand();
			m_ProcessAI = 1;
			m_SpecialSkillStep = 0;
		}
#ifndef _SERVER
		m_DataRes.SetBlur(FALSE);
#endif
	}
	else
	{
#ifndef _SERVER
		m_DataRes.SetBlur(FALSE);
#endif
		DoStand();
		m_ProcessAI = 1;
		m_SpecialSkillStep = 0;
	}
}

BOOL KNpc::DoJumpAttack()
{
	m_ProcessAI = 0;

	switch(m_SpecialSkillStep)
	{
	case 0:
	{
		DoJump();

#ifndef _SERVER
		m_DataRes.SetBlur(TRUE);
		m_ClientDoing = cdo_jump;
#endif
		m_Doing = do_jumpattack;
		break;

	case 1:
#ifndef _SERVER
		if (g_Random(2))
			m_ClientDoing = cdo_attack;
		else
			m_ClientDoing = cdo_attack1;
		int x, y, tx, ty;
		SubWorld[m_SubWorldIndex].Map2Mps(m_RegionIndex, m_MapX, m_MapY, m_OffX, m_OffY, &x, &y);
		if (m_SkillParam1 == -1)
		{
			Npc[m_SkillParam2].GetMpsPos(&tx, &ty);
		}
		else
		{
			tx = m_SkillParam1;
			ty = m_SkillParam2;
		}
		m_Dir = g_GetDirIndex(x, y, tx, ty);
#endif
		m_Frames.nTotalFrame = m_AttackFrame * MAX_PERCENT / (MAX_PERCENT + m_CurrentAttackSpeed);
		m_Frames.nCurrentFrame = 0;
		m_Doing = do_jumpattack;
		break;
	}
	case 2:
	case 3:
#ifndef _SERVER
		m_DataRes.SetBlur(FALSE);
#endif
		DoStand();
		m_ProcessAI = 1;
		m_SpecialSkillStep = 0;
		return FALSE;
		break;
	}

	m_Frames.nCurrentFrame = 0;

	return TRUE;

}

BOOL KNpc::OnJumpAttack()
{
	if (m_SpecialSkillStep == 0)
	{
		if (!OnJump())
		{
			m_SpecialSkillStep ++;
			m_nCurrentMeleeTime = 0;
			DoJumpAttack();
		}
		m_ProcessAI = 0;
	}
	else if (m_SpecialSkillStep == 1)
	{
#ifndef _SERVER
		m_DataRes.SetBlur(FALSE);
#endif
		if (WaitForFrame() &&m_Frames.nTotalFrame != 0)
		{
			DoStand();
			m_ProcessAI = 1;
		}
		else if (IsReachFrame(ATTACKACTION_EFFECT_PERCENT))
		{
			KSkill * pSkill =(KSkill*) GetActiveSkill();
			if (!pSkill)
                return FALSE;

            int nCurPhySkillId = pSkill->GetChildSkillId();//GetCurActiveWeaponSkill();
			if (nCurPhySkillId > 0)
			{
				KSkill * pOrdinSkill = (KSkill *) g_SkillManager.GetSkill(nCurPhySkillId, pSkill->m_ulLevel, SKILL_SS_Missles);
				if (pOrdinSkill)
                {
					pOrdinSkill->Cast(m_Index, m_SkillParam1, m_SkillParam2);
                }
			}
			DoStand();
			m_ProcessAI = 1;
			m_SpecialSkillStep = 0;
		}
	}
	else
	{
#ifndef _SERVER
		m_DataRes.SetBlur(FALSE);
#endif
		DoStand();
		m_ProcessAI = 1;
		m_SpecialSkillStep = 0;
		return FALSE;
	}
	return TRUE;
}

BOOL KNpc::CheckHitTarget(int nAR, int nDf, int nIngore/* = 0*/)
{
	int nDefense = 0;
	if (nIngore < MAX_PERCENT)
		nDefense = nDf * (MAX_PERCENT - nIngore) / MAX_PERCENT;
	int nPercent = 0;
	// Phong Than 2026-10-02: AR = dexterity * 4 - 28 is negative for new Dao Si / Di Nhan
	// (dexterity 3), which made every hit miss; treat it as 0 (the 40% floor below applies).
	if (nAR < 0)
		nAR = 0;

	if (nDf < 0)
		nPercent = MAX_HIT_PERCENT;
	else if ((nAR + nDefense) == 0)
		nPercent = 50;
	else
		nPercent = nAR * MAX_PERCENT / (nAR + nDefense);

	if (nPercent > MAX_HIT_PERCENT + 4)
		nPercent = MAX_HIT_PERCENT;

	if (nPercent < 40)
		nPercent = 40;

	BOOL bRet = g_RandPercent(nPercent);
	return bRet;
}

void KNpc::GetNpcCopyFromTemplate(int nNpcTemplateId)
{
	if (nNpcTemplateId < 0 || nNpcTemplateId >= MAX_NPCSTYLE)
	{
		g_DebugLog("NpcTemplateId out of range: %d", nNpcTemplateId);
		return ;
	}

	if (g_pNpcTemplate[nNpcTemplateId]) //������Ч�򿽱���������������
		LoadDataFromTemplate(nNpcTemplateId);
	else
	{
		g_pNpcTemplate[nNpcTemplateId] = new KNpcTemplate;
		g_pNpcTemplate[nNpcTemplateId]->m_NpcSettingIdx = nNpcTemplateId;
		g_pNpcTemplate[nNpcTemplateId]->Init(nNpcTemplateId);
		g_pNpcTemplate[nNpcTemplateId]->m_bHaveLoadedFromTemplate = TRUE;
		LoadDataFromTemplate(nNpcTemplateId);
	}
}

void	KNpc::LoadDataFromTemplate(int nNpcTemplateId)
{
	if (nNpcTemplateId < 0 || nNpcTemplateId >= MAX_NPCSTYLE)
	{
		g_DebugLog("NpcTemplateId out of range: %d", nNpcTemplateId);
		return ;
	}

	KNpcTemplate * pNpcTemp = g_pNpcTemplate[nNpcTemplateId];
	if (pNpcTemp == NULL)
	{
		g_DebugLog("NpcTemplate is null: %d", nNpcTemplateId);
		return ;
	}

	m_HeadImage =	pNpcTemp->m_HeadImage;
	m_CorpseSettingIdx =	pNpcTemp->m_CorpseSettingIdx;
	m_DeathFrame =	pNpcTemp->m_DeathFrame;
	m_WalkFrame =	pNpcTemp->m_WalkFrame;
	m_RunFrame =	pNpcTemp->m_RunFrame;
	m_HurtFrame =	pNpcTemp->m_HurtFrame;
	m_WalkSpeed =	pNpcTemp->m_WalkSpeed;
	m_StandFrame =  pNpcTemp->m_StandFrame;
	m_StandFrame1 = pNpcTemp->m_StandFrame1;

#ifndef _SERVER
	m_Appearance.Armor.nResourceId = pNpcTemp->m_ArmorResourceId;
	m_Appearance.Armor.nPaletteId = 0;
	m_Appearance.Armor.bVisible = TRUE;
	m_Appearance.Helm.nResourceId = pNpcTemp->m_HelmResourceId;
	m_Appearance.Helm.nPaletteId = 0;
	m_Appearance.Helm.bVisible = TRUE;
	m_Appearance.PhiPhong.nResourceId = 0;
	m_Appearance.PhiPhong.nPaletteId = 0;
	m_Appearance.PhiPhong.bVisible = FALSE;
	m_Appearance.Weapon.nResourceId = pNpcTemp->m_WeaponResourceId;
	m_Appearance.Weapon.nPaletteId = 0;
	m_Appearance.Weapon.bVisible = TRUE;
#endif

	if(m_Kind != kind_player)
	{
		m_AttackFrame =	pNpcTemp->m_AttackFrame;
		m_CastFrame =	pNpcTemp->m_CastFrame;
		m_RunSpeed =	pNpcTemp->m_RunSpeed;
#ifndef _SERVER
		m_Appearance.Horse.nResourceId = pNpcTemp->m_HorseResourceId;
		m_Appearance.Horse.nPaletteId = 0;
		m_Appearance.Horse.bVisible = pNpcTemp->m_HorseResourceId >= 0;
		m_bRideHorse			= pNpcTemp->m_bRideHorse;
#endif
		strcpy(Name, pNpcTemp->Name);
		m_Kind = pNpcTemp->m_Kind;
		m_Camp = pNpcTemp->m_Camp;
		m_Series = pNpcTemp->m_Series;
		m_bClientOnly = pNpcTemp->m_bClientOnly;
		m_NpcSettingIdx = pNpcTemp->m_NpcSettingIdx;
		m_nStature		= pNpcTemp->m_nStature;

#ifdef _SERVER
		m_SkillList		= pNpcTemp->m_SkillList;
		g_StrCpyLen(ActionScript, pNpcTemp->m_ActionScript,
			sizeof(ActionScript));
		m_ActionScriptID = pNpcTemp->m_ActionScriptID;
		m_DeathScriptID = pNpcTemp->m_DeathScriptID;
		// In the VNG registry every DeathScript without OnDeath belongs to a
		// kind_dialoger template and exposes main().  Those rows use the field
		// as their template interaction script when Region_S has no override.
		if (m_Kind == kind_dialoger && !m_ActionScriptID && m_DeathScriptID &&
			NpcScriptDefinesFunction(m_DeathScriptID, "main") &&
			!NpcScriptDefinesFunction(m_DeathScriptID, "OnDeath"))
		{
			g_StrCpyLen(ActionScript, pNpcTemp->m_DeathScript,
				sizeof(ActionScript));
			m_ActionScriptID = m_DeathScriptID;
			m_DeathScriptID = 0;
		}
		m_TimerScriptID = pNpcTemp->m_TimerScriptID;
		m_LevelScriptID = pNpcTemp->m_LevelScriptID;
		m_nNpcTimerValue = pNpcTemp->m_TimerValue;
		m_AiMode		= pNpcTemp->m_AiMode;
		m_AiAddLifeTime	= 0;

		if (!m_AiSkillRadiusLoadFlag)
		{
			m_AiSkillRadiusLoadFlag = 1;
			int i;
			for (i = 0; i < MAX_AI_PARAM - 1; i ++)
				m_AiParam[i] =	pNpcTemp->m_AiParam[i];

			int		nMaxRadius = 0, nTempRadius;
			KSkill	*pSkill;
			for (i = 1; i < MAX_NPC_USE_SKILL + 1; i++)
			{
				pSkill = (KSkill*)g_SkillManager.GetSkill(m_SkillList.m_Skills[i].SkillId, m_SkillList.m_Skills[i].CurrentSkillLevel);
				if (!pSkill)
					continue;
				nTempRadius = pSkill->GetAttackRadius();
				if (nTempRadius > nMaxRadius)
					nMaxRadius = nTempRadius;
			}
			m_AiParam[MAX_AI_PARAM - 1] = nMaxRadius * nMaxRadius;
		}

		m_FireResistMax			= pNpcTemp->m_FireResistMax;
		m_ColdResistMax			= pNpcTemp->m_ColdResistMax;
		m_LightResistMax		= pNpcTemp->m_LightResistMax;
		m_EarthResistMax		= pNpcTemp->m_EarthResistMax;
		m_PoisonResistMax		= pNpcTemp->m_PoisonResistMax;
		m_PhysicsResistMax		= pNpcTemp->m_PhysicsResistMax;
		m_ActiveRadius			= pNpcTemp->m_ActiveRadius;
		m_VisionRadius			= pNpcTemp->m_VisionRadius;
		m_AIMAXTime				= pNpcTemp->m_AIMAXTime;
		m_HitRecover			= pNpcTemp->m_HitRecover;
		m_ReviveFrame			= pNpcTemp->m_ReviveFrame;
		m_Experience			= pNpcTemp->m_Experience;
		m_CurrentExperience		= m_Experience;
		m_LifeReplenish			= pNpcTemp->m_LifeReplenish;
		m_AttackRating			= pNpcTemp->m_AttackRating;
		m_Defend				= pNpcTemp->m_Defend;
		m_ExDefend				= pNpcTemp->m_ExDefend;
		m_PhysicsDamage			= pNpcTemp->m_PhysicsDamage;
		m_RedLum				= pNpcTemp->m_RedLum;
		m_GreenLum				= pNpcTemp->m_GreenLum;
		m_BlueLum				= pNpcTemp->m_BlueLum;
		m_FireResist			= pNpcTemp->m_FireResist;
		m_ColdResist			= pNpcTemp->m_ColdResist;
		m_LightResist			= pNpcTemp->m_LightResist;
		m_EarthResist			= pNpcTemp->m_EarthResist;
		m_PoisonResist			= pNpcTemp->m_PoisonResist;
		m_PhysicsResist			= pNpcTemp->m_PhysicsResist;
		ApplyPhongThanNpcLevelData(this, pNpcTemp);
		m_CurrentExperience		= m_Experience;
#endif
		RestoreNpcBaseInfo();
	}
}

//-----------------------------------------------------------------------
//	���ܣ��趨���������������С??not end ��Ҫ���ǵ��õĵط�
//-----------------------------------------------------------------------
void	KNpc::SetPhysicsDamage(int nMinDamage, int nMaxDamage)
{
	m_PhysicsDamage.nValue[0] = nMinDamage;
	m_PhysicsDamage.nValue[2] = nMaxDamage;
}

void	KNpc::SetReviveFrame(int nReviveFrame)
{
	m_ReviveFrame = nReviveFrame;
}


//-----------------------------------------------------------------------
//	���ܣ��趨����������
//-----------------------------------------------------------------------
void	KNpc::SetBaseAttackRating(int nAttackRating)
{
	m_AttackRating = nAttackRating;
	// �˴�����Ҫ����װ�������ܵ�Ӱ�죬�������ǰ??
	m_CurrentAttackRating = m_AttackRating;
}

//-----------------------------------------------------------------------
//	���ܣ��趨������
//-----------------------------------------------------------------------
void	KNpc::SetBaseDefence(int nDefence)
{
	m_Defend = nDefence;
	// �˴�����Ҫ����װ�������ܵ�Ӱ�죬�������ǰ??
	m_CurrentDefend = m_Defend;
}

/*
//-----------------------------------------------------------------------
//	���ܣ��趨�����ٶ�
//-----------------------------------------------------------------------
void	KNpc::SetBaseWalkSpeed(int nSpeed)
{
	m_WalkSpeed = nSpeed;
	// �˴�����Ҫ����װ�������ܵ�Ӱ�죬�������ǰ??(not end)
	m_CurrentWalkSpeed = m_WalkSpeed;
}
*/

/*
//-----------------------------------------------------------------------
//	���ܣ��趨�ܲ��ٶ�
//-----------------------------------------------------------------------
void	KNpc::SetBaseRunSpeed(int nSpeed)
{
	m_RunSpeed = nSpeed;
	// �˴�����Ҫ����װ�������ܵ�Ӱ�죬�������ǰ??(not end)
	m_CurrentRunSpeed = m_RunSpeed;
}
*/

#ifdef _SERVER
void KNpc::DeathPunish(int nMode, int nBelongPlayer)
{
//	g_DebugLog("DeathPunish 1"); // Check lai va fix loi debug PK
#define	LOSE_EXP_SCALE		10

	if (IsPlayer())
	{
		// ��npc kill
		if (nMode == enumDEATH_MODE_NPC_KILL)
		{
			// ������???
			//if (Player[m_nPlayerIdx].m_nExp > 0)
			//{
				int nSubExp;
				if (m_Level <= 10)
					nSubExp = (PlayerSet.m_cLevelAdd.GetLevelExp(m_Level, m_byTranslife)  / MAX_PERCENT) * 2;
				else
					nSubExp = (PlayerSet.m_cLevelAdd.GetLevelExp(m_Level, m_byTranslife)  / MAX_PERCENT) * 4;

				Player[m_nPlayerIdx].DirectAddExp( -nSubExp );
			//}
			// Ǯ����
			int nMoney = Player[m_nPlayerIdx].m_ItemList.GetEquipmentMoney() / 2;
			if (nMoney > 0)
			{
				Player[m_nPlayerIdx].m_ItemList.CostMoney(nMoney);
				// ��ʧ��Ǯ��Ϣ
				SHOW_MSG_SYNC	sMsg;
				sMsg.ProtocolType = s2c_msgshow;
				sMsg.m_wMsgID = enumMSG_ID_DEC_MONEY;
				sMsg.m_lpBuf = (void *)(nMoney);
				sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1;
				g_pServer->PackDataToClient(Player[m_nPlayerIdx].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
				sMsg.m_lpBuf = 0;

				if (nMoney / 2 > 0)
					PlayerDeadCreateMoneyObj(nMoney / 2);
			}
		}
		// �д裬û�гͷ�
		else if (nMode == enumDEATH_MODE_PLAYER_NO_PUNISH)
		{
			return;
		}
		else if (nMode == enumDEATH_MODE_PKBATTLE_PUNISH)
		{
			return;
		}
		// PK��������PKֵ����ͷ???		else //if (nMode == enumDEATH_MODE_PLAYER_PUNISH)
		{
			int		nPKValue;
			nPKValue = Player[this->m_nPlayerIdx].m_cPK.GetPKValue();
			if (nPKValue < 0)
				nPKValue = 0;
			if (nPKValue > MAX_DEATH_PUNISH_PK_VALUE)
				nPKValue = MAX_DEATH_PUNISH_PK_VALUE;

			// ������???
			if(m_Level < NpcSet.m_nLevelBoundaryPKPunish)
			{
				DWORD		dwLevelExp = PlayerSet.m_cLevelAdd.GetLevelExp(m_Level, m_byTranslife);
				Player[m_nPlayerIdx].DirectAddExp( -(dwLevelExp / MAX_PERCENT * PlayerSet.m_sPKPunishParam[nPKValue].m_nExpP) );
			}
			else
				Player[m_nPlayerIdx].DirectAddExp( -PlayerSet.m_sPKPunishParam[nPKValue].m_nExpV );

			// Ǯ����
			int nMoney = Player[m_nPlayerIdx].m_ItemList.GetEquipmentMoney() * PlayerSet.m_sPKPunishParam[nPKValue].m_nMoney / MAX_PERCENT;
			if (nMoney > 0)
			{
				Player[m_nPlayerIdx].m_ItemList.CostMoney(nMoney);
				// ��ʧ��Ǯ��Ϣ
				SHOW_MSG_SYNC	sMsg;
				sMsg.ProtocolType = s2c_msgshow;
				sMsg.m_wMsgID = enumMSG_ID_DEC_MONEY;
				sMsg.m_lpBuf = (void *)(nMoney);
				sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1;
				g_pServer->PackDataToClient(Player[m_nPlayerIdx].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
				sMsg.m_lpBuf = 0;

				if (nMoney / 2 > 0)
					PlayerDeadCreateMoneyObj(nMoney / 2);
			}

			// ��ʧ��Ʒ
			if (nPKValue > 0)
			{
					int dobengiam = nPKValue*5;
					Player[m_nPlayerIdx].m_ItemList.AutoDurationItem(dobengiam);
					char ThongBaoDoBen[100];
					sprintf(ThongBaoDoBen,"�� b�n to�n b?trang b?gi�m %d ph�n tr�m do b�n �ang c?%d �i�m PK trong ng��i",dobengiam,nPKValue);
					KPlayerChat::SendSystemInfo(1,m_nPlayerIdx, MESSAGE_SYSTEM_ANNOUCE_HEAD,ThongBaoDoBen,strlen(ThongBaoDoBen) );

			}

			// ��ʧ�������ϵ�װ��
			if (g_Random(MAX_PERCENT) < PlayerSet.m_sPKPunishParam[nPKValue].m_nEquip)
			{
				Player[m_nPlayerIdx].m_ItemList.AutoLoseEquip();
			}

            if (nMode == enumDEATH_MODE_PKBATTLE_PUNISH)
			{
				Player[m_nPlayerIdx].m_cPK.AddPKValue(NpcSet.m_nBeKilledAddPKValue);
			}

			if (m_nLastDamageIdx)
			{
				if (Npc[m_nLastDamageIdx].IsPlayer())
				{
					KPlayerChat::MakeEnemy(Name, Npc[m_nLastDamageIdx].Name);
				}
			}
		}
	}
}


// �������ʱ���������Ǯ����һ��object
void	KNpc::PlayerDeadCreateMoneyObj(int nMoneyNum)
{
	int		nX, nY;
	POINT	ptLocal;
	KMapPos	Pos;

	GetMpsPos(&nX, &nY);
	ptLocal.x = nX;
	ptLocal.y = nY;
	SubWorld[m_SubWorldIndex].GetFreeObjPos(ptLocal);

	Pos.nSubWorld = m_SubWorldIndex;
	SubWorld[m_SubWorldIndex].Mps2Map(ptLocal.x, ptLocal.y,
		&Pos.nRegion, &Pos.nMapX, &Pos.nMapY,
		&Pos.nOffX, &Pos.nOffY);

	int nObjIdx = ObjSet.AddMoneyObj(Pos, nMoneyNum);
	if (nObjIdx > 0 && nObjIdx < MAX_OBJECT)
	{
		Object[nObjIdx].SetItemBelong(-1);
	}
}

void KNpc::Revive()
{
	RestoreNpcBaseInfo();
	int nRegion, nMapX, nMapY, nOffX, nOffY;
	SubWorld[m_SubWorldIndex].Mps2Map(m_OriginX, m_OriginY, &nRegion, &nMapX, &nMapY, &nOffX, &nOffY);
	m_RegionIndex = nRegion;
	m_MapX = nMapX;
	m_MapY = nMapY;
	m_MapZ = 0;
	m_OffX = nOffX;
	m_OffY = nOffY;
	if (m_RegionIndex < 0)
		return;
	SubWorld[m_SubWorldIndex].m_Region[m_RegionIndex].AddRef(m_MapX, m_MapY, obj_npc);
#ifdef _SERVER
	SubWorld[m_SubWorldIndex].NpcChangeRegion(VOID_REGION, nRegion, m_Index);	// spe 03/06/28
	if (m_ActionScriptID)
		NpcSet.ExecuteScript(m_Index, m_ActionScriptID, "Revive", m_Index);
#else
	SubWorld[0].NpcChangeRegion(VOID_REGION, SubWorld[0].m_Region[nRegion].m_RegionID, m_Index);
#endif
	DoStand();
	m_ProcessAI = 1;
	m_ProcessState = 1;
	m_AiAddLifeTime = 0;
}

void KNpc::RestoreLiveData()
{

}
#endif



#ifdef	_SERVER
// ����Χ�����㲥
void	KNpc::SendDataToNearRegion(void* pBuffer, DWORD dwSize)
{
	_ASSERT(m_RegionIndex >= 0);
	if (m_RegionIndex < 0)
		return;

	POINT	POff[8] =
	{
		{0, 32},
		{-16, 32},
		{-16, 0},
		{-16, -32},
		{0, -32},
		{16, -32},
		{16, 0},
		{16, 32},
	};
	int nMaxCount = MAX_BROADCAST_COUNT;
	SubWorld[m_SubWorldIndex].m_Region[m_RegionIndex].BroadCast(pBuffer, dwSize, nMaxCount, m_MapX, m_MapY);
	for (int i= 0; i < 8; i++)
	{
		if (SubWorld[m_SubWorldIndex].m_Region[m_RegionIndex].m_nConnectRegion[i] < 0)
			continue;
		SubWorld[m_SubWorldIndex].m_Region[SubWorld[m_SubWorldIndex].m_Region[m_RegionIndex].m_nConnectRegion[i]].BroadCast(pBuffer, dwSize, nMaxCount, m_MapX - POff[i].x, m_MapY - POff[i].y);
	}
}
#endif



#ifdef	_SERVER
//-----------------------------------------------------------------------------
//	���ܣ�����ʱ�����PKֵ
//-----------------------------------------------------------------------------
int		KNpc::DeathCalcPKValue(int nKiller)
{
//	g_DebugLog("DeathPunish 2"); // Check lai va fix loi debug PK / set Pk chien dau den do sat la bug - check lai
	// ����
	if (nKiller <= 0 || nKiller >= MAX_NPC)
		return enumDEATH_MODE_NPC_KILL;

//	g_DebugLog(".m_nKillPeopleNumber %d, %d", Player[Npc[nKiller].m_nPlayerIdx].m_nKillPeopleNumber,nKiller);

	if (m_nCurPKPunishState == enumDEATH_MODE_PKBATTLE_PUNISH ||
		m_nCurPKPunishState == enumDEATH_MODE_TOURNAMENTS_PUNISH)
		return m_nCurPKPunishState;

	// ���֮�䣬�����???
	if (this->m_Kind != kind_player || Npc[nKiller].m_Kind != kind_player || !m_FightMode)
		return enumDEATH_MODE_NPC_KILL;
	// ������д裬�����???
	if (Player[m_nPlayerIdx].m_cPK.GetExercisePKAim() == Npc[nKiller].m_nPlayerIdx)
	{
		if (Player[m_nPlayerIdx].m_cPK.IsEnmitySpar())
		{
			SHOW_MSG_SYNC	sMsg;
			sMsg.ProtocolType = s2c_msgshow;
			sMsg.m_wMsgID = enumMSG_ID_SPAR_DEFEAT;
			sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
			g_pServer->PackDataToClient(Player[m_nPlayerIdx].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
			sMsg.m_wMsgID = enumMSG_ID_SPAR_VICTORY;
			sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
			g_pServer->PackDataToClient(Player[Npc[nKiller].m_nPlayerIdx].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
			return enumDEATH_MODE_PLAYER_SPAR_NO_PUNISH;
		}

		return enumDEATH_MODE_PLAYER_NO_PUNISH;
	}
	// ����ǳ�??
	if (Player[m_nPlayerIdx].m_cPK.GetEnmityPKState() == enumPK_ENMITY_STATE_PKING &&
		Player[m_nPlayerIdx].m_cPK.GetEnmityPKAim() == Npc[nKiller].m_nPlayerIdx)
	{
		if (Player[Npc[nKiller].m_nPlayerIdx].m_cPK.IsEnmitySpar())
		{
			SHOW_MSG_SYNC	sMsg;
			sMsg.ProtocolType = s2c_msgshow;
			sMsg.m_wMsgID = enumMSG_ID_SPAR_DEFEAT;
			sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
			g_pServer->PackDataToClient(Player[m_nPlayerIdx].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
			sMsg.m_wMsgID = enumMSG_ID_SPAR_VICTORY;
			sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
			g_pServer->PackDataToClient(Player[Npc[nKiller].m_nPlayerIdx].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
			return enumDEATH_MODE_PLAYER_SPAR_NO_PUNISH;
		}
		else
		{
			if (Player[Npc[nKiller].m_nPlayerIdx].m_cPK.IsEnmityPKLauncher())
				Player[Npc[nKiller].m_nPlayerIdx].m_cPK.AddPKValue(NpcSet.m_nEnmityAddPKValue);

			Player[Npc[nKiller].m_nPlayerIdx].m_nKillPeopleNumber++; //Pk 10

			return enumDEATH_MODE_PLAYER_PUNISH;
		}
	}
	if (Player[m_nPlayerIdx].m_cPK.GetNormalPKState() != enumPKMurder && Player[Npc[nKiller].m_nPlayerIdx].m_cPK.GetNormalPKState() == enumPKMurder)
	{
		Player[Npc[nKiller].m_nPlayerIdx].m_cPK.AddPKValue(NpcSet.m_nMurderAddPKValue);

		Player[Npc[nKiller].m_nPlayerIdx].m_nKillPeopleNumber++;  //Pk 10

		return enumDEATH_MODE_PLAYER_PUNISH;
	}
	if (m_Level <= 50 && Npc[nKiller].m_Level * 2 >= m_Level * 3)
	{
		if (!Player[m_nPlayerIdx].m_cPK.GetNormalPKState())
		{
			if (Npc[nKiller].m_CurrentCamp == camp_free)
				Player[Npc[nKiller].m_nPlayerIdx].m_cPK.AddPKValue(NpcSet.m_nFreeCampKillAddPKValue);
			else
				Player[Npc[nKiller].m_nPlayerIdx].m_cPK.AddPKValue(NpcSet.m_nCampKillAddPKValue);
		}
		Player[Npc[nKiller].m_nPlayerIdx].m_nKillPeopleNumber++; //Pk 10

		return enumDEATH_MODE_PLAYER_PUNISH;
	}

	return enumDEATH_MODE_PLAYER_PUNISH;
}
#endif

#ifdef	_SERVER
//-----------------------------------------------------------------------------
//	���ܣ�������Χ9��Region���Ƿ���ָ���� player
//-----------------------------------------------------------------------------
int	KNpc::FindAroundPlayer(const char* Name)
{
	int nNpc = 0;
	if (Name[0] <= 0 || m_RegionIndex < 0)
		return nNpc;
	nNpc = SubWorld[m_SubWorldIndex].m_Region[m_RegionIndex].SearchNpcName(Name);
	if (nNpc)
		return nNpc;
	int		nRegionNo;
	for (int i = 0; i < 8; i++)
	{
		nRegionNo = SubWorld[m_SubWorldIndex].m_Region[m_RegionIndex].m_nConnectRegion[i];
		if ( nRegionNo < 0)
			continue;
		nNpc = SubWorld[m_SubWorldIndex].m_Region[nRegionNo].SearchNpcName(Name);
		if (nNpc)
			return nNpc;
	}
	return nNpc;
}
#endif

#ifndef _SERVER
//-------------------------------------------------------------------------
//	���ܣ��趨ͷ��״̬
//-------------------------------------------------------------------------
void	KNpc::SetMenuState(int nState, char *lpszSentence, int nLength)
{
	this->m_DataRes.SetMenuState(nState, lpszSentence, nLength);
}
#endif

#ifndef _SERVER
//-------------------------------------------------------------------------
//	���ܣ����ͷ��״??
//-------------------------------------------------------------------------
int		KNpc::GetMenuState()
{
	return this->m_DataRes.GetMenuState();
}
#endif

#ifndef _SERVER
//-------------------------------------------------------------------------
//	���ܣ�������Χ9��Region���Ƿ���ָ�� ID �� npc
//-------------------------------------------------------------------------
DWORD	KNpc::SearchAroundID(DWORD dwID)
{
	int		nIdx, nRegionNo;
	nIdx = SubWorld[0].m_Region[m_RegionIndex].SearchNpc(dwID);
	if (nIdx)
		return nIdx;
	for (int i = 0; i < 8; i++)
	{
		nRegionNo = SubWorld[0].m_Region[m_RegionIndex].m_nConnectRegion[i];
		if ( nRegionNo < 0)
			continue;
		nIdx = SubWorld[0].m_Region[nRegionNo].SearchNpc(dwID);
		if (nIdx)
			return nIdx;
	}
	return 0;
}
#endif

#ifndef _SERVER
//-------------------------------------------------------------------------
//	���ܣ��趨�����ֻ����һ�������spr�ļ�
//-------------------------------------------------------------------------
void	KNpc::SetSpecialSpr(char *lpszSprName)
{
	m_DataRes.SetSpecialSpr(lpszSprName);
}
#endif

#ifndef _SERVER
//-------------------------------------------------------------------------
//	���ܣ��趨˲����Ч
//-------------------------------------------------------------------------
void	KNpc::SetInstantSpr(int nNo)
{
	char	szName[FILE_NAME_LENGTH];
	szName[0] = 0;
	NpcSet.m_cInstantSpecial.GetSprName(nNo, szName, sizeof(szName));
	if (szName[0])
		this->SetSpecialSpr(szName);
}
#endif

#ifndef _SERVER
int		KNpc::GetNormalNpcStandDir(int nFrame)
{
	return m_DataRes.GetNormalNpcStandDir(nFrame);
}

void KNpc::GetNpcResFile(int nNpcSettingIdx, char* pszResPath)
{
	if (nNpcSettingIdx < 0)
		return;

	char szNpcTypeName[32];
	g_NpcSetting.GetString(nNpcSettingIdx + 2, "NpcResType", "", szNpcTypeName, sizeof(szNpcTypeName));
	m_DataRes.m_pcResTemp = g_NpcResList.AddNpcRes(szNpcTypeName);
	if ( m_DataRes.m_pcResTemp == NULL )
	{
		strcpy(pszResPath, UNKNOWNITEM_SPR);
		return;
	}
	m_DataRes.GetResFile(::GetRandomNumber(1, 12), pszResPath);
	if (!pszResPath[0])
		m_DataRes.GetResFile(0, pszResPath);
}

void KNpc::KeyToImage(char* szKey, int nAction, KUiImage* pImage)
{
	if (szKey[0] == 0)
	{
		memset(pImage->Name, 0, sizeof(pImage->Name));
		pImage->Name[0] = 0x20;
	}
	else
	{
		KImageParam sImage;
		if (g_pRepresent->GetImageParam(szKey, &sImage, ISI_T_SPR) == true)
		{
			strcpy(pImage->Name, szKey);
			pImage->Frame = sImage.nNumFrames;
		}
		else
		{
			if (strcmp(szKey, NPCNAME_KEY) != 0)
			{
				m_DataRes.m_pcResTemp = g_NpcResList.AddNpcRes(szKey);
				if ( m_DataRes.m_pcResTemp == NULL )
				{
					strcpy(pImage->Name, UNKNOWNITEM_SPR);
					pImage->Frame = 0;
				}
				else
				{
					for (int i = 0; i < MAX_PART; i++)
					{
						m_DataRes.m_pcResTemp->GetFileName(i, nAction, 0, "", pImage->Name, sizeof(pImage->Name));
						if (pImage->Name[0])
						{
							pImage->Frame = (m_DataRes.m_pcResTemp->GetTotalFrames(i, nAction, 0, MAX_PART))/
							(m_DataRes.m_pcResTemp->GetTotalDirs(i, nAction, 0, MAX_PART)); return;
						}
					}
					for (int j = 0; j < MAX_PART; j++)
					{
						m_DataRes.m_pcResTemp->GetFileName(j, 0, 0, "", pImage->Name, sizeof(pImage->Name));
						if (pImage->Name[0])
						{
							pImage->Frame = (m_DataRes.m_pcResTemp->GetTotalFrames(j, 0, 0, MAX_PART))/
							(m_DataRes.m_pcResTemp->GetTotalDirs(j, 0, 0, MAX_PART)); return;
						}
					}
				}
			}
			else
			{
				if (Player[m_nPlayerIdx].m_nLastNpcIndex)
				{
					for (int i = 0; i < MAX_PART; i++)
					{
						Npc[Player[m_nPlayerIdx].m_nLastNpcIndex].GetNpcRes()->m_pcResNode->GetFileName(i, nAction, 0, "", pImage->Name, sizeof(pImage->Name));
						if (pImage->Name[0])
						{
							pImage->Frame = (Npc[Player[m_nPlayerIdx].m_nLastNpcIndex].GetNpcRes()->m_pcResNode->GetTotalFrames(i, nAction, 0, MAX_PART))/
							(Npc[Player[m_nPlayerIdx].m_nLastNpcIndex].GetNpcRes()->m_pcResNode->GetTotalDirs(i, nAction, 0, MAX_PART)); return;
						}
					}
					for (int j = 0; j < MAX_PART; j++)
					{
						Npc[Player[m_nPlayerIdx].m_nLastNpcIndex].GetNpcRes()->m_pcResNode->GetFileName(j, 0, 0, "", pImage->Name, sizeof(pImage->Name));
						if (pImage->Name[0])
						{
							pImage->Frame = (Npc[Player[m_nPlayerIdx].m_nLastNpcIndex].GetNpcRes()->m_pcResNode->GetTotalFrames(j, 0, 0, MAX_PART))/
							(Npc[Player[m_nPlayerIdx].m_nLastNpcIndex].GetNpcRes()->m_pcResNode->GetTotalDirs(j, 0, 0, MAX_PART)); return;
						}
					}
				}
			}
		}
	}
}
#endif

#ifdef _SERVER
//���¸��½�ɫ״̬��Ϣ����
void	KNpc::UpdateNpcStateInfo()
{
	int i = 0, j = 0;
	memset(m_btStateInfo, 0 ,sizeof(BYTE) * MAX_SKILL_STATE);
	KStateNode *pNode = (KStateNode*)m_StateSkillList.GetTail();

	if (m_ActiveAuraID)
	{
		if (m_SkillList.GetLevel(m_ActiveAuraID) > 0)
		{
			KSkill * pOrdinSkill = (KSkill *) g_SkillManager.GetSkill(m_ActiveAuraID, 1);
			if (pOrdinSkill)
			{
				if (pOrdinSkill->GetStateSpecailId())
					m_btStateInfo[i++] = pOrdinSkill->GetStateSpecailId();

				if(pOrdinSkill->GetAppendSkillNum())
				{
					for( j = 0; j < pOrdinSkill->GetAppendSkillNum(); j++)
					{
						if(m_SkillList.GetLevel(pOrdinSkill->GetAppendSkillId(j)) <= 0)
							continue;
						pOrdinSkill = (KSkill *) g_SkillManager.GetSkill(pOrdinSkill->GetAppendSkillId(j), 1);
						if (pOrdinSkill)
						{
							if (pOrdinSkill->GetStateSpecailId())
								m_btStateInfo[i++] = pOrdinSkill->GetStateSpecailId();
						}
					}
				}
			}
		}
	}

	while ( pNode && i < MAX_SKILL_STATE)
	{
		if (pNode->m_StateGraphics > 0)
			m_btStateInfo[i++] = pNode->m_StateGraphics;
		pNode = (KStateNode*)pNode->GetPrev();
	}

	for (i; i < MAX_SKILL_STATE;i++)
		m_btStateInfo[i] = 0;
}

#endif

#ifndef _SERVER
void	KNpc::SetNpcState(BYTE* pNpcState)
{
	if (!pNpcState)
		return ;

	memcpy(m_btStateInfo, pNpcState, sizeof(BYTE) * MAX_SKILL_STATE);
}
#endif
void	KNpc::ClearNpcState()
{
	KStateNode * pNode = (KStateNode*)m_StateSkillList.GetHead();
	KStateNode * pTempNode = NULL;

	while(pNode)
	{
		pTempNode = pNode;
		pNode = (KStateNode*) pNode->GetNext();
		pTempNode->Remove();
		delete pTempNode;
	}
	return;
}


void	KNpc::RestoreNpcBaseInfo()
{

	m_CurrentCamp = m_Camp;
	m_ActiveSkillID = 0;
	m_ActiveAuraID = 0;
	m_nOwnerIdx = 0;
	m_nPetIdx = 0;
	m_nPeopleIdx = 0;
	m_nLastDamageIdx = 0;
	m_nLastPoisonDamageIdx = 0;
	m_nObjectIdx = 0;

	m_CurrentLife			= m_LifeMax;
	m_CurrentLifeMax		= m_LifeMax;
	m_CurrentLifeReplenish	= m_LifeReplenish;
	m_CurrentLifeReplenishPercent = 0;
	m_CurrentMana			= m_ManaMax;
	m_CurrentManaMax		= m_ManaMax;
	m_CurrentManaReplenish	= m_ManaReplenish;
	m_CurrentStamina		= m_StaminaMax;
	m_CurrentStaminaMax		= m_StaminaMax;
	m_CurrentStaminaGain	= m_StaminaGain;
	m_CurrentStaminaLoss	= m_StaminaLoss;

	memset(&m_CurrentFireDamage, 0, sizeof(m_CurrentFireDamage));
	memset(&m_CurrentColdDamage, 0, sizeof(m_CurrentColdDamage));
	memset(&m_CurrentLightDamage, 0, sizeof(m_CurrentLightDamage));
	memset(&m_CurrentEarthDamage, 0, sizeof(m_CurrentEarthDamage));
	memset(&m_CurrentPoisonDamage, 0, sizeof(m_CurrentPoisonDamage));

	memset(&m_CurrentFireMagic, 0, sizeof(m_CurrentFireMagic));
	memset(&m_CurrentColdMagic, 0, sizeof(m_CurrentColdMagic));
	memset(&m_CurrentLightMagic, 0, sizeof(m_CurrentLightMagic));
	memset(&m_CurrentEarthMagic, 0, sizeof(m_CurrentEarthMagic));
	memset(&m_CurrentPoisonMagic, 0, sizeof(m_CurrentPoisonMagic));

	m_CurrentAttackRating	= m_AttackRating;
	m_CurrentDefend			= m_Defend;

	m_CurrentFireResist		= m_FireResist;
	m_CurrentColdResist		= m_ColdResist;
	m_CurrentPoisonResist	= m_PoisonResist;
	m_CurrentLightResist	= m_LightResist;
	m_CurrentEarthResist	= m_EarthResist;
	m_CurrentPhysicsResist	= m_PhysicsResist;
	m_CurrentFireResistMax	= m_FireResistMax;
	m_CurrentColdResistMax	= m_ColdResistMax;
	m_CurrentPoisonResistMax = m_PoisonResistMax;
	m_CurrentLightResistMax	= m_LightResistMax;
	m_CurrentEarthResistMax	= m_EarthResistMax;
	m_CurrentPhysicsResistMax  = m_PhysicsResistMax;

	m_CurrentWalkSpeed		= m_WalkSpeed;
	m_CurrentRunSpeed		= m_RunSpeed;
	m_CurrentAttackSpeed	= m_AttackSpeed;
	m_CurrentCastSpeed		= m_CastSpeed;
	m_CurrentVisionRadius	= m_VisionRadius;
	m_CurrentActiveRadius	= m_ActiveRadius;
	m_CurrentHitRecover		= m_HitRecover;

	m_CurrentDamage2Mana	= 0;
	m_CurrentLifeStolen		= 0;
	m_CurrentManaStolen		= 0;
	m_CurrentStaminaStolen	= 0;
	m_CurrentPiercePercent	= 0;
	m_CurrentFreezeTimeReducePercent	= 0;
	m_CurrentPoisonTimeReducePercent	= 0;
	m_CurrentStunTimeReducePercent		= 0;
	m_CurrentFireEnhance	= 0;
	m_CurrentColdEnhance	= 0;
	m_CurrentPoisonEnhance	= 0;
	m_CurrentLightEnhance	= 0;
	m_CurrentEarthEnhance	= 0;
	m_CurrentRangeEnhance	= 0;
	m_CurrentHandEnhance	= 0;
	m_CurrentDeadlyStrikeEnhanceP	= 0;
	m_CurrentFatallyStrikeEnhanceP	= 0;
	m_CurrentFatallyStrikeResP	= 0;
	m_CurrentFatallyStrikeLifeP	= 0;	// engine2:D3r
	m_CurrentExDefend = m_ExDefend;
	m_CurrentIgnoreDefensePercent = 0;
	m_CurrentIgnoreExDefence = 0;
	m_CurrentIgnoreFireResist = 0;
	m_CurrentIgnoreColdResist = 0;
	m_CurrentIgnoreLightResist = 0;
	m_CurrentIgnoreEarthResist = 0;
	m_CurrentColdDamageMinPercent = 0;
	m_CurrentColdDamageMaxPercent = 0;
	m_CurrentAllMagicDeadlyStrike = 0;
	m_CurrentFireDeadlyStrike = 0;
	m_CurrentColdDeadlyStrike = 0;
	m_CurrentLightDeadlyStrike = 0;
	m_CurrentEarthDeadlyStrike = 0;
	m_CurrentReducePhysicsDeadlyStrike = 0;
	m_CurrentReduceMagicDeadlyStrike = 0;
	m_CurrentDamageReduce = 0;
	m_CurrentManaShield = 0;
	m_CurrentStaticMagicShieldP = 0;
	m_CurrentLucky = 0;
	m_CurrentExpEnhance = 0;
	m_CurrentExpSkillsEnchance = 1; //TamLTM ExpSkills x2
	m_CurrentPoisonDamageReturnPercent = 0;
	m_CurrentReturnSkillPercent = 0;
	m_CurrentIgnoreSkillPercent = 0;
	ZeroMemory(m_CurrentMeleeEnhance, sizeof(m_CurrentMeleeEnhance));
	memset(&m_ReplySkill, 0, sizeof(m_ReplySkill));
	memset(&m_RescueSkill, 0, sizeof(m_RescueSkill));
	memset(&m_AttackSkill, 0, sizeof(m_AttackSkill));
	memset(&m_DeathSkill, 0, sizeof(m_DeathSkill));
	m_CurrentIgnoreNegativeStateP = 0;

	m_CurrentSkillEnhancePercent = 0;
	m_CurrentFiveElementsEnhance = 0;
	m_CurrentFiveElementsResist = 0;
	m_CurrentManaToSkillEnhanceP = 0;

	ClearStateSkillEffect();
	ClearNormalState();
}

#ifndef _SERVER
void KNpc::DrawBorder()
{
	if (m_Index <= 0)
		return;

	m_DataRes.DrawBorder();
}

int KNpc::DrawMenuState(int n)
{
	if (m_Index <= 0)
		return n;

	return m_DataRes.DrawMenuState(n);
}

void KNpc::DrawBlood()
{
	if (m_Kind != kind_normal)
		return;
	// A dead monster waiting to revive has no body sprite (VNG *_die.spr missing);
	// do not draw its name and full life bar as if it were alive and targetable.
	if (m_Doing == do_death || m_Doing == do_revive)
		return;

	int nFontSize = 12;


	int nHeightOff = GetNpcPate();
	{
		nHeightOff = PaintLife(nHeightOff-10, true);
		nHeightOff += SHOW_SPACE_HEIGHT;
	}
	{
		nHeightOff = PaintInfo(nHeightOff, true);
	}
}
#endif

#ifdef _SERVER
int KNpc::SetPos(int nX, int nY)
{
	// if (m_SubWorldIndex < 0)
	// {
		// _ASSERT(0);
		// return 0;
	// }
	// int nRegion, nMapX, nMapY, nOffX, nOffY;
	// SubWorld[m_SubWorldIndex].Mps2Map(nX, nY, &nRegion, &nMapX, &nMapY, &nOffX, &nOffY);

	// if (nRegion < 0)
	// {
		// g_DebugLog("[Script]SetPos error:SubWorld:%d, Pos(%d, %d)", SubWorld[m_SubWorldIndex].m_SubWorldID, nX, nY);
		// return 0;
	// }

	// int nOldRegion = m_RegionIndex;
	// if (m_RegionIndex >= 0)
	// {
		// SubWorld[m_SubWorldIndex].m_Region[m_RegionIndex].DecRef(m_MapX, m_MapY, obj_npc);
		// NPC_REMOVE_SYNC	RemoveSync;
		// RemoveSync.ProtocolType = s2c_npcremove;
		// RemoveSync.ID = m_dwID;
		// RemoveSync.Rv = FALSE;
		// SendDataToNearRegion(&RemoveSync, sizeof(NPC_REMOVE_SYNC));
	// }
	// m_RegionIndex = nRegion;
	// m_MapX = nMapX;
	// m_MapY = nMapY;
	// m_MapZ = 0;
	// m_OffX = nOffX;
	// m_OffY = nOffY;

	// if (nOldRegion != nRegion)
	// {
		// SubWorld[m_SubWorldIndex].NpcChangeRegion(nOldRegion, nRegion, m_Index);
		// if (IsPlayer())
			// SubWorld[m_SubWorldIndex].PlayerChangeRegion(nOldRegion, nRegion, m_nPlayerIdx);
	// }
	// SubWorld[m_SubWorldIndex].m_Region[nRegion].AddRef(m_MapX, m_MapY, obj_npc);

	/* if (IsPlayer())
	 {
		 PHONGTHAN_ENTITY_POSITION	sSync;
		 ZeroMemory(&sSync, sizeof(sSync));
	PhongThanInitializeWireHeader(&sSync.Header, PHONGTHAN_MSG_WORLD_ENTITY_POSITION, sizeof(sSync), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	sSync.MapId = SubWorld[m_SubWorldIndex].m_SubWorldID;
	sSync.Mode = PHONGTHAN_POSITION_TELEPORT;
	sSync.Action = PhongThanEncodeEntityAction(m_Doing);
		 sSync.EntityId = m_dwID;
		 sSync.X = nX;
		 sSync.Y = nY;
		 g_pServer->PackDataToClient(Player[m_nPlayerIdx].m_nNetConnectIdx, (BYTE*)&sSync, sizeof(sSync));
	 }*/
	// DoStand();
	// m_ProcessAI = 1;
	// return 1;

	if (m_SubWorldIndex < 0)
	{
		_ASSERT(0);
		return 0;
	}
	int nRegion, nMapX, nMapY, nOffX, nOffY;
	SubWorld[m_SubWorldIndex].Mps2Map(nX, nY, &nRegion, &nMapX, &nMapY, &nOffX, &nOffY);

	if (nRegion < 0)
	{
		g_DebugLog("[Script]SetPos error:SubWorld:%d, Pos(%d, %d)", SubWorld[m_SubWorldIndex].m_SubWorldID, nX, nY);
		return 0;
	}

	int nOldRegion = m_RegionIndex;
	if (m_RegionIndex >= 0)
	{
		SubWorld[m_SubWorldIndex].m_Region[m_RegionIndex].DecRef(m_MapX, m_MapY, obj_npc);
		PHONGTHAN_ENTITY_REFERENCE RemoveSync;
		PhongThanInitializeWireHeader(&RemoveSync.Header, PHONGTHAN_MSG_WORLD_ENTITY_REMOVE,
			sizeof(RemoveSync), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
		RemoveSync.MapId = SubWorld[m_SubWorldIndex].m_SubWorldID;
		RemoveSync.EntityId = m_dwID;
		SendDataToNearRegion(&RemoveSync, sizeof(RemoveSync));
	}
	m_RegionIndex = nRegion;
	m_MapX = nMapX;
	m_MapY = nMapY;
	m_MapZ = 0;
	m_OffX = nOffX;
	m_OffY = nOffY;

	if (nOldRegion != nRegion)
	{
		SubWorld[m_SubWorldIndex].NpcChangeRegion(nOldRegion, nRegion, m_Index);
		if (IsPlayer())
			SubWorld[m_SubWorldIndex].PlayerChangeRegion(nOldRegion, nRegion, m_nPlayerIdx);
	}
	SubWorld[m_SubWorldIndex].m_Region[nRegion].AddRef(m_MapX, m_MapY, obj_npc);

	if (IsPlayer())
	{
		PHONGTHAN_ENTITY_POSITION	sSync;
		ZeroMemory(&sSync, sizeof(sSync));
	PhongThanInitializeWireHeader(&sSync.Header, PHONGTHAN_MSG_WORLD_ENTITY_POSITION, sizeof(sSync), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	sSync.MapId = SubWorld[m_SubWorldIndex].m_SubWorldID;
	sSync.Mode = PHONGTHAN_POSITION_TELEPORT;
	sSync.Action = PhongThanEncodeEntityAction(m_Doing);
		sSync.EntityId = m_dwID;
		sSync.X = nX;
		sSync.Y = nY;
		g_pServer->PackDataToClient(Player[m_nPlayerIdx].m_nNetConnectIdx, (BYTE*)&sSync, sizeof(sSync));
	 }

	DoStand();
	m_ProcessAI = 1;
	m_ProcessState = 1;
	return 1;
}
#endif

//TamLTM Fix lag pos NPC
#ifdef _SERVER
int KNpc::SetPosU(int nX, int nY)
{
	if (m_Doing == do_revive || m_Doing == do_death || !m_Index || !IsPlayer())
		return 0;

	if (m_SubWorldIndex < 0)
	{
		_ASSERT(0);
		return 0;
	}
	int nRegion, nMapX, nMapY, nOffX, nOffY;
	SubWorld[m_SubWorldIndex].Mps2Map(nX, nY, &nRegion, &nMapX, &nMapY, &nOffX, &nOffY);

	if (nRegion < 0)
	{
		g_DebugLog("[Script]SetPos error U:SubWorld:%d, Pos(%d, %d)", SubWorld[m_SubWorldIndex].m_SubWorldID, nX, nY);
		return 0;
	}

	int nOldRegion = m_RegionIndex;
	if (m_RegionIndex >= 0)
	{
		SubWorld[m_SubWorldIndex].m_Region[m_RegionIndex].DecRef(m_MapX, m_MapY, obj_npc);
	}
	m_RegionIndex = nRegion;
	m_MapX = nMapX;
	m_MapY = nMapY;
	m_MapZ = 0;
	m_OffX = nOffX;
	m_OffY = nOffY;

	if (nOldRegion != nRegion)
	{
		SubWorld[m_SubWorldIndex].NpcChangeRegion(nOldRegion, nRegion, m_Index);
		if (IsPlayer())
			SubWorld[m_SubWorldIndex].PlayerChangeRegion(nOldRegion, nRegion, m_nPlayerIdx);
	}
	SubWorld[m_SubWorldIndex].m_Region[nRegion].AddRef(m_MapX, m_MapY, obj_npc);

	PHONGTHAN_ENTITY_POSITION NpcSync;
	int	nMpsX, nMpsY;

	GetMpsPos(&nMpsX, &nMpsY);

	ZeroMemory(&NpcSync, sizeof(NpcSync));
	PhongThanInitializeWireHeader(&NpcSync.Header, PHONGTHAN_MSG_WORLD_ENTITY_POSITION, sizeof(NpcSync), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	NpcSync.MapId = SubWorld[m_SubWorldIndex].m_SubWorldID;
	NpcSync.Mode = PHONGTHAN_POSITION_TRACK;
	NpcSync.Action = PhongThanEncodeEntityAction(m_Doing);
	NpcSync.EntityId = m_dwID;
	NpcSync.X = nMpsX;
	NpcSync.Y = nMpsY;
	NpcSync.Action = PhongThanEncodeEntityAction(m_Doing);

	g_DebugLog("s2c_syncposmin %d", s2c_syncposmin); //TamLTM Debug error packet

	POINT	POff[8] =
	{
		{0, 32},
		{-16, 32},
		{-16, 0},
		{-16, -32},
		{0, -32},
		{16, -32},
		{16, 0},
		{16, 32},
	};
	int nMaxCount = MAX_PLAYER;
	CURREGION.BroadCast(&NpcSync, sizeof(NpcSync), nMaxCount, m_MapX, m_MapY);
	int j;
	for (j = 0; j < 8; j++)
	{
		int nConRegion = CURREGION.m_nConnectRegion[j];
		if (nConRegion == -1)
			continue;
		_ASSERT(m_SubWorldIndex >= 0 && nConRegion >= 0);
		SubWorld[m_SubWorldIndex].m_Region[nConRegion].BroadCast((BYTE*)&NpcSync, sizeof(PHONGTHAN_ENTITY_POSITION), nMaxCount, m_MapX - POff[j].x, m_MapY - POff[j].y);
	}

	DoStand();
	m_ProcessAI = 1;
	m_ProcessState = 1;
	return 1;
}
#endif
//end code


#ifdef _SERVER
int KNpc::ChangeWorld(DWORD dwSubWorldID, int nX, int nY)
{
	int nTargetSubWorld = g_SubWorldSet.SearchWorld(dwSubWorldID);

	if (!IsPlayer())
		return 0;
		if (-1 == nTargetSubWorld)
	{
		if (m_SubWorldIndex >= 0)
            //Son fix loi kick miss
		//SubWorld[m_SubWorldIndex].m_MissionArray.RemovePlayer(m_nPlayerIdx, Player[CLIENT_PLAYER_INDEX].m_dwID);
        SubWorld[m_SubWorldIndex].m_MissionArray.RemovePlayer(m_nPlayerIdx);
        //end code
		TobeExchangeServer(dwSubWorldID, nX, nY);
		g_DebugLog("[Map]World%d haven't been loaded!", dwSubWorldID);

		return 2;	// ��Ҫ���л��������Ĵ��� -- spe
	}
	if (IsPlayer())
		Player[m_nPlayerIdx].m_nPrePayMoney = 0;// ���ǿ�����������û�??
	// �л���������Ǳ��???
	if (nTargetSubWorld == m_SubWorldIndex)
	{
		// ֻ���л�����
		return SetPos(nX, nY);
	}

	int nRegion, nMapX, nMapY, nOffX, nOffY;
	SubWorld[nTargetSubWorld].Mps2Map(nX, nY, &nRegion, &nMapX, &nMapY, &nOffX, &nOffY);
	// �л���������Ƿ???
	if (nRegion < 0)
	{
		g_DebugLog("[Map]Change Pos(%d,%d) Invalid!", nX, nY);
		return 0;
	}
    if (m_SubWorldIndex >= 0)
	{
		//SubWorld[m_SubWorldIndex].m_MissionArray.RemovePlayer(m_nPlayerIdx, Player[CLIENT_PLAYER_INDEX].m_dwID);
        SubWorld[m_SubWorldIndex].m_MissionArray.RemovePlayer(m_nPlayerIdx);//Son fix loi kick ra miss
		}

	if (m_SubWorldIndex >= 0 && m_RegionIndex >= 0) //TamLTM fix dell nh�n vat qua map
	{
		SubWorld[m_SubWorldIndex].m_Region[m_RegionIndex].RemoveNpc(m_Index);
		SubWorld[m_SubWorldIndex].m_Region[m_RegionIndex].DecRef(m_MapX, m_MapY, obj_npc);

		//TamLTM them de remove nhan vat qua map thanh thi
		PHONGTHAN_ENTITY_REFERENCE RemoveSync;
		PhongThanInitializeWireHeader(&RemoveSync.Header, PHONGTHAN_MSG_WORLD_ENTITY_REMOVE,
			sizeof(RemoveSync), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
		RemoveSync.MapId = SubWorld[m_SubWorldIndex].m_SubWorldID;
		RemoveSync.EntityId = m_dwID;
		SendDataToNearRegion(&RemoveSync, sizeof(RemoveSync));
		g_DebugLog("[Map]Change Pos(%d,%d) Hop le!", nX, nY);
		//end code
	}

	int nSourceSubWorld = m_SubWorldIndex;
	int nSourceRegion = m_RegionIndex;

	m_SubWorldIndex = nTargetSubWorld;
	m_RegionIndex = nRegion;
	m_MapX = nMapX;
	m_MapY = nMapY;
	m_MapZ = 0;
	m_OffX = nOffX;
	m_OffY = nOffY;
	SubWorld[nTargetSubWorld].Map2Mps(nRegion, nMapX, nMapY, nOffX, nOffY, &m_OriginX, &m_OriginY);
	SubWorld[nTargetSubWorld].m_Region[nRegion].AddNpc(m_Index);
	SubWorld[nTargetSubWorld].m_Region[nRegion].AddRef(m_MapX, m_MapY, obj_npc);

	DoStand();
	m_ProcessAI = 1;

	if (IsPlayer())
	{
		SubWorld[nTargetSubWorld].SendSyncData(m_Index, Player[m_nPlayerIdx].m_nNetConnectIdx);
		SubWorld[nSourceSubWorld].RemovePlayer(nSourceRegion, m_nPlayerIdx);
		SubWorld[nTargetSubWorld].AddPlayer(nRegion, m_nPlayerIdx);
		// The map header clears the client's region membership. Publish the
		// authoritative entity position and appearance before awaiting movement.
		SendSyncData(Player[m_nPlayerIdx].m_nNetConnectIdx, FALSE);
		// Repopulate static NPCs immediately after the destination map/self.
		// They do not move, so no movement broadcast can recreate them.
		SubWorld[nTargetSubWorld].SyncNpcNearPlayer(m_nPlayerIdx);

		TRADE_DECISION_COMMAND	sTrade;
		sTrade.ProtocolType = c2s_tradedecision;
		sTrade.m_btDecision = 0;
		sTrade.m_btFolkGame = 0;
		Player[m_nPlayerIdx].TradeDecision((BYTE*)&sTrade);
	}
	return 1;
}
#endif

#ifdef _SERVER
void KNpc::TobeExchangeServer(DWORD dwMapID, int nX, int nY)
{
	if (!IsPlayer())
	{
		return;
	}

	m_OldFightMode = m_FightMode;
	m_bExchangeServer = TRUE;
	if (m_nPlayerIdx > 0 && m_nPlayerIdx <= MAX_PLAYER)
	{
		Player[m_nPlayerIdx].TobeExchangeServer(dwMapID, nX, nY);
	}
}
#endif

BOOL KNpc::IsPlayer()
{
#ifdef _SERVER
	return m_Kind == kind_player;
#else
	return m_Index == Player[CLIENT_PLAYER_INDEX].m_nIndex;
#endif
}

// ���NPC���ϵķǱ�����ļ���״??
void KNpc::ClearStateSkillEffect()
{
	// KStateNode* pNode;
	// pNode = (KStateNode *)m_StateSkillList.GetHead();
	// while(pNode)
	// {
		// KStateNode* pTempNode = pNode;
		// pNode = (KStateNode *)pNode->GetNext();

		// if (pTempNode->m_bOverLook)	// ��������
			// continue;

		// if (pTempNode->m_LeftTime == -1)	// ��������
			// continue;

		// if (pTempNode->m_LeftTime > 0)
		// {
			// for (int i = 0; i < MAX_SKILL_STATE; i++)
			// {
				// if (pTempNode->m_State[i].nAttribType)
					// ModifyAttrib(m_Index, &pTempNode->m_State[i]);
			// }
			// _ASSERT(pTempNode != NULL);
			// pTempNode->Remove();
			// delete pTempNode;
			// pTempNode = NULL;
			// continue;
		// }
	// }
// #ifdef _SERVER
	// UpdateNpcStateInfo();
// #endif

	KStateNode* pNode;
	pNode = (KStateNode *)m_StateSkillList.GetHead();
	while(pNode)
	{
		KStateNode* pTempNode = pNode;
		pNode = (KStateNode *)pNode->GetNext();

		if (pTempNode->m_LeftTime == -1)
			continue;

		if (pTempNode->m_LeftTime > 0)
		{
			for (int i = 0; i < MAX_SKILL_STATE; i++)
			{
				if (pTempNode->m_State[i].nAttribType)
					ModifyAttrib(m_Index, &pTempNode->m_State[i]);
			}
			_ASSERT(pTempNode != NULL);
			pTempNode->Remove();
			delete pTempNode;

#ifdef _SERVER
			UpdateNpcStateInfo();

#endif
			pTempNode = NULL;
			continue;
		}
	}
}

void KNpc::IgnoreState(BOOL bNegative)
{
	KStateNode* pNode;
	pNode = (KStateNode *)m_StateSkillList.GetHead();
	while(pNode)
	{
		KStateNode* pTempNode = pNode;
		pNode = (KStateNode *)pNode->GetNext();

		if (pTempNode->m_bOverLook)	// ��������
			continue;

		if (pTempNode->m_LeftTime >= 0)
		{
			if(bNegative)
			{
				KSkill * pSkill = (KSkill *) g_SkillManager.GetSkill(pTempNode->m_SkillID, pTempNode->m_Level);
				if (!pSkill->IsTargetOnly() && !pSkill->IsTargetEnemy())
					continue;
			}

			int i;
			for (i = 0; i < MAX_SKILL_STATE; i++)
			{
				if (pTempNode->m_State[i].nAttribType)
				{
					ModifyAttrib(m_Index, &pTempNode->m_State[i]);
				}
			}
			_ASSERT(pTempNode != NULL);
			pTempNode->Remove();
			delete pTempNode;

			pTempNode = NULL;

#ifdef _SERVER
			UpdateNpcStateInfo();
#endif
			continue;
		}
	}
#ifdef _SERVER
	PHONGTHAN_STATE_CLEAR Sync;
	ZeroMemory(&Sync, sizeof(Sync));
	PhongThanInitializeWireHeader(&Sync.Header, PHONGTHAN_MSG_GAMEPLAY_STATE_CLEAR,
		sizeof(Sync), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	Sync.MapId = SubWorld[m_SubWorldIndex].m_SubWorldID;
	Sync.EntityId = m_dwID;
	Sync.Negative = bNegative ? 1 : 0;
	g_pServer->PackDataToClient(Player[m_nPlayerIdx].m_nNetConnectIdx, &Sync, sizeof(Sync));
#endif
}

void KNpc::ClearNormalState()
{
	ZeroMemory(&m_PhysicsArmor, sizeof(m_PhysicsArmor));
	ZeroMemory(&m_ColdArmor, sizeof(m_ColdArmor));
	ZeroMemory(&m_FireArmor, sizeof(m_FireArmor));
	ZeroMemory(&m_PoisonArmor, sizeof(m_PoisonArmor));
	ZeroMemory(&m_LightArmor, sizeof(m_LightArmor));
	ZeroMemory(&m_EarthArmor, sizeof(m_EarthArmor));
	// ZeroMemory(&m_ManaShield, sizeof(m_ManaShield));
	ZeroMemory(&m_PoisonState, sizeof(m_PoisonState));
	ZeroMemory(&m_FreezeState, sizeof(m_FreezeState));
	ZeroMemory(&m_BurnState, sizeof(m_BurnState));
	// ZeroMemory(&m_FrozenAction, sizeof(m_FrozenAction));
	ZeroMemory(&m_RandMove, sizeof(m_RandMove));
	ZeroMemory(&m_StunState, sizeof(m_StunState));
	ZeroMemory(&m_LifeState, sizeof(m_LifeState));
	ZeroMemory(&m_ManaState, sizeof(m_ManaState));
	ZeroMemory(&m_LoseMana, sizeof(m_LoseMana));
	ZeroMemory(&m_HideState, sizeof(m_HideState));
	ZeroMemory(&m_SilentState, sizeof(m_SilentState));
	ZeroMemory(&m_WalkRun, sizeof(m_WalkRun));


}

BOOL KNpc::IsNpcStateExist(int nId)
{
	if (nId <= 0)
		return FALSE;
	KStateNode* pNode;
	pNode = (KStateNode *)m_StateSkillList.GetHead();
	while(pNode)
	{
		if (pNode->m_SkillID == nId)
			return TRUE;

		pNode = (KStateNode *)pNode->GetNext();
	}
	return FALSE;
}

BOOL KNpc::IsNpcSkillExist(int nId)
{
	if (nId <= 0)
		return FALSE;
	for (int i = 1; i < MAX_NPCSKILL; i++)
	{
		if (m_SkillList.m_Skills[i].SkillId)
		{
			if (m_SkillList.m_Skills[i].SkillId == nId)
				return TRUE;
		}
	}
	return FALSE;
}

BOOL KNpc::CheckTrap(int nMapX, int nMapY)
{
	if (m_Kind != kind_player)
		return FALSE;

	if (m_Index <= 0)
		return FALSE;

	if (m_SubWorldIndex < 0 || m_RegionIndex < 0)
		return FALSE;

	DWORD dwTrap = SubWorld[m_SubWorldIndex].m_Region[m_RegionIndex].GetTrap(nMapX, nMapY);

	if (m_TrapScriptID == dwTrap)
		return FALSE;
	else
		m_TrapScriptID = dwTrap;

	if (!m_TrapScriptID)
		return FALSE;
	Player[m_nPlayerIdx].ExecuteScript(m_TrapScriptID, NORMAL_FUNCTION_NAME, 0);
	return TRUE;
}

void KNpc::SetFightMode(BOOL bFightMode)
{
#ifdef _SERVER
	if (this->m_Kind == kind_player)
		Player[this->m_nPlayerIdx].m_cPK.CloseAll();
#endif

	m_FightMode = bFightMode;
}

void KNpc::TurnTo(int nIdx)
{
	if (!Npc[nIdx].m_Index || !m_Index)
		return;

	int nX1, nY1, nX2, nY2;

	GetMpsPos(&nX1, &nY1);
	Npc[nIdx].GetMpsPos(&nX2, &nY2);

	m_Dir = g_GetDirIndex(nX1, nY1, nX2, nY2);
}

void KNpc::ReCalcStateEffect()
{
	KStateNode* pNode;
	pNode = (KStateNode *)m_StateSkillList.GetHead();
	while(pNode)
	{
		if (pNode->m_LeftTime != 0)	// ��������(-1)������(>0)
		{
			int i;
			for (i = 0; i < MAX_SKILL_STATE; i++)
			{
				if (pNode->m_State[i].nAttribType)
				{
					KMagicAttrib	MagicAttrib;
					MagicAttrib.nAttribType = pNode->m_State[i].nAttribType;
					MagicAttrib.nValue[0] = -pNode->m_State[i].nValue[0];
					MagicAttrib.nValue[1] = -pNode->m_State[i].nValue[1];
					MagicAttrib.nValue[2] = -pNode->m_State[i].nValue[2];
					ModifyAttrib(m_Index, &MagicAttrib);
				}
			}
		}
		pNode = (KStateNode *)pNode->GetNext();
	}
}

#ifndef _SERVER
extern KTabFile g_ClientWeaponSkillTabFile;
#endif

int		KNpc::GetCurActiveWeaponSkill()
{
	int nSkillId = 0;
	if (IsPlayer())
	{

		int nDetailType = Player[m_nPlayerIdx].m_ItemList.GetWeaponType();
		int nParticularType = Player[m_nPlayerIdx].m_ItemList.GetWeaponParticular();

		//��������
		if (nDetailType == 0)
		{
			nSkillId = g_nMeleeWeaponSkill[nParticularType];
		}//Զ������
		else if (nDetailType == 1)
		{
			nSkillId = g_nRangeWeaponSkill[nParticularType];
		}//����
		else if (nDetailType == -1)
		{
			nSkillId = g_nHandSkill;
		}
	}
	else
	{
#ifdef _SERVER
		//Real Npc
		return 0;
#else
		if (m_Kind == kind_player) // No Local Player
		{
			g_ClientWeaponSkillTabFile.GetInteger(m_Appearance.Weapon.nResourceId + 1, "SkillId", 0, &nSkillId);
		}
		else						//Real Npc
		{
			return 0;//
		}
#endif
	}
	return nSkillId;
}

#ifndef _SERVER
void KNpc::ProcNetCommand(NPCCMD cmd, int x /* = 0 */, int y /* = 0 */, int z /* = 0 */)
{
	switch (cmd)
	{
	case do_death:
		DoDeath();
		break;
	case do_hurt:
		DoHurt(x, y, z);
		break;
	case do_revive:
		DoStand();
		m_ProcessAI = 1;
		m_ProcessState = 1;
		SetInstantSpr(enumINSTANT_STATE_REVIVE);
		break;
	case do_stand:
		DoStand();
		m_ProcessAI = 1;
		m_ProcessState = 1;
	default:
		break;
	}
}
#endif

//Fix move lag pos xy
#ifndef _SERVER
//HurtAutoMove()
//AutoFixXY()
void	KNpc::AutoFixXY()
{
	if (Player[CLIENT_PLAYER_INDEX].m_nIndex != m_Index)
	{
		if ((m_sSyncPos.m_nDoing == do_stand
			|| m_sSyncPos.m_nDoing == do_magic
			|| m_sSyncPos.m_nDoing == do_attack
			|| m_sSyncPos.m_nDoing == do_runattack
			|| m_sSyncPos.m_nDoing == do_manyattack
			|| m_sSyncPos.m_nDoing == do_jumpattack
			|| m_sSyncPos.m_nDoing == do_goattack
			)
			&& (m_Doing == do_run || m_Doing == do_walk))
		{
			int	nRegionIdx;

			if ((DWORD)SubWorld[0].m_Region[m_RegionIndex].m_RegionID == m_sSyncPos.m_dwRegionID)
			{
				SubWorld[0].m_Region[m_RegionIndex].DecRef(m_MapX, m_MapY, obj_npc);
				m_MapX = m_sSyncPos.m_nMapX;
				m_MapY = m_sSyncPos.m_nMapY;
				m_OffX = m_sSyncPos.m_nOffX;
				m_OffY = m_sSyncPos.m_nOffY;
				memset(&m_sSyncPos, 0, sizeof(m_sSyncPos));
				SubWorld[0].m_Region[m_RegionIndex].AddRef(m_MapX, m_MapY, obj_npc);
			}
			else
			{
				nRegionIdx = SubWorld[0].FindRegion(m_sSyncPos.m_dwRegionID);
				if (nRegionIdx < 0)
					return;
				SubWorld[0].m_Region[m_RegionIndex].DecRef(m_MapX, m_MapY, obj_npc);
				SubWorld[0].NpcChangeRegion(SubWorld[0].m_Region[m_RegionIndex].m_RegionID, SubWorld[0].m_Region[nRegionIdx].m_RegionID, m_Index);
				m_RegionIndex = nRegionIdx;
				m_dwRegionID = m_sSyncPos.m_dwRegionID;
				m_MapX = m_sSyncPos.m_nMapX;
				m_MapY = m_sSyncPos.m_nMapY;
				m_OffX = m_sSyncPos.m_nOffX;
				m_OffY = m_sSyncPos.m_nOffY;
				memset(&m_sSyncPos, 0, sizeof(m_sSyncPos));
			}
		}

	}
	else if (m_Doing == do_sit)
	{
		int	nRegionIdx;

		if ((DWORD)SubWorld[0].m_Region[m_RegionIndex].m_RegionID == m_sSyncPos.m_dwRegionID)
		{
			SubWorld[0].m_Region[m_RegionIndex].DecRef(m_MapX, m_MapY, obj_npc);
			m_MapX = m_sSyncPos.m_nMapX;
			m_MapY = m_sSyncPos.m_nMapY;
			m_OffX = m_sSyncPos.m_nOffX;
			m_OffY = m_sSyncPos.m_nOffY;
			memset(&m_sSyncPos, 0, sizeof(m_sSyncPos));
			SubWorld[0].m_Region[m_RegionIndex].AddRef(m_MapX, m_MapY, obj_npc);
		}
		else
		{
			nRegionIdx = SubWorld[0].FindRegion(m_sSyncPos.m_dwRegionID);
			if (nRegionIdx < 0)
				return;
			SubWorld[0].m_Region[m_RegionIndex].DecRef(m_MapX, m_MapY, obj_npc);
			SubWorld[0].NpcChangeRegion(SubWorld[0].m_Region[m_RegionIndex].m_RegionID, SubWorld[0].m_Region[nRegionIdx].m_RegionID, m_Index);
			m_RegionIndex = nRegionIdx;
			m_dwRegionID = m_sSyncPos.m_dwRegionID;
			m_MapX = m_sSyncPos.m_nMapX;
			m_MapY = m_sSyncPos.m_nMapY;
			m_OffX = m_sSyncPos.m_nOffX;
			m_OffY = m_sSyncPos.m_nOffY;
			memset(&m_sSyncPos, 0, sizeof(m_sSyncPos));
		}
	}
}

void	KNpc::HurtAutoMove()
{
	if (this->m_Doing != do_hurt)
		return;

	if (m_sSyncPos.m_nDoing != do_hurt && m_sSyncPos.m_nDoing != do_stand)
		return;

	int	nFrames, nRegionIdx;

	nFrames = m_Frames.nTotalFrame - m_Frames.nCurrentFrame;
	if (nFrames <= 1)
	{
		if ((DWORD)SubWorld[0].m_Region[m_RegionIndex].m_RegionID == m_sSyncPos.m_dwRegionID)
		{
			SubWorld[0].m_Region[m_RegionIndex].DecRef(m_MapX, m_MapY, obj_npc);
			m_MapX = m_sSyncPos.m_nMapX;
			m_MapY = m_sSyncPos.m_nMapY;
			m_OffX = m_sSyncPos.m_nOffX;
			m_OffY = m_sSyncPos.m_nOffY;
			memset(&m_sSyncPos, 0, sizeof(m_sSyncPos));
			SubWorld[0].m_Region[m_RegionIndex].AddRef(m_MapX, m_MapY, obj_npc);
		}
		else
		{
			nRegionIdx = SubWorld[0].FindRegion(m_sSyncPos.m_dwRegionID);
			if (nRegionIdx < 0)
				return;
			SubWorld[0].m_Region[m_RegionIndex].DecRef(m_MapX, m_MapY, obj_npc);
			SubWorld[0].NpcChangeRegion(SubWorld[0].m_Region[m_RegionIndex].m_RegionID, SubWorld[0].m_Region[nRegionIdx].m_RegionID, m_Index);
			m_RegionIndex = nRegionIdx;
			m_dwRegionID = m_sSyncPos.m_dwRegionID;
			m_MapX = m_sSyncPos.m_nMapX;
			m_MapY = m_sSyncPos.m_nMapY;
			m_OffX = m_sSyncPos.m_nOffX;
			m_OffY = m_sSyncPos.m_nOffY;
			memset(&m_sSyncPos, 0, sizeof(m_sSyncPos));
		}
	}
	else
	{
		nRegionIdx = SubWorld[0].FindRegion(m_sSyncPos.m_dwRegionID);
		if (nRegionIdx < 0)
			return;
		int		nNpcX, nNpcY, nSyncX, nSyncY;
		int		nNewX, nNewY, nMapX, nMapY, nOffX, nOffY;
		SubWorld[0].Map2Mps(m_RegionIndex,
			m_MapX, m_MapY,
			m_OffX, m_OffY,
			&nNpcX, &nNpcY);
		SubWorld[0].Map2Mps(nRegionIdx,
			m_sSyncPos.m_nMapX, m_sSyncPos.m_nMapY,
			m_sSyncPos.m_nOffX, m_sSyncPos.m_nOffY,
			&nSyncX, &nSyncY);
		nNewX = nNpcX + (nSyncX - nNpcX) / nFrames;
		nNewY = nNpcY + (nSyncY - nNpcY) / nFrames;
		SubWorld[0].Mps2Map(nNewX, nNewY, &nRegionIdx, &nMapX, &nMapY, &nOffX, &nOffY);
		_ASSERT(nRegionIdx >= 0);
		if (nRegionIdx < 0)
			return;
		if (nRegionIdx != m_RegionIndex)
		{
			SubWorld[0].m_Region[m_RegionIndex].DecRef(m_MapX, m_MapY, obj_npc);
			SubWorld[0].NpcChangeRegion(SubWorld[0].m_Region[m_RegionIndex].m_RegionID, SubWorld[0].m_Region[nRegionIdx].m_RegionID, m_Index);
			m_RegionIndex = nRegionIdx;
			m_dwRegionID = m_sSyncPos.m_dwRegionID;
			m_MapX = nMapX;
			m_MapY = nMapY;
			m_OffX = nOffX;
			m_OffY = nOffY;
		}
		else
		{
			SubWorld[0].m_Region[m_RegionIndex].DecRef(m_MapX, m_MapY, obj_npc);
			m_MapX = nMapX;
			m_MapY = nMapY;
			m_OffX = nOffX;
			m_OffY = nOffY;
			SubWorld[0].m_Region[m_RegionIndex].AddRef(m_MapX, m_MapY, obj_npc);
		}
	}
}

#endif
//End code

//TamLTM AutoMoveBarrier(int x, int y)
//void KNpc::CheckMoveBarrier(BOOL Obstacle_LT /*12h*/, BOOL Obstacle_RT /*6h*/, BOOL Obstacle_LB /*9h*/, BOOL Obstacle_RB /*3h*/)
int m_nIndexPlayerRun = 1;
int timerCountCheckAutoBarrier = 1;

/*void KNpc::CheckTimerMoveBarrier()
{
	// Chay lien tuc
}

void KNpc::CheckMoveBarrier()
{
#ifndef _SERVER

#endif
}

void	KNpc::ActiveAutoMoveBarrier(int moveX, int moveY)
{
#ifndef _SERVER

#endif
}*/

//Code chay
int isCheckAuto = false;
int countSlowFrameAutoMove = 1;
int checkPosIndexMove = 0;

void KNpc::DoAutoMoveBarrier(int arrowMove)
{
	//	g_DebugLog("arrowMove %d ", arrowMove);
#ifdef _SERVER
//	int nX, nY;
//	GetMpsPos(&nX, &nY);
//	SetPosU(nX, nY);
#endif // _SERVER

#ifndef _SERVER

//	g_DebugLog("va cham DoAutoMoveBarrier");

	if (m_Doing == do_skill || m_Doing == do_magic ||
		m_Doing == do_attack || m_Doing == do_goattack)
	{
		arrowMove = 0;
		return;
	}

	if (m_Doing == do_stand || m_Doing == do_sit ||
		m_Doing == do_death || m_Doing == do_jump)
	{
		//g_DebugLog("CheckMoveBarrier TamLTM stop hanh dong player");
		int nX, nY;
		GetMpsPos(&nX, &nY);
	//	MoveToBarrierPlayer(nX, nY, 0);
		arrowMove = 0;
		return;
	}

	m_nCheckAutoMoveBarrier = 1;

	if (GetCheckAutoMoveBarr(isCheckAuto) == false)
		return;

	int rands; //Random khi va cham va move huong khac

	//1 left //2 right //3 bottom //4 top
	if (Player[CLIENT_PLAYER_INDEX].m_nSendMoveFrames >= defMAX_PLAYER_SEND_MOVE_FRAME)
	{
		// Huong 1 Move Left top
		if (arrowMove == 1)
		{
			int nX, nY;
			GetMpsPos(&nX, &nY);

			int nDir = g_GetDirIndex(nX, nY, m_DesX, m_DesY);

			rands = rand() % 4 + 1;
		//	DoRun();
		//	DoStand(); // Xem lai cho nay

			//Chay qua trai va xuong duoi, duong ngan hon va cham  == 4
			if (m_Doing == do_walk)
			{
				MoveToBarrierPlayer(nX + 100 * 2, nY - 540 * 2, 1);
				checkPosIndexMove = 1;
				Player[CLIENT_PLAYER_INDEX].m_nSendMoveFrames = 0;
				return;
			}
			else
			{
				if (rands == 2)
				{
					if (nDir >= 25 && nDir <= 30)
					{
						MoveToBarrierPlayer(nX - 100, nY - 540, 0);
						checkPosIndexMove = 1;
						Player[CLIENT_PLAYER_INDEX].m_nSendMoveFrames = 0;
						return;
					}
					else if (nDir >= 32 && nDir <= 42)
					{
						MoveToBarrierPlayer(nX + 400, nY - 540, 0);
						checkPosIndexMove = 1;
						Player[CLIENT_PLAYER_INDEX].m_nSendMoveFrames = 0;
						return;
					}
					else
					{
						MoveToBarrierPlayer(nX - 100, nY + 540, 0);
						checkPosIndexMove = 1;
						Player[CLIENT_PLAYER_INDEX].m_nSendMoveFrames = 0;
						return;
					}

					return;
				}
				else
				{
					if (nDir >= 0 && nDir <= 15)
					{
						MoveToBarrierPlayer(nX - 100, nY + 540, 0);
						checkPosIndexMove = 1;
						Player[CLIENT_PLAYER_INDEX].m_nSendMoveFrames = 0;
						return;
					}
					else if (nDir >= 15 && nDir <= 25)
					{
						MoveToBarrierPlayer(nX - 100, nY + 540, 0);
						checkPosIndexMove = 1;
						Player[CLIENT_PLAYER_INDEX].m_nSendMoveFrames = 0;
						return;
					}
					else
					{
						MoveToBarrierPlayer(nX + 100, nY - 540, 0);
						checkPosIndexMove = 1;
						Player[CLIENT_PLAYER_INDEX].m_nSendMoveFrames = 0;
						return;
					}

					return;
				}
			}
		}

		// Huong 2  rand() % 100
		if (arrowMove == 2)
		{
			int nX, nY;
			GetMpsPos(&nX, &nY);

			int nDir = g_GetDirIndex(nX, nY, m_DesX, m_DesY);

			rands = rand() % 4 + 1;

			//Chay qua trai va xuong duoi, duong ngan hon va cham  == 2
			if (m_Doing == do_walk)
			{
				MoveToBarrierPlayer(nX - 50 * 2, nY + 540 * 2, 1);
				checkPosIndexMove = 2;
				Player[CLIENT_PLAYER_INDEX].m_nSendMoveFrames = 0;
				return;
			}
			else
			{
				if (rands == 2)
				{
					if (nDir >= 25 && nDir <= 35)
					{
						MoveToBarrierPlayer(nX + 480, nY - 640, 0);
						checkPosIndexMove = 2;
						Player[CLIENT_PLAYER_INDEX].m_nSendMoveFrames = 0;
						return;
					}
					else if (nDir >= 35 && nDir <= 40)
					{
						MoveToBarrierPlayer(nX - 480, nY - 640, 0);
						checkPosIndexMove = 2;
						Player[CLIENT_PLAYER_INDEX].m_nSendMoveFrames = 0;
						return;
					}
					else
					{
						MoveToBarrierPlayer(nX + 480, nY + 640, 0);
						checkPosIndexMove = 2;
						Player[CLIENT_PLAYER_INDEX].m_nSendMoveFrames = 0;
						return;
					}

					return;
				}
				else
				{
					if (nDir >= 63 && nDir <= 55)
					{
						MoveToBarrierPlayer(nX - 400, nY + 640, 0);
						checkPosIndexMove = 2;
						Player[CLIENT_PLAYER_INDEX].m_nSendMoveFrames = 0;
						return;
					}
					else if (nDir >= 63 && nDir <= 55)
					{
						MoveToBarrierPlayer(nX + 400, nY - 640, 0);
						checkPosIndexMove = 2;
						Player[CLIENT_PLAYER_INDEX].m_nSendMoveFrames = 0;
						return;
					}
					else
					{
						MoveToBarrierPlayer(nX + 400, nY + 640, 0);
						checkPosIndexMove = 2;
						Player[CLIENT_PLAYER_INDEX].m_nSendMoveFrames = 0;
						return;
					}

					return;
				}
			}
		}

		// Huong 3
		if (arrowMove == 3)
		{
			int nX, nY;
			GetMpsPos(&nX, &nY);

			rands = rand() % 4 + 1;

			// Chay len tren va cham == 3
			if (m_Doing == do_walk)
			{
				MoveToBarrierPlayer(nX - 400 * 2, nY - 440 * 2, 1);
				checkPosIndexMove = 3;
				Player[CLIENT_PLAYER_INDEX].m_nSendMoveFrames = 0;
				return;
			}
			else
			{
				if (rands == 3)
				{
					MoveToBarrierPlayer(nX + 420, nY + 680, 0);
					checkPosIndexMove = 3;
					Player[CLIENT_PLAYER_INDEX].m_nSendMoveFrames = 0;
					return;
				}
				else
				{
					MoveToBarrierPlayer(nX - 420, nY - 680, 0);
					checkPosIndexMove = 3;
					Player[CLIENT_PLAYER_INDEX].m_nSendMoveFrames = 0;
					return;
				}
			}
		}

		// Huong 4
		if (arrowMove == 4)
		{
			int nX, nY;
			GetMpsPos(&nX, &nY);

			rands = rand() % 4 + 1;

			//Chay qua trai va xuong duoi, duong ngan hon va cham  == 4
			if (m_Doing == do_walk)
			{
				MoveToBarrierPlayer(nX + 410 * 2, nY + 540 * 2, 1);
				checkPosIndexMove = 4;
				Player[CLIENT_PLAYER_INDEX].m_nSendMoveFrames = 0;
				return;
			}
			else
			{
				if (rands == 4)
				{
					MoveToBarrierPlayer(nX - 450, nY + 650, 0);
					checkPosIndexMove = 4;
					Player[CLIENT_PLAYER_INDEX].m_nSendMoveFrames = 0;
					return;
				}
				else
				{
					MoveToBarrierPlayer(nX + 480, nY + 680, 0);
					checkPosIndexMove = 4;
					Player[CLIENT_PLAYER_INDEX].m_nSendMoveFrames = 0;
					return;
				}
			}
		}
	}

	arrowMove = 0;
#endif

}

#ifndef _SERVER
void KNpc::MiniMapXY(int nX, int nY)
{
	m_nMoveToFlagMiniMapX = nX;
	m_nMoveToFlagMiniMapY = nY;

//	g_DebugLog("%d + %d dfas", m_nMoveToFlagMiniMapX, m_nMoveToFlagMiniMapY);
}

void KNpc::MoveToBarrierPlayer(int nX, int nY, int isCheckMoveCalculator)
{
	if (m_Doing == do_skill || m_Doing == do_magic ||
		m_Doing == do_attack || m_Doing == do_goattack)
	{
		return;
	}

	// Di bo
	if (isCheckMoveCalculator == 1)
	{
		Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].SendCommand(do_walk, nX, nY);
		SendClientCmdWalk(nX, nY);
	}
	else // Chay
	{
		Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].SendCommand(do_run, nX, nY);
		SendClientCmdRun(nX, nY);
	}
}

BOOL KNpc::GetCheckAutoMoveBarr(BOOL isCheck)
{
	isCheckAuto = isCheck;
	return isCheckAuto;
}
#endif

//end code chay

#ifndef _SERVER
void	KNpc::AddBlood(int nNo)
{
	if (nNo > 0)
	{
		m_nBlood[m_btCurBlood] = BLOOD_EVENTTIME;
		itoa(nNo, m_szBlood[m_btCurBlood], 10);

		m_btCurBlood++;
		if (m_btCurBlood >= BLOOD_COUNT)
			m_btCurBlood = 0;
	}
}

int	KNpc::PaintBlood(int nHeightOffset)
{
	int i = 0;
	while(i < BLOOD_COUNT)
	{
		if (m_szBlood[i][0]==0)
		{
			i++;
			continue;
		}

		int	nMpsX, nMpsY;
		GetMpsPos(&nMpsX, &nMpsY);

		g_pRepresent->OutputText(BLOOD_FONTSIZE, m_szBlood[i], KRF_ZERO_END, nMpsX - BLOOD_FONTSIZE * g_StrLen(m_szBlood[i]) / 4, nMpsY,
			0x00ff0000, 0, nHeightOffset + (BLOOD_EVENTTIME - m_nBlood[i]) * BLOOD_MOVESPEED / 5, 0xff000000);

		m_nBlood[i]--;
		if (m_nBlood[i] <= 0)
		{
			m_szBlood[i][0]=0;
			break;
		}
		i++;
	}
	return nHeightOffset;
}

#endif

#ifndef _SERVER
int	KNpc::GetNpcPate()
{
	int nHeight = m_Height + m_nStature;
	if (m_Kind == kind_player)
	{
		if (m_nSex)
			nHeight += 114;	//Ů
		else
			nHeight += 114;	//��

		if (m_MaskType <= 0)
		{
			if (m_DataRes.IgnoreShowRes()==FALSE && m_Doing == do_sit && MulDiv(10, m_Frames.nCurrentFrame, m_Frames.nTotalFrame) >= 8)
				nHeight -= MulDiv(30, m_Frames.nCurrentFrame, m_Frames.nTotalFrame);

			if (m_bRideHorse)
				nHeight += 38;	//����
		}
		else
		{
			nHeight += 16;
		}
	}

	return nHeight;
}
#endif

#ifndef _SERVER
int	KNpc::GetNpcPatePeopleInfo()
{
	int nFontSize = 12;
	if (m_nChatContentLen > 0 && m_nChatNumLine > 0)
		return m_nChatNumLine * (nFontSize + 1);

	int nHeight = 0;
	if (NpcSet.CheckShowLife())
	{
		if (m_Kind == kind_player || m_Kind == kind_partner)
		{
			if (m_CurrentLifeMax > 0 && (relation_enemy == NpcSet.GetRelation(m_Index, Player[CLIENT_PLAYER_INDEX].m_nIndex)) &&
				Npc[m_Index].m_nPKFlag != enumPKMurder
				)
				nHeight += SHOW_LIFE_HEIGHT;
		}
	}
	if (NpcSet.CheckShowName())
	{
		if (nHeight != 0)
			nHeight += SHOW_SPACE_HEIGHT;//�ÿ�

		if (m_Kind == kind_player || m_Kind == kind_dialoger)
			nHeight += nFontSize + 1;
	}
	return nHeight;
}
#endif


void KNpc::SwitchRideHorse(BOOL bRideHorse)
{
	int nIdx = Player[m_nPlayerIdx].m_ItemList.GetEquipment(itempart_horse);
	if(nIdx <= 0)
		return;
	if (bRideHorse && m_Doing == do_sit)
		DoStand();

	m_bRideHorse = bRideHorse;

	if(m_bRideHorse)
		Item[nIdx].ApplyMagicAttribToNPC(&Npc[m_Index], MAX_ITEM_MAGICATTRIB / 2);
	else
		Item[nIdx].RemoveMagicAttribFromNPC(&Npc[m_Index], MAX_ITEM_MAGICATTRIB / 2);

#ifdef _SERVER

	PHONGTHAN_MOUNT_EVENT	NetCommand;
	ZeroMemory(&NetCommand, sizeof(NetCommand));
	PhongThanInitializeWireHeader(&NetCommand.Header, PHONGTHAN_MSG_WORLD_MOUNT, sizeof(NetCommand), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	NetCommand.MapId = SubWorld[m_SubWorldIndex].m_SubWorldID;
	NetCommand.EntityId = m_dwID;
	NetCommand.Mounted = bRideHorse ? 1 : 0;

	//g_DebugLog("s2c_npchorsesync %d", s2c_npchorsesync); //TamLTM Debug error packet

	if (m_RegionIndex < 0)
		return;
	int nMaxCount = MAX_BROADCAST_COUNT;
	POINT	POff[8] =
	{
		{0, 32},
		{-16, 32},
		{-16, 0},
		{-16, -32},
		{0, -32},
		{16, -32},
		{16, 0},
		{16, 32},
	};
	CURREGION.BroadCast(&NetCommand, sizeof(NetCommand), nMaxCount, m_MapX, m_MapY);
	int i;
	for (i = 0; i < 8; i++)
	{
		if (CONREGIONIDX(i) == -1)
			continue;
		CONREGION(i).BroadCast(&NetCommand, sizeof(NetCommand), nMaxCount, m_MapX - POff[i].x, m_MapY - POff[i].y);
	}
#endif
}

#ifdef _SERVER
#define		MAX_SWITCH_HORSE_FIGHT_ACTIVE		90
#define		MAX_SWITCH_HORSE_FIGHT_NONE			36
BOOL KNpc::CanSwitchRideHorse()
{
	if (Player[m_nPlayerIdx].CheckTrading())
		return FALSE;

	if (Player[m_nPlayerIdx].m_ItemList.GetEquipment(itempart_horse) <= 0)
		return FALSE;

	if (Npc[Player[m_nPlayerIdx].m_nIndex].m_Doing == do_sit)
	{
		SHOW_MSG_SYNC	sMsg;
		sMsg.ProtocolType = s2c_msgshow;
		sMsg.m_wMsgID = enumMSG_ID_HORSE_CANT_SWITCH2;
		sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
		g_pServer->PackDataToClient(Player[m_nPlayerIdx].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
		return FALSE;
	}
	if (m_dwNextSwitchHorseTime <= 0 ||
		(g_SubWorldSet.GetGameTime() >= m_dwNextSwitchHorseTime))
	{
		m_dwNextSwitchHorseTime = g_SubWorldSet.GetGameTime() + (m_FightMode ? MAX_SWITCH_HORSE_FIGHT_ACTIVE : MAX_SWITCH_HORSE_FIGHT_NONE);
		return TRUE;
	}
	else
	{
		SHOW_MSG_SYNC	sMsg;
		sMsg.ProtocolType = s2c_msgshow;
		sMsg.m_wMsgID = enumMSG_ID_HORSE_CANT_SWITCH1;
		sMsg.m_wLength = sizeof(SHOW_MSG_SYNC) - 1 - sizeof(LPVOID);
		g_pServer->PackDataToClient(Player[m_nPlayerIdx].m_nNetConnectIdx, &sMsg, sMsg.m_wLength + 1);
		return FALSE;
	}
	return FALSE;
}
#endif

void	KNpc::ResetNpcTypeName(int nMark)
{

#ifndef _SERVER
	char	szNpcTypeName[32];
	szNpcTypeName[0] = 0;
#endif
	if (nMark == 1)
	{
#ifndef _SERVER
		if (m_NpcSettingIdx == PLAYER_MALE_NPCTEMPLATEID)
		{
			GetPhongThanPlayerResTypeName(m_NpcSettingIdx, m_Series, szNpcTypeName);
			m_StandFrame = NpcSet.GetPlayerStandFrame(TRUE);
			m_WalkFrame = NpcSet.GetPlayerWalkFrame(TRUE);
			m_RunFrame = NpcSet.GetPlayerRunFrame(TRUE);
		}
		else
		{
			GetPhongThanPlayerResTypeName(m_NpcSettingIdx, m_Series, szNpcTypeName);
			m_StandFrame = NpcSet.GetPlayerStandFrame(FALSE);
			m_WalkFrame = NpcSet.GetPlayerWalkFrame(FALSE);
			m_RunFrame = NpcSet.GetPlayerRunFrame(FALSE);
		}
#endif
		m_WalkSpeed = NpcSet.GetPlayerWalkSpeed();
		m_RunSpeed = NpcSet.GetPlayerRunSpeed();
		m_AttackFrame = NpcSet.GetPlayerAttackFrame();
		m_HurtFrame	= NpcSet.GetPlayerHurtFrame();
	}
	else
	{
		GetNpcCopyFromTemplate(m_MaskType);
#ifndef _SERVER
		g_NpcSetting.GetString(m_MaskType + 2, "NpcResType", "", szNpcTypeName, sizeof(szNpcTypeName));
		if (!szNpcTypeName[0])
		{
			g_NpcKindFile.GetString(2, "CharacterName", "", szNpcTypeName, sizeof(szNpcTypeName));//���û�ҵ����õ�һ��npc����
		}
#endif
	}
#ifndef _SERVER
	this->RemoveRes();
	m_DataRes._Init(szNpcTypeName, &g_NpcResList);

	BOOL bRenderRideHorse = m_bRideHorse && m_ClientDoing != cdo_jump;
	int nRenderDoing = m_ClientDoing;
	if (bRenderRideHorse && nRenderDoing == cdo_sit)
		nRenderDoing = cdo_stand;
	m_DataRes.SetRideHorse(bRenderRideHorse);
	m_DataRes.SetAction(nRenderDoing);
	m_DataRes.SetArmor(m_Appearance.Armor);
	m_DataRes.SetHelm(m_Appearance.Helm);
	m_DataRes.SetPhiPhong(m_Appearance.PhiPhong);
	m_DataRes.SetHorse(m_Appearance.Horse);
	m_DataRes.SetWeapon(m_Appearance.Weapon);
#endif
}

void KNpc::SetRank(int nRank)
{
	m_RankID = nRank;
#ifdef _SERVER
	POINT	POff[8] =
	{
		{0, 32},
		{-16, 32},
		{-16, 0},
		{-16, -32},
		{0, -32},
		{16, -32},
		{16, 0},
		{16, 32},
	};
	PHONGTHAN_TITLE_EVENT	NetCommand;
	ZeroMemory(&NetCommand, sizeof(NetCommand));
	PhongThanInitializeWireHeader(&NetCommand.Header, PHONGTHAN_MSG_WORLD_TITLE, sizeof(NetCommand), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	NetCommand.MapId = SubWorld[m_SubWorldIndex].m_SubWorldID;
	NetCommand.EntityId = m_dwID;
	NetCommand.RankId = m_RankID;
	if (m_RegionIndex < 0)
		return;
	int nMaxCount = MAX_BROADCAST_COUNT;
	CURREGION.BroadCast(&NetCommand, sizeof(NetCommand), nMaxCount, m_MapX, m_MapY);
	int i;
	for (i = 0; i < 8; i++)
	{
		if (CONREGIONIDX(i) == -1)
			continue;
		CONREGION(i).BroadCast(&NetCommand, sizeof(NetCommand), nMaxCount, m_MapX - POff[i].x, m_MapY - POff[i].y);
	}

#endif
}

void KNpc::SetExpandRank(KExpandRank* ExpandRank)
{
	int i = 0; //TamLTM Fix
	KStateNode* pNode;

	// û����ѭ���з��أ�˵�����¼���
	BOOL bAddNewStateGraphics = TRUE;

	int nCurStateGraphics = m_CurExpandRank.nStateGraphics;

	m_CurExpandRank = *ExpandRank;
	if (m_CurExpandRank.dwLeftTime > KSG_GetCurSec())
		m_ExpandRank = *ExpandRank;

	pNode = (KStateNode *)m_StateSkillList.GetHead();
	while(pNode)
	{
		if (pNode->m_bTempStateGraphics &&
			(pNode->m_StateGraphics == nCurStateGraphics))
		{
			bAddNewStateGraphics = FALSE;
			pNode->m_StateGraphics = m_CurExpandRank.nStateGraphics;
		}
		pNode = (KStateNode *)pNode->GetNext();
	}

	if (bAddNewStateGraphics)
	{
		pNode = new KStateNode;
		pNode->m_SkillID = 0;
		pNode->m_Level = 0;
		pNode->m_LeftTime = -1;
		pNode->m_bOverLook = TRUE;
		pNode->m_bTempStateGraphics = TRUE;
		pNode->m_StateGraphics = m_CurExpandRank.nStateGraphics;
		m_StateSkillList.AddTail(pNode);
	}

#ifdef _SERVER
	POINT	POff[8] =
	{
		{0, 32},
		{-16, 32},
		{-16, 0},
		{-16, -32},
		{0, -32},
		{16, -32},
		{16, 0},
		{16, 32},
	};
	PHONGTHAN_TITLE_EVENT	NetCommand;
	ZeroMemory(&NetCommand, sizeof(NetCommand));
	PhongThanInitializeWireHeader(&NetCommand.Header, PHONGTHAN_MSG_WORLD_TITLE, sizeof(NetCommand), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	NetCommand.MapId = SubWorld[m_SubWorldIndex].m_SubWorldID;
	NetCommand.EntityId = m_dwID;
	NetCommand.Expanded = 1;
	g_StrCpyLen(NetCommand.Name, m_CurExpandRank.szName, sizeof(NetCommand.Name));
	NetCommand.Color = m_CurExpandRank.dwColor;
	NetCommand.Graphic = m_CurExpandRank.nStateGraphics;
	NetCommand.RemainingTime = m_CurExpandRank.dwLeftTime;
	if (m_RegionIndex < 0)
		return;

	int nMaxCount = MAX_BROADCAST_COUNT;
	CURREGION.BroadCast(&NetCommand, sizeof(NetCommand), nMaxCount, m_MapX, m_MapY);

	for (i = 0; i < 8; i++)
	{
		if (CONREGIONIDX(i) == -1)
			continue;
		CONREGION(i).BroadCast(&NetCommand, sizeof(NetCommand), nMaxCount, m_MapX - POff[i].x, m_MapY - POff[i].y);
	}
#endif

#ifdef _SERVER
	UpdateNpcStateInfo();

#endif
}
