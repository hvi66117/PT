#include <windows.h>
#include <stdio.h>
#include "KWin32.h"
#include "KFilePath.h"
#include "KPakFile.h"
#include "KPakList.h"
#include "KTabFile.h"
int main(int argc,char**argv)
{
    if(argc!=3 || !SetCurrentDirectoryA(argv[1]))return 2;
    g_SetRootPath(NULL);g_SetFilePath("\\");KPakList packs;
    if(!packs.Open("\\package.ini"))return 3;
    g_SetPakFileMode(1);
    FILE* list=fopen(argv[2],"rb");if(!list)return 9;
    char path[256];int count=0;
    while(fgets(path,sizeof(path),list)){
        path[strcspn(path,"\r\n")]=0;if(!path[0])continue;
        ++count;
        KPakFile file;
        if(!file.Open(path) || !file.IsFileInPak())return 4;
        SPROFFS* offsets=0;SPRHEAD* head=SprGetHeader(path,offsets);
        if(!head || !head->Frames)return 5;
        for(int f=0;f<head->Frames;++f){
            SPRFRAME* frame=offsets?(SPRFRAME*)((char*)offsets+head->Frames*8+offsets[f].Offset):SprGetFrame(head,f);
            if(!frame || !frame->Width || !frame->Height)return 6;
            if(!offsets)SprReleaseFrame(frame);
        }
        printf("PASS PAK_SPR_ALL_FRAMES path=%s frames=%u\n",path,head->Frames);
        SprReleaseHeader(head);
    }
    fclose(list);if(!count)return 10;
    KTabFile names;char display[32];
    if(!names.Load("\\settings\\phongthan\\NpcDisplayNames.txt"))return 7;
    if(!names.GetString("\xC8\xBC\xB5\xC6\xB5\xC0\xC8\xCB","DisplayName","",display,sizeof(display)) ||
        strcmp(display,"Nhien Dang Dao Nhan"))return 8;
    puts("PASS NPC_DISPLAY_NAME_REGISTRY");
    return 0;
}
