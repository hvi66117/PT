-- Phong Than 2026-10-04 (content E2): ext tick of the daily login gift. servertimer.lua PTAdm_ExtTick calls
-- PTEXT_dailygift_Tick() once a minute (protected). dofile only at tick time (cwd = Server).
-- Logic: script\phongthan\content\dg_lib.lua. Doc: docs\features\noi-dung-moi-phong-than-20261004.md.
function PTEXT_dailygift_Tick()
	if not PTDG_Tick then dofile("script\\phongthan\\content\\dg_lib.lua") end
	if PTDG_Tick then PTDG_Tick() end
end
