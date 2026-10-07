/*******************************************************************************
File        : UiTimeOnline.h
Creator     : Fyt(TamLTM)
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

class KCanGetNumTimeImage : public KWndImage {
public:
    int GetMaxFrame();

    int GetCurrentFrame();
};

class KUiTimeOnline : public KWndImage {
public:
    KUiTimeOnline();

    virtual ~KUiTimeOnline();

    static KUiTimeOnline *OpenWindow(int uParam);      //????
    static KUiTimeOnline *GetIfVisible();    //????????,???????
    static void CloseWindow(bool bDestory = TRUE); //????,??????????????
    static void LoadScheme(const char *pScheme);   //??????

private:
    static KUiTimeOnline *ms_pSelf;

private:
    void Initialize();

    virtual int WndProc(unsigned int uMsg, unsigned int uParam, int nParam);

    virtual void Breathe();

//	virtual void	  LoadProgressBarLoading();
    void UpdateTimeOnline();

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
    KWndObjectBox m_Item;                            //?????
//	KWndObjectBox m_CompoundBox[compound_itempart_num];

    KWndText256 m_TimeOnlineYour;    // Hien thi text your
    KWndText256 m_HourOnline;        // Hien thi thoi gian
    KWndText256 m_MinOnline;
    KWndText256 m_TimeOut;            // Thoi gian qua' gioi hang 5h choi


    bool m_iCheckButton;

    KWndButton m_Confirm;                         //????

    KWndButton m_MainBoder;                       //Main
    int m_EffectTime;
    int m_HourTimeOnlineInGame;
    int m_MinTimeOnlineInGame;
    int m_EffectTimeOnlineImage;


    //Xanh
    KCanGetNumTimeImage m_ImgTimeOnlineEffect;                   //??????
    KCanGetNumTimeImage m_ImgTimeOnlineEffect2;
    KCanGetNumTimeImage m_ImgTimeOnlineEffect3;

    //Vang
    KCanGetNumTimeImage m_ImgTimeOnlineEffect4;
    KCanGetNumTimeImage m_ImgTimeOnlineEffect5;
    KCanGetNumTimeImage m_ImgTimeOnlineEffect6;

    //Cam
    KCanGetNumTimeImage m_ImgTimeOnlineEffect7;
    KCanGetNumTimeImage m_ImgTimeOnlineEffect8;
    KCanGetNumTimeImage m_ImgTimeOnlineEffect9;

    //Do
    KCanGetNumTimeImage m_ImgTimeOnlineEffect10;
    KCanGetNumTimeImage m_ImgTimeOnlineEffect11;
    KCanGetNumTimeImage m_ImgTimeOnlineEffect12;

private:
    int m_nStatus;                         //?????????
};

#endif // !defined(AFX_UITREMBLEITEM_H__69079BE2_10C3_4AA0_A3C2_190285964E36__INCLUDED_)
