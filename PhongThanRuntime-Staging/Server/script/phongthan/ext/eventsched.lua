-- Phong Than 2026-10-04 (content E1): ext tick of the automatic event schedule. servertimer.lua PTAdm_ExtTick calls
-- PTEXT_eventsched_Tick() once a minute (protected). dofile only at tick time (cwd = Server), never at the top level.
-- Logic: script\phongthan\content\ev_lib.lua. Doc: docs\features\noi-dung-moi-phong-than-20261004.md.
function PTEXT_eventsched_Tick()
	if not PTEV_Tick then dofile("script\\phongthan\\content\\ev_lib.lua") end
	if PTEV_Tick then PTEV_Tick() end
end
