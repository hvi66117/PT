-- Phong Than 2026-10-04 (agent lbdaosi): minute tick of Lenh Bai Dao Si / Lenh Bai Di Nhan.
-- Run by servertimer.lua PTAdm_ExtTick when "lbdaosi" is in PTADM_EXT_NAMES (protected call). The dofile
-- happens inside the function (tick time, cwd = Server), never at the top level.
function PTEXT_lbdaosi_Tick()
	if not PTLB_Tick then dofile("script\\phongthan\\item\\lbdaosi_lib.lua") end
	if PTLB_Tick then PTLB_Tick() end
end
