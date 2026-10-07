#include "KWin32.h"
#include "KIniFile.h"
#include "../Elem/WndMessage.h"
#include "../elem/wnds.h"
#include "UiToiUuImage.h"
#include "UiItem.h"
#include "UiTradeConfirmWnd.h"
#include "../../../core/src/CoreObjGenreDef.h"
#include "../../../core/src/coreshell.h"
#include "../UiSoundSetting.h"
#include "../UiBase.h"
//#include "UiOptions.h"
#include "UiInformation.h"
#include <crtdbg.h>

extern iCoreShell *g_pCoreShell;

#define SCHEME_INI        "UiToiUuImage.ini"

KUiToiUuImage *KUiToiUuImage::m_pSelf = NULL;

KUiToiUuImage::KUiToiUuImage() {
    m_pObjsList = NULL;
    m_nObjCount = 0;
    m_nPageCount = 0;
}

//--------------------------------------------------------------------------
//	¹¦ÄÜ£ºÈç¹û´°¿ÚÕý±»ÏÔÊ¾£¬Ôò·µ»ØÊµÀýÖ¸Õë
//--------------------------------------------------------------------------
KUiToiUuImage *KUiToiUuImage::GetIfVisible() {
    return m_pSelf;
}

//--------------------------------------------------------------------------
//	¹¦ÄÜ£º´ò¿ª´°¿Ú£¬·µ»ØÎ¨Ò»µÄÒ»¸öÀà¶ÔÏóÊµÀý
//--------------------------------------------------------------------------
KUiToiUuImage *KUiToiUuImage::OpenWindow() {
    if (m_pSelf == NULL) {
        m_pSelf = new KUiToiUuImage;
        if (m_pSelf) {
            m_pSelf->Initialize();
            //	m_pSelf->m_FightPad.Show();
        }
    }
    if (m_pSelf) {
        UiSoundPlay(UI_SI_WND_OPENCLOSE);
        m_pSelf->BringToTop();
        m_pSelf->Show();

    }
    return m_pSelf;
}

//--------------------------------------------------------------------------
//	¹¦ÄÜ£º¹Ø±Õ´°¿Ú£¬Í¬Ê±¿ÉÒÔÑ¡ÔòÊÇ·ñÉ¾³ý¶ÔÏóÊµÀý
//--------------------------------------------------------------------------
void KUiToiUuImage::CloseWindow() {
    if (m_pSelf) {
        //KUiItem::OnNpcTradeMode(false);
//		KUiOptions:CloseWindow();
        g_UiBase.SetStatus(UIS_S_IDLE);
        m_pSelf->Destroy();
        m_pSelf = NULL;
    }
}

//³õÊ¼»¯
void KUiToiUuImage::Initialize() {
    AddChild(&m_CloseBtn);
    AddChild(&m_TitleText);
    AddChild(&m_HideNpc);
    AddChild(&m_HidePlayer);
    AddChild(&m_HideNpcBtn);
    AddChild(&m_HidePlayerBtn);

    m_ItemsBox.SetContainerId((int) UOC_NPC_SHOP);
    Wnd_AddWindow(this);
    char Scheme[256];
    g_UiBase.GetCurSchemePath(Scheme, 256);
    LoadScheme(Scheme);
}

//ÔØÈë½çÃæ·½°¸
void KUiToiUuImage::LoadScheme(const char *pScheme) {
    if (m_pSelf) {
        char Buff[128];
        KIniFile Ini;
        sprintf(Buff, "%s\\" SCHEME_INI, pScheme);
        if (Ini.Load(Buff)) {
            m_pSelf->KWndShowAnimate::Init(&Ini, "Main");
            m_pSelf->m_CloseBtn.Init(&Ini, "CloseBtn");
            m_pSelf->m_TitleText.Init(&Ini, "TitleText");
            m_pSelf->m_HideNpc.Init(&Ini, "HideNpc");
            m_pSelf->m_HidePlayer.Init(&Ini, "HidePlayer");
            m_pSelf->m_HideNpcBtn.Init(&Ini, "HideNpcBtn");
            m_pSelf->m_HidePlayerBtn.Init(&Ini, "HidePlayerBtn");
            m_pSelf->m_TitleText.SetText("Tèi ­u h×nh ¶nh trß ch¬i");
            m_pSelf->m_HideNpc.SetText("Èn npc");
            m_pSelf->m_HidePlayer.SetText("Èn ng­êi ch¬i");
            m_pSelf->m_ItemsBox.EnablePickPut(false);
        }
    }
}

void KUiToiUuImage::Cancel() {
    CloseWindow();
}

//´°¿Úº¯Êý
int KUiToiUuImage::WndProc(unsigned int uMsg, unsigned int uParam, int nParam) {
    switch (uMsg) {
        case WND_N_BUTTON_CLICK:
            if (uParam == (unsigned int) (KWndWindow *) &m_HideNpcBtn) {
                OnHideNpc();
                return 0;
            } else if (uParam == (unsigned int) (KWndWindow *) &m_HidePlayerBtn) {
                OnHidePlayer();
                return 0;
            } else if (uParam == (unsigned int) (KWndWindow *) &m_CloseBtn) {
                m_pSelf->Hide();
                return 0;
            }
            break;
        default:
            return KWndShowAnimate::WndProc(uMsg, uParam, nParam);
    }
    return 0;
}

void KUiToiUuImage::OnBuyItem(KUiDraggedObject *pItem, bool bDoImmed) {
/*	if (pItem == NULL || g_pCoreShell == NULL)
		return;

/*	KUiObjAtContRegion	Obj;
	Obj.Obj.uGenre = pItem->uGenre;
	Obj.Obj.uId = pItem->uId;
	Obj.Region.h = pItem->DataX;
	Obj.Region.v = pItem->DataY;
	Obj.Region.Width  = pItem->DataW;
	Obj.Region.Height = pItem->DataH;
	Obj.eContainer = UOC_NPC_SHOP;

	if (bDoImmed == false)
	{
		KUiItemBuySelInfo	Price = { 0 };
		if (g_pCoreShell->GetGameData(GDI_TRADE_ITEM_PRICE,
			(unsigned int)(&Obj), (int)(&Price)))
		{
			KUiTradeConfirm::OpenWindow(&Obj, &Price, TCA_BUY);
		}
	}
	else
	{
		g_pCoreShell->OperationRequest(GOI_TRADE_NPC_BUY,
			(unsigned int)(&Obj), 0);
	}*/
}

void KUiToiUuImage::OnClickButton(KWndButton *pWnd, int bCheck) {
/*	if (Wnd_GetDragObj(NULL))
		return;
/*	if (uParam == (unsigned int)(KWndWindow*)&m_HideNpcBtn)
		{
			OnHideNpc();
			return 0;
		}
		else if (uParam == (unsigned int)(KWndWindow*)&m_HidePlayerBtn)
		{
			OnHidePlayer();
			return 0;
		}
		else if (pWnd == &m_CloseBtn)
		CloseWindow();*/
}

void KUiToiUuImage::OnHideNpc() {
    if (IsHide == FALSE) {
        IsHide = TRUE;
//		g_pCoreShell->OperationRequest(GOI_TOI_UU_IMAGE_COMMAND, 1, false);
        m_HideNpcBtn.CheckButton(true);
        m_HideNpcBtn.SetFrame(1);
    } else {
        IsHide = FALSE;
//		g_pCoreShell->OperationRequest(GOI_TOI_UU_IMAGE_COMMAND, 1, true);
        m_HideNpcBtn.CheckButton(false);
        m_HideNpcBtn.SetFrame(0);
    }
}

void KUiToiUuImage::OnHidePlayer() {
    if (IsHide == FALSE) {
        IsHide = TRUE;
//		g_pCoreShell->OperationRequest(GOI_TOI_UU_IMAGE_COMMAND, 2, false);
        m_HidePlayerBtn.CheckButton(true);
        m_HidePlayerBtn.SetFrame(1);
    } else {
        IsHide = FALSE;
//		g_pCoreShell->OperationRequest(GOI_TOI_UU_IMAGE_COMMAND, 2, true);
        m_HidePlayerBtn.CheckButton(false);
        m_HidePlayerBtn.SetFrame(0);
    }
}

void KUiToiUuImage::SetPage(int nIndex) {
    /*if (nIndex >= 0 && nIndex < m_nPageCount && m_pObjsList)
    {
        //m_ItemsBox.Clear();
        for (int i = 0; i < m_nObjCount; i++)
        {
            if (m_pObjsList[i].nContainer == nIndex)
                m_ItemsBox.AddObject((KUiDraggedObject*)&m_pObjsList[i], 1);
        }
        //m_nCurrentPage = nIndex;
    }*/
}

void KUiToiUuImage::UpdateData() {
/*	Clear();
	m_nObjCount = g_pCoreShell->GetGameData(GDI_TRADE_NPC_ITEM, 0, 0);
	if (m_nObjCount == 0)
		return;

	if (m_pObjsList = (KUiObjAtContRegion*)malloc(sizeof(KUiObjAtContRegion) * m_nObjCount))
	{
		g_pCoreShell->GetGameData(GDI_TRADE_NPC_ITEM, (unsigned int)m_pObjsList, m_nObjCount);
		m_nPageCount = m_pObjsList[m_nObjCount - 1].nContainer + 1;
		SetPage(0);
	}
	else
		m_nObjCount = 0;*/
}

void KUiToiUuImage::Clear() {
/*	m_nObjCount  = 0;
	m_nPageCount = 0;
	if (m_pObjsList)
	{
		free(m_pObjsList);
		m_pObjsList = NULL;
	}*/
}
