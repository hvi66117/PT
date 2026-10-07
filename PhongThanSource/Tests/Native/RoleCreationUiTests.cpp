#include <windows.h>
#include <stdio.h>
#include <string.h>
#include "KWin32.h"
#include "KFilePath.h"
#include "KPakFile.h"
#include "KPakList.h"
#include "KIniFile.h"
#include "../../Sources/GameClient/Ui/UiCase/PhongThanRoleCreationLayout.h"

#define CHECK(x) do { if (!(x)) { printf("FAIL line=%d: %s\n", __LINE__, #x); return 1; } } while(0)
static bool CheckSpr(const char* path)
{
    SPROFFS* offsets = NULL;
    SPRHEAD* header = SprGetHeader((char*)path, offsets);
    if (!header) { printf("MISSING_SPR %s\n", path); return false; }
    bool ok = header->Width > 0 && header->Height > 0 && header->Frames > 0;
    if (ok && !offsets) {
        SPRFRAME* frame = SprGetFrame(header, 0);
        ok = frame != NULL;
        if (frame) SprReleaseFrame(frame);
    }
    SprReleaseHeader(header);
    return ok;
}
int main()
{
    g_SetRootPath(NULL);
    KPakList packs;
    CHECK(packs.Open("\\package.ini"));
    g_pPakList = &packs;
    g_SetPakFileMode(1);
    KIniFile ini, worlds;
    CHECK(ini.LoadPakEntry(PHONGTHAN_PAK_NEWPLAYER));
    CHECK(worlds.Load("\\settings\\WorldSet.ini"));
    CHECK(PhongThanAdaptRoleCreationLayout(ini, 1024, 768));
    int value = 0;
    CHECK(ini.GetInteger("NewPlayer", "Width", 0, &value) && value == 1024);
    CHECK(ini.GetInteger("NewPlayer", "Height", 0, &value) && value == 768);
    CHECK(ini.GetInteger("Gold", "Left", 0, &value) && value == 341);
    CHECK(ini.GetInteger("Gold", "Top", 0, &value) && value == 262);
    CHECK(ini.GetInteger("Name", "Left", 0, &value) && value == 469);
    CHECK(ini.GetInteger("Name", "Top", 0, &value) && value == 571);
    CHECK(ini.GetInteger("EditBG", "DummyWnd", 0, &value) && value == 1);
    const char* buttons[] = {"Gold", "Wood", "Water", "OK", "Cancel", "EditBG"};
    for (int i = 0; i < 6; ++i) {
        char image[256];
        CHECK(ini.GetString(buttons[i], "Image", "", image, sizeof(image)));
        CHECK(CheckSpr(image));
    }
    const char* attr[] = {"\xBD\xF0", "\xC4\xBE", "\xCB\xAE"};
    const char* gender[] = {"\xC4\xD0", "\xC5\xAE"};
    char prefix[128];
    CHECK(ini.GetString("NewPlayer", "PlayerImgPrefix", "", prefix, sizeof(prefix)));
    for (i = 0; i < 3; ++i) {
        char key[24], mapName[128];
        sprintf(key, "%d", i);
        CHECK(ini.GetInteger("Nativeplace", key, 0, &value) && value > 0);
        int runtimeMap = value < 1000 ? value + 1000 : value;
        sprintf(key, "%d", runtimeMap);
        CHECK(worlds.GetString("List", key, "", mapName, sizeof(mapName)) && mapName[0]);
        for (int sex = 0; sex < 2; ++sex)
            for (int action = 0; action < 3; ++action) {
                char image[256];
                sprintf(image, "%s_%s_%s_%d.spr", prefix, attr[i], gender[sex], action);
                CHECK(CheckSpr(image));
            }
        printf("PASS profession=%d native_map=%d male/female idle/select/unselect SPRs\n", i, runtimeMap);
    }
    KIniFile empty;
    CHECK(!PhongThanAdaptRoleCreationLayout(empty, 1024, 768));
    g_pPakList = NULL;
    puts("PASS VNG role creation schema, button assets, 18 character SPRs, 1024x768 layout, missing-schema guard");
    return 0;
}
