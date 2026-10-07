// -------------------------------------------------------------------------
//	文件名		：	UiItem.cpp
//	Author		：	吕桂华, Wooy(Wu yue)
//	创建时间	：	2002-9-16 11:26:43
//	功能描述	：
// -------------------------------------------------------------------------
#include "KWin32.h"
#include "KIniFile.h"
#include "../elem/wnds.h"
#include "UiTrade.h"
#include "UiItem.h"
#include "UiGetMoney.h"
#include "UiGetString.h"
#include "UiStoreBox.h"
#include "UiTradeConfirmWnd.h"
#include "UiSysMsgCentre.h"
#include "UiShop.h"
#include "UiBreakItem.h"
#include "UiPlayerShop.h"
#include "UiStoreBox.h"
#include "UiSetPrice.h"
#include "UiStatus.h"
#include "UiStoreBox.h"
#include "UiExpandItem.h"
#include "UiSuperShop.h"
#include "UiGive.h"
#include "../../../core/src/coreshell.h"
#include "../../../core/src/GameDataDef.h"
#include "../../../Engine/src/KDebug.h"
#include "../UiBase.h"
#include "../UiShell.h"
#include "../ShortcutKey.h"
#include <crtdbg.h>
#include "../UiSoundSetting.h"
#include "../../../core/src/ItemActionDiag.h"

extern iCoreShell *g_pCoreShell;
extern bool PhongThanVngComposePutInventoryItem(const KUiDraggedObject* item);

#define SCHEME_INI    "UiItem.ini"

KUiItem *KUiItem::m_pSelf = NULL;

static struct UIITEM_EQUIP_CTRL_MAP {
    int nPosition;
    const char *pIniSection;
} EquipCtrlMap[UIITEM_EQUIP_BOX_COUNT] = {
        {UIEP_HEAD,        "Helm"},
        {UIEP_BODY,        "Armor"},
        {UIEP_WAIST,       "Belt"},
        {UIEP_FOOT,        "Boots"},
        {UIEP_HAND,        "Weapon"},
        {UIEP_HORSE,       "Horse"},
        {UIEP_WAIST_DECOR, "Pendant"},
        {UIEP_FINGER1,     "Talisman1"},
        {UIEP_FINGER2,     "Talisman2"},
        {UIEP_SHIPIN,      "Instrument"},
        {UIEP_SIGNET,      "Signet"},
        {UIEP_NECK,        "JadePendant"},
};

static int FindEquipMapIndex(int nPosition) {
    for (int i = 0; i < UIITEM_EQUIP_BOX_COUNT; i++) {
        if (EquipCtrlMap[i].nPosition == nPosition)
            return i;
    }

    // VNG maps the cuff position to the first talisman control.
    if (nPosition == UIEP_FINESSE)
        return 7;
    return -1;
}

enum WAIT_OTHER_WND_OPER_PARAM {
    UIITEM_WAIT_GETMONEY,
    UIITEM_WAIT_GETADV,
};

//TamLTM Khung F4
//--------------------------------------------------------------------------
//	功能：如果窗口正被显示，则返回实例指针
//--------------------------------------------------------------------------
KUiItem *KUiItem::GetIfVisible() {
    if (m_pSelf && m_pSelf->IsVisible())
        return m_pSelf;
    return NULL;
}

//--------------------------------------------------------------------------
//	功能：打开窗口，返回唯一的一个类对象实例
//--------------------------------------------------------------------------
KUiItem *KUiItem::OpenWindow(bool bFlag) {
    if (m_pSelf == NULL) {
        m_pSelf = new KUiItem;
        if (m_pSelf)
            m_pSelf->Initialize();
    }
    if (m_pSelf && bFlag) {
        if (g_pCoreShell && g_pCoreShell->GetGameData(GDI_EQUIPEX_TIME, NULL, NULL) > 0) {
            if (KUiExpandItem::GetIfVisible() == NULL)
                KUiExpandItem::OpenWindow();
        }
        UiSoundPlay(UI_SI_WND_OPENCLOSE);
        m_pSelf->UpdateData();
        m_pSelf->BringToTop();
        m_pSelf->Show();
    }
    return m_pSelf;
}

//--------------------------------------------------------------------------
//	功能：关闭窗口，同时可以选则是否删除对象实例
//--------------------------------------------------------------------------
void KUiItem::CloseWindow(bool bDestroy) {
    if (m_pSelf) {
        if (KUiExpandItem::GetIfVisible())
            KUiExpandItem::CloseWindow();
        if (bDestroy == false)
            m_pSelf->Hide();
        else {
            m_pSelf->Destroy();
            m_pSelf = NULL;
        }
    }
}

// -------------------------------------------------------------------------
// 功能	: 初始化
// -------------------------------------------------------------------------
void KUiItem::Initialize() {
    AddChild(&m_TitleIcon);
    AddChild(&m_EquipImage);
    AddChild(&m_NormalEquipBtn);
    AddChild(&m_JEvilEquipBtn);
    for (int i = 0; i < UIITEM_EQUIP_BOX_COUNT; i++) {
        // KWndObjectBox does not render the Image entry from UiItem.ini.
        // Keep the unmodified VNG slot SPR as a separate image layer, then
        // place the interactive object box exactly over that artwork.
        AddChild(&m_EquipSlotImage[i]);
        m_EquipBox[i].SetObjectGenre(CGOG_ITEM);
        m_EquipBox[i].SetContainerId((int) UOC_EQUIPTMENT);
        AddChild(&m_EquipBox[i]);
    }
    AddChild(&m_Money);
    AddChild(&m_ExtPoint);//TamLTm fix xu;
    AddChild(&m_MoneyIcon);
    AddChild(&m_GoldIcon);
    AddChild(&m_GetMoneyBtn);
    AddChild(&m_CloseBtn);
    AddChild(&m_ItemBox);
    AddChild(&m_OpenStatusPadBtn);
    AddChild(&m_MakeAdvBtn);
    AddChild(&m_MarkPriceBtn);
    AddChild(&m_MakeStallBtn);
    m_byMark = 0;
    m_szAdvStr[0] = 0;

    char Scheme[256];
    g_UiBase.GetCurSchemePath(Scheme, 256);
    LoadScheme(Scheme);

    m_ItemBox.SetContainerId((int) UOC_ITEM_TAKE_WITH);
    m_nMoney = 0;
    m_nExtPoint = 0; //TamLTM fix xu;
    Wnd_AddWindow(this);
}

//活动函数
void KUiItem::Breathe() {
    if (!g_pCoreShell->GetTradeState()) {
        m_MakeStallBtn.CheckButton(FALSE);
        if (m_byMark == 1)
            m_byMark = 0;
    } else if (m_byMark == 0 && g_pCoreShell->GetTradeState()) {
        if (g_UiBase.GetStatus() != UIS_S_IDLE)
            g_UiBase.SetStatus(UIS_S_IDLE);
        m_MakeStallBtn.CheckButton(TRUE);
        m_byMark = 1;
    }
    m_nMoney = g_pCoreShell->GetGameData(GDI_PLAYER_HOLD_MONEY, 0, 0);
    m_Money.Set3IntText(m_nMoney);
    //g_DebugLog("m_nMoney: %d", m_nMoney);

    m_nExtPoint = g_pCoreShell->GetGameData(GDI_PLAYER_HOLD_MONEY, 1, 0);
    m_ExtPoint.SetExtPointText(m_nExtPoint);     //TamLTM fix xu;

//	Sleep(5);
}

void KUiItem::OnNpcTradeMode(bool bTrue) {
    KUiExpandItem::OnNpcTradeMode(bTrue);
    if (m_pSelf)
        m_pSelf->m_ItemBox.EnablePickPut(!bTrue);
}

//--------------------------------------------------------------------------
//	功能：构造函数
//--------------------------------------------------------------------------
void KUiItem::UpdateData() {
    UpdateAllEquips();
    m_ItemBox.Clear();

    m_nMoney = g_pCoreShell->GetGameData(GDI_PLAYER_HOLD_MONEY, 0, 0);
    m_Money.Set3IntText(m_nMoney);

    m_nExtPoint = g_pCoreShell->GetGameData(GDI_PLAYER_HOLD_MONEY, 1, 0); //TamLTM fix xu;
    m_ExtPoint.SetExtPointText(m_nExtPoint);//TamLTM fix xu;

    KUiObjAtRegion *pObjs = NULL;
    int nCount = g_pCoreShell->GetGameData(GDI_ITEM_TAKEN_WITH, 0, 0);
    if (nCount == 0)
        return;

    if (pObjs = (KUiObjAtRegion *) malloc(sizeof(KUiObjAtRegion) * nCount)) {
        g_pCoreShell->GetGameData(GDI_ITEM_TAKEN_WITH, (unsigned int) pObjs, nCount);//单线程执行，nCount值不变
        for (int i = 0; i < nCount; i++) {
            KUiDraggedObject no;
            no.uGenre = pObjs[i].Obj.uGenre;
            no.uId = pObjs[i].Obj.uId;
            no.DataX = pObjs[i].Region.h;
            no.DataY = pObjs[i].Region.v;
            no.DataW = pObjs[i].Region.Width;
            no.DataH = pObjs[i].Region.Height;
            g_pCoreShell->PAIOperation(GPI_BAN_RAC, (unsigned int)no.uId, NULL, NULL);
            m_ItemBox.AddObject(&no, 1);
        }
        free(pObjs);
        pObjs = NULL;
    }
}

void KUiItem::UpdateAllEquips() {
    KUiObjAtRegion Equips[17];
    int nCount = g_pCoreShell->GetGameData(GDI_EQUIPMENT,
                                            (unsigned int) &Equips, 0);
    for (int i = 0; i < UIITEM_EQUIP_BOX_COUNT; i++)
        m_EquipBox[i].Celar();

    for (int nEquip = 0; nEquip < nCount; nEquip++) {
        if (Equips[nEquip].Obj.uGenre != CGOG_NOTHING)
            UpdateEquip(&Equips[nEquip], true);
    }
}

void KUiItem::UpdateEquip(KUiObjAtRegion *pEquip, int bAdd) {
    if (pEquip == NULL)
        return;

    int nBox = FindEquipMapIndex(pEquip->Region.v);
    if (nBox < 0 || nBox >= UIITEM_EQUIP_BOX_COUNT)
        return;

    if (bAdd) {
        m_EquipBox[nBox].HoldObject(pEquip->Obj.uGenre, pEquip->Obj.uId,
                                     pEquip->Region.Width, pEquip->Region.Height);
    } else {
        m_EquipBox[nBox].HoldObject(CGOG_NOTHING, 0, 0, 0);
    }
}

int KUiItem::GetEquipBoxIndex(KWndWindow *pWnd) {
    for (int i = 0; i < UIITEM_EQUIP_BOX_COUNT; i++) {
        if (pWnd == (KWndWindow *) &m_EquipBox[i])
            return i;
    }
    return -1;
}

void KUiItem::OnObjectPickDrop(ITEM_PICKDROP_PLACE *pPickPos,
                               ITEM_PICKDROP_PLACE *pDropPos) {
    KUiObjAtContRegion Pick;
    KUiObjAtContRegion Drop;
    KUiDraggedObject Obj;
    memset(&Pick, 0, sizeof(Pick));
    memset(&Drop, 0, sizeof(Drop));
    memset(&Obj, 0, sizeof(Obj));

    int nPickEquip = pPickPos ? GetEquipBoxIndex(pPickPos->pWnd) : -1;
    int nDropEquip = pDropPos ? GetEquipBoxIndex(pDropPos->pWnd) : -1;

    if (pPickPos) {
        if (nPickEquip >= 0) {
            if (!m_EquipBox[nPickEquip].GetObject(Obj))
                return;
            Pick.Region.h = 0;
            Pick.Region.v = EquipCtrlMap[nPickEquip].nPosition;
            Pick.eContainer = UOC_EQUIPTMENT;
        } else {
            if (!m_ItemBox.GetObject(Obj, pPickPos->h, pPickPos->v))
                return;
            Pick.Region.h = Obj.DataX;
            Pick.Region.v = Obj.DataY;
            Pick.eContainer = UOC_ITEM_TAKE_WITH;
        }
        Pick.Obj.uGenre = Obj.uGenre;
        Pick.Obj.uId = Obj.uId;
        Pick.Region.Width = Obj.DataW;
        Pick.Region.Height = Obj.DataH;
    }

    if (pDropPos) {
        Wnd_GetDragObj(&Obj);
        Drop.Obj.uGenre = Obj.uGenre;
        Drop.Obj.uId = Obj.uId;
        Drop.Region.Width = Obj.DataW;
        Drop.Region.Height = Obj.DataH;
        if (nDropEquip >= 0) {
            Drop.Region.h = 0;
            Drop.Region.v = EquipCtrlMap[nDropEquip].nPosition;
            Drop.eContainer = UOC_EQUIPTMENT;
        } else {
            Drop.Region.h = pDropPos->h;
            Drop.Region.v = pDropPos->v;
            Drop.eContainer = UOC_ITEM_TAKE_WITH;
        }
    }

    UISYS_STATUS eStatus = g_UiBase.GetStatus();
    if (pPickPos && eStatus == UIS_S_LOCK_ITEM) {
        g_UiBase.SetStatus(UIS_S_IDLE);
        g_pCoreShell->OperationRequest(GOI_LOCKITEM, (unsigned int) &Pick, 1);
        return;
    }
    if (pPickPos && eStatus == UIS_S_UNLOCK_ITEM) {
        g_UiBase.SetStatus(UIS_S_IDLE);
        g_pCoreShell->OperationRequest(GOI_UNLOCKITEM, (unsigned int) &Pick, 2);
        return;
    }

    g_pCoreShell->OperationRequest(GOI_SWITCH_OBJECT,
                                   pPickPos ? (unsigned int) &Pick : 0,
                                   pDropPos ? (int) &Drop : 0);
}

// -------------------------------------------------------------------------
// 功能	: 物品变化更新
// -------------------------------------------------------------------------
void KUiItem::UpdateItem(KUiObjAtRegion *pItem, int bAdd) {
    if (pItem) {
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

        UiSoundPlay(UI_SI_PICKPUT_ITEM);
    } else
        UpdateData();
}

// -------------------------------------------------------------------------
// 功能	: 载入界面方案
// -------------------------------------------------------------------------
void KUiItem::LoadScheme(const char *pScheme) {
    char Buff[128];
    KIniFile Ini;
    sprintf(Buff, "%s\\%s", pScheme, SCHEME_INI);
    if (m_pSelf && Ini.Load(Buff)) {
        m_pSelf->Init(&Ini, "Main");
        m_pSelf->m_EquipImage.Init(&Ini, "Equip");
        m_pSelf->m_NormalEquipBtn.Init(&Ini, "BtnNormalEquip");
        m_pSelf->m_JEvilEquipBtn.Init(&Ini, "BtnJEvilEquip");
        m_pSelf->m_NormalEquipBtn.CheckButton(TRUE);
        m_pSelf->m_JEvilEquipBtn.CheckButton(FALSE);
        for (int i = 0; i < UIITEM_EQUIP_BOX_COUNT; i++) {
            m_pSelf->m_EquipSlotImage[i].Init(&Ini,
                                               EquipCtrlMap[i].pIniSection);
            m_pSelf->m_EquipBox[i].Init(&Ini, EquipCtrlMap[i].pIniSection);

            int nLeft = 0;
            int nTop = 0;
            int nWidth = 0;
            int nHeight = 0;
            m_pSelf->m_EquipSlotImage[i].GetPosition(&nLeft, &nTop);
            m_pSelf->m_EquipSlotImage[i].GetSize(&nWidth, &nHeight);
            // Align the complete VNG equipment-slot group with the black
            // mannequin frame at the current 800x600 runtime scale.
            nLeft += 38;
            nTop += 38;
            m_pSelf->m_EquipSlotImage[i].SetPosition(nLeft, nTop);
            m_pSelf->m_EquipBox[i].SetPosition(nLeft, nTop);
            m_pSelf->m_EquipBox[i].SetSize(nWidth, nHeight);
        }

        // The VNG mannequin SPR contains male/female frames.  The remaining
        // class frames stay available for the later class-data port.
        m_pSelf->m_EquipImage.SetFrame(
                g_pCoreShell->GetGameData(GDI_PLAYER_IS_MALE, 0, 0) ? 1 : 0);
        m_pSelf->m_TitleIcon.Init(&Ini, "TitleIcon");
        m_pSelf->m_Money.Init(&Ini, "Money");
        m_pSelf->m_ExtPoint.Init(&Ini, "Gold");
        m_pSelf->m_MoneyIcon.Init(&Ini, "MoneyIcon");
        m_pSelf->m_GoldIcon.Init(&Ini, "GoldIcon");
        m_pSelf->m_GetMoneyBtn.Init(&Ini, "GetMoneyBtn");
        m_pSelf->m_CloseBtn.Init(&Ini, "CloseBtn");
        m_pSelf->m_ItemBox.Init(&Ini, "ItemBox");
        m_pSelf->m_ItemBox.EnablePickPut(true);
        m_pSelf->m_OpenStatusPadBtn.Init(&Ini, "OpenStatus");
        m_pSelf->m_ItemBox.EnableTracePutPos(true);
        m_pSelf->m_MakeAdvBtn.Init(&Ini, "MakeAdvBtn");
        m_pSelf->m_MarkPriceBtn.Init(&Ini, "MarkPriceBtn");
        m_pSelf->m_MakeStallBtn.Init(&Ini, "MakeStallBtn");
    }
}

void KUiItem::OnClickItem(KUiDraggedObject *pItem, bool bDoImmed) {
    if (pItem == NULL || g_pCoreShell == NULL)
        return;
    SO_ItemActionDiag("OnClickItem", pItem->uGenre, pItem->uId, pItem->DataX, pItem->DataY, pItem->DataW, pItem->DataH, (int)g_UiBase.GetStatus(), bDoImmed ? 1 : 0);
    KUiObjAtContRegion Obj;
    Obj.Obj.uGenre = pItem->uGenre;
    Obj.Obj.uId = pItem->uId;
    Obj.Region.h = pItem->DataX;
    Obj.Region.v = pItem->DataY;
    Obj.Region.Width = pItem->DataW;
    Obj.Region.Height = pItem->DataH;
    Obj.eContainer = UOC_ITEM_TAKE_WITH;

    if (KUiPlayerShop::GetIfVisible())
        return;
    if (bDoImmed == false) {
        KUiItemBuySelInfo Price = {0};
        if (KUiSuperShop::GetIfVisible() == NULL &&
            g_pCoreShell->GetGameData(GDI_TRADE_ITEM_PRICE,
                                      (unsigned int) (&Obj), (int) (&Price))) {
            KUiTradeConfirm::OpenWindow(&Obj, &Price, TCA_SALE);
        }
    } else {
        UISYS_STATUS eStatus = g_UiBase.GetStatus();
        if (eStatus == UIS_S_TRADE_SALE) {
            if (KUiSuperShop::GetIfVisible() == NULL)
                g_pCoreShell->OperationRequest(GOI_TRADE_NPC_SELL,
                                               (unsigned int) (&Obj), 1);
        } else if (eStatus == UIS_S_TRADE_NPC) {
            if (KUiSuperShop::GetIfVisible() == NULL) {
                if ((GetKeyState(VK_SHIFT) & 0x8000) != 0) {
                    g_pCoreShell->OperationRequest(GOI_TRADE_NPC_SELL,
                                                   (unsigned int) (&Obj), 1);
                } else {
                    KSystemMessage Msg;
                    Msg.byConfirmType = SMCT_NONE;
                    Msg.byParamSize = 0;
                    Msg.byPriority = 0;
                    Msg.eType = SMT_NORMAL;
                    Msg.uReservedForUi = 0;
                    strcpy(Msg.szMessage, "Nh蕁 gi?ph輒 Shift ng th阨 nh蕁 chu閠 ph秈 l藀 t鴆 b竛 頲 v藅 ph萴!");
                    KUiSysMsgCentre::AMessageArrival(&Msg, NULL);
                }
            }
        } else if (g_UiBase.GetStatus() == UIS_S_IDLE &&
                   pItem->uId > 0 && pItem->uId < MAX_ITEM) {
            if (PhongThanVngComposePutInventoryItem(pItem))
                return;
            int nOpRet = g_pCoreShell->OperationRequest(GOI_USE_ITEM,
                                                        (unsigned int) (&Obj), UOC_ITEM_TAKE_WITH);
            SO_ItemActionDiag("OperationRequest_USE_ITEM", pItem->uGenre, pItem->uId, pItem->DataX, pItem->DataY, pItem->DataW, pItem->DataH, (int)g_UiBase.GetStatus(), nOpRet);
        }
    }
}

void KUiItem::OnRepairItem(KUiDraggedObject *pItem) {
    if (pItem == NULL || g_pCoreShell == NULL)
        return;
    KUiObjAtContRegion Obj;
    Obj.Obj.uGenre = pItem->uGenre;
    Obj.Obj.uId = pItem->uId;
    Obj.Region.h = pItem->DataX;
    Obj.Region.v = pItem->DataY;
    Obj.Region.Width = pItem->DataW;
    Obj.Region.Height = pItem->DataH;
    Obj.eContainer = UOC_ITEM_TAKE_WITH;

    KUiItemBuySelInfo Price = {0};
    if (g_pCoreShell->GetGameData(GDI_REPAIR_ITEM_PRICE,
                                  (unsigned int) (&Obj), (int) (&Price))) {
        KUiTradeConfirm::OpenWindow(&Obj, &Price, TCA_REPAIR);
    }
}

// -------------------------------------------------------------------------
// 功能	: 窗口函数
// -------------------------------------------------------------------------
int KUiItem::WndProc(unsigned int uMsg, unsigned int uParam, int nParam) {
    switch (uMsg) {
        case WM_RBUTTONDOWN:
            // Recover clicks that land on a legacy transparent child instead
            // of the object matrix itself. The matrix path remains the
            // canonical path and will not be dispatched twice.
            if (m_ItemBox.HandleRightClickAt(LOWORD(nParam), HIWORD(nParam)))
                return 0;
            break;
        case WND_N_LEFT_CLICK_ITEM:
            if (g_UiBase.GetStatus() == UIS_S_TRADE_SALE)
                OnClickItem((KUiDraggedObject *) uParam, true);
            else if (g_UiBase.GetStatus() == UIS_S_TRADE_NPC)
                OnClickItem((KUiDraggedObject *) uParam, false);
            else if (g_UiBase.GetStatus() == UIS_S_TRADE_REPAIR)
                OnRepairItem((KUiDraggedObject *) uParam);
            else if (g_UiBase.GetStatus() == UIS_S_TRADE_SETPRICE)
                OnSetPrice((KUiDraggedObject *) uParam);
            break;
        case WND_N_RIGHT_CLICK_ITEM:
            if (uParam)
            {
                KUiDraggedObject *pItem = (KUiDraggedObject *)uParam;
                SO_ItemActionDiag("WndProc_RIGHT_CLICK", pItem->uGenre, pItem->uId, pItem->DataX, pItem->DataY, pItem->DataW, pItem->DataH, (int)g_UiBase.GetStatus(), nParam);
            }
            if (GetKeyState(VK_SHIFT) & 0x8000 && !g_UiBase.GetStatus())
                OnBreakItem((KUiDraggedObject *) uParam, true);
            else
                OnClickItem((KUiDraggedObject *) uParam, true);
            break;
        case WND_N_ITEM_PICKDROP:
        {
            ITEM_PICKDROP_PLACE *pPickPos = (ITEM_PICKDROP_PLACE *) uParam;
            ITEM_PICKDROP_PLACE *pDropPos = (ITEM_PICKDROP_PLACE *) nParam;
            int nPickEquip = pPickPos ? GetEquipBoxIndex(pPickPos->pWnd) : -1;
            int nDropEquip = pDropPos ? GetEquipBoxIndex(pDropPos->pWnd) : -1;
            if (nPickEquip >= 0 || nDropEquip >= 0)
                OnObjectPickDrop(pPickPos, pDropPos);
            else
                OnItemPickDrop(pPickPos, pDropPos);
            break;
        }
        case WND_N_BUTTON_CLICK:
            if (uParam == (unsigned int) (KWndWindow *) &m_CloseBtn && g_UiBase.GetStatus() != UIS_S_TRADE_SETPRICE)
                CloseWindow(false);
            else if (uParam == (unsigned int) (KWndWindow *) &m_NormalEquipBtn ||
                     uParam == (unsigned int) (KWndWindow *) &m_JEvilEquipBtn) {
                // The current CoreShell exports the normal equipment set.
                // Keep the populated page selected instead of exposing an
                // empty second set that the protocol cannot yet provide.
                m_NormalEquipBtn.CheckButton(TRUE);
                m_JEvilEquipBtn.CheckButton(FALSE);
            }
            else if (uParam == (unsigned int) (KWndWindow *) &m_OpenStatusPadBtn)
                KShortcutKeyCentre::ExcuteScript(SCK_SHORTCUT_STATUS);
            else if (uParam == (unsigned int) (KWndWindow *) &m_GetMoneyBtn) {
                if (KUiStoreBox::GetIfVisible())
                    KUiGetMoney::OpenWindow(0, m_nMoney, this, UIITEM_WAIT_GETMONEY, &m_Money);
            } else if (uParam == (unsigned int) (KWndWindow *) &m_MakeAdvBtn && m_MakeStallBtn.IsButtonChecked() == 0 &&
                       !g_UiBase.GetStatus())
                KUiGetString::OpenWindow(GSA_ADV, "", m_szAdvStr, this, UIITEM_WAIT_GETADV, 0, 4, 16);
            else if (uParam == (unsigned int) (KWndWindow *) &m_MarkPriceBtn && m_MakeStallBtn.IsButtonChecked() == 0) {
                if (g_UiBase.GetStatus() == UIS_S_IDLE) {
                    g_UiBase.SetStatus(UIS_S_TRADE_SETPRICE);
                    KUiItem::OnNpcTradeMode(true);
                } else if (g_UiBase.GetStatus() == UIS_S_TRADE_SETPRICE) {
                    g_UiBase.SetStatus(UIS_S_IDLE);
                    KUiItem::OnNpcTradeMode(false);
                }
            } else if (uParam == (unsigned int) (KWndWindow *) &m_MakeStallBtn && !g_UiBase.GetStatus()) {
                if (g_pCoreShell) {
                    if (m_szAdvStr[0]) {
                        if (!g_pCoreShell->OperationRequest(GOI_PLAYER_DOTRADE, (unsigned int) (&m_szAdvStr), 0))
                            m_MakeStallBtn.CheckButton(false);
                    } else
                        KUiGetString::OpenWindow(GSA_ADV, "", m_szAdvStr, this, UIITEM_WAIT_GETADV, 0, 4, 16);
                }
            }
            break;
        case WND_M_OTHER_WORK_RESULT:
            if (uParam == UIITEM_WAIT_GETMONEY) {
                OnGetMoney(nParam);
            } else if (uParam == UIITEM_WAIT_GETADV) {
                strcpy(m_szAdvStr, (char *) nParam);
                if (m_szAdvStr[0]) {
                    if (!g_pCoreShell->OperationRequest(GOI_PLAYER_DOTRADE, (unsigned int) (&m_szAdvStr), 0))
                        m_MakeStallBtn.CheckButton(false);
                }
            }
            break;
        default:
            return KWndShowAnimate::WndProc(uMsg, uParam, nParam);
    }
    return 0;
}

void KUiItem::OnGetMoney(int nMoney) {
    if (nMoney > 0 && KUiStoreBox::GetIfVisible()) {
        g_pCoreShell->OperationRequest(GOI_MONEY_INOUT_STORE_BOX,
                                       true, nMoney);
    }
}

void KUiItem::OnBreakItem(KUiDraggedObject *pItem, bool bDoImmed) {
    if (pItem == NULL || g_pCoreShell == NULL || KUiBreakItem::GetIfVisible())
        return;
    KUiObjAtContRegion Obj;
    Obj.Obj.uGenre = pItem->uGenre;
    Obj.Obj.uId = pItem->uId;
    Obj.Region.h = pItem->DataX;
    Obj.Region.v = pItem->DataY;
    Obj.Region.Width = pItem->DataW;
    Obj.Region.Height = pItem->DataH;
    Obj.eContainer = UOC_ITEM_TAKE_WITH;
    KUiItemBuySelInfo Price = {0};

    if (bDoImmed)
        g_pCoreShell->BreakItem((unsigned int) (&Obj), 0, FALSE);
    else {
        int nNum = g_pCoreShell->GetStackNum(pItem->uId);
        if (nNum > 1) {
            if (g_pCoreShell->GetGameData(GDI_TRADE_ITEM_PRICE,
                                          (unsigned int) (&Obj), (int) (&Price)))
                KUiBreakItem::OpenWindow(&Obj, &Price, nNum);
        }
    }
}

void KUiItem::OnSetPrice(KUiDraggedObject *pItem) {
    if (pItem == NULL || g_pCoreShell == NULL)
        return;
    KUiObjAtContRegion Obj;
    Obj.Obj.uGenre = pItem->uGenre;
    Obj.Obj.uId = pItem->uId;
    Obj.Region.h = pItem->DataX;
    Obj.Region.v = pItem->DataY;
    Obj.Region.Width = pItem->DataW;
    Obj.Region.Height = pItem->DataH;
    Obj.eContainer = UOC_ITEM_TAKE_WITH;

    KUiItemBuySelInfo Price = {0};
    if (g_pCoreShell->GetGameData(GDI_TRADE_ITEM_PRICE,
                                  (unsigned int) (&Obj), (int) (&Price))) {
        g_DebugLog("xxx");
        KUiSetPrice::OpenWindow(g_pCoreShell->GetTradePrice(pItem->uId), &Obj, &Price);
    }
}

void KUiItem::OnItemPickDrop(ITEM_PICKDROP_PLACE *pPickPos, ITEM_PICKDROP_PLACE *pDropPos) {
    KUiObjAtContRegion Pick, Drop;
    KUiDraggedObject Obj;
    memset(&Pick, 0, sizeof(Pick));
    memset(&Drop, 0, sizeof(Drop));
    memset(&Obj, 0, sizeof(Obj));

    UISYS_STATUS eStatus = g_UiBase.GetStatus();
    if (pPickPos) {
        _ASSERT(pPickPos->pWnd);
        ((KWndObjectMatrix *) (pPickPos->pWnd))->GetObject(
                Obj, pPickPos->h, pPickPos->v);
        Pick.Obj.uGenre = Obj.uGenre;
        Pick.Obj.uId = Obj.uId;
        Pick.Region.Width = Obj.DataW;
        Pick.Region.Height = Obj.DataH;
        Pick.Region.h = Obj.DataX;
        Pick.Region.v = Obj.DataY;
        Pick.eContainer = UOC_ITEM_TAKE_WITH;

        if (eStatus == UIS_S_TRADE_SALE) {
            g_pCoreShell->OperationRequest(GOI_TRADE_NPC_SELL,
                                           (unsigned int) (&Pick), 1);
            return;
        } else if (eStatus == UIS_S_TRADE_REPAIR) {
            if (g_pCoreShell->IsDamage(Obj.uId))
                g_pCoreShell->OperationRequest(GOI_TRADE_NPC_REPAIR,
                                               (unsigned int) (&Pick), 0);
            return;
        } else if (eStatus == UIS_S_TRADE_BUY) {
            return;
        } else if (eStatus == UIS_S_LOCK_ITEM) {
            g_UiBase.SetStatus(UIS_S_IDLE);
            g_pCoreShell->OperationRequest(GOI_LOCKITEM, (unsigned int) (&Pick), 1);
            return;
        } else if (eStatus == UIS_S_UNLOCK_ITEM) {
            g_UiBase.SetStatus(UIS_S_IDLE);
            g_pCoreShell->OperationRequest(GOI_UNLOCKITEM, (unsigned int) (&Pick), 2);
            return;
        } else if (GetKeyState(VK_SHIFT) & 0x8000 && !g_UiBase.GetStatus()) {
            OnBreakItem(&Obj, false);
            return;
        }
    }

    if (pDropPos) {
        Wnd_GetDragObj(&Obj);
        Drop.Obj.uGenre = Obj.uGenre;
        Drop.Obj.uId = Obj.uId;
        Drop.Region.Width = Obj.DataW;
        Drop.Region.Height = Obj.DataH;
        Drop.Region.h = pDropPos->h;
        Drop.Region.v = pDropPos->v;
        Drop.eContainer = UOC_ITEM_TAKE_WITH;
    }

    g_pCoreShell->OperationRequest(GOI_SWITCH_OBJECT,
                                   pPickPos ? (unsigned int) &Pick : 0,
                                   pDropPos ? (int) &Drop : 0);
}
