/*******************************************************************************
File        : UiTrembleItem.h
Creator     : Fyt(Fan Zhanpeng)
create data : 09-08-2003(mm-dd-yyyy)
Description : ???????
********************************************************************************/

#if !defined(AFX_UITREMBLEITEM_H__69079BE2_10C3_4AA0_A3C2_190285964E36__INCLUDED_)
#define AFX_UITREMBLEITEM_H__69079BE2_10C3_4AA0_A3C2_190285964E36__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

#include "../elem/wndobjcontainer.h"
#include "../elem/wndbutton.h"
#include "../elem/wndimage.h"

#define HOST_NAME_MAX 256
#define LOGIN_NAME_MAX 256

class KCanGetNumBarImage : public KWndImage {
public:
    int GetMaxFrame();

    int GetCurrentFrame();
};

class KUiProgressBarLoading : public KWndImage {
public:
    KUiProgressBarLoading();

    virtual ~KUiProgressBarLoading();

    static KUiProgressBarLoading *OpenWindow(int uParam);      //????
    static KUiProgressBarLoading *GetIfVisible();    //????????,???????
    static void CloseWindow(bool bDestory = TRUE); //????,??????????????
    static void LoadScheme(const char *pScheme);   //??????

    //Get Id number
    static int IndexLoadKeyPcName(int uParam);

private:
    static KUiProgressBarLoading *ms_pSelf;

private:
    void Initialize();

    virtual int WndProc(unsigned int uMsg, unsigned int uParam, int nParam);

    virtual void Breathe();

    virtual void LoadProgressBarLoading();

    void UpdatePercent(int percent, int addPercent);

    void GetPCName(); // Game PC Name

private:
    void ApplyAssemble();                   //?Core?????????
    void ResultReturn();                    //??????
    int PlayEffect();                      //????
    void UpdateResult();                    //?????????
    void StopEffect();

    void UpdateDataCompound();

    void OnCancel(bool bDestory = TRUE);

private:
    enum THIS_INTERFACE_STATUS {
        STATUS_WAITING_MATERIALS,
        STATUS_BEGIN_TREMBLE,
        STATUS_TREMBLING,
        STATUS_CHANGING_ITEM,
        STATUS_FINISH,
    };

private:
    KWndObjectBox m_GemSpirit;                       //??????
    KWndObjectBox m_GemWater;                        //???????
    KWndObjectBox m_GemEarth;                        //???????
    KWndObjectBox m_GemLevel;                        //??????
    KWndObjectBox m_GemFire;                         //???????
    KWndObjectBox m_GemGold;                         //???????
    KWndObjectBox m_GemWood;                         //???????
    KWndObjectBox m_Item;                            //?????
//	KWndObjectBox m_CompoundBox[compound_itempart_num];

    KWndText256 m_LoadingProgress;                // Hien thi dang tien trinh
    KWndText256 m_LoadingProgressPercent;                // Hien thi dang tien trinh phan %

    KWndButton m_Confirm;                         //????

    KWndButton m_MainBoder;                       //Main
    int m_EffectTime;

    // Tinh toan phan tram
    int m_PercentNew;
    int m_AddPercent;
    int m_SetTimeUpdateFrame;

    KCanGetNumBarImage m_TrembleEffect;                   //??????

private:
    int m_nStatus;                         //?????????
};

#endif // !defined(AFX_UITREMBLEITEM_H__69079BE2_10C3_4AA0_A3C2_190285964E36__INCLUDED_)
