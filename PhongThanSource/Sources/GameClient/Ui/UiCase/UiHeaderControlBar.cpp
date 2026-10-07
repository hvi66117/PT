/*****************************************************************************************
//	界面--屏幕顶控制操作条
//	Copyright : Kingsoft 2003
//	Author	:   Wooy(Wu yue)
//	CreateTime:	2003-4-22
*****************************************************************************************/
#include "KWin32.h"
#include "KIniFile.h"
#include "../elem/wnds.h"
#include "../Elem/WndMessage.h"
#include "../UiBase.h"
#include "UiHeaderControlBar.h"
#include "UiChatCentre.h"

#include "../ShortcutKey.h"
#include "../../../core/src/coreshell.h"

extern iCoreShell *g_pCoreShell;

#define    SCHEME_INI            "UiHeaderControlBar.ini"

KUiHeaderControlBar *KUiHeaderControlBar::m_pSelf = NULL;

// Native VNG id of the top strip containing ranking, hide-players,
// interaction, cash-shop and announcement controls.
#define PHONGTHAN_VNG_TOPBAR_INI_ID 1989332095UL

KUiPhongThanTopBar *KUiPhongThanTopBar::m_pSelf = NULL;

KUiPhongThanTopBar *KUiPhongThanTopBar::OpenWindow() {
    if (m_pSelf == NULL) {
        m_pSelf = new KUiPhongThanTopBar;
        if (m_pSelf)
            m_pSelf->Initialize();
    }
    if (m_pSelf)
        m_pSelf->Show();
    return m_pSelf;
}

void KUiPhongThanTopBar::CloseWindow() {
    if (m_pSelf) {
        m_pSelf->Destroy();
        m_pSelf = NULL;
    }
}

void KUiPhongThanTopBar::Initialize() {
    KIniFile Ini;
    if (Ini.LoadPakEntry(PHONGTHAN_VNG_TOPBAR_INI_ID))
        Init(&Ini, "Main");

    m_Style &= ~WND_S_VISIBLE;
    Wnd_AddWindow(this, WL_TOPMOST);
}

//--------------------------------------------------------------------------
//	功能：打开窗口，返回唯一的一个类对象实例
//--------------------------------------------------------------------------
KUiHeaderControlBar *KUiHeaderControlBar::OpenWindow() {
    if (m_pSelf == NULL) {
        m_pSelf = new KUiHeaderControlBar;
        if (m_pSelf)
            m_pSelf->Initialize();
    }
    if (m_pSelf)
        m_pSelf->Show();
    m_pSelf->UpdateData();
    return m_pSelf;
}

//--------------------------------------------------------------------------
//	功能：关闭窗口
//--------------------------------------------------------------------------
void KUiHeaderControlBar::CloseWindow() {
    if (m_pSelf) {
        m_pSelf->Destroy();
        m_pSelf = NULL;
    }
}

//初始化
void KUiHeaderControlBar::Initialize() {
    AddChild(&m_Portrait);
    AddChild(&m_AntiAddiction);
    AddChild(&m_LevelText);
    AddChild(&m_RankWorldText);
    char Scheme[256];
    g_UiBase.GetCurSchemePath(Scheme, 256);
    LoadScheme(Scheme);

    m_Style &= ~WND_S_VISIBLE;
    Wnd_AddWindow(this, WL_TOPMOST);
}

//载入界面方案
void KUiHeaderControlBar::LoadScheme(const char *pScheme) {
    char Buff[128];
    KIniFile Ini;
    if (m_pSelf) {
        sprintf(Buff, "%s\\" SCHEME_INI, pScheme);
        if (Ini.Load(Buff)) {
            m_pSelf->Init(&Ini, "Main");
            m_pSelf->m_Portrait.Init(&Ini, "ImgPortrait");
            m_pSelf->m_AntiAddiction.Init(&Ini, "ImgAntiAddiction");
            m_pSelf->m_LevelText.Init(&Ini, "Txt_Level");
            m_pSelf->m_RankWorldText.Init(&Ini, "Txt_WorldSort");
        }
    }
}

//重新初始化界面
void KUiHeaderControlBar::DefaultScheme(const char *pScheme) {
    char Buff[128];
    KIniFile Ini;
    if (m_pSelf) {
        sprintf(Buff, "%s\\" SCHEME_INI, pScheme);
        if (Ini.Load(Buff)) {
            int nValue1, nValue2;
            Ini.GetInteger("Main", "Left", 0, &nValue1);
            Ini.GetInteger("Main", "Top", 0, &nValue2);
            m_pSelf->SetPosition(nValue1, nValue2);
        }
    }
}

void KUiHeaderControlBar::Breathe() {
    UpdateData();
    if (g_pCoreShell) {
        int nVisual = g_pCoreShell->GetGameData(GDI_IS_CHECK_IMAGE, 0, 0);
        int nFaceVariant = nVisual > 0 ? (nVisual - 1) % 3 : 0;
        int nPortrait = nFaceVariant * 2 +
                        (g_pCoreShell->GetGameData(GDI_PLAYER_IS_MALE, 0, 0) ? 1 : 2);
        char szPortrait[128];
        sprintf(szPortrait, "\\Spr\\Ui4\\\xD0\xA4\xCF\xF1\\%03d.spr", nPortrait);
        m_Portrait.SetImage(ISI_T_SPR, szPortrait, true);
    }
}

