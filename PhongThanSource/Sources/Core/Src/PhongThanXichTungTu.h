#ifndef PHONGTHAN_XICH_TUNG_TU_H
#define PHONGTHAN_XICH_TUNG_TU_H

// Original PAK Region_S: Dieu Tri, passerby058, script entry D02B148D.
// Template 206 alone is an appearance, not a unique NPC service identity.
#define PT_XICH_TUNG_TU_SCRIPT "\\script\\phongthan\\npc_services\\xich_tung_tu.lua"
inline bool PhongThanIsXichTungTu(int world, int npcTemplate, DWORD scriptId)
{
    return world == 1052 && npcTemplate == 206 &&
        (scriptId == 0xD02B148DUL || scriptId == g_FileName2Id(PT_XICH_TUNG_TU_SCRIPT));
}
#endif
