/*****************************************************************************************
//	界面--窗口
//	Copyright : Kingsoft 2002
//	Author	:   Wooy(Wu yue)
//	CreateTime:	2002-8-28
------------------------------------------------------------------------------------------
*****************************************************************************************/
#pragma once

#include "../elem/wndpage.h"
#include "../Elem/WndImagePart.h"
#include "../elem/wndbutton.h"
#include "../elem/wndtext.h"
#include "../elem/WndObjContainer.h"

#include "../elem/wndlabeledbutton.h"
#include "../elem/wndscrollbar.h"
#include "../elem/wndimage.h"
#include "../elem/wndlist2.h"
#include "../Elem/WndMessageListBox.h"

#include "../../../core/src/gamedatadef.h"

class KCanGetNumImage2 : public KWndImage {
public:
    int GetMaxFrame();

    int GetCurrentFrame();
};

class KUiAtlas : public KWndPage {
public:
    KUiAtlas();

    void Initialize();                                //初始化
    void LoadScheme(const char *pScheme);            //载入界面方案

    void UpdateItem(KUiDraggedObject *pItem, int bAdd);

private:
    int WndProc(unsigned int uMsg, unsigned int uParam, int nParam);//窗口函数
    void PaintWindow();                                //绘制窗口
private:
    KWndObjectBox m_Box1;
    KWndObjectBox m_Box2;
    KWndObjectBox m_Box3;
    KWndText256 m_Guide;

    KWndScrollBar m_ListScroll;                      //列表的滚动条
    //KWndButton		m_ListBtn;
    KWndButton m_Compound;
    KWndButton m_Cancle;

    KCanGetNumImage2
            m_TrembleEffect1;                   //合成中的特效
    KCanGetNumImage2
            m_TrembleEffect2;                   //合成中的特效
    KCanGetNumImage2
            m_TrembleEffect3;                   //合成中的特效
};

class KUiEnchaseTim : public KWndPage {
public:
    KUiEnchaseTim();

    void Initialize();                                //初始化
    void LoadScheme(const char *pScheme);            //载入界面方案

    void UpdateItem(KUiDraggedObject *pItem, int bAdd);

    void CleanItem();

private:
    int WndProc(unsigned int uMsg, unsigned int uParam, int nParam);//窗口函数
    void PaintWindow();                                //绘制窗口
private:
    KWndObjectBox m_BigBox;
    KWndObjectBox m_Box1;
    KWndObjectBox m_Box2;
    KWndObjectMatrix m_ItemBox;
    KWndMessageListBox m_Guide;
    KWndText32 m_Pos1;
    KWndText32 m_Pos2;
    KWndText32 m_Pos3;
    KWndText32 m_Pos4;

    KWndScrollBar m_ListScroll;                      //列表的滚动条
    KWndButton m_ListBtn;
    KWndButton m_Distill;
    KWndButton m_Cancle;

    KCanGetNumImage2
            m_TrembleEffect1;                   //合成中的特效
    KCanGetNumImage2
            m_TrembleEffect2;                   //合成中的特效
    KCanGetNumImage2
            m_TrembleEffect3;                   //合成中的特效
};

class KUiForge : public KWndPage {
public:
    KUiForge();

    void Initialize();                                //初始化
    void LoadScheme(const char *pScheme);            //载入界面方案

    void UpdateItem(KUiDraggedObject *pItem, int bAdd);

    void CleanItem();

private:
    int WndProc(unsigned int uMsg, unsigned int uParam, int nParam);//窗口函数
    void PaintWindow();                                //绘制窗口
private:
    KWndObjectBox m_BigBox;
    KWndObjectBox m_SmallBox;
    KWndMessageListBox m_Guide;
    KWndText32 m_Pos1;
    KWndText32 m_Pos2;

    KWndScrollBar m_ListScroll;                      //列表的滚动条
    KWndButton m_ListBtn;
    KWndButton m_ForgeBtn;
    KWndButton m_Cancle;

    KCanGetNumImage2
            m_TrembleEffect1;                   //合成中的特效
};

class KUiDistill : public KWndPage {
public:
    KUiDistill();

    void Initialize();                                //初始化
    void LoadScheme(const char *pScheme);            //载入界面方案

    void UpdateItem(KUiDraggedObject *pItem, int bAdd);

    void CleanItem();

private:
    int WndProc(unsigned int uMsg, unsigned int uParam, int nParam);//窗口函数
    void PaintWindow();                                //绘制窗口
private:
    KWndObjectBox m_BigBox;
    KWndObjectBox m_Box1;
    KWndObjectBox m_Box2;
    KWndObjectMatrix m_ItemBox;
    KWndMessageListBox m_Guide;
    KWndText32 m_Pos1;
    KWndText32 m_Pos2;
    KWndText32 m_Pos3;
    KWndText32 m_Pos4;

    KWndScrollBar m_ListScroll;                      //列表的滚动条
    KWndButton m_ListBtn;
    KWndButton m_Distill;
    KWndButton m_Cancle;

    KCanGetNumImage2
            m_TrembleEffect1;                   //合成中的特效
    KCanGetNumImage2
            m_TrembleEffect2;                   //合成中的特效
    KCanGetNumImage2
            m_TrembleEffect3;                   //合成中的特效
};

class KUiCompound : public KWndPage {
public:
    KUiCompound();

    void Initialize();                                //初始化
    void LoadScheme(const char *pScheme);            //载入界面方案

    void UpdateItem(KUiDraggedObject *pItem, int bAdd);

    void SetPosText(int i = 1);

    void CleanItem();

private:
    int WndProc(unsigned int uMsg, unsigned int uParam, int nParam);//窗口函数
    void PaintWindow();

    virtual void Breathe();

    int PlayEffect();

    int m_nStatus;

    void UpdateResult();

private:
    KWndObjectBox m_Box1;
    KWndObjectBox m_Box2;
    KWndObjectBox m_Box3;
    KWndMessageListBox m_Guide;
    KWndText32 m_Pos1;
    KWndText32 m_Pos2;
    KWndText32 m_Pos3;

    int m_nSelect;

    KWndScrollBar m_ListScroll;                      //列表的滚动条
    KWndButton m_ListBtn;
    KWndButton m_Compound;
    KWndButton m_Cancle;

    KCanGetNumImage2
            m_TrembleEffect1;                   //合成中的特效
    KCanGetNumImage2
            m_TrembleEffect2;                   //合成中的特效
    KCanGetNumImage2
            m_TrembleEffect3;                   //合成中的特效
private:
    enum THIS_INTERFACE_STATUS {
        STATUS_WAITING_MATERIALS,
        STATUS_BEGIN_TREMBLE,
        STATUS_TREMBLING,
        STATUS_CHANGING_ITEM,
        STATUS_FINISH,
    };

};

class KUiComItem : public KWndPageSet {
public:
    static KUiComItem *OpenWindow();                            //打开窗口，返回唯一的一个类对象实例
    static KUiComItem *GetIfVisible();                        //如果窗口正被显示，则返回实例指针
    static void CloseWindow(bool bDestory = TRUE);            //关闭窗口，同时可以选则是否删除对象实例
    static void LoadScheme(const char *pScheme);        //载入界面方案
    static void ShowWindow(int nNum = 0);

    void UpdateItem(KUiObjAtRegion *pItem, int bAdd);

    int GetWindowsNum();

    void CleanItem();

    void ComItem(unsigned int pItem, int nWindowNum, int nNum);

private:
    KUiComItem() {}

    ~KUiComItem() {}

    void Initialize();                            //初始化
    int WndProc(unsigned int uMsg, unsigned int uParam, int nParam);//窗口函数

    virtual void Breathe();

    int PlayEffect();

private:
    static KUiComItem *m_pSelf;
private:

    enum THIS_INTERFACE_STATUS {
        STATUS_WAITING_MATERIALS,
        STATUS_BEGIN_TREMBLE,
        STATUS_TREMBLING,
        STATUS_CHANGING_ITEM,
        STATUS_FINISH,
    };

    enum THIS_WINDOWS {
        WINDOWS_COMP,
        WINDOWS_COMP2,
        WINDOWS_COMP3,
        WINDOWS_DISTill,
        WINDOWS_FORG,
        WINDOWS_ENCHASE,
        WINDOWS_ATLAS,
    };

    KUiCompound m_CompoundPad;
    KUiDistill m_DistillPad;
    KUiForge m_ForgePad;
    KUiEnchaseTim m_EnchasePad;
    KUiAtlas m_AtlasPad;

    KWndButton m_CompoundPadBtn;
    KWndButton m_DistillPadBtn;
    KWndButton m_ForgePadBtn;
    KWndButton m_EnchasePadBtn;
    KWndButton m_AtlasPadBtn;
    KWndButton m_UpCryoliteBtn;
    KWndButton m_UpPropMineBtn;
    KWndButton m_Close;
    KWndText32 m_CheTao;


private:
    int m_nStatus;                         //当前界面所处的状态
    int m_nNum;
};
