#include "KWin32.h"
#include "KIniFile.h"
#include "KTabFile.h"
#include "KStrBase.h"
#include "../Elem/Wnds.h"
#include "../Elem/WndMessage.h"
#include "../Elem/MouseHover.h"
#include "UiChatItem.h"
#include "../UiBase.h"
#include "../UiSoundSetting.h"
#include "../../../Represent/iRepresent/iRepresentShell.h"
#include "../../../Represent/iRepresent/KRepresentUnit.h"
#include "../../../Engine/src/Text.h"
#include "../../../Engine/src/KDebug.h"
#include "../../../Engine/src/KRandom.h"
#include "../../../core/src/coreshell.h"
#include <crtdbg.h>

extern iRepresentShell *g_pRepresentShell;
extern iCoreShell *g_pCoreShell;
#define        SCHEME_INI_CHATITEM            "UiChatItemInfo.ini"

KUiChatItem *KUiChatItem::m_pSelf = NULL;

KUiChatItem *KUiChatItem::OpenWindow(int uId) {
    if (m_pSelf == NULL) {
        m_pSelf = new KUiChatItem;
        if (m_pSelf)
            m_pSelf->Initialize();
    }

    if (m_pSelf) {
        m_pSelf->Updatedata(uId);
        m_pSelf->Show();
        m_pSelf->BringToTop();
    }
    return m_pSelf;
}

void KUiChatItem::CloseWindow(bool bDestory) {
    if (m_pSelf) {
        if (bDestory) {
            m_pSelf->Destroy();
            m_pSelf = NULL;
        } else
            m_pSelf->Hide();
    }
}

KUiChatItem::KUiChatItem() {
    m_nBgColor = 0;
    m_nBgAlpha = 0;
    memset(&m_sBgItemColor, 0, sizeof(m_sBgItemColor));
    pItemLen = 0;
    pItemDesc[0] = 0;
    nNumLine = 0;
    nMaxLineLen = 0;
    memset(&m_Image, 0, sizeof(KRUImage));
    m_nImgWidth = 0;
    m_nImgHeight = 0;
    memset(&m_IconImage, 0, sizeof(KRUImage));
    ZeroMemory(m_szIconImage, sizeof(m_szIconImage));
    m_nIconWidth = 0;
    m_nIconHeight = 0;
    m_bLock = false;
    memset(&m_LockImage, 0, sizeof(KRUImage));
}


KUiChatItem *KUiChatItem::GetIfVisible() {
    if (m_pSelf && m_pSelf->IsVisible())
        return m_pSelf;
    else
        return NULL;
}


void KUiChatItem::Initialize() {
    char szScheme[128];
    g_UiBase.GetCurSchemePath(szScheme, sizeof(szScheme));
    LoadScheme(szScheme);
    Wnd_AddWindow(this, WL_TOPMOST);
}


int KUiChatItem::WndProc(unsigned int uMsg, unsigned int uParam, int nParam) {
    int nResult = false;
    switch (uMsg) {
        case WM_LBUTTONDOWN:
            Hide();
            nResult = true;
        case WM_RBUTTONDOWN:
        case WM_KEYDOWN:
            break;
        default:
            nResult = KWndWindow::WndProc(uMsg, uParam, nParam);
            break;
    }
    return nResult;
}

void KUiChatItem::LoadScheme(const char *pScheme) {
    char Buff[128];
    KIniFile Ini;

    sprintf(Buff, "%s\\%s", pScheme, SCHEME_INI_CHATITEM);

    if (Ini.Load(Buff)) {
        Init(&Ini, "Main");
        Ini.GetString("Main", "BgColor", "0,0,0", Buff, 128);
        m_nBgColor = (GetColor(Buff) & 0x00ffffff);
        Ini.GetInteger("Main", "BgAlpha", 0, (int *) &m_nBgAlpha);
        m_nBgColor |= (m_nBgAlpha << 24);

        Ini.GetInteger("Border", "ImgWidth", 0, (int *) &m_nImgWidth);
        Ini.GetInteger("Border", "ImgHeight", 0, (int *) &m_nImgHeight);
        if (m_nImgWidth < 0)
            m_nImgWidth = 0;
        if (m_nImgHeight < 0)
            m_nImgHeight = 0;
        m_Image.nType = ISI_T_SPR;
        m_Image.bRenderStyle = IMAGE_RENDER_STYLE_ALPHA;
        m_Image.Color.Color_b.a = 255;
        m_Image.uImage = 0;
        m_Image.nISPosition = IMAGE_IS_POSITION_INIT;
        Ini.GetString("Border", "Image", "", m_Image.szImage, sizeof(m_Image.szImage));
        m_Image.nFrame = 0;

        Ini.GetString("ItemImage", "RectItemColor", "0,0,0", Buff, 128);
        m_nRectColor = (GetColor(Buff) & 0x00ffffff);
        Ini.GetString("ItemImage", "BgItemColor", "0,0,0", m_sBgItemColor, 128);
        Ini.GetInteger("ItemImage", "BgItemAlpha", 0, (int *) &m_nBgItemAlpha);
    }
    return;
}

#define PREFIX_SIZE 25

void KUiChatItem::PaintWindow() {
    KWndWindow::PaintWindow();

    KRUShadow Shadow;
    KOutputTextParam Param;
    Param.BorderColor = 0xff000000;
    Param.nZ = TEXT_IN_SINGLE_PLANE_COORD;

    Shadow.Color.Color_dw = m_nBgColor;
    Shadow.oPosition.nX = m_nAbsoluteLeft;

    Shadow.oPosition.nY = m_nAbsoluteTop;
    Shadow.oEndPos.nX = m_nAbsoluteLeft + m_Width + m_nImgWidth / 2 + m_nIconWidth * 25;
    Shadow.oEndPos.nY = m_nAbsoluteTop + m_Height;
    Shadow.oEndPos.nZ = Shadow.oPosition.nZ = 0;
    int m_nWndWidth = Shadow.oEndPos.nX - Shadow.oPosition.nX;
    int m_nWndHeight = Shadow.oEndPos.nY - Shadow.oPosition.nY;
    if (m_nWndWidth % m_nImgWidth != 0)
        Shadow.oEndPos.nX += (m_nImgWidth - (m_nWndWidth % m_nImgWidth));
    if (m_nWndHeight < 100)
        Shadow.oEndPos.nY += 20;
    m_Image.oPosition.nX = Shadow.oPosition.nX;
    while (m_Image.oPosition.nX < Shadow.oPosition.nX + m_nWndWidth) {
        m_Image.oPosition.nY = Shadow.oPosition.nY - m_nImgHeight;
        g_pRepresentShell->DrawPrimitives(1, &m_Image, RU_T_IMAGE, true);
        m_Image.oPosition.nY = Shadow.oEndPos.nY;
        g_pRepresentShell->DrawPrimitives(1, &m_Image, RU_T_IMAGE, true);
        m_Image.oPosition.nX += m_nImgWidth;
    };

    Param.nSkipLine = 0;
    Param.nNumLine = 1;
    Param.Color = 0xffffffff;
    Param.nY = Shadow.oPosition.nY;

    if (pItemLen > 0) {
        g_pRepresentShell->DrawPrimitives(1, &Shadow, RU_T_SHADOW, true);
        int nLineLen;
        while (true) {
            if (TGetEncodedTextLineCount(pItemDesc, pItemLen, 0, nLineLen, NORMAL_FONTSIZE, Param.nSkipLine, 1) == 0)
                break;
            Param.nX = 10 +
                       (m_nAbsoluteLeft + m_Width / 2 - (nLineLen * NORMAL_FONTSIZE) / 4 + m_nIconWidth * PREFIX_SIZE);
            g_pRepresentShell->OutputRichText(NORMAL_FONTSIZE, &Param, pItemDesc, pItemLen, 0);
            Param.nSkipLine++;
            Param.nY += NORMAL_FONTSIZE + 1;
        };
        Rect.Color.Color_dw = m_nRectColor;
        Rect.oPosition.nX = 2 + Shadow.oPosition.nX;
        Rect.oPosition.nY = 2 + Shadow.oPosition.nY;
        Rect.oEndPos.nX = 4 + Rect.oPosition.nX + m_nIconWidth * PREFIX_SIZE;
        Rect.oEndPos.nY = 4 + Rect.oPosition.nY + m_nIconHeight * PREFIX_SIZE;
        Rect.oEndPos.nZ = Rect.oPosition.nZ = 0;
        g_pRepresentShell->DrawPrimitives(1, &Rect, RU_T_RECT, true);

        KRUShadow bg;
        bg.oPosition.nX = Rect.oPosition.nX + 1;
        bg.oPosition.nY = Rect.oPosition.nY + 1;
        bg.Color.Color_dw = (GetColor("0,93,57") & 0xffffff) | ((150 << 21) & 0xff000000);
        bg.oEndPos.nX = Rect.oEndPos.nX;
        bg.oEndPos.nY = Rect.oEndPos.nY;
        g_pRepresentShell->DrawPrimitives(1, &bg, RU_T_SHADOW, true);

        m_IconImage.oPosition.nX = 4 + Shadow.oPosition.nX;
        m_IconImage.oPosition.nY = 4 + Shadow.oPosition.nY;
        g_pRepresentShell->DrawPrimitives(1, &m_IconImage, RU_T_IMAGE, true);

        if (m_bLock) {
            m_LockImage.oPosition.nX = m_IconImage.oPosition.nX;
            m_LockImage.oPosition.nY = m_IconImage.oPosition.nY;
            g_pRepresentShell->DrawPrimitives(1, &m_LockImage, RU_T_IMAGE, true);
        }
    }
}

void KUiChatItem::Show() {
    nNumLine = TGetEncodedTextLineCount(pItemDesc, pItemLen, 0, (int &) nMaxLineLen, NORMAL_FONTSIZE);
    m_Width = NORMAL_FONTSIZE * nMaxLineLen / 2 + PREFIX_SIZE - 5;
    m_Height = (NORMAL_FONTSIZE + 1) * nNumLine;

    if (m_Height < m_nIconHeight * PREFIX_SIZE + 6)
        m_Height = m_nIconHeight * PREFIX_SIZE + 12;

    m_IconImage.nType = ISI_T_SPR;
    m_IconImage.bRenderStyle = IMAGE_RENDER_STYLE_ALPHA;
    m_IconImage.Color.Color_b.a = 255;
    m_IconImage.uImage = 0;
    m_IconImage.nISPosition = IMAGE_IS_POSITION_INIT;
    m_IconImage.nFrame = 0;
    ::strcpy(m_IconImage.szImage, m_szIconImage);

    m_LockImage.nType = ISI_T_SPR;
    m_LockImage.bRenderStyle = IMAGE_RENDER_STYLE_ALPHA;
    m_LockImage.Color.Color_b.a = 255;
    m_LockImage.uImage = 0;
    m_LockImage.nISPosition = IMAGE_IS_POSITION_INIT;
    m_LockImage.nFrame = 0;
    ::strcpy(m_LockImage.szImage, "\\Spr\\Ui3\\button\\lock.spr");

    int nLeft = RESOLUTION_WIDTH / 2 - m_Width / 2;
    int nTop = RESOLUTION_HEIGHT / 2 - m_Height / 2 - PREFIX_SIZE;

    SetPosition(nLeft < 0 ? 0 : nLeft, nTop < 0 ? 0 : nTop);
    KWndWindow::Show();
}

void KUiChatItem::Updatedata(int uId) {
    if (uId) {
        g_pCoreShell->GetGameData(GDI_ITEM_DESC, (unsigned int) &pItemDesc, uId);
        pItemLen = TEncodeText(pItemDesc, strlen(pItemDesc));

        g_pCoreShell->GetGameData(GDI_CHAT_ITEM_IMAGE, (unsigned int) &m_szIconImage, uId);
        g_pCoreShell->GetSizeItem(uId, &m_nIconWidth, &m_nIconHeight);

        /*	if (g_pCoreShell->GetBindItem(uId) == 2)
                m_bLock = true;*/
    }
}

void KUiChatItem::Hide() {
    pItemLen = 0;
    pItemDesc[0] = 0;
    nNumLine = 0;
    nMaxLineLen = 0;
    memset(&m_IconImage, 0, sizeof(KRUImage));
    ZeroMemory(m_szIconImage, sizeof(m_szIconImage));
    memset(&m_LockImage, 0, sizeof(KRUImage));
    m_nIconWidth = 0;
    m_nIconHeight = 0;
    m_bLock = false;
    KWndWindow::Hide();
}

