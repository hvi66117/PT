#include "PhongThanStarterBag.h"
void KPlayer::DoScriptAction(KPhongThanScriptAction* action)
{
	if (!action) return;
#ifdef _SERVER
	if (!action->ServerOwned || m_nIndex <= 0 || m_nIndex >= MAX_NPC) return;
	const int world = Npc[m_nIndex].m_SubWorldIndex;
	if (world < 0 || world >= MAX_SUBWORLD) return;
	action->MapId = SubWorld[world].m_SubWorldID;
	if (action->Operation == PHONGTHAN_SCRIPT_CLOSE)
	{
		m_UiDialogToken = 0;
		m_UiDialogView = 0;
		m_bWaitingPlayerFeedBack = false;
		m_nAvailableAnswerNum = 0;
	}
	else if (action->Operation == PHONGTHAN_SCRIPT_SHOW &&
		(action->View == UI_SELECTDIALOG || action->View == UI_TALKDIALOG || action->View == UI_NUMBER_INPUT))
	{
		if (++m_UiDialogSerial == 0) ++m_UiDialogSerial;
		m_UiDialogToken = m_UiDialogSerial;
		m_UiDialogView = PhongThanEncodeScriptView(action->View);
		action->DialogToken = m_UiDialogToken;
	}
	PHONGTHAN_U8 packet[sizeof(PHONGTHAN_UI_ACTION_HEADER) + PHONGTHAN_UI_MAX_KEY + PHONGTHAN_UI_MAX_CONTENT];
	const unsigned int size = PhongThanBuildScriptPacket(*action, packet, sizeof(packet));
	HRESULT publishResult = E_FAIL;
	if (size && g_pServer)
		// A dialog is a targeted response. Keep its native frame independent
		// of legacy aggregate messages whose unknown length stops client parsing.
		publishResult = g_pServer->SendData(m_nNetConnectIdx, packet, size);
	FILE* dialogLog = fopen("ui_action_diag.log", "a");
	if (dialogLog)
	{
		fprintf(dialogLog, "server tick=%lu player=%d map=%u token=%u op=%d view=%d options=%d content=%d size=%u hr=%08X\n",
			(unsigned long)GetTickCount(), m_nPlayerIndex, action->MapId, action->DialogToken,
			action->Operation, action->View, action->OptionCount, action->ContentLength,
			size, (unsigned int)publishResult);
		fclose(dialogLog);
	}
	g_DebugLog("[PhongThanUI] server publish player=%d conn=%d map=%u token=%u op=%d view=%d options=%d content=%d size=%u hr=0x%08X",
		m_nPlayerIndex, m_nNetConnectIdx, action->MapId, action->DialogToken,
		action->Operation, action->View, action->OptionCount,
		action->ContentLength, size, (unsigned int)publishResult);
	if (!size || !g_pServer || FAILED(publishResult))
	{
		if (action->DialogToken && action->DialogToken == m_UiDialogToken)
		{
			m_UiDialogToken = 0;
			m_bWaitingPlayerFeedBack = false;
			m_nAvailableAnswerNum = 0;
		}
		g_DebugLog("[PhongThanUI] Cannot publish script action");
	}
#else
	if (!action->ServerOwned) OnScriptAction(action);
#endif
}

void KPlayer::ExecuteUiSelection(int selection, int view)
{
	if (selection == -1)
	{
		m_nAvailableAnswerNum = 0;
		m_bWaitingPlayerFeedBack = false;
		m_UiDialogToken = 0;
		return;
	}
	if (selection < 0 || selection >= m_nAvailableAnswerNum || selection >= MAX_ANSWERNUM ||
		m_nIndex <= 0 || m_nIndex >= MAX_NPC || (view != SELECT_TALKUI && view != SELECT_SELECTUI)) return;
	char callback[sizeof(m_szTaskAnswerFun[0])];
	g_StrCpyLen(callback, m_szTaskAnswerFun[view == SELECT_TALKUI ? 0 : selection], sizeof(callback));
	const DWORD scriptId = view == SELECT_TALKUI ? m_TalkUiScriptId : m_SelUiScriptId;
	// Consume before Lua: a new prompt created by the callback remains valid.
	m_bWaitingPlayerFeedBack = false;
	m_nAvailableAnswerNum = 0;
	m_UiDialogToken = 0;
#ifdef _SERVER
	if (PhongThanStarterBagChoice(*this, callback)) return;
#endif
	if (callback[0]) ExecuteScript(scriptId, callback, selection);
}

void KPlayer::ProcessPlayerSelectFromUI(BYTE* data)
{
#ifdef _SERVER
	const PHONGTHAN_UI_CHOICE_REQUEST* choice = (const PHONGTHAN_UI_CHOICE_REQUEST*)data;
	if (m_nIndex <= 0 || m_nIndex >= MAX_NPC) return;
	const int world = Npc[m_nIndex].m_SubWorldIndex;
	if (world < 0 || world >= MAX_SUBWORLD || !PhongThanUiChoiceMatches(*choice,
		SubWorld[world].m_SubWorldID, m_UiDialogToken, m_UiDialogView, m_nAvailableAnswerNum)) return;
	ExecuteUiSelection(choice->Selection, choice->View == PHONGTHAN_VIEW_CONVERSATION ? SELECT_TALKUI : SELECT_SELECTUI);
#else
	(void)data;
#endif
}

#ifndef _SERVER
void KPlayer::OnSelectFromUI(KPhongThanUiSelection* selection, UIInfo view)
{
	if (!selection || (view != UI_TALKDIALOG && view != UI_SELECTDIALOG)) return;
	const bool server = view == UI_TALKDIALOG ? g_bUISpeakActiveWithServer != 0 : g_bUISelIntelActiveWithServer != 0;
	if (!server)
	{
		ExecuteUiSelection(selection->Selection, selection->View);
		return;
	}
	PHONGTHAN_UI_CHOICE_REQUEST request;
	ZeroMemory(&request, sizeof(request));
	PhongThanInitializeWireHeader(&request.Header, PHONGTHAN_MSG_UI_CHOICE_REQUEST,
		sizeof(request), PHONGTHAN_WIRE_FLAG_REQUEST, 0);
	request.MapId = SubWorld[0].m_SubWorldID;
	request.DialogToken = m_UiDialogToken;
	request.View = PhongThanEncodeScriptView(view);
	request.Selection = selection->Selection;
	if (g_pClient && PhongThanValidateUiChoice(&request, sizeof(request)))
		g_pClient->SendPackToServer(&request, sizeof(request));
}
#else
void KPlayer::S2CExecuteScript(char* scriptName, char* parameters)
{
	if (!scriptName || !scriptName[0]) return;
	KPhongThanScriptAction action;
	ZeroMemory(&action, sizeof(action));
	action.Operation = PHONGTHAN_SCRIPT_EXECUTE;
	action.ServerOwned = 1;
	const unsigned int scriptLength = strlen(scriptName);
	const unsigned int parameterLength = parameters ? strlen(parameters) : 0;
	if (scriptLength + parameterLength + 2 >= sizeof(action.Content)) return;
	strcpy(action.Content, scriptName);
	if (parameterLength) { strcat(action.Content, "|"); strcat(action.Content, parameters); }
	action.ContentLength = strlen(action.Content);
	DoScriptAction(&action);
}
#endif
