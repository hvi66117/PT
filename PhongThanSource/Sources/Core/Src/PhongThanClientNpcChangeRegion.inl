// Parameters are packed region IDs on the client, not cache-slot indices.
// Movement callers may already have written the destination slot into KNpc.
void KSubWorld::NpcChangeRegion(int nSrcRnidx, int nDesRnIdx, int nIdx)
{
	if (!m_Region || nIdx <= 0 || nIdx >= MAX_NPC)
		return;

	KNpc& npc = Npc[nIdx];
	int nSrc = nSrcRnidx >= 0 ? FindRegion(nSrcRnidx) : -1;
	int nDest = nDesRnIdx >= 0 ? FindRegion(nDesRnIdx) : -1;
	if (nSrc >= 0)
		m_Region[nSrc].RemoveNpc(nIdx);
	else if (npc.m_Node.m_Ref > 0)
	{
		// The source slot may have been recycled already. Detach the actual
		// intrusive node rather than leave an entity owned by an unrelated slot.
		npc.m_Node.Remove();
		npc.m_Node.Release();
		npc.RemoveRes();
	}

	npc.m_RegionIndex = -1;
	npc.m_dwRegionID = nDesRnIdx >= 0 ? (DWORD)nDesRnIdx : 0;
	if (nDesRnIdx < 0)
		return;

	if (Player[CLIENT_PLAYER_INDEX].m_nIndex == nIdx &&
		(nSrcRnidx != -1 || nDest < 0))
	{
		// Load/recycle first, then attach self to the final destination slot.
		LoadMap(m_SubWorldID, nDesRnIdx);
		nDest = FindRegion(nDesRnIdx);
	}
	if (nDest >= 0)
	{
		m_Region[nDest].AddNpc(nIdx);
		if (npc.m_Node.m_Ref > 0)
			npc.m_RegionIndex = nDest;
	}
	// An unloaded destination remains detached with its real region ID. The
	// next region load or server update can now reattach it without stale slots.
}
