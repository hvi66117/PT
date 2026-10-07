#include <windows.h>
#include <stdio.h>
#include <string.h>
#include "../../Sources/MultiServer/Goddess/PhongThanCharacterStore.h"
struct Spec { int detail, row, particular; };
static const Spec specs[] = {
    {2,2109,210},{7,2109,210},{6,2109,210},{5,2109,210},{9,2109,210},
    {2,519,51},{7,519,51},{6,519,51},{5,519,51},{9,519,51},
    {0,59,5},{10,249,24}
};
int main(int argc,char** argv)
{
    if(argc!=3) return 2;
    CPhongThanCharacterStore store;
    BYTE data[PHONGTHAN_CHARACTER_MAX_STATE_SIZE], verify[PHONGTHAN_CHARACTER_MAX_STATE_SIZE];
    PHONGTHAN_U32 size=0;
    if(!store.Open(argv[1]) || !store.Load(argv[2],data,sizeof(data),&size)) return 3;
    PHONGTHAN_CHARACTER_STATE_HEADER* role=(PHONGTHAN_CHARACTER_STATE_HEADER*)data;
    if(strncmp((const char*)role->AccountName,"123456",32)) return 4;
    if(size+12*sizeof(PHONGTHAN_CHARACTER_ITEM_RECORD)>sizeof(data) || role->ItemCount+12>PHONGTHAN_CHARACTER_MAX_ITEMS) return 5;
    PHONGTHAN_CHARACTER_ITEM_RECORD* items=PhongThanCharacterItems(role);
    bool occupied[10]={false};
    // Reserve every existing item's row and the next three rows. This is
    // conservative for the current inventory and never moves existing items.
    for(unsigned i=0;i<role->ItemCount;++i)
        if(items[i].Container==3)
            for(int y=items[i].SlotY;y<items[i].SlotY+4 && y<10;++y)
                if(y>=0) occupied[y]=true;
    int freeSlots[60], count=0;
    for(int y=0;y<10;++y) if(!occupied[y])
        for(int x=0;x<6;++x) freeSlots[count++]=y*6+x;
    if(count<12) { puts("Not enough verified free space; no changes saved"); return 6; }
    unsigned oldCount=role->ItemCount;
    for(int s=0;s<12;++s)
    {
        PHONGTHAN_CHARACTER_ITEM_RECORD& item=items[role->ItemCount++];
        ZeroMemory(&item,sizeof(item));
        item.SchemaVersion=PHONGTHAN_EMBEDDED_ITEM_VERSION;
        item.TemplateRow=specs[s].row; item.Genre=0; item.Container=3;
        item.SlotX=freeSlots[s]%6; item.SlotY=freeSlots[s]/6;
        item.DetailType=specs[s].detail; item.ParticularType=specs[s].particular;
        item.Level=10; item.Series=0; item.TableVersion=1;
        item.RandomSeed=0x20260918+s; item.Durability=-2; item.StackCount=1;
        printf("ADD detail=%d row=%d slot=%d,%d\n",item.DetailType,item.TemplateRow,item.SlotX,item.SlotY);
    }
    role->StateSize=PhongThanCharacterExpectedStateSize(role);
    if(!PhongThanValidateCharacterState(role,role->StateSize) || !store.Save(role,role->StateSize)) return 7;
    PHONGTHAN_U32 n=0;
    if(!store.Load(argv[2],verify,sizeof(verify),&n) || n!=role->StateSize || memcmp(data,verify,n)) return 8;
    printf("PASS saved role=%s old_items=%u new_items=%u preserved_existing=1\n",argv[2],oldCount,role->ItemCount);
    return 0;
}
