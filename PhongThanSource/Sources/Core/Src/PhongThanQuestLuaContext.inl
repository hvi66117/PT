// Context lookups must not append hidden arguments to the caller's stack.
int GetPlayerIndex(Lua_State* L)
{
    const int top=Lua_GetTopIndex(L);
    Lua_GetGlobal(L,SCRIPT_PLAYERINDEX);
    const int index=lua_isnumber(L,-1)?(int)Lua_ValueToNumber(L,-1):-1;
    Lua_SetTopIndex(L,top);
    if(index<=0 || index>=MAX_PLAYER)return -1;
    const int npc=Player[index].m_nIndex;
    return npc>0 && npc<MAX_NPC?index:-1;
}

static int PhongThanQuestTeamMember(int team,int ordinal)
{
    if(team<0 || team>=MAX_TEAM || ordinal<1 || ordinal>MAX_TEAM_MEMBER+1)return 0;
    int found=0;int seen[MAX_TEAM_MEMBER+1];int count=0;
    for(int slot=0;slot<=MAX_TEAM_MEMBER;++slot){
        const int player=slot==0?g_Team[team].m_nCaptain:g_Team[team].m_nMember[slot-1];
        if(player<=0 || player>=MAX_PLAYER)continue;
#ifdef _SERVER
        const int npc=Player[player].m_nIndex;
        if(npc<=0 || npc>=MAX_NPC || !Player[player].m_cTeam.m_nFlag ||
           Player[player].m_cTeam.m_nID!=team)continue;
#endif
        bool duplicate=false;for(int i=0;i<count;++i)if(seen[i]==player)duplicate=true;
        if(duplicate)continue;seen[count++]=player;
        if(++found==ordinal)return player;
    }
    return 0;
}
