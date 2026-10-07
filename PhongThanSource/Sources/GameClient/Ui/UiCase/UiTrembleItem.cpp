/*******************************************************************************
File        : UiTrembleItem.cpp
Creator     : TamLTM || AWJX
create data : 01.05.2014
Chuc nang	: Kham nam trang bi xanh
********************************************************************************/

#include "KWin32.h"
#include "KIniFile.h"
#include "../Elem/AutoLocateWnd.h"
#include "../Elem/WndMessage.h"
#include "../Elem/Wnds.h"
#include "UiTrembleItem.h"
#include "UiItem.h"
#include "UiMsgCentrePad.h"
#include "UiInformation.h"
#include "../../../core/src/coreshell.h"
#include "../../../core/src/GameDataDef.h"
#include "../../../Engine/src/Text.h"
#include "../UiSoundSetting.h"
#include "../UiBase.h"
#include <crtdbg.h>

extern iCoreShell *g_pCoreShell;

#define TREMBLE_ITEM_INI "UiTremble.ini"

KUiTrembleItem *KUiTrembleItem::m_pSelf = NULL;

static struct UE_CTRL_MAP {
    int nPosition;
    const char *pIniSection;
}

        CtrlItemMap[] =
        {
                {UIEP_BUILDITEM1, "Item"},
                {UIEP_BUILDITEM2, "GemLevel"},    // tu tt
                {UIEP_BUILDITEM3, "GemSpirit"},    // luc tt
                {UIEP_BUILDITEM4, "GemGold"},
                {UIEP_BUILDITEM5, "GemWood"},
                {UIEP_BUILDITEM6, "GemWater"},
                {UIEP_BUILDITEM7, "GemFire"},
                {UIEP_BUILDITEM8, "GemEarth"},
                {UIEP_BUILDITEM9, "GemLucky"}
        };

/*********************************************************************
**********************************************************************/
KUiTrembleItem *KUiTrembleItem::OpenWindow() {
    if (m_pSelf == NULL) {
        m_pSelf = new KUiTrembleItem;
        if (m_pSelf)
            m_pSelf->Initialize();
    }
    if (m_pSelf) {
        UiSoundPlay(UI_SI_WND_OPENCLOSE);

        if (!KUiItem::GetIfVisible())
            KUiItem::OpenWindow();

        m_pSelf->UpdateData();
        m_pSelf->BringToTop();
        m_pSelf->Show();
        Wnd_GameSpaceHandleInput(false);
    }
    return m_pSelf;
}

/*********************************************************************
**********************************************************************/
KUiTrembleItem *KUiTrembleItem::GetIfVisible() {
    if (m_pSelf && m_pSelf->IsVisible())
        return m_pSelf;
    return NULL;
}

/*********************************************************************
**********************************************************************/
void KUiTrembleItem::CloseWindow(bool bDestory) {
    if (m_pSelf) {
        Wnd_GameSpaceHandleInput(true);
        if (bDestory) {
            m_pSelf->Destroy();
            m_pSelf = NULL;
        } else
            m_pSelf->Hide();

        m_pSelf->OnCancel();
    }
}

/*********************************************************************
**********************************************************************/
void KUiTrembleItem::Initialize() {
    int i = 0;
    AddChild(&m_Confirm);
    AddChild(&m_Cancel);
    AddChild(&m_TrembleEffect);

    for (i = 0; i < _ITEM_TREMBLE_COUNT; i++) {
        m_TrembleBox[i].SetObjectGenre(CGOG_ITEM);
        AddChild(&m_TrembleBox[i]);
        m_TrembleBox[i].SetContainerId((int) UOC_BUILD_ITEM);
    }
    char Scheme[256];
    g_UiBase.GetCurSchemePath(Scheme, 256);
    LoadScheme(Scheme);

    Wnd_AddWindow(this);
}


/*********************************************************************
**********************************************************************/
void KUiTrembleItem::LoadScheme(const char *pScheme) {
    if (m_pSelf) {
        char Buff[128];
        KIniFile Ini;
        int i = 0;
        sprintf(Buff, "%s\\%s", pScheme, TREMBLE_ITEM_INI);
        if (Ini.Load(Buff)) {
            m_pSelf->Init(&Ini, "Main");

            m_pSelf->m_TrembleEffect.Init(&Ini, "Effect");
            m_pSelf->m_TrembleEffect.Hide();
            m_pSelf->m_EffectTime = 0;

            m_pSelf->m_Confirm.Init(&Ini, "Assemble");
//			m_pSelf->m_Confirm.Enable(true);
            m_pSelf->m_Cancel.Init(&Ini, "Close");
//			m_pSelf->m_Cancel.Enable(true);


            for (i = 0; i < _ITEM_TREMBLE_COUNT; i++) {
                m_pSelf->m_TrembleBox[i].Init(&Ini, CtrlItemMap[i].pIniSection);
//				m_pSelf->m_TrembleBox[i].EnablePickPut(true);
            }

            char szTemp[2];
            for (i = 0; i < 8; i++) {
                sprintf(szTemp, "%d", i);
                Ini.GetString("ReturnInfo", szTemp, "", m_pSelf->ArrayReturnInfo[i],
                              sizeof(m_pSelf->ArrayReturnInfo[i]));
            }
        }
    }
}

/*********************************************************************
**********************************************************************/
int KUiTrembleItem::WndProc(unsigned int uMsg, unsigned int uParam, int nParam) {
    int nRet = 0;
    switch (uMsg) {
        case WND_N_BUTTON_CLICK:
            if (uParam == (unsigned int) &m_Confirm) {
                if (EnoughItemToGo()) {
                    if (m_EffectTime) break;
                    UIMessageBox(ArrayReturnInfo[0], this, "X¸c nhËn ", "Hñy bá ",
                                 ISP_DO_EVENT); // hien thi khung box talk
                }
            } else if (uParam == (unsigned int) &m_Cancel) {
                if (m_EffectTime) break;
                CloseWindow(true);
            }
            break;
        case WM_KEYDOWN:
            if (uParam == VK_RETURN)        //enter
            {
                if (EnoughItemToGo()) {
                    UIMessageBox(ArrayReturnInfo[0], this, "X¸c nhËn ", "Hñy bá ", ISP_DO_EVENT);
                }
                nRet = 1;
            } else if (uParam == VK_ESCAPE)    // esc
            {
                CloseWindow(true);
                nRet = 1;
            }
            break;
        case WND_N_ITEM_PICKDROP:
            if (g_UiBase.IsOperationEnable(UIS_O_MOVE_ITEM))
                OnItemPickDrop((ITEM_PICKDROP_PLACE *) uParam, (ITEM_PICKDROP_PLACE *) nParam);
            break;
        case WND_M_OTHER_WORK_RESULT:
            if (uParam == ISP_DO_EVENT) {
                if (!nParam) {
                    m_TrembleEffect.SetFrame(-1);
                    m_EffectTime = 1;
                    StartEffect();
                }
            }
            break;
        default:
            return KWndShowAnimate::WndProc(uMsg, uParam, nParam);
    }
    return nRet;
}

BOOL KUiTrembleItem::EnoughItemToGo() {
    int nLen;
    char szWarning[128];
    int nCount = 0;
    KUiDraggedObject pObj;
    for (int i = 0; i < _ITEM_TREMBLE_COUNT - 1; i++) {
        pObj.uId = 0;
        m_TrembleBox[i].GetObject(pObj);
        if (pObj.uId > 0)
            nCount += 1;
    }

    if (nCount < 2) {
        strcpy(szWarning, ArrayReturnInfo[1]);
        nLen = strlen(szWarning);
        KUiMsgCentrePad::SystemMessageArrival(szWarning, nLen);
        return FALSE;
    }

    if (nCount > 2) {
        strcpy(szWarning, ArrayReturnInfo[2]);
        nLen = strlen(szWarning);
        KUiMsgCentrePad::SystemMessageArrival(szWarning, nLen);
        return FALSE;
    }
    return TRUE;
}

BOOL KUiTrembleItem::EnoughItemPickDrop(KWndWindow *pWnd, int nIndex) {
    int nLen;
    char szWarning[128];
    int nGenre, nDetail, nParti, nSeries, nLevel, nStack;
    nGenre = g_pCoreShell->GetGenreItem(nIndex);
    nDetail = g_pCoreShell->GetDetailItem(nIndex);
    nParti = g_pCoreShell->GetParticularItem(nIndex);
    nLevel = g_pCoreShell->GetLevelItem(nIndex);
    nSeries = g_pCoreShell->GetSeriesItem(nIndex);
    nStack = g_pCoreShell->GetStackNum(nIndex);

    if (pWnd == (KWndWindow *) &m_TrembleBox[0]) {

        if (nGenre != item_equip) {
            strcpy(szWarning, ArrayReturnInfo[3]);
            nLen = strlen(szWarning);
            KUiMsgCentrePad::SystemMessageArrival(szWarning, nLen);
            return FALSE;
        }

        if (nDetail == equip_horse) /*||
			nDetail == equip_fifong || nDetail == equip_charm || nDetail == equip_key)*/
            return FALSE;

    } else if (pWnd == (KWndWindow *) &m_TrembleBox[1]) {

        if (nGenre != item_task || nDetail != SP_TUTHUYTINH) {
            strcpy(szWarning, ArrayReturnInfo[5]);
            nLen = strlen(szWarning);
            KUiMsgCentrePad::SystemMessageArrival(szWarning, nLen);
            return FALSE;
        }
    } else if (pWnd == (KWndWindow *) &m_TrembleBox[2]) {

        if (nGenre != item_task || nDetail != SP_LUCTHUYTINH) {
            strcpy(szWarning, ArrayReturnInfo[6]);
            nLen = strlen(szWarning);
            KUiMsgCentrePad::SystemMessageArrival(szWarning, nLen);
            return FALSE;
        }
    } else if (pWnd == (KWndWindow *) &m_TrembleBox[3]) {

        if (nGenre != item_task || nDetail != SP_LAMTHUYTINH) {
            strcpy(szWarning, ArrayReturnInfo[7]);
            nLen = strlen(szWarning);
            KUiMsgCentrePad::SystemMessageArrival(szWarning, nLen);
            return FALSE;
        }
    } else if (pWnd == (KWndWindow *) &m_TrembleBox[4]) {

        if (nGenre != item_task || nDetail != SP_LAMTHUYTINH) {
            strcpy(szWarning, ArrayReturnInfo[7]);
            nLen = strlen(szWarning);
            KUiMsgCentrePad::SystemMessageArrival(szWarning, nLen);
            return FALSE;
        }
    } else if (pWnd == (KWndWindow *) &m_TrembleBox[5]) {

        if (nGenre != item_task || nDetail != SP_LAMTHUYTINH) {
            strcpy(szWarning, ArrayReturnInfo[7]);
            nLen = strlen(szWarning);
            KUiMsgCentrePad::SystemMessageArrival(szWarning, nLen);
            return FALSE;
        }
    } else if (pWnd == (KWndWindow *) &m_TrembleBox[6]) {

        if (nGenre != item_task || nDetail != SP_LAMTHUYTINH) {
            strcpy(szWarning, ArrayReturnInfo[7]);
            nLen = strlen(szWarning);
            KUiMsgCentrePad::SystemMessageArrival(szWarning, nLen);
            return FALSE;
        }
    } else if (pWnd == (KWndWindow *) &m_TrembleBox[7]) {

        if (nGenre != item_task || nDetail != SP_LAMTHUYTINH) {
            strcpy(szWarning, ArrayReturnInfo[7]);
            nLen = strlen(szWarning);
            KUiMsgCentrePad::SystemMessageArrival(szWarning, nLen);
            return FALSE;
        }
    } else if (pWnd == (KWndWindow *) &m_TrembleBox[8]) {

        if (nStack > 1) {
            strcpy(szWarning, "ChØ ®Æt vµo sè l­îng 1 vËt phËm.");
            nLen = strlen(szWarning);
            KUiMsgCentrePad::SystemMessageArrival(szWarning, nLen);
            return FALSE;
        }

/*		if (nGenre == item_task && (nDetail == SP_CHANKHUYET || nDetail == SP_CHANTUYET))
			return TRUE;
*/
        strcpy(szWarning, ArrayReturnInfo[4]);
        nLen = strlen(szWarning);
        KUiMsgCentrePad::SystemMessageArrival(szWarning, nLen);
        return FALSE;
    }
    return TRUE;
}


void KUiTrembleItem::OnItemPickDrop(ITEM_PICKDROP_PLACE *pPickPos, ITEM_PICKDROP_PLACE *pDropPos) {
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
        Pick.eContainer = UOC_BUILD_ITEM;
        pWnd = pPickPos->pWnd;

    } else if (pDropPos) {
        pWnd = pDropPos->pWnd;
    } else
        return;

    if (pDropPos) {
        Wnd_GetDragObj(&Obj);
        if (EnoughItemPickDrop(pWnd, Obj.uId)) {
            Drop.Obj.uGenre = Obj.uGenre;
            Drop.Obj.uId = Obj.uId;
            Drop.Region.Width = Obj.DataW;
            Drop.Region.Height = Obj.DataH;
            Drop.Region.h = 0;
            Drop.eContainer = UOC_BUILD_ITEM;
        }
    }

    for (int i = 0; i < _ITEM_TREMBLE_COUNT; i++) {
        if (pWnd == (KWndWindow *) &m_TrembleBox[i]) {
            Drop.Region.v = Pick.Region.v = CtrlItemMap[i].nPosition;
            break;
        }
    }
    g_pCoreShell->OperationRequest(GOI_SWITCH_OBJECT,
                                   pPickPos ? (unsigned int) &Pick : 0,
                                   pDropPos ? (int) &Drop : 0);
}

/*********************************************************************
**********************************************************************/
void KUiTrembleItem::Breathe() {
    if (m_TrembleEffect.IsVisible())
        m_TrembleEffect.NextFrame();
    if (m_EffectTime)
        m_EffectTime++;
    if (m_EffectTime == (m_TrembleEffect.GetMaxFrame()) * 2 + 1) {
        StopEffect();
        m_EffectTime = 0;
    }
}

/*********************************************************************
**********************************************************************/
void KUiTrembleItem::StopEffect() {
    m_TrembleEffect.Hide();
    UpdatePickPut(true);
    OnOk();
}

void KUiTrembleItem::StartEffect() {
    m_TrembleEffect.Show();
    UpdatePickPut(false);
}

BOOL KUiTrembleItem::IsEffect() {
    if (m_EffectTime) return TRUE;
    return FALSE;
}


/*********************************************************************
**********************************************************************/
void KUiTrembleItem::UpdateItem(KUiObjAtRegion *pItem, int bAdd) {
    if (pItem) {
        for (int i = 0; i < _ITEM_TREMBLE_COUNT; i++) {
            if (CtrlItemMap[i].nPosition == pItem->Region.v) {
                if (bAdd)
                    m_TrembleBox[i].HoldObject(pItem->Obj.uGenre, pItem->Obj.uId,
                                               pItem->Region.Width, pItem->Region.Height);
                else
                    m_TrembleBox[i].HoldObject(CGOG_NOTHING, 0, 0, 0);
                break;
            }
        }
    }
}

/*********************************************************************
**********************************************************************/
void KUiTrembleItem::UpdateData() {
    KUiObjAtRegion Item[_ITEM_TREMBLE_COUNT];
    int nCount = g_pCoreShell->GetGameData(GDI_BUILD_ITEM, (unsigned int) &Item, 0);
    int i;
    for (i = 0; i < _ITEM_TREMBLE_COUNT; i++)
        m_TrembleBox[i].Celar();
    for (i = 0; i < nCount; i++) {
        if (Item[i].Obj.uGenre != CGOG_NOTHING)
            UpdateItem(&Item[i], true);
    }
}

/*********************************************************************
**********************************************************************/
void KUiTrembleItem::OnOk() {
    if (g_pCoreShell)
        g_pCoreShell->OperationRequest(GOI_ADD_UI_CMD_SCRIPT, 1, (unsigned int) "main");
}

void KUiTrembleItem::OnCancel() {
    if (g_pCoreShell) {
        KUiObjAtRegion Item[_ITEM_TREMBLE_COUNT];
        int nCount = g_pCoreShell->GetGameData(GDI_BUILD_ITEM, (unsigned int) &Item, 0);
        if (nCount)
            g_pCoreShell->OperationRequest(GOI_RECOVERY_BOX_COMMAND, pos_builditem, 0);
    }
}

void KUiTrembleItem::UpdatePickPut(bool bLock) {
    for (int i = 0; i < _ITEM_TREMBLE_COUNT; i++)
        m_TrembleBox[i].EnablePickPut(bLock);

    m_Confirm.Enable(bLock);
    m_Cancel.Enable(bLock);
}
