int LuaSayTaskCompat(Lua_State* L)
{
    if (GetPlayerIndex(L) <= 0 || Lua_GetTopIndex(L) < 2 ||
        (!Lua_IsNumber(L,1) && !Lua_IsString(L,1)) || !Lua_IsTable(L,2)) return 0;
    const bool numeric = Lua_IsNumber(L,1) != 0;
    const int resource = numeric ? (int)Lua_ValueToNumber(L,1) : 0;
    char prompt[MAX_SCIRPTACTION_BUFFERNUM];
    prompt[0]=0;
    if (!numeric) g_StrCpyLen(prompt,Lua_ValueToString(L,1),sizeof(prompt));
    char options[MAX_ANSWERNUM][160];
    int count=0;
    const int rows=Lua_GetN(L,2);
    for (int row=1; row<=rows && count<MAX_ANSWERNUM; ++row)
    {
        Lua_RawGetI(L,2,row);
        const int index=Lua_GetTopIndex(L);
        if (Lua_IsTable(L,index))
        {
            Lua_PushString(L,"show"); Lua_GetTable(L,index);
            const bool visible=lua_isnil(L,Lua_GetTopIndex(L)) || Lua_ValueToNumber(L,Lua_GetTopIndex(L))!=0;
            Lua_Pop(L,1);
            char label[100],callback[40]; label[0]=callback[0]=0;
            Lua_RawGetI(L,index,1);
            if (Lua_IsString(L,Lua_GetTopIndex(L))) g_StrCpyLen(label,Lua_ValueToString(L,Lua_GetTopIndex(L)),sizeof(label));
            Lua_Pop(L,1);
            Lua_RawGetI(L,index,2);
            if (Lua_IsString(L,Lua_GetTopIndex(L))) g_StrCpyLen(callback,Lua_ValueToString(L,Lua_GetTopIndex(L)),sizeof(callback));
            Lua_Pop(L,1);
            if (visible && label[0] && callback[0]) sprintf(options[count++],"%s/%s",label,callback);
        }
        Lua_Pop(L,1);
    }
    // Use the same counted question encoding as Say, preserving numeric VNG
    // StringResource IDs and the callback attached to each visible row.
    Lua_SetTopIndex(L,0);
    if (numeric) Lua_PushNumber(L,resource); else Lua_PushString(L,prompt);
    Lua_PushNumber(L,count);
    for (int i=0;i<count;++i) Lua_PushString(L,options[i]);
    return LuaSelectUI(L);
}

int LuaMsgBoxCompat(Lua_State* L)
{
    const int argc=Lua_GetTopIndex(L);
    if (argc<2 || !Lua_IsString(L,2) ||
        (!Lua_IsNumber(L,1) && !Lua_IsString(L,1))) return 0;
    const bool numeric=Lua_IsNumber(L,1)!=0;
    const int resource=numeric?(int)Lua_ValueToNumber(L,1):0;
    char prompt[MAX_SCIRPTACTION_BUFFERNUM],yes[64],no[64];
    prompt[0]=no[0]=0;
    if(!numeric) g_StrCpyLen(prompt,Lua_ValueToString(L,1),sizeof(prompt));
    g_StrCpyLen(yes,Lua_ValueToString(L,2),sizeof(yes));
    if(argc>=3 && Lua_IsString(L,3)) g_StrCpyLen(no,Lua_ValueToString(L,3),sizeof(no));
    Lua_SetTopIndex(L,0);
    if(numeric) Lua_PushNumber(L,resource);else Lua_PushString(L,prompt);
    Lua_PushNumber(L,no[0]?2:1);
    char option[96];sprintf(option,"OK/%s",yes);Lua_PushString(L,option);
    if(no[0]){sprintf(option,"Cancel/%s",no);Lua_PushString(L,option);}
    return LuaSelectUI(L);
}

#ifdef _SERVER
int LuaEnchaseItem(Lua_State* L)
{
    const int player=GetPlayerIndex(L);
    if(player<=0 || player>=MAX_PLAYER || !g_pServer) return 0;
    const int index=Player[player].m_nIndex;
    if(index<=0 || index>=MAX_NPC) return 0;
    const int world=Npc[index].m_SubWorldIndex;
    if(world<0 || world>=MAX_SUBWORLD) return 0;
    PHONGTHAN_PLAYER_EVENT event;
    ZeroMemory(&event,sizeof(event));
    PhongThanInitializeWireHeader(&event.Header,PHONGTHAN_MSG_UI_PLAYER_EVENT,sizeof(event),PHONGTHAN_WIRE_FLAG_RESPONSE,0);
    event.MapId=SubWorld[world].m_SubWorldID; event.EntityId=Npc[index].m_dwID;
    event.Operation=PHONGTHAN_PLAYER_ENCHASE_PANEL;
    event.Value=1; // Phong Than VNG combine panel, not SwordOnline purple forging.
    // UI service events are standalone native frames, like script dialogs.
    // Do not append them behind legacy aggregate data with unknown lengths.
    if(FAILED(g_pServer->SendData(Player[player].m_nNetConnectIdx,&event,sizeof(event))))
        g_DebugLog("[XichTungTu] compose panel delivery failed player=%d",player);
    return 0;
}
#endif
