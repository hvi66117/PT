// Phong Than 2026-10-05 (natives): Lua natives that VNG scripts call but this engine never registered.
// Included once from ScriptFuns.cpp inside #ifdef _SERVER, after the VNG compat helpers
// (GetVngNormalTuple, CountVngOwnedItems, CreateVngNormalItem) and LuaMsgToSubWorld. ASCII only.
//   #2  missile hit scripts: IsPlayer, GetNpc{Fire,Cold,Poison,Light,Earth,Physics}Resist
//   #3  VNG item API: FindAValidItemID, GetItemGen, GetItemDetail, IsItemBind, SetItemBind, DelItemByID,
//       HaveNormalItemInQuick, AddItemPileNum, EarnBind, GetIBItemGenTime, Time2LocalYMD,
//       GetServerStartTime, GetCompeteFlag, CanPolyMorph, GetNpcLifeMax, Get/SetGlobalStoreValue[Byte|Word],
//       AddEmoteBalloon (SendGlobalMessage is registered as an alias of Msg2SubWorld)
//   #13 SetItemUpgrade, GetItemUpgrade, GetItemListEntry (web admin "Cuong hoa")
// Rules that do not touch engine globals live in PhongThanLuaItemNativesCore.h (offline smoke test).
#include "PhongThanLuaItemNativesCore.h"
#include "../../../Headers/PhongThanUpgradeState.h"

static int PTN_ArgInt(Lua_State* L, int n, int def)
{
	if (Lua_GetTopIndex(L) < n || !Lua_IsNumber(L, n)) return def;
	return (int)Lua_ValueToNumber(L, n);
}
static int PTN_ValidNpc(int n)
{
	return n > 0 && n < MAX_NPC && Npc[n].m_Index > 0;
}
static int PTN_ValidItem(int i)
{
	return i > 0 && i < MAX_ITEM && Item[i].GetID() != 0;
}
static int PTN_OwnedItem(int player, int idx)
{
	return player > 0 && player < MAX_PLAYER && PTN_ValidItem(idx) &&
		Player[player].m_ItemList.FindSame(idx) > 0;
}

// ------------------------------------------------------------------ #2 missile hit scripts
// IsPlayer(npcIndex): 1 when the NPC is a player character (script\skill\missle\*.lua OnHitTarget).
int LuaPTN_IsPlayer(Lua_State* L)
{
	const int n = PTN_ArgInt(L, 1, 0);
	Lua_PushNumber(L, (PTN_ValidNpc(n) && Npc[n].IsPlayer() && Npc[n].GetPlayerIdx() > 0) ? 1 : 0);
	return 1;
}
// GetNpcXxxResist(npcIndex): current resist in percent, clamped like the damage code. 0 for a bad index.
static int PTN_PushNpcResist(Lua_State* L, int kind)
{
	const int n = PTN_ArgInt(L, 1, 0);
	int v = 0;
	if (PTN_ValidNpc(n))
	{
		KNpc& c = Npc[n];
		switch (kind)
		{
		case 0: v = PTN_ClampResist(c.m_CurrentFireResist, c.m_CurrentFireResistMax); break;
		case 1: v = PTN_ClampResist(c.m_CurrentColdResist, c.m_CurrentColdResistMax); break;
		case 2: v = PTN_ClampResist(c.m_CurrentPoisonResist, c.m_CurrentPoisonResistMax); break;
		case 3: v = PTN_ClampResist(c.m_CurrentLightResist, c.m_CurrentLightResistMax); break;
		case 4: v = PTN_ClampResist(c.m_CurrentEarthResist, c.m_CurrentEarthResistMax); break;
		default: v = PTN_ClampResist(c.m_CurrentPhysicsResist, c.m_CurrentPhysicsResistMax); break;
		}
	}
	Lua_PushNumber(L, v);
	return 1;
}
int LuaPTN_GetNpcFireResist(Lua_State* L) { return PTN_PushNpcResist(L, 0); }
int LuaPTN_GetNpcColdResist(Lua_State* L) { return PTN_PushNpcResist(L, 1); }
int LuaPTN_GetNpcPoisonResist(Lua_State* L) { return PTN_PushNpcResist(L, 2); }
int LuaPTN_GetNpcLightResist(Lua_State* L) { return PTN_PushNpcResist(L, 3); }
int LuaPTN_GetNpcEarthResist(Lua_State* L) { return PTN_PushNpcResist(L, 4); }
int LuaPTN_GetNpcPhysicsResist(Lua_State* L) { return PTN_PushNpcResist(L, 5); }

// GetNpcLifeMax(npcIndex): m_CurrentLifeMax. Same field this engine's GetNpcLife returns and SetNpcLife
// writes, so VNG "SetNpcLife(n, GetNpcLifeMax(n))" heals to full.
int LuaPTN_GetNpcLifeMax(Lua_State* L)
{
	const int n = PTN_ArgInt(L, 1, 0);
	Lua_PushNumber(L, PTN_ValidNpc(n) ? Npc[n].m_CurrentLifeMax : 0);
	return 1;
}

// ------------------------------------------------------------------ #3 VNG item API
// FindAValidItemID(itemIdx): itemIdx when the item exists and belongs to the calling player, else 0.
int LuaPTN_FindAValidItemID(Lua_State* L)
{
	const int idx = PTN_ArgInt(L, 1, 0);
	const int player = GetPlayerIndex(L);
	Lua_PushNumber(L, PTN_OwnedItem(player, idx) ? idx : 0);
	return 1;
}
// GetItemGen(itemIdx) / GetItemDetail(itemIdx): the VNG genre / detail (magic-script item = 6 / 1). -1 bad index.
int LuaPTN_GetItemGen(Lua_State* L)
{
	const int idx = PTN_ArgInt(L, 1, 0);
	Lua_PushNumber(L, PTN_ValidItem(idx) ? Item[idx].GetGenre() : -1);
	return 1;
}
int LuaPTN_GetItemDetail(Lua_State* L)
{
	const int idx = PTN_ArgInt(L, 1, 0);
	Lua_PushNumber(L, PTN_ValidItem(idx) ?
		PTN_VngDetail(Item[idx].GetGenre(), Item[idx].GetDetailType(), Item[idx].GetParticular()) : -1);
	return 1;
}
// IsItemBind(itemIdx): 1 when bound (LOCK_STATE_FOREVER or LOCK_STATE_CHARACTER).
int LuaPTN_IsItemBind(Lua_State* L)
{
	const int idx = PTN_ArgInt(L, 1, 0);
	int bound = 0;
	if (PTN_ValidItem(idx))
	{
		const int st = Item[idx].GetLock()->nState;
		bound = (st == LOCK_STATE_FOREVER || st == LOCK_STATE_CHARACTER) ? 1 : 0;
	}
	Lua_PushNumber(L, bound);
	return 1;
}
// SetItemBind(itemIdx, bind): bind > 0 binds the item for ever. bind 0 leaves it as it is. 1 = done.
int LuaPTN_SetItemBind(Lua_State* L)
{
	const int idx = PTN_ArgInt(L, 1, 0);
	const int bind = PTN_ArgInt(L, 2, 1);
	const int player = GetPlayerIndex(L);
	int result = 0;
	if (PTN_OwnedItem(player, idx))
	{
		if (bind > 0)
		{
			Item[idx].LockItem(LOCK_STATE_FOREVER);
			Player[player].m_ItemList.SyncItem(idx);
		}
		result = 1;
	}
	Lua_PushNumber(L, result);
	return 1;
}
// DelItemByID(itemIdx[, count]): removes count (default and 0 = 1) from that item of the calling player.
int LuaPTN_DelItemByID(Lua_State* L)
{
	const int idx = PTN_ArgInt(L, 1, 0);
	int count = PTN_ArgInt(L, 2, 1);
	const int player = GetPlayerIndex(L);
	int result = 0;
	if (PTN_OwnedItem(player, idx))
	{
		const int stack = Item[idx].GetStackNum();
		if (count <= 0) count = 1;
		if (count > stack) count = stack;
		if (Player[player].m_ItemList.RemoveItem(idx, count)) result = 1;
	}
	Lua_PushNumber(L, result);
	return 1;
}
// HaveNormalItemInQuick(genre, detail, particular, level[, series]): count in the quick bar (pos_immediacy).
int LuaPTN_HaveNormalItemInQuick(Lua_State* L)
{
	const int nArgs = Lua_GetTopIndex(L);
	const int player = GetPlayerIndex(L);
	Lua_SetTopIndex(L, nArgs);
	int g = -1, d = -1, lv = -1, se = -1, pa = -1, count = 0;
	if (player > 0 && GetVngNormalTuple(L, 1, &g, &d, &lv, &se, &pa))
		count = CountVngOwnedItems(player, g, d, lv, se, pos_immediacy, pa);
	Lua_PushNumber(L, count);
	return 1;
}
// AddItemPileNum(genre, detail, particular, level, count): gives count pieces, stacked where the item
// stacks. Materials have level 0 in this runtime; a VNG level that the table rejects is retried as 0.
// Returns the number of pieces given.
int LuaPTN_AddItemPileNum(Lua_State* L)
{
	const int nArgs = Lua_GetTopIndex(L);
	const int player = GetPlayerIndex(L);
	Lua_SetTopIndex(L, nArgs);
	int added = 0;
	if (player > 0 && nArgs >= 5)
	{
		const int g = PTN_ArgInt(L, 1, -1), d = PTN_ArgInt(L, 2, -1), pa = PTN_ArgInt(L, 3, -1);
		const int lv = PTN_ArgInt(L, 4, 0);
		int n = PTN_ArgInt(L, 5, 1);
		if (n < 1) n = 1;
		if (n > 10000) n = 10000;
		for (int guard = 0; added < n && guard < 200; ++guard)
		{
			int idx = CreateVngNormalItem(g, d, pa, lv, 0, 0);
			if (idx <= 0 && g == item_materials && lv != 0)
				idx = CreateVngNormalItem(g, d, pa, 0, 0, 0);
			if (idx <= 0) break;
			int put = 1;
			if (Item[idx].IsStack())
			{
				const int mx = Item[idx].GetMaxStackNum();
				put = (n - added) < mx ? (n - added) : mx;
				Item[idx].SetStackNum(put);
			}
			POINT size;
			size.x = Item[idx].GetWidth();
			size.y = Item[idx].GetHeight();
			if (Player[player].m_ItemList.Add(idx, size, true) <= 0)
			{
				ItemSet.Remove(idx);
				break;
			}
			added += put;
		}
	}
	Lua_PushNumber(L, added);
	return 1;
}
// EarnBind(money): VNG bound money. This engine has one money purse, so it is ordinary money (Earn).
int LuaPTN_EarnBind(Lua_State* L)
{
	const int money = PTN_ArgInt(L, 1, 0);
	const int player = GetPlayerIndex(L);
	int result = 0;
	if (player > 0 && money > 0)
	{
		Player[player].Earn(money);
		result = 1;
	}
	Lua_PushNumber(L, result);
	return 1;
}
// GetIBItemGenTime(itemIdx): the item has no stored creation time in this engine; the use time (now) is
// returned, so VNG "valid 30 days from creation" items count from the moment they are used.
int LuaPTN_GetIBItemGenTime(Lua_State* L)
{
	const int idx = PTN_ArgInt(L, 1, 0);
	Lua_PushNumber(L, PTN_ValidItem(idx) ? (double)time(NULL) : 0.0);
	return 1;
}
// Time2LocalYMD(t): year, month, day (then hour, minute, second) of a SystemTime() value, local time.
int LuaPTN_Time2LocalYMD(Lua_State* L)
{
	double t = (double)time(NULL);
	if (Lua_GetTopIndex(L) >= 1 && Lua_IsNumber(L, 1)) t = Lua_ValueToNumber(L, 1);
	int parts[6] = { 0, 0, 0, 0, 0, 0 };
	PTN_LocalParts(t, parts);
	for (int i = 0; i < 6; ++i) Lua_PushNumber(L, parts[i]);
	return 6;
}
// GetServerStartTime(): whole days since the server opened. Date from GameSetting
// [ServerConfig] ServerOpenDate=yyyymmdd; default 20260901.
int LuaPTN_GetServerStartTime(Lua_State* L)
{
	char sz[32];
	sz[0] = 0;
	g_GameSetting.GetString("ServerConfig", "ServerOpenDate", "20260901", sz, sizeof(sz));
	int days = PTN_DaysSince(atoi(sz), time(NULL));
	if (days < 0) days = PTN_DaysSince(20260901, time(NULL));
	Lua_PushNumber(L, days < 0 ? 0 : days);
	return 1;
}
// GetCompeteFlag(): 1 in a VNG competition (arena) state. No such state exists here: 0.
int LuaPTN_GetCompeteFlag(Lua_State* L)
{
	Lua_PushNumber(L, 0);
	return 1;
}
// CanPolyMorph(): VNG scripts treat 1 as "transformation blocked" (if f == 1 or CanPolyMorph() == 1 then
// refuse). Nothing blocks it here: 0.
int LuaPTN_CanPolyMorph(Lua_State* L)
{
	Lua_PushNumber(L, 0);
	return 1;
}
// Server-wide store (PhongThanLuaItemNativesCore.h): GetGlobalStoreValue(id), SetGlobalStoreValue(id, v[, save]),
// Get/SetGlobalStoreValueByte(id, 1..4[, b, save]), Get/SetGlobalStoreValueWord(id, 1..2[, w, save]).
// Every Set is written to pt_globalstore.txt; the save flag is accepted and ignored.
int LuaPTN_GetGlobalStoreValue(Lua_State* L)
{
	Lua_PushNumber(L, PTN_StoreGet(PTN_ArgInt(L, 1, -1)));
	return 1;
}
int LuaPTN_SetGlobalStoreValue(Lua_State* L)
{
	Lua_PushNumber(L, PTN_StoreSet(PTN_ArgInt(L, 1, -1), PTN_ArgInt(L, 2, 0)));
	return 1;
}
int LuaPTN_GetGlobalStoreValueByte(Lua_State* L)
{
	Lua_PushNumber(L, PTN_GetByte(PTN_StoreGet(PTN_ArgInt(L, 1, -1)), PTN_ArgInt(L, 2, 0)));
	return 1;
}
int LuaPTN_SetGlobalStoreValueByte(Lua_State* L)
{
	const int id = PTN_ArgInt(L, 1, -1), n = PTN_ArgInt(L, 2, 0);
	int r = 0;
	if (n >= 1 && n <= 4) r = PTN_StoreSet(id, PTN_SetByte(PTN_StoreGet(id), n, PTN_ArgInt(L, 3, 0)));
	Lua_PushNumber(L, r);
	return 1;
}
int LuaPTN_GetGlobalStoreValueWord(Lua_State* L)
{
	Lua_PushNumber(L, PTN_GetWord(PTN_StoreGet(PTN_ArgInt(L, 1, -1)), PTN_ArgInt(L, 2, 0)));
	return 1;
}
int LuaPTN_SetGlobalStoreValueWord(Lua_State* L)
{
	const int id = PTN_ArgInt(L, 1, -1), n = PTN_ArgInt(L, 2, 0);
	int r = 0;
	if (n >= 1 && n <= 2) r = PTN_StoreSet(id, PTN_SetWord(PTN_StoreGet(id), n, PTN_ArgInt(L, 3, 0)));
	Lua_PushNumber(L, r);
	return 1;
}
// AddEmoteBalloon(playerIndex, emote): VNG emote bubble over a character. No client support: no-op, 1.
int LuaPTN_AddEmoteBalloon(Lua_State* L)
{
	Lua_PushNumber(L, 1);
	return 1;
}

// ------------------------------------------------------------------ #13 equipment upgrade (+0..+12)
static int PTN_UpgradeRuleOf(KItem& item)
{
	static KTabFile recipes;
	static int loaded = -1;
	if (item.m_CommonAttrib.nUpgradeRule > 0) return item.m_CommonAttrib.nUpgradeRule;
	if (loaded < 0) loaded = recipes.Load(PTN_RECIPE_FILE) ? 1 : 0;
	return loaded ? PTN_FindUpgradeRule(recipes, item.GetDetailType(), item.GetParticular()) : 0;
}
// SetItemUpgrade(itemIdx, level[, rule]): sets the upgrade level (0..12) of an equipment item of the
// calling player, worn or carried. The rule (attribute table) is the item's own, else the given one,
// else the one of its Xich Tung Tu recipe. The item is taken out and put back in the same place, so
// stats are recalculated by the normal equip path and the client receives a fresh item snapshot
// (UpgradeLevel field) and shows the stars.
// Returns 1 done, 0 no such item of this player, -1 not equipment, -2 player locked/trading,
// -3 no upgrade rule for this item, -4 level outside 0..12 or rejected by the upgrade tables,
// -5 the item could not be put back (it is restored unchanged).
int LuaPTN_SetItemUpgrade(Lua_State* L)
{
	const int idx = PTN_ArgInt(L, 1, 0);
	const int level = PTN_ArgInt(L, 2, -1);
	int rule = PTN_ArgInt(L, 3, 0);
	const int player = GetPlayerIndex(L);
	int result = 0, oldLevel = 0;
	if (!PTN_OwnedItem(player, idx)) result = 0;
	else if (Item[idx].GetGenre() != item_equip) result = -1;
	else if (Player[player].GetLockState() || Player[player].CheckTrading()) result = -2;
	else if (!PTN_UpgradeLevelOk(level)) result = -4;
	else
	{
		KItem& item = Item[idx];
		oldLevel = item.m_CommonAttrib.nUpgradeLvl;
		if (rule <= 0) rule = PTN_UpgradeRuleOf(item);
		if (level > 0 && rule <= 0) result = -3;
		else
		{
			KItem updated = item;
			const int state = level > 0 ? PhongThanEncodeUpgradeState(level, rule) : 0;
			const int listIndex = Player[player].m_ItemList.FindSame(idx);
			if (state < 0 || !updated.ApplyUpgradeState(state)) result = -4;
			else if (listIndex <= 0 || Player[player].m_ItemList.m_Items[listIndex].nPlace == pos_hand) result = -5;
			else
			{
				const int place = Player[player].m_ItemList.m_Items[listIndex].nPlace;
				const int x = Player[player].m_ItemList.m_Items[listIndex].nX;
				const int y = Player[player].m_ItemList.m_Items[listIndex].nY;
				KItem original = item;
				if (!Player[player].m_ItemList.Remove(idx)) result = -5;
				else
				{
					Item[idx] = updated;
					if (Player[player].m_ItemList.Add(idx, place, x, y, false) > 0) result = 1;
					else
					{
						Item[idx] = original;
						if (Player[player].m_ItemList.Add(idx, place, x, y, false) <= 0)
						{
							POINT size;
							size.x = original.GetWidth();
							size.y = original.GetHeight();
							Player[player].m_ItemList.Add(idx, size, false);
						}
						result = -5;
					}
				}
			}
		}
	}
	FILE* audit = fopen("set_item_upgrade.log", "a");
	if (audit)
	{
		fprintf(audit, "player=%d item=%d id=%lu from=%d to=%d rule=%d result=%d\n", player, idx,
			(unsigned long)(PTN_ValidItem(idx) ? Item[idx].GetID() : 0), oldLevel, level, rule, result);
		fclose(audit);
	}
	Lua_PushNumber(L, result);
	return 1;
}
// GetItemUpgrade(itemIdx): upgrade level, rule of an equipment item (0, 0 otherwise).
int LuaPTN_GetItemUpgrade(Lua_State* L)
{
	const int idx = PTN_ArgInt(L, 1, 0);
	int level = 0, rule = 0;
	if (PTN_ValidItem(idx) && Item[idx].GetGenre() == item_equip)
	{
		level = Item[idx].m_CommonAttrib.nUpgradeLvl;
		rule = Item[idx].m_CommonAttrib.nUpgradeRule;
	}
	Lua_PushNumber(L, level);
	Lua_PushNumber(L, rule);
	return 2;
}
// GetItemListEntry(n): n-th item (1-based) of the calling player: itemIdx, place, x, y, itemId; 0 past the end.
int LuaPTN_GetItemListEntry(Lua_State* L)
{
	const int n = PTN_ArgInt(L, 1, 0);
	const int player = GetPlayerIndex(L);
	if (player > 0 && n > 0)
	{
		PlayerItem* p = Player[player].m_ItemList.GetFirstItem();
		for (int k = 1; p && k < n; ++k) p = Player[player].m_ItemList.GetNextItem();
		if (p && PTN_ValidItem(p->nIdx))
		{
			Lua_PushNumber(L, p->nIdx);
			Lua_PushNumber(L, p->nPlace);
			Lua_PushNumber(L, p->nX);
			Lua_PushNumber(L, p->nY);
			Lua_PushNumber(L, (double)Item[p->nIdx].GetID());
			return 5;
		}
	}
	Lua_PushNumber(L, 0);
	return 1;
}
