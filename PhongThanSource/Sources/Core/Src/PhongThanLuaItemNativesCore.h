#ifndef PHONGTHAN_LUA_ITEM_NATIVES_CORE_H
#define PHONGTHAN_LUA_ITEM_NATIVES_CORE_H
// Phong Than 2026-10-05 (natives): engine-independent rules behind PhongThanLuaItemNatives.h.
// Kept free of Item[]/Player[]/Npc[] so the offline smoke test can compile it against a mock KTabFile.
// ASCII only.
#include <stdio.h>
#include <string.h>
#include <time.h>
#include "PhongThanComposeRecipe.h"

#define PTN_GENRE_EQUIP			0
#define PTN_GENRE_MAGICSCRIPT	6
#define PTN_UPGRADE_MAX			12
#define PTN_STORE_MAX			4096
#define PTN_RECIPE_FILE			"\\settings\\item\\001\\zhuang_bei_he_cheng_gui_ze_biao.txt"

// ------------------------------------------------------------------ item identity
// VNG scripts see a magic-script item as (6, 1, P). This runtime stores it as genre 6, DetailType P,
// ParticularType 0 (KBasPropTbl.CPP magic-script loader, PhongThanQuestItemTuple.h). Every other
// genre keeps the same (genre, detail, particular) triple.
inline int PTN_IsRuntimeMagicScript(int genre, int detail, int particular)
{
	return genre == PTN_GENRE_MAGICSCRIPT && particular == 0 && detail > 0;
}
inline int PTN_VngDetail(int genre, int detail, int particular)
{
	return PTN_IsRuntimeMagicScript(genre, detail, particular) ? 1 : detail;
}
inline int PTN_VngParticular(int genre, int detail, int particular)
{
	return PTN_IsRuntimeMagicScript(genre, detail, particular) ? detail : particular;
}

// ------------------------------------------------------------------ resist
// Same clamp as KNpc damage code (KNpc.cpp nRes vs m_Current*ResistMax), without the attacker's
// five-element / ignore-resist terms, which a hit script does not know.
inline int PTN_ClampResist(int current, int maximum)
{
	if (maximum > 0)
	{
		if (current > maximum) return maximum;
		if (current < -maximum) return -maximum;
	}
	return current;
}

// ------------------------------------------------------------------ byte / word packing
// Byte 1 = lowest 8 bits, word 1 = lowest 16 bits (same numbering as GetByte/SetByte in ScriptFuns.cpp).
inline int PTN_GetByte(int value, int n)
{
	if (n < 1 || n > 4) return 0;
	return (int)(((unsigned int)value >> ((n - 1) * 8)) & 0xFFu);
}
inline int PTN_SetByte(int value, int n, int b)
{
	if (n < 1 || n > 4) return value;
	const unsigned int shift = (unsigned int)(n - 1) * 8;
	unsigned int u = (unsigned int)value & ~(0xFFu << shift);
	u |= ((unsigned int)b & 0xFFu) << shift;
	return (int)u;
}
inline int PTN_GetWord(int value, int n)
{
	if (n < 1 || n > 2) return 0;
	return (int)(((unsigned int)value >> ((n - 1) * 16)) & 0xFFFFu);
}
inline int PTN_SetWord(int value, int n, int w)
{
	if (n < 1 || n > 2) return value;
	const unsigned int shift = (unsigned int)(n - 1) * 16;
	unsigned int u = (unsigned int)value & ~(0xFFFFu << shift);
	u |= ((unsigned int)w & 0xFFFFu) << shift;
	return (int)u;
}

// ------------------------------------------------------------------ server-wide store
// VNG Get/SetGlobalStoreValue*(id, ...): one 32-bit value per id shared by every player and kept
// across restarts. Saved to <GameServer cwd>\pt_globalstore.txt ("id value" per line, non-zero only).
struct PTN_GlobalStore
{
	int value[PTN_STORE_MAX];
	int loaded;
	char path[260];
};
inline PTN_GlobalStore& PTN_Store()
{
	static PTN_GlobalStore s;
	static int init = 0;
	if (!init)
	{
		memset(&s, 0, sizeof(s));
		strcpy(s.path, "pt_globalstore.txt");
		init = 1;
	}
	return s;
}
inline void PTN_StoreLoad(PTN_GlobalStore& s)
{
	if (s.loaded) return;
	s.loaded = 1;
	FILE* f = fopen(s.path, "r");
	if (!f) return;
	int id = 0, v = 0;
	while (fscanf(f, "%d %d", &id, &v) == 2)
		if (id >= 0 && id < PTN_STORE_MAX) s.value[id] = v;
	fclose(f);
}
inline int PTN_StoreSave(PTN_GlobalStore& s)
{
	char tmp[280];
	sprintf(tmp, "%s.tmp", s.path);
	FILE* f = fopen(tmp, "w");
	if (!f) return 0;
	for (int i = 0; i < PTN_STORE_MAX; ++i)
		if (s.value[i]) fprintf(f, "%d %d\n", i, s.value[i]);
	fclose(f);
	remove(s.path);
	return rename(tmp, s.path) == 0 ? 1 : 0;
}
inline int PTN_StoreGet(int id)
{
	PTN_GlobalStore& s = PTN_Store();
	PTN_StoreLoad(s);
	return (id >= 0 && id < PTN_STORE_MAX) ? s.value[id] : 0;
}
inline int PTN_StoreSet(int id, int value)
{
	PTN_GlobalStore& s = PTN_Store();
	PTN_StoreLoad(s);
	if (id < 0 || id >= PTN_STORE_MAX) return 0;
	if (s.value[id] == value) return 1;
	s.value[id] = value;
	return PTN_StoreSave(s);
}

// ------------------------------------------------------------------ time
inline int PTN_LocalParts(double t, int* parts)	// parts[6] = Y, M, D, h, m, s
{
	time_t tt = (time_t)t;
	struct tm* p = localtime(&tt);
	if (!p) return 0;
	parts[0] = p->tm_year + 1900; parts[1] = p->tm_mon + 1; parts[2] = p->tm_mday;
	parts[3] = p->tm_hour; parts[4] = p->tm_min; parts[5] = p->tm_sec;
	return 1;
}
// whole days from local midnight of yyyymmdd to now; -1 when the date is not valid
inline int PTN_DaysSince(int ymd, time_t now)
{
	if (ymd < 19700101 || ymd > 29991231) return -1;
	struct tm t;
	memset(&t, 0, sizeof(t));
	t.tm_year = ymd / 10000 - 1900;
	t.tm_mon = (ymd / 100) % 100 - 1;
	t.tm_mday = ymd % 100;
	t.tm_isdst = -1;
	if (t.tm_mon < 0 || t.tm_mon > 11 || t.tm_mday < 1 || t.tm_mday > 31) return -1;
	time_t open = mktime(&t);
	if (open == (time_t)-1) return -1;
	if (now <= open) return 0;
	return (int)((now - open) / 86400);
}

// ------------------------------------------------------------------ equipment upgrade
inline int PTN_UpgradeLevelOk(int level)
{
	return level >= 0 && level <= PTN_UPGRADE_MAX;
}
// The upgrade rule (attribute table id) of an equipment identity: column 2 of the type-1 Xich Tung Tu
// recipe whose first input is this equipment. Prefer the recipe that starts from +0 (no level filter,
// or a filter that includes 0); otherwise the first matching recipe. 0 when none.
inline int PTN_FindUpgradeRule(KTabFile& recipes, int detail, int particular)
{
	int fallback = 0;
	for (int row = 2; row <= recipes.GetHeight(); ++row)
	{
		PhongThanComposeRecipe r;
		if (!PhongThanReadComposeRecipe(recipes, row, r)) continue;
		if (r.group != 1 || r.type != 1 || r.attributeId <= 0) continue;
		const PhongThanRecipeItem& in = r.inputs[0];
		if (in.genre != PTN_GENRE_EQUIP || in.detail != detail || in.part != particular) continue;
		if (!in.upgradeMask || (in.upgradeMask & 1u)) return r.attributeId;
		if (!fallback) fallback = r.attributeId;
	}
	return fallback;
}
#endif
