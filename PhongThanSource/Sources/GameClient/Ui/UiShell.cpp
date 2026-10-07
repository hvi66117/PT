/*****************************************************************************************
//	����Ӧ�ý��洰�ڵĹ����ӿ�
//	Copyright : Kingsoft 2002
//	Author	:   Wooy(Wu yue)
//	CreateTime:	2002-7-17
*****************************************************************************************/
#include "KWin32.h"
#include "KIniFile.h"
#include "Elem/Wnds.h"
#include "Elem/UiImage.h"
#include "UiShell.h"
#include "UiBase.h"
//#include "../../../core/src/gamedatadef.h"
#include "../../Core/Src/CoreShell.h"

#include "UiCase/UiInit.h"
#include "UiCase/UiConnectInfo.h"
#include "UiCase/UiInformation.h"
#include "UiCase/UiInformation1.h"
#include "UiCase/UiInformation2.h"
#include "UiCase/UiPlayerBar.h"
#include "UiCase/UiStatus.h"
#include "UiCase/UiParadeItem.h"
#include "UiCase/UiItem.h"
#include "UiCase/UiExpandItem.h"
#include "UiCase/UiSkills.h"
#include "UiCase/UiSkillTree.h"
#include "UiCase/UiEscDlg.h"
#include "UiCase/UiGame.h"
#include "UiCase/UiOptions.h"
#include "UiCase/UiMsgCentrePad.h"
#include "UiCase/UiLoginBg.h"
#include "UiCase/UiLogin.h"
#include "UiCase/UiSelPlayer.h"
#include "UiCase/UiSelServer.h"
#include "UiCase/UiNewPlayer.h"
#include "UiCase/UiSelNativePlace.h"
#include "UiCase/UiChatCentre.h"
#include "UiCase/UiChatRoom.h"
#include "UiCase/UiSysMsgCentre.h"
#include "UiCase/UiHeaderControlBar.h"
#include "UiCase/UiToolsControlBar.h"
#include "UiCase/UiStoreBox.h"
#include "UiCase/UiChannelSubscibe.h"
#include "UiCase/UiSelPlayerNearby.h"
#include "UiCase/UiMsgSel.h"
#include "UiCase/UiTeamManage.h"
#include "UiCase/UiShop.h"
#include "UiCase/UiSuperShop.h"
#include "UiCase/UiMiniMap.h"
#include "UiCase/UiTrade.h"
#include "UiCase/UiTradeConfirmWnd.h"
#include "UiCase/UiNewsMessage.h"
#include "UiCase/UiNewsMessage2.h"
#include "UiCase/UiNewsSysMsg.h"
#include "UiCase/UiExpandItem.h"
#include "UiCase/UiChooseFace.h"
#include "ShortcutKey.h"
#include "UiSoundSetting.h"
#include "../../Represent/iRepresent/iRepresentShell.h"
#include "../NetConnect/NetConnectAgent.h"
#include "../Login/Login.h"
#include "UiCase/UiNewPlayerStartMsg.h"
#include "UiCase/UiHelper.h"
#include "UiCase/UiHelper2.h"
#include "UiCase/UiTaskNote.h"
#include "UiCase/UiTaskTrace.h"
#include "UiCase/UiPartyPanel.h"   // 2026-10-03 partypanel
#include "UiCase/UiReconnect.h"
#include "UiCase/UiFaceSelector.h"
#include "UiCase/UiStrengthRank.h"
#include "UiCase/UiTongManager.h"
#include "UiCase/UiTongCreateSheet.h"
#include "UiCase/UiChatItem.h"
#include "UiCase/UiRankData.h"
#include "UiCase/UiEnchase.h"
#include "UiCase/UiGive.h"
#include "UiCase/UiAutoPlay.h"
#include "UiCase/UiPlayerControlBar.h"
#include "UiChatPhrase.h"
#include "UiCase/UiPlayerLock.h"
#include "UiCase/UiTimeOnline.h"

extern iCoreShell *g_pCoreShell;
extern iRepresentShell *g_pRepresentShell;
extern KUiChatPhrase g_UiChatPhrase;

enum UI_LIVING_STATUS {
    UI_LIVING_S_DEAD,            //���˳�������
    UI_LIVING_S_OUTGAME,        //������Ϸ������
    UI_LIVING_S_INGAME,            //��Ϸ������
};

static UI_LIVING_STATUS s_UiLiveSeed = UI_LIVING_S_DEAD;

int g_bDisconnect = false;

#include "KTimer.h"

static KTimer s_Timer;
static int s_nFrameRate = 30;

#include <shlwapi.h>
char			s_VersionInfo[60];

#ifdef PHONGTHAN_SHOW_DEBUG_INFO

int				g_nShowDebugInfo = true;
#else
int				g_nShowDebugInfo = false;
#endif



//�Ƿ�̬����Represent���ӿ�
#define DYNAMIC_LINK_REPRESENT_LIBRARY

#ifdef DYNAMIC_LINK_REPRESENT_LIBRARY
extern int g_bRepresent3;
#endif

void UiCloseWndsOutGame(bool bAll);

bool UiCloseWndsInGame(bool bAll);

bool GetFileTimeVersionString(const char* pszFile, char* pszVersionString, int nSize)
{
    if (pszVersionString)
        pszVersionString[0] = 0;
    //---���ļ�----
    HANDLE	hFile = CreateFile(pszFile, GENERIC_READ, 0, NULL,
                                 OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
    if (hFile == INVALID_HANDLE_VALUE)
        return false;

    FILETIME	time, FileTime;
    SYSTEMTIME	SysTime;
    if (::GetFileTime(hFile, NULL, NULL, &time) == FALSE)
    {
        CloseHandle(hFile);
        return false;
    }
    CloseHandle(hFile);
    hFile = NULL;
    FileTimeToLocalFileTime(&time, &FileTime);
    FileTimeToSystemTime(&FileTime, &SysTime);
    int nLen = GetDateFormat(LOCALE_USER_DEFAULT, 0, &SysTime, "M-d ", pszVersionString, nSize);
    if (nLen)
        nLen --;
    GetTimeFormat(LOCALE_USER_DEFAULT, 0, &SysTime, "H:mm", &pszVersionString[nLen], nSize - nLen);
    return true;
}

//--------------------------------------------------------------------------
//	���ܣ������Ƴ���Ϣ
//--------------------------------------------------------------------------
void UiPostQuitMsg() {
    if (g_UiBase.SavePrivateConfig())
        s_UiLiveSeed = UI_LIVING_S_DEAD;
}

//�Ƿ��Ѿ�ѡ���˳�����
bool UiIsAlreadyQuit() {
    return (s_UiLiveSeed == UI_LIVING_S_DEAD);
}

//--------------------------------------------------------------------------
//	���ܣ�����ϵͳ��ʼ��
//--------------------------------------------------------------------------
int UiInit() {
    Player_Life::RegisterSelfClass();
    Player_Mana::RegisterSelfClass();
    Player_Stamina::RegisterSelfClass();
    Player_Exp::RegisterSelfClass();
    Player_Level::RegisterSelfClass();
    Player_Name::RegisterSelfClass();    Player_SectSort::RegisterSelfClass();
    Player_WorldSort::RegisterSelfClass();
    Player_Status::RegisterSelfClass();
    Player_Items::RegisterSelfClass();
    Player_ItemEx::RegisterSelfClass();
    Player_Skills::RegisterSelfClass();
    Player_Friend::RegisterSelfClass();
    Player_FSBook::RegisterSelfClass();
    Player_Help::RegisterSelfClass();
    Player_IBShop::RegisterSelfClass();
    Player_Topten::RegisterSelfClass();
    Player_HidePeople::RegisterSelfClass();
    Player_Communication::RegisterSelfClass();
    Player_TextAnnounce::RegisterSelfClass();
    Player_Quest::RegisterSelfClass();
    Player_System::RegisterSelfClass();
    Player_Lvskill::RegisterSelfClass();
    Player_DivineInfusion::RegisterSelfClass();
    Player_PKTimer::RegisterSelfClass();
    Player_Team::RegisterSelfClass();
    Player_Sit::RegisterSelfClass();
    Player_Run::RegisterSelfClass();
    Player_Horse::RegisterSelfClass();
    Player_Exchange::RegisterSelfClass();
    Player_PK::RegisterSelfClass();
    Player_Faction::RegisterSelfClass();
    Player_ChatRoom::RegisterSelfClass();
    Player_Recorder::RegisterSelfClass();
    Player_Auto::RegisterSelfClass();

//	KWndEdit::Initialize(hInstance);

    Wnd_ShowCursor(false);
    if (g_UiBase.Init() == false)
        return false;
    IR_UpdateTime();
    g_UiInformation.Initialize();
    g_UiInformation1.Initialize();
    g_UiInformation2.Initialize();
    KUiLoginBackGround::OpenWindow("Init");
    Wnd_SetGameSpaceWnd(&g_WndGameSpace);

    UiSoundLoadSetting();

    KUiFaceSelector::LoadFaceList();
    KShortcutKeyCentre::InitScript();    //Ҫ�ŵ�KUiFaceSelector֮��

	char	szFile[MAX_PATH];
	GetModuleFileName(NULL, szFile, MAX_PATH);
	strcpy(s_VersionInfo, PathFindFileName(szFile));
	PathRemoveExtension(s_VersionInfo);
	strcat(s_VersionInfo, ":");
	int nLen = strlen(s_VersionInfo);
	GetFileTimeVersionString(szFile, &s_VersionInfo[nLen], sizeof(s_VersionInfo) - nLen);
	PathRemoveFileSpec(szFile);
	strcat(szFile, "\\CoreClient.dll");
	strcat(s_VersionInfo, " CoreClient:");
	nLen = strlen(s_VersionInfo);
	GetFileTimeVersionString(szFile, &s_VersionInfo[nLen], sizeof(s_VersionInfo) - nLen);

    g_UiChatPhrase.LoadEntireEmote();

    g_UiBase.NotifyEvent(APP_START);

    return true;
}

//--------------------------------------------------------------------------
//	���ܣ�����ϵͳ�˳�
//--------------------------------------------------------------------------
void UiExit() {
    if (s_UiLiveSeed == UI_LIVING_S_INGAME) {
        g_UiBase.SavePrivateConfig();
    }
    KReconnectWnd::Exit(false);

    KUiInit::StopTitleMusic();

    //���ֽ���ɾ���Լ�����ʱ�ļ�
    KUiStrengthRank::RemoveTempFile();
    KUiTongManager::RemoveTempFile();
    //ɾ�����

    UiCloseWndsInGame(true);
    UiCloseWndsOutGame(true);

    Wnd_SetGameSpaceWnd(NULL);
    g_LoginLogic.ReturnToIdle();
    g_LoginLogic.SaveLoginChoice();
    g_UiBase.Exit();
    KShortcutKeyCentre::UninitScript();//Ҫ��g_UiBase.Exit();����ΪҪ����
    s_UiLiveSeed = UI_LIVING_S_DEAD;
    KUiFaceSelector::Clear();
    Wnd_Cleanup();

    g_UiBase.NotifyEvent(APP_EXIT);
    g_UiBase.CleanTempDataFolder();
}

//--------------------------------------------------------------------------
//	���ܣ��_ʼ�����������
//--------------------------------------------------------------------------
int UiStart() {
    s_UiLiveSeed = UI_LIVING_S_OUTGAME;
    Wnd_ShowCursor(true);
    Wnd_SwitchCursor(CURSOR_NORMAL);
    return KUiSelServer::ConnectDefaultServer();
}

//--------------------------------------------------------------------------
//	���ܣ����ƽ���
//--------------------------------------------------------------------------
void UiPaint(int nGameLoop)
{
    if (g_pRepresentShell == NULL ||
        g_pRepresentShell->RepresentBegin(false, 0) == false)
    {
        if (g_pCoreShell)
            g_pCoreShell->SetRepresentShell(g_pRepresentShell);
        return;
    }
//	Wnd_Cleanup();
    Wnd_RenderWindows();


    DWORD	dwPing = 0;
	char	Info[128];
	s_Timer.GetFPS(&s_nFrameRate);
	if (g_pCoreShell)
		dwPing = g_pCoreShell->GetPing();

    sprintf(Info,"FPS=%d LOOP=%d PING=%d", s_nFrameRate, nGameLoop, dwPing);
	g_pRepresentShell->OutputText(12, Info, -1, 10, 20, 0xffffffff, 0);

	//g_pRepresentShell->OutputText(12, s_VersionInfo, -1, 2, 510, 0xffffffff, 0);
		
	// int nWidth, nHeight;
	// Wnd_GetScreenSize(nWidth, nHeight);
	// g_pRepresentShell->OutputText(12, g_bRepresent3 ? "Represent3" : "Represent2",
	// 			-1, nWidth - 100, 10, 0xffffffff, 0);
		


#ifdef PHONGTHAN_SHOW_DEBUG_INFO
    if (g_nShowDebugInfo)
	{
		sprintf(Info,"FPS=%d LOOP=%d PING=%d", s_nFrameRate, nGameLoop, dwPing);
		g_pRepresentShell->OutputText(12, Info, -1, 10, 20, 0xffffffff, 0);

		g_pRepresentShell->OutputText(12, s_VersionInfo, -1, 2, 510, 0xffffffff, 0);

		#ifdef DYNAMIC_LINK_REPRESENT_LIBRARY
		{
			int nWidth, nHeight;
			Wnd_GetScreenSize(nWidth, nHeight);
			g_pRepresentShell->OutputText(12, g_bRepresent3 ? "Represent3" : "Represent2",
				-1, nWidth - 100, 10, 0xffffffff, 0);
		}
		#endif
	}
#endif

    g_pRepresentShell->RepresentEnd();
}

//--------------------------------------------------------------------------
//	���ܣ�����
//--------------------------------------------------------------------------
int UiHeartBeat() {
    if (s_UiLiveSeed != UI_LIVING_S_DEAD) {
        // Some legacy CoreClient builds do not deliver GDCNI_GAME_START
        // after the initial sync.  Once the login state has remained in the
        // entering-game phase for a few heartbeats, complete the UI handoff
        // locally; the core data and world are already being processed.
        static int s_EnteringGameFrames = 0;
        if (g_LoginLogic.GetStatus() == LL_S_ENTERING_GAME) {
            if (++s_EnteringGameFrames >= 180) {
                s_EnteringGameFrames = 0;
                g_LoginLogic.NotifyToStartGame();
            }
        } else {
            s_EnteringGameFrames = 0;
        }
        if (g_bDisconnect == false) {
            IR_UpdateTime();
            Wnd_Heartbeat();
        } else {
            if (s_UiLiveSeed == UI_LIVING_S_INGAME &&
                !KReconnectWnd::IsReconnecttingGoingOn()) {
                g_UiBase.SavePrivateConfig();
                g_pCoreShell->OperationRequest(GOI_GAMESPACE_DISCONNECTED, 0, 0);
                UiCloseWndsInGame(false);
                KReconnectWnd::LaunchReconnect();
            } else {
                g_LoginLogic.NotifyDisconnect();
            }
            g_bDisconnect = false;
        }
        return true;
    }
    return false;
}

//--------------------------------------------------------------------------
//	���ܣ���������
//--------------------------------------------------------------------------
void UiProcessInput(unsigned int uMsg, unsigned int uParam, int nParam) {
    if (uMsg == WM_COPYDATA) {
        if (nParam) {
            COPYDATASTRUCT *pData = (COPYDATASTRUCT *) nParam;
            if (pData && pData->cbData > 0 && pData->lpData && ((char *) pData->lpData)[pData->cbData - 1] ==
                                                               0) {    //������,�������ݳ��Ȳ�����0, ������������0��β���ַ���
                KShortcutKeyCentre::ExcuteHWNDScript((const char *) pData->lpData);
            }
        }
    } else if (uMsg != WM_ACTIVATEAPP)
        Wnd_ProcessInput(uMsg, uParam, nParam);
    else if (uParam) {
        Wnd_RestoreCursor();
        KUiOptions::LoadSetting(false, true);
    }
}

void UiCloseWndsOutGame(bool bAll) {
    KUiLogin::CloseWindow(true);
    KUiSelServer::CloseWindow(true);
    KUiOptions::CloseWindow();
    KUiInit::CloseWindow();
    KUiSelPlayer::CloseWindow();
    KUiNewPlayer::CloseWindow(true);
    KUiSelNativePlace::CloseWindow(true);
    KUiConnectInfo::CloseWindow(true);
    g_UiInformation.Close();
    g_UiInformation1.Close();
    g_UiInformation2.Close();
    if (bAll)
        KUiLoginBackGround::CloseWindow(true);
}

//--------------------------------------------------------------------------
//	���ܣ�������Ϸ����ʱ
//--------------------------------------------------------------------------
void UiStartGame() {
    UiOnGameServerConnected();

    g_UiBase.CleanTempDataFolder();

    KUiInit::StopTitleMusic();

    UiCloseWndsOutGame(true);
    KUiLoginBackGround::CloseWindow(false);
    KUiConnectInfo::CloseWindow(true);
    // Create the VNG in-game communication UI after the login UI is gone.
    // OpenWindow is idempotent; server chat units remain synchronized only
    // by UiOnGameServerStartSyncEnd below.
    KUiMsgCentrePad::OpenWindow();
    KUiChatCentre::OpenWindow(false);
    KUiPlayerControlBar::OpenWindow();
    // Register the wide VNG toolbar first. KUiPlayerBar follows in the same
    // layer so its native 4 item + 2 skill controls remain visible/clickable.
    KUiToolsControlBar::OpenWindow();
    KUiPlayerBar::OpenWindow();
    KUiTimeOnline::OpenWindow(1); // Open time online
    KUiSysMsgCentre::OpenWindow();
    KUiHeaderControlBar::OpenWindow();
    KUiTaskTrace::OpenWindow();    // 2026-10-03 questtrack: quest tracker, left side
    KUiPartyPanel::OpenWindow();   // 2026-10-03 partypanel: VNG team list (bot party / team), right side
    KUiPhongThanTopBar::OpenWindow();
    KUiNewsMessage::OpenWindow();
    KUiNewsMessage2::OpenWindow();
    KUiNewsSysMsg::OpenWindow();
    Wnd_ShowHideGameSpace(true);
    g_UiBase.SetStatus(UIS_S_IDLE);
    Wnd_GameSpaceHandleInput(true);

    KShortcutKeyCentre::Enable(true);

    if (g_LoginLogic.IsRoleNewCreated()) {
        KUiNewPlayerStartMsg::OpenWindow();
    }

    KUiMsgCentrePad::ReleaseActivateChannelAll();
    KUiMsgCentrePad::QueryAllChannel();

    // Load the VNG minimap only after the player/map sync has completed.
    // Calling MapSetMode here corrupts the legacy UI heap during role entry.
    //MapSetMode(MINIMAP_M_BRIEF_PIC);

    g_UiBase.LoadPrivateConfig();
    s_UiLiveSeed = UI_LIVING_S_INGAME;

    char szRole[64];
    szRole[0] = 0;
    g_LoginLogic.GetLoginAccount(szRole);
    if (szRole[0] != 0) {
        char szEvent[256];
        sprintf(szEvent, APP_STARTGAME, szRole);
        g_UiBase.NotifyEvent(szEvent);
    }
}

//��Ϸ�����ߺ󣩼���
void UiResumeGame() {
    s_UiLiveSeed = UI_LIVING_S_INGAME;
}

bool UiCloseWndsInGame(bool bAll) {
    if (bAll == false) {
        if (KUiStatus::GetIfVisible() == NULL &&
            KUiItem::GetIfVisible() == NULL &&
            KUiExpandItem::GetIfVisible() == NULL &&
            KUiChatCentre::GetIfVisible() == NULL &&
            KUiChatRoom::GetIfVisible() == NULL &&
            KUiSkills::GetIfVisible() == NULL &&
            KUiSkillTree::GetIfVisible() == NULL &&
            KUiOptions::GetIfVisible() == NULL &&
            KUiStoreBox::GetIfVisible() == NULL &&
            KUiTeamManage::GetIfVisible() == NULL &&
            KUiTradeConfirm::GetIfVisible() == NULL &&
            KUiShop::GetIfVisible() == NULL &&
            KUiHelper::GetIfVisible() == NULL &&
            KUiHelper2::GetIfVisible() == NULL &&
            KUiTaskNote::GetIfVisible() == NULL &&
            KUiMissionNote::GetIfVisible() == NULL &&
            KUiSelPlayerNearby::DoesHaveVisibleWnd() == FALSE &&
            KUiParadeItem::GetIfVisible() == NULL &&
            KUiFaceSelector::GetIfVisible() == NULL &&
            KUiStrengthRank::GetIfVisible() == NULL &&
            KUiTongManager::GetIfVisible() == NULL &&
            KUiTongCreateSheet::GetIfVisible() == NULL &&
            KUiAutoPlay::GetIfVisible() == NULL &&
            KUiRankData::GetIfVisible() == NULL &&
            KUiChatItem::GetIfVisible() == NULL &&
            KUiEnchase::GetIfVisible() == NULL &&
            KUiPlayerLock::GetIfVisible() == NULL &&
            KUiGive::GetIfVisible() == NULL &&
            KUiSuperShop::GetIfVisible() == NULL &&
            KUiShoppingCart::GetIfVisible() == NULL &&
            KUiDynamicShop::GetIfVisible() == NULL &&
            KUiChooseFace::GetIfVisible() == NULL &&
            (KUiMiniMap::GetIfVisible() == NULL ||
             MapGetMode() == MINIMAP_M_BRIEF_NOT_PIC ||
             MapGetMode() == MINIMAP_M_BRIEF_PIC)
                ) {
            return false;
        }
    } else {
        KUiMsgSel::CloseWindow(true);
        KUiTrade::CloseWindow();
        KUiPlayerBar::CloseWindow(true);
        KUiTimeOnline::CloseWindow(true); //TamLTM KUiTimeOnline
        KUiMsgCentrePad::CloseWindow(true);
        KUiHeaderControlBar::CloseWindow();
        KUiTaskTrace::CloseWindow();
        KUiPartyPanel::CloseWindow();
        KUiPhongThanTopBar::CloseWindow();
        KUiToolsControlBar::CloseWindow();
        KUiESCDlg::CloseWindow(true);
        KUiSysMsgCentre::CloseWindow();
        MapSetMode(MINIMAP_M_NONE);
        KUiNewsMessage::CloseWindow(true);
        KUiNewsMessage2::CloseWindow(true);
        KUiNewsSysMsg::CloseWindow(true);
        KUiPlayerControlBar::CloseWindow(true);
        g_UiInformation.Close();
        g_UiInformation1.Close();
        g_UiInformation2.Close();
    }
    if (MapGetMode() != MINIMAP_M_BRIEF_NOT_PIC &&
        MapGetMode() != MINIMAP_M_NONE)
        MapSetMode(MINIMAP_M_BRIEF_PIC);
    KUiFaceSelector::CloseWindow(bAll);
    KUiStatus::CloseWindow(bAll);
    KUiItem::CloseWindow(bAll);
    KUiSkills::CloseWindow(bAll);
    KUiSkillTree::CloseWindow(bAll);
    KUiOptions::CloseWindow();
    KUiStoreBox::CloseWindow();
    KUiTeamManage::CloseWindow();
    KUiTradeConfirm::CloseWindow(bAll);
    KUiShop::CloseWindow();
    KUiSelPlayerNearby::CloseWindow(bAll);
    KUiHelper::CloseWindow(bAll);
    KUiHelper2::CloseWindow(bAll);
    KUiTaskNote::CloseWindow(bAll);
    KUiMissionNote::CloseWindow(bAll);
    KUiParadeItem::CloseWindow(bAll);
    KUiStrengthRank::CloseWindow();
    KUiTongManager::CloseWindow();
    KUiTongCreateSheet::CloseWindow();
    KUiExpandItem::CloseWindow();
    KUiChatCentre::CloseWindow(bAll);
    KUiChatRoom::CloseWindow(bAll);
    KUiAutoPlay::CloseWindow(bAll);
    KUiRankData::CloseWindow();
    KUiChatItem::CloseWindow(bAll); //TamLTM fix post item;
    KUiSuperShop::CloseWindow(bAll);
    KUiShoppingCart::CloseWindow(bAll);
    KUiDynamicShop::CloseWindow();
    KUiEnchase::CloseWindow(bAll);
    KUiGive::CloseWindow(bAll);
    KUiChooseFace::CloseWindow();
    KUiPlayerLock::CloseWindow();
    return true;
}

//--------------------------------------------------------------------------
//	���ܣ��뿪��Ϸ����ʱ
//--------------------------------------------------------------------------
void UiEndGame() {
    KReconnectWnd::Exit(false);
    g_UiBase.SavePrivateConfig();

    Wnd_DragFinished();
    Wnd_SwitchCursor(CURSOR_NORMAL);
    g_NetConnectAgent.DisconnectClient();
    s_UiLiveSeed = UI_LIVING_S_OUTGAME;

    KShortcutKeyCentre::Enable(false);

    UiCloseWndsInGame(true);
    Wnd_ShowHideGameSpace(false);
    Wnd_GameSpaceHandleInput(false);
    KUiLoginBackGround::OpenWindow("Init");
    g_UiBase.SetStatus(UIS_S_IDLE);

    g_UiBase.NotifyEvent(APP_EXITGAME);
}

//������Ļ��Χ��С
void UiSetScreenSize(int nWidth, int nHeight) {
    Wnd_SetScreenSize(nWidth, nHeight);
}

//��һ���µ�GameServer��������
void UiOnGameServerConnected() {
    g_UiBase.SavePrivateConfig();
}

//��һ���µ�GameServer�������ӣ�����ͬ�����
void UiOnGameServerStartSyncEnd() {
    KUiMsgCentrePad::OpenWindow();
    KUiChatCentre::OpenWindow(false);
    KUiChatCentre::CreateSeverUnit();
    KUiAutoPlay::OpenWindow(false);
    KUiStatus::OpenWindow(false);
    g_UiBase.LoadPrivateConfig();    //��̫��:-(
}

/////////////////////////////////////////////////////////////////////////////////

IMPLEMENT_COMCLASS(Player_Life)
bool Player_Life::m_bText = true;

void Player_Life::UpdateData() {
    if (g_pCoreShell) {
        KUiPlayerRuntimeInfo Info;
        memset(&Info, 0, sizeof(KUiPlayerRuntimeInfo));
        g_pCoreShell->GetGameData(GDI_PLAYER_RT_INFO, (int) &Info, 0);

        Info.nLife = max(Info.nLife, 0);
        Info.nLifeFull = max(Info.nLifeFull, 0);

        Set2IntValue(Info.nLife, Info.nLifeFull);
        if (m_bText)
            Set2IntText(Info.nLife, Info.nLifeFull, '/');
        else
            SetText(NULL, 0);
    }
}

void Player_Life::OnButtonClick() {
    KShortcutKeyCentre::ExcuteScript(SCK_SHORTCUT_SHOWPLAYERNUMBER);
    UpdateData();
}


IMPLEMENT_COMCLASS(Player_Mana)
bool Player_Mana::m_bText = true;

void Player_Mana::UpdateData() {
    if (g_pCoreShell) {
        KUiPlayerRuntimeInfo Info;
        memset(&Info, 0, sizeof(KUiPlayerRuntimeInfo));
        g_pCoreShell->GetGameData(GDI_PLAYER_RT_INFO, (int) &Info, 0);

        Info.nMana = max(Info.nMana, 0);
        Info.nManaFull = max(Info.nManaFull, 0);

        Set2IntValue(Info.nMana, Info.nManaFull);

        if (m_bText)
            Set2IntText(Info.nMana, Info.nManaFull, '/');
        else
            SetText(NULL, 0);
    }
}

void Player_Mana::OnButtonClick() {
    KShortcutKeyCentre::ExcuteScript(SCK_SHORTCUT_SHOWPLAYERNUMBER);
    UpdateData();
}


IMPLEMENT_COMCLASS(Player_Stamina)
bool Player_Stamina::m_bText = true;

void Player_Stamina::UpdateData() {
    if (g_pCoreShell) {
        KUiPlayerRuntimeInfo Info;
        memset(&Info, 0, sizeof(KUiPlayerRuntimeInfo));
        g_pCoreShell->GetGameData(GDI_PLAYER_RT_INFO, (int) &Info, 0);

        Info.nStamina = max(Info.nStamina, 0);
        Info.nStaminaFull = max(Info.nStaminaFull, 0);

        Set2IntValue(Info.nStamina, Info.nStaminaFull);

        if (m_bText)
            Set2IntText(Info.nStamina, Info.nStaminaFull, '/');
        else
            SetText(NULL, 0);
    }
}

void Player_Stamina::OnButtonClick() {
    KShortcutKeyCentre::ExcuteScript(SCK_SHORTCUT_SHOWPLAYERNUMBER);
    UpdateData();
}


IMPLEMENT_COMCLASS(Player_Exp)
bool Player_Exp::m_bText = true;

void Player_Exp::UpdateData() {
    int nFull, nCurrLevelExp, nCurrent;

    if (KUiPlayerBar::GetExp(nFull, nCurrLevelExp, nCurrent)) {
        if (g_pCoreShell) {
            KUiPlayerAttribute Info;
            memset(&Info, 0, sizeof(KUiPlayerAttribute));
            g_pCoreShell->GetGameData(GDI_PLAYER_RT_ATTRIBUTE, (unsigned int) &Info, 0);
            int np = 100;
            if (nCurrLevelExp != 0)
                np = (int) (((nCurrent - nFull + nCurrLevelExp) * 100.00) / nCurrLevelExp);
            np = max(np, 0);
            np = min(np, 100);
            Set2IntValue(np, 100);
            if (Info.nLevel >= 80) {

                if (m_bText) {
                    char szExp[32];
                    float abc = float(((nCurrent - nFull + nCurrLevelExp) * 100.0) / nCurrLevelExp);
                    int i = (int) (abc * 100);
                    float d = (float) i / 100;
                    SetText(szExp, sprintf(szExp, "%6.2f%%%", d));
                } else
                    SetText(NULL, 0);
            } else {

                if (m_bText) {
                    char szExp[32];
                    int nLen = sprintf(szExp, "%d%%%", np);
                    SetText(szExp, nLen);
                } else
                    SetText(NULL, 0);
            }

        }
    }
}

void Player_Exp::OnButtonClick() {
    KShortcutKeyCentre::ExcuteScript(SCK_SHORTCUT_SHOWPLAYERNUMBER);
    UpdateData();
}

int Player_Exp::GetToolTipInfo(char *szTip, int nMax) {
    int nFull, nCurrLevelExp, nCurrent;
    int nLen = 0;
    if (KUiPlayerBar::GetExp(nFull, nCurrLevelExp, nCurrent) && szTip && nMax > 0) {
        char szBuffer[64];
        nLen = sprintf(szBuffer, "Kinh nghi�m %d/%d", nCurrent, nFull);
        if (nLen <= nMax)
            memcpy(szTip, szBuffer, nLen);
        else
            nLen = 0;
    }
    return nLen;
}

IMPLEMENT_COMCLASS(Player_Level)

void Player_Level::UpdateData() {
    if (g_pCoreShell) {
        KUiPlayerAttribute Info;
        memset(&Info, 0, sizeof(KUiPlayerAttribute));
        g_pCoreShell->GetGameData(GDI_PLAYER_RT_ATTRIBUTE, (unsigned int) &Info, 0);
        Set5IntText(Info.nLevel);
    }
}

IMPLEMENT_COMCLASS(Player_Name)

void Player_Name::UpdateData() {
    if (g_pCoreShell) {
        KUiPlayerBaseInfo Info;
        memset(&Info, 0, sizeof(Info));
        g_pCoreShell->GetGameData(GDI_PLAYER_BASE_INFO, (unsigned int) &Info, 0);
        SetText(Info.Name);
    }
}

IMPLEMENT_COMCLASS(Player_SectSort)

void Player_SectSort::UpdateData() {
    if (g_pCoreShell) {
        KUiPlayerBaseInfo Info;
        memset(&Info, 0, sizeof(KUiPlayerBaseInfo));
        g_pCoreShell->GetGameData(GDI_PLAYER_BASE_INFO, (unsigned int) &Info, 0);
        Set5IntText(Info.nProfessionRank);
    }
}

void Player_SectSort::OnButtonClick() {
    if (KUiStrengthRank::GetIfVisible() == NULL)
        KUiStrengthRank::OpenDefaultWindow();
}

IMPLEMENT_COMCLASS(Player_WorldSort)

void Player_WorldSort::UpdateData() {
    if (g_pCoreShell) {
        KUiPlayerBaseInfo Info;
        memset(&Info, 0, sizeof(KUiPlayerBaseInfo));
        g_pCoreShell->GetGameData(GDI_PLAYER_BASE_INFO, (unsigned int) &Info, 0);
        Set5IntText(Info.nRankInWorld);
    }
}

void Player_WorldSort::OnButtonClick() {
    if (KUiStrengthRank::GetIfVisible() == NULL)
        KUiStrengthRank::OpenDefaultWindow();
}

IMPLEMENT_COMCLASS(Player_Status)

void Player_Status::OnButtonClick() {
    KShortcutKeyCentre::ExcuteScript(SCK_SHORTCUT_STATUS);
}

const char *Player_Status::GetShortKey() {
    return KShortcutKeyCentre::GetKeyName(
            KShortcutKeyCentre::GetCommandKey(
                    KShortcutKeyCentre::FindCommandByScript(SCK_SHORTCUT_STATUS)));
}


IMPLEMENT_COMCLASS(Player_Items)

void Player_Items::OnButtonClick() {
    KShortcutKeyCentre::ExcuteScript(SCK_SHORTCUT_ITEMS);
}

const char *Player_Items::GetShortKey() {
    return KShortcutKeyCentre::GetKeyName(
            KShortcutKeyCentre::GetCommandKey(
                    KShortcutKeyCentre::FindCommandByScript(SCK_SHORTCUT_ITEMS)));
}

IMPLEMENT_COMCLASS(Player_ItemEx)

void Player_ItemEx::OnButtonClick() {
    KShortcutKeyCentre::ExcuteScript(SCK_SHORTCUT_ITEMEX);
}

const char *Player_ItemEx::GetShortKey() {
    return KShortcutKeyCentre::GetKeyName(
            KShortcutKeyCentre::GetCommandKey(
                    KShortcutKeyCentre::FindCommandByScript(SCK_SHORTCUT_ITEMEX)));
}

IMPLEMENT_COMCLASS(Player_Skills)

void Player_Skills::OnButtonClick() {
    KShortcutKeyCentre::ExcuteScript(SCK_SHORTCUT_SKILLS);
}

const char *Player_Skills::GetShortKey() {
    return KShortcutKeyCentre::GetKeyName(
            KShortcutKeyCentre::GetCommandKey(
                    KShortcutKeyCentre::FindCommandByScript(SCK_SHORTCUT_SKILLS)));
}

IMPLEMENT_COMCLASS(Player_Friend)

void Player_Friend::OnButtonClick() {
    KShortcutKeyCentre::ExcuteScript(SCK_SHORTCUT_FRIEND);
}

const char *Player_Friend::GetShortKey() {
    return KShortcutKeyCentre::GetKeyName(
            KShortcutKeyCentre::GetCommandKey(
                    KShortcutKeyCentre::FindCommandByScript(SCK_SHORTCUT_FRIEND)));
}

IMPLEMENT_COMCLASS(Player_FSBook)

void Player_FSBook::OnButtonClick() {
    KShortcutKeyCentre::ExcuteScript("Open([[help]])");
}

const char *Player_FSBook::GetShortKey() {
    return 0;
}

IMPLEMENT_COMCLASS(Player_Help)

void Player_Help::OnButtonClick() {
    KShortcutKeyCentre::ExcuteScript("Open([[help]])");
}

const char *Player_Help::GetShortKey() {
    return 0;
}

IMPLEMENT_COMCLASS(Player_IBShop)

int Player_IBShop::Init(KIniFile *pIniFile, const char *pSection) {
    int nResult = KWndButton::Init(pIniFile, pSection);
    if (nResult) {
        // Exact CP936 path from the original VNG PAK. Hex bytes avoid any
        // source-editor transcoding while KPakFile resolves the PAK entry.
        SetImage(ISI_T_SPR,
                 "\\spr\\Ui4\\\xB0\xCB\xB1\xA6\xC8\xE7\xD2\xE2\xB8\xF3\\"
                 "\xB0\xCB\xB1\xA6\xB8\xF3\xB0\xB4\xC5\xA5.spr", true);
    }
    return nResult;
}

void Player_IBShop::OnButtonClick() {
    // Native Phong Than action: send the authoritative shop request directly.
    // This avoids the legacy client-side shortcut/Lua dispatcher swallowing the
    // click before it reaches CoreShell.
    if (g_pCoreShell)
        g_pCoreShell->OperationRequest(GOI_SUPERSHOP, 0, 0);
}

const char *Player_IBShop::GetShortKey() {
    return KShortcutKeyCentre::GetKeyName(
            KShortcutKeyCentre::GetCommandKey(
                    KShortcutKeyCentre::FindCommandByScript(SCK_SHORTCUT_IBSHOP)));
}

IMPLEMENT_COMCLASS(Player_Topten)

void Player_Topten::OnButtonClick() {
    KShortcutKeyCentre::ExcuteScript("Open([[rankdata]])");
}

const char *Player_Topten::GetShortKey() {
    return 0;
}

IMPLEMENT_COMCLASS(Player_HidePeople)
bool Player_HidePeople::m_bHidden = false;

void Player_HidePeople::OnButtonClick() {
    m_bHidden = !m_bHidden;
    if (g_pCoreShell)
        g_pCoreShell->OperationRequest(GOI_TOI_UU_IMAGE_COMMAND, 1,
                                       m_bHidden ? false : true);
}

const char *Player_HidePeople::GetShortKey() {
    return 0;
}

IMPLEMENT_COMCLASS(Player_Communication)

void Player_Communication::OnButtonClick() {
    if (KUiSelPlayerNearby::DoesHaveVisibleWnd())
        KUiSelPlayerNearby::CloseWindow(false);
    else
        KUiSelPlayerNearby::OpenWindow();
}

const char *Player_Communication::GetShortKey() {
    return 0;
}

IMPLEMENT_COMCLASS(Player_TextAnnounce)

IMPLEMENT_COMCLASS(Player_Quest)

void Player_Quest::OnButtonClick() {
    KShortcutKeyCentre::ExcuteScript("Open([[tasknote]])");
}

const char *Player_Quest::GetShortKey() {
    return 0;
}

IMPLEMENT_COMCLASS(Player_System)

void Player_System::OnButtonClick() {
    KShortcutKeyCentre::ExcuteScript(SCK_SHORTCUT_SYSTEM);
}

const char *Player_System::GetShortKey() {
    return KShortcutKeyCentre::GetKeyName(
            KShortcutKeyCentre::GetCommandKey(
                    KShortcutKeyCentre::FindCommandByScript(SCK_SHORTCUT_SYSTEM)));
}

IMPLEMENT_COMCLASS(Player_Lvskill)

void Player_Lvskill::OnButtonClick() {
    KShortcutKeyCentre::ExcuteScript("Open([[leftskill]])");
}

const char *Player_Lvskill::GetShortKey() {
    return 0;
}

IMPLEMENT_COMCLASS(Player_DivineInfusion)

void Player_DivineInfusion::OnButtonClick() {
    // This VNG entry stays visible when the current server has no window for it.
}

const char *Player_DivineInfusion::GetShortKey() {
    return 0;
}

IMPLEMENT_COMCLASS(Player_PKTimer)

void Player_PKTimer::OnButtonClick() {
    KShortcutKeyCentre::ExcuteScript(SCK_SHORTCUT_PK);
}

void Player_PKTimer::UpdateData() {
    if (g_pCoreShell) {
        int nPK = g_pCoreShell->GetGameData(GDI_PK_SETTING, 0, 0);
        SetFrame(nPK == enumPKNormal ? 0 :
                 nPK == enumPKWar ? 1 :
                 nPK == enumPKMurder ? 2 :
                 nPK == enumPKTongWar ? 3 : 0);
    }
}

const char *Player_PKTimer::GetShortKey() {
    return KShortcutKeyCentre::GetKeyName(
            KShortcutKeyCentre::GetCommandKey(
                    KShortcutKeyCentre::FindCommandByScript(SCK_SHORTCUT_FASTPK)));
}


IMPLEMENT_COMCLASS(Player_Team)

void Player_Team::OnButtonClick() {
    KShortcutKeyCentre::ExcuteScript(SCK_SHORTCUT_TEAM);
}

const char *Player_Team::GetShortKey() {
    return KShortcutKeyCentre::GetKeyName(
            KShortcutKeyCentre::GetCommandKey(
                    KShortcutKeyCentre::FindCommandByScript(SCK_SHORTCUT_TEAM)));
}


IMPLEMENT_COMCLASS(Player_Faction)

void Player_Faction::OnButtonClick() {
    KShortcutKeyCentre::ExcuteScript(SCK_SHORTCUT_TONG);
}

const char *Player_Faction::GetShortKey() {
    return KShortcutKeyCentre::GetKeyName(
            KShortcutKeyCentre::GetCommandKey(
                    KShortcutKeyCentre::FindCommandByScript(SCK_SHORTCUT_TONG)));
}


IMPLEMENT_COMCLASS(Player_Sit)

void Player_Sit::OnButtonClick() {
    KShortcutKeyCentre::ExcuteScript(SCK_SHORTCUT_SIT);
}

void Player_Sit::UpdateData() {
    if (g_pCoreShell) {
        KUiPlayerRuntimeInfo Info;
        memset(&Info, 0, sizeof(KUiPlayerRuntimeInfo));
        g_pCoreShell->GetGameData(GDI_PLAYER_RT_INFO, (int) &Info, 0);
        CheckButton(Info.byAction & PA_SIT);
    }
}

const char *Player_Sit::GetShortKey() {
    return KShortcutKeyCentre::GetKeyName(
            KShortcutKeyCentre::GetCommandKey(
                    KShortcutKeyCentre::FindCommandByScript(SCK_SHORTCUT_SIT)));
}


IMPLEMENT_COMCLASS(Player_Run)

void Player_Run::OnButtonClick() {
    KShortcutKeyCentre::ExcuteScript(SCK_SHORTCUT_RUN);
}

void Player_Run::UpdateData() {
    if (g_pCoreShell) {
        KUiPlayerRuntimeInfo Info;
        memset(&Info, 0, sizeof(KUiPlayerRuntimeInfo));
        g_pCoreShell->GetGameData(GDI_PLAYER_RT_INFO, (int) &Info, 0);
        CheckButton(Info.byAction & PA_RUN);
    }
}

const char *Player_Run::GetShortKey() {
    return KShortcutKeyCentre::GetKeyName(
            KShortcutKeyCentre::GetCommandKey(
                    KShortcutKeyCentre::FindCommandByScript(SCK_SHORTCUT_RUN)));
}

IMPLEMENT_COMCLASS(Player_Horse)

void Player_Horse::OnButtonClick() {
    KShortcutKeyCentre::ExcuteScript(SCK_SHORTCUT_HORSE);
}

void Player_Horse::UpdateData() {
    if (g_pCoreShell) {
        KUiPlayerRuntimeInfo Info;
        memset(&Info, 0, sizeof(KUiPlayerRuntimeInfo));
        g_pCoreShell->GetGameData(GDI_PLAYER_RT_INFO, (int) &Info, 0);
        CheckButton(Info.byAction & PA_RIDE);
    }
}

const char *Player_Horse::GetShortKey() {
    return KShortcutKeyCentre::GetKeyName(
            KShortcutKeyCentre::GetCommandKey(
                    KShortcutKeyCentre::FindCommandByScript(SCK_SHORTCUT_HORSE)));
}

IMPLEMENT_COMCLASS(Player_Exchange)

void Player_Exchange::OnButtonClick() {
    KShortcutKeyCentre::ExcuteScript(SCK_SHORTCUT_TRADE);
}

void Player_Exchange::UpdateData() {
    if (g_pCoreShell) {
        CheckButton(g_pCoreShell->GetGameData(GDI_TRADE_OPER_DATA, UTOD_IS_WILLING, 0));
    }
}

const char *Player_Exchange::GetShortKey() {
    return KShortcutKeyCentre::GetKeyName(
            KShortcutKeyCentre::GetCommandKey(
                    KShortcutKeyCentre::FindCommandByScript(SCK_SHORTCUT_TRADE)));
}

IMPLEMENT_COMCLASS(Player_PK)

void Player_PK::OnButtonClick() {
    KShortcutKeyCentre::ExcuteScript(SCK_SHORTCUT_PK);
}

void Player_PK::UpdateData() {
    if (g_pCoreShell) {
        if (g_pCoreShell->GetGameData(GDI_PK_SETTING, 0, 0) == enumPKNormal)
            SetFrame(0);
        else if (g_pCoreShell->GetGameData(GDI_PK_SETTING, 0, 0) == enumPKWar)
            SetFrame(1);
        else if (g_pCoreShell->GetGameData(GDI_PK_SETTING, 0, 0) == enumPKMurder)
            SetFrame(2);
        else if (g_pCoreShell->GetGameData(GDI_PK_SETTING, 0, 0) == enumPKTongWar)
            SetFrame(3);
    }
}

const char *Player_PK::GetShortKey() {
    return KShortcutKeyCentre::GetKeyName(
            KShortcutKeyCentre::GetCommandKey(
                    KShortcutKeyCentre::FindCommandByScript(SCK_SHORTCUT_FASTPK)));
}


IMPLEMENT_COMCLASS(Player_ChatRoom)

void Player_ChatRoom::OnButtonClick() {
    KShortcutKeyCentre::ExcuteScript(SCK_SHORTCUT_CHATROOM);
}

const char *Player_ChatRoom::GetShortKey() {
    return KShortcutKeyCentre::GetKeyName(
            KShortcutKeyCentre::GetCommandKey(
                    KShortcutKeyCentre::FindCommandByScript(SCK_SHORTCUT_CHATROOM)));
}


IMPLEMENT_COMCLASS(Player_Recorder)

void Player_Recorder::OnButtonClick() {
}

const char *Player_Recorder::GetShortKey() {
    return 0;
}


IMPLEMENT_COMCLASS(Player_Auto)

void Player_Auto::OnButtonClick() {
    KShortcutKeyCentre::ExcuteScript(SCK_SHORTCUT_AUTO);
}

const char *Player_Auto::GetShortKey() {
    return KShortcutKeyCentre::GetKeyName(
            KShortcutKeyCentre::GetCommandKey(
                    KShortcutKeyCentre::FindCommandByScript(SCK_SHORTCUT_AUTO)));
}
