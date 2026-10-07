-- Phong Than field-monster population (2026-09-28).
-- 86 of 102 loaded maps have no NPC records: the runtime Region_S NPC sections are empty and no
-- client/server PAK entry holds placement data except maps 1014/1016/1052 (verified by scanning
-- every PAK entry for Region_S/Region_C/Npc_S NPC records). This module adds a GENERATED
-- population through AddNpc: templates per map come from quest/script evidence, positions from
-- client Region_C walkable cells (see the header of each spawn_<mapId>.lua).
--
-- Engine facts (Core\Src):
--  * AddNpc needs 6 arguments; with 5 it creates nothing (ScriptFuns.cpp LuaAddNpc).
--    6th argument = bBarrier: 1 fails on a server obstacle cell, 0 places anywhere.
--  * Every non-player NPC revives at its spawn point after the template ReviveFrame
--    (KNpc::DoRevive/Revive), for AddNpc and Region_S NPCs alike, until DelNpc/ClearMapNpc.
--    So this must run ONCE per server start; a second run duplicates the population.
--  * Npcs.txt DropRateFile/Treasure columns are never read by the engine: kills give EXP only
--    unless a DeathScript/ActionScript/SetNpcDropScript produces items.
--
-- Usage from servertimer.lua (see PTSpawn_Tick below):
--	dofile("script\\phongthan\\spawn\\spawn_main.lua")
--	PTSpawn_Run(2500)   -- call every tick; spawns at most 2500 per call, stops when done

if PT_SPAWN_MAIN_VERSION then return end
PT_SPAWN_MAIN_VERSION = 1

PT_SPAWN_DIR = "script\\phongthan\\spawn\\"
PT_SPAWN_DATA = {}
PT_SPAWN_SPECIAL = {}
-- 1: also spawn the quest-target specials listed in PT_SPAWN_SPECIAL (off by default; several of
-- them are quest monsters whose quest scripts were not verified).
PT_SPAWN_WITH_SPECIAL = nil
-- 1: also populate 1073-1076 (not in the empty-map list; they hold 6-7 service NPCs already).
PT_SPAWN_USE_OPTIONAL = nil

PT_SPAWN_MAPS = {
	1005, 1006, 1007, 1008, 1009, 1010, 1011, 1012, 1013,
	1015, 1017, 1018, 1019, 1065,
	1022, 1023, 1024, 1025, 1026,
	1027, 1028, 1029, 1030, 1031,
	1032, 1033, 1034, 1035, 1036,
	1037, 1038, 1039, 1040, 1041,
	1042, 1043, 1044, 1045, 1046,
	1047, 1048, 1049, 1050, 1051,
	1053, 1054, 1055, 1056, 1057, 1072,
	1077, 1078,
}
PT_SPAWN_MAPS_OPTIONAL = { 1073, 1074, 1075, 1076 }

-- retry offsets in mps (1 cell = 32) when the server obstacle rejects a point
PT_SPAWN_OFFS = { {0,0}, {64,0}, {-64,0}, {0,64}, {0,-64}, {64,64}, {-64,-64}, {128,0}, {-128,0}, {0,128}, {0,-128} }

PT_SPAWN_LOADED = nil
PT_SPAWN_DONE = nil
PT_SPAWN_Q = nil        -- work queue: list of {mapId, rowsTable}
PT_SPAWN_QI = 1         -- queue position
PT_SPAWN_RI = 1         -- row position inside the current queue entry
PT_SPAWN_ADDED = 0
PT_SPAWN_FORCED = 0     -- placed with bBarrier 0 after every offset was rejected
PT_SPAWN_FAILED = 0
PT_SPAWN_SKIPMAP = 0
PT_SPAWN_NPCS = {}
PT_SPAWN_NPCN = 0

function PTSpawn_Put(mapId, rows)
	local t = PT_SPAWN_DATA[mapId]
	if not t then
		t = {}
		PT_SPAWN_DATA[mapId] = t
	end
	local n = getn(t)
	local k = 1
	while rows[k] do
		t[n + k] = rows[k]
		k = k + 1
	end
end

function PTSpawn_LoadList(list)
	local k = 1
	while list[k] do
		dofile(PT_SPAWN_DIR .. "spawn_" .. list[k] .. ".lua")
		k = k + 1
	end
end

function PTSpawn_Load()
	if PT_SPAWN_LOADED then return end
	PTSpawn_LoadList(PT_SPAWN_MAPS)
	if PT_SPAWN_USE_OPTIONAL then PTSpawn_LoadList(PT_SPAWN_MAPS_OPTIONAL) end
	PT_SPAWN_LOADED = 1
end

function PTSpawn_BuildQueue()
	local q = {}
	local n = 0
	local lists = { PT_SPAWN_MAPS }
	if PT_SPAWN_USE_OPTIONAL then lists[2] = PT_SPAWN_MAPS_OPTIONAL end
	local li = 1
	while lists[li] do
		local k = 1
		while lists[li][k] do
			local id = lists[li][k]
			if PT_SPAWN_DATA[id] then
				n = n + 1
				q[n] = { id, PT_SPAWN_DATA[id] }
			end
			if PT_SPAWN_WITH_SPECIAL and PT_SPAWN_SPECIAL[id] then
				n = n + 1
				q[n] = { id, PT_SPAWN_SPECIAL[id] }
			end
			k = k + 1
		end
		li = li + 1
	end
	return q
end

function PTSpawn_SubWorld(mapId)
	local sw = SubWorldID2Idx(mapId)
	if (not sw) or sw < 0 then sw = SubWorldID2Idx(mapId - 1000) end
	if (not sw) or sw < 0 then return nil end
	return sw
end

function PTSpawn_AddOne(sw, tid, lv, x, y)
	local k = 1
	local ni = 0
	while PT_SPAWN_OFFS[k] do
		ni = AddNpc(tid, lv, sw, x + PT_SPAWN_OFFS[k][1], y + PT_SPAWN_OFFS[k][2], 1)
		if ni and ni > 0 then return ni end
		k = k + 1
	end
	-- the point is walkable in client Region_C; place it even if server geometry disagrees
	ni = AddNpc(tid, lv, sw, x, y, 0)
	if ni and ni > 0 then
		PT_SPAWN_FORCED = PT_SPAWN_FORCED + 1
		return ni
	end
	return 0
end

-- Spawns up to budget NPCs per call; returns the number added by this call.
-- Runs once per server start (PT_SPAWN_DONE guard, global in the calling script state).
-- 2026-09-29: quest item drops (npc_fix\mob_drop.lua) for the templates it has rules for.
PT_SPAWN_DROP_TIDS = { [0] = 1, [1] = 1, [2] = 1, [3] = 1, [4] = 1, [6] = 1, [8] = 1, [101] = 1, [102] = 1, [105] = 1, [106] = 1, [114] = 1 }
function PTSpawn_BindDrop(ni, tid)
	if PT_SPAWN_DROP_TIDS[tid] then
		SetNpcScript(ni, "\\script\\phongthan\\npc_fix\\mob_drop.lua")
	end
end

function PTSpawn_Run(budget)
	if PT_SPAWN_DONE then return 0 end
	if not budget or budget <= 0 then budget = 100000 end
	PTSpawn_Load()
	if not PT_SPAWN_Q then
		PT_SPAWN_Q = PTSpawn_BuildQueue()
		PT_SPAWN_QI = 1
		PT_SPAWN_RI = 1
	end
	local added = 0
	while PT_SPAWN_Q[PT_SPAWN_QI] and added < budget do
		local e = PT_SPAWN_Q[PT_SPAWN_QI]
		local sw = PTSpawn_SubWorld(e[1])
		if not sw then
			PT_SPAWN_SKIPMAP = PT_SPAWN_SKIPMAP + 1
			PT_SPAWN_QI = PT_SPAWN_QI + 1
			PT_SPAWN_RI = 1
		else
			local rows = e[2]
			while rows[PT_SPAWN_RI] and added < budget do
				local r = rows[PT_SPAWN_RI]
				local ni = PTSpawn_AddOne(sw, r[1], r[2], r[3], r[4])
				if ni > 0 then
					PT_SPAWN_NPCN = PT_SPAWN_NPCN + 1
					PT_SPAWN_NPCS[PT_SPAWN_NPCN] = ni
					PTSpawn_BindDrop(ni, r[1])
					PT_SPAWN_ADDED = PT_SPAWN_ADDED + 1
				else
					PT_SPAWN_FAILED = PT_SPAWN_FAILED + 1
				end
				added = added + 1
				PT_SPAWN_RI = PT_SPAWN_RI + 1
			end
			if not rows[PT_SPAWN_RI] then
				PT_SPAWN_QI = PT_SPAWN_QI + 1
				PT_SPAWN_RI = 1
			end
		end
	end
	if not PT_SPAWN_Q[PT_SPAWN_QI] then PT_SPAWN_DONE = 1 end
	return added
end

-- Removes every NPC this module spawned since server start (for rollback/testing).
function PTSpawn_ClearAll()
	local k = 1
	local n = 0
	while k <= PT_SPAWN_NPCN do
		if PT_SPAWN_NPCS[k] and PT_SPAWN_NPCS[k] > 0 then
			DelNpc(PT_SPAWN_NPCS[k])
			n = n + 1
		end
		PT_SPAWN_NPCS[k] = nil
		k = k + 1
	end
	PT_SPAWN_NPCN = 0
	return n
end

function PTSpawn_Status()
	local s = "spawn added=" .. PT_SPAWN_ADDED .. " forced=" .. PT_SPAWN_FORCED .. " failed=" .. PT_SPAWN_FAILED .. " skippedMaps=" .. PT_SPAWN_SKIPMAP
	if PT_SPAWN_DONE then s = s .. " done" end
	return s
end
