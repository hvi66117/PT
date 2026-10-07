#pragma once

#include "../Elem/WndShowAnimate.h"
#include "../elem/wndbutton.h"
#include "../Elem/WndText.h"
#include "../elem/wndObjContainer.h"

struct KUiObjAtContRegion;

class KUiToiUuImage : protected KWndShowAnimate {
public:

    static KUiToiUuImage *OpenWindow();

    static KUiToiUuImage *GetIfVisible();

    static void CloseWindow();

    static void LoadScheme(const char *pScheme);

    static void Cancel();

    void UpdateData();

    int WndProc(unsigned int uMsg, unsigned int uParam, int nParam);

private:
    KUiToiUuImage();

    ~KUiToiUuImage() {}

    void SetPage(int nIndex);

    void Clear();

    void OnClickButton(KWndButton *pWnd, int bCheck);

    void OnBuyItem(KUiDraggedObject *pItem, bool bDoImmed);

    void Initialize();

    void OnHideNpc();

    void OnHidePlayer();

    void OnHideSkill();

    BOOL IsHide;
private:
    static KUiToiUuImage *m_pSelf;
private:
    KUiObjAtContRegion *m_pObjsList;
    int m_nObjCount;
    int m_nPageCount;
    int m_nCurrentPage;
    KWndObjectMatrix m_ItemsBox;

    KWndText32 m_TitleText;
    KWndText32 m_HideNpc;
    KWndText32 m_HidePlayer;
    KWndButton m_HideNpcBtn;
    KWndButton m_HidePlayerBtn;
    KWndButton m_CloseBtn;
};
