-- Phong Than 2026-10-03 (cankhon2): Thai Tue Su (Can Khon Luan) in Tay Ky (1020) and Trieu Ca (1021).
-- servertimer.lua PTAdm_ExtTick() loads this file and calls PTEXT_cankhon2_Tick() once per minute, protected.
--  1. first tick: ReLoadScript of the NPC script (npc_fix\1020_thai_tue.lua was changed on 2026-10-03);
--  2. keep one Thai Tue Su per city alive (idempotent: stored index + name + map check, respawn when gone),
--     re-bind the script every tick.
-- Template 1130 = "Thai Tue tinh quan (statue revived)", Kind 3, NpcResType passerby034: an animated
-- 8-direction figure (the old template 1116 is a 1-frame statue that stood behind a building, unreachable).
-- Places = the VNG minimap labels ("Thai Tue" beside the south gate of Tay Ky, "Can Khon Luan" in the
-- central square of Trieu Ca), moved onto the nearest open cell that the client grid (maps.pak Region_C)
-- connects to the city streets. Doc: docs\features\can-khon-luan-quay-cpp-phong-than-20261002.md

PTCK2_SCRIPT = "\\script\\phongthan\\npc_fix\\1020_thai_tue.lua"
PTCK2_TPL = 1130
-- "Thai Tue Su (Can Khon Luan)" in TCVN3 (27 bytes)
PTCK2_NAME = "Th\184i Tu\213 S\173 (C\181n Kh\171n Lu\169n)"
-- { map, mpsX, mpsY }
PTCK2_NPCS = {}
PTCK2_NPCS[1] = { 1020, 44464, 102256 }   -- Tay Ky, minimap label "Thai Tue" (display 173/199), near Cua Nam
PTCK2_NPCS[2] = { 1021, 55216, 95984 }    -- Trieu Ca, minimap label "Can Khon Luan" (display 215/187), city square
if PTCK2_IDX == nil then PTCK2_IDX = {} end

function PTCK2_Register()
	if PTCK2_REG then return end
	ReLoadScript(PTCK2_SCRIPT)
	PTCK2_REG = 1
end

function PTCK2_Alive(ni, w)
	if not ni or ni <= 0 then return nil end
	if GetNpcName(ni) ~= PTCK2_NAME then return nil end
	if GetNpcPos(ni) ~= w then return nil end
	return 1
end

function PTCK2_Spawn(s)
	local sw = SubWorldID2Idx(s[1])
	if not sw or sw < 0 then return nil end
	local ni = AddNpc(PTCK2_TPL, 1, sw, s[2], s[3], 0)
	if not ni or ni <= 0 then ni = AddNpc(PTCK2_TPL, 1, sw, s[2] + 64, s[3], 0) end
	if not ni or ni <= 0 then ni = AddNpc(PTCK2_TPL, 1, sw, s[2], s[3] + 64, 0) end
	if not ni or ni <= 0 then return nil end
	SetNpcName(ni, PTCK2_NAME)
	if PTAdm_Log then PTAdm_Log("cankhon2", "OK", "Thai Tue Su map " .. s[1] .. " npc " .. ni) end
	return ni
end

function PTCK2_EnsureNpcs()
	local k = 1
	while PTCK2_NPCS[k] do
		local s = PTCK2_NPCS[k]
		local ni = PTCK2_IDX[k]
		if not PTCK2_Alive(ni, s[1]) then
			ni = PTCK2_Spawn(s)
			PTCK2_IDX[k] = ni
		end
		if ni then SetNpcScript(ni, PTCK2_SCRIPT) end
		k = k + 1
	end
end

function PTEXT_cankhon2_Tick()
	PTCK2_Register()
	PTCK2_EnsureNpcs()
end
