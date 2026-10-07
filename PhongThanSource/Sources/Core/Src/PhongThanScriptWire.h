#ifndef PHONGTHAN_SCRIPT_WIRE_H
#define PHONGTHAN_SCRIPT_WIRE_H
#include "PhongThanScriptAction.h"
#include <string.h>

// The local UI enum is explicitly mapped to independent wire values.
inline PHONGTHAN_U16 PhongThanEncodeScriptView(int view)
{
	switch (view)
	{
	case UI_SELECTDIALOG: return PHONGTHAN_VIEW_QUESTION;
	case UI_SELDIALOG: return PHONGTHAN_VIEW_SELECTION;
	case UI_TALKDIALOG: return PHONGTHAN_VIEW_CONVERSATION;
	case UI_NOTEINFO: return PHONGTHAN_VIEW_NOTE;
	case UI_MSGINFO: return PHONGTHAN_VIEW_MESSAGE;
	case UI_NEWSINFO: return PHONGTHAN_VIEW_NEWS;
	case UI_NEWSINFO1: return PHONGTHAN_VIEW_NEWS_DETAIL;
	case UI_PLAYMUSIC: return PHONGTHAN_VIEW_MUSIC;
	case UI_OPENTONGUI: return PHONGTHAN_VIEW_CLAN;
	case UI_TOPMESSAGE: return PHONGTHAN_VIEW_TOP_MESSAGE;
	case UI_SCROLLMESSAGE: return PHONGTHAN_VIEW_SCROLL_MESSAGE;
	case UI_NUMBER_INPUT: return PHONGTHAN_VIEW_NUMBER_INPUT;
	default: return 0;
	}
}
inline int PhongThanDecodeScriptView(PHONGTHAN_U16 view)
{
	switch (view)
	{
	case PHONGTHAN_VIEW_QUESTION: return UI_SELECTDIALOG;
	case PHONGTHAN_VIEW_SELECTION: return UI_SELDIALOG;
	case PHONGTHAN_VIEW_CONVERSATION: return UI_TALKDIALOG;
	case PHONGTHAN_VIEW_NOTE: return UI_NOTEINFO;
	case PHONGTHAN_VIEW_MESSAGE: return UI_MSGINFO;
	case PHONGTHAN_VIEW_NEWS: return UI_NEWSINFO;
	case PHONGTHAN_VIEW_NEWS_DETAIL: return UI_NEWSINFO1;
	case PHONGTHAN_VIEW_MUSIC: return UI_PLAYMUSIC;
	case PHONGTHAN_VIEW_CLAN: return UI_OPENTONGUI;
	case PHONGTHAN_VIEW_TOP_MESSAGE: return UI_TOPMESSAGE;
	case PHONGTHAN_VIEW_SCROLL_MESSAGE: return UI_SCROLLMESSAGE;
	case PHONGTHAN_VIEW_NUMBER_INPUT: return UI_NUMBER_INPUT;
	default: return -1;
	}
}
inline unsigned int PhongThanBuildScriptPacket(const KPhongThanScriptAction& action,
	void* output, unsigned int capacity)
{
	if (!output || action.ContentLength < 0 || action.ContentLength >= PHONGTHAN_UI_MAX_CONTENT ||
		action.OptionCount < 0 || action.OptionCount > 255) return 0;
	unsigned int keyLength = 0;
	while (keyLength < PHONGTHAN_UI_MAX_KEY && action.Key[keyLength]) ++keyLength;
	if (keyLength >= PHONGTHAN_UI_MAX_KEY) return 0;
	const unsigned int size = sizeof(PHONGTHAN_UI_ACTION_HEADER) + keyLength + action.ContentLength;
	if (size > capacity) return 0;
	PHONGTHAN_UI_ACTION_HEADER* wire = (PHONGTHAN_UI_ACTION_HEADER*)output;
	memset(wire, 0, sizeof(*wire));
	PhongThanInitializeWireHeader(&wire->Header, PHONGTHAN_MSG_UI_SCRIPT_ACTION,
		size, PHONGTHAN_WIRE_FLAG_RESPONSE, 0);
	wire->MapId = action.MapId;
	wire->DialogToken = action.DialogToken;
	wire->Operation = action.Operation;
	wire->View = PhongThanEncodeScriptView(action.View);
	wire->OptionCount = action.OptionCount;
	wire->ResourceText = action.ResourceText ? 1 : 0;
	wire->BooleanArgument = action.BooleanArgument ? 1 : 0;
	wire->ServerOwned = 1;
	wire->NumberArgument = action.NumberArgument;
	wire->AuxiliaryArgument = action.AuxiliaryArgument;
	wire->KeySize = keyLength;
	wire->ContentSize = action.ContentLength;
	memcpy(wire + 1, action.Key, keyLength);
	memcpy((unsigned char*)(wire + 1) + keyLength, action.Content, action.ContentLength);
	return PhongThanValidateUiAction(output, size) ? size : 0;
}
inline int PhongThanReadScriptPacket(const void* input, unsigned int size,
	KPhongThanScriptAction* action)
{
	if (!action || !PhongThanValidateUiAction(input, size)) return 0;
	const PHONGTHAN_UI_ACTION_HEADER* wire = (const PHONGTHAN_UI_ACTION_HEADER*)input;
	memset(action, 0, sizeof(*action));
	action->MapId = wire->MapId;
	action->DialogToken = wire->DialogToken;
	action->Operation = wire->Operation;
	action->View = PhongThanDecodeScriptView(wire->View);
	action->OptionCount = wire->OptionCount;
	action->ResourceText = wire->ResourceText;
	action->ServerOwned = 1;
	action->BooleanArgument = wire->BooleanArgument;
	action->NumberArgument = wire->NumberArgument;
	action->AuxiliaryArgument = wire->AuxiliaryArgument;
	action->ContentLength = wire->ContentSize;
	memcpy(action->Key, wire + 1, wire->KeySize);
	memcpy(action->Content, (const unsigned char*)(wire + 1) + wire->KeySize, wire->ContentSize);
	return 1;
}
#endif
