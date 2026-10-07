// Phong Than 2026-10-03 partypanel: client data for the VNG-style team list (Game.exe KUiPartyPanel).
//
// Included ONCE, at the end of CoreShell.cpp, client build only. ASCII only (the TCVN3 tag is escaped).
// Entry: KCoreShell::PAIOperation(PTPP_GPI_QUERY, (unsigned int)&KPTPartyInfo, sizeof(KPTPartyInfo), 0).
//
// Real team (Player.m_cTeam.m_nFlag and g_Team[0] has a captain): captain first, then the members, names and
// levels from g_Team[0] (client side ids are NPC ids); life, level and profession from the NPC when it is in
// view, otherwise the row is flagged PTPP_F_FAR.
//
// Bot party: the server summons the companions with AddTotemNpc (owner = player, AiMode 11) and names them
// "[To doi] <name>" in TCVN3 (script\phongthan\bots\party.lua, PTBP_TAG), templates 2703..2720. The NPC owner
// is not sent to clients, so a companion is recognised by template + name tag + distance (the server keeps
// them within ~900 points and removes them beyond 34 cells, about 1088 points). The player is shown first as
// the captain. Up to 7 companions, nearest first. While the player is in a real team no bot is listed (the
// server dismisses the bot party then). Another player's companions standing right next to us would also
// match; on this local server that is accepted (see docs\features\khung-to-doi-bot-phong-than-20261003.md).
//
// Read only: touches no game state and sends nothing.
#ifndef _SERVER
#ifndef PHONGTHAN_PARTYPANEL_INL
#define PHONGTHAN_PARTYPANEL_INL

#include "PhongThanPartyPanel.h"

#define PTPP_BOT_TPL_MIN        2703
#define PTPP_BOT_TPL_MAX        2720
#define PTPP_BOT_RADIUS         1280        // Mps points around the player

// "[To doi] " in TCVN3 (same bytes as PTBP_TAG in party.lua).
static const char s_szPTPPBotTag[] = "[T\346 \256\351i] ";

static double PTPP_D2(int x1, int y1, int x2, int y2)
{
	double dx = (double)(x1 - x2);
	double dy = (double)(y1 - y2);
	return dx * dx + dy * dy;
}

static int PTPP_ValidNpc(int i)
{
	return (i > 0 && i < MAX_NPC && Npc[i].m_Index > 0 && Npc[i].m_dwID != 0) ? 1 : 0;
}

// Bounded copy, never reads past pSrc[nMax - 1]; strips the bot tag.
static void PTPP_CopyName(char* pDst, const char* pSrc, int nMax)
{
	pDst[0] = 0;
	if (!pSrc)
		return;
	int nTag = (int)sizeof(s_szPTPPBotTag) - 1;
	int nSrcLen = 0;
	while (nSrcLen < nMax && pSrc[nSrcLen])
		nSrcLen++;
	int nStart = 0;
	if (nSrcLen > nTag && memcmp(pSrc, s_szPTPPBotTag, nTag) == 0)
		nStart = nTag;
	int n = nSrcLen - nStart;
	if (n > PTPP_NAME_LEN - 1)
		n = PTPP_NAME_LEN - 1;
	if (n > 0)
		memcpy(pDst, pSrc + nStart, n);
	else
		n = 0;
	pDst[n] = 0;
}

static int PTPP_Profession(int n)
{
	return (n >= 0 && n <= 2) ? n : -1;
}

// Level, life and the dead flag from an NPC in view.
static void PTPP_FillFromNpc(KPTPartyMember* pm, int i)
{
	KNpc& n = Npc[i];
	pm->uNpcID = n.m_dwID;
	if (n.m_Level > 0)
		pm->nLevel = n.m_Level;
	if (n.m_CurrentLifeMax > 0)
	{
		int nLife = n.m_CurrentLife;
		if (nLife < 0)
			nLife = 0;
		double d = (double)nLife * 100.0 / (double)n.m_CurrentLifeMax;
		int nPct = (int)d;
		if (nLife > 0 && nPct <= 0)
			nPct = 1;
		if (nPct > 100)
			nPct = 100;
		pm->nLifePercent = nPct;
	}
	else
		pm->nLifePercent = -1;
	if (!n.IsAlive() || (n.m_CurrentLifeMax > 0 && n.m_CurrentLife <= 0))
	{
		pm->nFlags |= PTPP_F_DEAD;
		pm->nLifePercent = 0;
	}
}

static int PTPP_IsBotCompanion(int nMe, int i)
{
	if (i == nMe || !PTPP_ValidNpc(i))
		return 0;
	KNpc& n = Npc[i];
	if (n.m_Kind == kind_player)
		return 0;
	if (n.m_NpcSettingIdx < PTPP_BOT_TPL_MIN || n.m_NpcSettingIdx > PTPP_BOT_TPL_MAX)
		return 0;
	if (n.m_RegionIndex < 0 || n.m_SubWorldIndex != Npc[nMe].m_SubWorldIndex)
		return 0;
	int nTag = (int)sizeof(s_szPTPPBotTag) - 1;
	if (memcmp(n.Name, s_szPTPPBotTag, nTag) != 0 || n.Name[nTag] == 0)
		return 0;
	return 1;
}

static int PTPP_QueryTeam(KPTPartyInfo* pInfo, int nMe)
{
	KTeam& t = g_Team[0];
	DWORD dwMe = Npc[nMe].m_dwID;
	int aId[MAX_TEAM_MEMBER + 1];
	int aSlot[MAX_TEAM_MEMBER + 1];
	int nRows = 0;
	aId[nRows] = t.m_nCaptain;
	aSlot[nRows] = 0;
	nRows++;
	for (int k = 0; k < MAX_TEAM_MEMBER && nRows < PTPP_MAX_MEMBER; k++)
	{
		if (t.m_nMember[k] <= 0)
			continue;
		aId[nRows] = t.m_nMember[k];
		aSlot[nRows] = k + 1;
		nRows++;
	}
	pInfo->nMode = PTPP_MODE_TEAM;
	for (int r = 0; r < nRows; r++)
	{
		KPTPartyMember* pm = &pInfo->aMember[pInfo->nCount];
		pm->nLifePercent = -1;
		pm->nProfession = -1;
		PTPP_CopyName(pm->szName, t.m_szMemName[aSlot[r]], (int)sizeof(t.m_szMemName[0]));
		pm->nLevel = t.m_nMemLevel[aSlot[r]] > 0 ? t.m_nMemLevel[aSlot[r]] : 0;
		if (r == 0)
			pm->nFlags |= PTPP_F_CAPTAIN;
		int i = 0;
		if ((DWORD)aId[r] == dwMe)
		{
			pm->nFlags |= PTPP_F_SELF;
			i = nMe;
			pm->nProfession = PTPP_Profession(Player[CLIENT_PLAYER_INDEX].m_cProfession.m_nProfession);
		}
		else if (aId[r] > 0)
		{
			i = NpcSet.SearchID((DWORD)aId[r]);
			if (!PTPP_ValidNpc(i) || Npc[i].m_RegionIndex < 0 || Npc[i].m_SubWorldIndex != Npc[nMe].m_SubWorldIndex)
				i = 0;
			else
				pm->nProfession = PTPP_Profession(Npc[i].m_Series);
		}
		if (i > 0)
		{
			PTPP_FillFromNpc(pm, i);
			if (!pm->szName[0])
				PTPP_CopyName(pm->szName, Npc[i].Name, (int)sizeof(Npc[i].Name));
		}
		else
			pm->nFlags |= PTPP_F_FAR;
		pInfo->nCount++;
	}
	return pInfo->nCount;
}

static int PTPP_QueryBots(KPTPartyInfo* pInfo, int nMe)
{
	int aBot[PTPP_MAX_MEMBER];
	double aD2[PTPP_MAX_MEMBER];
	int nBots = 0;
	const int nMaxBots = PTPP_MAX_MEMBER - 1;
	int mx, my;
	Npc[nMe].GetMpsPos(&mx, &my);
	const double rMax = (double)PTPP_BOT_RADIUS * PTPP_BOT_RADIUS;
	int nGuard = 0;
	for (int i = NpcSet.GetNextIdx(0); i > 0 && nGuard < MAX_NPC; i = NpcSet.GetNextIdx(i), nGuard++)
	{
		if (!PTPP_IsBotCompanion(nMe, i))
			continue;
		int x, y;
		Npc[i].GetMpsPos(&x, &y);
		double d = PTPP_D2(mx, my, x, y);
		if (d > rMax)
			continue;
		// keep the nearest nMaxBots, sorted by distance
		int p = nBots;
		if (nBots < nMaxBots)
			nBots++;
		else if (d >= aD2[nMaxBots - 1])
			continue;
		else
			p = nMaxBots - 1;
		while (p > 0 && aD2[p - 1] > d)
		{
			aBot[p] = aBot[p - 1];
			aD2[p] = aD2[p - 1];
			p--;
		}
		aBot[p] = i;
		aD2[p] = d;
	}
	if (nBots == 0)
		return 0;

	pInfo->nMode = PTPP_MODE_BOT;
	pInfo->nBots = nBots;
	// the player leads the bot party
	KPTPartyMember* pm = &pInfo->aMember[pInfo->nCount++];
	pm->nFlags = PTPP_F_SELF | PTPP_F_CAPTAIN;
	pm->nLifePercent = -1;
	pm->nProfession = PTPP_Profession(Player[CLIENT_PLAYER_INDEX].m_cProfession.m_nProfession);
	PTPP_CopyName(pm->szName, Npc[nMe].Name, (int)sizeof(Npc[nMe].Name));
	PTPP_FillFromNpc(pm, nMe);
	for (int b = 0; b < nBots && pInfo->nCount < PTPP_MAX_MEMBER; b++)
	{
		int i = aBot[b];
		pm = &pInfo->aMember[pInfo->nCount++];
		pm->nFlags = PTPP_F_BOT;
		pm->nLifePercent = -1;
		pm->nProfession = PTPP_Profession((Npc[i].m_NpcSettingIdx - PTPP_BOT_TPL_MIN) / 6);
		PTPP_CopyName(pm->szName, Npc[i].Name, (int)sizeof(Npc[i].Name));
		PTPP_FillFromNpc(pm, i);
	}
	return pInfo->nCount;
}

// UI entry (KCoreShell::PAIOperation). Returns the number of rows written.
int PTPartyPanel_Query(unsigned int uInfo, int nSize)
{
	KPTPartyInfo* pInfo = (KPTPartyInfo*)uInfo;
	if (!pInfo || nSize < (int)sizeof(KPTPartyInfo))
		return 0;
	memset(pInfo, 0, sizeof(KPTPartyInfo));
	pInfo->nSize = (int)sizeof(KPTPartyInfo);
	int nMe = Player[CLIENT_PLAYER_INDEX].m_nIndex;
	if (!PTPP_ValidNpc(nMe) || SubWorld[0].m_SubWorldID <= 0)
		return 0;
	if (Player[CLIENT_PLAYER_INDEX].m_cTeam.m_nFlag && g_Team[0].m_nCaptain > 0)
		return PTPP_QueryTeam(pInfo, nMe);
	return PTPP_QueryBots(pInfo, nMe);
}

#endif // PHONGTHAN_PARTYPANEL_INL
#endif // _SERVER
