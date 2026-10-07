-- Phong Than 2026-10-04 (content E4): ext tick of the achievements board. servertimer.lua PTAdm_ExtTick calls
-- PTEXT_thanhtich_Tick() once a minute (protected). dofile only at tick time (cwd = Server).
-- Logic: script\phongthan\content\ac_lib.lua. Doc: docs\features\noi-dung-moi-phong-than-20261004.md.
function PTEXT_thanhtich_Tick()
	if not PTAC_Tick then dofile("script\\phongthan\\content\\ac_lib.lua") end
	if PTAC_Tick then PTAC_Tick() end
end
