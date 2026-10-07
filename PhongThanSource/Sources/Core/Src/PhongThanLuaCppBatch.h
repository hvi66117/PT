#ifndef PHONG_THAN_LUA_CPPBATCH_H
#define PHONG_THAN_LUA_CPPBATCH_H

// Phong Than 2026-10-03 (cppbatch): small server-side Lua natives. Included by ScriptFuns.cpp inside the
// _SERVER section, after PhongThanLuaWave7.h (PhongThanIsLiveNpc).
//
//   SetNpcAiMode(npc, mode) -> 1 when the mode was set, 0 otherwise.
//     Only two modes are accepted, and only for a non-player NPC owned by a live player (AddTotemNpc,
//     SetNpcOwner: m_nOwnerIdx is the owner's NPC and Owner[] is the owner's name):
//       11 = attacking pet (KNpcAI::ProcessAIType11, the AddTotemNpc default);
//       13 = companion pet (PhongThanCompanionFollow in KNpcAI.cpp): follows its owner, never attacks.
//     Both modes remove the NPC when its owner leaves the map, dies, hides or logs out, so a wrong index
//     can never make a map NPC or a monster disappear: anything without a live player owner is refused.
//     Used by the Linh thu pets (script\phongthan\sinhhoat\sh_lib.lua, PTLT_ApplyMode).
//
//   OpenNpcCollectionDlg(page) -> nothing.
//     The VNG "NPC collection" window opened by the Giang Son books (\script\item\<jiang shan juan>1..3.lua)
//     does not exist in this client. The stub only stops the "attempt to call global" Lua error; the Giang
//     Son chain itself is played at Du Khanh (script\phongthan\vienco\gs_*.lua).

#define PHONGTHAN_AI_PET_ATTACK 11
#define PHONGTHAN_AI_PET_COMPANION 13

int LuaSetNpcAiModeCompat(Lua_State *L)
{
	int nTop = Lua_GetTopIndex(L);
	int nNpc = nTop >= 1 ? (int)Lua_ValueToNumber(L, 1) : 0;
	int nMode = nTop >= 2 ? (int)Lua_ValueToNumber(L, 2) : -1;
	int nOk = 0;
	if ((nMode == PHONGTHAN_AI_PET_ATTACK || nMode == PHONGTHAN_AI_PET_COMPANION) &&
		PhongThanIsLiveNpc(nNpc) && Npc[nNpc].m_Kind != kind_player)
	{
		int nOwner = Npc[nNpc].m_nOwnerIdx;
		if (PhongThanIsLiveNpc(nOwner) && Npc[nOwner].m_Kind == kind_player &&
			Npc[nNpc].Owner[0] && strcmp(Npc[nNpc].Owner, Npc[nOwner].Name) == 0)
		{
			Npc[nNpc].m_AiMode = nMode;
			// both modes do their own following; the FindPathNpc escort path would bypass them
			Npc[nNpc].m_bNpcFollowFindPath = FALSE;
			if (nMode == PHONGTHAN_AI_PET_COMPANION)
				Npc[nNpc].m_nPeopleIdx = 0;
			nOk = 1;
		}
	}
	Lua_PushNumber(L, nOk);
	return 1;
}

int LuaOpenNpcCollectionDlgCompat(Lua_State *L)
{
	return 0;
}

#endif // PHONG_THAN_LUA_CPPBATCH_H
