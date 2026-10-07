/*****************************************************************************************
//	Hop thoai nhan thuong nhiem vu da tau
//
//	Author	:   Doan Van Kiem
//	CreateTime:	2012/9/02
------------------------------------------------------------------------------------------
*****************************************************************************************/

#include "KWin32.h"
#include "KIniFile.h"
#include "../Elem/WndMessage.h"
#include "../Elem/Wnds.h"
#include "../UiShell.h"
#include "../../../core/src/coreshell.h"
#include "UiInit.h"
#include "UiLoginBg.h"
#include "../UiSoundSetting.h"
#include <crtdbg.h>
#include "UiDaTau.h"
#include "../UiBase.h"

extern iCoreShell *g_pCoreShell;

#define SCHEME_INI                            "UiDaTau.ini"

KUiDaTau *KUiDaTau::m_pSelf = NULL;


//--------------------------------------------------------------------------
//	Mo hop thoai, tra ve con tro hop thoai
//--------------------------------------------------------------------------
KUiDaTau *KUiDaTau::OpenWindow(int uParam) {
    if (m_pSelf == NULL) {
//		g_DebugLog("mo ne %s", uParam);
        m_pSelf = new KUiDaTau;
        if (m_pSelf)
            m_pSelf->Initialize();
    }
    if (m_pSelf) {
        UiSoundPlay(UI_SI_POPUP_OUTGAME_WND);
        m_pSelf->Show();
        m_pSelf->ShowWindow(uParam);
    }
    return m_pSelf;
}


//--------------------------------------------------------------------------
// Dong hop thoai
//--------------------------------------------------------------------------
void KUiDaTau::CloseWindow() {
    if (m_pSelf) {
        Wnd_ShowCursor(true);
        m_pSelf->Destroy();
        m_pSelf = NULL;
    }
}

// -------------------------------------------------------------------------
// Khoi tao hop thoai
// -------------------------------------------------------------------------
void KUiDaTau::Initialize() {
    AddChild(&m_Notice);
    AddChild(&m_ExpBtn);
    AddChild(&m_RandomBtn);
    AddChild(&m_MoneyBtn);
    AddChild(&m_PointBtn);
    AddChild(&m_LuckyBtn);
    AddChild(&m_ItemBtn);
    char schemePath[256];
    g_UiBase.GetCurSchemePath(schemePath, 256);
    LoadScheme(schemePath);
    Wnd_AddWindow(this, WL_TOPMOST);
}


// -------------------------------------------------------------------------
// Tao layout hop thoai
// -------------------------------------------------------------------------
void KUiDaTau::LoadScheme(const char *pScheme) {
    char Buff[128];
    KIniFile Ini;
    sprintf(Buff, "%s\\%s", pScheme, SCHEME_INI);
    if (Ini.Load(Buff)) {
        KWndShowAnimate::Init(&Ini, "Main");
        m_Notice.Init(&Ini, "Notice");
        m_ExpBtn.Init(&Ini, "ExpBtn");
        m_RandomBtn.Init(&Ini, "RandomBtn");
        m_MoneyBtn.Init(&Ini, "MoneyBtn");
        m_PointBtn.Init(&Ini, "PointBtn");
        m_LuckyBtn.Init(&Ini, "LuckyBtn");
        m_ItemBtn.Init(&Ini, "ItemBtn");
        m_Notice.SetText("C¸c h¹ ®· vÊt v¶, xin mêi c¸c h¹ chän phÇn th­ëng!");
        Ini.GetString("Main", "StringQuest", "", m_szLoginBg, sizeof(m_szLoginBg));
    }
}

void KUiDaTau::ShowWindow(int nNum) {
    switch (nNum) {
        case 1:
            m_pSelf->m_ExpBtn.Show();
            m_pSelf->m_RandomBtn.Hide();
            m_pSelf->m_ItemBtn.Show();
            m_pSelf->m_PointBtn.Hide();
            m_pSelf->m_LuckyBtn.Hide();
            m_pSelf->m_MoneyBtn.Show();
            break;
        case 2:
            m_pSelf->m_ExpBtn.Hide();
            m_pSelf->m_RandomBtn.Show();
            m_pSelf->m_ItemBtn.Hide();
            m_pSelf->m_PointBtn.Show();
            m_pSelf->m_LuckyBtn.Show();
            m_pSelf->m_MoneyBtn.Hide();
            break;
        case 3:
            m_pSelf->m_ExpBtn.Show();
            m_pSelf->m_RandomBtn.Hide();
            m_pSelf->m_ItemBtn.Show();
            m_pSelf->m_PointBtn.Hide();
            m_pSelf->m_LuckyBtn.Show();
            m_pSelf->m_MoneyBtn.Hide();
            break;
        case 4:
            m_pSelf->m_ExpBtn.Show();
            m_pSelf->m_RandomBtn.Hide();
            m_pSelf->m_ItemBtn.Hide();
            m_pSelf->m_PointBtn.Show();
            m_pSelf->m_LuckyBtn.Hide();
            m_pSelf->m_MoneyBtn.Show();
            break;
        case 5:
            m_pSelf->m_ExpBtn.Hide();
            m_pSelf->m_RandomBtn.Show();
            m_pSelf->m_ItemBtn.Show();
            m_pSelf->m_PointBtn.Hide();
            m_pSelf->m_LuckyBtn.Hide();
            m_pSelf->m_MoneyBtn.Show();
            break;
        case 6:
            m_pSelf->m_ExpBtn.Show();
            m_pSelf->m_RandomBtn.Hide();
            m_pSelf->m_ItemBtn.Hide();
            m_pSelf->m_PointBtn.Show();
            m_pSelf->m_LuckyBtn.Show();
            m_pSelf->m_MoneyBtn.Hide();
            break;
        case 7:
            m_pSelf->m_ExpBtn.Hide();
            m_pSelf->m_RandomBtn.Show();
            m_pSelf->m_ItemBtn.Hide();
            m_pSelf->m_PointBtn.Show();
            m_pSelf->m_LuckyBtn.Hide();
            m_pSelf->m_MoneyBtn.Show();
            break;
        case 8:
            m_pSelf->m_ExpBtn.Show();
            m_pSelf->m_RandomBtn.Hide();
            m_pSelf->m_ItemBtn.Hide();
            m_pSelf->m_PointBtn.Hide();
            m_pSelf->m_LuckyBtn.Show();
            m_pSelf->m_MoneyBtn.Show();
        case 9:
            m_pSelf->m_ExpBtn.Hide();
            m_pSelf->m_RandomBtn.Show();
            m_pSelf->m_ItemBtn.Hide();
            m_pSelf->m_PointBtn.Hide();
            m_pSelf->m_LuckyBtn.Show();
            m_pSelf->m_MoneyBtn.Show();
        case 10:
            m_pSelf->m_ExpBtn.Hide();
            m_pSelf->m_RandomBtn.Show();
            m_pSelf->m_ItemBtn.Show();
            m_pSelf->m_PointBtn.Hide();
            m_pSelf->m_LuckyBtn.Show();
            m_pSelf->m_MoneyBtn.Hide();
    }
}

// -------------------------------------------------------------------------
// Hien thi dong text len hop thoai
// -------------------------------------------------------------------------
void KUiDaTau::UpdateNotice() {
    m_Notice.SetText("C¸c h¹ ®· vÊt v¶, xin mêi c¸c h¹ chän phÇn th­ëng!");
}

// -------------------------------------------------------------------------
// Xu ly khi hop thoai dang mo
/*
    if (nScript == 1)
{
sprintf(ScriptName,"\\script\\system\\datau\\quest_exp.lua");
g_DebugLog("quest_exp.lua->nScript: %d", nScript);
}
else if (nScript == 2)
{
sprintf(ScriptName,"\\script\\system\\datau\\quest_item.lua");
g_DebugLog("quest_item.lua->nScript: %d", nScript);
}
else if (nScript == 3)
{
sprintf(ScriptName,"\\script\\system\\datau\\quest_luck.lua");
g_DebugLog("quest_luck.lua->nScript: %d", nScript);
}
else if (nScript == 4)
{
sprintf(ScriptName,"\\script\\system\\datau\\quest_money.lua");
g_DebugLog("quest_money.lua->nScript: %d", nScript);
}
else if (nScript == 5)
{
sprintf(ScriptName,"\\script\\system\\datau\\quest_point.lua");
g_DebugLog("quest_point.lua->nScript: %d", nScript);
}
else if (nScript == 6)
{
sprintf(ScriptName,"\\script\\system\\datau\\quest_random.lua");
g_DebugLog("quest_random.lua->nScript: %d", nScript);
*/
// -------------------------------------------------------------------------
int KUiDaTau::WndProc(unsigned int uMsg, unsigned int uParam, int nParam) {
    int nRet = 0;
    switch (uMsg) {
        case WND_N_BUTTON_CLICK:
            if (uParam == (unsigned int) (KWndWindow *) &m_ExpBtn) {
                g_pCoreShell->OperationRequest(GOI_CP_LOAD_SCRIPT, 1, 0);
                CloseWindow();
            } else if (uParam == (unsigned int) (KWndWindow *) &m_ItemBtn) {
                g_pCoreShell->OperationRequest(GOI_CP_LOAD_SCRIPT, 2, 0);
                CloseWindow();
            } else if (uParam == (unsigned int) (KWndWindow *) &m_LuckyBtn) {
                g_pCoreShell->OperationRequest(GOI_CP_LOAD_SCRIPT, 3, 0);
                CloseWindow();
            } else if (uParam == (unsigned int) (KWndWindow *) &m_MoneyBtn) {
                g_pCoreShell->OperationRequest(GOI_CP_LOAD_SCRIPT, 4, 0);
                CloseWindow();
            } else if (uParam == (unsigned int) (KWndWindow *) &m_PointBtn) {
                g_pCoreShell->OperationRequest(GOI_CP_LOAD_SCRIPT, 5, 0);
                CloseWindow();
            } else if (uParam == (unsigned int) (KWndWindow *) &m_RandomBtn) {
                g_pCoreShell->OperationRequest(GOI_CP_LOAD_SCRIPT, 6, 0);
                CloseWindow();
            }
            break;
        default:
            nRet = KWndShowAnimate::WndProc(uMsg, uParam, nParam);
    }
    return nRet;
}


