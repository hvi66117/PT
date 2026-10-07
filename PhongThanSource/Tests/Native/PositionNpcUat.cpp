#include <windows.h>
#include <stdio.h>
#include "../../Sources/MultiServer/Goddess/PhongThanCharacterStore.h"

// Only the test character created by PhongThanLoginProbe may be positioned.
// Invoke while staging services are stopped; user gameplay characters untouched.
int main(int argc, char** argv)
{
    if (argc != 2 && argc != 3) return 2;
    CPhongThanCharacterStore store;
    BYTE bytes[PHONGTHAN_CHARACTER_MAX_STATE_SIZE];
    PHONGTHAN_U32 size=0;
    if (!store.Open(argv[1]) || !store.Load("PhongThanNpc",bytes,sizeof(bytes),&size)) return 3;
    PHONGTHAN_CHARACTER_STATE_HEADER* role=(PHONGTHAN_CHARACTER_STATE_HEADER*)bytes;
    if (strcmp((const char*)role->AccountName,"123456") || strcmp((const char*)role->RoleName,"PhongThanNpc")) return 4;
    role->EnterMapId=1052; role->EnterX=50824; role->EnterY=96855;
    if(argc==3){
        if(!strcmp(argv[2],"authored-dieutri")){
            role->EnterMapId=1052;role->EnterX=48256;role->EnterY=102624;
        }else if(!strcmp(argv[2],"viewport-ngochu")){
            // Chuyen Sinh Lao Lao is 992 MPS below this point: within the
            // projected viewport, outside the obsolete 800-MPS circle.
            role->EnterMapId=1003;role->EnterX=54400;role->EnterY=99616;
        }else return 6;
    }
    role->UseRevive=0;
    if (!store.Save(role,size)) return 5;
    printf("Positioned diagnostic PhongThanNpc map=%u x=%d y=%d; other characters unchanged\n",role->EnterMapId,role->EnterX,role->EnterY);
    return 0;
}
