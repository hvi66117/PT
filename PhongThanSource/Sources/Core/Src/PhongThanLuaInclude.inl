#include "KPakFile.h"
#include "KDebug.h"
#include <map>
#include <vector>
#include <string>

// Include shares the caller's Lua state (unlike a new KLuaScript). Resolve via
// the same PAK-first loader as the script itself. Candidate files are never an
// implicit search path; only the configured package chain/runtime root is used.
int LuaIncludeFile(Lua_State* L)
{
    if (Lua_GetTopIndex(L) < 1 || !Lua_IsString(L,1))
    { lua_error(L,"Include expects a logical script path"); return 0; }
    char path[240], error[320]; path[0]='\\';error[0]=0;
    const char* input=lua_tostring(L,1); unsigned int n=1;
    for (unsigned int i=0;input[i];++i)
    {
        char c=input[i]=='/'?'\\':input[i];
        if (c==':' || n+1>=sizeof(path))
        { lua_error(L,"Include rejected unsafe/long path"); return 0; }
        if(c=='\\' && path[n-1]=='\\')continue;
        // Preserve CP936 bytes, including ASCII-valued trail bytes. PAK and
        // Windows path lookups already implement their own case semantics.
        path[n++]=c;
    }
    path[n]=0;
    if(n<5 || strstr(path,"\\..\\") || strstr(path,"\\.\\") ||
       (stricmp(path+n-4,".lua") && (n<6 || stricmp(path+n-5,".luax"))))
    { lua_error(L,"Include rejected non-script or traversal path"); return 0; }

    typedef std::vector<std::string> IncludeStack;
    static std::map<Lua_State*,IncludeStack> stacks;
    {
        IncludeStack& stack=stacks[L];
        bool circular=false;
        for(unsigned int j=0;j<stack.size();++j)if(stack[j]==path)circular=true;
        if(circular || stack.size()>=32)
        {
            sprintf(error,"Include cycle/depth limit: %s",path);
        }
        else
        {
            stack.push_back(path);
            int status=-1;
            const int top=Lua_GetTopIndex(L);
            {
                KPakFile file;
                if(file.Open(path))
                {
                    const DWORD size=file.Size();
                    if(size>0 && size<=4*1024*1024)
                    {
                        std::vector<char> bytes(size);
                        if(file.Read(&bytes[0],size)==size)
                            status=Lua_ExecuteBuffer(L,&bytes[0],size,path);
                    }
                }
            }
            Lua_SetTopIndex(L,top);
            stack.pop_back();
            if(stack.empty())stacks.erase(L);
            if(status!=0)sprintf(error,"Include failed: %s (status=%d)",path,status);
        }
    }
    // Raise only after file/buffer RAII objects have left scope. Lua 4 uses a
    // longjmp; keeping C++ resource owners alive here would leak on errors.
    if(error[0]){g_DebugLog("[LuaInclude] %s",error);lua_error(L,error);}
    return 0;
}
