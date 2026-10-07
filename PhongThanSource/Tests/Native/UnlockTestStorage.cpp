#include <windows.h>
#include <stdio.h>
#include <string.h>
#include "../../Sources/MultiServer/Goddess/PhongThanCharacterStore.h"

int main(int argc, char** argv)
{
    if (argc != 3) return 2;
    CPhongThanCharacterStore store;
    BYTE state[PHONGTHAN_CHARACTER_MAX_STATE_SIZE];
    PHONGTHAN_U32 size = 0;
    if (!store.Open(argv[1]) || !store.Load(argv[2], state, sizeof(state), &size)) return 3;
    PHONGTHAN_CHARACTER_STATE_HEADER* role = (PHONGTHAN_CHARACTER_STATE_HEADER*)state;
    if (strncmp((const char*)role->AccountName, "123456", sizeof(role->AccountName))) return 4;
    const unsigned old = role->ExtraBox;
    role->ExtraBox = 5;
    if (!store.Save(role, size)) return 5;
    BYTE saved[PHONGTHAN_CHARACTER_MAX_STATE_SIZE];
    PHONGTHAN_U32 savedSize = 0;
    if (!store.Load(argv[2], saved, sizeof(saved), &savedSize) || savedSize != size ||
        memcmp(saved, state, size)) return 6;
    printf("PASS role=%s expanded_chests=%u->5 items=%u saved_and_verified\n",
        argv[2], old, role->ItemCount);
    return 0;
}
