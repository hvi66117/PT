-- Phong Than 2026-10-03 (newbie2): logic of the new-era newbie chain (VNG 2009+ "Tan thu doi moi"):
-- taskinfo 909..898 (Giap Si), 897..913 (Dao Si), 1000..1008 / 999 (Di Nhan), common tail 898/901/900/899,
-- mat tich / lenh 914-925, 1009, 1010 and the F11 hints 3003-3005. Data: nb2_data.lua (generated).
-- Included by: newbie2\quan_su.lua (hub NPC + 3 s poll timer), newbie2\nb2_dp.lua (spawned doctors),
-- newbie2\nb2_mob.lua (action script of the target monsters), newbie2\nb2_scroll.lua (mat tich items) and
-- ext\newbie2.lua (minute tick). Every state keeps its own globals; quest state lives only in task variables.
-- Task variables (range of agent newbie2, 2180-2219; only ids that no VNG/loose script references):
--   2180 chain position (index into PTNB2_CHAIN[profession]; 0 = chain not taken, n+1 = finished)
--   2184 step index inside the current quest (0 = waiting to be accepted: level too low)
--   2185 / 2191 / 2192 counters of the current step, 2194 flags (1 = 3003-3005 hint shown)
--   2205 game time (frames) of the last temporary spawn (chest Yeu Ma / kings)
--   2195, 2201, 2202, 2204: one byte per mat tich (14 x 1 byte): 0 = none, 1 + kills = active
-- Lua 4: no local function, no true/false; ASCII file (texts come from nb2_data.lua).
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")
Include("\\script\\phongthan\\newbie2\\nb2_data.lua")
-- coordinator 2026-10-03: ext\npcnames.lua renames GBK-named map NPCs to Vietnamese; map them back
Include("\\script\\phongthan\\lib\\pt_npcalias.lua")
-- taphoa 2026-10-03: a (re)load of this state may bring a new alias table (pt_npcalias.lua); drop the
-- cached NPC positions so the next PTNB2_ScanNpcs rebuilds them with it (the cache lives 10 minutes).
PTNB2_POS = nil
PTNB2_POS_TM = nil
PTNB2_SCAN_I = nil
PTNB2_SCAN_T = nil

PTNB2_T_Q = 2180
PTNB2_T_S = 2184
PTNB2_T_C = { 2185, 2191, 2192 }
PTNB2_T_F = 2194
PTNB2_T_TM = 2205
PTNB2_T_SC = { 2195, 2201, 2202, 2204 }
PTNB2_TAG = 21802180            -- npc param 0 of the temporary monsters spawned by this feature
PTNB2_MAX_PLAYER = 1200
PTNB2_MAX_NPC = 48000
PTNB2_NEAR_X = 5                -- "next to the NPC": |dx| <= 5 and |dy| <= 10 (GetWorldPos cells)
PTNB2_NEAR_Y = 10
PTNB2_SPAWN_TIMEOUT = 600       -- seconds a chest Yeu Ma / king stays before it is removed
PTNB2_SCROLL_RATE = 1           -- percent per kill: the mat tich of that monster drops
PTNB2_MAT_RATE = 35             -- percent per kill: material for the "Thu thap" mat tich
PTNB2_HINT_MAXLV = 30
PTNB2_MOB_SCRIPT = "\\script\\phongthan\\newbie2\\nb2_mob.lua"
PTNB2_TPL_YEUMA = 573           -- Npcs.txt "fu zai xiangzi yaohun" (soul in the chest)
PTNB2_TPL_HC = { 575, 577, 576 } -- Hoan Cau Vuong / Soai / Tinh (huangou jiangjun / dashuai / duizhang)
PTNB2_KIND_YEUMA = 10
PTNB2_KIND_KING = 20
PTNB2_KIND_HC = 21              -- 21 Vuong, 22 Soai, 23 Tinh
PTNB2_VILLAGE = { [0] = 1002, [1] = 1003, [2] = 1004 }
PTNB2_TAPHOA_MAPS = { 1002, 1003, 1004, 1020, 1021 }
if PTNB2_DEL == nil then PTNB2_DEL = {} end
if PTNB2_WARNED == nil then PTNB2_WARNED = {} end

-- ------------------------------------------------------------------ small helpers
function PTNB2_Abs(v)
	if v < 0 then return -v end
	return v
end

function PTNB2_In(list, v)
	if list == nil then return 1 end
	local i = 1
	while list[i] do
		if list[i] == v then return 1 end
		i = i + 1
	end
	return nil
end

function PTNB2_HasBit(v, b)
	return mod(floor(v / b), 2) == 1
end

function PTNB2_Prof()
	local p = GetProfession()
	if p == nil or p < 0 or p > 2 then return nil end
	return p
end

function PTNB2_Title(id)
	local t = PTTaskNote_Load()[id]
	if t and t.t then return t.t end
	return "#" .. id
end

-- step text of taskinfo (filled), for the dialog "current quest"
function PTNB2_StepText(id, n, args)
	local t = PTTaskNote_Load()[id]
	if t == nil or t.s == nil or t.s[n] == nil then return "" end
	return PTTaskNote_Fill(t.s[n], args)
end

-- nb2fix 2026-10-03: every script state of the engine has only 120 Lua stack slots (KLuaScript.cpp lua_open(100),
-- Lua 4 never grows it). An F11 note (PTTaskNote -> gsub -> closure -> format) at the bottom of
-- poll -> step done -> accept next quest -> step note overflowed it. Inside PTNB2_Protected (and the poll loop)
-- the notes and the auto-accept of the next quest are queued (arguments and PlayerIndex captured) and run right
-- after the protected call returns, at shallow depth, in the same order.
function PTNB2_Later(fn, t)
	if PTNB2_DEFER then
		if PTNB2_NOTEQ == nil then PTNB2_NOTEQ = {} end
		tinsert(PTNB2_NOTEQ, { PlayerIndex, fn, t })
		return
	end
	call(fn, t)
end

function PTNB2_Note(id, n, a1, a2, a3)
	local t = { id, n }
	if a1 ~= nil then tinsert(t, a1) end
	if a2 ~= nil then tinsert(t, a2) end
	if a3 ~= nil then tinsert(t, a3) end
	PTNB2_Later(PTTaskNote, t)
end

-- notes run directly; a queued routine (auto-accept) runs with notes deferred again, its notes are written by the
-- next pass of the outer loop (so the flush never goes deeper than routine -> step note)
function PTNB2_FlushNotes()
	local pi = PlayerIndex
	local guard = 0
	while PTNB2_NOTEQ and guard < 8 do
		local q = PTNB2_NOTEQ
		PTNB2_NOTEQ = nil
		local i = 1
		while q[i] do
			PlayerIndex = q[i][1]
			if q[i][2] == PTTaskNote then
				call(PTTaskNote, q[i][3], "x", PTNB2_Err)
			else
				PTNB2_DEFER = 1
				call(q[i][2], q[i][3], "x", PTNB2_Err)
				PTNB2_DEFER = nil
			end
			i = i + 1
		end
		guard = guard + 1
	end
	PTNB2_NOTEQ = nil
	PlayerIndex = pi
end

-- protected call of a quest routine (errors -> PTNB2_Err), F11 notes deferred until it returns; returns its result
function PTNB2_Protected(fn, args)
	local old = PTNB2_DEFER
	PTNB2_DEFER = 1
	local r = call(fn, args, "x", PTNB2_Err)
	PTNB2_DEFER = old
	if not old then PTNB2_FlushNotes() end
	return r
end

-- nb2fix 2026-10-03: load the taskinfo texts (vng_tasknote_data.lua) at the shallow start of an entry point,
-- never at the bottom of a deep chain; once per Lua state (PTTaskNote_Load latches PT_TASKINFO).
function PTNB2_Boot()
	if PT_TASKINFO == nil then PTTaskNote_Load() end
end

function PTNB2_Warn(text)
	local nm = GetName() or ""
	local now = GetGameTime()
	local t = PTNB2_WARNED[nm .. text]
	if t and now >= t and now - t < 60 * 18 then return end
	PTNB2_WARNED[nm .. text] = now
	Msg2Player(text)
end

function PTNB2_ResetCounters()
	SetTask(PTNB2_T_C[1], 0)
	SetTask(PTNB2_T_C[2], 0)
	SetTask(PTNB2_T_C[3], 0)
	SetTask(PTNB2_T_TM, 0)
end

function PTNB2_UsesCounters(st)
	if st == nil then return nil end
	if st.kill or st.coll or st.chest or st.king or st.go2 or st.nlv or st.mark then return 1 end
	return nil
end

-- ------------------------------------------------------------------ chain position
function PTNB2_Cur()
	PTNB2_Boot()
	local p = PTNB2_Prof()
	if p == nil then return nil end
	local qi = GetTask(PTNB2_T_Q)
	local ch = PTNB2_CHAIN[p]
	if qi <= 0 or ch == nil or ch[qi] == nil then return nil end
	local e = ch[qi]
	local q = PTNB2_Q[e[1]]
	if q == nil then return nil end
	local s = GetTask(PTNB2_T_S)
	return q, s, q.s[s], qi, e
end

function PTNB2_NextStep(q, s, p)
	local i = s + 1
	while q.s[i] do
		if q.s[i].p == nil or q.s[i].p == p then return i end
		i = i + 1
	end
	return nil
end

-- arguments of a step note: N label, c counter 1, k need, d counter 2 (kings), K kings needed
function PTNB2_Arg(q, st, ch)
	if ch == "c" then return GetTask(PTNB2_T_C[1]) end
	if ch == "d" then
		if st.king and st.king.boss902 then
			local v = GetTask(PTNB2_T_C[2])
			local n = 0
			if PTNB2_HasBit(v, 1) then n = n + 1 end
			if PTNB2_HasBit(v, 2) then n = n + 1 end
			if PTNB2_HasBit(v, 4) then n = n + 1 end
			return n
		end
		return GetTask(PTNB2_T_C[2])
	end
	if ch == "K" then
		if st.king and st.king.boss902 then return 3 end
		if st.king then return st.king.need end
		return 0
	end
	if ch == "k" then
		if st.kill then return st.kill.need end
		if st.chest then return st.chest end
		if st.coll then return st.coll[1].need end
		return 0
	end
	if ch == "N" then
		if st.kill then return st.kill.lab end
		if st.king and st.king.boss902 then
			local v = GetTask(PTNB2_T_C[2])
			if not PTNB2_HasBit(v, 1) then return PTNB2_TXT.hc_vuong end
			if not PTNB2_HasBit(v, 2) then return PTNB2_TXT.hc_soai end
			return PTNB2_TXT.hc_tinh
		end
		return ""
	end
	return ""
end

function PTNB2_Args(q, st, spec)
	local r = {}
	if spec == nil then return r end
	local i = 1
	while i <= strlen(spec) do
		r[i] = PTNB2_Arg(q, st, strsub(spec, i, i))
		i = i + 1
	end
	return r
end

-- start = 1: note of a step that was just reached (n0/a0 when the step has them)
function PTNB2_StepNote(q, s, start)
	local st = q.s[s]
	if st == nil then return end
	local n, a = st.n, st.a
	if start and st.n0 ~= nil then n, a = st.n0, st.a0 end
	local r = PTNB2_Args(q, st, a)
	PTNB2_Note(q.id, n, r[1], r[2], r[3])
end

function PTNB2_StatusText(q, s)
	local st = q.s[s]
	if st == nil then return "" end
	local n, a = st.n, st.a
	if st.n0 ~= nil and GetTask(PTNB2_T_C[1]) == 0 and GetTask(PTNB2_T_C[2]) == 0 then n, a = st.n0, st.a0 end
	return PTNB2_StepText(q.id, n, PTNB2_Args(q, st, a))
end

-- ------------------------------------------------------------------ accept / step done / reward
-- nb2fix: dialog entry (Quan Su), notes deferred
function PTNB2_Start()
	local r = PTNB2_Protected(PTNB2_StartNow, {})
	if r == nil then return 0 end
	return r
end

function PTNB2_StartNow()
	local p = PTNB2_Prof()
	if p == nil or GetTask(PTNB2_T_Q) ~= 0 then return 0 end
	SetTask(PTNB2_T_Q, 1)
	SetTask(PTNB2_T_S, 0)
	PTNB2_Note(3003 + p, -1)
	return PTNB2_TryAccept(1)
end

function PTNB2_TryAccept(talk)
	local q, s, st, qi, e = PTNB2_Cur()
	if q == nil or s ~= 0 then return 0 end
	if GetLevel() < q.lv then return 0 end
	local p = PTNB2_Prof()
	local first = PTNB2_NextStep(q, (e[2] or 1) - 1, p)
	if first == nil then return 0 end
	PTNB2_ResetCounters()
	SetTask(PTNB2_T_S, first)
	PTNB2_StepNote(q, first, 1)
	Msg2Player(PTNB2_TXT.accepted .. PTNB2_Title(q.id))
	Msg2Player(q.intro)
	if talk then Talk(1, "no", PTNB2_TXT.accepted .. PTNB2_Title(q.id) .. ". " .. q.intro) end
	return 1
end

function PTNB2_GiveCash(rw)
	if rw == nil then return end
	if rw.exp and rw.exp > 0 then
		AddOwnExp(rw.exp)
		Msg2Player(PTNB2_TXT.got_exp .. rw.exp)
	end
	if rw.money and rw.money > 0 then
		Earn(rw.money)
		Msg2Player(PTNB2_TXT.got .. rw.money .. PTNB2_TXT.got_money)
	end
end

function PTNB2_StepDone(q, s, st, qi)
	local p = PTNB2_Prof()
	local ns = PTNB2_NextStep(q, s, p)
	local rw = st.rw
	if ns == nil then rw = q.rw end
	local items = {}
	if rw and rw.items then items = rw.items end
	local to = 0
	if ns then to = ns end
	-- compare-and-set on the step variable: rewards and progress together, nothing on a full bag
	if QuestExchange(PTNB2_T_S, s, to, {}, items) ~= 1 then
		if GetTask(PTNB2_T_S) == s then PTNB2_Warn(PTNB2_TXT.bag_full) end
		return 0
	end
	if st.msg then Msg2Player(st.msg) end
	PTNB2_GiveCash(rw)
	if ns then
		if PTNB2_UsesCounters(q.s[ns]) then PTNB2_ResetCounters() end
		PTNB2_StepNote(q, ns, 1)
	else
		PTNB2_ResetCounters()
		SetTask(PTNB2_T_Q, qi + 1)
		PTNB2_Note(q.id, -1)
		Msg2Player(PTNB2_TXT.completed .. PTNB2_Title(q.id))
		if PTNB2_Cur() == nil then
			Msg2Player(PTNB2_TXT.done_all)
		else
			PTNB2_Later(PTNB2_TryAccept, {})   -- nb2fix: at shallow depth (see PTNB2_Later)
		end
	end
	return 1
end

-- ------------------------------------------------------------------ NPC positions (proximity steps)
-- PTNB2_POS[map][name] = { {x, y}, ... } from a scan of every NPC index (GetNpcName / GetNpcPos)
function PTNB2_WantNames()
	if PTNB2_WANT then return PTNB2_WANT end
	PTNB2_WANT = {}
	local k, q
	for k, q in PTNB2_Q do
		local i = 1
		while q.s[i] do
			local st = q.s[i]
			if st.go then PTNB2_WantAdd(st.go) end
			if st.go2 then PTNB2_WantAdd(st.go2[1]) PTNB2_WantAdd(st.go2[2]) end
			i = i + 1
		end
	end
	PTNB2_WANT[PTNB2_N_TAPHOA] = 1
	return PTNB2_WANT
end

function PTNB2_WantAdd(g)
	local j = 1
	while g[2][j] do
		PTNB2_WANT[g[2][j]] = 1
		j = j + 1
	end
end

function PTNB2_ScanNpcs(budget)
	local want = PTNB2_WantNames()
	local now = GetGameTime()
	if PTNB2_SCAN_I == nil then
		if PTNB2_POS and PTNB2_POS_TM and now >= PTNB2_POS_TM and now - PTNB2_POS_TM < 600 * 18 then return end
		PTNB2_SCAN_I = 1
		PTNB2_SCAN_T = {}
	end
	local i = PTNB2_SCAN_I
	local last = i + budget - 1
	if last > PTNB2_MAX_NPC then last = PTNB2_MAX_NPC end
	while i <= last do
		local nm = GetNpcName(i)
		if nm and PTNN_ALIAS and PTNN_ALIAS[nm] then nm = PTNN_ALIAS[nm] end
		if nm and nm ~= "" and want[nm] then
			local w, x, y = GetNpcPos(i)
			if w and w > 0 then
				if PTNB2_SCAN_T[w] == nil then PTNB2_SCAN_T[w] = {} end
				if PTNB2_SCAN_T[w][nm] == nil then PTNB2_SCAN_T[w][nm] = {} end
				tinsert(PTNB2_SCAN_T[w][nm], { x, y })
			end
		end
		i = i + 1
	end
	PTNB2_SCAN_I = i
	if i > PTNB2_MAX_NPC then
		PTNB2_POS = PTNB2_SCAN_T
		PTNB2_POS_TM = now
		PTNB2_SCAN_I = nil
		PTNB2_SCAN_T = nil
	end
end

function PTNB2_NearAny(g)
	local w, x, y = GetWorldPos()
	if w ~= g[1] or PTNB2_POS == nil or PTNB2_POS[w] == nil then return nil end
	local j = 1
	while g[2][j] do
		local l = PTNB2_POS[w][g[2][j]]
		if l then
			local k = 1
			while l[k] do
				if PTNB2_Abs(l[k][1] - x) <= PTNB2_NEAR_X and PTNB2_Abs(l[k][2] - y) <= PTNB2_NEAR_Y then return 1 end
				k = k + 1
			end
		end
		j = j + 1
	end
	return nil
end

function PTNB2_NearTaphoa()
	local i = 1
	while PTNB2_TAPHOA_MAPS[i] do
		if PTNB2_NearAny({ PTNB2_TAPHOA_MAPS[i], { PTNB2_N_TAPHOA } }) then return 1 end
		i = i + 1
	end
	return nil
end

function PTNB2_HasBook(b)
	local lv = HaveMagic(b[1])
	if lv ~= nil and lv > 0 then return 1 end
	if HaveNormalItem(6, 1, b[2], 1) > 0 then return 1 end
	return nil
end

-- ------------------------------------------------------------------ temporary monsters (chest, kings)
function PTNB2_SpawnTemp(tpl, lv, map, x, y, name, kind)
	local sw = SubWorldID2Idx(map)
	if sw == nil or sw < 0 then return 0 end
	local ni = AddNpc(tpl, lv, sw, x * 32, y * 32, 1)
	if ni == nil or ni <= 0 then ni = AddNpc(tpl, lv, sw, x * 32, y * 32, 0) end
	if ni == nil or ni <= 0 then return 0 end
	SetNpcName(ni, name)
	SetNpcScript(ni, PTNB2_MOB_SCRIPT)
	SetNpcParam(ni, 0, PTNB2_TAG)
	SetNpcParam(ni, 1, GetPlayerID() or 0)
	SetNpcParam(ni, 2, kind)
	SetNpcTimeout(ni, PTNB2_SPAWN_TIMEOUT * 18)
	return ni
end

function PTNB2_SpawnFree(now)
	local alive = GetTask(PTNB2_T_C[3])
	local tm = GetTask(PTNB2_T_TM)
	return alive <= 0 or now < tm or now - tm > PTNB2_SPAWN_TIMEOUT * 18
end

PTNB2_CHEST_OFF = { { 3, 0 }, { -3, 0 }, { 0, 5 }, { 0, -5 } }
function PTNB2_PollChest(q, s, st, now)
	local w, x, y = GetWorldPos()
	if not PTNB2_FIELD[w] then return end
	if not PTNB2_SpawnFree(now) then return end
	local left = st.chest - GetTask(PTNB2_T_C[1])
	if left <= 0 then return end
	local lv = GetLevel()
	if lv < 5 then lv = 5 end
	local n = 0
	local k = 1
	while k <= left and PTNB2_CHEST_OFF[k] do
		if PTNB2_SpawnTemp(PTNB2_TPL_YEUMA, lv, w, x + PTNB2_CHEST_OFF[k][1], y + PTNB2_CHEST_OFF[k][2], PTNB2_TXT.yeuma, PTNB2_KIND_YEUMA) > 0 then n = n + 1 end
		k = k + 1
	end
	if n > 0 then
		SetTask(PTNB2_T_C[3], n)
		SetTask(PTNB2_T_TM, now)
		Msg2Player(PTNB2_TXT.chest_open)
	end
end

-- ------------------------------------------------------------------ poll (proximity / level / chest)
function PTNB2_PollStep(q, s, st, qi, now)
	if st.go then
		local lvok = (st.lv == nil) or (GetLevel() >= st.lv)
		if st.nlv and lvok and GetTask(PTNB2_T_C[3]) == 0 then
			SetTask(PTNB2_T_C[3], 1)
			PTNB2_Note(q.id, st.nlv)
		end
		if lvok and PTNB2_NearAny(st.go) then
			if st.book and not PTNB2_HasBook(st.book) then
				PTNB2_Warn(PTNB2_TXT.need_book)
				return
			end
			PTNB2_StepDone(q, s, st, qi)
		end
	elseif st.go2 then
		local v = GetTask(PTNB2_T_C[1])
		local k = 1
		while k <= 2 do
			local b = 1
			if k == 2 then b = 2 end
			if not PTNB2_HasBit(v, b) and PTNB2_NearAny(st.go2[k]) then
				v = v + b
				SetTask(PTNB2_T_C[1], v)
				if v < 3 then
					if k == 1 then PTNB2_Note(q.id, st.n2a) else PTNB2_Note(q.id, st.n2b) end
				end
			end
			k = k + 1
		end
		if v >= 3 then PTNB2_StepDone(q, s, st, qi) end
	elseif st.auto then
		PTNB2_StepDone(q, s, st, qi)
	elseif st.chest then
		PTNB2_PollChest(q, s, st, now)
	end
end

function PTNB2_PollPlayer(now)
	local p = PTNB2_Prof()
	if p == nil then return end
	local qi = GetTask(PTNB2_T_Q)
	if qi == 0 then
		local f = GetTask(PTNB2_T_F)
		if not PTNB2_HasBit(f, 1) and GetLevel() <= PTNB2_HINT_MAXLV then
			SetTask(PTNB2_T_F, f + 1)
			PTNB2_Note(3003 + p, 0)
		end
	else
		local q, s, st = PTNB2_Cur()
		if q then
			if s == 0 then
				PTNB2_TryAccept()
			elseif st then
				PTNB2_PollStep(q, s, st, qi, now)
			end
		end
	end
	if PTNB2_NearTaphoa() then PTNB2_ScrollTurnin(nil) end
end

function PTNB2_PollAll()
	PTNB2_Boot()
	local now = GetGameTime()
	local i = 1
	while i <= PTNB2_MAX_PLAYER do
		PlayerIndex = i
		local nm = GetName()
		if nm and nm ~= "" then
			-- nb2fix: PTNB2_Protected inlined (one frame less on the deepest chain of the minute tick)
			PTNB2_DEFER = 1
			call(PTNB2_PollPlayer, { now }, "x", PTNB2_Err)
			PTNB2_DEFER = nil
			if PTNB2_NOTEQ then PTNB2_FlushNotes() end
		end
		i = i + 1
	end
	PlayerIndex = nil
end

function PTNB2_Err(m)
	if PTNB2_LOGGED == nil then PTNB2_LOGGED = 0 end
	if PTNB2_LOGGED > 20 then return end
	PTNB2_LOGGED = PTNB2_LOGGED + 1
	local h = openfile("admin_bridge\\newbie2_error.log", "a")
	if h then
		write(h, tostring(m) .. "\n")
		closefile(h)
	end
end

-- ------------------------------------------------------------------ kills (nb2_mob.lua LastDamage)
function PTNB2_OnKill(npc)
	local p = PTNB2_Prof()
	if p == nil then return end
	local tid = GetNpcTemplateID(npc)
	if tid == nil then return end
	local w, nx, ny = GetNpcPos(npc)
	local q, s, st, qi = PTNB2_Cur()
	if q and s > 0 and st then
		if st.kill and PTNB2_In(st.kill.tids, tid) and PTNB2_In(st.kill.maps, w) then
			local c = GetTask(PTNB2_T_C[1]) + 1
			SetTask(PTNB2_T_C[1], c)
			if c >= st.kill.need then
				PTNB2_StepDone(q, s, st, qi)
			else
				PTNB2_StepNote(q, s)
			end
		end
		if st.mark and GetTask(PTNB2_T_C[3]) == 0 and PTNB2_In(st.mark.tids, tid) and PTNB2_In(st.mark.maps, w) then
			SetTask(PTNB2_T_C[3], 1)
			Msg2Player(st.mark.msg)
		end
		if st.coll then PTNB2_CollKill(q, s, st, qi, tid, w) end
		if st.king then PTNB2_KingKill(q, s, st, qi, tid, w, nx, ny) end
	end
	PTNB2_ScrollKill(tid)
	PTNB2_Mat917(p, tid)
	PTNB2_ScrollDrop(tid)
end

function PTNB2_CollKill(q, s, st, qi, tid, w)
	local k = 1
	while st.coll[k] do
		local g = st.coll[k]
		local c = GetTask(PTNB2_T_C[k])
		if c < g.need and PTNB2_In(g.tids, tid) and PTNB2_In(g.maps, w) and (g.mark == nil or GetTask(PTNB2_T_C[3]) == 1) then
			if random(1, 100) <= g.chance then
				c = c + 1
				SetTask(PTNB2_T_C[k], c)
				Msg2Player(PTNB2_TXT.got .. g.lab .. " (" .. c .. "/" .. g.need .. ")")
				if g.n then PTNB2_Note(q.id, g.n, c) end
			end
			break
		end
		k = k + 1
	end
	k = 1
	while st.coll[k] do
		if GetTask(PTNB2_T_C[k]) < st.coll[k].need then return end
		k = k + 1
	end
	PTNB2_StepDone(q, s, st, qi)
end

function PTNB2_KingKill(q, s, st, qi, tid, w, nx, ny)
	local kg = st.king
	if tid ~= kg.tid or not PTNB2_In(kg.maps, w) then return end
	local now = GetGameTime()
	local c = GetTask(PTNB2_T_C[1]) + 1
	SetTask(PTNB2_T_C[1], c)
	if c < kg.every then
		Msg2Player(PTNB2_TXT.kill_prog .. c .. "/" .. kg.every)
		return
	end
	if not PTNB2_SpawnFree(now) then return end
	local lv = GetLevel() + 2
	local n = 0
	local nm = ""
	if kg.boss902 then
		local v = GetTask(PTNB2_T_C[2])
		if not PTNB2_HasBit(v, 1) then
			nm = PTNB2_TXT.hc_vuong
			if PTNB2_SpawnTemp(PTNB2_TPL_HC[1], lv, w, nx + 3, ny, nm, PTNB2_KIND_HC) > 0 then n = 1 end
		else
			n = PTNB2_SpawnHcPair(v, w, nx, ny, lv)
			nm = PTNB2_TXT.hc_soai
		end
	else
		nm = kg.kname
		if PTNB2_SpawnTemp(kg.ktpl, lv, w, nx + 3, ny, nm, PTNB2_KIND_KING) > 0 then n = 1 end
	end
	if n > 0 then
		SetTask(PTNB2_T_C[1], 0)
		SetTask(PTNB2_T_C[3], n)
		SetTask(PTNB2_T_TM, now)
		Msg2Player(nm .. PTNB2_TXT.king_appear)
	end
end

function PTNB2_SpawnHcPair(v, w, x, y, lv)
	local n = 0
	if not PTNB2_HasBit(v, 2) and PTNB2_SpawnTemp(PTNB2_TPL_HC[2], lv, w, x + 3, y, PTNB2_TXT.hc_soai, PTNB2_KIND_HC + 1) > 0 then n = n + 1 end
	if not PTNB2_HasBit(v, 4) and PTNB2_SpawnTemp(PTNB2_TPL_HC[3], lv, w, x - 3, y, PTNB2_TXT.hc_tinh, PTNB2_KIND_HC + 2) > 0 then n = n + 1 end
	return n
end

-- a temporary monster of this feature died (killer = PlayerIndex)
function PTNB2_OnTempKill(npc)
	local kind = GetNpcParam(npc, 2)
	local owner = GetNpcParam(npc, 1)
	PTNB2_DEL[npc] = 1
	SetNpcParam(npc, 0, 0)
	if (GetPlayerID() or 0) ~= owner then
		Msg2Player(PTNB2_TXT.not_owner)
		return
	end
	local q, s, st, qi = PTNB2_Cur()
	if not (q and s > 0 and st) then return end
	local alive = GetTask(PTNB2_T_C[3]) - 1
	if alive < 0 then alive = 0 end
	if kind == PTNB2_KIND_YEUMA and st.chest then
		local c = GetTask(PTNB2_T_C[1]) + 1
		SetTask(PTNB2_T_C[1], c)
		SetTask(PTNB2_T_C[3], alive)
		if c >= st.chest then PTNB2_StepDone(q, s, st, qi) else PTNB2_StepNote(q, s) end
	elseif kind == PTNB2_KIND_KING and st.king and not st.king.boss902 then
		local c = GetTask(PTNB2_T_C[2]) + 1
		SetTask(PTNB2_T_C[2], c)
		SetTask(PTNB2_T_C[3], 0)
		if c >= st.king.need then PTNB2_StepDone(q, s, st, qi) else PTNB2_StepNote(q, s) end
	elseif kind >= PTNB2_KIND_HC and kind <= PTNB2_KIND_HC + 2 and st.king and st.king.boss902 then
		local b = 1
		if kind == PTNB2_KIND_HC + 1 then b = 2 elseif kind == PTNB2_KIND_HC + 2 then b = 4 end
		local v = GetTask(PTNB2_T_C[2])
		if not PTNB2_HasBit(v, b) then v = v + b end
		SetTask(PTNB2_T_C[2], v)
		SetTask(PTNB2_T_C[3], alive)
		if kind == PTNB2_KIND_HC then
			local w, x, y = GetNpcPos(npc)
			local n = PTNB2_SpawnHcPair(v, w, x, y, GetLevel() + 2)
			SetTask(PTNB2_T_C[3], n)
			SetTask(PTNB2_T_TM, GetGameTime())
			Msg2Player(PTNB2_TXT.lenhbai)
		end
		if v >= 7 then PTNB2_StepDone(q, s, st, qi) else PTNB2_StepNote(q, s) end
	end
end

-- ------------------------------------------------------------------ mat tich / lenh
function PTNB2_ScGet(i)
	local v = floor((i - 1) / 4) + 1
	local b = mod(i - 1, 4) + 1
	return GetByte(GetTask(PTNB2_T_SC[v]), b)
end

function PTNB2_ScSet(i, val)
	local v = floor((i - 1) / 4) + 1
	local b = mod(i - 1, 4) + 1
	SetTask(PTNB2_T_SC[v], SetByte(GetTask(PTNB2_T_SC[v]), b, val))
end

function PTNB2_ScrollIndex(part)
	local i = 1
	while PTNB2_SCROLL[i] do
		if PTNB2_SCROLL[i][1] == part then return i end
		i = i + 1
	end
	return nil
end

function PTNB2_ScrollKill(tid)
	local i = 1
	while PTNB2_SCROLL[i] do
		local sc = PTNB2_SCROLL[i]
		if sc[3] == tid then
			local v = PTNB2_ScGet(i)
			if v > 0 and v - 1 < sc[4] then
				v = v + 1
				PTNB2_ScSet(i, v)
				if v - 1 >= sc[4] then
					PTNB2_Note(sc[2], 2)
					Msg2Player(PTNB2_TXT.sc_done)
				else
					PTNB2_Note(sc[2], 1, v - 1, sc[4])
				end
			end
		end
		i = i + 1
	end
end

function PTNB2_Mat917(p, tid)
	local i = PTNB2_ScrollIndex(309)
	if i == nil or PTNB2_ScGet(i) == 0 then return end
	local d = PTNB2_MAT917[tid]
	local c = PTNB2_C917[p]
	if d == nil or (d ~= c[2] and d ~= c[3]) then return end
	if HaveNormalItem(3, c[2], 0, 0) + HaveNormalItem(3, c[3], 0, 0) >= 2 then return end
	if random(1, 100) > PTNB2_MAT_RATE then return end
	AddNormalItem(3, d, 0, 1, 0, 0)
end

function PTNB2_ScrollDrop(tid)
	if random(1, 100) > PTNB2_SCROLL_RATE then return end
	local i = 1
	while PTNB2_SCROLL[i] do
		local sc = PTNB2_SCROLL[i]
		local hit = (sc[3] == tid)
		if sc[3] < 0 and PTNB2_MAT917[tid] and random(1, 4) == 1 then hit = 1 end
		if hit and GetLevel() <= sc[5] + 15 and PTNB2_ScGet(i) == 0 and HaveNormalItem(6, 1, sc[1], 1) < 1 then
			AddNormalItem(6, 1, sc[1], 1, 0, 0)
			Msg2Player(PTNB2_TXT.sc_drop .. sc[6])
			return
		end
		i = i + 1
	end
end

function PTNB2_ScrollReward(sc)
	local exp = sc[4] * sc[5] * 80
	local money = sc[4] * sc[5] * 15
	if sc[3] < 0 then exp = 3000 money = 1500 end
	return exp, money
end

-- turn in every finished mat tich (near a Tap hoa Thuong, or force = 1 at Quan Su); returns count
function PTNB2_ScrollTurnin(force)
	PTNB2_Boot()
	local p = PTNB2_Prof()
	if p == nil then return 0 end
	local n = 0
	local i = 1
	while PTNB2_SCROLL[i] do
		local sc = PTNB2_SCROLL[i]
		local v = PTNB2_ScGet(i)
		if v > 0 then
			local var = PTNB2_T_SC[floor((i - 1) / 4) + 1]
			local cur = GetTask(var)
			local nxt = SetByte(cur, mod(i - 1, 4) + 1, 0)
			local ok = 0
			local rew = { { 1, 0, 1, 1, 0, 0, 2 } }
			if sc[3] >= 0 then
				if v - 1 >= sc[4] then ok = QuestExchange(var, cur, nxt, {}, rew) end
			else
				ok = PTNB2_Take917(p, var, cur, nxt, rew, force)
			end
			if ok == 1 then
				local exp, money = PTNB2_ScrollReward(sc)
				Msg2Player(PTNB2_TXT.sc_reward .. PTNB2_Title(sc[2]))
				PTNB2_Note(sc[2], -1)
				PTNB2_GiveCash({ exp = exp, money = money })
				n = n + 1
			elseif (v - 1 >= sc[4] and sc[3] >= 0) then
				PTNB2_Warn(PTNB2_TXT.bag_full)
			end
		end
		i = i + 1
	end
	return n
end

-- "Thu thap" mat tich: 2 of material A or B (materials may carry level 0 or 1)
function PTNB2_Take917(p, var, cur, nxt, rew, force)
	local c = PTNB2_C917[p]
	if HaveNormalItem(3, c[2], 0, 0) + HaveNormalItem(3, c[3], 0, 0) < 2 then
		if force then Msg2Player(PTNB2_TXT.sc_need917 .. "2 " .. c[4] .. PTNB2_TXT.orw .. c[5]) end
		return 0
	end
	local lv = 0
	while lv <= 1 do
		if QuestExchange(var, cur, nxt, { { 3, c[2], 0, lv, 0, 0, 2 } }, rew) == 1 then return 1 end
		if QuestExchange(var, cur, nxt, { { 3, c[3], 0, lv, 0, 0, 2 } }, rew) == 1 then return 1 end
		if QuestExchange(var, cur, nxt, { { 3, c[2], 0, lv, 0, 0, 1 }, { 3, c[3], 0, lv, 0, 0, 1 } }, rew) == 1 then return 1 end
		lv = lv + 1
	end
	return 0
end

-- ------------------------------------------------------------------ Quan Su report (turn-in steps)
-- nb2fix: dialog entry (Quan Su), notes deferred
function PTNB2_Report()
	local r = PTNB2_Protected(PTNB2_ReportNow, {})
	if r == nil then return 0 end
	return r
end

function PTNB2_ReportNow()
	local n = PTNB2_ScrollTurnin(1)
	local q, s, st, qi = PTNB2_Cur()
	if q and s > 0 and st and st.ti then
		if PTNB2_StepDone(q, s, st, qi) == 1 then return 1 end
		return 0
	end
	if n > 0 then return 1 end
	return 0
end
