/*****************************************************************************************
//	UiInCre.cpp
//	Author	:   AlexKing
//	CreateTime:	11/7/2018
------------------------------------------------------------------------------------------
		Duc trang bi
*****************************************************************************************/

#include "KWin32.h"
#include "KIniFile.h"
#include "../Elem/WndMessage.h"
#include "../elem/wnds.h"
#include "UiInCre.h"
#include "UiItem.h"
#include "UiInformation.h"
#include "UiMsgCentrePad.h"
#include "../ShortcutKey.h"
#include "../UiSoundSetting.h"
#include "../../../core/src/coreshell.h"
#include "../UiBase.h"
#include <crtdbg.h>
#include "../../../core/src/gamedatadef.h"

extern iCoreShell *g_pCoreShell;

#define    SCHEME_INI            "UiInCre.ini"
#define    DETAIL_BUILD        "\\Ui\\BuildHelp.ini"
#define    DETAIL_INCRE        "\\Ui\\InCreHelp.ini"

/******************************************************************************************
**********************************************************************************************/
static struct UE_CTRL_MAP_BUF {
    int nPosition;
    const char *pIniSection;
}

        CtrlItemMapBUF[_ITEM_BUILD_COUNT] =
        {
                {UIEP_COMPOUNDITEM1, "BigBoxBUF"},
                {UIEP_COMPOUNDITEM2, "SmallBoxBUF1"},
                {UIEP_COMPOUNDITEM3, "SmallBoxBUF2"},
                {UIEP_COMPOUNDITEM4, "SmallBoxBUF3"},
        };

void KUiBuildFPad::Initialize() {
    int i = 0;
    for (i = 0; i < _ITEM_BUILD_COUNT; i++) {
        m_Box[i].SetObjectGenre(CGOG_ITEM);
        AddChild(&m_Box[i]);
        m_Box[i].SetContainerId((int) UOC_COMPOUND_ITEM);
    }
    for (i = 0; i < 2; i++)
        AddChild(&m_BK[i]);

    AddChild(&m_ItemBox);
    AddChild(&m_BuildBtn);
    AddChild(&m_CancleBtn);

    AddChild(&m_ItemText);
    AddChild(&m_InputText);

    AddChild(&m_IndexList);
    AddChild(&m_IndexScroll);
    m_IndexList.SetScrollbar(&m_IndexScroll);

    AddChild(&m_MessageList);
    AddChild(&m_MessageScroll);
    m_MessageList.SetScrollbar(&m_MessageScroll);

    m_ItemBox.SetContainerId((int) UOC_AFFAIR_ITEM);
    Wnd_AddWindow(this);
}

void KUiBuildFPad::LoadScheme(class KIniFile *pIni) {
    char Buff[32];
    int i = 0;
    KWndPage::Init(pIni, "BuildFMain");
    for (i = 0; i < _ITEM_BUILD_COUNT; i++) {
        m_Box[i].Init(pIni, CtrlItemMapBUF[i].pIniSection);
    }

    for (i = 0; i < 2; i++) {
        sprintf(Buff, "BK_%d", i + 1);
        m_BK[i].Init(pIni, Buff);
    }
    m_ItemBox.Init(pIni, "ItemBox");
//	m_ItemBox		.BringToTop();
    m_BuildBtn.Init(pIni, "BuildPBtn");
    m_CancleBtn.Init(pIni, "CancleBBtn");

    m_ItemText.Init(pIni, "ItemText");
    m_InputText.Init(pIni, "InputText");

    m_IndexList.Init(pIni, "IndexList");
    m_IndexScroll.Init(pIni, "IndexScroll");
    m_MessageScroll.Init(pIni, "ContentScroll");
    m_MessageList.Init(pIni, "ContentList");

    LoadIndexList();
}

int KUiBuildFPad::WndProc(unsigned int uMsg, unsigned int uParam, int nParam) {
    switch (uMsg) {
        case WND_N_BUTTON_CLICK:
            if (uParam == (unsigned int) &m_BuildBtn)
                OnOk();
            else if (uParam == (unsigned int) &m_CancleBtn)
                CleanItem();
            break;
        case WND_N_ITEM_PICKDROP:
            if (g_UiBase.IsOperationEnable(UIS_O_MOVE_ITEM))
                OnItemPickDrop((ITEM_PICKDROP_PLACE *) uParam, (ITEM_PICKDROP_PLACE *) nParam);
            break;
        case WND_M_OTHER_WORK_RESULT:
            break;
            // scrollbar's position changed.
        case WND_N_SCORLLBAR_POS_CHANGED:
            if (uParam == (unsigned int) (KWndWindow *) &m_IndexScroll)
                m_IndexList.SetTopItemIndex(nParam);
            else if (uParam == (unsigned int) (KWndWindow *) &m_MessageScroll)
                m_MessageList.SetFirstShowLine(nParam);
            break;
            // list's click
        case WND_N_LIST_ITEM_SEL:
            if (uParam == (unsigned int) (KWndWindow *) &m_IndexList) {
                int nIndex = nParam;
                if (nIndex < 0)
                    nIndex = 0;
                // Get the content of "nParam" index.
                UpdateData(nIndex);
            }
            break;
        case WM_KEYDOWN: {
            int nCurIdx = 0;
            int nTotal = 0;

            nCurIdx = m_IndexList.GetCurSel();
            nTotal = m_IndexList.GetCount();
            switch (uParam) {
                case VK_UP:
                    if (nCurIdx == 0)
                        nCurIdx = nTotal;
                    nCurIdx = nCurIdx - 1;
                    m_IndexList.SetCurSel(nCurIdx);
                    m_IndexScroll.SetScrollPos(m_IndexList.GetTopItemIndex());
                    break;
                case VK_DOWN:
                    if (nCurIdx == nTotal - 1)
                        nCurIdx = -1;
                    nCurIdx = nCurIdx + 1;
                    m_IndexList.SetCurSel(nCurIdx);
                    m_IndexScroll.SetScrollPos(m_IndexList.GetTopItemIndex());
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            return KWndPage::WndProc(uMsg, uParam, nParam);
    }
    return 0;
}

void KUiBuildFPad::LoadIndexList() {
    KIniFile ListIni;
    int nCount;
    char szInifile[128] = "";
    if (!ListIni.Load(DETAIL_BUILD))
        return;

    memset(m_IndexData, 0, sizeof(m_IndexData));
    ListIni.GetInteger("ListFF", "Count", 0, &nCount);
    for (int i = 0; i < nCount; i++) {
        char szName[32] = "";
        char szIni[32] = "";
        char szIniSection[32] = "";
        char szNode[32] = "";
        char szPos[32] = "";

        sprintf(szName, "%d_Name", i);
        sprintf(szIni, "%d_Ini", i);
        sprintf(szIniSection, "%d_IniSection", i);
        sprintf(szNode, "%d_Node", i);
        sprintf(szPos, "%d_Pos", i);
        ListIni.GetString("ListFF", szName, "", m_IndexData[i].szName, 128);
        ListIni.GetString("ListFF", szIni, "", m_IndexData[i].szIni, 128);
        ListIni.GetString("ListFF", szIniSection, "", m_IndexData[i].szIniSection, 128);
        ListIni.GetInteger("ListFF", szNode, 0, &m_IndexData[i].nNode);
        ListIni.GetInteger2("ListFF", szPos, &m_IndexData[i].nP1, &m_IndexData[i].nP2);
        m_IndexList.AddString(i, m_IndexData[i].szName, m_IndexData[i].nNode > 0);
    }
}

void KUiBuildFPad::UpdateData(int nIndex) {
    KIniFile Ini;
    char Scheme[256];
    char szIniFile[128];
    g_UiBase.GetCurSchemePath(Scheme, 256);
    sprintf(szIniFile, "%s\\%s", Scheme, m_IndexData[nIndex].szIni);

    if (Ini.Load(szIniFile)) {
        m_MessageList.SetFirstShowLine(0);
        m_MessageScroll.SetScrollPos(0);
        MsgListBox_LoadContent(&m_MessageList, &Ini,
                               m_IndexData[nIndex].szIniSection);
    }
}


void KUiBuildFPad::OnOk() {
    KUiInPutBoxCmd pCmd;
    int nCurIdx = m_IndexList.GetCurSel();
//	memset(pCmd.szStr,0,sizeof(pCmd.szStr));
    pCmd.nNum[0] = m_IndexData[nCurIdx].nP1;
    pCmd.nNum[1] = m_IndexData[nCurIdx].nP2;
    strcpy(pCmd.szFunc, "main");
    if (g_pCoreShell)
        g_pCoreShell->OperationRequest(GOI_INPUT_INFO, 7, (unsigned int) (&pCmd));
}

void KUiBuildFPad::CleanItem() {
    if (g_pCoreShell) {
        int nCount;
        KUiObjAtRegion Item[_ITEM_BUILD_COUNT];
        nCount = g_pCoreShell->GetGameData(GDI_COMPOUND_ITEM, (unsigned int) &Item, 0);
        if (nCount)
            g_pCoreShell->OperationRequest(GOI_RECOVERY_BOX_COMMAND, pos_compound_item, 0);
        nCount = g_pCoreShell->GetGameData(GDI_AFFAIR_ITEM, 0, 0);
        if (nCount)
            g_pCoreShell->OperationRequest(GOI_RECOVERY_BOX_COMMAND, pos_affairitem, 0);
    }
}

void KUiBuildFPad::UpdateItemObjBox(KUiObjAtRegion *pItem, int bAdd) {
    if (pItem) {
        for (int i = 0; i < _ITEM_BUILD_COUNT; i++) {
            if (CtrlItemMapBUF[i].nPosition == pItem->Region.v) {
                if (bAdd)
                    m_Box[i].HoldObject(pItem->Obj.uGenre, pItem->Obj.uId,
                                        pItem->Region.Width, pItem->Region.Height);
                else
                    m_Box[i].HoldObject(CGOG_NOTHING, 0, 0, 0);
                break;
            }
        }
    }
}

void KUiBuildFPad::UpdateDataObjBox() {
    KUiObjAtRegion Item[_ITEM_BUILD_COUNT];
    int nCount = g_pCoreShell->GetGameData(GDI_COMPOUND_ITEM, (unsigned int) &Item, 0);
    int i;
    for (i = 0; i < _ITEM_BUILD_COUNT; i++)
        m_Box[i].Celar();
    for (i = 0; i < nCount; i++) {
        if (Item[i].Obj.uGenre != CGOG_NOTHING)
            UpdateItemObjBox(&Item[i], true);
    }
}

void KUiBuildFPad::UpdateItemMatrixBox(KUiObjAtRegion *pItem, int bAdd) {
    if (pItem) {
        UiSoundPlay(UI_SI_PICKPUT_ITEM);
        if (pItem->Obj.uGenre != CGOG_MONEY) {
            KUiDraggedObject Obj;
            Obj.uGenre = pItem->Obj.uGenre;
            Obj.uId = pItem->Obj.uId;
            Obj.DataX = pItem->Region.h;
            Obj.DataY = pItem->Region.v;
            Obj.DataW = pItem->Region.Width;
            Obj.DataH = pItem->Region.Height;
            if (bAdd)
                m_ItemBox.AddObject(&Obj, 1);
            else
                m_ItemBox.RemoveObject(&Obj);
        }
    } else
        UpdateDataMatrixBox();
}

void KUiBuildFPad::UpdateDataMatrixBox() {
    m_ItemBox.Clear();

    KUiObjAtRegion *pObjs = NULL;

    int nCount = g_pCoreShell->GetGameData(GDI_AFFAIR_ITEM, 0, 0);
    if (nCount <= 0)
        return;

    if (pObjs = (KUiObjAtRegion *) malloc(sizeof(KUiObjAtRegion) * nCount)) {
        g_pCoreShell->GetGameData(GDI_AFFAIR_ITEM, (unsigned int) pObjs, nCount);
        for (int i = 0; i < nCount; i++)
            UpdateItemMatrixBox(&pObjs[i], true);
        free(pObjs);
        pObjs = NULL;
    }
}


void KUiBuildFPad::OnItemPickDrop(ITEM_PICKDROP_PLACE *pPickPos, ITEM_PICKDROP_PLACE *pDropPos) {
    KUiObjAtContRegion Drop, Pick;
    KUiDraggedObject Obj;
    KWndWindow *pWnd = NULL;

    UISYS_STATUS eStatus = g_UiBase.GetStatus();
    if (pPickPos) {
        if (pPickPos->TypeItemBox == 1) {
            ((KWndObjectBox *) (pPickPos->pWnd))->GetObject(Obj);
            Pick.Obj.uGenre = Obj.uGenre;
            Pick.Obj.uId = Obj.uId;
            Pick.Region.Width = Obj.DataW;
            Pick.Region.Height = Obj.DataH;
            Pick.Region.h = 0;
            Pick.eContainer = UOC_COMPOUND_ITEM;
            pWnd = pPickPos->pWnd;
        } else if (pPickPos->TypeItemBox == 0) {
            _ASSERT(pPickPos->pWnd);
            ((KWndObjectMatrix *) (pPickPos->pWnd))->GetObject(
                    Obj, pPickPos->h, pPickPos->v);
            Pick.Obj.uGenre = Obj.uGenre;
            Pick.Obj.uId = Obj.uId;
            Pick.Region.Width = Obj.DataW;
            Pick.Region.Height = Obj.DataH;
            Pick.Region.h = Obj.DataX;
            Pick.Region.v = Obj.DataY;
            Pick.eContainer = UOC_AFFAIR_ITEM;
        }

    } else if (pDropPos) {
        pWnd = pDropPos->pWnd;
    } else
        return;

    if (pDropPos) {
        if (pDropPos->TypeItemBox == 1) {
            Wnd_GetDragObj(&Obj);
            Drop.Obj.uGenre = Obj.uGenre;
            Drop.Obj.uId = Obj.uId;
            Drop.Region.Width = Obj.DataW;
            Drop.Region.Height = Obj.DataH;
            Drop.Region.h = 0;
            Drop.eContainer = UOC_COMPOUND_ITEM;
        } else if (pDropPos->TypeItemBox == 0) {
            Wnd_GetDragObj(&Obj);
            Drop.Obj.uGenre = Obj.uGenre;
            Drop.Obj.uId = Obj.uId;
            Drop.Region.Width = Obj.DataW;
            Drop.Region.Height = Obj.DataH;
            Drop.Region.h = pDropPos->h;
            Drop.Region.v = pDropPos->v;
            Drop.eContainer = UOC_AFFAIR_ITEM;
        }
    }

    for (int i = 0; i < _ITEM_INCRE_COUNT; i++) {
        if (pWnd == (KWndWindow *) &m_Box[i]) {
            Drop.Region.v = Pick.Region.v = CtrlItemMapBUF[i].nPosition;
            break;
        }
    }

    g_pCoreShell->OperationRequest(GOI_SWITCH_OBJECT,
                                   pPickPos ? (unsigned int) &Pick : 0,
                                   pDropPos ? (int) &Drop : 0);
}

/******************************************************************************************
**********************************************************************************************/
static struct UE_CTRL_MAP_ICF {
    int nPosition;
    const char *pIniSection;
}

        CtrlItemMapICF[_ITEM_INCRE_COUNT] =
        {
                {UIEP_COMPOUNDITEM1, "BigBoxCRF"},
                {UIEP_COMPOUNDITEM2, "SmallBoxCRF1"},
                {UIEP_COMPOUNDITEM3, "SmallBoxCRF2"},
                {UIEP_COMPOUNDITEM4, "SmallBoxCRF3"},
        };

void KUiInCreFPad::Initialize() {
    int i = 0;
    for (i = 0; i < _ITEM_INCRE_COUNT; i++) {
        m_Box[i].SetObjectGenre(CGOG_ITEM);
        AddChild(&m_Box[i]);
        m_Box[i].SetContainerId((int) UOC_COMPOUND_ITEM);
    }
    for (i = 0; i < 2; i++)
        AddChild(&m_BK[i]);
    AddChild(&m_ItemBox);
    AddChild(&m_InCreBtn);
    AddChild(&m_CancleBtn);

    AddChild(&m_ItemText);
    AddChild(&m_InputText);

    AddChild(&m_IndexList);
    AddChild(&m_IndexScroll);
    m_IndexList.SetScrollbar(&m_IndexScroll);

    AddChild(&m_MessageList);
    AddChild(&m_MessageScroll);
    m_MessageList.SetScrollbar(&m_MessageScroll);

    m_ItemBox.SetContainerId((int) UOC_AFFAIR_ITEM);
    Wnd_AddWindow(this);
}

void KUiInCreFPad::LoadScheme(class KIniFile *pIni) {
    char Buff[32];
    int i = 0;
    KWndPage::Init(pIni, "InCreFMain");
    for (i = 0; i < _ITEM_INCRE_COUNT; i++) {
        m_Box[i].Init(pIni, CtrlItemMapICF[i].pIniSection);
    }

    for (i = 0; i < 2; i++) {
        sprintf(Buff, "BK_%d", i + 1);
        m_BK[i].Init(pIni, Buff);
    }
    m_ItemBox.Init(pIni, "ItemBox");
    m_ItemBox.BringToTop();
    m_InCreBtn.Init(pIni, "InCrePBtn");
    m_CancleBtn.Init(pIni, "CancleCBtn");

    m_ItemText.Init(pIni, "ItemText");
    m_InputText.Init(pIni, "InputText");

    m_IndexList.Init(pIni, "IndexList");
    m_IndexScroll.Init(pIni, "IndexScroll");
    m_MessageScroll.Init(pIni, "ContentScroll");
    m_MessageList.Init(pIni, "ContentList");

    LoadIndexList();
}

int KUiInCreFPad::WndProc(unsigned int uMsg, unsigned int uParam, int nParam) {
    switch (uMsg) {
        case WND_N_BUTTON_CLICK:
            if (uParam == (unsigned int) &m_InCreBtn)
                OnOk();
            else if (uParam == (unsigned int) &m_CancleBtn)
                CleanItem();
            break;
        case WND_N_ITEM_PICKDROP:
            if (g_UiBase.IsOperationEnable(UIS_O_MOVE_ITEM))
                OnItemPickDrop((ITEM_PICKDROP_PLACE *) uParam, (ITEM_PICKDROP_PLACE *) nParam);
            break;
        case WND_M_OTHER_WORK_RESULT:
            break;
            // scrollbar's position changed.
        case WND_N_SCORLLBAR_POS_CHANGED:
            if (uParam == (unsigned int) (KWndWindow *) &m_IndexScroll)
                m_IndexList.SetTopItemIndex(nParam);
            else if (uParam == (unsigned int) (KWndWindow *) &m_MessageScroll)
                m_MessageList.SetFirstShowLine(nParam);
            break;
            // list's click
        case WND_N_LIST_ITEM_SEL:
            if (uParam == (unsigned int) (KWndWindow *) &m_IndexList) {
                int nIndex = nParam;
                if (nIndex < 0)
                    nIndex = 0;
                // Get the content of "nParam" index.
                UpdateData(nIndex);
            }
            break;
        case WM_KEYDOWN: {
            int nCurIdx = 0;
            int nTotal = 0;

            nCurIdx = m_IndexList.GetCurSel();
            nTotal = m_IndexList.GetCount();
            switch (uParam) {
                case VK_UP:
                    if (nCurIdx == 0)
                        nCurIdx = nTotal;
                    nCurIdx = nCurIdx - 1;
                    m_IndexList.SetCurSel(nCurIdx);
                    m_IndexScroll.SetScrollPos(m_IndexList.GetTopItemIndex());
                    break;
                case VK_DOWN:
                    if (nCurIdx == nTotal - 1)
                        nCurIdx = -1;
                    nCurIdx = nCurIdx + 1;
                    m_IndexList.SetCurSel(nCurIdx);
                    m_IndexScroll.SetScrollPos(m_IndexList.GetTopItemIndex());
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            return KWndPage::WndProc(uMsg, uParam, nParam);
    }
    return 0;
}

void KUiInCreFPad::LoadIndexList() {
    KIniFile ListIni;
    int nCount;
    char szInifile[128] = "";

    if (!ListIni.Load(DETAIL_INCRE))
        return;

    memset(m_IndexData, 0, sizeof(m_IndexData));
    ListIni.GetInteger("ListFF", "Count", 0, &nCount);
    for (int i = 0; i < nCount; i++) {
        char szName[32] = "";
        char szIni[32] = "";
        char szIniSection[32] = "";
        char szNode[32] = "";
        char szPos[32] = "";

        sprintf(szName, "%d_Name", i);
        sprintf(szIni, "%d_Ini", i);
        sprintf(szIniSection, "%d_IniSection", i);
        sprintf(szNode, "%d_Node", i);
        sprintf(szPos, "%d_Pos", i);
        ListIni.GetString("ListFF", szName, "", m_IndexData[i].szName, 128);
        ListIni.GetString("ListFF", szIni, "", m_IndexData[i].szIni, 128);
        ListIni.GetString("ListFF", szIniSection, "", m_IndexData[i].szIniSection, 128);
        ListIni.GetInteger("ListFF", szNode, 0, &m_IndexData[i].nNode);
        ListIni.GetInteger2("ListFF", szPos, &m_IndexData[i].nP1, &m_IndexData[i].nP2);
        m_IndexList.AddString(i, m_IndexData[i].szName, m_IndexData[i].nNode > 0);
    }
}

void KUiInCreFPad::UpdateData(int nIndex) {
    KIniFile Ini;
    char Scheme[256];
    char szIniFile[128];
    g_UiBase.GetCurSchemePath(Scheme, 256);
    sprintf(szIniFile, "%s\\%s", Scheme, m_IndexData[nIndex].szIni);

    if (Ini.Load(szIniFile)) {
        m_MessageList.SetFirstShowLine(0);
        m_MessageScroll.SetScrollPos(0);
        MsgListBox_LoadContent(&m_MessageList, &Ini,
                               m_IndexData[nIndex].szIniSection);
    }
}


void KUiInCreFPad::OnOk() {
    KUiInPutBoxCmd pCmd;
    int nCurIdx = m_IndexList.GetCurSel();
//	memset(pCmd.szStr,0,sizeof(pCmd.szStr));
    pCmd.nNum[0] = m_IndexData[nCurIdx].nP1;
    pCmd.nNum[1] = m_IndexData[nCurIdx].nP2;
    strcpy(pCmd.szFunc, "main");
    if (g_pCoreShell)
        g_pCoreShell->OperationRequest(GOI_INPUT_INFO, 7, (unsigned int) (&pCmd));
}

void KUiInCreFPad::CleanItem() {
    if (g_pCoreShell) {
        int nCount;
        KUiObjAtRegion Item[_ITEM_INCRE_COUNT];
        nCount = g_pCoreShell->GetGameData(GDI_COMPOUND_ITEM, (unsigned int) &Item, 0);
        if (nCount)
            g_pCoreShell->OperationRequest(GOI_RECOVERY_BOX_COMMAND, pos_compound_item, 0);
        nCount = g_pCoreShell->GetGameData(GDI_AFFAIR_ITEM, 0, 0);
        if (nCount)
            g_pCoreShell->OperationRequest(GOI_RECOVERY_BOX_COMMAND, pos_affairitem, 0);
    }
}

void KUiInCreFPad::UpdateItemObjBox(KUiObjAtRegion *pItem, int bAdd) {
    if (pItem) {
        for (int i = 0; i < _ITEM_INCRE_COUNT; i++) {
            if (CtrlItemMapICF[i].nPosition == pItem->Region.v) {
                if (bAdd)
                    m_Box[i].HoldObject(pItem->Obj.uGenre, pItem->Obj.uId,
                                        pItem->Region.Width, pItem->Region.Height);
                else
                    m_Box[i].HoldObject(CGOG_NOTHING, 0, 0, 0);
                break;
            }
        }
    }
}

void KUiInCreFPad::UpdateDataObjBox() {
    KUiObjAtRegion Item[_ITEM_INCRE_COUNT];
    int nCount = g_pCoreShell->GetGameData(GDI_COMPOUND_ITEM, (unsigned int) &Item, 0);
    int i;
    for (i = 0; i < _ITEM_INCRE_COUNT; i++)
        m_Box[i].Celar();
    for (i = 0; i < nCount; i++) {
        if (Item[i].Obj.uGenre != CGOG_NOTHING)
            UpdateItemObjBox(&Item[i], true);
    }
}

void KUiInCreFPad::UpdateItemMatrixBox(KUiObjAtRegion *pItem, int bAdd) {
    if (pItem) {
        UiSoundPlay(UI_SI_PICKPUT_ITEM);
        if (pItem->Obj.uGenre != CGOG_MONEY) {
            KUiDraggedObject Obj;
            Obj.uGenre = pItem->Obj.uGenre;
            Obj.uId = pItem->Obj.uId;
            Obj.DataX = pItem->Region.h;
            Obj.DataY = pItem->Region.v;
            Obj.DataW = pItem->Region.Width;
            Obj.DataH = pItem->Region.Height;
            if (bAdd)
                m_ItemBox.AddObject(&Obj, 1);
            else
                m_ItemBox.RemoveObject(&Obj);
        }
    } else
        UpdateDataMatrixBox();
}

void KUiInCreFPad::UpdateDataMatrixBox() {
    m_ItemBox.Clear();

    KUiObjAtRegion *pObjs = NULL;

    int nCount = g_pCoreShell->GetGameData(GDI_AFFAIR_ITEM, 0, 0);
    if (nCount <= 0)
        return;

    if (pObjs = (KUiObjAtRegion *) malloc(sizeof(KUiObjAtRegion) * nCount)) {
        g_pCoreShell->GetGameData(GDI_AFFAIR_ITEM, (unsigned int) pObjs, nCount);
        for (int i = 0; i < nCount; i++)
            UpdateItemMatrixBox(&pObjs[i], true);
        free(pObjs);
        pObjs = NULL;
    }
}


void KUiInCreFPad::OnItemPickDrop(ITEM_PICKDROP_PLACE *pPickPos, ITEM_PICKDROP_PLACE *pDropPos) {
    KUiObjAtContRegion Drop, Pick;
    KUiDraggedObject Obj;
    KWndWindow *pWnd = NULL;

    UISYS_STATUS eStatus = g_UiBase.GetStatus();
    if (pPickPos) {
        if (pPickPos->TypeItemBox == 1) {
            ((KWndObjectBox *) (pPickPos->pWnd))->GetObject(Obj);
            Pick.Obj.uGenre = Obj.uGenre;
            Pick.Obj.uId = Obj.uId;
            Pick.Region.Width = Obj.DataW;
            Pick.Region.Height = Obj.DataH;
            Pick.Region.h = 0;
            Pick.eContainer = UOC_COMPOUND_ITEM;
            pWnd = pPickPos->pWnd;
        } else if (pPickPos->TypeItemBox == 0) {
            _ASSERT(pPickPos->pWnd);
            ((KWndObjectMatrix *) (pPickPos->pWnd))->GetObject(
                    Obj, pPickPos->h, pPickPos->v);
            Pick.Obj.uGenre = Obj.uGenre;
            Pick.Obj.uId = Obj.uId;
            Pick.Region.Width = Obj.DataW;
            Pick.Region.Height = Obj.DataH;
            Pick.Region.h = Obj.DataX;
            Pick.Region.v = Obj.DataY;
            Pick.eContainer = UOC_AFFAIR_ITEM;
        }

    } else if (pDropPos) {
        pWnd = pDropPos->pWnd;
    } else
        return;

    if (pDropPos) {
        if (pDropPos->TypeItemBox == 1) {
            Wnd_GetDragObj(&Obj);
            Drop.Obj.uGenre = Obj.uGenre;
            Drop.Obj.uId = Obj.uId;
            Drop.Region.Width = Obj.DataW;
            Drop.Region.Height = Obj.DataH;
            Drop.Region.h = 0;
            Drop.eContainer = UOC_COMPOUND_ITEM;
        } else if (pDropPos->TypeItemBox == 0) {
            Wnd_GetDragObj(&Obj);
            Drop.Obj.uGenre = Obj.uGenre;
            Drop.Obj.uId = Obj.uId;
            Drop.Region.Width = Obj.DataW;
            Drop.Region.Height = Obj.DataH;
            Drop.Region.h = pDropPos->h;
            Drop.Region.v = pDropPos->v;
            Drop.eContainer = UOC_AFFAIR_ITEM;
        }
    }

    for (int i = 0; i < _ITEM_INCRE_COUNT; i++) {
        if (pWnd == (KWndWindow *) &m_Box[i]) {
            Drop.Region.v = Pick.Region.v = CtrlItemMapICF[i].nPosition;
            break;
        }
    }

    g_pCoreShell->OperationRequest(GOI_SWITCH_OBJECT,
                                   pPickPos ? (unsigned int) &Pick : 0,
                                   pDropPos ? (int) &Drop : 0);
}

/******************************************************************************************
**********************************************************************************************/
static struct UE_CTRL_MAP_BU {
    int nPosition;
    const char *pIniSection;
}

        CtrlItemMapBU[_ITEM_BUILD_COUNT] =
        {
                {UIEP_COMPOUNDITEM1, "BigBoxBU"},
                {UIEP_COMPOUNDITEM2, "SmallBoxBU1"},
                {UIEP_COMPOUNDITEM3, "SmallBoxBU2"},
                {UIEP_COMPOUNDITEM4, "SmallBoxBU3"},
        };

void KUiBuildPad::Initialize() {
    int i = 0;
    for (i = 0; i < _ITEM_BUILD_COUNT; i++) {
        m_Box[i].SetObjectGenre(CGOG_ITEM);
        AddChild(&m_Box[i]);
        m_Box[i].SetContainerId((int) UOC_COMPOUND_ITEM);
    }
    for (i = 0; i < 2; i++)
        AddChild(&m_BK[i]);

    AddChild(&m_ItemBox);
    AddChild(&m_BuildBtn);
    AddChild(&m_CancleBtn);

    AddChild(&m_ItemText);
    AddChild(&m_InputText);

    AddChild(&m_IndexList);
    AddChild(&m_IndexScroll);
    m_IndexList.SetScrollbar(&m_IndexScroll);

    AddChild(&m_MessageList);
    AddChild(&m_MessageScroll);
    m_MessageList.SetScrollbar(&m_MessageScroll);

    m_ItemBox.SetContainerId((int) UOC_AFFAIR_ITEM);
    Wnd_AddWindow(this);
}

void KUiBuildPad::LoadScheme(class KIniFile *pIni) {
    char Buff[32];
    int i = 0;
    KWndPage::Init(pIni, "BuildMain");
    for (i = 0; i < _ITEM_BUILD_COUNT; i++) {
        m_Box[i].Init(pIni, CtrlItemMapBU[i].pIniSection);
    }

    for (i = 0; i < 2; i++) {
        sprintf(Buff, "BK_%d", i + 1);
        m_BK[i].Init(pIni, Buff);
    }
    m_ItemBox.Init(pIni, "ItemBox");
//	m_ItemBox		.BringToTop();
    m_BuildBtn.Init(pIni, "BuildPBtn");
    m_CancleBtn.Init(pIni, "CancleBBtn");

    m_ItemText.Init(pIni, "ItemText");
    m_InputText.Init(pIni, "InputText");

    m_IndexList.Init(pIni, "IndexList");
    m_IndexScroll.Init(pIni, "IndexScroll");
    m_MessageScroll.Init(pIni, "ContentScroll");
    m_MessageList.Init(pIni, "ContentList");

    LoadIndexList();
}

int KUiBuildPad::WndProc(unsigned int uMsg, unsigned int uParam, int nParam) {
    switch (uMsg) {
        case WND_N_BUTTON_CLICK:
            if (uParam == (unsigned int) &m_BuildBtn)
                OnOk();
            else if (uParam == (unsigned int) &m_CancleBtn)
                CleanItem();
            break;
        case WND_N_ITEM_PICKDROP:
            if (g_UiBase.IsOperationEnable(UIS_O_MOVE_ITEM))
                OnItemPickDrop((ITEM_PICKDROP_PLACE *) uParam, (ITEM_PICKDROP_PLACE *) nParam);
            break;
        case WND_M_OTHER_WORK_RESULT:
            break;
            // scrollbar's position changed.
        case WND_N_SCORLLBAR_POS_CHANGED:
            if (uParam == (unsigned int) (KWndWindow *) &m_IndexScroll)
                m_IndexList.SetTopItemIndex(nParam);
            else if (uParam == (unsigned int) (KWndWindow *) &m_MessageScroll)
                m_MessageList.SetFirstShowLine(nParam);
            break;
            // list's click
        case WND_N_LIST_ITEM_SEL:
            if (uParam == (unsigned int) (KWndWindow *) &m_IndexList) {
                int nIndex = nParam;
                if (nIndex < 0)
                    nIndex = 0;
                // Get the content of "nParam" index.
                UpdateData(nIndex);
            }
            break;
        case WM_KEYDOWN: {
            int nCurIdx = 0;
            int nTotal = 0;

            nCurIdx = m_IndexList.GetCurSel();
            nTotal = m_IndexList.GetCount();
            switch (uParam) {
                case VK_UP:
                    if (nCurIdx == 0)
                        nCurIdx = nTotal;
                    nCurIdx = nCurIdx - 1;
                    m_IndexList.SetCurSel(nCurIdx);
                    m_IndexScroll.SetScrollPos(m_IndexList.GetTopItemIndex());
                    break;
                case VK_DOWN:
                    if (nCurIdx == nTotal - 1)
                        nCurIdx = -1;
                    nCurIdx = nCurIdx + 1;
                    m_IndexList.SetCurSel(nCurIdx);
                    m_IndexScroll.SetScrollPos(m_IndexList.GetTopItemIndex());
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            return KWndPage::WndProc(uMsg, uParam, nParam);
    }
    return 0;
}

void KUiBuildPad::LoadIndexList() {
    KIniFile ListIni;
    int nCount;
    char szInifile[128] = "";

    if (!ListIni.Load(DETAIL_BUILD))
        return;

    memset(m_IndexData, 0, sizeof(m_IndexData));
    ListIni.GetInteger("List", "Count", 0, &nCount);
    for (int i = 0; i < nCount; i++) {
        char szName[32] = "";
        char szIni[32] = "";
        char szIniSection[32] = "";
        char szNode[32] = "";
        char szPos[32] = "";

        sprintf(szName, "%d_Name", i);
        sprintf(szIni, "%d_Ini", i);
        sprintf(szIniSection, "%d_IniSection", i);
        sprintf(szNode, "%d_Node", i);
        sprintf(szPos, "%d_Pos", i);
        ListIni.GetString("List", szName, "", m_IndexData[i].szName, 128);
        ListIni.GetString("List", szIni, "", m_IndexData[i].szIni, 128);
        ListIni.GetString("List", szIniSection, "", m_IndexData[i].szIniSection, 128);
        ListIni.GetInteger("List", szNode, 0, &m_IndexData[i].nNode);
        ListIni.GetInteger2("List", szPos, &m_IndexData[i].nP1, &m_IndexData[i].nP2);
        m_IndexList.AddString(i, m_IndexData[i].szName, m_IndexData[i].nNode > 0);
    }
}

void KUiBuildPad::UpdateData(int nIndex) {
    KIniFile Ini;
    char Scheme[256];
    char szIniFile[128];
    g_UiBase.GetCurSchemePath(Scheme, 256);
    sprintf(szIniFile, "%s\\%s", Scheme, m_IndexData[nIndex].szIni);

    if (Ini.Load(szIniFile)) {
        m_MessageList.SetFirstShowLine(0);
        m_MessageScroll.SetScrollPos(0);
        MsgListBox_LoadContent(&m_MessageList, &Ini,
                               m_IndexData[nIndex].szIniSection);
    }
}


void KUiBuildPad::OnOk() {
    KUiInPutBoxCmd pCmd;
    int nCurIdx = m_IndexList.GetCurSel();
//	memset(pCmd.szStr,0,sizeof(pCmd.szStr));
    pCmd.nNum[0] = m_IndexData[nCurIdx].nP1;
    pCmd.nNum[1] = m_IndexData[nCurIdx].nP2;
    strcpy(pCmd.szFunc, "main");
    if (g_pCoreShell)
        g_pCoreShell->OperationRequest(GOI_INPUT_INFO, 4, (unsigned int) (&pCmd));
}

void KUiBuildPad::CleanItem() {
    if (g_pCoreShell) {
        int nCount;
        KUiObjAtRegion Item[_ITEM_BUILD_COUNT];
        nCount = g_pCoreShell->GetGameData(GDI_COMPOUND_ITEM, (unsigned int) &Item, 0);
        if (nCount)
            g_pCoreShell->OperationRequest(GOI_RECOVERY_BOX_COMMAND, pos_compound_item, 0);
        nCount = g_pCoreShell->GetGameData(GDI_AFFAIR_ITEM, 0, 0);
        if (nCount)
            g_pCoreShell->OperationRequest(GOI_RECOVERY_BOX_COMMAND, pos_affairitem, 0);
    }
}

void KUiBuildPad::UpdateItemObjBox(KUiObjAtRegion *pItem, int bAdd) {
    if (pItem) {
        for (int i = 0; i < _ITEM_BUILD_COUNT; i++) {
            if (CtrlItemMapBU[i].nPosition == pItem->Region.v) {
                if (bAdd)
                    m_Box[i].HoldObject(pItem->Obj.uGenre, pItem->Obj.uId,
                                        pItem->Region.Width, pItem->Region.Height);
                else
                    m_Box[i].HoldObject(CGOG_NOTHING, 0, 0, 0);
                break;
            }
        }
    }
}

void KUiBuildPad::UpdateDataObjBox() {
    KUiObjAtRegion Item[_ITEM_BUILD_COUNT];
    int nCount = g_pCoreShell->GetGameData(GDI_COMPOUND_ITEM, (unsigned int) &Item, 0);
    int i;
    for (i = 0; i < _ITEM_BUILD_COUNT; i++)
        m_Box[i].Celar();
    for (i = 0; i < nCount; i++) {
        if (Item[i].Obj.uGenre != CGOG_NOTHING)
            UpdateItemObjBox(&Item[i], true);
    }
}

void KUiBuildPad::UpdateItemMatrixBox(KUiObjAtRegion *pItem, int bAdd) {
    if (pItem) {
        UiSoundPlay(UI_SI_PICKPUT_ITEM);
        if (pItem->Obj.uGenre != CGOG_MONEY) {
            KUiDraggedObject Obj;
            Obj.uGenre = pItem->Obj.uGenre;
            Obj.uId = pItem->Obj.uId;
            Obj.DataX = pItem->Region.h;
            Obj.DataY = pItem->Region.v;
            Obj.DataW = pItem->Region.Width;
            Obj.DataH = pItem->Region.Height;
            if (bAdd)
                m_ItemBox.AddObject(&Obj, 1);
            else
                m_ItemBox.RemoveObject(&Obj);
        }
    } else
        UpdateDataMatrixBox();
}

void KUiBuildPad::UpdateDataMatrixBox() {
    m_ItemBox.Clear();

    KUiObjAtRegion *pObjs = NULL;

    int nCount = g_pCoreShell->GetGameData(GDI_AFFAIR_ITEM, 0, 0);
    if (nCount <= 0)
        return;

    if (pObjs = (KUiObjAtRegion *) malloc(sizeof(KUiObjAtRegion) * nCount)) {
        g_pCoreShell->GetGameData(GDI_AFFAIR_ITEM, (unsigned int) pObjs, nCount);
        for (int i = 0; i < nCount; i++)
            UpdateItemMatrixBox(&pObjs[i], true);
        free(pObjs);
        pObjs = NULL;
    }
}


void KUiBuildPad::OnItemPickDrop(ITEM_PICKDROP_PLACE *pPickPos, ITEM_PICKDROP_PLACE *pDropPos) {
    KUiObjAtContRegion Drop, Pick;
    KUiDraggedObject Obj;
    KWndWindow *pWnd = NULL;

    UISYS_STATUS eStatus = g_UiBase.GetStatus();
    if (pPickPos) {
        if (pPickPos->TypeItemBox == 1) {
            ((KWndObjectBox *) (pPickPos->pWnd))->GetObject(Obj);
            Pick.Obj.uGenre = Obj.uGenre;
            Pick.Obj.uId = Obj.uId;
            Pick.Region.Width = Obj.DataW;
            Pick.Region.Height = Obj.DataH;
            Pick.Region.h = 0;
            Pick.eContainer = UOC_COMPOUND_ITEM;
            pWnd = pPickPos->pWnd;
        } else if (pPickPos->TypeItemBox == 0) {
            _ASSERT(pPickPos->pWnd);
            ((KWndObjectMatrix *) (pPickPos->pWnd))->GetObject(
                    Obj, pPickPos->h, pPickPos->v);
            Pick.Obj.uGenre = Obj.uGenre;
            Pick.Obj.uId = Obj.uId;
            Pick.Region.Width = Obj.DataW;
            Pick.Region.Height = Obj.DataH;
            Pick.Region.h = Obj.DataX;
            Pick.Region.v = Obj.DataY;
            Pick.eContainer = UOC_AFFAIR_ITEM;
        }

    } else if (pDropPos) {
        pWnd = pDropPos->pWnd;
    } else
        return;

    if (pDropPos) {
        if (pDropPos->TypeItemBox == 1) {
            Wnd_GetDragObj(&Obj);
            Drop.Obj.uGenre = Obj.uGenre;
            Drop.Obj.uId = Obj.uId;
            Drop.Region.Width = Obj.DataW;
            Drop.Region.Height = Obj.DataH;
            Drop.Region.h = 0;
            Drop.eContainer = UOC_COMPOUND_ITEM;
        } else if (pDropPos->TypeItemBox == 0) {
            Wnd_GetDragObj(&Obj);
            Drop.Obj.uGenre = Obj.uGenre;
            Drop.Obj.uId = Obj.uId;
            Drop.Region.Width = Obj.DataW;
            Drop.Region.Height = Obj.DataH;
            Drop.Region.h = pDropPos->h;
            Drop.Region.v = pDropPos->v;
            Drop.eContainer = UOC_AFFAIR_ITEM;
        }
    }

    for (int i = 0; i < _ITEM_INCRE_COUNT; i++) {
        if (pWnd == (KWndWindow *) &m_Box[i]) {
            Drop.Region.v = Pick.Region.v = CtrlItemMapBU[i].nPosition;
            break;
        }
    }

    g_pCoreShell->OperationRequest(GOI_SWITCH_OBJECT,
                                   pPickPos ? (unsigned int) &Pick : 0,
                                   pDropPos ? (int) &Drop : 0);
}

/******************************************************************************************
**********************************************************************************************/
static struct UE_CTRL_MAP_IC {
    int nPosition;
    const char *pIniSection;
}

        CtrlItemMapIC[_ITEM_INCRE_COUNT] =
        {
                {UIEP_COMPOUNDITEM1, "BigBoxCR"},
                {UIEP_COMPOUNDITEM2, "SmallBoxCR1"},
                {UIEP_COMPOUNDITEM3, "SmallBoxCR2"},
                {UIEP_COMPOUNDITEM4, "SmallBoxCR3"},
        };

void KUiInCrePad::Initialize() {
    int i = 0;
    for (i = 0; i < _ITEM_INCRE_COUNT; i++) {
        m_Box[i].SetObjectGenre(CGOG_ITEM);
        AddChild(&m_Box[i]);
        m_Box[i].SetContainerId((int) UOC_COMPOUND_ITEM);
    }
    for (i = 0; i < 2; i++)
        AddChild(&m_BK[i]);
    AddChild(&m_ItemBox);
    AddChild(&m_InCreBtn);
    AddChild(&m_CancleBtn);

    AddChild(&m_ItemText);
    AddChild(&m_InputText);

    AddChild(&m_IndexList);
    AddChild(&m_IndexScroll);
    m_IndexList.SetScrollbar(&m_IndexScroll);

    AddChild(&m_MessageList);
    AddChild(&m_MessageScroll);
    m_MessageList.SetScrollbar(&m_MessageScroll);

    m_ItemBox.SetContainerId((int) UOC_AFFAIR_ITEM);
    Wnd_AddWindow(this);
}

void KUiInCrePad::LoadScheme(class KIniFile *pIni) {
    char Buff[32];
    int i = 0;
    KWndPage::Init(pIni, "InCreMain");
    for (i = 0; i < _ITEM_INCRE_COUNT; i++) {
        m_Box[i].Init(pIni, CtrlItemMapIC[i].pIniSection);
    }

    for (i = 0; i < 2; i++) {
        sprintf(Buff, "BK_%d", i + 1);
        m_BK[i].Init(pIni, Buff);
    }
    m_ItemBox.Init(pIni, "ItemBox");
    m_ItemBox.BringToTop();
    m_InCreBtn.Init(pIni, "InCrePBtn");
    m_CancleBtn.Init(pIni, "CancleCBtn");

    m_ItemText.Init(pIni, "ItemText");
    m_InputText.Init(pIni, "InputText");

    m_IndexList.Init(pIni, "IndexList");
    m_IndexScroll.Init(pIni, "IndexScroll");
    m_MessageScroll.Init(pIni, "ContentScroll");
    m_MessageList.Init(pIni, "ContentList");

    LoadIndexList();
}

int KUiInCrePad::WndProc(unsigned int uMsg, unsigned int uParam, int nParam) {
    switch (uMsg) {
        case WND_N_BUTTON_CLICK:
            if (uParam == (unsigned int) &m_InCreBtn)
                OnOk();
            else if (uParam == (unsigned int) &m_CancleBtn)
                CleanItem();
            break;
        case WND_N_ITEM_PICKDROP:
            if (g_UiBase.IsOperationEnable(UIS_O_MOVE_ITEM))
                OnItemPickDrop((ITEM_PICKDROP_PLACE *) uParam, (ITEM_PICKDROP_PLACE *) nParam);
            break;
        case WND_M_OTHER_WORK_RESULT:
            break;
            // scrollbar's position changed.
        case WND_N_SCORLLBAR_POS_CHANGED:
            if (uParam == (unsigned int) (KWndWindow *) &m_IndexScroll)
                m_IndexList.SetTopItemIndex(nParam);
            else if (uParam == (unsigned int) (KWndWindow *) &m_MessageScroll)
                m_MessageList.SetFirstShowLine(nParam);
            break;
            // list's click
        case WND_N_LIST_ITEM_SEL:
            if (uParam == (unsigned int) (KWndWindow *) &m_IndexList) {
                int nIndex = nParam;
                if (nIndex < 0)
                    nIndex = 0;
                // Get the content of "nParam" index.
                UpdateData(nIndex);
            }
            break;
        case WM_KEYDOWN: {
            int nCurIdx = 0;
            int nTotal = 0;

            nCurIdx = m_IndexList.GetCurSel();
            nTotal = m_IndexList.GetCount();
            switch (uParam) {
                case VK_UP:
                    if (nCurIdx == 0)
                        nCurIdx = nTotal;
                    nCurIdx = nCurIdx - 1;
                    m_IndexList.SetCurSel(nCurIdx);
                    m_IndexScroll.SetScrollPos(m_IndexList.GetTopItemIndex());
                    break;
                case VK_DOWN:
                    if (nCurIdx == nTotal - 1)
                        nCurIdx = -1;
                    nCurIdx = nCurIdx + 1;
                    m_IndexList.SetCurSel(nCurIdx);
                    m_IndexScroll.SetScrollPos(m_IndexList.GetTopItemIndex());
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            return KWndPage::WndProc(uMsg, uParam, nParam);
    }
    return 0;
}

void KUiInCrePad::LoadIndexList() {
    KIniFile ListIni;
    int nCount;
    char szInifile[128] = "";

    if (!ListIni.Load(DETAIL_INCRE))
        return;

    memset(m_IndexData, 0, sizeof(m_IndexData));
    ListIni.GetInteger("List", "Count", 0, &nCount);
    for (int i = 0; i < nCount; i++) {
        char szName[32] = "";
        char szIni[32] = "";
        char szIniSection[32] = "";
        char szNode[32] = "";
        char szPos[32] = "";

        sprintf(szName, "%d_Name", i);
        sprintf(szIni, "%d_Ini", i);
        sprintf(szIniSection, "%d_IniSection", i);
        sprintf(szNode, "%d_Node", i);
        sprintf(szPos, "%d_Pos", i);
        ListIni.GetString("List", szName, "", m_IndexData[i].szName, 128);
        ListIni.GetString("List", szIni, "", m_IndexData[i].szIni, 128);
        ListIni.GetString("List", szIniSection, "", m_IndexData[i].szIniSection, 128);
        ListIni.GetInteger("List", szNode, 0, &m_IndexData[i].nNode);
        ListIni.GetInteger2("List", szPos, &m_IndexData[i].nP1, &m_IndexData[i].nP2);
        m_IndexList.AddString(i, m_IndexData[i].szName, m_IndexData[i].nNode > 0);
    }
}

void KUiInCrePad::UpdateData(int nIndex) {
    KIniFile Ini;
    char Scheme[256];
    char szIniFile[128];
    g_UiBase.GetCurSchemePath(Scheme, 256);
    sprintf(szIniFile, "%s\\%s", Scheme, m_IndexData[nIndex].szIni);

    if (Ini.Load(szIniFile)) {
        m_MessageList.SetFirstShowLine(0);
        m_MessageScroll.SetScrollPos(0);
        MsgListBox_LoadContent(&m_MessageList, &Ini,
                               m_IndexData[nIndex].szIniSection);
    }
}


void KUiInCrePad::OnOk() {
    KUiInPutBoxCmd pCmd;
    int nCurIdx = m_IndexList.GetCurSel();
//	memset(pCmd.szStr,0,sizeof(pCmd.szStr));
    pCmd.nNum[0] = m_IndexData[nCurIdx].nP1;
    pCmd.nNum[1] = m_IndexData[nCurIdx].nP2;
    strcpy(pCmd.szFunc, "main");
    if (g_pCoreShell)
        g_pCoreShell->OperationRequest(GOI_INPUT_INFO, 5, (unsigned int) (&pCmd));
}

void KUiInCrePad::CleanItem() {
    if (g_pCoreShell) {
        int nCount;
        KUiObjAtRegion Item[_ITEM_INCRE_COUNT];
        nCount = g_pCoreShell->GetGameData(GDI_COMPOUND_ITEM, (unsigned int) &Item, 0);
        if (nCount)
            g_pCoreShell->OperationRequest(GOI_RECOVERY_BOX_COMMAND, pos_compound_item, 0);
        nCount = g_pCoreShell->GetGameData(GDI_AFFAIR_ITEM, 0, 0);
        if (nCount)
            g_pCoreShell->OperationRequest(GOI_RECOVERY_BOX_COMMAND, pos_affairitem, 0);
    }
}

void KUiInCrePad::UpdateItemObjBox(KUiObjAtRegion *pItem, int bAdd) {
    if (pItem) {
        for (int i = 0; i < _ITEM_INCRE_COUNT; i++) {
            if (CtrlItemMapIC[i].nPosition == pItem->Region.v) {
                if (bAdd)
                    m_Box[i].HoldObject(pItem->Obj.uGenre, pItem->Obj.uId,
                                        pItem->Region.Width, pItem->Region.Height);
                else
                    m_Box[i].HoldObject(CGOG_NOTHING, 0, 0, 0);
                break;
            }
        }
    }
}

void KUiInCrePad::UpdateDataObjBox() {
    KUiObjAtRegion Item[_ITEM_INCRE_COUNT];
    int nCount = g_pCoreShell->GetGameData(GDI_COMPOUND_ITEM, (unsigned int) &Item, 0);
    int i;
    for (i = 0; i < _ITEM_INCRE_COUNT; i++)
        m_Box[i].Celar();
    for (i = 0; i < nCount; i++) {
        if (Item[i].Obj.uGenre != CGOG_NOTHING)
            UpdateItemObjBox(&Item[i], true);
    }
}

void KUiInCrePad::UpdateItemMatrixBox(KUiObjAtRegion *pItem, int bAdd) {
    if (pItem) {
        UiSoundPlay(UI_SI_PICKPUT_ITEM);
        if (pItem->Obj.uGenre != CGOG_MONEY) {
            KUiDraggedObject Obj;
            Obj.uGenre = pItem->Obj.uGenre;
            Obj.uId = pItem->Obj.uId;
            Obj.DataX = pItem->Region.h;
            Obj.DataY = pItem->Region.v;
            Obj.DataW = pItem->Region.Width;
            Obj.DataH = pItem->Region.Height;
            if (bAdd)
                m_ItemBox.AddObject(&Obj, 1);
            else
                m_ItemBox.RemoveObject(&Obj);
        }
    } else
        UpdateDataMatrixBox();
}

void KUiInCrePad::UpdateDataMatrixBox() {
    m_ItemBox.Clear();

    KUiObjAtRegion *pObjs = NULL;

    int nCount = g_pCoreShell->GetGameData(GDI_AFFAIR_ITEM, 0, 0);
    if (nCount <= 0)
        return;

    if (pObjs = (KUiObjAtRegion *) malloc(sizeof(KUiObjAtRegion) * nCount)) {
        g_pCoreShell->GetGameData(GDI_AFFAIR_ITEM, (unsigned int) pObjs, nCount);
        for (int i = 0; i < nCount; i++)
            UpdateItemMatrixBox(&pObjs[i], true);
        free(pObjs);
        pObjs = NULL;
    }
}


void KUiInCrePad::OnItemPickDrop(ITEM_PICKDROP_PLACE *pPickPos, ITEM_PICKDROP_PLACE *pDropPos) {
    KUiObjAtContRegion Drop, Pick;
    KUiDraggedObject Obj;
    KWndWindow *pWnd = NULL;

    UISYS_STATUS eStatus = g_UiBase.GetStatus();
    if (pPickPos) {
        if (pPickPos->TypeItemBox == 1) {
            ((KWndObjectBox *) (pPickPos->pWnd))->GetObject(Obj);
            Pick.Obj.uGenre = Obj.uGenre;
            Pick.Obj.uId = Obj.uId;
            Pick.Region.Width = Obj.DataW;
            Pick.Region.Height = Obj.DataH;
            Pick.Region.h = 0;
            Pick.eContainer = UOC_COMPOUND_ITEM;
            pWnd = pPickPos->pWnd;
        } else if (pPickPos->TypeItemBox == 0) {
            _ASSERT(pPickPos->pWnd);
            ((KWndObjectMatrix *) (pPickPos->pWnd))->GetObject(
                    Obj, pPickPos->h, pPickPos->v);
            Pick.Obj.uGenre = Obj.uGenre;
            Pick.Obj.uId = Obj.uId;
            Pick.Region.Width = Obj.DataW;
            Pick.Region.Height = Obj.DataH;
            Pick.Region.h = Obj.DataX;
            Pick.Region.v = Obj.DataY;
            Pick.eContainer = UOC_AFFAIR_ITEM;
        }

    } else if (pDropPos) {
        pWnd = pDropPos->pWnd;
    } else
        return;

    if (pDropPos) {
        if (pDropPos->TypeItemBox == 1) {
            Wnd_GetDragObj(&Obj);
            Drop.Obj.uGenre = Obj.uGenre;
            Drop.Obj.uId = Obj.uId;
            Drop.Region.Width = Obj.DataW;
            Drop.Region.Height = Obj.DataH;
            Drop.Region.h = 0;
            Drop.eContainer = UOC_COMPOUND_ITEM;
        } else if (pDropPos->TypeItemBox == 0) {
            Wnd_GetDragObj(&Obj);
            Drop.Obj.uGenre = Obj.uGenre;
            Drop.Obj.uId = Obj.uId;
            Drop.Region.Width = Obj.DataW;
            Drop.Region.Height = Obj.DataH;
            Drop.Region.h = pDropPos->h;
            Drop.Region.v = pDropPos->v;
            Drop.eContainer = UOC_AFFAIR_ITEM;
        }
    }

    for (int i = 0; i < _ITEM_INCRE_COUNT; i++) {
        if (pWnd == (KWndWindow *) &m_Box[i]) {
            Drop.Region.v = Pick.Region.v = CtrlItemMapIC[i].nPosition;
            break;
        }
    }

    g_pCoreShell->OperationRequest(GOI_SWITCH_OBJECT,
                                   pPickPos ? (unsigned int) &Pick : 0,
                                   pDropPos ? (int) &Drop : 0);
}

/*********************************************************************************************
**********************************************************************************************/
KUiInCre *KUiInCre::m_pSelf = NULL;

KUiInCre::KUiInCre() {
    m_nCurPage = WINDOWS_BUILDE;
}

KUiInCre::~KUiInCre() {
}

KUiInCre *KUiInCre::OpenWindow(BYTE nKind) {
    if (m_pSelf == NULL) {
        m_pSelf = new KUiInCre;
        if (m_pSelf)
            m_pSelf->Initialize();
    }
    if (m_pSelf) {
        if (!KUiItem::GetIfVisible())
            KUiItem::OpenWindow();

        UiSoundPlay(UI_SI_WND_OPENCLOSE);
        m_pSelf->UpdateDataObjBox();
        m_pSelf->UpdateDataMatrixBox();
        m_pSelf->BringToTop();
        m_pSelf->Show();
        m_pSelf->ShowPage(nKind);
        Wnd_GameSpaceHandleInput(false);
    }
    return m_pSelf;
}

KUiInCre *KUiInCre::GetIfVisible() {
    if (m_pSelf && m_pSelf->IsVisible())
        return m_pSelf;
    return NULL;
}

void KUiInCre::CloseWindow(bool bDestroy) {
    if (m_pSelf) {
        Wnd_GameSpaceHandleInput(true);
        if (bDestroy == false)
            m_pSelf->Hide();
        else {
            m_pSelf->Destroy();
            m_pSelf = NULL;
        }
        m_pSelf->OnCancel();
    }
}

void KUiInCre::Initialize() {
    m_BuildPad.Initialize();
    AddPage(&m_BuildPad, &m_BuildBtn);
    m_InCrePad.Initialize();
    AddPage(&m_InCrePad, &m_InCreBtn);
    m_BuildFPad.Initialize();
    AddPage(&m_BuildFPad, &m_BuildFBtn);
    m_InCreFPad.Initialize();
    AddPage(&m_InCreFPad, &m_InCreFBtn);

    AddChild(&m_Close);

    AddChild(&m_BuildBtn);
    AddChild(&m_InCreBtn);
    AddChild(&m_BuildFBtn);
    AddChild(&m_InCreFBtn);

    char Scheme[256];
    g_UiBase.GetCurSchemePath(Scheme, 256);
    LoadScheme(Scheme);
    Wnd_AddWindow(this);
}

void KUiInCre::LoadScheme(const char *pScheme) {
    if (m_pSelf) {
        char Buff[128];
        KIniFile Ini;
        sprintf(Buff, "%s\\%s", pScheme, SCHEME_INI);
        if (Ini.Load(Buff))
            m_pSelf->LoadScheme(&Ini);
    }
}

void KUiInCre::LoadScheme(class KIniFile *pIni) {
    m_pSelf->Init(pIni, "Main");

    m_pSelf->m_BuildPad.LoadScheme(pIni);
    m_pSelf->m_InCrePad.LoadScheme(pIni);
    m_pSelf->m_BuildFPad.LoadScheme(pIni);
    m_pSelf->m_InCreFPad.LoadScheme(pIni);

    m_pSelf->m_BuildBtn.Init(pIni, "BuildPadBtn");
    m_pSelf->m_InCreBtn.Init(pIni, "InCrePadBtn");

    m_pSelf->m_BuildFBtn.Init(pIni, "BuildPadBtn");
    m_pSelf->m_InCreFBtn.Init(pIni, "InCrePadBtn");

    m_pSelf->m_Close.Init(pIni, "CloseBtn");
}

int KUiInCre::WndProc(unsigned int uMsg, unsigned int uParam, int nParam) {
    switch (uMsg) {
        case WND_N_BUTTON_CLICK:
            if (uParam == (unsigned int) (KWndWindow *) &m_Close) {
                CloseWindow(false);
                return 0;
            } else if (uParam == (unsigned int) (KWndWindow *) &m_BuildBtn) {
                m_nCurPage = WINDOWS_BUILDE;
                ShowPage();
                return 0;
            } else if (uParam == (unsigned int) (KWndWindow *) &m_InCreBtn) {
                m_nCurPage = WINDOWS_INCREE;
                ShowPage();
                return 0;
            } else if (uParam == (unsigned int) (KWndWindow *) &m_BuildFBtn) {
                m_nCurPage = WINDOWS_BUILDF;
                ShowPage();
                return 0;
            } else if (uParam == (unsigned int) (KWndWindow *) &m_InCreFBtn) {
                m_nCurPage = WINDOWS_INCREF;
                ShowPage();
                return 0;
            }
            break;
        case WM_KEYDOWN:
            if (uParam == VK_ESCAPE)    // esc
            {
                CloseWindow(false);
                return 0;
            }
            break;
    }
    return KWndPageSet::WndProc(uMsg, uParam, nParam);
}

void KUiInCre::ShowPage(BYTE nKind) {
    switch (nKind) {
        case 1:
            m_nCurPage = WINDOWS_BUILDE;
            m_pSelf->m_BuildPad.Show();
            m_pSelf->m_InCrePad.Hide();
            m_pSelf->m_BuildFPad.Hide();
            m_pSelf->m_InCreFPad.Hide();

            m_pSelf->m_BuildBtn.Show();
            m_pSelf->m_InCreBtn.Show();

            m_pSelf->m_BuildBtn.CheckButton(true);
            m_pSelf->m_InCreBtn.CheckButton(false);

            m_pSelf->m_BuildFBtn.Hide();
            m_pSelf->m_InCreFBtn.Hide();
            break;
        case 2:
            m_nCurPage = WINDOWS_BUILDF;
            m_pSelf->m_BuildPad.Hide();
            m_pSelf->m_InCrePad.Hide();
            m_pSelf->m_BuildFPad.Show();
            m_pSelf->m_InCreFPad.Hide();

            m_pSelf->m_BuildFBtn.CheckButton(true);
            m_pSelf->m_InCreFBtn.CheckButton(false);

            m_pSelf->m_BuildBtn.Hide();
            m_pSelf->m_InCreBtn.Hide();
            m_pSelf->m_BuildFBtn.Show();
            m_pSelf->m_InCreFBtn.Show();
            break;
    }
}

void KUiInCre::ShowPage() {
    switch (m_nCurPage) {
        case WINDOWS_BUILDE:
            m_BuildBtn.CheckButton(true);
            m_InCreBtn.CheckButton(false);
            m_BuildPad.Show();
            m_InCrePad.Hide();
            OnCancel();
            break;
        case WINDOWS_INCREE:
            m_BuildBtn.CheckButton(false);
            m_InCreBtn.CheckButton(true);
            m_BuildPad.Hide();
            m_InCrePad.Show();
            OnCancel();
            break;
        case WINDOWS_BUILDF:
            m_BuildFBtn.CheckButton(true);
            m_InCreFBtn.CheckButton(false);
            m_BuildFPad.Show();
            m_InCreFPad.Hide();
            OnCancel();
            break;
        case WINDOWS_INCREF:
            m_BuildFBtn.CheckButton(false);
            m_InCreFBtn.CheckButton(true);
            m_BuildFPad.Hide();
            m_InCreFPad.Show();
            OnCancel();
            break;
    }
}

void KUiInCre::UpdateItemObjBox(KUiObjAtRegion *pItem, int bAdd) {
    if (m_pSelf) {
        switch (m_nCurPage) {
            case WINDOWS_BUILDE:
                m_BuildPad.UpdateItemObjBox(pItem, bAdd);
                break;
            case WINDOWS_INCREE:
                m_InCrePad.UpdateItemObjBox(pItem, bAdd);
                break;
            case WINDOWS_BUILDF:
                m_BuildFPad.UpdateItemObjBox(pItem, bAdd);
                break;
            case WINDOWS_INCREF:
                m_InCreFPad.UpdateItemObjBox(pItem, bAdd);
                break;
        }
    }
}

void KUiInCre::UpdateItemMatrixBox(KUiObjAtRegion *pItem, int bAdd) {
    if (m_pSelf) {
        switch (m_nCurPage) {
            case WINDOWS_BUILDE:
                m_BuildPad.UpdateItemMatrixBox(pItem, bAdd);
                break;
            case WINDOWS_INCREE:
                m_InCrePad.UpdateItemMatrixBox(pItem, bAdd);
                break;
            case WINDOWS_BUILDF:
                m_BuildFPad.UpdateItemMatrixBox(pItem, bAdd);
                break;
            case WINDOWS_INCREF:
                m_InCreFPad.UpdateItemMatrixBox(pItem, bAdd);
                break;
        }
    }
}

void KUiInCre::UpdateDataObjBox() {
    if (m_pSelf) {
        switch (m_nCurPage) {
            case WINDOWS_BUILDE:
                m_BuildPad.UpdateDataObjBox();
                break;
            case WINDOWS_INCREE:
                m_InCrePad.UpdateDataObjBox();
                break;
            case WINDOWS_BUILDF:
                m_BuildFPad.UpdateDataObjBox();
                break;
            case WINDOWS_INCREF:
                m_InCreFPad.UpdateDataObjBox();
                break;
        }
    }
}

void KUiInCre::UpdateDataMatrixBox() {
    if (m_pSelf) {
        switch (m_nCurPage) {
            case WINDOWS_BUILDE:
                m_BuildPad.UpdateDataMatrixBox();
                break;
            case WINDOWS_INCREE:
                m_InCrePad.UpdateDataMatrixBox();
                break;
            case WINDOWS_BUILDF:
                m_BuildFPad.UpdateDataMatrixBox();
                break;
            case WINDOWS_INCREF:
                m_InCreFPad.UpdateDataMatrixBox();
                break;
        }
    }
}

void KUiInCre::OnCancel() {
    if (g_pCoreShell) {
        int nCount;
        KUiObjAtRegion Item[_ITEM_BUILD_COUNT];
        nCount = g_pCoreShell->GetGameData(GDI_COMPOUND_ITEM, (unsigned int) &Item, 0);
        if (nCount)
            g_pCoreShell->OperationRequest(GOI_RECOVERY_BOX_COMMAND, pos_compound_item, 0);
        nCount = g_pCoreShell->GetGameData(GDI_AFFAIR_ITEM, 0, 0);
        if (nCount)
            g_pCoreShell->OperationRequest(GOI_RECOVERY_BOX_COMMAND, pos_affairitem, 0);
    }
}
