#ifndef PHONGTHAN_ROLE_CREATION_LAYOUT_H
#define PHONGTHAN_ROLE_CREATION_LAYOUT_H

// Original VNG UI schema keys; the artwork is Giap Sy / Dao Sy / Di Nhan.
static const unsigned long PHONGTHAN_PAK_NEWPLAYER = 0xB705E9D8UL;
static const char* const PHONGTHAN_NEWPLAYER_SECTIONS[3] = {"Gold", "Wood", "Water"};

static bool PhongThanAdaptRoleCreationLayout(KIniFile& ini, int width, int height)
{
    if (!ini.IsSectionExist("NewPlayer") || !ini.IsSectionExist("EditBG") ||
        !ini.IsSectionExist("Name") || !ini.IsSectionExist("OK") ||
        !ini.IsSectionExist("Cancel"))
        return false;
    for (int i = 0; i < 3; ++i)
        if (!ini.IsSectionExist(PHONGTHAN_NEWPLAYER_SECTIONS[i]))
            return false;
    int x = (width - 800) / 2, y = (height - 600) / 2;
    ini.WriteInteger("NewPlayer", "Left", 0);
    ini.WriteInteger("NewPlayer", "Top", 0);
    ini.WriteInteger("NewPlayer", "Width", width);
    ini.WriteInteger("NewPlayer", "Height", height);
    const char* sections[] = {"Male", "Female", "Name", "EditBG", "PropertyShow", "OK", "Cancel"};
    for (i = 0; i < sizeof(sections) / sizeof(sections[0]); ++i)
    {
        int left, top;
        ini.GetInteger(sections[i], "Left", 0, &left);
        ini.GetInteger(sections[i], "Top", 0, &top);
        ini.WriteInteger(sections[i], "Left", left + x);
        ini.WriteInteger(sections[i], "Top", top + y);
    }
    // The selectors belong to VNG's ButtonGroup. Apply its final animation
    // position once to both drawing and input coordinates.
    int count = 0, groupX = 0, groupY = 0;
    ini.GetInteger("ButtonGroup", "PosCount", 0, &count);
    if (count > 0 && count <= 100)
    {
        char last[16];
        sprintf(last, "%d", count - 1);
        ini.GetInteger2("ButtonGroup", last, &groupX, &groupY);
    }
    for (i = 0; i < 3; ++i)
    {
        int left, top;
        ini.GetInteger(PHONGTHAN_NEWPLAYER_SECTIONS[i], "Left", 0, &left);
        ini.GetInteger(PHONGTHAN_NEWPLAYER_SECTIONS[i], "Top", 0, &top);
        ini.WriteInteger(PHONGTHAN_NEWPLAYER_SECTIONS[i], "Left", left + groupX + x);
        ini.WriteInteger(PHONGTHAN_NEWPLAYER_SECTIONS[i], "Top", top + groupY + y);
    }
    ini.WriteInteger("EditBG", "DummyWnd", 1);
    return true;
}
#endif
