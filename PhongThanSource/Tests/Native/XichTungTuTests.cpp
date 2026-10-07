// Execute original/derived Lua4 and the production credit transaction together.
// Player inventory is an isolated test double; not live-client acceptance.
#define main QuestExchangeRegressionMain
#include "QuestExchangeTests.cpp"
#undef main
#include "KStrBase.h"
#include "KFilePath.h"
enum { MAX_SUBWORLD=2, TASKVALUE_PT_CREDIT=4837 };
struct TestNpc {int m_SubWorldIndex,m_RegionIndex,m_NpcSettingIdx,m_DialogRadius;DWORD m_ActionScriptID;} Npc[MAX_NPC];
struct TestWorld {int m_SubWorldID;} SubWorld[MAX_SUBWORLD];
struct NpcSetTest {int distance;int GetDistance(int,int){return distance;}} NpcSet;
static int panelOpened,lastMessage,menuCount,helpPages;
static char callback[16][40];
int LuaEnchaseItem(Lua_State*){++panelOpened;return 0;}
#include "../../Sources/Core/Src/PhongThanXichTungTuService.inl"
static int Credit(Lua_State* L){lua_pushnumber(L,Player[1].m_cTask.value);return 1;}
static int DecCredit(Lua_State* L){Player[1].m_cTask.value-=(int)lua_tonumber(L,1);return 0;}
static int RejectReward(Lua_State* L){lua_pushnumber(L,0);return 1;}
static int Stub(Lua_State*){return 0;}
static int Msg(Lua_State* L){lastMessage=(int)lua_tonumber(L,1);return 0;}
static int Talk(Lua_State*){++helpPages;return 0;}
static int Menu(Lua_State* L){
    assert(lua_istable(L,2));menuCount=Lua_GetN(L,2);assert(menuCount<=16);
    for(int i=0;i<menuCount;++i){lua_rawgeti(L,2,i+1);lua_rawgeti(L,-1,2);
        assert(lua_isstring(L,-1));strcpy(callback[i],lua_tostring(L,-1));lua_pop(L,2);}
    return 0;
}
static void Setup(int capacity,int credit){
    Reset(capacity);Player[1].m_ItemList.Remove(1);Item[1].id=0;
    Player[1].m_nIndex=1;Player[1].m_nLastNpcIndex=2;Player[1].m_cTask.value=credit;
    ZeroMemory(Npc,sizeof(Npc));Npc[2].m_NpcSettingIdx=206;Npc[2].m_DialogRadius=100;
    Npc[2].m_ActionScriptID=g_FileName2Id(PT_XICH_TUNG_TU_SCRIPT);SubWorld[0].m_SubWorldID=1052;
    NpcSet.distance=0;panelOpened=lastMessage=helpPages=menuCount=0;
}
static void Call(KLuaScript& s,char* name){assert(s.CallFunction(name,0,""));}
int main(int argc,char** argv){
    if(argc!=2 || !SetCurrentDirectoryA(argv[1]))return 2;
    g_SetRootPath(NULL);g_SetFilePath("\\");
    TLua_Funcs api[]={{"SayTask",Menu},{"MsgBox",Msg},{"Talk",Talk},{"CloseDialog",Stub},
        {"EnchaseItem",LuaEnchaseItem},{"GetCredit",Credit},{"DecCredit",DecCredit},
        {"AddNormalItem",RejectReward},{"XichTungTuService",LuaXichTungTuService}};
    KLuaScript original,patched;assert(original.Init() && patched.Init());
    assert(original.RegisterFunctions(api,sizeof(api)/sizeof(api[0])));
    assert(patched.RegisterFunctions(api,sizeof(api)/sizeof(api[0])));
    assert(original.Load("\\original.lua") && patched.Load("\\patched.lua"));
    Setup(0,20);Call(original,"change");assert(Player[1].m_cTask.value==10);
    Setup(0,20);Call(patched,"change");assert(Player[1].m_cTask.value==20 && !Player[1].m_ItemList.Count());
    Setup(3,20);Call(patched,"main");assert(menuCount==3 && !strcmp(callback[0],"dz") && !strcmp(callback[1],"tszs"));
    Call(patched,"dz");assert(panelOpened==1);
    Call(patched,"tszs");assert(lastMessage==11256);
    Call(patched,"change");assert(Player[1].m_cTask.value==10 && Player[1].m_ItemList.Count()==1 && lastMessage==11257);
    assert(Item[2].genre==3 && Item[2].detail==82 && Item[2].level==0);
    Call(patched,"change");assert(Player[1].m_cTask.value==0 && Player[1].m_ItemList.Count()==2);
    Call(patched,"change");assert(Player[1].m_ItemList.Count()==2 && lastMessage==11258);
    Setup(3,20);ItemSet.failAt=1;Call(patched,"change");assert(Player[1].m_cTask.value==20 && !Player[1].m_ItemList.Count());
    Setup(3,20);NpcSet.distance=201;Call(patched,"change");Call(patched,"dz");assert(Player[1].m_cTask.value==20 && !panelOpened);
    Setup(3,20);Npc[2].m_ActionScriptID=123;Call(patched,"change");assert(Player[1].m_cTask.value==20);
    Setup(3,20);Player[1].locked=true;Call(patched,"change");assert(Player[1].m_cTask.value==20);
    Setup(3,20);Player[1].trading=true;Call(patched,"change");assert(Player[1].m_cTask.value==20);
    Setup(3,20);SubWorld[0].m_SubWorldID=1016;Call(patched,"change");assert(Player[1].m_cTask.value==20);
    Setup(3,20);Npc[2].m_RegionIndex=-1;Call(patched,"change");assert(Player[1].m_cTask.value==20);
    Setup(3,20);Call(patched,"hcbd");assert(menuCount==6);
    char* pages[]={"wqsj","wqsj1","wqsj2","wqsj3","wqsj4","zbsj","zbsj1","zbsj2","zbsj3","fbhc","fbhc1","blhc","blhc1","blhc2","bshc","qthc"};
    for(int i=0;i<16;++i)Call(patched,pages[i]);assert(helpPages==16);
    puts("PASS XICH_TUNG_TU real_lua4 original_loss_reproduced fixed_credit_exchange menu3 help6/pages16 panel_dispatch proximity_identity_lock_room_generation_guards");
    return 0;
}
