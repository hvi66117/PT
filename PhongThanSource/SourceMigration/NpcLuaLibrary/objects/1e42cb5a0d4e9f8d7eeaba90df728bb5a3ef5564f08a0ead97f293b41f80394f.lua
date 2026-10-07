-- Blaze game server startup script
-- Created in 2006-07-19
-- by zhujialiang

function OnDeath(npcidx)
	AddNormalItem(3,87,0,0,0,1)
	DelNpc(npcidx)
end;