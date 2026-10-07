-- Phong Than npc_fix 2026-09-28: Kim Ha thu (jinxiashou) quest-monster death handler; original script.pak \script\[GBK guaiwu]\[GBK jinxiashou].lua (pak3, yichuan 2004).
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
-- Attach at runtime: SetNpcScript(npcIndex, "\\script\\phongthan\\npc_fix\\mob_kim_ha_thu.lua"). Changes: QuestExchange(2,31,32); LastDamage entry (region ActionScript \script\guaiwu\jinxiashou.lua only has OnDeath, which the engine never calls for an ActionScript).

PTMOB_FULL = "Hµnh trang kh«ng ®ñ chç trèng, ch­a nhËn ®­îc vËt phÈm nhiÖm vô."

function PTMOB_Death(npcIndex)
	local killer = PlayerIndex
	if (killer == nil) or (killer <= 0) then return end
	local world = GetNpcWorldPos(npcIndex)
	local w = GetWorldPos()
	if (world == nil) or (world <= 0) or (w ~= world) then return end
	calc_task()
	PlayerIndex = killer
end

function calc_task()
	if (GetPlayerType() == 2) and (GetLevel() >= 35) and (GetTask(2) == 31) then
		if PTMOB_Give(2,31,32,18) == 1 then
			Msg2Player("T×m ®­îc Kim Hµ qu¸n cña Háa Linh Th¸nh MÉu lµm mÊt, cã thÓ ®em nã ®Õn BÝch Du cung.")
			TaskNote(29,11)
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
