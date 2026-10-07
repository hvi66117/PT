#ifndef PHONGTHAN_STARTER_BAG_PROPERTY_H
#define PHONGTHAN_STARTER_BAG_PROPERTY_H
// Project-only item, separate from the untouched VNG MagicScript table.
static const KBASICPROP_MAGICSCRIPT* PhongThanStarterBagProperty(const KLibOfBPT& catalog)
{
    static KBASICPROP_MAGICSCRIPT value;
    static bool loaded = false;
    if (!loaded) {
        loaded = true;
        KIniFile ini;
        if (!ini.Load("\\settings\\item\\PhongThanStarterBag.ini")) return NULL;
        memset(&value, 0, sizeof(value));
        ini.GetString("Item", "Name", "Tui tan thu", value.m_szName, sizeof(value.m_szName));
        int iconId = -1;
        ini.GetInteger("Item", "IconMagicScriptId", -1, &iconId);
        const KBASICPROP_MAGICSCRIPT* icon = catalog.GetMagicScript(iconId);
        if (!icon) return NULL;
        strncpy(value.m_szImageName, icon->m_szImageName, sizeof(value.m_szImageName) - 1);
        ini.GetString("Item", "Intro", "Nhan vat pham bang ID.", value.m_szIntro, sizeof(value.m_szIntro));
        value.m_nItemGenre = item_magicscript;
        value.m_nDetailType = PHONGTHAN_STARTER_BAG_ID;
        value.m_nObjIdx = 39;
        value.m_nWidth = value.m_nHeight = value.m_nMaxStack = 1;
    }
    return value.m_szImageName[0] ? &value : NULL;
}
#endif
