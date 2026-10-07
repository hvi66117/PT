-- Phong Than 2026-10-02: ActionScript of the 4 Bao ruong Thong Thien (template 1929, no DeathScript).
-- 2026-10-04 (vtcc, "qua chuan VNG"): VNG chests have no scripted reward (VNG Bao ruong script, script.pak
-- e0b3d463: OnDeath is empty); their loot is the VNG drop table of template 1929 (Treasure 30 x
-- npcdroprate-boss1.ini, Treasure1 6 x baoxiang5.ini), rolled by vt_drop.lua into the breaker's bag.
Include("\\script\\phongthan\\vantien\\vt_lib.lua")
Include("\\script\\phongthan\\vantien\\vt_drop.lua")

function LastDamage(npcIndex)
	local pi = PlayerIndex
	if PTVD_Drop then PTVD_Drop(npcIndex) end
	PlayerIndex = pi
	PTVT_ChestDeath(npcIndex)
end

function Revive(npcIndex)
end

function DeathSelf(npcIndex)
end
