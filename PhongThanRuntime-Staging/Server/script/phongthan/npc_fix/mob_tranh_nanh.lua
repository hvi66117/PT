-- Phong Than npc_fix 2026-09-28: Tranh Nanh than thu (zhengning) quest-monster death handler; original script.pak \script\[GBK guaiwu]\[GBK zhengning].lua (pak4, yichuan 2004).
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
-- Attach at runtime: SetNpcScript(npcIndex, "\\script\\phongthan\\npc_fix\\mob_tranh_nanh.lua"). Changes: QuestExchange(t,51,52). No Npcs.txt template named zhengning exists: spawn tid 461 (zheng) + SetNpcName.

PTMOB_FULL = "Hµnh trang kh«ng ®ñ chç trèng, ch­a nhËn ®­îc vËt phÈm nhiÖm vô."

-- Team rule of the VNG original (every member on the NPC's world is credited),
-- with the npc_quests\normal.lua fix: GetTeam() is nil when solo, so use
-- GetTeamSize() and snapshot members before PlayerIndex changes.
function PTMOB_Death(npcIndex)
	local killer = PlayerIndex
	if (killer == nil) or (killer <= 0) then return end
	local world = GetNpcWorldPos(npcIndex)
	local w = GetWorldPos()
	if (world == nil) or (world <= 0) or (w ~= world) then return end
	local n = GetTeamSize()
	local members = {}
	if (n ~= nil) and (n > 0) then
		for i=1,n do
			local m = GetTeamMember(i)
			if (m ~= nil) and (m > 0) then
				members[getn(members)+1] = m
			end
		end
	end
	if getn(members) == 0 then
		members[1] = killer
	end
	local done = {}
	for i=1,getn(members) do
		local m = members[i]
		if done[m] == nil then
			done[m] = 1
			PlayerIndex = m
			local mw = GetWorldPos()
			if mw == world then
				calc_task()
			end
		end
	end
	PlayerIndex = killer
end

function calc_task()
	if GetLevel() < 55 then return end
	local ptype = GetPlayerType()
	if (ptype == 2) and (GetTask(2) == 51) then
		if PTMOB_Give(2,51,52,4) == 1 then
			Msg2Player("DiÖt ®­îc Tr¹nh Nanh thÇn thó, ®o¹t ®­îc ThÇn Dô kÝnh.")
			TaskNote(29,20)
		end
	elseif (ptype == 1) and (GetTask(1) == 51) then
		if PTMOB_Give(1,51,52,4) == 1 then
			Msg2Player("DiÖt ®­îc Tr¹nh Nanh thÇn thó, ®o¹t ®­îc ThÇn Dô kÝnh.")
			TaskNote(28,25)
		end
	elseif (ptype == 0) and (GetTask(3) == 51) then
		if PTMOB_Give(3,51,52,4) == 1 then
			Msg2Player("DiÖt ®­îc Tr¹nh Nanh thÇn thó, ®o¹t ®­îc ThÇn Dô kÝnh.")
			TaskNote(27,21)
		end
	end
end

-- One QuestExchange = compare-and-set on the task value + item grant; a full bag
-- changes nothing, and a second call for the same kill is a no-op.
function PTMOB_Give(task, from, to, eventId)
	if QuestExchange(task, from, to, {}, {{4,eventId,0,0,0,0,1}}) ~= 1 then
		Msg2Player(PTMOB_FULL)
		return 0
	end
	return 1
end

-- Entry points. SetNpcScript (ActionScript) -> engine calls LastDamage(npc) with
-- PlayerIndex = kill owner (KNpc::DoDeath, kind_normal). DeathScript -> OnDeath(npc)
-- (PhongThanRunNpcDeathScript). Revive/DeathSelf are called by SetNpcScript/Revive.
function LastDamage(npcIndex)
	PTMOB_Death(npcIndex)
end

function OnDeath(npcIndex)
	PTMOB_Death(npcIndex)
end

function Revive(npcIndex)
end

function DeathSelf(npcIndex)
end
