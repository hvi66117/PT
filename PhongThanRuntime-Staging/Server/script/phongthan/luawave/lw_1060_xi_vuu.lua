-- Phong Than 2026-10-05 (luawave #10): Xi Vuu of Thien Lao (1060). Runs the VNG script \script\tian_lao\chi_you.lua
-- (script.pak, GBK path) unchanged; it calls GetCheatTime(), which this engine never registered, so the dialog
-- aborted: give it a fallback (0) first. ASCII only.

function PTLW_CheatTime()
	return 0
end

if GetCheatTime == nil then GetCheatTime = PTLW_CheatTime end
Include("\92script\92\204\236\192\206\92\242\191\211\200.lua")
