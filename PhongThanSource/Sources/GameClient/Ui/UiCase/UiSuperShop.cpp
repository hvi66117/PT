#include "KWin32.h"
#include "KIniFile.h"
#include "GameDataDef.h"
#include "../Elem/WndMessage.h"
#include "../Elem/Wnds.h"
#include "UiSuperShop.h"
#include "UiItem.h"
#include "../../../Core/Src/CoreObjGenreDef.h"
#include "../../../Core/Src/CoreShell.h"
#include "../../../Engine/Src/Text.h"
#include "../../../Engine/Src/KDebug.h"
#include "../UiSoundSetting.h"
#include "../UiBase.h"
#include "UiInformation.h"
#include "UiSysMsgCentre.h"
#include "UiTradeConfirmWnd.h"
#include "KTabFile.h"
#include <crtdbg.h>
#include "../../../Represent/iRepresent/iRepresentShell.h"


#include "../ShortcutKey.h"
#include "GameDataDef.h"

extern iRepresentShell *g_pRepresentShell;
extern iCoreShell *g_pCoreShell;

#define SCHEME_INI                            "ibshopcfg.ini"
#define SCHEME_SHOPPING_INI                   "ibshopcfg.ini"
#define UI_WAIT_CLEAR_SHOPPINGCART            1

// The Phong Than shop owns the original Ui3 layout found in the VNG PAK. The
// selected scheme is retained only as a whole-file fallback.
static bool LoadPhongThanIbShopScheme(KIniFile &Ini, const char *pScheme) {
    if (Ini.Load("\\Ui\\ui3\\ibshopcfg.ini"))
        return true;

    if (pScheme && pScheme[0]) {
        char szFallback[512];
        sprintf(szFallback, "%s\\%s", pScheme, SCHEME_INI);
        if (Ini.Load(szFallback))
            return true;
    }
    return false;
}
#define MARKET_DISCOUNT_PIC                    "\\spr\\Ui3\\买卖\\新奇珍阁界面\\%d_vn.spr"

KUiShoppingCart *KUiShoppingCart::m_pSelf = NULL;

KUiShoppingCart::KUiShoppingCart() {
    m_nBuyValue = 1;
    m_nCostValue = 0;
    m_nOldValue = 0;
    m_nSaveValue = 0;
    m_nOwnValue = 0;
    m_PriceInfo.szItemName[0] = 0;
    m_PriceInfo.nOldPrice = 0;
    m_PriceInfo.nCurPrice = 0;
    m_PriceInfo.bNewArrival = FALSE;
    m_PriceInfo.nMoneyUnit = 0;
    m_ItemInfo.Obj.uGenre = CGOG_NOTHING;
}

//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
KUiShoppingCart *KUiShoppingCart::GetIfVisible() {
    if (m_pSelf && m_pSelf->IsVisible())
        return m_pSelf;
    return NULL;
}

//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
KUiShoppingCart *KUiShoppingCart::OpenWindow(KUiObjAtContRegion *pObj,
                                             KUiItemBuySelInfo *pPriceInfo) {
    if (pObj == NULL || pPriceInfo == NULL)
        return NULL;

    if (m_pSelf == NULL) {
        m_pSelf = new KUiShoppingCart;
        if (m_pSelf)
            m_pSelf->Initialize();
    }
    if (m_pSelf) {
        if (m_pSelf->m_ItemInfo.Obj.uId != pObj->Obj.uId)
            m_pSelf->m_nBuyValue = 1;
        m_pSelf->m_ItemInfo = *pObj;
        m_pSelf->m_PriceInfo = *pPriceInfo;
        m_pSelf->UpdateData();
        m_pSelf->BringToTop();
        m_pSelf->Show();
    }
    return m_pSelf;
}

void KUiShoppingCart::Breathe() {
    m_GoodsInfo_CountEdit.SetIntText(m_nBuyValue);
    m_GoodsInfo_TotalPrice.SetMoneyUnitPrice(m_nCostValue * m_nBuyValue,
                                             m_PriceInfo.nMoneyUnit);

    if (m_nOwnValue >= m_nCostValue * m_nBuyValue && m_nBuyValue > 0)
        m_ConfirmBuy.Enable(true);
    else
        m_ConfirmBuy.Enable(false);

}

void KUiShoppingCart::AddCount() {
    int nNumber = m_GoodsInfo_CountEdit.GetIntNumber();
    nNumber++;

    m_nBuyValue = nNumber;
    char szBuff1[16], szBuff2[16];
    itoa(m_nBuyValue, szBuff1, 10);
    m_GoodsInfo_CountEdit.GetText(szBuff2, sizeof(szBuff2), true);
    if (strcmp(szBuff1, szBuff2))
        m_GoodsInfo_CountEdit.SetIntText(m_nBuyValue);
    Wnd_SetFocusWnd(&m_pSelf->m_GoodsInfo_CountEdit);
}

void KUiShoppingCart::DelCount() {
    int nNumber = m_GoodsInfo_CountEdit.GetIntNumber();
    nNumber--;

    if (nNumber <= 0)
        nNumber = 0;

    m_nBuyValue = nNumber;
    char szBuff1[16], szBuff2[16];
    itoa(m_nBuyValue, szBuff1, 10);
    m_GoodsInfo_CountEdit.GetText(szBuff2, sizeof(szBuff2), true);
    if (strcmp(szBuff1, szBuff2))
        m_GoodsInfo_CountEdit.SetIntText(m_nBuyValue);
    Wnd_SetFocusWnd(&m_pSelf->m_GoodsInfo_CountEdit);
}

void KUiShoppingCart::OnCheckInput() {
    int nNumber = m_GoodsInfo_CountEdit.GetIntNumber();
    m_nBuyValue = nNumber;

    char szBuff1[16], szBuff2[16];
    itoa(m_nBuyValue, szBuff1, 10);
    m_GoodsInfo_CountEdit.GetText(szBuff2, sizeof(szBuff2), true);
    if (strcmp(szBuff1, szBuff2))
        m_GoodsInfo_CountEdit.SetIntText(m_nBuyValue);
}

void KUiShoppingCart::Show() {
    Wnd_SetFocusWnd(&m_pSelf->m_GoodsInfo_CountEdit);
    KWndShowAnimate::Show();
    Wnd_SetExclusive((KWndWindow *) this);
}

void KUiShoppingCart::UpdateData() {
    if (g_pCoreShell) {
        m_GoodsInfo_GoodsName.SetText(m_PriceInfo.szItemName);

        m_nOwnValue = g_pCoreShell->GetOwnValue(m_PriceInfo.nMoneyUnit);

        m_nCostValue = m_PriceInfo.nCurPrice;
        m_nOldValue = m_PriceInfo.nOldPrice;
        if (m_nCostValue < m_nOldValue)
            m_nSaveValue = m_nOldValue - m_nCostValue;
        else
            m_nSaveValue = 0;
    }
}

//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
void KUiShoppingCart::CloseWindow(bool bDestroy) {
    if (m_pSelf) {
        if (bDestroy == false)
            m_pSelf->Hide();
        else {
            m_pSelf->Destroy();
            m_pSelf = NULL;
        }
    }
}


void KUiShoppingCart::Initialize() {
    AddChild(&m_GoodsInfo_GoodsName);
    AddChild(&m_GoodsInfo_TotalPrice);
    AddChild(&m_GoodsInfo_DelItem);
    AddChild(&m_GoodsInfo_AddCount);
    AddChild(&m_GoodsInfo_DelCount);
    AddChild(&m_GoodsInfo_CountEdit);
    AddChild(&m_ConfirmBuy);
    AddChild(&m_CloseBtn);
    Wnd_AddWindow(this);
    char Scheme[256];
    g_UiBase.GetCurSchemePath(Scheme, 256);
    LoadScheme(Scheme);
}


void KUiShoppingCart::LoadScheme(const char *pScheme) {
    KIniFile Ini;
    if (LoadPhongThanIbShopScheme(Ini, pScheme)) {
        KWndShowAnimate::Init(&Ini, "BuyBox");
        m_GoodsInfo_GoodsName.Init(&Ini, "BuyBox_TxtInfo");
        m_GoodsInfo_TotalPrice.Init(&Ini, "BuyBox_TxtCost");
        m_GoodsInfo_AddCount.Init(&Ini, "BuyBox_BtnInc");
        m_GoodsInfo_DelCount.Init(&Ini, "BuyBox_BtnDec");
        m_GoodsInfo_CountEdit.Init(&Ini, "BuyBox_EditCount");
        m_ConfirmBuy.Init(&Ini, "BuyBox_BtnConfirm");
        m_GoodsInfo_DelItem.Init(&Ini, "BuyBox_BtnCancel");
        m_CloseBtn.Init(&Ini, "BuyBox_BtnClose");
    }
}

void KUiShoppingCart::CartRelease() {
    m_nBuyValue = 1;
    m_nCostValue = 0;
    m_nOldValue = 0;
    m_nSaveValue = 0;
    m_nOwnValue = 0;
    CloseWindow(true);
}

int KUiShoppingCart::WndProc(unsigned int uMsg, unsigned int uParam, int nParam) {
    if (uMsg == WND_N_BUTTON_CLICK) {
        if ((KWndWindow *) uParam == (KWndWindow *) &m_CloseBtn) {
            CloseWindow(true);
            return 0;
        }
        else if ((KWndWindow *) uParam == (KWndWindow *) &m_GoodsInfo_DelItem) {
            KUiSuperShop::PutItem(NULL);
            CartRelease();
            return 0;
        } else if ((KWndWindow *) uParam == (KWndWindow *) &m_GoodsInfo_AddCount)
            AddCount();
        else if ((KWndWindow *) uParam == (KWndWindow *) &m_GoodsInfo_DelCount)
            DelCount();
        else if ((KWndWindow *) uParam == (KWndWindow *) &m_ConfirmBuy) {
            const int nBuyValue = m_nBuyValue;
            KUiSuperShop::BuyItem(nBuyValue);
            CartRelease();
            return 0;
        } else if ((KWndWindow *) uParam == (KWndWindow *) &m_PrePaidBtn) {
            /*KIniFile Ini;
                if (Ini.Load(GAME_SETTING_FILE_INI))
                {
                    char szFilePath[MAX_PATH];
                    Ini.GetString("URL", "PrePaid", "", szFilePath, sizeof(szFilePath));
                    ShellExecute(NULL,"open",szFilePath,NULL,NULL,SW_SHOWNORMAL);
                }*/
            if (g_pCoreShell)
                g_pCoreShell->OperationRequest(GOI_ADD_UI_CMD_SCRIPT, 2,
                                               (unsigned int) "main");    //TamLTM Suppershop card
        }
    } else if (uMsg == WND_N_SCORLLBAR_POS_CHANGED) {
        if (uParam == (unsigned int) (KWndWindow *) &m_ScrollBar)
            return 0;
    } else if (uMsg == WM_KEYDOWN) {
        if (uParam == VK_RETURN && m_ConfirmBuy.IsVisible()) {
            if (m_nOwnValue >= m_nCostValue * m_nBuyValue && m_nBuyValue > 0) {
                const int nBuyValue = m_nBuyValue;
                KUiSuperShop::BuyItem(nBuyValue);
                CartRelease();
                return 0;
            }
        } else if (uParam == VK_ESCAPE) {
            if (g_UiBase.GetStatus() == UIS_S_TRADE_NPC)
                Hide();
            else
                g_UiBase.SetStatus(UIS_S_TRADE_NPC);
        }
    } else if (uMsg == WND_N_EDIT_CHANGE)
        OnCheckInput();
    return KWndShowAnimate::WndProc(uMsg, uParam, nParam);
}


////////////////////////////////////////////////////
void KWndSellItem::Initialize() {
    AddChild(&m_MarketGoods);
    AddChild(&m_MarketGoods_DisCount);
    m_MarketGoods_DisCount.Hide();
    AddChild(&m_MarketGoods_imgNewArrival);
    m_MarketGoods_imgNewArrival.Hide();
    AddChild(&m_GoodsNameText);
    AddChild(&m_OriginalPriceText);
    AddChild(&m_OriginalPrice_NumberText);
    AddChild(&m_PriceText);
    AddChild(&m_Price_NumberText);
    AddChild(&m_ItemBox);
    AddChild(&m_MarketGoods_Buy);
    m_MarketGoods_Buy.Enable(false);
}

//--------------------------------------------------------------------------
//	功能：载入窗口的界面方案
//--------------------------------------------------------------------------
void KWndSellItem::LoadScheme(const char *pScheme, const char *pTheme) {
    KIniFile Ini;
    if (LoadPhongThanIbShopScheme(Ini, pScheme)) {
        // Native Phong Than/VNG IBShop schema. The INI and every referenced
        // sprite are resolved from PAK before loose-file fallback.
        const char *pItemTheme = pTheme;
        if (pItemTheme == NULL || pItemTheme[0] == 0 ||
            !Ini.IsSectionExist(pItemTheme))
            pItemTheme = "Theme_Normal";

        char szSection[64];
        KWndSellItem::Init(&Ini, pItemTheme);
        m_MarketGoods.Init(&Ini, pItemTheme);

        sprintf(szSection, "%s_Name", pItemTheme);
        m_GoodsNameText.Init(&Ini, szSection);

        sprintf(szSection, "%s_Mark", pItemTheme);
        if (!Ini.IsSectionExist(szSection))
            strcpy(szSection, "Theme_Normal_Mark");
        m_MarketGoods_DisCount.Init(&Ini, szSection);

        sprintf(szSection, "%s_Status", pItemTheme);
        m_MarketGoods_imgNewArrival.Init(&Ini, szSection);

        sprintf(szSection, "%s_ShowPrice", pItemTheme);
        m_OriginalPrice_NumberText.Init(&Ini, szSection);

        sprintf(szSection, "%s_ActualPrice", pItemTheme);
        m_Price_NumberText.Init(&Ini, szSection);

        sprintf(szSection, "%s_Obj", pItemTheme);
        m_ItemBox.Init(&Ini, szSection);

        sprintf(szSection, "%s_btnBuy", pItemTheme);
        m_MarketGoods_Buy.Init(&Ini, szSection);
    }
}

void KWndSellItem::Clear() {
    m_MarketGoods_DisCount.Hide();
    m_MarketGoods_imgNewArrival.Hide();
    m_GoodsNameText.Clear();//物品名
    m_OriginalPriceText.Clear();//原价
    m_OriginalPrice_NumberText.Clear();//原价
    m_PriceText.Clear();//新价
    m_Price_NumberText.Clear();//新价
    m_ItemBox.Celar();
    m_MarketGoods_Buy.Enable(false);
}

void KWndSellItem::PaintWindow() {
//	KWndObjectBox::PaintWindow();
}

int KWndSellItem::WndProc(unsigned int uMsg, unsigned int uParam, int nParam)//窗口函数
{
    if (uMsg == WND_N_BUTTON_CLICK) {
        if ((KWndWindow *) uParam == (KWndWindow *) &m_MarketGoods_Buy) {
            KUiDraggedObject pItem;
            KUiObjAtContRegion Obj;
            m_ItemBox.GetObject(pItem);

            Obj.Obj.uGenre = pItem.uGenre;
            Obj.Obj.uId = pItem.uId;
            Obj.Region.h = 0;
            Obj.Region.v = 0;
            Obj.Region.Width = pItem.DataW;
            Obj.Region.Height = pItem.DataH;
            Obj.eContainer = UOC_NPC_SHOP;
            KUiItemBuySelInfo Price = {0};
            if (g_pCoreShell->GetGameData(GDI_TRADE_ITEM_PRICE, (unsigned int) (&Obj), (int) (&Price))) {
                KUiShoppingCart::OpenWindow(&Obj, &Price);
                KUiSuperShop::PutItem(&Obj);
            }
        }
    }
    return KWndObjectBox::WndProc(uMsg, uParam, nParam);
}
//////////////////////////////////////////////////

KUiSuperShop *KUiSuperShop::m_pSelf = NULL;

KUiSuperShop::KUiSuperShop() {
    m_pBSinfo.Clear();
    m_nStoreActive = 0;
    m_nSellTypeCount = 0;
    m_nSellTypeStart = 0;
    m_nCurrentPage = 0;
    m_nCurrentShopId = 0;
    m_nPageCount = 0;
    m_uEnableTextColor = 0;
    m_uInvalidTextColor = 0;
    m_pItemInfo.Obj.uGenre = CGOG_NOTHING;
    m_pItemInfo.Obj.uId = -1;
    m_pObjsList = NULL;
    m_nObjCount = 0;
}

KUiSuperShop::~KUiSuperShop() {
}

//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
KUiSuperShop *KUiSuperShop::GetIfVisible() {
    if (m_pSelf && m_pSelf->IsVisible())
        return m_pSelf;
    return NULL;
}

//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
KUiSuperShop *KUiSuperShop::OpenWindow(BuySellInfo *pBSinfo) {
    if (pBSinfo == NULL)
        return NULL;

    if (m_pSelf == NULL) {
        m_pSelf = new KUiSuperShop;
        if (m_pSelf)
            m_pSelf->Initialize();
    }
    if (m_pSelf) {
        if (KUiItem::GetIfVisible() == FALSE)
            KUiItem::OpenWindow();
        KUiItem::OnNpcTradeMode(true);
        g_UiBase.SetStatus(UIS_S_TRADE_NPC);
        UiSoundPlay(UI_SI_WND_OPENCLOSE);
        m_pSelf->UpdateShop(pBSinfo);
        m_pSelf->BringToTop();
        m_pSelf->Show();
    }
    return m_pSelf;
}

//--------------------------------------------------------------------------
//--------------------------------------------------------------------------
void KUiSuperShop::CloseWindow(bool bDestroy) {
    if (m_pSelf) {
        //if (m_pSelf->m_pItemInfo.Obj.uGenre != CGOG_NOTHING)
        //{
        //	UIMessageBox("Gi?h祅g ch璦 thanh to竛. B筺 mu鑞 h駓 kh玭g?", m_pSelf, "X竎 nh薾", "H駓 b?, UI_WAIT_CLEAR_SHOPPINGCART);
        //}
        //else
        //{
        KUiItem::OnNpcTradeMode(false);
        g_UiBase.SetStatus(UIS_S_IDLE);
        if (bDestroy == false)
            m_pSelf->Hide();
        else {
            m_pSelf->Destroy();
            m_pSelf = NULL;
        }
        //}
    }
}

void KUiSuperShop::Initialize() {
    AddChild(&m_PageBackground);
    for (int i = 0; i < MAX_SUPERSHOP_PAGETAB; i++) {
        AddChild(&m_SellType[i]);
        m_SellType[i].Hide();
    }
    for (i = 0; i < MAX_SUPERSHOP_ITEM_COUNT; i++) {
        m_WndSellItem[i].Initialize();
        AddChild(&m_WndSellItem[i]);
    }
    AddChild(&m_NextBtn);
    AddChild(&m_LastBtn);
    AddChild(&m_SellTypeGuide);
    AddChild(&m_PrePaidBtn);
    AddChild(&m_NextPageBtn);
    AddChild(&m_LastPageBtn);
    AddChild(&m_CurrentPageText);
//	AddChild(&m_ShoppingCartBtn);
    AddChild(&m_CloseBtn);
    Wnd_AddWindow(this);
    char Scheme[256];
    g_UiBase.GetCurSchemePath(Scheme, 256);
    LoadScheme(Scheme);
}


void KUiSuperShop::LoadScheme(const char *pScheme) {
    if (m_pSelf) {
        KIniFile Ini;
        if (LoadPhongThanIbShopScheme(Ini, pScheme)) {
            m_pSelf->KWndShowAnimate::Init(&Ini, "Main");
            m_pSelf->m_PrePaidBtn.Init(&Ini, "BtnBuyCoin");

            for (int i = 0; i < MAX_SUPERSHOP_PAGETAB; i++) {
                char szPageButton[32];
                if (i == MAX_SUPERSHOP_PAGETAB - 1)
                    strcpy(szPageButton, "BtnLimitTips");
                else
                    sprintf(szPageButton, "PageBtn_%d", i);
                m_pSelf->m_SellType[i].Init(&Ini, szPageButton);
                if (i == MAX_SUPERSHOP_PAGETAB - 1) {
                    m_pSelf->m_SellType[i].SetPosition(441, 41);
                    m_pSelf->m_SellType[i].SetLabel("Tat ca");
                    m_pSelf->m_SellType[i].SetLabelColor(0xfff09e);
                }
            }
            m_pSelf->m_CloseBtn.Init(&Ini, "BtnClose");
            m_pSelf->LoadPageScheme(pScheme, 0);
            m_pSelf->m_NextBtn.Hide();
            m_pSelf->m_LastBtn.Hide();
            m_pSelf->m_SellTypeGuide.Hide();
            m_pSelf->m_uEnableTextColor = 0xffffffff;
            m_pSelf->m_uInvalidTextColor = 0xffffffff;
        }
    }
}

bool KUiSuperShop::LoadPageScheme(const char *pScheme, int nTab) {
    KIniFile Ini;
    if (!LoadPhongThanIbShopScheme(Ini, pScheme))
        return false;

    if (nTab < 0)
        nTab = 0;
    if (nTab >= MAX_SUPERSHOP_PAGETAB)
        nTab = MAX_SUPERSHOP_PAGETAB - 1;

    char szPage[32];
    sprintf(szPage, "Page_%d", nTab);
    // The ninth VNG entry is the limited-goods selector and has no Page_8
    // block. Reuse the normal VNG grid instead of inventing a loose layout.
    if (!Ini.IsSectionExist(szPage))
        strcpy(szPage, "Page_1");

    int nPageLeft = 0;
    int nPageTop = 0;
    Ini.GetInteger(szPage, "Left", 0, &nPageLeft);
    Ini.GetInteger(szPage, "Top", 0, &nPageTop);
    m_PageBackground.Init(&Ini, szPage);
    m_PageBackground.Show();

    for (int i = 0; i < MAX_SUPERSHOP_ITEM_COUNT; i++) {
        char szThemeKey[32];
        char szTheme[64];
        char szItemPos[32];
        sprintf(szThemeKey, "Item_Theme_%d", i);
        szTheme[0] = 0;
        Ini.GetString(szPage, szThemeKey, "", szTheme, sizeof(szTheme));

        if (szTheme[0] == 0) {
            m_WndSellItem[i].Clear();
            m_WndSellItem[i].Hide();
            continue;
        }

        m_WndSellItem[i].LoadScheme(pScheme, szTheme);
        int nItemLeft = 0;
        int nItemTop = 0;
        sprintf(szItemPos, "Item_Pos_%d", i);
        Ini.GetInteger2(szPage, szItemPos, &nItemLeft, &nItemTop);
        m_WndSellItem[i].SetPosition(nPageLeft + nItemLeft,
                                     nPageTop + nItemTop);
        m_WndSellItem[i].Show();
    }

    char szSection[48];
    sprintf(szSection, "%s_BtnNext", szPage);
    if (Ini.IsSectionExist(szSection)) {
        int nLeft = 0;
        int nTop = 0;
        m_NextPageBtn.Init(&Ini, szSection);
        m_NextPageBtn.GetPosition(&nLeft, &nTop);
        m_NextPageBtn.SetPosition(nPageLeft + nLeft, nPageTop + nTop);
        m_NextPageBtn.Show();
    } else {
        m_NextPageBtn.Hide();
    }

    sprintf(szSection, "%s_BtnPrev", szPage);
    if (Ini.IsSectionExist(szSection)) {
        int nLeft = 0;
        int nTop = 0;
        m_LastPageBtn.Init(&Ini, szSection);
        m_LastPageBtn.GetPosition(&nLeft, &nTop);
        m_LastPageBtn.SetPosition(nPageLeft + nLeft, nPageTop + nTop);
        m_LastPageBtn.Show();
    } else {
        m_LastPageBtn.Hide();
    }

    sprintf(szSection, "%s_TxtPageIndex", szPage);
    if (Ini.IsSectionExist(szSection)) {
        int nLeft = 0;
        int nTop = 0;
        m_CurrentPageText.Init(&Ini, szSection);
        m_CurrentPageText.GetPosition(&nLeft, &nTop);
        m_CurrentPageText.SetPosition(nPageLeft + nLeft, nPageTop + nTop);
        m_CurrentPageText.Show();
    } else {
        m_CurrentPageText.Hide();
    }
    return true;
}

void KUiSuperShop::UpdateShop(BuySellInfo *pBSinfo) {
    if (m_pSelf && pBSinfo) {
        m_pSelf->m_pBSinfo = *pBSinfo;
        m_pSelf->m_nSellTypeCount = pBSinfo->m_nShopNum;
        m_pSelf->m_nStoreActive = m_pSelf->m_nSellTypeCount;
        if (m_pSelf->m_nStoreActive > MAX_SUPERSHOP_PAGETAB)
            m_pSelf->m_nStoreActive = MAX_SUPERSHOP_PAGETAB;
        for (int i = 0; i < m_pSelf->m_nStoreActive; i++)
            m_pSelf->m_SellType[i].Show();
        m_pSelf->SetSellTypeStart(0);
        m_pSelf->SellSortChange(m_pSelf->m_nCurrentShopId - m_pSelf->m_nSellTypeStart);
        m_pSelf->PutItem(NULL);
        g_UiBase.SetStatus(UIS_S_TRADE_NPC);
    }
}

void KUiSuperShop::SetSellTypeStart(int nStart) {
    m_NextBtn.Enable(true);
    m_LastBtn.Enable(true);

    m_nSellTypeStart = nStart;
    if (m_nSellTypeStart + m_nStoreActive >= m_nSellTypeCount) {
        m_nSellTypeStart = m_nSellTypeCount - m_nStoreActive;
        m_NextBtn.Enable(false);
    }

    if (m_nSellTypeStart <= 0) {
        m_nSellTypeStart = 0;
        m_LastBtn.Enable(false);
    }
    for (int i = 0; i < m_nStoreActive; i++) {
        m_SellType[i].CheckButton((m_nCurrentShopId - m_nSellTypeStart) == i);
    }
}

void KUiSuperShop::SetCurrSellSort(int nSaleId) {
    m_nCurrentShopId = m_nSellTypeStart + nSaleId;
    char szName[6];
    itoa(m_pBSinfo.m_nShopIdx[m_nCurrentShopId], szName, 10);
    m_SellTypeGuide.SetText(szName, strlen(szName));
    m_nCurrentPage = 0;
    char szScheme[256];
    g_UiBase.GetCurSchemePath(szScheme, sizeof(szScheme));
    LoadPageScheme(szScheme, nSaleId);
    UpdateData();
    PageChangeInfo();
}

void KUiSuperShop::PageChangeInfo() {
    char Buff[32];
    if (m_nPageCount <= 0)
        m_nPageCount = 1;
    if (m_nObjCount)
        sprintf(Buff, "%d/%d", m_nCurrentPage + 1, m_nPageCount);
    else
        strcpy(Buff, "_/_");
    m_CurrentPageText.SetText(Buff);

    m_NextPageBtn.Enable(true);
    m_LastPageBtn.Enable(true);
    if ((m_nCurrentPage + 1) >= m_nPageCount)
        m_NextPageBtn.Enable(false);
    if (m_nCurrentPage <= 0)
        m_LastPageBtn.Enable(false);
}

void KUiSuperShop::ClearPage() {
    for (int i = 0; i < MAX_SUPERSHOP_ITEM_COUNT; i++)
        m_WndSellItem[i].Clear();
}

void KUiSuperShop::BuyItem(int nNumber) {
    if (m_pSelf && g_pCoreShell && nNumber > 0 &&
        m_pSelf->m_pItemInfo.Obj.uGenre == CGOG_NPCSELLITEM &&
        m_pSelf->m_pItemInfo.Obj.uId != (unsigned int)-1) {
        g_pCoreShell->OperationRequest(GOI_TRADE_NPC_BUY,
                                       (unsigned int) (&m_pSelf->m_pItemInfo), nNumber);
        PutItem(NULL);
    }
}


void KUiSuperShop::SetPage(int nIndex) {
    ClearPage();
    int nAdd = 0;
    if (nIndex >= 0 && nIndex < m_nPageCount && m_pObjsList) {
        for (int i = 0; i < m_nObjCount; i++) {
            if (m_pObjsList[i].nContainer == nIndex && nAdd < MAX_SUPERSHOP_ITEM_COUNT) {
                UpdateItem(&m_pObjsList[i], nAdd);
                nAdd++;
            }
        }
        m_nCurrentPage = nIndex;
        PageChangeInfo();
    }
}

void KUiSuperShop::UpdateItem(KUiObjAtContRegion *pItem, int nAdd) {
    if (pItem) {
        if (pItem->Obj.uGenre != CGOG_MONEY) {
            KUiObjAtContRegion Obj;
            Obj.Obj.uGenre = pItem->Obj.uGenre;
            Obj.Obj.uId = pItem->Obj.uId;
            Obj.Region.h = 0;
            Obj.Region.v = 0;
            Obj.Region.Width = pItem->Region.Width;
            Obj.Region.Height = pItem->Region.Height;
            Obj.eContainer = UOC_NPC_SHOP;
            KUiItemBuySelInfo Price = {0};
            if (g_pCoreShell->GetGameData(GDI_TRADE_ITEM_PRICE,
                                          (unsigned int) (&Obj), (int) (&Price))) {
                m_WndSellItem[nAdd].m_GoodsNameText.SetText(Price.szItemName);
                if (Price.nCurPrice < Price.nOldPrice) {
                    m_WndSellItem[nAdd].m_MarketGoods_DisCount.Show();
                    int nDiscountVal = 100 - (Price.nCurPrice * 100 / Price.nOldPrice);
                    if (nDiscountVal % 10 == 0 && (nDiscountVal > 0 && nDiscountVal < 100)) {
                        char szBuffer[128];
                        sprintf(szBuffer, MARKET_DISCOUNT_PIC, nDiscountVal);
                        m_WndSellItem[nAdd].m_MarketGoods_DisCount.SetImage(ISI_T_SPR, szBuffer);
                    }
                }
                if (Price.bNewArrival)
                    m_WndSellItem[nAdd].m_MarketGoods_imgNewArrival.Show();
                m_WndSellItem[nAdd].m_Price_NumberText.SetMoneyUnitPrice(Price.nCurPrice, Price.nMoneyUnit);
                m_WndSellItem[nAdd].m_OriginalPrice_NumberText.SetMoneyUnitPrice(Price.nOldPrice, Price.nMoneyUnit);
                m_WndSellItem[nAdd].m_MarketGoods_Buy.Enable(true);
                m_WndSellItem[nAdd].m_ItemBox.HoldObject(pItem->Obj.uGenre, pItem->Obj.uId, pItem->Region.Width,
                                                         pItem->Region.Height);
            }
        }
    } else
        SetPage(m_nCurrentPage);
}


void KUiSuperShop::UpdateData() {
    Clear();
    m_nObjCount = g_pCoreShell->GetDataSuperShop(m_nCurrentShopId, 0, 0);
    if (m_nObjCount == 0)
        return;

    if (m_pObjsList = (KUiObjAtContRegion *) malloc(sizeof(KUiObjAtContRegion) * m_nObjCount)) {
        m_nPageCount = g_pCoreShell->GetDataSuperShop(m_nCurrentShopId, (unsigned int) m_pObjsList, m_nObjCount) + 1;
        SetPage(0);
    } else
        m_nObjCount = 0;
}

void KUiSuperShop::Clear() {
    m_nObjCount = 0;
    m_nPageCount = 0;
    if (m_pObjsList) {
        free(m_pObjsList);
        m_pObjsList = NULL;
    }
    ClearPage();
}

void KUiSuperShop::SellSortChange(int i) {
    if (g_pCoreShell) {
        SetCurrSellSort(i);
        for (int j = 0; j < m_nStoreActive; j++) {
            m_SellType[j].CheckButton(i == j);
            m_SellType[j].SetLabelColor(i == j ?
                                        m_uInvalidTextColor : m_uEnableTextColor);
        }
    }
}

void KUiSuperShop::CancelTrade() {
    CloseWindow(true);
}

int KUiSuperShop::WndProc(unsigned int uMsg, unsigned int uParam, int nParam) {
    if (uMsg == WND_N_BUTTON_CLICK) {
        for (int i = 0; i < MAX_SUPERSHOP_PAGETAB; i++) {
            if ((KWndWindow *) uParam == (KWndWindow *) &m_SellType[i])
                SellSortChange(i);
        }
        if ((KWndWindow *) uParam == (KWndWindow *) &m_CloseBtn) {
            CancelTrade();
            return 0;
        } else if ((KWndWindow *) uParam == (KWndWindow *) &m_PrePaidBtn) {
            /*KIniFile Ini;
                if (Ini.Load(GAME_SETTING_FILE_INI))
                {
                    char szFilePath[MAX_PATH];
                    Ini.GetString("URL", "PrePaid", "", szFilePath, sizeof(szFilePath));
                    ShellExecute(NULL,"open",szFilePath,NULL,NULL,SW_SHOWNORMAL);
                }
                */
            if (g_pCoreShell)
                g_pCoreShell->OperationRequest(GOI_ADD_UI_CMD_SCRIPT, 2,
                                               (unsigned int) "main");    //TamLTM Suppershop card
        } else if ((KWndWindow *) uParam == (KWndWindow *) &m_NextBtn)
            SetSellTypeStart(m_nSellTypeStart + 1);
        else if ((KWndWindow *) uParam == (KWndWindow *) &m_LastBtn)
            SetSellTypeStart(m_nSellTypeStart - 1);
        else if ((KWndWindow *) uParam == (KWndWindow *) &m_NextPageBtn)
            SetPage(m_nCurrentPage + 1);
        else if ((KWndWindow *) uParam == (KWndWindow *) &m_LastPageBtn)
            SetPage(m_nCurrentPage - 1);
        else if ((KWndWindow *) uParam == (KWndWindow *) &m_ShoppingCartBtn) {
            if (m_pItemInfo.Obj.uGenre != CGOG_NOTHING) {
                KUiItemBuySelInfo Price = {0};
                if (g_pCoreShell->GetGameData(GDI_TRADE_ITEM_PRICE, (unsigned int) (&m_pItemInfo), (int) (&Price))) {
                    KUiShoppingCart::OpenWindow(&m_pItemInfo, &Price);
                }
            }
        }
    } else if (uMsg == WM_KEYDOWN) {
        if (uParam == VK_ESCAPE) {
            if (g_UiBase.GetStatus() == UIS_S_TRADE_NPC) {
                CancelTrade();
            } else
                g_UiBase.SetStatus(UIS_S_TRADE_NPC);
        }
    } else if (uMsg == WND_M_OTHER_WORK_RESULT) {
        if (uParam == UI_WAIT_CLEAR_SHOPPINGCART) {
            if (!nParam) {
                m_pItemInfo.Obj.uGenre = CGOG_NOTHING;
                m_pItemInfo.Obj.uId = -1;
                CancelTrade();
            }
        }
    }
    return KWndImage::WndProc(uMsg, uParam, nParam);
}

void KUiSuperShop::PutItem(KUiObjAtContRegion *pObj) {
    if (!m_pSelf)
        return;
    if (pObj != NULL) {
        m_pSelf->m_pItemInfo = *pObj;
        m_pSelf->m_ShoppingCartBtn.Enable(true);
    } else {
        m_pSelf->m_pItemInfo.Obj.uGenre = CGOG_NOTHING;
        m_pSelf->m_pItemInfo.Obj.uId = -1;
        m_pSelf->m_ShoppingCartBtn.Enable(false);
    }
}

void KUiSuperShop::Breathe() {
    for (int i = 0; i < MAX_SUPERSHOP_ITEM_COUNT; i++)
        if (m_WndSellItem[i].m_MarketGoods_imgNewArrival.IsVisible()) {
            if (m_WndSellItem[i].m_MarketGoods_imgNewArrival.GetCurrentFrame() >= 2)
                m_WndSellItem[i].m_MarketGoods_imgNewArrival.SetFrame(0);
            else
                m_WndSellItem[i].m_MarketGoods_imgNewArrival.NextFrame();
        }
}

int KCanGetNumFrame::GetMaxFrame() {
    return m_Image.nNumFrames;
}


int KCanGetNumFrame::GetCurrentFrame() {
    return m_Image.nFrame;
}


#define SCHEME_INI_VN        "精炼石商店vn.ini"

KUiDynamicShop *KUiDynamicShop::m_pSelf = NULL;

KUiDynamicShop::KUiDynamicShop() {
    m_pBSinfo.Clear();
    m_nCurrentShopId = 0;
    m_pObjsList = NULL;
    m_nObjCount = 0;
    m_nPageCount = 0;
}

//--------------------------------------------------------------------------
//	功能：如果窗口正被显示，则返回实例指针
//--------------------------------------------------------------------------
KUiDynamicShop *KUiDynamicShop::GetIfVisible() {
    return m_pSelf;
}

//--------------------------------------------------------------------------
//	功能：打开窗口，返回唯一的一个类对象实例
//--------------------------------------------------------------------------
KUiDynamicShop *KUiDynamicShop::OpenWindow(BuySellInfo *pBSinfo) {
    if (m_pSelf == NULL) {
        m_pSelf = new KUiDynamicShop;
        if (m_pSelf)
            m_pSelf->Initialize();
    }
    if (m_pSelf) {
        if (KUiItem::GetIfVisible() == FALSE)
            KUiItem::OpenWindow();
        KUiItem::OnNpcTradeMode(true);
        g_UiBase.SetStatus(UIS_S_TRADE_NPC);
        UiSoundPlay(UI_SI_WND_OPENCLOSE);
        m_pSelf->UpdateShop(pBSinfo);
        m_pSelf->BringToTop();
        m_pSelf->Show();
    }
    return m_pSelf;
}

//--------------------------------------------------------------------------
//	功能：关闭窗口，同时可以选则是否删除对象实例
//--------------------------------------------------------------------------
void KUiDynamicShop::CloseWindow() {
    if (m_pSelf) {
        KUiItem::OnNpcTradeMode(false);
        KUiTradeConfirm::CloseWindow(true);
        g_UiBase.SetStatus(UIS_S_IDLE);
        m_pSelf->Destroy();
        m_pSelf = NULL;
    }
}

//初始化
void KUiDynamicShop::Initialize() {
    for (int i = 0; i < MAX_SUPERSHOP_PAGETAB; i++) {
        AddChild(&m_SellType[i]);
        m_SellType[i].Hide();
    }
    AddChild(&m_ItemsBox);
    AddChild(&m_BuyBtn);
    AddChild(&m_SellBtn);
    AddChild(&m_RepairBtn);
    AddChild(&m_PreBtn);
    AddChild(&m_NextBtn);
    AddChild(&m_CloseBtn);
    AddChild(&m_CurPageTxt);
    AddChild(&m_TitleImage);

    m_ItemsBox.SetContainerId((int) UOC_NPC_SHOP);
    Wnd_AddWindow(this);
    char Scheme[256];
    g_UiBase.GetCurSchemePath(Scheme, 256);
    LoadScheme(Scheme);
}

//载入界面方案
void KUiDynamicShop::LoadScheme(const char *pScheme) {
    if (m_pSelf) {
        char Buff[128];
        KIniFile Ini;
        sprintf(Buff, "%s\\" SCHEME_INI_VN, pScheme);
        if (Ini.Load(Buff)) {
            char szKey[16];
            m_pSelf->KWndShowAnimate::Init(&Ini, "Main");
            for (int i = 0; i < MAX_SUPERSHOP_PAGETAB; i++) {
                sprintf(szKey, "TypeBtn_%d", i);
                m_pSelf->m_SellType[i].Init(&Ini, szKey);
            }
            m_pSelf->m_ItemsBox.Init(&Ini, "ItemBox");
            m_pSelf->m_BuyBtn.Init(&Ini, "BuyBtn");
            m_pSelf->m_SellBtn.Init(&Ini, "SellBtn");
            m_pSelf->m_RepairBtn.Init(&Ini, "RepairBtn");
            m_pSelf->m_PreBtn.Init(&Ini, "LeftBtn");
            m_pSelf->m_NextBtn.Init(&Ini, "RightBtn");
            m_pSelf->m_CloseBtn.Init(&Ini, "CloseBtn");
            m_pSelf->m_CurPageTxt.Init(&Ini, "CurPageTxt");
            m_pSelf->m_TitleImage.Init(&Ini, "TitleImage");

            m_pSelf->m_ItemsBox.EnablePickPut(false);
        }
    }
}

void KUiDynamicShop::CancelTrade() {
    CloseWindow();
}

//窗口函数
int KUiDynamicShop::WndProc(unsigned int uMsg, unsigned int uParam, int nParam) {
    switch (uMsg) {
        case WND_N_BUTTON_CLICK:
            OnClickButton((KWndButton *) (KWndWindow *) uParam, nParam);
            break;
        case WND_N_LEFT_CLICK_ITEM:
            OnBuyItem((KUiDraggedObject *) uParam,
                      g_UiBase.GetStatus() == UIS_S_TRADE_BUY);
            break;
        case WND_N_RIGHT_CLICK_ITEM:
            if (nParam == (int) (KWndWindow *) &m_ItemsBox)
                OnBuyItem((KUiDraggedObject *) uParam, true);
            break;
        case WM_KEYDOWN:
            if (uParam == VK_ESCAPE) {
                if (g_UiBase.GetStatus() == UIS_S_TRADE_NPC) {
                    CloseWindow();
                } else {
                    m_BuyBtn.CheckButton(false);
                    m_SellBtn.CheckButton(false);
                    m_RepairBtn.CheckButton(false);
                    g_UiBase.SetStatus(UIS_S_TRADE_NPC);
                }
            }
            break;
        default:
            return KWndShowAnimate::WndProc(uMsg, uParam, nParam);
    }
    return 0;
}

void KUiDynamicShop::OnBuyItem(KUiDraggedObject *pItem, bool bDoImmed) {
    if (pItem == NULL || g_pCoreShell == NULL)
        return;

    KUiObjAtContRegion Obj;
    Obj.Obj.uGenre = pItem->uGenre;
    Obj.Obj.uId = pItem->uId;
    Obj.Region.h = pItem->DataX;
    Obj.Region.v = pItem->DataY;
    Obj.Region.Width = pItem->DataW;
    Obj.Region.Height = pItem->DataH;
    Obj.eContainer = UOC_NPC_SHOP;

    UISYS_STATUS eStatus = g_UiBase.GetStatus();
    if (bDoImmed == false) {
        KUiItemBuySelInfo Price = {0};
        if (g_pCoreShell->GetGameData(GDI_TRADE_ITEM_PRICE,
                                      (unsigned int) (&Obj), (int) (&Price)) && eStatus != UIS_S_TRADE_SALE &&
            eStatus != UIS_S_TRADE_REPAIR) {
            KUiTradeConfirm::OpenWindow(&Obj, &Price, TCA_BUY);
        }
    } else {
        if (eStatus == UIS_S_TRADE_BUY) {
            g_pCoreShell->OperationRequest(GOI_TRADE_NPC_BUY,
                                           (unsigned int) (&Obj), 1);
            return;
        } else {
            if ((GetKeyState(VK_SHIFT) & 0x8000) != 0) {
                g_pCoreShell->OperationRequest(GOI_TRADE_NPC_BUY,
                                               (unsigned int) (&Obj), 1);
                return;
            } else {
                KSystemMessage Msg;
                Msg.byConfirmType = SMCT_NONE;
                Msg.byParamSize = 0;
                Msg.byPriority = 0;
                Msg.eType = SMT_NORMAL;
                Msg.uReservedForUi = 0;
                strcpy(Msg.szMessage, "Nh蕁 gi?ph輒 Shift ng th阨 nh蕁 chu閠 ph秈 l藀 t鴆 mua 頲 v藅 ph萴!");
                KUiSysMsgCentre::AMessageArrival(&Msg, NULL);
                return;
            }
        }
    }
}

void KUiDynamicShop::OnClickButton(KWndButton *pWnd, int bCheck) {
    if (Wnd_GetDragObj(NULL))
        return;
    if (pWnd == &m_BuyBtn) {
        if (bCheck) {
            m_SellBtn.CheckButton(false);
            m_RepairBtn.CheckButton(false);
            g_UiBase.SetStatus(UIS_S_TRADE_BUY);
        } else
            g_UiBase.SetStatus(UIS_S_TRADE_NPC);
    } else if (pWnd == &m_SellBtn) {
        if (bCheck) {
            m_BuyBtn.CheckButton(false);
            m_RepairBtn.CheckButton(false);
            g_UiBase.SetStatus(UIS_S_TRADE_SALE);
        } else
            g_UiBase.SetStatus(UIS_S_TRADE_NPC);
    } else if (pWnd == &m_RepairBtn) {
        if (bCheck) {
            m_BuyBtn.CheckButton(false);
            m_SellBtn.CheckButton(false);
            g_UiBase.SetStatus(UIS_S_TRADE_REPAIR);
        } else
            g_UiBase.SetStatus(UIS_S_TRADE_NPC);
    } else if (pWnd == &m_PreBtn)
        SetPage(m_nCurrentPage - 1);
    else if (pWnd == &m_NextBtn)
        SetPage(m_nCurrentPage + 1);
    else if (pWnd == &m_CloseBtn)
        CloseWindow();
    else {
        for (int i = 0; i < MAX_SUPERSHOP_PAGETAB; i++) {
            if (pWnd == &m_SellType[i])
                SellSortChange(i);
        }
    }
}

void KUiDynamicShop::SellSortChange(int i) {
    m_nCurrentShopId = i;
    UpdateData();
    for (int j = 0; j < MAX_SUPERSHOP_PAGETAB; j++) {
        m_SellType[j].CheckButton(i == j);
    }
}

void KUiDynamicShop::SetPage(int nIndex) {
    if (nIndex >= 0 && nIndex < m_nPageCount && m_pObjsList) {
        m_ItemsBox.Clear();
        for (int i = 0; i < m_nObjCount; i++) {
            if (m_pObjsList[i].nContainer == nIndex)
                UpdateItem(&m_pObjsList[i], true);
        }
        m_nCurrentPage = nIndex;
    }
    char Buff[32];
    if (m_nPageCount <= 0)
        m_nPageCount = 1;
    if (m_nObjCount)
        sprintf(Buff, "%d/%d", m_nCurrentPage + 1, m_nPageCount);
    else
        strcpy(Buff, "_/_");
    m_CurPageTxt.SetText(Buff);

    m_NextBtn.Enable(true);
    m_PreBtn.Enable(true);
    if ((m_nCurrentPage + 1) >= m_nPageCount)
        m_NextBtn.Enable(false);
    if (m_nCurrentPage <= 0)
        m_PreBtn.Enable(false);
}

void KUiDynamicShop::UpdateItem(KUiObjAtContRegion *pItem, int bAdd) {
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
                m_ItemsBox.AddObject(&Obj, 1);
            else
                m_ItemsBox.RemoveObject(&Obj);
        }

    } else
        SetPage(m_nCurrentPage);
}

void KUiDynamicShop::UpdateShop(BuySellInfo *pBSinfo) {
    m_pBSinfo = *pBSinfo;
    for (int i = 0; i < pBSinfo->m_nShopNum; i++) {
        char szName[6];
        itoa(pBSinfo->m_nShopIdx[i], szName, 10);
        m_SellType[i].SetLabel(szName);

        m_SellType[i].Show();
    }
    SellSortChange(m_nCurrentShopId);
    UpdateData();
}

void KUiDynamicShop::UpdateData() {
    Clear();
    m_nObjCount = g_pCoreShell->GetDataDynamicShop(m_nCurrentShopId, 0, 0);
    if (m_nObjCount == 0)
        return;

    if (m_pObjsList = (KUiObjAtContRegion *) malloc(sizeof(KUiObjAtContRegion) * m_nObjCount)) {
        g_pCoreShell->GetDataDynamicShop(m_nCurrentShopId, (unsigned int) m_pObjsList,
                                         m_nObjCount);//单线程执行，nCount值不变
        m_nPageCount = m_pObjsList[m_nObjCount - 1].nContainer + 1;
        SetPage(0);
    } else
        m_nObjCount = 0;
}

void KUiDynamicShop::Clear() {
    m_nObjCount = 0;
    m_nPageCount = 0;
    if (m_pObjsList) {
        free(m_pObjsList);
        m_pObjsList = NULL;
    }
}
