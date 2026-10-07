-- Phong Than 2026-10-02 (tutuong_b): DeathScript of Npcs.txt row 2091 (Huyen Vu Hoang Hon), lost VNG file.
-- NPCs spawned by Thu Thach Huyen Vu: credit the owner and remove the NPC (hv_lib.lua PTHV_MobDeath).
-- Other copies (none are placed by region data today) keep the engine behaviour (revive).
Include("\\script\\phongthan\\tutuong\\hv_lib.lua")

function OnDeath(npc)
	PTHV_MobDeath(npc)
end