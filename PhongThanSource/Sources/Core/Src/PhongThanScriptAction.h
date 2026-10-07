#ifndef PHONGTHAN_SCRIPT_ACTION_H
#define PHONGTHAN_SCRIPT_ACTION_H
#include "PhongThanUiProtocol.h"

// Internal rendering choices; PhongThanScriptWire maps them explicitly.
enum UIInfo
{
	UI_SELECTDIALOG, UI_SELDIALOG, UI_TALKDIALOG, UI_NOTEINFO, UI_MSGINFO,
	UI_NEWSINFO, UI_NEWSINFO1, UI_PLAYMUSIC, UI_OPENTONGUI,
	UI_TOPMESSAGE, UI_SCROLLMESSAGE, UI_NUMBER_INPUT
};

// Local rendering command, not a network packet. Scalars/strings are serialized
// explicitly by PhongThanScriptWire.h. Local Lua uses the same rendering model.
struct KPhongThanScriptAction
{
	int Operation;
	int View;
	int OptionCount;
	int ResourceText;
	int ServerOwned;
	int BooleanArgument;
	int NumberArgument;
	int AuxiliaryArgument;
	int ContentLength;
	PHONGTHAN_U32 MapId;
	PHONGTHAN_U32 DialogToken;
	char Key[PHONGTHAN_UI_MAX_KEY];
	char Content[PHONGTHAN_UI_MAX_CONTENT];
};
struct KPhongThanUiSelection
{
	int Selection;
	int View;
};
#endif
