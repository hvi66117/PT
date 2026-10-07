#include <windows.h>
#include <assert.h>
#include <stdio.h>
#include "KWin32.h"
#include "KLuaScript.h"
enum {MAX_PLAYER=12,MAX_NPC=20,MAX_TEAM=2,MAX_TEAM_MEMBER=4};
#define SCRIPT_PLAYERINDEX "PlayerIndex"
struct TeamState {int m_nFlag,m_nID;};
struct PlayerState {int m_nIndex;TeamState m_cTeam;} Player[MAX_PLAYER];
struct Team {int m_nCaptain,m_nMember[MAX_TEAM_MEMBER];} g_Team[MAX_TEAM];
#define _SERVER
#include "../../Sources/Core/Src/PhongThanQuestLuaContext.inl"
int main()
{
    KLuaScript s;assert(s.Init());Lua_State* L=s.m_LuaState;
    lua_pushnumber(L,123);const int top=lua_gettop(L);
    assert(GetPlayerIndex(L)==-1 && lua_gettop(L)==top);
    lua_pushnumber(L,1);lua_setglobal(L,SCRIPT_PLAYERINDEX);
    assert(GetPlayerIndex(L)==-1 && lua_gettop(L)==top); // empty player slot
    Player[1].m_nIndex=1;
    for(int i=0;i<1000;++i)assert(GetPlayerIndex(L)==1 && lua_gettop(L)==top);
    Player[2].m_nIndex=2;Player[3].m_nIndex=0;Player[4].m_nIndex=4;
    Player[1].m_cTeam.m_nFlag=Player[2].m_cTeam.m_nFlag=Player[3].m_cTeam.m_nFlag=Player[4].m_cTeam.m_nFlag=1;
    g_Team[0].m_nCaptain=1;g_Team[0].m_nMember[0]=0;g_Team[0].m_nMember[1]=2;
    g_Team[0].m_nMember[2]=3;g_Team[0].m_nMember[3]=2;
    assert(PhongThanQuestTeamMember(0,1)==1 && PhongThanQuestTeamMember(0,2)==2);
    assert(PhongThanQuestTeamMember(0,3)==0); // gaps/offline/duplicate filtered
    assert(!PhongThanQuestTeamMember(-1,1) && !PhongThanQuestTeamMember(2,1));
    assert(!PhongThanQuestTeamMember(0,0) && !PhongThanQuestTeamMember(0,6));
    puts("PASS QUEST_LUA_CONTEXT balanced_stack=1000 invalid_player team_zero gap_offline_duplicate");return 0;
}
