#include <windows.h>
#include <stdio.h>
#include <string.h>
#include "KWin32.h"
#include "KFilePath.h"
#include "KLuaScript.h"
static int mapId, prompts, closed;
static int World(Lua_State* L){Lua_PushNumber(L,mapId);Lua_PushNumber(L,0);Lua_PushNumber(L,0);return 3;}
static int Say(Lua_State* L){
    if(!Lua_IsString(L,1) || !Lua_IsNumber(L,2))lua_error(L,"invalid menu types");
    int count=(int)Lua_ValueToNumber(L,2);
    if(count<1 || count>8 || Lua_GetTopIndex(L)!=count+2)lua_error(L,"invalid menu count");
    for(int i=3;i<count+3;i++){
        if(!Lua_IsString(L,i))lua_error(L,"invalid option");
        const char* text=Lua_ValueToString(L,i);const char* callback=strrchr(text,'/');
        if(!callback || !callback[1])lua_error(L,"missing callback");
        lua_getglobal(L,callback+1);if(!lua_isfunction(L,-1))lua_error(L,"unbound callback");lua_pop(L,1);
    }
    ++prompts;return 0;
}
static int Close(Lua_State*){++closed;return 0;}
int main(int argc,char**argv){
    if(argc!=3)return 2;
    SetErrorMode(SEM_FAILCRITICALERRORS|SEM_NOGPFAULTERRORBOX);
    SetCurrentDirectoryA(argv[1]);g_SetRootPath(NULL);g_SetFilePath("\\");
    FILE* list=fopen(argv[2],"rb");if(!list)return 3;
    int total=0;char path[256];
    while(fgets(path,sizeof(path),list)){
        path[strcspn(path,"\r\n")]=0;if(!path[0])continue;
        const char* base=strrchr(path,'\\');if(!base)return 4;mapId=atoi(base+1);
        KLuaScript script;if(!script.Init())return 5;
        TLua_Funcs api[]={{"GetWorldPos",World},{"Say",Say},{"CloseDialog",Close}};
        script.RegisterFunctions(api,3);
        if(!script.Load(path)){printf("FAIL LOAD %s\n",path);return 6;}
        const char* callbacks[]={"main","pt_about","pt_routes","pt_status","pt_close"};
        prompts=closed=0;
        for(int i=0;i<5;++i)if(!script.CallFunction((char*)callbacks[i],0,"")){printf("FAIL CALLBACK %s %s\n",path,callbacks[i]);return 7;}
        if(prompts!=4 || closed!=1)return 8;
        ++mapId;prompts=closed=0;
        for(i=0;i<4;++i)if(!script.CallFunction((char*)callbacks[i],0,""))return 9;
        if(prompts || closed!=4)return 10;
        ++total;
    }
    fclose(list);printf("PASS AUTHORED_NPC_LUA scripts=%d callbacks=%d wrong_map_guards=%d\n",total,total*5,total*4);
    return total==126?0:11;
}
