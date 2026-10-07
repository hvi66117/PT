/*****************************************************************************************
//	UiComPound.h
//	Author	:   AlexKing
//	CreateTime:	11/7/2018
------------------------------------------------------------------------------------------
		Khung kham nam do tim
*****************************************************************************************/
#pragma once

#include "../Elem/WndPage.h"
#include "../Elem/WndButton.h"
#include "../Elem/WndText.h"
#include "../Elem/WndShowAnimate.h"
#include "../elem/WndObjContainer.h"
#include "../Elem/WndLabeledButton.h"
#include "../Elem/WndEdit.h"

#define EFFECT_COUNT    2
#define _ITEM_DISTILL_COUNT        4
#define _ITEM_FORGE_COUNT        4
#define _ITEM_ENCHASE_COUNT        4

struct KUiObjAtRegion;
struct KUiComPoundCmd;

class KUiDistillPad : public KWndPage {
public:
    void Initialize();

    void LoadScheme(class KIniFile *pIni);

    void Breathe();

    void CleanItem();

    void UpdateDataObjBox();

    void UpdateDataMatrixBox();

    void UpdateItemObjBox(KUiObjAtRegion *pItem, int bAdd);

    void UpdateItemMatrixBox(KUiObjAtRegion *pItem, int bAdd);

private:
    int WndProc(unsigned int uMsg, unsigned int uParam, int nParam);

    void StartEffect();

    void StopEffect();

    BOOL IsEffect();

    void OnOk();

    void UpdatePickPut(bool bLock);

    BOOL EnoughItemToGo();

    void OnItemPickDrop(ITEM_PICKDROP_PLACE *pPickPos, ITEM_PICKDROP_PLACE *pDropPos);

    BOOL EnoughItemPickDrop(KWndWindow *pWnd, int nIndex, int nTypeBox);

private:
    KWndObjectBox m_Box[_ITEM_DISTILL_COUNT];
    KWndObjectMatrix m_ItemBox;

    KWndImage m_Effect[EFFECT_COUNT];
    KWndLabeledButton m_DistillBtn;
    KWndLabeledButton m_CancleDTBtn;
    unsigned int m_EffectTime; //thoi gian trinh dien hieu ung

    enum STRING_NOTE_EVENT {
        ISP_DO_EVENT = 0x100,
    };
    char ArrayReturnInfo[8][64];
};

class KUiForgePad : public KWndPage {
public:
    void Initialize();

    void LoadScheme(class KIniFile *pIni);

    void Breathe();

    void CleanItem();

    void UpdateDataObjBox();

    void UpdateItemObjBox(KUiObjAtRegion *pItem, int bAdd);

private:
    int WndProc(unsigned int uMsg, unsigned int uParam, int nParam);

    void StartEffect();

    void StopEffect();

    BOOL IsEffect();

    void OnOk();

    void UpdatePickPut(bool bLock);

    BOOL EnoughItemToGo();

    void OnItemPickDrop(ITEM_PICKDROP_PLACE *pPickPos, ITEM_PICKDROP_PLACE *pDropPos);

    BOOL EnoughItemPickDrop(KWndWindow *pWnd, int nIndex);

private:
    KWndObjectBox m_Box[_ITEM_FORGE_COUNT];

    KWndImage m_Effect[EFFECT_COUNT - 1];
    KWndLabeledButton m_ForgeBtn;
    KWndLabeledButton m_CancleFGBtn;
    unsigned int m_EffectTime; //thoi gian trinh dien hieu ung

    enum STRING_NOTE_EVENT {
        ISP_DO_EVENT = 0x100,
    };
    char ArrayReturnInfo[6][64];
};


class KUiEnchasePad : public KWndPage {
public:
    void Initialize();

    void LoadScheme(class KIniFile *pIni);

    void Breathe();

    void CleanItem();

    void UpdateDataObjBox();

    void UpdateDataMatrixBox();

    void UpdateItemObjBox(KUiObjAtRegion *pItem, int bAdd);

    void UpdateItemMatrixBox(KUiObjAtRegion *pItem, int bAdd);

private:
    int WndProc(unsigned int uMsg, unsigned int uParam, int nParam);

    void StartEffect();

    void StopEffect();

    BOOL IsEffect();

    void OnOk();

    void UpdatePickPut(bool bLock);

    BOOL EnoughItemToGo();

    void OnItemPickDrop(ITEM_PICKDROP_PLACE *pPickPos, ITEM_PICKDROP_PLACE *pDropPos);

    BOOL EnoughItemPickDrop(KWndWindow *pWnd, int nIndex, int nTypeBox);

private:
    KWndObjectBox m_Box[_ITEM_ENCHASE_COUNT];
    KWndObjectMatrix m_ItemBox;

    KWndImage m_Effect[EFFECT_COUNT];
    KWndLabeledButton m_EnchaseBtn;
    KWndLabeledButton m_CancleECBtn;
    unsigned int m_EffectTime; //thoi gian trinh dien hieu ung

    enum STRING_NOTE_EVENT {
        ISP_DO_EVENT = 0x100,
    };
    char ArrayReturnInfo[8][64];
};

class KUiComPound : public KWndPageSet {
public:
    static KUiComPound *OpenWindow();

    static KUiComPound *GetIfVisible();

    static void CloseWindow(bool bDestroy);

    static void LoadScheme(const char *pScheme);

    KUiDistillPad m_DistillPad;
    KUiForgePad m_ForgePad;
    KUiEnchasePad m_EnchasePad;

    void UpdateDataObjBox();

    void UpdateDataMatrixBox();

    void UpdateItemObjBox(KUiObjAtRegion *pItem, int bAdd);

    void UpdateItemMatrixBox(KUiObjAtRegion *pItem, int bAdd);

public:
    KWndButton m_Close;
    BYTE m_nCurPage;

    KWndLabeledButton m_DistillBtn;
    KWndLabeledButton m_ForgeBtn;
    KWndLabeledButton m_EnchaseBtn;
private:
    KUiComPound();

    ~KUiComPound();

    void Initialize();

    void LoadScheme(class KIniFile *pIni);

    int WndProc(unsigned int uMsg, unsigned int uParam, int nParam);

    void Breathe();

    void ShowPage();

    void OnCancel();

private:
    static KUiComPound *m_pSelf;
private:

};
