#ifndef PHONG_THAN_LUA_CONGTHANH_H
#define PHONG_THAN_LUA_CONGTHANH_H

// Phong Than 2026-10-03 (congthanh): guild-mode natives of the VNG territory scripts
// (\script\ji shi guo zhan\*.lua: Trai linh, Dien Phong Than, Phong luyen thuoc, Thao truong, building
// unlock OnBuild, qicaidan, mojiangzhiling). Until now these names were not registered: the scripts
// either aborted ("attempt to call global") or got the pt_compat.lua zero/no-op fallback.
// Solo players use the Lua "personal territory" (script\phongthan\congthanh\ct_api.lua, task values
// 2430-2479); ct_api.lua falls back to these natives only when the player owns no personal territory.
// Every value needs a real tong (KPlayerTong::m_nFlag) and, for city values, a city owned by that tong
// (KSubWorld::m_bCheckTong / m_dwTongName, set by LoadTongMap). Without a tong every getter returns 0
// and every setter does nothing, exactly like the old Lua fallback, so deploying this is safe today.
// Storage = the Wave 8 KGameData persistent groups (PhongThanGet/SetPersistentValue):
//   city task      pt_persist_city_task, owner = city id (same store as GetCityTaskByID / SetCityTaskByID)
//   city resource  pt_persist_tong_resource, owner = tong id, slot 200 + type (AddTongAttr uses 100 + type)
//   city level     pt_persist_city_task, owner = city id, slot 9000 (1 when never set)
//   contribution   PHONGTHAN_PERSIST_CT_CONTRI, owner = tong id, slot = hash of the role name
// Requires PhongThanLuaWave7.h and PhongThanLuaWave8.h (included before this header in ScriptFuns.cpp).

#define PHONGTHAN_CT_RES_SLOT 200
#define PHONGTHAN_CT_LEVEL_TASK 9000
#define PHONGTHAN_PERSIST_CT_CONTRI 7301

// player in a tong (returns the player index, 0 otherwise)
static int PhongThanCTTongPlayer(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (!PhongThanIsLivePlayer(nPlayerIndex) || !Player[nPlayerIndex].m_cTong.m_nFlag)
		return 0;
	return nPlayerIndex;
}

// city id of the player's current map (0 when unknown)
static int PhongThanCTCurrentCity(Lua_State *L)
{
	int nSubWorld = PhongThanCurrentSubWorld(L);
	if (nSubWorld < 0 || nSubWorld >= MAX_SUBWORLD)
		return 0;
	return SubWorld[nSubWorld].m_SubWorldID > 0 ? SubWorld[nSubWorld].m_SubWorldID : 0;
}

// the player's tong owns the map the player stands on
static int PhongThanCTOwnsCurrentCity(Lua_State *L, int nPlayerIndex)
{
	int nSubWorld = PhongThanCurrentSubWorld(L);
	if (nPlayerIndex <= 0 || nSubWorld < 0 || nSubWorld >= MAX_SUBWORLD)
		return 0;
	return (SubWorld[nSubWorld].m_bCheckTong &&
		SubWorld[nSubWorld].m_dwTongName == Player[nPlayerIndex].m_cTong.m_dwTongNameID) ? 1 : 0;
}

// first city owned by the player's tong (0 = none)
static int PhongThanCTOwnedCity(int nPlayerIndex)
{
	if (nPlayerIndex <= 0)
		return 0;
	DWORD dwTongId = Player[nPlayerIndex].m_cTong.m_dwTongNameID;
	for (int i = 0; i < MAX_SUBWORLD; ++i)
	{
		if (SubWorld[i].m_SubWorldID > 0 && SubWorld[i].m_bCheckTong &&
			SubWorld[i].m_dwTongName == dwTongId)
			return SubWorld[i].m_SubWorldID;
	}
	return 0;
}

static int PhongThanCTContriSlot(int nPlayerIndex)
{
	return (int)(g_FileName2Id(Player[nPlayerIndex].Name) & 0x7fffffff);
}

// GetCityTask(task) -> value of the current city
int LuaGetCityTaskCompat(Lua_State *L)
{
	int nTask = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : 0;
	int nCity = PhongThanCTCurrentCity(L);
	Lua_PushNumber(L, nCity > 0 ?
		PhongThanGetPersistentValue(pt_persist_city_task, (DWORD)nCity, nTask) : 0);
	return 1;
}

// SetCityTask(task, value) -> 1 when stored (only by a member of the owning tong, in the city)
int LuaSetCityTaskCompat(Lua_State *L)
{
	int nPlayerIndex = PhongThanCTTongPlayer(L);
	int nResult = 0;
	if (nPlayerIndex && Lua_GetTopIndex(L) >= 2 && PhongThanCTOwnsCurrentCity(L, nPlayerIndex))
	{
		int nCity = PhongThanCTCurrentCity(L);
		if (nCity > 0)
			nResult = PhongThanSetPersistentValue(pt_persist_city_task, (DWORD)nCity,
				(int)Lua_ValueToNumber(L, 1), (int)Lua_ValueToNumber(L, 2));
	}
	Lua_PushNumber(L, nResult);
	return 1;
}

// AddCityIndexRes(type, delta) -> new amount of the city resource (huong lieu 1, go 2, ...)
int LuaAddCityIndexResCompat(Lua_State *L)
{
	int nPlayerIndex = PhongThanCTTongPlayer(L);
	int nValue = 0;
	if (nPlayerIndex && Lua_GetTopIndex(L) >= 1 && PhongThanCTOwnsCurrentCity(L, nPlayerIndex))
	{
		int nType = (int)Lua_ValueToNumber(L, 1);
		int nDelta = Lua_GetTopIndex(L) >= 2 ? (int)Lua_ValueToNumber(L, 2) : 1;
		if (nType < 0) nType = 0;
		if (nType > 99) nType = 99;
		DWORD dwTongId = Player[nPlayerIndex].m_cTong.m_dwTongNameID;
		nValue = PhongThanGetPersistentValue(pt_persist_tong_resource, dwTongId,
			PHONGTHAN_CT_RES_SLOT + nType) + nDelta;
		if (nValue < 0) nValue = 0;
		PhongThanSetPersistentValue(pt_persist_tong_resource, dwTongId,
			PHONGTHAN_CT_RES_SLOT + nType, nValue);
	}
	Lua_PushNumber(L, nValue);
	return 1;
}

// GetCityIndexRes(type) -> amount of the city resource of the player's tong
int LuaGetCityIndexResCompat(Lua_State *L)
{
	int nPlayerIndex = PhongThanCTTongPlayer(L);
	int nValue = 0;
	if (nPlayerIndex && Lua_GetTopIndex(L) >= 1)
	{
		int nType = (int)Lua_ValueToNumber(L, 1);
		if (nType < 0) nType = 0;
		if (nType > 99) nType = 99;
		nValue = PhongThanGetPersistentValue(pt_persist_tong_resource,
			Player[nPlayerIndex].m_cTong.m_dwTongNameID, PHONGTHAN_CT_RES_SLOT + nType);
	}
	Lua_PushNumber(L, nValue);
	return 1;
}

// GetOwnCityLevel() -> level (1..4) of the city owned by the player's tong, 0 = no city
int LuaGetOwnCityLevelCompat(Lua_State *L)
{
	int nPlayerIndex = PhongThanCTTongPlayer(L);
	int nLevel = 0;
	int nCity = PhongThanCTOwnedCity(nPlayerIndex);
	if (nCity > 0)
	{
		nLevel = PhongThanGetPersistentValue(pt_persist_city_task, (DWORD)nCity,
			PHONGTHAN_CT_LEVEL_TASK);
		if (nLevel < 1) nLevel = 1;
		if (nLevel > 4) nLevel = 4;
	}
	Lua_PushNumber(L, nLevel);
	return 1;
}

// IsHaveTongRight(right) -> 1 for the tong master (VNG rights 11 demolish, 13 resources, 15 tax)
int LuaIsHaveTongRightCompat(Lua_State *L)
{
	int nPlayerIndex = PhongThanCTTongPlayer(L);
	Lua_PushNumber(L, (nPlayerIndex &&
		Player[nPlayerIndex].m_cTong.m_nFigure == enumTONG_FIGURE_MASTER) ? 1 : 0);
	return 1;
}

// GetTongContri() -> contribution of the role in its tong
int LuaGetTongContriCompat(Lua_State *L)
{
	int nPlayerIndex = PhongThanCTTongPlayer(L);
	Lua_PushNumber(L, nPlayerIndex ? PhongThanGetPersistentValue(PHONGTHAN_PERSIST_CT_CONTRI,
		Player[nPlayerIndex].m_cTong.m_dwTongNameID, PhongThanCTContriSlot(nPlayerIndex)) : 0);
	return 1;
}

// AddTongContri(delta) -> new contribution (floored at 0)
int LuaAddTongContriCompat(Lua_State *L)
{
	int nPlayerIndex = PhongThanCTTongPlayer(L);
	int nValue = 0;
	if (nPlayerIndex && Lua_GetTopIndex(L) >= 1)
	{
		DWORD dwTongId = Player[nPlayerIndex].m_cTong.m_dwTongNameID;
		int nSlot = PhongThanCTContriSlot(nPlayerIndex);
		nValue = PhongThanGetPersistentValue(PHONGTHAN_PERSIST_CT_CONTRI, dwTongId, nSlot) +
			(int)Lua_ValueToNumber(L, 1);
		if (nValue < 0) nValue = 0;
		PhongThanSetPersistentValue(PHONGTHAN_PERSIST_CT_CONTRI, dwTongId, nSlot, nValue);
	}
	Lua_PushNumber(L, nValue);
	return 1;
}

#endif // PHONG_THAN_LUA_CONGTHANH_H
