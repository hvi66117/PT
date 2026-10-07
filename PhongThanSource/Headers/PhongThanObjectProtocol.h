#ifndef PHONGTHAN_OBJECT_PROTOCOL_H
#define PHONGTHAN_OBJECT_PROTOCOL_H
#include "PhongThanWorldProtocol.h"
#pragma pack(push, 1)
struct PHONGTHAN_OBJECT_REFERENCE
{
	PHONGTHAN_WIRE_HEADER Header;
	PHONGTHAN_U32 MapId;
	PHONGTHAN_U32 RegionId;
	PHONGTHAN_U32 ObjectId;
};
struct PHONGTHAN_OBJECT_EVENT
{
	PHONGTHAN_WIRE_HEADER Header;
	PHONGTHAN_U32 MapId;
	PHONGTHAN_U32 RegionId;
	PHONGTHAN_U32 ObjectId;
	PHONGTHAN_U32 Value;
};
struct PHONGTHAN_OBJECT_SNAPSHOT
{
	PHONGTHAN_WIRE_HEADER Header;
	PHONGTHAN_U32 MapId;
	PHONGTHAN_U32 RegionId;
	PHONGTHAN_U32 ObjectId;
	PHONGTHAN_U32 TemplateId;
	PHONGTHAN_S32 X;
	PHONGTHAN_S32 Y;
	PHONGTHAN_S32 Money;
	PHONGTHAN_S32 Genre;
	PHONGTHAN_S32 DetailType;
	PHONGTHAN_U16 Frame;
	PHONGTHAN_U16 NameLength;
	PHONGTHAN_U8 State;
	PHONGTHAN_U8 Direction;
	PHONGTHAN_U8 Width;
	PHONGTHAN_U8 Height;
	PHONGTHAN_U8 Color;
	PHONGTHAN_U8 Flags;
	char Name[128];
};
#pragma pack(pop)
inline int PhongThanValidateObjectReference(const void* data, PHONGTHAN_U32 size, PHONGTHAN_U16 type)
{
	if (!PhongThanWorldFixedPacket(data, size, type, PHONGTHAN_WIRE_FLAG_REQUEST,
		sizeof(PHONGTHAN_OBJECT_REFERENCE))) return 0;
	const PHONGTHAN_OBJECT_REFERENCE* object = (const PHONGTHAN_OBJECT_REFERENCE*)data;
	return object->MapId > 0 && object->ObjectId > 0;
}
inline int PhongThanValidateObjectEvent(const void* data, PHONGTHAN_U32 size, PHONGTHAN_U16 type)
{
	if (!PhongThanWorldFixedPacket(data, size, type, PHONGTHAN_WIRE_FLAG_RESPONSE,
		sizeof(PHONGTHAN_OBJECT_EVENT))) return 0;
	const PHONGTHAN_OBJECT_EVENT* object = (const PHONGTHAN_OBJECT_EVENT*)data;
	return object->MapId > 0 && object->ObjectId > 0 &&
		object->Value <= (type == PHONGTHAN_MSG_WORLD_OBJECT_REMOVE ? 1u : 255u);
}
inline int PhongThanValidateObjectSnapshot(const void* data, PHONGTHAN_U32 size)
{
	if (!PhongThanWorldFixedPacket(data, size, PHONGTHAN_MSG_WORLD_OBJECT_SNAPSHOT,
		PHONGTHAN_WIRE_FLAG_RESPONSE, sizeof(PHONGTHAN_OBJECT_SNAPSHOT))) return 0;
	const PHONGTHAN_OBJECT_SNAPSHOT* object = (const PHONGTHAN_OBJECT_SNAPSHOT*)data;
	return object->MapId > 0 && object->ObjectId > 0 && object->NameLength < sizeof(object->Name) &&
		object->Name[object->NameLength] == 0 && PhongThanWorldPositionValid(object->X, object->Y);
}
#endif
