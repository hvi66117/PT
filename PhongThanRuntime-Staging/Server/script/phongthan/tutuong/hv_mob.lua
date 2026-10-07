-- Phong Than 2026-10-02 (tutuong_b): action script of every NPC spawned by Thu Thach Huyen Vu
-- (SetNpcScript in hv_lib.lua PTHV_Tag). Vat To have no DeathScript in Npcs.txt, so the engine calls
-- DeathSelf after the death; the soul/boss templates use their DeathScript (npcdeath\xuanwu_lv*.lua,
-- npcdeath\xuan_wu.lua). Timeout removes NPCs of a run that was abandoned (SetNpcTimeout).
Include("\\script\\phongthan\\tutuong\\hv_lib.lua")

function Revive(npc)
end

function LastDamage(npc)
end

function DeathSelf(npc)
	PTHV_MobDeath(npc)
end

function Timeout(npc)
	if GetNpcParam(npc, 1) ~= 0 then
		SetNpcParam(npc, 1, 0)
		DelNpc(npc)
	end
end