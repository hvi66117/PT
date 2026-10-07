#include "KWin32.h"
#include "KIniFile.h"
#include "../Elem/WndMessage.h"
#include "../elem/wnds.h"
#include "UiItem.h"
#include "UiCompoundItem.h"
#include "UiSysMsgCentre.h"
#include "../../../core/src/coreshell.h"
#include "../UiBase.h"
#include "crtdbg.h"
#include "../UiSoundSetting.h"

#include "../../../Represent/iRepresent/iRepresentShell.h"

extern iRepresentShell *g_pRepresentShell;

extern iCoreShell *g_pCoreShell;

KUiComItem *KUiComItem::m_pSelf = NULL;

#define    SCHEME_INI_SHEET            "UiCompoundItem_Sheet.ini"
#define    SCHEME_INI_COMPE            "UiCompoundItem_Compe.ini"
#define    SCHEME_INI_BUILD            "UiCompoundItem_Build.ini"
#define    SCHEME_INI_OUTIN            "UiCompoundItem_Outin.ini"
//#define		SCHEME_INI_INOUT			"UiCompoundItem_Inout.ini"//them

void KUiComItem::LoadScheme(const char *pScheme) {
    char Buff[128];
    KIniFile Ini;
    sprintf(Buff, "%s\\%s", pScheme, SCHEME_INI_SHEET);
    if (m_pSelf && Ini.Load(Buff)) {
        m_pSelf->Init(&Ini, "Main");
        m_pSelf->m_CompoundPadBtn.Init(&Ini, "CompoundBtn");
        m_pSelf->m_DistillPadBtn.Init(&Ini, "DistillBtn");
        m_pSelf->m_ForgePadBtn.Init(&Ini, "ForgeBtn");
        m_pSelf->m_EnchasePadBtn.Init(&Ini, "EnchaseBtn");
        m_pSelf->m_AtlasPadBtn.Init(&Ini, "AtlasBtn");
        m_pSelf->m_UpCryoliteBtn.Init(&Ini, "CryoliteBtn");
        m_pSelf->m_UpPropMineBtn.Init(&Ini, "PropMineBtn");
        m_pSelf->m_CheTao.Init(&Ini, "CheTao");
        m_pSelf->m_CheTao.SetText("ChÕ T¹o");
        m_pSelf->m_Close.Init(&Ini, "CloseBtn");

        m_pSelf->m_CompoundPad.LoadScheme(pScheme);
// 		m_pSelf->m_LiveSkillPad.LoadScheme(pScheme);
// 		m_pSelf->m_FightSkillPad.LoadScheme(pScheme);
    }
}

void KUiComItem::Initialize() {
    AddChild(&m_CompoundPadBtn);
    AddChild(&m_DistillPadBtn);
    AddChild(&m_EnchasePadBtn);
    AddChild(&m_ForgePadBtn);
    AddChild(&m_AtlasPadBtn);
    AddChild(&m_UpCryoliteBtn);
    AddChild(&m_UpPropMineBtn);
    AddChild(&m_CheTao);
    AddChild(&m_Close);

    m_CompoundPad.Initialize();
    AddPage(&m_CompoundPad, &m_CompoundPadBtn);

    m_DistillPad.Initialize();
    AddPage(&m_DistillPad, &m_DistillPadBtn);

    m_ForgePad.Initialize();
    AddPage(&m_ForgePad, &m_ForgePadBtn);

    m_EnchasePad.Initialize();
    AddPage(&m_EnchasePad, &m_EnchasePadBtn);

    m_AtlasPad.Initialize();
    AddPage(&m_AtlasPad, &m_AtlasPadBtn);

    char Scheme[256];
    g_UiBase.GetCurSchemePath(Scheme, 256);
    LoadScheme(Scheme);

    Wnd_AddWindow(this);
}

/*********************************************************************
* ¹¦ÄÜ£º´ò¿ª´°¿Ú
**********************************************************************/
KUiComItem *KUiComItem::OpenWindow() {
    if (m_pSelf == NULL) {
        m_pSelf = new KUiComItem;
        if (m_pSelf)
            m_pSelf->Initialize();
    }
    if (m_pSelf) {
        UiSoundPlay(UI_SI_WND_OPENCLOSE);
        m_pSelf->m_nStatus = STATUS_WAITING_MATERIALS;
        m_pSelf->m_nNum = WINDOWS_COMP;
        m_pSelf->m_CompoundPadBtn.CheckButton(TRUE);
        m_pSelf->m_DistillPadBtn.CheckButton(FALSE);
        m_pSelf->m_AtlasPadBtn.CheckButton(FALSE);
        m_pSelf->m_EnchasePadBtn.CheckButton(FALSE);
        m_pSelf->m_ForgePadBtn.CheckButton(FALSE);
        m_pSelf->m_UpCryoliteBtn.Hide();
        m_pSelf->m_UpPropMineBtn.Hide();
        m_pSelf->BringToTop();
        m_pSelf->Show();

        if (KUiItem::GetIfVisible() == NULL)
            KUiItem::OpenWindow();
        else
            UiSoundPlay(UI_SI_WND_OPENCLOSE);
        KUiItem::OnNpcTradeMode(true);
    }
    return m_pSelf;
}


/*********************************************************************
* ¹¦ÄÜ£ºÈç¹û´°¿ÚÕý±»ÏÔÊ¾£¬Ôò·µ»ØÊµÀýÖ¸Õë
**********************************************************************/
KUiComItem *KUiComItem::GetIfVisible() {
    if (m_pSelf && m_pSelf->IsVisible())
        return m_pSelf;
    return NULL;
}


/*********************************************************************
* ¹¦ÄÜ£º¹Ø±Õ´°¿Ú£¬Í¬Ê±¿ÉÒÔÑ¡ÔòÊÇ·ñÉ¾³ý¶ÔÏóÊµÀý
**********************************************************************/
void KUiComItem::CloseWindow(bool bDestory) {
    if (m_pSelf) {
        m_pSelf->Hide();
        if (bDestory) {
            m_pSelf->Destroy();
            m_pSelf = NULL;
        }
    }
    KUiItem::OnNpcTradeMode(false);
}

int KUiComItem::WndProc(unsigned int uMsg, unsigned int uParam, int nParam) {
    switch (uMsg) {
        case WND_N_BUTTON_CLICK:
            if (uParam == (unsigned int) &m_Close) {
                CloseWindow();
            } else if (uParam == (unsigned int) &m_UpPropMineBtn && m_UpCryoliteBtn.IsVisible()) {
                m_nNum = WINDOWS_COMP3;
                ShowWindow(0);
                m_CompoundPad.SetPosText(3);
            } else if (uParam == (unsigned int) &m_UpCryoliteBtn && m_UpCryoliteBtn.IsVisible()) {
                m_nNum = WINDOWS_COMP2;
                ShowWindow(0);
                m_CompoundPad.SetPosText(2);
            } else if (uParam == (unsigned int) &m_CompoundPadBtn && m_UpCryoliteBtn.IsVisible()) {
                m_nNum = WINDOWS_COMP;
                ShowWindow(0);
                m_CompoundPad.SetPosText(1);
            } else if (uParam == (unsigned int) &m_CompoundPadBtn && !m_UpCryoliteBtn.IsVisible()) {
                m_CompoundPadBtn.CheckButton(TRUE);
                int nX, nY;
                m_CompoundPadBtn.GetPosition(&nX, &nY);
                m_UpCryoliteBtn.SetPosition(nX, nY + 19);
                m_UpPropMineBtn.SetPosition(nX, nY + 38);
                m_UpCryoliteBtn.BringToTop();
                m_UpPropMineBtn.BringToTop();
                m_UpCryoliteBtn.Show();
                m_UpPropMineBtn.Show();
            } else if (uParam == (unsigned int) &m_DistillPadBtn) {
                m_nNum = WINDOWS_DISTill;
                ShowWindow(1);
            } else if (uParam == (unsigned int) &m_ForgePadBtn) {
                m_nNum = WINDOWS_FORG;
                ShowWindow(2);
            } else if (uParam == (unsigned int) &m_EnchasePadBtn) {
                m_nNum = WINDOWS_ENCHASE;
                ShowWindow(3);
            } else if (uParam == (unsigned int) &m_AtlasPadBtn) {
                m_nNum = WINDOWS_ATLAS;
                ShowWindow(4);
            }
            break;

        default:
            return KWndImage::WndProc(uMsg, uParam, nParam);
    }
    return 1;
}

void KUiComItem::ShowWindow(int nNum /*= 0*/ ) {
    m_pSelf->CleanItem();
    switch (nNum) {
        case 0:
            m_pSelf->m_CompoundPad.Show();
            m_pSelf->m_CompoundPadBtn.CheckButton(TRUE);
            m_pSelf->m_UpCryoliteBtn.CheckButton(FALSE);
            m_pSelf->m_UpPropMineBtn.CheckButton(FALSE);
            m_pSelf->m_UpCryoliteBtn.Hide();
            m_pSelf->m_UpPropMineBtn.Hide();
            m_pSelf->m_DistillPad.Hide();
            m_pSelf->m_EnchasePad.Hide();
            m_pSelf->m_ForgePad.Hide();
            m_pSelf->m_AtlasPad.Hide();
            m_pSelf->m_DistillPadBtn.CheckButton(FALSE);
            m_pSelf->m_EnchasePadBtn.CheckButton(FALSE);
            m_pSelf->m_ForgePadBtn.CheckButton(FALSE);
            m_pSelf->m_AtlasPadBtn.CheckButton(FALSE);
            break;
        case 1:
            m_pSelf->m_DistillPad.Show();
            m_pSelf->m_DistillPadBtn.CheckButton(TRUE);
            m_pSelf->m_UpCryoliteBtn.Hide();
            m_pSelf->m_UpPropMineBtn.Hide();
            m_pSelf->m_CompoundPad.Hide();
            m_pSelf->m_EnchasePad.Hide();
            m_pSelf->m_ForgePad.Hide();
            m_pSelf->m_AtlasPad.Hide();
            m_pSelf->m_CompoundPadBtn.CheckButton(FALSE);
            m_pSelf->m_EnchasePadBtn.CheckButton(FALSE);
            m_pSelf->m_ForgePadBtn.CheckButton(FALSE);
            m_pSelf->m_AtlasPadBtn.CheckButton(FALSE);
            break;
        case 2:
            m_pSelf->m_ForgePad.Show();
            m_pSelf->m_ForgePadBtn.CheckButton(TRUE);
            m_pSelf->m_UpCryoliteBtn.Hide();
            m_pSelf->m_UpPropMineBtn.Hide();
            m_pSelf->m_DistillPad.Hide();
            m_pSelf->m_EnchasePad.Hide();
            m_pSelf->m_CompoundPad.Hide();
            m_pSelf->m_AtlasPad.Hide();
            m_pSelf->m_DistillPadBtn.CheckButton(FALSE);
            m_pSelf->m_EnchasePadBtn.CheckButton(FALSE);
            m_pSelf->m_CompoundPadBtn.CheckButton(FALSE);
            m_pSelf->m_AtlasPadBtn.CheckButton(FALSE);
            break;
        case 3:
            m_pSelf->m_EnchasePad.Show();
            m_pSelf->m_EnchasePadBtn.CheckButton(TRUE);
            m_pSelf->m_UpCryoliteBtn.Hide();
            m_pSelf->m_UpPropMineBtn.Hide();
            m_pSelf->m_DistillPad.Hide();
            m_pSelf->m_CompoundPad.Hide();
            m_pSelf->m_ForgePad.Hide();
            m_pSelf->m_AtlasPad.Hide();
            m_pSelf->m_DistillPadBtn.CheckButton(FALSE);
            m_pSelf->m_CompoundPadBtn.CheckButton(FALSE);
            m_pSelf->m_ForgePadBtn.CheckButton(FALSE);
            m_pSelf->m_AtlasPadBtn.CheckButton(FALSE);
            break;
        case 4:
            m_pSelf->m_AtlasPad.Show();
            m_pSelf->m_AtlasPadBtn.CheckButton(TRUE);
            m_pSelf->m_UpCryoliteBtn.Hide();
            m_pSelf->m_UpPropMineBtn.Hide();
            m_pSelf->m_DistillPad.Hide();
            m_pSelf->m_EnchasePad.Hide();
            m_pSelf->m_ForgePad.Hide();
            m_pSelf->m_CompoundPad.Hide();
            m_pSelf->m_DistillPadBtn.CheckButton(FALSE);
            m_pSelf->m_EnchasePadBtn.CheckButton(FALSE);
            m_pSelf->m_ForgePadBtn.CheckButton(FALSE);
            m_pSelf->m_CompoundPadBtn.CheckButton(FALSE);
            break;
    }
}

void KUiComItem::UpdateItem(KUiObjAtRegion *pItem, int bAdd) {

    KUiDraggedObject obj;
    obj.uGenre = pItem->Obj.uGenre;
    obj.uId = pItem->Obj.uId;
    obj.DataX = pItem->Region.h;
    obj.DataY = pItem->Region.v;
    obj.DataW = pItem->Region.Width;
    obj.DataH = pItem->Region.Height;

    switch (m_nNum) {
        case WINDOWS_COMP: {
            m_CompoundPad.UpdateItem(&obj, bAdd);
        }
            break;
        case WINDOWS_COMP2: {
            m_CompoundPad.UpdateItem(&obj, 4);
        }
            break;
        case WINDOWS_COMP3: {
            m_CompoundPad.UpdateItem(&obj, 4);
        }
            break;
        case WINDOWS_DISTill: {
            m_DistillPad.UpdateItem(&obj, bAdd);
        }
            break;
        case WINDOWS_FORG: {
            m_ForgePad.UpdateItem(&obj, bAdd);
        }
            break;
        case WINDOWS_ENCHASE: {
            m_EnchasePad.UpdateItem(&obj, bAdd);
        }
            break;
        case WINDOWS_ATLAS: {

        }
            break;
    }
}

int KUiComItem::GetWindowsNum() {
    return m_nNum;
}

void KUiComItem::ComItem(unsigned int pItem, int nWindowNum, int nNum) {
    switch (nWindowNum) {
        case WINDOWS_COMP:
            if (g_pCoreShell) {
                g_pCoreShell->OperationRequest(GOI_COMPITEM_COM, pItem, 1);
            }
            break;
        case WINDOWS_COMP2:
            if (g_pCoreShell) {
                g_pCoreShell->OperationRequest(GOI_COMPITEM_COM, pItem, 2);
            }
            break;
        case WINDOWS_COMP3:
            if (g_pCoreShell) {
                g_pCoreShell->OperationRequest(GOI_COMPITEM_COM, pItem, 3);
            }
            break;
        case WINDOWS_DISTill:
            if (g_pCoreShell) {
                g_pCoreShell->OperationRequest(GOI_COMPITEM_DISTILL, pItem, nNum);
            }
            break;
        case WINDOWS_FORG:
            if (g_pCoreShell) {
                g_pCoreShell->OperationRequest(GOI_COMPITEM_FORGE, pItem, nNum);
            }
            break;
        case WINDOWS_ENCHASE:
            if (g_pCoreShell) {
                g_pCoreShell->OperationRequest(GOI_COMPITEM_ENCHASE, pItem, nNum);
            }
            break;
        case WINDOWS_ATLAS:
            if (g_pCoreShell) {
                g_pCoreShell->OperationRequest(GOI_COMPITEM_ALTAL, pItem, nNum);
            }
            break;
    }
}

void KUiComItem::Breathe() {
// 	if(m_nStatus == STATUS_BEGIN_TREMBLE)
// 	{
// 		m_TrembleEffect.Show();
// 		m_TrembleEffect.SetFrame(0);
// 		m_nStatus = STATUS_TREMBLING;
// 	}
// 	else if(m_nStatus == STATUS_TREMBLING)
// 	{
// 		if(!PlayEffect())
// 		{
// 			m_nStatus = STATUS_CHANGING_ITEM;
// 			m_TrembleEffect.Hide();
// 		}
// 	}
// 	else if(m_nStatus == STATUS_CHANGING_ITEM)
// 	{
// 		m_nStatus = STATUS_FINISH;
// 	}
}

int KUiComItem::PlayEffect() {
// 	if(m_TrembleEffect.GetMaxFrame() == 0 ||
// 		m_TrembleEffect.GetMaxFrame() >= m_TrembleEffect.GetCurrentFrame() - 1)
// 	{
// 		m_TrembleEffect.SetFrame(0);
// 		return 0;
// 	}
// 	else
// 	{
// 		m_TrembleEffect.NextFrame();
// 		return 1;
// 	}
    return 0;
}

void KUiComItem::CleanItem() {
    m_CompoundPad.CleanItem();
    m_DistillPad.CleanItem();
    m_ForgePad.CleanItem();
    m_EnchasePad.CleanItem();
}

KUiCompound::KUiCompound() {

}

int KUiCompound::WndProc(unsigned int uMsg, unsigned int uParam, int nParam) {
    switch (uMsg) {
        case WND_N_SCORLLBAR_POS_CHANGED:
            if (uParam == (unsigned int) &m_ListScroll) {
                m_Guide.SetFirstShowLine(nParam);
            }
            break;
        case WND_N_BUTTON_CLICK:
            if (uParam == (unsigned int) &m_Cancle) {
                CleanItem();
            } else if (uParam == (unsigned int) &m_Compound) {
                KUiComItem *pSelf = KUiComItem::GetIfVisible();

                KUiDraggedObject pObj;
                unsigned int pUP[3];

                m_Box1.GetObject(pObj);
                if (pObj.uId > 0) {
                    pUP[0] = pObj.uId;
                } else {
                    return 1;
                }

                pObj.uId = 0;
                m_Box2.GetObject(pObj);
                if (pObj.uId > 0) {
                    pUP[1] = pObj.uId;
                } else {
                    return 1;
                }

                pObj.uId = 0;
                m_Box3.GetObject(pObj);
                if (pObj.uId > 0) {
                    pUP[2] = pObj.uId;
                } else {
                    return 1;
                }
                PlayEffect();
                pSelf->ComItem((unsigned int) (&pUP), m_nSelect, 3);
                CleanItem();
            }
            break;

        default:
            return KWndImage::WndProc(uMsg, uParam, nParam);
    }
    return 1;
}

void KUiCompound::UpdateResult() {

}

void KUiCompound::Breathe() {
    if (m_nStatus == STATUS_BEGIN_TREMBLE) {
        m_TrembleEffect1.Show();
        m_TrembleEffect1.SetFrame(0);
        m_nStatus = STATUS_TREMBLING;
    } else if (m_nStatus == STATUS_TREMBLING) {
        if (!PlayEffect()) {
            m_nStatus = STATUS_CHANGING_ITEM;
            m_TrembleEffect1.Hide();
        }
    } else if (m_nStatus == STATUS_CHANGING_ITEM) {
        UpdateResult();
        m_nStatus = STATUS_FINISH;
    }
}

int KUiCompound::PlayEffect() {
    if (m_TrembleEffect1.GetMaxFrame() == 0 ||
        m_TrembleEffect1.GetMaxFrame() >= m_TrembleEffect1.GetCurrentFrame() - 1) {
        m_TrembleEffect1.SetFrame(0);
        return 0;
    } else {
        m_TrembleEffect1.NextFrame();
        return 1;
    }
}

void KUiCompound::PaintWindow() {
    KWndPage::PaintWindow();
}

void KUiCompound::LoadScheme(const char *pScheme) {
    char Buff[128], Buffer[64];
    KIniFile Ini;
    sprintf(Buff, "%s\\%s", pScheme, SCHEME_INI_COMPE);
    if (Ini.Load(Buff)) {
        KWndImage::Init(&Ini, "Main");
        m_Box1.Init(&Ini, "Ore1");
        m_Box2.Init(&Ini, "Ore3");
        m_Box3.Init(&Ini, "Ore2");
        m_Compound.Init(&Ini, "CompoundBtn");
        m_Cancle.Init(&Ini, "CancleBtn");
        m_Guide.Init(&Ini, "GuideList");
        m_ListScroll.Init(&Ini, "GuideList_Scroll");
        m_TrembleEffect1.Init(&Ini, "Effect_0");
        m_TrembleEffect2.Init(&Ini, "Effect_1");
        m_TrembleEffect3.Init(&Ini, "Effect_2");
        //m_ListBtn.Init(&Ini,"GuideList_Scroll_Btn");

        int nX, nY, nColor;
        Ini.GetInteger2("Box_0", "Pos", &nX, &nY);

        if (Ini.GetString("TextColor", "Font", "", Buffer, sizeof(Buffer))) {
            nColor = (::GetColor(Buffer) & 0xFFFFFF);
        }
        m_nSelect = 0;
        m_Pos1.SetPosition(nX - 14, nY - 4);
        m_Pos1.SetText("NhÉn");
        m_Pos1.SetTextColor(nColor);
        //m_Pos1.BringToTop();

        Ini.GetInteger2("Box_1", "Pos", &nX, &nY);

        m_Pos2.SetPosition(nX - 14, nY - 4);
        m_Pos2.SetText("D©y chuyÒn/hé thÇn phï");
        m_Pos2.SetTextColor(nColor);
        //m_Pos2.BringToTop();

        Ini.GetInteger2("Box_2", "Pos", &nX, &nY);

        m_Pos3.SetPosition(nX - 14, nY - 4);
        m_Pos3.SetText("Ngäc béi/h­íng nang");
        m_Pos3.SetTextColor(nColor);
        //m_Pos3.BringToTop();

        // 		m_pSelf->m_LiveSkillPad.LoadScheme(pScheme);
        // 		m_pSelf->m_FightSkillPad.LoadScheme(pScheme);
    }
}

void KUiCompound::Initialize() {
    AddChild(&m_Pos1);
    AddChild(&m_Pos2);
    AddChild(&m_Pos3);
    AddChild(&m_Box1);
    AddChild(&m_Box2);
    AddChild(&m_Box3);
    AddChild(&m_Compound);
    AddChild(&m_Cancle);
    AddChild(&m_TrembleEffect1);
    AddChild(&m_TrembleEffect2);
    AddChild(&m_TrembleEffect3);
    AddChild(&m_Guide);
    AddChild(&m_ListScroll);
//	AddChild(&m_ListBtn);


    m_Guide.SetScrollbar(&m_ListScroll);


    char Scheme[256];
    g_UiBase.GetCurSchemePath(Scheme, 256);
    LoadScheme(Scheme);

    char Buff[128];
    KIniFile Ini;

    sprintf(Buff, "%s\\%s", Scheme, SCHEME_INI_SHEET);
    if (Ini.Load(Buff)) {
        ZeroMemory(Buff, sizeof(Buff));
        Ini.GetString("RuleInfo", "Compound", "", Buff, sizeof(Buff));

        m_Guide.AddOneMessage(Buff, sizeof(Buff));

        ZeroMemory(Buff, sizeof(Buff));
        Ini.GetString("RuleInfo", "CompoundRule", "", Buff, sizeof(Buff));

        m_Guide.AddOneMessage(Buff, sizeof(Buff));
    }

    Wnd_AddWindow(this);
}

void KUiCompound::UpdateItem(KUiDraggedObject *pItem, int bAdd) {
    if (bAdd == 1) {
        m_Box1.HoldObject(pItem->uGenre, pItem->uId, 58, 54);
        //m_Box1.EnablePickPut(true);
    }
    if (bAdd == 2) {
        m_Box2.HoldObject(pItem->uGenre, pItem->uId, 58, 54);
    }
    if (bAdd == 3) {
        m_Box3.HoldObject(pItem->uGenre, pItem->uId, 58, 54);
    }
    if (bAdd == 4) {
        KUiDraggedObject pObj;
        m_Box1.GetObject(pObj);
        if (pObj.uGenre) {
            m_Box2.GetObject(pObj);
            if (pObj.uGenre) {
                m_Box3.GetObject(pObj);
                if (pObj.uGenre) {
                    m_Box1.HoldObject(pItem->uGenre, pItem->uId, 58, 54);
                } else {
                    m_Box3.HoldObject(pItem->uGenre, pItem->uId, 58, 54);
                }
            } else {
                m_Box2.HoldObject(pItem->uGenre, pItem->uId, 58, 54);
            }
        } else {
            m_Box1.HoldObject(pItem->uGenre, pItem->uId, 58, 54);
        }
    }
}

void KUiCompound::SetPosText(int i) {
    switch (i) {
        case 1:
            m_nSelect = 0;
            m_Pos1.SetText("NhÉn");
            m_Pos2.SetText("D©y chuyÒn/hé thÇn phï");
            m_Pos3.SetText("Ngäc béi/h­íng nang");
            break;
        case 2:
            m_nSelect = 1;
            m_Pos1.SetText("HuyÒn tinh 1");
            m_Pos2.SetText("HuyÒn tinh 2");
            m_Pos3.SetText("HuyÒn tinh 3");
            break;
        case 3:
            m_nSelect = 2;
            m_Pos1.SetText("Kho¸ng th¹ch 1");
            m_Pos2.SetText("Kho¸ng th¹ch 2");
            m_Pos3.SetText("Kho¸ng th¹ch 3");
            break;
    }
}

void KUiCompound::CleanItem() {
    m_Box1.Celar();
    m_Box2.Celar();
    m_Box3.Celar();
}

KUiDistill::KUiDistill() {

}

void KUiDistill::PaintWindow() {
    KWndPage::PaintWindow();
}

int KUiDistill::WndProc(unsigned int uMsg, unsigned int uParam, int nParam) {
    switch (uMsg) {
        case WND_N_SCORLLBAR_POS_CHANGED:
            if (uParam == (unsigned int) &m_ListScroll) {
                m_Guide.SetFirstShowLine(nParam);
            }
            break;
        case WND_N_BUTTON_CLICK:
            if (uParam == (unsigned int) &m_Cancle) {
                CleanItem();
            } else if (uParam == (unsigned int) &m_Distill) {
                int nNum = 0;

                KUiDraggedObject pObj;
                unsigned int pUP[11];

                m_BigBox.GetObject(pObj);
                if (pObj.uId > 0) {
                    pUP[nNum] = pObj.uId;
                    nNum++;
                } else {
                    return 1;
                }

                pObj.uId = 0;
                m_Box1.GetObject(pObj);
                if (pObj.uId > 0) {
                    pUP[nNum] = pObj.uId;
                    nNum++;
                } else {
                    return 1;
                }

                pObj.uId = 0;
                m_Box2.GetObject(pObj);
                if (pObj.uId > 0) {
                    pUP[nNum] = pObj.uId;
                    nNum++;
                } else {
                    return 1;
                }

                for (int i = 0; i < 2; i++) {
                    for (int j = 0; j < 4; j++) {
                        pObj.uId = 0;
                        m_ItemBox.GetObject(pObj, i, j);
                        if (pObj.uId > 0) {
                            pUP[nNum] = pObj.uId;
                            nNum++;
                        } else {
                            break;
                        }
                    }
                }

                KUiComItem *pSelf = KUiComItem::GetIfVisible();
                pSelf->ComItem((unsigned int) (&pUP), 3, nNum);

                CleanItem();
            }
            break;

        default:
            return KWndImage::WndProc(uMsg, uParam, nParam);
    }
    return 1;
}

void KUiDistill::LoadScheme(const char *pScheme) {
    char Buff[128], Buffer[64];
    KIniFile Ini;
    sprintf(Buff, "%s\\%s", pScheme, SCHEME_INI_OUTIN);
    if (Ini.Load(Buff)) {
        KWndImage::Init(&Ini, "Main");
        m_BigBox.Init(&Ini, "BigBox");
        m_Box1.Init(&Ini, "SmallBox1");
        m_Box2.Init(&Ini, "SmallBox2");
        m_ItemBox.Init(&Ini, "ItemBox");
        m_Distill.Init(&Ini, "DistillBtn");
        m_Cancle.Init(&Ini, "CancleBtn");
        m_Guide.Init(&Ini, "GuideList");
        m_ListScroll.Init(&Ini, "GuideList_Scroll");
        //m_ListBtn.Init(&Ini,"GuideList_Scroll_Btn");
        m_ItemBox.EnableTracePutPos(FALSE);

        int nX, nY, nColor;
        Ini.GetInteger2("EquipPos", "Pos", &nX, &nY);
        if (Ini.GetString("TextColor", "Font", "", Buffer, sizeof(Buffer))) {
            nColor = (::GetColor(Buffer) & 0xFFFFFF);
        }

        m_Pos1.SetPosition(nX - 14, nY - 4);
        m_Pos1.SetTextColor(nColor);
        m_Pos1.BringToTop();
        m_Pos1.SetText("Trang bÞ xanh/tr¾ng");

        Ini.GetInteger2("CryolitePos", "Pos", &nX, &nY);
        m_Pos2.SetPosition(nX - 12, nY - 4);
        m_Pos2.SetTextColor(nColor);
        m_Pos2.BringToTop();
        m_Pos2.SetText("HuyÒn tinh");

        Ini.GetInteger2("PropMinePos", "Pos", &nX, &nY);
        m_Pos3.SetPosition(nX - 12, nY - 4);
        m_Pos3.SetTextColor(nColor);
        m_Pos3.BringToTop();
        m_Pos3.SetText("Nguyªn kho¸ng");

        Ini.GetInteger2("ConsumePos", "Pos", &nX, &nY);
        m_Pos4.SetPosition(nX - 14, nY - 4);
        m_Pos4.SetTextColor(nColor);
        m_Pos4.BringToTop();
        m_Pos4.SetText("Cã thÓ chän nguyªn liÖu");
        // 		m_pSelf->m_LiveSkillPad.LoadScheme(pScheme);
        // 		m_pSelf->m_FightSkillPad.LoadScheme(pScheme);
    }
}

void KUiDistill::Initialize() {
    AddChild(&m_BigBox);
    AddChild(&m_Box1);
    AddChild(&m_Box2);
    AddChild(&m_ItemBox);
    AddChild(&m_Distill);
    AddChild(&m_Cancle);

    AddChild(&m_Guide);
    AddChild(&m_ListScroll);
    //AddChild(&m_ListBtn);

    AddChild(&m_Pos1);
    AddChild(&m_Pos2);
    AddChild(&m_Pos3);
    AddChild(&m_Pos4);
    m_Guide.SetScrollbar(&m_ListScroll);


    char Scheme[256];
    g_UiBase.GetCurSchemePath(Scheme, 256);
    LoadScheme(Scheme);

    char Buff[128];
    KIniFile Ini;

    sprintf(Buff, "%s\\%s", Scheme, SCHEME_INI_SHEET);
    if (Ini.Load(Buff)) {
        ZeroMemory(Buff, sizeof(Buff));
        Ini.GetString("RuleInfo", "Distill", "", Buff, sizeof(Buff));

        m_Guide.AddOneMessage(Buff, sizeof(Buff));

        ZeroMemory(Buff, sizeof(Buff));
        Ini.GetString("RuleInfo", "DistillRule", "", Buff, sizeof(Buff));

        m_Guide.AddOneMessage(Buff, sizeof(Buff));
    }

    Wnd_AddWindow(this);
}

void KUiDistill::UpdateItem(KUiDraggedObject *pItem, int bAdd) {
    if (bAdd == 1) {
        m_BigBox.HoldObject(pItem->uGenre, pItem->uId, 58, 54);
    } else if (bAdd == 2) {
        m_Box1.HoldObject(pItem->uGenre, pItem->uId, 58, 54);
    } else if (bAdd == 3) {
        m_Box2.HoldObject(pItem->uGenre, pItem->uId, 58, 54);
    } else if (bAdd == 4) {
        KUiDraggedObject pObj;
        for (int i = 0; i < 2; i++) {
            for (int j = 0; j < 4; j++) {
                pObj.uId = 0;
                m_ItemBox.GetObject(pObj, i, j);
                if (pObj.uId == pItem->uId) {
                    return;
                }
                if (!pObj.uId) {
                    pItem->DataX = i;
                    pItem->DataY = j;
                    m_ItemBox.AddObject(pItem, 1);
                    return;
                }
            }
        }
    }
}

void KUiDistill::CleanItem() {
    m_BigBox.Celar();
    m_Box1.Celar();
    m_Box2.Celar();
    m_ItemBox.Clear();
}

KUiForge::KUiForge() {

}

void KUiForge::PaintWindow() {
    KWndPage::PaintWindow();
}

int KUiForge::WndProc(unsigned int uMsg, unsigned int uParam, int nParam) {
    switch (uMsg) {
        case WND_N_SCORLLBAR_POS_CHANGED:
            if (uParam == (unsigned int) &m_ListScroll) {
                m_Guide.SetFirstShowLine(nParam);
            }
            break;
        case WND_N_BUTTON_CLICK:
            if (uParam == (unsigned int) &m_Cancle) {
                CleanItem();
            } else if (uParam == (unsigned int) &m_ForgeBtn) {
                int nNum = 0;

                KUiDraggedObject pObj;
                unsigned int pUP[2];

                m_BigBox.GetObject(pObj);
                if (pObj.uId > 0) {
                    pUP[nNum] = pObj.uId;
                    nNum++;
                } else {
                    return 1;
                }

                pObj.uId = 0;
                m_SmallBox.GetObject(pObj);
                if (pObj.uId > 0) {
                    pUP[nNum] = pObj.uId;
                    nNum++;
                } else {
                    return 1;
                }

                KUiComItem *pSelf = KUiComItem::GetIfVisible();
                pSelf->ComItem((unsigned int) (&pUP), 4, nNum);

                CleanItem();
            }
            break;
        default:
            return KWndImage::WndProc(uMsg, uParam, nParam);
    }
    return 1;
}

void KUiForge::LoadScheme(const char *pScheme) {
    char Buff[128];
    KIniFile Ini;
    sprintf(Buff, "%s\\%s", pScheme, SCHEME_INI_BUILD);
    if (Ini.Load(Buff)) {
        KWndImage::Init(&Ini, "Main");
        m_BigBox.Init(&Ini, "BigBox");
        m_SmallBox.Init(&Ini, "SmallBox");
        m_ForgeBtn.Init(&Ini, "ForgeBtn");
        m_Cancle.Init(&Ini, "CancleBtn");
        m_Guide.Init(&Ini, "GuideList");
        m_ListScroll.Init(&Ini, "GuideList_Scroll");
        //m_ListBtn.Init(&Ini,"GuideList_Scroll_Btn");

        int nX, nY, nColor;
        Ini.GetInteger2("EquipPos", "Pos", &nX, &nY);
        if (Ini.GetString("TextColor", "Font", "", Buff, sizeof(Buff))) {
            nColor = (::GetColor(Buff) & 0xFFFFFF);
        }

        m_Pos1.SetPosition(nX - 14, nY - 4);
        m_Pos1.SetTextColor(nColor);
        m_Pos1.BringToTop();
        m_Pos1.SetText("Trang bÞ xanh/tr¾ng");

        Ini.GetInteger2("CryolitePos", "Pos", &nX, &nY);
        m_Pos2.SetPosition(nX - 12, nY - 4);
        m_Pos2.SetTextColor(nColor);
        m_Pos2.BringToTop();
        m_Pos2.SetText("HuyÒn tinh");

    }
}

void KUiForge::Initialize() {
    AddChild(&m_BigBox);
    AddChild(&m_SmallBox);
    AddChild(&m_ForgeBtn);
    AddChild(&m_Cancle);

    AddChild(&m_Guide);
    AddChild(&m_ListScroll);
    //AddChild(&m_ListBtn);

    AddChild(&m_Pos1);
    AddChild(&m_Pos2);
    m_Guide.SetScrollbar(&m_ListScroll);


    char Scheme[256];
    g_UiBase.GetCurSchemePath(Scheme, 256);
    LoadScheme(Scheme);

    char Buff[128];
    KIniFile Ini;

    sprintf(Buff, "%s\\%s", Scheme, SCHEME_INI_SHEET);
    if (Ini.Load(Buff)) {
        ZeroMemory(Buff, sizeof(Buff));
        Ini.GetString("RuleInfo", "Forge", "", Buff, sizeof(Buff));

        m_Guide.AddOneMessage(Buff, sizeof(Buff));

        ZeroMemory(Buff, sizeof(Buff));
        Ini.GetString("RuleInfo", "ForgeRule", "", Buff, sizeof(Buff));

        m_Guide.AddOneMessage(Buff, sizeof(Buff));
    }

    Wnd_AddWindow(this);
}

void KUiForge::UpdateItem(KUiDraggedObject *pItem, int bAdd) {
    if (bAdd == 1) {
        m_BigBox.HoldObject(pItem->uGenre, pItem->uId, 58, 54);
    } else if (bAdd == 2) {
        m_SmallBox.HoldObject(pItem->uGenre, pItem->uId, 58, 54);
    }
}

void KUiForge::CleanItem() {
    m_BigBox.Celar();
    m_SmallBox.Celar();
}

KUiEnchaseTim::KUiEnchaseTim() {

}

void KUiEnchaseTim::PaintWindow() {
    KWndPage::PaintWindow();
}

int KUiEnchaseTim::WndProc(unsigned int uMsg, unsigned int uParam, int nParam) {
    switch (uMsg) {
        case WND_N_SCORLLBAR_POS_CHANGED:
            if (uParam == (unsigned int) &m_ListScroll) {
                m_Guide.SetFirstShowLine(nParam);
            }
            break;
        case WND_N_BUTTON_CLICK:
            if (uParam == (unsigned int) &m_Cancle) {
                CleanItem();
            } else if (uParam == (unsigned int) &m_Distill) {
                int nNum = 0;

                KUiDraggedObject pObj;
                unsigned int pUP[11];

                m_BigBox.GetObject(pObj);
                if (pObj.uId > 0) {
                    pUP[nNum] = pObj.uId;
                    nNum++;
                } else {
                    return 0;
                }

                pObj.uId = 0;
                m_Box1.GetObject(pObj);
                if (pObj.uId > 0) {
                    pUP[nNum] = pObj.uId;
                    nNum++;
                } else {
                    return 0;
                }

                pObj.uId = 0;
                m_Box2.GetObject(pObj);
                if (pObj.uId > 0) {
                    pUP[nNum] = pObj.uId;
                    nNum++;
                } else {
                    return 0;
                }

                for (int i = 0; i < 2; i++) {
                    for (int j = 0; j < 4; j++) {
                        pObj.uId = 0;
                        m_ItemBox.GetObject(pObj, i, j);
                        if (pObj.uId > 0) {
                            pUP[nNum] = pObj.uId;
                            nNum++;
                        } else {
                            break;
                        }
                    }
                }

                KUiComItem *pSelf = KUiComItem::GetIfVisible();
                pSelf->ComItem((unsigned int) (&pUP), 5, nNum);

                CleanItem();
            }
            break;
        default:
            return KWndImage::WndProc(uMsg, uParam, nParam);
    }
    return 1;
}

void KUiEnchaseTim::LoadScheme(const char *pScheme) {
    char Buff[128];
    KIniFile Ini;
//	sprintf(Buff, "%s\\%s", pScheme, SCHEME_INI_INOUT);
    if (Ini.Load(Buff)) {
        KWndImage::Init(&Ini, "Main");
        m_BigBox.Init(&Ini, "BigBox");
        m_Box1.Init(&Ini, "SmallBox1");
        m_Box2.Init(&Ini, "SmallBox2");
        m_ItemBox.Init(&Ini, "ItemBox");
        m_Distill.Init(&Ini, "DistillBtn");
        m_Cancle.Init(&Ini, "CancleBtn");
        m_Guide.Init(&Ini, "GuideList");
        m_ListScroll.Init(&Ini, "GuideList_Scroll");
        //m_ListBtn.Init(&Ini,"GuideList_Scroll_Btn");
        m_ItemBox.EnableTracePutPos(FALSE);


        int nX, nY, nColor;
        Ini.GetInteger2("EquipPos", "Pos", &nX, &nY);
        if (Ini.GetString("TextColor", "Font", "", Buff, sizeof(Buff))) {
            nColor = (::GetColor(Buff) & 0xFFFFFF);
        }

        m_Pos1.SetPosition(nX - 14, nY - 4);
        m_Pos1.SetTextColor(nColor);
        m_Pos1.BringToTop();
        m_Pos1.SetText("Trang bÞ huyÒn tinh");

        Ini.GetInteger2("CryolitePos", "Pos", &nX, &nY);
        m_Pos2.SetPosition(nX - 12, nY - 4);
        m_Pos2.SetTextColor(nColor);
        m_Pos2.BringToTop();
        m_Pos2.SetText("HuyÒn tinh");

        Ini.GetInteger2("PropMinePos", "Pos", &nX, &nY);
        m_Pos3.SetPosition(nX - 12, nY - 4);
        m_Pos3.SetTextColor(nColor);
        m_Pos3.BringToTop();
        m_Pos3.SetText("Kho¸ng th¹ch");

        Ini.GetInteger2("ConsumePos", "Pos", &nX, &nY);
        m_Pos4.SetPosition(nX - 14, nY - 4);
        m_Pos4.SetTextColor(nColor);
        m_Pos4.BringToTop();
        m_Pos4.SetText("Cã thÓ chän nguyªn liÖu");
        // 		m_pSelf->m_LiveSkillPad.LoadScheme(pScheme);
        // 		m_pSelf->m_FightSkillPad.LoadScheme(pScheme);
    }
}

void KUiEnchaseTim::Initialize() {
    AddChild(&m_BigBox);
    AddChild(&m_Box1);
    AddChild(&m_Box2);
    AddChild(&m_ItemBox);
    AddChild(&m_Distill);
    AddChild(&m_Cancle);

    AddChild(&m_Guide);
    AddChild(&m_ListScroll);
    //AddChild(&m_ListBtn);

    AddChild(&m_Pos1);
    AddChild(&m_Pos2);
    AddChild(&m_Pos3);
    AddChild(&m_Pos4);
    m_Guide.SetScrollbar(&m_ListScroll);


    char Scheme[256];
    g_UiBase.GetCurSchemePath(Scheme, 256);
    LoadScheme(Scheme);

    char Buff[128];
    KIniFile Ini;

    sprintf(Buff, "%s\\%s", Scheme, SCHEME_INI_SHEET);
    if (Ini.Load(Buff)) {
        ZeroMemory(Buff, sizeof(Buff));
        Ini.GetString("RuleInfo", "Enchase", "", Buff, sizeof(Buff));

        m_Guide.AddOneMessage(Buff, sizeof(Buff));

        ZeroMemory(Buff, sizeof(Buff));
        Ini.GetString("RuleInfo", "EnchaseRule", "", Buff, sizeof(Buff));

        m_Guide.AddOneMessage(Buff, sizeof(Buff));
    }

    Wnd_AddWindow(this);
}

void KUiEnchaseTim::UpdateItem(KUiDraggedObject *pItem, int bAdd) {
    if (bAdd == 1) {
        m_BigBox.HoldObject(pItem->uGenre, pItem->uId, 58, 54);
    } else if (bAdd == 2) {
        m_Box1.HoldObject(pItem->uGenre, pItem->uId, 58, 54);
    } else if (bAdd == 3) {
        m_Box2.HoldObject(pItem->uGenre, pItem->uId, 58, 54);
    } else if (bAdd == 4) {
        KUiDraggedObject pObj;
        for (int i = 0; i < 2; i++) {
            for (int j = 0; j < 4; j++) {
                pObj.uId = 0;
                m_ItemBox.GetObject(pObj, i, j);
                if (pObj.uId == pItem->uId) {
                    return;
                }
                if (!pObj.uId) {
                    pItem->DataX = i;
                    pItem->DataY = j;
                    m_ItemBox.AddObject(pItem, 1);
                    return;
                }
            }
        }
    }
}

void KUiEnchaseTim::CleanItem() {
    m_BigBox.Celar();
    m_Box1.Celar();
    m_Box2.Celar();
    m_ItemBox.Clear();
}

KUiAtlas::KUiAtlas() {

}

void KUiAtlas::PaintWindow() {

}

int KUiAtlas::WndProc(unsigned int uMsg, unsigned int uParam, int nParam) {
    return 1;
}

void KUiAtlas::LoadScheme(const char *pScheme) {

}

void KUiAtlas::Initialize() {

}

void KUiAtlas::UpdateItem(KUiDraggedObject *pItem, int bAdd) {

}

int KCanGetNumImage2::GetMaxFrame() {
    return m_Image.nNumFrames;
}


int KCanGetNumImage2::GetCurrentFrame() {
    return m_Image.nFrame;
}
