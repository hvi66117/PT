#ifndef PHONGTHAN_ITEM_PICKER_CATALOG_H
#define PHONGTHAN_ITEM_PICKER_CATALOG_H
// Shared by the live bag and the catalog audit/export tool. ItemGen provides
// the already-parsed registry; never reinterpret the VNG columns here.
struct PTB_Record {
    int genre, detail, particular, level, series, row;
    const char* name;
};
static bool PTB_Resolve(int category, int key, PTB_Record& record)
{
    memset(&record, 0, sizeof(record));
    record.row = -1; record.series = 0; record.level = 1;
    if (key < 0 || key > 999999 || (category == 0 && key == PHONGTHAN_STARTER_BAG_ID)) return false;
    const KLibOfBPT& lib = ItemGen.Catalog();
    if (category == 0) {
        const KBASICPROP_MAGICSCRIPT* p = lib.GetMagicScript(key);
        if (!p || p->m_nItemGenre != item_magicscript || !p->m_szName[0] || p->m_nWidth <= 0 || p->m_nHeight <= 0) return false;
        record.genre = item_magicscript; record.detail = p->m_nDetailType; record.name = p->m_szName;
    } else if (category >= 1 && category <= 11) {
        // User-facing row 1 = first data record, excluding the heading row.
        if (key < 1 || key > ItemGen.CatalogEquipmentCount(category - 1)) return false;
        const KBASICPROP_EQUIPMENT* p = ItemGen.CatalogEquipment(category - 1, key - 1);
        if (!p || p->m_nDetailType != category - 1 || !p->m_szName[0] || p->m_nWidth <= 0 || p->m_nHeight <= 0) return false;
        record.genre = item_equip; record.detail = p->m_nDetailType;
        record.particular = p->m_nParticularType; record.level = p->m_nLevel;
        record.series = p->m_nSeries; record.row = key - 1; record.name = p->m_szName;
    } else if (category == 12) {
        if (key < 1 || key > lib.GetIBItemRecordNumber()) return false;
        const KBASICPROP_IBITEM* p = lib.IBItemAt(key - 1);
        if (!p || !p->m_szName[0] || p->m_nWidth <= 0 || p->m_nHeight <= 0) return false;
        record.genre = item_ibitem; record.detail = p->m_nDetailType;
        record.particular = p->m_nParticularType; record.name = p->m_szName;
    } else if (category == 13) {
        const KBASICPROP_EVENTITEM* p = lib.GetMaterial(key);
        if (!p || !p->m_szName[0] || p->m_nWidth <= 0 || p->m_nHeight <= 0) return false;
        record.genre = item_materials; record.detail = p->m_nDetailType; record.name = p->m_szName;
    } else if (category == 14) {
        const KBASICPROP_QUEST* p = lib.GetQuestRecord(key);
        if (!p || !p->m_szName[0] || p->m_nWidth <= 0 || p->m_nHeight <= 0) return false;
        record.genre = item_task; record.detail = p->m_nDetailType; record.name = p->m_szName;
    } else return false;
    return true;
}
static void PTB_Name(const char* source, char* dest, int capacity)
{
    int n = 0;
    while (source && *source && n + 1 < capacity) {
        if (*source == '<') { const char* end = strchr(source, '>'); if (end) { source = end + 1; continue; } }
        unsigned char ch = (unsigned char)*source++;
        if (ch < 32 || ch == '#' || ch == '$' || ch == '|') continue;
        dest[n++] = ch;
    }
    dest[n] = 0;
}
#endif
