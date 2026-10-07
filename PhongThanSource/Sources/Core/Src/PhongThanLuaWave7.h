#ifndef PHONG_THAN_LUA_WAVE7_H
#define PHONG_THAN_LUA_WAVE7_H

// Phong Than VNG Lua completion campaign - Wave 7.
// This file is included by ScriptFuns.cpp inside the server-only section.
// The legacy NPC array recycles indices, therefore every extension record is
// guarded by the engine-owned m_dwID before it can be read.

#define PHONGTHAN_EFFECT_NPC_MAX 16

struct PHONGTHAN_NPC_EXT_STATE
{
	DWORD dwNpcId;
	int nOriginalTemplate;
	int nMorphTemplate;
	DWORD dwAiScriptId;
	int nTargetIndex;
	DWORD dwTargetId;
	int nGuardLevel;
	int nOwnerPlayerIndex;
	DWORD dwOwnerUuid;
	int nCreatureSkill;
	int nCreatureType;
	int nEffectCount;
	int bCaptured;
	int nHardAttrib;
	int nBarrierState;
};

struct PHONGTHAN_EFFECT_NPC_REF
{
	int nNpcIndex;
	DWORD dwNpcId;
	int nTemplateId;
};

struct PHONGTHAN_PLAYER_NPC_STATE
{
	DWORD dwPlayerUuid;
	DWORD dwPlayerNpcId;
	int nOriginalTemplate;
	int nMorphTemplate;
	int nCreatureSkill;
	int nCreatureType;
	int nMotionTarget;
	DWORD dwMotionTargetId;
	int nMotionInterruptMask;
	int nEffectCount;
	int nEffectUsed;
	PHONGTHAN_EFFECT_NPC_REF Effect[PHONGTHAN_EFFECT_NPC_MAX];
};

static PHONGTHAN_NPC_EXT_STATE g_PhongThanNpcExt[MAX_NPC];
static PHONGTHAN_PLAYER_NPC_STATE g_PhongThanPlayerNpcState[MAX_PLAYER];

static int PhongThanIsLiveNpc(int nNpcIndex)
{
	return nNpcIndex > 0 && nNpcIndex < MAX_NPC &&
		Npc[nNpcIndex].m_dwID != 0 && Npc[nNpcIndex].m_RegionIndex >= 0;
}

static PHONGTHAN_NPC_EXT_STATE *PhongThanNpcState(int nNpcIndex)
{
	if (!PhongThanIsLiveNpc(nNpcIndex))
		return NULL;
	PHONGTHAN_NPC_EXT_STATE *pState = &g_PhongThanNpcExt[nNpcIndex];
	if (pState->dwNpcId != Npc[nNpcIndex].m_dwID)
	{
		ZeroMemory(pState, sizeof(*pState));
		pState->dwNpcId = Npc[nNpcIndex].m_dwID;
		pState->nOriginalTemplate = Npc[nNpcIndex].m_NpcSettingIdx;
		pState->nMorphTemplate = -1;
		pState->nTargetIndex = 0;
		pState->nGuardLevel = 0;
		pState->nHardAttrib = -1;
		pState->nBarrierState = 1;
	}
	return pState;
}

static int PhongThanIsLivePlayer(int nPlayerIndex)
{
	if (nPlayerIndex <= 0 || nPlayerIndex >= MAX_PLAYER)
		return 0;
	int nNpcIndex = Player[nPlayerIndex].m_nIndex;
	return PhongThanIsLiveNpc(nNpcIndex) &&
		Npc[nNpcIndex].m_Kind == kind_player;
}

static PHONGTHAN_PLAYER_NPC_STATE *PhongThanPlayerState(int nPlayerIndex)
{
	if (!PhongThanIsLivePlayer(nPlayerIndex))
		return NULL;
	int nNpcIndex = Player[nPlayerIndex].m_nIndex;
	PHONGTHAN_PLAYER_NPC_STATE *pState =
		&g_PhongThanPlayerNpcState[nPlayerIndex];
	if (pState->dwPlayerUuid != Player[nPlayerIndex].m_dwID ||
		pState->dwPlayerNpcId != Npc[nNpcIndex].m_dwID)
	{
		ZeroMemory(pState, sizeof(*pState));
		pState->dwPlayerUuid = Player[nPlayerIndex].m_dwID;
		pState->dwPlayerNpcId = Npc[nNpcIndex].m_dwID;
		pState->nOriginalTemplate = Npc[nNpcIndex].m_NpcSettingIdx;
		pState->nMorphTemplate = -1;
		pState->nCreatureType = -1;
	}
	return pState;
}

static void PhongThanRemoveNpc(int nNpcIndex)
{
	if (!PhongThanIsLiveNpc(nNpcIndex))
		return;
	int nSubWorld = Npc[nNpcIndex].m_SubWorldIndex;
	int nRegion = Npc[nNpcIndex].m_RegionIndex;
	if (nSubWorld >= 0 && nSubWorld < MAX_SUBWORLD &&
		nRegion >= 0 && nRegion < 9)
	{
		SubWorld[nSubWorld].m_Region[nRegion].RemoveNpc(nNpcIndex);
		PHONGTHAN_NPC_EXT_STATE *pState = &g_PhongThanNpcExt[nNpcIndex];
		if (pState->dwNpcId != Npc[nNpcIndex].m_dwID ||
			pState->nBarrierState != 0)
			SubWorld[nSubWorld].m_Region[nRegion].DecRef(
				Npc[nNpcIndex].m_MapX, Npc[nNpcIndex].m_MapY, obj_npc);
	}
	ZeroMemory(&g_PhongThanNpcExt[nNpcIndex],
		sizeof(g_PhongThanNpcExt[nNpcIndex]));
	NpcSet.Remove(nNpcIndex);
}

static int PhongThanSpawnNpc(int nTemplateId, int nLevel, int nSubWorld,
	int nMpsX, int nMpsY, BOOL bBarrier)
{
	if (nTemplateId < 0 || nTemplateId > g_NpcSetting.GetHeight() - 2 ||
		nSubWorld < 0 || nSubWorld >= MAX_SUBWORLD ||
		SubWorld[nSubWorld].m_SubWorldID < 0)
		return 0;
	if (nLevel < 1)
		nLevel = 1;
	int nNpcIndex = NpcSet.Add(MAKELONG(nLevel, nTemplateId),
		nSubWorld, nMpsX, nMpsY, bBarrier);
	if (nNpcIndex > 0)
		PhongThanNpcState(nNpcIndex);
	return nNpcIndex;
}

static int PhongThanOwnerPlayerFromNpc(int nNpcIndex)
{
	PHONGTHAN_NPC_EXT_STATE *pState = PhongThanNpcState(nNpcIndex);
	if (pState && PhongThanIsLivePlayer(pState->nOwnerPlayerIndex) &&
		Player[pState->nOwnerPlayerIndex].m_dwID == pState->dwOwnerUuid)
		return pState->nOwnerPlayerIndex;
	int nOwnerNpc = PhongThanIsLiveNpc(nNpcIndex) ?
		Npc[nNpcIndex].m_nOwnerIdx : 0;
	if (PhongThanIsLiveNpc(nOwnerNpc) && Npc[nOwnerNpc].m_Kind == kind_player &&
		Npc[nOwnerNpc].GetPlayerIdx() > 0)
		return Npc[nOwnerNpc].GetPlayerIdx();
	return 0;
}

static void PhongThanSetNpcOwner(int nNpcIndex, int nPlayerIndex)
{
	PHONGTHAN_NPC_EXT_STATE *pState = PhongThanNpcState(nNpcIndex);
	if (!pState || !PhongThanIsLivePlayer(nPlayerIndex))
		return;
	pState->nOwnerPlayerIndex = nPlayerIndex;
	pState->dwOwnerUuid = Player[nPlayerIndex].m_dwID;
	Npc[nNpcIndex].m_nOwnerIdx = Player[nPlayerIndex].m_nIndex;
	g_StrCpyLen(Npc[nNpcIndex].Owner, Player[nPlayerIndex].Name,
		sizeof(Npc[nNpcIndex].Owner));
}

static void PhongThanPurgeEffectRefs(PHONGTHAN_PLAYER_NPC_STATE *pState)
{
	if (!pState)
		return;
	int nWrite = 0;
	for (int i = 0; i < pState->nEffectUsed; ++i)
	{
		int nNpcIndex = pState->Effect[i].nNpcIndex;
		if (PhongThanIsLiveNpc(nNpcIndex) &&
			Npc[nNpcIndex].m_dwID == pState->Effect[i].dwNpcId)
		{
			if (nWrite != i)
				pState->Effect[nWrite] = pState->Effect[i];
			++nWrite;
		}
	}
	pState->nEffectUsed = nWrite;
	if (pState->nEffectCount > nWrite)
		pState->nEffectCount = nWrite;
}

int LuaGetHardNpcAttribCompat(Lua_State *L)
{
	int nNpcIndex = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : 0;
	PHONGTHAN_NPC_EXT_STATE *pState = PhongThanNpcState(nNpcIndex);
	int nAttrib = -1;
	if (pState && Npc[nNpcIndex].m_btSpecial != npc_normal)
	{
		if (pState->nHardAttrib < 0)
		{
			DWORD dwSeed = Npc[nNpcIndex].m_dwID ^
				((DWORD)Npc[nNpcIndex].m_NpcSettingIdx << 11) ^
				((DWORD)Npc[nNpcIndex].m_Level << 3);
			pState->nHardAttrib = (int)(dwSeed & 7);
		}
		nAttrib = pState->nHardAttrib;
	}
	Lua_PushNumber(L, nAttrib);
	return 1;
}

int LuaNpcPolyMorphCompat(Lua_State *L)
{
	int nNpcIndex = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : 0;
	int nTemplateId = Lua_GetTopIndex(L) >= 2 ?
		(int)Lua_ValueToNumber(L, 2) : -1;
	PHONGTHAN_NPC_EXT_STATE *pState = PhongThanNpcState(nNpcIndex);
	int nResult = 0;
	if (pState)
	{
		int nTarget = nTemplateId < 0 ? pState->nOriginalTemplate : nTemplateId;
		if (nTarget >= 0 && nTarget <= g_NpcSetting.GetHeight() - 2)
		{
			Npc[nNpcIndex].m_NpcSettingIdx = nTarget;
			pState->nMorphTemplate = nTemplateId < 0 ? -1 : nTarget;
			Npc[nNpcIndex].SendSyncData(0, TRUE);
			nResult = 1;
		}
	}
	Lua_PushNumber(L, nResult);
	return 1;
}

int LuaSetAIScriptCompat(Lua_State *L)
{
	int nNpcIndex = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : 0;
	const char *pszScript = Lua_GetTopIndex(L) >= 2 && Lua_IsString(L, 2) ?
		Lua_ValueToString(L, 2) : NULL;
	PHONGTHAN_NPC_EXT_STATE *pState = PhongThanNpcState(nNpcIndex);
	int nResult = 0;
	if (pState && pszScript && pszScript[0] && g_GetScript(pszScript))
	{
		pState->dwAiScriptId = g_FileName2Id((char *)pszScript);
		// Execute the initialization boundary immediately.  The script remains
		// identified separately from ActionScript/DeathScript in extension state.
		NpcSet.ExecuteScript(nNpcIndex, pState->dwAiScriptId,
			"OnInit", nNpcIndex);
		nResult = 1;
	}
	Lua_PushNumber(L, nResult);
	return 1;
}

int LuaSetNpcCampCompat(Lua_State *L)
{
	int nNpcIndex = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : 0;
	int nCamp = Lua_GetTopIndex(L) >= 2 ?
		(int)Lua_ValueToNumber(L, 2) : -1;
	int nResult = 0;
	if (PhongThanNpcState(nNpcIndex) && nCamp >= 0 && nCamp < camp_num)
	{
		Npc[nNpcIndex].SetCamp(nCamp);
		nResult = 1;
	}
	Lua_PushNumber(L, nResult);
	return 1;
}

int LuaSetGuardLevelCompat(Lua_State *L)
{
	int nNpcIndex = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : 0;
	int nLevel = Lua_GetTopIndex(L) >= 2 ?
		(int)Lua_ValueToNumber(L, 2) : 0;
	PHONGTHAN_NPC_EXT_STATE *pState = PhongThanNpcState(nNpcIndex);
	int nResult = 0;
	if (pState)
	{
		if (nLevel < 0) nLevel = 0;
		if (nLevel > 255) nLevel = 255;
		pState->nGuardLevel = nLevel;
		nResult = 1;
	}
	Lua_PushNumber(L, nResult);
	return 1;
}

int LuaAddTotemNpcCompat(Lua_State *L)
{
	if (Lua_GetTopIndex(L) < 5)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}
	int nNpcIndex = PhongThanSpawnNpc(
		(int)Lua_ValueToNumber(L, 1), (int)Lua_ValueToNumber(L, 2),
		(int)Lua_ValueToNumber(L, 3), (int)Lua_ValueToNumber(L, 4),
		(int)Lua_ValueToNumber(L, 5), FALSE);
	int nPlayerIndex = GetPlayerIndex(L);
	if (nNpcIndex > 0 && PhongThanIsLivePlayer(nPlayerIndex))
	{
		PhongThanSetNpcOwner(nNpcIndex, nPlayerIndex);
		Npc[nNpcIndex].m_AiMode = 11;
		// Phong Than 2026-10-02: the pet fights for its owner's side; with the template camp it could be
		// on the monsters' side, so GetNearestNpc(relation_enemy) found nothing and skills were refused.
		Npc[nNpcIndex].SetCamp(Npc[Player[nPlayerIndex].m_nIndex].m_Camp);
		Npc[nNpcIndex].SetCurrentCamp(Npc[Player[nPlayerIndex].m_nIndex].m_CurrentCamp);
		Npc[nNpcIndex].m_nPeopleIdx = Player[nPlayerIndex].m_nIndex;
	}
	Lua_PushNumber(L, nNpcIndex);
	return 1;
}

int LuaAddMyTrapCompat(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (!PhongThanIsLivePlayer(nPlayerIndex) || Lua_GetTopIndex(L) < 3)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}
	int nPlayerNpc = Player[nPlayerIndex].m_nIndex;
	int nX = 0, nY = 0;
	Npc[nPlayerNpc].GetMpsPos(&nX, &nY);
	int nNpcIndex = PhongThanSpawnNpc((int)Lua_ValueToNumber(L, 1),
		(int)Lua_ValueToNumber(L, 2), Npc[nPlayerNpc].m_SubWorldIndex,
		nX, nY, FALSE);
	if (nNpcIndex > 0)
	{
		PhongThanSetNpcOwner(nNpcIndex, nPlayerIndex);
		Npc[nNpcIndex].m_AiMode = 11;
		// Phong Than 2026-10-02: the pet fights for its owner's side; with the template camp it could be
		// on the monsters' side, so GetNearestNpc(relation_enemy) found nothing and skills were refused.
		Npc[nNpcIndex].SetCamp(Npc[Player[nPlayerIndex].m_nIndex].m_Camp);
		Npc[nNpcIndex].SetCurrentCamp(Npc[Player[nPlayerIndex].m_nIndex].m_CurrentCamp);
		int nFrames = (int)Lua_ValueToNumber(L, 3);
		if (nFrames < 1) nFrames = 1;
		Npc[nNpcIndex].m_nNpcTimerValue = nFrames;
		Npc[nNpcIndex].m_dwNpcTimerDeadline =
			g_SubWorldSet.GetGameTime() + nFrames;
	}
	Lua_PushNumber(L, nNpcIndex);
	return 1;
}

int LuaGetMorphTypeCompat(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	PHONGTHAN_PLAYER_NPC_STATE *pState = PhongThanPlayerState(nPlayerIndex);
	Lua_PushNumber(L, pState ? pState->nMorphTemplate : -1);
	return 1;
}

int LuaSetNpcTargetCompat(Lua_State *L)
{
	int nNpcIndex = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : 0;
	int nTargetIndex = Lua_GetTopIndex(L) >= 2 ?
		(int)Lua_ValueToNumber(L, 2) : 0;
	PHONGTHAN_NPC_EXT_STATE *pState = PhongThanNpcState(nNpcIndex);
	int nResult = 0;
	if (pState && PhongThanIsLiveNpc(nTargetIndex) &&
		Npc[nNpcIndex].m_SubWorldIndex == Npc[nTargetIndex].m_SubWorldIndex)
	{
		pState->nTargetIndex = nTargetIndex;
		pState->dwTargetId = Npc[nTargetIndex].m_dwID;
		Npc[nNpcIndex].m_nPeopleIdx = nTargetIndex;
		nResult = 1;
	}
	Lua_PushNumber(L, nResult);
	return 1;
}

int LuaPolyMorphCompat(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	PHONGTHAN_PLAYER_NPC_STATE *pState = PhongThanPlayerState(nPlayerIndex);
	int nTemplateId = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : -1;
	int nResult = 0;
	if (pState)
	{
		int nNpcIndex = Player[nPlayerIndex].m_nIndex;
		int nTarget = nTemplateId < 0 ? pState->nOriginalTemplate : nTemplateId;
		if (nTarget >= 0 && nTarget <= g_NpcSetting.GetHeight() - 2)
		{
			Npc[nNpcIndex].m_NpcSettingIdx = nTarget;
			pState->nMorphTemplate = nTemplateId < 0 ? -1 : nTarget;
			Npc[nNpcIndex].SendSyncData(0, TRUE);
			nResult = 1;
		}
	}
	Lua_PushNumber(L, nResult);
	return 1;
}

int LuaGetCreatureInfoCompat(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	PHONGTHAN_PLAYER_NPC_STATE *pState = PhongThanPlayerState(nPlayerIndex);
	Lua_PushNumber(L, pState ? pState->nCreatureSkill : 0);
	Lua_PushNumber(L, pState ? pState->nCreatureType : -1);
	return 2;
}

int LuaSetCreatureTypeCompat(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	PHONGTHAN_PLAYER_NPC_STATE *pState = PhongThanPlayerState(nPlayerIndex);
	int nResult = 0;
	if (pState && Lua_GetTopIndex(L) >= 2)
	{
		pState->nCreatureSkill = (int)Lua_ValueToNumber(L, 1);
		pState->nCreatureType = (int)Lua_ValueToNumber(L, 2);
		int nPlayerNpc = Player[nPlayerIndex].m_nIndex;
		int nPetIndex = Npc[nPlayerNpc].m_nPetIdx;
		if (PhongThanIsLiveNpc(nPetIndex) && pState->nCreatureType >= 0 &&
			pState->nCreatureType <= g_NpcSetting.GetHeight() - 2)
		{
			Npc[nPetIndex].m_NpcSettingIdx = pState->nCreatureType;
			Npc[nPetIndex].SendSyncData(0, TRUE);
		}
		nResult = 1;
	}
	Lua_PushNumber(L, nResult);
	return 1;
}

int LuaDelNpcTimerCompat(Lua_State *L)
{
	int nNpcIndex = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : 0;
	int nResult = 0;
	if (PhongThanNpcState(nNpcIndex))
	{
		Npc[nNpcIndex].m_TimerScriptID = 0;
		Npc[nNpcIndex].m_nNpcTimerValue = 0;
		Npc[nNpcIndex].m_dwNpcTimerDeadline = 0;
		nResult = 1;
	}
	Lua_PushNumber(L, nResult);
	return 1;
}

int LuaCancelNpcBelongerCompat(Lua_State *L)
{
	int nNpcIndex = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : 0;
	PHONGTHAN_NPC_EXT_STATE *pState = PhongThanNpcState(nNpcIndex);
	int nResult = 0;
	if (pState)
	{
		pState->nOwnerPlayerIndex = 0;
		pState->dwOwnerUuid = 0;
		Npc[nNpcIndex].m_nOwnerIdx = 0;
		Npc[nNpcIndex].Owner[0] = 0;
		nResult = 1;
	}
	Lua_PushNumber(L, nResult);
	return 1;
}

int LuaBeginMotionCompat(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	if (!PhongThanIsLivePlayer(nPlayerIndex) || Lua_GetTopIndex(L) < 5 ||
		!Lua_IsString(L, 4))
	{
		Lua_PushNumber(L, 0);
		return 1;
	}
	const char *pszScript = Lua_ValueToString(L, 4);
	if (!pszScript || !pszScript[0] || !g_GetScript(pszScript))
	{
		Lua_PushNumber(L, 0);
		return 1;
	}
	int nSeconds = (int)Lua_ValueToNumber(L, 3);
	if (nSeconds < 1) nSeconds = 1;
	if (nSeconds > 3600) nSeconds = 3600;
	Player[nPlayerIndex].m_dwTaskExcuteScriptId =
		g_FileName2Id((char *)pszScript);
	const char *pszFunction = Lua_GetTopIndex(L) >= 6 && Lua_IsString(L, 6) ?
		Lua_ValueToString(L, 6) : MAINFUNCTIONNAME;
	g_StrCpyLen(Player[nPlayerIndex].m_szTaskExcuteFun,
		pszFunction && pszFunction[0] ? pszFunction : MAINFUNCTIONNAME,
		sizeof(Player[nPlayerIndex].m_szTaskExcuteFun));
	Player[nPlayerIndex].m_nPaceBarTime = nSeconds * GAME_FPS;
	Player[nPlayerIndex].m_nPaceBarTimeMax =
		Player[nPlayerIndex].m_nPaceBarTime;
	// Keep target identity and interrupt policy without reusing unrelated
	// player currency/task fields.
	PHONGTHAN_PLAYER_NPC_STATE *pState = PhongThanPlayerState(nPlayerIndex);
	if (pState)
	{
		pState->nMotionTarget = (int)Lua_ValueToNumber(L, 1);
		pState->dwMotionTargetId = PhongThanIsLiveNpc(pState->nMotionTarget) ?
			Npc[pState->nMotionTarget].m_dwID : 0;
		pState->nMotionInterruptMask = (int)Lua_ValueToNumber(L, 5);
	}
	Lua_PushNumber(L, 1);
	return 1;
}

int LuaGetBossTargetPlayerCompat(Lua_State *L)
{
	int nNpcIndex = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : 0;
	int nTarget = 0;
	PHONGTHAN_NPC_EXT_STATE *pState = PhongThanNpcState(nNpcIndex);
	if (pState)
	{
		int nCandidate[3];
		nCandidate[0] = Npc[nNpcIndex].m_nLastDamageIdx;
		nCandidate[1] = pState->nTargetIndex;
		nCandidate[2] = Npc[nNpcIndex].m_nPeopleIdx;
		for (int i = 0; i < 3; ++i)
		{
			int nNpc = nCandidate[i];
			if (PhongThanIsLiveNpc(nNpc) && Npc[nNpc].m_Kind == kind_player &&
				Npc[nNpc].GetPlayerIdx() > 0)
			{
				nTarget = nNpc;
				break;
			}
		}
	}
	Lua_PushNumber(L, nTarget);
	return 1;
}

int LuaGetNpcPolyMorphCompat(Lua_State *L)
{
	int nNpcIndex = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : 0;
	PHONGTHAN_NPC_EXT_STATE *pState = PhongThanNpcState(nNpcIndex);
	Lua_PushNumber(L, pState ? pState->nMorphTemplate : -1);
	return 1;
}

int LuaSetEffectNpcCompat(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	PHONGTHAN_PLAYER_NPC_STATE *pState = PhongThanPlayerState(nPlayerIndex);
	if (!pState || Lua_GetTopIndex(L) < 3 || !Lua_IsString(L, 1))
	{
		Lua_PushNumber(L, 0);
		return 1;
	}
	PhongThanPurgeEffectRefs(pState);
	if (pState->nEffectUsed >= PHONGTHAN_EFFECT_NPC_MAX)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}
	int nPlayerNpc = Player[nPlayerIndex].m_nIndex;
	int nX = 0, nY = 0;
	Npc[nPlayerNpc].GetMpsPos(&nX, &nY);
	int nNpcIndex = PhongThanSpawnNpc((int)Lua_ValueToNumber(L, 2),
		Npc[nPlayerNpc].m_Level, Npc[nPlayerNpc].m_SubWorldIndex,
		nX + 24 + pState->nEffectUsed * 8, nY + 12, FALSE);
	if (nNpcIndex > 0)
	{
		g_StrCpyLen(Npc[nNpcIndex].Name, Lua_ValueToString(L, 1),
			sizeof(Npc[nNpcIndex].Name));
		PhongThanSetNpcOwner(nNpcIndex, nPlayerIndex);
		Npc[nNpcIndex].m_nPeopleIdx = nPlayerNpc;
		Npc[nNpcIndex].m_bNpcFollowFindPath = TRUE;
		Npc[nNpcIndex].SendSyncData(0, TRUE);
		PHONGTHAN_EFFECT_NPC_REF *pRef =
			&pState->Effect[pState->nEffectUsed++];
		pRef->nNpcIndex = nNpcIndex;
		pRef->dwNpcId = Npc[nNpcIndex].m_dwID;
		pRef->nTemplateId = Npc[nNpcIndex].m_NpcSettingIdx;
		pState->nEffectCount = pState->nEffectUsed;
	}
	Lua_PushNumber(L, nNpcIndex);
	return 1;
}

int LuaSetEffectNpcCountCompat(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	PHONGTHAN_PLAYER_NPC_STATE *pState = PhongThanPlayerState(nPlayerIndex);
	int nResult = 0;
	if (pState && Lua_GetTopIndex(L) >= 1)
	{
		PhongThanPurgeEffectRefs(pState);
		int nCount = (int)Lua_ValueToNumber(L, 1);
		if (nCount < 0) nCount = 0;
		if (nCount > pState->nEffectUsed) nCount = pState->nEffectUsed;
		pState->nEffectCount = nCount;
		nResult = nCount;
	}
	Lua_PushNumber(L, nResult);
	return 1;
}

int LuaGetFreeNpcCountCompat(Lua_State *L)
{
	int nFree = MAX_NPC - 1 - NpcSet.GetNpcNumber();
	if (nFree < 0) nFree = 0;
	Lua_PushNumber(L, nFree);
	return 1;
}

int LuaHaveEffectNpcCompat(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	PHONGTHAN_PLAYER_NPC_STATE *pState = PhongThanPlayerState(nPlayerIndex);
	int nTemplateId = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : -1;
	int nCount = 0;
	if (pState)
	{
		PhongThanPurgeEffectRefs(pState);
		for (int i = 0; i < pState->nEffectUsed; ++i)
			if (pState->Effect[i].nTemplateId == nTemplateId)
				++nCount;
	}
	Lua_PushNumber(L, nCount);
	return 1;
}

int LuaClearEffectNpcCompat(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	PHONGTHAN_PLAYER_NPC_STATE *pState = PhongThanPlayerState(nPlayerIndex);
	int nRemoved = 0;
	if (pState)
	{
		for (int i = 0; i < pState->nEffectUsed; ++i)
		{
			int nNpcIndex = pState->Effect[i].nNpcIndex;
			if (PhongThanIsLiveNpc(nNpcIndex) &&
				Npc[nNpcIndex].m_dwID == pState->Effect[i].dwNpcId)
			{
				PhongThanRemoveNpc(nNpcIndex);
				++nRemoved;
			}
		}
		pState->nEffectUsed = 0;
		pState->nEffectCount = 0;
	}
	Lua_PushNumber(L, nRemoved);
	return 1;
}

int LuaModifyEffectNpcCompat(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	PHONGTHAN_PLAYER_NPC_STATE *pState = PhongThanPlayerState(nPlayerIndex);
	int nTemplateId = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : -1;
	int nChanged = 0;
	if (pState && nTemplateId >= 0 &&
		nTemplateId <= g_NpcSetting.GetHeight() - 2)
	{
		PhongThanPurgeEffectRefs(pState);
		for (int i = 0; i < pState->nEffectUsed; ++i)
		{
			int nNpcIndex = pState->Effect[i].nNpcIndex;
			Npc[nNpcIndex].m_NpcSettingIdx = nTemplateId;
			pState->Effect[i].nTemplateId = nTemplateId;
			PHONGTHAN_NPC_EXT_STATE *pNpcState =
				PhongThanNpcState(nNpcIndex);
			if (pNpcState) pNpcState->nMorphTemplate = nTemplateId;
			Npc[nNpcIndex].SendSyncData(0, TRUE);
			++nChanged;
		}
	}
	Lua_PushNumber(L, nChanged);
	return 1;
}

int LuaCaptureNpcCompat(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	PHONGTHAN_PLAYER_NPC_STATE *pPlayerState =
		PhongThanPlayerState(nPlayerIndex);
	int nNpcIndex = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : 0;
	PHONGTHAN_NPC_EXT_STATE *pNpcState = PhongThanNpcState(nNpcIndex);
	int nResult = 0;
	if (pPlayerState && pNpcState &&
		pPlayerState->nEffectUsed < PHONGTHAN_EFFECT_NPC_MAX)
	{
		PhongThanSetNpcOwner(nNpcIndex, nPlayerIndex);
		Npc[nNpcIndex].m_nPeopleIdx = Player[nPlayerIndex].m_nIndex;
		Npc[nNpcIndex].m_bNpcFollowFindPath = TRUE;
		Npc[nNpcIndex].SetCamp(Npc[Player[nPlayerIndex].m_nIndex].m_Camp);
		pNpcState->bCaptured = 1;
		PHONGTHAN_EFFECT_NPC_REF *pRef =
			&pPlayerState->Effect[pPlayerState->nEffectUsed++];
		pRef->nNpcIndex = nNpcIndex;
		pRef->dwNpcId = Npc[nNpcIndex].m_dwID;
		pRef->nTemplateId = Npc[nNpcIndex].m_NpcSettingIdx;
		pPlayerState->nEffectCount = pPlayerState->nEffectUsed;
		nResult = 1;
	}
	Lua_PushNumber(L, nResult);
	return 1;
}

int LuaCallMonsterAttackerCompat(Lua_State *L)
{
	if (Lua_GetTopIndex(L) < 10)
	{
		Lua_PushNumber(L, 0);
		return 1;
	}
	int nTargetNpc = (int)Lua_ValueToNumber(L, 1);
	if (!PhongThanIsLiveNpc(nTargetNpc))
	{
		Lua_PushNumber(L, 0);
		return 1;
	}
	int nNpcIndex = PhongThanSpawnNpc((int)Lua_ValueToNumber(L, 2),
		(int)Lua_ValueToNumber(L, 3), Npc[nTargetNpc].m_SubWorldIndex,
		(int)Lua_ValueToNumber(L, 4), (int)Lua_ValueToNumber(L, 5), FALSE);
	if (nNpcIndex > 0)
	{
		PHONGTHAN_NPC_EXT_STATE *pState = PhongThanNpcState(nNpcIndex);
		pState->nTargetIndex = nTargetNpc;
		pState->dwTargetId = Npc[nTargetNpc].m_dwID;
		Npc[nNpcIndex].m_nPeopleIdx = nTargetNpc;
		const char *pszTimer = Lua_IsString(L, 6) ?
			Lua_ValueToString(L, 6) : NULL;
		int nLifeSeconds = (int)Lua_ValueToNumber(L, 7);
		if (pszTimer && pszTimer[0] && g_GetScript(pszTimer))
		{
			Npc[nNpcIndex].m_TimerScriptID =
				g_FileName2Id((char *)pszTimer);
			Npc[nNpcIndex].m_nNpcTimerValue = nLifeSeconds;
			Npc[nNpcIndex].m_dwNpcTimerDeadline =
				g_SubWorldSet.GetGameTime() + nLifeSeconds * GAME_FPS;
		}
		const char *pszDeath = Lua_IsString(L, 8) ?
			Lua_ValueToString(L, 8) : NULL;
		if (pszDeath && pszDeath[0] && g_GetScript(pszDeath))
		{
			g_StrCpyLen(Npc[nNpcIndex].ActionScript, pszDeath,
				sizeof(Npc[nNpcIndex].ActionScript));
			Npc[nNpcIndex].m_ActionScriptID =
				g_FileName2Id((char *)pszDeath);
		}
		Npc[nNpcIndex].m_btSpecial =
			(int)Lua_ValueToNumber(L, 9) ? npc_blue : npc_normal;
		if (Lua_GetTopIndex(L) >= 11)
		{
			int nSecondaryTarget = (int)Lua_ValueToNumber(L, 11);
			if (PhongThanIsLiveNpc(nSecondaryTarget) &&
				Npc[nSecondaryTarget].m_SubWorldIndex ==
				Npc[nNpcIndex].m_SubWorldIndex)
			{
				// Preserve the secondary attacker objective in an engine-owned
				// NPC parameter while the primary objective remains in target state.
				Npc[nNpcIndex].m_nNpcParam[0] = nSecondaryTarget;
				Npc[nNpcIndex].m_nNpcParam[1] =
					(int)Npc[nSecondaryTarget].m_dwID;
			}
		}
		Npc[nNpcIndex].SendSyncData(0, TRUE);
	}
	Lua_PushNumber(L, nNpcIndex);
	return 1;
}

int LuaGetNpcBelongerCompat(Lua_State *L)
{
	int nNpcIndex = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : 0;
	Lua_PushNumber(L, PhongThanOwnerPlayerFromNpc(nNpcIndex));
	return 1;
}

int LuaDelBuildingNpcCompat(Lua_State *L)
{
	int nNpcIndex = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : 0;
	int nResult = PhongThanIsLiveNpc(nNpcIndex) ? 1 : 0;
	if (nResult)
		PhongThanRemoveNpc(nNpcIndex);
	Lua_PushNumber(L, nResult);
	return 1;
}

int LuaGetNpcEnmityItemCompat(Lua_State *L)
{
	int nNpcIndex = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : 0;
	int nOrdinal = Lua_GetTopIndex(L) >= 2 ?
		(int)Lua_ValueToNumber(L, 2) : 0;
	int nAttacker = 0;
	int nDamage = 0;
	if (PhongThanNpcState(nNpcIndex) && nOrdinal >= 0 && nOrdinal <= 1)
	{
		nAttacker = Npc[nNpcIndex].m_nLastDamageIdx;
		if (!PhongThanIsLiveNpc(nAttacker))
			nAttacker = 0;
		else
		{
			nDamage = Npc[nNpcIndex].m_CurrentLifeMax -
				Npc[nNpcIndex].m_CurrentLife;
			if (nDamage < 0) nDamage = 0;
		}
	}
	Lua_PushNumber(L, nAttacker);
	Lua_PushNumber(L, nAttacker ? Npc[nAttacker].m_dwID : 0);
	Lua_PushNumber(L, nDamage);
	return 3;
}

int LuaGetGuardLevelCompat(Lua_State *L)
{
	int nPlayerIndex = GetPlayerIndex(L);
	int nLevel = 0;
	if (PhongThanIsLivePlayer(nPlayerIndex))
	{
		PHONGTHAN_NPC_EXT_STATE *pState =
			PhongThanNpcState(Player[nPlayerIndex].m_nIndex);
		if (pState) nLevel = pState->nGuardLevel;
	}
	Lua_PushNumber(L, nLevel);
	return 1;
}

int LuaGetNpcEnmityCountCompat(Lua_State *L)
{
	int nNpcIndex = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : 0;
	int nCount = 0;
	if (PhongThanNpcState(nNpcIndex) &&
		PhongThanIsLiveNpc(Npc[nNpcIndex].m_nLastDamageIdx))
		nCount = 1;
	Lua_PushNumber(L, nCount);
	return 1;
}

int LuaGetNpcOwerCompat(Lua_State *L)
{
	int nNpcIndex = Lua_GetTopIndex(L) >= 1 ?
		(int)Lua_ValueToNumber(L, 1) : 0;
	int nPlayerIndex = PhongThanOwnerPlayerFromNpc(nNpcIndex);
	Lua_PushNumber(L, nPlayerIndex > 0 ? Player[nPlayerIndex].m_dwID : 0);
	return 1;
}

#endif // PHONG_THAN_LUA_WAVE7_H
