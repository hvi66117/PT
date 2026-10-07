-- Phong Than npc_fix 2026-09-28: Thuong quan hieu uy (shangjunxiaowei) quest-monster death handler; original script.pak \script\[GBK guaiwu]\[GBK shangjunxiaowei].lua (pak3, yichuan 2004).
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
-- Attach at runtime: SetNpcScript(npcIndex, "\\script\\phongthan\\npc_fix\\mob_thuong_quan_hieu_uy.lua"). Changes: none in quest logic (no item).

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
	if (GetPlayerType() == 2) and (GetLevel() >= 25) and (GetTask(2) == 21) then
		SetTask(2,22)
		Msg2Player("§· diÖt trõ t­íng qu©n Th­¬ng phãng háa.")
		TaskNote(29,8)
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
