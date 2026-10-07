#ifndef PHONGTHAN_UI_PROTOCOL_H
#define PHONGTHAN_UI_PROTOCOL_H
#include "PhongThanWorldProtocol.h"
enum PHONGTHAN_SCRIPT_OPERATION
{
	PHONGTHAN_SCRIPT_SHOW = 100,
	PHONGTHAN_SCRIPT_EXECUTE = 101,
	PHONGTHAN_SCRIPT_CLOSE = 102
};
enum PHONGTHAN_SCRIPT_VIEW
{
	PHONGTHAN_VIEW_QUESTION = 200,
	PHONGTHAN_VIEW_SELECTION = 201,
	PHONGTHAN_VIEW_CONVERSATION = 202,
	PHONGTHAN_VIEW_NOTE = 203,
	PHONGTHAN_VIEW_MESSAGE = 204,
	PHONGTHAN_VIEW_NEWS = 205,
	PHONGTHAN_VIEW_NEWS_DETAIL = 206,
	PHONGTHAN_VIEW_MUSIC = 207,
	PHONGTHAN_VIEW_CLAN = 208,
	PHONGTHAN_VIEW_TOP_MESSAGE = 209,
	PHONGTHAN_VIEW_SCROLL_MESSAGE = 210,
	PHONGTHAN_VIEW_NUMBER_INPUT = 211
};
enum PHONGTHAN_UI_LIMIT
{
	PHONGTHAN_UI_MAX_CONTENT = 4096,
	PHONGTHAN_UI_MAX_KEY = 260,
	PHONGTHAN_UI_MAX_ANSWERS = 20
};
#pragma pack(push, 1)
// Key bytes and counted content bytes follow. No pointers/runtime UI object.
struct PHONGTHAN_UI_ACTION_HEADER
{
	PHONGTHAN_WIRE_HEADER Header;
	PHONGTHAN_U32 MapId;
	PHONGTHAN_U32 DialogToken;
	PHONGTHAN_U16 Operation;
	PHONGTHAN_U16 View;
	PHONGTHAN_S32 NumberArgument;
	PHONGTHAN_S32 AuxiliaryArgument;
	PHONGTHAN_U16 KeySize;
	PHONGTHAN_U16 ContentSize;
	PHONGTHAN_U8 OptionCount;
	PHONGTHAN_U8 ResourceText;
	PHONGTHAN_U8 BooleanArgument;
	PHONGTHAN_U8 ServerOwned;
};
struct PHONGTHAN_UI_CHOICE_REQUEST
{
	PHONGTHAN_WIRE_HEADER Header;
	PHONGTHAN_U32 MapId;
	PHONGTHAN_U32 DialogToken;
	PHONGTHAN_S32 Selection; // -1 cancels; all other negative indexes rejected.
	PHONGTHAN_U16 View;
	PHONGTHAN_U16 Reserved;
};
#pragma pack(pop)

enum { PHONGTHAN_MSG_UI_NUMBER_INPUT = 0x5103 };
#pragma pack(push, 1)
struct PHONGTHAN_UI_NUMBER_REQUEST
{
	PHONGTHAN_WIRE_HEADER Header;
	PHONGTHAN_U32 MapId, DialogToken;
	PHONGTHAN_S32 Value; // -1 cancels, otherwise unsigned decimal input.
};
#pragma pack(pop)
inline int PhongThanValidateNumberRequest(const void* data, PHONGTHAN_U32 size)
{
	if (!PhongThanWorldFixedPacket(data, size, PHONGTHAN_MSG_UI_NUMBER_INPUT,
		PHONGTHAN_WIRE_FLAG_REQUEST, sizeof(PHONGTHAN_UI_NUMBER_REQUEST))) return 0;
	const PHONGTHAN_UI_NUMBER_REQUEST* r = (const PHONGTHAN_UI_NUMBER_REQUEST*)data;
	return r->MapId > 0 && r->DialogToken > 0 && r->Value >= -1 && r->Value <= 999999;
}

inline int PhongThanValidateUiAction(const void* data, PHONGTHAN_U32 size)
{
	if (!data || size < sizeof(PHONGTHAN_UI_ACTION_HEADER)) return 0;
	const PHONGTHAN_UI_ACTION_HEADER* ui = (const PHONGTHAN_UI_ACTION_HEADER*)data;
	if (ui->KeySize >= PHONGTHAN_UI_MAX_KEY || ui->ContentSize >= PHONGTHAN_UI_MAX_CONTENT ||
		ui->ResourceText > 1 || ui->BooleanArgument > 1 || ui->ServerOwned != 1 ||
		ui->Operation < PHONGTHAN_SCRIPT_SHOW || ui->Operation > PHONGTHAN_SCRIPT_CLOSE ||
		!PhongThanWorldFixedPacket(data, size, PHONGTHAN_MSG_UI_SCRIPT_ACTION,
			PHONGTHAN_WIRE_FLAG_RESPONSE, sizeof(*ui) + ui->KeySize + ui->ContentSize)) return 0;
	if (ui->Operation == PHONGTHAN_SCRIPT_SHOW)
	{
		if (ui->View < PHONGTHAN_VIEW_QUESTION || ui->View > PHONGTHAN_VIEW_NUMBER_INPUT) return 0;
		if (ui->View == PHONGTHAN_VIEW_NUMBER_INPUT && (!ui->MapId || !ui->DialogToken || ui->OptionCount != 0)) return 0;
		if (ui->View == PHONGTHAN_VIEW_QUESTION || ui->View == PHONGTHAN_VIEW_CONVERSATION)
			if (!ui->MapId || !ui->DialogToken || ui->OptionCount > PHONGTHAN_UI_MAX_ANSWERS) return 0;
	}
	return 1;
}

inline int PhongThanValidateUiChoice(const void* data, PHONGTHAN_U32 size)
{
	if (!PhongThanWorldFixedPacket(data, size, PHONGTHAN_MSG_UI_CHOICE_REQUEST,
		PHONGTHAN_WIRE_FLAG_REQUEST, sizeof(PHONGTHAN_UI_CHOICE_REQUEST))) return 0;
	const PHONGTHAN_UI_CHOICE_REQUEST* choice = (const PHONGTHAN_UI_CHOICE_REQUEST*)data;
	return choice->MapId > 0 && choice->DialogToken > 0 && choice->Reserved == 0 &&
		choice->Selection >= -1 && choice->Selection < PHONGTHAN_UI_MAX_ANSWERS &&
		(choice->View == PHONGTHAN_VIEW_QUESTION || choice->View == PHONGTHAN_VIEW_CONVERSATION);
}

inline int PhongThanUiChoiceMatches(const PHONGTHAN_UI_CHOICE_REQUEST& choice,
	PHONGTHAN_U32 map, PHONGTHAN_U32 token, PHONGTHAN_U16 view, int answerCount)
{
	return token != 0 && choice.MapId == map && choice.DialogToken == token && choice.View == view &&
		choice.Selection >= -1 && (choice.Selection == -1 ||
			(choice.Selection < answerCount && choice.Selection < PHONGTHAN_UI_MAX_ANSWERS));
}
#endif
