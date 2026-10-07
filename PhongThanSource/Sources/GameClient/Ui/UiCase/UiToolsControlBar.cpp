/*****************************************************************************************
*****************************************************************************************/
#include "KWin32.h"
#include "KIniFile.h"
#include "../elem/wnds.h"
#include "../Elem/WndMessage.h"
#include "../UiBase.h"
#include "UiToolsControlBar.h"
#include "UiChatCentre.h"
#include "UiTaskNote.h"

#include "../ShortcutKey.h"
#include "../../../core/src/coreshell.h"
#include "../../../Engine/src/KDebug.h"
#include "GameDataDef.h"

extern iCoreShell *g_pCoreShell;

#define    SCHEME_INI            "gong_ju_kong_zhi_tiao.ini"
#define    PHONGTHAN_VNG_TOOLBAR_INI "\\Ui\\Ui4\\gong_ju_kong_zhi_tiao.ini"

char szArray_NormalPK[][64] =
        {
                "LuyÖn c«ng",
                "ChiÕn ®Êu",
                "§å s¸t",
//	"Bang chiÕn"
        };

KUiToolsControlBar *KUiToolsControlBar::m_pSelf = NULL;

//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
KUiToolsControlBar *KUiToolsControlBar::OpenWindow() {
    if (m_pSelf == NULL) {
        m_pSelf = new KUiToolsControlBar;
        if (m_pSelf)
            m_pSelf->Initialize();
    }
    if (m_pSelf)
        m_pSelf->Show();
    return m_pSelf;
}

//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
void KUiToolsControlBar::CloseWindow() {
    if (m_pSelf) {
        m_pSelf->Destroy();
        m_pSelf = NULL;
    }
}


void KUiToolsControlBar::Initialize() {
    char Scheme[256];
    g_UiBase.GetCurSchemePath(Scheme, 256);
    LoadScheme(Scheme);

    m_Style &= ~WND_S_VISIBLE;
    Wnd_AddWindow(this, WL_LOWEST);
}


void KUiToolsControlBar::LoadScheme(const char *pScheme) {
    char Buff[128];
    KIniFile Ini;
    if (m_pSelf) {
        // Bind the runtime window to the official Phong Than Ui4 PAK entry.
        // A loose Ui3 file cannot override PAK-first resource resolution.
        BOOL bLoaded = Ini.Load(PHONGTHAN_VNG_TOOLBAR_INI);
        if (!bLoaded && pScheme && pScheme[0]) {
            sprintf(Buff, "%s\\%s", pScheme, SCHEME_INI);
            bLoaded = Ini.Load(Buff);
        }

        if (bLoaded) {
            // Add the missing VNG cash-shop control in memory.  Player_IBShop
            // supplies the original SPR path from the active PAK chain.
            Ini.WriteString("Main", "Button13", "IBShop");
            Ini.WriteInteger("IBShop", "Left", 390);
            Ini.WriteInteger("IBShop", "Top", 0);
            Ini.WriteInteger("IBShop", "Width", 48);
            Ini.WriteInteger("IBShop", "Height", 50);
            Ini.WriteInteger("IBShop", "Trans", 0);
            Ini.WriteInteger("IBShop", "Up", 0);
            Ini.WriteInteger("IBShop", "Down", 1);
            Ini.WriteInteger("IBShop", "Over", 1);
            Ini.WriteInteger("IBShop", "OverFrame", 2);
            Ini.WriteString("IBShop", "ClassType", "Player_IBShop");
            m_pSelf->Init(&Ini, "Main");

            // Native 1024x768 layout: keep the original artwork size and
            // center it against the real bottom edge of the client area.
            int nScreenWidth = 800;
            int nScreenHeight = 600;
            int nWidth = 0;
            int nHeight = 0;
            Wnd_GetScreenSize(nScreenWidth, nScreenHeight);
            m_pSelf->GetSize(&nWidth, &nHeight);
            if (nWidth > 0 && nHeight > 0)
                m_pSelf->SetPosition(nScreenWidth - nWidth,
                                     nScreenHeight - nHeight - 2);
        }
    }
}

int KUiToolsControlBar::WndProc(unsigned int uMsg, unsigned int uParam, int nParam) {
    int nRet = 0;
    switch (uMsg) {
        case WND_N_BUTTON_CLICK:
            break;
        case WND_M_MENUITEM_SELECTED:
            if (uParam == (unsigned int) (KWndWindow *) this) {
                if ((short) (LOWORD(nParam) >= 0))
                    SwitchPK((short) (LOWORD(nParam)));
            }
            break;
        default:
            nRet = KWndImage::WndProc(uMsg, uParam, nParam);
    }
    return nRet;
}

void KUiToolsControlBar::DefaultScheme(const char *pScheme) {
    char Buff[128];
    KIniFile Ini;
    if (m_pSelf) {
        BOOL bLoaded = Ini.Load(PHONGTHAN_VNG_TOOLBAR_INI);
        if (!bLoaded && pScheme && pScheme[0]) {
            sprintf(Buff, "%s\\%s", pScheme, SCHEME_INI);
            bLoaded = Ini.Load(Buff);
        }
        if (bLoaded) {
            int nValue1, nValue2;
            Ini.GetInteger("Main", "Left", 0, &nValue1);
            Ini.GetInteger("Main", "Top", 0, &nValue2);
            int nScreenWidth, nScreenHeight, nWidth, nHeight;
            Wnd_GetScreenSize(nScreenWidth, nScreenHeight);
            m_pSelf->GetSize(&nWidth, &nHeight);
            m_pSelf->SetPosition(nScreenWidth - nWidth, nScreenHeight - nHeight - 2);
        }
    }
}

void KUiToolsControlBar::Breathe() {
    UpdateData();
}

void KUiToolsControlBar::SwitchPK() {
    int nActionDataCount = sizeof(szArray_NormalPK) / sizeof(szArray_NormalPK[0]);
    struct KPopupMenuData *pSelUnitMenu = (KPopupMenuData *) malloc(MENU_DATA_SIZE(nActionDataCount));
    if (pSelUnitMenu == NULL)
        return;
    KPopupMenu::InitMenuData(pSelUnitMenu, nActionDataCount);
    pSelUnitMenu->nNumItem = 0;
    pSelUnitMenu->usMenuFlag |= PM_F_AUTO_DEL_WHEN_HIDE;

    int bTongFlag = g_pCoreShell->TongOperation(GTOI_TONG_FLAG, 0, 0);
    for (int i = 0; i < nActionDataCount; i++) {
        if (i == enumPKTongWar && !bTongFlag)
            continue;
        strncpy(pSelUnitMenu->Items[pSelUnitMenu->nNumItem].szData, szArray_NormalPK[i], sizeof(szArray_NormalPK[i]));
        pSelUnitMenu->Items[pSelUnitMenu->nNumItem].szData[sizeof(pSelUnitMenu->Items[pSelUnitMenu->nNumItem].szData) -
                                                           1] = 0;
        pSelUnitMenu->Items[pSelUnitMenu->nNumItem].uDataLen = strlen(
                pSelUnitMenu->Items[pSelUnitMenu->nNumItem].szData);
        pSelUnitMenu->nNumItem++;
    }
    int x, y;
    Wnd_GetCursorPos(&x, &y);
    pSelUnitMenu->nX = x;
    pSelUnitMenu->nY = y;
    KPopupMenu::Popup(pSelUnitMenu, m_pSelf, 0);
}


void KUiToolsControlBar::SwitchFastPK() {
    int nPKSet = g_pCoreShell->GetGameData(GDI_PK_SETTING, NULL, NULL);
    if (nPKSet != enumPKNormal && nPKSet != enumPKWar)
        g_pCoreShell->OperationRequest(GOI_PK_SETTING, 0, enumPKNormal);
    else {
        if (nPKSet == enumPKNormal)
            g_pCoreShell->OperationRequest(GOI_PK_SETTING, 0, enumPKWar);
        else
            g_pCoreShell->OperationRequest(GOI_PK_SETTING, 0, enumPKNormal);
    }
}

void KUiToolsControlBar::SwitchPK(int nPKSet) {
    switch (nPKSet) {
        case Exercises:
            g_pCoreShell->OperationRequest(GOI_PK_SETTING, 0, enumPKNormal);
            break;
        case Fighting:
            g_pCoreShell->OperationRequest(GOI_PK_SETTING, 0, enumPKWar);
            break;
        case Murder:
            g_pCoreShell->OperationRequest(GOI_PK_SETTING, 0, enumPKMurder);
            break;
        case Tongwar:
            g_pCoreShell->OperationRequest(GOI_PK_SETTING, 0, enumPKTongWar);
            break;
    }
}

