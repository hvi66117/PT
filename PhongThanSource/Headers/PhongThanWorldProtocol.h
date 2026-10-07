#ifndef PHONGTHAN_WORLD_PROTOCOL_H
#define PHONGTHAN_WORLD_PROTOCOL_H

#include "PhongThanProtocol.h"

// Coordinates are absolute map pixels, never region indexes or packed words.
// The sender identity and source position are owned by the server.
enum PHONGTHAN_MOVEMENT_MODE
{
	PHONGTHAN_MOVE_WALK = 1,
	PHONGTHAN_MOVE_RUN = 2,
	PHONGTHAN_MOVE_JUMP = 3
};

enum PHONGTHAN_WORLD_LIMIT
{
	PHONGTHAN_WORLD_COORDINATE_MAX = 0x00ffffff,
	PHONGTHAN_ENTITY_NAME_CAPACITY = 64,
	PHONGTHAN_ENTITY_EFFECT_CAPACITY = 18
};

enum PHONGTHAN_POSITION_MODE
{
	PHONGTHAN_POSITION_STAND = 1,
	PHONGTHAN_POSITION_RECONCILE = 2,
	PHONGTHAN_POSITION_TELEPORT = 3,
	PHONGTHAN_POSITION_TRACK = 4
};
enum PHONGTHAN_ENTITY_STATUS_KIND
{
	PHONGTHAN_STATUS_SIT = 1,
	PHONGTHAN_STATUS_DEATH = 2,
	PHONGTHAN_STATUS_HURT = 3,
	PHONGTHAN_STATUS_REVIVE = 4,
	PHONGTHAN_STATUS_BASE_CAMP = 5,
	PHONGTHAN_STATUS_CURRENT_CAMP = 6
};
enum PHONGTHAN_POSE_REQUEST_KIND
{
	PHONGTHAN_POSE_STAND = 1,
	PHONGTHAN_POSE_SIT = 2,
	PHONGTHAN_POSE_TOGGLE_MOUNT = 3,
	PHONGTHAN_POSE_REVIVE = 4
};

enum PHONGTHAN_ENTITY_ACTION
{
	PHONGTHAN_ACTION_NONE = 100, PHONGTHAN_ACTION_STAND = 101,
	PHONGTHAN_ACTION_WALK = 102, PHONGTHAN_ACTION_RUN = 103,
	PHONGTHAN_ACTION_JUMP = 104, PHONGTHAN_ACTION_SKILL = 105,
	PHONGTHAN_ACTION_MAGIC = 106, PHONGTHAN_ACTION_ATTACK = 107,
	PHONGTHAN_ACTION_SIT = 108, PHONGTHAN_ACTION_HURT = 109,
	PHONGTHAN_ACTION_DEATH = 110, PHONGTHAN_ACTION_DEFENSE = 111,
	PHONGTHAN_ACTION_IDLE = 112, PHONGTHAN_ACTION_SPECIAL_SKILL = 113,
	PHONGTHAN_ACTION_SPECIAL1 = 114, PHONGTHAN_ACTION_SPECIAL2 = 115,
	PHONGTHAN_ACTION_SPECIAL3 = 116, PHONGTHAN_ACTION_BLUR_MOVE = 117,
	PHONGTHAN_ACTION_RUN_ATTACK = 118, PHONGTHAN_ACTION_MANY_ATTACK = 119,
	PHONGTHAN_ACTION_JUMP_ATTACK = 120, PHONGTHAN_ACTION_REVIVE = 121,
	PHONGTHAN_ACTION_GO_ATTACK = 122
};

#pragma pack(push, 1)
struct PHONGTHAN_ENTITY_POSITION
{
	PHONGTHAN_WIRE_HEADER Header;
	PHONGTHAN_U32 MapId;
	PHONGTHAN_U32 EntityId;
	PHONGTHAN_S32 X;
	PHONGTHAN_S32 Y;
	PHONGTHAN_U16 Mode;
	PHONGTHAN_U16 Action;
};
struct PHONGTHAN_ENTITY_STATUS
{
	PHONGTHAN_WIRE_HEADER Header;
	PHONGTHAN_U32 MapId;
	PHONGTHAN_U32 EntityId;
	PHONGTHAN_U16 Kind;
	PHONGTHAN_U16 Reserved;
	PHONGTHAN_S32 Value;
	PHONGTHAN_S32 X;
	PHONGTHAN_S32 Y;
};
struct PHONGTHAN_POSE_REQUEST
{
	PHONGTHAN_WIRE_HEADER Header;
	PHONGTHAN_U32 MapId;
	PHONGTHAN_U16 Kind;
	PHONGTHAN_U16 Reserved;
};
struct PHONGTHAN_WORLD_SYNC_FENCE
{
	PHONGTHAN_WIRE_HEADER Header;
	PHONGTHAN_U8 SessionTicket[PHONGTHAN_SESSION_TICKET_SIZE];
};

struct PHONGTHAN_MAP_SNAPSHOT
{
	PHONGTHAN_WIRE_HEADER Header;
	PHONGTHAN_U32 MapId;
	PHONGTHAN_U32 RegionId;
	PHONGTHAN_U32 Tick;
	PHONGTHAN_S32 ClanTax;
	PHONGTHAN_S32 ClanTreasury;
	PHONGTHAN_U8 Weather;
	PHONGTHAN_U8 ClanControlled;
	PHONGTHAN_U16 Reserved;
	char ClanName[32];
	char ControllingClanName[32];
};

struct PHONGTHAN_SELF_SNAPSHOT
{
	PHONGTHAN_WIRE_HEADER Header;
	PHONGTHAN_U32 MapId;
	PHONGTHAN_U32 EntityId;
	PHONGTHAN_U32 PlayerId;
	PHONGTHAN_U32 Level;
	PHONGTHAN_U8 Gender;
	PHONGTHAN_U8 Profession;
	PHONGTHAN_U8 Series;
	PHONGTHAN_U8 Transcendence;
	PHONGTHAN_S32 BaseMaxLife;
	PHONGTHAN_S32 BaseMaxStamina;
	PHONGTHAN_S32 BaseMaxMana;
	PHONGTHAN_S32 HeadImage;
	PHONGTHAN_S32 AttributePoints;
	PHONGTHAN_S32 SkillPoints;
	PHONGTHAN_S32 Power;
	PHONGTHAN_S32 Agility;
	PHONGTHAN_S32 Physique;
	PHONGTHAN_S32 Wisdom;
	PHONGTHAN_S32 Luck;
	PHONGTHAN_S32 Experience;
	PHONGTHAN_S32 LeadershipExperience;
	PHONGTHAN_S32 MissionGroup;
	PHONGTHAN_S32 ChatRoomId;
	PHONGTHAN_S32 WorldRank;
	PHONGTHAN_S32 ProfessionRank;
	PHONGTHAN_S32 KillCount;
	PHONGTHAN_S32 Money;
	PHONGTHAN_S32 BankMoney;
	PHONGTHAN_U32 ExtraEquipUntil;
	PHONGTHAN_U32 ClanLeaveTime;
	PHONGTHAN_S32 ExtensionPoint;
	PHONGTHAN_U16 BankPages;
	PHONGTHAN_U8 Portrait;
	PHONGTHAN_U8 Reserved;
};

struct PHONGTHAN_SELF_VITALS
{
	PHONGTHAN_WIRE_HEADER Header;
	PHONGTHAN_U32 MapId;
	PHONGTHAN_U32 EntityId;
	PHONGTHAN_S32 Life;
	PHONGTHAN_S32 Stamina;
	PHONGTHAN_S32 Mana;
	PHONGTHAN_U8 TeamRole; // 0: none, 1: member, 2: captain
	PHONGTHAN_U8 Reserved[3];
};

struct PHONGTHAN_VISUAL_PART_WIRE
{
	PHONGTHAN_S32 ResourceId;
	PHONGTHAN_S32 PaletteId;
	PHONGTHAN_U8 Visible;
};

struct PHONGTHAN_PLAYER_SNAPSHOT
{
	PHONGTHAN_WIRE_HEADER Header;
	PHONGTHAN_U32 MapId;
	PHONGTHAN_U32 EntityId;
	PHONGTHAN_S32 TeamId;
	PHONGTHAN_VISUAL_PART_WIRE Helm, Armor, Weapon, PhiPhong, Horse;
	PHONGTHAN_S32 TitleId;
	PHONGTHAN_U32 TitleColor;
	PHONGTHAN_S32 TitleGraphic;
	PHONGTHAN_U32 TitleRemainingTime;
	PHONGTHAN_S32 ClanEmblem;
	PHONGTHAN_U32 ClanId;
	PHONGTHAN_S32 ClanRole;
	PHONGTHAN_S32 Reputation;
	PHONGTHAN_S32 Fortune;
	PHONGTHAN_S32 PkValue;
	PHONGTHAN_S32 MaskResource;
	PHONGTHAN_S32 WorldRank;
	PHONGTHAN_S32 ShopDestination;
	PHONGTHAN_U8 FullSnapshot;
	PHONGTHAN_U8 Mounted;
	PHONGTHAN_U8 Transcendence;
	PHONGTHAN_U8 VipRank;
	PHONGTHAN_U8 PkMode;
	PHONGTHAN_U8 FortuneRank;
	PHONGTHAN_U8 Profession;
	PHONGTHAN_U8 Portrait;
	PHONGTHAN_U8 ProgressPercent;
	PHONGTHAN_U8 FightMode;
	PHONGTHAN_U8 Sleeping;
	PHONGTHAN_U8 ShopOpen;
	char TitleName[64];
	char ClanName[32];
	char ClanTitle[32];
	char PartnerName[32];
	char ShopName[32];
};

struct PHONGTHAN_NPC_SNAPSHOT
{
	PHONGTHAN_WIRE_HEADER Header;
	PHONGTHAN_U32 MapId;
	PHONGTHAN_U32 EntityId;
	PHONGTHAN_S32 TemplateId;
	PHONGTHAN_U16 Level;
	PHONGTHAN_U16 Action;
	PHONGTHAN_S32 X;
	PHONGTHAN_S32 Y;
	PHONGTHAN_S32 Direction;
	PHONGTHAN_S32 Life;
	PHONGTHAN_S32 MaxLife;
	PHONGTHAN_S32 MissionGroup;
	PHONGTHAN_U8 Kind;
	PHONGTHAN_U8 Camp;
	PHONGTHAN_U8 CurrentCamp;
	PHONGTHAN_U8 Series;
	PHONGTHAN_U8 MenuState;
	PHONGTHAN_U8 Special;
	PHONGTHAN_U16 NameLength;
	PHONGTHAN_U8 Name[PHONGTHAN_ENTITY_NAME_CAPACITY];
};

struct PHONGTHAN_NPC_UPDATE
{
	PHONGTHAN_WIRE_HEADER Header;
	PHONGTHAN_U32 MapId;
	PHONGTHAN_U32 EntityId;
	PHONGTHAN_S32 X;
	PHONGTHAN_S32 Y;
	PHONGTHAN_S32 Life;
	PHONGTHAN_S32 MaxLife;
	PHONGTHAN_S32 WalkSpeed;
	PHONGTHAN_S32 RunSpeed;
	PHONGTHAN_S32 AttackSpeed;
	PHONGTHAN_S32 CastSpeed;
	PHONGTHAN_U16 Action;
	PHONGTHAN_U8 Camp;
	PHONGTHAN_U8 StateFlags;
	PHONGTHAN_U8 Effects[PHONGTHAN_ENTITY_EFFECT_CAPACITY];
};

struct PHONGTHAN_MOVE_REQUEST
{
	PHONGTHAN_WIRE_HEADER Header;
	PHONGTHAN_U32 MapId;
	PHONGTHAN_S32 X;
	PHONGTHAN_S32 Y;
	PHONGTHAN_U16 Mode;
	PHONGTHAN_U16 Reserved;
};

struct PHONGTHAN_ENTITY_MOVE
{
	PHONGTHAN_WIRE_HEADER Header;
	PHONGTHAN_U32 MapId;
	PHONGTHAN_U32 EntityId;
	PHONGTHAN_S32 X;
	PHONGTHAN_S32 Y;
	PHONGTHAN_U16 Mode;
	PHONGTHAN_U16 Reserved;
};

struct PHONGTHAN_ENTITY_REFERENCE
{
	PHONGTHAN_WIRE_HEADER Header;
	PHONGTHAN_U32 MapId;
	PHONGTHAN_U32 EntityId;
};
#pragma pack(pop)

inline int PhongThanWorldPositionValid(PHONGTHAN_S32 x, PHONGTHAN_S32 y)
{
	return x >= 0 && y >= 0 && x <= PHONGTHAN_WORLD_COORDINATE_MAX &&
		y <= PHONGTHAN_WORLD_COORDINATE_MAX;
}

inline int PhongThanWorldFixedPacket(const void* data, PHONGTHAN_U32 size,
	PHONGTHAN_U16 type, PHONGTHAN_U16 flags, PHONGTHAN_U32 expected)
{
	if (!data || size < sizeof(PHONGTHAN_WIRE_HEADER) || size != expected)
		return 0;
	const PHONGTHAN_WIRE_HEADER* header = (const PHONGTHAN_WIRE_HEADER*)data;
	return PhongThanValidateWireHeader(header, size) && header->PacketSize == size &&
		header->MessageType == type && header->Flags == flags;
}

inline int PhongThanValidateMoveRequest(const void* data, PHONGTHAN_U32 size)
{
	if (!PhongThanWorldFixedPacket(data, size, PHONGTHAN_MSG_WORLD_MOVE_REQUEST,
		PHONGTHAN_WIRE_FLAG_REQUEST, sizeof(PHONGTHAN_MOVE_REQUEST)))
		return 0;
	const PHONGTHAN_MOVE_REQUEST* move = (const PHONGTHAN_MOVE_REQUEST*)data;
	return move->MapId > 0 && move->Reserved == 0 &&
		(move->Mode == PHONGTHAN_MOVE_WALK || move->Mode == PHONGTHAN_MOVE_RUN) &&
		PhongThanWorldPositionValid(move->X, move->Y);
}

inline int PhongThanValidateNpcSnapshot(const void* data, PHONGTHAN_U32 size)
{
	if (!PhongThanWorldFixedPacket(data, size, PHONGTHAN_MSG_WORLD_NPC_SNAPSHOT,
		PHONGTHAN_WIRE_FLAG_RESPONSE, sizeof(PHONGTHAN_NPC_SNAPSHOT))) return 0;
	const PHONGTHAN_NPC_SNAPSHOT* npc = (const PHONGTHAN_NPC_SNAPSHOT*)data;
	if (!npc->MapId || !npc->EntityId || npc->TemplateId < -2 || npc->TemplateId > 0x7fff ||
		npc->Action < PHONGTHAN_ACTION_NONE || npc->Action > PHONGTHAN_ACTION_GO_ATTACK ||
		npc->NameLength >= PHONGTHAN_ENTITY_NAME_CAPACITY || npc->Name[npc->NameLength] != 0 ||
		!PhongThanWorldPositionValid(npc->X, npc->Y)) return 0;
	for (PHONGTHAN_U16 i = 0; i < npc->NameLength; ++i)
		if (!npc->Name[i]) return 0;
	return 1;
}

inline int PhongThanValidateNpcUpdate(const void* data, PHONGTHAN_U32 size)
{
	if (!PhongThanWorldFixedPacket(data, size, PHONGTHAN_MSG_WORLD_NPC_UPDATE,
		PHONGTHAN_WIRE_FLAG_RESPONSE, sizeof(PHONGTHAN_NPC_UPDATE))) return 0;
	const PHONGTHAN_NPC_UPDATE* npc = (const PHONGTHAN_NPC_UPDATE*)data;
	return npc->MapId > 0 && npc->EntityId > 0 &&
		npc->Action >= PHONGTHAN_ACTION_NONE && npc->Action <= PHONGTHAN_ACTION_GO_ATTACK &&
		npc->WalkSpeed >= 0 && npc->RunSpeed >= 0 && npc->AttackSpeed >= 0 && npc->CastSpeed >= 0 &&
		PhongThanWorldPositionValid(npc->X, npc->Y);
}

inline int PhongThanWireTextTerminated(const char* text, PHONGTHAN_U32 capacity)
{
	for (PHONGTHAN_U32 i = 0; i < capacity; ++i)
		if (text[i] == 0) return 1;
	return 0;
}

inline int PhongThanVisualPartValid(const PHONGTHAN_VISUAL_PART_WIRE& part)
{
	return part.Visible <= 1 && part.ResourceId >= 0 && part.PaletteId >= 0;
}

inline int PhongThanValidatePlayerSnapshot(const void* data, PHONGTHAN_U32 size)
{
	if (!PhongThanWorldFixedPacket(data, size, PHONGTHAN_MSG_WORLD_PLAYER_SNAPSHOT,
		PHONGTHAN_WIRE_FLAG_RESPONSE, sizeof(PHONGTHAN_PLAYER_SNAPSHOT))) return 0;
	const PHONGTHAN_PLAYER_SNAPSHOT* player = (const PHONGTHAN_PLAYER_SNAPSHOT*)data;
	return player->MapId > 0 && player->EntityId > 0 &&
		player->Profession < PHONGTHAN_PROFESSION_COUNT && player->FullSnapshot <= 1 &&
		player->Mounted <= 1 && player->FightMode <= 1 && player->Sleeping <= 1 &&
		player->ShopOpen <= 1 && player->ProgressPercent <= 100 &&
		PhongThanVisualPartValid(player->Helm) && PhongThanVisualPartValid(player->Armor) &&
		PhongThanVisualPartValid(player->Weapon) && PhongThanVisualPartValid(player->Horse) &&
		PhongThanVisualPartValid(player->PhiPhong) &&
		PhongThanWireTextTerminated(player->TitleName, sizeof(player->TitleName)) &&
		PhongThanWireTextTerminated(player->ClanName, sizeof(player->ClanName)) &&
		PhongThanWireTextTerminated(player->ClanTitle, sizeof(player->ClanTitle)) &&
		PhongThanWireTextTerminated(player->PartnerName, sizeof(player->PartnerName)) &&
		PhongThanWireTextTerminated(player->ShopName, sizeof(player->ShopName));
}

inline int PhongThanValidateMapSnapshot(const void* data, PHONGTHAN_U32 size)
{
	if (!PhongThanWorldFixedPacket(data, size, PHONGTHAN_MSG_WORLD_MAP_SNAPSHOT,
		PHONGTHAN_WIRE_FLAG_RESPONSE, sizeof(PHONGTHAN_MAP_SNAPSHOT))) return 0;
	const PHONGTHAN_MAP_SNAPSHOT* map = (const PHONGTHAN_MAP_SNAPSHOT*)data;
	return map->MapId > 0 && map->Reserved == 0 && map->ClanControlled <= 1 &&
		PhongThanWireTextTerminated(map->ClanName, sizeof(map->ClanName)) &&
		PhongThanWireTextTerminated(map->ControllingClanName, sizeof(map->ControllingClanName));
}

inline int PhongThanValidateSelfSnapshot(const void* data, PHONGTHAN_U32 size)
{
	if (!PhongThanWorldFixedPacket(data, size, PHONGTHAN_MSG_WORLD_SELF_SNAPSHOT,
		PHONGTHAN_WIRE_FLAG_RESPONSE, sizeof(PHONGTHAN_SELF_SNAPSHOT))) return 0;
	const PHONGTHAN_SELF_SNAPSHOT* player = (const PHONGTHAN_SELF_SNAPSHOT*)data;
	return player->MapId > 0 && player->EntityId > 0 && player->Level > 0 &&
		player->Gender < PHONGTHAN_GENDER_COUNT && player->Profession < PHONGTHAN_PROFESSION_COUNT &&
		player->Series < 5 && player->BankPages <= 255 && player->Reserved == 0;
}

inline int PhongThanValidateSelfVitals(const void* data, PHONGTHAN_U32 size)
{
	if (!PhongThanWorldFixedPacket(data, size, PHONGTHAN_MSG_WORLD_SELF_VITALS,
		PHONGTHAN_WIRE_FLAG_RESPONSE, sizeof(PHONGTHAN_SELF_VITALS))) return 0;
	const PHONGTHAN_SELF_VITALS* player = (const PHONGTHAN_SELF_VITALS*)data;
	return player->MapId > 0 && player->EntityId > 0 && player->TeamRole <= 2 &&
		!player->Reserved[0] && !player->Reserved[1] && !player->Reserved[2];
}

inline int PhongThanValidateEntityPosition(const void* data, PHONGTHAN_U32 size)
{
	if (!PhongThanWorldFixedPacket(data, size, PHONGTHAN_MSG_WORLD_ENTITY_POSITION,
		PHONGTHAN_WIRE_FLAG_RESPONSE, sizeof(PHONGTHAN_ENTITY_POSITION))) return 0;
	const PHONGTHAN_ENTITY_POSITION* position = (const PHONGTHAN_ENTITY_POSITION*)data;
	return position->MapId > 0 && position->EntityId > 0 &&
		position->Mode >= PHONGTHAN_POSITION_STAND && position->Mode <= PHONGTHAN_POSITION_TRACK &&
		position->Action >= PHONGTHAN_ACTION_NONE && position->Action <= PHONGTHAN_ACTION_GO_ATTACK &&
		PhongThanWorldPositionValid(position->X, position->Y);
}
inline int PhongThanValidateEntityStatus(const void* data, PHONGTHAN_U32 size)
{
	if (!PhongThanWorldFixedPacket(data, size, PHONGTHAN_MSG_WORLD_ENTITY_STATUS,
		PHONGTHAN_WIRE_FLAG_RESPONSE, sizeof(PHONGTHAN_ENTITY_STATUS))) return 0;
	const PHONGTHAN_ENTITY_STATUS* status = (const PHONGTHAN_ENTITY_STATUS*)data;
	if (status->Kind == PHONGTHAN_STATUS_REVIVE && status->Value > 1) return 0;
	if ((status->Kind == PHONGTHAN_STATUS_BASE_CAMP || status->Kind == PHONGTHAN_STATUS_CURRENT_CAMP) &&
		status->Value >= 9) return 0;
	return status->MapId > 0 && status->EntityId > 0 && !status->Reserved && status->Value >= 0 &&
		status->Kind >= PHONGTHAN_STATUS_SIT && status->Kind <= PHONGTHAN_STATUS_CURRENT_CAMP &&
		PhongThanWorldPositionValid(status->X, status->Y);
}
inline int PhongThanValidatePoseRequest(const void* data, PHONGTHAN_U32 size)
{
	if (!PhongThanWorldFixedPacket(data, size, PHONGTHAN_MSG_WORLD_POSE_REQUEST,
		PHONGTHAN_WIRE_FLAG_REQUEST, sizeof(PHONGTHAN_POSE_REQUEST))) return 0;
	const PHONGTHAN_POSE_REQUEST* pose = (const PHONGTHAN_POSE_REQUEST*)data;
	return pose->MapId > 0 && !pose->Reserved && pose->Kind >= PHONGTHAN_POSE_STAND &&
		pose->Kind <= PHONGTHAN_POSE_REVIVE;
}

inline int PhongThanValidateEntityMove(const void* data, PHONGTHAN_U32 size)
{
	if (!PhongThanWorldFixedPacket(data, size, PHONGTHAN_MSG_WORLD_ENTITY_MOVE,
		PHONGTHAN_WIRE_FLAG_RESPONSE, sizeof(PHONGTHAN_ENTITY_MOVE)))
		return 0;
	const PHONGTHAN_ENTITY_MOVE* move = (const PHONGTHAN_ENTITY_MOVE*)data;
	return move->MapId > 0 && move->EntityId > 0 && move->Reserved == 0 &&
		move->Mode >= PHONGTHAN_MOVE_WALK && move->Mode <= PHONGTHAN_MOVE_JUMP &&
		PhongThanWorldPositionValid(move->X, move->Y);
}

inline int PhongThanValidateEntityReference(const void* data, PHONGTHAN_U32 size,
	PHONGTHAN_U16 type, PHONGTHAN_U16 flags)
{
	if (!PhongThanWorldFixedPacket(data, size, type, flags,
		sizeof(PHONGTHAN_ENTITY_REFERENCE)))
		return 0;
	const PHONGTHAN_ENTITY_REFERENCE* entity = (const PHONGTHAN_ENTITY_REFERENCE*)data;
	return entity->MapId > 0 && entity->EntityId > 0;
}

#endif
