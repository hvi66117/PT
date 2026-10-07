 #include "KEngine.h"
#include "KCore.h"
#include "SkillDef.h"
#include "KSkillList.h"
#include "KSkills.h"
#include "KThiefSkill.h"
#include "KPlayer.h"
#include "KPlayerSet.h"
#include "KPhongThanProfessionSkills.h"

#ifndef _SERVER
#include "cOREsHELL.H"
#endif

KSkillList::KSkillList()
{
	ZeroMemory(m_Skills, sizeof(NPCSKILL) * MAX_NPCSKILL);
	m_nAllSkillV = 0;
	m_nNpcIndex = 0;
}

KSkillList::~KSkillList()
{
}


static int g_CallCount = 0;

int	KSkillList::FindSame(int nSkillID)
{
    g_CallCount++;

	if (!nSkillID)
		return 0;
	
	for (int i=1; i<MAX_NPCSKILL; i++)
	{
		if (m_Skills[i].SkillId == nSkillID)
		{
			return i;
		}
	}
	return 0;	
}

int KSkillList::FindFree()
{
	for (int i = 1; i < MAX_NPCSKILL; i++)
	{
		if (!m_Skills[i].SkillId)
		{
			return i;
		}
	}
	return 0;	
}

#ifdef _SERVER
void KSkillList::SetNpcSkill(int nSkillNo, int nSkillId, int nSkillLevel)
{
	if (nSkillNo <= 0 || nSkillLevel <= 0 || nSkillId <= 0)
		return ;
	if (nSkillNo >= MAX_NPCSKILL) 
		return ;
	
	m_Skills[nSkillNo].SkillId = nSkillId;
	m_Skills[nSkillNo].SkillLevel = nSkillLevel;
	m_Skills[nSkillNo].AddLevel = m_nAllSkillV;
	m_Skills[nSkillNo].CurrentSkillLevel = nSkillLevel;
	m_Skills[nSkillNo].SkillExp = 0;
	m_Skills[nSkillNo].NextSkillExp = 0;
	m_Skills[nSkillNo].TempSkill = FALSE;
	m_Skills[nSkillNo].MaxTimes = 0;
	m_Skills[nSkillNo].RemainTimes = 0;
	m_Skills[nSkillNo].NextCastTime = 0;
	m_Skills[nSkillNo].WaitCastTime = 0;

	_ASSERT(nSkillId > 0 && nSkillLevel > 0);
	KSkill * pOrdinSkill = (KSkill *) g_SkillManager.GetSkill(nSkillId, nSkillLevel);
	if (!pOrdinSkill) 
        return ;

    if (pOrdinSkill->GetSkillStyle() == SKILL_SS_InitiativeNpcState ||
		pOrdinSkill->GetSkillStyle() == SKILL_SS_PassivityNpcState)
	{
		pOrdinSkill->Cast(m_nNpcIndex, -1, m_nNpcIndex);
	}
	
	if (pOrdinSkill->IsAura())
	{
		Npc[m_nNpcIndex].SetAuraSkill(m_Skills[nSkillNo].SkillId);
	}
}

void KSkillList::RemoveNpcSkill(int nSkillNo)
{
	if (nSkillNo <= 0 )
		return ;
	if (nSkillNo >= MAX_NPCSKILL) 
		return ;
	
	_ASSERT(m_Skills[nSkillNo].SkillId > 0);
	KSkill * pOrdinSkill = (KSkill *) g_SkillManager.GetSkill(m_Skills[nSkillNo].SkillId, 1);
	if (!pOrdinSkill) 
        return ;

	if (pOrdinSkill->IsAura() && Npc[m_nNpcIndex].m_ActiveAuraID == m_Skills[nSkillNo].SkillId)
	{
		Npc[m_nNpcIndex].SetAuraSkill(0);
	}

	m_Skills[nSkillNo].SkillId = 0;
	m_Skills[nSkillNo].SkillLevel = 0;
	m_Skills[nSkillNo].AddLevel = m_nAllSkillV;
	m_Skills[nSkillNo].CurrentSkillLevel = 0;
	m_Skills[nSkillNo].SkillExp = 0;
	m_Skills[nSkillNo].NextSkillExp = 0;
	m_Skills[nSkillNo].TempSkill = FALSE;
	m_Skills[nSkillNo].MaxTimes = 0;
	m_Skills[nSkillNo].RemainTimes = 0;
	m_Skills[nSkillNo].NextCastTime = 0;
	m_Skills[nSkillNo].WaitCastTime = 0;
}

// skilllv:BEGIN Phong Than 2026-10-04 skilllv
// A passive profession skill (style 3) is cast once, when it is learned or loaded, at the level of that
// moment. Bonus levels from equipment (AllSkillV / SeriesSkillV, re-applied by KPlayer::UpdataCurData)
// never re-cast it, so +skill items did nothing for passives. Called at the end of UpdataCurData:
// re-cast every profession passive whose state level differs from CurrentSkillLevel, after removing the
// old state the same way KNpc::IgnoreState does.
void KSkillList::PtSkillLvRefreshPassive()
{
	if (m_nNpcIndex <= 0)
		return;
	KNpc* pNpc = &Npc[m_nNpcIndex];
	for (int i = 1; i < MAX_NPCSKILL; i++)
	{
		const int nId = m_Skills[i].SkillId;
		if (!PhongThanIsProfessionSkill(nId) || m_Skills[i].TempSkill || m_Skills[i].SkillLevel <= 0)
			continue;
		const int nCur = m_Skills[i].CurrentSkillLevel;
		if (nCur <= 0 || nCur >= MAX_SKILLLEVEL)
			continue;
		KSkill* pSkill = (KSkill*)g_SkillManager.GetSkill(nId, nCur);
		if (!pSkill || pSkill->GetSkillStyle() != SKILL_SS_PassivityNpcState || pSkill->GetStateAttribsNum() <= 0)
			continue;
		BOOL bKeep = FALSE;
		KStateNode* pNode = (KStateNode*)pNpc->m_StateSkillList.GetHead();
		while (pNode)
		{
			KStateNode* pNext = (KStateNode*)pNode->GetNext();
			if (pNode->m_SkillID == nId)
			{
				if (!bKeep && pNode->m_Level == nCur)
					bKeep = TRUE;
				else
				{
					if (pNode->m_LeftTime != 0)
					{
						for (int k = 0; k < MAX_SKILL_STATE; k++)
						{
							if (pNode->m_State[k].nAttribType)
								pNpc->ModifyAttrib(m_nNpcIndex, &pNode->m_State[k]);
						}
					}
					pNode->Remove();
					delete pNode;
				}
			}
			pNode = pNext;
		}
		if (!bKeep)
			pSkill->Cast(m_nNpcIndex, -1, m_nNpcIndex);
	}
}
// skilllv:END
#endif

int KSkillList::GetCount()
{
	int nCount = 0;
	
	for (int i = 1; i < MAX_NPCSKILL; i++)
	{
		if (m_Skills[i].SkillId)
		{
			nCount++;
		}
	}
	return nCount;
}

#ifndef _SERVER
void KSkillList::SetSkillLevel(int nId/*���ܵ�ID��*/, int nLevel)
{
	int i = FindSame(nId);
	
	if (!i)
	{
		Add(nId, nLevel);
		return;		
	}
	else
		//m_Skills[i].SkillLevel = nLevel;
		SetLevel(i, nLevel);
}
#endif

#ifndef _SERVER
BOOL KSkillList::SetLevel(int nIndex/*�����б���������*/, int nLevel)
{
	if (nIndex <= 0 || nIndex >= MAX_NPCSKILL)
		return FALSE;
	if (nLevel < 0 || nLevel >= MAX_SKILLLEVEL)
		return FALSE;
	
	int nInc = nLevel - m_Skills[nIndex].SkillLevel;
	// skilllv:BEGIN the level comes from the server (authoritative). IncreaseLevel refuses levels above
	// skills.txt MaxLevel and every decrease, so the client kept a stale SkillLevel (e.g. 10 instead of
	// 15 after SetSkillLevel, or the old level after a skill reset). Accept the server value as is.
	if (nInc == 0)
		return TRUE;
	if (nInc > 0 && IncreaseLevel(nIndex, nInc))
		return TRUE;
	m_Skills[nIndex].SkillLevel = nLevel;
	m_Skills[nIndex].CurrentSkillLevel = nLevel + m_Skills[nIndex].AddLevel;
	m_Skills[nIndex].NextSkillExp = PlayerSet.m_cMagicLevelExp.GetNextExp(m_Skills[nIndex].SkillId, nLevel);
	// skilllv:END
	return TRUE;
}

BOOL KSkillList::SetExp(int nIndex/*�����б���������*/, int nExp)
{
	if (nIndex <= 0 || nIndex >= MAX_NPCSKILL)
		return FALSE;

	m_Skills[nIndex].SkillExp = nExp;
	return TRUE;
}
#endif

BOOL KSkillList::IsBaseSkill(int nSkillId)
{
	if (nSkillId < 0)
		return FALSE;

	if (nSkillId > 0)
	{
		KSkill * pOrdinSkill = (KSkill *)g_SkillManager.GetSkill(nSkillId, 1);
		if (!pOrdinSkill) 
			return FALSE;
		
		return pOrdinSkill->IsBase();
	}
	return FALSE;
}

void KSkillList::AllSkillV(int nSkillId, int nLevel)
{
	if (nSkillId < 0)
		return;

	if (nSkillId > 0)
	{
		int i = FindSame(nSkillId);
		if (i)
		{
			if (m_Skills[i].TempSkill)
			{
				m_Skills[i].SkillLevel += nLevel;
				m_Skills[i].AddLevel = m_nAllSkillV;
				m_Skills[i].CurrentSkillLevel = m_Skills[i].SkillLevel + m_Skills[i].AddLevel;
				if (m_Skills[i].SkillLevel <= 0)
					RemoveIdx(i);
			}
			else
			{
				m_Skills[i].AddLevel += nLevel;
				m_Skills[i].CurrentSkillLevel += nLevel;
			}
		}
		else
		{
			i = FindFree();
			if (i)
			{
				m_Skills[i].SkillId = nSkillId;
				m_Skills[i].SkillLevel += nLevel;
				m_Skills[i].AddLevel = m_nAllSkillV;
				m_Skills[i].CurrentSkillLevel = m_Skills[i].SkillLevel + m_Skills[i].AddLevel;
				m_Skills[i].SkillExp = 0;
				m_Skills[i].NextSkillExp = PlayerSet.m_cMagicLevelExp.GetNextExp(nSkillId, nLevel);
				m_Skills[i].TempSkill = TRUE;
				m_Skills[i].MaxTimes = 0;
				m_Skills[i].RemainTimes = 0;
				m_Skills[i].NextCastTime = 0;
				m_Skills[i].WaitCastTime = 0;

				if (m_Skills[i].SkillLevel > 0)
				{
					ISkill * pSkill =  g_SkillManager.GetSkill(m_Skills[i].SkillId, m_Skills[i].CurrentSkillLevel);
					if (!pSkill) 
						return ;
					if (pSkill->GetSkillStyle() == SKILL_SS_PassivityNpcState)
					{
						((KSkill*)pSkill)->Cast(m_nNpcIndex, -1, m_nNpcIndex);
					}
					if(!pSkill->IsAura())
					{
						eSkillStyle eStyle = (eSkillStyle)pSkill->GetSkillStyle();
						DWORD dwCastTime = 0;
						if (eStyle == SKILL_SS_Missles 
							|| eStyle == SKILL_SS_Melee 
							|| eStyle == SKILL_SS_InitiativeNpcState 
							|| eStyle == SKILL_SS_PassivityNpcState)
						{
							dwCastTime = pSkill->GetDelayPerCast(Npc[m_nNpcIndex].m_bRideHorse);
						}
						else
						{
							switch(eStyle)
							{
							case SKILL_SS_Thief:
								{
									dwCastTime = ((KThiefSkill*)pSkill)->GetDelayPerCast();
								}break;
							default:
								return;
							}
						}
						SetNextCastTime(m_Skills[i].SkillId, SubWorld[Npc[m_nNpcIndex].m_SubWorldIndex].m_dwCurrentTime, SubWorld[Npc[m_nNpcIndex].m_SubWorldIndex].m_dwCurrentTime + dwCastTime);
					}
				}
			}
		}
	}
	else
	{
		m_nAllSkillV += nLevel;
		for (int i = 0; i < MAX_NPCSKILL ; i ++)
		{
			if (!IsBaseSkill(m_Skills[i].SkillId))
			{
				m_Skills[i].AddLevel += nLevel;
				m_Skills[i].CurrentSkillLevel += nLevel;
			}
		}
	}
}

void KSkillList::SeriesSkillV(int nSeries, int nLevel)
{
	if (nSeries >= series_metal && 
		nSeries < series_num)
	{
		for (int i = 0; i < MAX_NPCSKILL ; i ++)
		{
				ISkill * pSkill = g_SkillManager.GetSkill(m_Skills[i].SkillId, 1);
				if (!pSkill) 
					continue;

				if (pSkill->IsBase() &&
					!PhongThanIsProfessionSkill(m_Skills[i].SkillId))
					continue;

				if (pSkill->GetSkillSeries() == nSeries)
				{
					m_Skills[i].AddLevel += nLevel;
					m_Skills[i].CurrentSkillLevel += nLevel;
				}
		}
	}
}

BOOL KSkillList::IncreaseLevel(int nIdx, int nLvl)
{
	if (nIdx <= 0 || nIdx >= MAX_NPCSKILL)
		return FALSE;
	if (nLvl <= 0)
		return FALSE;
	if (m_Skills[nIdx].TempSkill)
		return FALSE;

	const int skillId = m_Skills[nIdx].SkillId;
	if (skillId <= 0 || skillId > MAX_SKILL)
		return FALSE;
	const int maxLearned = (int)g_SkillManager.GetSkillMaxLevel(skillId);
	if (maxLearned <= 0 || m_Skills[nIdx].SkillLevel > maxLearned ||
		nLvl > maxLearned - m_Skills[nIdx].SkillLevel ||
		m_Skills[nIdx].CurrentSkillLevel < 0 ||
		nLvl >= MAX_SKILLLEVEL - m_Skills[nIdx].CurrentSkillLevel)
		return FALSE;
	// Resolve before committing. Failed level loads must not change saved levels.
	KSkill * pOrdinSkill = (KSkill *)g_SkillManager.GetSkill(skillId,
		m_Skills[nIdx].CurrentSkillLevel + nLvl);
	if (!pOrdinSkill)
		return FALSE;
	m_Skills[nIdx].SkillLevel += nLvl;
	m_Skills[nIdx].CurrentSkillLevel += nLvl;
	m_Skills[nIdx].SkillExp = 0;
	m_Skills[nIdx].NextSkillExp = PlayerSet.m_cMagicLevelExp.GetNextExp(m_Skills[nIdx].SkillId, m_Skills[nIdx].SkillLevel);
	m_Skills[nIdx].TempSkill = FALSE;

	if (pOrdinSkill->GetSkillStyle() == SKILL_SS_PassivityNpcState)
	{
		pOrdinSkill->Cast(m_nNpcIndex, -1, m_nNpcIndex);
	}
	return TRUE;
}

BOOL KSkillList::IncreaseExp(int nIdx, int nExp)
{
	if (nIdx <= 0 || nIdx >= MAX_NPCSKILL)
		return FALSE;
	if (m_Skills[nIdx].SkillLevel <= 0)
		return FALSE;
	if (m_Skills[nIdx].TempSkill)
		return FALSE;
	if (m_Skills[nIdx].NextSkillExp <= 0)
		return FALSE;

	m_Skills[nIdx].SkillExp += nExp;

	if (m_Skills[nIdx].SkillExp >= m_Skills[nIdx].NextSkillExp)
	{
		return IncreaseLevel(nIdx, 1);
	}
	return FALSE;
}

BOOL KSkillList::SetNextExp(int nIdx, int nExp)
{
	if (nIdx <= 0 || nIdx >= MAX_NPCSKILL)
		return FALSE;

	if (nExp <= 0)
		return FALSE;

	m_Skills[nIdx].NextSkillExp = nExp;
	return TRUE;
}


BOOL KSkillList::SetTempSkill(int nIdx, BOOL bTempSkill)
{
	if (nIdx <= 0 || nIdx >= MAX_NPCSKILL)
		return FALSE;

	m_Skills[nIdx].TempSkill = bTempSkill;
	return TRUE;
}

int KSkillList::Add(int nSkillID, int nSkillLevel, int nSkillExp, BOOL bTempSkill, int nMaxTimes, int RemainTimes)
{
	int i;
	// Skill data comes from the network on the client.  Never let a malformed
	// id/level reach KSkillManager's fixed-size tables.
	if (nSkillID <= 0 || nSkillID > MAX_SKILL ||
		nSkillLevel < 0 || nSkillLevel >= MAX_SKILLLEVEL)
		return 0;
	i = FindSame(nSkillID);
	if (i)
	{
		if (nSkillLevel > m_Skills[i].SkillLevel)
		{
			int nInc = nSkillLevel - m_Skills[i].SkillLevel;
			IncreaseLevel(i, nInc);
		}
		m_Skills[i].MaxTimes = 0;
		m_Skills[i].RemainTimes = 0;

		// The server owns passive-state application.  Re-casting a passive skill
		// while the client is consuming the initial skill snapshot is both
		// redundant and unsafe with VNG data (the corresponding level script may
		// not be client-loadable yet).
#ifdef _SERVER
		if (nSkillLevel > 0)
		{
			ISkill * pSkill = g_SkillManager.GetSkill(nSkillID, m_Skills[i].CurrentSkillLevel);
			if (!pSkill) 
				return 0;
			//����ļ������ڱ�����������ʱ��������Npc״̬
			if (pSkill->GetSkillStyle() == SKILL_SS_PassivityNpcState)
			{
				((KSkill *)pSkill)->Cast(m_nNpcIndex, -1, m_nNpcIndex);
			}
		}
#endif

		return i;
	}

	i = FindFree();
	if (i)
	{
		m_Skills[i].SkillId = nSkillID;
		m_Skills[i].SkillLevel = nSkillLevel;
		m_Skills[i].AddLevel = m_nAllSkillV;
		m_Skills[i].CurrentSkillLevel = m_Skills[i].SkillLevel + m_Skills[i].AddLevel;
		m_Skills[i].SkillExp = nSkillExp;
		m_Skills[i].NextSkillExp = PlayerSet.m_cMagicLevelExp.GetNextExp(nSkillID, nSkillLevel);
		m_Skills[i].TempSkill = bTempSkill;
		m_Skills[i].MaxTimes = 0;
		m_Skills[i].RemainTimes = 0;
		m_Skills[i].NextCastTime = 0;
		m_Skills[i].WaitCastTime = 0;

#ifdef _SERVER
		if (nSkillLevel > 0)
		{
			ISkill * pSkill =  g_SkillManager.GetSkill(m_Skills[i].SkillId, m_Skills[i].CurrentSkillLevel);
			if (!pSkill) 
				return 0 ;
			if (pSkill->GetSkillStyle() == SKILL_SS_PassivityNpcState)
			{
				((KSkill*)pSkill)->Cast(m_nNpcIndex, -1, m_nNpcIndex);
			}
		}
#endif
		return i;
	}
	
	return 0;
}

int KSkillList::GetLevel(int nSkillID)
{
	int i;
	
	if (!nSkillID)
		return 0;
	
	i = FindSame(nSkillID);
	if (i)
	{
		_ASSERT(m_Skills[i].SkillLevel < MAX_SKILLLEVEL);
		return m_Skills[i].SkillLevel;
	}

	return 0;
}

int KSkillList::GetExp(int nSkillID)
{
	int i;
	
	if (!nSkillID)
		return 0;
	
	i = FindSame(nSkillID);
	if (i)
	{
		return m_Skills[i].SkillExp;
	}

	return 0;
}

int KSkillList::GetNextExp(int nSkillID)
{
	int i;
	
	if (!nSkillID)
		return 0;
	
	i = FindSame(nSkillID);
	if (i)
	{
		return m_Skills[i].NextSkillExp;
	}

	return 0;
}

BOOL KSkillList::IsTempSkill(int nSkillID)
{
	int i;
	
	if (!nSkillID)
		return FALSE;
	
	i = FindSame(nSkillID);
	if (i)
	{
		return m_Skills[i].TempSkill;
	}

	return FALSE;
}

int KSkillList::GetCurrentLevel(int nSkillID)
{
	int i;
	
	if (!nSkillID)
		return 0;
	
	i = FindSame(nSkillID);

	if (i)
	{
		_ASSERT(m_Skills[i].SkillLevel < MAX_SKILLLEVEL);
		if (m_Skills[i].SkillLevel > 0)
			return m_Skills[i].CurrentSkillLevel;
	}

	return 0;
}

BOOL KSkillList::CanCast(int nSkillID, DWORD dwTime)
{
	ISkill * pSkill =  g_SkillManager.GetSkill(nSkillID, 1);
	if(pSkill)
	{
		eSkillStyle eStyle = (eSkillStyle)pSkill->GetSkillStyle();
		if (eStyle == 4)
			return TRUE;
	}
	if (!nSkillID)
		return FALSE;
	
	int i = FindSame(nSkillID);
	if (!i)
	{
		return FALSE;
	}

	if (m_Skills[i].NextCastTime > dwTime)
		return FALSE;


	if (m_Skills[i].SkillLevel <= 0)
		return FALSE;
	
	return TRUE;
}

void KSkillList::SetNextCastTime(int nSkillID, DWORD dwCurrentTime, DWORD dwNextCastTime)
{
	if (!nSkillID)
		return;;
	
	int i = FindSame(nSkillID);
	if (!i)
		return;
	
	m_Skills[i].NextCastTime = dwNextCastTime;
	m_Skills[i].WaitCastTime = dwNextCastTime - dwCurrentTime;
#ifndef _SERVER
	m_Skills[i].TotalTime = dwNextCastTime - dwCurrentTime;
#endif
}	



#ifndef _SERVER
#define MAX_FIGHTSKILL_SORTLIST 50
#define MAX_LRSKILL_SORTLIST 65
static BOOL PhongThanSkillUsesFightUiStyle(eSkillStyle eStyle)
{
	return eStyle == SKILL_SS_PhongThanAttack ||
		eStyle == SKILL_SS_PhongThanProduce ||
		eStyle == SKILL_SS_PhongThanAwaken;
}
int	KSkillList::GetSkillSortList(KUiSkillData * pSkillList)
{
	//Ques
	if (!pSkillList) return 0;
	memset(pSkillList, 0, sizeof(KUiSkillData) * MAX_FIGHTSKILL_SORTLIST);
	int nCount = 0;
	ISkill* pSkill = NULL;
	KSkill * pOrdinSkill = NULL;
	int nSkillLevel = 0;
	for (int i = 1; i < MAX_NPCSKILL; i++)
	{
		if (m_Skills[i].SkillId)
		{
			_ASSERT(m_Skills[i].SkillLevel >= 0);
			nSkillLevel = m_Skills[i].SkillLevel + m_Skills[i].AddLevel;
			
			if (!m_Skills[i].SkillLevel)
			{
				pSkill =  g_SkillManager.GetSkill(m_Skills[i].SkillId, 1);
			}
			else 
			{
				pSkill =  g_SkillManager.GetSkill(m_Skills[i].SkillId, nSkillLevel);
			}
			
			if (!pSkill)
				continue;
			eSkillStyle eStyle = (eSkillStyle)pSkill->GetSkillStyle();
			if (PhongThanSkillUsesFightUiStyle(eStyle))
				eStyle = SKILL_SS_Missles;
			
			switch(eStyle)
			{
			case SKILL_SS_Missles:			//	�ӵ���		���������ڷ����ӵ���
			case SKILL_SS_Melee:
			case SKILL_SS_InitiativeNpcState:	//	������		���������ڸı䵱ǰNpc������״̬
			case SKILL_SS_PassivityNpcState:
			case SKILL_SS_CreateNpc:		//	������		���������ڸı�Npc�ı���״̬
				{
					pOrdinSkill = (KSkill * ) pSkill;
					if (pOrdinSkill->IsBase() &&
						!PhongThanIsProfessionSkill(m_Skills[i].SkillId))
						continue;
				}break;
			case SKILL_SS_Thief:					//	͵����
				{
					
				}
				break;
			default:
				continue;
			}
			
            KUiSkillData * pSkill = pSkillList + nCount;
			pSkill->uGenre = CGOG_SKILL_FIGHT;
			pSkill->uId = m_Skills[i].SkillId;
			pSkill->nLevel = m_Skills[i].SkillLevel;
			if ((++nCount) == MAX_FIGHTSKILL_SORTLIST)
			{
				break;
			}
		}
	}
	return nCount;
}

int KSkillList::GetLeftSkillSortList(KUiSkillData* pSkillList)
{
	if (!pSkillList) return 0;
	memset(pSkillList, 0, sizeof(KUiSkillData) * MAX_LRSKILL_SORTLIST);
	int nCount = 1;
	
	pSkillList->uGenre = CGOG_SKILL_SHORTCUT;
	pSkillList->uId = Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].GetCurActiveWeaponSkill();//����������ǰ!
	pSkillList->nData = 0;
	
	ISkill * pISkill = NULL;
	KSkill * pOrdinSkill = NULL;
	int nSkillLevel = 0;
	for (int i = 1; i < MAX_NPCSKILL; i++)
	{
		nSkillLevel = m_Skills[i].SkillLevel + m_Skills[i].AddLevel;
		if (m_Skills[i].SkillId && m_Skills[i].SkillLevel > 0)
		{
			_ASSERT(m_Skills[i].SkillId > 0);
			pISkill = g_SkillManager.GetSkill(m_Skills[i].SkillId, nSkillLevel);
			if (!pISkill)
				continue;
			pOrdinSkill = (KSkill * ) pISkill;

			if(Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_Level < pOrdinSkill->GetSkillReqLevel())
				continue;

			eSkillStyle eStyle = (eSkillStyle)pISkill->GetSkillStyle();
			if (PhongThanSkillUsesFightUiStyle(eStyle))
				eStyle = SKILL_SS_Missles;
			switch(eStyle)
			{
			case SKILL_SS_Missles:			//	�ӵ���		���������ڷ����ӵ���
			case SKILL_SS_Melee:
			case SKILL_SS_InitiativeNpcState:	//	������		���������ڸı䵱ǰNpc������״̬
			case SKILL_SS_PassivityNpcState:		//	������		���������ڸı�Npc�ı���״̬
				{	
					if ((!pOrdinSkill->IsBase() ||
						PhongThanIsProfessionSkill(m_Skills[i].SkillId)) &&
						(pOrdinSkill->GetSkillLRInfo() == BothSkill ||
						 pOrdinSkill->GetSkillLRInfo() == LeftOnlySkill ||
						 // Phong Than 2026-10-04 daosi:L1 right-only attack skills of a profession (Dao Si 18/23/25/26)
						 // may also be put on the left button. Buffs, heals and auras stay right-only. The server never
						 // checks the hand: CanCast / TimePerCast / mana are enforced the same for both buttons.
						 (pOrdinSkill->GetSkillLRInfo() == RightOnlySkill &&
						  PhongThanIsProfessionSkill(m_Skills[i].SkillId) && !pOrdinSkill->IsAura() &&
						  pOrdinSkill->IsTargetEnemy() && !pOrdinSkill->IsTargetAlly() && !pOrdinSkill->IsTargetSelf())))
					{
						
					}
					else 
						continue;
				}
				break;
			case SKILL_SS_Thief:
				{
					
					continue;
					
				}break;
			}
			
			KUiSkillData * pSkill = pSkillList + nCount;
			pSkill->uGenre = CGOG_SKILL_SHORTCUT;
			pSkill->uId = m_Skills[i].SkillId;
			pSkill->nData = nCount / 8;
			nCount ++;
			if (nCount >= MAX_LRSKILL_SORTLIST)
				break;
			
		}
	}
	return nCount;
}

int KSkillList::GetRightSkillSortList(KUiSkillData* pSkillList)
{
	if (!pSkillList) return 0;
	memset(pSkillList, 0, sizeof(KUiSkillData) * MAX_LRSKILL_SORTLIST);
	
	int nCount = 1;
	pSkillList->uGenre = CGOG_SKILL_SHORTCUT;
	//pSkillList->uId = (unsigned int)-1;//����������ǰ!
	pSkillList->uId = Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].GetCurActiveWeaponSkill();//����������ǰ!;	 
	pSkillList->nData = 0;
	ISkill * pISkill = NULL;
	KSkill * pOrdinSkill = NULL;
	int nSkillLevel = 0;
	for (int i = 1; i < MAX_NPCSKILL; i++)
	{
		nSkillLevel = m_Skills[i].SkillLevel + m_Skills[i].AddLevel;
		if (m_Skills[i].SkillId && m_Skills[i].SkillLevel > 0)
		{
			_ASSERT(m_Skills[i].SkillId > 0);
			pISkill  =  g_SkillManager.GetSkill(m_Skills[i].SkillId, nSkillLevel);
			if(!pISkill)
				continue;

			eSkillStyle eStyle = ( eSkillStyle ) pISkill->GetSkillStyle();
			if (PhongThanSkillUsesFightUiStyle(eStyle))
				eStyle = SKILL_SS_Missles;
			
			pOrdinSkill = (KSkill * ) pISkill;

			if(Npc[Player[CLIENT_PLAYER_INDEX].m_nIndex].m_Level < pOrdinSkill->GetSkillReqLevel())
				continue;

			switch(eStyle)
			{
			case SKILL_SS_Missles:			//	�ӵ���		���������ڷ����ӵ���
			case SKILL_SS_Melee:
			case SKILL_SS_InitiativeNpcState:	//	������		���������ڸı䵱ǰNpc������״̬
			case SKILL_SS_PassivityNpcState:		//	������		���������ڸı�Npc�ı���״̬
				{
					if ((!pOrdinSkill->IsBase() ||
						PhongThanIsProfessionSkill(m_Skills[i].SkillId)) &&
						(pOrdinSkill->GetSkillLRInfo() == BothSkill ||
						 pOrdinSkill->GetSkillLRInfo() == RightOnlySkill))
					{
						
					}
					else 
						continue;
				}
				break;
			}
			
			KUiSkillData * pSkill = pSkillList + nCount;
			pSkill->uGenre = CGOG_SKILL_SHORTCUT;
			pSkill->uId = m_Skills[i].SkillId;
			pSkill->nData = nCount / 8;
			nCount ++;
			if (nCount >= MAX_LRSKILL_SORTLIST)
				break;
			
		}
	}
	return nCount;
}


int KSkillList::GetSkillPosition(int nSkillId)//��ü����ڼ��ܽ����λ��
{
	if (nSkillId <= 0) return -1;
	KSkill * pOrdinSkill = NULL;
	
	ISkill * pISkill = NULL;
	int nCount = 0;
	for (int i = 1; i < MAX_NPCSKILL; i++)
	{
		_ASSERT(m_Skills[i].SkillLevel >= 0);
		if (m_Skills[i].SkillId<= 0) continue;
		
		if (m_Skills[i].SkillLevel == 0)
		{
			pISkill = g_SkillManager.GetSkill(m_Skills[i].SkillId, 1);
		}
		else
		{
			pISkill =  g_SkillManager.GetSkill(m_Skills[i].SkillId, m_Skills[i].SkillLevel + m_Skills[i].AddLevel);
		}

		if (!pISkill) 
        	continue ;


		eSkillStyle eStyle = ( eSkillStyle ) pISkill->GetSkillStyle();
		if (PhongThanSkillUsesFightUiStyle(eStyle))
			eStyle = SKILL_SS_Missles;
		switch(eStyle)
		{
		case SKILL_SS_Missles:			//	�ӵ���		���������ڷ����ӵ���
		case SKILL_SS_Melee:
		case SKILL_SS_InitiativeNpcState:	//	������		���������ڸı䵱ǰNpc������״̬
		case SKILL_SS_PassivityNpcState:		//	������		���������ڸı�Npc�ı���״̬
			{
				pOrdinSkill = (KSkill * ) pISkill;
				if (
					(!m_Skills[i].SkillId) || 
					//(pOrdinSkill->IsPhysical())
					(pOrdinSkill->IsBase() &&
					 !PhongThanIsProfessionSkill(m_Skills[i].SkillId))
					)
				{
					continue;
				}
			}
			break;
		case SKILL_SS_Thief:
			{		
			}break;
		}
		
		
		if (m_Skills[i].SkillId == nSkillId)
		{
			return nCount;
		}
		nCount ++;
		
	}
	return nCount;
}

void KSkillList::SetAddLevel(int nId, int nAdd)
{
	int i = FindSame(nId);

	if (i > 0 && i < MAX_NPCSKILL)
	{
		m_Skills[i].AddLevel = nAdd;
	}
}

void KSkillList::SetCurLevel(int nId, int nLevel)
{
	int i = FindSame(nId);

	if (i > 0 && i < MAX_NPCSKILL)
	{
		m_Skills[i].CurrentSkillLevel = nLevel;
	}
}
#endif

#ifdef _SERVER
int KSkillList::UpdateDBSkillList(
    PHONGTHAN_CHARACTER_SKILL_RECORD* pSkillData)
{
    if (!pSkillData)
        return -1;

    int nCount = 0;
    for (int i = 0; i < MAX_NPCSKILL; ++i)
    {
        if (m_Skills[i].TempSkill)
            continue;
        if (m_Skills[i].SkillId > 0)
        {
            pSkillData->SkillId = m_Skills[i].SkillId;
            pSkillData->Level = m_Skills[i].SkillLevel;
            pSkillData->Value = m_Skills[i].SkillExp;
            ++pSkillData;
            ++nCount;
        }
    }
    return nCount;
}
int KSkillList::RollBackSkills(bool bRbAll)
{
	int nTotalSkillPoint = 0;

	for (int i = 0 ; i < MAX_NPCSKILL; i ++)
	{
		if (m_Skills[i].SkillId > 0)
		{
			ISkill * pSkill = g_SkillManager.GetSkill(m_Skills[i].SkillId, 1);
			if (pSkill)
			{
				if (pSkill->IsBase() &&
					!PhongThanIsProfessionSkill(m_Skills[i].SkillId)) continue;
				if (!bRbAll && pSkill->IsExp()) continue;
				if(!pSkill->IsExp())
					nTotalSkillPoint += m_Skills[i].SkillLevel;
				m_Skills[i].SkillLevel = 0;
				m_Skills[i].AddLevel = m_nAllSkillV;
				m_Skills[i].CurrentSkillLevel = 0;
			}
		}
	}
	return nTotalSkillPoint;
}
#endif

int KSkillList::GetAddSkillDamage(int nSkillID) // add damage ky nang
{ 
    int nAddP = 0; 

    if (nSkillID <= 0 || nSkillID >= MAX_SKILL) 
        return nAddP; 
     
    for (int i = 1; i < MAX_NPCSKILL; i++) 
    { 
		if (m_Skills[i].SkillLevel)
		{
			KSkill * pSkill = (KSkill *) g_SkillManager.GetSkill(m_Skills[i].SkillId, m_Skills[i].CurrentSkillLevel); 
			if (pSkill)  
			{ 
				KMagicAttrib* pMagicData = NULL; 
				pMagicData = pSkill->GetAddSkillDamage();     
				for (int j =0 ; j < MAX_ADDSKILLDAMAGE ; j ++) 
				{ 
					if (!pMagicData[j].nAttribType) continue; 
					if ( pMagicData[j].nValue[0] == nSkillID) 
					{ 
						nAddP += pMagicData[j].nValue[2]; 
					} 
				} 
			}
		}
    } 
    return nAddP; 
}  

//TamLTM auto
#ifndef _SERVER
int KSkillList::GetNextSkillState(int nIndex)
{
	if (nIndex > 0)
	{
		int i = 0, j = 0;
		for (i = 1; i < MAX_NPCSKILL; i++)
		{
			int nCurLevel = 0;
			if (m_Skills[i].SkillId && m_Skills[i].SkillLevel)
			{	
				nCurLevel = this->GetCurrentLevel(m_Skills[i].SkillId);
				if(nCurLevel > 0)
				{
					KSkill * pOrdinSkill = (KSkill *)g_SkillManager.GetSkill(m_Skills[i].SkillId, nCurLevel);
					if (!pOrdinSkill) 
						continue;
		
					if(pOrdinSkill->IsAura())
						continue;

					if ((pOrdinSkill->GetSkillStyle() == SKILL_SS_Missles || 
						pOrdinSkill->GetSkillStyle() == SKILL_SS_InitiativeNpcState) && pOrdinSkill->IsTargetSelf())
					{
						j++;
						if (j == nIndex)
							return m_Skills[i].SkillId;
					}
				}
				else
					continue;
			}
		}
		return 0;
	}
	int _nCount = 0;
	for (int i = 1; i < MAX_NPCSKILL; i++)
	{
		int nCurLevel = 0;
		if (m_Skills[i].SkillId && m_Skills[i].SkillLevel)
		{	
			nCurLevel = this->GetCurrentLevel(m_Skills[i].SkillId);
			if(nCurLevel > 0)
			{
				KSkill * pOrdinSkill = (KSkill *)g_SkillManager.GetSkill(m_Skills[i].SkillId, nCurLevel);
				if (!pOrdinSkill) 
					continue;
	
				if(pOrdinSkill->IsAura())
					continue;

				if ((pOrdinSkill->GetSkillStyle() == SKILL_SS_Missles || 
					pOrdinSkill->GetSkillStyle() == SKILL_SS_InitiativeNpcState) && pOrdinSkill->IsTargetSelf())
					_nCount++;
			}
			else
				continue;
		}
	}
	return _nCount;
}

int KSkillList::GetNextSkillFight(int nIndex)
{
	if (nIndex > 0)
	{
		int i = 0, j = 0;
		for (i = 1; i < MAX_NPCSKILL; i++)
		{
			int nCurLevel = 0;
			if (m_Skills[i].SkillId && m_Skills[i].SkillLevel)
			{	
				nCurLevel = this->GetCurrentLevel(m_Skills[i].SkillId);
				if(nCurLevel > 0)
				{
					KSkill * pOrdinSkill = (KSkill *)g_SkillManager.GetSkill(m_Skills[i].SkillId, nCurLevel);
					if (!pOrdinSkill) 
						continue;

					if (pOrdinSkill->IsBase() &&
						!PhongThanIsProfessionSkill(m_Skills[i].SkillId))
						continue;

					if(pOrdinSkill->IsAura())
						continue;

					if ((pOrdinSkill->GetSkillStyle() == SKILL_SS_Missles || 
						pOrdinSkill->GetSkillStyle() == SKILL_SS_Melee) && pOrdinSkill->IsTargetEnemy())
					{
						j++;

						g_DebugLog("m_Skills[i].SkillId = %d", m_Skills[i].SkillId);

						if (j == nIndex)
							return m_Skills[i].SkillId;
					}
				}
				else
					continue;
			}
		}
		return 0;
	}

	int _nCount = 0;
	for (int i = 1; i < MAX_NPCSKILL; i++)
	{
		int nCurLevel = 0;
		if (m_Skills[i].SkillId && m_Skills[i].SkillLevel)
		{	
			nCurLevel = this->GetCurrentLevel(m_Skills[i].SkillId);
			if(nCurLevel > 0)
			{
				KSkill * pOrdinSkill = (KSkill *)g_SkillManager.GetSkill(m_Skills[i].SkillId, nCurLevel);
				if (!pOrdinSkill) 
					continue;
	
				if (pOrdinSkill->IsBase() &&
					!PhongThanIsProfessionSkill(m_Skills[i].SkillId))
					continue;

				if(pOrdinSkill->IsAura())
					continue;

				if ((pOrdinSkill->GetSkillStyle() == SKILL_SS_Missles || 
					pOrdinSkill->GetSkillStyle() == SKILL_SS_Melee) && pOrdinSkill->IsTargetEnemy())
					_nCount++;

				g_DebugLog("int _nCount = %d", _nCount);
			}
			else
				continue;
		}
	}
	return _nCount;
}

int KSkillList::GetNextSkillAura(int nIndex)
{
	if (nIndex > 0)
	{
		int i = 0, j = 0;
		for (i = 1; i < MAX_NPCSKILL; i++)
		{
			int nCurLevel = 0;
			if (m_Skills[i].SkillId && m_Skills[i].SkillLevel)
			{	
				nCurLevel = this->GetCurrentLevel(m_Skills[i].SkillId);
				if(nCurLevel > 0)
				{
					KSkill * pOrdinSkill = (KSkill *)g_SkillManager.GetSkill(m_Skills[i].SkillId, nCurLevel);
					if (!pOrdinSkill) 
						continue;
		
					if(pOrdinSkill->IsAura())
					{
						j++;
						if (j == nIndex)
							return m_Skills[i].SkillId;
					}
				}
				else
					continue;
			}
		}
		return 0;
	}
	int _nCount = 0;
	for (int i = 1; i < MAX_NPCSKILL; i++)
	{
		int nCurLevel = 0;
		if (m_Skills[i].SkillId && m_Skills[i].SkillLevel)
		{	
			nCurLevel = this->GetCurrentLevel(m_Skills[i].SkillId);
			if(nCurLevel > 0)
			{
				KSkill * pOrdinSkill = (KSkill *)g_SkillManager.GetSkill(m_Skills[i].SkillId, nCurLevel);
				if (!pOrdinSkill) 
					continue;
	
				if(pOrdinSkill->IsAura())
					_nCount++;
			}
			else
				continue;
		}
	}
	return _nCount;
}

int KSkillList::FindSkillLifeReplenish()
{
	int i = 0, j = 0;
	for (i = 1; i < MAX_NPCSKILL; i++)
	{
		int nCurLevel = 0;
		if (m_Skills[i].SkillId && m_Skills[i].SkillLevel)
		{	
			nCurLevel = this->GetCurrentLevel(m_Skills[i].SkillId);
			if(nCurLevel > 0)
			{
				KSkill * pOrdinSkill = (KSkill *)g_SkillManager.GetSkill(m_Skills[i].SkillId, nCurLevel);
				if (!pOrdinSkill) 
					continue;

			//	g_DebugLog("pOrdinSkill %d - %d", pOrdinSkill, m_Skills[i].SkillId);
	
				if (pOrdinSkill->IsSkillLifeReplenish()) 
					return m_Skills[i].SkillId;
			}
			else
				continue;
		}
	}
	return 0;
}
#endif
//end code
