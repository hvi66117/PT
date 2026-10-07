-- Phong Than 2026-10-02 (agent vantien2): ActionScript of the Van Tien tran mobs (templates 53..60).
-- LastDamage (PlayerIndex = kill owner) credits the Thien Hung daily quest "kill N mobs" to the owner and
-- his team members on the same map (VNG npcdeath\cuong hoa *.lua logic, tasks 2008/2009).
-- The template DeathScript still runs as usual.
Include("\\script\\phongthan\\vantien\\vt_lib.lua")

function LastDamage(npcIndex)
	PTVT_MobDeath(npcIndex)
end

function Revive(npcIndex)
end

function DeathSelf(npcIndex)
end
