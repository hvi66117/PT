// Client region slots are recycled while walking. Server NPC identity must
// survive that cache eviction just like the original client-only decorations.
void KNpcSet::InsertNpcToRegion(int nRegionIdx)
{
	if (!SubWorld[0].m_Region || nRegionIdx < 0 || nRegionIdx >= MAX_REGION ||
		SubWorld[0].m_Region[nRegionIdx].m_RegionID < 0)
		return;

	KRegion& region = SubWorld[0].m_Region[nRegionIdx];
	int nIdx = 0;
	while ((nIdx = m_UseIdx.GetNext(nIdx)) != 0)
	{
		KNpc& npc = Npc[nIdx];
		const BOOL bClientNpc = npc.m_sClientNpcID.m_dwRegionID > 0;
		const BOOL bServerNpc = !npc.m_bClientOnly && npc.m_dwID != 0 &&
			(npc.m_Kind == kind_normal || npc.m_Kind == kind_dialoger);
		if ((!bClientNpc && !bServerNpc) || npc.m_SubWorldIndex != 0 ||
			npc.m_RegionIndex != -1 || npc.m_Node.m_Ref != 0 ||
			npc.m_dwRegionID != (DWORD)region.m_RegionID ||
			npc.m_MapX < 0 || npc.m_MapX >= region.m_nWidth ||
			npc.m_MapY < 0 || npc.m_MapY >= region.m_nHeight)
			continue;

		region.AddNpc(nIdx);
		if (npc.m_Node.m_Ref == 0)
			continue;
		npc.m_RegionIndex = nRegionIdx;
		// Close() clears the old cell references. Only server-owned entities
		// occupy collision cells; AddClientNpc deliberately excludes them.
		if (!npc.m_bClientOnly)
			region.AddRef(npc.m_MapX, npc.m_MapY, obj_npc);
		if (bClientNpc)
		{
			npc.m_SyncSignal = SubWorld[0].m_dwCurrentTime;
			npc.SendCommand(do_stand);
		}
		// Keep the authoritative action and sync age for server entities.
	}
}
