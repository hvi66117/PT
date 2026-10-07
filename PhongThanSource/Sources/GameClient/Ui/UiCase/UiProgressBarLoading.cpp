/*******************************************************************************
File        : UiProgressBarLoading.cpp
Creator     : TamLTM
create data : 25-09-2020(mm-dd-yyyy)
Description : ???????
********************************************************************************/

#include "KWin32.h"
#ifdef PHONGTHAN_MODERN_BUILD
#include <winsock2.h>
#endif
#include "KIniFile.h"
#include "CoreShell.h"
#include "GameDataDef.h"
#include "../Elem/MouseHover.h"
#include "../elem/wnds.h"
#include "../Elem/WndMessage.h"
#include "../UiBase.h"
#include "../UiSoundSetting.h"
#include "../../../core/src/coreshell.h"
#include "../../../Engine/Src/KDebug.h"
#include <string>
#include <sstream>

#include "UiProgressBarLoading.h"

extern iCoreShell *g_pCoreShell;

#define TREMBLE_ITEM_INI "UiProgressBarLoading.ini"


KUiProgressBarLoading *KUiProgressBarLoading::ms_pSelf = NULL;

//TamLTM Get index PC Name
int m_GetIndexPCName;

//Delay animation
int countIndexAnimation = 1;

//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

KUiProgressBarLoading::KUiProgressBarLoading() {
    m_nStatus = STATUS_WAITING_MATERIALS;
}

KUiProgressBarLoading::~KUiProgressBarLoading() {

}


/*********************************************************************
* ??:????
**********************************************************************/
KUiProgressBarLoading *KUiProgressBarLoading::OpenWindow(int uParam) {
    if (ms_pSelf == NULL) {
        ms_pSelf = new KUiProgressBarLoading;
        if (ms_pSelf)
            ms_pSelf->Initialize();
    }
    if (ms_pSelf) {
        UiSoundPlay(UI_SI_WND_OPENCLOSE);
        ms_pSelf->m_nStatus = STATUS_WAITING_MATERIALS;
        ms_pSelf->BringToTop();
        ms_pSelf->Show();
        IndexLoadKeyPcName(uParam);
    }

    return ms_pSelf;
}


/*********************************************************************
* ??:????????,???????
**********************************************************************/
KUiProgressBarLoading *KUiProgressBarLoading::GetIfVisible() {
    if (ms_pSelf && ms_pSelf->IsVisible())
        return ms_pSelf;

    return NULL;
}


/*********************************************************************
* ??:????,??????????????
**********************************************************************/
void KUiProgressBarLoading::CloseWindow(bool bDestory) {
    if (ms_pSelf) {
        ms_pSelf->Hide();
        if (bDestory) {
            ms_pSelf->Destroy();
            ms_pSelf = NULL;
        }
    }
}


/*********************************************************************
* ??:???
**********************************************************************/
void KUiProgressBarLoading::Initialize() {
    AddChild(&m_GemSpirit);
    AddChild(&m_GemWater);
    AddChild(&m_GemEarth);
    AddChild(&m_GemLevel);
    AddChild(&m_GemFire);
    AddChild(&m_GemGold);
    AddChild(&m_GemWood);
    AddChild(&m_Item);
    AddChild(&m_Confirm);
    AddChild(&m_MainBoder);
    AddChild(&m_TrembleEffect);
    AddChild(&m_LoadingProgress);
    AddChild(&m_LoadingProgressPercent);

    m_EffectTime = 0;

    char Scheme[256];
    g_UiBase.GetCurSchemePath(Scheme, 256);
    LoadScheme(Scheme);

    //Loading progress bar
    LoadProgressBarLoading();


    Wnd_AddWindow(this);
}


/*********************************************************************
* ??:??????
**********************************************************************/
void KUiProgressBarLoading::LoadScheme(const char *pScheme) {
    if (ms_pSelf) {
        char Buff[128];
        KIniFile Ini;
        sprintf(Buff, "%s\\%s", pScheme, TREMBLE_ITEM_INI);
        if (Ini.Load(Buff)) {
            ms_pSelf->Init(&Ini, "Main");

            ms_pSelf->m_LoadingProgress.Init(&Ini, "LoadingProgress");
            ms_pSelf->m_LoadingProgressPercent.Init(&Ini, "LoadingProgressPercent");
            ms_pSelf->m_Item.Init(&Ini, "Item");
            ms_pSelf->m_GemGold.Init(&Ini, "GemGold");
            ms_pSelf->m_GemWood.Init(&Ini, "GemWood");
            ms_pSelf->m_GemWater.Init(&Ini, "GemWater");
            ms_pSelf->m_GemFire.Init(&Ini, "GemFire");
            ms_pSelf->m_GemEarth.Init(&Ini, "GemEarth");
            ms_pSelf->m_GemLevel.Init(&Ini, "GemLevel");
            ms_pSelf->m_GemSpirit.Init(&Ini, "GemSpirit");
            ms_pSelf->m_TrembleEffect.Init(&Ini, "Effect");
            ms_pSelf->m_LoadingProgress.SetText("§ang tiÕn tr×nh...");

            ms_pSelf->StopEffect();
            ms_pSelf->m_EffectTime = 0;
            ms_pSelf->m_AddPercent = 0;
            ms_pSelf->m_SetTimeUpdateFrame = 1;

            ms_pSelf->m_LoadingProgressPercent.SetText("0%");

            ms_pSelf->m_Confirm.Init(&Ini, "Assemble");
            ms_pSelf->m_MainBoder.Init(&Ini, "MainBoder");

        }
    }
}


/*********************************************************************
* ??:??????
**********************************************************************/
int KUiProgressBarLoading::WndProc(unsigned int uMsg, unsigned int uParam, int nParam) {
    switch (uMsg) {
        case WND_N_BUTTON_CLICK:
            if (uParam == (unsigned int) &m_Confirm) {
                //	PlayEffect();
                /*	if(m_EffectTime)
                    m_TrembleEffect.SetFrame(-1);
                    m_EffectTime = 1;
                    m_TrembleEffect.Show();*/
            } else if (uParam == (unsigned int) &m_MainBoder) {
                //	CloseWindow();
                //	g_DebugLog("CloseWindow m_Cancel");
            }
            break;
        case WM_LBUTTONDOWN: {
            //	g_DebugLog("WM_LBUTTONDOWN");
            /*		StopEffect();
                    m_EffectTime = 0; // Set 0 ve vi tri bang dau
                    m_TrembleEffect.SetFrame(-1); // Set -1 ve vi tri bang dau
                    CloseWindow(); //*/
        }
        case WM_RBUTTONDOWN: {
            //	g_DebugLog("WM_RBUTTONDOWN");
            /*	StopEffect();
                m_EffectTime = 0; // Set 0 ve vi tri bang dau
                m_TrembleEffect.SetFrame(-1); // Set -1 ve vi tri bang dau
                CloseWindow(); //*/
        }
            break;
        case VK_LBUTTON: {
            //	g_DebugLog("VK_LBUTTON");
            /*	StopEffect();
                m_EffectTime = 0; // Set 0 ve vi tri bang dau
                m_TrembleEffect.SetFrame(-1); // Set -1 ve vi tri bang dau
                CloseWindow();//*/
        }
            break;
        default:
            return KWndImage::WndProc(uMsg, uParam, nParam);
    }

    return 1;
}

//TamLTM LoadProgressBarLoading
void KUiProgressBarLoading::LoadProgressBarLoading() {
    if (m_EffectTime)
        m_TrembleEffect.SetFrame(-1);

    m_EffectTime = 1;
    m_AddPercent = 1;

    m_TrembleEffect.Show();
}

//TamLTM Convert int to string and char
template<typename T>
std::string ToString(T val) {
    std::stringstream stream;
    stream << val;
    return stream.str();
}

//TamLTM Update Percent
void KUiProgressBarLoading::UpdatePercent(int percent, int addPercent) {
    //m_TrembleEffect.GetMaxFrame() 130
    m_PercentNew = (percent * 100) / 130; // -5 la so du cua phan tram percent 105 - 5 = 100%
    std::string s = ToString(m_PercentNew);
    char ch = '%';
    s += ch;
    char const *totalPercent = s.c_str();  //use char const* as target type

    m_LoadingProgressPercent.SetText(totalPercent);
}

//end code

/*********************************************************************
* ??:????
**********************************************************************/
void KUiProgressBarLoading::Breathe() {
    if (m_nStatus == STATUS_BEGIN_TREMBLE) {
        m_TrembleEffect.Show();
        m_TrembleEffect.SetFrame(0);
        m_nStatus = STATUS_TREMBLING;
    } else if (m_nStatus == STATUS_TREMBLING) {
        if (!PlayEffect()) {
            m_nStatus = STATUS_CHANGING_ITEM;
            m_TrembleEffect.Hide();
        }
    } else if (m_nStatus == STATUS_CHANGING_ITEM) {
        UpdateResult();
        m_nStatus = STATUS_FINISH;
    }

//	Sleep(50);

    if (m_SetTimeUpdateFrame)
        m_SetTimeUpdateFrame++;

    if (m_SetTimeUpdateFrame == 4) {
        m_SetTimeUpdateFrame = 1;
        return;
    }

    //Tinh phan tram cua loading
    countIndexAnimation++;
    if (countIndexAnimation == 2) {
        if (m_TrembleEffect.IsVisible())
            m_TrembleEffect.NextFrame();

        if (m_EffectTime)
            m_EffectTime++;

        countIndexAnimation = 1;

        if (m_AddPercent)
            m_AddPercent++;

        UpdatePercent(m_EffectTime, m_AddPercent);
    }
    //end code

//	g_DebugLog("m_GetIndexPCName %d ", m_GetIndexPCName);

    if (m_EffectTime == (m_TrembleEffect.GetMaxFrame())) // Lap lai x * 2
    {
        //	g_DebugLog("CloseWindow");
        StopEffect();
        m_EffectTime = 0; // Set 0 ve vi tri bang dau
        m_AddPercent = 0;
        m_TrembleEffect.SetFrame(-1); // Set -1 ve vi tri bang dau
        CloseWindow();

        if (m_GetIndexPCName == 1) {
            g_pCoreShell->OperationRequest(GOI_CP_LOAD_SCRIPT_PROGRESS_BAR, 1, 0); // Load script
        }
//		else if (m_GetIndexPCName == 2)
//		{
//			GetPCName(); //Name pc
//		}
    }

    if (m_GetIndexPCName == 2) {
        StopEffect();
        m_EffectTime = 0; // Set 0 ve vi tri bang dau
        m_TrembleEffect.SetFrame(-1); // Set -1 ve vi tri bang dau
        CloseWindow();
    }
}


/*********************************************************************
* ??:????
**********************************************************************/
int KUiProgressBarLoading::PlayEffect() {
    if (m_TrembleEffect.GetMaxFrame() == 0 ||
        m_TrembleEffect.GetMaxFrame() >= m_TrembleEffect.GetCurrentFrame() - 1) {
        m_TrembleEffect.SetFrame(0);
        return 0;
    } else {
        m_TrembleEffect.NextFrame();
        return 1;
    }

}

void KUiProgressBarLoading::StopEffect() {
    m_TrembleEffect.Hide();

//	KUiComItem* pSelf =  KUiComItem::GetIfVisible();

    KUiDraggedObject pObj;
    unsigned int pUP[3];

    m_GemGold.GetObject(pObj);
    if (pObj.uId > 0) {
        pUP[0] = pObj.uId;
    } else {
        return;
    }
    pObj.uId = 0;
//	pSelf->ComItem((unsigned int)(&pUP),m_nSelect,3);
}


/*********************************************************************
* ??:?????????
**********************************************************************/
void KUiProgressBarLoading::UpdateResult() {

}

int KCanGetNumBarImage::GetMaxFrame() {
//	g_DebugLog("m_Image.nNumFrames %d", m_Image.nNumFrames);
    return m_Image.nNumFrames;
}


int KCanGetNumBarImage::GetCurrentFrame() {
    return m_Image.nFrame;
}


void KUiProgressBarLoading::UpdateDataCompound() {
/*	KUiObjAtRegion	Equips[compound_itempart_num];
	int nCount = g_pCoreShell->GetGameData(GDI_COMPOUND, (unsigned int)&Equips, 0);
	for (int i = 0; i < compound_itempart_num; i++)
		m_Item.Celar();
	for (i = 0; i < nCount; i++)
	{
		if (Equips[i].Obj.uGenre != CGOG_NOTHING)
			UpdateItemCompound(&Equips[i], true);
	}*/
}

void KUiProgressBarLoading::OnCancel(bool bDestory) {
/*	if (bDestory)
	{
		for (int i=0; i< compound_itempart_num; i++)
		{
			m_CompoundBox[i].Celar();
		}
	}*/
}

#include <limits.h>
#include <windows.h>

//Load Get PC Name Client
void KUiProgressBarLoading::GetPCName() {
    //Get host name
    WSADATA wsa_data;
    /* Load Winsock 2.0 DLL */
    if (WSAStartup(MAKEWORD(2, 0), &wsa_data) != 0) {
        //"WSAStartup() failed"
        return;
    }

    char myhostname[256];
    int rc = gethostname(myhostname, sizeof myhostname);

    g_DebugLog("myhostname %s", myhostname);

    g_pCoreShell->OperationRequest(GOI_CP_LOAD_SCRIPT_PROGRESS_BAR, (unsigned int) myhostname, 0); // Load script
//	g_DebugLog("(unsigned int)myhostname %s: ", (unsigned int)myhostname);

    /* Cleanup Winsock */
    WSACleanup();
}

int KUiProgressBarLoading::IndexLoadKeyPcName(int uParam) {
    m_GetIndexPCName = uParam;
    return m_GetIndexPCName;
}
//end code
