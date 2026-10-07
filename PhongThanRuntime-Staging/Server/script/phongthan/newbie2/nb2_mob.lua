-- Phong Than 2026-10-03 (newbie2): action script (SetNpcScript) of
--  * the field monsters that the new-era newbie quests and mat tich count (templates in ext\newbie2.lua
--    PTNB2_BIND_TID, spawn_main population + VNG region monsters of Dong Quan 1014 / Tam Son 1016);
--  * the temporary monsters of this feature (chest Yeu Ma, Bang Lang / Luc Quai / Hoan Cau kings; npc param 0 =
--    PTNB2_TAG, 1 = owner GetPlayerID, 2 = kind).
-- The engine calls LastDamage(npc) with PlayerIndex = the kill owner (KNpc.cpp DoDeath). The quest-item drops of
-- npc_fix\mob_drop.lua (old 2004 chain) are kept: PTDrop_Death runs first for every ordinary monster.
-- DelNpc is never called inside the death handler (deferred to DeathSelf, like the questfix wrapper).
Include("\\script\\phongthan\\npc_fix\\mob_drop.lua")
Include("\\script\\phongthan\\newbie2\\nb2_lib.lua")

function LastDamage(npc)
	local killer = PlayerIndex
	if (killer == nil) or (killer <= 0) then return end
	if GetNpcParam(npc, 0) == PTNB2_TAG then
		PTNB2_Protected(PTNB2_OnTempKill, { npc })
		PlayerIndex = killer
		return
	end
	if PTDrop_Death then call(PTDrop_Death, { npc }, "x", PTNB2_Err) end
	PlayerIndex = killer
	PTNB2_Protected(PTNB2_OnKill, { npc })
	PlayerIndex = killer
end

function DeathSelf(npc)
	if PTNB2_DEL[npc] then
		PTNB2_DEL[npc] = nil
		DelNpc(npc)
	end
end

function Timeout(npc)
	if GetNpcParam(npc, 0) == PTNB2_TAG then
		SetNpcParam(npc, 0, 0)
		PTNB2_DEL[npc] = nil
		DelNpc(npc)
	end
end

function OnDeath(npc)
end

function Revive(npc)
end
