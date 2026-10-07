#ifndef PHONG_THAN_LUA_WAVE8_H
#define PHONG_THAN_LUA_WAVE8_H

// Phong Than VNG Lua completion campaign - Wave 8.
// Tong identity comes from KPlayerTong, city ownership comes from KSubWorld,
// durable tasks/resources use KGameData, and transient siege objects retain
// both the engine index and m_dwID to survive NPC-slot recycling safely.

#define PHONGTHAN_SIEGE_MAX 64
#define PHONGTHAN_TGUARD_MAX 128
#define PHONGTHAN_CITY_REF_MAX 64

enum PHONGTHAN_PERSIST_SCOPE
{
	pt_persist_city_task = 7101,
	pt_persist_tong_task = 7102,
	pt_persist_tong_resource = 7103,
	pt_persist_union_tong = 7104,
	pt_persist_union_warpower = 7105
};

struct PHONGTHAN_SIEGE_RECORD
{
	int bUsed;
	int nNpcIndex;
	DWORD dwNpcId;
	int nMapId;
	int nType;
	DWORD dwCreatorUuid;
};

struct PHONGTHAN_TGUARD_RECORD
{
	int bUsed;
	int nPlayerIndex;
	DWORD dwPlayerUuid;
	char szPlayerName[32];
	int nCarriageIndex;
	int nBounty;
	int nState;
	DWORD dwTongId;
};

struct PHONGTHAN_CITY_NPC_REFS
{
	int nCityId;
	int nGateNpcIndex;
	DWORD dwGateNpcId;
	int nTotemNpcIndex;
	DWORD dwTotemNpcId;
};

static PHONGTHAN_SIEGE_RECORD g_PhongThanSiege[PHONGTHAN_SIEGE_MAX];
static PHONGTHAN_TGUARD_RECORD g_PhongThanTGuard[PHONGTHAN_TGUARD_MAX];
static PHONGTHAN_CITY_NPC_REFS g_PhongThanCityRefs[PHONGTHAN_CITY_REF_MAX];

// Phong Than 2026-10-03 (vantieu): defined in PhongThanLuaCarriage.h (SendCarriage record).
static int PhongThanCarriageBounty(int nCarriageIndex);

static int PhongThanPersistentGroup(int nScope, DWORD dwOwnerId,
	int nSlot, int bCreate)
{
	char szKey[96];
	for (int nSalt = 0; nSalt < 16; ++nSalt)
	{
		sprintf(szKey, "phongthan:%d:%lu:%d:%d", nScope,
			(unsigned long)dwOwnerId, nSlot, nSalt);
		DWORD dwKey = g_FileName2Id(szKey);
		if (!dwKey) continue;
		int nGroup = GameData.FindDataId(dwKey);
		if (nGroup >= 0)
		{
			if (GameData.m_sDataGroup[nGroup].nValue[0] == nScope &&
				(DWORD)GameData.m_sDataGroup[nGroup].nValue[1] == dwOwnerId &&
				GameData.m_sDataGroup[nGroup].nValue[2] == nSlot)
				return nGroup;
			continue;
		}
		if (bCreate)
		{
			KDataGroup Info;
			Info.Clear();
			Info.nNameId = dwKey;
			Info.nValue[0] = nScope;
			Info.nValue[1] = (int)dwOwnerId;
			Info.nValue[2] = nSlot;
			Info.nValue[3] = 0;
			g_StrCpyLen(Info.szName1, "PhongThan", sizeof(Info.szName1));
			sprintf(Info.szName2, "%d:%d", nScope, nSlot);
			return GameData.AddDataGr(&Info);
		}
	}
	return -1;
}

static int PhongThanGetPersistentValue(int nScope, DWORD dwOwnerId, int nSlot)
{
	int nGroup = PhongThanPersistentGroup(nScope, dwOwnerId, nSlot, 0);
	return nGroup >= 0 ? GameData.m_sDataGroup[nGroup].nValue[3] : 0;
}

static int PhongThanSetPersistentValue(int nScope, DWORD dwOwnerId,
	int nSlot, int nValue)
{
	int nGroup = PhongThanPersistentGroup(nScope, dwOwnerId, nSlot, 1);
	if (nGroup < 0)
		return 0;
	GameData.m_sDataGroup[nGroup].nValue[3] = nValue;
	GameData.Save();
	return 1;
}

static int PhongThanTongPlayerById(DWORD dwTongId)
{
	int nPlayerIndex = PlayerSet.GetNextPlayerFrom(0);
	while (nPlayerIndex > 0)
	{
		if (Player[nPlayerIndex].m_cTong.m_nFlag &&
			Player[nPlayerIndex].m_cTong.m_dwTongNameID == dwTongId)
			return nPlayerIndex;
		nPlayerIndex = PlayerSet.GetNextPlayerFrom(nPlayerIndex);
	}
	return 0;
}

static void PhongThanSendTongMessage(DWORD dwTongId, const char *pszMessage)
{
	if (!dwTongId || !pszMessage || !pszMessage[0])
		return;
	int nPlayerIndex = PlayerSet.GetNextPlayerFrom(0);
	while (nPlayerIndex > 0)
	{
		if (Player[nPlayerIndex].m_cTong.m_nFlag &&
			Player[nPlayerIndex].m_cTong.m_dwTongNameID == dwTongId)
		{
			KPlayerChat::SendSystemInfo(1, nPlayerIndex,
				MESSAGE_BROADCAST_ANNOUCE_HEAD, (char *)pszMessage,
				strlen(pszMessage));
		}
		nPlayerIndex = PlayerSet.GetNextPlayerFrom(nPlayerIndex);
	}
}

static int PhongThanSubWorldFromCityId(int nCityId)
{
	int nSubWorld = g_SubWorldSet.SearchWorld((DWORD)nCityId);
	if (nSubWorld < 0 && nCityId >= 0 && nCityId < MAX_SUBWORLD &&
		SubWorld[nCityId].m_SubWorldID >= 0)
		nSubWorld = nCityId;
	return nSubWorld;
}

static int PhongThanCurrentSubWorld(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (PhongThanIsLivePlayer(nPlayerIndex))
		return Npc[Player[nPlayerIndex].m_nIndex].m_SubWorldIndex;
	return -1;
}

static const char *PhongThanCityName(int nCityId)
{
	if (nCityId >= 0 && nCityId <= g_SubWorldSet.m_MapListCount &&
		g_SubWorldSet.m_sMapListInfo)
		return g_SubWorldSet.m_sMapListInfo[nCityId].szName;
	return "";
}

static void PhongThanPushCityInfo(Lua_State *L, int nCityId)
{
	int nSubWorld = PhongThanSubWorldFromCityId(nCityId);
	if (nSubWorld < 0)
	{
		Lua_PushString(L, "");
		for (int i = 0; i < 5; ++i) Lua_PushNumber(L, 0);
		Lua_PushString(L, "");
		return;
	}
	KSubWorld &rWorld = SubWorld[nSubWorld];
	int nLevel = rWorld.m_bCheckTong ? 1 : 0;
	int nTemplate = nCityId >= 0 ? nCityId % 5 : 0;
	Lua_PushString(L, PhongThanCityName(nCityId));
	Lua_PushNumber(L, rWorld.m_bCheckTong ? 1 : 0);
	Lua_PushNumber(L, rWorld.m_nTongT);
	Lua_PushNumber(L, rWorld.m_nTongVG);
	Lua_PushNumber(L, nLevel);
	Lua_PushNumber(L, nTemplate);
	Lua_PushString(L, rWorld.m_szTongName);
}

static int PhongThanValidSiege(int nCarriageIndex)
{
	if (nCarriageIndex <= 0 || nCarriageIndex > PHONGTHAN_SIEGE_MAX)
		return 0;
	PHONGTHAN_SIEGE_RECORD *pRecord =
		&g_PhongThanSiege[nCarriageIndex - 1];
	if (!pRecord->bUsed || !PhongThanIsLiveNpc(pRecord->nNpcIndex) ||
		Npc[pRecord->nNpcIndex].m_dwID != pRecord->dwNpcId)
	{
		ZeroMemory(pRecord, sizeof(*pRecord));
		return 0;
	}
	return 1;
}

static int PhongThanFindSiegeByNpc(int nNpcIndex)
{
	if (!PhongThanIsLiveNpc(nNpcIndex))
		return 0;
	for (int i = 0; i < PHONGTHAN_SIEGE_MAX; ++i)
	{
		if (PhongThanValidSiege(i + 1) &&
			g_PhongThanSiege[i].nNpcIndex == nNpcIndex &&
			g_PhongThanSiege[i].dwNpcId == Npc[nNpcIndex].m_dwID)
			return i + 1;
	}
	return 0;
}

static int PhongThanRegisterExistingSiege(int nNpcIndex, int nType)
{
	int nExisting = PhongThanFindSiegeByNpc(nNpcIndex);
	if (nExisting)
		return nExisting;
	if (!PhongThanIsLiveNpc(nNpcIndex))
		return 0;
	for (int i = 0; i < PHONGTHAN_SIEGE_MAX; ++i)
	{
		if (!PhongThanValidSiege(i + 1))
		{
			PHONGTHAN_SIEGE_RECORD *pRecord = &g_PhongThanSiege[i];
			ZeroMemory(pRecord, sizeof(*pRecord));
			pRecord->bUsed = 1;
			pRecord->nNpcIndex = nNpcIndex;
			pRecord->dwNpcId = Npc[nNpcIndex].m_dwID;
			int nSubWorld = Npc[nNpcIndex].m_SubWorldIndex;
			pRecord->nMapId = nSubWorld >= 0 && nSubWorld < MAX_SUBWORLD ?
				SubWorld[nSubWorld].m_SubWorldID : 0;
			pRecord->nType = nType;
			return i + 1;
		}
	}
	return 0;
}

static int PhongThanValidGuard(int nGuardIndex)
{
	if (nGuardIndex <= 0 || nGuardIndex > PHONGTHAN_TGUARD_MAX)
		return 0;
	PHONGTHAN_TGUARD_RECORD *pGuard = &g_PhongThanTGuard[nGuardIndex - 1];
	if (!pGuard->bUsed || !PhongThanIsLivePlayer(pGuard->nPlayerIndex) ||
		Player[pGuard->nPlayerIndex].m_dwID != pGuard->dwPlayerUuid ||
		!PhongThanValidSiege(pGuard->nCarriageIndex))
	{
		ZeroMemory(pGuard, sizeof(*pGuard));
		return 0;
	}
	return 1;
}

static int PhongThanFindGuardByPlayer(int nPlayerIndex)
{
	if (!PhongThanIsLivePlayer(nPlayerIndex))
		return 0;
	for (int i = 0; i < PHONGTHAN_TGUARD_MAX; ++i)
		if (PhongThanValidGuard(i + 1) &&
			g_PhongThanTGuard[i].nPlayerIndex == nPlayerIndex &&
			g_PhongThanTGuard[i].dwPlayerUuid == Player[nPlayerIndex].m_dwID)
			return i + 1;
	return 0;
}

static int PhongThanAttachPlayerToSiege(int nPlayerIndex, int nCarriageIndex)
{
	if (!PhongThanIsLivePlayer(nPlayerIndex) ||
		!PhongThanValidSiege(nCarriageIndex))
		return 0;
	int nGuardIndex = PhongThanFindGuardByPlayer(nPlayerIndex);
	if (!nGuardIndex)
	{
		for (int i = 0; i < PHONGTHAN_TGUARD_MAX; ++i)
		{
			if (!g_PhongThanTGuard[i].bUsed)
			{
				nGuardIndex = i + 1;
				break;
			}
		}
	}
	if (!nGuardIndex)
		return 0;
	PHONGTHAN_TGUARD_RECORD *pGuard = &g_PhongThanTGuard[nGuardIndex - 1];
	ZeroMemory(pGuard, sizeof(*pGuard));
	pGuard->bUsed = 1;
	pGuard->nPlayerIndex = nPlayerIndex;
	pGuard->dwPlayerUuid = Player[nPlayerIndex].m_dwID;
	g_StrCpyLen(pGuard->szPlayerName, Player[nPlayerIndex].Name,
		sizeof(pGuard->szPlayerName));
	pGuard->nCarriageIndex = nCarriageIndex;
	pGuard->nState = 1;
	pGuard->nBounty = PhongThanCarriageBounty(nCarriageIndex);	// 2026-10-03: bounty of the carriage
	pGuard->dwTongId = Player[nPlayerIndex].m_cTong.m_nFlag ?
		Player[nPlayerIndex].m_cTong.m_dwTongNameID : 0;
	Player[nPlayerIndex].m_cTask.SetSaveVal(
		TASKVALUE_PT_INSIDE_WEAPON, nCarriageIndex, TRUE);
	return nGuardIndex;
}

static void PhongThanDetachGuard(int nGuardIndex)
{
	if (nGuardIndex <= 0 || nGuardIndex > PHONGTHAN_TGUARD_MAX)
		return;
	PHONGTHAN_TGUARD_RECORD *pGuard = &g_PhongThanTGuard[nGuardIndex - 1];
	if (pGuard->bUsed && PhongThanIsLivePlayer(pGuard->nPlayerIndex) &&
		Player[pGuard->nPlayerIndex].m_dwID == pGuard->dwPlayerUuid)
		Player[pGuard->nPlayerIndex].m_cTask.SetSaveVal(
			TASKVALUE_PT_INSIDE_WEAPON, 0, TRUE);
	ZeroMemory(pGuard, sizeof(*pGuard));
}

static PHONGTHAN_CITY_NPC_REFS *PhongThanCityRefs(int nCityId)
{
	if (nCityId <= 0)
		return NULL;
	PHONGTHAN_CITY_NPC_REFS *pFree = NULL;
	for (int i = 0; i < PHONGTHAN_CITY_REF_MAX; ++i)
	{
		if (g_PhongThanCityRefs[i].nCityId == nCityId)
			return &g_PhongThanCityRefs[i];
		if (!pFree && g_PhongThanCityRefs[i].nCityId == 0)
			pFree = &g_PhongThanCityRefs[i];
	}
	if (pFree)
	{
		ZeroMemory(pFree, sizeof(*pFree));
		pFree->nCityId = nCityId;
	}
	return pFree;
}

static int PhongThanFindOnlineUnionPlayer(int nPosterityType)
{
	int nPlayerIndex = PlayerSet.GetNextPlayerFrom(0);
	while (nPlayerIndex > 0)
	{
		if (Player[nPlayerIndex].m_cTong.m_nFlag &&
			Player[nPlayerIndex].m_cTask.GetSaveVal(
				TASKVALUE_PT_POSTERITY_TYPE) == nPosterityType)
			return nPlayerIndex;
		nPlayerIndex = PlayerSet.GetNextPlayerFrom(nPlayerIndex);
	}
	return 0;
}

static void PhongThanBindUnionTong(int nPosterityType, int nPlayerIndex)
{
	if (nPosterityType <= 0 || !PhongThanIsLivePlayer(nPlayerIndex) ||
		!Player[nPlayerIndex].m_cTong.m_nFlag)
		return;
	int nGroup = PhongThanPersistentGroup(pt_persist_union_tong,
		(DWORD)nPosterityType, 0, 1);
	if (nGroup < 0) return;
	GameData.m_sDataGroup[nGroup].nValue[3] =
		(int)Player[nPlayerIndex].m_cTong.m_dwTongNameID;
	g_StrCpyLen(GameData.m_sDataGroup[nGroup].szName1,
		Player[nPlayerIndex].m_cTong.m_szName,
		sizeof(GameData.m_sDataGroup[nGroup].szName1));
	GameData.Save();
}

int LuaIsTongMemberCompat(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nResult = 0;
	if (PhongThanIsLivePlayer(nPlayerIndex) &&
		Player[nPlayerIndex].m_cTong.m_nFlag)
	{
		nResult = 1;
		if (Lua_GetTopIndex(L) >= 1)
		{
			int nPosterityType = (int)Lua_ValueToNumber(L, 1);
			nResult = Player[nPlayerIndex].m_cTask.GetSaveVal(
				TASKVALUE_PT_POSTERITY_TYPE) == nPosterityType ? 1 : 0;
			if (nResult) PhongThanBindUnionTong(nPosterityType, nPlayerIndex);
		}
	}
	Lua_PushNumber(L, nResult);
	return 1;
}

int LuaMsg2TongMemberCompat(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (PhongThanIsLivePlayer(nPlayerIndex) &&
		Player[nPlayerIndex].m_cTong.m_nFlag &&
		Lua_GetTopIndex(L) >= 1 && Lua_IsString(L, 1))
		PhongThanSendTongMessage(Player[nPlayerIndex].m_cTong.m_dwTongNameID,
			Lua_ValueToString(L, 1));
	return 0;
}

int LuaMsg2TongMemberByTongNameCompat(Lua_State *L)
{
	if (Lua_GetTopIndex(L) >= 2 && Lua_IsString(L, 1) && Lua_IsString(L, 2))
		PhongThanSendTongMessage(g_FileName2Id((char *)Lua_ValueToString(L, 1)),
			Lua_ValueToString(L, 2));
	return 0;
}

int LuaIsOwnerCityCompat(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nSubWorld = PhongThanCurrentSubWorld(L);
	int nResult = 0;
	if (PhongThanIsLivePlayer(nPlayerIndex) && nSubWorld >= 0 &&
		Player[nPlayerIndex].m_cTong.m_nFlag && SubWorld[nSubWorld].m_bCheckTong)
	{
		DWORD dwTongId = Player[nPlayerIndex].m_cTong.m_dwTongNameID;
		nResult = dwTongId == SubWorld[nSubWorld].m_dwTongName ? 1 : 0;
	}
	Lua_PushNumber(L, nResult);
	return 1;
}

int LuaGetCityInfoCompat(Lua_State *L)
{
	int nSubWorld = PhongThanCurrentSubWorld(L);
	int nCityId = nSubWorld >= 0 ? SubWorld[nSubWorld].m_SubWorldID : 0;
	PhongThanPushCityInfo(L, nCityId);
	return 7;
}

int LuaNewSiegeWeaponCompat(Lua_State *L)
{
	if (Lua_GetTopIndex(L) < 4)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}
	int nMapId = (int)Lua_ValueToNumber(L, 1);
	int nSubWorld = PhongThanSubWorldFromCityId(nMapId);
	int nTemplateId = (int)Lua_ValueToNumber(L, 4);
	int nNpcIndex = PhongThanSpawnNpc(nTemplateId, 1, nSubWorld,
		(int)Lua_ValueToNumber(L, 2), (int)Lua_ValueToNumber(L, 3), FALSE);
	int nCarriageIndex = 0;
	if (nNpcIndex > 0)
	{
		for (int i = 0; i < PHONGTHAN_SIEGE_MAX; ++i)
		{
			if (!PhongThanValidSiege(i + 1))
			{
				nCarriageIndex = i + 1;
				PHONGTHAN_SIEGE_RECORD *pRecord = &g_PhongThanSiege[i];
				ZeroMemory(pRecord, sizeof(*pRecord));
				pRecord->bUsed = 1;
				pRecord->nNpcIndex = nNpcIndex;
				pRecord->dwNpcId = Npc[nNpcIndex].m_dwID;
				pRecord->nMapId = nMapId;
				pRecord->nType = Lua_GetTopIndex(L) >= 5 ?
					(int)Lua_ValueToNumber(L, 5) : nTemplateId;
				int nPlayerIndex = GetPlayerIndex(L);
				pRecord->dwCreatorUuid = PhongThanIsLivePlayer(nPlayerIndex) ?
					Player[nPlayerIndex].m_dwID : 0;
				break;
			}
		}
		if (!nCarriageIndex) PhongThanRemoveNpc(nNpcIndex);
	}
	Lua_PushNumber(L, nCarriageIndex);
	return 1;
}

int LuaGetSiegeWeaponNpcIndexCompat(Lua_State *L)
{
	int nCarriage = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : 0;
	Lua_PushNumber(L, PhongThanValidSiege(nCarriage) ?
		g_PhongThanSiege[nCarriage - 1].nNpcIndex : 0);
	return 1;
}

int LuaGetTongIDByNameCompat(Lua_State *L)
{
	const char *pszName = Lua_GetTopIndex(L) >= 1 && Lua_IsString(L, 1) ?
		Lua_ValueToString(L, 1) : NULL;
	Lua_PushNumber(L, pszName && pszName[0] ?
		g_FileName2Id((char *)pszName) : 0);
	return 1;
}

int LuaGetSiegeWeaponPlayerCountCompat(Lua_State *L)
{
	int nNpcIndex = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : 0;
	int nCarriage = PhongThanFindSiegeByNpc(nNpcIndex);
	int nCount = 0;
	if (nCarriage)
		for (int i = 0; i < PHONGTHAN_TGUARD_MAX; ++i)
			if (PhongThanValidGuard(i + 1) &&
				g_PhongThanTGuard[i].nCarriageIndex == nCarriage)
				++nCount;
	Lua_PushNumber(L, nCount);
	return 1;
}

int LuaGetCityInfoByIDCompat(Lua_State *L)
{
	int nCityId = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : 0;
	PhongThanPushCityInfo(L, nCityId);
	return 7;
}

int LuaGetNpcMapCityIDCompat(Lua_State *L)
{
	int nNpcIndex = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : 0;
	int nCityId = 0;
	if (PhongThanIsLiveNpc(nNpcIndex))
	{
		int nSubWorld = Npc[nNpcIndex].m_SubWorldIndex;
		if (nSubWorld >= 0 && nSubWorld < MAX_SUBWORLD)
			nCityId = SubWorld[nSubWorld].m_SubWorldID;
	}
	Lua_PushNumber(L, nCityId);
	return 1;
}

int LuaGetTGuardInfoCompat(Lua_State *L)
{
	int nGuardIndex = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : 0;
	PHONGTHAN_TGUARD_RECORD *pGuard = PhongThanValidGuard(nGuardIndex) ?
		&g_PhongThanTGuard[nGuardIndex - 1] : NULL;
	Lua_PushNumber(L, pGuard ? pGuard->nBounty : 0);
	Lua_PushNumber(L, pGuard ? pGuard->nState : 0);
	Lua_PushNumber(L, pGuard ? pGuard->nPlayerIndex : 0);
	Lua_PushString(L, pGuard ? pGuard->szPlayerName : "");
	Lua_PushNumber(L, pGuard ? pGuard->nCarriageIndex : 0);
	Lua_PushNumber(L, pGuard ? pGuard->dwPlayerUuid : 0);
	Lua_PushNumber(L, pGuard ? pGuard->dwTongId : 0);
	return 7;
}

int LuaGetCityTaskByIDCompat(Lua_State *L)
{
	DWORD dwCityId = Lua_GetTopIndex(L) >= 1 ?
		(DWORD)Lua_ValueToNumber(L, 1) : 0;
	int nTask = Lua_GetTopIndex(L) >= 2 ?
		(int)Lua_ValueToNumber(L, 2) : 0;
	Lua_PushNumber(L, PhongThanGetPersistentValue(
		pt_persist_city_task, dwCityId, nTask));
	return 1;
}

int LuaDeleteSiegeWeaponCompat(Lua_State *L)
{
	int nCarriage = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : 0;
	int nResult = 0;
	if (PhongThanValidSiege(nCarriage))
	{
		for (int i = 0; i < PHONGTHAN_TGUARD_MAX; ++i)
			if (PhongThanValidGuard(i + 1) &&
				g_PhongThanTGuard[i].nCarriageIndex == nCarriage)
				PhongThanDetachGuard(i + 1);
		PhongThanRemoveNpc(g_PhongThanSiege[nCarriage - 1].nNpcIndex);
		ZeroMemory(&g_PhongThanSiege[nCarriage - 1],
			sizeof(g_PhongThanSiege[nCarriage - 1]));
		nResult = 1;
	}
	Lua_PushNumber(L, nResult);
	return 1;
}

int LuaGetTGuardIndexByCarriageIndexCompat(Lua_State *L)
{
	int nCarriage = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : 0;
	int nGuardIndex = 0;
	if (PhongThanValidSiege(nCarriage))
		for (int i = 0; i < PHONGTHAN_TGUARD_MAX; ++i)
			if (PhongThanValidGuard(i + 1) &&
				g_PhongThanTGuard[i].nCarriageIndex == nCarriage)
			{
				nGuardIndex = i + 1;
				break;
			}
	Lua_PushNumber(L, nGuardIndex);
	return 1;
}

int LuaGetSiegeWeaponIndexByNpcIndexCompat(Lua_State *L)
{
	int nNpcIndex = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : 0;
	Lua_PushNumber(L, PhongThanFindSiegeByNpc(nNpcIndex));
	return 1;
}

int LuaGetTGuardIndexByPlayerNameCompat(Lua_State *L)
{
	const char *pszName = Lua_GetTopIndex(L) >= 1 && Lua_IsString(L, 1) ?
		Lua_ValueToString(L, 1) : NULL;
	int nGuardIndex = 0;
	if (pszName && pszName[0])
	{
		for (int i = 0; i < PHONGTHAN_TGUARD_MAX; ++i)
			if (PhongThanValidGuard(i + 1) &&
				_stricmp(g_PhongThanTGuard[i].szPlayerName, pszName) == 0)
			{
				nGuardIndex = i + 1;
				break;
			}
		if (!nGuardIndex)
		{
			int nPlayerIndex = PlayerSet.GetNextPlayerFrom(0);
			while (nPlayerIndex > 0)
			{
				if (_stricmp(Player[nPlayerIndex].Name, pszName) == 0)
				{
					int nCarriage = Player[nPlayerIndex].m_cTask.GetSaveVal(
						TASKVALUE_PT_INSIDE_WEAPON);
					if (PhongThanValidSiege(nCarriage))
						nGuardIndex = PhongThanAttachPlayerToSiege(
							nPlayerIndex, nCarriage);
					break;
				}
				nPlayerIndex = PlayerSet.GetNextPlayerFrom(nPlayerIndex);
			}
		}
	}
	Lua_PushNumber(L, nGuardIndex);
	return 1;
}

int LuaModifyUnionTongWarPowerByNameCompat(Lua_State *L)
{
	const char *pszName = Lua_GetTopIndex(L) >= 1 && Lua_IsString(L, 1) ?
		Lua_ValueToString(L, 1) : NULL;
	int nDelta = Lua_GetTopIndex(L) >= 2 ?
		(int)Lua_ValueToNumber(L, 2) : 0;
	DWORD dwTongId = pszName && pszName[0] ?
		g_FileName2Id((char *)pszName) : 0;
	int nValue = PhongThanGetPersistentValue(
		pt_persist_union_warpower, dwTongId, 0) + nDelta;
	if (nValue < 0) nValue = 0;
	if (dwTongId)
	{
		PhongThanSetPersistentValue(pt_persist_union_warpower,
			dwTongId, 0, nValue);
		int nPlayerIndex = PlayerSet.GetNextPlayerFrom(0);
		while (nPlayerIndex > 0)
		{
			if (Player[nPlayerIndex].m_cTong.m_nFlag &&
				Player[nPlayerIndex].m_cTong.m_dwTongNameID == dwTongId)
				Player[nPlayerIndex].m_cTong.m_dwTotalEff = (DWORD)nValue;
			nPlayerIndex = PlayerSet.GetNextPlayerFrom(nPlayerIndex);
		}
	}
	Lua_PushNumber(L, nValue);
	return 1;
}

int LuaGetTongTaskByIDCompat(Lua_State *L)
{
	DWORD dwTongId = Lua_GetTopIndex(L) >= 1 ?
		(DWORD)Lua_ValueToNumber(L, 1) : 0;
	int nTask = Lua_GetTopIndex(L) >= 2 ?
		(int)Lua_ValueToNumber(L, 2) : 0;
	Lua_PushNumber(L, PhongThanGetPersistentValue(
		pt_persist_tong_task, dwTongId, nTask));
	return 1;
}

int LuaGetUnionTongNameByPosterityTypeCompat(Lua_State *L)
{
	int nType = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : 0;
	int nPlayerIndex = PhongThanFindOnlineUnionPlayer(nType);
	if (nPlayerIndex) PhongThanBindUnionTong(nType, nPlayerIndex);
	int nGroup = PhongThanPersistentGroup(pt_persist_union_tong,
		(DWORD)nType, 0, 0);
	Lua_PushString(L, nGroup >= 0 ?
		GameData.m_sDataGroup[nGroup].szName1 : "");
	return 1;
}

int LuaSetCityTaskByIDCompat(Lua_State *L)
{
	DWORD dwCityId = Lua_GetTopIndex(L) >= 1 ?
		(DWORD)Lua_ValueToNumber(L, 1) : 0;
	int nTask = Lua_GetTopIndex(L) >= 2 ?
		(int)Lua_ValueToNumber(L, 2) : 0;
	int nValue = Lua_GetTopIndex(L) >= 3 ?
		(int)Lua_ValueToNumber(L, 3) : 0;
	Lua_PushNumber(L, PhongThanSetPersistentValue(
		pt_persist_city_task, dwCityId, nTask, nValue));
	return 1;
}

int LuaGetUnionTongIDByPosterityTypeCompat(Lua_State *L)
{
	int nType = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : 0;
	int nPlayerIndex = PhongThanFindOnlineUnionPlayer(nType);
	if (nPlayerIndex) PhongThanBindUnionTong(nType, nPlayerIndex);
	Lua_PushNumber(L, PhongThanGetPersistentValue(
		pt_persist_union_tong, (DWORD)nType, 0));
	return 1;
}

int LuaGetHeavenCityUnionCompat(Lua_State *L)
{
	return LuaGetUnionTongIDByPosterityTypeCompat(L);
}

int LuaGetCityGateNpcIdxByNpcCompat(Lua_State *L)
{
	int nNpcIndex = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : 0;
	int nGate = 0;
	if (PhongThanIsLiveNpc(nNpcIndex))
	{
		int nSubWorld = Npc[nNpcIndex].m_SubWorldIndex;
		int nCityId = SubWorld[nSubWorld].m_SubWorldID;
		PHONGTHAN_CITY_NPC_REFS *pRefs = PhongThanCityRefs(nCityId);
		if (pRefs && PhongThanIsLiveNpc(pRefs->nGateNpcIndex) &&
			Npc[pRefs->nGateNpcIndex].m_dwID == pRefs->dwGateNpcId)
			nGate = pRefs->nGateNpcIndex;
		else
		{
			int nBestDistance = 0x7fffffff;
			for (int i = 1; i < MAX_NPC; ++i)
			{
				if (i != nNpcIndex && PhongThanIsLiveNpc(i) &&
					Npc[i].m_SubWorldIndex == nSubWorld &&
					Npc[i].m_Kind == kind_dialoger)
				{
					int nDistance = KNpcSet::GetDistance(i, nNpcIndex);
					if (nDistance < nBestDistance)
					{
						nBestDistance = nDistance;
						nGate = i;
					}
				}
			}
			if (!nGate) nGate = nNpcIndex;
			if (pRefs)
			{
				pRefs->nGateNpcIndex = nGate;
				pRefs->dwGateNpcId = Npc[nGate].m_dwID;
			}
		}
	}
	Lua_PushNumber(L, nGate);
	return 1;
}

int LuaIsInMonsterAttackDayCompat(Lua_State *L)
{
	time_t tNow = time(NULL);
	struct tm *pLocal = localtime(&tNow);
	int nState = 0;
	if (pLocal)
	{
		// VNG city attacks have a full Wednesday wave and a reduced
		// Saturday wave.  Returning distinct states preserves Lua's count rule.
		if (pLocal->tm_wday == 3) nState = 1;
		else if (pLocal->tm_wday == 6) nState = 2;
	}
	Lua_PushNumber(L, nState);
	return 1;
}

int LuaGetCityTotemNpcIdxByNpcCompat(Lua_State *L)
{
	int nNpcIndex = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : 0;
	int nTotem = 0;
	if (PhongThanIsLiveNpc(nNpcIndex))
	{
		int nSubWorld = Npc[nNpcIndex].m_SubWorldIndex;
		int nCityId = SubWorld[nSubWorld].m_SubWorldID;
		PHONGTHAN_CITY_NPC_REFS *pRefs = PhongThanCityRefs(nCityId);
		if (pRefs)
		{
			if (!PhongThanIsLiveNpc(pRefs->nTotemNpcIndex) ||
				Npc[pRefs->nTotemNpcIndex].m_dwID != pRefs->dwTotemNpcId)
			{
				pRefs->nTotemNpcIndex = nNpcIndex;
				pRefs->dwTotemNpcId = Npc[nNpcIndex].m_dwID;
			}
			nTotem = pRefs->nTotemNpcIndex;
		}
	}
	Lua_PushNumber(L, nTotem);
	return 1;
}

int LuaSetTongTaskCompat(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nResult = 0;
	if (PhongThanIsLivePlayer(nPlayerIndex) &&
		Player[nPlayerIndex].m_cTong.m_nFlag && Lua_GetTopIndex(L) >= 2)
	{
		int nTask = (int)Lua_ValueToNumber(L, 1);
		int nValue = (int)Lua_ValueToNumber(L, 2);
		int nGroup = Lua_GetTopIndex(L) >= 3 ?
			(int)Lua_ValueToNumber(L, 3) : 0;
		nResult = PhongThanSetPersistentValue(pt_persist_tong_task,
			Player[nPlayerIndex].m_cTong.m_dwTongNameID,
			nTask + nGroup * 10000, nValue);
	}
	Lua_PushNumber(L, nResult);
	return 1;
}

int LuaAddTongResCompat(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nValue = 0;
	if (PhongThanIsLivePlayer(nPlayerIndex) &&
		Player[nPlayerIndex].m_cTong.m_nFlag && Lua_GetTopIndex(L) >= 2)
	{
		int nResource = (int)Lua_ValueToNumber(L, 1);
		int nDelta = (int)Lua_ValueToNumber(L, 2);
		DWORD dwTongId = Player[nPlayerIndex].m_cTong.m_dwTongNameID;
		nValue = PhongThanGetPersistentValue(pt_persist_tong_resource,
			dwTongId, nResource) + nDelta;
		if (nValue < 0) nValue = 0;
		PhongThanSetPersistentValue(pt_persist_tong_resource,
			dwTongId, nResource, nValue);
		int nMember = PlayerSet.GetNextPlayerFrom(0);
		while (nMember > 0)
		{
			if (Player[nMember].m_cTong.m_nFlag &&
				Player[nMember].m_cTong.m_dwTongNameID == dwTongId)
			{
				if (nResource == 1)
					Player[nMember].m_cTong.m_dwMoney = (DWORD)nValue;
				else
					Player[nMember].m_cTong.m_dwTotalEff = (DWORD)nValue;
			}
			nMember = PlayerSet.GetNextPlayerFrom(nMember);
		}
	}
	Lua_PushNumber(L, nValue);
	return 1;
}

int LuaGetTongTaskCompat(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nValue = 0;
	if (PhongThanIsLivePlayer(nPlayerIndex) &&
		Player[nPlayerIndex].m_cTong.m_nFlag && Lua_GetTopIndex(L) >= 1)
	{
		int nTask = (int)Lua_ValueToNumber(L, 1);
		int nGroup = Lua_GetTopIndex(L) >= 2 ?
			(int)Lua_ValueToNumber(L, 2) : 0;
		nValue = PhongThanGetPersistentValue(pt_persist_tong_task,
			Player[nPlayerIndex].m_cTong.m_dwTongNameID,
			nTask + nGroup * 10000);
	}
	Lua_PushNumber(L, nValue);
	return 1;
}

int LuaGetCityNameCompat(Lua_State *L)
{
	int nSubWorld = PhongThanCurrentSubWorld(L);
	int nCityId = nSubWorld >= 0 ? SubWorld[nSubWorld].m_SubWorldID : 0;
	Lua_PushString(L, PhongThanCityName(nCityId));
	return 1;
}

#endif // PHONG_THAN_LUA_WAVE8_H
