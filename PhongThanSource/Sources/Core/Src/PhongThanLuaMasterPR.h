#ifndef PHONG_THAN_LUA_MASTER_PR_H
#define PHONG_THAN_LUA_MASTER_PR_H

// Phong Than 2026-10-03 (sudocpp): the VNG master-apprentice (su do) Lua API used by Hoang Phi Ho
// (PAK script ChaoGe\HuangFeiHu, npc_fix 1021_hoang_phi_ho.lua), Na Tra (PAK XiQi\NeZha), the newbie
// Vo su, the trial NPCs and the JiaMa (Dai Giap Ma) items. Included by ScriptFuns.cpp inside _SERVER after
// PhongThanXichTungTuService.inl; it reuses GetPlayerIndex, GetPersistentMasterName and
// FindOnlinePlayerByExactName (ScriptFuns.cpp) and PhongThanDieuTriGetTeamMate (PhongThanDieuTriLua.inl).
//
// Persistence only in engine-owned task values (Task_List ABI, no DB schema change):
//   TASKVALUE_PT_MASTER_NAME_BEGIN..END     apprentice side: the master's name, 3 x 15 chars (existing,
//                                           already read by IsMasterPRRelation / IsMantlePrentice)
//   TASKVALUE_PT_MASTER_APPRENTICE_COUNT    master side: number of apprentices (existing, read by IsMantleMaster)
//   TASKVALUE_PT_MASTER_PR_VALUE            master-apprentice points (new, GameDataDef.h)
//   TASKVALUE_PT_NATIVE_WEIGHT_MAX          "suc luc" (native carrying capacity) bought from Na Tra (new)
//
//   MasterPRVersion()          -> 1 (capability probe for Lua: the pt_compat stubs make the VNG names non-nil)
//   GetMasterPRValue()         -> points of the caller
//   AddMasterPRValue(n)        -> new points (n <= 0 ignored), capped at PHONGTHAN_MPR_VALUE_MAX
//   DecMasterPRValue(n)        -> new points, never below 0
//   CanMasterPR()              -> 1 when the caller is in a team of exactly 2 with: one member level >= 50
//                                 (master, fewer than PHONGTHAN_MPR_MAX_APPRENTICES apprentices), the other
//                                 level < 30 without a master, and no relation between them yet
//   DoMasterPR()               -> 1 after writing the relation of that pair (CanMasterPR rules re-checked)
//   UnMasterPREx(name)         -> 1 when a relation between the caller and `name` was removed;
//                                 name "" / nil: the caller leaves its own master
//   CanChangeMasterPRValue()   -> 0 (the VNG ext-point conversion is not offered on this server)
//   ChangeMasterPRValue()      -> 0
//   GetNativeWeightMax()       -> stored "suc luc", PHONGTHAN_WEIGHT_BASE when never changed
//   AddWeightMax(n)            -> new value, kept in [1, PHONGTHAN_WEIGHT_MAX]
// "IsMaster" is registered to the existing LuaIsMantleMasterCompat (same meaning).
// The engine has no carrying-capacity rule: the "suc luc" value is stored and shown, nothing else reads it.

#define PHONGTHAN_MPR_VERSION				1
#define PHONGTHAN_MPR_APPRENTICE_MAX_LEVEL	29
#define PHONGTHAN_MPR_MASTER_MIN_LEVEL		50
#define PHONGTHAN_MPR_MAX_APPRENTICES		3
#define PHONGTHAN_MPR_VALUE_MAX				1000000
#define PHONGTHAN_MPR_NAME_PART				15
#define PHONGTHAN_WEIGHT_BASE				300
#define PHONGTHAN_WEIGHT_MAX				5000

static BOOL PhongThanMprLive(int nPlayerIndex)
{
	return nPlayerIndex > 0 && nPlayerIndex < MAX_PLAYER &&
		Player[nPlayerIndex].m_nIndex > 0 && Player[nPlayerIndex].m_nIndex < MAX_NPC;
}

static int PhongThanMprLevel(int nPlayerIndex)
{
	return PhongThanMprLive(nPlayerIndex) ? Npc[Player[nPlayerIndex].m_nIndex].m_Level : 0;
}

static int PhongThanMprGetValue(int nPlayerIndex)
{
	int nValue = Player[nPlayerIndex].m_cTask.GetSaveVal(TASKVALUE_PT_MASTER_PR_VALUE);
	return nValue > 0 ? nValue : 0;
}

static int PhongThanMprSetValue(int nPlayerIndex, int nValue)
{
	if (nValue < 0)
		nValue = 0;
	if (nValue > PHONGTHAN_MPR_VALUE_MAX)
		nValue = PHONGTHAN_MPR_VALUE_MAX;
	Player[nPlayerIndex].m_cTask.SetSaveVal(TASKVALUE_PT_MASTER_PR_VALUE, nValue, TRUE);
	return nValue;
}

static int PhongThanMprGetCount(int nPlayerIndex)
{
	int nCount = Player[nPlayerIndex].m_cTask.GetSaveVal(TASKVALUE_PT_MASTER_APPRENTICE_COUNT);
	return nCount > 0 ? nCount : 0;
}

static void PhongThanMprAddCount(int nPlayerIndex, int nDelta)
{
	if (!PhongThanMprLive(nPlayerIndex))
		return;
	int nCount = PhongThanMprGetCount(nPlayerIndex) + nDelta;
	Player[nPlayerIndex].m_cTask.SetSaveVal(TASKVALUE_PT_MASTER_APPRENTICE_COUNT,
		nCount > 0 ? nCount : 0, TRUE);
}

// apprentice side: store the master's name over the 3 string slots (15 chars + NUL each, strcpy in SetSaveVal)
static void PhongThanMprSetMasterName(int nPlayerIndex, const char *pszName)
{
	int nLength = pszName ? (int)strlen(pszName) : 0;
	int nPos = 0;
	for (int i = TASKVALUE_PT_MASTER_NAME_BEGIN; i <= TASKVALUE_PT_MASTER_NAME_END; ++i)
	{
		char szPart[PHONGTHAN_MPR_NAME_PART + 1];
		int nPart = nLength - nPos;
		if (nPart > PHONGTHAN_MPR_NAME_PART)
			nPart = PHONGTHAN_MPR_NAME_PART;
		if (nPart < 0)
			nPart = 0;
		if (nPart > 0)
			memcpy(szPart, pszName + nPos, nPart);
		szPart[nPart] = 0;
		nPos += nPart;
		Player[nPlayerIndex].m_cTask.SetSaveVal(i, szPart, TRUE);
	}
}

static BOOL PhongThanMprIsMasterOf(int nMaster, int nApprentice)
{
	if (!PhongThanMprLive(nMaster) || !PhongThanMprLive(nApprentice))
		return FALSE;
	char szMaster[64];
	GetPersistentMasterName(nApprentice, szMaster, sizeof(szMaster));
	return szMaster[0] && strcmp(szMaster, Player[nMaster].Name) == 0;
}

// the pair of a VNG "bai su": team of exactly 2, master level >= 50, apprentice level < 30 without a master
static BOOL PhongThanMprResolvePair(int nCaller, int *pnMaster, int *pnApprentice)
{
	if (!PhongThanMprLive(nCaller))
		return FALSE;
	int nMate = PhongThanDieuTriGetTeamMate(nCaller);
	if (nMate <= 0 || nMate == nCaller || !PhongThanMprLive(nMate))
		return FALSE;
	int nMaster = 0, nApprentice = 0;
	if (PhongThanMprLevel(nCaller) >= PHONGTHAN_MPR_MASTER_MIN_LEVEL &&
		PhongThanMprLevel(nMate) <= PHONGTHAN_MPR_APPRENTICE_MAX_LEVEL)
	{
		nMaster = nCaller;
		nApprentice = nMate;
	}
	else if (PhongThanMprLevel(nMate) >= PHONGTHAN_MPR_MASTER_MIN_LEVEL &&
		PhongThanMprLevel(nCaller) <= PHONGTHAN_MPR_APPRENTICE_MAX_LEVEL)
	{
		nMaster = nMate;
		nApprentice = nCaller;
	}
	else
		return FALSE;
	char szMaster[64];
	GetPersistentMasterName(nApprentice, szMaster, sizeof(szMaster));
	if (szMaster[0])
		return FALSE;
	if (PhongThanMprIsMasterOf(nApprentice, nMaster))
		return FALSE;
	if (PhongThanMprGetCount(nMaster) >= PHONGTHAN_MPR_MAX_APPRENTICES)
		return FALSE;
	if (pnMaster)
		*pnMaster = nMaster;
	if (pnApprentice)
		*pnApprentice = nApprentice;
	return TRUE;
}

int LuaMasterPRVersionCompat(Lua_State *L)
{
	Lua_PushNumber(L, PHONGTHAN_MPR_VERSION);
	return 1;
}

int LuaGetMasterPRValueCompat(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	Lua_PushNumber(L, PhongThanMprLive(nPlayerIndex) ? PhongThanMprGetValue(nPlayerIndex) : 0);
	return 1;
}

int LuaAddMasterPRValueCompat(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (!PhongThanMprLive(nPlayerIndex))
	{
		Lua_PushNumber(L, 0);
		return 1;
	}
	int nValue = PhongThanMprGetValue(nPlayerIndex);
	int nAdd = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : 0;
	if (nAdd > 0)
	{
		if (nAdd > PHONGTHAN_MPR_VALUE_MAX - nValue)
			nAdd = PHONGTHAN_MPR_VALUE_MAX - nValue;
		nValue = PhongThanMprSetValue(nPlayerIndex, nValue + nAdd);
	}
	Lua_PushNumber(L, nValue);
	return 1;
}

int LuaDecMasterPRValueCompat(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (!PhongThanMprLive(nPlayerIndex))
	{
		Lua_PushNumber(L, 0);
		return 1;
	}
	int nValue = PhongThanMprGetValue(nPlayerIndex);
	int nDec = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : 0;
	if (nDec > 0)
		nValue = PhongThanMprSetValue(nPlayerIndex, nDec >= nValue ? 0 : nValue - nDec);
	Lua_PushNumber(L, nValue);
	return 1;
}

int LuaCanMasterPRCompat(Lua_State *L)
{
	Lua_PushNumber(L, PhongThanMprResolvePair(GetPlayerIndex(L), NULL, NULL) ? 1 : 0);
	return 1;
}

int LuaDoMasterPRCompat(Lua_State *L)
{
	int nMaster = 0, nApprentice = 0;
	int nResult = 0;
	if (PhongThanMprResolvePair(GetPlayerIndex(L), &nMaster, &nApprentice))
	{
		PhongThanMprSetMasterName(nApprentice, Player[nMaster].Name);
		PhongThanMprAddCount(nMaster, 1);
		nResult = 1;
	}
	Lua_PushNumber(L, nResult);
	return 1;
}

int LuaUnMasterPRExCompat(Lua_State *L)
{
	int nCaller = GetPlayerIndex(L);
	int nResult = 0;
	if (!PhongThanMprLive(nCaller))
	{
		Lua_PushNumber(L, 0);
		return 1;
	}
	const char *pszName = NULL;
	if (Lua_GetTopIndex(L) >= 1 && Lua_IsString(L, 1))
		pszName = Lua_ValueToString(L, 1);
	char szOwnMaster[64];
	GetPersistentMasterName(nCaller, szOwnMaster, sizeof(szOwnMaster));
	if (!pszName || !pszName[0])
	{
		// the caller leaves its own master (solo graduation)
		if (szOwnMaster[0])
		{
			PhongThanMprAddCount(FindOnlinePlayerByExactName(szOwnMaster), -1);
			PhongThanMprSetMasterName(nCaller, "");
			nResult = 1;
		}
	}
	else if (szOwnMaster[0] && strcmp(szOwnMaster, pszName) == 0)
	{
		// caller = apprentice of `name`
		PhongThanMprAddCount(FindOnlinePlayerByExactName(pszName), -1);
		PhongThanMprSetMasterName(nCaller, "");
		nResult = 1;
	}
	else
	{
		// caller = master of `name` (the apprentice must be online: its record holds the relation)
		int nTarget = FindOnlinePlayerByExactName(pszName);
		if (nTarget > 0 && PhongThanMprIsMasterOf(nCaller, nTarget))
		{
			PhongThanMprSetMasterName(nTarget, "");
			PhongThanMprAddCount(nCaller, -1);
			nResult = 1;
		}
	}
	Lua_PushNumber(L, nResult);
	return 1;
}

int LuaCanChangeMasterPRValueCompat(Lua_State *L)
{
	Lua_PushNumber(L, 0);
	return 1;
}

int LuaChangeMasterPRValueCompat(Lua_State *L)
{
	Lua_PushNumber(L, 0);
	return 1;
}

static int PhongThanGetNativeWeight(int nPlayerIndex)
{
	int nValue = Player[nPlayerIndex].m_cTask.GetSaveVal(TASKVALUE_PT_NATIVE_WEIGHT_MAX);
	return nValue > 0 ? nValue : PHONGTHAN_WEIGHT_BASE;
}

int LuaGetNativeWeightMaxCompat(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	Lua_PushNumber(L, PhongThanMprLive(nPlayerIndex) ? PhongThanGetNativeWeight(nPlayerIndex) : 0);
	return 1;
}

int LuaAddWeightMaxCompat(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (!PhongThanMprLive(nPlayerIndex))
	{
		Lua_PushNumber(L, 0);
		return 1;
	}
	int nValue = PhongThanGetNativeWeight(nPlayerIndex);
	int nAdd = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : 0;
	if (nAdd > PHONGTHAN_WEIGHT_MAX)
		nAdd = PHONGTHAN_WEIGHT_MAX;
	if (nAdd < -PHONGTHAN_WEIGHT_MAX)
		nAdd = -PHONGTHAN_WEIGHT_MAX;
	nValue += nAdd;
	if (nValue < 1)
		nValue = 1;
	if (nValue > PHONGTHAN_WEIGHT_MAX)
		nValue = PHONGTHAN_WEIGHT_MAX;
	Player[nPlayerIndex].m_cTask.SetSaveVal(TASKVALUE_PT_NATIVE_WEIGHT_MAX, nValue, TRUE);
	Lua_PushNumber(L, nValue);
	return 1;
}

#endif
