#ifndef PHONGTHAN_CHARACTER_H
#define PHONGTHAN_CHARACTER_H

#include "PhongThanProtocol.h"
#include <string.h>

// Canonical Phong Than character state. This schema is independent from the
// in-memory classes of either client or server and from every legacy database
// struct. Variable sections are serialized directly after the fixed header in
// this order: fight skills, state skills, tasks, items.
enum PHONGTHAN_CHARACTER_CONSTANT
{
	PHONGTHAN_CHARACTER_SCHEMA_VERSION = 1,
	PHONGTHAN_CHARACTER_STAT_TASK_COUNT = 10,
	PHONGTHAN_CHARACTER_MAX_SKILLS = 512,
	PHONGTHAN_CHARACTER_MAX_TASKS = 255,
	PHONGTHAN_CHARACTER_MAX_ITEMS = 512,
	PHONGTHAN_CHARACTER_MAX_STATE_SIZE = 64 * 1024
};

#pragma pack(push, 1)

typedef struct
{
	PHONGTHAN_S32 SkillId;
	PHONGTHAN_S32 Level;
	PHONGTHAN_S32 Value;
} PHONGTHAN_CHARACTER_SKILL_RECORD;

typedef struct
{
	PHONGTHAN_S32 TaskId;
	PHONGTHAN_U8 Value[16];
} PHONGTHAN_CHARACTER_TASK_RECORD;

typedef struct
{
	PHONGTHAN_U32 SchemaVersion;
	PHONGTHAN_S32 TemplateRow;
	PHONGTHAN_S32 Genre;
	PHONGTHAN_S32 Container;
	PHONGTHAN_S32 SlotX;
	PHONGTHAN_S32 SlotY;
	PHONGTHAN_S32 DetailType;
	PHONGTHAN_S32 ParticularType;
	PHONGTHAN_S32 Level;
	PHONGTHAN_S32 Series;
	PHONGTHAN_S32 TableVersion;
	PHONGTHAN_U32 RandomSeed;
	PHONGTHAN_S32 Luck;
	PHONGTHAN_S32 Durability;
	PHONGTHAN_S32 GeneratorLevel[PHONGTHAN_ITEM_PROPERTY_VALUE_COUNT];
	PHONGTHAN_U32 ExpireTime;
	PHONGTHAN_S32 StackCount;
	PHONGTHAN_S32 LockState;
	PHONGTHAN_U32 LockUntil;
	PHONGTHAN_S32 ScriptParam;
	PHONGTHAN_S32 Fortune;
	PHONGTHAN_U32 OwnerId;
	PHONGTHAN_S32 TradePrice;
	PHONGTHAN_U8 LockSell;
	PHONGTHAN_U8 LockTrade;
	PHONGTHAN_U8 LockDrop;
	PHONGTHAN_U8 Reserved;
	// Legacy level or tagged rule/level; see PhongThanUpgradeState.h.
	PHONGTHAN_S32 UpgradeLevel;
	PHONGTHAN_S32 PhysicalValue;
	PHONGTHAN_S32 MagicValue;
	PHONGTHAN_U32 Flash;
} PHONGTHAN_CHARACTER_ITEM_RECORD;

typedef struct
{
	PHONGTHAN_U32 SchemaVersion;
	PHONGTHAN_U32 StateSize;
	PHONGTHAN_U32 Revision;
	PHONGTHAN_U32 RoleTime;
	PHONGTHAN_U8 RoleName[32];
	PHONGTHAN_U8 AccountName[32];
	PHONGTHAN_U8 Gender;
	PHONGTHAN_U8 Profession;
	PHONGTHAN_U8 FightMode;
	PHONGTHAN_U8 UseRevive;
	PHONGTHAN_U8 IsExchange;
	PHONGTHAN_U8 PkStatus;
	PHONGTHAN_U8 LockPkState;
	PHONGTHAN_U8 HelmResource;
	PHONGTHAN_U8 Transcendence;
	PHONGTHAN_U8 ClanLevel;
	PHONGTHAN_U8 ExtraBox;
	PHONGTHAN_U8 ReservedFlags;

	PHONGTHAN_S32 TitleRank;
	PHONGTHAN_U8 RankName[64];
	PHONGTHAN_U32 RankColor;
	PHONGTHAN_S32 RankGraphic;
	PHONGTHAN_U32 RankRemainingTime;

	PHONGTHAN_S32 ReviveMapId;
	PHONGTHAN_S32 ReviveX;
	PHONGTHAN_S32 ReviveY;
	PHONGTHAN_S32 EnterMapId;
	PHONGTHAN_S32 EnterX;
	PHONGTHAN_S32 EnterY;
	PHONGTHAN_S32 BankMoney;
	PHONGTHAN_S32 Money;
	PHONGTHAN_S32 TeamId;
	PHONGTHAN_S32 FightLevel;
	PHONGTHAN_S32 FightExperience;
	PHONGTHAN_S32 LeadershipLevel;
	PHONGTHAN_S32 LeadershipExperience;
	PHONGTHAN_S32 Power;
	PHONGTHAN_S32 Agility;
	PHONGTHAN_S32 Physique;
	PHONGTHAN_S32 Wisdom;
	PHONGTHAN_S32 Luck;
	PHONGTHAN_S32 MaxLife;
	PHONGTHAN_S32 MaxStamina;
	PHONGTHAN_S32 MaxMana;
	PHONGTHAN_S32 CurrentLife;
	PHONGTHAN_S32 CurrentStamina;
	PHONGTHAN_S32 CurrentMana;
	PHONGTHAN_S32 PkValue;
	PHONGTHAN_S32 RemainingAttributePoints;
	PHONGTHAN_S32 RemainingSkillPoints;
	PHONGTHAN_S32 ProfessionRank;
	PHONGTHAN_S32 WorldState;
	PHONGTHAN_S32 KillCount;
	PHONGTHAN_U32 ForbiddenUntil;
	PHONGTHAN_U32 ClanLeaveTime;
	PHONGTHAN_U32 ClanId;
	PHONGTHAN_U8 ClanName[32];
	PHONGTHAN_S32 ClanMemberCount;
	PHONGTHAN_U32 ClanEffect;
	PHONGTHAN_U32 ExtraItemRole;
	PHONGTHAN_S32 ExtensionPoint;
	PHONGTHAN_S32 StatTask[PHONGTHAN_CHARACTER_STAT_TASK_COUNT];

	PHONGTHAN_U32 FightSkillCount;
	PHONGTHAN_U32 StateSkillCount;
	PHONGTHAN_U32 TaskCount;
	PHONGTHAN_U32 ItemCount;
} PHONGTHAN_CHARACTER_STATE_HEADER;

#pragma pack(pop)

typedef char PHONGTHAN_CHARACTER_SKILL_RECORD_SIZE_MUST_BE_12[
	(sizeof(PHONGTHAN_CHARACTER_SKILL_RECORD) == 12) ? 1 : -1];
typedef char PHONGTHAN_CHARACTER_TASK_RECORD_SIZE_MUST_BE_20[
	(sizeof(PHONGTHAN_CHARACTER_TASK_RECORD) == 20) ? 1 : -1];
typedef char PHONGTHAN_CHARACTER_STATE_HEADER_SIZE_MUST_BE_408[
	(sizeof(PHONGTHAN_CHARACTER_STATE_HEADER) == 408) ? 1 : -1];

inline PHONGTHAN_U32 PhongThanCharacterExpectedStateSize(
	const PHONGTHAN_CHARACTER_STATE_HEADER* pState)
{
	if (!pState)
		return 0;
	unsigned __int64 nSize = sizeof(PHONGTHAN_CHARACTER_STATE_HEADER);
	nSize += (unsigned __int64)pState->FightSkillCount *
		sizeof(PHONGTHAN_CHARACTER_SKILL_RECORD);
	nSize += (unsigned __int64)pState->StateSkillCount *
		sizeof(PHONGTHAN_CHARACTER_SKILL_RECORD);
	nSize += (unsigned __int64)pState->TaskCount *
		sizeof(PHONGTHAN_CHARACTER_TASK_RECORD);
	nSize += (unsigned __int64)pState->ItemCount *
		sizeof(PHONGTHAN_CHARACTER_ITEM_RECORD);
	return nSize <= 0xffffffffui64 ? (PHONGTHAN_U32)nSize : 0;
}

inline int PhongThanValidateCharacterState(
	const PHONGTHAN_CHARACTER_STATE_HEADER* pState,
	PHONGTHAN_U32 nAvailableSize)
{
	if (!pState || nAvailableSize < sizeof(*pState) ||
		pState->SchemaVersion != PHONGTHAN_CHARACTER_SCHEMA_VERSION ||
		pState->StateSize != nAvailableSize ||
		pState->StateSize > PHONGTHAN_CHARACTER_MAX_STATE_SIZE ||
		pState->FightSkillCount > PHONGTHAN_CHARACTER_MAX_SKILLS ||
		pState->StateSkillCount > PHONGTHAN_CHARACTER_MAX_SKILLS ||
		pState->TaskCount > PHONGTHAN_CHARACTER_MAX_TASKS ||
		pState->ItemCount > PHONGTHAN_CHARACTER_MAX_ITEMS ||
		!memchr(pState->RoleName, 0, sizeof(pState->RoleName)) ||
		!memchr(pState->AccountName, 0, sizeof(pState->AccountName)) ||
		PhongThanCharacterExpectedStateSize(pState) != nAvailableSize)
	{
		return 0;
	}
	return 1;
}

inline PHONGTHAN_CHARACTER_SKILL_RECORD* PhongThanCharacterFightSkills(
	PHONGTHAN_CHARACTER_STATE_HEADER* pState)
{
	return pState ? (PHONGTHAN_CHARACTER_SKILL_RECORD*)(pState + 1) : 0;
}

inline const PHONGTHAN_CHARACTER_SKILL_RECORD* PhongThanCharacterFightSkills(
	const PHONGTHAN_CHARACTER_STATE_HEADER* pState)
{
	return pState ? (const PHONGTHAN_CHARACTER_SKILL_RECORD*)(pState + 1) : 0;
}

inline PHONGTHAN_CHARACTER_SKILL_RECORD* PhongThanCharacterStateSkills(
	PHONGTHAN_CHARACTER_STATE_HEADER* pState)
{
	return pState ? PhongThanCharacterFightSkills(pState) +
		pState->FightSkillCount : 0;
}

inline const PHONGTHAN_CHARACTER_SKILL_RECORD* PhongThanCharacterStateSkills(
	const PHONGTHAN_CHARACTER_STATE_HEADER* pState)
{
	return pState ? PhongThanCharacterFightSkills(pState) +
		pState->FightSkillCount : 0;
}

inline PHONGTHAN_CHARACTER_TASK_RECORD* PhongThanCharacterTasks(
	PHONGTHAN_CHARACTER_STATE_HEADER* pState)
{
	return pState ? (PHONGTHAN_CHARACTER_TASK_RECORD*)(
		PhongThanCharacterStateSkills(pState) + pState->StateSkillCount) : 0;
}

inline const PHONGTHAN_CHARACTER_TASK_RECORD* PhongThanCharacterTasks(
	const PHONGTHAN_CHARACTER_STATE_HEADER* pState)
{
	return pState ? (const PHONGTHAN_CHARACTER_TASK_RECORD*)(
		PhongThanCharacterStateSkills(pState) + pState->StateSkillCount) : 0;
}

inline PHONGTHAN_CHARACTER_ITEM_RECORD* PhongThanCharacterItems(
	PHONGTHAN_CHARACTER_STATE_HEADER* pState)
{
	return pState ? (PHONGTHAN_CHARACTER_ITEM_RECORD*)(
		PhongThanCharacterTasks(pState) + pState->TaskCount) : 0;
}

inline const PHONGTHAN_CHARACTER_ITEM_RECORD* PhongThanCharacterItems(
	const PHONGTHAN_CHARACTER_STATE_HEADER* pState)
{
	return pState ? (const PHONGTHAN_CHARACTER_ITEM_RECORD*)(
		PhongThanCharacterTasks(pState) + pState->TaskCount) : 0;
}

#endif
