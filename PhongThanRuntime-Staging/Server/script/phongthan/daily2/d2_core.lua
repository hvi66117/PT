-- Phong Than 2026-10-03 (daily2): shared core of the newer-era VNG daily quests
-- Thien Cong (taskinfo 56), Thien Cuong Hon (53), Sieu Do Linh Hon (48), Hap Hon Am Sat (70) and
-- Nhiem vu van chuyen (61). Lua 4.0: no true/false, no local function, no string/table/math libs.
-- Source is UTF-8 in the scratchpad (daily2\src); the deployed file is TCVN3 (daily2\mk.py).
-- This file has no TaskNote: the ext tick (servertimer state) includes it too.
--
-- Task variables (agent range 2140-2179). 2156-2160, 2162, 2166-2168 are skipped: VNG item scripts
-- (friend card, 11.11 card, daily gift packs, cross-server invitation) use them. 2140-2155 are also
-- listed by the 2021 oracle-bone event (inactive, its dates are in 2021).
PTD2_T_DAY = 2140        -- yyyymmdd of the last daily reset
PTD2_T_TC_DONE = 2141    -- Thien Cong rounds finished today
PTD2_T_TC_STEP = 2142    -- Thien Cong current request: 0 none, else taskinfo step + 1
PTD2_T_TCH_DONE = 2143   -- Thien Cuong Hon rounds finished today
PTD2_T_TCH_STATE = 2144  -- 0 none, 1 shadows, 2 star out, 3 soul taken
PTD2_T_TCH_INFO = 2145   -- star * 10000 + map (1042..1051)
PTD2_T_TCH_KILL = 2146   -- shadows killed (0..5)
PTD2_T_SD_DONE = 2147    -- Sieu Do rounds finished today
PTD2_T_SD_STATE = 2148   -- 0 none, 1 active, 2 all souls freed
PTD2_T_SD_INFO = 2149    -- index in PTD2_SD_SPOTS
PTD2_T_SD_CNT = 2150     -- countA * 100 + countB
PTD2_T_HH_DONE = 2151    -- Hap Hon rounds finished today
PTD2_T_HH_STATE = 2152   -- 0 none, 1 active, 2 done
PTD2_T_HH_INFO = 2153    -- target (1..6) * 10 + island (1 Dong Doanh, 2 Phuong Truong)
PTD2_T_HH_CNT = 2154     -- souls taken
PTD2_T_VC_DONE = 2155    -- Van chuyen rounds finished today
PTD2_T_VC_INFO = 2169    -- 0 none, else dest(1..5) * 100000 + goods(1..5) * 1000 + count
PTD2_T_VC_FROM = 2170    -- origin city 1..5
PTD2_T_PK_KEY = 2171     -- field pack key (one pack per player at a time)
PTD2_T_PK_CODE = 2172    -- quest of the pack: 1 Thien Cuong Hon, 2 Sieu Do, 3 Hap Hon
PTD2_T_PK_TIME = 2173    -- SystemTime of the spawn / last timer re-arm
PTD2_T_PK_ALIVE = 2174   -- live monsters of the pack
PTD2_T_TC_REROLL = 2175  -- Thien Cong request changes today

PTD2_MAX = { tc = 5, tch = 6, sd = 5, hh = 4, vc = 7 }
PTD2_MOB_SCRIPT = "\\script\\phongthan\\daily2\\d2_mob.lua"
PTD2_MAGIC = 20261003
PTD2_LIFE = 600          -- seconds a field monster lives without its owner re-arming it
PTD2_CODE_TCH = 1
PTD2_CODE_SD = 2
PTD2_CODE_HH = 3
PTD2_EXIT = "KÕt thóc ®èi tho¹i"

function PTD2_No()
	CloseDialog()
end

function PTD2_Today()
	if date then return tonumber(date("%Y%m%d")) end
	if GetLocalDate then
		local s = GetLocalDate("%Y%m%d")
		if s then return tonumber(s) end
	end
	return floor(SystemTime() / 86400)
end

-- next-day reset of the round counters (an accepted round is kept)
function PTD2_CheckDay()
	local d = PTD2_Today()
	if GetTask(PTD2_T_DAY) ~= d then
		SetTask(PTD2_T_DAY, d)
		SetTask(PTD2_T_TC_DONE, 0)
		SetTask(PTD2_T_TC_REROLL, 0)
		SetTask(PTD2_T_TCH_DONE, 0)
		SetTask(PTD2_T_SD_DONE, 0)
		SetTask(PTD2_T_HH_DONE, 0)
		SetTask(PTD2_T_VC_DONE, 0)
	end
end

function PTD2_MapId(m)
	if m == nil then return 0 end
	if m > 0 and m < 1000 then return m + 1000 end
	return m
end

function PTD2_MyPos()
	local m, x, y = GetWorldPos()
	return PTD2_MapId(m), x, y
end

-- Say with a dynamic option list that always ends with the exit row
function PTD2_Say(text, opts)
	local t = { text, 0 }
	local i = 1
	while opts[i] do
		t[i + 2] = opts[i]
		i = i + 1
	end
	t[i + 2] = PTD2_EXIT .. "/PTD2_No"
	t[2] = i
	t.n = i + 2
	call(Say, t)
end

function PTD2_Talk(text)
	Talk(1, "PTD2_No", text)
end

function PTD2_Rand(a, b)
	if b <= a then return a end
	return random(a, b)
end

-- ---------------------------------------------------------------- field packs
-- ring offsets in cells around the spawn point
PTD2_OFFS = { {0,0}, {3,0}, {-3,0}, {0,3}, {0,-3}, {3,3}, {-3,-3}, {3,-3}, {-3,3}, {5,0}, {-5,0}, {0,5} }

-- Spawns one monster of the current player's pack. Returns the NPC index or 0.
-- tag = slot of the quest (1, 2 = counted kinds, 9 = decoration that is not counted).
function PTD2_AddMob(code, tag, tpl, lvl, sw, x, y, name, key)
	local ni = AddNpc(tpl, lvl, sw, x * 32, y * 32, 1)
	if not ni or ni <= 0 then ni = AddNpc(tpl, lvl, sw, x * 32, y * 32, 0) end
	if not ni or ni <= 0 then return 0 end
	if name and name ~= "" then SetNpcName(ni, name) end
	SetNpcScript(ni, PTD2_MOB_SCRIPT)
	SetNpcParam(ni, 5, PTD2_MAGIC)
	SetNpcParam(ni, 6, key)
	SetNpcParam(ni, 7, PlayerIndex)
	SetNpcParam(ni, 8, code * 1000 + tag)
	SetNpcTimer(ni, PTD2_MOB_SCRIPT, PTD2_LIFE)
	return ni
end

-- list = { { tag, tpl, level, name }, ... }; spawned around (x, y) of map (runtime id).
-- A new key makes every older monster of this player stale (their timer deletes them).
function PTD2_SpawnPack(code, map, x, y, list)
	local sw = SubWorldID2Idx(map)
	if sw == nil or sw < 0 then return 0 end
	local key = random(1, 999999)
	SetTask(PTD2_T_PK_KEY, key)
	SetTask(PTD2_T_PK_CODE, code)
	SetTask(PTD2_T_PK_TIME, SystemTime())
	local alive = 0
	local i = 1
	while list[i] do
		local e = list[i]
		local o = PTD2_OFFS[mod(i - 1, getn(PTD2_OFFS)) + 1]
		local ni = PTD2_AddMob(code, e[1], e[2], e[3], sw, x + o[1], y + o[2], e[4], key)
		if ni > 0 and e[1] ~= 9 then alive = alive + 1 end
		i = i + 1
	end
	SetTask(PTD2_T_PK_ALIVE, alive)
	return alive
end

-- 1 when the current player's pack of this quest is probably still standing
function PTD2_PackLive(code)
	if GetTask(PTD2_T_PK_CODE) ~= code then return nil end
	if GetTask(PTD2_T_PK_ALIVE) <= 0 then return nil end
	if SystemTime() - GetTask(PTD2_T_PK_TIME) > PTD2_LIFE + 120 then return nil end
	return 1
end

function PTD2_DropPack()
	SetTask(PTD2_T_PK_KEY, 0)
	SetTask(PTD2_T_PK_CODE, 0)
	SetTask(PTD2_T_PK_ALIVE, 0)
end

-- ---------------------------------------------------------------- quest data
-- Sieu Do: { map, tplA, lvA, xA, yA, tplB, lvB } (spawn_<map>.lua rows of the field population)
-- PTD2_SD_SPOTS is generated (daily2\gen_spots.py) into d2_data.lua.
Include("\\script\\phongthan\\daily2\\d2_data.lua")

-- Thien Cuong Hon: 36 stars, Bich Du (1042..1046) / Khon Tien (1047..1051)
PTD2_STARS = { "Thiªn Kh«i", "Thiªn C­¬ng", "Thiªn C¬", "Thiªn Nhµn", "Thiªn Dòng", "Thiªn Hïng",
	"Thiªn M·nh", "Thiªn Uy", "Thiªn Anh", "Thiªn Quý", "Thiªn Phó", "Thiªn M·n", "Thiªn C«",
	"Thiªn Th­¬ng", "Thiªn LËp", "Thiªn TiÖp", "Thiªn ¸m", "Thiªn Hùu", "Thiªn Kh«ng", "Thiªn Tèc",
	"Thiªn DÞ", "Thiªn S¸t", "Thiªn Vi", "Thiªn Cøu", "Thiªn Tho¸i", "Thiªn Thä", "Thiªn KiÕm",
	"Thiªn B×nh", "Thiªn Téi", "Thiªn Tæn", "Thiªn B¹i", "Thiªn Lao", "Thiªn TuÖ", "Thiªn B¹o",
	"Thiªn Khèc", "Thiªn X¶o" }
PTD2_TPL_SHADOW = 571    -- Ììî¸ÐÇµÄÓ°×Ó
PTD2_TPL_STAR = 549      -- Ììî¸ÐÇ
PTD2_TCH_SHADOWS = 5

-- Hap Hon: the six island spirits of Îü»ê·û.lua, template rows in Npcs.txt
PTD2_HH_TARGETS = {
	{ 52, "¶i Nh©n" }, { 652, "Quang Quû" }, { 653, "L·o §ång" },
	{ 654, "S¬n Tiªu" }, { 655, "V« Danh Thó" }, { 656, "Th¹ch Di" } }
PTD2_HH_ISLANDS = {
	{ 1055, "§«ng Doanh", 1720, 3043, 88 },
	{ 1056, "Ph­¬ng Tr­îng", 1577, 3038, 90 } }
PTD2_HH_NEED = 6
PTD2_TPL_HH_TRAN = 672   -- Ç¿ÕÐ»êÕó (decoration, kind 2)
PTD2_TPL_SD_TRAN = 551   -- ÕÐ»êÕó (decoration, kind 2)
PTD2_SD_NEED = 3

-- Van chuyen: the five Tap hoa cities, goods = their specialty (material genre 3)
PTD2_VC_CITIES = {
	{ 1002, "Sïng Thµnh" }, { 1003, "Ngäc H­ Cung" }, { 1004, "Xi V­u Mé" },
	{ 1020, "T©y Kú" }, { 1021, "TriÒu Ca" } }
PTD2_VC_GOODS = { { 4, "T¬ lôa" }, { 2, "Linh chi" }, { 1, "L­u huúnh" }, { 5, "B× c¸ch" }, { 0, "Thñy tinh" } }
PTD2_VC_DEPOSIT = 1000   -- l­îng per unit, refunded on delivery

function PTD2_CityIdx(map)
	local i = 1
	while PTD2_VC_CITIES[i] do
		if PTD2_VC_CITIES[i][1] == map then return i end
		i = i + 1
	end
	return 0
end

-- ---------------------------------------------------------------- tick side (respawn)
-- Called for every online player once a minute by the ext tick: a player standing on the map of an
-- active field round whose pack is gone (killed by others, timed out, server restart) gets a new one
-- around him.
function PTD2_TickPlayer()
	local m, x, y = PTD2_MyPos()
	if GetTask(PTD2_T_TCH_STATE) == 1 or GetTask(PTD2_T_TCH_STATE) == 2 then
		local info = GetTask(PTD2_T_TCH_INFO)
		if m == mod(info, 10000) and not PTD2_PackLive(PTD2_CODE_TCH) then
			PTD2_TchSpawn(x, y)
			return
		end
	end
	if GetTask(PTD2_T_SD_STATE) == 1 then
		local sp = PTD2_SD_SPOTS[GetTask(PTD2_T_SD_INFO)]
		if sp and m == sp[1] and not PTD2_PackLive(PTD2_CODE_SD) then
			PTD2_SdSpawn(x, y)
			return
		end
	end
	if GetTask(PTD2_T_HH_STATE) == 1 then
		local isl = PTD2_HH_ISLANDS[mod(GetTask(PTD2_T_HH_INFO), 10)]
		if isl and m == isl[1] and not PTD2_PackLive(PTD2_CODE_HH) then
			PTD2_HhSpawn(x, y)
			return
		end
	end
end

-- Thien Cuong Hon: 5 shadows (state 1, minus the ones already killed) or the star (state 2)
function PTD2_TchSpawn(x, y)
	local info = GetTask(PTD2_T_TCH_INFO)
	local map = mod(info, 10000)
	local star = floor(info / 10000)
	local lv = PTD2_TCH_MAPLV[map] or 60
	local sname = (PTD2_STARS[star] or "Thiªn C­¬ng") .. " Tinh"
	local list = {}
	if GetTask(PTD2_T_TCH_STATE) == 2 then
		list[1] = { 2, PTD2_TPL_STAR, lv + 2, sname }
	else
		local n = PTD2_TCH_SHADOWS - GetTask(PTD2_T_TCH_KILL)
		if n < 1 then n = 1 end
		local i = 1
		while i <= n do
			list[i] = { 1, PTD2_TPL_SHADOW, lv, "¶nh Tö " .. sname }
			i = i + 1
		end
	end
	return PTD2_SpawnPack(PTD2_CODE_TCH, map, x, y, list)
end

-- Sieu Do: the souls still missing of both kinds + the Chieu Hon Tran
function PTD2_SdSpawn(x, y)
	local sp = PTD2_SD_SPOTS[GetTask(PTD2_T_SD_INFO)]
	if not sp then return 0 end
	local c = GetTask(PTD2_T_SD_CNT)
	local ca = floor(c / 100)
	local cb = mod(c, 100)
	local list = { { 9, PTD2_TPL_SD_TRAN, 1, "Chiªu Hån TrËn" } }
	local i = ca
	while i < PTD2_SD_NEED do
		list[getn(list) + 1] = { 1, sp[2], sp[3], "O¸n Hån " .. PTD2_MobName(sp[2]) }
		i = i + 1
	end
	i = cb
	while i < PTD2_SD_NEED do
		list[getn(list) + 1] = { 2, sp[6], sp[7], "O¸n Hån " .. PTD2_MobName(sp[6]) }
		i = i + 1
	end
	return PTD2_SpawnPack(PTD2_CODE_SD, sp[1], x, y, list)
end

-- Hap Hon: the Hap Hon Tran + the souls still missing
function PTD2_HhSpawn(x, y)
	local info = GetTask(PTD2_T_HH_INFO)
	local t = PTD2_HH_TARGETS[floor(info / 10)]
	local isl = PTD2_HH_ISLANDS[mod(info, 10)]
	if not t or not isl then return 0 end
	local list = { { 9, PTD2_TPL_HH_TRAN, 1, "HÊp Hån TrËn" } }
	local i = GetTask(PTD2_T_HH_CNT)
	while i < PTD2_HH_NEED do
		list[getn(list) + 1] = { 1, t[1], isl[5], "¢m Hån " .. t[2] }
		i = i + 1
	end
	return PTD2_SpawnPack(PTD2_CODE_HH, isl[1], x, y, list)
end

function PTD2_MobName(tpl)
	return PTD2_MOBNAMES[tpl] or "Yªu Ma"
end
