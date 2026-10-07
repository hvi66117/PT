-- pt_ibitem_lib.lua (Lua 4, ASCII). Phong Than 2026-09-30: ibitem effects the rebuilt engine does
-- not implement (docs\features\vat-pham-ibitem-lo-buff-phong-than-20260929.md). Shared by the item
-- script (pt_ibitem.lua) and the minute tick in servertimer.lua (PTAdm_IbTick).
-- All effects are native attributes applied with ModifyAttrib. The engine recomputes a player's stats
-- (equip change, relog) and wipes them; a +1% experience sentinel, held while any effect is on, makes
-- that visible through GetNpcExpRate(), and PTIB_Refresh() then re-applies.
-- Tasks (unused by VNG): 1906/1907/1908 exp expiry/%/skill x2; 1911/1912 life expiry/rate;
-- 1913/1914 mana expiry/rate; 1909 GetNpcExpRate() after applying; 1917-1920 what is applied now
-- (exp incl. sentinel, skill x2, life, mana). 2021 = B\185ch H\230 privilege expiry (2026-10-02, see below).
-- Edited by hand since 2026-10-02 (tutuong2): scratchpad\ibitem\gen.py would overwrite the additions.
Include("\\script\\phongthan\\ibitem\\pt_ibitem_data.lua")
PTIB_T_EXP_END = 1906
PTIB_T_EXP_PCT = 1907
PTIB_T_EXP_SKILL = 1908
PTIB_T_SNAP = 1909
PTIB_T_LIFE_END = 1911
PTIB_T_LIFE_RATE = 1912
PTIB_T_MANA_END = 1913
PTIB_T_MANA_RATE = 1914
PTIB_T_A_EXP = 1917
PTIB_T_A_SKILL = 1918
PTIB_T_A_LIFE = 1919
PTIB_T_A_MANA = 1920
PTIB_A_EXP = 181
PTIB_A_SKILLEXP = 187
PTIB_A_LIFE = 88
PTIB_A_MANA = 92

-- generic stat buffs: PTIB_GEN_SLOTS slots of { buff id (PTIB_GEN), expiry }, plus the id applied now
PTIB_GEN_SLOTS = 6
PTIB_T_GEN = 1921      -- 1921/1922, 1923/1924, ... 1931/1932
PTIB_T_GEN_A = 1933    -- 1933..1938

-- 2026-10-02 (tutuong2): Th\206 Tr\182i Nghi\214m \167\198c Quy\210n B\185ch H\230 6/1/1304 = monster EXP x2 (getmoreexp_p
-- +100, used by KPlayer::AddSelfExp) until the expiry kept in task 2021 (SystemTime; range of the
-- T\248 T\173\238ng agents, unused by VNG). It is added on top of the exp buff above and the sentinel, so the
-- re-apply after a stat recompute works the same way.
PTIB_T_BAIHU_END = 2021
PTIB_BAIHU_PCT = 100
PTIB_BAIHU_MAX = 15552000   -- at most 180 days stored ahead

-- seconds -> "d ng\181y h gi\234 m ph\243t" (long effects)
function PTIB_LongTime(sec)
	if sec < 0 then sec = 0 end
	local d = floor(sec / 86400)
	local h = floor((sec - d * 86400) / 3600)
	local m = floor((sec - d * 86400 - h * 3600) / 60)
	local s = ""
	if d > 0 then s = d .. " ng\181y " end
	if d > 0 or h > 0 then s = s .. h .. " gi\234 " end
	return s .. m .. " ph\243t"
end

-- B\185ch H\230 privilege: add secs (from now, or from the current expiry); returns the seconds left
function PTIB_BaihuExtend(secs)
	local now = SystemTime()
	local e = GetTask(PTIB_T_BAIHU_END)
	if e < now then e = now end
	e = e + secs
	if e - now > PTIB_BAIHU_MAX then e = now + PTIB_BAIHU_MAX end
	SetTask(PTIB_T_BAIHU_END, e)
	PTIB_Refresh()
	return e - now
end

function PTIB_BaihuLeft()
	local left = GetTask(PTIB_T_BAIHU_END) - SystemTime()
	if left < 0 then left = 0 end
	return left
end

-- generic stat buff without an item (H\233p Chu T\173\237c, T\248 Linh tier 4...): the same buff extends its
-- slot, a new one takes a free slot or the slot that ends first. Returns the seconds left (0 = bad id).
function PTIB_GrantGen(gid, secs)
	local g = PTIB_GEN[gid]
	if g == nil then return 0 end
	if secs == nil or secs <= 0 then secs = g[1] end
	local now = SystemTime()
	local slot = -1
	local k = 0
	while k < PTIB_GEN_SLOTS do
		if GetTask(PTIB_T_GEN + 2 * k) == gid and GetTask(PTIB_T_GEN + 2 * k + 1) > now then slot = k end
		k = k + 1
	end
	local left
	if slot >= 0 then
		local e = GetTask(PTIB_T_GEN + 2 * slot + 1)
		if e < now then e = now end
		SetTask(PTIB_T_GEN + 2 * slot + 1, e + secs)
		left = e + secs - now
	else
		local best = 0
		local bestEnd = -1
		k = 0
		while k < PTIB_GEN_SLOTS do
			local e = GetTask(PTIB_T_GEN + 2 * k + 1)
			if e <= now then e = 0 end
			if bestEnd < 0 or e < bestEnd then best = k bestEnd = e end
			k = k + 1
		end
		SetTask(PTIB_T_GEN + 2 * best, gid)
		SetTask(PTIB_T_GEN + 2 * best + 1, now + secs)
		left = secs
	end
	PTIB_Refresh()
	return left
end

-- generic buff id of an ibitem name (with or without the leading '#'), nil when unknown
function PTIB_GenId(name)
	local gid = PTIB_GENID[name]
	if gid == nil then gid = PTIB_GENID["#" .. name] end
	return gid
end

function PTIB_GenAttrs(id, sign)
	local g = PTIB_GEN[id]
	if g == nil then return end
	local i = 2
	while g[i] do
		ModifyAttrib(g[i], sign * g[i + 1], 0, 0, 0)
		i = i + 2
	end
end

-- make the applied generic buffs match the active slots (reset = engine wiped everything)
function PTIB_GenSync(reset)
	local k = 0
	while k < PTIB_GEN_SLOTS do
		local want = 0
		if GetTask(PTIB_T_GEN + 2 * k + 1) > 0 then want = GetTask(PTIB_T_GEN + 2 * k) end
		local have = GetTask(PTIB_T_GEN_A + k)
		if reset == 1 then have = 0 end
		if want ~= have then
			if have ~= 0 then PTIB_GenAttrs(have, -1) end
			if want ~= 0 then PTIB_GenAttrs(want, 1) end
		end
		SetTask(PTIB_T_GEN_A + k, want)
		k = k + 1
	end
end

function PTIB_Expire(tEnd, tVal, msg, now)
	local e = GetTask(tEnd)
	if e > 0 and now >= e then
		SetTask(tEnd, 0)
		if tVal then SetTask(tVal, 0) end
		Msg2Player(msg)
	end
end

-- engine2 (2026-10-04): GetNpcExpRate() minus the part that comes from engine states (GetNpcStateExpRate on the
-- engine2 CoreServer: AddIBBuff ibitem effects such as 175/176/215, skill states). A native state that starts or ends
-- is then not taken for a stat recompute (that re-applied the buffs below a second time). Old engine: no native, 0.
function PTIB_ExpRate()
	local r = GetNpcExpRate() or 0
	if GetNpcStateExpRate then r = r - (GetNpcStateExpRate() or 0) end
	return r
end

function PTIB_Refresh()
	local now = SystemTime()
	PTIB_Expire(PTIB_T_EXP_END, PTIB_T_EXP_PCT, "Hi\214u qu\182 t\168ng kinh nghi\214m \174\183 h\213t.", now)
	if GetTask(PTIB_T_EXP_END) == 0 then SetTask(PTIB_T_EXP_SKILL, 0) end
	PTIB_Expire(PTIB_T_LIFE_END, PTIB_T_LIFE_RATE, "Hi\214u qu\182 h\229i ph\244c sinh l\249c \174\183 h\213t.", now)
	PTIB_Expire(PTIB_T_MANA_END, PTIB_T_MANA_RATE, "Hi\214u qu\182 h\229i ph\244c n\233i l\249c \174\183 h\213t.", now)
	local k = 0
	local genOn = 0
	while k < PTIB_GEN_SLOTS do
		local e = GetTask(PTIB_T_GEN + 2 * k + 1)
		if e > 0 and now >= e then
			SetTask(PTIB_T_GEN + 2 * k, 0)
			SetTask(PTIB_T_GEN + 2 * k + 1, 0)
			Msg2Player("M\233t hi\214u qu\182 v\203t ph\200m \174\183 h\213t.")
		elseif e > 0 then
			genOn = 1
		end
		k = k + 1
	end
	local baihu = 0
	local be = GetTask(PTIB_T_BAIHU_END)
	if be > 0 and now >= be then
		SetTask(PTIB_T_BAIHU_END, 0)
		Msg2Player("\167\198c quy\210n B\185ch H\230 (nh\169n \174\171i kinh nghi\214m \174\184nh qu\184i) \174\183 h\213t h\185n.")
	elseif be > 0 then
		baihu = PTIB_BAIHU_PCT
		genOn = 1
	end
	local any = genOn
	if GetTask(PTIB_T_EXP_END) > 0 or GetTask(PTIB_T_LIFE_END) > 0 or GetTask(PTIB_T_MANA_END) > 0 then any = 1 end
	local wExp = GetTask(PTIB_T_EXP_PCT) + baihu + any
	local wSkill = GetTask(PTIB_T_EXP_SKILL)
	local wLife = GetTask(PTIB_T_LIFE_RATE)
	local wMana = GetTask(PTIB_T_MANA_RATE)
	local aExp = GetTask(PTIB_T_A_EXP)
	local aSkill = GetTask(PTIB_T_A_SKILL)
	local aLife = GetTask(PTIB_T_A_LIFE)
	local aMana = GetTask(PTIB_T_A_MANA)
	local genApplied = 0
	k = 0
	while k < PTIB_GEN_SLOTS do
		if GetTask(PTIB_T_GEN_A + k) ~= 0 then genApplied = 1 end
		k = k + 1
	end
	local reset = 0
	if (aExp ~= 0 or aSkill ~= 0 or aLife ~= 0 or aMana ~= 0 or genApplied == 1) and PTIB_ExpRate() ~= GetTask(PTIB_T_SNAP) then
		-- the engine recomputed the stats: nothing of ours is applied any more
		aExp = 0 aSkill = 0 aLife = 0 aMana = 0
		reset = 1
	end
	PTIB_GenSync(reset)
	if aExp == wExp and aSkill == wSkill and aLife == wLife and aMana == wMana then return end
	if aExp ~= 0 then ModifyAttrib(PTIB_A_EXP, -aExp, 0, 0, 0) end
	if aSkill ~= 0 then ModifyAttrib(PTIB_A_SKILLEXP, 0, 0, 0, 0) end
	if aLife ~= 0 then ModifyAttrib(PTIB_A_LIFE, -aLife, 0, 0, 0) end
	if aMana ~= 0 then ModifyAttrib(PTIB_A_MANA, -aMana, 0, 0, 0) end
	if wExp ~= 0 then ModifyAttrib(PTIB_A_EXP, wExp, 0, 0, 0) end
	if wSkill ~= 0 then ModifyAttrib(PTIB_A_SKILLEXP, 100, 0, 0, 0) end
	if wLife ~= 0 then ModifyAttrib(PTIB_A_LIFE, wLife, 0, 0, 0) end
	if wMana ~= 0 then ModifyAttrib(PTIB_A_MANA, wMana, 0, 0, 0) end
	SetTask(PTIB_T_A_EXP, wExp)
	SetTask(PTIB_T_A_SKILL, wSkill)
	SetTask(PTIB_T_A_LIFE, wLife)
	SetTask(PTIB_T_A_MANA, wMana)
	SetTask(PTIB_T_SNAP, PTIB_ExpRate())
end

-- minute tick (servertimer.lua) for each online player
function PTIB_Tick()
	if GetTask(PTIB_T_EXP_END) == 0 and GetTask(PTIB_T_LIFE_END) == 0 and GetTask(PTIB_T_MANA_END) == 0 and
	   GetTask(PTIB_T_BAIHU_END) == 0 and GetTask(PTIB_T_A_EXP) == 0 and GetTask(PTIB_T_A_LIFE) == 0 and GetTask(PTIB_T_A_MANA) == 0 and GetTask(PTIB_T_A_SKILL) == 0 then
		local k = 0
		local on = 0
		while k < PTIB_GEN_SLOTS do
			if GetTask(PTIB_T_GEN + 2 * k + 1) > 0 or GetTask(PTIB_T_GEN_A + k) ~= 0 then on = 1 end
			k = k + 1
		end
		if on == 0 then return end
	end
	PTIB_Refresh()
end

function PTIB_TimeText(sec)
	if sec >= 7200 then return floor(sec / 3600) .. " gi\234." end
	return floor(sec / 60) .. " ph\243t."
end
