#include <windows.h>
#include <stdio.h>
#include <assert.h>
#include "KWin32.h"
#include "KDebug.h"
#include "KFilePath.h"
#include "KPakList.h"
#include "KStrBase.h"
#include "../../Headers/PhongThanCompose.h"
enum {MAX_NPC=8,MAX_ITEM=64,MAX_PLAYER_ITEM=64,MAX_SUBWORLD=1,MAX_ITEM_MAGICLEVEL=20,
      pos_builditem=9,item_materials=3};
struct Lock {bool IsLock(){return false;}};
struct KItem {
    int id,genre,detail,stack;
    int GetID(){return id;} int GetGenre(){return genre;} int GetDetailType(){return detail;}
    int GetStackNum(){return stack;} bool GetLockTrade(){return false;} bool IsTemp(){return false;}
    int GetParticular(){return 0;}
    int GetWidth(){return 1;} int GetHeight(){return 1;} Lock* GetLock(){static Lock l;return &l;}
} Item[MAX_ITEM];
struct ItemPos {int nPlace,nX,nY;};
struct Inv {
    ItemPos m_Items[MAX_PLAYER_ITEM];int money;bool room;int input,output;
    bool owned[MAX_ITEM];int placed,capacity,removeFailure;
    int GetBuildItem(int i){return i==0?input:0;}
    int FindSame(int i){return owned[i]?i:0;}
    int GetEquipmentMoney(){return money;}
    bool SearchPosition(int,int,ItemPos* p,bool){p->nPlace=1;p->nX=placed;p->nY=0;return room && placed<capacity;}
    bool Add(int i,int place,int x,int y,bool){if(place==pos_builditem){input=i;owned[i]=true;return true;}if(!room || placed>=capacity)return false;output=i;owned[i]=true;++placed;return true;}
    bool Remove(int i){if(removeFailure==i)return false;if(!owned[i])return false;owned[i]=false;if(input==i)input=0;else --placed;if(output==i)output=0;return true;}
    bool RemoveItem(int i,int){Item[i].id=0;if(input==i)input=0;if(output==i)output=0;return true;}
};
struct PlayerMock {
    int m_nIndex,m_nLastNpcIndex,m_nNetConnectIdx;Inv m_ItemList;
    bool GetLockState(){return false;} bool CheckTrading(){return false;}
    bool Pay(int n){if(m_ItemList.money<n)return false;m_ItemList.money-=n;return true;}
} Player[2];
struct NpcMock {int m_SubWorldIndex,m_NpcSettingIdx,m_DialogRadius,m_RegionIndex;DWORD m_dwID,m_ActionScriptID;} Npc[MAX_NPC];
struct WorldMock {int m_SubWorldID;} SubWorld[1];
struct NpcSetMock {int GetDistance(int,int){return 0;}} NpcSet;
struct ItemSetMock {
    int next,failAt;
    int Add(int,int,int,int,int d,int,int*,int){int i=++next;if(failAt==i)return 0;Item[i].id=i*100;Item[i].genre=3;Item[i].detail=d;Item[i].stack=1;return i;}
    void Remove(int i){Item[i].id=0;}
} ItemSet;
struct WorldSetMock {int GetGameVersion(){return 1;}} g_SubWorldSet;
struct ServerMock {
    PHONGTHAN_COMPOSE_RESULT result;
    void SendData(int,const void* p,int){result=*(const PHONGTHAN_COMPOSE_RESULT*)p;}
} server,*g_pServer=&server;
#define PHONGTHAN_MATERIAL_ONLY_TEST
#include "../../Sources/Core/Src/PhongThanComposeServer.inl"
static void Reset(int money,bool room)
{
    ZeroMemory(Item,sizeof(Item));ZeroMemory(Player,sizeof(Player));
    ItemSet.next=1;ItemSet.failAt=0;
    Player[1].m_nIndex=1;Player[1].m_nLastNpcIndex=2;
    Player[1].m_ItemList.money=money;Player[1].m_ItemList.room=room;Player[1].m_ItemList.input=1;
    Player[1].m_ItemList.owned[1]=true;Player[1].m_ItemList.capacity=8;
    Player[1].m_ItemList.m_Items[1].nPlace=pos_builditem;
    Item[1].id=100;Item[1].genre=3;Item[1].detail=29;Item[1].stack=2;
    Npc[1].m_SubWorldIndex=Npc[2].m_SubWorldIndex=0;Npc[2].m_NpcSettingIdx=206;Npc[2].m_DialogRadius=100;
    Npc[2].m_ActionScriptID=0xD02B148DUL;
    SubWorld[0].m_SubWorldID=1052;
}
int main(int argc,char**argv)
{
    if(argc!=2 || !SetCurrentDirectoryA(argv[1]))return 2;
    g_SetRootPath(NULL);g_SetFilePath("\\");KPakList packs;
    if(!packs.Open("\\package.ini"))return 3;g_SetPakFileMode(1);
    PHONGTHAN_COMPOSE_COMMAND command;ZeroMemory(&command,sizeof(command));command.MapId=1052;command.Items[0]=100;
    Reset(1000,true);PhongThanProcessCompose(1,&command);
    assert(server.result.Result==PT_COMPOSE_OK && server.result.RecipeId==83);
    assert(Player[1].m_ItemList.money==600 && Item[1].id==0 && Item[2].detail==30);
    PhongThanProcessCompose(1,&command);
    assert(server.result.Result!=PT_COMPOSE_OK && Player[1].m_ItemList.money==600);
    Reset(399,true);PhongThanProcessCompose(1,&command);
    assert(server.result.Result==PT_COMPOSE_NO_MONEY && Item[1].id==100 && !Item[2].id && Player[1].m_ItemList.money==399);
    Reset(1000,false);PhongThanProcessCompose(1,&command);
    assert(server.result.Result==PT_COMPOSE_NO_ROOM && Item[1].id==100 && Player[1].m_ItemList.money==1000);
    Reset(1000,true);command.Items[0]=999;PhongThanProcessCompose(1,&command);
    assert(server.result.Result==PT_COMPOSE_STALE && Player[1].m_ItemList.money==1000 && Item[1].id==100);
    // Multi-output uses the same transaction; all objects survive failed commit.
    int inputs[9]={1,0,0,0,0,0,0,0,0};PhongThanComposeRecipe recipe;ZeroMemory(&recipe,sizeof(recipe));
    recipe.output.detail=110;recipe.output.quantity=5;
    Reset(1000,true);assert(PhongThanCommitMaterialCompose(1,inputs,recipe,400)==PT_COMPOSE_OK);
    assert(Player[1].m_ItemList.placed==5 && Player[1].m_ItemList.money==600 && !Item[1].id);
    Reset(1000,true);Player[1].m_ItemList.capacity=4;
    assert(PhongThanCommitMaterialCompose(1,inputs,recipe,400)==PT_COMPOSE_NO_ROOM);
    assert(Player[1].m_ItemList.placed==0 && Player[1].m_ItemList.input==1 && Item[1].id==100 && Player[1].m_ItemList.money==1000);
    Reset(1000,true);ItemSet.failAt=4;assert(PhongThanCommitMaterialCompose(1,inputs,recipe,400)==PT_COMPOSE_TABLE_ERROR);
    assert(Player[1].m_ItemList.input==1 && Item[1].id==100 && Player[1].m_ItemList.money==1000);
    Reset(399,true);assert(PhongThanCommitMaterialCompose(1,inputs,recipe,400)==PT_COMPOSE_NO_MONEY);
    assert(Player[1].m_ItemList.input==1 && Item[1].id==100 && Player[1].m_ItemList.placed==0);
    Reset(1000,true);Player[1].m_ItemList.removeFailure=1;
    assert(PhongThanCommitMaterialCompose(1,inputs,recipe,400)==PT_COMPOSE_TABLE_ERROR);
    assert(Item[1].id==100 && Player[1].m_ItemList.money==1000 && Player[1].m_ItemList.placed==0);
    Reset(1000,true);command.Items[0]=100;Npc[2].m_ActionScriptID=123;PhongThanProcessCompose(1,&command);
    assert(server.result.Result==PT_COMPOSE_NOT_NEAR_NPC && Item[1].id==100);
    puts("PASS NPC_COMPOSE_TRANSACTION recipe83 fee400 multi_output5 partial_generation_partial_placement_payment_detach_rollback stale_repeat_wrong_npc");return 0;
}
