-- Phong Than npc_fix 2026-09-28: Ton Vu Tien The (sunwuqianshi) quest-monster death handler; original script.pak \script\[GBK guaiwu]\[GBK sunwuqianshi].lua (pak3, yichuan 2004).
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
-- Attach at runtime: SetNpcScript(npcIndex, "\\script\\phongthan\\npc_fix\\mob_ton_vu_tien_the.lua"). Task 42 bit 2; chance DN/DS/GS = 2/5/2 in 10 (VNG). Changes: AddEventItem+SetTask(42) -> QuestExchange(42,num,num+2).

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
	local num = GetTask(42)
	local i = random(1,10)
	if (num == 0) or (num == 1) or (num == 4) or (num == 5) then
		local ptype = GetPlayerType()
		if GetLevel() < 65 then return end
		if ((ptype == 2) and (GetTask(2) == 63) and (i <= 2)) or ((ptype == 1) and (GetTask(1) == 63) and (i <= 5)) or ((ptype == 0) and (GetTask(3) == 63) and (i <= 2)) then
			if PTMOB_Give(42,num,num+2,6) == 1 then
				Msg2Player("NhËn ®­îc 1 quyÓn HuyÒn N÷ Binh Ph¸p.")
			end
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
