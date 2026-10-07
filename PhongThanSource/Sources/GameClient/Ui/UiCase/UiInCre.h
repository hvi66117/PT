/*****************************************************************************************
//	UiInCre.h
//	Author	:   AlexKing
//	CreateTime:	11/7/2018
------------------------------------------------------------------------------------------
		Duc trang bi
*****************************************************************************************/
#pragma once

#include "../Elem/WndPage.h"
#include "../Elem/WndButton.h"
#include "../Elem/WndText.h"
#include "../Elem/WndShowAnimate.h"
#include "../elem/WndObjContainer.h"
#include "../Elem/WndLabeledButton.h"
#include "../Elem/WndEdit.h"
#include "../Elem/WndScrollBar.h"
#include "../Elem/WndList2.h"
#include "../Elem/WndMessageListBox.h"

#define _ITEM_BUILD_COUNT        4
#define _ITEM_INCRE_COUNT        4
#define    _INCREINDEX_NUM            250

struct KUiObjAtRegion;

typedef struct _IndexData {
    char szName[128];
    char szIni[128];
    char szIniSection[128];
    int nNode;
    int nP1, nP2;
} IndexData;

class KUiBuildFPad : public KWndPage {
public:
    void Initialize();

    void LoadScheme(class KIniFile *pIni);

    void UpdateDataObjBox();

    void UpdateDataMatrixBox();

    void UpdateItemObjBox(KUiObjAtRegion *pItem, int bAdd);

    void UpdateItemMatrixBox(KUiObjAtRegion *pItem, int bAdd);

private:
    int WndProc(unsigned int uMsg, unsigned int uParam, int nParam);

    void OnItemPickDrop(ITEM_PICKDROP_PLACE *pPickPos, ITEM_PICKDROP_PLACE *pDropPos);

    void CleanItem();

    void OnOk();

    void LoadIndexList();

    void UpdateData(int nIndex);

private:
    KWndObjectBox m_Box[_ITEM_BUILD_COUNT];
    KWndObjectMatrix m_ItemBox;

    KWndLabeledButton m_BuildBtn;
    KWndLabeledButton m_CancleBtn;
    KWndImage m_BK[2];

    KWndText32 m_ItemText;
    KWndText32 m_InputText;

    KWndList2 m_IndexList;
    KWndScrollBar m_IndexScroll;
    KWndMessageListBox m_MessageList;
    KWndScrollBar m_MessageScroll;
    IndexData m_IndexData[_INCREINDEX_NUM];
};

class KUiInCreFPad : public KWndPage {
public:
    void Initialize();

    void LoadScheme(class KIniFile *pIni);

    void UpdateDataObjBox();

    void UpdateDataMatrixBox();

    void UpdateItemObjBox(KUiObjAtRegion *pItem, int bAdd);

    void UpdateItemMatrixBox(KUiObjAtRegion *pItem, int bAdd);

private:
    int WndProc(unsigned int uMsg, unsigned int uParam, int nParam);

    void OnItemPickDrop(ITEM_PICKDROP_PLACE *pPickPos, ITEM_PICKDROP_PLACE *pDropPos);

    void CleanItem();

    void OnOk();

    void LoadIndexList();

    void UpdateData(int nIndex);

private:
    KWndObjectBox m_Box[_ITEM_INCRE_COUNT];
    KWndObjectMatrix m_ItemBox;

    KWndLabeledButton m_InCreBtn;
    KWndLabeledButton m_CancleBtn;
    KWndImage m_BK[2];

    KWndText32 m_ItemText;
    KWndText32 m_InputText;

    KWndList2 m_IndexList;
    KWndScrollBar m_IndexScroll;
    KWndMessageListBox m_MessageList;
    KWndScrollBar m_MessageScroll;
    IndexData m_IndexData[_INCREINDEX_NUM];
};

class KUiBuildPad : public KWndPage {
public:
    void Initialize();

    void LoadScheme(class KIniFile *pIni);

    void UpdateDataObjBox();

    void UpdateDataMatrixBox();

    void UpdateItemObjBox(KUiObjAtRegion *pItem, int bAdd);

    void UpdateItemMatrixBox(KUiObjAtRegion *pItem, int bAdd);

private:
    int WndProc(unsigned int uMsg, unsigned int uParam, int nParam);

    void OnItemPickDrop(ITEM_PICKDROP_PLACE *pPickPos, ITEM_PICKDROP_PLACE *pDropPos);

    void CleanItem();

    void OnOk();

    void LoadIndexList();

    void UpdateData(int nIndex);

private:
    KWndObjectBox m_Box[_ITEM_BUILD_COUNT];
    KWndObjectMatrix m_ItemBox;

    KWndLabeledButton m_BuildBtn;
    KWndLabeledButton m_CancleBtn;
    KWndImage m_BK[2];

    KWndText32 m_ItemText;
    KWndText32 m_InputText;

    KWndList2 m_IndexList;
    KWndScrollBar m_IndexScroll;
    KWndMessageListBox m_MessageList;
    KWndScrollBar m_MessageScroll;
    IndexData m_IndexData[_INCREINDEX_NUM];
};

class KUiInCrePad : public KWndPage {
public:
    void Initialize();

    void LoadScheme(class KIniFile *pIni);

    void UpdateDataObjBox();

    void UpdateDataMatrixBox();

    void UpdateItemObjBox(KUiObjAtRegion *pItem, int bAdd);

    void UpdateItemMatrixBox(KUiObjAtRegion *pItem, int bAdd);

private:
    int WndProc(unsigned int uMsg, unsigned int uParam, int nParam);

    void OnItemPickDrop(ITEM_PICKDROP_PLACE *pPickPos, ITEM_PICKDROP_PLACE *pDropPos);

    void CleanItem();

    void OnOk();

    void LoadIndexList();

    void UpdateData(int nIndex);

private:
    KWndObjectBox m_Box[_ITEM_INCRE_COUNT];
    KWndObjectMatrix m_ItemBox;

    KWndLabeledButton m_InCreBtn;
    KWndLabeledButton m_CancleBtn;
    KWndImage m_BK[2];

    KWndText32 m_ItemText;
    KWndText32 m_InputText;

    KWndList2 m_IndexList;
    KWndScrollBar m_IndexScroll;
    KWndMessageListBox m_MessageList;
    KWndScrollBar m_MessageScroll;
    IndexData m_IndexData[_INCREINDEX_NUM];
};

class KUiInCre : public KWndPageSet {
public:
    static KUiInCre *OpenWindow(BYTE nKind);

    static KUiInCre *GetIfVisible();

    static void CloseWindow(bool bDestroy);

    static void LoadScheme(const char *pScheme);

    KUiBuildPad m_BuildPad;
    KUiInCrePad m_InCrePad;
    KUiBuildFPad m_BuildFPad;
    KUiInCreFPad m_InCreFPad;

    void UpdateDataObjBox();

    void UpdateDataMatrixBox();

    void UpdateItemObjBox(KUiObjAtRegion *pItem, int bAdd);

    void UpdateItemMatrixBox(KUiObjAtRegion *pItem, int bAdd);

    void ShowPage(BYTE nKind);

public:
    KWndButton m_Close;
    BYTE m_nCurPage;
    KWndLabeledButton m_BuildBtn;
    KWndLabeledButton m_InCreBtn;

    KWndLabeledButton m_BuildFBtn;
    KWndLabeledButton m_InCreFBtn;
private:
    KUiInCre();

    ~KUiInCre();

    void Initialize();

    void LoadScheme(class KIniFile *pIni);

    int WndProc(unsigned int uMsg, unsigned int uParam, int nParam);

    void ShowPage();

    void OnCancel();

private:
    static KUiInCre *m_pSelf;
private:

};
