// Server-owned item picker. Client sends only a number with a one-use dialog
// token; item category/identity and confirmation callbacks stay on the server.
#ifdef _SERVER
#include "KItemGenerator.h"
#include "PhongThanStarterBag.h"

static const char* PTB_Groups[] = {
    "MagicScript (ID)", "Vu khi gan", "Vu khi xa", "Giap", "Nhan", "Day chuyen",
    "Giay", "That lung", "Mu", "Ho uyen", "Boi", "Thu cuoi",
    "Ky tran cac / IBItem", "Nguyen lieu (ID)", "Nhiem vu (ID)"
};
#include "PhongThanItemPickerCatalog.h"
static bool PTB_OwnsBag(KPlayer& player)
{
    // Require the live item in the player's possession on every step, not just
    // when the first screen opens. A dropped/deleted bag cannot keep granting.
    for (PlayerItem* p = player.m_ItemList.GetFirstItem(); p; p = player.m_ItemList.GetNextItem()) {
        if (p->nIdx > 0 && p->nIdx < MAX_ITEM &&
            Item[p->nIdx].GetGenre() == item_magicscript && Item[p->nIdx].GetDetailType() == PHONGTHAN_STARTER_BAG_ID)
            return true;
    }
    return false;
}
static bool PTB_HasBag(KPlayer& player)
{
    if (player.m_nIndex <= 0 || player.m_nIndex >= MAX_NPC || player.CheckTrading()) return false;
    const int world = Npc[player.m_nIndex].m_SubWorldIndex;
    return world >= 0 && world < MAX_SUBWORLD && Npc[player.m_nIndex].m_CurrentLife > 0 && PTB_OwnsBag(player);
}
static void PTB_Menu(KPlayer& player, const char* title, const char* const* labels, const char* const* callbacks, int count)
{
    if (count < 0 || count > MAX_ANSWERNUM) return;
    KPhongThanScriptAction action;
    memset(&action, 0, sizeof(action));
    action.Operation = PHONGTHAN_SCRIPT_SHOW; action.View = UI_SELECTDIALOG;
    action.ServerOwned = 1; action.NumberArgument = -1;
    g_StrCpyLen(action.Content, title, sizeof(action.Content));
    memset(player.m_szTaskAnswerFun, 0, sizeof(player.m_szTaskAnswerFun));
    for (int i = 0; i < count; ++i) {
        int used = strlen(action.Content);
        if (used + strlen(labels[i]) + 2 >= sizeof(action.Content)) return;
        strcat(action.Content, "|"); strcat(action.Content, labels[i]);
        g_StrCpyLen(player.m_szTaskAnswerFun[i], callbacks[i], sizeof(player.m_szTaskAnswerFun[i]));
    }
    player.m_nAvailableAnswerNum = count; player.m_bWaitingPlayerFeedBack = true;
    action.OptionCount = count; action.ContentLength = strlen(action.Content);
    player.DoScriptAction(&action);
}
static void PTB_GroupsMenu(KPlayer& player, const char* title)
{
    char callback[16][32]; const char* labels[16]; const char* functions[16];
    for (int i = 0; i < 15; ++i) { labels[i] = PTB_Groups[i]; sprintf(callback[i], "PTB:I:%d", i); functions[i] = callback[i]; }
    labels[15] = "Dong"; functions[15] = "PTB:X";
    PTB_Menu(player, title, labels, functions, 16);
}
static void PTB_Input(KPlayer& player, int category)
{
    if (category < 0 || category >= 15) return;
    KPhongThanScriptAction action;
    memset(&action, 0, sizeof(action));
    action.Operation = PHONGTHAN_SCRIPT_SHOW; action.View = UI_NUMBER_INPUT;
    action.ServerOwned = 1; action.NumberArgument = 999999;
    // Original VNG input title is 112px wide, so keep it deliberately short.
    strcpy(action.Content, category == 0 || category >= 13 ? "Nhap ID" : "Nhap STT");
    action.ContentLength = strlen(action.Content);
    sprintf(player.m_szTaskAnswerFun[0], "PTB:I:%d", category);
    player.m_nAvailableAnswerNum = 0; player.m_bWaitingPlayerFeedBack = false;
    player.DoScriptAction(&action);
}
static bool PTB_Add(KPlayer& player, const PTB_Record& record)
{
    int levels[MAX_ITEM_MAGICLEVEL]; memset(levels, 0, sizeof(levels));
    int idx = ItemSet.Add(record.genre, record.series, record.level, 0,
        record.detail, record.particular, levels, g_SubWorldSet.GetGameVersion(), 0, record.row);
    if (idx <= 0 || idx >= MAX_ITEM) return false;
    if (Item[idx].GetGenre() != record.genre || Item[idx].GetDetailType() != record.detail ||
        Item[idx].GetWidth() <= 0 || Item[idx].GetHeight() <= 0) { ItemSet.Remove(idx); return false; }
    POINT size; size.x = Item[idx].GetWidth(); size.y = Item[idx].GetHeight();
    if (player.m_ItemList.Add(idx, size, false) <= 0) { ItemSet.Remove(idx); return false; }
    FILE* log = fopen("starterbag_grants.log", "a");
    if (log) { fprintf(log, "account=%s genre=%d detail=%d row=%d uid=%lu\n", player.AccountName,
        record.genre, record.detail, record.row, Item[idx].GetID()); fclose(log); }
    return true;
}
static void PTB_Preview(KPlayer& player, int category, int key, bool grant)
{
    PTB_Record record;
    if (!PTB_Resolve(category, key, record)) { PTB_GroupsMenu(player, "Khong tim thay ID/STT hop le. Hay tra dung nhom."); return; }
    char name[128], title[320], give[48], again[32];
    PTB_Name(record.name, name, sizeof(name));
    if (grant) {
        bool added = PTB_Add(player, record);
        sprintf(title, "%s: %s (ma %d)", added ? "Da nhan vao F4" : "Khong nhan duoc (kiem tra cho trong F4)", name, key);
    } else sprintf(title, "%s\nMa %d: %s\nNhan 1 vat pham?", PTB_Groups[category], key, name);
    sprintf(give, "PTB:G:%d:%d", category, key); sprintf(again, "PTB:I:%d", category);
    const char* labels[] = {grant ? "Nhan them 1" : "Xac nhan nhan 1", "Nhap ma khac", "Chon nhom khac", "Dong"};
    const char* callbacks[] = {give, again, "PTB:M", "PTB:X"};
    PTB_Menu(player, title, labels, callbacks, 4);
}
bool PhongThanOpenStarterBag(KPlayer& player, int itemIndex)
{
    if (itemIndex <= 0 || itemIndex >= MAX_ITEM || Item[itemIndex].GetDetailType() != PHONGTHAN_STARTER_BAG_ID ||
        Item[itemIndex].GetGenre() != item_magicscript || !PTB_HasBag(player)) return false;
    PTB_GroupsMenu(player, "Tui tan thu - nhan theo ID/STT. Trang bi: STT 1 la dong du lieu dau tien, khong tinh tieu de.");
    return true;
}
bool PhongThanStarterBagChoice(KPlayer& player, const char* callback)
{
    if (strncmp(callback, "PTB:", 4) != 0) return false;
    if (!PTB_HasBag(player)) return true;
    int category = -1, key = -1;
    if (!strcmp(callback, "PTB:M")) PTB_GroupsMenu(player, "Tui tan thu - chon nhom de nhap ma.");
    else if (sscanf(callback, "PTB:I:%d", &category) == 1) PTB_Input(player, category);
    else if (sscanf(callback, "PTB:G:%d:%d", &category, &key) == 2) PTB_Preview(player, category, key, true);
    return true;
}
void PhongThanStarterBagInput(KPlayer& player, const PHONGTHAN_UI_NUMBER_REQUEST& request)
{
    if (!PTB_HasBag(player) || player.m_UiDialogView != PHONGTHAN_VIEW_NUMBER_INPUT ||
        !player.m_UiDialogToken || request.DialogToken != player.m_UiDialogToken ||
        request.MapId != (PHONGTHAN_U32)SubWorld[Npc[player.m_nIndex].m_SubWorldIndex].m_SubWorldID) return;
    int category = -1;
    if (sscanf(player.m_szTaskAnswerFun[0], "PTB:I:%d", &category) != 1) return;
    player.m_UiDialogToken = 0; // consume before sending the next dialog
    player.m_UiDialogView = 0;
    player.m_szTaskAnswerFun[0][0] = 0;
    if (request.Value >= 0) PTB_Preview(player, category, request.Value, false);
}
void PhongThanGrantStarterBag(KPlayer& player)
{
    if (PTB_OwnsBag(player) || ItemGen.Catalog().GetMagicScript(PHONGTHAN_STARTER_BAG_ID)) return;
    KIniFile ini;
    if (!ini.Load("\\settings\\item\\PhongThanStarterBag.ini")) return;
    char accounts[512], target[40], wrapped[516];
    ini.GetString("Grant", "Accounts", "", accounts, sizeof(accounts));
    sprintf(target, ",%s,", player.AccountName); sprintf(wrapped, ",%s,", accounts);
    if (!strstr(wrapped, target)) return;
    PTB_Record record; memset(&record, 0, sizeof(record));
    record.genre = item_magicscript; record.detail = PHONGTHAN_STARTER_BAG_ID; record.level = 1; record.row = -1;
    PTB_Add(player, record);
}
#endif
