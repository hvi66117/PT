// Read-only diagnosis of the active client's region/render memberships.
#define private public
#define protected public
#include "KCore.h"
#include "KNpc.h"
#include "Scene/KIpotLeaf.h"
#undef private
#undef protected
#include <tlhelp32.h>
#include <stdio.h>
int main(int argc,char** argv)
{
    if(argc!=4)return 2;
    DWORD pid=strtoul(argv[1],0,10),rva=strtoul(argv[2],0,16),base=0;
    HANDLE snap=CreateToolhelp32Snapshot(TH32CS_SNAPMODULE,pid);
    MODULEENTRY32 m;ZeroMemory(&m,sizeof(m));m.dwSize=sizeof(m);
    if(Module32First(snap,&m))do{
        if(!lstrcmpiA(m.szModule,"CoreClient.dll")){base=(DWORD)m.modBaseAddr;break;}
    }while(Module32Next(snap,&m));
    CloseHandle(snap);if(!base)return 3;
    HANDLE process=OpenProcess(PROCESS_VM_READ|PROCESS_QUERY_INFORMATION,FALSE,pid);
    if(!process)return 4;
    KNpc* n=(KNpc*)malloc(sizeof(KNpc));
    printf("base=%08X sizeof_npc=%u\n",base,sizeof(KNpc));
    for(int i=1;i<=atoi(argv[3]);++i){
        SIZE_T got=0;
        if(!ReadProcessMemory(process,(void*)(base+rva+i*sizeof(KNpc)),n,sizeof(KNpc),&got))return 5;
        if(n->m_Index!=i)continue;
        printf("npc=%d id=%u kind=%d region=%d rid=%08X pos=%d,%d scene=%08X sync=%d name=%.31s\n",
            i,n->m_dwID,n->m_Kind,n->m_RegionIndex,n->m_dwRegionID,n->m_DataRes.m_nXpos,n->m_DataRes.m_nYpos,
            n->m_DataRes.m_SceneID,n->m_SyncSignal,n->Name);
        if(n->m_DataRes.m_SceneID){
            KIpotRuntimeObj leaf;
            if(ReadProcessMemory(process,(void*)n->m_DataRes.m_SceneID,&leaf,sizeof(leaf),&got))
                printf(" leaf id=%d pos=%d,%d branch=%p parent=%p ahead=%p next=%p\n",leaf.nId,leaf.oPosition.x,leaf.oPosition.y,
                    leaf.pParentBranch,leaf.pParentLeaf,leaf.pAheadBrother,leaf.pBrother);
        }
    }
    free(n);CloseHandle(process);return 0;
}
