/*******************************************************************************
File        : UiProgressBarLoading.cpp
Creator     : TamLTM
create data : 25-09-2020(mm-dd-yyyy)
Description : ???????
********************************************************************************/

#include "KWin32.h"
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
#include <time.h>

#include "UiTimeOnline.h"

extern iCoreShell *g_pCoreShell;

#define TREMBLE_ITEM_INI "UiTimeOnline.ini"


KUiTimeOnline *KUiTimeOnline::ms_pSelf = NULL;



//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

KUiTimeOnline::KUiTimeOnline() {
    m_nStatus = STATUS_WAITING_MATERIALS;
}

KUiTimeOnline::~KUiTimeOnline() {

}


/*********************************************************************
* ??:????
**********************************************************************/
KUiTimeOnline *KUiTimeOnline::OpenWindow(int uParam) {
    if (ms_pSelf == NULL) {
        ms_pSelf = new KUiTimeOnline;
        if (ms_pSelf)
            ms_pSelf->Initialize();
    }
    if (ms_pSelf) {
        UiSoundPlay(UI_SI_WND_OPENCLOSE);
        ms_pSelf->m_nStatus = STATUS_WAITING_MATERIALS;
        ms_pSelf->BringToTop();
        ms_pSelf->Show();
    }
    return ms_pSelf;
}


/*********************************************************************
* ??:????????,???????
**********************************************************************/
KUiTimeOnline *KUiTimeOnline::GetIfVisible() {
    if (ms_pSelf && ms_pSelf->IsVisible())
        return ms_pSelf;

    return NULL;
}


/*********************************************************************
* ??:????,??????????????
**********************************************************************/
void KUiTimeOnline::CloseWindow(bool bDestory) {
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
void KUiTimeOnline::Initialize() {
    AddChild(&m_Item);
    AddChild(&m_Confirm);
    AddChild(&m_TimeOut);
    AddChild(&m_ImgTimeOnlineEffect);
    AddChild(&m_ImgTimeOnlineEffect2);
    AddChild(&m_ImgTimeOnlineEffect3);
    AddChild(&m_ImgTimeOnlineEffect4);
    AddChild(&m_ImgTimeOnlineEffect5);
    AddChild(&m_ImgTimeOnlineEffect6);
    AddChild(&m_ImgTimeOnlineEffect7);
    AddChild(&m_ImgTimeOnlineEffect8);
    AddChild(&m_ImgTimeOnlineEffect9);
    AddChild(&m_ImgTimeOnlineEffect10);
    AddChild(&m_ImgTimeOnlineEffect11);
    AddChild(&m_ImgTimeOnlineEffect12);
    AddChild(&m_TimeOnlineYour);
    AddChild(&m_HourOnline);
    AddChild(&m_MinOnline);
    AddChild(&m_MainBoder);

    m_EffectTime = 0;

    char Scheme[256];
    g_UiBase.GetCurSchemePath(Scheme, 256);
    LoadScheme(Scheme);

    //Load time online
    m_EffectTime = 1;
    m_EffectTimeOnlineImage = 1;
    m_MinTimeOnlineInGame = 0;
    m_HourTimeOnlineInGame = 0;
    UpdateTimeOnline();
    m_TimeOut.Hide();
//	m_MainBoder.Hide();

/*	if (m_EffectTimeOnlineImage)
		m_ImgTimeOnlineEffect.SetFrame(-1);

	m_EffectTimeOnlineImage = 1;
	m_ImgTimeOnlineEffect.Show();*/
//	PlayEffect();

    //Xanh
    m_ImgTimeOnlineEffect.Hide();
    m_ImgTimeOnlineEffect2.Hide();
    m_ImgTimeOnlineEffect3.Hide();

    //Vang
    m_ImgTimeOnlineEffect4.Hide();
    m_ImgTimeOnlineEffect5.Hide();
    m_ImgTimeOnlineEffect6.Hide();

    //Cam
    m_ImgTimeOnlineEffect7.Hide();
    m_ImgTimeOnlineEffect8.Hide();
    m_ImgTimeOnlineEffect9.Hide();

    //Do
    m_ImgTimeOnlineEffect10.Hide();
    m_ImgTimeOnlineEffect11.Hide();
    m_ImgTimeOnlineEffect12.Hide();

    m_iCheckButton = false;

    Wnd_AddWindow(this);
}


/*********************************************************************
* ??:??????
**********************************************************************/
void KUiTimeOnline::LoadScheme(const char *pScheme) {
    if (ms_pSelf) {
        char Buff[128];
        KIniFile Ini;
        sprintf(Buff, "%s\\%s", pScheme, TREMBLE_ITEM_INI);
        if (Ini.Load(Buff)) {
            ms_pSelf->Init(&Ini, "Main");

            ms_pSelf->m_TimeOut.Init(&Ini, "TimeOut");
            ms_pSelf->m_TimeOnlineYour.Init(&Ini, "TimeOnlineYour");
            ms_pSelf->m_HourOnline.Init(&Ini, "HourOnline");
            ms_pSelf->m_MinOnline.Init(&Ini, "MinOnline");
            ms_pSelf->m_Item.Init(&Ini, "Item");

            //Xanh
            ms_pSelf->m_ImgTimeOnlineEffect.Init(&Ini, "TimeEffect");
            ms_pSelf->m_ImgTimeOnlineEffect2.Init(&Ini, "TimeEffect2");
            ms_pSelf->m_ImgTimeOnlineEffect3.Init(&Ini, "TimeEffect3");

            //Vang
            ms_pSelf->m_ImgTimeOnlineEffect4.Init(&Ini, "TimeEffect4");
            ms_pSelf->m_ImgTimeOnlineEffect5.Init(&Ini, "TimeEffect5");
            ms_pSelf->m_ImgTimeOnlineEffect6.Init(&Ini, "TimeEffect6");

            //cam
            ms_pSelf->m_ImgTimeOnlineEffect7.Init(&Ini, "TimeEffect7");
            ms_pSelf->m_ImgTimeOnlineEffect8.Init(&Ini, "TimeEffect8");
            ms_pSelf->m_ImgTimeOnlineEffect9.Init(&Ini, "TimeEffect9");

            //Do
            ms_pSelf->m_ImgTimeOnlineEffect10.Init(&Ini, "TimeEffect10");
            ms_pSelf->m_ImgTimeOnlineEffect11.Init(&Ini, "TimeEffect11");
            ms_pSelf->m_ImgTimeOnlineEffect12.Init(&Ini, "TimeEffect12");

            ms_pSelf->m_TimeOut.SetText("B¹n ®· v­ît qu¸ thêi gian, cã thÓ ¶nh h­ëng ®Õn søc kháe.");
            ms_pSelf->m_TimeOnlineYour.SetText("B¹n ®· online    h     phót");


            ms_pSelf->StopEffect();
            ms_pSelf->m_EffectTime = 0;
            ms_pSelf->m_EffectTimeOnlineImage = 0;

            ms_pSelf->m_HourOnline.SetText("0");
            ms_pSelf->m_MinOnline.SetText("0");

            ms_pSelf->m_Confirm.Init(&Ini, "Assemble");
            ms_pSelf->m_MainBoder.Init(&Ini, "MainBoder");

        }
    }
}


/*********************************************************************
* ??:??????
**********************************************************************/
int KUiTimeOnline::WndProc(unsigned int uMsg, unsigned int uParam, int nParam) {
    switch (uMsg) {
        case WND_N_BUTTON_CLICK:
            if (uParam == (unsigned int) &m_Confirm) {
                //	PlayEffect();
                /*	if(m_EffectTime)
                    m_TrembleEffect.SetFrame(-1);
                    m_EffectTime = 1;
                    m_TrembleEffect.Show();*/
            } else if (uParam == (unsigned int) &m_MainBoder) // An hien time online
            {
                if (m_iCheckButton == true) {
                    ms_pSelf->Hide();
                    m_TimeOut.Hide();
                    m_iCheckButton = false;
                } else {
                    ms_pSelf->Hide();
                    m_TimeOut.Show();
                    m_iCheckButton = true;
                }

                //	CloseWindow();
                //	g_DebugLog("CloseWindow m_Cancel");
            }
            break;
        default:
            return KWndImage::WndProc(uMsg, uParam, nParam);
    }

    return 1;
}


//TamLTM Convert int to string and char
template<typename T>
std::string ToString(T val) {
    std::stringstream stream;
    stream << val;
    return stream.str();
}

//TamLTM Update Percent
void KUiTimeOnline::UpdateTimeOnline() {
    time_t currentTime;

    struct tm nowLocal;

    currentTime = time(NULL);

    nowLocal = *localtime(&currentTime);

    //Min
    m_MinTimeOnlineInGame += 1;
    std::string tMin = ToString(m_MinTimeOnlineInGame); //(nowLocal.tm_min);
    char chm = ' ';
    tMin += chm;
    char const *min = tMin.c_str();  //use char const* as target type

    m_MinOnline.SetText(min);

    //Hour
//	g_DebugLog("m_MinTimeOnlineInGame 1: %d", m_MinTimeOnlineInGame);
    if (m_MinTimeOnlineInGame == 60) {
        //	g_DebugLog("m_MinTimeOnlineInGame: %d", m_MinTimeOnlineInGame);

        m_HourTimeOnlineInGame += 1;

        //	g_DebugLog("m_HourTimeOnlineInGame: %d", m_HourTimeOnlineInGame);

        std::string tHour = ToString(m_HourTimeOnlineInGame);//(nowLocal.tm_hour);
        char ch = ' ';
        tHour += ch;
        char const *hour = tHour.c_str();  //use char const* as target type

        m_HourOnline.SetText(hour);

        //Set min == 0
        m_MinTimeOnlineInGame = 0;
        m_MinOnline.SetText("0");
    }


    //Check time
    if (m_HourTimeOnlineInGame == 0 && m_MinTimeOnlineInGame == 20) {
        //Xanh
        m_ImgTimeOnlineEffect.Show();
        m_ImgTimeOnlineEffect2.Hide();
        m_ImgTimeOnlineEffect3.Hide();

        //Vang
        m_ImgTimeOnlineEffect4.Hide();
        m_ImgTimeOnlineEffect5.Hide();
        m_ImgTimeOnlineEffect6.Hide();

        //Cam
        m_ImgTimeOnlineEffect7.Hide();
        m_ImgTimeOnlineEffect8.Hide();
        m_ImgTimeOnlineEffect9.Hide();

        //Do
        m_ImgTimeOnlineEffect10.Hide();
        m_ImgTimeOnlineEffect11.Hide();
        m_ImgTimeOnlineEffect12.Hide();
    } else if (m_HourTimeOnlineInGame == 0 && m_MinTimeOnlineInGame == 45) {
        //Xanh
        m_ImgTimeOnlineEffect.Show();
        m_ImgTimeOnlineEffect2.Show();
        m_ImgTimeOnlineEffect3.Hide();

        //Vang
        m_ImgTimeOnlineEffect4.Hide();
        m_ImgTimeOnlineEffect5.Hide();
        m_ImgTimeOnlineEffect6.Hide();

        //Cam
        m_ImgTimeOnlineEffect7.Hide();
        m_ImgTimeOnlineEffect8.Hide();
        m_ImgTimeOnlineEffect9.Hide();

        //Do
        m_ImgTimeOnlineEffect10.Hide();
        m_ImgTimeOnlineEffect11.Hide();
        m_ImgTimeOnlineEffect12.Hide();
    } else if (m_HourTimeOnlineInGame == 1 && m_MinTimeOnlineInGame == 5) {
        //Xanh
        m_ImgTimeOnlineEffect.Show();
        m_ImgTimeOnlineEffect2.Show();
        m_ImgTimeOnlineEffect3.Show();

        //Vang
        m_ImgTimeOnlineEffect4.Hide();
        m_ImgTimeOnlineEffect5.Hide();
        m_ImgTimeOnlineEffect6.Hide();

        //Cam
        m_ImgTimeOnlineEffect7.Hide();
        m_ImgTimeOnlineEffect8.Hide();
        m_ImgTimeOnlineEffect9.Hide();

        //Do
        m_ImgTimeOnlineEffect10.Hide();
        m_ImgTimeOnlineEffect11.Hide();
        m_ImgTimeOnlineEffect12.Hide();
    } else if (m_HourTimeOnlineInGame == 1 && m_MinTimeOnlineInGame == 25) {
        //Xanh
        m_ImgTimeOnlineEffect.Show();
        m_ImgTimeOnlineEffect2.Show();
        m_ImgTimeOnlineEffect3.Show();

        //Vang
        m_ImgTimeOnlineEffect4.Show();
        m_ImgTimeOnlineEffect5.Hide();
        m_ImgTimeOnlineEffect6.Hide();

        //Cam
        m_ImgTimeOnlineEffect7.Hide();
        m_ImgTimeOnlineEffect8.Hide();
        m_ImgTimeOnlineEffect9.Hide();

        //Do
        m_ImgTimeOnlineEffect10.Hide();
        m_ImgTimeOnlineEffect11.Hide();
        m_ImgTimeOnlineEffect12.Hide();
    } else if (m_HourTimeOnlineInGame == 1 && m_MinTimeOnlineInGame == 45) {
        //Xanh
        m_ImgTimeOnlineEffect.Show();
        m_ImgTimeOnlineEffect2.Show();
        m_ImgTimeOnlineEffect3.Show();

        //Vang
        m_ImgTimeOnlineEffect4.Show();
        m_ImgTimeOnlineEffect5.Show();
        m_ImgTimeOnlineEffect6.Hide();

        //Cam
        m_ImgTimeOnlineEffect7.Hide();
        m_ImgTimeOnlineEffect8.Hide();
        m_ImgTimeOnlineEffect9.Hide();

        //Do
        m_ImgTimeOnlineEffect10.Hide();
        m_ImgTimeOnlineEffect11.Hide();
        m_ImgTimeOnlineEffect12.Hide();
    } else if (m_HourTimeOnlineInGame == 2 && m_MinTimeOnlineInGame == 5) {
        //Xanh
        m_ImgTimeOnlineEffect.Show();
        m_ImgTimeOnlineEffect2.Show();
        m_ImgTimeOnlineEffect3.Show();

        //Vang
        m_ImgTimeOnlineEffect4.Show();
        m_ImgTimeOnlineEffect5.Show();
        m_ImgTimeOnlineEffect6.Show();

        //Cam
        m_ImgTimeOnlineEffect7.Hide();
        m_ImgTimeOnlineEffect8.Hide();
        m_ImgTimeOnlineEffect9.Hide();

        //Do
        m_ImgTimeOnlineEffect10.Hide();
        m_ImgTimeOnlineEffect11.Hide();
        m_ImgTimeOnlineEffect12.Hide();
    } else if (m_HourTimeOnlineInGame == 2 && m_MinTimeOnlineInGame == 25) {
        //Xanh
        m_ImgTimeOnlineEffect.Show();
        m_ImgTimeOnlineEffect2.Show();
        m_ImgTimeOnlineEffect3.Show();

        //Vang
        m_ImgTimeOnlineEffect4.Show();
        m_ImgTimeOnlineEffect5.Show();
        m_ImgTimeOnlineEffect6.Show();

        //Cam
        m_ImgTimeOnlineEffect7.Show();
        m_ImgTimeOnlineEffect8.Hide();
        m_ImgTimeOnlineEffect9.Hide();

        //Do
        m_ImgTimeOnlineEffect10.Hide();
        m_ImgTimeOnlineEffect11.Hide();
        m_ImgTimeOnlineEffect12.Hide();
    } else if (m_HourTimeOnlineInGame == 2 && m_MinTimeOnlineInGame == 55) {
        //Xanh
        m_ImgTimeOnlineEffect.Show();
        m_ImgTimeOnlineEffect2.Show();
        m_ImgTimeOnlineEffect3.Show();

        //Vang
        m_ImgTimeOnlineEffect4.Show();
        m_ImgTimeOnlineEffect5.Show();
        m_ImgTimeOnlineEffect6.Show();

        //Cam
        m_ImgTimeOnlineEffect7.Show();
        m_ImgTimeOnlineEffect8.Show();
        m_ImgTimeOnlineEffect9.Hide();

        //Do
        m_ImgTimeOnlineEffect10.Hide();
        m_ImgTimeOnlineEffect11.Hide();
        m_ImgTimeOnlineEffect12.Hide();
    } else if (m_HourTimeOnlineInGame == 3 && m_MinTimeOnlineInGame == 25) {
        //Xanh
        m_ImgTimeOnlineEffect.Show();
        m_ImgTimeOnlineEffect2.Show();
        m_ImgTimeOnlineEffect3.Show();

        //Vang
        m_ImgTimeOnlineEffect4.Show();
        m_ImgTimeOnlineEffect5.Show();
        m_ImgTimeOnlineEffect6.Show();

        //Cam
        m_ImgTimeOnlineEffect7.Show();
        m_ImgTimeOnlineEffect8.Show();
        m_ImgTimeOnlineEffect9.Show();

        //Do
        m_ImgTimeOnlineEffect10.Hide();
        m_ImgTimeOnlineEffect11.Hide();
        m_ImgTimeOnlineEffect12.Hide();
    } else if (m_HourTimeOnlineInGame == 3 && m_MinTimeOnlineInGame == 45) {
        //Xanh
        m_ImgTimeOnlineEffect.Show();
        m_ImgTimeOnlineEffect2.Show();
        m_ImgTimeOnlineEffect3.Show();

        //Vang
        m_ImgTimeOnlineEffect4.Show();
        m_ImgTimeOnlineEffect5.Show();
        m_ImgTimeOnlineEffect6.Show();

        //Cam
        m_ImgTimeOnlineEffect7.Show();
        m_ImgTimeOnlineEffect8.Show();
        m_ImgTimeOnlineEffect9.Show();

        //Do
        m_ImgTimeOnlineEffect10.Show();
        m_ImgTimeOnlineEffect11.Hide();
        m_ImgTimeOnlineEffect12.Hide();

        m_TimeOut.Show();
        m_MainBoder.Show();
        m_iCheckButton = true;
    } else if (m_HourTimeOnlineInGame == 4 && m_MinTimeOnlineInGame == 25) {
        //Xanh
        m_ImgTimeOnlineEffect.Show();
        m_ImgTimeOnlineEffect2.Show();
        m_ImgTimeOnlineEffect3.Show();

        //Vang
        m_ImgTimeOnlineEffect4.Show();
        m_ImgTimeOnlineEffect5.Show();
        m_ImgTimeOnlineEffect6.Show();

        //Cam
        m_ImgTimeOnlineEffect7.Show();
        m_ImgTimeOnlineEffect8.Show();
        m_ImgTimeOnlineEffect9.Show();

        //Do
        m_ImgTimeOnlineEffect10.Show();
        m_ImgTimeOnlineEffect11.Show();
        m_ImgTimeOnlineEffect12.Hide();
    } else if (m_HourTimeOnlineInGame == 5 && m_MinTimeOnlineInGame == 0) {
        //Xanh
        m_ImgTimeOnlineEffect.Show();
        m_ImgTimeOnlineEffect2.Show();
        m_ImgTimeOnlineEffect3.Show();

        //Vang
        m_ImgTimeOnlineEffect4.Show();
        m_ImgTimeOnlineEffect5.Show();
        m_ImgTimeOnlineEffect6.Show();

        //Cam
        m_ImgTimeOnlineEffect7.Show();
        m_ImgTimeOnlineEffect8.Show();
        m_ImgTimeOnlineEffect9.Show();

        //Do
        m_ImgTimeOnlineEffect10.Show();
        m_ImgTimeOnlineEffect11.Show();
        m_ImgTimeOnlineEffect12.Show();

        m_TimeOut.Show();
        m_MainBoder.Show();
        m_iCheckButton = true;
    }

//	g_DebugLog("Runtime tm_hour: %d", nowLocal.tm_hour);
//	g_DebugLog("Runtime min: %d", nowLocal.tm_min);
}

//end code

/*********************************************************************
* ??:????
**********************************************************************/
void KUiTimeOnline::Breathe() {
    if (m_EffectTime)
        m_EffectTime++;

    if (m_ImgTimeOnlineEffect.IsVisible())
        m_ImgTimeOnlineEffect.NextFrame();

    if (m_EffectTimeOnlineImage)
        m_EffectTimeOnlineImage++;

    //m_EffectTime >= 850
    if (m_EffectTime >= 810) {
        UpdateTimeOnline();
        m_EffectTime = 1;

        //	g_DebugLog("KUiTimeOnline::Breathe()");
    }

    if (m_EffectTimeOnlineImage == (m_ImgTimeOnlineEffect.GetMaxFrame() + 2)) // Lap lai x * 2
    {
        //	g_DebugLog("CloseWindow");
        //	StopEffect();
        //	m_EffectTimeOnlineImage = 0; // Set 0 ve vi tri bang dau
        //	m_ImgTimeOnlineEffect.SetFrame(-1); // Set -1 ve vi tri bang dau
        //	CloseWindow();
        //	g_pCoreShell->OperationRequest(GOI_CP_LOAD_SCRIPT_PROGRESS_BAR, 1, 0); // Load script
    }

    //g_DebugLog("KUiTimeOnline::Breathe()");
}


/*********************************************************************
* ??:????
**********************************************************************/
int KUiTimeOnline::PlayEffect() {
    if (m_ImgTimeOnlineEffect.GetMaxFrame() == 0 ||
        m_ImgTimeOnlineEffect.GetMaxFrame() >= m_ImgTimeOnlineEffect.GetCurrentFrame() - 1) {
        m_ImgTimeOnlineEffect.SetFrame(0);
        m_ImgTimeOnlineEffect.Show();
        g_DebugLog("KUiTimeOnline SetFrame %d", m_ImgTimeOnlineEffect.GetCurrentFrame() - 1);
        return 0;
    } else {
        m_ImgTimeOnlineEffect.NextFrame();
        g_DebugLog("KUiTimeOnline SetFrame %d", m_ImgTimeOnlineEffect.NextFrame());
        return 1;
    }

}

void KUiTimeOnline::StopEffect() {
    m_ImgTimeOnlineEffect.Hide();

//	KUiComItem* pSelf =  KUiComItem::GetIfVisible();

    KUiDraggedObject pObj;
    pObj.uId = 0;
//	pSelf->ComItem((unsigned int)(&pUP),m_nSelect,3);
}


/*********************************************************************
* ??:?????????
**********************************************************************/
void KUiTimeOnline::UpdateResult() {

}

int KCanGetNumTimeImage::GetMaxFrame() {
//	g_DebugLog("m_Image.nNumFrames %d", m_Image.nNumFrames);
    return m_Image.nNumFrames;
}


int KCanGetNumTimeImage::GetCurrentFrame() {
    return m_Image.nFrame;
}


void KUiTimeOnline::UpdateDataCompound() {
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

void KUiTimeOnline::OnCancel(bool bDestory) {
/*	if (bDestory)
	{
		for (int i=0; i< compound_itempart_num; i++)
		{
			m_CompoundBox[i].Celar();
		}
	}*/
}
