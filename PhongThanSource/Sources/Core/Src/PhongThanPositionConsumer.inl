static void PhongThanApplyPositionEvent(const PHONGTHAN_ENTITY_POSITION* position)
{
	if (position->MapId != (PHONGTHAN_U32)SubWorld[0].m_SubWorldID) return;
	int index = NpcSet.SearchID(position->EntityId);
	if (index <= 0 || index >= MAX_NPC) return;
	const bool self = index == Player[CLIENT_PLAYER_INDEX].m_nIndex;
	if (position->Mode == PHONGTHAN_POSITION_RECONCILE && !self) return;
	int x, y;
	Npc[index].GetMpsPos(&x, &y);
	const int distance = g_GetDistance(x, y, position->X, position->Y);
	if ((position->Mode == PHONGTHAN_POSITION_RECONCILE && Npc[index].m_RegionIndex >= 0 && distance <= 128) ||
		(position->Mode == PHONGTHAN_POSITION_STAND && self && distance <= 256))
	{
		Npc[index].m_SyncSignal = SubWorld[0].m_dwCurrentTime;
		return;
	}
	int region, mapX, mapY, offX, offY;
	SubWorld[0].Mps2Map(position->X, position->Y, &region, &mapX, &mapY, &offX, &offY);
	if (region < 0)
	{
		if (!self) return;
		const int regionX = position->X / (SubWorld[0].m_nCellWidth * SubWorld[0].m_nRegionWidth);
		const int regionY = position->Y / (SubWorld[0].m_nCellHeight * SubWorld[0].m_nRegionHeight);
		SubWorld[0].LoadMap(position->MapId, MAKELONG(regionX, regionY));
		index = NpcSet.SearchID(position->EntityId);
		if (index <= 0 || index >= MAX_NPC) return;
		SubWorld[0].Mps2Map(position->X, position->Y, &region, &mapX, &mapY, &offX, &offY);
	}
	if (region < 0 || region >= SubWorld[0].m_nTotalRegion) return;
	const int oldRegion = Npc[index].m_RegionIndex;
	const bool oldValid = oldRegion >= 0 && oldRegion < SubWorld[0].m_nTotalRegion &&
		Npc[index].m_dwRegionID == SubWorld[0].m_Region[oldRegion].m_RegionID;
	if (oldValid)
	{
		SubWorld[0].m_Region[oldRegion].DecRef(Npc[index].m_MapX, Npc[index].m_MapY, obj_npc);
		if (oldRegion != region) SubWorld[0].m_Region[oldRegion].RemoveNpc(index);
	}
	Npc[index].m_MapX = mapX;
	Npc[index].m_MapY = mapY;
	Npc[index].m_OffX = offX;
	Npc[index].m_OffY = offY;
	Npc[index].m_RegionIndex = region;
	Npc[index].m_dwRegionID = SubWorld[0].m_Region[region].m_RegionID;
	if (!oldValid || oldRegion != region) SubWorld[0].m_Region[region].AddNpc(index);
	SubWorld[0].m_Region[region].AddRef(mapX, mapY, obj_npc);
	ZeroMemory(&Npc[index].m_sSyncPos, sizeof(Npc[index].m_sSyncPos));
	if (position->Mode == PHONGTHAN_POSITION_STAND || position->Mode == PHONGTHAN_POSITION_TELEPORT)
		Npc[index].SendCommand(do_stand);
	Npc[index].m_SyncSignal = SubWorld[0].m_dwCurrentTime;
}
