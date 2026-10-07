#ifndef PHONG_THAN_LUA_CARRIAGE_H
#define PHONG_THAN_LUA_CARRIAGE_H

// Phong Than 2026-10-03 (vantieu): escort carriages for Van Tieu 2004 (\script\yun_biao\*) and Van Luong
// (\script\phongthan\vanluong\*). Included by ScriptFuns.cpp after PhongThanLuaWave9.h.
//   SendCarriage(carriage, playerName, level, seconds) -> guard index (0 = failed)
//   GetTGuardNum()                                     -> carriages running
//   GetTGuardTimeScale()                               -> remaining time of the caller's carriage, 0..100
//   AddTongAttr(type, value)                           -> new value of the caller's tong attribute
// A carriage is a NewSiegeWeapon NPC (PhongThanLuaWave8.h). SendCarriage turns it into a kind_normal NPC of
// its owner's camp that walks after the owner and never fights (AiMode 12, PhongThanCarriageFollow in
// KNpcAI.cpp). Death is reported to the ActionScript (DeathSelf, then Revive after one second) instead of
// the template death script, so the Lua side can fail the run and delete the NPC once it is back in a
// region. Timeout, failure and rewards are decided in Lua; the engine only keeps the record.

#define PHONGTHAN_AI_CARRIAGE 12
#define PHONGTHAN_CARRIAGE_REVIVE_FRAMES 18
#define PHONGTHAN_CARRIAGE_BOUNTY 500000
#define PHONGTHAN_TONG_ATTR_SLOT 100

struct PHONGTHAN_CARRIAGE_RECORD
{
	DWORD dwNpcId;
	DWORD dwOwnerUuid;
	int nLevel;
	int nBounty;
	DWORD dwStartTime;
	int nSeconds;
};

static PHONGTHAN_CARRIAGE_RECORD g_PhongThanCarriage[PHONGTHAN_SIEGE_MAX];

static PHONGTHAN_CARRIAGE_RECORD *PhongThanCarriageRecord(int nCarriageIndex)
{
	if (!PhongThanValidSiege(nCarriageIndex))
		return NULL;
	PHONGTHAN_CARRIAGE_RECORD *pRecord = &g_PhongThanCarriage[nCarriageIndex - 1];
	if (!pRecord->dwNpcId ||
		pRecord->dwNpcId != g_PhongThanSiege[nCarriageIndex - 1].dwNpcId)
		return NULL;
	return pRecord;
}

// Declared in PhongThanLuaWave8.h: PhongThanAttachPlayerToSiege (re)creates the guard record when the
// owner enters the carriage again (PlayerInOrOut), the bounty belongs to the carriage.
static int PhongThanCarriageBounty(int nCarriageIndex)
{
	PHONGTHAN_CARRIAGE_RECORD *pRecord = PhongThanCarriageRecord(nCarriageIndex);
	return pRecord ? pRecord->nBounty : 0;
}

static int PhongThanFindLivePlayerByName(const char *pszName)
{
	if (!pszName || !pszName[0])
		return 0;
	int nPlayerIndex = PlayerSet.GetNextPlayerFrom(0);
	while (nPlayerIndex > 0)
	{
		if (PhongThanIsLivePlayer(nPlayerIndex) &&
			_stricmp(Player[nPlayerIndex].Name, pszName) == 0)
			return nPlayerIndex;
		nPlayerIndex = PlayerSet.GetNextPlayerFrom(nPlayerIndex);
	}
	return 0;
}

int LuaSendCarriageCompat(Lua_State *L)
{
	int nTop = Lua_GetTopIndex(L);
	int nCarriage = nTop >= 1 ? (int)Lua_ValueToNumber(L, 1) : 0;
	const char *pszName = nTop >= 2 && Lua_IsString(L, 2) ?
		Lua_ValueToString(L, 2) : NULL;
	int nLevel = nTop >= 3 ? (int)Lua_ValueToNumber(L, 3) : 1;
	int nSeconds = nTop >= 4 ? (int)Lua_ValueToNumber(L, 4) : 1800;
	if (nLevel < 1) nLevel = 1;
	if (nLevel > 10) nLevel = 10;
	if (nSeconds < 60) nSeconds = 60;
	if (nSeconds > 7200) nSeconds = 7200;
	int nGuard = 0;
	int nPlayerIndex = PhongThanFindLivePlayerByName(pszName);
	if (PhongThanValidSiege(nCarriage) && nPlayerIndex > 0)
	{
		int nNpcIndex = g_PhongThanSiege[nCarriage - 1].nNpcIndex;
		int nPlayerNpc = Player[nPlayerIndex].m_nIndex;
		if (Npc[nNpcIndex].m_SubWorldIndex == Npc[nPlayerNpc].m_SubWorldIndex)
		{
			KNpc &rCart = Npc[nNpcIndex];
			// VNG carriage rows (363, 556...) carry Kind 8, outside the kind x camp relation table.
			rCart.m_Kind = kind_normal;
			rCart.SetCamp(Npc[nPlayerNpc].m_Camp);
			rCart.SetCurrentCamp(Npc[nPlayerNpc].m_CurrentCamp);
			PhongThanSetNpcOwner(nNpcIndex, nPlayerIndex);
			rCart.m_bNpcFollowFindPath = FALSE;
			rCart.m_nPeopleIdx = 0;
			rCart.m_AiMode = PHONGTHAN_AI_CARRIAGE;
			rCart.m_DeathScriptID = 0;
			rCart.SetReviveFrame(PHONGTHAN_CARRIAGE_REVIVE_FRAMES);
			PHONGTHAN_CARRIAGE_RECORD *pRecord = &g_PhongThanCarriage[nCarriage - 1];
			ZeroMemory(pRecord, sizeof(*pRecord));
			pRecord->dwNpcId = rCart.m_dwID;
			pRecord->dwOwnerUuid = Player[nPlayerIndex].m_dwID;
			pRecord->nLevel = nLevel;
			pRecord->nBounty = PHONGTHAN_CARRIAGE_BOUNTY * nLevel;
			pRecord->dwStartTime = (DWORD)time(NULL);
			pRecord->nSeconds = nSeconds;
			g_PhongThanSiege[nCarriage - 1].dwCreatorUuid = pRecord->dwOwnerUuid;
			nGuard = PhongThanAttachPlayerToSiege(nPlayerIndex, nCarriage);
		}
	}
	Lua_PushNumber(L, nGuard);
	return 1;
}

int LuaGetTGuardNumCompat(Lua_State *L)
{
	int nCount = 0;
	for (int i = 0; i < PHONGTHAN_SIEGE_MAX; ++i)
		if (PhongThanCarriageRecord(i + 1))
			++nCount;
	Lua_PushNumber(L, nCount);
	return 1;
}

int LuaGetTGuardTimeScaleCompat(Lua_State *L)
{
	int nScale = 100;
	int nPlayerIndex = GetPlayerIndex(L);
	int nGuard = PhongThanFindGuardByPlayer(nPlayerIndex);
	PHONGTHAN_CARRIAGE_RECORD *pRecord = nGuard ?
		PhongThanCarriageRecord(g_PhongThanTGuard[nGuard - 1].nCarriageIndex) : NULL;
	if (pRecord && pRecord->nSeconds > 0)
	{
		int nUsed = (int)((DWORD)time(NULL) - pRecord->dwStartTime);
		if (nUsed < 0) nUsed = 0;
		nScale = (pRecord->nSeconds - nUsed) * 100 / pRecord->nSeconds;
		if (nScale < 0) nScale = 0;
		if (nScale > 100) nScale = 100;
	}
	Lua_PushNumber(L, nScale);
	return 1;
}

int LuaAddTongAttrCompat(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nValue = 0;
	if (PhongThanIsLivePlayer(nPlayerIndex) &&
		Player[nPlayerIndex].m_cTong.m_nFlag && Lua_GetTopIndex(L) >= 2)
	{
		int nType = (int)Lua_ValueToNumber(L, 1);
		int nDelta = (int)Lua_ValueToNumber(L, 2);
		if (nType < 0) nType = 0;
		if (nType > 99) nType = 99;
		DWORD dwTongId = Player[nPlayerIndex].m_cTong.m_dwTongNameID;
		nValue = PhongThanGetPersistentValue(pt_persist_tong_resource, dwTongId,
			PHONGTHAN_TONG_ATTR_SLOT + nType) + nDelta;
		if (nValue < 0) nValue = 0;
		PhongThanSetPersistentValue(pt_persist_tong_resource, dwTongId,
			PHONGTHAN_TONG_ATTR_SLOT + nType, nValue);
	}
	Lua_PushNumber(L, nValue);
	return 1;
}

#endif // PHONG_THAN_LUA_CARRIAGE_H
