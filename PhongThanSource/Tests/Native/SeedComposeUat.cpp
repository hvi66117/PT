#include <windows.h>
#include <stdio.h>
#include <string.h>
#include "../../Sources/MultiServer/Goddess/PhongThanCharacterStore.h"

// One-time fixture for the diagnostic role only. Run with services stopped.
int main(int argc, char** argv)
{
    if (argc != 2) return 2;
    CPhongThanCharacterStore store;
    BYTE bytes[PHONGTHAN_CHARACTER_MAX_STATE_SIZE];
    PHONGTHAN_U32 size=0;
    if (!store.Open(argv[1]) || !store.Load("PhongThanNpc",bytes,sizeof(bytes),&size)) return 3;
    PHONGTHAN_CHARACTER_STATE_HEADER* role=(PHONGTHAN_CHARACTER_STATE_HEADER*)bytes;
    if (strcmp((const char*)role->AccountName,"123456") ||
        strcmp((const char*)role->RoleName,"PhongThanNpc")) return 4;
    if (role->ItemCount > 1 || size + (role->ItemCount ? 0 : sizeof(PHONGTHAN_CHARACTER_ITEM_RECORD)) > sizeof(bytes)) return 5;
    PHONGTHAN_CHARACTER_ITEM_RECORD* item=role->ItemCount ? PhongThanCharacterItems(role) :
        (PHONGTHAN_CHARACTER_ITEM_RECORD*)(bytes+size);
    if (role->ItemCount && (item->Genre!=3 || item->DetailType!=30 || item->StackCount!=1)) return 5;
    ZeroMemory(item,sizeof(*item));
    item->SchemaVersion=PHONGTHAN_EMBEDDED_ITEM_VERSION;
    item->Genre=3;              // item_materials
    item->Container=3;          // pos_equiproom
    item->SlotX=0;item->SlotY=0;
    item->DetailType=29;        // VNG Bo Luc Nhan level 1
    item->Level=1;item->TableVersion=1;
    item->Durability=-2;item->StackCount=2;
    if (!role->ItemCount) { ++role->ItemCount; role->StateSize=size+sizeof(*item); }
    if (!store.Save(role,role->StateSize)) return 6;
    puts("Seeded diagnostic PhongThanNpc with exactly two VNG material 29 items; main role untouched");
    return 0;
}
