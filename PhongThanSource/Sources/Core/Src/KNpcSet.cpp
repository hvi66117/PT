#include "KCore.h"
#include "PhongThanWorldProtocol.h"
#include <math.h>
#include "KNpc.h"
#include "KSubWorld.h"
#include "KRegion.h"
#include "GameDataDef.h"
#include "KNpcSet.h"
#include "KPlayer.h"
#ifndef _SERVER
#include "CoreShell.h"
#include "Scene\KScenePlaceC.h"
#include "../../Represent/iRepresent/iRepresentshell.h"
#include "KOption.h"
#ifndef TOOLVERSION
#include "../../Headers/IClient.h"
#endif
#endif
#include "Scene/SceneDataDef.h"
#include "KMath.h"
#include "PhongThanXichTungTu.h"

extern int GetRandomNumber(int nMin, int nMax);
//#define	ENCHANT_SETTING_PATH	"settings\\npc"
//#define	ENCHANT_NORMAL_FILE		"normalunique.txt"
//#define	ENCHANT_SPECIAL_FILE	"speicalunique.txt"

KNpcSet	NpcSet;

KNpcSet::KNpcSet()
{
	m_dwIDCreator = 1000;
}

// �ƽ�����趨�ļ��ĳ�ʼ��û�з������ֱ�ӷ��� core �ĳ�ʼ������
void KNpcSet::Init()
{
    // Add by Freeway Chen in 2003.6.29
    GenRelationTable();
	m_FreeIdx.Init(MAX_NPC);
	m_UseIdx.Init(MAX_NPC);
	m_FreeIdxHigh.Init(MAX_NPC);	// engine2:A4 high index zone
	m_dwPtHighZoneLoop = 0;

	// ��ʼʱ���е�����Ԫ�ض�Ϊ��
	for (int i = MAX_NPC - 1; i > 0; i--)
	{
		PtFreeInsert(i);	// engine2:A4i
		Npc[i].m_Node.m_nIndex = i;
#ifdef _SERVER
		Npc[i].m_cDeathCalcExp.Init(i);
#endif
	}

	LoadPlayerBaseValue(PLAYER_BASE_VALUE);

#ifdef _SERVER
	KIniFile	cPKIni;
//	g_SetFilePath("\\");
	if (cPKIni.Load(PLAYER_PK_SET_FILE))
	{
		cPKIni.GetInteger("PK", "Rate", 20, &m_nPKDamageRate);
		cPKIni.GetInteger("PK", "LevelRate", 0, &m_nLevelPKDamageRate);
		cPKIni.GetInteger("PK", "SpecialRate", 50, &m_nNpcSpecialDamageRate);
		cPKIni.GetInteger("PK", "CampKill", 1, &m_nCampKillAddPKValue);
		cPKIni.GetInteger("PK", "FreeCampKill", 1, &m_nFreeCampKillAddPKValue);
		cPKIni.GetInteger("PK", "EnmityPK", 2, &m_nEnmityAddPKValue);
		cPKIni.GetInteger("PK", "BeKilled", -1, &m_nBeKilledAddPKValue);
		cPKIni.GetInteger("PK", "LevelDistance", 25, &m_nLevelDistance);
		cPKIni.GetInteger("PK", "LevelBoundaryPKPunish", 130, &m_nLevelBoundaryPKPunish);
		cPKIni.GetInteger("PK", "ButcherPKExercise", 10, &m_nButcherPKExercise);
		cPKIni.GetInteger("PK", "NotSubPKExpPercent", -20, &m_nNotSubPKExpPercent);
		cPKIni.GetInteger("PK", "NotEnmityExpPercent", -30, &m_nNotEnmityExpPercent);
		cPKIni.GetInteger("PK", "NotFightExpPercent", -80, &m_nNotFightExpPercent);
		cPKIni.GetInteger("PK", "MurderPK", 1, &m_nMurderAddPKValue);
		cPKIni.GetInteger("PK", "PKWarOpen", 1, &m_nPKWarOpen);
		cPKIni.GetInteger("PK", "PKMurderOpen", 1, &m_nPKMurderOpen);
		cPKIni.GetInteger("PK", "PKTongOpen", 0, &m_nPKTongOpen);
		cPKIni.GetInteger("PK", "PKTongOpenCamp", 0, &m_nPKTongOpenCamp);
		cPKIni.GetInteger("PK", "NormalPKTimeLong", 180000, &m_nNormalPKTimeLong);
		cPKIni.GetInteger("PK", "FightPKTimeLong", 5000, &m_nFightPKTimeLong);
		cPKIni.GetInteger("PK", "NotFightWhenHightPK", 10, &m_nNotFightWhenHightPK);
		cPKIni.GetInteger("PK", "PKNotSwitchPKWhenLock", 3, &m_nPKNotSwitchPKWhenLock);
		cPKIni.GetInteger("PK", "SparPacific", 0, &m_nSparPacific);
	}
	else
	{
		m_nPKDamageRate = 20;
		m_nNpcSpecialDamageRate = 50;
		m_nCampKillAddPKValue = 1;
		m_nFreeCampKillAddPKValue = 1;
		m_nEnmityAddPKValue = 2;
		m_nBeKilledAddPKValue = -1;
		m_nLevelDistance = 25;
		m_nLevelBoundaryPKPunish = 130;
		m_nButcherPKExercise = 10;
		m_nNotSubPKExpPercent = -20;
		m_nNotEnmityExpPercent = -30;
		m_nNotFightExpPercent = -80;
		m_nMurderAddPKValue = 1;
		m_nPKWarOpen = 1;
		m_nPKMurderOpen = 1;
		m_nPKTongOpen = 0;
		m_nPKTongOpenCamp = 0;
		m_nNormalPKTimeLong = 180000;
		m_nFightPKTimeLong = 5000;
		m_nNotFightWhenHightPK = 10;
		m_nPKNotSwitchPKWhenLock = 3;
		m_nSparPacific = 0;
	}
#endif

#ifndef _SERVER
	m_nShowPateFlag = 0;
	m_nShowPateFlag |= PATE_NAME;
	m_nShowPateFlag |= PATE_LIFE;
	m_nShowPateFlag |= PATE_OBJ;
	ZeroMemory(m_RequestNpc, sizeof(m_RequestNpc));
	m_RequestFreeIdx.Init(MAX_NPC_REQUEST);
	m_RequestUseIdx.Init(MAX_NPC_REQUEST);

	for (i = MAX_NPC_REQUEST - 1; i > 0; i--)
	{
		m_RequestFreeIdx.Insert(i);
	}
#endif

}

void KNpcSet::LoadPlayerBaseValue(LPSTR szFile)
{
	KIniFile	File;

	File.Load(szFile);

	File.GetInteger("Common", "HurtFrame", 12, &m_cPlayerBaseValue.nHurtFrame);
	File.GetInteger("Common", "RunSpeed", 10, &m_cPlayerBaseValue.nRunSpeed);
	File.GetInteger("Common", "WalkSpeed", 5, &m_cPlayerBaseValue.nWalkSpeed);
	File.GetInteger("Common", "AttackFrame", 20, &m_cPlayerBaseValue.nAttackFrame);
#ifndef _SERVER
	File.GetInteger("Male", "WalkFrame", 15, &m_cPlayerBaseValue.nWalkFrame[0]);
	File.GetInteger("Female", "WalkFrame", 15, &m_cPlayerBaseValue.nWalkFrame[1]);
	File.GetInteger("Male", "RunFrame", 15, &m_cPlayerBaseValue.nRunFrame[0]);
	File.GetInteger("Female", "RunFrame", 15, &m_cPlayerBaseValue.nRunFrame[1]);
	File.GetInteger("Male", "StandFrame", 15, &m_cPlayerBaseValue.nStandFrame[0]);
	File.GetInteger("Female", "StandFrame", 15, &m_cPlayerBaseValue.nStandFrame[1]);
#endif
	File.Clear();
}

BOOL KNpcSet::IsNpcExist(int nIdx, DWORD dwId)
{
	if (Npc[nIdx].m_dwID == dwId)
		return TRUE;
	else
		return FALSE;
}

// Add by Freeway Chen in 2003.6.29
NPC_RELATION KNpcSet::GenOneRelation(NPCKIND Kind1, NPCKIND Kind2, NPCCAMP Camp1, NPCCAMP Camp2)
{
	// ·��NPCû��ս����ϵ
	if (Kind1 == kind_dialoger || Kind2 == kind_dialoger)
		return relation_dialog;

	if (Kind1 >= kind_bird || Kind2 >= kind_bird)
		return relation_none;

	// ·����Ӫû��ս����ϵ
	if (Camp1 == camp_event || Camp2 == camp_event)
		return relation_none;

	// ���ֺͶ��ﻹ��ս����ϵ
	if ((Camp1 == camp_begin && Camp2 == camp_animal)
		||(Camp1 == camp_animal && Camp2 == camp_begin))
		return relation_enemy;

	// ֻҪ��һ�����֣��Ͳ�����ս����ϵ(��ͬ�˹�ϵ����Ұ�����)
	if (Camp1 == camp_begin || Camp2 == camp_begin)
		return relation_ally;

    // �����������
	if (Kind1 == kind_player && Kind2 == kind_player)
	{
		// ֻҪ��һ����ҿ���PK����һ������ս����ϵ
		if (Camp1 == camp_free || Camp2 == camp_free)
		{
			return relation_enemy;
		}
	}
	// ͬ��ӪΪ����ϵ
	if (Camp1 == Camp2)
		return relation_ally;

	// �������Ϊս����ϵ
	return relation_enemy;
}



// Add by Freeway Chen in 2003.7.14
int KNpcSet::GenRelationTable()
{
    int nKind1 = 0;
    int nKind2 = 0;
    int nCamp1 = 0;
    int nCamp2 = 0;

    for (nKind1 = 0; nKind1 < kind_num; nKind1++)
    {
        for (nKind2 = 0; nKind2 < kind_num; nKind2++)
        {
            for (nCamp1 = 0; nCamp1 < camp_num; nCamp1++)
            {
                for (nCamp2 = 0; nCamp2 < camp_num; nCamp2++)
                {
					m_RelationTable[nKind1][nKind2][nCamp1][nCamp2] = GenOneRelation(
						(NPCKIND)nKind1,
						(NPCKIND)nKind2,
						(NPCCAMP)nCamp1,
						(NPCCAMP)nCamp2);
                }
            }
        }
    }
    return true;
}




int	KNpcSet::SearchID(DWORD dwID)
{
//	int nMaxNpc = m_BinTree.GetCount();
//	for (int i = 0; i < MAX_NPC; i++)
//	{
//		if (Npc[i].m_dwID == dwID)
//			return Npc[i].m_Index;
//	}
	int nIdx = 0;
	while (1)
	{
		nIdx = m_UseIdx.GetNext(nIdx);
		if (nIdx == 0)
			break;
		if (Npc[nIdx].m_dwID == dwID)
			return nIdx;
	}

	return 0;
}

#ifndef _SERVER
//---------------------------------------------------------------------------
//	���ܣ�����ĳ��ClientID��npc�Ƿ����
//---------------------------------------------------------------------------
int		KNpcSet::SearchClientID(KClientNpcID sClientID)
{
	int nIdx = 0;
	while (1)
	{
		nIdx = m_UseIdx.GetNext(nIdx);
		if (nIdx == 0)
			break;
		if (Npc[nIdx].m_sClientNpcID.m_dwRegionID == sClientID.m_dwRegionID &&
			Npc[nIdx].m_sClientNpcID.m_nNo == sClientID.m_nNo)
			return nIdx;
	}

	return 0;
}
#endif

int KNpcSet::SearchName(LPSTR szName)
{
//	for (int i = 0; i < MAX_NPC; i ++)
//	{
//		if (!strcmp(Npc[i].Name, szName))
//			return i ;
//	}
	int nIdx = 0;
	while (1)
	{
		nIdx = m_UseIdx.GetNext(nIdx);
		if (nIdx == 0)
			break;
		if (g_StrCmp(Npc[nIdx].Name, szName))
			return nIdx;
	}
	return 0;
}

int KNpcSet::SearchUUID(DWORD dwID)
{
	int nIdx = 0;
	DWORD	dwNameID = 0;
	while(1)
	{
		nIdx = m_UseIdx.GetNext(nIdx);
		if (nIdx == 0)
			break;
		if (Npc[nIdx].m_Kind != kind_player)
			continue;
		DWORD dwNameID = 0;
#ifdef _SERVER
		dwNameID = Player[Npc[nIdx].GetPlayerIdx()].m_dwID;
#else
		dwNameID = g_FileName2Id(Npc[nIdx].Name);
#endif
		if (dwID == dwNameID)
			return nIdx;
	}
	return 0;
}

int KNpcSet::FindFree()
{
	return PtFindFree();	// engine2:A4z
}

// engine2:BEGIN A4 2026-10-04 two NPC index zones. MAX_NPC went 48000 -> 96000, but many Lua scripts scan the NPC
// indices 1..47999 (servertimer PTADM_MAX_NPC, bots, vienco, tienma, tienma45, sudo_dongdi, daily3, congthanh,
// vanluong, newbie2 ...). Normal NPCs take the low zone [1, PT_NPC_LOW_ZONE) first, as before, and spill into the
// high zone only when it is full. SetNpcAllocZone(1) (ext matdo: density extras) makes the AddNpc calls of the
// same game loop take the high zone only (0 when it is full, no spill into the low zone), so the extras never push
// a feature NPC out of the scanned range.
void KNpcSet::PtSetHighZone(BOOL bOn)
{
#ifdef _SERVER
	m_dwPtHighZoneLoop = bOn ? (DWORD)g_SubWorldSet.GetGameTime() + 1 : 0;
#endif
}

int KNpcSet::PtFindFree()
{
#ifdef _SERVER
	if (m_dwPtHighZoneLoop && m_dwPtHighZoneLoop == (DWORD)g_SubWorldSet.GetGameTime() + 1)
		return m_FreeIdxHigh.GetNext(0);
#endif
	int nIdx = m_FreeIdx.GetNext(0);
	if (!nIdx)
		nIdx = m_FreeIdxHigh.GetNext(0);
	return nIdx;
}

void KNpcSet::PtFreeInsert(int nIdx)
{
	if (nIdx >= PT_NPC_LOW_ZONE)
		m_FreeIdxHigh.Insert(nIdx);
	else
		m_FreeIdx.Insert(nIdx);
}

void KNpcSet::PtFreeRemove(int nIdx)
{
	if (nIdx >= PT_NPC_LOW_ZONE)
		m_FreeIdxHigh.Remove(nIdx);
	else
		m_FreeIdx.Remove(nIdx);
}
// engine2:END

#ifndef _SERVER
//---------------------------------------------------------------------------
//	���ܣ�����һ���ͻ���npc����Ҫ�趨ClientNpcID��
//---------------------------------------------------------------------------
int		KNpcSet::AddClientNpc(int nTemplateID, int nRegionX, int nRegionY, int nMpsX, int nMpsY, int nNo)
{
	int		nNpcNo, nNpcSettingIdxInfo, nMapX, nMapY, nOffX, nOffY, nRegion;

	nNpcSettingIdxInfo = MAKELONG(1, nTemplateID);
	SubWorld[0].Mps2Map(nMpsX, nMpsY, &nRegion, &nMapX, &nMapY, &nOffX, &nOffY);
	if (nRegion < 0)
		return 0;
	nNpcNo = this->Add(nNpcSettingIdxInfo, 0, nRegion, nMapX, nMapY, nOffX, nOffY);
	if (nNpcNo > 0)
	{
		Npc[nNpcNo].m_sClientNpcID.m_dwRegionID = MAKELONG(nRegionX, nRegionY);
		Npc[nNpcNo].m_sClientNpcID.m_nNo = nNo;
		Npc[nNpcNo].m_RegionIndex = nRegion;
		Npc[nNpcNo].m_dwRegionID = SubWorld[0].m_Region[nRegion].m_RegionID;
		Npc[nNpcNo].m_bClientOnly = TRUE;
		Npc[nNpcNo].m_SyncSignal = SubWorld[0].m_dwCurrentTime;
		SubWorld[0].m_Region[nRegion].DecRef(Npc[nNpcNo].m_MapX, Npc[nNpcNo].m_MapY, obj_npc);
	}

	return nNpcNo;
}
#endif

int KNpcSet::Add(int nSubWorld, void* pNpcInfo)
{
	KSPNpc*	pKSNpcInfo = (KSPNpc *)pNpcInfo;

	int nMpsX = pKSNpcInfo->nPositionX;
	int nMpsY = pKSNpcInfo->nPositionY;
	int	nNpcSettingIdxInfo = MAKELONG(pKSNpcInfo->nLevel, pKSNpcInfo->nTemplateID);

	int nRet = Add(nNpcSettingIdxInfo, nSubWorld, nMpsX, nMpsY);

	if (nRet)
	{
		Npc[nRet].m_TrapScriptID = 0;
		g_StrCpyLen(Npc[nRet].Name, pKSNpcInfo->szName, sizeof(Npc[nRet].Name));
		Npc[nRet].m_Kind = pKSNpcInfo->shKind;
		Npc[nRet].SetCamp(pKSNpcInfo->cCamp);
		Npc[nRet].SetCurrentCamp(pKSNpcInfo->cCamp);
		Npc[nRet].m_Series = pKSNpcInfo->cSeries;
		Npc[nRet].m_btSpecial = pKSNpcInfo->bSpecialNpc;

		if (pKSNpcInfo->szScript[0])
		{
			if (pKSNpcInfo->szScript[0] == '.')
				g_StrCpyLen(Npc[nRet].ActionScript, &pKSNpcInfo->szScript[1], sizeof(Npc[nRet].ActionScript));
			else
				g_StrCpyLen(Npc[nRet].ActionScript, pKSNpcInfo->szScript, sizeof(Npc[nRet].ActionScript));
			// ����Сд����֤�ű���Ӧ��ϵ
			g_StrLower(Npc[nRet].ActionScript);
			Npc[nRet].m_ActionScriptID = g_FileName2Id(Npc[nRet].ActionScript);
#ifdef _SERVER
			if(PhongThanIsXichTungTu(SubWorld[nSubWorld].m_SubWorldID,
				Npc[nRet].m_NpcSettingIdx,Npc[nRet].m_ActionScriptID))
			{
				g_StrCpyLen(Npc[nRet].ActionScript,PT_XICH_TUNG_TU_SCRIPT,sizeof(Npc[nRet].ActionScript));
				Npc[nRet].m_ActionScriptID=g_FileName2Id(Npc[nRet].ActionScript);
			}
#endif
            g_DebugLog("[Script]Npc %s,%d", Npc[nRet].ActionScript, Npc[nRet].m_ActionScriptID);
		}
		// An empty Region_S action script does not erase the template-level
		// ActionScript from the VNG Npcs.txt registry.
	}
	return nRet;
}

int KNpcSet::Add(int nNpcSettingIdxInfo, int nSubWorld, int nMpsX, int nMpsY, BOOL bBarrier/* = FALSE*/)
{
	int nRegion, nMapX, nMapY, nOffX, nOffY;
	if (nSubWorld < 0 || nSubWorld >= MAX_SUBWORLD)
		return 0;
	SubWorld[nSubWorld].Mps2Map(nMpsX, nMpsY, &nRegion, &nMapX, &nMapY, &nOffX, &nOffY);
	if (nRegion < 0)
		return 0;
	if (bBarrier)
	{
		//TamLTM va cham GetBarrierMin
		if (SubWorld[nSubWorld].m_Region[nRegion].GetBarrierMin(nMapX, nMapY, nOffX, nOffY, TRUE, TRUE) != Obstacle_NULL)
		{
			g_DebugLog("[AddNpc]Npc in Barrier %d,%d,%d",nSubWorld, nMpsX, nMpsY);
			return 0;
		}
	}
	return Add(nNpcSettingIdxInfo, nSubWorld, nRegion, nMapX, nMapY, nOffX, nOffY);
}

int KNpcSet::Add(int nNpcSettingIdxInfo, int nSubWorld, int nRegion, int nMapX, int nMapY, int nOffX /* = 0 */, int nOffY /* = 0 */)
{
	int nNpcSettingIdx = (short)HIWORD(nNpcSettingIdxInfo);// >> 7; //����128
	int nLevel = LOWORD(nNpcSettingIdxInfo);// & 0x7f;
	if (nNpcSettingIdx != PLAYER_MALE_NPCTEMPLATEID &&
		nNpcSettingIdx != PLAYER_FEMALE_NPCTEMPLATEID &&
		(nNpcSettingIdx < 0 || nNpcSettingIdx >= MAX_NPCSTYLE))
	{
		g_DebugLog("[AddNpc] invalid template=%d level=%d", nNpcSettingIdx, nLevel);
		return 0;
	}

	int i = FindFree();

	if (i == 0)
	{
		g_DebugLog("[Error!]AddNpc Error KNpcSet.cpp");
		return 0;
	}

#ifndef _SERVER
	Npc[i].m_sClientNpcID.m_dwRegionID = 0;
	Npc[i].m_sClientNpcID.m_nNo = -1;
	Npc[i].Remove();
#endif

	Npc[i].m_Index = i;
	Npc[i].Load(nNpcSettingIdx, nLevel);
	Npc[i].m_SkillList.m_nNpcIndex = i;
	Npc[i].m_SubWorldIndex = nSubWorld;
	Npc[i].m_RegionIndex = nRegion;
	ZeroMemory(Npc[i].m_nNpcParam, sizeof(Npc[i].m_nNpcParam));
	Npc[i].m_bNpcRemoveDeath = FALSE;
	Npc[i].m_nNpcTimeout = 0;
	Npc[i].m_dwNpcTimerDeadline = 0;
#ifdef _SERVER
	if (Npc[i].m_TimerScriptID && Npc[i].m_nNpcTimerValue > 0)
	{
		Npc[i].m_dwNpcTimerDeadline = g_SubWorldSet.GetGameTime() +
			Npc[i].m_nNpcTimerValue * GAME_FPS;
	}
#endif
	Npc[i].m_bNpcFollowFindPath = FALSE;
	Npc[i].m_uFindPathTime = 0;
	Npc[i].m_uFindPathMaxTime = 0;
	Npc[i].m_uLastFindPathTime = 0;
#ifndef _SERVER
	if (nRegion >= 0 && nRegion < 9)
		Npc[i].m_dwRegionID = SubWorld[nSubWorld].m_Region[nRegion].m_RegionID;
#endif
	Npc[i].m_MapX = nMapX;
	Npc[i].m_MapY = nMapY;
	Npc[i].m_OffX = nOffX;
	Npc[i].m_OffY = nOffY;

	SubWorld[nSubWorld].Map2Mps(nRegion, nMapX, nMapY, nOffX, nOffY, &Npc[i].m_OriginX, &Npc[i].m_OriginY);

#ifdef _SERVER
	SetID(i);
#endif
	// �޸Ŀ�����ʹ�ñ�
	PtFreeRemove(i);	// engine2:A4r
	m_UseIdx.Insert(i);
	SubWorld[nSubWorld].m_Region[nRegion].AddNpc(i);//m_WorldMessage.Send(GWM_NPC_ADD, nRegion, i); //Add Player and npc
	SubWorld[nSubWorld].m_Region[nRegion].AddRef(nMapX, nMapY, obj_npc);

#ifndef _SERVER
	Npc[i].m_dwRegionID = SubWorld[nSubWorld].m_Region[nRegion].m_RegionID;
#endif
	return i;
}


void KNpcSet::Remove(int nIdx)
{
	if (nIdx <= 0 || nIdx >= MAX_NPC)
		return;
#ifdef _SERVER
	PHONGTHAN_ENTITY_REFERENCE NetCommand;
	PhongThanInitializeWireHeader(&NetCommand.Header, PHONGTHAN_MSG_WORLD_ENTITY_REMOVE,
		sizeof(NetCommand), PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	NetCommand.EntityId = Npc[nIdx].m_dwID;

	int nSubWorld = Npc[nIdx].m_SubWorldIndex;
	int nRegion = Npc[nIdx].m_RegionIndex;

	if (nSubWorld >= 0 && nSubWorld < MAX_SUBWORLD && nRegion >= 0 && nRegion < SubWorld[nSubWorld].m_nTotalRegion)
	{
		NetCommand.MapId = SubWorld[nSubWorld].m_SubWorldID;
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
		SubWorld[nSubWorld].m_Region[nRegion].BroadCast(&NetCommand, sizeof(NetCommand), nMaxCount, Npc[nIdx].m_MapX, Npc[nIdx].m_MapY);

		int nConRegion;
		for (int i = 0; i < 8; i++)
		{
			nConRegion = SubWorld[nSubWorld].m_Region[nRegion].m_nConnectRegion[i];
			if (nConRegion == -1)
				continue;
			SubWorld[nSubWorld].m_Region[nConRegion].BroadCast(&NetCommand, sizeof(NetCommand), nMaxCount, Npc[nIdx].m_MapX - POff[i].x, Npc[nIdx].m_MapY - POff[i].y);
		}
	}
#endif
	Npc[nIdx].ClearNpcState();
	Npc[nIdx].m_SkillList.Clear();
	Npc[nIdx].Remove();

	PtFreeInsert(nIdx);	// engine2:A4f
	m_UseIdx.Remove(nIdx);
}

void KNpcSet::RemoveAll()
{
	int nIdx = m_UseIdx.GetNext(0);
	int nIdx1 = 0;
	while(nIdx)
	{
		nIdx1 = m_UseIdx.GetNext(nIdx);
		Npc[nIdx].ClearNpcState();
		Npc[nIdx].m_SkillList.Clear();
		Npc[nIdx].Remove();
		PtFreeInsert(nIdx);	// engine2:A4f
		m_UseIdx.Remove(nIdx);
		nIdx = nIdx1;
	}
}


#ifndef _SERVER
//---------------------------------------------------------------------------
//	���ܣ���npc������Ѱ������ĳ��region�� client npc �����ӽ�ȥ
//---------------------------------------------------------------------------
#include "PhongThanClientNpcReattach.inl"
#endif


void KNpcSet::SetID(int m_nIndex)
{
	if (m_nIndex <= 0 || m_nIndex >= MAX_NPC)
		return;

	Npc[m_nIndex].m_dwID = m_dwIDCreator;
	m_dwIDCreator++;
}

int KNpcSet::GetDistance(int nIdx1, int nIdx2)
{
	//TamLTM Debug
//	g_DebugLog("GetDistance");

	int	nRet = 0;
	if (Npc[nIdx1].m_SubWorldIndex != Npc[nIdx2].m_SubWorldIndex)
		return -1;

	if (Npc[nIdx1].m_RegionIndex == Npc[nIdx2].m_RegionIndex)
	{
		int XOff = (Npc[nIdx1].m_MapX - Npc[nIdx2].m_MapX) * SubWorld[Npc[nIdx1].m_SubWorldIndex].m_nCellWidth;
		XOff += (Npc[nIdx1].m_OffX - Npc[nIdx2].m_OffX) >> 10;

		int YOff = (Npc[nIdx1].m_MapY - Npc[nIdx2].m_MapY) * SubWorld[Npc[nIdx1].m_SubWorldIndex].m_nCellHeight;
		YOff += (Npc[nIdx1].m_OffY - Npc[nIdx2].m_OffY) >> 10;

		nRet = (int)sqrt(XOff * XOff + YOff * YOff);
	}
	else
	{
		int X1, Y1;
		SubWorld[Npc[nIdx1].m_SubWorldIndex].Map2Mps(Npc[nIdx1].m_RegionIndex,
			Npc[nIdx1].m_MapX,
			Npc[nIdx1].m_MapY,
			Npc[nIdx1].m_OffX,
			Npc[nIdx1].m_OffY,
			&X1,
			&Y1);
		int X2, Y2;
		SubWorld[Npc[nIdx2].m_SubWorldIndex].Map2Mps(Npc[nIdx2].m_RegionIndex,
			Npc[nIdx2].m_MapX,
			Npc[nIdx2].m_MapY,
			Npc[nIdx2].m_OffX,
			Npc[nIdx2].m_OffY,
			&X2,
			&Y2);

		nRet = (int)sqrt((X2 - X1) * (X2 - X1) + (Y2 - Y1) * (Y2 - Y1));
	}
	return nRet;
}

int		KNpcSet::GetDistanceSquare(int nIdx1, int nIdx2)
{
	//TamLTM Debug
//	g_DebugLog("GetDistanceSquare");

	int	nRet = 0;
	if (Npc[nIdx1].m_SubWorldIndex != Npc[nIdx2].m_SubWorldIndex)
		return -1;

	if (Npc[nIdx1].m_RegionIndex == Npc[nIdx2].m_RegionIndex)
	{
		int XOff = (Npc[nIdx1].m_MapX - Npc[nIdx2].m_MapX) * SubWorld[Npc[nIdx1].m_SubWorldIndex].m_nCellWidth;
		XOff += (Npc[nIdx1].m_OffX - Npc[nIdx2].m_OffX) >> 10;

		int YOff = (Npc[nIdx1].m_MapY - Npc[nIdx2].m_MapY) * SubWorld[Npc[nIdx1].m_SubWorldIndex].m_nCellHeight;
		YOff += (Npc[nIdx1].m_OffY - Npc[nIdx2].m_OffY) >> 10;

		nRet = (int)(XOff * XOff + YOff * YOff);
	}
	else
	{
		int X1, Y1;
		SubWorld[Npc[nIdx1].m_SubWorldIndex].Map2Mps(Npc[nIdx1].m_RegionIndex,
			Npc[nIdx1].m_MapX,
			Npc[nIdx1].m_MapY,
			Npc[nIdx1].m_OffX,
			Npc[nIdx1].m_OffY,
			&X1,
			&Y1);
		int X2, Y2;
		SubWorld[Npc[nIdx2].m_SubWorldIndex].Map2Mps(Npc[nIdx2].m_RegionIndex,
			Npc[nIdx2].m_MapX,
			Npc[nIdx2].m_MapY,
			Npc[nIdx2].m_OffX,
			Npc[nIdx2].m_OffY,
			&X2,
			&Y2);

		nRet = (int)((X2 - X1) * (X2 - X1) + (Y2 - Y1) * (Y2 - Y1));
	}
	return nRet;
}

int		KNpcSet::GetNextIdx(int nIdx)
{
	if (nIdx < 0 || nIdx >= MAX_NPC)
		return 0;
	return m_UseIdx.GetNext(nIdx);
}

#ifdef _SERVER

BOOL KNpcSet::ExecuteScript(int nNpcIndex, char* szScriptName, char* szFuncName, int nParam)
{
	DWORD dwScriptId = g_FileName2Id(szScriptName);
	return ExecuteScript(nNpcIndex, dwScriptId, szFuncName, nParam);
}

BOOL KNpcSet::ExecuteScript(int nNpcIndex, DWORD dwScriptId, char* szFuncName, int nParam)
{
	if (nNpcIndex > 0 && nNpcIndex < MAX_NPC)
	{
		try
		{
			KLuaScript * pScript = (KLuaScript* )g_GetScript(dwScriptId);
			if (pScript)
			{
				Lua_PushNumber(pScript->m_LuaState, Npc[nNpcIndex].m_SubWorldIndex);
				pScript->SetGlobalName(SCRIPT_SUBWORLDINDEX);

				int nTopIndex = 0;

				pScript->SafeCallBegin(&nTopIndex);
				pScript->CallFunction(szFuncName,0, "d", nParam);
				pScript->SafeCallEnd(nTopIndex);

			}
			return TRUE;
		}
		catch(...)
		{
			printf("-->Error Execute: %u [%s]\n", dwScriptId, szFuncName);
			return FALSE;
		}
	}
	return FALSE;
}
#endif

#ifndef _SERVER
void KNpcSet::CheckBalance()
{
/*	int nIdx;
	nIdx = m_UseIdx.GetNext(0);
	while(nIdx)
	{
		int nTmpIdx = m_UseIdx.GetNext(nIdx);
		if (SubWorld[0].m_dwCurrentTime - Npc[nIdx].m_SyncSignal > 1000)
		{
			if (nIdx != Player[CLIENT_PLAYER_INDEX].m_nIndex)
			{
				if (Npc[nIdx].m_RegionIndex >= 0)
				{
					SubWorld[0].m_Region[Npc[nIdx].m_RegionIndex].RemoveNpc(nIdx);
					SubWorld[0].m_Region[Npc[nIdx].m_RegionIndex].DecRef(Npc[nIdx].m_MapX, Npc[nIdx].m_MapY, obj_npc);
				}
				Remove(nIdx);
			}
		}
		nIdx = nTmpIdx;
	}
	nIdx = m_RequestUseIdx.GetNext(0);
	while(nIdx)
	{
		int nTmpIdx = m_RequestUseIdx.GetNext(nIdx);
		if (SubWorld[0].m_dwCurrentTime - m_RequestNpc[nIdx].dwRequestTime > 100)
		{
			DWORD	dwID = m_RequestNpc[nIdx].dwRequestId;
			m_RequestNpc[nIdx].dwRequestId = 0;
			m_RequestNpc[nIdx].dwRequestTime = 0;

			m_RequestUseIdx.Remove(nIdx);
			m_RequestFreeIdx.Insert(nIdx);
//			g_DebugLog("[Request]Remove %d from %d on %d timeout", dwID, nIdx, SubWorld[0].m_dwCurrentTime);
		}
		nIdx = nTmpIdx;
	}*/

	//Fix remove del npc
	int nIdx;
	nIdx = m_UseIdx.GetNext(0);
	while(nIdx)
	{
		int nTmpIdx = m_UseIdx.GetNext(nIdx);
		// Region_S NPCs and monsters can remain completely static.  The server
		// sends their full state when they enter the player's interest area and
		// later removes them with s2c_npcremove.  Treating the lack of movement
		// packets as a timeout made every static NPC disappear from the client
		// after a few seconds.
		BOOL bPersistentServerNpc =
			(Npc[nIdx].m_Kind == kind_normal || Npc[nIdx].m_Kind == kind_dialoger);
		if (!bPersistentServerNpc &&
			SubWorld[0].m_dwCurrentTime - Npc[nIdx].m_SyncSignal > 1000)
		{
			if (nIdx != Player[CLIENT_PLAYER_INDEX].m_nIndex)
			{
				if (Npc[nIdx].m_RegionIndex >= 0)
				{
					SubWorld[0].m_Region[Npc[nIdx].m_RegionIndex].RemoveNpc(nIdx);
					SubWorld[0].m_Region[Npc[nIdx].m_RegionIndex].DecRef(Npc[nIdx].m_MapX, Npc[nIdx].m_MapY, obj_npc);
				}
				Remove(nIdx);
			}
		}
		else if (!bPersistentServerNpc &&
			nIdx != Player[CLIENT_PLAYER_INDEX].m_nIndex &&
			Player[CLIENT_PLAYER_INDEX].m_nIndex > 0 &&
			Player[CLIENT_PLAYER_INDEX].m_nIndex < MAX_NPC)
			{

			if (Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_SyncSignal - Npc[nIdx].m_SyncSignal > 5*18)//Fix lag toa do
			{
				if (Npc[nIdx].m_RegionIndex >= 0)
				{
					SubWorld[0].m_Region[Npc[nIdx].m_RegionIndex].RemoveNpc(nIdx);
					SubWorld[0].m_Region[Npc[nIdx].m_RegionIndex].DecRef(Npc[nIdx].m_MapX, Npc[nIdx].m_MapY, obj_npc);
				}

				Remove(nIdx);
			}
		}

		nIdx = nTmpIdx;
	}
	nIdx = m_RequestUseIdx.GetNext(0);
	while(nIdx)
	{
		int nTmpIdx = m_RequestUseIdx.GetNext(nIdx);
		if (SubWorld[0].m_dwCurrentTime - m_RequestNpc[nIdx].dwRequestTime > 100)
		{
			DWORD	dwID = m_RequestNpc[nIdx].dwRequestId;
			m_RequestNpc[nIdx].dwRequestId = 0;
			m_RequestNpc[nIdx].dwRequestTime = 0;

			m_RequestUseIdx.Remove(nIdx);
			m_RequestFreeIdx.Insert(nIdx);
		//	g_DebugLog("[Request]Remove %d from %d on %d timeout", dwID, nIdx, SubWorld[0].m_dwCurrentTime);
		}
		nIdx = nTmpIdx;
	}
	//end code
}
#endif

#ifndef _SERVER
//-------------------------------------------------------------------------
//	���ܣ������Χ����б������ڽ��棬���������б�
//-------------------------------------------------------------------------
int		KNpcSet::GetAroundPlayerForTeamInvite(KUiPlayerItem *pList, int nCount)
{
	int nCamp = Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_Camp;
	int nNum = 0, i;

	if (nCount == 0)
	{
		int nIdx = 0;
		while (1)
		{
			nIdx = m_UseIdx.GetNext(nIdx);
			if (nIdx == 0)
				break;
			if (Npc[nIdx].m_Kind != kind_player)
				continue;
			if (nIdx == Player[CLIENT_PLAYER_INDEX].m_nIndex)
				continue;
			if (Npc[nIdx].m_Camp != camp_begin && nCamp == camp_begin)
				continue;
			if (Npc[nIdx].m_RegionIndex < 0)
				continue;
			if (Npc[nIdx].Name[0]==0)
				continue;
			for (i = 0; i < MAX_TEAM_MEMBER; i++)
			{
				if ((DWORD)g_Team[0].m_nMember[i] == Npc[nIdx].m_dwID)
					break;
			}
			if (i < MAX_TEAM_MEMBER)
				continue;
			if ((DWORD)g_Team[0].m_nCaptain == Npc[nIdx].m_dwID)
				continue;
			nNum++;
		}

		return nNum;
	}

	if (!pList)
		return 0;

	int nIdx = 0;
	while (1)
	{
		nIdx = m_UseIdx.GetNext(nIdx);
		if (nIdx == 0)
			break;
		if (Npc[nIdx].m_Kind != kind_player)
			continue;
		if (nIdx == Player[CLIENT_PLAYER_INDEX].m_nIndex)
			continue;
		if (Npc[nIdx].m_Camp != camp_begin && nCamp == camp_begin)
			continue;
		if (Npc[nIdx].m_RegionIndex < 0)
			continue;
		if (Npc[nIdx].Name[0]==0)
			continue;
		for (i = 0; i < MAX_TEAM_MEMBER; i++)
		{
			if ((DWORD)g_Team[0].m_nMember[i] == Npc[nIdx].m_dwID)
				break;
		}
		if (i < MAX_TEAM_MEMBER)
			continue;
		if ((DWORD)g_Team[0].m_nCaptain == Npc[nIdx].m_dwID)
			continue;
		pList[nNum].nIndex = nIdx;
		pList[nNum].uId = Npc[nIdx].m_dwID;
		strcpy(pList[nNum].Name, Npc[nIdx].Name);
		nNum++;
	}

	return nNum;
}
#endif

#ifndef _SERVER
//-------------------------------------------------------------------------
//	���ܣ������Χ����б�(�����б�)
//-------------------------------------------------------------------------
int		KNpcSet::GetAroundPlayer(KUiPlayerItem *pList, int nCount)
{
	int nNum = 0;

	if (nCount <= 0)
	{
		int nIdx = 0;
		while (1)
		{
			nIdx = m_UseIdx.GetNext(nIdx);
			if (nIdx == 0)
				break;
			if (Npc[nIdx].m_Kind != kind_player ||
				nIdx == Player[CLIENT_PLAYER_INDEX].m_nIndex ||
				Npc[nIdx].m_RegionIndex < 0)
			{
				continue;
			}
			nNum++;
		}

		return nNum;
	}

	if (!pList)
		return 0;

	int nIdx = 0;
	while (nNum < nCount)
	{
		nIdx = m_UseIdx.GetNext(nIdx);
		if (nIdx == 0)
			break;
		if (Npc[nIdx].m_Kind != kind_player ||
			nIdx == Player[CLIENT_PLAYER_INDEX].m_nIndex ||
			Npc[nIdx].m_RegionIndex < 0)
		{
			continue;
		}
		pList[nNum].nIndex = nIdx;
		pList[nNum].uId = Npc[nIdx].m_dwID;
		strcpy(pList[nNum].Name, Npc[nIdx].Name);
		pList[nNum].nData = Npc[nIdx].GetMenuState();
		nNum++;
	}

	return nNum;
}
#endif

#ifndef _SERVER
//-------------------------------------------------------------------------
//	���ܣ��趨�Ƿ�ȫ����ʾ��ҵ�����
//			bFlag ==	TRUE ��ʾ��bFlag == FALSE ����ʾ zroc add
//-------------------------------------------------------------------------
void	KNpcSet::SetShowNameFlag(BOOL bFlag)
{
	if (bFlag)
		m_nShowPateFlag |= PATE_NAME;
	else
		m_nShowPateFlag &= ~PATE_NAME;
}
#endif

#ifndef _SERVER
//-------------------------------------------------------------------------
//	���ܣ��ж��Ƿ�ȫ����ʾ��ҵ�����  ����ֵ TRUE ��ʾ��FALSE ����ʾ
//-------------------------------------------------------------------------
BOOL	KNpcSet::CheckShowName()
{
	return m_nShowPateFlag & PATE_NAME;
}
#endif

#ifndef _SERVER
//-------------------------------------------------------------------------
//	���ܣ��趨�Ƿ�ȫ����ʾ��ҵ�Ѫ
//			bFlag ==	TRUE ��ʾ��bFlag == FALSE ����ʾ zroc add
//-------------------------------------------------------------------------
void	KNpcSet::SetShowLifeFlag(BOOL bFlag)
{
	if (bFlag)
		m_nShowPateFlag |= PATE_LIFE;
	else
		m_nShowPateFlag &= ~PATE_LIFE;
}
#endif

#ifndef _SERVER
//-------------------------------------------------------------------------
//	���ܣ��ж��Ƿ�ȫ����ʾ��ҵ�Ѫ  ����ֵ TRUE ��ʾ��FALSE ����ʾ
//-------------------------------------------------------------------------
BOOL	KNpcSet::CheckShowLife()
{
	return m_nShowPateFlag & PATE_LIFE;
}
#endif

#ifndef _SERVER
//-------------------------------------------------------------------------
//	���ܣ��趨�Ƿ�ȫ����ʾ��ҵ�����
//			bFlag ==	TRUE ��ʾ��bFlag == FALSE ����ʾ zroc add
//-------------------------------------------------------------------------
void	KNpcSet::SetShowObjFlag(BOOL bFlag)
{
	if (bFlag)
		m_nShowPateFlag |= PATE_OBJ;
	else
		m_nShowPateFlag &= ~PATE_OBJ;
}
#endif

#ifndef _SERVER
//-------------------------------------------------------------------------
//	���ܣ��ж��Ƿ�ȫ����ʾ��ҵ�����  ����ֵ TRUE ��ʾ��FALSE ����ʾ
//-------------------------------------------------------------------------
BOOL	KNpcSet::CheckShowObj()
{
	return m_nShowPateFlag & PATE_OBJ;
}
#endif

//-------------------------------------------------------------------------
//	���ܣ�������npc�� bActivateFlag ��Ϊ FALSE
//		(ÿ����Ϸѭ����������npc��activate֮ǰ���������)
//-------------------------------------------------------------------------
void	KNpcSet::ClearActivateFlagOfAllNpc()
{
	int nIdx = 0;
	while (1)
	{
		nIdx = m_UseIdx.GetNext(nIdx);
		if (nIdx == 0)
			break;
		Npc[nIdx].m_bActivateFlag = FALSE;
	}
}

#ifndef _SERVER
//-------------------------------------------------------------------------
//	���ܣ������Χͬ��Ӫ���ѿ��Ŷ���ӳ��б� ��ͬ��Ӫ���ڿ������
//-------------------------------------------------------------------------
void	KNpcSet::GetAroundOpenCaptain(int nCamp)
{
	int		nIdx, nNum, nNo;

	nIdx = 0;
	nNum = 0;
	while (1)
	{
		nIdx = m_UseIdx.GetNext(nIdx);
		if (nIdx == 0)
			break;
		if (Npc[nIdx].m_Kind != kind_player)
			continue;
		if (nIdx == Player[CLIENT_PLAYER_INDEX].m_nIndex)
			continue;
		// ��ͬ��Ӫ���ڿ�����ӣ����ֲ��ܼ������˶��飬���˿��Լ������ֶ���
		if (Npc[nIdx].m_Camp == camp_begin && nCamp != camp_begin)
			continue;
//		if (Npc[nIdx].m_Camp != nCamp)
//			continue;
		if (Npc[nIdx].m_RegionIndex < 0)
			continue;
		if (Npc[nIdx].GetMenuState() == PLAYER_MENU_STATE_TEAMOPEN)
			nNum++;
	}

	if (nNum > 0)
	{
		KUiTeamItem* const pTeamList = new KUiTeamItem[nNum];
		nIdx = 0;
		nNo = 0;
		while (1)
		{
			nIdx = m_UseIdx.GetNext(nIdx);
			if (nIdx == 0)
				break;
			if (Npc[nIdx].m_Kind != kind_player)
				continue;
			if (nIdx == Player[CLIENT_PLAYER_INDEX].m_nIndex)
				continue;
			// ��ͬ��Ӫ���ڿ�����ӣ����ֲ��ܼ������˶��飬���˿��Լ������ֶ���
			if (Npc[nIdx].m_Camp == camp_begin && nCamp != camp_begin)
				continue;
//			if (Npc[nIdx].m_Camp != nCamp)
//				continue;
			if (Npc[nIdx].m_RegionIndex < 0)
				continue;
			if (Npc[nIdx].GetMenuState() == PLAYER_MENU_STATE_TEAMOPEN)
			{
				pTeamList[nNo].Leader.nIndex = nIdx;
				pTeamList[nNo].Leader.uId = Npc[nIdx].m_dwID;
				strcpy(pTeamList[nNo].Leader.Name, Npc[nIdx].Name);
				nNo++;
				if (nNo >= nNum)
					break;
			}
		}
		CoreDataChanged(GDCNI_TEAM_NEARBY_LIST, (unsigned int)pTeamList, nNo);
		delete []pTeamList;
	}
}
#endif

#ifndef _SERVER	// ���ڿͻ���
int	KNpcSet::SearchNpcAt(int nX, int nY, int nRelation, int nRange)
{
	int nIdx;
	int	nMin = nRange;
	int nMinIdx = 0;
	int	nLength = 0;
	int nSrcX[2];
	int	nSrcY[2];

	nSrcX[0] = nX;
	nSrcY[0] = nY;
	g_ScenePlace.ViewPortCoordToSpaceCoord(nSrcX[0], nSrcY[0], 0);

	nSrcX[1] = nX;
	nSrcY[1] = nY;
	g_ScenePlace.ViewPortCoordToSpaceCoord(nSrcX[1], nSrcY[1], 120);

	int nDx = nSrcX[0] - nSrcX[1];
	int nDy = nSrcY[0] - nSrcY[1];

	nIdx = 0;
	while (1)
	{
		nIdx = m_UseIdx.GetNext(nIdx);

		if (nIdx == 0)
			break;

		if (Npc[nIdx].m_RegionIndex < 0)
			continue;

		if (nIdx == Player[CLIENT_PLAYER_INDEX].m_nIndex)
			continue;

		if (Npc[nIdx].m_bClientOnly)
			continue;

		if (!(GetRelation(Player[CLIENT_PLAYER_INDEX].m_nIndex, nIdx) & nRelation))
			continue;

		int x, y;
		SubWorld[0].Map2Mps(Npc[nIdx].m_RegionIndex, Npc[nIdx].m_MapX, Npc[nIdx].m_MapY,
			Npc[nIdx].m_OffX, Npc[nIdx].m_OffY, &x, &y);

		if (nSrcY[0] > y)
			continue;

		int nNpcHitHeight = Npc[nIdx].GetNpcPate();
		if (nNpcHitHeight < 80)
			nNpcHitHeight = 80;
		else if (nNpcHitHeight > 220)
			nNpcHitHeight = 220;

		if (nSrcY[0] < y - nNpcHitHeight)
			continue;

		nLength = abs(nDx * (nSrcY[0] - y) / nDy + nSrcX[0] - x);
		if (nLength < nMin)
		{
			nMin = nLength;
			nMinIdx = nIdx;
		}
	}

	return nMinIdx;
}
#endif

#ifndef _SERVER
BOOL KNpcSet::IsNpcRequestExist(DWORD dwID)
{
	return (GetRequestIndex(dwID) > 0);
}

BOOL KNpcSet::InsertNpcRequest(DWORD dwID)
{
	if (IsNpcRequestExist(dwID))
	{
		return FALSE;
	}

	int nIndex = m_RequestFreeIdx.GetNext(0);
	if (!nIndex)
		return FALSE;

	m_RequestNpc[nIndex].dwRequestId = dwID;
	m_RequestNpc[nIndex].dwRequestTime = SubWorld[0].m_dwCurrentTime;
	m_RequestFreeIdx.Remove(nIndex);
	m_RequestUseIdx.Insert(nIndex);
	g_DebugLog("[Request]Insert %d at %d on %d", dwID, nIndex, SubWorld[0].m_dwCurrentTime);

	return TRUE;
}

void KNpcSet::RemoveNpcRequest(DWORD dwID)
{
	if(!IsNpcRequestExist(dwID))
	{
		return;
	}
	int nIndex = GetRequestIndex(dwID);

	// because _ASSERT(IsNpcRequestExist()); so nIndex > 0;
	m_RequestNpc[nIndex].dwRequestId = 0;
	m_RequestNpc[nIndex].dwRequestTime = 0;

	m_RequestUseIdx.Remove(nIndex);
	m_RequestFreeIdx.Insert(nIndex);
//	g_DebugLog("[Request]Remove %d from %d on %d", dwID, nIndex, SubWorld[0].m_dwCurrentTime);
}

int KNpcSet::GetRequestIndex(DWORD dwID)
{
	int nIndex = m_RequestUseIdx.GetNext(0);

	while(nIndex)
	{
		if (m_RequestNpc[nIndex].dwRequestId == dwID)
		{
			return nIndex;
		}
		nIndex = m_RequestUseIdx.GetNext(nIndex);
	}
	return 0;
}
#endif

NPC_RELATION KNpcSet::GetRelation(int nId1, int nId2)
{
	// ͬһ����
	if (nId1 == nId2)
		return relation_self;

#ifndef _SERVER
	if (Npc[nId1].m_bClientOnly || Npc[nId2].m_bClientOnly)
		return relation_none;
#endif

    _ASSERT(
        ((Npc[nId1].m_Kind >= 0) && (Npc[nId1].m_Kind < kind_num)) &&
        ((Npc[nId2].m_Kind >= 0) && (Npc[nId2].m_Kind < kind_num)) &&
        ((Npc[nId1].m_CurrentCamp >= 0) && (Npc[nId1].m_CurrentCamp < camp_num)) &&
        ((Npc[nId2].m_CurrentCamp >= 0) && (Npc[nId2].m_CurrentCamp < camp_num))
    );

#ifndef _SERVER
	if (Player[CLIENT_PLAYER_INDEX].m_nIndex != nId1 && Player[CLIENT_PLAYER_INDEX].m_nIndex != nId2)
	{
		if (!Npc[nId1].IsAlive() || !Npc[nId2].IsAlive())
			return relation_none;

		NPC_RELATION nRelation =  (NPC_RELATION)m_RelationTable
			[Npc[nId1].m_Kind]
			[Npc[nId2].m_Kind]
			[Npc[nId1].m_CurrentCamp]
			[Npc[nId2].m_CurrentCamp];
		if (nRelation == relation_enemy)
		{
			if (Npc[nId1].m_Kind == kind_player &&
				Npc[nId2].m_Kind == kind_player &&
				(!Npc[nId1].m_nPKFlag ||
				!Npc[nId2].m_nPKFlag ||
				Npc[nId1].m_FightMode == enumFightNone ||
				Npc[nId2].m_FightMode == enumFightNone)
				)
				return relation_none;
			if ((Npc[nId1].m_Kind == kind_player &&
				Npc[nId2].m_Kind == kind_normal && Npc[nId1].m_FightMode == enumFightNone) ||
				(Npc[nId1].m_Kind == kind_normal &&
				Npc[nId2].m_Kind == kind_player && Npc[nId2].m_FightMode == enumFightNone)
				)
				return relation_none;
		}
		return nRelation;
	}
	else if (Player[CLIENT_PLAYER_INDEX].m_nIndex == nId1)
	{
		if (/*!Npc[nId1].IsAlive() || */!Npc[nId2].IsAlive())
			return relation_none;

		if (Player[CLIENT_PLAYER_INDEX].m_cPK.GetExercisePKAim() == Npc[nId2].m_dwID)
			return relation_enemy;

		if (Player[CLIENT_PLAYER_INDEX].m_cPK.GetEnmityPKState() == enumPK_ENMITY_STATE_PKING &&
			Player[CLIENT_PLAYER_INDEX].m_cPK.GetEnmityPKAimNpcID() == Npc[nId2].m_dwID
			)
			return relation_enemy;

		if ((Npc[nId2].m_Kind == kind_player && Player[CLIENT_PLAYER_INDEX].m_cPK.GetNormalPKState() == enumPKMurder) ||
				(Npc[nId2].m_Kind == kind_player &&
				Npc[nId2].m_nPKFlag == enumPKMurder &&
				Player[CLIENT_PLAYER_INDEX].m_cPK.GetNormalPKState())
			)
		{
			if(Npc[nId1].m_FightMode && Npc[nId2].m_FightMode &&
				Npc[nId2].m_CurrentCamp != camp_begin &&
				Npc[nId1].m_CurrentCamp != camp_begin &&
				Npc[nId2].m_CurrentCamp != Npc[nId1].m_CurrentCamp
				)
			{
				return relation_enemy;
			}
		}

		if (Npc[nId1].m_nTeamServerID >= 0 &&
			Npc[nId2].m_nTeamServerID >= 0 &&
			Npc[nId1].m_nTeamServerID == Npc[nId2].m_nTeamServerID
			)
			return relation_ally;

		if (Npc[nId2].m_Kind == kind_player &&
			Player[CLIENT_PLAYER_INDEX].m_cPK.GetNormalPKState() == enumPKTongWar &&
			Npc[nId2].m_nPKFlag == enumPKTongWar)
		{
			if (Npc[nId1].m_FightMode && Npc[nId2].m_FightMode)
			{
				if (Npc[nId1].m_dwTongNameID == Npc[nId2].m_dwTongNameID)
				{
					if (Npc[nId1].m_CurrentCamp != Npc[nId2].m_CurrentCamp)
						return relation_none;
					else
						return relation_ally;
				}
				else
					return relation_enemy;

			}
			else
			{
				if (Npc[nId1].m_dwTongNameID == Npc[nId2].m_dwTongNameID)
					return relation_ally;
				else
					return relation_none;
			}
		}

		NPC_RELATION nRelation =  (NPC_RELATION)m_RelationTable
			[Npc[nId1].m_Kind]
			[Npc[nId2].m_Kind]
			[Npc[nId1].m_CurrentCamp]
			[Npc[nId2].m_CurrentCamp];
		if (nRelation == relation_enemy)
		{
			if (Npc[nId1].m_Kind == kind_player &&
				Npc[nId2].m_Kind == kind_player &&
				(!Npc[nId1].m_nPKFlag ||
				!Npc[nId2].m_nPKFlag ||
				Npc[nId1].m_FightMode == enumFightNone ||
				Npc[nId2].m_FightMode == enumFightNone)
				)
				return relation_none;
			if ((Npc[nId1].m_Kind == kind_player &&
				Npc[nId2].m_Kind == kind_normal && Npc[nId1].m_FightMode == enumFightNone) ||
				(Npc[nId1].m_Kind == kind_normal &&
				Npc[nId2].m_Kind == kind_player && Npc[nId2].m_FightMode == enumFightNone)
				)
				return relation_none;
		}
		/*else if(nRelation == relation_ally)
		{
			if (Npc[nId1].m_Kind == kind_player &&
				Npc[nId2].m_Kind == kind_player &&
				(Npc[nId1].m_FightMode != Npc[nId2].m_FightMode)
				)
				return relation_none;
		}*/
		return nRelation;
	}
	else
	{
		if (!Npc[nId1].IsAlive()/* || !Npc[nId2].IsAlive()*/)
			return relation_none;

		if (Player[CLIENT_PLAYER_INDEX].m_cPK.GetExercisePKAim() == Npc[nId1].m_dwID)
			return relation_enemy;

		if (Player[CLIENT_PLAYER_INDEX].m_cPK.GetEnmityPKState() == enumPK_ENMITY_STATE_PKING &&
			Player[CLIENT_PLAYER_INDEX].m_cPK.GetEnmityPKAimNpcID() == Npc[nId1].m_dwID)
			return relation_enemy;

		if ((Npc[nId1].m_Kind == kind_player && Player[CLIENT_PLAYER_INDEX].m_cPK.GetNormalPKState() == enumPKMurder) ||
				(Npc[nId1].m_Kind == kind_player &&
				Npc[nId1].m_nPKFlag == enumPKMurder &&
				!Player[CLIENT_PLAYER_INDEX].m_cPK.GetNormalPKState())
			)
		{
			if(Npc[nId1].m_FightMode && Npc[nId2].m_FightMode &&
				(Npc[nId1].m_CurrentCamp != camp_begin &&
				Npc[nId2].m_CurrentCamp != camp_begin &&
				Npc[nId1].m_CurrentCamp != Npc[nId2].m_CurrentCamp)
				)
			{
				return relation_enemy;
			}
		}

		if (Npc[nId1].m_nTeamServerID >= 0 &&
			Npc[nId2].m_nTeamServerID >= 0 &&
			Npc[nId1].m_nTeamServerID == Npc[nId2].m_nTeamServerID
			)
			return relation_ally;

		if (Npc[nId1].m_Kind == kind_player &&
			Player[CLIENT_PLAYER_INDEX].m_cPK.GetNormalPKState() == enumPKTongWar &&
			Npc[nId1].m_nPKFlag == enumPKTongWar
			)
		{
			if (Npc[nId1].m_FightMode && Npc[nId2].m_FightMode)
			{
				if (Npc[nId2].m_dwTongNameID == Npc[nId1].m_dwTongNameID)
				{
					if (Npc[nId1].m_CurrentCamp != Npc[nId2].m_CurrentCamp)
						return relation_none;
					else
						return relation_ally;
				}
				else
					return relation_enemy;
			}
			else
			{
				if (Npc[nId2].m_dwTongNameID == Npc[nId1].m_dwTongNameID)
					return relation_ally;
				else
					return relation_none;
			}
		}


		NPC_RELATION nRelation =  (NPC_RELATION)m_RelationTable
			[Npc[nId1].m_Kind]
			[Npc[nId2].m_Kind]
			[Npc[nId1].m_CurrentCamp]
			[Npc[nId2].m_CurrentCamp];

		if (nRelation == relation_enemy)
		{
			if (Npc[nId1].m_Kind == kind_player &&
				Npc[nId2].m_Kind == kind_player &&
				(!Npc[nId1].m_nPKFlag ||
				!Npc[nId2].m_nPKFlag ||
				Npc[nId1].m_FightMode == enumFightNone ||
				Npc[nId2].m_FightMode == enumFightNone)
				)
				return relation_none;
			if ((Npc[nId1].m_Kind == kind_player &&
				Npc[nId2].m_Kind == kind_normal && Npc[nId1].m_FightMode == enumFightNone) ||
				(Npc[nId1].m_Kind == kind_normal &&
				Npc[nId2].m_Kind == kind_player && Npc[nId2].m_FightMode == enumFightNone)
				)
				return relation_none;
		}
		/*else if(nRelation == relation_ally)
		{
			if (Npc[nId1].m_Kind == kind_player &&
				Npc[nId2].m_Kind == kind_player &&
				(Npc[nId1].m_FightMode != Npc[nId2].m_FightMode)
				)
				return relation_none;
		}*/
		return nRelation;
	}
#endif

#ifdef _SERVER
	if (Npc[nId1].m_Kind != kind_player ||
		Npc[nId2].m_Kind != kind_player
		)
	{
		return (NPC_RELATION)m_RelationTable
			[Npc[nId1].m_Kind]
			[Npc[nId2].m_Kind]
			[Npc[nId1].m_CurrentCamp]
			[Npc[nId2].m_CurrentCamp];

	}
	else
	{
		//if (!Npc[nId1].IsAlive() || !Npc[nId2].IsAlive())
		//	return relation_none;

		if (Player[Npc[nId1].m_nPlayerIdx].m_cPK.GetExercisePKAim() == Npc[nId2].m_nPlayerIdx)
			return relation_enemy;

		if (Player[Npc[nId1].m_nPlayerIdx].m_cPK.GetEnmityPKState() == enumPK_ENMITY_STATE_PKING &&
			Player[Npc[nId1].m_nPlayerIdx].m_cPK.GetEnmityPKAim() == Npc[nId2].m_nPlayerIdx
			)
			return relation_enemy;

		if ((Npc[nId2].m_Kind == kind_player && Player[Npc[nId1].m_nPlayerIdx].m_cPK.GetNormalPKState() == enumPKMurder) ||
				(Npc[nId2].m_Kind == kind_player &&
				Player[Npc[nId1].m_nPlayerIdx].m_cPK.GetNormalPKState() == enumPKMurder &&
				!Player[Npc[nId1].m_nPlayerIdx].m_cPK.GetNormalPKState())
			)
		{
			if (Npc[nId1].m_FightMode && Npc[nId2].m_FightMode &&
				Npc[nId1].m_CurrentCamp != camp_begin &&
				Npc[nId2].m_CurrentCamp != camp_begin &&
				Npc[nId1].m_CurrentCamp != Npc[nId2].m_CurrentCamp
				)
			{
				return relation_enemy;
			}
		}

		if (Player[Npc[nId1].m_nPlayerIdx].m_cTeam.m_nID >= 0 &&
			Player[Npc[nId2].m_nPlayerIdx].m_cTeam.m_nID >= 0 &&
			Player[Npc[nId1].m_nPlayerIdx].m_cTeam.m_nID == Player[Npc[nId2].m_nPlayerIdx].m_cTeam.m_nID
			)
			return relation_ally;

		if (Npc[nId2].m_Kind == kind_player &&
			Player[Npc[nId1].m_nPlayerIdx].m_cPK.GetNormalPKState() == enumPKTongWar &&
			Npc[nId2].m_nPKFlag == enumPKTongWar
			)
		{
			if (Npc[nId1].m_FightMode && Npc[nId2].m_FightMode)
			{
				if (Player[nId1].m_cTong.m_dwTongNameID == Player[nId2].m_cTong.m_dwTongNameID)
				{
					if (Npc[nId1].m_CurrentCamp != Npc[nId2].m_CurrentCamp)
						return relation_none;
					else
						return relation_ally;
				}
				else
					return relation_enemy;
			}
			else
			{
				if (Player[nId1].m_cTong.m_dwTongNameID == Player[nId2].m_cTong.m_dwTongNameID)
					return relation_ally;
				else
					return relation_none;
			}
		}
		NPC_RELATION nRelation =  (NPC_RELATION)m_RelationTable
			[Npc[nId1].m_Kind]
			[Npc[nId2].m_Kind]
			[Npc[nId1].m_CurrentCamp]
			[Npc[nId2].m_CurrentCamp];

		if (nRelation == relation_enemy)
		{
			if (!Player[Npc[nId1].m_nPlayerIdx].m_cPK.GetNormalPKState() ||
				!Player[Npc[nId2].m_nPlayerIdx].m_cPK.GetNormalPKState() ||
				Npc[nId1].m_FightMode == enumFightNone ||
				Npc[nId2].m_FightMode == enumFightNone
				)
				return relation_none;
			if ((Npc[nId1].m_Kind == kind_player &&
				Npc[nId2].m_Kind == kind_normal && Npc[nId1].m_FightMode == enumFightNone) ||
				(Npc[nId1].m_Kind == kind_normal &&
				Npc[nId2].m_Kind == kind_player && Npc[nId2].m_FightMode == enumFightNone)
				)
				return relation_none;
		}
		/*else if(nRelation == relation_ally)
		{
			if (Npc[nId1].m_FightMode != Npc[nId2].m_FightMode)
				return relation_none;
		}*/
		return nRelation;
	}
#endif
}

//------------------------ class KInstantSpecial start -------------------------
#ifndef _SERVER
KInstantSpecial::KInstantSpecial()
{
	int		i;
	this->m_nLoadFlag = FALSE;
	for (i = 0; i < MAX_INSTANT_STATE; i++)
		this->m_szSprName[i][0] = 0;
	for (i = 0; i < MAX_INSTANT_SOUND; i++)
		this->m_szSoundName[i][0] = 0;

	m_pSoundNode = NULL;
	m_pWave = NULL;
}

void	KInstantSpecial::LoadSprName()
{
	int		i;
	for (i = 0; i < MAX_INSTANT_STATE; i++)
		m_szSprName[i][0] = 0;

	KTabFile	cSprName;
//	g_SetFilePath("\\");
	if (!cSprName.Load(PLAYER_INSTANT_SPECIAL_FILE))
		return;
	for (i = 0; i < MAX_INSTANT_STATE; i++)
		cSprName.GetString(i + 2, 3, "", m_szSprName[i], sizeof(m_szSprName[i]));
}

void	KInstantSpecial::LoadSoundName()
{
	int		i;
	for (i = 0; i < MAX_INSTANT_SOUND; i++)
		m_szSoundName[i][0] = 0;

	KIniFile	cSoundName;
	char		szTemp[32];
//	g_SetFilePath("\\");
	if (!cSoundName.Load(defINSTANT_SOUND_FILE))
		return;
	for (i = 0; i < MAX_INSTANT_SOUND; i++)
	{
		sprintf(szTemp, "%d", i);
		cSoundName.GetString("Game", szTemp, "", this->m_szSoundName[i], sizeof(m_szSoundName[i]));
	}
}

void	KInstantSpecial::GetSprName(int nNo, char *lpszName, int nLength)
{
	if (!lpszName || nLength <= 0)
		return;
	if (nNo < 0 || nNo >= MAX_INSTANT_STATE)
	{
		lpszName[0] = 0;
		return;
	}
	if (this->m_nLoadFlag == FALSE)
	{
		this->LoadSprName();
		this->LoadSoundName();
		m_nLoadFlag = TRUE;
	}

	if (strlen(this->m_szSprName[nNo]) < (DWORD)nLength)
		strcpy(lpszName, m_szSprName[nNo]);
	else
		lpszName[0] = 0;
}

void	KInstantSpecial::PlaySound(int nNo)
{
	if (this->m_nLoadFlag == FALSE)
	{
		this->LoadSprName();
		this->LoadSoundName();
		m_nLoadFlag = TRUE;
	}
	if (nNo < 0 || nNo >= MAX_INSTANT_SOUND)
		return;
	if ( !m_szSoundName[nNo][0] )
		return;

	m_pSoundNode = (KCacheNode*)g_SoundCache.GetNode(m_szSoundName[nNo], (KCacheNode*)m_pSoundNode);
	m_pWave = (KWavSound*)m_pSoundNode->m_lpData;
	if (m_pWave)
	{
		if (m_pWave->IsPlaying())
			return;
		m_pWave->Play(0, -10000 + Option.GetSndVolume() * 100, 0);
	}
}

#endif
//------------------------- class KInstantSpecial end --------------------------
