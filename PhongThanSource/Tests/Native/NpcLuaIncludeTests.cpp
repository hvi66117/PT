#include <windows.h>
#include <stdio.h>
#include "KWin32.h"
#include "KFilePath.h"
#include "KLuaScript.h"
#include "KPakList.h"
#include "../../Sources/Core/Src/PhongThanLuaInclude.inl"
int main(int argc,char**argv)
{
    if(argc!=2 || !SetCurrentDirectoryA(argv[1]))return 2;
    g_SetRootPath(NULL);g_SetFilePath("\\");KPakList packs;
    if(!packs.Open("\\package.ini"))return 3;
    g_SetPakFileMode(1);KLuaScript script;
    if(!script.Init())return 4;
    script.RegisterFunction("Include",(void*)LuaIncludeFile);
    if(!script.Load("\\script\\caller.lua"))return 5;
    if(!script.CallFunction("main",0,""))return 6;
    lua_getglobal(script.m_LuaState,"pak_value");
    if(lua_tonumber(script.m_LuaState,-1)!=37)return 7;lua_pop(script.m_LuaState,1);
    lua_getglobal(script.m_LuaState,"fallback_value");
    if(lua_tonumber(script.m_LuaState,-1)!=11)return 8;lua_pop(script.m_LuaState,1);
    if(!script.CallFunction("child_callback",0,""))return 9;
    const char* failures[]={"missing","cycle","unsafe"};
    for(int i=0;i<3;++i){
        if(script.CallFunction((char*)failures[i],0,""))return 10+i;
        if(!script.CallFunction("main",0,""))return 13+i; // failed include must not poison state
    }
    puts("PASS NPC_LUA_INCLUDE pak_priority=1 loose_fallback=1 same_state=1 missing_cycle_path_guards=1 recovery=1");
    return 0;
}
