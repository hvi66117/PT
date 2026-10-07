-- ct_def.lua (Lua 4, Phong Than GameServer) - 2026-10-03 congthanh2
-- City defence ("thu thanh") of the personal territories, at the territory row of Tay Ky (1020).
--  * schedule: every day at PTCT_DEF_SCHED (12:30, 20:30): 2 minutes of gathering (owners join at the Lanh dia
--    quan), then 3 waves; nobody joined = no attack. "Khieu chien ngay" at the Lanh dia quan starts at once (solo).
--  * attackers: template 116 (Thuong quan hieu uy, camp 5 = enemy of players and bots), life / damage scaled to
--    the defenders' level; wave 3 has a "Tuong cong thanh". Defenders: the registered players (fight mode on)
--    and guards = bot templates 2703-2720 (camp 0, fight camp 5 monsters, never players), 1 + Thao truong level
--    + Trai linh level / 2, max 6.
--  * a wave is won when all its attackers died (ct_mob.lua counts LastDamage / Revive / DeathSelf), lost when
--    its 5 minutes run out. Win: exp, money, contribution, hung thinh, Xich dong, Luong thao (2 rewarded
--    defences a day). Lost: hung thinh - 1.
--  * all state in GlobalValue 2430-2479 (ct_lib.lua), because the ext tick (servertimer state), the steward and
--    ct_mob.lua run in different Lua states.
-- Included by ext\congthanh.lua (tick, schedule) and ct_steward.lua (join, start now).
Include("\\script\\phongthan\\congthanh\\ct_lib.lua")

if PTCT_DEF_LOADED == nil then
PTCT_DEF_LOADED = 1
PTCT_DEF_MAP = 1020
PTCT_DEF_WAVES = 3
PTCT_DEF_GATHER = 2          -- minutes of gathering before a scheduled attack
PTCT_DEF_WAVE_MIN = 5        -- minutes per wave
PTCT_DEF_MAXDAY = 2          -- rewarded defences per day
PTCT_DEF_TPL = 116
PTCT_DEF_GTPL = 2703         -- guards: 2703 + (k * 5) mod 18
PTCT_DEF_SLOTS = 8
PTCT_DEF_NGUARD = 6
PTCT_DEF_NATK = 16
PTCT_DEF_REV = 36            -- revive frames of the attackers (Revive -> counted + removed)
PTCT_DEF_SCHED = {}
PTCT_DEF_SCHED[1] = 1230
PTCT_DEF_SCHED[2] = 2030
-- attacker cells (world units; client Region_C + server Region_S free 5x5, connected to the territory row)
PTCT_DEF_CELL = {}
PTCT_DEF_CELL[1] = { 1521, 3036 }
PTCT_DEF_CELL[2] = { 1518, 3032 }
PTCT_DEF_CELL[3] = { 1524, 3032 }
PTCT_DEF_CELL[4] = { 1516, 3036 }
PTCT_DEF_CELL[5] = { 1526, 3036 }
PTCT_DEF_CELL[6] = { 1514, 3040 }
PTCT_DEF_CELL[7] = { 1519, 3040 }
PTCT_DEF_CELL[8] = { 1524, 3040 }
PTCT_DEF_CELL[9] = { 1564, 3036 }
PTCT_DEF_CELL[10] = { 1570, 3036 }
PTCT_DEF_CELL[11] = { 1566, 3038 }
PTCT_DEF_CELL[12] = { 1574, 3038 }
PTCT_DEF_CELL[13] = { 1512, 3042 }
PTCT_DEF_CELL[14] = { 1528, 3042 }
PTCT_DEF_CELL[15] = { 1562, 3030 }
PTCT_DEF_CELL[16] = { 1566, 3032 }
-- guard cells
PTCT_DEF_GCELL = {}
PTCT_DEF_GCELL[1] = { 1524, 3028 }
PTCT_DEF_GCELL[2] = { 1530, 3028 }
PTCT_DEF_GCELL[3] = { 1562, 3034 }
PTCT_DEF_GCELL[4] = { 1518, 3028 }
PTCT_DEF_GCELL[5] = { 1568, 3034 }
PTCT_DEF_GCELL[6] = { 1534, 3028 }
PTCT_DEF_TXT = {}
PTCT_DEF_TXT.atk = "Qu\169n c\171ng th\181nh"
PTCT_DEF_TXT.boss = "T\173\237ng c\171ng th\181nh"
PTCT_DEF_TXT.guard = "H\233 v\214 l\183nh \174\222a"
end

function PTCT_D_Now() return floor(SystemTime() / 60) end
function PTCT_D_On()
	if GetGlobalValue(PTCT_GV_STATE) == 1 then return 1 end
	return nil
end

-- 1 when ni is a live NPC of this session with role r (not yet counted dead). GetNpcID = 0: free slot (an NPC
-- removed by someone else may keep stale params; DelNpc on a free slot must never happen)
function PTCT_D_Mine(ni, r)
	if not ni or ni <= 0 then return nil end
	local id = GetNpcID(ni)
	if not id or id == 0 then return nil end
	if GetNpcParam(ni, 1) ~= PTCT_K or GetNpcParam(ni, 3) ~= r then return nil end
	if GetNpcParam(ni, 2) ~= GetGlobalValue(PTCT_GV_KEY) then return nil end
	if GetNpcParam(ni, 4) ~= 0 then return nil end
	return 1
end

function PTCT_D_Spawn(tpl, lv, c, r)
	local sw = SubWorldID2Idx(PTCT_DEF_MAP)
	if not sw or sw < 0 then return 0 end
	local ni = AddNpc(tpl, lv, sw, c[1] * 32, c[2] * 32, 0)
	if not ni or ni <= 0 then ni = AddNpc(tpl, lv, sw, (c[1] + 1) * 32, c[2] * 32, 0) end
	if not ni or ni <= 0 then return 0 end
	SetNpcScript(ni, PTCT_MOB_SCRIPT)
	SetNpcParam(ni, 1, PTCT_K)
	SetNpcParam(ni, 2, GetGlobalValue(PTCT_GV_KEY))
	SetNpcParam(ni, 3, r)
	SetNpcParam(ni, 4, 0)
	return ni
end

-- remove one NPC of this session (any state), clear its GlobalValue slot
function PTCT_D_Drop(g)
	local ni = GetGlobalValue(g)
	local id = 0
	if ni > 0 then id = GetNpcID(ni) or 0 end
	if id ~= 0 and GetNpcParam(ni, 1) == PTCT_K and GetNpcParam(ni, 2) == GetGlobalValue(PTCT_GV_KEY) then
		SetNpcParam(ni, 1, 0)
		DelNpc(ni)
	end
	SetGlobalValue(g, 0)
end

function PTCT_D_Clear()
	local k = 1
	while k <= PTCT_DEF_NATK do
		PTCT_D_Drop(PTCT_GV_ATK + k)
		k = k + 1
	end
	k = 1
	while k <= PTCT_DEF_NGUARD do
		PTCT_D_Drop(PTCT_GV_GUARD + k)
		k = k + 1
	end
end

-- defenders ---------------------------------------------------------------------------------
-- fn(slot) for every registered defender still online on the defence map (PlayerIndex set); stale slots cleared.
-- Returns the number of defenders.
function PTCT_D_Each(fn)
	local old = PlayerIndex
	local n = 0
	local i = 1
	while i <= PTCT_DEF_SLOTS do
		local p = GetGlobalValue(PTCT_GV_SLOT + i)
		if p > 0 then
			local id = GetPlayerID(p)
			if id == nil or mod(id, 1000000) ~= GetGlobalValue(PTCT_GV_SID + i) then
				SetGlobalValue(PTCT_GV_SLOT + i, 0)
			else
				PlayerIndex = p
				if GetWorldPos() ~= PTCT_DEF_MAP then
					Msg2Player("Ng\173\172i \174\183 r\234i T\169y K\250, kh\171ng c\223n tham gia th\241 th\181nh.")
					SetGlobalValue(PTCT_GV_SLOT + i, 0)
				else
					n = n + 1
					if fn then fn(i) end
				end
				PlayerIndex = old
			end
		end
		i = i + 1
	end
	PlayerIndex = old
	return n
end

PTCT_D_SUM = 0
function PTCT_D_LvOne(i) PTCT_D_SUM = PTCT_D_SUM + GetLevel() end
-- average level of the defenders (50 when nobody)
function PTCT_D_Level()
	PTCT_D_SUM = 0
	local n = PTCT_D_Each(PTCT_D_LvOne)
	if n <= 0 then return 50 end
	local lv = floor(PTCT_D_SUM / n)
	if lv < 20 then lv = 20 end
	return lv
end

PTCT_D_MSG = ""
function PTCT_D_TellOne(i) Msg2Player(PTCT_D_MSG) end
function PTCT_D_Tell(s)
	PTCT_D_MSG = s
	return PTCT_D_Each(PTCT_D_TellOne)
end

-- guards granted by one defender's buildings
function PTCT_D_GuardsOf()
	local g = 1 + PTCT_BLevel(6) + floor(PTCT_BLevel(2) / 2)
	if g > PTCT_DEF_NGUARD then g = PTCT_DEF_NGUARD end
	return g
end

-- PlayerIndex = the player. 1 joined, 2 already in, 0 no session, -1 full
function PTCT_D_Join()
	if not PTCT_D_On() then return 0 end
	local id = GetPlayerID()
	if id == nil then return 0 end
	id = mod(id, 1000000)
	local free = 0
	local i = 1
	while i <= PTCT_DEF_SLOTS do
		local p = GetGlobalValue(PTCT_GV_SLOT + i)
		if p == PlayerIndex and GetGlobalValue(PTCT_GV_SID + i) == id then
			SetFightState(1)
			return 2
		end
		if free == 0 and (p <= 0 or GetPlayerID(p) == nil) then free = i end
		i = i + 1
	end
	if free == 0 then return -1 end
	SetGlobalValue(PTCT_GV_SLOT + free, PlayerIndex)
	SetGlobalValue(PTCT_GV_SID + free, id)
	local g = PTCT_D_GuardsOf()
	if g > GetGlobalValue(PTCT_GV_NGUARD) then SetGlobalValue(PTCT_GV_NGUARD, g) end
	SetFightState(1)
	return 1
end

-- session -----------------------------------------------------------------------------------
function PTCT_D_Start(from)
	if PTCT_D_On() then return nil end
	PTCT_D_Clear()
	SetGlobalValue(PTCT_GV_KEY, PTCT_D_Now())
	SetGlobalValue(PTCT_GV_STATE, 1)
	SetGlobalValue(PTCT_GV_WAVE, 0)
	SetGlobalValue(PTCT_GV_END, PTCT_D_Now() + PTCT_DEF_GATHER)
	SetGlobalValue(PTCT_GV_WKILL, 0)
	SetGlobalValue(PTCT_GV_WSIZE, 0)
	SetGlobalValue(PTCT_GV_SKILL, 0)
	SetGlobalValue(PTCT_GV_NGUARD, 1)
	SetGlobalValue(PTCT_GV_FROM, from)
	local i = 1
	while i <= PTCT_DEF_SLOTS do
		SetGlobalValue(PTCT_GV_SLOT + i, 0)
		SetGlobalValue(PTCT_GV_SID + i, 0)
		i = i + 1
	end
	return 1
end

function PTCT_D_SpawnAtk(k, w, lv)
	local ni = PTCT_D_Spawn(PTCT_DEF_TPL, lv, PTCT_DEF_CELL[k], PTCT_ROLE_ATK)
	if ni <= 0 then return 0 end
	if w >= PTCT_DEF_WAVES and k == 1 then
		SetNpcName(ni, PTCT_DEF_TXT.boss)
		SetNpcLife(ni, lv * 700, 1)
		SetNpcDamage(ni, lv * 2, lv * 3)
	else
		SetNpcName(ni, PTCT_DEF_TXT.atk)
		SetNpcLife(ni, lv * (100 + 30 * w), 1)
		SetNpcDamage(ni, lv, lv * 2)
	end
	SetNpcCurCamp(ni, 5)
	SetNpcRevTime(ni, PTCT_DEF_REV)
	return ni
end

-- keep the guards of this session standing (dead guards come back next minute)
function PTCT_D_Guards()
	local n = GetGlobalValue(PTCT_GV_NGUARD)
	local lv = GetGlobalValue(PTCT_GV_LV)
	if lv < 20 then lv = 20 end
	local k = 1
	while k <= PTCT_DEF_NGUARD do
		local g = PTCT_GV_GUARD + k
		if k <= n then
			if not PTCT_D_Mine(GetGlobalValue(g), PTCT_ROLE_GUARD) then
				local ni = PTCT_D_Spawn(PTCT_DEF_GTPL + mod(k * 5, 18), lv, PTCT_DEF_GCELL[k], PTCT_ROLE_GUARD)
				if ni > 0 then SetNpcName(ni, PTCT_DEF_TXT.guard) end
				SetGlobalValue(g, ni)
			end
		end
		k = k + 1
	end
end

function PTCT_D_NextWave()
	local w = GetGlobalValue(PTCT_GV_WAVE) + 1
	local np = PTCT_D_Each(nil)
	if np < 1 then np = 1 end
	local lv = PTCT_D_Level()
	SetGlobalValue(PTCT_GV_WAVE, w)
	SetGlobalValue(PTCT_GV_WKILL, 0)
	SetGlobalValue(PTCT_GV_END, PTCT_D_Now() + PTCT_DEF_WAVE_MIN)
	SetGlobalValue(PTCT_GV_LV, lv)
	local n = 4 + 2 * w + 2 * (np - 1)
	if n > PTCT_DEF_NATK then n = PTCT_DEF_NATK end
	local made = 0
	local k = 1
	while k <= PTCT_DEF_NATK do
		PTCT_D_Drop(PTCT_GV_ATK + k)
		if k <= n then
			local ni = PTCT_D_SpawnAtk(k, w, lv)
			SetGlobalValue(PTCT_GV_ATK + k, ni)
			if ni > 0 then made = made + 1 end
		end
		k = k + 1
	end
	SetGlobalValue(PTCT_GV_WSIZE, made)
	PTCT_D_Guards()
	local s = "Th\241 th\181nh: \174\238t " .. w .. "/" .. PTCT_DEF_WAVES .. ", " .. made .. " qu\169n c\171ng th\181nh (c\202p " .. lv .. ") \174ang t\202n c\171ng l\183nh \174\222a! H\185 h\213t trong " .. PTCT_DEF_WAVE_MIN .. " ph\243t."
	if w >= PTCT_DEF_WAVES then s = s .. " T\173\237ng c\171ng th\181nh \174\183 xu\202t hi\214n!" end
	PTCT_D_Tell(s)
	return made
end

-- live attackers of the current wave
function PTCT_D_Alive()
	local a = 0
	local k = 1
	while k <= PTCT_DEF_NATK do
		if PTCT_D_Mine(GetGlobalValue(PTCT_GV_ATK + k), PTCT_ROLE_ATK) then a = a + 1 end
		k = k + 1
	end
	return a
end

-- results -----------------------------------------------------------------------------------
function PTCT_D_WinOne(i)
	SetFightState(0)
	if not PTCT_Owns() then return end
	local n = PTCT_DayN(PTCT_T_DEF)
	if n >= PTCT_DEF_MAXDAY then
		Msg2Player("Th\241 th\181nh th\181nh c\171ng! H\171m nay ng\173\172i \174\183 nh\203n \174\241 " .. PTCT_DEF_MAXDAY .. " l\199n th\173\235ng th\241 th\181nh.")
		return
	end
	PTCT_DaySet(PTCT_T_DEF, n + 1)
	local exp = GetLevel() * 5000
	local money = 20000 * PTCT_Level()
	AddOwnExp(exp)
	Earn(money)
	PTCT_AddContri(2)
	SetTask(PTCT_T_HUNG, GetTask(PTCT_T_HUNG) + 1)
	PTCT_AddRes(3, 1)
	PTCT_AddRes(4, 1)
	Msg2Player("Th\241 th\181nh th\181nh c\171ng! Nh\203n " .. exp .. " kinh nghi\214m, " .. money .. " l\173\238ng, 2 c\232ng hi\213n, 1 H\173ng th\222nh, 1 X\221ch \174\229ng, 1 L\173\172ng th\182o.")
end

function PTCT_D_LoseOne(i)
	SetFightState(0)
	if not PTCT_Owns() then return end
	local h = GetTask(PTCT_T_HUNG)
	if h > 0 then SetTask(PTCT_T_HUNG, h - 1) end
	Msg2Player("Th\241 th\181nh th\202t b\185i, l\183nh \174\222a b\222 c\173\237p ph\184: H\173ng th\222nh -1.")
end

-- r: 1 win, 2 lost, 3 nobody defended
function PTCT_D_End(r)
	local np = 0
	if r == 1 then np = PTCT_D_Each(PTCT_D_WinOne) end
	if r == 2 then np = PTCT_D_Each(PTCT_D_LoseOne) end
	PTCT_D_Clear()
	SetGlobalValue(PTCT_GV_LAST, GetGlobalValue(PTCT_GV_KEY) * 10 + r)
	SetGlobalValue(PTCT_GV_STATE, 0)
	if GetGlobalValue(PTCT_GV_FROM) == 1 and np > 0 then
		if r == 1 then
			AddGlobalNews("C\184c l\183nh ch\243a \174\183 \174\200y lui <color=green>qu\169n c\171ng th\181nh<color> \235 T\169y K\250!")
		else
			AddGlobalNews("<color=red>Qu\169n c\171ng th\181nh<color> \174\183 c\173\237p ph\184 c\184c l\183nh \174\222a \235 T\169y K\250.")
		end
	end
	return np
end

-- minute tick (ext\congthanh.lua) ------------------------------------------------------------
function PTCT_D_Schedule()
	local hm = tonumber(date("%H%M")) or 0
	local i = 1
	while PTCT_DEF_SCHED[i] do
		local key = PTCT_Today() * 10000 + PTCT_DEF_SCHED[i]
		if hm == PTCT_DEF_SCHED[i] and GetGlobalValue(PTCT_GV_SCHED) ~= key then
			SetGlobalValue(PTCT_GV_SCHED, key)
			if PTCT_D_Start(1) then
				AddGlobalNews("<color=red>Qu\169n c\171ng th\181nh<color> s\190p t\202n c\171ng c\184c l\183nh \174\222a \235 T\169y K\250! L\183nh ch\243a h\183y \174\213n <color=green>L\183nh \174\222a quan<color> nh\203n th\241 th\181nh trong " .. PTCT_DEF_GATHER .. " ph\243t.")
			end
			return 1
		end
		i = i + 1
	end
	return nil
end

function PTCT_D_Tick()
	if not PTCT_D_On() then
		PTCT_D_Schedule()
		return 0
	end
	local now = PTCT_D_Now()
	local w = GetGlobalValue(PTCT_GV_WAVE)
	local np = PTCT_D_Each(nil)
	if w == 0 then
		if now < GetGlobalValue(PTCT_GV_END) then return 1 end
		if np <= 0 then return PTCT_D_End(3) end
		PTCT_D_NextWave()
		return 2
	end
	if np <= 0 then return PTCT_D_End(3) end
	local a = PTCT_D_Alive()
	if a <= 0 then
		if w >= PTCT_DEF_WAVES then
			PTCT_D_End(1)
			return 4
		end
		PTCT_D_Tell("\167\238t " .. w .. " \174\183 b\222 \174\200y lui!")
		PTCT_D_NextWave()
		return 3
	end
	if now >= GetGlobalValue(PTCT_GV_END) then
		PTCT_D_End(2)
		return 5
	end
	PTCT_D_Guards()
	PTCT_D_Tell("Th\241 th\181nh \174\238t " .. w .. "/" .. PTCT_DEF_WAVES .. ": c\223n " .. a .. " qu\169n c\171ng th\181nh, " .. (GetGlobalValue(PTCT_GV_END) - now) .. " ph\243t.")
	return 6
end

-- status line for the steward
function PTCT_D_Status()
	if not PTCT_D_On() then return "Kh\171ng c\227 tr\203n th\241 th\181nh n\181o." end
	local w = GetGlobalValue(PTCT_GV_WAVE)
	local left = GetGlobalValue(PTCT_GV_END) - PTCT_D_Now()
	if left < 0 then left = 0 end
	if w == 0 then return "Qu\169n c\171ng th\181nh s\207 t\202n c\171ng sau kho\182ng " .. left .. " ph\243t." end
	return "\167\238t " .. w .. "/" .. PTCT_DEF_WAVES .. ": \174\183 h\185 " .. GetGlobalValue(PTCT_GV_WKILL) .. "/" .. GetGlobalValue(PTCT_GV_WSIZE) .. " qu\169n, c\223n kho\182ng " .. left .. " ph\243t."
end
