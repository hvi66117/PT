#pragma once

#if !defined _SHOWITEM
#define _SHOWITEM

#include "../Elem/WndButton.h"
#include "../Elem/WndEdit.h"
#include "../elem/WndPureTextBtn.h"
#include "../../../core/src/GameDataDef.h"

class KUiChatItem : public KWndWindow {
public:
    static KUiChatItem *OpenWindow(int uId);

    static void CloseWindow(bool bDestory);

    static KUiChatItem *GetIfVisible();

    void LoadScheme(const char *pScheme);

private:
    KUiChatItem();

    ~KUiChatItem() {}

    void PaintWindow();

    int WndProc(unsigned int uMsg, unsigned int uParam, int nParam);

    void Initialize();

    void Updatedata(int uId);

    void Show();

    void Hide();

private:
    static KUiChatItem *m_pSelf;
private:
    unsigned int m_nBgColor;
    unsigned short m_nBgAlpha;
    unsigned short m_nRectColor;
    char m_sBgItemColor[32];
    unsigned short m_nBgItemAlpha;
    char pItemDesc[GOD_MAX_OBJ_TITLE_LEN];
    short pItemLen;
    short nMaxLineLen;
    short nNumLine;
    KRUImagePart m_Image;
    short m_nImgWidth;
    short m_nImgHeight;
    KRUImagePart m_IconImage;
    KRUImagePart m_LockImage;
    char m_szIconImage[MAX_PATH];
    int m_nIconWidth;
    int m_nIconHeight;
    KRURect Rect;
    BYTE nKind;
    bool m_bLock;
};

#endif
