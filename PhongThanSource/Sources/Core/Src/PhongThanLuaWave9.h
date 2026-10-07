#ifndef PHONG_THAN_LUA_WAVE9_H
#define PHONG_THAN_LUA_WAVE9_H

// Phong Than VNG Lua completion campaign - Wave 9.
// Instance values are owned by the existing KSubWorld/KMission system.  World
// events use the durable GameData groups introduced by Wave 8.

#define PHONGTHAN_INSTANCE_STATE_SLOT 96
#define PHONGTHAN_INSTANCE_TYPE_SLOT 97
#define PHONGTHAN_INSTANCE_FIRST_TIME_SLOT 98
#define PHONGTHAN_INSTANCE_KILL_SLOT 95

enum PHONGTHAN_WAVE9_PERSIST_SCOPE
{
	pt_persist_world_event_value = 7201,
	pt_persist_world_event_progress = 7202,
	pt_persist_world_boss_death = 7203
};

static int PhongThanLuaGlobalNumber(Lua_State *L, const char *pszName)
{
	int nTop = Lua_GetTopIndex(L);
	int nValue = 0;
	Lua_GetGlobal(L, pszName);
	if (!lua_isnil(L, Lua_GetTopIndex(L)))
		nValue = (int)Lua_ValueToNumber(L, Lua_GetTopIndex(L));
	Lua_SetTopIndex(L, nTop);
	return nValue;
}

static KMission *PhongThanFindInstanceMission(int nInstanceId,
	int *pnSubWorld)
{
	if (pnSubWorld) *pnSubWorld = -1;
	if (nInstanceId <= 0)
		return NULL;
	KMission Mission;
	Mission.SetMissionId((unsigned long)nInstanceId);
	for (int i = 0; i < MAX_SUBWORLD; ++i)
	{
		if (SubWorld[i].m_SubWorldID < 0)
			continue;
		KMission *pMission = SubWorld[i].m_MissionArray.GetData(&Mission);
		if (pMission)
		{
			if (pnSubWorld) *pnSubWorld = i;
			return pMission;
		}
	}
	return NULL;
}

static int PhongThanInstanceIdFromContext(Lua_State *L, int *pnSubWorld)
{
	int nSubWorld = PhongThanCurrentSubWorld(L);
	int nInstanceId = PhongThanLuaGlobalNumber(L, "InstanceIndex");
	if (nInstanceId <= 0)
	{
		int nScriptSubWorld = PhongThanLuaGlobalNumber(L, SCRIPT_SUBWORLDINDEX);
		if (nScriptSubWorld >= 0 && nScriptSubWorld < MAX_SUBWORLD &&
			SubWorld[nScriptSubWorld].m_SubWorldID >= 0)
			nSubWorld = nScriptSubWorld;
	}
	if (nInstanceId <= 0 && nSubWorld >= 0)
	{
		int nMissionIndex = SubWorld[nSubWorld].m_MissionArray.m_UseIdx.GetNext(0);
		KMission *pMission = nMissionIndex > 0 ?
			SubWorld[nSubWorld].m_MissionArray.GetData(nMissionIndex) : NULL;
		if (pMission)
			nInstanceId = (int)pMission->GetMissionId();
	}
	if (nInstanceId <= 0 && nSubWorld >= 0)
		nInstanceId = SubWorld[nSubWorld].m_SubWorldID;
	if (pnSubWorld) *pnSubWorld = nSubWorld;
	return nInstanceId;
}

static KMission *PhongThanEnsureInstanceMission(int nInstanceId, int nSubWorld)
{
	int nFoundSubWorld = -1;
	KMission *pMission = PhongThanFindInstanceMission(nInstanceId,
		&nFoundSubWorld);
	if (pMission)
		return pMission;
	if (nSubWorld < 0 || nSubWorld >= MAX_SUBWORLD ||
		SubWorld[nSubWorld].m_SubWorldID < 0 || nInstanceId <= 0)
		return NULL;
	pMission = SubWorld[nSubWorld].m_MissionArray.Add();
	if (!pMission)
		return NULL;
	pMission->Init();
	pMission->m_MissionPlayer.Clear();
	pMission->m_MissionNpc.Clear();
	pMission->SetMissionId((unsigned long)nInstanceId);
	char szValue[32];
	sprintf(szValue, "%d", 1);
	pMission->SetMission(PHONGTHAN_INSTANCE_STATE_SLOT, szValue);
	int nMapId = SubWorld[nSubWorld].m_SubWorldID;
	int nType = nMapId >= 0 && nMapId <= g_SubWorldSet.m_MapListCount &&
		g_SubWorldSet.m_sMapListInfo ?
		g_SubWorldSet.m_sMapListInfo[nMapId].nKind : 0;
	sprintf(szValue, "%d", nType);
	pMission->SetMission(PHONGTHAN_INSTANCE_TYPE_SLOT, szValue);
	sprintf(szValue, "%d", (int)time(NULL));
	pMission->SetMission(PHONGTHAN_INSTANCE_FIRST_TIME_SLOT, szValue);
	return pMission;
}

static void PhongThanPushInstanceInfo(Lua_State *L, int nInstanceId,
	int bIncludeSubWorld)
{
	int nSubWorld = -1;
	KMission *pMission = PhongThanFindInstanceMission(nInstanceId, &nSubWorld);
	int nState = pMission ?
		pMission->GetMissionValue(PHONGTHAN_INSTANCE_STATE_SLOT) : 0;
	if (pMission && nState == 0) nState = 1;
	int nType = pMission ?
		pMission->GetMissionValue(PHONGTHAN_INSTANCE_TYPE_SLOT) : 0;
	int nFirstTime = pMission ?
		pMission->GetMissionValue(PHONGTHAN_INSTANCE_FIRST_TIME_SLOT) : 0;
	int nPlayerCount = pMission ? (int)pMission->GetPlayerCount() : 0;
	Lua_PushNumber(L, nState);
	Lua_PushNumber(L, nType);
	Lua_PushNumber(L, nFirstTime);
	Lua_PushNumber(L, nPlayerCount);
	if (bIncludeSubWorld) Lua_PushNumber(L, nSubWorld);
}

int LuaWorldBossDeathCompat(Lua_State *L)
{
	int nNpcIndex = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : 0;
	int nResult = 0;
	if (PhongThanIsLiveNpc(nNpcIndex))
	{
		DWORD dwBossTemplate = (DWORD)Npc[nNpcIndex].m_NpcSettingIdx;
		int nDeathCount = PhongThanGetPersistentValue(
			pt_persist_world_boss_death, dwBossTemplate, 0) + 1;
		PhongThanSetPersistentValue(pt_persist_world_boss_death,
			dwBossTemplate, 0, nDeathCount);
		PhongThanSetPersistentValue(pt_persist_world_boss_death,
			dwBossTemplate, 1, (int)time(NULL));
		PHONGTHAN_NPC_EXT_STATE *pState = PhongThanNpcState(nNpcIndex);
		if (pState && PhongThanIsLiveNpc(Npc[nNpcIndex].m_nLastDamageIdx))
		{
			int nAttacker = Npc[nNpcIndex].m_nLastDamageIdx;
			if (Npc[nAttacker].m_Kind == kind_player)
			{
				pState->nOwnerPlayerIndex = Npc[nAttacker].GetPlayerIdx();
				pState->dwOwnerUuid = pState->nOwnerPlayerIndex > 0 ?
					Player[pState->nOwnerPlayerIndex].m_dwID : 0;
			}
		}
		nResult = nDeathCount;
	}
	Lua_PushNumber(L, nResult);
	return 1;
}

int LuaSetInstanceTempValueCompat(Lua_State *L)
{
	int nSubWorld = -1;
	int nInstanceId = PhongThanInstanceIdFromContext(L, &nSubWorld);
	int nSlot = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : -1;
	int nValue = Lua_GetTopIndex(L) >= 2 ?
		(int)Lua_ValueToNumber(L, 2) : 0;
	int nResult = 0;
	if (nSlot >= 0 && nSlot < PHONGTHAN_INSTANCE_KILL_SLOT)
	{
		KMission *pMission = PhongThanEnsureInstanceMission(
			nInstanceId, nSubWorld);
		if (pMission)
		{
			char szValue[32];
			sprintf(szValue, "%d", nValue);
			pMission->SetMission((unsigned long)nSlot, szValue);
			nResult = 1;
		}
	}
	Lua_PushNumber(L, nResult);
	return 1;
}

int LuaInstanceMsg2AllCompat(Lua_State *L)
{
	int nInstanceId = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : 0;
	const char *pszTitle = Lua_GetTopIndex(L) >= 2 && Lua_IsString(L, 2) ?
		Lua_ValueToString(L, 2) : "";
	const char *pszMessage = Lua_GetTopIndex(L) >= 3 && Lua_IsString(L, 3) ?
		Lua_ValueToString(L, 3) : "";
	int nSubWorld = -1;
	KMission *pMission = PhongThanFindInstanceMission(nInstanceId, &nSubWorld);
	int nSent = 0;
	if (pMission && pszMessage && pszMessage[0])
	{
		char szBuffer[MAX_SCIRPTACTION_BUFFERNUM];
		if (pszTitle && pszTitle[0])
			_snprintf(szBuffer, sizeof(szBuffer) - 1, "%s: %s",
				pszTitle, pszMessage);
		else
			g_StrCpyLen(szBuffer, pszMessage, sizeof(szBuffer));
		szBuffer[sizeof(szBuffer) - 1] = 0;
		nSent = (int)pMission->Msg2All(szBuffer, -1);
	}
	Lua_PushNumber(L, nSent);
	return 1;
}

int LuaMonsterOnDeathCompat(Lua_State *L)
{
	int nNpcIndex = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : 0;
	int nSubWorld = -1;
	int nInstanceId = PhongThanInstanceIdFromContext(L, &nSubWorld);
	KMission *pMission = PhongThanEnsureInstanceMission(nInstanceId, nSubWorld);
	int nKillCount = 0;
	if (pMission && PhongThanIsLiveNpc(nNpcIndex))
	{
		nKillCount = pMission->GetMissionValue(PHONGTHAN_INSTANCE_KILL_SLOT) + 1;
		char szValue[32];
		sprintf(szValue, "%d", nKillCount);
		pMission->SetMission(PHONGTHAN_INSTANCE_KILL_SLOT, szValue);
		if (PhongThanIsLiveNpc(Npc[nNpcIndex].m_nLastDamageIdx))
		{
			PHONGTHAN_NPC_EXT_STATE *pState = PhongThanNpcState(nNpcIndex);
			int nAttacker = Npc[nNpcIndex].m_nLastDamageIdx;
			if (pState && Npc[nAttacker].m_Kind == kind_player)
			{
				pState->nOwnerPlayerIndex = Npc[nAttacker].GetPlayerIdx();
				pState->dwOwnerUuid = pState->nOwnerPlayerIndex > 0 ?
					Player[pState->nOwnerPlayerIndex].m_dwID : 0;
			}
		}
	}
	Lua_PushNumber(L, nKillCount);
	return 1;
}

int LuaPlayerInOrOutCompat(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int bEnter = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : 0;
	int nNpcIndex = Lua_GetTopIndex(L) >= 2 ?
		(int)Lua_ValueToNumber(L, 2) : 0;
	int nResult = 0;
	if (PhongThanIsLivePlayer(nPlayerIndex))
	{
		if (bEnter)
		{
			int nCarriage = PhongThanFindSiegeByNpc(nNpcIndex);
			if (!nCarriage)
				nCarriage = PhongThanRegisterExistingSiege(nNpcIndex,
					PhongThanIsLiveNpc(nNpcIndex) ?
					Npc[nNpcIndex].m_NpcSettingIdx : 0);
			nResult = PhongThanAttachPlayerToSiege(nPlayerIndex, nCarriage);
			if (nResult && PhongThanIsLiveNpc(nNpcIndex))
				Npc[nNpcIndex].m_nPeopleIdx = Player[nPlayerIndex].m_nIndex;
		}
		else
		{
			int nGuardIndex = PhongThanFindGuardByPlayer(nPlayerIndex);
			if (nGuardIndex)
			{
				PhongThanDetachGuard(nGuardIndex);
				nResult = 1;
			}
			else
			{
				Player[nPlayerIndex].m_cTask.SetSaveVal(
					TASKVALUE_PT_INSIDE_WEAPON, 0, TRUE);
				nResult = 1;
			}
		}
	}
	Lua_PushNumber(L, nResult);
	return 1;
}

int LuaAddEventCompat(Lua_State *L)
{
	const char *pszFormat = Lua_GetTopIndex(L) >= 1 && Lua_IsString(L, 1) ?
		Lua_ValueToString(L, 1) : NULL;
	int nType = Lua_GetTopIndex(L) >= 2 ?
		(int)Lua_ValueToNumber(L, 2) : 0;
	int nPlayerIndex = GetPlayerIndex(L);
	if (!pszFormat || !pszFormat[0] || !PhongThanIsLivePlayer(nPlayerIndex))
		return 0;
	char szMessage[MAX_SCIRPTACTION_BUFFERNUM];
	const char *pszToken = strstr(pszFormat, "%s");
	if (pszToken)
	{
		int nPrefix = (int)(pszToken - pszFormat);
		if (nPrefix >= (int)sizeof(szMessage)) nPrefix = sizeof(szMessage) - 1;
		memcpy(szMessage, pszFormat, nPrefix);
		szMessage[nPrefix] = 0;
		g_StrCatLen(szMessage, Player[nPlayerIndex].Name, sizeof(szMessage));
		g_StrCatLen(szMessage, pszToken + 2, sizeof(szMessage));
	}
	else
		g_StrCpyLen(szMessage, pszFormat, sizeof(szMessage));
	if (nType == 1)
		KPlayerChat::SendSystemInfo(0, 0, MESSAGE_BROADCAST_ANNOUCE_HEAD,
			szMessage, strlen(szMessage));
	else
		SendMapAnnouncement(Npc[Player[nPlayerIndex].m_nIndex].m_SubWorldIndex,
			szMessage);
	Lua_PushNumber(L, 1);
	return 1;
}

int LuaGetInstanceActiveInfoCompat(Lua_State *L)
{
	int nInstanceId = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : 0;
	PhongThanPushInstanceInfo(L, nInstanceId, 0);
	return 4;
}

int LuaGetInstanceBaseInfoCompat(Lua_State *L)
{
	int nInstanceId = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : 0;
	PhongThanPushInstanceInfo(L, nInstanceId, 1);
	return 5;
}

int LuaGetInstanceTempValueCompat(Lua_State *L)
{
	int nSubWorld = -1;
	int nInstanceId = PhongThanInstanceIdFromContext(L, &nSubWorld);
	int nSlot = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : -1;
	KMission *pMission = PhongThanFindInstanceMission(nInstanceId, &nSubWorld);
	int nValue = pMission && nSlot >= 0 &&
		nSlot < PHONGTHAN_INSTANCE_KILL_SLOT ?
		pMission->GetMissionValue((unsigned long)nSlot) : 0;
	Lua_PushNumber(L, nValue);
	return 1;
}

int LuaSetMissionVCompat(Lua_State *L)
{
	if (Lua_GetTopIndex(L) < 3)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}
	int nMissionId = (int)Lua_ValueToNumber(L, 1);
	int nStoreId = (int)Lua_ValueToNumber(L, 2);
	int nValue = (int)Lua_ValueToNumber(L, 3);
	int nSubWorld = PhongThanCurrentSubWorld(L);
	KMission *pMission = nStoreId >= 0 && nStoreId <
		MAX_MISSIONARRAY_VALUE_COUNT ?
		PhongThanEnsureInstanceMission(nMissionId, nSubWorld) : NULL;
	int nResult = 0;
	if (pMission)
	{
		char szValue[32];
		sprintf(szValue, "%d", nValue);
		pMission->SetMission((unsigned long)nStoreId, szValue);
		nResult = 1;
	}
	Lua_PushNumber(L, nResult);
	return 1;
}

int LuaGetWorldEventValueCompat(Lua_State *L)
{
	DWORD dwEventId = Lua_GetTopIndex(L) >= 1 ?
		(DWORD)Lua_ValueToNumber(L, 1) : 0;
	int nSlot = Lua_GetTopIndex(L) >= 2 ?
		(int)Lua_ValueToNumber(L, 2) : 0;
	Lua_PushNumber(L, PhongThanGetPersistentValue(
		pt_persist_world_event_value, dwEventId, nSlot));
	return 1;
}

int LuaSetWorldEventValueCompat(Lua_State *L)
{
	DWORD dwEventId = Lua_GetTopIndex(L) >= 1 ?
		(DWORD)Lua_ValueToNumber(L, 1) : 0;
	int nSlot = Lua_GetTopIndex(L) >= 2 ?
		(int)Lua_ValueToNumber(L, 2) : 0;
	int nValue = Lua_GetTopIndex(L) >= 3 ?
		(int)Lua_ValueToNumber(L, 3) : 0;
	Lua_PushNumber(L, PhongThanSetPersistentValue(
		pt_persist_world_event_value, dwEventId, nSlot, nValue));
	return 1;
}

int LuaDeleteSubWorldKindNpcsCompat(Lua_State *L)
{
	int nSubWorld = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : -1;
	int nKind = Lua_GetTopIndex(L) >= 2 ?
		(int)Lua_ValueToNumber(L, 2) : -1;
	int nRemoved = 0;
	if (nSubWorld >= 0 && nSubWorld < MAX_SUBWORLD &&
		SubWorld[nSubWorld].m_SubWorldID >= 0)
	{
		for (int i = 1; i < MAX_NPC; ++i)
		{
			if (PhongThanIsLiveNpc(i) &&
				Npc[i].m_SubWorldIndex == nSubWorld &&
				(int)Npc[i].m_Kind == nKind && nKind != kind_player)
			{
				PhongThanRemoveNpc(i);
				++nRemoved;
			}
		}
	}
	Lua_PushNumber(L, nRemoved);
	return 1;
}

int LuaSetBarrierStateCompat(Lua_State *L)
{
	int nNpcIndex = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : 0;
	int nState = Lua_GetTopIndex(L) >= 2 &&
		(int)Lua_ValueToNumber(L, 2) ? 1 : 0;
	PHONGTHAN_NPC_EXT_STATE *pState = PhongThanNpcState(nNpcIndex);
	int nResult = 0;
	if (pState)
	{
		int nSubWorld = Npc[nNpcIndex].m_SubWorldIndex;
		int nRegion = Npc[nNpcIndex].m_RegionIndex;
		if (nSubWorld >= 0 && nSubWorld < MAX_SUBWORLD &&
			nRegion >= 0 && nRegion < 9)
		{
			if (pState->nBarrierState != nState)
			{
				if (nState)
					SubWorld[nSubWorld].m_Region[nRegion].AddRef(
						Npc[nNpcIndex].m_MapX, Npc[nNpcIndex].m_MapY, obj_npc);
				else
					SubWorld[nSubWorld].m_Region[nRegion].DecRef(
						Npc[nNpcIndex].m_MapX, Npc[nNpcIndex].m_MapY, obj_npc);
			}
			pState->nBarrierState = nState;
			Npc[nNpcIndex].m_nNpcParam[MAX_NPCPARAM - 1] = nState;
			Npc[nNpcIndex].m_AiMode = nState ? 0 : Npc[nNpcIndex].m_AiMode;
			nResult = 1;
		}
	}
	Lua_PushNumber(L, nResult);
	return 1;
}

int LuaSetWorldEventProgressCompat(Lua_State *L)
{
	DWORD dwEventId = Lua_GetTopIndex(L) >= 1 ?
		(DWORD)Lua_ValueToNumber(L, 1) : 0;
	int nProgress = Lua_GetTopIndex(L) >= 2 ?
		(int)Lua_ValueToNumber(L, 2) : 0;
	Lua_PushNumber(L, PhongThanSetPersistentValue(
		pt_persist_world_event_progress, dwEventId, 0, nProgress));
	return 1;
}

int LuaGetWorldEventProgressCompat(Lua_State *L)
{
	DWORD dwEventId = Lua_GetTopIndex(L) >= 1 ?
		(DWORD)Lua_ValueToNumber(L, 1) : 0;
	Lua_PushNumber(L, PhongThanGetPersistentValue(
		pt_persist_world_event_progress, dwEventId, 0));
	return 1;
}

#endif // PHONG_THAN_LUA_WAVE9_H
