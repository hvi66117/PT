/*****************************************************************************************
//	UiComPound.cpp
//	Author	:   AlexKing
//	CreateTime:	11/7/2018
------------------------------------------------------------------------------------------
		Khung kham nam do tim
*****************************************************************************************/

#include "KWin32.h"
#include "KIniFile.h"
#include "../Elem/WndMessage.h"
#include "../elem/wnds.h"
#include "UiComPound.h"
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

#define    SCHEME_INI        "UiComPound.ini"
#define    SCHEME_INI_2        "UiComPoundItem.ini"

/*********************************************************************************************
Class KUiDistillPad
**********************************************************************************************/
static struct UE_CTRL_MAP_DT {
    int nPosition;
    const char *pIniSection;
}

        CtrlItemMapDT[_ITEM_DISTILL_COUNT] =
        {
                {UIEP_COMPOUNDITEM1, "BigBoxDT"},
                {UIEP_COMPOUNDITEM2, "SmallBoxDT1"},
                {UIEP_COMPOUNDITEM3, "SmallBoxDT2"},
                {UIEP_COMPOUNDITEM4, "SmallBoxDT3"},
        };

void KUiDistillPad::Initialize() {
    int i = 0;
    for (i = 0; i < _ITEM_DISTILL_COUNT; i++) {
        m_Box[i].SetObjectGenre(CGOG_ITEM);
        AddChild(&m_Box[i]);
        m_Box[i].SetContainerId((int) UOC_COMPOUND_ITEM);
    }
    for (i = 0; i < EFFECT_COUNT; i++) {
        AddChild(&m_Effect[i]);
        m_Effect[i].Hide();
    }
    AddChild(&m_ItemBox);
    AddChild(&m_DistillBtn);
    AddChild(&m_CancleDTBtn);
    m_ItemBox.SetContainerId((int) UOC_COMPOUND_BOX);
    Wnd_AddWindow(this);
}

void KUiDistillPad::LoadScheme(class KIniFile *pIni) {
    char Buff[32];
    int i = 0;
    KWndPage::Init(pIni, "DistillMain");
    for (i = 0; i < _ITEM_DISTILL_COUNT; i++) {
        m_Box[i].Init(pIni, CtrlItemMapDT[i].pIniSection);
    }

    m_Effect[0].Init(pIni, "EquipDTEffect");
    m_Effect[1].Init(pIni, "ConsumeDTEffect");

    m_ItemBox.Init(pIni, "ItemBoxDT");
    m_DistillBtn.Init(pIni, "DistillBtn");
    m_CancleDTBtn.Init(pIni, "CancleDTBtn");

    for (i = 0; i < 8; i++) {
        sprintf(Buff, "%d", i);
        pIni->GetString("ReturnDTInfo", Buff, "", ArrayReturnInfo[i], sizeof(ArrayReturnInfo[i]));
    }

    m_EffectTime = 0;
}

int KUiDistillPad::WndProc(unsigned int uMsg, unsigned int uParam, int nParam) {
    switch (uMsg) {
        case WND_N_BUTTON_CLICK:
            if (uParam == (unsigned int) &m_DistillBtn) {
                if (EnoughItemToGo()) {
                    if (m_EffectTime) break;
                    UIMessageBox(ArrayReturnInfo[0], this, "X¸c nhËn ", "Hñy bá ", ISP_DO_EVENT);
                }
            } else if (uParam == (unsigned int) &m_CancleDTBtn) {
                if (m_EffectTime) break;
                CleanItem();
            }
            break;
        case WND_N_ITEM_PICKDROP:
            if (g_UiBase.IsOperationEnable(UIS_O_MOVE_ITEM))
                OnItemPickDrop((ITEM_PICKDROP_PLACE *) uParam, (ITEM_PICKDROP_PLACE *) nParam);
            break;
        case WND_M_OTHER_WORK_RESULT:
            if (uParam == ISP_DO_EVENT) {
                if (!nParam) {
                    m_Effect[0].SetFrame(-1);
                    m_Effect[1].SetFrame(-1);
                    m_EffectTime = 1;
                    StartEffect();
                }
            }
            break;
        default:
            return KWndPage::WndProc(uMsg, uParam, nParam);
    }
    return 0;
}

void KUiDistillPad::Breathe() {
    if (m_Effect[0].IsVisible())
        m_Effect[0].NextFrame();
    if (m_Effect[1].IsVisible())
        m_Effect[1].NextFrame();
    if (m_EffectTime)
        m_EffectTime++;
    if (m_EffectTime == (m_Effect[0].GetMaxFrame()) * 2 / 2 + 4) {
        StopEffect();
        m_EffectTime = 0;
    }
}

void KUiDistillPad::StopEffect() {
    m_Effect[0].Hide();
    m_Effect[1].Hide();
    UpdatePickPut(true);
    OnOk();
}

void KUiDistillPad::StartEffect() {
    m_Effect[0].Show();
    m_Effect[1].Show();
    UpdatePickPut(false);
}

BOOL KUiDistillPad::IsEffect() {
    if (m_EffectTime) return TRUE;
    return FALSE;
}

void KUiDistillPad::UpdatePickPut(bool bLock) {
    for (int i = 0; i < _ITEM_DISTILL_COUNT; i++)
        m_Box[i].EnablePickPut(bLock);
    m_ItemBox.EnablePickPut(bLock);
    m_DistillBtn.Enable(bLock);
    m_CancleDTBtn.Enable(bLock);

    KUiComPound *pCom = KUiComPound::GetIfVisible();
    if (pCom) {
        pCom->m_Close.Enable(bLock);
        pCom->m_DistillBtn.Enable(bLock);
        pCom->m_EnchaseBtn.Enable(bLock);
        pCom->m_ForgeBtn.Enable(bLock);
    }
}

void KUiDistillPad::OnOk() {
    if (g_pCoreShell) {
        g_pCoreShell->OperationRequest(GOI_ADD_UI_CMD_SCRIPT, 6, (unsigned int) "main");
    }
}

BOOL KUiDistillPad::EnoughItemToGo() {
    int nLen;
    char szWarning[128];
    int nCount = 0;
    KUiDraggedObject pObj;
    for (int i = 0; i < _ITEM_DISTILL_COUNT - 1; i++) {
        pObj.uId = 0;
        m_Box[i].GetObject(pObj);
        if (pObj.uId > 0)
            nCount += 1;
    }

    if (nCount < 3) {
        strcpy(szWarning, ArrayReturnInfo[6]);
        nLen = strlen(szWarning);
        KUiMsgCentrePad::SystemMessageArrival(szWarning, nLen);
        return FALSE;
    }
    return TRUE;
}

void KUiDistillPad::CleanItem() {
    if (g_pCoreShell) {
        int nCount;
        KUiObjAtRegion Item[_ITEM_DISTILL_COUNT];
        nCount = g_pCoreShell->GetGameData(GDI_COMPOUND_ITEM, (unsigned int) &Item, 0);
        if (nCount)
            g_pCoreShell->OperationRequest(GOI_RECOVERY_BOX_COMMAND, pos_compound_item, 0);
        nCount = g_pCoreShell->GetGameData(GDI_COMPOUND_BOX, (unsigned int) &Item, 0);
        if (nCount)
            g_pCoreShell->OperationRequest(GOI_RECOVERY_BOX_COMMAND, pos_compound_box, 0);
    }
}

void KUiDistillPad::UpdateItemObjBox(KUiObjAtRegion *pItem, int bAdd) {
    if (pItem) {
        for (int i = 0; i < _ITEM_DISTILL_COUNT; i++) {
            if (CtrlItemMapDT[i].nPosition == pItem->Region.v) {
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

void KUiDistillPad::UpdateDataObjBox() {
    KUiObjAtRegion Item[_ITEM_DISTILL_COUNT];
    int nCount = g_pCoreShell->GetGameData(GDI_COMPOUND_ITEM, (unsigned int) &Item, 0);
    int i;
    for (i = 0; i < _ITEM_DISTILL_COUNT; i++)
        m_Box[i].Celar();
    for (i = 0; i < nCount; i++) {
        if (Item[i].Obj.uGenre != CGOG_NOTHING)
            UpdateItemObjBox(&Item[i], true);
    }
}

void KUiDistillPad::UpdateItemMatrixBox(KUiObjAtRegion *pItem, int bAdd) {
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

void KUiDistillPad::UpdateDataMatrixBox() {
    m_ItemBox.Clear();

    KUiObjAtRegion *pObjs = NULL;

    int nCount = g_pCoreShell->GetGameData(GDI_COMPOUND_BOX, 0, 0);
    if (nCount <= 0)
        return;

    if (pObjs = (KUiObjAtRegion *) malloc(sizeof(KUiObjAtRegion) * nCount)) {
        g_pCoreShell->GetGameData(GDI_COMPOUND_BOX, (unsigned int) pObjs, nCount);
        for (int i = 0; i < nCount; i++)
            UpdateItemMatrixBox(&pObjs[i], true);
        free(pObjs);
        pObjs = NULL;
    }
}

BOOL KUiDistillPad::EnoughItemPickDrop(KWndWindow *pWnd, int nIndex, int nTypeBox) {
    int nLen;
    char szWarning[128];
    int nGenre, nDetail, nParti, nSeries, nLevel, nStack, nColor; //, bBind;
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
            //		if (bBind != 0)
            //			return FALSE;

            if (nGenre != item_equip || nColor != 1) {
                strcpy(szWarning, ArrayReturnInfo[1]);
                nLen = strlen(szWarning);
                KUiMsgCentrePad::SystemMessageArrival(szWarning, nLen);
                return FALSE;
            }
        } else if (pWnd == (KWndWindow *) &m_Box[1]) {

            if (nStack > 1) {
                strcpy(szWarning, ArrayReturnInfo[4]);
                nLen = strlen(szWarning);
                KUiMsgCentrePad::SystemMessageArrival(szWarning, nLen);
                return FALSE;
            }

            if (nGenre != item_materials || nDetail != CB_HUYENTINH) {
                strcpy(szWarning, ArrayReturnInfo[2]);
                nLen = strlen(szWarning);
                KUiMsgCentrePad::SystemMessageArrival(szWarning, nLen);
                return FALSE;
            }
        } else if (pWnd == (KWndWindow *) &m_Box[2]) {

            if (nStack > 1) {
                strcpy(szWarning, ArrayReturnInfo[4]);
                nLen = strlen(szWarning);
                KUiMsgCentrePad::SystemMessageArrival(szWarning, nLen);
                return FALSE;
            }

            if (nGenre != item_materials || (nDetail < CB_HUYENTHIET_T || nDetail > CB_CHUNGNHU_T)) {
                strcpy(szWarning, ArrayReturnInfo[3]);
                nLen = strlen(szWarning);
                KUiMsgCentrePad::SystemMessageArrival(szWarning, nLen);
                return FALSE;
            }
        } else if (pWnd == (KWndWindow *) &m_Box[3]) {

            if (nStack > 1) {
                strcpy(szWarning, ArrayReturnInfo[4]);
                nLen = strlen(szWarning);
                KUiMsgCentrePad::SystemMessageArrival(szWarning, nLen);
                return FALSE;
            }

            if (nGenre != item_task || (nDetail < SP_CHANKHUYET || nDetail > SP_CHANTUYET)) {
                strcpy(szWarning, ArrayReturnInfo[5]);
                nLen = strlen(szWarning);
                KUiMsgCentrePad::SystemMessageArrival(szWarning, nLen);
                return FALSE;
            }
        }
    } else {
        if (pWnd == (KWndWindow *) &m_ItemBox) {

            if (nGenre != item_task)
                return FALSE;

            if (nStack > 1) {
                strcpy(szWarning, ArrayReturnInfo[4]);
                nLen = strlen(szWarning);
                KUiMsgCentrePad::SystemMessageArrival(szWarning, nLen);
                return FALSE;
            }

            if (nDetail == SP_TBKTHACH || nDetail == SP_TUTHUYTINH || nDetail == SP_LUCTHUYTINH ||
                nDetail == SP_LAMTHUYTINH || nDetail == SP_PPTIEU || nDetail == SP_PPTRUNG ||
                nDetail == SP_PPDAI || nDetail == SP_THBTHACH)
                return TRUE;
        }
    }
    return TRUE;
}


void KUiDistillPad::OnItemPickDrop(ITEM_PICKDROP_PLACE *pPickPos, ITEM_PICKDROP_PLACE *pDropPos) {
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
            Pick.eContainer = UOC_COMPOUND_BOX;
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
            Drop.eContainer = UOC_COMPOUND_BOX;
        }
    }

    for (int i = 0; i < _ITEM_DISTILL_COUNT; i++) {
        if (pWnd == (KWndWindow *) &m_Box[i]) {
            Drop.Region.v = Pick.Region.v = CtrlItemMapDT[i].nPosition;
            break;
        }
    }

    g_pCoreShell->OperationRequest(GOI_SWITCH_OBJECT,
                                   pPickPos ? (unsigned int) &Pick : 0,
                                   pDropPos ? (int) &Drop : 0);
}

/*********************************************************************************************
Class KUiForgePad
**********************************************************************************************/
static struct UE_CTRL_MAP_FG {
    int nPosition;
    const char *pIniSection;
}

        CtrlItemMapFG[_ITEM_FORGE_COUNT] =
        {
                {UIEP_COMPOUNDITEM1, "BigBoxFG"},
                {UIEP_COMPOUNDITEM2, "SmallBoxFG"},
        };

void KUiForgePad::Initialize() {
    int i = 0;
    for (i = 0; i < _ITEM_FORGE_COUNT; i++) {
        m_Box[i].SetObjectGenre(CGOG_ITEM);
        AddChild(&m_Box[i]);
        m_Box[i].SetContainerId((int) UOC_COMPOUND_ITEM);
    }
    for (i = 0; i < EFFECT_COUNT - 1; i++) {
        AddChild(&m_Effect[i]);
        m_Effect[i].Hide();
    }
    AddChild(&m_ForgeBtn);
    AddChild(&m_CancleFGBtn);
}

void KUiForgePad::LoadScheme(class KIniFile *pIni) {
    char Buff[32];
    KWndPage::Init(pIni, "ForgeMain");
    for (int i = 0; i < _ITEM_FORGE_COUNT; i++) {
        m_Box[i].Init(pIni, CtrlItemMapFG[i].pIniSection);
    }

    m_Effect[0].Init(pIni, "EquipFGEffect");
    m_ForgeBtn.Init(pIni, "ForgeBtn");
    m_CancleFGBtn.Init(pIni, "CancleFGBtn");

    for (i = 0; i < 6; i++) {
        sprintf(Buff, "%d", i);
        pIni->GetString("ReturnFGInfo", Buff, "", ArrayReturnInfo[i], sizeof(ArrayReturnInfo[i]));
    }

    m_EffectTime = 0;
}

int KUiForgePad::WndProc(unsigned int uMsg, unsigned int uParam, int nParam) {
    switch (uMsg) {
        case WND_N_BUTTON_CLICK:
            if (uParam == (unsigned int) &m_ForgeBtn) {
                if (EnoughItemToGo()) {
                    if (m_EffectTime) break;
                    UIMessageBox(ArrayReturnInfo[0], this, "X¸c nhËn ", "Hñy bá ", ISP_DO_EVENT);
                }
            } else if (uParam == (unsigned int) &m_CancleFGBtn) {
                if (m_EffectTime) break;
                CleanItem();
            }
            break;
        case WND_N_ITEM_PICKDROP:
            if (g_UiBase.IsOperationEnable(UIS_O_MOVE_ITEM))
                OnItemPickDrop((ITEM_PICKDROP_PLACE *) uParam, (ITEM_PICKDROP_PLACE *) nParam);
            break;
        case WND_M_OTHER_WORK_RESULT:
            if (uParam == ISP_DO_EVENT) {
                if (!nParam) {
                    m_Effect[0].SetFrame(-1);
                    m_EffectTime = 1;
                    StartEffect();
                }
            }
            break;
        default:
            return KWndPage::WndProc(uMsg, uParam, nParam);
    }
    return 0;
}

void KUiForgePad::Breathe() {
    if (m_Effect[0].IsVisible())
        m_Effect[0].NextFrame();
    if (m_EffectTime)
        m_EffectTime++;
    if (m_EffectTime == (m_Effect[0].GetMaxFrame()) * 2 / 2 + 4) {
        StopEffect();
        m_EffectTime = 0;
    }
}

void KUiForgePad::StopEffect() {
    m_Effect[0].Hide();
    UpdatePickPut(true);
    OnOk();
}

void KUiForgePad::StartEffect() {
    m_Effect[0].Show();
    UpdatePickPut(false);
}

BOOL KUiForgePad::IsEffect() {
    if (m_EffectTime) return TRUE;
    return FALSE;
}

void KUiForgePad::UpdatePickPut(bool bLock) {
    for (int i = 0; i < _ITEM_FORGE_COUNT; i++)
        m_Box[i].EnablePickPut(bLock);
    m_ForgeBtn.Enable(bLock);
    m_CancleFGBtn.Enable(bLock);

    KUiComPound *pCom = KUiComPound::GetIfVisible();
    if (pCom) {
        pCom->m_Close.Enable(bLock);
        pCom->m_DistillBtn.Enable(bLock);
        pCom->m_EnchaseBtn.Enable(bLock);
        pCom->m_ForgeBtn.Enable(bLock);
    }
}

void KUiForgePad::OnOk() {
    if (g_pCoreShell) {
        g_pCoreShell->OperationRequest(GOI_ADD_UI_CMD_SCRIPT, 7, (unsigned int) "main");
    }
}

BOOL KUiForgePad::EnoughItemToGo() {
    int nLen;
    char szWarning[128];
    int nCount = 0;
    KUiDraggedObject pObj;
    for (int i = 0; i < _ITEM_FORGE_COUNT; i++) {
        pObj.uId = 0;
        m_Box[i].GetObject(pObj);
        if (pObj.uId > 0)
            nCount += 1;
    }

    if (nCount < 2) {
        strcpy(szWarning, ArrayReturnInfo[5]);
        nLen = strlen(szWarning);
        KUiMsgCentrePad::SystemMessageArrival(szWarning, nLen);
        return FALSE;
    }
    return TRUE;
}

void KUiForgePad::CleanItem() {
    if (g_pCoreShell) {
        int nCount;
        KUiObjAtRegion Item[_ITEM_DISTILL_COUNT];
        nCount = g_pCoreShell->GetGameData(GDI_COMPOUND_ITEM, (unsigned int) &Item, 0);
        if (nCount)
            g_pCoreShell->OperationRequest(GOI_RECOVERY_BOX_COMMAND, pos_compound_item, 0);
    }
}

void KUiForgePad::UpdateItemObjBox(KUiObjAtRegion *pItem, int bAdd) {
    if (pItem) {
        for (int i = 0; i < _ITEM_FORGE_COUNT; i++) {
            if (CtrlItemMapFG[i].nPosition == pItem->Region.v) {
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

void KUiForgePad::UpdateDataObjBox() {
    KUiObjAtRegion Item[_ITEM_FORGE_COUNT];
    int nCount = g_pCoreShell->GetGameData(GDI_COMPOUND_ITEM, (unsigned int) &Item, 0);
    int i;
    for (i = 0; i < _ITEM_FORGE_COUNT; i++)
        m_Box[i].Celar();
    for (i = 0; i < nCount; i++) {
        if (Item[i].Obj.uGenre != CGOG_NOTHING)
            UpdateItemObjBox(&Item[i], true);
    }
}

BOOL KUiForgePad::EnoughItemPickDrop(KWndWindow *pWnd, int nIndex) {
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

    if (pWnd == (KWndWindow *) &m_Box[0]) {
//		if (bBind != 0)
//			return FALSE;

        if (nGenre != item_equip) {
            strcpy(szWarning, ArrayReturnInfo[1]);
            nLen = strlen(szWarning);
            KUiMsgCentrePad::SystemMessageArrival(szWarning, nLen);
            return FALSE;
        }

        if (nDetail == equip_ring || nDetail == equip_amulet || nDetail == equip_pendant ||
            nDetail == equip_horse /*|| nDetail == equip_fifong ||
			nDetail == equip_charm || nDetail == equip_key*/)
            return FALSE;
    } else if (pWnd == (KWndWindow *) &m_Box[1]) {

        if (nStack > 1) {
            strcpy(szWarning, ArrayReturnInfo[3]);
            nLen = strlen(szWarning);
            KUiMsgCentrePad::SystemMessageArrival(szWarning, nLen);
            return FALSE;
        }

        if (nGenre != item_materials || nDetail != CB_HUYENTINH) {
            strcpy(szWarning, ArrayReturnInfo[2]);
            nLen = strlen(szWarning);
            KUiMsgCentrePad::SystemMessageArrival(szWarning, nLen);
            return FALSE;
        }
    }
    return TRUE;
}

void KUiForgePad::OnItemPickDrop(ITEM_PICKDROP_PLACE *pPickPos, ITEM_PICKDROP_PLACE *pDropPos) {
    KUiObjAtContRegion Drop, Pick;
    KUiDraggedObject Obj;
    KWndWindow *pWnd = NULL;

    UISYS_STATUS eStatus = g_UiBase.GetStatus();
    if (pPickPos) {
        ((KWndObjectBox *) (pPickPos->pWnd))->GetObject(Obj);
        Pick.Obj.uGenre = Obj.uGenre;
        Pick.Obj.uId = Obj.uId;
        Pick.Region.Width = Obj.DataW;
        Pick.Region.Height = Obj.DataH;
        Pick.Region.h = 0;
        Pick.eContainer = UOC_COMPOUND_ITEM;
        pWnd = pPickPos->pWnd;

    } else if (pDropPos) {
        pWnd = pDropPos->pWnd;
    } else
        return;

    if (pDropPos) {
        Wnd_GetDragObj(&Obj);
        if (!EnoughItemPickDrop(pWnd, Obj.uId))
            return;

        Drop.Obj.uGenre = Obj.uGenre;
        Drop.Obj.uId = Obj.uId;
        Drop.Region.Width = Obj.DataW;
        Drop.Region.Height = Obj.DataH;
        Drop.Region.h = 0;
        Drop.eContainer = UOC_COMPOUND_ITEM;
    }

    for (int i = 0; i < _ITEM_FORGE_COUNT; i++) {
        if (pWnd == (KWndWindow *) &m_Box[i]) {
            Drop.Region.v = Pick.Region.v = CtrlItemMapFG[i].nPosition;
            break;
        }
    }

    g_pCoreShell->OperationRequest(GOI_SWITCH_OBJECT,
                                   pPickPos ? (unsigned int) &Pick : 0,
                                   pDropPos ? (int) &Drop : 0);
}

/******************************************************************************************
Class KUiEnchasePad
**********************************************************************************************/
static struct UE_CTRL_MAP_EC {
    int nPosition;
    const char *pIniSection;
}

        CtrlItemMapEC[_ITEM_ENCHASE_COUNT] =
        {
                {UIEP_COMPOUNDITEM1, "BigBoxEC"},
                {UIEP_COMPOUNDITEM2, "SmallBoxEC1"},
                {UIEP_COMPOUNDITEM3, "SmallBoxEC2"},
                {UIEP_COMPOUNDITEM4, "SmallBoxEC3"},
        };

void KUiEnchasePad::Initialize() {
    int i = 0;
    for (i = 0; i < _ITEM_ENCHASE_COUNT; i++) {
        m_Box[i].SetObjectGenre(CGOG_ITEM);
        AddChild(&m_Box[i]);
        m_Box[i].SetContainerId((int) UOC_COMPOUND_ITEM);
    }
    for (i = 0; i < EFFECT_COUNT; i++) {
        AddChild(&m_Effect[i]);
        m_Effect[i].Hide();
    }
    AddChild(&m_ItemBox);
    AddChild(&m_EnchaseBtn);
    AddChild(&m_CancleECBtn);
    m_ItemBox.SetContainerId((int) UOC_COMPOUND_BOX);
    Wnd_AddWindow(this);
}

void KUiEnchasePad::LoadScheme(class KIniFile *pIni) {
    char Buff[32];
    int i = 0;
    KWndPage::Init(pIni, "EnchaseMain");
    for (i = 0; i < _ITEM_ENCHASE_COUNT; i++) {
        m_Box[i].Init(pIni, CtrlItemMapEC[i].pIniSection);
    }

    m_Effect[0].Init(pIni, "EquipECEffect");
    m_Effect[1].Init(pIni, "ConsumeECEffect");
    m_ItemBox.Init(pIni, "ItemBoxEC");
    m_EnchaseBtn.Init(pIni, "EnchaseBtn");
    m_CancleECBtn.Init(pIni, "CancleECBtn");

    for (i = 0; i < 8; i++) {
        sprintf(Buff, "%d", i);
        pIni->GetString("ReturnECInfo", Buff, "", ArrayReturnInfo[i], sizeof(ArrayReturnInfo[i]));
    }

    m_EffectTime = 0;
}

int KUiEnchasePad::WndProc(unsigned int uMsg, unsigned int uParam, int nParam) {
    switch (uMsg) {
        case WND_N_BUTTON_CLICK:
            if (uParam == (unsigned int) &m_EnchaseBtn) {
                if (EnoughItemToGo()) {
                    if (m_EffectTime) break;
                    UIMessageBox(ArrayReturnInfo[0], this, "X¸c nhËn ", "Hñy bá ", ISP_DO_EVENT);
                }
            } else if (uParam == (unsigned int) &m_CancleECBtn) {
                if (m_EffectTime) break;
                CleanItem();
            }
            break;
        case WND_N_ITEM_PICKDROP:
            if (g_UiBase.IsOperationEnable(UIS_O_MOVE_ITEM))
                OnItemPickDrop((ITEM_PICKDROP_PLACE *) uParam, (ITEM_PICKDROP_PLACE *) nParam);
            break;
        case WND_M_OTHER_WORK_RESULT:
            if (uParam == ISP_DO_EVENT) {
                if (!nParam) {
                    m_Effect[0].SetFrame(-1);
                    m_Effect[1].SetFrame(-1);
                    m_EffectTime = 1;
                    StartEffect();
                }
            }
            break;
        default:
            return KWndPage::WndProc(uMsg, uParam, nParam);
    }
    return 0;
}

void KUiEnchasePad::Breathe() {
    if (m_Effect[0].IsVisible())
        m_Effect[0].NextFrame();
    if (m_Effect[1].IsVisible())
        m_Effect[1].NextFrame();
    if (m_EffectTime)
        m_EffectTime++;
    if (m_EffectTime == (m_Effect[0].GetMaxFrame()) * 2 / 2 + 4) {
        StopEffect();
        m_EffectTime = 0;
    }
}

void KUiEnchasePad::StopEffect() {
    m_Effect[0].Hide();
    m_Effect[1].Hide();
    UpdatePickPut(true);
    OnOk();
}

void KUiEnchasePad::StartEffect() {
    m_Effect[0].Show();
    m_Effect[1].Show();
    UpdatePickPut(false);
}

BOOL KUiEnchasePad::IsEffect() {
    if (m_EffectTime) return TRUE;
    return FALSE;
}

void KUiEnchasePad::UpdatePickPut(bool bLock) {
    for (int i = 0; i < _ITEM_ENCHASE_COUNT; i++)
        m_Box[i].EnablePickPut(bLock);
    m_ItemBox.EnablePickPut(bLock);
    m_EnchaseBtn.Enable(bLock);
    m_CancleECBtn.Enable(bLock);

    KUiComPound *pCom = KUiComPound::GetIfVisible();
    if (pCom) {
        pCom->m_Close.Enable(bLock);
        pCom->m_DistillBtn.Enable(bLock);
        pCom->m_EnchaseBtn.Enable(bLock);
        pCom->m_ForgeBtn.Enable(bLock);
    }
}

void KUiEnchasePad::OnOk() {
    if (g_pCoreShell) {
        g_pCoreShell->OperationRequest(GOI_ADD_UI_CMD_SCRIPT, 8, (unsigned int) "main");
    }
}

BOOL KUiEnchasePad::EnoughItemToGo() {
    int nLen;
    char szWarning[128];
    int nCount = 0;
    KUiDraggedObject pObj;
    for (int i = 0; i < _ITEM_ENCHASE_COUNT - 1; i++) {
        pObj.uId = 0;
        m_Box[i].GetObject(pObj);
        if (pObj.uId > 0)
            nCount += 1;
    }

    if (nCount < 3) {
        strcpy(szWarning, ArrayReturnInfo[6]);
        nLen = strlen(szWarning);
        KUiMsgCentrePad::SystemMessageArrival(szWarning, nLen);
        return FALSE;
    }
    return TRUE;
}

void KUiEnchasePad::CleanItem() {
    if (g_pCoreShell) {
        int nCount;
        KUiObjAtRegion Item[_ITEM_ENCHASE_COUNT];
        nCount = g_pCoreShell->GetGameData(GDI_COMPOUND_ITEM, (unsigned int) &Item, 0);
        if (nCount)
            g_pCoreShell->OperationRequest(GOI_RECOVERY_BOX_COMMAND, pos_compound_item, 0);
        nCount = g_pCoreShell->GetGameData(GDI_COMPOUND_BOX, (unsigned int) &Item, 0);
        if (nCount)
            g_pCoreShell->OperationRequest(GOI_RECOVERY_BOX_COMMAND, pos_compound_box, 0);
    }
}

void KUiEnchasePad::UpdateItemObjBox(KUiObjAtRegion *pItem, int bAdd) {
    if (pItem) {
        for (int i = 0; i < _ITEM_ENCHASE_COUNT; i++) {
            if (CtrlItemMapEC[i].nPosition == pItem->Region.v) {
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

void KUiEnchasePad::UpdateDataObjBox() {
    KUiObjAtRegion Item[_ITEM_ENCHASE_COUNT];
    int nCount = g_pCoreShell->GetGameData(GDI_COMPOUND_ITEM, (unsigned int) &Item, 0);
    int i;
    for (i = 0; i < _ITEM_ENCHASE_COUNT; i++)
        m_Box[i].Celar();
    for (i = 0; i < nCount; i++) {
        if (Item[i].Obj.uGenre != CGOG_NOTHING)
            UpdateItemObjBox(&Item[i], true);
    }
}

void KUiEnchasePad::UpdateItemMatrixBox(KUiObjAtRegion *pItem, int bAdd) {
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

void KUiEnchasePad::UpdateDataMatrixBox() {
    m_ItemBox.Clear();

    KUiObjAtRegion *pObjs = NULL;

    int nCount = g_pCoreShell->GetGameData(GDI_COMPOUND_BOX, 0, 0);
    if (nCount <= 0)
        return;

    if (pObjs = (KUiObjAtRegion *) malloc(sizeof(KUiObjAtRegion) * nCount)) {
        g_pCoreShell->GetGameData(GDI_COMPOUND_BOX, (unsigned int) pObjs, nCount);
        for (int i = 0; i < nCount; i++)
            UpdateItemMatrixBox(&pObjs[i], true);
        free(pObjs);
        pObjs = NULL;
    }
}

BOOL KUiEnchasePad::EnoughItemPickDrop(KWndWindow *pWnd, int nIndex, int nTypeBox) {
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
//			if (bBind != 0)
//				return FALSE;

            if (nColor != 4) {
                strcpy(szWarning, ArrayReturnInfo[1]);
                nLen = strlen(szWarning);
                KUiMsgCentrePad::SystemMessageArrival(szWarning, nLen);
                return FALSE;
            }
        } else if (pWnd == (KWndWindow *) &m_Box[1]) {

            if (nStack > 1) {
                strcpy(szWarning, ArrayReturnInfo[4]);
                nLen = strlen(szWarning);
                KUiMsgCentrePad::SystemMessageArrival(szWarning, nLen);
                return FALSE;
            }

            if (nGenre != item_materials || nDetail != CB_HUYENTINH) {
                strcpy(szWarning, ArrayReturnInfo[2]);
                nLen = strlen(szWarning);
                KUiMsgCentrePad::SystemMessageArrival(szWarning, nLen);
                return FALSE;
            }
        } else if (pWnd == (KWndWindow *) &m_Box[2]) {

            if (nStack > 1) {
                strcpy(szWarning, ArrayReturnInfo[4]);
                nLen = strlen(szWarning);
                KUiMsgCentrePad::SystemMessageArrival(szWarning, nLen);
                return FALSE;
            }

            if (nGenre != item_materials || (nDetail < CB_HUYENTHIET || nDetail > CB_CHUNGNHU)) {
                strcpy(szWarning, ArrayReturnInfo[3]);
                nLen = strlen(szWarning);
                KUiMsgCentrePad::SystemMessageArrival(szWarning, nLen);
                return FALSE;
            }
        } else if (pWnd == (KWndWindow *) &m_Box[3]) {

            if (nStack > 1) {
                strcpy(szWarning, ArrayReturnInfo[4]);
                nLen = strlen(szWarning);
                KUiMsgCentrePad::SystemMessageArrival(szWarning, nLen);
                return FALSE;
            }

            if (nGenre != item_task || (nDetail < SP_CHANKHUYET || nDetail > SP_CHANTUYET)) {
                strcpy(szWarning, ArrayReturnInfo[5]);
                nLen = strlen(szWarning);
                KUiMsgCentrePad::SystemMessageArrival(szWarning, nLen);
                return FALSE;
            }
        }
    } else {
        if (pWnd == (KWndWindow *) &m_ItemBox) {

            if (nGenre != item_task)
                return FALSE;

            if (nStack > 1) {
                strcpy(szWarning, ArrayReturnInfo[4]);
                nLen = strlen(szWarning);
                KUiMsgCentrePad::SystemMessageArrival(szWarning, nLen);
                return FALSE;
            }

            if (nDetail == SP_TBKTHACH || nDetail == SP_TUTHUYTINH || nDetail == SP_LUCTHUYTINH ||
                nDetail == SP_LAMTHUYTINH || nDetail == SP_PPTIEU || nDetail == SP_PPTRUNG ||
                nDetail == SP_PPDAI || nDetail == SP_THBTHACH)
                return TRUE;
        }
    }
    return TRUE;
}

void KUiEnchasePad::OnItemPickDrop(ITEM_PICKDROP_PLACE *pPickPos, ITEM_PICKDROP_PLACE *pDropPos) {
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
            Pick.eContainer = UOC_COMPOUND_BOX;
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
            Drop.eContainer = UOC_COMPOUND_BOX;
        }
    }

    for (int i = 0; i < _ITEM_ENCHASE_COUNT; i++) {
        if (pWnd == (KWndWindow *) &m_Box[i]) {
            Drop.Region.v = Pick.Region.v = CtrlItemMapEC[i].nPosition;
            break;
        }
    }

    g_pCoreShell->OperationRequest(GOI_SWITCH_OBJECT,
                                   pPickPos ? (unsigned int) &Pick : 0,
                                   pDropPos ? (int) &Drop : 0);
}

/*********************************************************************************************
Class KUiComPound
**********************************************************************************************/
KUiComPound *KUiComPound::m_pSelf = NULL;

KUiComPound::KUiComPound() {
    m_nCurPage = WINDOWS_DISTILL;
}

KUiComPound::~KUiComPound() {
}

KUiComPound *KUiComPound::OpenWindow() {
    if (m_pSelf == NULL) {
        m_pSelf = new KUiComPound;
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

KUiComPound *KUiComPound::GetIfVisible() {
    if (m_pSelf && m_pSelf->IsVisible())
        return m_pSelf;
    return NULL;
}

void KUiComPound::CloseWindow(bool bDestroy) {
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

void KUiComPound::Initialize() {
    m_DistillPad.Initialize();
    AddPage(&m_DistillPad, &m_DistillBtn);
    m_ForgePad.Initialize();
    AddPage(&m_ForgePad, &m_ForgeBtn);
    m_EnchasePad.Initialize();
    AddPage(&m_EnchasePad, &m_EnchaseBtn);

    AddChild(&m_Close);

    AddChild(&m_DistillBtn);
    AddChild(&m_ForgeBtn);
    AddChild(&m_EnchaseBtn);

    char Scheme[256];
    g_UiBase.GetCurSchemePath(Scheme, 256);
    LoadScheme(Scheme);
    Wnd_AddWindow(this);
}

void KUiComPound::LoadScheme(const char *pScheme) {
    if (m_pSelf) {
        char Buff[128];
        KIniFile Ini;
        sprintf(Buff, "%s\\%s", pScheme, SCHEME_INI);
        if (Ini.Load(Buff))
            m_pSelf->LoadScheme(&Ini);
    }
}

void KUiComPound::LoadScheme(class KIniFile *pIni) {
    m_pSelf->Init(pIni, "Main");

    m_pSelf->m_DistillPad.LoadScheme(pIni);
    m_pSelf->m_ForgePad.LoadScheme(pIni);
    m_pSelf->m_EnchasePad.LoadScheme(pIni);

    m_pSelf->m_DistillBtn.Init(pIni, "DistillPadBtn");
    m_pSelf->m_ForgeBtn.Init(pIni, "ForgePadBtn");
    m_pSelf->m_EnchaseBtn.Init(pIni, "EnchasePadBtn");

    m_pSelf->m_Close.Init(pIni, "CloseBtn");
}

int KUiComPound::WndProc(unsigned int uMsg, unsigned int uParam, int nParam) {
    switch (uMsg) {
        case WND_N_BUTTON_CLICK:
            if (uParam == (unsigned int) (KWndWindow *) &m_Close) {
                CloseWindow(false);
                return 0;
            } else if (uParam == (unsigned int) (KWndWindow *) &m_DistillBtn) {
                m_nCurPage = WINDOWS_DISTILL;
                ShowPage();
                return 0;
            } else if (uParam == (unsigned int) (KWndWindow *) &m_ForgeBtn) {
                m_nCurPage = WINDOWS_FORGE;
                ShowPage();
                return 0;
            } else if (uParam == (unsigned int) (KWndWindow *) &m_EnchaseBtn) {
                m_nCurPage = WINDOWS_ENCHASE;
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

void KUiComPound::Breathe() {
    switch (m_nCurPage) {
        case WINDOWS_DISTILL:
            m_DistillPad.Breathe();
            break;
        case WINDOWS_FORGE:
            m_ForgePad.Breathe();
            break;
        case WINDOWS_ENCHASE:
            m_EnchasePad.Breathe();
            break;
    }
}

void KUiComPound::ShowPage() {
    switch (m_nCurPage) {
        case WINDOWS_DISTILL:
            m_DistillBtn.CheckButton(true);
            m_ForgeBtn.CheckButton(false);
            m_EnchaseBtn.CheckButton(false);
            m_DistillPad.Show();
            m_ForgePad.Hide();
            m_EnchasePad.Hide();
            OnCancel();
            break;
        case WINDOWS_FORGE:
            m_DistillBtn.CheckButton(false);
            m_ForgeBtn.CheckButton(true);
            m_EnchaseBtn.CheckButton(false);
            m_DistillPad.Hide();
            m_ForgePad.Show();
            m_EnchasePad.Hide();
            OnCancel();
            break;
        case WINDOWS_ENCHASE:
            m_DistillBtn.CheckButton(false);
            m_ForgeBtn.CheckButton(false);
            m_EnchaseBtn.CheckButton(true);
            m_DistillPad.Hide();
            m_ForgePad.Hide();
            m_EnchasePad.Show();
            OnCancel();
            break;
    }
}

void KUiComPound::UpdateItemObjBox(KUiObjAtRegion *pItem, int bAdd) {
    if (m_pSelf) {
        switch (m_nCurPage) {
            case WINDOWS_DISTILL:
                m_DistillPad.UpdateItemObjBox(pItem, bAdd);
                break;
            case WINDOWS_FORGE:
                m_ForgePad.UpdateItemObjBox(pItem, bAdd);
                break;
            case WINDOWS_ENCHASE:
                m_EnchasePad.UpdateItemObjBox(pItem, bAdd);
                break;
        }
    }
}

void KUiComPound::UpdateItemMatrixBox(KUiObjAtRegion *pItem, int bAdd) {
    if (m_pSelf) {
        switch (m_nCurPage) {
            case WINDOWS_DISTILL:
                m_DistillPad.UpdateItemMatrixBox(pItem, bAdd);
                break;
            case WINDOWS_ENCHASE:
                m_EnchasePad.UpdateItemMatrixBox(pItem, bAdd);
                break;
        }
    }
}

void KUiComPound::UpdateDataObjBox() {
    if (m_pSelf) {
        switch (m_nCurPage) {
            case WINDOWS_DISTILL:
                m_DistillPad.UpdateDataObjBox();
                break;
            case WINDOWS_FORGE:
                m_ForgePad.UpdateDataObjBox();
                break;
            case WINDOWS_ENCHASE:
                m_EnchasePad.UpdateDataObjBox();
                break;
        }
    }
}

void KUiComPound::UpdateDataMatrixBox() {
    if (m_pSelf) {
        switch (m_nCurPage) {
            case WINDOWS_DISTILL:
                m_DistillPad.UpdateDataMatrixBox();
                break;
            case WINDOWS_ENCHASE:
                m_EnchasePad.UpdateDataMatrixBox();
                break;
        }
    }
}

void KUiComPound::OnCancel() {
    if (g_pCoreShell) {
        int nCount;
        KUiObjAtRegion Item[_ITEM_ENCHASE_COUNT];
        nCount = g_pCoreShell->GetGameData(GDI_COMPOUND_ITEM, (unsigned int) &Item, 0);
        if (nCount)
            g_pCoreShell->OperationRequest(GOI_RECOVERY_BOX_COMMAND, pos_compound_item, 0);
        nCount = g_pCoreShell->GetGameData(GDI_COMPOUND_BOX, (unsigned int) &Item, 0);
        if (nCount)
            g_pCoreShell->OperationRequest(GOI_RECOVERY_BOX_COMMAND, pos_compound_box, 0);
    }
}
