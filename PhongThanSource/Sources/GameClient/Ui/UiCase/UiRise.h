/*****************************************************************************************
//	UiRise.h
//	Author	:   AlexKing
//	CreateTime:	11/7/2018
------------------------------------------------------------------------------------------
		Khung duc vat pham
*****************************************************************************************/
#pragma once

#include "../Elem/WndPage.h"
#include "../Elem/WndButton.h"
#include "../Elem/WndText.h"
#include "../Elem/WndShowAnimate.h"
#include "../elem/WndObjContainer.h"
#include "../Elem/WndLabeledButton.h"
#include "../Elem/WndEdit.h"
#include "../Elem/WndMessageListBox.h"

#define _ITEM_BUILDF_COUNT        4
#define _ITEM_INCREF_COUNT        4
#define _ITEM_INCREH_COUNT        4

#define MAX_RISE_TYPE            2
#define    _RISEINDEX_NUM            50

struct KUiObjAtRegion;

enum RISESTATUS {
    enumType_Select,
    enumLevel_Select,
};

class KUiIncreHPad : public KWndPage {
public:
    void Initialize();

    void LoadScheme();

    void CleanItem();

    void UpdateDataObjBox();

    void UpdateDataMatrixBox();

    void UpdateItemObjBox(KUiObjAtRegion *pItem, int bAdd);

    void UpdateItemMatrixBox(KUiObjAtRegion *pItem, int bAdd);

private:
    int WndProc(unsigned int uMsg, unsigned int uParam, int nParam);

    void OnItemPickDrop(ITEM_PICKDROP_PLACE *pPickPos, ITEM_PICKDROP_PLACE *pDropPos);

    BOOL EnoughItemPickDrop(KWndWindow *pWnd, int nIndex, int nTypeBox);

    void OnSelectType(int nIndex);

    void SetHorseType(int nIndex, int nSel);

    void LoadIndexList();

    void UpdateData(int nIndex, int nPab);

    void OnOk();

private:
    KWndObjectBox m_Box[_ITEM_BUILDF_COUNT];
    KWndObjectMatrix m_ItemBox;
    KWndLabeledButton m_IncreBtn;
    KWndLabeledButton m_CancleBtn;
    KWndButton m_HourseL[MAX_RISE_TYPE];
    char szLevel[10][32];
    char szHorse[30][64];
    int nCount[MAX_RISE_TYPE];
    KWndText80 m_HorseTxt[MAX_RISE_TYPE];
    KWndText80 m_TypeText;

    typedef struct _IndexData {
        char szName[128];
        char szIni[128];
        char szIniSection[128];
        int nP1, nP2;
    } IndexData;

    IndexData m_IndexData[_RISEINDEX_NUM];
    int nCurHor;
    int nCurLv;
    KWndMessageListBox m_MessageList;
    KWndScrollBar m_MessageScroll;
    char ArrayReturnInfo[2][64];
};

class KUiRise : public KWndPageSet {
public:
    static KUiRise *OpenWindow();

    static KUiRise *GetIfVisible();

    static void CloseWindow(bool bDestroy);

    KUiIncreHPad m_IncreHPad;

    static void LoadScheme();

    void UpdateDataObjBox();

    void UpdateDataMatrixBox();

    void UpdateItemObjBox(KUiObjAtRegion *pItem, int bAdd);

    void UpdateItemMatrixBox(KUiObjAtRegion *pItem, int bAdd);

private:
    KUiRise();

    ~KUiRise();

    void Initialize();

    int WndProc(unsigned int uMsg, unsigned int uParam, int nParam);

    void ShowPage();

    void OnCancel();

private:
    static KUiRise *m_pSelf;
private:
    KWndLabeledButton m_IncreHBtn;
    KWndButton m_Close;
    BYTE m_nCurPage;
};
