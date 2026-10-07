            // KSkills.cpp: implementation of the KSkills class.
//
//////////////////////////////////////////////////////////////////////
#include "KCore.h"
// Phong Than 2026-10-03: some missile rows have speed 0 -> divide by zero (GameServer crash at
// KSkill::CastExtractiveLineMissle). Treat 0/negative speed as 1.
#define PT_SAFE_SPEED(s) ((s) > 0 ? (s) : 1)
#ifdef _STANDALONE
#include "KSG_StringProcess.h"
#else
#include "../../Engine/Src/KSG_StringProcess.h"
#endif
#include "KSkills.h"
#include "KPhongThanProfessionSkills.h"
#include "../../../Headers/PhongThanItemDisplay.h"
#include "KMissle.h"
#include "KMissleSet.h"
#include "KNpc.h"
#include "math.h"
#include "KNpcSet.h"
#include "KSubWorld.h"
#include "KMath.h"
#include "KEngine.h"
#include "KTabFile.h"
#include "KTabFileCtrl.h"
#include "KMissleMagicAttribsData.h"
#include "KPlayer.h"
#include "CoreShell.h"
#ifdef _SERVER
#include "LuaFuns.h"
#endif
#ifndef _SERVER
#include "../../Represent/iRepresent/iRepresentshell.h"
#include "scene/KScenePlaceC.h"
#include "../../Represent/iRepresent/KRepresentUnit.h"
#include "imgref.h"
#include "KMagicDesc.h"
#include "KOption.h"
#endif

#define	 NPCINDEXOFOBJECT 0 //�����ħ��ʱ����Ӧ��Npc���
const char * g_MagicID2String(int nAttrib);
extern  const KScript * g_GetScript(DWORD dwScriptId);
//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

/*!*****************************************************************************
// Function		: KSkill::KSkill
// Purpose		: 
// Return		: 
// Comments		:
// Author		: RomanDou
*****************************************************************************/
KSkill::KSkill()
{
	m_nFlySkillId =  m_nCollideSkillId = m_nVanishedSkillId = 0;
	
    // add by FreewayChen in 2003.6.6
    m_nImmediateAttribsNum = m_nStateAttribsNum = m_nMissleAttribsNum = m_nDamageAttribsNum = m_nAppendSkillNum =0;
	m_nSkillCostType = attrib_mana_v;
    m_nWaitTime = 0;
	m_nEquiptLimited = 0;
	m_nDoHurtP = 1;
	m_szMagicSkillDesc[0] = 0;
	m_nIsExpSkill = FALSE;
	m_bSkillReduceResist = FALSE;
	m_bSkillLifeReplenish = FALSE;
	memset(m_nAppendSkillId, 0, sizeof(m_nAppendSkillId));
#ifndef _SERVER
	m_szSkillDesc[0] = 0;
	m_szManPreCastSoundFile[0] = 0;
	m_szFMPreCastSoundFile[0] = 0;
#else
	m_dwSkillLevelUpScriptID = 0;
	m_dwSkillLevelDataScriptId = 0;
#endif
	
}
/*!*****************************************************************************
// Function		: KSkill::~KSkill
// Purpose		: 
// Return		: 
// Comments		:
// Author		: RomanDou
*****************************************************************************/
KSkill::~KSkill()
{
}

/*!*****************************************************************************
// Function		: KSkill::Param2PCoordinate
// Purpose		: 
// Return		: 
// Argumant		: int nLauncher
// Argumant		: int nParam1
// Argumant		: int nParam2
// Argumant		: int nParam3
// Argumant		: int *npPX
// Argumant		: int *npPY
// Comments		:
// Author		: RomanDou
*****************************************************************************/
inline int	KSkill::Param2PCoordinate(int nLauncher, int nParam1, int nParam2 , int *npPX, int *npPY, eSkillLauncherType eLauncherType)  const 
{
	
	int nRegionId, nDesMapX, nDesMapY ;
	int nTargetId = -1;
	if (eLauncherType == SKILL_SLT_Obj) return 0;
	
	switch(nParam1)
	{
	case -1://nParam2 ����ָ��ĳ��Npc����Obj��Index
		nTargetId		= nParam2;
		nRegionId		= Npc[nParam2].m_RegionIndex;
		nDesMapX		= Npc[nParam2].m_MapX;
		nDesMapY		= Npc[nParam2].m_MapY;
		
		if (eLauncherType == SKILL_SLT_Npc)
			SubWorld[Npc[nLauncher].m_SubWorldIndex].Map2Mps(nRegionId, nDesMapX , nDesMapY, Npc[nParam2].m_OffX , Npc[nParam2].m_OffY, npPX, npPY);
		else if(eLauncherType == SKILL_SLT_Obj)
			SubWorld[Object[nLauncher].m_nSubWorldID].Map2Mps(nRegionId, nDesMapX, nDesMapY, Object[nParam2].m_nOffX , Object[nParam2].m_nOffY, npPX, npPY);
		else;
		break;
		
	case -2://nParam ����ָ��ĳ������
		
		break;
	default://Ĭ��ʱ, nParam1 ��nParam2 Ϊʵ�ʵ�����
		*npPX = nParam1;
		*npPY = nParam2;
		break;
	}
	
	if (*npPX < 0 || *npPY < 0)	
		g_DebugLog("Param2PCoordinate error nParam1 ,nParam2 [%d,%d], nPX,nPY", nParam1, nParam2, *npPX, * npPY);
	
	return nTargetId;
}

int KSkill::CanCastSkill(int nLauncher, int &nParam1, int &nParam2)  const 
{
	//�����ѵ�������������
	ISkill * pSkill = Npc[nLauncher].GetActiveSkill();
	if(pSkill)
	{
		eSkillStyle eStyle = (eSkillStyle)pSkill->GetSkillStyle();
		if (eStyle == 4)
			goto relationisvalid;
	}
	if (m_bTargetSelf && (nParam1 != -1)) 
	{
		nParam1 = -1;
		nParam2 = nLauncher;
		goto relationisvalid;
	}
	else
	{
		if (m_bTargetOnly && (nParam1 != -1)) return 0;
		
		if (nParam1 == -1)
		{
			if ( nParam2 <= 0 || nParam2 >= MAX_NPC) return 0;
			NPC_RELATION  Relation = NpcSet.GetRelation(nLauncher, nParam2);
			
			if (m_bTargetEnemy)
			{
				if (Relation & relation_enemy) goto relationisvalid;
			}
			
			if (m_bTargetAlly)
			{
				if (Relation & relation_ally) goto relationisvalid;
			}
			
			if (m_bTargetSelf)
			{
				if (Relation & relation_self) goto relationisvalid;
			}
			return 0;
		}
		
	}
	
relationisvalid:

	if (Npc[nLauncher].IsPlayer())
	{
		//-2��ʾ���ܲ��ܵ�ǰװ��������,
		//-1��ʾ��������
		//0-99��ĳ�ֽ����������װ������ ȡֵΪ��װ���ľ�������
		//100-199��ĳ��Զ�̹������װ������ ȡֵΪ��װ���ľ������� ��100
		if (Npc[nLauncher].m_SilentState.nTime > 0)
		{
#ifndef _SERVER
			KSystemMessage	sMsg;
			sprintf(sMsg.szMessage, MSG_NPC_NOT_USE_SKILL_SILENT);
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
#endif
			return 0;
		}
		if (-2 != m_nEquiptLimited)
		{

#ifdef _SERVER
			int nPlayerIdx		= Npc[nLauncher].GetPlayerIdx();
#else
			int nPlayerIdx		= CLIENT_PLAYER_INDEX;
#endif
			int nDetailType		= Player[nPlayerIdx].m_ItemList.GetWeaponType();
			int nParticularType = Player[nPlayerIdx].m_ItemList.GetWeaponParticular();
			
			//��������
			if (nDetailType == 0)
			{
				
			}//Զ������
			else if (nDetailType == 1)
			{
				nParticularType += MAX_MELEEWEAPON_PARTICULARTYPE_NUM;
			}//����
			else if (nDetailType == -1)
			{
				nParticularType = -1;
			}
			if (nParticularType == HAND_PARTICULAR)
				nParticularType = -1;

			if (nParticularType == -1)
			{
			#ifndef _SERVER
				KSystemMessage sMsg;
				sprintf(sMsg.szMessage, "Khong The Dung Tay Khong!");
				sMsg.eType = SMT_NORMAL;
				sMsg.byConfirmType = SMCT_NONE;
				sMsg.byPriority = 0;
				sMsg.byParamSize = 0;
				CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
			#endif
				return 0;
			}

			if (nParticularType != m_nEquiptLimited)
			{
#ifndef _SERVER
			KSystemMessage	sMsg;
			sprintf(sMsg.szMessage, MSG_NPC_NOT_USE_SKILL_WEAPON);
			sMsg.eType = SMT_NORMAL;
			sMsg.byConfirmType = SMCT_NONE;
			sMsg.byPriority = 0;
			sMsg.byParamSize = 0;
			CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
#endif
			return 0;
			}
		}

		if (nParam1 == -1)
		{
			if ( nParam2 <= 0 || nParam2 >= MAX_NPC) return FALSE;
			if (Npc[nParam2].IsPlayer())
			{
				if (Npc[nLauncher].m_FightMode != Npc[nParam2].m_FightMode)
					return 0;
			}
		}		
		//0��ʾ������
		//1��ʾ�������������ü���
		//2��ʾ�����������ü���
		if (m_nHorseLimited)
		{
			switch(m_nHorseLimited)
			{
			case 1:
				{
					if (Npc[nLauncher].m_bRideHorse)
					{
#ifndef _SERVER
						KSystemMessage	sMsg;
						sprintf(sMsg.szMessage, MSG_NPC_NOT_USE_SKILL_HORSE1);
						sMsg.eType = SMT_NORMAL;
						sMsg.byConfirmType = SMCT_NONE;
						sMsg.byPriority = 0;
						sMsg.byParamSize = 0;
						CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
#endif
						return 0;
					}
				}
				break;
			case 2:
				{
					if (!Npc[nLauncher].m_bRideHorse)
					{
#ifndef _SERVER
						KSystemMessage	sMsg;
						sprintf(sMsg.szMessage, MSG_NPC_NOT_USE_SKILL_HORSE2);
						sMsg.eType = SMT_NORMAL;
						sMsg.byConfirmType = SMCT_NONE;
						sMsg.byPriority = 0;
						sMsg.byParamSize = 0;
						CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
#endif
						return 0;
					}
				}
				break;
			}
		}
		if(m_bTargetEnemy || m_bTargetAlly)
		{
			int distance = 0;
			if(nParam1 == -1)
			{
				distance = NpcSet.GetDistance(nLauncher, nParam2);
				if (distance > GetAttackRadius())
					return -1;
			}
			else
			{
				if(m_eMisslesForm == SKILL_MF_AtTarget/* || 
					m_eMisslesForm == SKILL_MF_AtFirer*/)
				{
					int nLauncherX, nLauncherY;
					Npc[nLauncher].GetMpsPos(&nLauncherX, &nLauncherY);
					distance = g_GetDistance(nLauncherX, nLauncherY, nParam1, nParam2);
					if (distance > GetAttackRadius())
					{
#ifndef _SERVER
						KSystemMessage	sMsg;
						sprintf(sMsg.szMessage, MSG_NPC_NOT_USE_SKILL_DISTANCE);
						sMsg.eType = SMT_NORMAL;
						sMsg.byConfirmType = SMCT_NONE;
						sMsg.byPriority = 0;
						sMsg.byParamSize = 0;
						CoreDataChanged(GDCNI_SYSTEM_MESSAGE, (unsigned int)&sMsg, 0);
#endif
						return 0;
					}
				}
			}
		}
	}
	return 1;
}

//		����ҵ���ĳ������ʱ���� [5/28/2002]
//		�ͻ��˺ͷ��������ڼ��ܵĵ��÷�����һЩ��ͬ
//		��������һ���յ��ľ����ͻ��˴�����Ĳ���
//		��Ϸ��������Ϣ�������ִ��ÿ���仯����˶��ڷ�����Ӧ��Ҳ��ͳһ���ݽӿ�
//		�ͻ���ʱ���������Ϣ�����Ա�����ҵ����룬����뽫��ת��Ϊʵ�ʵ���Ϣ
//		��ִ�С�ͬʱ��Ӧ��ת���õ���Ϣ������������
/*
�йش��Ĳ�����MapX������PointX���ݾ����ħ�����ܶ���
����һ�����ħ��ΪMap���꣬������ħ��ΪPoint����
*/
/*
ע�⵱����Castʱ��������ȷ����ǰ��nLauncherIndex��Socket���Ӧ��dwIdһ�£���IsMatch()ͨ����
*/

/*!*****************************************************************************
// Function		: KSkill::Cast
// Purpose		: �����ܵ�ͳһ�ӿ�
// Return		: 
// Argumant		: int nLauncher ������Id
// Argumant		: int nParam1   
// Argumant		: int nParam2
// Argumant		: int nWaitTime ���͵��ӳ�ʱ��
// Argumant		: eSkillLauncherType eLauncherType ����������
// Comments		:
// Author		: RomanDou
*****************************************************************************/
BOOL	KSkill::Cast(int nLauncher, int nParam1, int nParam2, int nWaitTime, eSkillLauncherType eLauncherType)  const 
{
	//-----------------�ӿں�����ڵ㣬�������Ϸ���-------------------------------
	if (nLauncher < 0 )
	{
		g_DebugLog("Skill::Cast(), nLauncher < 0 , Return False;"); 
		return FALSE; 
	}
	//��鷢�����Ƿ����Ҫ��
	switch(eLauncherType)
	{
	case SKILL_SLT_Npc:
		{
			if (MAX_NPC <= nLauncher) return FALSE;
			if (Npc[nLauncher].m_dwID < 0) return FALSE;
			if (nParam1 == -1)
			{
				if (nParam2 >= MAX_NPC) 
					return FALSE;
				
				if (
					(Npc[nParam2].m_Index <= 0)
					|| Npc[nLauncher].m_SubWorldIndex != Npc[nParam2].m_SubWorldIndex
					)
					return FALSE;
			}
		}
		break;
		
	case SKILL_SLT_Obj:
		{
			return FALSE;
			if (MAX_OBJECT <= nLauncher) return FALSE;
			if (Object[nLauncher].m_nDataID < 0) return FALSE;
		}
		break;
	case SKILL_SLT_Missle:
		{
			if (MAX_MISSLE <= nLauncher) 
				return FALSE;
			
			if (Missle[nLauncher].m_nMissleId < 0) 
				return FALSE;
			
			if (nParam1 == -1)
			{
				if (nParam2 >= MAX_NPC) 
					return FALSE;
				
				if ((Npc[nParam2].m_Index <= 0) ||  Missle[nLauncher].m_nSubWorldId != Npc[nParam2].m_SubWorldIndex)
					return FALSE;
			}

		}
		break;
	default:
		{
			return FALSE;
		}
	}

	
	
	if (nParam1 < 0 && nParam2 < 0 ) 
		return FALSE;
	
	if (nWaitTime < 0 ) 
	{
		g_DebugLog("Call Skill::Cast(), nWaitTime < 0 "); 
		nWaitTime = 0;
	}
	
	//------------------------------------------------------------------------------
	int nSkillId = Npc[nLauncher].m_ActiveSkillID;
	int i = Npc[nLauncher].m_SkillList.FindSame(nSkillId);
	int nSkillLevel = Npc[nLauncher].m_SkillList.m_Skills[i].SkillLevel;
	
	switch(m_eSkillStyle)
	{
		
	case	SKILL_SS_Missles:				//���ӵ�
	case	SKILL_SS_PhongThanAttack:
	case	SKILL_SS_PhongThanProduce:
		{
			CastMissles(nLauncher, nParam1, nParam2, nWaitTime, eLauncherType);
		}
		break;
		
	case	SKILL_SS_Melee:
		{

		}break;
		
	case	SKILL_SS_InitiativeNpcState:	//�ı��ɫ������״̬
	case	SKILL_SS_PhongThanAwaken:
		{
			CastInitiativeSkill(nLauncher, nParam1, nParam2, nWaitTime);
		}
		break;
		
	case	SKILL_SS_PassivityNpcState:	//�ı��ɫ�ı���״̬	
		{
			CastPassivitySkill(nLauncher, nParam1, nParam2, nWaitTime);
		}
		break;
		
	case SKILL_SS_CreateNpc:
		{
			
			if (Npc[nLauncher].m_nPetIdx > 0)
			{
				int nNpcPetIndex = Npc[nLauncher].m_nPetIdx;
				if (Npc[nNpcPetIndex].m_RegionIndex >= 0)
				{
					SubWorld[Npc[nNpcPetIndex].m_SubWorldIndex].m_Region[Npc[nNpcPetIndex].m_RegionIndex].RemoveNpc(nNpcPetIndex);
					SubWorld[Npc[nNpcPetIndex].m_SubWorldIndex].m_Region[Npc[nNpcPetIndex].m_RegionIndex].DecRef(Npc[nNpcPetIndex].m_MapX, Npc[nNpcPetIndex].m_MapY, obj_npc);
				}
				NpcSet.Remove(nNpcPetIndex);
			}

			// Phong Than 2026-10-04 pet10: the Di Nhan summons (450-461) are pets of level 1-10 (VNG skills MaxLevel 10)
			// with their OWN stats: npc level = learn level + 5 * (level - 1) instead of the owner's level, same table
			// as the Lenh Bai pet (script\phongthan\lib\petexp_lib.lua PTPE_Stats). Other templates: unchanged.
			int nPetReq = 0;
			switch (m_nAttrib)
			{
			case 359: nPetReq = 5; break;	case 360: nPetReq = 15; break;	case 361: nPetReq = 25; break;
			case 362: nPetReq = 35; break;	case 403: nPetReq = 45; break;	case 404: nPetReq = 55; break;
			case 405: nPetReq = 65; break;	case 406: nPetReq = 75; break;	case 407: nPetReq = 85; break;
			case 1345: nPetReq = 95; break;	case 1346: nPetReq = 105; break;	case 2032: nPetReq = 120; break;
			}
			int nPetLv = nSkillLevel < 1 ? 1 : (nSkillLevel > 10 ? 10 : nSkillLevel);
			int nPetSkillLv = nPetReq > 0 ? nPetLv : nSkillLevel;
			int nNpcLevel = nPetReq > 0 ? nPetReq + 5 * (nPetLv - 1) : Npc[nLauncher].m_Level;
			int	nNpcIdxInfo = MAKELONG(nNpcLevel, m_nAttrib);
			int nPosX = 0;
			int nPosY = 0;
			Npc[nLauncher].GetMpsPos(&nPosX, &nPosY);

			int nSubWorldIndex = Npc[nLauncher].m_SubWorldIndex;
			int nNpcIdx = NpcSet.Add(nNpcIdxInfo,nSubWorldIndex,nPosX+1,nPosY+1,FALSE);
			
			if (nNpcIdx > 0)
			{
				Npc[nNpcIdx].m_Kind = 0;
				Npc[nNpcIdx].m_AiMode = 11;
				strcpy(
					Npc[nNpcIdx].Owner,
					Npc[nLauncher].Name
				);
				
				char NameSkill[64];
				// Phong Than 2026-10-04 onepet: the pet carries its owner's name ("[level]Owner"); the template name
				// is GBK and showed garbled in the TCVN3 client.
				sprintf(NameSkill,"[%d]%s", nPetSkillLv, Npc[nLauncher].Name);
				g_StrCpyLen(Npc[nNpcIdx].Name, NameSkill, sizeof(Npc[nNpcIdx].Name));
				Npc[nLauncher].m_nPetIdx = nNpcIdx;
				Npc[nNpcIdx].m_nOwnerIdx = nLauncher;
#ifdef _SERVER
				// P0 schema reservation: task 254 stores the selected VNG summon-
				// beast appearance. Reapply it whenever the combat pet is recreated.
				int nOwnerPlayer = Npc[nLauncher].GetPlayerIdx();
				if (nOwnerPlayer > 0 && nOwnerPlayer < MAX_PLAYER)
				{
					int nMorphTemplate = Player[nOwnerPlayer].m_cTask.GetSaveVal(254);
					if (nMorphTemplate >= 2651 && nMorphTemplate <= 2656)
						Npc[nNpcIdx].m_NpcSettingIdx = nMorphTemplate;
					// Phong Than 2026-10-04 onepet: one pet at a time, the Lenh Bai Trieu Hoi pet (task 1941) goes.
					int nTokenPet = Player[nOwnerPlayer].m_cTask.GetSaveVal(1941);
					if (nTokenPet > 0 && nTokenPet < MAX_NPC && nTokenPet != nNpcIdx && Npc[nTokenPet].m_dwID &&
						Npc[nTokenPet].m_Kind != kind_player && Npc[nTokenPet].m_AiMode == 11 &&
						Npc[nTokenPet].m_nOwnerIdx == nLauncher)
					{
						if (Npc[nTokenPet].m_RegionIndex >= 0)
						{
							SubWorld[Npc[nTokenPet].m_SubWorldIndex].m_Region[Npc[nTokenPet].m_RegionIndex].RemoveNpc(nTokenPet);
							SubWorld[Npc[nTokenPet].m_SubWorldIndex].m_Region[Npc[nTokenPet].m_RegionIndex].DecRef(Npc[nTokenPet].m_MapX, Npc[nTokenPet].m_MapY, obj_npc);
						}
						NpcSet.Remove(nTokenPet);
					}
					if (nTokenPet)
					{
						Player[nOwnerPlayer].m_cTask.SetSaveVal(1941, 0, TRUE);
						Player[nOwnerPlayer].m_cTask.SetSaveVal(1942, 0, TRUE);
					}
				}
#endif
				if (nPetReq > 0)
				{
					// pet10: own stats = the template at nNpcLevel (NpcSet.Add above: Npcs.txt Param1 + Param2 * level),
					// life and base damage x (100 + 50 * (level - 1))% (VNG summonskill.txt scaleparam 512/1024, inferred).
					// No owner life/AR/defence/damage any more; movement speed follows the owner so the pet keeps up.
					int nPetScale = 100 + 50 * (nPetLv - 1);
					Npc[nNpcIdx].m_LifeMax = Npc[nNpcIdx].m_LifeMax * nPetScale / 100;
					Npc[nNpcIdx].m_CurrentLifeMax = Npc[nNpcIdx].m_LifeMax;
					Npc[nNpcIdx].m_CurrentLife = Npc[nNpcIdx].m_LifeMax;
					Npc[nNpcIdx].m_PhysicsDamage.nValue[0] = Npc[nNpcIdx].m_PhysicsDamage.nValue[0] * nPetScale / 100;
					Npc[nNpcIdx].m_PhysicsDamage.nValue[2] = Npc[nNpcIdx].m_PhysicsDamage.nValue[2] * nPetScale / 100;
					Npc[nNpcIdx].m_CurrentCamp = Npc[nLauncher].m_CurrentCamp;
					Npc[nNpcIdx].m_Series = Npc[nLauncher].m_Series;
					Npc[nNpcIdx].m_CurrentWalkSpeed = Npc[nLauncher].m_CurrentWalkSpeed;
					Npc[nNpcIdx].m_CurrentRunSpeed = Npc[nLauncher].m_CurrentRunSpeed;
				}
				else
				{
					Npc[nNpcIdx].m_CurrentLife = Npc[nNpcIdx].m_CurrentLifeMax + Npc[nLauncher].m_CurrentLifeMax ;
				Npc[nNpcIdx].m_CurrentLifeMax = Npc[nNpcIdx].m_CurrentLifeMax + Npc[nLauncher].m_CurrentLifeMax ;
					Npc[nNpcIdx].m_LifeMax = Npc[nNpcIdx].m_LifeMax + Npc[nLauncher].m_CurrentLifeMax ;
					Npc[nNpcIdx].m_CurrentCamp = Npc[nLauncher].m_CurrentCamp;
					Npc[nNpcIdx].m_Series = Npc[nLauncher].m_Series;
					Npc[nNpcIdx].m_CurrentAttackRating = Npc[nNpcIdx].m_CurrentAttackRating + Npc[nLauncher].m_CurrentAttackRating ;
					Npc[nNpcIdx].m_CurrentDefend = Npc[nNpcIdx].m_CurrentDefend + Npc[nLauncher].m_CurrentDefend ;
					Npc[nNpcIdx].m_CurrentWalkSpeed = Npc[nLauncher].m_CurrentWalkSpeed;
					Npc[nNpcIdx].m_CurrentRunSpeed = Npc[nLauncher].m_CurrentRunSpeed;
					Npc[nNpcIdx].m_CurrentAttackSpeed = Npc[nLauncher].m_CurrentAttackSpeed ;
					Npc[nNpcIdx].m_PhysicsDamage = Npc[nLauncher].m_PhysicsDamage;		// Npcĵǰ˺(˺ֱӼ˺ħ)
					Npc[nNpcIdx].m_CurrentFireDamage = Npc[nLauncher].m_CurrentFireDamage;	// Npcĵǰ˺
					Npc[nNpcIdx].m_CurrentColdDamage = Npc[nLauncher].m_CurrentColdDamage;	// Npcĵǰ˺
					Npc[nNpcIdx].m_CurrentLightDamage = Npc[nLauncher].m_CurrentLightDamage;	// Npcĵǰ˺
					Npc[nNpcIdx].m_CurrentEarthDamage = Npc[nLauncher].m_CurrentEarthDamage;	// Npcĵǰ˺
					//Npc[nNpcIdx].m_CurrentPoisonDamage = Npc[nLauncher].m_CurrentPoisonDamage;	// Npcĵǰ˺
				}
				// Phong Than 2026-10-02: the VNG slot-4 formula only fits templates >= 2152. For the Di Nhan summons
				// (359..2032) it gave a negative id and the pet never attacked; keep the template's own skill.
				int skillidpet = Npc[nNpcIdx].m_SkillList.m_Skills[4].SkillId;
				if (m_nAttrib == 2152)
					skillidpet = 1;
				else if (m_nAttrib > 2152)
					skillidpet = 1574 + m_nAttrib - 2152;
				if (skillidpet <= 0)
					skillidpet = 1;
				Npc[nNpcIdx].m_SkillList.m_Skills[4].SkillId = skillidpet;
				Npc[nNpcIdx].m_SkillList.m_Skills[4].SkillLevel = nPetSkillLv;
				Npc[nNpcIdx].m_SkillList.m_Skills[4].AddLevel = nPetSkillLv;
				Npc[nNpcIdx].m_SkillList.m_Skills[4].CurrentSkillLevel = nPetSkillLv;
				Npc[nNpcIdx].m_SkillList.m_Skills[4].SkillExp = 0;
				Npc[nNpcIdx].m_SkillList.m_Skills[4].NextSkillExp = 0;
				Npc[nNpcIdx].m_SkillList.m_Skills[4].TempSkill = FALSE;
				Npc[nNpcIdx].m_SkillList.m_Skills[4].MaxTimes = 0;
				Npc[nNpcIdx].m_SkillList.m_Skills[4].RemainTimes = 0;
				Npc[nNpcIdx].m_SkillList.m_Skills[4].NextCastTime = 0;
				Npc[nNpcIdx].m_SkillList.m_Skills[4].WaitCastTime = 0;
				// vancot:BEGIN pet10 follow-up 2026-10-04: KSkillList::FindSame / GetCurrentLevel / GetActiveSkill take
				// the FIRST slot holding an id. The summon templates (359..1346) carry their attack skill in slots 1-4,
				// so the pet cast at slot 1's level 1 although slot 4 had the pet level. Slots 1-3 with the same id now
				// get the slot-4 level too (template 2032 holds 85/86/87/88: only slot 4, as before).
				for (int nPtSlot = 1; nPtSlot < 4 && nPtSlot < MAX_NPCSKILL; nPtSlot++)
				{
					if (Npc[nNpcIdx].m_SkillList.m_Skills[nPtSlot].SkillId != skillidpet)
						continue;
					Npc[nNpcIdx].m_SkillList.m_Skills[nPtSlot].SkillLevel = nPetSkillLv;
					Npc[nNpcIdx].m_SkillList.m_Skills[nPtSlot].AddLevel = nPetSkillLv;
					Npc[nNpcIdx].m_SkillList.m_Skills[nPtSlot].CurrentSkillLevel = nPetSkillLv;
					Npc[nNpcIdx].m_SkillList.m_Skills[nPtSlot].NextCastTime = 0;
				}
				// vancot:END
				Npc[nNpcIdx].m_bNpcRemoveDeath = FALSE;
			}else{
				printf("Skill::Cast(), Add Missle Npc Failed!\n"); 
			}
		}
		break;
		
	case	SKILL_SS_BuildPoison:			//������
		{
			
		}
		break;
		
	case	SKILL_SS_AddPoison:			//�Ӷ���
		{
			
		}
		break;
		
	case	SKILL_SS_GetObjDirectly:		//����ȡ��	
		{
			
		}
		break;
		
	case	SKILL_SS_StrideObstacle:		//��Խ�ϰ�
		{
			
		}
		break;
		
	case	SKILL_SS_BodyToObject:		//ʬ��
		{
			
		}
		break;
		
	case	SKILL_SS_Mining:				//�ɿ�
		{
			
		}
		break;
		
	case	SKILL_SS_RepairWeapon:		//�޸���
		{
			
		}
		break;
		
	case	SKILL_SS_Capture:				//��׽�� 
		{
			
		}
		break;
	}
//		printf("m_bStartEvent %d %d %d\n", m_bStartEvent, m_nStartSkillId, m_nEventSkillLevel);
	if (m_bStartEvent && m_nStartSkillId > 0 && m_nEventSkillLevel > 0)
	{
		KSkill * pOrdinSkill = (KSkill *) g_SkillManager.GetSkill(m_nStartSkillId, m_nEventSkillLevel);
		if (!pOrdinSkill) 
            return FALSE;
        pOrdinSkill->Cast(nLauncher, nParam1, nParam2, nWaitTime, eLauncherType);
	}
	return TRUE;	  
}

/*!*****************************************************************************
// Function		: KSkill::Vanish
// Purpose		: �ӵ���������ʱ�ص�
// Return		: 
// Argumant		: KMissle* Missle
// Comments		:
// Author		: RomanDou
*****************************************************************************/
void	KSkill::Vanish(KMissle * pMissle)  const 
{
	OnMissleEvent(Missle_VanishEvent, pMissle);
}

BOOL KSkill::OnMissleEvent(unsigned short usEvent, KMissle * pMissle)  const 
{
	if (!pMissle) 
        return FALSE;

	int nLauncherIdx = pMissle->m_nLauncher;
	
    if (
		pMissle->m_nMissleId <= 0 
		|| pMissle->m_nMissleId >= MAX_MISSLE 
		|| nLauncherIdx <= 0
		|| nLauncherIdx >= MAX_NPC
		|| Npc[nLauncherIdx].m_Index <= 0
		)
        return FALSE;

	
	if (
		(!Npc[nLauncherIdx].IsMatch(pMissle->m_dwLauncherId)) 
		|| Npc[nLauncherIdx].m_SubWorldIndex != pMissle->m_nSubWorldId
		|| Npc[nLauncherIdx].m_RegionIndex < 0
		)
	{
		return FALSE;
	}
	
	int nEventSkillId = 0;
	int nEventSkillLevel = 0;
	switch(usEvent)
	{
	case Missle_FlyEvent:
		if (!m_bFlyingEvent || m_nFlySkillId <= 0 || m_nEventSkillLevel <= 0)
			return FALSE;
		nEventSkillId = m_nFlySkillId ;
		nEventSkillLevel = m_nEventSkillLevel;
		break;
		
	case Missle_StartEvent:
		if (!m_bStartEvent || m_nStartSkillId <= 0 || m_nEventSkillLevel <= 0)
			return FALSE;
		nEventSkillId = m_nStartSkillId ;
		nEventSkillLevel = m_nEventSkillLevel;
		break;
		
	case Missle_VanishEvent:
		if (!m_bVanishedEvent || m_nVanishedSkillId <= 0 || m_nEventSkillLevel <= 0)
			return FALSE;
		nEventSkillId = m_nVanishedSkillId ;
		nEventSkillLevel = m_nEventSkillLevel;
		break;
		
	case Missle_CollideEvent:
		if (!m_bCollideEvent || m_nCollideSkillId <= 0 || m_nEventSkillLevel <= 0)
			return FALSE;
		nEventSkillId = m_nCollideSkillId;
		nEventSkillLevel = m_nEventSkillLevel;
		break;
	default:
		return FALSE;
	}
		
	int nDesPX = 0, nDesPY = 0;
	
	if (m_bByMissle)
	{
		pMissle->GetMpsPos(&nDesPX, &nDesPY);
	}
	else
	{
		Npc[nLauncherIdx].GetMpsPos(&nDesPX, &nDesPY);
	}
	
	KSkill * pOrdinSkill = (KSkill *)g_SkillManager.GetSkill(nEventSkillId, nEventSkillLevel);
	if (!pOrdinSkill) 
        return FALSE;
	
	BOOL bRetCode = FALSE;
	
    if (m_bByMissle)    //When Event
	{
		if (pOrdinSkill->GetSkillStyle() == SKILL_SS_Missles)
		{
			bRetCode = pOrdinSkill->CastMissles(pMissle->m_nMissleId, nDesPX, nDesPY, 0, SKILL_SLT_Missle);
		}
	}
	else
	{
		if (pOrdinSkill->GetSkillStyle() == SKILL_SS_Missles)
		{   
            bRetCode = pOrdinSkill->CastMissles(nLauncherIdx, nDesPX, nDesPY, 0, SKILL_SLT_Npc);
		}
	}
	
	return bRetCode;
}

/*!*****************************************************************************
// Function		: KSkill::FlyEvent
// Purpose		: 
// Return		: void 
// Argumant		: int nMissleId
// Comments		:
// Author		: RomanDou
*****************************************************************************/
void KSkill::FlyEvent(KMissle * pMissle)  const 
{
	OnMissleEvent(Missle_FlyEvent, pMissle);
}

/*!*****************************************************************************
// Function		: KSkill::Collidsion
// Purpose		: �ӵ���ײʱ�ص�
// Return		: 
// Argumant		: KMissle* Missle
// Comments		:
// Author		: RomanDou
*****************************************************************************/
void	KSkill::Collidsion(KMissle * pMissle)  const 
{
	OnMissleEvent(Missle_CollideEvent, pMissle);
}

/*!*****************************************************************************
// Function		: KSkill::CastMissles
// Purpose		: �����ӵ�����
// Return		: 
// Argumant		: int nLauncher  ������id
// Argumant		: int nParam1
// Argumant		: int nParam2
// Argumant		: int nWaitTime  �ӳ�ʱ��
// Argumant		: eSkillLauncherType eLauncherType ����������
// Comments		:
// Author		: RomanDou
*****************************************************************************/
BOOL	KSkill::CastMissles(int nLauncher, int nParam1, int nParam2, int nWaitTime  , eSkillLauncherType eLauncherType )  const 
{
	int nRegionId		=	0;
	int	nDesMapX		=	0;//��ͼ����
	int nDesMapY		=	0;
	int nDesOffX		=	0;
	int nDesOffY		=	0;
	int nSrcOffX		=	0;
	int nSrcOffY		=	0;
	int nSrcPX			=	0;//������
	int nSrcPY			=	0;
	int nDesPX			=	0;
	int nDesPY			=	0;
	int nDistance		=	0;
	int nDir			=	0;
	int nDirIndex		=	0;
	int nTargetId		=	-1;
	int nRefPX			=	0;
	int nRefPY			=	0;
	TOrdinSkillParam	SkillParam ;
	SkillParam.eLauncherType = SKILL_SLT_Npc;
	SkillParam.nParent = 0;
	SkillParam.eParentType = (eSkillLauncherType)0;
	SkillParam.nWaitTime = nWaitTime;
	SkillParam.nTargetId = 0;
	if (nLauncher <= 0) return FALSE;
	if (eLauncherType == SKILL_SLT_Npc && nLauncher >= MAX_NPC) return FALSE;
	if (eLauncherType == SKILL_SLT_Missle && nLauncher >= MAX_MISSLE) return FALSE;
	if (m_bBaseSkill && (m_nChildSkillId <= 0 || m_nChildSkillId >= MAX_MISSLESTYLE))
		return FALSE;

	switch(m_eMisslesForm)
	{
	/*
	��ǽʱ����һ���ֲ�����ʾ�ӵ�֮��ĳ��ȼ��
	X2  = X1 + N * SinA
	Y2  = Y2 - N * CosA
	*/
		
	case	SKILL_MF_Wall:			//ǽ��	����ӵ��ʴ�ֱ�������У���ʽ��ǽ״
		{
			//ǽ��ħ��������ֻ������
			if (nParam1 == SKILL_SPT_Direction) return FALSE;
			
			switch(eLauncherType)
			{
			case SKILL_SLT_Npc:
				{	
					nTargetId		= Param2PCoordinate(nLauncher,nParam1, nParam2, &nDesPX, &nDesPY,  SKILL_SLT_Npc);
					
					if (Npc[nLauncher].m_SubWorldIndex < 0) 
					{
						return FALSE;
					}
					
					SubWorld[Npc[nLauncher].m_SubWorldIndex].Map2Mps(Npc[nLauncher].m_RegionIndex, Npc[nLauncher].m_MapX, Npc[nLauncher].m_MapY, Npc[nLauncher].m_OffX, Npc[nLauncher].m_OffY, &nSrcPX, &nSrcPY);
					
					nDirIndex		= g_GetDirIndex(nSrcPX, nSrcPY, nDesPX, nDesPY);
					nDir			= g_DirIndex2Dir(nDirIndex, MaxMissleDir);
					nDir = nDir + MaxMissleDir / 4;
					if (nDir >= MaxMissleDir) nDir -= MaxMissleDir;
					SkillParam.nLauncher = nLauncher;
					SkillParam.eLauncherType = eLauncherType;
					SkillParam.nTargetId = nTargetId;
					if (m_nValue1 == 0 || m_nValue2 == 0)
						CastWall(&SkillParam, nDir, nDesPX, nDesPY);
					else
						CastWall(&SkillParam , nDir, nSrcPX, nSrcPY);
					
				}	break;
			case SKILL_SLT_Obj:
				{
				}break;
			case SKILL_SLT_Missle:
				{
					KMissle * pMissle = &Missle[nLauncher];
					if (!Npc[pMissle->m_nLauncher].IsMatch(pMissle->m_dwLauncherId)) return FALSE;
					
					SubWorld[Missle[nLauncher].m_nSubWorldId].Map2Mps(pMissle->m_nRegionId, pMissle->m_nCurrentMapX, pMissle->m_nCurrentMapY , pMissle->m_nXOffset, pMissle->m_nYOffset, &nRefPX, &nRefPY);
					int nDir = pMissle->m_nDir + MaxMissleDir / 4;
					if (nDir >= MaxMissleDir) nDir -= MaxMissleDir;
					SkillParam.nLauncher = pMissle->m_nLauncher;
					SkillParam.nParent = nLauncher;
					SkillParam.nParent = SKILL_SLT_Missle;
					SkillParam.nTargetId = pMissle->m_nFollowNpcIdx;
					CastWall(&SkillParam,  nDir, nRefPX, nRefPY);
				}break;
			}
		}break;
		
		
	case	SKILL_MF_Line:				//����	����ӵ���ƽ������ҷ�������
		{
			g_DebugLog("Skill::CastMissles(), SKILL_MF_Line nParam1 %d, eLauncherType %d", nParam1,eLauncherType);
			if (nParam1 == SKILL_SPT_Direction)
			{
				switch(eLauncherType)
				{
				case SKILL_SLT_Npc:
					{
						SubWorld[Npc[nLauncher].m_SubWorldIndex].Map2Mps(Npc[nLauncher].m_RegionIndex, Npc[nLauncher].m_MapX, Npc[nLauncher].m_MapY, Npc[nLauncher].m_OffX, Npc[nLauncher].m_OffY, &nSrcPX, &nSrcPY);
						if (nParam2 > MaxMissleDir || nParam2 < 0) return FALSE;
						nDir = nParam2;
						SkillParam.nLauncher = nLauncher;
						SkillParam.eLauncherType = eLauncherType;
						SkillParam.nTargetId = nTargetId;
						CastLine(&SkillParam, nDir, nSrcPX,nSrcPY);
						
					}break;
				case SKILL_SLT_Obj:
					{
						
					}break;
				case SKILL_SLT_Missle:
					{
						KMissle * pMissle = &Missle[nLauncher];
						if (nParam2 > MaxMissleDir || nParam2 < 0) return FALSE;
						if (!Npc[pMissle->m_nLauncher].IsMatch(pMissle->m_dwLauncherId)) return FALSE;
						nDir = nParam2;
						SubWorld[pMissle->m_nSubWorldId].Map2Mps(pMissle->m_nRegionId, pMissle->m_nCurrentMapX, pMissle->m_nCurrentMapY , pMissle->m_nXOffset, pMissle->m_nYOffset, &nRefPX, &nRefPY);
						SkillParam.nLauncher = pMissle->m_nLauncher;
						SkillParam.nParent = nLauncher;
						SkillParam.nTargetId = pMissle->m_nFollowNpcIdx;
						CastLine(&SkillParam, nDir,  nRefPX, nRefPY);
					}break;
				}
				
			}
			else
			{
				switch(eLauncherType)
				{
				case SKILL_SLT_Npc:
					{
						nTargetId		= Param2PCoordinate(nLauncher,nParam1, nParam2, &nDesPX, &nDesPY,  SKILL_SLT_Npc);
						SubWorld[Npc[nLauncher].m_SubWorldIndex].Map2Mps(Npc[nLauncher].m_RegionIndex, Npc[nLauncher].m_MapX, Npc[nLauncher].m_MapY, Npc[nLauncher].m_OffX, Npc[nLauncher].m_OffY, &nSrcPX, &nSrcPY);
						nDirIndex		= g_GetDirIndex(nSrcPX, nSrcPY, nDesPX, nDesPY);
						nDir			= g_DirIndex2Dir(nDirIndex, MaxMissleDir);
						SkillParam.nLauncher = nLauncher;
						SkillParam.eLauncherType = eLauncherType;
						SkillParam.nTargetId = nTargetId;
						// vancot:BEGIN Phong Than 2026-10-04 vancot (skillself extension): besides TargetOnly skills, an attack
						// skill that may only hit enemies (TargetEnemy, no Ally/Self), has no missile event and a real attack
						// radius (<= 600) also gets its Stand missile born on the enemy NPC it was cast at. In the VNG data that
						// is exactly Van Cot Toan Kho 51 / 921 (missile 20, range damage +-7 cells, thunder on the target);
						// the heal/buff skills (Ally/Self), npc Bo Tam Chu Phap 415/852 (StartEvent 416) and Hong Sa Tien 810
						// (AttackRadius 9999) keep the caster. Client and server run this same code.
						BOOL bPtStandAtTarget = m_bBaseSkill && nTargetId > 0 && nTargetId < MAX_NPC && nTargetId != nLauncher &&
							g_MisslesLib[m_nChildSkillId].m_eMoveKind == MISSLE_MMK_Stand &&
							(m_bTargetOnly ||
							(m_bTargetEnemy && !m_bTargetAlly && !m_bTargetSelf && !m_bStartEvent && !m_bFlyingEvent &&
							!m_bCollideEvent && !m_bVanishedEvent && m_nAttackRadius > 0 && m_nAttackRadius <= 600 &&
							(NpcSet.GetRelation(nLauncher, nTargetId) & relation_enemy)));
						// vancot:END
						// botheal:BEGIN Phong Than 2026-10-04 botheal (C2): a heal / ally skill cast AT another NPC (Line form, Stand
						// child missile, TargetAlly, not TargetEnemy, no missile event, attack radius <= 600: Bo Tam Chu 45 / 106 /
						// 1120-1126, npc Tu Hang Chu 110, Tri lieu / Kich hoat dong loat 197 / 198, 416 / 853, Kho Moc Phung Xuan
						// 1508 / 1509) had its missile born on the caster like every Line skill. VNG Bo Tam Chu = missile 5 (Stand,
						// DmgRange 12 = +-6 cells, LifeTime 13 < DmgInterval 14: one pass) hitting every ally | self NPC around it:
						// cast on a party member up to 200 away it healed the caster only. Cast at an ally the missile is now born
						// on that ally (the caster is still inside the area when he stands near). A self cast / ground click
						// (TargetSelf turns it into the launcher) keeps the VNG area around the caster. Client and server alike.
						BOOL bPtHealAtTarget = m_bBaseSkill && nTargetId > 0 && nTargetId < MAX_NPC && nTargetId != nLauncher &&
							g_MisslesLib[m_nChildSkillId].m_eMoveKind == MISSLE_MMK_Stand &&
							m_bTargetAlly && !m_bTargetEnemy && !m_bStartEvent && !m_bFlyingEvent && !m_bCollideEvent &&
							!m_bVanishedEvent && m_nAttackRadius > 0 && m_nAttackRadius <= 600 &&
							!(NpcSet.GetRelation(nLauncher, nTargetId) & relation_enemy);	// CanCastSkill already refuses one
						// botheal:END
						if (m_nChildSkillNum == 1 && (g_MisslesLib[m_nChildSkillId].m_eMoveKind == MISSLE_MMK_Line || g_MisslesLib[m_nChildSkillId].m_eMoveKind == MISSLE_MMK_Parabola) ) 
						{
							if (nSrcPX == nDesPX && nSrcPY == nDesPY)		return FALSE ;
							nDistance = g_GetDistance(nSrcPX, nSrcPY, nDesPX, nDesPY);
							
							if (nDistance == 0 ) return FALSE;
							int		nYLength = nDesPY - nSrcPY;
							int		nXLength = nDesPX - nSrcPX;
							int		nSin = (nYLength << 10) / nDistance;	// �Ŵ�1024��
							int		nCos = (nXLength << 10) / nDistance;
							
							if (abs(nSin) > 1024) 
								return FALSE;

							if (abs(nCos) > 1024) 
								return FALSE;
							
							
							CastExtractiveLineMissle(&SkillParam, nDir, nSrcPX, nSrcPY, nCos, nSin, nDesPX, nDesPY);
						}
						// Phong Than 2026-10-04 skillself: VNG Line skills whose missile stands still (Chuong Tam Loi 3/65 ->
						// missile 17, Tich Lich Hoa 6/68 -> 57, Luu Tinh Thach 4/66 -> 44, Bang Tuyet Dan 5/67 -> 9, basic
						// attacks 1/2/63/64 -> 64/65 ...; MoveKind Stand, Param1 0) were born on the caster: the spell showed on
						// the player and CheckNearestCollision (+-1 cell) never reached a monster 300 away. A Stand missile
						// cast at another NPC is now born on that NPC (Param1 spacing still applies from there). TargetOnly only:
						// the heal/buff child skills (Bo Tam Chu 45, Tri lieu dong loat 197 ..., TargetOnly 0) keep the caster.
						else if (bPtStandAtTarget || bPtHealAtTarget)	// skillself: TargetOnly; vancot: enemy-only attack skills; botheal: heal cast at an ally
							CastLine(&SkillParam, nDir, nDesPX, nDesPY);
						else
							CastLine(&SkillParam, nDir, nSrcPX,nSrcPY);
					}break;
				case SKILL_SLT_Obj:
					{
					}break;
				case SKILL_SLT_Missle:
					{
						KMissle * pMissle = &Missle[nLauncher];
						if (!Npc[pMissle->m_nLauncher].IsMatch(pMissle->m_dwLauncherId)) return FALSE;
						SubWorld[pMissle->m_nSubWorldId].Map2Mps(pMissle->m_nRegionId, pMissle->m_nCurrentMapX, pMissle->m_nCurrentMapY , pMissle->m_nXOffset, pMissle->m_nYOffset, &nRefPX, &nRefPY);
						SkillParam.nLauncher = pMissle->m_nLauncher;
						SkillParam.nParent = nLauncher;
						SkillParam.eParentType = eLauncherType;
						SkillParam.nTargetId = pMissle->m_nFollowNpcIdx;
						CastLine(&SkillParam,  pMissle->m_nDir,  nRefPX, nRefPY);
					}break;
				}
			}
		}
		break;
		
		//  ���ֲ���һ��ʾ�ӵ�֮��ĽǶȲ��64����Ϊ׼
		//  ������X/Y����Ϊ��������
		
	case	SKILL_MF_Spread:				//ɢ��	����ӵ���һ���ĽǶȵķ�ɢ״	
		{
			if (nParam1 == SKILL_SPT_Direction)
			{
				switch(eLauncherType)
				{
				case SKILL_SLT_Npc:
					{
						SubWorld[Npc[nLauncher].m_SubWorldIndex].Map2Mps(Npc[nLauncher].m_RegionIndex, Npc[nLauncher].m_MapX, Npc[nLauncher].m_MapY, Npc[nLauncher].m_OffX, Npc[nLauncher].m_OffY, &nSrcPX, &nSrcPY);
						if (nParam2 > MaxMissleDir || nParam2 < 0) return FALSE;
						nDir = nParam2;
						SkillParam.nLauncher = nLauncher;
						SkillParam.eLauncherType = eLauncherType;
						CastSpread(&SkillParam, nDir, nSrcPX,nSrcPY);
					}break;
				case SKILL_SLT_Obj:
					{
						
					}break;
				case SKILL_SLT_Missle:
					{
						KMissle * pMissle = &Missle[nLauncher];
						if (nParam2 > MaxMissleDir || nParam2 < 0) return FALSE;
						if (!Npc[pMissle->m_nLauncher].IsMatch(pMissle->m_dwLauncherId)) return FALSE;
						nDir = nParam2;
						SubWorld[pMissle->m_nSubWorldId].Map2Mps(pMissle->m_nRegionId, pMissle->m_nCurrentMapX, pMissle->m_nCurrentMapY , pMissle->m_nXOffset, pMissle->m_nYOffset, &nRefPX, &nRefPY);
						SkillParam.nLauncher = pMissle->m_nLauncher;
						SkillParam.nParent = nLauncher;
						SkillParam.eParentType = eLauncherType;
						SkillParam.nTargetId = pMissle->m_nFollowNpcIdx;

						CastSpread(&SkillParam, nDir,  nRefPX, nRefPY);

					}break;
				}
			}
			else
			{
				switch(eLauncherType)
				{
				case SKILL_SLT_Npc:
					{
						nTargetId		= Param2PCoordinate(nLauncher,nParam1, nParam2, &nDesPX, &nDesPY, SKILL_SLT_Npc);		
						SubWorld[Npc[nLauncher].m_SubWorldIndex].Map2Mps(Npc[nLauncher].m_RegionIndex, Npc[nLauncher].m_MapX, Npc[nLauncher].m_MapY, Npc[nLauncher].m_OffX, Npc[nLauncher].m_OffY, &nSrcPX, &nSrcPY);
						nDirIndex		= g_GetDirIndex(nSrcPX, nSrcPY, nDesPX, nDesPY);
						nDir			= g_DirIndex2Dir(nDirIndex, MaxMissleDir);
						SkillParam.nLauncher = nLauncher;
						SkillParam.eLauncherType = eLauncherType;
						SkillParam.nTargetId = nTargetId;
						
						if (m_nChildSkillNum == 1 && (g_MisslesLib[m_nChildSkillId].m_eMoveKind == MISSLE_MMK_Line) ) 
						{
							if (nSrcPX == nDesPX && nSrcPY == nDesPY)		return FALSE ;
							nDistance = g_GetDistance(nSrcPX, nSrcPY, nDesPX, nDesPY);
							
							if (nDistance == 0 ) return FALSE;
							int		nYLength = nDesPY - nSrcPY;
							int		nXLength = nDesPX - nSrcPX;
							int		nSin = (nYLength << 10) / nDistance;	// �Ŵ�1024��
							int		nCos = (nXLength << 10) / nDistance;

							if (abs(nSin) > 1024) 
								return FALSE;
							
							if (abs(nCos) > 1024) 
								return FALSE;

							CastExtractiveLineMissle(&SkillParam, nDir, nSrcPX, nSrcPY, nCos, nSin, nDesPX, nDesPY);
						}
						else
							CastSpread(&SkillParam, nDir, nSrcPX, nSrcPY);
					}break;
				case SKILL_SLT_Obj:
					{
						
					}break;
				case SKILL_SLT_Missle:
					{
						KMissle * pMissle = &Missle[nLauncher];
						if (!Npc[pMissle->m_nLauncher].IsMatch(pMissle->m_dwLauncherId)) return FALSE;
						SubWorld[pMissle->m_nSubWorldId].Map2Mps(pMissle->m_nRegionId, pMissle->m_nCurrentMapX, pMissle->m_nCurrentMapY , pMissle->m_nXOffset, pMissle->m_nYOffset, &nRefPX, &nRefPY);
						SkillParam.nLauncher = pMissle->m_nLauncher;
						SkillParam.nParent = nLauncher;
						SkillParam.eParentType = eLauncherType;
						SkillParam.nTargetId = pMissle->m_nFollowNpcIdx;
						CastSpread(&SkillParam ,pMissle->m_nDir,  nRefPX, nRefPY);
					}break;
				}
			}
			
		}break;
		
		
		//�Ե�ǰ��ΪԲ��������Χ�ŵ��ӵ�
		//�ֳ����������һ��Ϊ��ԭ��Ϊԭ�ķ�������һ��Ϊ��Ŀ���Ϊԭ�ķ���
		// ���ֲ���һ��ʾ �Ƿ�Ϊԭ�ط���
		
	case	SKILL_MF_Circle:				//Բ��	����ӵ�Χ��һ��Ȧ
		{
			
			if (nParam1 == SKILL_SPT_Direction) return FALSE;
			
			switch(eLauncherType)
			{
			case SKILL_SLT_Npc:
				{
					nTargetId		= Param2PCoordinate(nLauncher,nParam1, nParam2,  &nDesPX, &nDesPY, eLauncherType);
					SubWorld[Npc[nLauncher].m_SubWorldIndex].Map2Mps(Npc[nLauncher].m_RegionIndex, Npc[nLauncher].m_MapX, Npc[nLauncher].m_MapY, Npc[nLauncher].m_OffX, Npc[nLauncher].m_OffY, &nSrcPX, &nSrcPY);
					nDirIndex		= g_GetDirIndex(nSrcPX, nSrcPY, nDesPX, nDesPY);
					nDir			= g_DirIndex2Dir(nDirIndex, MaxMissleDir);
					SkillParam.nLauncher = nLauncher;
					SkillParam.eLauncherType = eLauncherType;
					SkillParam.nTargetId = nTargetId;
					
					if (m_nValue1 == 0)
						CastCircle(&SkillParam, nDir, nSrcPX, nSrcPY);
					else
						CastCircle(&SkillParam, nDir, nDesPX, nDesPY);
				}break;
			case SKILL_SLT_Obj:
				{
					
				}break;
			case SKILL_SLT_Missle:
				{
					KMissle * pMissle = &Missle[nLauncher];
					if (!Npc[pMissle->m_nLauncher].IsMatch(pMissle->m_dwLauncherId)) return FALSE;
					SubWorld[pMissle->m_nSubWorldId].Map2Mps(pMissle->m_nRegionId, pMissle->m_nCurrentMapX, pMissle->m_nCurrentMapY , pMissle->m_nXOffset, pMissle->m_nYOffset, &nRefPX, &nRefPY);
					SkillParam.nLauncher = pMissle->m_nLauncher;
					SkillParam.nParent = nLauncher;
					SkillParam.eParentType = eLauncherType;
					SkillParam.nTargetId = pMissle->m_nFollowNpcIdx;
					CastCircle(&SkillParam, pMissle->m_nDir,  nRefPX, nRefPY);
				}break;
			}
			
		}break;
		
	case	SKILL_MF_Random:				//���	����ӵ�����ŷ�
		{
			switch(eLauncherType)
			{
			case SKILL_SLT_Npc:
				{
					
				}break;
			case SKILL_SLT_Obj:
				{
					
				}break;
			case SKILL_SLT_Missle:
				{
					
				}break;
			}
		}
		break;
		
	case	SKILL_MF_AtTarget:				//����	����ӵ�����
		{
			if (nParam1 == SKILL_SPT_Direction) return FALSE;	
			
			switch(eLauncherType)
			{
			case SKILL_SLT_Npc:
				{
					nTargetId		= Param2PCoordinate(nLauncher,nParam1, nParam2, &nDesPX, &nDesPY);
					nDirIndex		= g_GetDirIndex(nSrcPX, nSrcPY, nDesPX, nDesPY);
					nDir			= g_DirIndex2Dir(nDirIndex, MaxMissleDir);
					SkillParam.nLauncher = nLauncher;
					SkillParam.eLauncherType = eLauncherType;
					SkillParam.nTargetId = nTargetId;
					CastZone(&SkillParam, nDir, nDesPX, nDesPY);
				}break;
			case SKILL_SLT_Obj:
				{
					
				}break;
			case SKILL_SLT_Missle:
				{
					KMissle * pMissle = &Missle[nLauncher];
					if (!Npc[pMissle->m_nLauncher].IsMatch(pMissle->m_dwLauncherId)) return FALSE;
					SubWorld[pMissle->m_nSubWorldId].Map2Mps(pMissle->m_nRegionId, pMissle->m_nCurrentMapX, pMissle->m_nCurrentMapY , pMissle->m_nXOffset, pMissle->m_nYOffset, &nRefPX, &nRefPY);
					SkillParam.nLauncher = pMissle->m_nLauncher;
					SkillParam.nParent = nLauncher;
					SkillParam.eParentType = eLauncherType;
					SkillParam.nTargetId = pMissle->m_nFollowNpcIdx;
					CastZone(&SkillParam, pMissle->m_nDir, nRefPX, nRefPY);
				}break;
			}
		}break;
		
	case	SKILL_MF_AtFirer:				//����	����ӵ�ͣ����ҵ�ǰλ��
		{
			if (nParam1 == SKILL_SPT_Direction) return FALSE;
			switch(eLauncherType)
			{
			case SKILL_SLT_Npc:
				{
					SubWorld[Npc[nLauncher].m_SubWorldIndex].Map2Mps(Npc[nLauncher].m_RegionIndex, Npc[nLauncher].m_MapX, Npc[nLauncher].m_MapY, Npc[nLauncher].m_OffX, Npc[nLauncher].m_OffY, &nSrcPX, &nSrcPY);
					nDirIndex		= g_GetDirIndex(nSrcPX, nSrcPY, nDesPX, nDesPY);
					nDir			= g_DirIndex2Dir(nDirIndex, MaxMissleDir);
					SkillParam.nLauncher = nLauncher;
					SkillParam.eLauncherType = eLauncherType;
					SkillParam.nTargetId = nTargetId;
					CastZone(&SkillParam,  nDir, nSrcPX, nSrcPY);
				}break;
			case SKILL_SLT_Obj:
				{
					
				}break;
			case SKILL_SLT_Missle:
				{
					KMissle * pMissle = &Missle[nLauncher];
					if (!Npc[pMissle->m_nLauncher].IsMatch(pMissle->m_dwLauncherId)) return FALSE;
					SubWorld[pMissle->m_nSubWorldId].Map2Mps(pMissle->m_nRegionId, pMissle->m_nCurrentMapX, pMissle->m_nCurrentMapY , pMissle->m_nXOffset, pMissle->m_nYOffset, &nRefPX, &nRefPY);
					SkillParam.nLauncher = pMissle->m_nLauncher;
					SkillParam.nParent = nLauncher;
					SkillParam.eParentType = eLauncherType;
					SkillParam.nTargetId = pMissle->m_nFollowNpcIdx;
					CastZone(&SkillParam , pMissle->m_nDir, nRefPX, nRefPY);
				}break;
			}
			
		}break;
		
	case	SKILL_MF_Zone:
		{
			if (nParam1 == SKILL_SPT_Direction) return FALSE;
			
			switch(eLauncherType)
			{
			case SKILL_SLT_Npc:
				{
					nTargetId		= Param2PCoordinate(nLauncher,nParam1, nParam2,  &nDesPX, &nDesPY);
					SubWorld[Npc[nLauncher].m_SubWorldIndex].Map2Mps(Npc[nLauncher].m_RegionIndex, Npc[nLauncher].m_MapX, Npc[nLauncher].m_MapY, Npc[nLauncher].m_OffX, Npc[nLauncher].m_OffY, &nSrcPX, &nSrcPY);
					nDirIndex		= g_GetDirIndex(nSrcPX, nSrcPY, nDesPX, nDesPY);
					nDir			= g_DirIndex2Dir(nDirIndex, MaxMissleDir);
					SkillParam.nLauncher = nLauncher;
					SkillParam.eLauncherType = eLauncherType;
					SkillParam.nTargetId = nTargetId;
					CastZone(&SkillParam, nDir, nSrcPX, nSrcPY);
				}break;
			case SKILL_SLT_Obj:
				{
					
				}break;
			case SKILL_SLT_Missle:
				{
					KMissle * pMissle = &Missle[nLauncher];
					if (!Npc[pMissle->m_nLauncher].IsMatch(pMissle->m_dwLauncherId)) return FALSE;
					SubWorld[pMissle->m_nSubWorldId].Map2Mps(pMissle->m_nRegionId, pMissle->m_nCurrentMapX, pMissle->m_nCurrentMapY , pMissle->m_nXOffset, pMissle->m_nYOffset, &nRefPX, &nRefPY);
					SkillParam.nLauncher = pMissle->m_nLauncher;
					SkillParam.nParent = nLauncher;
					SkillParam.eParentType = eLauncherType;
					SkillParam.nTargetId = pMissle->m_nFollowNpcIdx;
					CastZone(&SkillParam, pMissle->m_nDir, nRefPX, nRefPY);
				}break;
			}
		}break;
	}
	return TRUE;
}

/*!*****************************************************************************
// Function		: KSkill::CastZone
// Purpose		: 
// Return		: int 
// Argumant		: int nLauncher
// Argumant		: eSkillLauncherType eLauncherType
// Argumant		: int nDir
// Argumant		: int nRefPX
// Argumant		: int nRefPY
// Argumant		: int nWaitTime
// Argumant		: int nTargetId
// Comments		:
// Author		: RomanDou
*****************************************************************************/
//nValue1 = 0 ��ʾ��������  nValue1 = 1 ��ʾԲ������
//nValue2 = 0 
int KSkill::CastZone(TOrdinSkillParam * pSkillParam , int nDir, int nRefPX, int nRefPY)  const 
{
	int nLauncher = pSkillParam->nLauncher;
	eSkillLauncherType eLauncherType = pSkillParam->eLauncherType;
	
	if (eLauncherType != SKILL_SLT_Npc) return 0;
	int nCastMissleNum	= 0;
	int nBeginPX ;
	int nBeginPY ;
	if (m_nChildSkillNum == 1)
	{
		nBeginPX = nRefPX;
		nBeginPY = nRefPY;
	}
	else 
	{
		nBeginPX		= nRefPX - m_nChildSkillNum * SubWorld[Npc[nLauncher].m_SubWorldIndex].m_nCellWidth / 2;
		nBeginPY		= nRefPY - m_nChildSkillNum * SubWorld[Npc[nLauncher].m_SubWorldIndex].m_nCellHeight / 2;
	}
	
#ifdef _SERVER
	KMissleMagicAttribsData * pNewMagicAttribsData = CreateMissleMagicAttribsData(nLauncher);
#endif //_SERVER
	
	for (int i = 0; i < m_nChildSkillNum; i ++)
		for (int j = 0; j < m_nChildSkillNum; j ++)
		{
			if (m_bBaseSkill)
			{
				int nMissleIndex ;
				int nSubWorldId ; 
				
				nSubWorldId = Npc[nLauncher].m_SubWorldIndex;
				
				if (m_nValue1 == 1)
					if ( ((i - m_nChildSkillNum / 2) * (i - m_nChildSkillNum / 2) + (j - m_nChildSkillNum / 2) * (j - m_nChildSkillNum / 2)) > (m_nChildSkillNum * m_nChildSkillNum / 4))			continue;
					
					
					if (nSubWorldId < 0)	goto exit;
					int nDesSubX = nBeginPX + j * SubWorld[nSubWorldId].m_nCellWidth;
					int nDesSubY = nBeginPY +  i * SubWorld[nSubWorldId].m_nCellHeight;
					nMissleIndex = MissleSet.Add(nSubWorldId, nDesSubX , nDesSubY);
					
					if (nMissleIndex < 0)	continue;
					
					Missle[nMissleIndex].m_nDir				= nDir;
					Missle[nMissleIndex].m_nDirIndex		= g_Dir2DirIndex(nDir, MaxMissleDir);
					CreateMissle(nLauncher, m_nChildSkillId, nMissleIndex);
					Missle[nMissleIndex].m_nFollowNpcIdx	= pSkillParam->nTargetId;
					if (pSkillParam->nTargetId)
						Missle[nMissleIndex].m_dwFollowNpcID	= Npc[pSkillParam->nTargetId].m_dwID;
					Missle[nMissleIndex].m_dwBornTime		= SubWorld[nSubWorldId].m_dwCurrentTime;
					Missle[nMissleIndex].m_nSubWorldId		= nSubWorldId;
					Missle[nMissleIndex].m_nLauncher		= nLauncher;
					Missle[nMissleIndex].m_dwLauncherId		= Npc[nLauncher].m_dwID;
					Missle[nMissleIndex].m_nPKFlag			= Npc[nLauncher].m_nPKFlag;
					Missle[nMissleIndex].m_nMissleSeries	= -1;
					KSkill * pSkill =(KSkill*) Npc[nLauncher].GetActiveSkill();
					if(pSkill)
						Missle[nMissleIndex].m_nMissleSeries	= pSkill->GetSkillSeries();
					
					if (pSkillParam->nParent)
						Missle[nMissleIndex].m_nParentMissleIndex = pSkillParam->nParent;
					else 
						Missle[nMissleIndex].m_nParentMissleIndex = 0;
					
					Missle[nMissleIndex].m_nSkillId			= m_nId;
					Missle[nMissleIndex].m_nStartLifeTime	= pSkillParam->nWaitTime + GetMissleGenerateTime(i * m_nChildSkillNum + j);
					Missle[nMissleIndex].m_nLifeTime		+= Missle[nMissleIndex].m_nStartLifeTime;
					Missle[nMissleIndex].m_nRefPX			= nDesSubX;
					Missle[nMissleIndex].m_nRefPY			= nDesSubY;
					
					if (Missle[nMissleIndex].m_eMoveKind == MISSLE_MMK_Line|| Missle[nMissleIndex].m_eMoveKind == MISSLE_MMK_RollBack || Missle[nMissleIndex].m_eMoveKind == MISSLE_MMK_Follow)
					{
						Missle[nMissleIndex].m_nXFactor = g_DirCos(nDir, MaxMissleDir);
						Missle[nMissleIndex].m_nYFactor = g_DirSin(nDir, MaxMissleDir);
					}
#ifdef _SERVER
					Missle[nMissleIndex].SetMagicAttribsData(pNewMagicAttribsData);
#endif //_SERVER
					nCastMissleNum ++;
			}
			else
			{
				_ASSERT(m_nChildSkillId > 0 && m_nChildSkillLevel > 0)	;
				KSkill * pOrdinSkill = (KSkill *) g_SkillManager.GetSkill(m_nChildSkillId, m_nChildSkillLevel);
				if (pOrdinSkill) 
				{
					if (!pSkillParam->nParent)
						nCastMissleNum += pOrdinSkill->Cast(nLauncher, nBeginPX + j * SubWorld[Npc[nLauncher].m_SubWorldIndex].m_nCellWidth , nBeginPY +  i * SubWorld[Npc[nLauncher].m_SubWorldIndex].m_nCellHeight, pSkillParam->nWaitTime + GetMissleGenerateTime(i * m_nChildSkillNum + j ), eLauncherType);
					else 
						nCastMissleNum += pOrdinSkill->Cast(pSkillParam->nLauncher, nBeginPX + j * SubWorld[Npc[nLauncher].m_SubWorldIndex].m_nCellWidth , nBeginPY +  i * SubWorld[Npc[nLauncher].m_SubWorldIndex].m_nCellHeight, pSkillParam->nWaitTime + GetMissleGenerateTime(i * m_nChildSkillNum + j ), pSkillParam->eLauncherType);
				}
			}
			
		}
exit:	
#ifdef _SERVER
		if (pNewMagicAttribsData)
			if (pNewMagicAttribsData->GetRef() == 0)
				delete pNewMagicAttribsData;
#endif
			return nCastMissleNum;
}

/*!*****************************************************************************
// Function		: KSkill::CastLine
// Purpose		: 
// Return		: 
// Argumant		: int nLauncher
// Argumant		: eSkillLauncherType eLauncherType
// Argumant		: int nDir
// Argumant		: int nRefPX
// Argumant		: int nRefPY
// Argumant		: int nWaitTime
// Argumant		: int nTargetId
// Comments		:
// Author		: RomanDou
*****************************************************************************/
// Value1 �ӵ�֮��ļ��
// Value2 
int		KSkill::CastLine(TOrdinSkillParam *pSkillParam, int nDir, int nRefPX, int nRefPY)  const 
{
	int nLauncher = pSkillParam->nLauncher;
	eSkillLauncherType eLauncherType = pSkillParam->eLauncherType;
	if (eLauncherType != SKILL_SLT_Npc) return 0;
	int	nDirIndex		= g_Dir2DirIndex(nDir, MaxMissleDir);
	int nDesSubX		= 0;
	int nDesSubY		= 0;
	int nCastMissleNum	= 0;
	
	//�ӵ�֮��ļ��
	int nMSDistanceEach = m_nValue1;
	
#ifdef _SERVER
	KMissleMagicAttribsData * pNewMagicAttribsData = CreateMissleMagicAttribsData(nLauncher);
#endif //_SERVER
	
	int nNum = 0;
	//�ֱ����ɶ����ӵ�
	for(int i = 0; i < m_nChildSkillNum; i++)
	{
		if (m_nValue2)
		{
			int nCurMSDistance	= -1 * nMSDistanceEach * m_nChildSkillNum / 2;
			int nDir1 = nDirIndex + MaxMissleDir / 4;
			if (nDir1 > MaxMissleDir)
				nDir1 -= MaxMissleDir;
			int nDIndex = g_Dir2DirIndex(nDir1,MaxMissleDir);
			if (i % 2)
			{
				nCurMSDistance = -nCurMSDistance;
				nNum++;
			}
			
			nDesSubX	= nRefPX + ((nCurMSDistance * nNum * g_DirCos(nDIndex, MaxMissleDir) )>>10);
			nDesSubY	= nRefPY + ((nCurMSDistance * nNum * g_DirSin(nDIndex, MaxMissleDir) )>>10);
		}
		else
		{
			nDesSubX	= nRefPX + ((nMSDistanceEach * (i + 1) * g_DirCos(nDirIndex, MaxMissleDir) )>>10);
			nDesSubY	= nRefPY + ((nMSDistanceEach * (i + 1) * g_DirSin(nDirIndex, MaxMissleDir) )>>10);
		}
		if (nDesSubX < 0 || nDesSubY < 0) 	continue;
		
		if (m_bBaseSkill)
		{
			int nMissleIndex ;
			int nSubWorldId ; 
			nSubWorldId = Npc[nLauncher].m_SubWorldIndex;
			
			if (nSubWorldId < 0)	goto exit;
			nMissleIndex = MissleSet.Add(nSubWorldId, nDesSubX, nDesSubY);
			
			if (nMissleIndex < 0)	continue;
			
			Missle[nMissleIndex].m_nDir				= nDir;
			Missle[nMissleIndex].m_nDirIndex		= nDirIndex;
			CreateMissle(nLauncher, m_nChildSkillId, nMissleIndex);
			Missle[nMissleIndex].m_nFollowNpcIdx	= pSkillParam->nTargetId;
			if (pSkillParam->nTargetId)
				Missle[nMissleIndex].m_dwFollowNpcID	= Npc[pSkillParam->nTargetId].m_dwID;
			Missle[nMissleIndex].m_dwBornTime		= SubWorld[nSubWorldId].m_dwCurrentTime;
			Missle[nMissleIndex].m_nSubWorldId		= nSubWorldId;
			Missle[nMissleIndex].m_nLauncher		= nLauncher;
			Missle[nMissleIndex].m_dwLauncherId		= Npc[nLauncher].m_dwID;
			Missle[nMissleIndex].m_nPKFlag			= Npc[nLauncher].m_nPKFlag;
			Missle[nMissleIndex].m_nMissleSeries	= -1;
			KSkill * pSkill =(KSkill*) Npc[nLauncher].GetActiveSkill();
			if(pSkill)
				Missle[nMissleIndex].m_nMissleSeries	= pSkill->GetSkillSeries();
			
			if (pSkillParam->nParent)
				Missle[nMissleIndex].m_nParentMissleIndex = pSkillParam->nParent;
			else 
				Missle[nMissleIndex].m_nParentMissleIndex = 0;
			
			Missle[nMissleIndex].m_nSkillId			= m_nId;
			Missle[nMissleIndex].m_nStartLifeTime	= pSkillParam->nWaitTime + GetMissleGenerateTime(i);
			Missle[nMissleIndex].m_nLifeTime		+= Missle[nMissleIndex].m_nStartLifeTime;	
			Missle[nMissleIndex].m_nRefPX			= nDesSubX;
			Missle[nMissleIndex].m_nRefPY			= nDesSubY;
			if (Missle[nMissleIndex].m_eMoveKind == MISSLE_MMK_Line || Missle[nMissleIndex].m_eMoveKind == MISSLE_MMK_RollBack || Missle[nMissleIndex].m_eMoveKind == MISSLE_MMK_Follow)
			{
				Missle[nMissleIndex].m_nXFactor = g_DirCos(nDir, MaxMissleDir);
				Missle[nMissleIndex].m_nYFactor = g_DirSin(nDir, MaxMissleDir);
			}
			
			
#ifdef _SERVER
			Missle[nMissleIndex].SetMagicAttribsData(pNewMagicAttribsData);
#endif //_SERVER
			nCastMissleNum ++;
		}
		else
		{
			_ASSERT(m_nChildSkillId > 0 && m_nChildSkillLevel > 0)	;
			KSkill * pOrdinSkill = (KSkill *) g_SkillManager.GetSkill(m_nChildSkillId, m_nChildSkillLevel);
			if (pOrdinSkill) 
			{
				if (!pSkillParam->nParent)
					nCastMissleNum += pOrdinSkill->Cast(nLauncher, nDesSubX, nDesSubY, pSkillParam->nWaitTime + GetMissleGenerateTime(i), eLauncherType);
				else
					nCastMissleNum += pOrdinSkill->Cast(pSkillParam->nParent, nDesSubX, nDesSubY, pSkillParam->nWaitTime + GetMissleGenerateTime(i), pSkillParam->eParentType);
				
			}
		}
		
	}
	
exit:	
#ifdef _SERVER
	if (pNewMagicAttribsData)
		if (pNewMagicAttribsData->GetRef() == 0)
			delete pNewMagicAttribsData;
#endif
		return nCastMissleNum;
}

int		KSkill::CastExtractiveLineMissle(TOrdinSkillParam* pSkillParam,  int nDir,int nSrcX, int nSrcY, int nXOffset, int nYOffset, int nDesX, int nDesY)  const 
{
	
	_ASSERT(pSkillParam);
	
	int nLauncher = pSkillParam->nLauncher;
	if (pSkillParam->eLauncherType != SKILL_SLT_Npc) return 0;	
	int	nDirIndex		= g_Dir2DirIndex(nDir, MaxMissleDir);
	int nDesSubX		= 0;
	int nDesSubY		= 0;
	int nCastMissleNum	= 0;
	
	//�ӵ�֮��ļ��
	
	
#ifdef _SERVER
	KMissleMagicAttribsData * pNewMagicAttribsData = CreateMissleMagicAttribsData(nLauncher);
#endif //_SERVER
	
	//�ֱ����ɶ����ӵ�
	{
		
		if (m_bBaseSkill)
		{
			int nMissleIndex ;
			int nSubWorldId ; 
			
			nSubWorldId = Npc[nLauncher].m_SubWorldIndex;
			
			if (nSubWorldId < 0)	goto exit;
			nMissleIndex = MissleSet.Add(nSubWorldId, nSrcX, nSrcY);
			
			if (nMissleIndex < 0)	goto exit;
			
			Missle[nMissleIndex].m_nDir				= nDir;
			Missle[nMissleIndex].m_nDirIndex		= nDirIndex;
			CreateMissle(nLauncher, m_nChildSkillId, nMissleIndex);
			
			if (Missle[nMissleIndex].m_eMoveKind == MISSLE_MMK_Parabola)
			{
				int nLength = g_GetDistance(nSrcX, nSrcY, nDesX, nDesY);
				int nTime = nLength / PT_SAFE_SPEED(Missle[nMissleIndex].m_nSpeed);
				Missle[nMissleIndex].m_nHeightSpeed	= Missle[nMissleIndex].m_nZAcceleration * (nTime - 1) / 2;
				
			}
			
			Missle[nMissleIndex].m_nFollowNpcIdx	= pSkillParam->nTargetId;
			if (pSkillParam->nTargetId)
				Missle[nMissleIndex].m_dwFollowNpcID	= Npc[pSkillParam->nTargetId].m_dwID;
			Missle[nMissleIndex].m_dwBornTime		= SubWorld[nSubWorldId].m_dwCurrentTime;
			Missle[nMissleIndex].m_nSubWorldId		= nSubWorldId;
			Missle[nMissleIndex].m_nLauncher		= nLauncher;
			Missle[nMissleIndex].m_dwLauncherId		= Npc[nLauncher].m_dwID;
			Missle[nMissleIndex].m_nPKFlag			= Npc[nLauncher].m_nPKFlag;
			Missle[nMissleIndex].m_nMissleSeries	= -1;
			KSkill * pSkill =(KSkill*) Npc[nLauncher].GetActiveSkill();
			if(pSkill)
				Missle[nMissleIndex].m_nMissleSeries	= pSkill->GetSkillSeries();
		
			if (pSkillParam->nParent)
				Missle[nMissleIndex].m_nParentMissleIndex = pSkillParam->nParent;
			else 
				Missle[nMissleIndex].m_nParentMissleIndex = 0;
			
			Missle[nMissleIndex].m_nSkillId			= m_nId;
			Missle[nMissleIndex].m_nStartLifeTime	= pSkillParam->nWaitTime + GetMissleGenerateTime(0);
			Missle[nMissleIndex].m_nLifeTime		+= Missle[nMissleIndex].m_nStartLifeTime;	
			Missle[nMissleIndex].m_nRefPX			= nSrcX;
			Missle[nMissleIndex].m_nRefPY			= nSrcY;

			int nTempR = 0;
			int nTempMapX = 0;
			int nTempMapY = 0;
			int nTempOffsetX = 0;
			int nTempOffsetY = 0;

			Missle[nMissleIndex].m_bNeedReclaim = TRUE;
			int nLength = g_GetDistance(nSrcX, nSrcY, nDesX, nDesY);
			Missle[nMissleIndex].m_nFirstReclaimTime = nLength / PT_SAFE_SPEED(Missle[nMissleIndex].m_nSpeed) + Missle[nMissleIndex].m_nStartLifeTime;
			Missle[nMissleIndex].m_nEndReclaimTime = Missle[nMissleIndex].m_nFirstReclaimTime + SubWorld[nSubWorldId].m_nCellWidth / PT_SAFE_SPEED(Missle[nMissleIndex].m_nSpeed) + 2;

			if (Missle[nMissleIndex].m_eMoveKind == MISSLE_MMK_Line || Missle[nMissleIndex].m_eMoveKind == MISSLE_MMK_Parabola || Missle[nMissleIndex].m_eMoveKind == MISSLE_MMK_Follow)
			{	
				Missle[nMissleIndex].m_nXFactor = nXOffset;
				Missle[nMissleIndex].m_nYFactor = nYOffset;
			}
			
			
#ifdef _SERVER
			Missle[nMissleIndex].SetMagicAttribsData(pNewMagicAttribsData);
#endif //_SERVER
			
			nCastMissleNum ++;
		}
		else
		{
			KSkill * pOrdinSkill = (KSkill *) g_SkillManager.GetSkill(m_nChildSkillId, m_nChildSkillLevel);
			if (pOrdinSkill) 
			{
				if (!pSkillParam->nParent)
					nCastMissleNum += pOrdinSkill->Cast(nLauncher, nDesSubX, nDesSubY, pSkillParam->nWaitTime + GetMissleGenerateTime(0), pSkillParam->eLauncherType);
				else
					nCastMissleNum += pOrdinSkill->Cast(pSkillParam->nParent, nDesSubX, nDesSubY, pSkillParam->nWaitTime + GetMissleGenerateTime(0), pSkillParam->eParentType);
				
			}
		}
		
	}
	
exit:	
#ifdef _SERVER
	if (pNewMagicAttribsData)
		if (pNewMagicAttribsData->GetRef() == 0)
			delete pNewMagicAttribsData;
#endif
		
		return nCastMissleNum;
		
}

/*!*****************************************************************************
// Function		: KSkill::CastWall
// Purpose		: Wall Magic 
// Return		: int 
// Argumant		: int nLauncher
// Argumant		: eSkillLauncherType eLauncherType
// Argumant		: int nDir
// Argumant		: int nRefPX
// Argumant		: int nRefPY
// Argumant		: int nWaitTime
// Argumant		: int nTargetId
// Comments		:
// Author		: RomanDou
*****************************************************************************/
/*
m_nValue1 ��ʾ�ӵ�֮��ľ��룬��λ���ص�
*/
int KSkill::CastWall(TOrdinSkillParam * pSkillParam,  int nDir , int nRefPX , int nRefPY)  const 
{
	int nLauncher = pSkillParam->nLauncher;
	eSkillLauncherType eLauncherType = pSkillParam->eLauncherType;
	
	if (eLauncherType != SKILL_SLT_Npc) return 0;
	int	nDirIndex		= g_Dir2DirIndex(nDir, MaxMissleDir);
	int nDesSubX		= 0;
	int nDesSubY		= 0;
	int nCastMissleNum	= 0;
	
	
	//�ӵ�֮��ļ��
	int nMSDistanceEach = m_nValue1;
	int nCurMSDistance	= -1 * nMSDistanceEach * m_nChildSkillNum / 2;
	
#ifdef _SERVER
	KMissleMagicAttribsData * pNewMagicAttribsData = CreateMissleMagicAttribsData(nLauncher);
#endif //_SERVER
	
	//�ֱ����ɶ����ӵ�
	for(int i = 0; i < m_nChildSkillNum; i++)
	{
		nDesSubX	= nRefPX + ((nCurMSDistance * g_DirCos(nDirIndex, MaxMissleDir)) >>10);
		nDesSubY	= nRefPY + ((nCurMSDistance * g_DirSin(nDirIndex, MaxMissleDir)) >>10);
		
		if (nDesSubX < 0 || nDesSubY < 0) 	continue;
		
		if (m_bBaseSkill)
		{
			int nMissleIndex ;
			int nSubWorldId ; 
			nSubWorldId = Npc[nLauncher].m_SubWorldIndex;
			
			if (nSubWorldId < 0)	
			{
				goto exit;
			}
			
			nMissleIndex = MissleSet.Add(nSubWorldId, nDesSubX, nDesSubY);
			if (nMissleIndex < 0)	
			{
				continue;
			}

			if (m_nValue2)
			{
				int nDirTemp = nDir - MaxMissleDir / 4;
				if (nDirTemp < 0) nDirTemp += MaxMissleDir;
				Missle[nMissleIndex].m_nDir				= nDirTemp;
				Missle[nMissleIndex].m_nDirIndex = g_Dir2DirIndex(nDirTemp, 64);

			}
			else
			{
				Missle[nMissleIndex].m_nDir				= nDir;
				Missle[nMissleIndex].m_nDirIndex		= nDirIndex;
			}
			
			Missle[nMissleIndex].m_nSubWorldId		= nSubWorldId;
			CreateMissle(nLauncher, m_nChildSkillId, nMissleIndex);
			Missle[nMissleIndex].m_nFollowNpcIdx	= pSkillParam->nTargetId;
			if (pSkillParam->nTargetId)
				Missle[nMissleIndex].m_dwFollowNpcID	= Npc[pSkillParam->nTargetId].m_dwID;
			Missle[nMissleIndex].m_dwBornTime		= SubWorld[nSubWorldId].m_dwCurrentTime;
			Missle[nMissleIndex].m_nLauncher		= nLauncher;
			Missle[nMissleIndex].m_dwLauncherId		= Npc[nLauncher].m_dwID;
			Missle[nMissleIndex].m_nPKFlag			= Npc[nLauncher].m_nPKFlag;
			Missle[nMissleIndex].m_nMissleSeries	= -1;
			KSkill * pSkill =(KSkill*) Npc[nLauncher].GetActiveSkill();
			if(pSkill)
				Missle[nMissleIndex].m_nMissleSeries	= pSkill->GetSkillSeries();
			
			if (pSkillParam->nParent)
				Missle[nMissleIndex].m_nParentMissleIndex = pSkillParam->nParent;
			else 
				Missle[nMissleIndex].m_nParentMissleIndex = 0;
			
			
			Missle[nMissleIndex].m_nSkillId			= m_nId;
			Missle[nMissleIndex].m_nStartLifeTime	= pSkillParam->nWaitTime + GetMissleGenerateTime(i);
			Missle[nMissleIndex].m_nLifeTime		+= Missle[nMissleIndex].m_nStartLifeTime;
			Missle[nMissleIndex].m_nRefPX			= nDesSubX;
			Missle[nMissleIndex].m_nRefPY			= nDesSubY;
			
			if (Missle[nMissleIndex].m_eMoveKind == MISSLE_MMK_Line || Missle[nMissleIndex].m_eMoveKind == MISSLE_MMK_RollBack || Missle[nMissleIndex].m_eMoveKind == MISSLE_MMK_Follow)
			{
				Missle[nMissleIndex].m_nXFactor = g_DirCos(Missle[nMissleIndex].m_nDir, MaxMissleDir);
				Missle[nMissleIndex].m_nYFactor = g_DirSin(Missle[nMissleIndex].m_nDir, MaxMissleDir);
			}
			
#ifdef _SERVER
			Missle[nMissleIndex].SetMagicAttribsData(pNewMagicAttribsData);
#endif //_SERVER
			
			nCastMissleNum ++;
		}
		else
		{
			_ASSERT(m_nChildSkillId > 0 && m_nChildSkillLevel > 0)	;
			KSkill * pOrdinSkill = (KSkill *) g_SkillManager.GetSkill(m_nChildSkillId, m_nChildSkillLevel);
			if (pOrdinSkill) 
			{
				if (!pSkillParam->nParent)
					nCastMissleNum += pOrdinSkill->Cast(nLauncher, nDesSubX, nDesSubY, pSkillParam->nWaitTime + GetMissleGenerateTime(i), eLauncherType);
				else
					nCastMissleNum += pOrdinSkill->Cast(pSkillParam->nParent, nDesSubX, nDesSubY, pSkillParam->nWaitTime +  GetMissleGenerateTime(i), pSkillParam->eParentType);
			}
		}
		
		nCurMSDistance += nMSDistanceEach;
	}
	
exit:	
#ifdef _SERVER
	if (pNewMagicAttribsData)
		if (pNewMagicAttribsData->GetRef() == 0)
			delete pNewMagicAttribsData;
#endif
		return nCastMissleNum;
}

/*!*****************************************************************************
// Function		: KSkill::CastCircle
// Purpose		: 
// Return		: 
// Argumant		: int nLauncher
// Argumant		: eSkillLauncherType  eLauncherType
// Argumant		: int nDir
// Argumant		: int nRefPX
// Argumant		: int nRefPY
// Argumant		: int nWaitTime
// Argumant		: int nTargetId
// Comments		:
// Author		: RomanDou
*****************************************************************************/
// Value1  == 0 ��ʾ������ΪԲ�Ĳ���Բ��������Ŀ���ΪԲ�Ĳ���Բ
int		KSkill::CastCircle(TOrdinSkillParam * pSkillParam, int nDir, int nRefPX, int nRefPY)  const 
{
	int nLauncher = pSkillParam->nLauncher;
	eSkillLauncherType  eLauncherType = pSkillParam->eLauncherType;
	if (eLauncherType != SKILL_SLT_Npc) return 0;	
	int nDesSubPX	= 0;
	int nDesSubPY	= 0;
	int nFirstStep	= m_nValue2;			//��һ���ĳ��ȣ��ӵ��ڸշ���ȥʱ����ҵľ���
	int nCurSubDir	= 0;
	int nDirPerNum  = 	m_nChildSkillNum > 0 ? MaxMissleDir / m_nChildSkillNum : MaxMissleDir;	// cppbatch:G1 0 missles
	int nCastMissleNum = 0;
#ifdef _SERVER
	KMissleMagicAttribsData * pNewMagicAttribsData = CreateMissleMagicAttribsData(nLauncher);
#endif //_SERVER
	
	//�ֱ����ɶ���ӵ�
	for(int i = 0; i < m_nChildSkillNum; i++)
	{
		int nCurSubDir	= nDir + nDirPerNum * i ;
		
		if (nCurSubDir < 0)
			nCurSubDir = MaxMissleDir + nCurSubDir;
		
		if (nCurSubDir >= MaxMissleDir)
			nCurSubDir -= MaxMissleDir;
		
		int nSinAB	= g_DirSin(nCurSubDir, MaxMissleDir);
		int nCosAB	= g_DirCos(nCurSubDir, MaxMissleDir);
		
		nDesSubPX	= nRefPX + ((nCosAB * nFirstStep) >> 10);
		nDesSubPY	= nRefPY + ((nSinAB * nFirstStep) >> 10);
		
		
		
		if (nDesSubPX < 0 || nDesSubPY < 0) 	continue;
		
		if (m_bBaseSkill)
		{
			int nMissleIndex ;
			int nSubWorldId ; 
			
			nSubWorldId = Npc[nLauncher].m_SubWorldIndex;
			
			if (nSubWorldId < 0)	goto exit;
			nMissleIndex = MissleSet.Add(nSubWorldId, nDesSubPX, nDesSubPY);
			
			if (nMissleIndex < 0)	
			{
				continue;
			}
			
			Missle[nMissleIndex].m_nDir			= nCurSubDir;
			Missle[nMissleIndex].m_nDirIndex	= g_Dir2DirIndex(nCurSubDir, MaxMissleDir);
			CreateMissle(nLauncher, m_nChildSkillId, nMissleIndex);
			
			Missle[nMissleIndex].m_nFollowNpcIdx	= pSkillParam->nTargetId;
			if (pSkillParam->nTargetId)
				Missle[nMissleIndex].m_dwFollowNpcID	= Npc[pSkillParam->nTargetId].m_dwID;
			Missle[nMissleIndex].m_dwBornTime		= SubWorld[nSubWorldId].m_dwCurrentTime;
			Missle[nMissleIndex].m_nSubWorldId		= nSubWorldId;
			Missle[nMissleIndex].m_nLauncher		= nLauncher;
			Missle[nMissleIndex].m_dwLauncherId		= Npc[nLauncher].m_dwID;
			Missle[nMissleIndex].m_nPKFlag			= Npc[nLauncher].m_nPKFlag;
			Missle[nMissleIndex].m_nMissleSeries	= -1;
			KSkill * pSkill =(KSkill*) Npc[nLauncher].GetActiveSkill();
			if(pSkill)
				Missle[nMissleIndex].m_nMissleSeries	= pSkill->GetSkillSeries();
			
			if (pSkillParam->nParent)
				Missle[nMissleIndex].m_nParentMissleIndex = pSkillParam->nParent;
			else 
				Missle[nMissleIndex].m_nParentMissleIndex = 0;
			
			
			Missle[nMissleIndex].m_nSkillId			= m_nId;
			Missle[nMissleIndex].m_nStartLifeTime	= pSkillParam->nWaitTime + GetMissleGenerateTime(i);
			Missle[nMissleIndex].m_nLifeTime		+= Missle[nMissleIndex].m_nStartLifeTime;
			Missle[nMissleIndex].m_nRefPX			= nDesSubPX;
			Missle[nMissleIndex].m_nRefPY			= nDesSubPY;
			
			if (Missle[nMissleIndex].m_eMoveKind == MISSLE_MMK_Line || Missle[nMissleIndex].m_eMoveKind == MISSLE_MMK_Follow)
			{
				Missle[nMissleIndex].m_nXFactor = g_DirCos(nCurSubDir, MaxMissleDir);
				Missle[nMissleIndex].m_nYFactor = g_DirSin(nCurSubDir, MaxMissleDir);
			}
			
			
#ifdef _SERVER
			Missle[nMissleIndex].SetMagicAttribsData(pNewMagicAttribsData);
#endif //_SERVER
			
			nCastMissleNum ++;
		}
		else
		{
			_ASSERT(m_nChildSkillId > 0 && m_nChildSkillLevel > 0)	;
			KSkill * pOrdinSkill = (KSkill *) g_SkillManager.GetSkill(m_nChildSkillId, m_nChildSkillLevel);
			if (pOrdinSkill) 
			{
				if (!pSkillParam->nParent)
					nCastMissleNum += pOrdinSkill->Cast(nLauncher, nDesSubPX, nDesSubPY, pSkillParam->nWaitTime + GetMissleGenerateTime(i), eLauncherType);
				else
					nCastMissleNum += pOrdinSkill->Cast(pSkillParam->nParent, nDesSubPX, nDesSubPY, pSkillParam->nWaitTime + GetMissleGenerateTime(i), pSkillParam->eParentType);
			}
		}
		
	}

exit:	
#ifdef _SERVER
	if (pNewMagicAttribsData)
		if (pNewMagicAttribsData->GetRef() == 0)
			delete pNewMagicAttribsData;
#endif
		
		return nCastMissleNum;
}

/*!*****************************************************************************
// Function		: KSkill::CastSpread
// Purpose		: 
// Return		: 
// Argumant		: int nLauncher
// Argumant		: eSkillLauncherType eLauncherType
// Argumant		: int nDir
// Argumant		: int nRefPX
// Argumant		: int nRefPY
// Argumant		: int nWaitTime
// Argumant		: int nTargetId
// Comments		:
// Author		: RomanDou
*****************************************************************************/
/*
Value1 ÿ���ӵ����ĽǶȵ�λ
Value2 ÿһ���ĳ��ȣ���һ���ĳ��ȣ��ӵ��ڸշ���ȥʱ����ҵľ���
*/
int		KSkill::CastSpread(TOrdinSkillParam * pSkillParam, int nDir, int nRefPX, int nRefPY)  const 
{
	int nLauncher = pSkillParam->nLauncher;
	eSkillLauncherType eLauncherType = pSkillParam->eLauncherType;
	if (eLauncherType != SKILL_SLT_Npc) return 0;
	int nDesSubMapX		= 0;
	int nDesSubMapY		= 0;
	int nFirstStep		= m_nValue2;			//��һ���ĳ��ȣ��ӵ��ڸշ���ȥʱ����ҵľ���
	int nCurMSRadius	= m_nChildSkillNum / 2 ; 
	int nCurSubDir		= 0;
	int	nCastMissleNum  = 0;			//ʵ�ʷ��͵�Missle������
	
	// Sin A+B = SinA*CosB + CosA*SinB
	// Cos A+B = CosA*CosB - SinA*SinB
	// Sin A = nYFactor
	// Cos A = nXFactor
	
#ifdef _SERVER
	KMissleMagicAttribsData * pNewMagicAttribsData = CreateMissleMagicAttribsData(nLauncher);
#endif
	
	int nDesSubX = 0;
	int nDesSubY = 0;
	int nXFactor = 0;
	int nYFactor = 0;
	
	if (pSkillParam->nTargetId > 0)
	{
		int nTargetId = pSkillParam->nTargetId;
		int nDistance = 0;
		int nDesX = nRefPX, nDesY = nRefPY;
		if (Npc[nTargetId].m_Index > 0 && Npc[nTargetId].m_SubWorldIndex >= 0) 
			SubWorld[Npc[nTargetId].m_SubWorldIndex].Map2Mps(Npc[nTargetId].m_RegionIndex, Npc[nTargetId].m_MapX, Npc[nTargetId].m_MapY, Npc[nTargetId].m_OffX, Npc[nTargetId].m_OffY, &nDesX, &nDesY);
		
		nDistance = (int)sqrt((nDesX - nRefPX)*(nDesX - nRefPX) +	(nDesY - nRefPY)*(nDesY - nRefPY));
		// Phong Than 2026-10-02: target on the caster's own spot gave nDistance 0 -> divide by zero (GameServer crash).
		if (nDistance <= 0) nDistance = 1;
		nXFactor = ((nDesX - nRefPX)<<10) / nDistance;
		nYFactor = ((nDesY - nRefPY)<<10) / nDistance;
		
		nDesSubX = nRefPX + ((nXFactor * nFirstStep)>>10);
		nDesSubY = nRefPY + ((nYFactor * nFirstStep)>>10);
		
		if (nDesSubX < 0  || nDesSubY < 0 ) return 0;
	}
	
	int nTargetId = pSkillParam->nTargetId;
	
	//�ֱ����ɶ���ӵ�
	for(int i = 0; i < m_nChildSkillNum; i++)
	{
		int nDSubDir	= m_nValue1 * nCurMSRadius; 
		nCurSubDir		= nDir - m_nValue1 * nCurMSRadius;
		
		
		if (nCurSubDir < 0)
			nCurSubDir = MaxMissleDir + nCurSubDir;
		
		if (nCurSubDir >= MaxMissleDir)
			nCurSubDir -= MaxMissleDir;
		
		int nSinAB	;
		int nCosAB	;
		
		if (nTargetId > 0)
		{
			nDSubDir	+= 48;
			if (nDSubDir >= MaxMissleDir)
				nDSubDir -= MaxMissleDir;
			//sin(a - b) = sinacosb - cosa*sinb
			//cos(a - b) = cosacoab + sinasinb
			nSinAB = (nYFactor * g_DirCos(nDSubDir, MaxMissleDir) - nXFactor * g_DirSin(nDSubDir, MaxMissleDir)) >> 10;
			nCosAB = (nXFactor * g_DirCos(nDSubDir, MaxMissleDir) + nYFactor * g_DirSin(nDSubDir , MaxMissleDir)) >> 10;
		}
		else
		{
			nSinAB = g_DirSin(nCurSubDir, MaxMissleDir);
			nCosAB = g_DirCos(nCurSubDir, MaxMissleDir);
		}
		
		nDesSubX	= nRefPX + ((nCosAB * nFirstStep) >> 10);
		nDesSubY	= nRefPY + ((nSinAB * nFirstStep) >> 10);
		
		if (nDesSubX < 0 || nDesSubY < 0) 	continue;
		
		if (m_bBaseSkill)
		{
			
			int nMissleIndex ;
			int nSubWorldId ; 
			nSubWorldId = Npc[nLauncher].m_SubWorldIndex;
			
			if (nSubWorldId < 0)	goto exit;
			
			nMissleIndex = MissleSet.Add(nSubWorldId, nDesSubX, nDesSubY);
			
			if (nMissleIndex < 0)	continue;
			
			Missle[nMissleIndex].m_nDir				= nCurSubDir;
			Missle[nMissleIndex].m_nDirIndex		= g_Dir2DirIndex(nCurSubDir, MaxMissleDir);
			CreateMissle(nLauncher, m_nChildSkillId, nMissleIndex);
			Missle[nMissleIndex].m_nFollowNpcIdx	= nTargetId;
			if (pSkillParam->nTargetId)
				Missle[nMissleIndex].m_dwFollowNpcID	= Npc[pSkillParam->nTargetId].m_dwID;
			Missle[nMissleIndex].m_dwBornTime		= SubWorld[nSubWorldId].m_dwCurrentTime;
			Missle[nMissleIndex].m_nSubWorldId		= nSubWorldId;
			Missle[nMissleIndex].m_nLauncher		= nLauncher;
			Missle[nMissleIndex].m_dwLauncherId		= Npc[nLauncher].m_dwID;
			Missle[nMissleIndex].m_nPKFlag			= Npc[nLauncher].m_nPKFlag;
			Missle[nMissleIndex].m_nMissleSeries	= -1;
			KSkill * pSkill =(KSkill*) Npc[nLauncher].GetActiveSkill();
			if(pSkill)
				Missle[nMissleIndex].m_nMissleSeries	= pSkill->GetSkillSeries();
			
			if (pSkillParam->nParent)
				Missle[nMissleIndex].m_nParentMissleIndex = pSkillParam->nParent;
			else 
				Missle[nMissleIndex].m_nParentMissleIndex = 0;
			
			Missle[nMissleIndex].m_nSkillId			= m_nId;
			Missle[nMissleIndex].m_nStartLifeTime	= pSkillParam->nWaitTime + GetMissleGenerateTime(i);
			Missle[nMissleIndex].m_nLifeTime		+= Missle[nMissleIndex].m_nStartLifeTime;
			Missle[nMissleIndex].m_nXFactor			= nCosAB;
			Missle[nMissleIndex].m_nYFactor			= nSinAB;
			Missle[nMissleIndex].m_nRefPX			= nDesSubX;
			Missle[nMissleIndex].m_nRefPY			= nDesSubY;
			
#ifdef _SERVER
			Missle[nMissleIndex].SetMagicAttribsData(pNewMagicAttribsData);
#endif //_SERVER
			nCastMissleNum ++;
		}
		else
		{
			_ASSERT(m_nChildSkillId > 0 && m_nChildSkillLevel > 0)	;
			KSkill * pOrdinSkill = (KSkill *) g_SkillManager.GetSkill(m_nChildSkillId, m_nChildSkillLevel);
			if (pOrdinSkill) 
			{
				if (!pSkillParam->nParent)
					nCastMissleNum +=  pOrdinSkill->Cast(nLauncher,  nRefPX, nRefPY , pSkillParam->nWaitTime + GetMissleGenerateTime(i), eLauncherType);
				else
					nCastMissleNum +=  pOrdinSkill->Cast(pSkillParam->nParent,  nRefPX, nRefPY , pSkillParam->nWaitTime + GetMissleGenerateTime(i), pSkillParam->eParentType); 
			}
		}
		
		nCurMSRadius -- ;
	}
exit:	
#ifdef _SERVER
	if (pNewMagicAttribsData)
		if (pNewMagicAttribsData->GetRef() == 0)
			delete pNewMagicAttribsData;
#endif
		
		return nCastMissleNum;
}

/*!*****************************************************************************
// Function		: KSkill::GetChildSkillNum
// Purpose		: ���ڿ���ĳЩ�����У����ż��ܵȼ����������ӵ�����ĿҲ��������ӣ�����ͨ���ú������ʵ�ʵ��Ӽ�����Ŀ
// Return		: 
// Argumant		: int nLevel
// Comments		:
// Author		: RomanDou
*****************************************************************************/
int 	KSkill::GetChildSkillNum(int nLevel)  const 
{
	return m_nChildSkillNum;
};
/*!*****************************************************************************
// Function		: KSkill::CreateMissle
// Purpose		: �����ӵ��Ļ������ݣ��Լ��ü��ܸõȼ��µĶ��ӵ���Ϣ�ı䶯����
//					����������ֵ�����ָ��
// Return		: 
// Argumant		: int nChildSkillId
// Argumant		: int nMissleIndex
// Comments		:
// Author		: RomanDou
*****************************************************************************/
void	KSkill::CreateMissle(int nLauncher, int nChildSkillId, int nMissleIndex)  const 
{
	_ASSERT(nChildSkillId > 0 && nChildSkillId < MAX_MISSLESTYLE && nMissleIndex > 0);
	if (nChildSkillId <= 0 || nChildSkillId >= MAX_MISSLESTYLE ||
		nMissleIndex <= 0 || nMissleIndex >= MAX_MISSLE ||
		nLauncher <= 0 || nLauncher >= MAX_NPC)
	{
		return;
	}
	
	KMissle * pMissle = &Missle[nMissleIndex];
	
	g_MisslesLib[nChildSkillId] = *pMissle;//���ƿ�������
	
	pMissle->m_nLevel			= m_ulLevel;
	pMissle->m_bCollideEvent	= m_bCollideEvent;
	pMissle->m_bVanishedEvent   = m_bVanishedEvent;
	pMissle->m_bStartEvent		= m_bStartEvent;
	pMissle->m_bFlyEvent		= m_bFlyingEvent;
	pMissle->m_nFlyEventTime	= m_nFlyEventTime;
	pMissle->m_nMissleId		= nMissleIndex;
	pMissle->m_bClientSend      = m_bClientSend;
	pMissle->m_bMustBeHit		= m_bMustBeHit;
	pMissle->m_bIsMelee			= m_bIsMelee;
	pMissle->m_bByMissle		= m_bByMissle;
	pMissle->m_bTargetSelf		= (m_bTargetSelf == 1);
	pMissle->m_nInteruptTypeWhenMove = m_nInteruptTypeWhenMove;
	pMissle->m_bHeelAtParent	= m_bHeelAtParent;
	pMissle->m_bUseAttackRating	= m_bUseAttackRate;
	pMissle->m_nDoHurtP			= m_nDoHurtP;
	
	if (pMissle->m_nInteruptTypeWhenMove)
	{
		Npc[nLauncher].GetMpsPos(&pMissle->m_nLauncherSrcPX, &pMissle->m_nLauncherSrcPY);
	}
	pMissle->m_eRelation = m_eRelation;

	
#ifndef _SERVER
	pMissle->m_MissleRes.m_bNeedShadow   = m_bNeedShadow;
	pMissle->m_MissleRes.m_nMaxShadowNum = m_nMaxShadowNum;
	pMissle->m_MissleRes.m_nMissleId	 = nMissleIndex;
	if (!pMissle->m_MissleRes.Init()) g_DebugLog("Create bullet sticker failed! %s", __FILE__) ;
#endif
	
	pMissle->DoWait();
	
	for (int i = 0  ; i < m_nMissleAttribsNum; i ++)
	{
		switch (m_MissleAttribs[i].nAttribType)
		{
		case magic_missle_movekind_v:
			{
				pMissle->m_eMoveKind	= (eMissleMoveKind) m_MissleAttribs[i].nValue[0];
			}break;
			
		case magic_missle_speed_v:	
			{
				pMissle->m_nSpeed		= m_MissleAttribs[i].nValue[0];
			}break;
			
		case magic_missle_lifetime_v:
			{
				pMissle->m_nLifeTime	= m_MissleAttribs[i].nValue[0];
			}break;
			
		case magic_missle_height_v:	
			{
				pMissle->m_nHeight		= m_MissleAttribs[i].nValue[0];
			}break;
			
		case magic_missle_damagerange_v:
			{
				pMissle->m_nDamageRange = m_MissleAttribs[i].nValue[0];
			}break;
			
		case magic_missle_radius_v:	
			{
			}break;
		case magic_missle_missrate:
			{
				pMissle->m_nMissRate = m_MissleAttribs[i].nValue[0];
			}break;
		case magic_missle_hitcount:
			{
				pMissle->m_nHitCount = m_MissleAttribs[i].nValue[0];
			}break;
		case magic_missle_range:
			{
			}break;
		case magic_missle_dmginterval:
			{
				pMissle->m_ulDamageInterval = m_MissleAttribs[i].nValue[0];
			}break;
		case magic_missle_zspeed:
			{
				pMissle->m_nHeightSpeed = m_MissleAttribs[i].nValue[0];
			}break;
		case magic_missle_ablility:
			{
			}break;
		case magic_missle_param:
			{
			}break;
		case magic_missle_wait:
			{
			}break;
		case magic_missle_fly:
			{
			}break;
		case magic_missle_collide:
			{
			}break;
		case magic_missle_vanish:
			{
			}break;
		}
	}
	
	if (m_bIsMelee)
		pMissle->m_nLifeTime = Npc[nLauncher].ModifyMissleLifeTime(pMissle->m_nLifeTime);
	else
	{
		pMissle->m_nSpeed = Npc[nLauncher].ModifyMissleSpeed(pMissle->m_nSpeed);
		pMissle->m_bCollideVanish = Npc[nLauncher].ModifyMissleCollsion(pMissle->m_bCollideVanish);
	}
	
}


/*!*****************************************************************************
// Function		: KSkill::GetInfoFromTabFile
// Purpose		: ��TabFile�л�øü��ܵĳ�������
// Return		: 
// Argumant		: int nCol
// Comments		:
// Author		: RomanDou
*****************************************************************************/
BOOL	KSkill::GetInfoFromTabFile(int nRow)
{
	KITabFile * pITabFile = &g_OrdinSkillsSetting;
	return GetInfoFromTabFile(&g_OrdinSkillsSetting, nRow);
}


BOOL	KSkill::GetInfoFromTabFile(KITabFile *pSkillsSettingFile, int nRow)
{
	if (!pSkillsSettingFile || nRow < 0) return FALSE;
	//	
	pSkillsSettingFile->GetString(nRow, "SkillName",		"", m_szName, sizeof(m_szName) ,TRUE);
	pSkillsSettingFile->GetInteger(nRow, "SkillId",			0, (int *)&m_nId,TRUE);
	pSkillsSettingFile->GetInteger(nRow, "Attrib",			0, (int *)&m_nAttrib,TRUE);
	
	int nReqLevel = 0;
	pSkillsSettingFile->GetInteger(nRow, "ReqLevel",		0, (int *)&nReqLevel, TRUE);
	m_usReqLevel = (unsigned short)nReqLevel;


	pSkillsSettingFile->GetInteger(nRow, "EqtLimit",		-2, (int *)&m_nEquiptLimited, TRUE);
	pSkillsSettingFile->GetInteger(nRow, "HorseLimit",		0, (int *)&m_nHorseLimited, TRUE);

	pSkillsSettingFile->GetInteger(nRow, "DoHurt",			1, (int *)&m_nDoHurtP);
	pSkillsSettingFile->GetInteger(nRow, "ChildSkillNum",	0, &m_nChildSkillNum,TRUE);
	pSkillsSettingFile->GetInteger(nRow, "MisslesForm",		0, (int *)&m_eMisslesForm, TRUE);
	pSkillsSettingFile->GetInteger(nRow, "CharClass",		0, &m_nCharClass, TRUE);
	pSkillsSettingFile->GetInteger(nRow, "SkillStyle",		0, (int *)&m_eSkillStyle, TRUE);
	pSkillsSettingFile->GetInteger(nRow, "CharAnimId",		0, (int *)&m_nCharActionId, TRUE);
	pSkillsSettingFile->GetInteger(nRow, "IsPhysical",		0, &m_bIsPhysical, TRUE);
	pSkillsSettingFile->GetInteger(nRow, "IsAura",			0, &m_bIsAura, TRUE);
	pSkillsSettingFile->GetInteger(nRow, "IsUseAR",			0, &m_bUseAttackRate, TRUE);
	pSkillsSettingFile->GetInteger(nRow, "TargetOnly",		0, &m_bTargetOnly, TRUE);
	pSkillsSettingFile->GetInteger(nRow, "TargetEnemy",		0, &m_bTargetEnemy, TRUE);
	pSkillsSettingFile->GetInteger(nRow, "TargetAlly",		0, &m_bTargetAlly, TRUE);
	pSkillsSettingFile->GetInteger(nRow, "TargetObj",		0, &m_bTargetObj, TRUE);
	pSkillsSettingFile->GetInteger(nRow, "TargetNoNpc",		0, &m_bTargetNoNpc, TRUE);
	pSkillsSettingFile->GetInteger(nRow, "BaseSkill",		0, &m_bBaseSkill, TRUE);
	pSkillsSettingFile->GetInteger(nRow, "ByMissle",		0, &m_bByMissle, TRUE);
	pSkillsSettingFile->GetInteger(nRow, "ChildSkillId",	0, &m_nChildSkillId, TRUE);
	pSkillsSettingFile->GetInteger(nRow, "StartEvent",		0, &m_bStartEvent, TRUE);
	pSkillsSettingFile->GetInteger(nRow, "StartSkillId",	0, &m_nStartSkillId, TRUE);
	pSkillsSettingFile->GetInteger(nRow, "FlyEvent",		0, &m_bFlyingEvent, TRUE);
	pSkillsSettingFile->GetInteger(nRow, "FlySkillId",		0, &m_nFlySkillId, TRUE);
	pSkillsSettingFile->GetInteger(nRow, "FlyEventTime",	0, &m_nFlyEventTime, TRUE);
	pSkillsSettingFile->GetInteger(nRow, "CollideEvent",	0, &m_bCollideEvent, TRUE);
	pSkillsSettingFile->GetInteger(nRow, "CollidSkillId",	0, &m_nCollideSkillId, TRUE);
	pSkillsSettingFile->GetInteger(nRow, "VanishedEvent",	0, &m_bVanishedEvent, TRUE);
	pSkillsSettingFile->GetInteger(nRow, "VanishedSkillId",	0, &m_nVanishedSkillId, TRUE);
	pSkillsSettingFile->GetInteger(nRow, "SkillCostType",	0, (int *)&m_nSkillCostType, TRUE);
	pSkillsSettingFile->GetInteger(nRow, "CostValue",		0, &m_nCost, TRUE);
	pSkillsSettingFile->GetInteger(nRow, "TimePerCast",		0, &m_nMinTimePerCast, TRUE);
	pSkillsSettingFile->GetInteger(nRow, "TimePerCastOnHorse",		0, &m_nMinTimePerCastOnHorse, TRUE);
	pSkillsSettingFile->GetInteger(nRow, "Param1",			0, &m_nValue1, TRUE);
	pSkillsSettingFile->GetInteger(nRow, "Param2",			0, &m_nValue2, TRUE);
	pSkillsSettingFile->GetInteger(nRow, "ChildSkillLevel", 0, &m_nChildSkillLevel, TRUE);
	pSkillsSettingFile->GetInteger(nRow, "EventSkillLevel", 0, &m_nEventSkillLevel, TRUE);
	pSkillsSettingFile->GetInteger(nRow, "IsMelee",			0, &m_bIsMelee, TRUE);
	
	pSkillsSettingFile->GetInteger(nRow, "MslsGenerate",	0, (int *)&m_eMisslesGenerateStyle, TRUE);
	pSkillsSettingFile->GetInteger(nRow, "MslsGenerateData",0, &m_nMisslesGenerateData, TRUE);
	pSkillsSettingFile->GetInteger(nRow, "MaxShadowNum",	0, &m_nMaxShadowNum, TRUE);
	pSkillsSettingFile->GetInteger(nRow, "AttackRadius",	50, &m_nAttackRadius, TRUE);
	pSkillsSettingFile->GetInteger(nRow, "WaitTime",		0, &m_nWaitTime, TRUE);
	pSkillsSettingFile->GetInteger(nRow, "ClientSend",		0, &m_bClientSend, TRUE);
	pSkillsSettingFile->GetInteger(nRow, "TargetSelf",		0, &m_bTargetSelf, TRUE);
	pSkillsSettingFile->GetInteger(nRow, "StopWhenMove",	0, &m_nInteruptTypeWhenMove, TRUE);
	pSkillsSettingFile->GetInteger(nRow, "HeelAtParent",  0, (int *)&m_bHeelAtParent, TRUE );
	pSkillsSettingFile->GetInteger(nRow, "ShowEvent",  0, (int *)&m_nShowEvent, TRUE );
	//����������Ҫ��ò�֪ͨ�ͻ���
	pSkillsSettingFile->GetInteger(nRow, "StateSpecialId",  0, &m_nStateSpecialId, TRUE);
	pSkillsSettingFile->GetInteger(nRow, "IsExpSkill",		0, (int *)&m_nIsExpSkill, TRUE);
	pSkillsSettingFile->GetInteger(nRow, "Series",		-1, (int *)&m_nSeries, TRUE);
	pSkillsSettingFile->GetInteger(nRow, "ShowAddition",		0, (int *)&m_nShowAddition, TRUE);

	m_eRelation = 0;
	if (m_bTargetEnemy)
		m_eRelation |= relation_enemy;
	
	if (m_bTargetAlly)
		m_eRelation |= relation_ally;
	
	if (m_bTargetSelf)
		m_eRelation |= relation_self;
	
#ifndef _SERVER
	pSkillsSettingFile->GetString(nRow, "SkillDesc", "", m_szSkillDesc, sizeof(m_szSkillDesc));
	pSkillsSettingFile->GetInteger(nRow, "NeedShadow",		0, &m_bNeedShadow, TRUE);
	pSkillsSettingFile->GetString(nRow, "SkillIcon","\\spr\\skill\\ͼ��\\ͨ��.spr",	m_szSkillIcon, 80);
	if (!m_szSkillIcon[0])	strcpy(m_szSkillIcon, "\\spr\\skill\\ͼ��\\ͨ��.spr");
		KImageParam sImage;
	if (g_pRepresent->GetImageParam(m_szSkillIcon, &sImage, ISI_T_SPR) == false)
	{
		strcpy(m_szSkillIcon, UNKNOWNITEM_SPR36);
	}
	pSkillsSettingFile->GetInteger(nRow, "LRSkill",		0, (int*)&m_eLRSkillInfo);
	pSkillsSettingFile->GetString(nRow, "PreCastSpr", "", m_szPreCastEffectFile, 100);
	pSkillsSettingFile->GetString(nRow, "ManCastSnd","", m_szManPreCastSoundFile, 100);
	pSkillsSettingFile->GetString(nRow, "FMCastSnd", "", m_szFMPreCastSoundFile, 100);
#else
	char szLevelScript[MAX_PATH];
	
	//��ȡ�趨�ű�1����¼ÿһ�����ܵ����Ա仯����ֵ�趨��
	pSkillsSettingFile->GetString(nRow, "LvlSetScript", "", szLevelScript, MAX_PATH);
	if (szLevelScript[0])
	{
		strlwr(szLevelScript);
		m_dwSkillLevelDataScriptId = g_FileName2Id(szLevelScript);
	}
	
	//��ȡ�趨�ű�2����¼����������Ϣ
	pSkillsSettingFile->GetString(nRow, "LevelUpScript","",szLevelScript, MAX_PATH);
	if (szLevelScript[0])
	{
		strlwr(szLevelScript);
		m_dwSkillLevelUpScriptID = g_FileName2Id(szLevelScript);
	}
#endif
	return TRUE;
}

/*!*****************************************************************************
// Function		: KSkill::LoadSkillLevelData
// Purpose		: ������õ�ǰ�ȼ��µ�ǰ���ܵļ��ܡ��ӵ�����ײ��ֵӰ��
// Return		: 
// Argumant		: int nLevel
// Comments		:
// Author		: Romandou
****************************************************************************/
void		KSkill::LoadSkillLevelData(unsigned long  nLevel /* =0*/, int nParam)
{
	m_nMissleAttribsNum = 0;
	m_nDamageAttribsNum = 0;
	m_nAddSkillDamageNum = 0;
	m_nImmediateAttribsNum = 0;
	m_nStateAttribsNum	= 0;		//���������10
		
	char szSettingScriptName[MAX_PATH];
	char szSettingNameValue[100];
	char szSettingDataValue[100];
	char szResult[300];
	int nRowId = nParam;
	if (nRowId < 2) return ;
	//Question ����˳��һ������
	KLuaScript * pScript = NULL;
#ifdef _SERVER
	KLuaScript LocalLevelScript;
#endif
#ifndef _SERVER
	g_OrdinSkillsSetting.GetString(nRowId,  "LvlSetScript", "", szSettingScriptName, MAX_PATH );
	if (!szSettingScriptName[0]) return;
	g_SetFilePath("\\");
	//����Lua�ű�
	KLuaScript Script;
	Script.Init();
	if (!Script.Load(szSettingScriptName)) 
	{
		g_DebugLog("Can't load %s", szSettingScriptName);
		return;
	}
	pScript  = &Script;
#else
	if (!m_dwSkillLevelDataScriptId) 
	{
		g_DebugLog("Not exits script [%s]\n", GetSkillName());
		return ;
	}
	
	pScript = (KLuaScript*)g_GetScript(m_dwSkillLevelDataScriptId);
	
	if (!pScript)
	{
		// The global script cache is a legacy fixed-size table.  Load the exact
		// VNG level script directly when it was not present in that cache.
		g_OrdinSkillsSetting.GetString(nRowId, "LvlSetScript", "",
			szSettingScriptName, MAX_PATH);
		if (szSettingScriptName[0])
		{
			g_SetFilePath("\\");
			LocalLevelScript.Init();
			LocalLevelScript.RegisterFunctions(GameScriptFuns,
				g_GetGameScriptFunNum());
			if (LocalLevelScript.Load(szSettingScriptName))
				pScript = &LocalLevelScript;
		}
		if (!pScript)
		{
			g_DebugLog("Can't find or load script [%s]\n", GetSkillName());
			return ;
		}
	}
#endif
	
	
	int nSafeIndex = 1;
	pScript->SafeCallBegin(&nSafeIndex);
	
	for(int i = 0 ;  i  < MAXSKILLLEVELSETTINGNUM ; i ++)
	{
		char szSettingName[40];
		char szSettingData[40];
		sprintf(szSettingName, "LvlSetting%d", i + 1);
		sprintf(szSettingData, "LvlData%d", i + 1);
		
		g_OrdinSkillsSetting.GetString(nRowId, szSettingName, "", szSettingNameValue, 100);
		g_OrdinSkillsSetting.GetString(nRowId, szSettingData, "", szSettingDataValue, 100);
		if (szSettingNameValue[0] == 0 	|| szSettingDataValue[0] == '0'	)
		{
			continue;
		}
		
		pScript->CallFunction("GetSkillLevelData", 1, "ssd", szSettingNameValue, szSettingDataValue, nLevel);
		const char * szType = lua_typename(pScript->m_LuaState, Lua_GetTopIndex(pScript->m_LuaState));
		if (Lua_IsNumber(pScript->m_LuaState, Lua_GetTopIndex(pScript->m_LuaState)) == 1)
		{
			int nResult = (int)Lua_ValueToNumber(pScript->m_LuaState, Lua_GetTopIndex(pScript->m_LuaState));
			sprintf(szResult, "%d", nResult);
		}
		else if (Lua_IsString(pScript->m_LuaState, Lua_GetTopIndex(pScript->m_LuaState)) == 1)
		{
			if(strcmp(szSettingNameValue, "skill_desc") == 0)
			{
#ifndef _SERVER
				strcpy(m_szMagicSkillDesc, (char *)Lua_ValueToString(pScript->m_LuaState, Lua_GetTopIndex(pScript->m_LuaState)));
#endif
				continue;
			}
			else
			strcpy(szResult , (char *)Lua_ValueToString(pScript->m_LuaState, Lua_GetTopIndex(pScript->m_LuaState)));
		}
		else
		{
			char szMsg[300];
			sprintf(szMsg, "Cap ky nang %d(%s,%s) da xay ra loi, xin kiem ra lai!",nLevel, szSettingNameValue, szSettingDataValue);
			g_DebugLog(szMsg);
			break;
		}
		ParseString2MagicAttrib(nLevel, szSettingNameValue, szResult);
		
	}
	pScript->SafeCallEnd(nSafeIndex);
}

#ifdef _SERVER
//When nLauncher == 0 , means neednt  AppendSkillEffect;
KMissleMagicAttribsData* KSkill::CreateMissleMagicAttribsData(int nLauncher)  const 
{
	if (nLauncher < 0 || m_bClientSend) return NULL; 
	
	KMissleMagicAttribsData* pMissleMagicAttribsData = new KMissleMagicAttribsData;
	
	pMissleMagicAttribsData->m_pStateMagicAttribs = (KMagicAttrib *)m_StateAttribs;
	pMissleMagicAttribsData->m_nStateMagicAttribsNum = m_nStateAttribsNum;
	
	pMissleMagicAttribsData->m_pImmediateAttribs = (KMagicAttrib *)m_ImmediateAttribs;
	pMissleMagicAttribsData->m_nImmediateMagicAttribsNum = m_nImmediateAttribsNum;
	
	KMagicAttrib * pDamageAttribs =  new KMagicAttrib[MAX_MISSLE_DAMAGEATTRIB];
	pMissleMagicAttribsData->m_nDamageMagicAttribsNum = m_nDamageAttribsNum;
	
	//������ҵĻ������ԣ�ȷ���ӵ����˺�
	if (nLauncher)
	{
		Npc[nLauncher].AppendSkillEffect(m_nId, m_bIsPhysical, m_bIsMelee, (KMagicAttrib *)m_DamageAttribs, pDamageAttribs);
	}
	else
	{
		memcpy(pDamageAttribs, (KMagicAttrib *)m_DamageAttribs, sizeof(m_DamageAttribs));
	}
	
	pMissleMagicAttribsData->m_pDamageMagicAttribs = pDamageAttribs;
	return pMissleMagicAttribsData;
}
#endif
/*!*****************************************************************************
// Function		: KSkill::SetMissleGenerateTime
// Purpose		: ��õ�ǰ���ӵ���ʵ�ʲ���ʱ��
// Return		: void 
// Argumant		: Missle * pMissle
// Argumant		: int nNo
// Comments		:
// Author		: RomanDou
*****************************************************************************/
unsigned int KSkill::GetMissleGenerateTime(int nNo) const 
{
	
	switch(m_eMisslesGenerateStyle)
	{
	case SKILL_MGS_NULL:
		{
			return m_nWaitTime;
		}break;
		
	case SKILL_MGS_SAMETIME:
		{
			return  m_nWaitTime + m_nMisslesGenerateData;
		}break;
		
	case SKILL_MGS_ORDER:		
		{
			return  m_nWaitTime + nNo * m_nMisslesGenerateData;
		}break;
		
	case SKILL_MGS_RANDONORDER:	
		{
			if (g_Random(2) == 1) 
				return m_nWaitTime + nNo * m_nMisslesGenerateData + g_Random(m_nMisslesGenerateData);
			else 
				return m_nWaitTime + nNo * m_nMisslesGenerateData  - g_Random(m_nMisslesGenerateData / 2);
		}break;
		
	case SKILL_MGS_RANDONSAME:	
		{
			return  m_nWaitTime + g_Random(m_nMisslesGenerateData);
		}break;
		
	case SKILL_MGS_CENTEREXTENDLINE:
		{
			if (m_nChildSkillNum <= 1) return m_nWaitTime;
			int nCenter = m_nChildSkillNum / 2	;
			return m_nWaitTime + abs(nNo - nCenter) * m_nMisslesGenerateData ;
		}
	}
	return m_nWaitTime;
}

int KSkill::GetSkillIdFromName(char * szSkillName)  
{
	//	
	if (!szSkillName || !szSkillName[0]) 
        return -1;
	
	for (int i = 0; i < MAX_SKILL; i ++)
	{
		KSkill * pOrdinSkill = (KSkill *) g_SkillManager.GetSkill(i, 1);
		if (pOrdinSkill) 
		{
			if (!strcmp(pOrdinSkill->m_szName, szSkillName))
            {
                return i;
            }
		}
	}
	return -1;
	
}


/*!*****************************************************************************
// Function		: KSkill::CastInitiativeSkill
// Purpose		: ������������
// Return		: BOOL 
// Argumant		: int nLauncher
// Argumant		: int nParam1
// Argumant		: int nParam2
// Argumant		: int nWaitTime
// Comments		:
// Author		: RomanDou
*****************************************************************************/
BOOL KSkill::CastInitiativeSkill(int nLauncher, int nParam1, int nParam2, int nWaitTime)  const 
{
#ifdef _SERVER
	//�����ѵ�������������
	if (nParam1 != -1 && m_bTargetSelf) 
	{
		nParam1 = -1;
		nParam2 = nLauncher;
	}
	else
	{
		if (nParam1 != -1 || nParam2 <= 0 || nParam2 >= MAX_NPC) return FALSE;
		
		NPC_RELATION  Relation = NpcSet.GetRelation(nLauncher, nParam2);
		
		if (m_bTargetEnemy)
		{
			if (Relation & relation_enemy) 
				goto lab_processdamage;
		}
		
		if (m_bTargetAlly)
		{
			if (Relation & relation_ally) 
				goto lab_processdamage;
		}
		
		if (m_bTargetSelf)
		{
			if (Relation & relation_self) 
				goto lab_processdamage;
		}
		return FALSE;
		
	}
	
lab_processdamage:			
	
	KMissleMagicAttribsData * pAttribsData = CreateMissleMagicAttribsData(nLauncher);
	if (pAttribsData) 
	{
		if (Npc[nParam2].ReceiveDamage(nLauncher, -1, m_bIsMelee, pAttribsData->m_pDamageMagicAttribs, m_bUseAttackRate, m_nDoHurtP, 0))
		{		
			if (pAttribsData->m_nStateMagicAttribsNum > 0)
				Npc[nParam2].SetStateSkillEffect(nLauncher, m_nId, m_ulLevel, pAttribsData->m_pStateMagicAttribs, pAttribsData->m_nStateMagicAttribsNum, pAttribsData->m_pStateMagicAttribs[0].nValue[1]);
			
			if (pAttribsData->m_nImmediateMagicAttribsNum > 0)
				Npc[nParam2].SetImmediatelySkillEffect(nLauncher, pAttribsData->m_pImmediateAttribs, pAttribsData->m_nImmediateMagicAttribsNum);
		}
		return TRUE;
	}
	if (pAttribsData->DelRef() == 0)
		delete pAttribsData;
#endif //_SERVER
	return TRUE;
}

/*!*****************************************************************************
// Function		: KSkill::CastPassivitySkill
// Purpose		: ����
// Return		: BOOL 
// Argumant		: int nLauncher
// Argumant		: int nParam1
// Argumant		: int nParam2
// Argumant		: int nWaitTime
// Comments		:
// Author		: RomanDou
*****************************************************************************/
BOOL KSkill::CastPassivitySkill(int nLauncher, int nParam1, int nParam2, int nWaitTime)  const 
{
#ifdef _SERVER
	//�Ǳ�������ʱ���Ƿ���Ҫ����MissleMagicAttribs?
	KMissleMagicAttribsData * pAttribsData = (KMissleMagicAttribsData*)m_StateAttribs;//CreateMissleMagicAttribsData(nLauncher);
	if (m_nStateAttribsNum > 0)
	{
		Npc[nLauncher].SetStateSkillEffect(nLauncher, m_nId, m_ulLevel, (KMagicAttrib *)m_StateAttribs, m_nStateAttribsNum, -1);
	}
#endif
	return TRUE;
}

// skilllv:BEGIN Phong Than 2026-10-04 skilllv (skill stats per level, like VNG)
// VNG level scripts call the event-skill level "skill_eventskilllevel", but the registry key of
// magic_skill_eventskilllevel is "skill_reserve2": the setting was never parsed and the event
// skill of a profession skill (Dao Si 21, 25) stayed at skills.txt EventSkillLevel (1).
static char* PtSkillLvAttribAlias(DWORD nSkillId, char* pszName)
{
	if (!pszName || !PhongThanIsProfessionSkill((int)nSkillId))
		return pszName;
	if (!strcmp(pszName, "skill_eventskilllevel"))
		return (char*)g_MagicID2String(magic_skill_eventskilllevel);
	return pszName;
}
// VNG formulas such as "3+level/2" return a fraction ("5.5,-1,0"). KSG_StringGetInt stops at the '.',
// the ',' is then not found and the 2nd/3rd values become 0: at odd levels the passive bonus of Giap Si
// 33/34 lost its -1 (permanent) flag and was never applied. Drop the fraction of each number (C truncation,
// the integer the engine already used for the 1st value). Profession skills only.
static char* PtSkillLvFixValue(DWORD nSkillId, char* pszValue, char* pszBuf, int nBufSize)
{
	if (!pszValue || !pszBuf || nBufSize <= 0 || !PhongThanIsProfessionSkill((int)nSkillId) || !strchr(pszValue, '.'))
		return pszValue;
	int n = 0;
	for (const char* p = pszValue; *p && n < nBufSize - 1; ++p)
	{
		if (*p == '.' && p > pszValue && p[-1] >= '0' && p[-1] <= '9')
		{
			while (p[1] >= '0' && p[1] <= '9')
				++p;
			continue;
		}
		pszBuf[n++] = *p;
	}
	pszBuf[n] = 0;
	return pszBuf;
}
// Tooltip: magic_seriesdamage_p is a legacy id (>= 1000) in the Phong Than registry, so the old test
// "type >= ignoredefense_p && type <= seriesdamage_p" hid every damage line of the skill.
// Only ignoredefense_p / seriesdamage_p are printed separately (above the cost line).
static BOOL PtSkillLvShowDamageAttrib(int nType)
{
	if (nType <= 0)
		return FALSE;
	return nType != magic_ignoredefense_p && nType != magic_seriesdamage_p;
}
// Tooltip: immediate (non-state) attributes outside the skill/missile/damage blocks, e.g. the
// attackspeed_v of a Giap Si attack skill, were never printed.
static BOOL PtSkillLvShowImmediateAttrib(int nType)
{
	return nType >= magic_normal_begin && nType < magic_normal_end;
}
// skilllv:END
/*!*****************************************************************************
// Function		: KSkill::ParseString2MagicAttrib
// Purpose		: ����ͨ���ű������õļ�������
// Return		: 
// Argumant		: char * szMagicAttribName
// Argumant		: char * szValue
// Comments		:
// Author		: RomanDou
*****************************************************************************/
BOOL	KSkill::ParseString2MagicAttrib(unsigned long ulLevel, char * szMagicAttribName, char * szValue)  
{
	int nValue1 = 0;
	int nValue2 = 0;
	int nValue3 = 0;
    const char *pcszTemp = NULL;
	if ((!szMagicAttribName) || (!szMagicAttribName[0])) return FALSE;
	// skilllv: VNG alias names (see PtSkillLvAttribAlias)
	szMagicAttribName = PtSkillLvAttribAlias(m_nId, szMagicAttribName);
	char szPtValue[300];
	szValue = PtSkillLvFixValue(m_nId, szValue, szPtValue, sizeof(szPtValue));
	//nValue2 ��ֵΪ-1ʱΪ������״̬��0Ϊ��״̬������ֵΪ��ʱЧ��״̬ħ��Ч��
	//��Ҫ��״̬�������״̬���ݷ��������������Ӧ�������ڣ�����¼������
	for (int i  = 0 ; i <= magic_normal_end; i ++)
	{
	
		if (!strcmp(szMagicAttribName, MagicAttrib2String(i)))
		{
            pcszTemp = szValue;
            nValue1 = KSG_StringGetInt(&pcszTemp, 0);
            KSG_StringSkipSymbol(&pcszTemp, ',');
            nValue2 = KSG_StringGetInt(&pcszTemp, 0);
            KSG_StringSkipSymbol(&pcszTemp, ',');
            nValue3 = KSG_StringGetInt(&pcszTemp, 0);
			if ((i > magic_missle_begin && i < magic_missle_end) || 
				(i > magic_missle_exp_begin && i < magic_missle_exp_end))
			{
				m_MissleAttribs[m_nMissleAttribsNum].nAttribType = i;
				m_MissleAttribs[m_nMissleAttribsNum].nValue[0] = nValue1;
				m_MissleAttribs[m_nMissleAttribsNum].nValue[1] = nValue2;
				m_MissleAttribs[m_nMissleAttribsNum].nValue[2] = nValue3;
				m_nMissleAttribsNum++;
				return TRUE;
			}
			if (i >= magic_addskilldamage1 && i <= magic_addskilldamage9)
			{
                m_AddSkillDamage[m_nAddSkillDamageNum].nAttribType = i; 
                m_AddSkillDamage[m_nAddSkillDamageNum].nValue[0] = nValue1; 
                m_AddSkillDamage[m_nAddSkillDamageNum].nValue[1] = nValue2; 
                m_AddSkillDamage[m_nAddSkillDamageNum].nValue[2] = nValue3; 
				m_nAddSkillDamageNum++;
				return TRUE;
			}
			if (i > magic_skill_begin && i < magic_skill_end)
			{
				switch(i)
				{
				case magic_skill_cost_v:				// ����MANA
					{
						m_nCost = nValue1;
					}
					break;
					
				case magic_skill_costtype_v:
					{
						m_nSkillCostType = (NPCATTRIB)nValue1;
					}
					break;
					
				case magic_skill_mintimepercast_v: 		// ÿ�η�ħ���ļ��ʱ��
					{
						m_nMinTimePerCast = nValue1;
					}
					break;
					
				case magic_skill_misslenum_v:
					{
						m_nChildSkillNum = nValue1;
					}
					break;
					
				case magic_skill_misslesform_v:
					{
						m_eMisslesForm = (eMisslesForm) nValue1;
					}
					break;
				case magic_skill_param1_v:
					{
						m_nValue1 = nValue1;
					}
					break;
				case magic_skill_param2_v:	
					{
						m_nValue2 = nValue2;
					}
					break;
				case magic_skill_eventskilllevel:
					{
						m_nEventSkillLevel = nValue1;
					}
					break;
				case magic_skill_attackradius:
					{
						m_nAttackRadius = nValue1;
					}
					break;
				case magic_skill_showevent:	
					{
						m_nShowEvent = nValue1;
					}
					break;
				case magic_skill_appendskill:
					{
						if(m_nAppendSkillNum >= MAX_APPENDSKILL)
							break;
						m_nAppendSkillId[m_nAppendSkillNum] = nValue1;
						m_nAppendSkillNum++;
					}break;
				}
				return TRUE;
			}
			
			if (i > magic_damage_begin && i < magic_damage_end)
			{
				switch(i)
				{
				case magic_attackrating_v:
				case magic_attackrating_p:
					m_DamageAttribs[0].nAttribType = i;
					m_DamageAttribs[0].nValue[0] = nValue1;
					m_DamageAttribs[0].nValue[1] = nValue2;
					m_DamageAttribs[0].nValue[2] = nValue3;
					m_nDamageAttribsNum ++;
					break;
				case magic_ignoredefense_p:
					m_DamageAttribs[1].nAttribType = i;
					m_DamageAttribs[1].nValue[0] = nValue1;
					m_DamageAttribs[1].nValue[1] = nValue2;
					m_DamageAttribs[1].nValue[2] = nValue3;
					m_nDamageAttribsNum ++;
					break;
				case magic_magicdamage_v:
					m_DamageAttribs[2].nAttribType = i;
					m_DamageAttribs[2].nValue[0] = nValue1;
					m_DamageAttribs[2].nValue[1] = nValue2;
					m_DamageAttribs[2].nValue[2] = nValue3;
					m_nDamageAttribsNum ++;
					break;
				case magic_seriesdamage_p:
					m_DamageAttribs[3].nAttribType = i;
					m_DamageAttribs[3].nValue[0] = nValue1;
					m_DamageAttribs[3].nValue[1] = nValue2;
					m_DamageAttribs[3].nValue[2] = nValue3;
					m_nDamageAttribsNum ++;
					break;
			/*	//TamLTM
				case magic_addskilldamage1:
					m_AddSkillDamage[0].nValue[0] = nValue1;
					m_AddSkillDamage[0].nValue[1] = nValue2;
					break;
				case magic_addskilldamage2:
					m_AddSkillDamage[1].nValue[0] = nValue1;
					m_AddSkillDamage[1].nValue[1] = nValue2;
					break;
				case magic_addskilldamage3:
					m_AddSkillDamage[2].nValue[0] = nValue1;
					m_AddSkillDamage[2].nValue[1] = nValue2;
					break;

				case magic_addskilldamage4:
					m_AddSkillDamage[3].nValue[0] = nValue1;
					m_AddSkillDamage[3].nValue[1] = nValue2;
					break;
				case magic_addskilldamage5:
					m_AddSkillDamage[4].nValue[0] = nValue1;
					m_AddSkillDamage[4].nValue[1] = nValue2;
					break;
				case magic_addskilldamage6:
					m_AddSkillDamage[5].nValue[0] = nValue1;
					m_AddSkillDamage[5].nValue[1] = nValue2;
					break;
				case magic_addskilldamage7:
					m_AddSkillDamage[6].nValue[0] = nValue1;
					m_AddSkillDamage[6].nValue[1] = nValue2;
					break;
				case magic_addskilldamage8:
					m_AddSkillDamage[7].nValue[0] = nValue1;
					m_AddSkillDamage[7].nValue[1] = nValue2;
					break;
				case magic_addskilldamage9:
					m_AddSkillDamage[8].nValue[0] = nValue1;
					m_AddSkillDamage[8].nValue[1] = nValue2;
					break;
				//end code */
				case magic_deadlystrike_p:
					m_DamageAttribs[4].nAttribType = i;
					m_DamageAttribs[4].nValue[0] = nValue1;
					m_DamageAttribs[4].nValue[1] = nValue2;
					m_DamageAttribs[4].nValue[2] = nValue3;
					m_nDamageAttribsNum ++;
					break;
				case magic_fatallystrike_p:
					m_DamageAttribs[5].nAttribType = i;
					m_DamageAttribs[5].nValue[0] = nValue1;
					m_DamageAttribs[5].nValue[1] = nValue2;
					m_DamageAttribs[5].nValue[2] = nValue3;
					m_nDamageAttribsNum ++;
					break;
				case magic_steallife_p:
					m_DamageAttribs[6].nAttribType = i;
					m_DamageAttribs[6].nValue[0] = nValue1;
					m_DamageAttribs[6].nValue[1] = nValue2;
					m_DamageAttribs[6].nValue[2] = nValue3;
					m_nDamageAttribsNum ++;
					break;
				case magic_stealmana_p:
					m_DamageAttribs[7].nAttribType = i;
					m_DamageAttribs[7].nValue[0] = nValue1;
					m_DamageAttribs[7].nValue[1] = nValue2;
					m_DamageAttribs[7].nValue[2] = nValue3;
					m_nDamageAttribsNum ++;
					break;
				case magic_stealstamina_p:					
					m_DamageAttribs[8].nAttribType = i;
					m_DamageAttribs[8].nValue[0] = nValue1;
					m_DamageAttribs[8].nValue[1] = nValue2;
					m_DamageAttribs[8].nValue[2] = nValue3;
					m_nDamageAttribsNum ++;
					break;
				case magic_physicsdamage_v:
				case magic_physicsenhance_p:
					m_DamageAttribs[9].nAttribType = i;
					m_DamageAttribs[9].nValue[0] = nValue1;
					m_DamageAttribs[9].nValue[1] = nValue2;
					m_DamageAttribs[9].nValue[2] = nValue3;
					m_nDamageAttribsNum ++;
					break;
				case magic_colddamage_v:
					m_DamageAttribs[10].nAttribType = i;
					m_DamageAttribs[10].nValue[0] = nValue1;
					m_DamageAttribs[10].nValue[1] = nValue2;
					m_DamageAttribs[10].nValue[2] = nValue3;
					m_nDamageAttribsNum ++;
					break;
				case magic_firedamage_v:
					m_DamageAttribs[11].nAttribType = i;
					m_DamageAttribs[11].nValue[0] = nValue1;
					m_DamageAttribs[11].nValue[1] = nValue2;
					m_DamageAttribs[11].nValue[2] = nValue3;
					m_nDamageAttribsNum ++;
					break;
				case magic_lightingdamage_v:
					m_DamageAttribs[12].nAttribType = i;
					m_DamageAttribs[12].nValue[0] = nValue1;
					m_DamageAttribs[12].nValue[1] = nValue2;
					m_DamageAttribs[12].nValue[2] = nValue3;
					m_nDamageAttribsNum ++;
					break;
				case magic_earthdamage_v:
					m_DamageAttribs[13].nAttribType = i;
					m_DamageAttribs[13].nValue[0] = nValue1;
					m_DamageAttribs[13].nValue[1] = nValue2;
					m_DamageAttribs[13].nValue[2] = nValue3;
					m_nDamageAttribsNum ++;
					break;
				// case magic_poisondamage_v:
				// 	m_DamageAttribs[14].nAttribType = i;
				// 	m_DamageAttribs[14].nValue[0] = nValue1;
				// 	m_DamageAttribs[14].nValue[1] = nValue2;
				// 	m_DamageAttribs[14].nValue[2] = nValue3;
				// 	m_nDamageAttribsNum ++;
				// 	break;
				case magic_stun_p:
					m_DamageAttribs[14].nAttribType = i;
					m_DamageAttribs[14].nValue[0] = nValue1;
					m_DamageAttribs[14].nValue[1] = nValue2;
					m_DamageAttribs[14].nValue[2] = nValue3;
					m_nDamageAttribsNum ++;
					break;
				case magic_ignorenegativestate_p:
					m_DamageAttribs[15].nAttribType = i;
					m_DamageAttribs[15].nValue[0] = nValue1;
					m_DamageAttribs[15].nValue[1] = nValue2;
					m_DamageAttribs[15].nValue[2] = nValue3;
					m_nDamageAttribsNum ++;
					break;
				case magic_randmove:
					m_DamageAttribs[16].nAttribType = i;
					m_DamageAttribs[16].nValue[0] = nValue1;
					m_DamageAttribs[16].nValue[1] = nValue2;
					m_DamageAttribs[16].nValue[2] = nValue3;
					m_nDamageAttribsNum ++;
					break;
				}
				//return TRUE;
			}
			switch (i)
			{
				case magic_physicsres_p:
				//case magic_poisonres_p:
				case magic_coldres_p:
				case magic_fireres_p:
				case magic_lightingres_p:
				case magic_earthres_p:
					m_bSkillReduceResist = TRUE;
					break;
				case magic_lifereplenish_v:
					m_bSkillLifeReplenish = TRUE;
					break;
				case magic_skill_mintimepercastonhorse_v:
					m_nMinTimePerCastOnHorse = nValue1;
					break;
				case magic_skill_collideevent:
					m_bCollideEvent = (BOOL)nValue1;
					m_nCollideSkillId = nValue3;
					break;
				case magic_skill_vanishedevent:
					m_bVanishedEvent = (BOOL)nValue1;
					m_nVanishedSkillId = nValue3;
					break;
				case magic_skill_startevent:
					m_bStartEvent = (BOOL)nValue1;
					m_nStartSkillId = nValue3;
					break;
				case magic_skill_flyevent:
					m_bFlyingEvent = (BOOL)nValue1;
					m_nFlyEventTime = nValue2;
					m_nFlySkillId = nValue3;
					break;
				case magic_skill_dohurt:
					m_nDoHurtP = nValue1;
					break;
				case magic_skill_bymissle:
					m_bByMissle = nValue1;
					break;
			}
			if (nValue2 == 0 || i == magic_skill_flyevent) 
			{
				m_ImmediateAttribs[m_nImmediateAttribsNum].nAttribType = i;
				m_ImmediateAttribs[m_nImmediateAttribsNum].nValue[0] = nValue1;
				m_ImmediateAttribs[m_nImmediateAttribsNum].nValue[1] = nValue2;
				m_ImmediateAttribs[m_nImmediateAttribsNum].nValue[2] = nValue3;
				m_nImmediateAttribsNum ++;
				return TRUE;
			}
			else
			{
				m_StateAttribs[m_nStateAttribsNum].nAttribType = i;
				m_StateAttribs[m_nStateAttribsNum].nValue[0] = nValue1;
				m_StateAttribs[m_nStateAttribsNum].nValue[1] = nValue2;
				m_StateAttribs[m_nStateAttribsNum].nValue[2] = nValue3;
				m_nStateAttribsNum ++;
				return TRUE;
			}
			
		}
	}
	return FALSE;
}

const char * KSkill::MagicAttrib2String(int MagicAttrib)  const 
{
	return 	g_MagicID2String(MagicAttrib);
}

#ifndef _SERVER
void	KSkill::DrawSkillIcon(int x, int y, int Width, int Height)  
{
	
	if (!m_szSkillIcon[0]) return ;
	
	m_RUIconImage.nType = ISI_T_SPR;
	m_RUIconImage.Color.Color_b.a = 255;
	m_RUIconImage.bRenderStyle = IMAGE_RENDER_STYLE_ALPHA;
	m_RUIconImage.uImage = 0;
	m_RUIconImage.nISPosition = IMAGE_IS_POSITION_INIT;
	m_RUIconImage.bRenderFlag = 0;
	strcpy(m_RUIconImage.szImage, m_szSkillIcon);
	m_RUIconImage.oPosition.nX = x;
	m_RUIconImage.oPosition.nY = y;
	m_RUIconImage.oPosition.nZ = 0;
	m_RUIconImage.nFrame = 0;
	g_pRepresent->DrawPrimitives(1, &m_RUIconImage, RU_T_IMAGE, 1);

	/*KRUShadow	Shadow;			
	Shadow.Color.Color_dw = 0xFF0000;
	Shadow.oPosition.nX = x;
	Shadow.oPosition.nY = y;// + (Height - Height * nPercent / 100);
	Shadow.oEndPos.nX = x + Width;
	Shadow.oEndPos.nY = y + Height;
	g_pRepresent->DrawPrimitives(1, &Shadow, RU_T_SHADOW , FALSE);*/
}

void	KSkill::GetDesc(unsigned long ulSkillId, unsigned long ulCurLevel, char * pszMsg, int nOwnerIndex,  bool bNextLevelDesc)
{
	
	if (!pszMsg) return;
	if (nOwnerIndex <= 0 )	return ;

	char szTemp[256];
	
	KSkill * pTempSkill = NULL;
	KSkill * pCurSkill = NULL;
	KSkill * pNextSkill = NULL;
	if(ulCurLevel == 0)
	{
		pNextSkill = (KSkill *)g_SkillManager.GetSkill(ulSkillId, 1);
		pTempSkill = pNextSkill;
	}
	else
	{
		pCurSkill = (KSkill *) g_SkillManager.GetSkill(ulSkillId, ulCurLevel);
		pNextSkill = (KSkill *) g_SkillManager.GetSkill(ulSkillId, ulCurLevel + 1);
		pTempSkill = pCurSkill;
	}
	
	int nLevel = Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_SkillList.GetLevel(ulSkillId);
	int nAddLevel = Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_SkillList.GetAddLevel(ulSkillId);
	if (pTempSkill == NULL)
	{
		return;
	}
	
	strcat(pszMsg, "<color=255,255,0>");
	char displayName[128];
	PhongThanPlainItemName(pTempSkill->m_szName, displayName, sizeof(displayName));
	strcat(pszMsg, displayName);
	if (PhongThanIsProfessionSkill(ulSkillId))
	{
		int profession = ulSkillId <= PHONGTHAN_DAOSHI_SKILL_LAST ? 1 :
			(ulSkillId <= PHONGTHAN_JIASHI_SKILL_LAST ? 0 : 2);
		strcat(pszMsg, " (");
		strcat(pszMsg, g_Profession.GetName(profession));
		strcat(pszMsg, ")");
	}
	else switch(pTempSkill->m_nSeries)
	{
	case series_metal:
		strcat(pszMsg, "(h\xd6 Kim)");
		break;
	case series_wood:
		strcat(pszMsg, "(h\xd6 M\xe9""c)");
		break;
	case series_water:
		strcat(pszMsg, "(h\xd6 Th\xf1y)");
		break;
	case series_fire:
		strcat(pszMsg, "(h\xd6 H\xe1""a)");
		break;
	case series_earth:
		strcat(pszMsg, "(h\xd6 Th\xe6)");
		break;
	}
	strcat(pszMsg, "\n");
	if (Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_Level < pTempSkill->GetSkillReqLevel())
	{
		sprintf(szTemp, "<color=255,255,255>\xa7\xbcng c\xcap y\xaau c\xc7u: %d", pTempSkill->GetSkillReqLevel());
		strcat(pszMsg, szTemp);
	}
	strcat (pszMsg, "\n<color=255,255,255>");	
	
	int nStrL = sprintf(szTemp, "%s", pTempSkill->m_szSkillDesc);
	int offset = 0, nL = 0;

	while(szTemp[offset] != 0)
	{
		if(szTemp[offset] == '<')
		{
			if(szTemp[offset+1] == 'e' &&
				szTemp[offset+2] == 'n' &&
				szTemp[offset+3] == 't' &&
				szTemp[offset+4] == 'e' &&
				szTemp[offset+5] == 'r' &&
				szTemp[offset+6] == '>')
				nL = 0;
			if(szTemp[offset+1] == 'c' &&
				szTemp[offset+2] == 'o' &&
				szTemp[offset+3] == 'l' &&
				szTemp[offset+4] == 'o' &&
				szTemp[offset+5] == 'r')
			{
				if (szTemp[offset+6] == '>')
					nL -= 6;
				else
				{
					int k;
					for(k = 0; k<12; k++)
					{
						if(szTemp[offset+6+k] == '>') 
							break;
					}
					nL -= 6+k;
				}
			}
			if(szTemp[offset+1] == 'b' &&
				szTemp[offset+2] == 'c' &&
				szTemp[offset+3] == 'l' &&
				szTemp[offset+4] == 'r')
			{
				if (szTemp[offset+5] == '>')
					nL -= 5;
				else
				{
					if (szTemp[offset+5] == '=')
					{
						int k;
						for(k = 0; k<12; k++)
						{
							if(szTemp[offset+5+k] == '>') 
								break;
						}
						nL -= 5+k;
					}
				}
			}
		}

		if(nL == 32 && (offset+7) <nStrL)
		{
			memmove(&szTemp[offset+7], &szTemp[offset], nStrL-offset+1);
			memcpy(&szTemp[offset],"<enter>",7);
			offset += 7;
			nStrL += 7;
			nL = 0;
		}
		offset++;
		nL++;
	}
    if(strlen(szTemp) > 255)
    szTemp[255] = 0;
    ::memcpy(szTemp, szTemp, 256);
	if (szTemp[0])
	{
		strcat(pszMsg, szTemp);
		strcat(pszMsg, "\n\n");
	}
	if (!pTempSkill->IsBase())
	{
		KIniFile Ini;
		Ini.Load(GAME_SETTING_FILE_INI);
	
		char cbBuffer[16];
		itoa(pTempSkill->GetAttribType(), cbBuffer, 10);
		Ini.GetString("SkillAttrib", cbBuffer, "", szTemp, sizeof(szTemp));
		if (szTemp[0])
		{
			strcat(pszMsg, szTemp);
			strcat (pszMsg, "\n\n");
		}
	}
	if (!Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_SkillList.IsBaseSkill(ulSkillId) ||
		PhongThanIsProfessionSkill(ulSkillId))	// skilllv: profession attack skills are Attrib 1 (IsBase)
	{
		if (nAddLevel > 0)
		{
			if (ulCurLevel)
				sprintf(szTemp, "<color=100,100,255>\xa7\xbcng c\xcap hi\xd6n th\xeai: %d (%d+%d)<color>\n" ,ulCurLevel, nLevel, nAddLevel);
			else
				sprintf(szTemp, "\xa7\xbcng c\xcap hi\xd6n th\xeai: %d\n", ulCurLevel);
		}
		else
			sprintf(szTemp, "\xa7\xbcng c\xcap hi\xd6n th\xeai: %d\n", ulCurLevel);
		strcat(pszMsg, szTemp);
	}
	// skilllv:BEGIN max level (skills.txt MaxLevel, the cap the server uses) + extrapolation note
	if (PhongThanIsProfessionSkill(ulSkillId))
	{
		int nPtMax = (int)g_SkillManager.GetSkillMaxLevel(ulSkillId);
		if (nPtMax > 0)
		{
			sprintf(szTemp, "\xa7\xbcng c\xcap t\xe8i \xae""a: %d\n", nPtMax);
			strcat(pszMsg, szTemp);
			if ((int)ulCurLevel > nPtMax)
				strcat(pszMsg, "<color=255,180,0>(V\xad\xeet c\xcap t\xe8i \xae""a: ch\xd8 s\xe8 ngo\xb9i suy theo c\xabng th\xf8""c c\xcap VNG)<color>\n");
		}
	}
	// skilllv:END

    int nAddSkillDamage = Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_SkillList.GetAddSkillDamage(ulSkillId); 
    if (nAddSkillDamage) 
    { 
        sprintf(szTemp, "H\xe7 tr\xee t\xf5 c\xb8""c k\xfc n\xa8ng kh\xb8""c: %d%%", nAddSkillDamage); 
        strcat(pszMsg, szTemp); 
        strcat(pszMsg, "\n"); 
    }

    int nSkillEnhance = Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_CurrentSkillEnhancePercent; 
    if (nSkillEnhance && 
		(pTempSkill->GetSkillStyle() == SKILL_SS_Missles || 
		pTempSkill->GetSkillStyle() == SKILL_SS_Melee) && 
		pTempSkill->IsTargetEnemy() && 
		!pTempSkill->IsBase()) 
    { 
        sprintf(szTemp, "Trang b\xde t\xa8ng k\xfc n\xa8ng: %d%%", nSkillEnhance); 
        strcat(pszMsg, szTemp); 
        strcat(pszMsg, "\n"); 
    }
	
	int i = 0;
	
	if (pCurSkill)
	{
		pCurSkill->GetDescAboutLevel(ulSkillId, pszMsg);
	}
	
	if (-2 !=pTempSkill->m_nEquiptLimited)
	{
		strcat(pszMsg, "\n");
		switch(pTempSkill->m_nEquiptLimited)
		{
		case -2:
			g_GameSetting.GetString("WeaponLimit", "F2", "", szTemp, sizeof(szTemp));
			strcat(pszMsg, szTemp);
			break;
		case -1:
			g_GameSetting.GetString("WeaponLimit", "F1", "", szTemp, sizeof(szTemp));
			strcat(pszMsg, szTemp);
			break;
		case 0:
			g_GameSetting.GetString("WeaponLimit", "0", "", szTemp, sizeof(szTemp));
			strcat(pszMsg, szTemp);
			break;
		case 1:
			g_GameSetting.GetString("WeaponLimit", "1", "", szTemp, sizeof(szTemp));
			strcat(pszMsg, szTemp);
			break;
		case 2:
			g_GameSetting.GetString("WeaponLimit", "2", "", szTemp, sizeof(szTemp));
			strcat(pszMsg, szTemp);
			break;
		case 3:
			g_GameSetting.GetString("WeaponLimit", "3", "", szTemp, sizeof(szTemp));
			strcat(pszMsg, szTemp);
			break;
		case 4:
			g_GameSetting.GetString("WeaponLimit", "4", "", szTemp, sizeof(szTemp));
			strcat(pszMsg, szTemp);
			break;
		case 5:
			g_GameSetting.GetString("WeaponLimit", "5", "", szTemp, sizeof(szTemp));
			strcat(pszMsg, szTemp);
			break;
		case 101:
			g_GameSetting.GetString("WeaponLimit", "101", "", szTemp, sizeof(szTemp));
			strcat(pszMsg, szTemp);
			break;	
		case 102:
			g_GameSetting.GetString("WeaponLimit", "102", "", szTemp, sizeof(szTemp));
			strcat(pszMsg, szTemp);
			break;
		case 100:
			g_GameSetting.GetString("WeaponLimit", "100", "", szTemp, sizeof(szTemp));
			strcat(pszMsg, szTemp);
			break;
		}
		strcat(pszMsg, "\n");
	}

	if (pTempSkill->m_nHorseLimited)
	{
		if (-2 == pTempSkill->m_nEquiptLimited)
			strcat(pszMsg, "\n");

		switch(pTempSkill->m_nHorseLimited)
		{
		case 1:
			{
				g_GameSetting.GetString("HorseLimit", "1", "", szTemp, sizeof(szTemp));
				strcat(pszMsg, szTemp);
				strcat(pszMsg, "\n");
			}
			break;
		case 2:
			{
				g_GameSetting.GetString("HorseLimit", "2", "", szTemp, sizeof(szTemp));
				strcat(pszMsg, szTemp);
				strcat(pszMsg, "\n");
			}
			break;
		default:
			break;
		}
	}

	if (bNextLevelDesc)
	{
		// skilllv: a profession skill at its MaxLevel cannot be raised any more: no next level
		if (pNextSkill && PhongThanIsProfessionSkill(ulSkillId) &&
			(int)g_SkillManager.GetSkillMaxLevel(ulSkillId) > 0 &&
			nLevel >= (int)g_SkillManager.GetSkillMaxLevel(ulSkillId))
			pNextSkill = NULL;
		if (pNextSkill)
		{
			strcat(pszMsg, "\n<color=255,0,0>\xa7\xbcng c\xcap k\xd5 ti\xd5p\n\n");
			if (PhongThanIsProfessionSkill(ulSkillId) &&
				(int)(ulCurLevel + 1) > (int)g_SkillManager.GetSkillMaxLevel(ulSkillId))
				strcat(pszMsg, "<color=255,180,0>(V\xad\xeet c\xcap t\xe8i \xae""a: ch\xd8 s\xe8 ngo\xb9i suy theo c\xabng th\xf8""c c\xcap VNG)<color>\n");
			pNextSkill->GetDescAboutLevel(ulSkillId, pszMsg, bNextLevelDesc);
		}
		else
		{
			
		}
	}

}

void KSkill::GetDescAboutLevel(unsigned long ulSkillId, char * pszMsg, BOOL bNextLevel/* = FALSE*/, BOOL bAddSkillDamage/* = FALSE*/, BOOL bEventSkill/* = FALSE*/)
{
	char pszInfo[SZBUFLEN_0];
	if (!Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_SkillList.IsTempSkill(ulSkillId))
	{
		int nLevel = Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_SkillList.GetLevel(ulSkillId);
		if (nLevel > 0 && nLevel < MAX_SKILLLEVEL)
		{
			if (m_nIsExpSkill && !bNextLevel && !bAddSkillDamage)
			{ 
				int nExp = Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_SkillList.GetExp(ulSkillId);
				int nNextExp = Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_SkillList.GetNextExp(ulSkillId);
				
				if (nNextExp)
				{
					//Muc do luyen skill
					float fPer = (float)(nExp * MAX_PERCENT / nNextExp);
				//	if (nLevel >= 20)
				//		sprintf(pszInfo, "M\xf8""c \xae\xe9 luy\xd6n: <color=255,0,0>Max R\xe5i<color> <color=9,255,0>%0.2f%%<color>.", fPer);
				//	else
					sprintf(pszInfo, "M\xf8""c \xae\xe9 luy\xd6n: <color=25,141,250>%0.2f%%<color>", fPer);
					strcat(pszMsg, pszInfo); 
					strcat(pszMsg, "\n");
				}
			} 
		}
	}
	//�ӵ���������Լ�����ɵ��˺�
	//KMagicAttrib *DamageAttribs[MAX_MISSLE_DAMAGEATTRIB];
	KMagicAttrib *DamageAttribs = m_DamageAttribs;
	//������ҵĻ������ԣ�ȷ���ӵ����˺�

	if (!bNextLevel && !bAddSkillDamage && (!IsBase() || PhongThanIsProfessionSkill((int)m_nId)))
		strcat(pszMsg, "\n");

	for (int i = 0; i < MAX_MISSLE_DAMAGEATTRIB; i++)
	{
		if (!(DamageAttribs + i)->nAttribType) continue;
		if ((DamageAttribs + i)->nAttribType == magic_seriesdamage_p && !bEventSkill)
		{
			sprintf(pszInfo, "Ng\xf2 h\xb5nh t\xad\xacng kh\xbe""c: %d%%", (DamageAttribs + i)->nValue[0]);
			strcat(pszMsg, pszInfo);
			strcat(pszMsg, "\n");
		}
		else if ((DamageAttribs + i)->nAttribType == magic_ignoredefense_p && !bEventSkill)
		{
			sprintf(pszInfo, "B\xe1 qua n\xd0 tr\xb8nh: %d%%", (DamageAttribs + i)->nValue[0]);  //fix hien thi bo qua ne tranh TamLTM;
			strcat(pszMsg, pszInfo);
			strcat(pszMsg, "\n");
		}
	}

	int nGetCost = GetSkillCost(NULL);

	if (nGetCost && !bAddSkillDamage)
	{
		switch(m_nSkillCostType)
		{
		case attrib_mana_v:
			sprintf(pszInfo, "Ti\xaau hao n\xe9i l\xf9""c: %d\n", nGetCost);
			break;
		case attrib_mana_p:
			nGetCost = Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_CurrentManaMax * GetSkillCost(NULL) / MAX_PERCENT;
			sprintf(pszInfo, "Ti\xaau hao n\xe9i l\xf9""c: %d\n", nGetCost);
			break;
		case attrib_stamina_v:
			sprintf(pszInfo, "Ti\xaau hao th\xd3 l\xf9""c: %d\n", nGetCost);
			break;
		case attrib_stamina_p:
			nGetCost = Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_CurrentStaminaMax * GetSkillCost(NULL) / MAX_PERCENT;
			sprintf(pszInfo, "Ti\xaau hao th\xd3 l\xf9""c: %d\n", nGetCost);
			break;
		case attrib_life_v:
			sprintf(pszInfo, "Ti\xaau hao sinh l\xf9""c: %d\n", nGetCost);
			break;
		case attrib_life_p:
			nGetCost = Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_CurrentLifeMax * GetSkillCost(NULL) / MAX_PERCENT;
			sprintf(pszInfo, "Ti\xaau hao sinh l\xf9""c: %d\n", nGetCost);
			break;
		}
		strcat(pszMsg,pszInfo);
	}
	
	int nAttackRadius = GetAttackRadius();
	if (nAttackRadius && !bAddSkillDamage)
	{
		sprintf(pszInfo,"Ph\xb9m vi hi\xd6u qu\xb6: %d\n", nAttackRadius);
		strcat(pszMsg,pszInfo);
	}

	//����ȼ��仯�������˺�
	/*for (i  = 0; i < m_nImmediateAttribsNum; i ++)
	{
		if (!m_ImmediateAttribs[i].nAttribType || 
			(m_ImmediateAttribs[i].nAttribType > magic_damage_begin && 
			m_ImmediateAttribs[i].nAttribType < magic_damage_end)) continue;
		char * pszInfo = (char *)g_MagicDesc.GetDesc(&m_ImmediateAttribs[i]);
		if (!pszInfo) continue;
		strcat(pszMsg, pszInfo);
		strcat(pszMsg, "\n");
	}*/

	if (m_szMagicSkillDesc[0])
		strcat(pszMsg, m_szMagicSkillDesc);	

	for (i = 0; i < MAX_MISSLE_DAMAGEATTRIB; i ++)
	{ 
		// skilllv: was "type >= ignoredefense_p && type <= seriesdamage_p" (hid all damage lines)
		if (!PtSkillLvShowDamageAttrib((DamageAttribs + i)->nAttribType)) continue;

		char * pszInfo = (char *)g_MagicDesc.GetDesc((DamageAttribs + i));
		if (pszInfo[0])
		{
			strcat(pszMsg, pszInfo); 
			strcat(pszMsg, "\n"); 
		}
	}

	// skilllv:BEGIN immediate attributes (see PtSkillLvShowImmediateAttrib)
	for (i = 0; i < m_nImmediateAttribsNum; i ++)
	{
		if (!PtSkillLvShowImmediateAttrib(m_ImmediateAttribs[i].nAttribType)) continue;
		const char * pszPtImm = g_MagicDesc.GetDesc(&m_ImmediateAttribs[i]);
		if (pszPtImm && pszPtImm[0])
		{
			strcat(pszMsg, pszPtImm);
			strcat(pszMsg, "\n");
		}
	}
	// skilllv:END

	//״̬����Ч��
	if(m_nAppendSkillNum)
	{
		for (i = 0; i < m_nAppendSkillNum; i ++)
		{
			if (m_nAppendSkillId[i] <= 0 || m_nAppendSkillId[i] >= MAX_SKILL)
				continue;
			int nSkillLevel = Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_SkillList.GetCurrentLevel(m_nAppendSkillId[i]);
			if (nSkillLevel > GetSkillLevel())
				nSkillLevel = GetSkillLevel();
			if (nSkillLevel > 0)
			{
				KSkill * pTempSkill;
				pTempSkill = (KSkill *) g_SkillManager.GetSkill(m_nAppendSkillId[i], nSkillLevel);
				if(pTempSkill)
				{
					sprintf(pszInfo, "<color=100,100,255>T\xc7ng %d:<color><color=255,255,0> ", i+2);
					strcat(pszMsg, pszInfo);
					strcat(pszMsg, pTempSkill->GetSkillName());
					strcat(pszMsg, "<color>\n");
					pTempSkill->GetDescAboutLevel(ulSkillId, pszMsg, FALSE, TRUE, TRUE);
				}
			}
		}
	}

	for (i  = 0; i < m_nStateAttribsNum; i ++)
	{
		if (!m_StateAttribs[i].nAttribType || 
			(m_StateAttribs[i].nAttribType > magic_damage_begin && 
			m_StateAttribs[i].nAttribType < magic_damage_end)) continue;
		char* pszInfo = (char *)g_MagicDesc.GetDesc(&m_StateAttribs[i]);
		if (pszInfo[0])
		{
			strcat(pszMsg, pszInfo); 
			strcat(pszMsg, "\n"); 
		}
	}

	int nNum = 0;
	if(m_nShowEvent)
	{
		for (i  = 0; i < m_nImmediateAttribsNum; i ++)
		{
			if (m_ImmediateAttribs[i].nAttribType >= magic_skill_collideevent && m_ImmediateAttribs[i].nAttribType <= magic_skill_flyevent && m_ImmediateAttribs[i].nValue[0])
			{
				KSkill * pTempSkill = (KSkill *) g_SkillManager.GetSkill(m_ImmediateAttribs[i].nValue[2], m_nEventSkillLevel);
				if(bEventSkill)
					sprintf(pszInfo, "\n<color=100,100,255>T\xc7ng ph\xf4 %d:<color><color=255,255,0> ", nNum+2);
				else
					sprintf(pszInfo, "\n<color=100,100,255>T\xc7ng %d:<color><color=255,255,0> ", nNum+2);
				strcat(pszMsg,pszInfo);
				strcat(pszMsg, pTempSkill->GetSkillName());
				strcat(pszMsg, "<color>\n");
				pTempSkill->GetDescAboutLevel(ulSkillId, pszMsg, FALSE, TRUE, TRUE);
				nNum++;

				if(nNum >= m_nShowEvent)
					break;
			}
		}

		if(nNum <= 0)
		{
			if(m_bStartEvent && m_nStartSkillId && m_nEventSkillLevel)
			{
				KSkill * pTempSkill = (KSkill *) g_SkillManager.GetSkill(m_nStartSkillId, m_nEventSkillLevel);
				if(bEventSkill)
					sprintf(pszInfo, "\n<color=100,100,255>T\xc7ng ph\xf4 %d:<color><color=255,255,0> ", nNum+2);
				else
					sprintf(pszInfo, "\n<color=100,100,255>T\xc7ng %d:<color><color=255,255,0> ", nNum+2);
				strcat(pszMsg,pszInfo);
				strcat(pszMsg, pTempSkill->GetSkillName());
				strcat(pszMsg, "<color>\n");
				pTempSkill->GetDescAboutLevel(ulSkillId, pszMsg, FALSE, TRUE, TRUE);
			}
		}
	}

	nNum = 0;
	if(m_nAddSkillDamageNum > 0)
	{
		for ( i  = 0; i < m_nAddSkillDamageNum; i ++) 
		{ 
			if (m_AddSkillDamage[i].nValue[0] <= 0) continue; 
			KSkill * pTempSkill = (KSkill *) g_SkillManager.GetSkill(m_AddSkillDamage[i].nValue[0], 1);

			if (pTempSkill)
			{
				if (pTempSkill->GetShowAddition())
				{
					if(nNum == 0)
					{
						strcat(pszMsg, "\n"); 
						nNum++;
					}
					sprintf(pszInfo, "K\xfc n\xa8ng %s: +%d%%", pTempSkill->GetSkillName(), m_AddSkillDamage[i].nValue[2]);
					strcat(pszMsg, pszInfo); 
					strcat(pszMsg, "\n"); 
				}
			}
		}
	}
}

void KSkill::PlayPreCastSound(BOOL bIsFeMale, int nX, int nY)  const 
{
	char * pSoundFile = NULL;
	
	if (!bIsFeMale)
		pSoundFile = (char *)m_szManPreCastSoundFile;
	else 
		pSoundFile = (char *)m_szFMPreCastSoundFile;
	
	int		nCenterX = 0, nCenterY = 0, nCenterZ = 0;
	
	// �����Ļ���ĵ�ĵ�ͼ���� not end
	g_ScenePlace.GetFocusPosition(nCenterX, nCenterY, nCenterZ);
	KCacheNode * pSoundNode = NULL;
	pSoundNode = (KCacheNode*) g_SoundCache.GetNode(pSoundFile, (KCacheNode*)pSoundNode);
	KWavSound * pWave = (KWavSound*)pSoundNode->m_lpData;
	if (pWave)
	{
		pWave->Play((nX - nCenterX) * 5, (10000 - (abs(nX - nCenterX) + abs(nY - nCenterY))) * Option.GetSndVolume() / 100 - 10000, 0);
	}
}
#endif

//---new
BOOL KSkill::CastStateSkill( int nLauncher, int nParam1, int nParam2, int nWaitTime, BOOL bOverLook) const
{
#ifdef _SERVER
	//�Ǳ�������ʱ���Ƿ���Ҫ����MissleMagicAttribs?
	KMissleMagicAttribsData * pAttribsData = (KMissleMagicAttribsData*)m_StateAttribs;//CreateMissleMagicAttribsData(nLauncher);
	if (m_nStateAttribsNum > 0)
	{
		Npc[nLauncher].SetStateSkillEffect(nLauncher, m_nId, m_ulLevel, (KMagicAttrib *)m_StateAttribs, m_nStateAttribsNum, nWaitTime, bOverLook);
	}
#endif
	return TRUE;
}
