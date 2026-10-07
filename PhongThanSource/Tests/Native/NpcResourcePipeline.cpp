#include "KCore.h"
#include "KNpcResNode.h"
#include "CoreUseNameDef.h"
#include "KPakList.h"
#include "../../Sources/Represent/iRepresent/iRepresentShell.h"
#include <stdio.h>
iRepresentShell* g_pRepresent = NULL;
int main(int argc, char** argv)
{
    if(argc < 3 || !SetCurrentDirectoryA(argv[1])) return 2;
    g_SetRootPath(NULL); g_SetFilePath("\\"); KPakList packs;
    if(!packs.Open("\\package.ini"))return 3;
    g_SetPakFileMode(1);
    KTabFile templates;
    if(!templates.Load("\\settings\\Npcs.txt"))return 4;
    CActionName human, npc;
    if(!human.Init(ACTION_FILE_NAME) || !npc.Init(NPC_ACTION_NAME))return 5;
    int failures=0;
    for(int i=2;i<argc;++i){
        int id=atoi(argv[i]); char type[80], path[256];
        templates.GetString(id+2,"NpcResType","",type,sizeof(type));
        KNpcResNode node;
        if(!node.Init(type,&human,&npc)){
            printf("FAIL template=%d type=%s resource_init\n",id,type); ++failures; continue;
        }
        node.GetFileName(NORMAL_NPC_PART_NO,node.GetActNo(cdo_stand,0,FALSE),0,"",path,sizeof(path));
        SPROFFS* offsets=NULL; SPRHEAD* head=path[0]?SprGetHeader(path,offsets):NULL;
        if(!head){printf("FAIL template=%d type=%s stand=%s\n",id,type,path);++failures;}
        else{printf("PASS template=%d type=%s stand=%s frames=%d\n",id,type,path,head->Frames);SprReleaseHeader(head);}
    }
    return failures?1:0;
}
