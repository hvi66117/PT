// Original VNG Region_S NPC section: 12-byte header followed by 60-byte
// records and counted script names. Never read beyond the section into objects.
BOOL KRegion::LoadServerNpc(int nSubWorld, KPakFile* file, DWORD size)
{
    const unsigned int prefix = sizeof(KSPNpc) - sizeof(((KSPNpc*)0)->szScript);
    if (!file || nSubWorld < 0 || nSubWorld >= MAX_SUBWORLD)
        return FALSE;
    // Authored NPC restoration is an explicit, map/region-scoped replacement
    // of this section, not a second spawn pass. Original PAKs stay untouched.
    KPakFile restored;
    char restoredPath[128];
    sprintf(restoredPath,
        "\\settings\\phongthan\\npc_regions\\%d\\v_%03d\\%03d_region_s.dat",
        SubWorld[nSubWorld].m_SubWorldID, HIWORD(m_RegionID), LOWORD(m_RegionID));
    BOOL usingRestored = restored.Open(restoredPath);
    if (usingRestored)
    {
        DWORD sections = 0, entry[2] = {0, 0};
        if (restored.Read(&sections, 4) != 4 || sections < 6 || sections > 64)
            return FALSE;
        const DWORD header = 4 + sections * 8;
        if (header > restored.Size() || restored.Seek(20, FILE_BEGIN) != 20 ||
            restored.Read(entry, 8) != 8 || entry[0] > restored.Size() - header ||
            entry[1] > restored.Size() - header - entry[0])
            return FALSE;
        restored.Seek(header + entry[0], FILE_BEGIN);
        file = &restored;
        size = entry[1];
    }
    else if (size == 0)
    {
        // Sparse worlds need no invented Region_S geometry. The original
        // standalone Npc_S.dat payload is KNpcFileHead + KSPNpc records.
        // Only use it where the base has no NPC section; never double-spawn
        // or replace original NPCs when a future PAK supplies this cell.
        sprintf(restoredPath,
            "\\settings\\phongthan\\npc_regions\\%d\\v_%03d\\%03d_npc_s.dat",
            SubWorld[nSubWorld].m_SubWorldID, HIWORD(m_RegionID), LOWORD(m_RegionID));
        usingRestored = restored.Open(restoredPath);
        if (usingRestored)
        {
            file = &restored;
            size = restored.Size();
        }
    }
    if (size == 0) return TRUE;
    if (size < sizeof(KNpcFileHead) || size > 16 * 1024 * 1024 || prefix != 60)
        return FALSE;
    BYTE* bytes = new BYTE[size];
    if (!bytes) return FALSE;
    if (file->Read(bytes, size) != size) { delete[] bytes; return FALSE; }
    KNpcFileHead head;
    memcpy(&head, bytes, sizeof(head));
    unsigned int offset = sizeof(head);
    if (head.uNumNpc > (size - offset) / prefix) { delete[] bytes; return FALSE; }
    // Validate the whole section first, before creating any live entities.
    unsigned int i;
    for (i = 0; i < head.uNumNpc; ++i)
    {
        if (prefix > size - offset) { delete[] bytes; return FALSE; }
        KSPNpc cell;
        memcpy(&cell, bytes + offset, prefix);
        offset += prefix;
        if (cell.nScriptNameLen > size - offset ||
            cell.nTemplateID < 0 || cell.nTemplateID >= MAX_NPCSTYLE ||
            cell.nLevel <= 0 || cell.shKind < 0 || cell.shKind > 3 ||
            (usingRestored && (cell.nPositionX < 0 || cell.nPositionY < 0 ||
             cell.nPositionX / 512 != LOWORD(m_RegionID) ||
             cell.nPositionY / 1024 != HIWORD(m_RegionID))))
        { delete[] bytes; return FALSE; }
        offset += cell.nScriptNameLen;
    }
    if (offset != size) { delete[] bytes; return FALSE; }
    offset = sizeof(head);
    int added = 0, failed = 0, missingScripts = 0;
    for (i = 0; i < head.uNumNpc; ++i)
    {
        KSPNpc cell;
        ZeroMemory(&cell, sizeof(cell));
        memcpy(&cell, bytes + offset, prefix);
        offset += prefix;
        const unsigned int copyLength = cell.nScriptNameLen < sizeof(cell.szScript) ?
            cell.nScriptNameLen : sizeof(cell.szScript) - 1;
        memcpy(cell.szScript, bytes + offset, copyLength);
        cell.szScript[copyLength] = 0;
        cell.szName[sizeof(cell.szName) - 1] = 0;
        offset += cell.nScriptNameLen;
        // Directory enumeration cannot discover PAK-only Lua. Register the
        // actual Region_S path through the existing Lua/PAK loader once.
        if (cell.szScript[0] && !g_GetScript(g_FileName2Id(cell.szScript)))
            ReLoadScript(cell.szScript);
        const int index = NpcSet.Add(nSubWorld, &cell);
        if (index <= 0) { ++failed; continue; }
        ++added;
        if (Npc[index].m_Kind == kind_dialoger &&
            (!Npc[index].m_ActionScriptID || !g_GetScript(Npc[index].m_ActionScriptID)))
            ++missingScripts;
    }
    delete[] bytes;
    if (head.uNumNpc)
    {
        FILE* log = fopen("server_npc_load_diag.log", "a");
        if (log)
        {
            fprintf(log, "map=%d region=%08X declared=%u added=%d failed=%d missing_dialog_script=%d\n",
                SubWorld[nSubWorld].m_SubWorldID, m_RegionID, head.uNumNpc, added, failed, missingScripts);
            if (usingRestored)
                fprintf(log, "restored_region=%s source=authored_npc_section added=%d\n", restoredPath, added);
            fclose(log);
        }
    }
    return failed == 0;
}
