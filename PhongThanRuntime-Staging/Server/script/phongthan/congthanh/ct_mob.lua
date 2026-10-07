-- ct_mob.lua (Lua 4, Phong Than GameServer) - 2026-10-03 congthanh2
-- Action script (SetNpcScript) of every NPC the territory spawns: city-defence attackers and guards (ct_def.lua)
-- and the personal Cuu Linh of task 908 (ct_boss.lua). NpcParam 1 = PTCT_K, 2 = session / summon stamp,
-- 3 = role, 4 = 1 once counted dead, 5/6 = summoner PlayerIndex / id (boss).
--  LastDamage: KNpc::DoDeath, PlayerIndex = the player credited with the kill (bots and guards give none).
--  Revive:     templates with a DeathScript (116, 123) revive after SetNpcRevTime frames: count the death when
--              no player got it, then remove the NPC.
--  DeathSelf:  templates without a DeathScript (guards = bot templates): remove (the ext tick sends a new one).
--  Timeout:    lifetime of the personal Cuu Linh / short delay after LastDamage: remove.
-- Registered by ext\congthanh.lua (ReLoadScript). DelNpc inside these handlers is deferred by the engine.
Include("\\script\\phongthan\\lib\\pt_compat.lua")
Include("\\script\\phongthan\\congthanh\\ct_lib.lua")
Include("\\script\\phongthan\\congthanh\\ct_boss.lua")

-- an attacker died: count it once for the running session
function PTCT_M_Atk(npc, killer)
	if GetNpcParam(npc, 4) ~= 0 then return 0 end
	SetNpcParam(npc, 4, 1)
	if GetGlobalValue(PTCT_GV_STATE) ~= 1 or GetNpcParam(npc, 2) ~= GetGlobalValue(PTCT_GV_KEY) then return 0 end
	local c = GetGlobalValue(PTCT_GV_WKILL) + 1
	SetGlobalValue(PTCT_GV_WKILL, c)
	SetGlobalValue(PTCT_GV_SKILL, GetGlobalValue(PTCT_GV_SKILL) + 1)
	if killer then
		Msg2Player("H\185 qu\169n c\171ng th\181nh: " .. c .. "/" .. GetGlobalValue(PTCT_GV_WSIZE) .. " (\174\238t " .. GetGlobalValue(PTCT_GV_WAVE) .. ")")
	end
	return 1
end

function PTCT_M_Dead(npc, killer)
	local r = GetNpcParam(npc, 3)
	if r == PTCT_ROLE_ATK then return PTCT_M_Atk(npc, killer) end
	if r == PTCT_ROLE_BOSS then return PTCT_B_Killed(npc, killer) end
	return 0
end

function PTCT_M_Remove(npc)
	SetNpcParam(npc, 1, 0)
	DelNpc(npc)
end

function LastDamage(npc)
	if GetNpcParam(npc, 1) ~= PTCT_K then return end
	PTCT_M_Dead(npc, 1)
	SetNpcTimeout(npc, 18)
end

function Revive(npc)
	if GetNpcParam(npc, 1) ~= PTCT_K then return end
	PTCT_M_Dead(npc, nil)
	PTCT_M_Remove(npc)
end

function DeathSelf(npc)
	if GetNpcParam(npc, 1) ~= PTCT_K then return end
	PTCT_M_Dead(npc, nil)
	PTCT_M_Remove(npc)
end

function Timeout(npc)
	if GetNpcParam(npc, 1) ~= PTCT_K then return end
	PTCT_M_Remove(npc)
end
