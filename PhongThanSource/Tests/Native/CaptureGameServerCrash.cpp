#include <windows.h>
#include <stdio.h>
#include <stdlib.h>
struct DumpException {DWORD ThreadId; EXCEPTION_POINTERS* ExceptionPointers; BOOL ClientPointers;};
typedef BOOL (WINAPI* WriteDump)(HANDLE,DWORD,HANDLE,DWORD,DumpException*,void*,void*);
typedef BOOL (WINAPI* KillOnExit)(BOOL);
typedef BOOL (WINAPI* Detach)(DWORD);
typedef HANDLE (WINAPI* OpenThreadFn)(DWORD,BOOL,DWORD);
int main(int argc,char**argv)
{
    if(argc!=3)return 2;
    DWORD pid=atoi(argv[1]);
    if(!DebugActiveProcess(pid))return 3;
    KillOnExit keep=(KillOnExit)GetProcAddress(GetModuleHandleA("kernel32.dll"),"DebugSetProcessKillOnExit");
    Detach detach=(Detach)GetProcAddress(GetModuleHandleA("kernel32.dll"),"DebugActiveProcessStop");
    OpenThreadFn openThread=(OpenThreadFn)GetProcAddress(GetModuleHandleA("kernel32.dll"),"OpenThread");
    if(keep)keep(FALSE);
    HANDLE process=OpenProcess(PROCESS_ALL_ACCESS,FALSE,pid);
    HMODULE dbg=LoadLibraryA("Dbghelp.dll");
    WriteDump dump=dbg?(WriteDump)GetProcAddress(dbg,"MiniDumpWriteDump"):0;
    DEBUG_EVENT ev; DWORD until=GetTickCount()+180000; bool exited=false;
    printf("Attached GameServer PID=%u\n",pid);fflush(stdout);
    while(GetTickCount()<until){
        if(!WaitForDebugEvent(&ev,1000))continue;
        DWORD status=DBG_CONTINUE;
        if(ev.dwDebugEventCode==EXCEPTION_DEBUG_EVENT){
            EXCEPTION_DEBUG_INFO& ex=ev.u.Exception;
            if(ex.ExceptionRecord.ExceptionCode!=EXCEPTION_BREAKPOINT)status=DBG_EXCEPTION_NOT_HANDLED;
            if(!ex.dwFirstChance){
                HANDLE thread=openThread(THREAD_GET_CONTEXT|THREAD_QUERY_INFORMATION,FALSE,ev.dwThreadId);
                CONTEXT ctx;ZeroMemory(&ctx,sizeof(ctx));ctx.ContextFlags=CONTEXT_FULL;
                GetThreadContext(thread,&ctx);
                EXCEPTION_POINTERS pointers={&ex.ExceptionRecord,&ctx};
                DumpException info={ev.dwThreadId,&pointers,FALSE};
                HANDLE file=CreateFileA(argv[2],GENERIC_WRITE,0,0,CREATE_NEW,FILE_ATTRIBUTE_NORMAL,0);
                if(file!=INVALID_HANDLE_VALUE && dump)dump(process,pid,file,0x1000,&info,0,0);
                if(file!=INVALID_HANDLE_VALUE)CloseHandle(file);
                CloseHandle(thread);
                printf("SECOND_CHANCE code=%08X address=%p eip=%08X esp=%08X dump=%s\n",
                    ex.ExceptionRecord.ExceptionCode,ex.ExceptionRecord.ExceptionAddress,ctx.Eip,ctx.Esp,argv[2]);fflush(stdout);
            }
        }else if(ev.dwDebugEventCode==LOAD_DLL_DEBUG_EVENT && ev.u.LoadDll.hFile)CloseHandle(ev.u.LoadDll.hFile);
        else if(ev.dwDebugEventCode==CREATE_PROCESS_DEBUG_EVENT && ev.u.CreateProcessInfo.hFile)CloseHandle(ev.u.CreateProcessInfo.hFile);
        else if(ev.dwDebugEventCode==EXIT_PROCESS_DEBUG_EVENT)exited=true;
        ContinueDebugEvent(ev.dwProcessId,ev.dwThreadId,status);
        if(exited)break;
    }
    if(!exited && detach)detach(pid);
    CloseHandle(process);
    printf("Debugger ended exited=%d\n",exited);return 0;
}
