// Real Engine/Lua 4 executes the hash-derived VNG script and the shared C++
// death-context helper. Player/task/team stores are isolated test doubles.
#include <windows.h>
#include <stdio.h>
#include <string.h>
#include <stdarg.h>
#include "KWin32.h"
#include "KFilePath.h"
#include "KLuaScript.h"

#define MAX_PLAYER 8
#define MAX_NPC 16
#define MAX_SUBWORLD 2
#define SCRIPT_PLAYERINDEX "PlayerIndex"
#define SCRIPT_PLAYERID "PlayerId"
#define SCRIPT_SUBWORLDINDEX "SubWorld"
struct QuestTestNpc
{
    DWORD m_dwID;
    int m_SubWorldIndex, m_PlayerIndex, m_Template, m_Level, m_RegionIndex;
    BOOL IsPlayer() { return m_PlayerIndex > 0; }
    int GetPlayerIdx() { return m_PlayerIndex; }
} Npc[MAX_NPC];
struct QuestTestPlayer
{
    DWORD m_dwID;
    int m_nIndex, m_nNetConnectIdx, level, buff;
    unsigned long task[1024];
    int notes[1024];
} Player[MAX_PLAYER];
static KLuaScript* activeScript;
static void* g_GetScript(DWORD id) { return id == 1 ? activeScript : NULL; }
static void g_DebugLog(const char*, ...) {}
#include "../../Sources/Core/Src/PhongThanQuestDeathContext.inl"

static int team[6], teamCount, teamEnabled, hardAttrib, drops, messages, writes;
static int assertions, lastDrop[8];
#define CHECK(test) do { ++assertions; if (!(test)) { \
    printf("FAIL line=%d test=%s\n", __LINE__, #test); return 1; } } while (0)

static int Current(Lua_State* L)
{
    lua_getglobal(L, "PlayerIndex");
    int id = (int)lua_tonumber(L, -1); lua_pop(L, 1);
    if (id <= 0 || id >= MAX_PLAYER || Player[id].m_nIndex <= 0 ||
        Player[id].m_nNetConnectIdx < 0) return 0;
    return id;
}
static int GetTask(Lua_State* L)
{
    int id=Current(L), task=(int)lua_tonumber(L,1);
    lua_pushnumber(L,id && task>=0 && task<1024 ? Player[id].task[task] : 0); return 1;
}
static int SetTask(Lua_State* L)
{
    int id=Current(L), task=(int)lua_tonumber(L,1);
    if (!id || task<0 || task>=1024) lua_error(L,"invalid task context");
    Player[id].task[task]=(unsigned long)lua_tonumber(L,2);++writes;return 0;
}
static int World(Lua_State* L)
{
    int id=Current(L);
    if (!id) { lua_pushnil(L); return 1; }
    lua_pushnumber(L,1014+2*Npc[Player[id].m_nIndex].m_SubWorldIndex);
    lua_pushnumber(L,100);lua_pushnumber(L,100);return 3;
}
static int NpcWorld(Lua_State* L)
{
    int npc=(int)lua_tonumber(L,1);
    lua_pushnumber(L,npc>0 && npc<MAX_NPC && Npc[npc].m_RegionIndex>=0 ?
        1014+2*Npc[npc].m_SubWorldIndex : 0);
    lua_pushnumber(L,100);lua_pushnumber(L,100);return 3;
}
static int Level(Lua_State* L) {lua_pushnumber(L,Player[Current(L)].level);return 1;}
static int NpcLevel(Lua_State* L) {lua_pushnumber(L,Npc[(int)lua_tonumber(L,1)].m_Level);return 1;}
static int Template(Lua_State* L) {lua_pushnumber(L,Npc[(int)lua_tonumber(L,1)].m_Template);return 1;}
static int Hard(Lua_State* L) {lua_pushnumber(L,hardAttrib);return 1;}
static int Drop(Lua_State* L)
{
    for(int i=0;i<8;++i)lastDrop[i]=(int)lua_tonumber(L,i+1);
    ++drops;return 0;
}
static int Team(Lua_State* L)
{
    // Actual historical semantics: nil solo, ID 0 for the first valid team.
    if(teamEnabled)lua_pushnumber(L,0);else lua_pushnil(L);return 1;
}
static int TeamSize(Lua_State* L) {lua_pushnumber(L,teamEnabled?teamCount:0);return 1;}
static int TeamMember(Lua_State* L)
{
    int ordinal=(int)lua_tonumber(L,1);
    lua_pushnumber(L,ordinal>0 && ordinal<=teamCount ? team[ordinal-1]:0);return 1;
}
static int Captain(Lua_State* L) {lua_pushnumber(L,Current(L)==team[0]?1:0);return 1;}
static int Relation(Lua_State* L)
{
    int id=Current(L), mate=(int)lua_tonumber(L,1);
    lua_pushnumber(L,(id==1&&mate==2)||(id==2&&mate==1)?1:0);return 1;
}
static int Buff(Lua_State* L) {lua_pushnumber(L,Player[Current(L)].buff);return 1;}
static int GetByte(Lua_State* L)
{
    unsigned long value=(unsigned long)lua_tonumber(L,1);
    int index=(int)lua_tonumber(L,2);
    lua_pushnumber(L,(value>>((index-1)*8))&255);return 1;
}
static int SetByte(Lua_State* L)
{
    unsigned long value=(unsigned long)lua_tonumber(L,1);
    int index=(int)lua_tonumber(L,2);
    unsigned long byte=(unsigned long)lua_tonumber(L,3);
    value=(value&~(255UL<<((index-1)*8)))|((byte&255)<<((index-1)*8));
    lua_pushnumber(L,value);return 1;
}
static int Note(Lua_State* L)
{
    int id=Current(L), task=(int)lua_tonumber(L,1), step=(int)lua_tonumber(L,2);
    if(!id)lua_error(L,"task note for offline player");
    if(task>=0&&task<1024&&step>=1)++Player[id].notes[task];return 0;
}
static int Message(Lua_State*) {++messages;return 0;}
static int Name(Lua_State* L) {lua_pushstring(L,"TemplateName");return 1;}
static int Noop(Lua_State*) {return 0;}
static void Reset()
{
    memset(Player,0,sizeof(Player));memset(Npc,0,sizeof(Npc));
    for(int i=1;i<MAX_PLAYER;++i)
    {
        Player[i].m_dwID=1000+i;Player[i].m_nIndex=i;
        Player[i].m_nNetConnectIdx=i;Player[i].level=35;
        Npc[i].m_dwID=2000+i;Npc[i].m_PlayerIndex=i;
    }
    Npc[10].m_dwID=9001;Npc[10].m_Level=35;Npc[10].m_Template=12;
    teamEnabled=teamCount=0;memset(team,0,sizeof(team));
    hardAttrib=-1;drops=messages=writes=0;
}
static unsigned long Pack(int a,int b,int c,int d)
{return (unsigned long)a|((unsigned long)b<<8)|((unsigned long)c<<16)|((unsigned long)d<<24);}
static int Byte(unsigned long value,int n) {return (value>>((n-1)*8))&255;}
static BOOL Kill(int player=1,DWORD id=1001)
{return PhongThanRunNpcDeathScript(10,1,player,id);}
static void Global(Lua_State* L,const char* name,int value)
{lua_pushnumber(L,value);lua_setglobal(L,name);}
static int GlobalValue(Lua_State* L,const char* name)
{lua_getglobal(L,name);int value=(int)lua_tonumber(L,-1);lua_pop(L,1);return value;}

int main(int argc,char**argv)
{
    if(argc!=2)return 2;
    SetErrorMode(SEM_FAILCRITICALERRORS|SEM_NOGPFAULTERRORBOX);
    SetCurrentDirectoryA(argv[1]);g_SetRootPath(NULL);g_SetFilePath("\\");
    KLuaScript script;CHECK(script.Init());activeScript=&script;
    TLua_Funcs api[]={
        {"GetTask",GetTask},{"SetTask",SetTask},{"GetWorldPos",World},
        {"GetNpcWorldPos",NpcWorld},{"GetNpcLevel",NpcLevel},{"GetLevel",Level},
        {"GetNpcTemplateID",Template},{"GetHardNpcAttrib",Hard},{"ThrowItem",Drop},
        {"GetTeam",Team},{"GetTeamSize",TeamSize},{"GetTeamMember",TeamMember},
        {"IsCaptain",Captain},{"IsMasterPRRelation",Relation},{"HaveIBBuff",Buff},
        {"GetByte",GetByte},{"SetByte",SetByte},{"TaskNote",Note},
        {"Msg2Player",Message},{"GetNpcTempName",Name},{"CloseDialog",Noop}
    };
    script.RegisterFunctions(api,sizeof(api)/sizeof(api[0]));
    CHECK(script.Load("\\script\\phongthan\\npc_quests\\normal.lua"));
    Lua_State* L=script.m_LuaState;

    // Solo works despite GetTeam()==nil; IDs/limits stay exactly VNG.
    Reset();Player[1].task[854]=Pack(13,2,16,0);
    CHECK(Kill());CHECK(Byte(Player[1].task[854],2)==1);
    CHECK(Kill());CHECK(Byte(Player[1].task[854],2)==0);
    int completed=Player[1].notes[854], priorWrites=writes;
    CHECK(completed==1);CHECK(Kill());CHECK(writes==priorWrites);
    CHECK(Player[1].notes[854]==completed);

    Reset();Player[1].task[854]=Pack(16,7,17,8);
    CHECK(Kill());CHECK(writes==0); // Wrong template must not advance.
    Npc[1].m_SubWorldIndex=1;Player[1].task[854]=Pack(13,7,16,0);
    CHECK(Kill());CHECK(writes==0); // Owner has left the kill's map.

    // Team ID zero, different targets, wrong-map, offline, duplicate member.
    Reset();teamEnabled=1;teamCount=6;
    team[0]=1;team[1]=2;team[2]=3;team[3]=4;team[4]=5;team[5]=2;
    Npc[3].m_SubWorldIndex=1;Player[4].m_nNetConnectIdx=-1;
    Player[5].m_nIndex=0;
    for(int i=1;i<=5;++i)Player[i].task[854]=Pack(13,10,16,0);
    CHECK(Kill());CHECK(Byte(Player[1].task[854],2)==9);
    CHECK(Byte(Player[2].task[854],2)==9);
    CHECK(Byte(Player[3].task[854],2)==10);
    CHECK(Byte(Player[4].task[854],2)==10);
    CHECK(Byte(Player[5].task[854],2)==10);

    // Master/disciple targets belong to each recipient, not the killer.
    Reset();teamEnabled=1;teamCount=2;team[0]=1;team[1]=2;
    Player[1].task[897]=16;Player[1].task[898]=3;Player[1].buff=1;
    Player[2].task[897]=13;Player[2].task[898]=2;Player[2].buff=1;
    CHECK(Kill());CHECK(Player[1].task[898]==3);CHECK(Player[2].task[898]==1);
    CHECK(Kill());CHECK(Player[2].task[898]==0);CHECK(Player[2].notes[42]==1);
    CHECK(Kill());CHECK(Player[2].notes[42]==1);CHECK(Player[1].task[898]==3);
    Player[2].task[898]=2;Player[2].buff=0;
    CHECK(Kill());CHECK(Player[2].task[898]==2);
    Player[2].buff=1;Npc[2].m_SubWorldIndex=1;
    CHECK(Kill());CHECK(Player[2].task[898]==2);

    // Flower progress is capped at 50; duplicate target bytes don't overwrite.
    Reset();Player[1].task[894]=Pack(13,13,16,0);
    Player[1].task[889]=Pack(49,48,7,0);
    CHECK(Kill());CHECK(Byte(Player[1].task[889],1)==50);
    CHECK(Byte(Player[1].task[889],2)==49);CHECK(Byte(Player[1].task[889],3)==7);
    CHECK(Kill());CHECK(Byte(Player[1].task[889],2)==50);
    CHECK(Kill());CHECK(Byte(Player[1].task[889],1)==50);
    CHECK(Byte(Player[1].task[889],2)==50);

    // Template display names outside the 61-entry name table don't abort Lua.
    Reset();Npc[10].m_Template=199;Player[1].task[854]=Pack(200,2,16,0);
    CHECK(Kill());CHECK(Byte(Player[1].task[854],2)==1);
    Reset();hardAttrib=3;CHECK(Kill());CHECK(drops==1);
    CHECK(lastDrop[0]==10&&lastDrop[1]==1&&lastDrop[2]==3&&lastDrop[3]==21);

    // Shared Lua globals are restored, and stale/reused owners cannot credit.
    Reset();Global(L,"PlayerIndex",7);Global(L,"PlayerId",888);Global(L,"SubWorld",1);
    Player[1].task[854]=Pack(13,2,16,0);
    lua_pushstring(L,"stack-marker");int top=lua_gettop(L);
    CHECK(Kill());CHECK(lua_gettop(L)==top);CHECK(GlobalValue(L,"PlayerIndex")==7);
    CHECK(GlobalValue(L,"PlayerId")==888);CHECK(GlobalValue(L,"SubWorld")==1);
    CHECK(Byte(Player[1].task[854],2)==1);
    priorWrites=writes;CHECK(Kill(1,9999));CHECK(writes==priorWrites);
    CHECK(Kill(0,0));CHECK(writes==priorWrites);CHECK(GlobalValue(L,"PlayerIndex")==7);
    Player[1].m_nNetConnectIdx=-1;CHECK(Kill());CHECK(writes==priorWrites);
    Player[1].m_nNetConnectIdx=1;Npc[1].m_PlayerIndex=2;
    CHECK(Kill());CHECK(writes==priorWrites);

    // Native scope also restores nil and stack state after a Lua runtime error.
    lua_pushnil(L);lua_setglobal(L,"PlayerId");
    CHECK(lua_dostring(L,"function OnDeath(n) PlayerIndex=6; SubWorld=777; error('expected') end")==0);
    CHECK(!Kill());CHECK(lua_gettop(L)==top);CHECK(GlobalValue(L,"PlayerIndex")==7);
    lua_getglobal(L,"PlayerId");CHECK(lua_isnil(L,-1));lua_pop(L,1);
    CHECK(GlobalValue(L,"SubWorld")==1);
    printf("PASS QUEST_DEATH_PROGRESS assertions=%d real_lua4=1\n",assertions);
    return 0;
}
