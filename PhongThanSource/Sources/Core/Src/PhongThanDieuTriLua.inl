// Native VNG services used by the original 26 NPC scripts in Dieu Tri.
// This file is included by ScriptFuns.cpp inside _SERVER after the Wave 7-9
// helpers, so it can reuse the authoritative player/item/NPC runtime.

static BOOL PhongThanDieuTriIsLivePlayer(int nPlayerIndex)
{
	return nPlayerIndex > 0 && nPlayerIndex < MAX_PLAYER &&
		Player[nPlayerIndex].m_nIndex > 0 &&
		Player[nPlayerIndex].m_nIndex < MAX_NPC;
}

static int PhongThanDieuTriGetTeamMate(int nPlayerIndex)
{
	if (!PhongThanDieuTriIsLivePlayer(nPlayerIndex) ||
		!Player[nPlayerIndex].m_cTeam.m_nFlag)
		return 0;
	int nTeamId = Player[nPlayerIndex].m_cTeam.m_nID;
	if (nTeamId < 0 || nTeamId >= MAX_TEAM ||
		g_Team[nTeamId].m_nMemNum != 1)
		return 0;
	int nMate = g_Team[nTeamId].m_nCaptain == nPlayerIndex ?
		g_Team[nTeamId].m_nMember[0] : g_Team[nTeamId].m_nCaptain;
	return PhongThanDieuTriIsLivePlayer(nMate) && nMate != nPlayerIndex ?
		nMate : 0;
}

static int PhongThanDieuTriGetMateOrSpouse(int nPlayerIndex)
{
	int nMate = PhongThanDieuTriGetTeamMate(nPlayerIndex);
	if (nMate > 0)
		return nMate;
	const char *pszMate = PhongThanDieuTriIsLivePlayer(nPlayerIndex) ?
		Player[nPlayerIndex].m_cTask.GetSaveStr(TASKVALUE_BASEDATA_MATENAME) : NULL;
	return pszMate && pszMate[0] ? FindOnlinePlayerByExactName(pszMate) : 0;
}

static int PhongThanDieuTriCreateExactItem(int nGenre, int nDetail,
	int nParticular, int nLevel, int nSeries, int nLuck)
{
	if (nGenre != item_equip)
		return CreateVngNormalItem(nGenre, nDetail, nParticular,
			nLevel, nSeries, nLuck);
	if (nDetail < 0 || nDetail >= equip_detailnum || nParticular < 0 ||
		nLevel < 0 || nSeries < series_metal || nSeries >= series_num)
		return 0;
	int nMagicLevel[MAX_ITEM_MAGICLEVEL];
	ZeroMemory(nMagicLevel, sizeof(nMagicLevel));
	int nItemIndex = ItemSet.Add(item_equip, nSeries, nLevel, nLuck,
		nDetail, nParticular, nMagicLevel, g_SubWorldSet.GetGameVersion());
	if (nItemIndex <= 0)
		return 0;
	if (Item[nItemIndex].GetGenre() != item_equip ||
		Item[nItemIndex].GetDetailType() != nDetail ||
		Item[nItemIndex].GetParticular() != nParticular ||
		Item[nItemIndex].GetWidth() <= 0 || Item[nItemIndex].GetHeight() <= 0)
	{
		ItemSet.Remove(nItemIndex);
		return 0;
	}
	return nItemIndex;
}

int LuaAddNormalItem2Vng(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (!PhongThanDieuTriIsLivePlayer(nPlayerIndex) || Lua_GetTopIndex(L) < 6)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}
	int nItemIndex = PhongThanDieuTriCreateExactItem(
		(int)Lua_ValueToNumber(L, 1), (int)Lua_ValueToNumber(L, 2),
		(int)Lua_ValueToNumber(L, 3), (int)Lua_ValueToNumber(L, 4),
		(int)Lua_ValueToNumber(L, 5), (int)Lua_ValueToNumber(L, 6));
	if (nItemIndex <= 0)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}
	POINT Size;
	Size.x = Item[nItemIndex].GetWidth();
	Size.y = Item[nItemIndex].GetHeight();
	int nOwned = Player[nPlayerIndex].m_ItemList.Add(nItemIndex, Size,
		Item[nItemIndex].GetGenre() != item_equip);
	if (nOwned <= 0)
		ItemSet.Remove(nItemIndex);
	Lua_PushNumber(L, nOwned > 0 ? nOwned : 0);
	return 1;
}

static BOOL PhongThanDieuTriMatchItem(int nItemIndex, int nGenre,
	int nDetail, int nParticular, int nLevel)
{
	return nItemIndex > 0 && nItemIndex < MAX_ITEM &&
		Item[nItemIndex].GetID() != 0 && Item[nItemIndex].GetGenre() == nGenre &&
		Item[nItemIndex].GetDetailType() == nDetail &&
		Item[nItemIndex].GetParticular() == nParticular &&
		(nLevel < 0 || Item[nItemIndex].GetLevel() == nLevel);
}

int LuaGetItemLevel2Vng(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nBestLevel = 0;
	if (PhongThanDieuTriIsLivePlayer(nPlayerIndex) && Lua_GetTopIndex(L) >= 3)
	{
		int nGenre = (int)Lua_ValueToNumber(L, 1);
		int nDetail = (int)Lua_ValueToNumber(L, 2);
		int nParticular = (int)Lua_ValueToNumber(L, 3);
		PlayerItem *pOwned = Player[nPlayerIndex].m_ItemList.GetFirstItem();
		while (pOwned)
		{
			if (pOwned->nPlace == pos_equiproom &&
				PhongThanDieuTriMatchItem(pOwned->nIdx, nGenre, nDetail,
					nParticular, -1) && Item[pOwned->nIdx].GetLevel() > nBestLevel)
				nBestLevel = Item[pOwned->nIdx].GetLevel();
			pOwned = Player[nPlayerIndex].m_ItemList.GetNextItem();
		}
	}
	Lua_PushNumber(L, nBestLevel);
	return 1;
}

int LuaDelItem2Vng(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nRemoved = 0;
	if (PhongThanDieuTriIsLivePlayer(nPlayerIndex) && Lua_GetTopIndex(L) >= 4)
	{
		int nGenre = (int)Lua_ValueToNumber(L, 1);
		int nDetail = (int)Lua_ValueToNumber(L, 2);
		int nParticular = (int)Lua_ValueToNumber(L, 3);
		int nLevel = (int)Lua_ValueToNumber(L, 4);
		int nItemIndex = 0;
		PlayerItem *pOwned = Player[nPlayerIndex].m_ItemList.GetFirstItem();
		while (pOwned)
		{
			if (pOwned->nPlace == pos_equiproom &&
				PhongThanDieuTriMatchItem(pOwned->nIdx, nGenre, nDetail,
					nParticular, nLevel))
			{
				nItemIndex = pOwned->nIdx;
				break;
			}
			pOwned = Player[nPlayerIndex].m_ItemList.GetNextItem();
		}
		if (nItemIndex > 0 && Player[nPlayerIndex].m_ItemList.Remove(nItemIndex))
		{
			ItemSet.Remove(nItemIndex);
			nRemoved = 1;
		}
	}
	Lua_PushNumber(L, nRemoved);
	return 1;
}

int LuaSaleExVng(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nShopId = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : 0;
	if (PhongThanDieuTriIsLivePlayer(nPlayerIndex) && nShopId > 0)
		BuySell.OpenSale(nPlayerIndex, nShopId - 1, moneyunit_money);
	return 0;
}

int LuaGetPetTypeVng(Lua_State *L)
{
	return LuaPetGetTypeCompat(L);
}

int LuaDelPetVng(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nResult = 0;
	if (PhongThanDieuTriIsLivePlayer(nPlayerIndex))
	{
		int nPlayerNpc = Player[nPlayerIndex].m_nIndex;
		int nPetNpc = Npc[nPlayerNpc].m_nPetIdx;
		Npc[nPlayerNpc].m_nPetIdx = 0;
		Player[nPlayerIndex].m_cTask.SetSaveVal(TASKVALUE_PT_PET_TYPE, 0, TRUE);
		if (nPetNpc > 0 && nPetNpc < MAX_NPC)
		{
			PhongThanRemoveNpc(nPetNpc);
			nResult = 1;
		}
	}
	Lua_PushNumber(L, nResult);
	return 1;
}

int LuaCanMarryVng(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nMate = PhongThanDieuTriGetTeamMate(nPlayerIndex);
	int nResult = 0;
	if (nMate > 0)
	{
		const char *pszSelfMate = Player[nPlayerIndex].m_cTask.GetSaveStr(
			TASKVALUE_BASEDATA_MATENAME);
		const char *pszOtherMate = Player[nMate].m_cTask.GetSaveStr(
			TASKVALUE_BASEDATA_MATENAME);
		nResult = Npc[Player[nPlayerIndex].m_nIndex].m_nSex !=
			Npc[Player[nMate].m_nIndex].m_nSex &&
			(!pszSelfMate || !pszSelfMate[0]) &&
			(!pszOtherMate || !pszOtherMate[0]);
	}
	Lua_PushNumber(L, nResult ? 1 : 0);
	return 1;
}

int LuaGetMateTaskVng(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nTaskId = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : -1;
	int nMate = PhongThanDieuTriGetMateOrSpouse(nPlayerIndex);
	Lua_PushNumber(L, nMate > 0 && nTaskId >= 0 && nTaskId < MAX_TASK ?
		Player[nMate].m_cTask.GetSaveVal(nTaskId) : 0);
	return 1;
}

int LuaGetNameIDVng(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	Lua_PushNumber(L, PhongThanDieuTriIsLivePlayer(nPlayerIndex) ?
		g_FileName2Id(Player[nPlayerIndex].Name) : 0);
	return 1;
}

int LuaGetMateNameIDVng(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nMate = PhongThanDieuTriGetMateOrSpouse(nPlayerIndex);
	Lua_PushNumber(L, nMate > 0 ? g_FileName2Id(Player[nMate].Name) : 0);
	return 1;
}

int LuaDoMarryVng(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nMate = PhongThanDieuTriGetTeamMate(nPlayerIndex);
	int nResult = 0;
	const int nMarriageFee = 1314520;
	if (nMate > 0 &&
		Npc[Player[nPlayerIndex].m_nIndex].m_nSex !=
		Npc[Player[nMate].m_nIndex].m_nSex &&
		!Player[nPlayerIndex].m_cTask.GetSaveStr(TASKVALUE_BASEDATA_MATENAME)[0] &&
		!Player[nMate].m_cTask.GetSaveStr(TASKVALUE_BASEDATA_MATENAME)[0] &&
		Player[nPlayerIndex].Pay(nMarriageFee))
	{
		Player[nPlayerIndex].m_cTask.SetSaveVal(TASKVALUE_BASEDATA_MATENAME,
			Player[nMate].Name, TRUE);
		Player[nMate].m_cTask.SetSaveVal(TASKVALUE_BASEDATA_MATENAME,
			Player[nPlayerIndex].Name, TRUE);
		Player[nPlayerIndex].m_cTask.SetSaveVal(800, 0, TRUE);
		Player[nPlayerIndex].m_cTask.SetSaveVal(801, 0, TRUE);
		Player[nMate].m_cTask.SetSaveVal(800, 0, TRUE);
		Player[nMate].m_cTask.SetSaveVal(801, 0, TRUE);
		KPlayerChat::MakeMate(Player[nPlayerIndex].Name, Player[nMate].Name);
		nResult = 1;
	}
	Lua_PushNumber(L, nResult);
	return 1;
}

int LuaEnhanceVng(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (!PhongThanDieuTriIsLivePlayer(nPlayerIndex) || Lua_GetTopIndex(L) < 4)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}
	int nAttrib = (int)Lua_ValueToNumber(L, 1);
	int nSeconds = (int)Lua_ValueToNumber(L, 2);
	int nMin = (int)Lua_ValueToNumber(L, 3);
	int nMax = (int)Lua_ValueToNumber(L, 4);
	if (nAttrib <= 0 || nAttrib >= magic_normal_end || nSeconds <= 0)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}
	if (nMax < nMin)
	{
		int nSwap = nMin;
		nMin = nMax;
		nMax = nSwap;
	}
	KMagicAttrib Attribute;
	ZeroMemory(&Attribute, sizeof(Attribute));
	Attribute.nAttribType = nAttrib;
	Attribute.nValue[0] = nMin == nMax ? nMin : nMin + (nMax - nMin) / 2;
	Attribute.nValue[1] = nSeconds;
	Attribute.nValue[2] = nMax;
	int nStateId = 3600 + nAttrib;
	Npc[Player[nPlayerIndex].m_nIndex].SetStateSkillEffect(
		Player[nPlayerIndex].m_nIndex, nStateId, 1, &Attribute, 1,
		nSeconds * GAME_FPS, FALSE);
	Lua_PushNumber(L, 1);
	return 1;
}

static int PhongThanDieuTriClampAdd(int nValue, int nDelta)
{
	if (nDelta > 0 && nValue > MAX_INT - nDelta)
		return MAX_INT;
	if (nDelta < 0 && nValue < -nDelta)
		return 0;
	return nValue + nDelta;
}

static int PhongThanDieuTriChangeWallet(int nPlayerIndex, int nTaskId,
	int nDelta)
{
	if (!PhongThanDieuTriIsLivePlayer(nPlayerIndex))
		return 0;
	int nCurrent = Player[nPlayerIndex].m_cTask.GetSaveVal(nTaskId);
	int nValue = PhongThanDieuTriClampAdd(nCurrent, nDelta);
	Player[nPlayerIndex].m_cTask.SetSaveVal(nTaskId, nValue, TRUE);
	return nValue;
}

// engine2:BEGIN D2 2026-10-04 credit = Danh vong. The VNG GetCredit/AddCredit/DecCredit value is the "danh vong" the
// status page (F3, StatusPage_Credit) shows from task 210 (TASKVALUE_STATTASK_REPUTE, AddRepute/GetRepute); it was
// a hidden wallet (TASKVALUE_PT_CREDIT = 4840) that only Xich Tung Tu read. Both now use task 210. The old wallet
// moves once: repute += wallet, wallet = 0 (at login, KPlayerDBFuns.cpp, and before every credit call).
#define PT_CREDIT_TASK	TASKVALUE_STATTASK_REPUTE

void PhongThanMigrateCreditToRepute(int nPlayerIndex)
{
	if (nPlayerIndex <= 0 || nPlayerIndex >= MAX_PLAYER)
		return;
	int nOld = Player[nPlayerIndex].m_cTask.GetSaveVal(TASKVALUE_PT_CREDIT);
	if (nOld == 0)
		return;
	if (nOld > 0)
	{
		int nRepute = Player[nPlayerIndex].m_cTask.GetSaveVal(PT_CREDIT_TASK);
		Player[nPlayerIndex].m_cTask.SetSaveVal(PT_CREDIT_TASK, PhongThanDieuTriClampAdd(nRepute, nOld), TRUE);
		g_DebugLog("[engine2] credit %d added to repute %d (player %d)", nOld, nRepute, nPlayerIndex);
	}
	Player[nPlayerIndex].m_cTask.SetSaveVal(TASKVALUE_PT_CREDIT, 0, TRUE);
}

int LuaGetCreditVng(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nValue = 0;
	if (PhongThanDieuTriIsLivePlayer(nPlayerIndex))
	{
		PhongThanMigrateCreditToRepute(nPlayerIndex);
		nValue = Player[nPlayerIndex].m_cTask.GetSaveVal(PT_CREDIT_TASK);
	}
	Lua_PushNumber(L, nValue);
	return 1;
}

int LuaAddCreditVng(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nAmount = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : 0;
	if (PhongThanDieuTriIsLivePlayer(nPlayerIndex))
		PhongThanMigrateCreditToRepute(nPlayerIndex);
	Lua_PushNumber(L, nAmount > 0 ? PhongThanDieuTriChangeWallet(
		nPlayerIndex, PT_CREDIT_TASK, nAmount) : 0);
	return 1;
}

int LuaDecCreditVng(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nAmount = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : 0;
	int nResult = 0;
	if (PhongThanDieuTriIsLivePlayer(nPlayerIndex))
		PhongThanMigrateCreditToRepute(nPlayerIndex);
	if (PhongThanDieuTriIsLivePlayer(nPlayerIndex) && nAmount > 0 &&
		Player[nPlayerIndex].m_cTask.GetSaveVal(PT_CREDIT_TASK) >= nAmount)
	{
		PhongThanDieuTriChangeWallet(nPlayerIndex, PT_CREDIT_TASK, -nAmount);
		nResult = 1;
	}
	Lua_PushNumber(L, nResult);
	return 1;
}
// engine2:END

int LuaGetTreasureCountVng(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	Lua_PushNumber(L, PhongThanDieuTriIsLivePlayer(nPlayerIndex) ?
		Player[nPlayerIndex].m_cTask.GetSaveVal(TASKVALUE_PT_TREASURE) : 0);
	return 1;
}

int LuaAddTreasureVng(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nAmount = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : 0;
	Lua_PushNumber(L, nAmount > 0 ? PhongThanDieuTriChangeWallet(
		nPlayerIndex, TASKVALUE_PT_TREASURE, nAmount) : 0);
	return 1;
}

int LuaWasteTreasureVng(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nAmount = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : 0;
	int nResult = 0;
	if (PhongThanDieuTriIsLivePlayer(nPlayerIndex) && nAmount > 0 &&
		Player[nPlayerIndex].m_cTask.GetSaveVal(TASKVALUE_PT_TREASURE) >= nAmount)
	{
		PhongThanDieuTriChangeWallet(nPlayerIndex, TASKVALUE_PT_TREASURE, -nAmount);
		nResult = 1;
	}
	Lua_PushNumber(L, nResult);
	return 1;
}

int LuaIsHaveSpaceForCopperCashVng(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nAmount = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : 0;
	int nCurrent = PhongThanDieuTriIsLivePlayer(nPlayerIndex) ?
		Player[nPlayerIndex].m_cTask.GetSaveVal(TASKVALUE_PT_COPPER_CASH) : MAX_INT;
	Lua_PushNumber(L, nAmount >= 0 && nCurrent <= MAX_INT - nAmount ? 1 : 0);
	return 1;
}

int LuaAddCopperCashVng(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nAmount = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : 0;
	Lua_PushNumber(L, nAmount > 0 ? PhongThanDieuTriChangeWallet(
		nPlayerIndex, TASKVALUE_PT_COPPER_CASH, nAmount) : 0);
	return 1;
}

int LuaUseSilverVng(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nResult = 0;
	if (PhongThanDieuTriIsLivePlayer(nPlayerIndex) && Lua_GetTopIndex(L) >= 3)
	{
		int nGroup = (int)Lua_ValueToNumber(L, 1);
		int nKind = (int)Lua_ValueToNumber(L, 2);
		int nCount = (int)Lua_ValueToNumber(L, 3);
		if (nGroup >= 0 && nKind >= 0 && nCount > 0)
		{
			PhongThanDieuTriChangeWallet(nPlayerIndex,
				TASKVALUE_PT_SILVER_SPENT, nCount);
			Player[nPlayerIndex].m_cTask.SetSaveVal(
				TASKVALUE_PT_SILVER_LAST_GROUP, nGroup, TRUE);
			Player[nPlayerIndex].m_cTask.SetSaveVal(
				TASKVALUE_PT_SILVER_LAST_KIND, nKind, TRUE);
			Player[nPlayerIndex].m_cTask.SetSaveVal(
				TASKVALUE_PT_SILVER_LAST_COUNT, nCount, TRUE);
			nResult = 1;
		}
	}
	Lua_PushNumber(L, nResult);
	return 1;
}

int LuaStopUsePillsVng(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (PhongThanDieuTriIsLivePlayer(nPlayerIndex))
	{
		Player[nPlayerIndex].m_cAI.m_bEatLife = FALSE;
		Player[nPlayerIndex].m_cAI.m_bEatMana = FALSE;
		Player[nPlayerIndex].m_cAI.m_bOpenMedicine = FALSE;
	}
	return 0;
}

int LuaReplaceBoxPwdVng(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nResult = 0;
	if (PhongThanDieuTriIsLivePlayer(nPlayerIndex))
	{
		char szEmpty[1] = {0};
		Player[nPlayerIndex].m_bLock = FALSE;
		Player[nPlayerIndex].m_bLockState = FALSE;
		Player[nPlayerIndex].SetSavePw(szEmpty, TRUE);
		nResult = 1;
	}
	Lua_PushNumber(L, nResult);
	return 1;
}

int LuaAddConVng(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nValue = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : 0;
	if (PhongThanDieuTriIsLivePlayer(nPlayerIndex) && nValue)
		Player[nPlayerIndex].SetBaseVitality(nValue);
	Lua_PushNumber(L, PhongThanDieuTriIsLivePlayer(nPlayerIndex) ?
		Player[nPlayerIndex].m_nVitality : 0);
	return 1;
}

int LuaAddIntVng(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nValue = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : 0;
	if (PhongThanDieuTriIsLivePlayer(nPlayerIndex) && nValue)
		Player[nPlayerIndex].SetBaseEngergy(nValue);
	Lua_PushNumber(L, PhongThanDieuTriIsLivePlayer(nPlayerIndex) ?
		Player[nPlayerIndex].m_nEngergy : 0);
	return 1;
}
