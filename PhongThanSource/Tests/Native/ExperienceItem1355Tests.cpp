#include <windows.h>
#include <stdio.h>
#include <string.h>
#include "KWin32.h"
#include "KFilePath.h"
#include "KPakList.h"
#include "KPakFile.h"
#include "KTabFile.h"
#include "KLuaScript.h"

// Real runtime Engine/Lua 4 and the exact native tuple wrappers extracted by
// the test driver. Only inventory/world effects are isolated in this fixture.
#define MAX_PLAYER 8
#define MAX_NPC 8
#define SCRIPT_PLAYERINDEX "PlayerIndex"
#define _ASSERT(x) ((void)0)
enum { item_materials=3, item_task=4, item_magicscript=6, item_ibitem=8, pos_equiproom=3 };
struct TestPlayer { int m_nIndex; } Player[MAX_PLAYER];
static int stock=20, playerLevel=1, credit=0, expAdded=0, buffs=0;
static int messages=0, prompts=0;
static int CountVngOwnedItems(int, int genre, int detail, int level, int series, int) {
    return genre==6 && detail==1355 && level==1 && series<=0 ? stock : 0;
}
static int RemoveVngItems(int player, int genre, int detail, int level, int series, int place, BOOL) {
    if(place!=pos_equiproom || CountVngOwnedItems(player,genre,detail,level,series,place)<=0) return 0;
    --stock; return 1;
}
#include "ExperienceItem1355Native.inc"
static int Level(Lua_State* L) { Lua_PushNumber(L,playerLevel);return 1; }
static int Credit(Lua_State* L) { Lua_PushNumber(L,credit);return 1; }
static int Exp(Lua_State* L) { expAdded+=(int)Lua_ValueToNumber(L,1);return 0; }
static int Buff(Lua_State* L) { if(Lua_ValueToNumber(L,1)==228 && Lua_ValueToNumber(L,2)==7200) ++buffs;return 0; }
static int Message(Lua_State*) { ++messages;return 0; }
static int Prompt(Lua_State*) { ++prompts;return 0; }
static int Noop(Lua_State*) { return 0; }
#define CHECK(x) do {if(!(x)){printf("FAIL line=%d %s stock=%d exp=%d\n",__LINE__,#x,stock,expAdded);return 1;}}while(0)
int main(int argc,char**argv) {
    if(argc!=2)return 2;
    SetErrorMode(SEM_FAILCRITICALERRORS|SEM_NOGPFAULTERRORBOX);
    CHECK(SetCurrentDirectoryA(argv[1]));g_SetRootPath(NULL);
    KPakList packs;CHECK(packs.Open("\\package.ini"));g_pPakList=&packs;g_SetPakFileMode(1);
    KTabFile table;CHECK(table.Load("\\settings\\item\\001\\magicscript.txt"));
    char script[256]={0};int count=0;
    for(int row=2;row<=table.GetHeight();++row) {
        int id=0;table.GetInteger(row,4,0,&id);
        if(id==1355){table.GetString(row,15,"",script,sizeof(script));++count;}
    }
    CHECK(count==1 && script[0]);
    KPakFile file;CHECK(file.Open(script));
    printf("ACTIVE_SCRIPT bytes=%lu packed=%d path=%s\n",file.Size(),file.IsFileInPak(),script);file.Close();
    KLuaScript lua;CHECK(lua.Init());
    TLua_Funcs functions[]={
        {"HaveNormalItem",LuaHaveNormalItemCompat},{"DelNormalItem",LuaDelNormalItemCompat},
        {"GetLevel",Level},{"GetJusticEvilCredit",Credit},{"AddOwnExp",Exp},
        {"AddIBBuff",Buff},{"Msg2Player",Message},{"MsgBox",Prompt},
        {"WriteLog",Noop},{"CloseDialog",Noop}
    };
    CHECK(lua.RegisterFunctions(functions,sizeof(functions)/sizeof(functions[0])));
    CHECK(lua.Load(script));
    Player[1].m_nIndex=1;Lua_PushNumber(lua.m_LuaState,1);lua.SetGlobalName("PlayerIndex");
    CHECK(Lua_ExecuteString(lua.m_LuaState,"assert(HaveNormalItem(6,1,1355,1)==20)")==0);
    CHECK(Lua_ExecuteString(lua.m_LuaState,"assert(HaveNormalItem(6,1,1355,1,2)==0)")==0);
    CHECK(Lua_ExecuteString(lua.m_LuaState,"assert(HaveNormalItem(6,1,1355)==0)")==0);
    for(int i=0;i<12;++i) CHECK(lua.CallFunction("main",0,"d",1));
    CHECK(stock==8 && expAdded==12 && messages==12);
    puts("PASS level=1 uses=12 consumed=12 exp=12 (no daily limit)");
    stock=0;int before=expAdded;CHECK(lua.CallFunction("main",0,"d",1));CHECK(expAdded==before);
    stock=2;playerLevel=40;CHECK(lua.CallFunction("main",0,"d",1));CHECK(stock==1 && expAdded-before==94100);
    puts("PASS empty inventory; explicit series; missing arguments; VNG level-40 formula");
    stock=2;playerLevel=200;credit=1;CHECK(lua.CallFunction("main",0,"d",1));CHECK(stock==2 && prompts==1);
    CHECK(lua.CallFunction("SureGetBuff",0,""));CHECK(stock==1 && buffs==1);
    puts("PASS existing level-200 confirmation and buff");
    g_pPakList=NULL;return 0;
}
