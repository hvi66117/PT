-- questfix2 (2026-10-03): ext tick for Quy Tinh (task 53), called once per minute by servertimer.lua
-- (PTAdm_ExtTick -> PTEXT_questfix2_Tick, protected).
-- The Thien Cuong Tinh templates (123 Thien Cuong Tinh, 124 Thien Cuong Ma Tinh) carry DeathScript
-- \script\npcdeath\normal.lua, so the engine revives a killed star and never calls DeathSelf: every star
-- released by a Phong An Thap would stay on the map for good. The star scripts (ptfix extra_questfix2.py)
-- rename a killed star to PTQ2_DEAD; this tick deletes those, and any star older than PTQ2_STAR_TTL minutes
-- (released and left alone; the player gets a new Bach Linh phuon from Duong Tien).
-- The 6 towers stay where servertimer.lua spawns them: the VNG taskinfo gives (217,197) for both Bac Hai and
-- Cu Loc, the Chinese original says the same, and both cells are walkable and reachable from the map exits
-- (docs\features\quy-tinh-hoi-thoai-npc-phong-than-20261003.md). PTQ2_TOWER_POS lets an admin move one
-- later: set { mapId, cellX, cellY } and the tick moves the tower found by map + template 1002.
-- Lua 4: no true/false, no local function.

PTQ2_MAPS = { [1006] = 1, [1007] = 1, [1012] = 1, [1013] = 1, [1010] = 1, [1009] = 1 }
PTQ2_STAR_TPL = { [123] = 1, [124] = 1 }
PTQ2_DEAD_NAME = "PTQ2_DEAD"
PTQ2_STAR_TTL = 30
PTQ2_TOWER_TPL = 1002
PTQ2_TOWER_POS = {}      -- e.g. { { 1013, 1736, 3152 } } (cells); empty = towers stay as spawned
PTQ2_SEEN = {}           -- npc index -> { id = engine id, t = minute first seen }
PTQ2_MIN = 0
PTQ2_LAST = { dead = 0, old = 0, moved = 0, stars = 0 }

function PTQ2_MaxNpc()
	if PTADM_MAX_NPC then return PTADM_MAX_NPC end
	return 48000
end

function PTQ2_MoveTowers()
	local n = 0
	local k = 1
	while PTQ2_TOWER_POS[k] do
		local p = PTQ2_TOWER_POS[k]
		local i = 1
		local mx = PTQ2_MaxNpc()
		while i < mx do
			local id = GetNpcID(i)
			if id and id ~= 0 and GetNpcTemplateID(i) == PTQ2_TOWER_TPL then
				local w, x, y = GetNpcPos(i)
				if w == p[1] and (x ~= p[2] or y ~= p[3]) then
					SetNpcPos(i, p[2], p[3])
					n = n + 1
				end
			end
			i = i + 1
		end
		k = k + 1
	end
	return n
end

function PTEXT_questfix2_Tick()
	PTQ2_MIN = PTQ2_MIN + 1
	local dead, old, stars = 0, 0, 0
	local i = 1
	local mx = PTQ2_MaxNpc()
	while i < mx do
		local id = GetNpcID(i)
		if id and id ~= 0 and PTQ2_STAR_TPL[GetNpcTemplateID(i) or 0] then
			local w = GetNpcPos(i)
			if PTQ2_MAPS[w] then
				stars = stars + 1
				local s = PTQ2_SEEN[i]
				if not s or s.id ~= id then
					s = { id = id, t = PTQ2_MIN }
					PTQ2_SEEN[i] = s
				end
				if GetNpcName(i) == PTQ2_DEAD_NAME then
					DelNpc(i)
					PTQ2_SEEN[i] = nil
					dead = dead + 1
				elseif PTQ2_MIN - s.t >= PTQ2_STAR_TTL then
					DelNpc(i)
					PTQ2_SEEN[i] = nil
					old = old + 1
				end
			end
		end
		i = i + 1
	end
	PTQ2_LAST.dead = dead
	PTQ2_LAST.old = old
	PTQ2_LAST.stars = stars
	PTQ2_LAST.moved = PTQ2_MoveTowers()
end
