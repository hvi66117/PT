-- Phong Than 2026-10-02 (tutuong_b): shared constants and helpers for Tu Linh (Linh Te) and
-- Thu Thach Huyen Vu. Lua 4.0 (no true/false, no local function, no string/table/math libs).
-- Source is UTF-8 in the scratchpad (tutuong_b\src); the deployed file is TCVN3 (mk.py).
-- 2026-10-02 (tutuong2): also 2021 (B¹ch Hæ privilege expiry, pt_ibitem_lib.lua), 2022 (ThÊt Tinh
-- HuyÒn Vò exchanges, hv_lib.lua) and the VNG star bits 2028/1..6 (ThÊt Tinh HuyÒn Vò).
-- Task variables (range 2040-2069 of tutuong_b; 2058, 2061-2065, 2069 are skipped because
-- VNG new-server scripts in script\common and the GBK new-server event folder use them):
--   Tu Linh   2040 day, 2041 runs used today, 2042 extra runs (Chia khoa Linh Te) today,
--             2043 round (0 idle, 1..6 active, 7 all rounds done, 8 time out), 2044 zone 1..4,
--             2045 target map, 2046 kills, 2047 kills needed, 2048 deadline (SystemTime)
--   Huyen Vu  2049 day, 2050 runs today, 2051 state (0 none, 1 registered 19:20, 2 in trial,
--             3 chest waiting), 2052 wave 1..8, 2053 NPCs left in the wave, 2054 deadline,
--             2055 run serial, 2056/2057/2059 return map/x/y, 2060/2066/2067/2068 NPC slots
PTTT_T_TL_DAY = 2040
PTTT_T_TL_USED = 2041
PTTT_T_TL_EXTRA = 2042
PTTT_T_TL_ROUND = 2043
PTTT_T_TL_ZONE = 2044
PTTT_T_TL_MAP = 2045
PTTT_T_TL_KILLS = 2046
PTTT_T_TL_NEED = 2047
PTTT_T_TL_DEADLINE = 2048
PTTT_T_HV_DAY = 2049
PTTT_T_HV_RUNS = 2050
PTTT_T_HV_STATE = 2051
PTTT_T_HV_WAVE = 2052
PTTT_T_HV_LEFT = 2053
PTTT_T_HV_DEADLINE = 2054
PTTT_T_HV_SERIAL = 2055
PTTT_T_HV_RETMAP = 2056
PTTT_T_HV_RETX = 2057
PTTT_T_HV_RETY = 2059
PTTT_T_HV_SLOTS = { 2060, 2066, 2067, 2068 }

PTTT_EXIT = "KÕt thóc ®èi tho¹i"

function PTTT_No()
	CloseDialog()
end

-- yyyymmdd of the server's local clock
function PTTT_Today()
	if date then return tonumber(date("%Y%m%d")) end
	if GetLocalDate then
		local s = GetLocalDate("%Y%m%d")
		if s then return tonumber(s) end
	end
	return floor(SystemTime() / 86400)
end

-- hhmm of the server's local clock
function PTTT_HHMM()
	if date then return tonumber(date("%H%M")) end
	if GetLocalDate then
		local s = GetLocalDate("%H%M")
		if s then return tonumber(s) end
	end
	return 0
end

function PTTT_Now()
	return SystemTime()
end

-- VNG scripts use map N, the runtime uses 1000 + N (WorldSet.ini)
function PTTT_MapId(m)
	if m == nil then return 0 end
	if m > 0 and m < 1000 then return m + 1000 end
	return m
end

function PTTT_MyMap()
	local w = GetWorldPos()
	return PTTT_MapId(w)
end

-- Say with a dynamic option list; always ends with an exit row
function PTTT_Say(text, opts)
	local t = { text, 0 }
	local i = 1
	while opts[i] do
		t[i + 2] = opts[i]
		i = i + 1
	end
	t[i + 2] = PTTT_EXIT .. "/PTTT_No"
	t[2] = i
	t.n = i + 2
	call(Say, t)
end

-- ibitem (genre 8) the way the admin bridge gives it: AddItem + AddItemID
function PTTT_GiveIB(d, p)
	local idx = AddItem(8, d, p, 0, 0, 0)
	if idx and idx > 0 then
		AddItemID(idx, 0)
		return 1
	end
	return 0
end

-- seconds -> "m phót s gi©y"
function PTTT_TimeText(sec)
	if sec < 0 then sec = 0 end
	local m = floor(sec / 60)
	local s = sec - m * 60
	if m > 0 then return m .. " phót " .. s .. " gi©y" end
	return s .. " gi©y"
end

-- the killer plus every team member (snapshot before PlayerIndex changes);
-- GetTeamSize() is 0/nil when solo
function PTTT_Members()
	local killer = PlayerIndex
	local members = {}
	local n = GetTeamSize()
	if n ~= nil and n > 0 then
		local i = 1
		while i <= n do
			local m = GetTeamMember(i)
			if m ~= nil and m > 0 then members[getn(members) + 1] = m end
			i = i + 1
		end
	end
	local found = 0
	local i = 1
	while members[i] do
		if members[i] == killer then found = 1 end
		i = i + 1
	end
	if found == 0 and killer ~= nil and killer > 0 then members[getn(members) + 1] = killer end
	return members
end
