-- Phong Than 2026-10-04 (agent items): minute tick of the Lenh Bai Hanh Trang (pickup filter sync, IB buff bar
-- sync, auto gift, auto clean, fight state back after the box). Run by servertimer.lua PTAdm_ExtTick when
-- "hanhtrang" is in PTADM_EXT_NAMES (protected call). The dofile happens inside the function (tick time,
-- cwd = Server), never at the top level.
function PTEXT_hanhtrang_Tick()
	if not PTHT_Tick then dofile("script\\phongthan\\item\\hanhtrang_lib.lua") end
	if PTHT_Tick then PTHT_Tick() end
end
