// Server-only synchronous NPC death callback. Include after KNpc/KPlayer/Lua.
// A death event must not replace the killer's dialogue callback or inherit the
// PlayerIndex left in a shared Lua state by an unrelated earlier invocation.
#ifndef PHONGTHAN_QUEST_DEATH_CONTEXT_INL
#define PHONGTHAN_QUEST_DEATH_CONTEXT_INL

class PhongThanQuestDeathLuaScope
{
public:
    explicit PhongThanQuestDeathLuaScope(Lua_State* pState)
        : m_State(pState), m_Top(lua_gettop(pState))
    {
        for (int i = 0; i < 3; ++i)
        {
            lua_getglobal(m_State, Name(i));
            m_Ref[i] = lua_ref(m_State, 1);
        }
    }

    ~PhongThanQuestDeathLuaScope()
    {
        for (int i = 0; i < 3; ++i)
        {
            if (m_Ref[i] == LUA_REFNIL)
                lua_pushnil(m_State);
            else
                lua_getref(m_State, m_Ref[i]);
            lua_setglobal(m_State, Name(i));
            if (m_Ref[i] >= 0)
                lua_unref(m_State, m_Ref[i]);
        }
        lua_settop(m_State, m_Top);
    }

    void Set(int nPlayer, DWORD dwPlayerId, int nSubWorld)
    {
        lua_pushnumber(m_State, nPlayer);
        lua_setglobal(m_State, Name(0));
        lua_pushnumber(m_State, dwPlayerId);
        lua_setglobal(m_State, Name(1));
        lua_pushnumber(m_State, nSubWorld);
        lua_setglobal(m_State, Name(2));
    }

private:
    const char* Name(int nIndex) const
    {
        return nIndex == 0 ? SCRIPT_PLAYERINDEX :
            (nIndex == 1 ? SCRIPT_PLAYERID : SCRIPT_SUBWORLDINDEX);
    }
    PhongThanQuestDeathLuaScope(const PhongThanQuestDeathLuaScope&);
    PhongThanQuestDeathLuaScope& operator=(const PhongThanQuestDeathLuaScope&);
    Lua_State* m_State;
    int m_Top;
    int m_Ref[3];
};

// dwExpectedPlayerId is captured when damage ownership is determined, not read
// anew after the death animation. Zero means no player owns the death.
static BOOL PhongThanRunNpcDeathScript(int nNpcIndex, DWORD dwScriptId,
    int nPlayerIndex, DWORD dwExpectedPlayerId)
{
    if (nNpcIndex <= 0 || nNpcIndex >= MAX_NPC || !dwScriptId ||
        !Npc[nNpcIndex].m_dwID || Npc[nNpcIndex].IsPlayer() ||
        Npc[nNpcIndex].m_SubWorldIndex < 0 ||
        Npc[nNpcIndex].m_SubWorldIndex >= MAX_SUBWORLD)
        return FALSE;

    KLuaScript* pScript = (KLuaScript*)g_GetScript(dwScriptId);
    if (!pScript || !pScript->m_LuaState)
    {
        g_DebugLog("[NpcQuestDeath] missing script=%u npc=%d", dwScriptId, nNpcIndex);
        return FALSE;
    }

    int nOwner = 0;
    if (nPlayerIndex > 0 && nPlayerIndex < MAX_PLAYER && dwExpectedPlayerId &&
        Player[nPlayerIndex].m_dwID == dwExpectedPlayerId &&
        Player[nPlayerIndex].m_nNetConnectIdx >= 0)
    {
        int nPlayerNpc = Player[nPlayerIndex].m_nIndex;
        if (nPlayerNpc > 0 && nPlayerNpc < MAX_NPC &&
            Npc[nPlayerNpc].IsPlayer() &&
            Npc[nPlayerNpc].GetPlayerIdx() == nPlayerIndex &&
            Npc[nPlayerNpc].m_dwID &&
            Npc[nPlayerNpc].m_SubWorldIndex == Npc[nNpcIndex].m_SubWorldIndex)
            nOwner = nPlayerIndex;
    }

    PhongThanQuestDeathLuaScope scope(pScript->m_LuaState);
    scope.Set(nOwner, nOwner ? dwExpectedPlayerId : 0,
        Npc[nNpcIndex].m_SubWorldIndex);
    BOOL bResult = pScript->CallFunction("OnDeath", 0, "d", nNpcIndex);
    if (!bResult)
        g_DebugLog("[NpcQuestDeath] failed script=%s npc=%d player=%d",
            pScript->m_szScriptName, nNpcIndex, nOwner);
    return bResult;
}

#endif
