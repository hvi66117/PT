#ifndef PHONGTHAN_PLAYER_PROTOCOL_H
#define PHONGTHAN_PLAYER_PROTOCOL_H
#include "PhongThanWorldProtocol.h"
enum PHONGTHAN_PLAYER_EVENT_CODE
{
	PHONGTHAN_PLAYER_EXIT = 100, PHONGTHAN_PLAYER_GIVE = 101,
	PHONGTHAN_PLAYER_EQUIP_EXPIRY = 102, PHONGTHAN_PLAYER_BANK_PAGES = 103,
	PHONGTHAN_PLAYER_LOCK = 104, PHONGTHAN_PLAYER_ATTRIBUTE_POINTS = 105,
	PHONGTHAN_PLAYER_SKILL_POINTS = 106, PHONGTHAN_PLAYER_RANK_PANEL = 107,
	PHONGTHAN_PLAYER_ENCHASE_PANEL = 108, PHONGTHAN_PLAYER_INPUT_PANEL = 109,
	PHONGTHAN_PLAYER_MASK = 110, PHONGTHAN_PLAYER_LEFT_SKILL = 111,
	PHONGTHAN_PLAYER_RIGHT_SKILL = 112
};
#pragma pack(push, 1)
struct PHONGTHAN_EXPERIENCE_EVENT
{
	PHONGTHAN_WIRE_HEADER Header;
	PHONGTHAN_U32 MapId, EntityId;
	PHONGTHAN_S32 Experience;
};
struct PHONGTHAN_LEVEL_EVENT
{
	PHONGTHAN_WIRE_HEADER Header;
	PHONGTHAN_U32 MapId, EntityId, Level;
	PHONGTHAN_S32 Experience, AttributePoints, SkillPoints;
	PHONGTHAN_S32 BaseMaxLife, BaseMaxStamina, BaseMaxMana;
	PHONGTHAN_U8 ResetAttributes;
	PHONGTHAN_U8 Reserved[3];
};
struct PHONGTHAN_TITLE_EVENT
{
	PHONGTHAN_WIRE_HEADER Header;
	PHONGTHAN_U32 MapId, EntityId;
	PHONGTHAN_S32 RankId, Graphic;
	PHONGTHAN_U32 Color, RemainingTime;
	PHONGTHAN_U8 Expanded;
	PHONGTHAN_U8 Reserved[3];
	char Name[64];
};
struct PHONGTHAN_MOUNT_EVENT
{
	PHONGTHAN_WIRE_HEADER Header;
	PHONGTHAN_U32 MapId, EntityId;
	PHONGTHAN_U8 Mounted;
	PHONGTHAN_U8 Reserved[3];
};
struct PHONGTHAN_PLAYER_EVENT
{
	PHONGTHAN_WIRE_HEADER Header;
	PHONGTHAN_U32 MapId, EntityId;
	PHONGTHAN_U16 Operation;
	PHONGTHAN_U16 Reserved;
	PHONGTHAN_S32 Value;
};
#pragma pack(pop)
inline int PhongThanValidatePlayerEventPacket(const void* data, PHONGTHAN_U32 size)
{
	if (!data || size < sizeof(PHONGTHAN_WIRE_HEADER)) return 0;
	const PHONGTHAN_WIRE_HEADER* header = (const PHONGTHAN_WIRE_HEADER*)data;
	switch (header->MessageType)
	{
	case PHONGTHAN_MSG_GAMEPLAY_EXPERIENCE:
		if (!PhongThanWorldFixedPacket(data, size, header->MessageType, PHONGTHAN_WIRE_FLAG_RESPONSE, sizeof(PHONGTHAN_EXPERIENCE_EVENT))) return 0;
		return ((const PHONGTHAN_EXPERIENCE_EVENT*)data)->MapId && ((const PHONGTHAN_EXPERIENCE_EVENT*)data)->EntityId;
	case PHONGTHAN_MSG_GAMEPLAY_LEVEL:
		{
		if (!PhongThanWorldFixedPacket(data, size, header->MessageType, PHONGTHAN_WIRE_FLAG_RESPONSE, sizeof(PHONGTHAN_LEVEL_EVENT))) return 0;
		const PHONGTHAN_LEVEL_EVENT* event = (const PHONGTHAN_LEVEL_EVENT*)data;
		return event->MapId && event->EntityId && event->Level && event->ResetAttributes <= 1 && !event->Reserved[0] && !event->Reserved[1] && !event->Reserved[2];
		}
	case PHONGTHAN_MSG_WORLD_TITLE:
		{
		if (!PhongThanWorldFixedPacket(data, size, header->MessageType, PHONGTHAN_WIRE_FLAG_RESPONSE, sizeof(PHONGTHAN_TITLE_EVENT))) return 0;
		const PHONGTHAN_TITLE_EVENT* event = (const PHONGTHAN_TITLE_EVENT*)data;
		return event->MapId && event->EntityId && event->Expanded <= 1 && !event->Reserved[0] && !event->Reserved[1] && !event->Reserved[2] && PhongThanWireTextTerminated(event->Name, sizeof(event->Name));
		}
	case PHONGTHAN_MSG_WORLD_MOUNT:
		{
		if (!PhongThanWorldFixedPacket(data, size, header->MessageType, PHONGTHAN_WIRE_FLAG_RESPONSE, sizeof(PHONGTHAN_MOUNT_EVENT))) return 0;
		const PHONGTHAN_MOUNT_EVENT* event = (const PHONGTHAN_MOUNT_EVENT*)data;
		return event->MapId && event->EntityId && event->Mounted <= 1 && !event->Reserved[0] && !event->Reserved[1] && !event->Reserved[2];
		}
	case PHONGTHAN_MSG_UI_PLAYER_EVENT:
		{
		if (!PhongThanWorldFixedPacket(data, size, header->MessageType, PHONGTHAN_WIRE_FLAG_RESPONSE, sizeof(PHONGTHAN_PLAYER_EVENT))) return 0;
		const PHONGTHAN_PLAYER_EVENT* event = (const PHONGTHAN_PLAYER_EVENT*)data;
		return event->MapId && event->EntityId && !event->Reserved && event->Operation >= PHONGTHAN_PLAYER_EXIT && event->Operation <= PHONGTHAN_PLAYER_RIGHT_SKILL;
		}
	}
	return 0;
}
#endif
