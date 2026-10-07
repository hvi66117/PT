#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct lua_State;
typedef int (__cdecl *LuaCFunction)(lua_State *);
typedef lua_State * (__cdecl *LuaOpenFunction)(int);
typedef void (__cdecl *LuaCloseFunction)(lua_State *);
typedef void (__cdecl *LuaSetTopFunction)(lua_State *, int);
typedef void (__cdecl *LuaPushNumberFunction)(lua_State *, double);
typedef void (__cdecl *LuaPushStringFunction)(lua_State *, const char *);
typedef void (__cdecl *LuaPushNilFunction)(lua_State *);
typedef void (__cdecl *LuaNewTableFunction)(lua_State *);
typedef void (__cdecl *LuaPushClosureFunction)(lua_State *, LuaCFunction, int);

static int __cdecl SmokeNoop(lua_State *)
{
    return 0;
}

static int IsExecutableAddress(void *address)
{
    MEMORY_BASIC_INFORMATION info;
    DWORD protection;
    if (!VirtualQuery(address, &info, sizeof(info)))
        return 0;
    if (info.State != MEM_COMMIT || (info.Protect & (PAGE_GUARD | PAGE_NOACCESS)))
        return 0;
    protection = info.Protect & 0xff;
    return protection == PAGE_EXECUTE || protection == PAGE_EXECUTE_READ ||
        protection == PAGE_EXECUTE_READWRITE || protection == PAGE_EXECUTE_WRITECOPY;
}

static void StripLineEnd(char *text)
{
    size_t length = strlen(text);
    while (length && (text[length - 1] == '\r' || text[length - 1] == '\n'))
        text[--length] = 0;
}

int main(int argc, char **argv)
{
    HMODULE luaModule;
    HMODULE coreModule;
    LuaOpenFunction luaOpen;
    LuaCloseFunction luaClose;
    LuaSetTopFunction luaSetTop;
    LuaPushNumberFunction luaPushNumber;
    LuaPushStringFunction luaPushString;
    LuaPushNilFunction luaPushNil;
    LuaNewTableFunction luaNewTable;
    LuaPushClosureFunction luaPushClosure;
    FILE *fixture;
    char line[4096];
    int total = 0;
    int passed = 0;
    int failed = 0;

    if (argc != 3) {
        fprintf(stderr, "usage: LuaApiBinarySmoke.exe <server-root> <fixture-tsv>\n");
        return 64;
    }
    SetErrorMode(SEM_FAILCRITICALERRORS | SEM_NOGPFAULTERRORBOX | SEM_NOOPENFILEERRORBOX);
    if (!SetCurrentDirectoryA(argv[1])) {
        fprintf(stderr, "ERROR\tSetCurrentDirectory\t%lu\n", GetLastError());
        return 65;
    }
    luaModule = LoadLibraryA("LuaLibDll.dll");
    if (!luaModule) {
        fprintf(stderr, "ERROR\tLoadLuaLibDll\t%lu\n", GetLastError());
        return 66;
    }
    coreModule = LoadLibraryA("CoreServer.dll");
    if (!coreModule) {
        fprintf(stderr, "ERROR\tLoadCoreServer\t%lu\n", GetLastError());
        return 67;
    }

    luaOpen = (LuaOpenFunction)GetProcAddress(luaModule, "lua_open");
    luaClose = (LuaCloseFunction)GetProcAddress(luaModule, "lua_close");
    luaSetTop = (LuaSetTopFunction)GetProcAddress(luaModule, "lua_settop");
    luaPushNumber = (LuaPushNumberFunction)GetProcAddress(luaModule, "lua_pushnumber");
    luaPushString = (LuaPushStringFunction)GetProcAddress(luaModule, "lua_pushstring");
    luaPushNil = (LuaPushNilFunction)GetProcAddress(luaModule, "lua_pushnil");
    luaNewTable = (LuaNewTableFunction)GetProcAddress(luaModule, "lua_newtable");
    luaPushClosure = (LuaPushClosureFunction)GetProcAddress(luaModule, "lua_pushcclosure");
    if (!luaOpen || !luaClose || !luaSetTop || !luaPushNumber || !luaPushString ||
        !luaPushNil || !luaNewTable || !luaPushClosure) {
        fprintf(stderr, "ERROR\tResolveLuaAbi\t%lu\n", GetLastError());
        return 68;
    }

    fixture = fopen(argv[2], "rb");
    if (!fixture) {
        fprintf(stderr, "ERROR\tOpenFixture\t%s\n", argv[2]);
        return 69;
    }
    while (fgets(line, sizeof(line), fixture)) {
        char *name;
        char *rvaText;
        char *kinds;
        unsigned long rva;
        LuaCFunction api;
        lua_State *state;
        int result = 0;
        unsigned long exceptionCode = 0;
        char kindsCopy[2048];
        char *kind;

        StripLineEnd(line);
        if (!line[0] || line[0] == '#')
            continue;
        name = strtok(line, "\t");
        rvaText = strtok(NULL, "\t");
        kinds = strtok(NULL, "\t");
        if (!name || !rvaText) {
            fprintf(stderr, "FAIL\tfixture-row\tmalformed\n");
            failed++;
            continue;
        }
        rva = strtoul(rvaText, NULL, 0);
        api = (LuaCFunction)(((unsigned char *)coreModule) + rva);
        if (!IsExecutableAddress((void *)api)) {
            fprintf(stderr, "FAIL\t%s\tnon-executable-rva\n", name);
            failed++;
            continue;
        }
        state = luaOpen(512);
        if (!state) {
            fprintf(stderr, "FAIL\t%s\tlua-open\n", name);
            failed++;
            continue;
        }
        luaSetTop(state, 0);
        kindsCopy[0] = 0;
        if (kinds) {
            strncpy(kindsCopy, kinds, sizeof(kindsCopy) - 1);
            kindsCopy[sizeof(kindsCopy) - 1] = 0;
        }
        kind = kindsCopy[0] ? strtok(kindsCopy, ",") : NULL;
        while (kind) {
            if (!strcmp(kind, "string"))
                luaPushString(state, "");
            else if (!strcmp(kind, "nil"))
                luaPushNil(state);
            else if (!strcmp(kind, "table"))
                luaNewTable(state);
            else if (!strcmp(kind, "function"))
                luaPushClosure(state, SmokeNoop, 0);
            else
                luaPushNumber(state, 0.0);
            kind = strtok(NULL, ",");
        }

        __try {
            result = api(state);
        }
        __except(EXCEPTION_EXECUTE_HANDLER) {
            exceptionCode = GetExceptionCode();
        }
        if (exceptionCode) {
            fprintf(stderr, "FAIL\t%s\tseh-0x%08lX\n", name, exceptionCode);
            failed++;
        } else {
            printf("PASS\t%s\t%d\n", name, result);
            passed++;
        }
        total++;
        luaClose(state);
    }
    fclose(fixture);
    printf("SUMMARY\t%d\t%d\t%d\n", total, passed, failed);
    return failed ? 1 : 0;
}
