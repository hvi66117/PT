#ifndef PHONG_THAN_BOT_PET_H
#define PHONG_THAN_BOT_PET_H

// Phong Than 2026-10-04 dinhanbot: Lua natives for the "de tu" (summon pet) of a Di Nhan party bot. Included by
// ScriptFuns.cpp inside the _SERVER section, after PhongThanLuaWave7.h (PhongThanIsLiveNpc, PhongThanSpawnNpc).
// Doc: docs\features\dinhan-bot-phong-than-20261004.md
//
//   AddNpcPet(owner, template, npclevel, petlevel) -> pet npc index, 0 on failure.
//     owner    = a live NON-player NPC (the party bot, itself an AiMode-11 pet of the player).
//     template = summon template (359..2032 of Lenh Bai Trieu Hoi), npclevel = NpcSet level of the pet,
//     petlevel = 1..10: slot-4 skill level and the pet10 scale of life / base damage (100 + 50 * (lv - 1))%,
//     the same numbers as the summon skills 450-461 (KSkill::Cast SKILL_SS_CreateNpc, pet10).
//     The pet: AiMode 11, m_nOwnerIdx = owner, Owner[] = owner name, owner.m_nPetIdx = pet (one pet per owner:
//     the previous one is removed first), camp / current camp / series / speed of the owner.
//     KNpcAI::ProcessAIType11 removes it when the owner dies, changes map, hides or is removed (dinhanbot
//     owner check); KNpc death (botparty:P3) removes it when it dies. KNpc::CalcDamage follows the owner chain
//     pet -> bot -> player (dinhanbot), so its hits are the player's (EXP, drops, LastDamage).
//   GetNpcPetIdx(owner) -> the live pet of owner (AiMode 11, m_nOwnerIdx == owner), 0 when none.
//     Its existence is also the Lua capability check ("if AddNpcPet and GetNpcPetIdx then ...").

static int PhongThanBotPetOf(int nOwner)
{
	if (!PhongThanIsLiveNpc(nOwner))
		return 0;
	int nPet = Npc[nOwner].m_nPetIdx;
	if (!PhongThanIsLiveNpc(nPet) || nPet == nOwner || Npc[nPet].m_Kind == kind_player ||
		Npc[nPet].m_AiMode != 11 || Npc[nPet].m_nOwnerIdx != nOwner)
		return 0;
	return nPet;
}

int LuaAddNpcPetCompat(Lua_State *L)
{
	int nTop = Lua_GetTopIndex(L);
	int nOwner = nTop >= 1 ? (int)Lua_ValueToNumber(L, 1) : 0;
	int nTemplate = nTop >= 2 ? (int)Lua_ValueToNumber(L, 2) : -1;
	int nLevel = nTop >= 3 ? (int)Lua_ValueToNumber(L, 3) : 1;
	int nPetLv = nTop >= 4 ? (int)Lua_ValueToNumber(L, 4) : 1;
	int nPet = 0;
	if (PhongThanIsLiveNpc(nOwner) && Npc[nOwner].m_Kind != kind_player && Npc[nOwner].IsAlive() &&
		Npc[nOwner].m_CurrentLifeMax > 0 && nTemplate > 0)
	{
		if (nPetLv < 1) nPetLv = 1;
		if (nPetLv > 10) nPetLv = 10;
		if (nLevel < 1) nLevel = 1;
		if (nLevel > 200) nLevel = 200;
		int nOld = PhongThanBotPetOf(nOwner);
		if (nOld > 0)
		{
			Npc[nOwner].m_nPetIdx = 0;
			SubWorld[Npc[nOld].m_SubWorldIndex].m_Region[Npc[nOld].m_RegionIndex].RemoveNpc(nOld);
			SubWorld[Npc[nOld].m_SubWorldIndex].m_Region[Npc[nOld].m_RegionIndex].DecRef(Npc[nOld].m_MapX, Npc[nOld].m_MapY, obj_npc);
			NpcSet.Remove(nOld);
		}
		int nX = 0, nY = 0;
		Npc[nOwner].GetMpsPos(&nX, &nY);
		nPet = PhongThanSpawnNpc(nTemplate, nLevel, Npc[nOwner].m_SubWorldIndex, nX + 1, nY + 1, FALSE);
		if (nPet > 0)
		{
			KNpc &p = Npc[nPet];
			p.m_Kind = kind_normal;
			p.m_AiMode = 11;
			p.m_bNpcFollowFindPath = FALSE;
			g_StrCpyLen(p.Owner, Npc[nOwner].Name, sizeof(p.Owner));
			p.m_nOwnerIdx = nOwner;
			p.m_nPeopleIdx = 0;
			Npc[nOwner].m_nPetIdx = nPet;
			p.SetCamp(Npc[nOwner].m_Camp);
			p.SetCurrentCamp(Npc[nOwner].m_CurrentCamp);
			p.m_Series = Npc[nOwner].m_Series;
			int nScale = 100 + 50 * (nPetLv - 1);
			p.m_LifeMax = p.m_LifeMax * nScale / 100;
			p.m_CurrentLifeMax = p.m_LifeMax;
			p.m_CurrentLife = p.m_LifeMax;
			p.m_PhysicsDamage.nValue[0] = p.m_PhysicsDamage.nValue[0] * nScale / 100;
			p.m_PhysicsDamage.nValue[2] = p.m_PhysicsDamage.nValue[2] * nScale / 100;
			p.m_CurrentWalkSpeed = Npc[nOwner].m_CurrentWalkSpeed;
			p.m_CurrentRunSpeed = Npc[nOwner].m_CurrentRunSpeed;
			// the template's own slot-4 attack skill (summon templates 359..2032 keep it, see KSkills pet10)
			int nSkill = p.m_SkillList.m_Skills[4].SkillId;
			if (nSkill <= 0)
				nSkill = 1;
			p.m_SkillList.SetNpcSkill(4, nSkill, nPetLv);
			// vancot 2026-10-04: FindSame takes the first slot holding an id; the summon templates carry it in slots
			// 1-4, so slots 1-3 with the same id get the pet level as well (else the pet casts at level 1).
			for (int nPtSlot = 1; nPtSlot < 4; nPtSlot++)
				if (p.m_SkillList.m_Skills[nPtSlot].SkillId == nSkill)
					p.m_SkillList.SetNpcSkill(nPtSlot, nSkill, nPetLv);
			p.m_bNpcRemoveDeath = FALSE;
		}
	}
	Lua_PushNumber(L, nPet);
	return 1;
}

int LuaGetNpcPetIdxCompat(Lua_State *L)
{
	int nOwner = Lua_GetTopIndex(L) >= 1 ? (int)Lua_ValueToNumber(L, 1) : 0;
	Lua_PushNumber(L, PhongThanBotPetOf(nOwner));
	return 1;
}

#endif // PHONG_THAN_BOT_PET_H
