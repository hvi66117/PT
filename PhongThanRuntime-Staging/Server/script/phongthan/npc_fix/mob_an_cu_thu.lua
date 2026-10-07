-- Phong Than npc_fix 2026-09-28: An Cu thu (Cu Da) (anjushou) quest-monster death handler; original script.pak \script\[GBK guaiwu]\[GBK anjushou].lua (pak3, yichuan 2004).
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
-- Attach at runtime: SetNpcScript(npcIndex, "\\script\\phongthan\\npc_fix\\mob_an_cu_thu.lua"). Changes: item only for the member whose own profession task is 42 (VNG also gave the map when another profession var was 42 without advancing); QuestExchange(t,42,43).

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
	local ptype = GetPlayerType()
	local task = 3
	local note = 27
	local step = 18
	if ptype == 1 then
		task = 1
		note = 28
		step = 22
	elseif ptype == 2 then
		task = 2
		note = 29
		step = 17
	end
	if GetTask(task) == 42 then
		if PTMOB_Give(task,42,43,3) == 1 then
			Msg2Player("DiÖt trõ Cù D· t×m ®­îc 1 tÊm An C­ ®å.")
			TaskNote(note,step)
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
