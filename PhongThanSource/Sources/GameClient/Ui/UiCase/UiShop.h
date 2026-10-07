// -------------------------------------------------------------------------
//	�ļ���		��	UiTrade.h
//	������		��	Wooy(Wu yue)
//	����ʱ��	��	2002-12-21
//	��������	��	npc����ϵͳ����
// -------------------------------------------------------------------------
#pragma once

#include "../Elem/WndShowAnimate.h"
#include "../elem/wndbutton.h"
#include "../Elem/WndText.h"
#include "../elem/wndObjContainer.h"

struct KUiObjAtContRegion;

class KUiShop : protected KWndShowAnimate {
public:
    //----�������ͳһ�Ľӿں���----
    static KUiShop *OpenWindow();                //�򿪴��ڣ�����Ψһ��һ�������ʵ��
    static KUiShop *GetIfVisible();                //�������������ʾ���򷵻�ʵ��ָ��
    static void CloseWindow();                //�رմ��ڣ�ͬʱ����ѡ���Ƿ�ɾ������ʵ��
    static void LoadScheme(const char *pScheme);    //������淽��
    static void CancelTrade();

    void UpdateData();

    void UpdateItem(KUiObjAtContRegion *pItem, int bAdd);

    int WndProc(unsigned int uMsg, unsigned int uParam, int nParam);//���ں���
private:
    KUiShop();

    ~KUiShop() {}

    void SetPage(int nIndex);

    void Clear();

    void OnClickButton(KWndButton *pWnd, int bCheck);

    void Breathe();

    void OnBuyItem(KUiDraggedObject *pItem, bool bDoImmed);

    void Initialize();                        //��ʼ��
private:
    static KUiShop *m_pSelf;
private:
    KUiObjAtContRegion *m_pObjsList;
    int m_nObjCount;
    int m_nPageCount;
    int m_nCurrentPage;
    KWndObjectMatrix m_ItemsBox;        //��Ʒ��
    KWndButton m_BuyBtn;
    KWndButton m_SellBtn;
    KWndButton m_RepairBtn;
    KWndButton m_PreBtn;
    KWndButton m_NextBtn;
    KWndButton m_CloseBtn;
};
