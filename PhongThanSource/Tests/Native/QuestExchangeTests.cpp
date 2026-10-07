#include <windows.h>
#include <stdio.h>
#include <assert.h>
#include "KWin32.h"
#include "KDebug.h"
#include "KLuaScript.h"
enum {MAX_PLAYER=3,MAX_NPC=8,MAX_ITEM=128,MAX_TASK=5000,MAX_ITEM_MAGICLEVEL=20,
      pos_equiproom=3,item_equip=0,item_medicine=1,item_materials=3,item_task=4,item_magicscript=6,item_skillbook=7,item_ibitem=8,equip_detailnum=16};
#include "../../Sources/Core/Src/PhongThanQuestItemTuple.h"
struct Lock {bool IsLock(){return false;}};
struct KItem {
    int id,genre,detail,part,level,series,stack;
    int GetID(){return id;} int GetGenre(){return genre;} int GetDetailType(){return detail;}
    int GetParticular(){return part;}int GetLevel(){return level;}int GetSeries(){return series;}
    int GetStackNum(){return stack;}int GetWidth(){return 1;}int GetHeight(){return 1;}
    void SetStackNum(int value){stack=value;}Lock* GetLock(){static Lock lock;return &lock;}
} Item[MAX_ITEM];
struct ItemPos {int nPlace,nX,nY;};
struct PlayerItem {int nIdx,nPlace,nX,nY;};
struct KItemList {
    PlayerItem m_Items[MAX_ITEM];int capacity,cursor;
    PlayerItem* GetFirstItem(){cursor=0;return GetNextItem();}
    PlayerItem* GetNextItem(){while(++cursor<MAX_ITEM)if(m_Items[cursor].nIdx)return &m_Items[cursor];return 0;}
    int FindSame(int index){return m_Items[index].nIdx?index:0;}
    bool Remove(int index){if(!FindSame(index))return false;m_Items[index].nIdx=0;return true;}
    void SyncItem(int){}
    bool SearchPosition(int,int,ItemPos* p,bool){
        for(int x=0;x<capacity;++x){bool used=false;for(int i=1;i<MAX_ITEM;++i)if(m_Items[i].nIdx && m_Items[i].nX==x)used=true;
            if(!used){p->nPlace=pos_equiproom;p->nX=x;p->nY=0;return true;}}
        return false;
    }
    int Add(int index,int place,int x,int y,bool){
        if(x<0 || x>=capacity || m_Items[index].nIdx)return 0;
        for(int i=1;i<MAX_ITEM;++i)if(m_Items[i].nIdx && m_Items[i].nX==x)return 0;
        m_Items[index].nIdx=index;m_Items[index].nPlace=place;m_Items[index].nX=x;m_Items[index].nY=y;return index;
    }
    int Count(){int count=0;for(int i=1;i<MAX_ITEM;++i)if(m_Items[i].nIdx)++count;return count;}
};
struct Task {int value;int GetSaveVal(int){return value;}void SetSaveVal(int,int next,BOOL){value=next;}};
struct PlayerMock {int m_nIndex,m_nLastNpcIndex;bool locked,trading;Task m_cTask;KItemList m_ItemList;bool GetLockState(){return locked;}bool CheckTrading(){return trading;}} Player[MAX_PLAYER];
int GetPlayerIndex(Lua_State*){return 1;}
struct WorldSet {int GetGameVersion(){return 1;}} g_SubWorldSet;
struct Items {
    int allocated,failAt;
    int Add(int genre,int series,int level,int,int detail,int particular,int*,int){
        if(++allocated==failAt)return 0;
        for(int i=2;i<MAX_ITEM;++i)if(!Item[i].id){Item[i].id=i+100;Item[i].genre=genre;Item[i].detail=detail;
            Item[i].part=particular;Item[i].level=level;Item[i].series=series;Item[i].stack=1;return i;}
        return 0;
    }
    void Remove(int index){Item[index].id=0;}
} ItemSet;
#define _SERVER
#include "../../Sources/Core/Src/PhongThanQuestExchange.inl"
static PhongThanQuestExchangeRow need[1],rewards[2];
static void Reset(int capacity)
{
    ZeroMemory(Player,sizeof(Player));ZeroMemory(Item,sizeof(Item));ItemSet.allocated=0;ItemSet.failAt=0;
    Player[1].m_cTask.value=18;Player[1].m_ItemList.capacity=capacity;
    Item[1].id=101;Item[1].genre=4;Item[1].detail=26;Item[1].stack=1;
    Player[1].m_ItemList.Add(1,pos_equiproom,0,0,false);
    assert(PhongThanDecodeQuestItemTuple(4,26,0,0,0,0,need[0].item));need[0].count=1;
    assert(PhongThanDecodeQuestItemTuple(1,0,1,1,0,0,rewards[0].item));rewards[0].count=3;
    assert(PhongThanDecodeQuestItemTuple(1,3,1,1,0,0,rewards[1].item));rewards[1].count=3;
}
static void Unchanged(){assert(Player[1].m_cTask.value==18 && Item[1].id==101 && Player[1].m_ItemList.Count()==1);}
int main()
{
    Reset(6);assert(PhongThanQuestExchange(1,20,18,19,need,1,rewards,2)==1);
    assert(Player[1].m_cTask.value==19 && Item[1].id==0 && Player[1].m_ItemList.Count()==6);
    assert(!PhongThanQuestExchange(1,20,18,19,need,1,rewards,2));assert(Player[1].m_ItemList.Count()==6);
    Reset(5);assert(!PhongThanQuestExchange(1,20,18,19,need,1,rewards,2));Unchanged();
    Reset(6);ItemSet.failAt=3;assert(!PhongThanQuestExchange(1,20,18,19,need,1,rewards,2));Unchanged();
    Reset(6);need[0].item.detail=27;assert(!PhongThanQuestExchange(1,20,18,19,need,1,rewards,2));Unchanged();
    Reset(6);assert(!PhongThanQuestExchange(1,20,17,19,need,1,rewards,2));Unchanged();
    Reset(2);Item[1].stack=3;need[0].count=2;assert(!PhongThanQuestExchange(1,20,18,19,need,1,rewards,2));Unchanged();assert(Item[1].stack==3);
    Reset(1);assert(PhongThanQuestExchange(1,20,18,19,need,0,rewards,0));assert(Player[1].m_cTask.value==19);
    puts("PASS QUEST_EXCHANGE original_ids full_reward_set phase_guard bag_full_generate_failure_exact_input_partial_stack_restore_repeat");return 0;
}
