// Phong Than 2026-10-04 hanhtrang:B5 IB item buffs in the VNG buff bar (docs\features\hanh-trang-phong-than-20261004.md).
//
// Included ONCE, at the end of CoreShell.cpp, client build only. ASCII only.
// Game.exe KUiPlayerControlBar (Ui\ui3\UiPlayerControlBar.ini [BuffList]) already draws an icon + time left right
// of the life bar for every entry of GetGameData(GDI_NPC_STATE_SKILL). The IB item effects of
// script\phongthan\ibitem\pt_ibitem_lib.lua are attributes kept in tasks, not skill states, so nothing showed.
// PTBuffBar_Fill() appends one entry per running effect after the skill states (CoreShell.cpp hanhtrang:B5).
// The server (script\phongthan\item\hanhtrang_lib.lua, minute tick) sends the tasks with SyncTaskValue:
//   1906/1907 exp expiry / %   -> 90001 (>= 100 %: Nhan doi kinh nghiem) or 90002 (Tang kinh nghiem)
//   1911 life regen expiry     -> 90003        1913 mana regen expiry -> 90004
//   2021 Bach Ho privilege     -> 90005
//   1921 + 2k / 1922 + 2k (k 0..5) generic buff id / expiry -> 212 (gid 116, Can Khon Luan Dai Hao), 213 (gid 124,
//                                 Bach Ho tinh quan) or 90006 (Hieu qua vat pham)
//   2645 server SystemTime() at the sync: the client keeps offset = server time - time(NULL).
// Expiries are SystemTime() seconds; nLeftTime is in game frames (GAME_FPS). Ids 90001..90006 are rows
// Buff_62..Buff_67 added to UiPlayerControlBar.ini (scratchpad\items\deploy); without them the UI skips the
// entries (no icon, no harm). Read only: touches no game state, sends nothing.
#ifndef _SERVER
#ifndef PHONGTHAN_BUFFBAR_INL
#define PHONGTHAN_BUFFBAR_INL
#include <time.h>

#define PTBB_TASK_NOW           2645
#define PTBB_ID_EXP2            90001
#define PTBB_ID_EXP             90002
#define PTBB_ID_LIFE            90003
#define PTBB_ID_MANA            90004
#define PTBB_ID_BAIHU           90005
#define PTBB_ID_GEN             90006
#define PTBB_MAX_LEFT           5000000     // seconds (nLeftTime * GAME_FPS stays far below 2^31)

extern int PTAF_SyncedTask(int nTask);     // PhongThanAutoFight.inl (KPlayerAI.cpp)

static int s_nPTBBSrvTime = 0;
static int s_nPTBBOffset = 0;

static int PTBB_Now()
{
	const char* s = Player[CLIENT_PLAYER_INDEX].m_cTask.GetSaveStr(PTBB_TASK_NOW);
	if (s && s[0])
	{
		int v = atoi(s);
		if (v > 0 && v != s_nPTBBSrvTime)
		{
			s_nPTBBSrvTime = v;
			s_nPTBBOffset = v - (int)time(NULL);
		}
	}
	return (int)time(NULL) + s_nPTBBOffset;
}

static int PTBB_Put(KStateControl* p, int nMax, int n, int nId, int nLeft)
{
	if (nLeft <= 0)
		return n;
	if (p)
	{
		if (n >= nMax)
			return n;
		if (nLeft > PTBB_MAX_LEFT)
			nLeft = PTBB_MAX_LEFT;
		p[n].nSkillId = nId;
		p[n].nLeftTime = nLeft * GAME_FPS;
	}
	return n + 1;
}

// p == NULL: count only. Otherwise fills at most nMax entries and zeroes the rest of the nMax slots (the UI
// allocated them from the count call; an effect may have ended in between).
int PTBuffBar_Fill(KStateControl* p, int nMax)
{
	int n = 0;
	int nNow = PTBB_Now();
	int e = PTAF_SyncedTask(1906);
	if (e > 0)
		n = PTBB_Put(p, nMax, n, PTAF_SyncedTask(1907) >= 100 ? PTBB_ID_EXP2 : PTBB_ID_EXP, e - nNow);
	e = PTAF_SyncedTask(1911);
	if (e > 0)
		n = PTBB_Put(p, nMax, n, PTBB_ID_LIFE, e - nNow);
	e = PTAF_SyncedTask(1913);
	if (e > 0)
		n = PTBB_Put(p, nMax, n, PTBB_ID_MANA, e - nNow);
	e = PTAF_SyncedTask(2021);
	if (e > 0)
		n = PTBB_Put(p, nMax, n, PTBB_ID_BAIHU, e - nNow);
	for (int k = 0; k < 6; k++)
	{
		int nGid = PTAF_SyncedTask(1921 + 2 * k);
		e = PTAF_SyncedTask(1922 + 2 * k);
		if (nGid > 0 && e > 0)
			n = PTBB_Put(p, nMax, n, nGid == 116 ? 212 : (nGid == 124 ? 213 : PTBB_ID_GEN), e - nNow);
	}
	if (p)
	{
		for (int i = n; i < nMax; i++)
		{
			p[i].nSkillId = 0;
			p[i].nLeftTime = 0;
		}
	}
	return n;
}

#endif // PHONGTHAN_BUFFBAR_INL
#endif // _SERVER
