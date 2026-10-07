-- Phong Than 2026-10-03 (daily3): shared core of Ma De (taskinfo 81), Phuc Kim (71) and Luc Lam Hao Han (bandit
-- side of Van Luong, Tam Son). Lua 4.0: no true/false, no local function, no string/table/math libs.
-- Source is UTF-8 in the scratchpad (daily3\src); the deployed file is TCVN3 (daily3\mk.py).
-- Needs \script\phongthan\daily2\d2_core.lua loaded first (PTD2_Today, PTD2_SD_SPOTS, PTD2_MobName, PTD2_Say ...):
-- the includer loads it (d2_lib.lua in dialog states, d2_core.lua in the ext tick). No TaskNote here.
--
-- Task variables (agent range 2310-2339, verified free in loose + PAK scripts on 2026-10-03).
PTD3_T_DAY = 2310        -- yyyymmdd of the last daily reset
PTD3_T_MD_DONE = 2311    -- Ma De rounds finished today
PTD3_T_MD_STATE = 2312   -- 0 none, 1 active, 2 all souls freed
PTD3_T_MD_INFO = 2313    -- index in PTD2_SD_SPOTS (daily2 data, read only)
PTD3_T_MD_CNT = 2314     -- countA * 100 + countB
PTD3_T_PK_DONE = 2315    -- Phuc Kim deliveries today
PTD3_T_PK_REQ = 2316     -- requested Ba Lac Nhan level 1..5 (0 none)
PTD3_T_PK_GOLD = 2317    -- promised reward (van luong)
PTD3_T_LL_FLAG = 2318    -- 0 none, 1 Luc Lam Dao Tac, 2 Kim Bai Luc Lam Dao Tac
PTD3_T_LL_EXPIRE = 2319  -- SystemTime when the flag expires
PTD3_T_LL_BONUS = 2320   -- yyyymmdd of the last "first robbery of the day" bonus
PTD3_T_LL_JOB = 2321     -- 0 none, 1 convoy job active
PTD3_T_LL_KIND = 2322    -- 1 grain convoy, 2 army convoy (Kim Bai)
PTD3_T_LL_DEADLINE = 2323 -- SystemTime deadline of the job
PTD3_T_LL_DONE = 2324    -- convoys robbed today
PTD3_T_LL_TITLE = 2325   -- title (rank) the player had before the bandit title
PTD3_T_LL_SPOT = 2326    -- convoy spot index
PTD3_T_FK_KEY = 2327     -- field pack key (one pack per player at a time)
PTD3_T_FK_CODE = 2328    -- quest of the pack: 1 Ma De, 2 convoy
PTD3_T_FK_TIME = 2329    -- SystemTime of the spawn / last timer re-arm
PTD3_T_FK_ALIVE = 2330   -- live counted monsters of the pack
PTD3_T_PK_REROLL = 2331  -- Phuc Kim request changes today

PTD3_MAGIC = 20261013
PTD3_MOB_SCRIPT = "\\script\\phongthan\\daily3\\d3_mob.lua"
PTD3_LIFE = 600
PTD3_CODE_MD = 1
PTD3_CODE_LL = 2

-- ---------------------------------------------------------------- Ma De (81)
PTD3_MD_LEVEL = 40
PTD3_MD_MAX = 10         -- rounds per day, after the 5 daily Sieu Do rounds of An Hong
PTD3_MD_NEED = 3
PTD3_MD_EXP = 2500       -- x level, +10% per round already done today ("lien tuc")

-- ---------------------------------------------------------------- Phuc Kim (71)
PTD3_PK_LEVEL = 30
PTD3_PK_MAX = 5
PTD3_PK_REROLL_COST = 20000
-- Ba Lac Nhan level k = material (3, 28 + k); promised van luong per level
PTD3_PK_GOLD = { 5, 12, 25, 50, 100 }

-- ---------------------------------------------------------------- Luc Lam Hao Han
PTD3_LL_MAP = 1016       -- Tam Son
PTD3_LL_NPC = { 1016, 156, 1373, 3465 }   -- VNG placement of \194\204\193\214\186\195\186\186 (maps\\200\253\201\189\185\216_S v_108\085)
PTD3_LL_LEVEL = 20
PTD3_LL_LEVEL2 = 50
PTD3_LL_MAX = 6
PTD3_LL_TIME = 900       -- seconds to rob the convoy
PTD3_LL_FLAGTIME = 3600  -- the bandit title lasts one hour
PTD3_LL_SPOTS = { { 1401, 3448 }, { 1373, 3495 }, { 1396, 3438 } }   -- open ground 30-40 cells from the Hao Han
PTD3_TPL_CART = 364      -- \201\204\179\181 (kind 0, camp 5, AI 0: stands still, can be attacked)
PTD3_TPL_GUARD = 891     -- \207\201\189\231\202\216\206\192\210\187 (kind 0, camp 5, human look)
PTD3_TITLE = { 200, 201 } -- rows added to \settings\RankSetting.txt by ptfix extra_daily3.py
PTD3_LL_NAMES = { "LÙc L©m ßπo T∆c", "Kim Bµi LÙc L©m ßπo T∆c" }

function PTD3_CheckDay()
	local d = PTD2_Today()
	if GetTask(PTD3_T_DAY) ~= d then
		SetTask(PTD3_T_DAY, d)
		SetTask(PTD3_T_MD_DONE, 0)
		SetTask(PTD3_T_PK_DONE, 0)
		SetTask(PTD3_T_PK_REROLL, 0)
		SetTask(PTD3_T_LL_DONE, 0)
	end
end

-- Sieu Do rounds of daily2 finished today (task 2140 day, 2147 count; read only)
function PTD3_SdDoneToday()
	if GetTask(2140) ~= PTD2_Today() then return 0 end
	return GetTask(2147)
end

-- ---------------------------------------------------------------- field packs (same scheme as daily2)
PTD3_OFFS = { {0,0}, {3,0}, {-3,0}, {0,3}, {0,-3}, {3,3}, {-3,-3}, {3,-3}, {-3,3}, {5,0}, {-5,0}, {0,5} }

-- params: 5 = PTD3_MAGIC, 6 = pack key, 7 = owner PlayerIndex, 8 = code * 1000 + tag (9 = decoration)
function PTD3_AddMob(code, tag, tpl, lvl, sw, x, y, name, key, life)
	local ni = AddNpc(tpl, lvl, sw, x * 32, y * 32, 1)
	if not ni or ni <= 0 then ni = AddNpc(tpl, lvl, sw, x * 32, y * 32, 0) end
	if not ni or ni <= 0 then return 0 end
	if name and name ~= "" then SetNpcName(ni, name) end
	if life and life > 0 and SetNpcLife then SetNpcLife(ni, life) end
	SetNpcScript(ni, PTD3_MOB_SCRIPT)
	SetNpcParam(ni, 5, PTD3_MAGIC)
	SetNpcParam(ni, 6, key)
	SetNpcParam(ni, 7, PlayerIndex)
	SetNpcParam(ni, 8, code * 1000 + tag)
	SetNpcTimer(ni, PTD3_MOB_SCRIPT, PTD3_LIFE)
	return ni
end

-- list = { { tag, tpl, level, name, life }, ... } around (x, y) of map
function PTD3_SpawnPack(code, map, x, y, list)
	local sw = SubWorldID2Idx(map)
	if sw == nil or sw < 0 then return 0 end
	local key = random(1, 999999)
	SetTask(PTD3_T_FK_KEY, key)
	SetTask(PTD3_T_FK_CODE, code)
	SetTask(PTD3_T_FK_TIME, SystemTime())
	local alive = 0
	local i = 1
	while list[i] do
		local e = list[i]
		local o = PTD3_OFFS[mod(i - 1, getn(PTD3_OFFS)) + 1]
		local ni = PTD3_AddMob(code, e[1], e[2], e[3], sw, x + o[1], y + o[2], e[4], key, e[5])
		if ni > 0 and e[1] ~= 9 then alive = alive + 1 end
		i = i + 1
	end
	SetTask(PTD3_T_FK_ALIVE, alive)
	return alive
end

function PTD3_PackLive(code)
	if GetTask(PTD3_T_FK_CODE) ~= code then return nil end
	if GetTask(PTD3_T_FK_ALIVE) <= 0 then return nil end
	if SystemTime() - GetTask(PTD3_T_FK_TIME) > PTD3_LIFE + 120 then return nil end
	return 1
end

function PTD3_DropPack()
	SetTask(PTD3_T_FK_KEY, 0)
	SetTask(PTD3_T_FK_CODE, 0)
	SetTask(PTD3_T_FK_ALIVE, 0)
end

-- Ma De: the souls still missing of both kinds + the Chieu Hon Tran (daily2 Sieu Do spots, read only)
function PTD3_MdSpawn(x, y)
	local sp = PTD2_SD_SPOTS[GetTask(PTD3_T_MD_INFO)]
	if not sp then return 0 end
	local c = GetTask(PTD3_T_MD_CNT)
	local list = { { 9, PTD2_TPL_SD_TRAN, 1, "Chi™u HÂn TrÀn" } }
	local i = floor(c / 100)
	while i < PTD3_MD_NEED do
		list[getn(list) + 1] = { 1, sp[2], sp[3], "O∏n Linh " .. PTD2_MobName(sp[2]) }
		i = i + 1
	end
	i = mod(c, 100)
	while i < PTD3_MD_NEED do
		list[getn(list) + 1] = { 2, sp[6], sp[7], "O∏n Linh " .. PTD2_MobName(sp[6]) }
		i = i + 1
	end
	return PTD3_SpawnPack(PTD3_CODE_MD, sp[1], x, y, list)
end

-- Luc Lam: the convoy (cart + guards) at the job spot. Guards are tough, only the cart counts.
function PTD3_LlSpawn()
	local sp = PTD3_LL_SPOTS[GetTask(PTD3_T_LL_SPOT)] or PTD3_LL_SPOTS[1]
	local lv = GetLevel()
	local kind = GetTask(PTD3_T_LL_KIND)
	local n = 3
	local glv = lv - 2
	local glife = 800 + lv * lv
	local cname = "Xe L≠¨ng Quan PhÒ"
	local gname = "Quan Binh ∏p L≠¨ng"
	if kind == 2 then
		n = 5
		glv = lv
		glife = floor(glife * 3 / 2)
		cname = "Xe Qu©n L≠¨ng Tri“u Ca"
		gname = "C m Qu©n ∏p L≠¨ng"
	end
	if glv < 10 then glv = 10 end
	local list = { { 2, PTD3_TPL_CART, lv, cname, 2000 + lv * 150 * kind } }
	local i = 1
	while i <= n do
		list[i + 1] = { 1, PTD3_TPL_GUARD, glv, gname, glife }
		i = i + 1
	end
	return PTD3_SpawnPack(PTD3_CODE_LL, PTD3_LL_MAP, sp[1], sp[2], list)
end

-- ---------------------------------------------------------------- bandit title (Lua flag + visible title)
-- The VNG markers are IB buffs 302 / 1306; this engine maps IB buff ids to skills (302 = Pha Quan Chu,
-- 1306 = Phi Sa Tau Thach), so they cannot be used. Flag in task 2318 + rank title 200/201 instead.
function PTD3_LL_SetTitle(kind)
	local t = PTD3_TITLE[kind]
	if not t then return end
	if GetTask(PTD3_T_LL_FLAG) == 0 and GetRank then
		local r = GetRank() or 0
		if r == PTD3_TITLE[1] or r == PTD3_TITLE[2] then r = 0 end
		SetTask(PTD3_T_LL_TITLE, r)
	end
	if ActiveTitleQualify then ActiveTitleQualify(t) end
	if SetCurTitle then SetCurTitle(t) end
end

function PTD3_LL_ClearTitle()
	local old = GetTask(PTD3_T_LL_TITLE)
	SetTask(PTD3_T_LL_TITLE, 0)
	if not SetCurTitle then return end
	if old > 0 and SetCurTitle(old) == 1 then return end
	SetCurTitle(0)
end

-- PlayerIndex = the robber. Public: also meant for the Van Luong cart death hook (see the daily3 doc).
function PTD3_LL_GrantFlag(kind)
	if kind ~= 2 then kind = 1 end
	if GetTask(PTD3_T_LL_FLAG) == 2 then kind = 2 end
	PTD3_LL_SetTitle(kind)
	SetTask(PTD3_T_LL_FLAG, kind)
	SetTask(PTD3_T_LL_EXPIRE, SystemTime() + PTD3_LL_FLAGTIME)
	Msg2Player("<color=red>Ng≠¨i Æ∑ mang danh hi÷u " .. PTD3_LL_NAMES[kind] .. "!<color> Trong 60 phÛt h∑y v“ Tam S¨n g∆p <color=yellow>LÙc L©m H∂o H∏n<color> (" .. floor(PTD3_LL_NPC[3] / 8) .. "/" .. floor(PTD3_LL_NPC[4] / 16) .. ") nhÀn th≠Îng.")
	if TopMessage then TopMessage("ßoπt xe l≠¨ng thµnh c´ng! Danh hi÷u: " .. PTD3_LL_NAMES[kind]) end
	if AddNote then AddNote(28, 1, "<color=Yellow>LÙc L©m H∂o H∏n<color>: ß∑ c„ danh hi÷u <color=Red>" .. PTD3_LL_NAMES[kind] .. "<color>, trong 60 phÛt v“ <color=Green>Tam S¨n<color> g∆p <color=Green>LÙc L©m H∂o H∏n<color> nhÀn th≠Îng.", 0) end
end

function PTD3_LL_DropFlag()
	SetTask(PTD3_T_LL_FLAG, 0)
	SetTask(PTD3_T_LL_EXPIRE, 0)
	PTD3_LL_ClearTitle()
end

function PTD3_LL_ClearJob()
	SetTask(PTD3_T_LL_JOB, 0)
	SetTask(PTD3_T_LL_DEADLINE, 0)
	if GetTask(PTD3_T_FK_CODE) == PTD3_CODE_LL then PTD3_DropPack() end
end

-- ---------------------------------------------------------------- tick side (every online player, once a minute)
function PTD3_TickPlayer()
	local now = SystemTime()
	if GetTask(PTD3_T_LL_FLAG) > 0 and now > GetTask(PTD3_T_LL_EXPIRE) then
		PTD3_LL_DropFlag()
		Msg2Player("Danh hi÷u LÙc L©m ßπo T∆c Æ∑ h’t hπn.")
	end
	local m, x, y = PTD2_MyPos()
	if GetTask(PTD3_T_LL_JOB) == 1 then
		if now > GetTask(PTD3_T_LL_DEADLINE) then
			PTD3_LL_ClearJob()
			Msg2Player("ßoµn xe l≠¨ng Æ∑ Æi xa, l«n ch∆n Æ≠Íng nµy th t bπi.")
		elseif m == PTD3_LL_MAP and not PTD3_PackLive(PTD3_CODE_LL) then
			PTD3_LlSpawn()
			return
		end
	end
	if GetTask(PTD3_T_MD_STATE) == 1 then
		local sp = PTD2_SD_SPOTS[GetTask(PTD3_T_MD_INFO)]
		if sp and m == sp[1] and not PTD3_PackLive(PTD3_CODE_MD) then
			PTD3_MdSpawn(x, y)
		end
	end
end
