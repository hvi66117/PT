/*****************************************************************************************
//	UiRise.cpp
//	Author	:   AlexKing
//	CreateTime:	11/7/2018
------------------------------------------------------------------------------------------
		Khung ep vat pham
*****************************************************************************************/

#include "KWin32.h"
#include "KIniFile.h"
#include "../Elem/WndMessage.h"
#include "../elem/wnds.h"
#include "../elem/PopupMenu.h"
#include "UiRise.h"
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

#define    SCHEME_INI                "UiRise.ini"
#define    DETAIL_SCHEME_INI        "\\Ui\\Ui3\\UiRise.ini"
#define    DETAIL_RISE                "\\Ui\\RiseHelp.ini"

#define    SELECT_TYPE_HORSE        0x00
#define    SELECT_TYPE_LEVEL        0x02
/******************************************************************************************
**********************************************************************************************/
static struct UE_CTRL_MAP_ICH {
    int nPosition;
    const char *pIniSection;
}

        CtrlItemMapICH[_ITEM_INCREH_COUNT] =
        {
                {UIEP_COMPOUNDITEM1, "BigBox"},
                {UIEP_COMPOUNDITEM2, "SmallBox1"},
                {UIEP_COMPOUNDITEM3, "SmallBox2"},
                {UIEP_COMPOUNDITEM4, "SmallBox3"},
        };


void KUiIncreHPad::Initialize() {
    int i = 0;
    for (i = 0; i < _ITEM_INCREH_COUNT; i++) {
        m_Box[i].SetObjectGenre(CGOG_ITEM);
        AddChild(&m_Box[i]);
        m_Box[i].SetContainerId((int) UOC_COMPOUND_ITEM);
    }

    for (i = 0; i < MAX_RISE_TYPE; i++) {
        AddChild(&m_HourseL[i]);
        AddChild(&m_HorseTxt[i]);
    }

    AddChild(&m_ItemBox);
    AddChild(&m_IncreBtn);
    AddChild(&m_CancleBtn);
    AddChild(&m_TypeText);
    AddChild(&m_MessageList);
    AddChild(&m_MessageScroll);
    m_MessageList.SetScrollbar(&m_MessageScroll);

    nCurHor = 0;
    nCurLv = 0;
    m_ItemBox.SetContainerId((int) UOC_AFFAIR_ITEM);
    Wnd_AddWindow(this);
}

void KUiIncreHPad::LoadScheme() {
    int i = 0;
    KIniFile Ini;
    char szBuff[32];
    if (Ini.Load(DETAIL_SCHEME_INI)) {
        KWndPage::Init(&Ini, "IncreHMain");
        m_TypeText.Init(&Ini, "TypeText");
        for (i = 0; i < _ITEM_INCREH_COUNT; i++) {
            m_Box[i].Init(&Ini, CtrlItemMapICH[i].pIniSection);
        }

        for (i = 0; i < MAX_RISE_TYPE; i++) {
            sprintf(szBuff, "Horse_%d", i);
            m_HourseL[i].Init(&Ini, szBuff);

            sprintf(szBuff, "HorseTxt_%d", i);
            m_HorseTxt[i].Init(&Ini, szBuff);
        }

        m_ItemBox.Init(&Ini, "ItemBox");
        m_IncreBtn.Init(&Ini, "HorseBtn");
        m_CancleBtn.Init(&Ini, "CancleHBtn");

        m_MessageScroll.Init(&Ini, "ContentScroll");
        m_MessageList.Init(&Ini, "ContentList");

        for (i = 0; i < 2; i++) {
            sprintf(szBuff, "%d", i);
            Ini.GetString("ReturnHInfo", szBuff, "", ArrayReturnInfo[i], sizeof(ArrayReturnInfo[i]));
        }

        LoadIndexList();
        m_HorseTxt[0].SetText(szHorse[nCurHor]);
        m_HorseTxt[1].SetText(szLevel[nCurLv]);

        UpdateData(nCurHor, nCurLv);
    }
}

void KUiIncreHPad::LoadIndexList() {
    KIniFile ListIni;

    char szName[32] = "";
    char szIni[32] = "";
    char szIniSection[32] = "";
    char szPos[32] = "";

    if (!ListIni.Load(DETAIL_RISE))
        return;

    memset(m_IndexData, 0, sizeof(m_IndexData));
    ListIni.GetInteger("HorseL", "Count", 0, &nCount[0]);
    for (int i = 0; i < nCount[0]; i++) {
        sprintf(szName, "%d_Name", i);
        sprintf(szIni, "%d_Ini", i);
        sprintf(szIniSection, "%d_IniSection", i);
        sprintf(szPos, "%d_Pos", i);
        ListIni.GetString("HorseL", szName, "", szHorse[i], 128);
        ListIni.GetString("HorseL", szIni, "", m_IndexData[i].szIni, 128);
        ListIni.GetString("HorseL", szIniSection, "", m_IndexData[i].szIniSection, 128);
        ListIni.GetInteger("HorseL", szPos, 0, &m_IndexData[i].nP1);
        m_IndexData[i].nP2 = 2;
    }
    ListIni.GetInteger("LevelL", "Count", 0, &nCount[1]);
    for (i = 0; i < nCount[1]; i++) {
        sprintf(szName, "%d_Name", i);
        ListIni.GetString("LevelL", szName, "", szLevel[i], 128);
    }
}

void KUiIncreHPad::UpdateData(int nIndex, int nPab) {
    KIniFile Ini;
    char Scheme[256];
    char szIniFile[128];
    char szPos[32] = "";
    g_UiBase.GetCurSchemePath(Scheme, 256);
    sprintf(szIniFile, "%s\\%s", Scheme, m_IndexData[nIndex].szIni);
    if (Ini.Load(szIniFile)) {
        m_MessageList.SetFirstShowLine(0);
        m_MessageScroll.SetScrollPos(0);
        MsgListBox_LoadContent(&m_MessageList, &Ini,
                               m_IndexData[nIndex].szIniSection);
    }
    if (Ini.Load(DETAIL_RISE)) {
        sprintf(szPos, "%d_Pos", nPab);
        Ini.GetInteger("LevelL", szPos, 0, &m_IndexData[nIndex].nP2);
    }
}

int KUiIncreHPad::WndProc(unsigned int uMsg, unsigned int uParam, int nParam) {
    switch (uMsg) {
        case WND_N_BUTTON_CLICK:
            if (uParam == (unsigned int) (KWndWindow *) &m_HourseL[0])
                OnSelectType(enumType_Select);
            else if (uParam == (unsigned int) (KWndWindow *) &m_HourseL[1])
                OnSelectType(enumLevel_Select);
            else if (uParam == (unsigned int) (KWndWindow *) &m_IncreBtn)
                OnOk();
            else if (uParam == (unsigned int) (KWndWindow *) &m_CancleBtn)
                CleanItem();
            break;
        case WND_N_ITEM_PICKDROP:
            if (g_UiBase.IsOperationEnable(UIS_O_MOVE_ITEM))
                OnItemPickDrop((ITEM_PICKDROP_PLACE *) uParam, (ITEM_PICKDROP_PLACE *) nParam);
            break;
        case WND_M_MENUITEM_SELECTED:
            if (uParam == (unsigned int) (KWndWindow *) this) {
                if ((short) (LOWORD(nParam)) >= 0) {
                    SetHorseType(HIWORD(nParam), (short) (LOWORD(nParam)));
                }
            }
            break;
        case WND_N_SCORLLBAR_POS_CHANGED:
            if (uParam == (unsigned int) (KWndWindow *) &m_MessageScroll)
                m_MessageList.SetFirstShowLine(nParam);
            break;
        case WND_M_OTHER_WORK_RESULT:
            break;
        default:
            return KWndPage::WndProc(uMsg, uParam, nParam);
    }
    return 0;
}

void KUiIncreHPad::OnSelectType(int nIndex) {
    int nActionDataCount = nCount[nIndex];
    struct KPopupMenuData *pSelUnitMenu = (KPopupMenuData *) malloc(MENU_DATA_SIZE(nActionDataCount));
    if (pSelUnitMenu == NULL)
        return;
    KPopupMenu::InitMenuData(pSelUnitMenu, nActionDataCount);
    pSelUnitMenu->nNumItem = 0;
    pSelUnitMenu->usMenuFlag |= PM_F_AUTO_DEL_WHEN_HIDE;
    for (int i = 0; i < nActionDataCount; i++) {
        if (nIndex == enumType_Select)
            strncpy(pSelUnitMenu->Items[i].szData, szHorse[i], sizeof(szHorse[i]));
        else if (nIndex = enumLevel_Select)
            strncpy(pSelUnitMenu->Items[i].szData, szLevel[i], sizeof(szLevel[i]));

        pSelUnitMenu->Items[i].szData[sizeof(pSelUnitMenu->Items[i].szData) - 1] = 0;
        pSelUnitMenu->Items[i].uDataLen = strlen(pSelUnitMenu->Items[i].szData);
        pSelUnitMenu->nNumItem++;
    }
    int nX = 0, nY = 0;
    int Left, Top, nWidth;
    GetSize(&nWidth, NULL);
    GetAbsolutePos(&Left, &Top);
    KIniFile Ini;
    switch (nIndex) {
        case enumType_Select:
            if (Ini.Load(DETAIL_SCHEME_INI))
                Ini.GetInteger2("PopupPosition", "TypeSelect", &nX, &nY);
            pSelUnitMenu->nX = Left + nX;
            pSelUnitMenu->nY = Top + nY;
            KPopupMenu::Popup(pSelUnitMenu, this, SELECT_TYPE_HORSE);
            break;
        case enumLevel_Select:
            if (Ini.Load(DETAIL_SCHEME_INI))
                Ini.GetInteger2("PopupPosition", "LevelSelect", &nX, &nY);
            pSelUnitMenu->nX = Left + nX;
            pSelUnitMenu->nY = Top + nY;
            KPopupMenu::Popup(pSelUnitMenu, this, SELECT_TYPE_LEVEL);
            break;
    }
}

void KUiIncreHPad::SetHorseType(int nIndex, int nSel) {
    switch (nIndex) {
        case SELECT_TYPE_HORSE:
            nCurHor = nSel;
            m_HorseTxt[0].SetText(szHorse[nSel]);
            break;
        case SELECT_TYPE_LEVEL:
            nCurLv = nSel;
            m_HorseTxt[1].SetText(szLevel[nSel]);
            break;
    }
    UpdateData(nCurHor, nCurLv);
}

void KUiIncreHPad::OnOk() {
    KUiInPutBoxCmd pCmd;
    pCmd.nNum[0] = m_IndexData[nCurHor].nP1;
    pCmd.nNum[1] = m_IndexData[nCurHor].nP2;
    strcpy(pCmd.szFunc, "main");
    if (g_pCoreShell)
        g_pCoreShell->OperationRequest(GOI_INPUT_INFO, 6, (unsigned int) (&pCmd));
}

void KUiIncreHPad::CleanItem() {
    if (g_pCoreShell) {
        int nCount;
        KUiObjAtRegion Item[_ITEM_INCREH_COUNT];
        nCount = g_pCoreShell->GetGameData(GDI_COMPOUND_ITEM, (unsigned int) &Item, 0);
        if (nCount)
            g_pCoreShell->OperationRequest(GOI_RECOVERY_BOX_COMMAND, pos_compound_item, 0);
        nCount = g_pCoreShell->GetGameData(GDI_AFFAIR_ITEM, 0, 0);
        if (nCount)
            g_pCoreShell->OperationRequest(GOI_RECOVERY_BOX_COMMAND, pos_affairitem, 0);
    }
}

void KUiIncreHPad::UpdateItemObjBox(KUiObjAtRegion *pItem, int bAdd) {
    if (pItem) {
        for (int i = 0; i < _ITEM_INCREH_COUNT; i++) {
            if (CtrlItemMapICH[i].nPosition == pItem->Region.v) {
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

void KUiIncreHPad::UpdateDataObjBox() {
    KUiObjAtRegion Item[_ITEM_INCREH_COUNT];
    int nCount = g_pCoreShell->GetGameData(GDI_COMPOUND_ITEM, (unsigned int) &Item, 0);
    int i;
    for (i = 0; i < _ITEM_INCREH_COUNT; i++)
        m_Box[i].Celar();
    for (i = 0; i < nCount; i++) {
        if (Item[i].Obj.uGenre != CGOG_NOTHING)
            UpdateItemObjBox(&Item[i], true);
    }
}

void KUiIncreHPad::UpdateItemMatrixBox(KUiObjAtRegion *pItem, int bAdd) {
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

void KUiIncreHPad::UpdateDataMatrixBox() {
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

BOOL KUiIncreHPad::EnoughItemPickDrop(KWndWindow *pWnd, int nIndex, int nTypeBox) {
    int nLen;
    char szWarning[128];
    int nGenre, nDetail, nParti, nSeries, nLevel, nStack, nColor;//, bBind;
    nGenre = g_pCoreShell->GetGenreItem(nIndex);
    nDetail = g_pCoreShell->GetDetailItem(nIndex);
    nParti = g_pCoreShell->GetParticularItem(nIndex);
    nLevel = g_pCoreShell->GetLevelItem(nIndex);
    nSeries = g_pCoreShell->GetSeriesItem(nIndex);
    nStack = g_pCoreShell->GetStackNum(nIndex);
    nColor = g_pCoreShell->GetItemColor(nIndex);
//	bBind	= g_pCoreShell->GetBindItem(nIndex);

    if (nTypeBox) {
        if (pWnd == (KWndWindow *) &m_Box[0]) {
            //	if (bBind != 0)
            //		return FALSE;

            if (nGenre != item_equip || nDetail != equip_horse) {
                strcpy(szWarning, ArrayReturnInfo[0]);
                nLen = strlen(szWarning);
                KUiMsgCentrePad::SystemMessageArrival(szWarning, nLen);
                return FALSE;
            }
        }
    }
    return TRUE;
}

void KUiIncreHPad::OnItemPickDrop(ITEM_PICKDROP_PLACE *pPickPos, ITEM_PICKDROP_PLACE *pDropPos) {
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
            if (!EnoughItemPickDrop(pWnd, Obj.uId, pDropPos->TypeItemBox))
                return;

            Drop.Obj.uGenre = Obj.uGenre;
            Drop.Obj.uId = Obj.uId;
            Drop.Region.Width = Obj.DataW;
            Drop.Region.Height = Obj.DataH;
            Drop.Region.h = 0;
            Drop.eContainer = UOC_COMPOUND_ITEM;
        } else if (pDropPos->TypeItemBox == 0) {
            Wnd_GetDragObj(&Obj);
            if (!EnoughItemPickDrop(pWnd, Obj.uId, pDropPos->TypeItemBox))
                return;

            Drop.Obj.uGenre = Obj.uGenre;
            Drop.Obj.uId = Obj.uId;
            Drop.Region.Width = Obj.DataW;
            Drop.Region.Height = Obj.DataH;
            Drop.Region.h = pDropPos->h;
            Drop.Region.v = pDropPos->v;
            Drop.eContainer = UOC_AFFAIR_ITEM;
        }
    }

    for (int i = 0; i < _ITEM_INCREH_COUNT; i++) {
        if (pWnd == (KWndWindow *) &m_Box[i]) {
            Drop.Region.v = Pick.Region.v = CtrlItemMapICH[i].nPosition;
            break;
        }
    }

    g_pCoreShell->OperationRequest(GOI_SWITCH_OBJECT,
                                   pPickPos ? (unsigned int) &Pick : 0,
                                   pDropPos ? (int) &Drop : 0);
}

/*********************************************************************************************
**********************************************************************************************/
KUiRise *KUiRise::m_pSelf = NULL;

KUiRise::KUiRise() {
    m_nCurPage = WINDOWS_INCREH;
}

KUiRise::~KUiRise() {
}

KUiRise *KUiRise::OpenWindow() {
    if (m_pSelf == NULL) {
        m_pSelf = new KUiRise;
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
        Wnd_GameSpaceHandleInput(false);
    }
    return m_pSelf;
}

KUiRise *KUiRise::GetIfVisible() {
    if (m_pSelf && m_pSelf->IsVisible())
        return m_pSelf;
    return NULL;
}

void KUiRise::CloseWindow(bool bDestroy) {
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

void KUiRise::Initialize() {
    m_IncreHPad.Initialize();
    AddPage(&m_IncreHPad, &m_IncreHBtn);

    AddChild(&m_Close);
    AddChild(&m_IncreHBtn);

    LoadScheme();
    Wnd_AddWindow(this);
}

void KUiRise::LoadScheme() {
    KIniFile Ini;
    if (m_pSelf && Ini.Load(DETAIL_SCHEME_INI)) {
        m_pSelf->Init(&Ini, "Main");
        m_pSelf->m_IncreHBtn.Init(&Ini, "IncreHBtn");
        m_pSelf->m_Close.Init(&Ini, "CloseBtn");

        m_pSelf->m_IncreHPad.LoadScheme();

    }
}

int KUiRise::WndProc(unsigned int uMsg, unsigned int uParam, int nParam) {
    switch (uMsg) {
        case WND_N_BUTTON_CLICK:
            if (uParam == (unsigned int) (KWndWindow *) &m_Close) {
                CloseWindow(false);
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

void KUiRise::ShowPage() {
    switch (m_nCurPage) {
        case WINDOWS_INCREH:
            m_IncreHBtn.CheckButton(true);
            m_IncreHPad.Show();
            OnCancel();
            break;
    }
}

void KUiRise::UpdateItemObjBox(KUiObjAtRegion *pItem, int bAdd) {
    if (m_pSelf) {
        switch (m_nCurPage) {
            case WINDOWS_INCREH:
                m_IncreHPad.UpdateItemObjBox(pItem, bAdd);
                break;
        }
    }
}

void KUiRise::UpdateItemMatrixBox(KUiObjAtRegion *pItem, int bAdd) {
    if (m_pSelf) {
        switch (m_nCurPage) {
            case WINDOWS_INCREH:
                m_IncreHPad.UpdateItemMatrixBox(pItem, bAdd);
                break;
        }
    }
}

void KUiRise::UpdateDataObjBox() {
    if (m_pSelf) {
        switch (m_nCurPage) {
            case WINDOWS_INCREH:
                m_IncreHPad.UpdateDataObjBox();
                break;
        }
    }
}

void KUiRise::UpdateDataMatrixBox() {
    if (m_pSelf) {
        switch (m_nCurPage) {
            case WINDOWS_INCREH:
                m_IncreHPad.UpdateDataMatrixBox();
                break;
        }
    }
}

void KUiRise::OnCancel() {
    if (g_pCoreShell) {
        int nCount;
        KUiObjAtRegion Item[_ITEM_BUILDF_COUNT];
        nCount = g_pCoreShell->GetGameData(GDI_COMPOUND_ITEM, (unsigned int) &Item, 0);
        if (nCount)
            g_pCoreShell->OperationRequest(GOI_RECOVERY_BOX_COMMAND, pos_compound_item, 0);
        nCount = g_pCoreShell->GetGameData(GDI_AFFAIR_ITEM, 0, 0);
        if (nCount)
            g_pCoreShell->OperationRequest(GOI_RECOVERY_BOX_COMMAND, pos_affairitem, 0);
    }
}
