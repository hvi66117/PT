#ifndef PHONGTHAN_GAMEPLAY_PROTOCOL_H
#define PHONGTHAN_GAMEPLAY_PROTOCOL_H
#include "PhongThanWorldProtocol.h"

enum PHONGTHAN_SKILL_TARGET
{
	PHONGTHAN_SKILL_TARGET_POSITION = 1,
	PHONGTHAN_SKILL_TARGET_ENTITY = 2
};

#pragma pack(push, 1)
struct PHONGTHAN_ATTRIBUTE_REQUEST
{
	PHONGTHAN_WIRE_HEADER Header;
	PHONGTHAN_U32 MapId;
	PHONGTHAN_U16 Attribute;
	PHONGTHAN_U16 Reserved;
	PHONGTHAN_S32 Points;
};
struct PHONGTHAN_ATTRIBUTE_UPDATE
{
	PHONGTHAN_WIRE_HEADER Header;
	PHONGTHAN_U32 MapId;
	PHONGTHAN_U32 EntityId;
	PHONGTHAN_U16 Attribute;
	PHONGTHAN_U16 Reserved;
	PHONGTHAN_S32 Base;
	PHONGTHAN_S32 Current;
	PHONGTHAN_S32 RemainingPoints;
};
struct PHONGTHAN_SKILL_LEVEL_REQUEST
{
	PHONGTHAN_WIRE_HEADER Header;
	PHONGTHAN_U32 MapId;
	PHONGTHAN_U32 SkillId;
	PHONGTHAN_S32 Points;
};
struct PHONGTHAN_SKILL_LEVEL_UPDATE
{
	PHONGTHAN_WIRE_HEADER Header;
	PHONGTHAN_U32 MapId;
	PHONGTHAN_U32 EntityId;
	PHONGTHAN_U32 SkillId;
	PHONGTHAN_S32 Level;
	PHONGTHAN_S32 BonusLevel;
	PHONGTHAN_S32 Experience;
	PHONGTHAN_S32 RemainingPoints;
	PHONGTHAN_U8 Temporary;
	PHONGTHAN_U8 Reserved[3];
};
struct PHONGTHAN_STATE_CLEAR
{
	PHONGTHAN_WIRE_HEADER Header;
	PHONGTHAN_U32 MapId;
	PHONGTHAN_U32 EntityId;
	PHONGTHAN_U8 Negative;
	PHONGTHAN_U8 Reserved[3];
};
struct PHONGTHAN_SKILL_ENTRY
{
	PHONGTHAN_U32 SkillId;
	PHONGTHAN_U32 Level;
	PHONGTHAN_S32 Experience;
};
struct PHONGTHAN_SKILL_LIST_HEADER
{
	PHONGTHAN_WIRE_HEADER Header;
	PHONGTHAN_U32 MapId;
	PHONGTHAN_U32 EntityId;
	PHONGTHAN_U16 Count;
	PHONGTHAN_U16 Reserved;
};
struct PHONGTHAN_STATE_EFFECT_HEADER
{
	PHONGTHAN_WIRE_HEADER Header;
	PHONGTHAN_U32 MapId;
	PHONGTHAN_U32 EntityId;
	PHONGTHAN_U32 SkillId;
	PHONGTHAN_U32 Level;
	PHONGTHAN_S32 DurationTicks;
	PHONGTHAN_U16 AttributeCount;
	PHONGTHAN_U8 ReplaceExisting;
	PHONGTHAN_U8 Reserved;
};
struct PHONGTHAN_SKILL_REQUEST
{
	PHONGTHAN_WIRE_HEADER Header;
	PHONGTHAN_U32 MapId;
	PHONGTHAN_U32 SkillId;
	PHONGTHAN_U32 TargetId;
	PHONGTHAN_S32 X;
	PHONGTHAN_S32 Y;
	PHONGTHAN_U16 TargetKind;
	PHONGTHAN_U16 Reserved;
};
struct PHONGTHAN_SKILL_CAST
{
	PHONGTHAN_WIRE_HEADER Header;
	PHONGTHAN_U32 MapId;
	PHONGTHAN_U32 EntityId;
	PHONGTHAN_U32 SkillId;
	PHONGTHAN_U32 SkillLevel;
	PHONGTHAN_U32 TargetId;
	PHONGTHAN_S32 X;
	PHONGTHAN_S32 Y;
	PHONGTHAN_U16 TargetKind;
	PHONGTHAN_U8 DirectEffect;
	PHONGTHAN_U8 Reserved;
};
#pragma pack(pop)

inline PHONGTHAN_U16 PhongThanEncodeAttribute(int index)
{
	switch (index) { case 0: return 10; case 1: return 20; case 2: return 30; case 3: return 40; }
	return 0;
}
inline int PhongThanDecodeAttribute(PHONGTHAN_U16 attribute)
{
	switch (attribute) { case 10: return 0; case 20: return 1; case 30: return 2; case 40: return 3; }
	return -1;
}
inline int PhongThanValidateAttributeRequest(const void* data, PHONGTHAN_U32 size)
{
	if (!PhongThanWorldFixedPacket(data, size, PHONGTHAN_MSG_GAMEPLAY_ATTRIBUTE_REQUEST,
		PHONGTHAN_WIRE_FLAG_REQUEST, sizeof(PHONGTHAN_ATTRIBUTE_REQUEST))) return 0;
	const PHONGTHAN_ATTRIBUTE_REQUEST* request = (const PHONGTHAN_ATTRIBUTE_REQUEST*)data;
	return request->MapId > 0 && request->Points > 0 && !request->Reserved &&
		PhongThanDecodeAttribute(request->Attribute) >= 0;
}
inline int PhongThanValidateSkillLevelRequest(const void* data, PHONGTHAN_U32 size)
{
	if (!PhongThanWorldFixedPacket(data, size, PHONGTHAN_MSG_GAMEPLAY_SKILL_LEVEL_REQUEST,
		PHONGTHAN_WIRE_FLAG_REQUEST, sizeof(PHONGTHAN_SKILL_LEVEL_REQUEST))) return 0;
	const PHONGTHAN_SKILL_LEVEL_REQUEST* request = (const PHONGTHAN_SKILL_LEVEL_REQUEST*)data;
	return request->MapId > 0 && request->SkillId > 0 && request->Points > 0;
}
inline int PhongThanValidateAttributeUpdate(const void* data, PHONGTHAN_U32 size)
{
	if (!PhongThanWorldFixedPacket(data, size, PHONGTHAN_MSG_GAMEPLAY_ATTRIBUTE_UPDATE,
		PHONGTHAN_WIRE_FLAG_RESPONSE, sizeof(PHONGTHAN_ATTRIBUTE_UPDATE))) return 0;
	const PHONGTHAN_ATTRIBUTE_UPDATE* update = (const PHONGTHAN_ATTRIBUTE_UPDATE*)data;
	return update->MapId > 0 && update->EntityId > 0 && !update->Reserved &&
		PhongThanDecodeAttribute(update->Attribute) >= 0;
}
inline int PhongThanValidateSkillLevelUpdate(const void* data, PHONGTHAN_U32 size)
{
	if (!PhongThanWorldFixedPacket(data, size, PHONGTHAN_MSG_GAMEPLAY_SKILL_LEVEL_UPDATE,
		PHONGTHAN_WIRE_FLAG_RESPONSE, sizeof(PHONGTHAN_SKILL_LEVEL_UPDATE))) return 0;
	const PHONGTHAN_SKILL_LEVEL_UPDATE* update = (const PHONGTHAN_SKILL_LEVEL_UPDATE*)data;
	return update->MapId > 0 && update->EntityId > 0 && update->SkillId > 0 && update->Level >= 0 &&
		update->Temporary <= 1 && !update->Reserved[0] && !update->Reserved[1] && !update->Reserved[2];
}
inline int PhongThanValidateStateClear(const void* data, PHONGTHAN_U32 size)
{
	if (!PhongThanWorldFixedPacket(data, size, PHONGTHAN_MSG_GAMEPLAY_STATE_CLEAR,
		PHONGTHAN_WIRE_FLAG_RESPONSE, sizeof(PHONGTHAN_STATE_CLEAR))) return 0;
	const PHONGTHAN_STATE_CLEAR* state = (const PHONGTHAN_STATE_CLEAR*)data;
	return state->MapId > 0 && state->EntityId > 0 && state->Negative <= 1 &&
		!state->Reserved[0] && !state->Reserved[1] && !state->Reserved[2];
}

inline int PhongThanSkillTargetValid(PHONGTHAN_U16 kind, PHONGTHAN_U32 id,
	PHONGTHAN_S32 x, PHONGTHAN_S32 y)
{
	if (kind == PHONGTHAN_SKILL_TARGET_ENTITY)
		return id != 0 && x == 0 && y == 0;
	return kind == PHONGTHAN_SKILL_TARGET_POSITION && id == 0 &&
		PhongThanWorldPositionValid(x, y);
}

inline int PhongThanValidateSkillRequest(const void* data, PHONGTHAN_U32 size)
{
	if (!PhongThanWorldFixedPacket(data, size, PHONGTHAN_MSG_GAMEPLAY_SKILL_REQUEST,
		PHONGTHAN_WIRE_FLAG_REQUEST, sizeof(PHONGTHAN_SKILL_REQUEST))) return 0;
	const PHONGTHAN_SKILL_REQUEST* skill = (const PHONGTHAN_SKILL_REQUEST*)data;
	return skill->MapId > 0 && skill->SkillId > 0 && skill->Reserved == 0 &&
		PhongThanSkillTargetValid(skill->TargetKind, skill->TargetId, skill->X, skill->Y);
}

inline int PhongThanValidateSkillCast(const void* data, PHONGTHAN_U32 size)
{
	if (!PhongThanWorldFixedPacket(data, size, PHONGTHAN_MSG_GAMEPLAY_SKILL_CAST,
		PHONGTHAN_WIRE_FLAG_RESPONSE, sizeof(PHONGTHAN_SKILL_CAST))) return 0;
	const PHONGTHAN_SKILL_CAST* skill = (const PHONGTHAN_SKILL_CAST*)data;
	return skill->MapId > 0 && skill->EntityId > 0 && skill->SkillId > 0 &&
		skill->SkillLevel > 0 && skill->DirectEffect <= 1 && skill->Reserved == 0 &&
		PhongThanSkillTargetValid(skill->TargetKind, skill->TargetId, skill->X, skill->Y);
}

inline int PhongThanValidateSkillList(const void* data, PHONGTHAN_U32 size)
{
	if (!data || size < sizeof(PHONGTHAN_SKILL_LIST_HEADER)) return 0;
	const PHONGTHAN_SKILL_LIST_HEADER* list = (const PHONGTHAN_SKILL_LIST_HEADER*)data;
	if (!list->MapId || !list->EntityId || list->Count > 512 || list->Reserved ||
		!PhongThanWorldFixedPacket(data, size, PHONGTHAN_MSG_GAMEPLAY_SKILL_LIST,
			PHONGTHAN_WIRE_FLAG_RESPONSE, sizeof(*list) + list->Count * sizeof(PHONGTHAN_SKILL_ENTRY)))
		return 0;
	const PHONGTHAN_SKILL_ENTRY* skills = (const PHONGTHAN_SKILL_ENTRY*)(list + 1);
	for (PHONGTHAN_U16 i = 0; i < list->Count; ++i)
	{
		if (!skills[i].SkillId) return 0;
		for (PHONGTHAN_U16 j = 0; j < i; ++j)
			if (skills[i].SkillId == skills[j].SkillId) return 0;
	}
	return 1;
}

inline int PhongThanValidateStateEffect(const void* data, PHONGTHAN_U32 size)
{
	if (!data || size < sizeof(PHONGTHAN_STATE_EFFECT_HEADER)) return 0;
	const PHONGTHAN_STATE_EFFECT_HEADER* state = (const PHONGTHAN_STATE_EFFECT_HEADER*)data;
	return state->MapId > 0 && state->EntityId > 0 && state->SkillId > 0 && state->Level > 0 &&
		state->AttributeCount <= PHONGTHAN_ENTITY_EFFECT_CAPACITY && state->ReplaceExisting <= 1 &&
		!state->Reserved && PhongThanWorldFixedPacket(data, size, PHONGTHAN_MSG_GAMEPLAY_STATE_EFFECT,
			PHONGTHAN_WIRE_FLAG_RESPONSE, sizeof(*state) + state->AttributeCount * sizeof(PHONGTHAN_ATTRIBUTE_WIRE));
}
#endif
