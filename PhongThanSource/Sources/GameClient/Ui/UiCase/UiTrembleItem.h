/*******************************************************************************
File        : UiTrembleItem.h
Creator     : TamLTM || AWJX
create data : 01.05.2014
Chuc nang	: Kham nam trang bi xanh
********************************************************************************/
#pragma once

#include "../elem/wndbutton.h"
#include "../elem/wndtext.h"
#include "../elem/WndObjContainer.h"
#include "../elem/wndlabeledbutton.h"
#include "../elem/wndimage.h"
#include "../../../core/src/gamedatadef.h"
#include "../Elem/WndShowAnimate.h"

#define _ITEM_TREMBLE_COUNT 9

struct KUiObjAtRegion;

class KCanGetNumImage : public KWndImage {
public:
    int GetMaxFrame();

    int GetCurrentFrame();
};

class KUiTrembleItem : public KWndShowAnimate {
public:
    static KUiTrembleItem *OpenWindow();      //??????
    static KUiTrembleItem *GetIfVisible();    //??????????????????????????
    static void CloseWindow(bool bDestory = TRUE); //?????????????????????????????
    static void LoadScheme(const char *pScheme);   //?????????
    void UpdateData();

    void UpdateItem(KUiObjAtRegion *pItem, int bAdd);

private:
    static KUiTrembleItem *m_pSelf;
private:
    KUiTrembleItem() {}

    ~KUiTrembleItem() {}

    void Initialize();

    virtual int WndProc(unsigned int uMsg, unsigned int uParam, int nParam);

    virtual void Breathe();

    void OnItemPickDrop(ITEM_PICKDROP_PLACE *pPickPos, ITEM_PICKDROP_PLACE *pDropPos);

    void StartEffect();

    void StopEffect();

    BOOL IsEffect();

    void OnOk();

    void OnCancel();

    void UpdatePickPut(bool bLock);

    BOOL EnoughItemPickDrop(KWndWindow *pWnd, int nIndex);

    BOOL EnoughItemToGo();

private:
    KWndObjectBox m_TrembleBox[_ITEM_TREMBLE_COUNT];
    KWndLabeledButton m_Confirm;                         //????t
    KWndLabeledButton m_Cancel;                          //????t
    KWndImage m_TrembleEffect;
    unsigned int m_EffectTime; //thoi gian trinh dien hieu ung
    char ArrayReturnInfo[8][128];

    enum STRING_NOTE_EVENT {
        ISP_DO_EVENT = 0x100,
    };
};
