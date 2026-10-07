#include <stdio.h>
#include <windows.h>
#include "../../Sources/Represent/iRepresent/PhongThanSpriteAnchor.h"
enum { WND_N_LIST_ITEM_ACTIVE=12 };
class KWndWindow { public: virtual int WndProc(unsigned int,unsigned int,int)=0; };
class KWndMessageListBox : public KWndWindow {
public:
    int m_nSelMsgIndex;
    KWndWindow* m_pParentWnd;
    int HitTextAtPoint(int x,int y) { return x>=20 && x<200 && y>=60 && y<105 ? (y-60)/15 : -1; }
    void OnLButtonDown(int,int);
    int WndProc(unsigned int,unsigned int,int){return 0;}
};
#include "../../Sources/GameClient/Ui/Elem/PhongThanListClick.inl"
struct Parent:KWndWindow { int row;bool destroy;Parent():row(-1),destroy(false){} int WndProc(unsigned int,unsigned int source,int selected){row=selected;if(destroy)delete (KWndMessageListBox*)source;return 0;} };
#define CHECK(x) do { if(!(x)){printf("FAIL line=%d\n",__LINE__);return 1;} }while(0)
int main() {
    CHECK(PhongThanUsesActorCanvas("\\spr\\npcres\\passerby\\NpcS_passerby058.spr",510,510));
    CHECK(PhongThanUsesActorCanvas("\\spr\\npcres\\human\\jsm00_bd_st0.spr",510,510));
    CHECK(!PhongThanUsesActorCanvas("\\spr\\ui4\\dialog.spr",510,510));
    CHECK(!PhongThanUsesActorCanvas("\\spr\\npcres\\passerby\\npc.spr",320,320));
    int x=1000,y=1000;PhongThanActorReference("npcres\\passerby\\npc.spr",0,0,x,y);CHECK(x==745 && y==707);
    x=y=1000;PhongThanActorReference("npcres\\passerby\\npc.spr",250,290,x,y);CHECK(x==750 && y==710);
    Parent parent;KWndMessageListBox list;list.m_pParentWnd=&parent;list.m_nSelMsgIndex=0;
    list.OnLButtonDown(30,98);CHECK(parent.row==2 && list.m_nSelMsgIndex==2);
    list.OnLButtonDown(30,61);CHECK(parent.row==0 && list.m_nSelMsgIndex==0);
    list.OnLButtonDown(30,40);CHECK(parent.row==0 && list.m_nSelMsgIndex==-1);
    KWndMessageListBox* owned=new KWndMessageListBox;owned->m_pParentWnd=&parent;owned->m_nSelMsgIndex=0;parent.destroy=true;
    owned->OnLButtonDown(30,80);CHECK(parent.row==1);
    puts("PASS NPC_UI: VNG anchors; clicked row identity; callback may destroy list");
    return 0;
}
