//---------------------------------------------------------------------------
// Sword3 Engine (c) 1999-2000 by Kingsoft
//
// File:	KNpcDeathCalcExp.cpp
// Date:	2003.07.21
// Code:	�߳�����
// Desc:	KNpcDeathCalcExp Class
//---------------------------------------------------------------------------

#include	"KCore.h"
#include	"KNpc.h"
#include	"KPlayerDef.h"
#include	"KPlayer.h"
#include	"KNpcDeathCalcExp.h"
#ifdef _SERVER
#include	"KSubWorldSet.h"
// Phong Than 2026-10-03 botparty:P1 solo party-bot EXP bonus (VNG party bonus, +X% per member in range).
// script\phongthan\bots\party.lua calls SetPartyBotBonus(pct) every minute for each online player
// (PhongThanPartyBot.h): pct = party bots alive within PLAYER_SHARE_EXP_DISTANCE x the % per bot of the
// web admin. A value older than PHONGTHAN_PARTYBOT_TTL frames (bot tick stopped) or set for another login
// (m_dwID) is ignored. Only the no-team branch of CalcExp uses it: the bots are not real team members and
// never take a share; a real team keeps the engine's team sharing unchanged.
#define	PHONGTHAN_PARTYBOT_MAX_PCT	400
#define	PHONGTHAN_PARTYBOT_TTL		(3 * 60 * 18)
#define	PHONGTHAN_SOLO_EXP_DISTANCE	1600
int		g_nPhongThanPartyBotPct[MAX_PLAYER];
DWORD	g_dwPhongThanPartyBotId[MAX_PLAYER];
int		g_nPhongThanPartyBotTime[MAX_PLAYER];

void	PhongThanSetPartyBotBonus(int nPlayerIdx, int nPct)
{
	if (nPlayerIdx <= 0 || nPlayerIdx >= MAX_PLAYER || Player[nPlayerIdx].m_nIndex <= 0)
		return;
	if (nPct < 0)
		nPct = 0;
	if (nPct > PHONGTHAN_PARTYBOT_MAX_PCT)
		nPct = PHONGTHAN_PARTYBOT_MAX_PCT;
	g_nPhongThanPartyBotPct[nPlayerIdx] = nPct;
	g_dwPhongThanPartyBotId[nPlayerIdx] = Player[nPlayerIdx].m_dwID;
	g_nPhongThanPartyBotTime[nPlayerIdx] = g_SubWorldSet.GetGameTime();
}

int		PhongThanPartyBotBonus(int nPlayerIdx)
{
	if (nPlayerIdx <= 0 || nPlayerIdx >= MAX_PLAYER || g_nPhongThanPartyBotPct[nPlayerIdx] <= 0)
		return 0;
	if (g_dwPhongThanPartyBotId[nPlayerIdx] != Player[nPlayerIdx].m_dwID)
		return 0;
	int nAge = g_SubWorldSet.GetGameTime() - g_nPhongThanPartyBotTime[nPlayerIdx];
	if (nAge < 0 || nAge > PHONGTHAN_PARTYBOT_TTL)
		return 0;
	return g_nPhongThanPartyBotPct[nPlayerIdx];
}
#endif


void	KNpcDeathCalcExp::Init(int nNpcIdx)
{
	m_nNpcIdx = (nNpcIdx > 0 ? nNpcIdx : 0);
	memset(m_sCalcInfo, 0, sizeof(m_sCalcInfo));
}

void	KNpcDeathCalcExp::Active()
{
	//g_DebugLog("player Active"); //Chay lien tuc
	if (Npc[m_nNpcIdx].m_Kind != kind_normal)
		return;
	for (int i = 0; i < defMAX_CALC_EXP_NUM; i++)
	{
		if (m_sCalcInfo[i].m_nAttackIdx <= 0)
			continue;
		m_sCalcInfo[i].m_nTime--;
		if (m_sCalcInfo[i].m_nTime <= 0)
		{
			m_sCalcInfo[i].m_nTime = 0;
			m_sCalcInfo[i].m_nAttackIdx = 0;
			m_sCalcInfo[i].m_nTotalDamage = 0;
		}
	}
}

#ifdef _SERVER
void	KNpcDeathCalcExp::AddDamage(int nPlayerIdx, int nDamage)
{
	//g_DebugLog("player damage: %s",Npc[Player[nPlayerIdx].m_nIndex].Name);

	if (Npc[m_nNpcIdx].m_Kind != kind_normal)
		return;
	if (nPlayerIdx <= 0 || nPlayerIdx >= MAX_PLAYER || Player[nPlayerIdx].m_nIndex <= 0)
		return;
	if (nDamage <= 0)
		return;
	if (Player[nPlayerIdx].m_cTeam.m_nFlag)
	{
		nPlayerIdx = g_Team[Player[nPlayerIdx].m_cTeam.m_nID].m_nCaptain;
		if (nPlayerIdx <= 0 || nPlayerIdx >= MAX_PLAYER || Player[nPlayerIdx].m_nIndex <= 0)
			return;
	}
	int		i;
	for (i = 0; i < defMAX_CALC_EXP_NUM; i++)
	{
		if (m_sCalcInfo[i].m_nAttackIdx == nPlayerIdx)
		{
			this->m_sCalcInfo[i].m_nTotalDamage += nDamage;
			this->m_sCalcInfo[i].m_nTime = defMAX_CALC_EXP_TIME;
			return;
		}
	}
	for (i = 0; i < defMAX_CALC_EXP_NUM; i++)
	{
		if (m_sCalcInfo[i].m_nAttackIdx == 0)
			break;
	}
	if (i >= defMAX_CALC_EXP_NUM)
		return;
	m_sCalcInfo[i].m_nAttackIdx = nPlayerIdx;
	m_sCalcInfo[i].m_nTotalDamage = nDamage;
	m_sCalcInfo[i].m_nTime = defMAX_CALC_EXP_TIME;
}

// Son fix exp party
int		KNpcDeathCalcExp::CalcExp(int nAttacker)
{
	//g_DebugLog("player CalcExp");
	if (Npc[m_nNpcIdx].m_CurrentLifeMax <= 0)
		return 0;
	int i, j, nDamage = 0, nMaxPlayer = 0;
	for (i = 0; i < defMAX_CALC_EXP_NUM; i++)
	{
		if (m_sCalcInfo[i].m_nAttackIdx <= 0)
			continue;
		// ������
		if (Player[m_sCalcInfo[i].m_nAttackIdx].m_cTeam.m_nFlag && Player[m_sCalcInfo[i].m_nAttackIdx].m_cTeam.m_nID >= 0)
		{
			int		nTeam, nPlayer, nDistance, nMinDistance, nPlayerP;
			nPlayer = 0;
            nPlayerP = 0;
			nMinDistance = PLAYER_SHARE_EXP_DISTANCE * PLAYER_SHARE_EXP_DISTANCE;
			nTeam = Player[m_sCalcInfo[i].m_nAttackIdx].m_cTeam.m_nID;
			nDistance = KNpcSet::GetDistanceSquare(m_nNpcIdx, Player[g_Team[nTeam].m_nCaptain].m_nIndex);
			if (nDistance >= 0 && nDistance < nMinDistance)
			{
				nMinDistance = nDistance;
				nPlayerP = g_Team[nTeam].m_nCaptain;
			}
			if (nAttacker == Player[g_Team[nTeam].m_nCaptain].m_nIndex)
			{
				nPlayer = g_Team[nTeam].m_nCaptain;
			}
			// ��Ա
			for (j = 0; j < MAX_TEAM_MEMBER; j++)
			{
				if (g_Team[nTeam].m_nMember[j] <= 0)
					continue;
				nDistance = KNpcSet::GetDistanceSquare(m_nNpcIdx, Player[g_Team[nTeam].m_nMember[j]].m_nIndex);
				if (nDistance >= 0 && nDistance < nMinDistance)
				{
					nMinDistance = nDistance;
					nPlayerP = g_Team[nTeam].m_nMember[j];
				}

				if (nAttacker == Player[g_Team[nTeam].m_nMember[j]].m_nIndex)
				{
				    nPlayer = g_Team[nTeam].m_nMember[j];
                }
			}
			if (nPlayer > 0)
			{
				if (m_sCalcInfo[i].m_nTotalDamage > nDamage)
				{
					nDamage = m_sCalcInfo[i].m_nTotalDamage;
					nMaxPlayer = nPlayer;
				}
				Player[nPlayer].AddExp(m_sCalcInfo[i].m_nTotalDamage * Npc[m_nNpcIdx].m_CurrentExperience / Npc[m_nNpcIdx].m_CurrentLifeMax, Npc[m_nNpcIdx].m_Level);
			}
            else if (nPlayerP > 0)
			{
				nPlayer = nPlayerP;
				if (m_sCalcInfo[i].m_nTotalDamage > nDamage)
				{
					nDamage = m_sCalcInfo[i].m_nTotalDamage;
					nMaxPlayer = nPlayer;
				}
				Player[nPlayer].AddExp(m_sCalcInfo[i].m_nTotalDamage * Npc[m_nNpcIdx].m_Experience / Npc[m_nNpcIdx].m_CurrentLifeMax, Npc[m_nNpcIdx].m_Level,TRUE);
			}
		}
		// ���û�����
		else
		{
			int nDistance = KNpcSet::GetDistanceSquare(m_nNpcIdx, Player[m_sCalcInfo[i].m_nAttackIdx].m_nIndex);
			// Phong Than 2026-10-03 desertexp: solo range 768 -> 1600. The pet / party bots (AiMode 11, their damage
			// is booked on the owner in KNpc::CalcDamage) fight targets up to 1000 from the owner (PhongThanPetTargetOk)
			// and leash at 900, so their kills between 768 and ~1600 gave the owner 0 EXP.
			if (nDistance >= PHONGTHAN_SOLO_EXP_DISTANCE * PHONGTHAN_SOLO_EXP_DISTANCE)
				continue;
			if (m_sCalcInfo[i].m_nTotalDamage > nDamage)
			{
				nDamage = m_sCalcInfo[i].m_nTotalDamage;
				nMaxPlayer = m_sCalcInfo[i].m_nAttackIdx;
			}
			// Phong Than 2026-10-03 botparty:P2 + party-bot bonus of a solo player (0 without bot party)
			int nPTExp = m_sCalcInfo[i].m_nTotalDamage * Npc[m_nNpcIdx].m_CurrentExperience / Npc[m_nNpcIdx].m_CurrentLifeMax;
			int nPTBonus = PhongThanPartyBotBonus(m_sCalcInfo[i].m_nAttackIdx);
			if (nPTBonus > 0 && nPTExp > 0)
				nPTExp += nPTExp / 100 * nPTBonus + nPTExp % 100 * nPTBonus / 100;
			Player[m_sCalcInfo[i].m_nAttackIdx].AddExp(nPTExp, Npc[m_nNpcIdx].m_Level);
		}
	}
	Clear();
	return nMaxPlayer;
}

#endif

void	KNpcDeathCalcExp::Clear()
{
	memset(m_sCalcInfo, 0, sizeof(m_sCalcInfo));
}



