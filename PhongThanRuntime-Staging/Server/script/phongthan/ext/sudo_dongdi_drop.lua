-- sudo_dongdi_drop.lua (2026-10-03): ActionScript of the Dong Di quest-drop monsters (bound by
-- ext\sudo_dongdi.lua). KNpc::DoDeath calls LastDamage for the killer (PlayerIndex); the template
-- DeathScript (VNG kill counters) still runs separately. Doc: docs\features\su-do-dong-di-phong-than-20261003.md
Include("\\script\\phongthan\\lib\\pt_compat.lua")
Include("\\script\\phongthan\\ext\\sudo_dongdi_lib.lua")
function PTSD_DropErr(m)
end
function LastDamage(npc)
	call(PTSD_DY_OnKill, { npc }, "x", PTSD_DropErr)
end
function DeathSelf(npc)
end
function Revive(npc)
end
