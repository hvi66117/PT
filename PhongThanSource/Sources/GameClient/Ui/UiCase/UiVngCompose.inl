#include "PhongThanCompose.h"
#include "PhongThanNativeUiLayout.h"
// Original VNG nine-slot compose layout. Kept separate from purple-item
// forging: that older path consumes different item schemas and must not run.
class KUiVngCompose : public KWndShowAnimate
{
    KWndButton m_Close, m_Combine;
    KWndObjectBox m_Slots[9];
    KWndText256 m_Info;
    KWndText80 m_Cost;
    DWORD m_RequestStarted;
    bool m_Waiting;
    static KUiVngCompose* s_Window;
public:
    static bool PutInventoryItem(const KUiDraggedObject* item)
    {
        if(!s_Window || !s_Window->IsVisible() || !item || !g_pCoreShell)
            return false;
        if(item->uGenre!=CGOG_ITEM || !item->uId)
            return true;
        if(s_Window->m_Waiting)
        {
            s_Window->m_Info.SetText("Dang xu ly. Hay cho ket qua truoc khi dat them vat pham.");
            return true;
        }

        KUiObjAtRegion current[9];ZeroMemory(current,sizeof(current));
        g_pCoreShell->GetGameData(GDI_BUILD_ITEM,(unsigned int)current,0);
        int freeSlot=-1;
        for(int i=0;i<9;++i)
            if(current[i].Obj.uGenre==CGOG_NOTHING || !current[i].Obj.uId)
            {
                freeSlot=i;
                break;
            }
        if(freeSlot<0)
        {
            s_Window->m_Info.SetText("Chin o dat vat pham da day.");
            return true;
        }

        KUiObjAtContRegion from,to;ZeroMemory(&from,sizeof(from));ZeroMemory(&to,sizeof(to));
        from.Obj.uGenre=item->uGenre;from.Obj.uId=item->uId;
        from.Region.h=item->DataX;from.Region.v=item->DataY;
        from.Region.Width=item->DataW;from.Region.Height=item->DataH;
        from.eContainer=UOC_ITEM_TAKE_WITH;
        to.Obj.uGenre=item->uGenre;to.Obj.uId=item->uId;
        to.Region.h=0;to.Region.v=freeSlot;
        to.Region.Width=item->DataW;to.Region.Height=item->DataH;
        to.eContainer=UOC_BUILD_ITEM;
        if(!g_pCoreShell->OperationRequest(GOI_SWITCH_OBJECT,(unsigned int)&from,(int)&to))
            s_Window->m_Info.SetText("Khong the dua vat pham vao o thang. Kiem tra khoa vat pham.");
        return true;
    }
    static void Open()
    {
        if (!s_Window)
        {
            s_Window=new KUiVngCompose;
            if (!s_Window->Initialize()) { delete s_Window; s_Window=0; return; }
        }
        if(!KUiItem::GetIfVisible()) KUiItem::OpenWindow();
        s_Window->m_Waiting=false;
        s_Window->m_Combine.Enable(true);
        s_Window->BringToTop();
        s_Window->Show();
    }
    static void Close()
    {
        if(s_Window)
        {
            if(g_pCoreShell)g_pCoreShell->OperationRequest(GOI_RECOVERY_BOX_COMMAND,pos_builditem,0);
            s_Window->m_Waiting=false;
            s_Window->Hide();
        }
    }
    static void Result(int code)
    {
        if(!s_Window)return;
        const char* messages[]={"Thanh cong. Da nhan do vao F4.","Cong thuc nay chua duoc mo.","Hay dung gan Xich Tung Tu.","Nguyen lieu khong hop le.","Can cho trong F4.","Vat pham/tai khoan dang khoa.","Du lieu hop thanh bi loi.","Nguyen lieu da thay doi.","Khong du luong trong F4.","Phi VNG chua ro. Khong tru do."};
        const char* upgradeMessages[]={"Thang cap thanh cong.","Hoan nguyen thanh cong.","That bai. Trang bi ve +3.","That bai. Mat ca trang bi.","That bai. Trang bi ve +0.","Do cu: can hoan nguyen truoc.","Khong tron quy tac thang cap.","Ty le nay chua xac minh."};
        s_Window->m_Info.SetText(code>=10 && code<=17?upgradeMessages[code-10]:messages[code>=0 && code<10?code:6]);
        s_Window->m_Waiting=false;
        s_Window->m_Combine.Enable(true);
    }
    bool Initialize()
    {
        char scheme[256],path[300];
        g_UiBase.GetCurSchemePath(scheme,sizeof(scheme));
        sprintf(path,"%s\\UiVngCompose.ini",scheme);
        KIniFile ini;
        if(!ini.Load(path)) return false;
        int screenWidth=800,screenHeight=600,offsetX=0,offsetY=0;
        PhongThanGetNativeUiMetrics(screenWidth,screenHeight,offsetX,offsetY);
        PhongThanCenterIniWindow(ini,"Main",offsetX,offsetY);
        if(!Init(&ini,"Main")) return false;
        m_Close.Init(&ini,"CloseBtn");AddChild(&m_Close);
        m_Combine.Init(&ini,"CombineBtn");AddChild(&m_Combine);
        m_Info.Init(&ini,"TxtInfo");AddChild(&m_Info);
        m_Cost.Init(&ini,"TxtMoneyCost");AddChild(&m_Cost);
        for(int i=0;i<9;++i)
        {
            char key[16];sprintf(key,"Item%d",i+1);
            m_Slots[i].Init(&ini,key);m_Slots[i].SetObjectGenre(CGOG_ITEM);
            m_Slots[i].SetContainerId(UOC_BUILD_ITEM);
            m_Slots[i].EnablePickPut(true);AddChild(&m_Slots[i]);
        }
        // Opening the correct panel is distinct from accepting a transaction.
        // Never invoke the old random-purple crafting algorithm for VNG items.
        m_Cost.SetText("Hop vat pham Phong Than");
        m_Info.SetText("Co the mat do khi that bai. Phi tru luong F4.");
        m_Combine.Enable(true);
        m_Waiting=false;m_RequestStarted=0;
        Wnd_AddWindow(this);
        return m_Width>0 && m_Height>0;
    }
    int WndProc(unsigned int message,unsigned int param,int value)
    {
        if((message==WND_N_BUTTON_CLICK && param==(unsigned int)(KWndWindow*)&m_Close) ||
            (message==WM_KEYDOWN && param==VK_ESCAPE)) { Close();return 1; }
        if(message==WND_N_ITEM_PICKDROP)
        {
            ITEM_PICKDROP_PLACE* pick=(ITEM_PICKDROP_PLACE*)param;
            ITEM_PICKDROP_PLACE* drop=(ITEM_PICKDROP_PLACE*)value;
            KUiObjAtContRegion from,to;ZeroMemory(&from,sizeof(from));ZeroMemory(&to,sizeof(to));
            KUiDraggedObject object;ZeroMemory(&object,sizeof(object));
            int picked=-1,dropped=-1;
            for(int i=0;i<9;++i){if(pick && pick->pWnd==&m_Slots[i])picked=i;if(drop && drop->pWnd==&m_Slots[i])dropped=i;}
            if((pick && picked<0) || (drop && dropped<0) || m_Waiting)return 1;
            if(pick){m_Slots[picked].GetObject(object);from.Obj.uGenre=object.uGenre;from.Obj.uId=object.uId;from.Region.Width=object.DataW;from.Region.Height=object.DataH;from.Region.v=picked;from.eContainer=UOC_BUILD_ITEM;}
            if(drop){Wnd_GetDragObj(&object);to.Obj.uGenre=object.uGenre;to.Obj.uId=object.uId;to.Region.Width=object.DataW;to.Region.Height=object.DataH;to.Region.v=dropped;to.eContainer=UOC_BUILD_ITEM;}
            g_pCoreShell->OperationRequest(GOI_SWITCH_OBJECT,pick?(unsigned int)&from:0,drop?(int)&to:0);
            return 1;
        }
        if(message==WND_N_BUTTON_CLICK && param==(unsigned int)(KWndWindow*)&m_Combine)
        {
            if(m_Waiting)return 1;
            PHONGTHAN_COMPOSE_COMMAND request;ZeroMemory(&request,sizeof(request));
            for(int i=0;i<9;++i){KUiDraggedObject item;ZeroMemory(&item,sizeof(item));m_Slots[i].GetObject(item);request.Items[i]=item.uId;}
            m_Info.SetText("Dang kiem tra cong thuc tren server...");
            m_Combine.Enable(false);
            m_Waiting=true;m_RequestStarted=GetTickCount();
            if(!g_pCoreShell->OperationRequest(PHONGTHAN_COMPOSE_CORE_OP,(unsigned int)&request,sizeof(request)))Result(PT_COMPOSE_INVALID_ITEMS);
            return 1;
        }
        return KWndShowAnimate::WndProc(message,param,value);
    }
    void Breathe()
    {
        if(!g_pCoreShell)return;
        if(m_Waiting && GetTickCount()-m_RequestStarted>8000)
        {
            m_Waiting=false;m_Combine.Enable(true);
            m_Info.SetText("Chua nhan phan hoi. Kiem tra ket noi; dong va mo lai cua so neu can.");
        }
        KUiObjAtRegion items[9];ZeroMemory(items,sizeof(items));
        g_pCoreShell->GetGameData(GDI_BUILD_ITEM,(unsigned int)items,0);
        for(int i=0;i<9;++i)m_Slots[i].HoldObject(items[i].Obj.uGenre,items[i].Obj.uId,items[i].Region.Width,items[i].Region.Height);
    }
};
KUiVngCompose* KUiVngCompose::s_Window=0;
bool PhongThanVngComposePutInventoryItem(const KUiDraggedObject* item)
{
    return KUiVngCompose::PutInventoryItem(item);
}
