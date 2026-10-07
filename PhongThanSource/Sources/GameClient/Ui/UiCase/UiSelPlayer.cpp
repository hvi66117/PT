// -------------------------------------------------------------------------
//	ÎÄ¼þÃû		£º	UiSelPlayer.cpp
//	´´½¨Õß		£º	ÂÀ¹ð»ª
//	´´½¨Ê±¼ä	£º	2002-9-10 14:24:12
//	¹¦ÄÜÃèÊö	£º
// -------------------------------------------------------------------------
#include "KWin32.h"
#include "KIniFile.h"
#include "../Elem/WndMessage.h"
#include "../elem/wnds.h"
#include "UiSelPlayer.h"
#include "UiNewPlayer.h"
#include "UiSelServer.h"
#include "UiLoginbg.h"
#include "UiConnectInfo.h"
#include "PhongThanNativeUiLayout.h"
#include "../UiSoundSetting.h"
#include "../UiBase.h"
#include "../UiShell.h"
#include "KDebug.h"
#include "../../Login/Login.h"
#include "../../Core/Src/GameDataDef.h"
#include "../../../Represent/iRepresent/iRepresentShell.h"
#include <crtdbg.h>

extern iRepresentShell *g_pRepresentShell;

#define    SCHEME_INI_SELPLAYER    "UiSelPlayer.ini"
#define    VNG_PAK_UI_SELPLAYER    0x4746029EUL
#define    PROFESSION_INI                "\\Ui\\Profession.ini"
#define    LIFE_TIME_STRING_ID        "25"
#define    LIFE_TIME_DAY_ID        "26"
#define    LIFE_TIME_HOUR_ID        "27"
#define    LIFE_TIME_MINUTE_ID        "28"
#define    LIFE_TIME_SECOND_ID        "29"

const char *PROFESSION_GetTitleString(int nProfession);

KUiSelPlayer *KUiSelPlayer::m_pSelf = NULL;

//--------------------------------------------------------------------------
//	¹¦ÄÜ£ºÎö¹¹º¯Êý
//--------------------------------------------------------------------------
KUiSelPlayer::KUiSelPlayer() {
    m_nSelPlayer = -1;
    m_nNumPlayer = 0;
    m_szLoginBg[0] = 0;
    m_szPlayerImgPrefix[0] = 0;
    m_bJustClicked = false;
    m_szSelPlayerSound[0][0] = m_szSelPlayerSound[1][0] =
    m_szSelPlayerSound[2][0] = m_szSelPlayerSound[3][0] =
    m_szSelPlayerSound[4][0] = 0;
}

//--------------------------------------------------------------------------
//	¹¦ÄÜ£º´ò¿ª´°¿Ú£¬·µ»ØÎ¨Ò»µÄÒ»¸öÀà¶ÔÏóÊµÀý
//--------------------------------------------------------------------------
KUiSelPlayer *KUiSelPlayer::OpenWindow() {
    if (m_pSelf == NULL) {
        m_pSelf = new KUiSelPlayer;
        if (m_pSelf)
            m_pSelf->Initialize();
    }
    if (m_pSelf) {
        UiSoundPlay(UI_SI_POPUP_OUTGAME_WND);
        m_pSelf->UpdateData();
        KUiLoginBackGround::SetConfig(m_pSelf->m_szLoginBg);
        m_pSelf->Show();
    }
    return m_pSelf;
}

//--------------------------------------------------------------------------
//	¹¦ÄÜ£º¹Ø±Õ´°¿Ú£¬Í¬Ê±¿ÉÒÔÑ¡ÔòÊÇ·ñÉ¾³ý¶ÔÏóÊµÀý
//--------------------------------------------------------------------------
void KUiSelPlayer::CloseWindow() {
    if (m_pSelf) {
        m_pSelf->m_bJustClicked = false;
        m_pSelf->Destroy();
        m_pSelf = NULL;
    }
}

void KUiSelPlayer::Hide() {
    m_pSelf->m_bJustClicked = false;
    KWndShowAnimate::Hide();
}

// -------------------------------------------------------------------------
// º¯Êý		: KUiSelPlayer::Initialize
// ¹¦ÄÜ		: ³õÊ¼»¯
// -------------------------------------------------------------------------
void KUiSelPlayer::Initialize() {
    AddChild(&m_btnOk);
    AddChild(&m_btnCancel);
    AddChild(&m_btnDel);
    AddChild(&m_btnNew);
    AddChild(&m_ButterflyWnd);

    char Scheme[128];
    g_UiBase.GetCurSchemePath(Scheme, 128);
    m_pSelf->LoadScheme(Scheme);

    // ×¢²á±¾´°¿Ú
    Wnd_AddWindow(this, WL_TOPMOST);
}

// -------------------------------------------------------------------------
// º¯Êý		: KUiSelPlayer::LoadScheme
// ¹¦ÄÜ		: ÔØÈë½çÃæ·½°¸
// -------------------------------------------------------------------------
void KUiSelPlayer::LoadScheme(const char *pScheme) {
    char Buff[128];
    KIniFile Ini;
    sprintf(Buff, "%s\\%s", pScheme, SCHEME_INI_SELPLAYER);
    if (Ini.LoadPakEntry(VNG_PAK_UI_SELPLAYER) || Ini.Load(Buff)) {
        int nScreenWidth, nScreenHeight, nOffsetX, nOffsetY;
        PhongThanGetNativeUiMetrics(nScreenWidth, nScreenHeight, nOffsetX, nOffsetY);
        PhongThanMakeIniRootNative(Ini, "SelRole", nScreenWidth, nScreenHeight);

        const char *pszCenteredSections[] = {
            "Player", "Shadow", "PlayerInfoBg", "Name", "Level", "Career",
            "Ok", "Cancel", "New", "Del", "LastMap", "LastTime", "LastIP",
            "PlayListWnd", "btnPlayer", "btnNext", "btnBack", "Butterfly"
        };
        for (int nLayoutSection = 0;
             nLayoutSection < sizeof(pszCenteredSections) / sizeof(pszCenteredSections[0]);
             ++nLayoutSection)
            PhongThanOffsetIniPosition(Ini, pszCenteredSections[nLayoutSection], nOffsetX, nOffsetY);

        // Keep the remaining-time label aligned to the full native canvas.
        Ini.WriteInteger("LifeTime", "Left", 0);
        Ini.WriteInteger("LifeTime", "Width", nScreenWidth);

        Init(&Ini, "SelRole");    // ´°¿Ú±³¾°Êý¾Ý
        Ini.GetString("SelRole", "LoginBg", "", m_szLoginBg, sizeof(m_szLoginBg));
        Ini.GetString("SelRole", "PlayerImgPrefix", "", m_szPlayerImgPrefix, sizeof(m_szPlayerImgPrefix));

        Buff[0] = '\0';    // Çå¿Õ»º´æ
        m_btnOk.Init(&Ini, "Ok");
        m_btnCancel.Init(&Ini, "Cancel");
        m_btnDel.Init(&Ini, "Del");
        m_btnNew.Init(&Ini, "New");
        m_ButterflyWnd.Init(&Ini, "Butterfly");

        m_player[0].Init(&Ini, "Player");
        m_Name[0].Init(&Ini, "Name");
        m_Level[0].Init(&Ini, "Level");
        m_PlayerInfoBg[0].Init(&Ini, "PlayerInfoBg");
        for (int i = 1; i < MAX_PLAYER_PER_ACCOUNT; i++) {
            m_player[0].Clone(&m_player[i]);
            m_Name[0].Clone(&m_Name[i]);
            m_Level[0].Clone(&m_Level[i]);
            m_PlayerInfoBg[0].Clone(&m_PlayerInfoBg[i]);
        }

        Ini.GetInteger("SelRole", "Player2Pos_0", 0, &m_ChildWndXOffset[0]);
        Ini.GetInteger("SelRole", "Player2Pos_1", 0, &m_ChildWndXOffset[1]);
        Ini.GetInteger("SelRole", "Player3Pos_0", 0, &m_ChildWndXOffset[2]);
        Ini.GetInteger("SelRole", "Player3Pos_1", 0, &m_ChildWndYOffset);
        Ini.GetInteger("SelRole", "Player3Pos_2", 0, &m_ChildWndXOffset[3]);

        m_player[0].GetPosition(&m_ChildPos[0], NULL);
        m_Name[0].GetPosition(&m_ChildPos[1], NULL);
        m_Level[0].GetPosition(&m_ChildPos[2], NULL);
        m_PlayerInfoBg[0].GetPosition(&m_ChildPos[3], NULL);

        m_LifeTimeText.Init(&Ini, "LifeTime");

        isCheckPlayGame = false; // check nhan vat
    }
}

// -------------------------------------------------------------------------
// ¹¦ÄÜ	: »æÖÆ´°¿Ú
// -------------------------------------------------------------------------
void KUiSelPlayer::PaintWindow() {
    KWndShowAnimate::PaintWindow();
    for (int i = 0; i < m_nNumPlayer; i++) {
        int nLoopBack = m_player[i].NextFrame();
        if (m_bJustClicked && nLoopBack && i == m_nSelPlayer) {
            char szFileName[128];
            GetRoleImageName(szFileName, m_szPlayerImgPrefix, m_Gender[m_nSelPlayer], m_Profession[m_nSelPlayer], 0);
            m_player[m_nSelPlayer].SetImage(ISI_T_SPR, szFileName);
            m_player[m_nSelPlayer].SetFrame(0);
            m_bJustClicked = false;
        }
    }

    m_LifeTimeText.PaintWindow();
}

// -------------------------------------------------------------------------
// ¹¦ÄÜ	: ¸üÐÂ
// -------------------------------------------------------------------------
void KUiSelPlayer::UpdateData() {
    int nSel;
    m_nNumPlayer = g_LoginLogic.GetRoleCount(nSel);
    if (m_nNumPlayer > 0 && nSel < 0)
        m_nSelPlayer = 0;
    else
        m_nSelPlayer = nSel;

    int x, y;
    //---µ÷Õû×Ó´°¿ÚÎ»ÖÃ----
    switch (m_nNumPlayer) {
        case 1:
            m_player[0].GetPosition(&x, &y);
            x = m_ChildPos[0];
            m_player[0].SetPosition(x, y);
            m_Name[0].GetPosition(&x, &y);
            x = m_ChildPos[1];
            m_Name[0].SetPosition(x, y);
            m_Level[0].GetPosition(&x, &y);
            x = m_ChildPos[2];
            m_Level[0].SetPosition(x, y);
            m_PlayerInfoBg[0].GetPosition(&x, &y);
            x = m_ChildPos[3];
            m_PlayerInfoBg[0].SetPosition(x, y);
            break;
        case 2:
            m_player[0].GetPosition(&x, &y);
            x = m_ChildPos[0] + m_ChildWndXOffset[0];
            m_player[0].SetPosition(x, y);
            x = m_ChildPos[0] + m_ChildWndXOffset[1];
            m_player[1].SetPosition(x, y);

            m_Name[0].GetPosition(&x, &y);
            x = m_ChildPos[1] + m_ChildWndXOffset[0];
            m_Name[0].SetPosition(x, y);
            x = m_ChildPos[1] + m_ChildWndXOffset[1];
            m_Name[1].SetPosition(x, y);

            m_Level[0].GetPosition(&x, &y);
            x = m_ChildPos[2] + m_ChildWndXOffset[0];
            m_Level[0].SetPosition(x, y);
            x = m_ChildPos[2] + m_ChildWndXOffset[1];
            m_Level[1].SetPosition(x, y);

            m_PlayerInfoBg[0].GetPosition(&x, &y);
            x = m_ChildPos[3] + m_ChildWndXOffset[0];
            m_PlayerInfoBg[0].SetPosition(x, y);
            x = m_ChildPos[3] + m_ChildWndXOffset[1];
            m_PlayerInfoBg[1].SetPosition(x, y);
            break;
        case 3:
            m_player[0].GetPosition(&x, &y);
            x = m_ChildPos[0];
            m_player[1].SetPosition(x, y + m_ChildWndYOffset);
            x += m_ChildWndXOffset[2];
            m_player[0].SetPosition(x, y);
            x = m_ChildPos[0] + m_ChildWndXOffset[3];
            m_player[2].SetPosition(x, y);

            m_Name[0].GetPosition(&x, &y);
            x = m_ChildPos[1];
            m_Name[1].SetPosition(x, y + m_ChildWndYOffset);
            x += m_ChildWndXOffset[2];
            m_Name[0].SetPosition(x, y);
            x = m_ChildPos[1] + m_ChildWndXOffset[3];
            m_Name[2].SetPosition(x, y);

            m_Level[0].GetPosition(&x, &y);
            x = m_ChildPos[2];
            m_Level[1].SetPosition(x, y + m_ChildWndYOffset);
            x += m_ChildWndXOffset[2];
            m_Level[0].SetPosition(x, y);
            x = m_ChildPos[2] + m_ChildWndXOffset[3];
            m_Level[2].SetPosition(x, y);

            m_PlayerInfoBg[0].GetPosition(&x, &y);
            x = m_ChildPos[3];
            m_PlayerInfoBg[1].SetPosition(x, y + m_ChildWndYOffset);
            x += m_ChildWndXOffset[2];
            m_PlayerInfoBg[0].SetPosition(x, y);
            x = m_ChildPos[3] + m_ChildWndXOffset[3];
            m_PlayerInfoBg[2].SetPosition(x, y);
            break;
    }

    int i;
    char szFileName[128];
    if (m_nNumPlayer > 0) {
        KIniFile Ini;
        Ini.Load(PROFESSION_INI);

        for (i = 0; i < m_nNumPlayer; i++) {
            KRoleChiefInfo Info;
            g_LoginLogic.GetRoleInfo(i, &Info);
            m_Name[i].SetText(Info.Name);
            m_Level[i].SetIntText(Info.nLevel);
            AddChild(&m_PlayerInfoBg[i]);
            AddChild(&m_player[i]);
            AddChild(&m_Name[i]);
            AddChild(&m_Level[i]);
            m_Gender[i] = Info.Gender;
            m_Profession[i] = Info.Profession;

            m_szSelPlayerSound[i][0] = 0;
            Ini.GetString(PROFESSION_GetTitleString(Info.Profession),
                          Info.Gender ? "SelSound_f" : "SelSound_m", "",
                          m_szSelPlayerSound[i], sizeof(m_szSelPlayerSound[i]));
            GetRoleImageName(szFileName, m_szPlayerImgPrefix, Info.Gender, Info.Profession, 2);
            m_player[i].SetImage(ISI_T_SPR, szFileName);
            m_player[i].SetFrame(0);

        }

        if (m_nSelPlayer < 0)
            m_nSelPlayer = 0;

        OnSelectPlayer(m_nSelPlayer);
    }

    for (i = m_nNumPlayer; i < MAX_PLAYER_PER_ACCOUNT; i++) {
        m_player[i].LeaveAlone();
        m_Name[i].LeaveAlone();
        m_Level[i].LeaveAlone();
        m_PlayerInfoBg[i].LeaveAlone();
    }

    m_btnOk.BringToTop();
    m_btnCancel.BringToTop();
    m_btnDel.BringToTop();
    m_btnNew.BringToTop();

    m_btnNew.Enable(m_nNumPlayer < MAX_PLAYER_PER_ACCOUNT);
    m_btnDel.Enable(m_nNumPlayer > 0 && m_nSelPlayer >= 0);
    m_btnOk.Enable(m_nNumPlayer > 0 && m_nSelPlayer >= 0);

    DWORD dwLifeTime = g_LoginLogic.GetAccountLifeTime();
    int nDays, nHours, nMinutes;
    nDays = dwLifeTime / 86400;
    dwLifeTime -= nDays * 86400;
    nHours = dwLifeTime / 3600;
    dwLifeTime -= nHours * 3600;
    nMinutes = dwLifeTime / 60;
    dwLifeTime -= nMinutes * 60;

    char szInfo[128] = "";
    char szDay[16] = "day(s)";
    char szHour[16] = "hour(s)";
    char szMinute[16] = "minute(s)";
    char szSecond[16] = "second(s)";
    KIniFile *pSetting = g_UiBase.GetCommConfigFile();
    if (pSetting) {
        pSetting->GetString("InfoString", LIFE_TIME_STRING_ID,
                            "", szInfo, sizeof(szInfo));
        pSetting->GetString("InfoString", LIFE_TIME_DAY_ID,
                            "day(s)", szDay, sizeof(szDay));
        pSetting->GetString("InfoString", LIFE_TIME_HOUR_ID,
                            "hour(s)", szHour, sizeof(szHour));
        pSetting->GetString("InfoString", LIFE_TIME_MINUTE_ID,
                            "minute(s)", szMinute, sizeof(szMinute));
        pSetting->GetString("InfoString", LIFE_TIME_SECOND_ID,
                            "second(s)", szSecond, sizeof(szSecond));
        g_UiBase.CloseCommConfigFile();
    }
    int nLen = strlen(szInfo);
    if (nDays) {
        nLen += sprintf(szInfo + nLen, "%d%s", nDays, szDay);
    }
    if (nHours) {
        nLen += sprintf(szInfo + nLen, "%d%s", nHours, szHour);
    }
    if (nDays == 0) {
        if (nMinutes) {
            nLen += sprintf(szInfo + nLen, "%d%s", nMinutes, szMinute);
        }
        if (nHours == 0 && (dwLifeTime || nMinutes == 0)) {
            nLen += sprintf(szInfo + nLen, "%d%s", dwLifeTime, szSecond);
        }
    }

    m_LifeTimeText.SetText(szInfo, nLen);

    countTimerLoadGame = 1;
}

void
KUiSelPlayer::GetRoleImageName(char *pszName, const char *pszPrefix, unsigned char bGender, unsigned char bAttribute,
                               int nIndex) {
    _ASSERT(pszName && bAttribute >= series_metal && bAttribute < series_num);
    static const char *pszAttribute[series_num] = {"½ð", "Ä¾", "Ë®", "»ð", "ÍÁ"};
    static const char *pszGender[2] = {"ÄÐ", "Å®"};
    sprintf(pszName, "%s_%s_%s_%d.spr", pszPrefix, pszAttribute[bAttribute],
            (bGender ? pszGender[1] : pszGender[0]), nIndex);
}

// -------------------------------------------------------------------------
// º¯Êý	: ÏûÏ¢´¦Àí
// -------------------------------------------------------------------------
int KUiSelPlayer::WndProc(unsigned int uMsg, unsigned int uParam, int nParam) {
    int nRet = 0;
    switch (uMsg) {
        case WND_N_BUTTON_CLICK:
            OnClickButton((KWndButton *) (KWndWindow *) uParam, false);
            break;

        case WND_N_BUTTON_DB_CLICK:
            OnClickButton((KWndButton *) (KWndWindow *) uParam, true);
            break;
        case WM_KEYDOWN:
            nRet = OnKeyDown(uParam);
            break;
        default:
            nRet = KWndShowAnimate::WndProc(uMsg, uParam, nParam);
            break;
    }
    return nRet;
}

int KUiSelPlayer::OnKeyDown(unsigned int uKey) {
    int nRet = 1;
    KWndWindow *pActive = NULL;
    KWndButton *pToActive = NULL;
    switch (uKey) {
        case VK_RETURN:
            pActive = GetActiveBtn();
            if (pActive == NULL && m_btnOk.IsDisable() == FALSE)
                pActive = &m_btnOk;
            OnClickButton((KWndButton *) pActive, false);
            break;
        case VK_ESCAPE:
            OnCancel();
            nRet = 1;
            break;
        case VK_UP:
            pActive = GetActiveBtn();
            if (pActive == &m_btnCancel)
                pToActive = &m_btnDel;
            else if (pActive == &m_btnDel)
                pToActive = &m_btnNew;
            else if (pActive == &m_btnOk)
                pToActive = &m_btnCancel;
            else
                pToActive = &m_btnOk;
            nRet = 1;
            break;
        case VK_DOWN:
            pActive = GetActiveBtn();
            if (pActive == &m_btnOk)
                pToActive = &m_btnNew;
            else if (pActive == &m_btnNew)
                pToActive = &m_btnDel;
            else if (pActive == &m_btnCancel)
                pToActive = &m_btnOk;
            else
                pToActive = &m_btnCancel;
            nRet = 1;
            break;
        case VK_LEFT:
            if (m_nSelPlayer > 0)
                OnSelectPlayer(m_nSelPlayer - 1);
            else if (m_nSelPlayer < 0 && m_nNumPlayer > 0)
                OnSelectPlayer(0);
            m_btnDel.Enable(m_nSelPlayer >= 0);
            nRet = 1;
            break;
        case VK_RIGHT:
        case VK_SPACE:
            if (m_nSelPlayer < m_nNumPlayer - 1)
                OnSelectPlayer(m_nSelPlayer + 1);
            else if (m_nNumPlayer < 0 && m_nNumPlayer > 0)
                OnSelectPlayer(0);
            m_btnDel.Enable(m_nSelPlayer >= 0);
            nRet = 1;
            break;
        default:
            nRet = 0;
    }
    if (pToActive)
        pToActive->SetCursorAbove();
    return nRet;
}

void KUiSelPlayer::OnSelectPlayer(int nSel, bool bPlaySound) {
    char szFileName[128];
    if (m_nSelPlayer != nSel) {
        if (m_nSelPlayer >= 0) {
            GetRoleImageName(szFileName, m_szPlayerImgPrefix, m_Gender[m_nSelPlayer], m_Profession[m_nSelPlayer], 2);
            m_player[m_nSelPlayer].SetImage(ISI_T_SPR, szFileName);
            m_player[m_nSelPlayer].SetFrame(0);
        }
        m_btnDel.Enable(true);
        m_nSelPlayer = nSel;
    }
    GetRoleImageName(szFileName, m_szPlayerImgPrefix, m_Gender[m_nSelPlayer], m_Profession[m_nSelPlayer], 1);
    m_player[m_nSelPlayer].SetImage(ISI_T_SPR, szFileName);
    m_player[m_nSelPlayer].SetFrame(0);
    m_bJustClicked = true;
    if (bPlaySound)
        UiSoundPlay(m_szSelPlayerSound[m_nSelPlayer]);
}

// -------------------------------------------------------------------------
// º¯Êý		: KUiSelPlayer::OnClickButton
// ¹¦ÄÜ		: ÏìÓ¦µã»÷°´Å¥
// ²ÎÊý		: KWndWindow* pWnd ---> ±»µã»÷µÄ¿Ø¼þÖ¸Õë
// -------------------------------------------------------------------------
void KUiSelPlayer::OnClickButton(KWndButton *pWnd, bool bDoubleClick) {
    // ---> ÅÐ¶ÏµãÖÐµÄÊÇÄÇ¸ö¿Ø¼þ
    for (int i = 0; i < m_nNumPlayer; i++) {
        if (pWnd == (KWndWindow *) &m_player[i])    // µãÖÐÁËÄ³¸öÍæ¼ÒÐÅÏ¢¿ò
        {
            OnSelectPlayer(i, !bDoubleClick);
            // Èç¹ûÊÇË«»÷£¬¾Í·ÂÕæÑ¡ÔñÓÃ»§
            if (bDoubleClick) {
                OnEnterGame();
            }
            return;
        }
    }

    if (pWnd == (KWndWindow *) &m_btnNew)
        OnNew();
    else if (pWnd == (KWndWindow *) &m_btnCancel)
        OnCancel();
    else if (pWnd == (KWndWindow *) &m_btnOk) {
        OnEnterGame();
    } else if (pWnd == (KWndWindow *) &m_btnDel)
        OnDel();
}

//TamLTM select nhan vat game and xac nhan
void KUiSelPlayer::OnEnterGame() {
    //TamLTM select nhan vat game and xac nhan

    //g_DebugLog("m_nSelPlayer, xac nhan vao tro choi");
    //end code

    if (m_nSelPlayer >= 0) {
        if (g_LoginLogic.SelectRole(m_nSelPlayer)) {
            KUiConnectInfo::OpenWindow(CI_MI_ENTERING_GAME, LL_S_IN_GAME);
            Hide();
        }
    }
}

// -------------------------------------------------------------------------
// º¯Êý		: KUiSelPlayer::OnNew
// ¹¦ÄÜ		: ÐÂ½¨°´Å¥µã»÷ÊÂ¼þ´¦Àí
// -------------------------------------------------------------------------
void KUiSelPlayer::OnNew() {
    int nSel;
    if (g_LoginLogic.GetRoleCount(nSel) < MAX_PLAYER_PER_ACCOUNT) {
        // VNG chooses birthplace from the profession inside the new-role UI.
        if (KUiNewPlayer::OpenWindow(0))
            Hide();
    }
}

void KUiSelPlayer::OnDel() {
    if (m_nSelPlayer >= 0) {
        //	KUiConnectInfo::OpenWindow(CI_MI_TO_DEL_ROLE, CI_NS_SEL_ROLE_WND, m_nSelPlayer);

        //Khong the xoa nhan vat nay
        KUiConnectInfo::OpenWindow(CI_MI_INVALID_NOT_DELETE_PLAYER, CI_NS_SEL_ROLE_WND, 0);
        Hide();

        //	g_DebugLog("OpenWindow(CI_MI_TO_DEL_ROLE, CI_NS_SEL_ROLE_WND, m_nSelPlayer) HiÖn t¹i kh«ng thÓ xãa nh©n vËt nµy.");
    }
}

// -------------------------------------------------------------------------
// º¯Êý		: KUiSelPlayer::OnCancel
// ¹¦ÄÜ		: È¡Ïû°´Å¥µã»÷ÊÂ¼þ´¦Àí
// -------------------------------------------------------------------------
void KUiSelPlayer::OnCancel() {
    Hide();
    g_LoginLogic.ReturnToIdle();
    KUiSelServer::OpenWindow();
}

KWndButton *KUiSelPlayer::GetActiveBtn() {
    KWndButton *pBtn = NULL;
    if (m_btnOk.IsButtonActive())
        pBtn = &m_btnOk;
    else if (m_btnCancel.IsButtonActive())
        pBtn = &m_btnCancel;
    else if (m_btnDel.IsButtonActive())
        pBtn = &m_btnDel;
    else if (m_btnNew.IsButtonActive())
        pBtn = &m_btnNew;

    return pBtn;
}

//TamLTM Check timer in game
void KUiSelPlayer::Breathe() {
//	if (countTimerLoadGame)
//		countTimerLoadGame++;

//	if (countTimerLoadGame == 20)
//	{
    isCheckPlayGame = true;
//		g_DebugLog("Log Breathe");
//	}
//	g_DebugLog("Log Breathe");
}
//end code
