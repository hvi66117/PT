// Native world messages are consumed before inventory/UI side effects.
#ifndef _SERVER
#include "PhongThanPositionConsumer.inl"
bool KProtocolProcess::ProcessPhongThanWorldPacket(BYTE* data, unsigned int size)
{
	const PHONGTHAN_WIRE_HEADER* header = (const PHONGTHAN_WIRE_HEADER*)data;
	if(header->MessageType==PHONGTHAN_COMPOSE_RESPONSE)
	{
		if(PhongThanWorldFixedPacket(data,size,PHONGTHAN_COMPOSE_RESPONSE,PHONGTHAN_WIRE_FLAG_RESPONSE,sizeof(PHONGTHAN_COMPOSE_RESULT)))
		{
			const PHONGTHAN_COMPOSE_RESULT* result=(const PHONGTHAN_COMPOSE_RESULT*)data;
			const int player=Player[CLIENT_PLAYER_INDEX].m_nIndex;
			if(player>0 && player<MAX_NPC && result->MapId==(PHONGTHAN_U32)SubWorld[0].m_SubWorldID && result->EntityId==Npc[player].m_dwID)
				CoreDataChanged(PHONGTHAN_COMPOSE_CORE_RESULT,result->Result,0);
		}
		return true;
	}
	if (header->MessageType == PHONGTHAN_MSG_GAMEPLAY_EXPERIENCE || header->MessageType == PHONGTHAN_MSG_GAMEPLAY_LEVEL ||
		header->MessageType == PHONGTHAN_MSG_WORLD_TITLE || header->MessageType == PHONGTHAN_MSG_WORLD_MOUNT || header->MessageType == PHONGTHAN_MSG_UI_PLAYER_EVENT)
	{
		if (!PhongThanValidatePlayerEventPacket(data, size)) return true;
		PHONGTHAN_U32 mapId, entityId;
		memcpy(&mapId, data + sizeof(PHONGTHAN_WIRE_HEADER), sizeof(mapId));
		memcpy(&entityId, data + sizeof(PHONGTHAN_WIRE_HEADER) + sizeof(mapId), sizeof(entityId));
		if (mapId != (PHONGTHAN_U32)SubWorld[0].m_SubWorldID) return true;
		const int index = NpcSet.SearchID(entityId);
		if (index <= 0 || index >= MAX_NPC) return true;
		if (header->MessageType == PHONGTHAN_MSG_WORLD_TITLE)
		{
			const PHONGTHAN_TITLE_EVENT* event = (const PHONGTHAN_TITLE_EVENT*)data;
			if (event->Expanded)
			{
				KExpandRank title;
				title.Release();
				g_StrCpyLen(title.szName, event->Name, sizeof(title.szName));
				title.dwColor = event->Color; title.nStateGraphics = event->Graphic; title.dwLeftTime = event->RemainingTime;
				Npc[index].SetExpandRank(&title);
			}
			else Npc[index].m_RankID = event->RankId;
		}
		else if (header->MessageType == PHONGTHAN_MSG_WORLD_MOUNT)
			// Server already validated the mount. Remote players have no local
			// inventory; consume state exactly as the player snapshot does.
			Npc[index].m_bRideHorse = ((const PHONGTHAN_MOUNT_EVENT*)data)->Mounted;
		else if (index == Player[CLIENT_PLAYER_INDEX].m_nIndex)
		{
			if (header->MessageType == PHONGTHAN_MSG_GAMEPLAY_EXPERIENCE) s2cPlayerExp(data);
			else if (header->MessageType == PHONGTHAN_MSG_GAMEPLAY_LEVEL) s2cLevelUp(data);
			else s2cPlayerSync(data);
		}
		Npc[index].m_SyncSignal = SubWorld[0].m_dwCurrentTime;
		return true;
	}
	if (header->MessageType == PHONGTHAN_MSG_WORLD_OBJECT_SNAPSHOT)
	{
		if (!PhongThanValidateObjectSnapshot(data, size)) return true;
		if (((const PHONGTHAN_OBJECT_SNAPSHOT*)data)->MapId == (PHONGTHAN_U32)SubWorld[0].m_SubWorldID)
			SyncObjectAdd(data);
		return true;
	}
	if (header->MessageType == PHONGTHAN_MSG_WORLD_OBJECT_STATE ||
		header->MessageType == PHONGTHAN_MSG_WORLD_OBJECT_DIRECTION ||
		header->MessageType == PHONGTHAN_MSG_WORLD_OBJECT_REMOVE)
	{
		if (!PhongThanValidateObjectEvent(data, size, header->MessageType)) return true;
		const PHONGTHAN_OBJECT_EVENT* event = (const PHONGTHAN_OBJECT_EVENT*)data;
		if (event->MapId != (PHONGTHAN_U32)SubWorld[0].m_SubWorldID) return true;
		const int index = ObjSet.FindID(event->ObjectId);
		if (index <= 0)
		{
			if (header->MessageType != PHONGTHAN_MSG_WORLD_OBJECT_REMOVE && g_pClient)
			{
				PHONGTHAN_OBJECT_REFERENCE request;
				PhongThanInitializeWireHeader(&request.Header, PHONGTHAN_MSG_WORLD_OBJECT_REQUEST,
					sizeof(request), PHONGTHAN_WIRE_FLAG_REQUEST, 0);
				request.MapId = event->MapId; request.RegionId = event->RegionId; request.ObjectId = event->ObjectId;
				g_pClient->SendPackToServer(&request, sizeof(request));
			}
			return true;
		}
		if (header->MessageType == PHONGTHAN_MSG_WORLD_OBJECT_REMOVE) Object[index].Remove(event->Value);
		else if (header->MessageType == PHONGTHAN_MSG_WORLD_OBJECT_DIRECTION) Object[index].SetDir(event->Value);
		else
		{
			if (Object[index].m_nRegionIdx < 0)
			{
				const int region = SubWorld[0].FindRegion(event->RegionId);
				if (region < 0) return true;
				Object[index].m_nRegionIdx = region;
				SubWorld[0].m_Region[region].AddObj(index);
			}
			Object[index].SetState(event->Value);
		}
		return true;
	}
	if (header->MessageType == PHONGTHAN_MSG_WORLD_ENTITY_POSITION)
	{
		if (PhongThanValidateEntityPosition(data, size))
			PhongThanApplyPositionEvent((const PHONGTHAN_ENTITY_POSITION*)data);
		return true;
	}
	if (header->MessageType == PHONGTHAN_MSG_WORLD_ENTITY_STATUS)
	{
		if (!PhongThanValidateEntityStatus(data, size)) return true;
		const PHONGTHAN_ENTITY_STATUS* status = (const PHONGTHAN_ENTITY_STATUS*)data;
		if (status->MapId != (PHONGTHAN_U32)SubWorld[0].m_SubWorldID) return true;
		const int index = NpcSet.SearchID(status->EntityId);
		if (index <= 0 || index >= MAX_NPC) return true;
		switch (status->Kind)
		{
		case PHONGTHAN_STATUS_SIT:
			if (Player[CLIENT_PLAYER_INDEX].ConformIdx(index))
				Npc[index].SendCommand(Npc[index].m_bRideHorse ? do_stand : do_sit);
			break;
		case PHONGTHAN_STATUS_DEATH:
			Npc[index].ProcNetCommand(do_death);
			Npc[index].m_CurrentLife = 0;
			break;
		case PHONGTHAN_STATUS_HURT:
			Npc[index].ProcNetCommand(do_hurt, status->Value, status->X, status->Y);
			break;
		case PHONGTHAN_STATUS_REVIVE:
			if (!Npc[index].IsPlayer() && status->Value == REMOTE_REVIVE_TYPE)
				SubWorld[0].m_WorldMessage.Send(GWM_NPC_DEL, index);
			else Npc[index].ProcNetCommand(do_revive);
			break;
		case PHONGTHAN_STATUS_BASE_CAMP: Npc[index].SetCamp(status->Value); break;
		case PHONGTHAN_STATUS_CURRENT_CAMP: Npc[index].SetCurrentCamp(status->Value); break;
		}
		Npc[index].m_SyncSignal = SubWorld[0].m_dwCurrentTime;
		return true;
	}
	if (header->MessageType == PHONGTHAN_MSG_GAMEPLAY_ATTRIBUTE_UPDATE ||
		header->MessageType == PHONGTHAN_MSG_GAMEPLAY_SKILL_LEVEL_UPDATE ||
		header->MessageType == PHONGTHAN_MSG_GAMEPLAY_STATE_CLEAR)
	{
		PHONGTHAN_U32 mapId = 0, entityId = 0;
		switch (header->MessageType)
		{
		case PHONGTHAN_MSG_GAMEPLAY_ATTRIBUTE_UPDATE:
			if (!PhongThanValidateAttributeUpdate(data, size)) return true;
			mapId = ((const PHONGTHAN_ATTRIBUTE_UPDATE*)data)->MapId;
			entityId = ((const PHONGTHAN_ATTRIBUTE_UPDATE*)data)->EntityId;
			break;
		case PHONGTHAN_MSG_GAMEPLAY_SKILL_LEVEL_UPDATE:
			if (!PhongThanValidateSkillLevelUpdate(data, size)) return true;
			mapId = ((const PHONGTHAN_SKILL_LEVEL_UPDATE*)data)->MapId;
			entityId = ((const PHONGTHAN_SKILL_LEVEL_UPDATE*)data)->EntityId;
			break;
		case PHONGTHAN_MSG_GAMEPLAY_STATE_CLEAR:
			if (!PhongThanValidateStateClear(data, size)) return true;
			mapId = ((const PHONGTHAN_STATE_CLEAR*)data)->MapId;
			entityId = ((const PHONGTHAN_STATE_CLEAR*)data)->EntityId;
			break;
		}
		const int index = Player[CLIENT_PLAYER_INDEX].m_nIndex;
		if (index <= 0 || index >= MAX_NPC || entityId != Npc[index].m_dwID ||
			mapId != (PHONGTHAN_U32)SubWorld[0].m_SubWorldID) return true;
		if (header->MessageType == PHONGTHAN_MSG_GAMEPLAY_ATTRIBUTE_UPDATE) s2cGetCurAttribute(data);
		else if (header->MessageType == PHONGTHAN_MSG_GAMEPLAY_SKILL_LEVEL_UPDATE) s2cGetSkillLevel(data);
		else IgnoreState(data);
		return true;
	}
	if (header->MessageType == PHONGTHAN_MSG_UI_SCRIPT_ACTION)
	{
		FILE* dialogLog = fopen("ui_action_diag.log", "a");
		if (dialogLog)
		{
			fprintf(dialogLog, "client receive tick=%lu size=%u valid=%d\n", (unsigned long)GetTickCount(), size, PhongThanValidateUiAction(data, size));
			fclose(dialogLog);
		}
		if (PhongThanValidateUiAction(data, size)) SyncScriptAction(data);
		dialogLog = fopen("ui_action_diag.log", "a");
		if (dialogLog) { fprintf(dialogLog, "client dispatch returned\n"); fclose(dialogLog); }
		return true;
	}
	if (header->MessageType == PHONGTHAN_MSG_GAMEPLAY_SKILL_LIST ||
		header->MessageType == PHONGTHAN_MSG_GAMEPLAY_STATE_EFFECT)
	{
		const bool isList = header->MessageType == PHONGTHAN_MSG_GAMEPLAY_SKILL_LIST;
		if (isList ? !PhongThanValidateSkillList(data, size) : !PhongThanValidateStateEffect(data, size)) return true;
		// Both schemas begin with the same fixed scalar map/entity prefix.
		const PHONGTHAN_U32 mapId = isList ? ((const PHONGTHAN_SKILL_LIST_HEADER*)data)->MapId :
			((const PHONGTHAN_STATE_EFFECT_HEADER*)data)->MapId;
		const PHONGTHAN_U32 entityId = isList ? ((const PHONGTHAN_SKILL_LIST_HEADER*)data)->EntityId :
			((const PHONGTHAN_STATE_EFFECT_HEADER*)data)->EntityId;
		const int index = Player[CLIENT_PLAYER_INDEX].m_nIndex;
		if (index <= 0 || index >= MAX_NPC || mapId != (PHONGTHAN_U32)SubWorld[0].m_SubWorldID ||
			entityId != Npc[index].m_dwID) return true;
		if (isList) s2cSyncAllSkill(data);
		else SyncStateEffect(data);
		return true;
	}
	if (header->MessageType == PHONGTHAN_MSG_WORLD_MAP_SNAPSHOT)
	{
		if (PhongThanValidateMapSnapshot(data, size)) SyncWorld(data);
		// Clear any pending item-click throttle when applying a map sync,
		// so interaction can resume after the transition completes.
		if (PhongThanValidateMapSnapshot(data, size))
			Player[CLIENT_PLAYER_INDEX].m_dwRightMouse = 0;
		FILE* mapLog = fopen("ui_action_diag.log", "a");
		if (mapLog) {
			fprintf(mapLog, "client map-sync valid=%d current=%d\n", PhongThanValidateMapSnapshot(data, size), SubWorld[0].m_SubWorldID);
			fclose(mapLog);
		}
		return true;
	}
	if (header->MessageType == PHONGTHAN_MSG_WORLD_SELF_SNAPSHOT)
	{
		if (!PhongThanValidateSelfSnapshot(data, size)) return true;
		const PHONGTHAN_SELF_SNAPSHOT* player = (const PHONGTHAN_SELF_SNAPSHOT*)data;
		if (player->MapId == (PHONGTHAN_U32)SubWorld[0].m_SubWorldID) SyncCurPlayer(data);
		return true;
	}
	if (header->MessageType == PHONGTHAN_MSG_WORLD_SELF_VITALS)
	{
		if (!PhongThanValidateSelfVitals(data, size)) return true;
		const PHONGTHAN_SELF_VITALS* player = (const PHONGTHAN_SELF_VITALS*)data;
		const int index = Player[CLIENT_PLAYER_INDEX].m_nIndex;
		if (index > 0 && index < MAX_NPC && player->EntityId == Npc[index].m_dwID &&
			player->MapId == (PHONGTHAN_U32)SubWorld[0].m_SubWorldID) SyncCurNormalData(data);
		return true;
	}
	if (header->MessageType == PHONGTHAN_MSG_WORLD_SYNC_COMPLETE)
	{
		if (PhongThanWorldFixedPacket(data, size, PHONGTHAN_MSG_WORLD_SYNC_COMPLETE,
			PHONGTHAN_WIRE_FLAG_RESPONSE, sizeof(PHONGTHAN_WORLD_SYNC_FENCE))) SyncEnd(data);
		return true;
	}
	if (header->MessageType == PHONGTHAN_MSG_WORLD_PLAYER_SNAPSHOT)
	{
		const int valid = PhongThanValidatePlayerSnapshot(data, size);
		static unsigned long lastTrace = 0;
		if (size == sizeof(PHONGTHAN_PLAYER_SNAPSHOT) && GetTickCount() - lastTrace > 2000)
		{
			lastTrace = GetTickCount();
			const PHONGTHAN_PLAYER_SNAPSHOT* s = (const PHONGTHAN_PLAYER_SNAPSHOT*)data;
			FILE* log = fopen("appearance_packet_trace.log", "a");
			if (log)
			{
				fprintf(log, "valid=%d map=%u current=%d entity=%u index=%d profession=%u flags=%u full=%u ride=%u progress=%u fight=%u sleep=%u shop=%u\n",
					valid, s->MapId, SubWorld[0].m_SubWorldID, s->EntityId, NpcSet.SearchID(s->EntityId),
					s->Profession, s->Header.Flags, s->FullSnapshot, s->Mounted, s->ProgressPercent,
					s->FightMode, s->Sleeping, s->ShopOpen);
				const PHONGTHAN_VISUAL_PART_WIRE* parts[] = {&s->Helm,&s->Armor,&s->Weapon,&s->PhiPhong,&s->Horse};
				for (int p=0;p<5;++p) fprintf(log,"part=%d resource=%d palette=%d visible=%u\n",p,parts[p]->ResourceId,parts[p]->PaletteId,parts[p]->Visible);
				fclose(log);
			}
		}
		if (!valid) return true;
		const PHONGTHAN_PLAYER_SNAPSHOT* player = (const PHONGTHAN_PLAYER_SNAPSHOT*)data;
		if (player->MapId == (PHONGTHAN_U32)SubWorld[0].m_SubWorldID)
			SyncPlayer(data);
		return true;
	}
	if (header->MessageType == PHONGTHAN_MSG_GAMEPLAY_SKILL_CAST)
	{
		if (!PhongThanValidateSkillCast(data, size)) return true;
		const PHONGTHAN_SKILL_CAST* skill = (const PHONGTHAN_SKILL_CAST*)data;
		if (skill->MapId != (PHONGTHAN_U32)SubWorld[0].m_SubWorldID ||
			skill->SkillId >= MAX_SKILL || skill->SkillLevel >= MAX_SKILLLEVEL) return true;
		if (skill->DirectEffect) s2cDirectlyCastSkill(data);
		else NetCommandSkill(data);
		return true;
	}
	if (header->MessageType == PHONGTHAN_MSG_WORLD_NPC_SNAPSHOT)
	{
		if (!PhongThanValidateNpcSnapshot(data, size)) return true;
		const PHONGTHAN_NPC_SNAPSHOT* npc = (const PHONGTHAN_NPC_SNAPSHOT*)data;
		if (npc->MapId == (PHONGTHAN_U32)SubWorld[0].m_SubWorldID)
			SyncNpc(data);
		return true;
	}
	if (header->MessageType == PHONGTHAN_MSG_WORLD_NPC_UPDATE)
	{
		if (!PhongThanValidateNpcUpdate(data, size)) return true;
		const PHONGTHAN_NPC_UPDATE* npc = (const PHONGTHAN_NPC_UPDATE*)data;
		if (npc->MapId == (PHONGTHAN_U32)SubWorld[0].m_SubWorldID)
			SyncNpcMin(data);
		return true;
	}
	if (header->MessageType == PHONGTHAN_MSG_WORLD_ENTITY_MOVE)
	{
		if (!PhongThanValidateEntityMove(data, size)) return true;
		const PHONGTHAN_ENTITY_MOVE* move = (const PHONGTHAN_ENTITY_MOVE*)data;
		if (move->MapId != (PHONGTHAN_U32)SubWorld[0].m_SubWorldID) return true;
		const int index = NpcSet.SearchID(move->EntityId);
		if (index <= 0 || index >= MAX_NPC) return true;
		if (move->Mode == PHONGTHAN_MOVE_WALK && Npc[index].m_HideState.nTime > 0)
			Npc[index].Madnessto(move->X, move->Y);
		else if (Player[CLIENT_PLAYER_INDEX].ConformIdx(index))
			Npc[index].SendCommand(move->Mode == PHONGTHAN_MOVE_RUN ? do_run :
				(move->Mode == PHONGTHAN_MOVE_JUMP ? do_jump : do_walk), move->X, move->Y);
		Npc[index].m_SyncSignal = SubWorld[0].m_dwCurrentTime;
		return true;
	}
	if (header->MessageType == PHONGTHAN_MSG_WORLD_ENTITY_REMOVE ||
		header->MessageType == PHONGTHAN_MSG_WORLD_ENTITY_NOT_FOUND)
	{
		const bool missing = header->MessageType == PHONGTHAN_MSG_WORLD_ENTITY_NOT_FOUND;
		if (!PhongThanValidateEntityReference(data, size, header->MessageType,
			missing ? (PHONGTHAN_WIRE_FLAG_RESPONSE | PHONGTHAN_WIRE_FLAG_ERROR) :
			PHONGTHAN_WIRE_FLAG_RESPONSE)) return true;
		const PHONGTHAN_ENTITY_REFERENCE* entity = (const PHONGTHAN_ENTITY_REFERENCE*)data;
		if (entity->MapId != (PHONGTHAN_U32)SubWorld[0].m_SubWorldID) return true;
		if (NpcSet.IsNpcRequestExist(entity->EntityId))
			NpcSet.RemoveNpcRequest(entity->EntityId);
		if (missing) return true;
		const int index = NpcSet.SearchID(entity->EntityId);
		if (index <= 0 || index >= MAX_NPC || !Player[CLIENT_PLAYER_INDEX].ConformIdx(index))
			return true;
		const int region = Npc[index].m_RegionIndex;
		if (region >= 0 && region < SubWorld[0].m_nTotalRegion)
		{
			SubWorld[0].m_Region[region].RemoveNpc(index);
			SubWorld[0].m_Region[region].DecRef(Npc[index].m_MapX, Npc[index].m_MapY, obj_npc);
		}
		NpcSet.Remove(index);
		return true;
	}
	return false;
}
#else
bool KProtocolProcess::ProcessPhongThanWorldPacket(int playerIndex, BYTE* data, unsigned int size)
{
	const PHONGTHAN_WIRE_HEADER* header = (const PHONGTHAN_WIRE_HEADER*)data;
	if (header->MessageType == PHONGTHAN_MSG_WORLD_OBJECT_REQUEST || header->MessageType == PHONGTHAN_MSG_WORLD_OBJECT_INTERACT)
	{
		if (!PhongThanValidateObjectReference(data, size, header->MessageType) || playerIndex <= 0 || playerIndex >= MAX_PLAYER) return true;
		const PHONGTHAN_OBJECT_REFERENCE* request = (const PHONGTHAN_OBJECT_REFERENCE*)data;
		const int index = Player[playerIndex].m_nIndex;
		if (index <= 0 || index >= MAX_NPC) return true;
		const int world = Npc[index].m_SubWorldIndex, currentRegion = Npc[index].m_RegionIndex;
		if (world < 0 || world >= MAX_SUBWORLD || currentRegion < 0 || currentRegion >= SubWorld[world].m_nTotalRegion ||
			request->MapId != (PHONGTHAN_U32)SubWorld[world].m_SubWorldID) return true;
		const int targetRegion = SubWorld[world].FindRegion(request->RegionId);
		if (targetRegion < 0) return true;
		bool nearby = targetRegion == currentRegion;
		for (int i = 0; i < 8 && !nearby; ++i)
			nearby = SubWorld[world].m_Region[currentRegion].m_nConnectRegion[i] == targetRegion;
		if (!nearby) return true;
		if (header->MessageType == PHONGTHAN_MSG_WORLD_OBJECT_INTERACT) ObjMouseClick(playerIndex, data);
		else
		{
			const int object = SubWorld[world].m_Region[targetRegion].FindObject(request->ObjectId);
			if (object > 0) Object[object].SyncAdd(Player[playerIndex].m_nNetConnectIdx);
		}
		return true;
	}
	if (header->MessageType == PHONGTHAN_MSG_WORLD_POSE_REQUEST)
	{
		if (!PhongThanValidatePoseRequest(data, size) || playerIndex <= 0 || playerIndex >= MAX_PLAYER) return true;
		const PHONGTHAN_POSE_REQUEST* pose = (const PHONGTHAN_POSE_REQUEST*)data;
		const int index = Player[playerIndex].m_nIndex;
		if (index <= 0 || index >= MAX_NPC) return true;
		const int world = Npc[index].m_SubWorldIndex;
		if (world < 0 || world >= MAX_SUBWORLD || pose->MapId != (PHONGTHAN_U32)SubWorld[world].m_SubWorldID) return true;
		if (pose->Kind == PHONGTHAN_POSE_REVIVE) NpcReviveCommand(playerIndex, data);
		else if (Npc[index].m_CurrentLife > 0 && Npc[index].m_Doing != do_death)
		{
			if (pose->Kind == PHONGTHAN_POSE_TOGGLE_MOUNT)
			{
				if (Npc[index].CanSwitchRideHorse()) Npc[index].SwitchRideHorse(!Npc[index].m_bRideHorse);
			}
			else Npc[index].SendCommand(pose->Kind == PHONGTHAN_POSE_SIT && !Npc[index].m_bRideHorse ? do_sit : do_stand);
		}
		return true;
	}
	if (header->MessageType == PHONGTHAN_MSG_GAMEPLAY_ATTRIBUTE_REQUEST ||
		header->MessageType == PHONGTHAN_MSG_GAMEPLAY_SKILL_LEVEL_REQUEST)
	{
		if (playerIndex <= 0 || playerIndex >= MAX_PLAYER) return true;
		const int index = Player[playerIndex].m_nIndex;
		if (index <= 0 || index >= MAX_NPC) return true;
		const int world = Npc[index].m_SubWorldIndex;
		if (world < 0 || world >= MAX_SUBWORLD) return true;
		if (header->MessageType == PHONGTHAN_MSG_GAMEPLAY_ATTRIBUTE_REQUEST)
		{
			if (!PhongThanValidateAttributeRequest(data, size)) return true;
			const PHONGTHAN_ATTRIBUTE_REQUEST* request = (const PHONGTHAN_ATTRIBUTE_REQUEST*)data;
			if (request->MapId != (PHONGTHAN_U32)SubWorld[world].m_SubWorldID) return true;
			Player[playerIndex].AddBaseAttribute(data);
		}
		else
		{
			if (!PhongThanValidateSkillLevelRequest(data, size)) return true;
			const PHONGTHAN_SKILL_LEVEL_REQUEST* request = (const PHONGTHAN_SKILL_LEVEL_REQUEST*)data;
			if (request->MapId != (PHONGTHAN_U32)SubWorld[world].m_SubWorldID || request->SkillId >= MAX_SKILL ||
				request->Points >= MAX_SKILLLEVEL) return true;
			Player[playerIndex].AddSkillPoint(data);
		}
		Player[playerIndex].SetLastNetOperationTime(g_SubWorldSet.GetGameTime());
		return true;
	}
	if (header->MessageType == PHONGTHAN_MSG_UI_CHOICE_REQUEST)
	{
		if (playerIndex > 0 && playerIndex < MAX_PLAYER && PhongThanValidateUiChoice(data, size))
			Player[playerIndex].ProcessPlayerSelectFromUI(data);
		return true;
	}
	if (header->MessageType == PHONGTHAN_MSG_UI_NUMBER_INPUT)
	{
		if (playerIndex > 0 && playerIndex < MAX_PLAYER && PhongThanValidateNumberRequest(data, size)) {
			extern void PhongThanStarterBagInput(KPlayer&, const PHONGTHAN_UI_NUMBER_REQUEST&);
			PhongThanStarterBagInput(Player[playerIndex], *(const PHONGTHAN_UI_NUMBER_REQUEST*)data);
		}
		return true;
	}
	if (header->MessageType != PHONGTHAN_MSG_WORLD_MOVE_REQUEST &&
		header->MessageType != PHONGTHAN_MSG_WORLD_ENTITY_REQUEST &&
		header->MessageType != PHONGTHAN_MSG_GAMEPLAY_SKILL_REQUEST &&
		header->MessageType != PHONGTHAN_MSG_NPC_INTERACT_REQUEST)
		return false;
	if (playerIndex <= 0 || playerIndex >= MAX_PLAYER) return true;
	const int index = Player[playerIndex].m_nIndex;
	if (index <= 0 || index >= MAX_NPC) return true;
	const int world = Npc[index].m_SubWorldIndex;
	if (world < 0 || world >= MAX_SUBWORLD || Npc[index].m_RegionIndex < 0 ||
		Npc[index].m_RegionIndex >= SubWorld[world].m_nTotalRegion) return true;
	if (header->MessageType == PHONGTHAN_MSG_GAMEPLAY_SKILL_REQUEST)
	{
		if (!PhongThanValidateSkillRequest(data, size)) return true;
		const PHONGTHAN_SKILL_REQUEST* skill = (const PHONGTHAN_SKILL_REQUEST*)data;
		if (skill->MapId == (PHONGTHAN_U32)SubWorld[world].m_SubWorldID)
			NpcSkillCommand(playerIndex, data);
		return true;
	}
	if (header->MessageType == PHONGTHAN_MSG_NPC_INTERACT_REQUEST)
	{
		if (!PhongThanValidateEntityReference(data, size, PHONGTHAN_MSG_NPC_INTERACT_REQUEST,
			PHONGTHAN_WIRE_FLAG_REQUEST)) return true;
		const PHONGTHAN_ENTITY_REFERENCE* npc = (const PHONGTHAN_ENTITY_REFERENCE*)data;
		if (npc->MapId == (PHONGTHAN_U32)SubWorld[world].m_SubWorldID)
			Player[playerIndex].DialogNpc(data);
		return true;
	}
	if (header->MessageType == PHONGTHAN_MSG_WORLD_MOVE_REQUEST)
	{
		if (!PhongThanValidateMoveRequest(data, size)) return true;
		const PHONGTHAN_MOVE_REQUEST* move = (const PHONGTHAN_MOVE_REQUEST*)data;
		if (move->MapId != (PHONGTHAN_U32)SubWorld[world].m_SubWorldID) return true;
		int region, x, y, offX, offY;
		SubWorld[world].Mps2Map(move->X, move->Y, &region, &x, &y, &offX, &offY);
		if (region < 0 || region >= SubWorld[world].m_nTotalRegion) return true;
		if (Player[playerIndex].m_nPaceBarTime)
		{
			Player[playerIndex].m_nPaceBarTime = 0;
			Player[playerIndex].m_nPaceBarTimeMax = 0;
			Player[playerIndex].LoadScriptProgressBar(2);
		}
		const NPCCMD command = move->Mode == PHONGTHAN_MOVE_RUN ? do_run : do_walk;
		Npc[index].SendCommand(command, move->X, move->Y);
		Npc[index].m_NowCommand.CmdKind = command;
		Npc[index].m_NowCommand.Param_X = move->X;
		Npc[index].m_NowCommand.Param_Y = move->Y;
		Npc[index].m_NowCommand.Param_Z = -1;
		Player[playerIndex].SetLastNetOperationTime(g_SubWorldSet.GetGameTime());
		return true;
	}
	if (!PhongThanValidateEntityReference(data, size, PHONGTHAN_MSG_WORLD_ENTITY_REQUEST,
		PHONGTHAN_WIRE_FLAG_REQUEST)) return true;
	const PHONGTHAN_ENTITY_REFERENCE* request = (const PHONGTHAN_ENTITY_REFERENCE*)data;
	if (request->MapId != (PHONGTHAN_U32)SubWorld[world].m_SubWorldID) return true;
	const int target = request->EntityId == Npc[index].m_dwID ? index :
		Player[playerIndex].FindAroundNpc(request->EntityId);
	if (target > 0 && target < MAX_NPC && Npc[target].m_SubWorldIndex == world)
		Npc[target].SendSyncData(Player[playerIndex].m_nNetConnectIdx);
	else if (g_pServer)
	{
		PHONGTHAN_ENTITY_REFERENCE response = *request;
		PhongThanInitializeWireHeader(&response.Header, PHONGTHAN_MSG_WORLD_ENTITY_NOT_FOUND,
			sizeof(response), PHONGTHAN_WIRE_FLAG_RESPONSE | PHONGTHAN_WIRE_FLAG_ERROR,
			request->Header.Sequence);
		g_pServer->PackDataToClient(Player[playerIndex].m_nNetConnectIdx, &response, sizeof(response));
	}
	return true;
}
#endif
