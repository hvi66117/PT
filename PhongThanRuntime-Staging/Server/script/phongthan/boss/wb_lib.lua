-- Phong Than world-boss timer (2026-09-30). Loaded and ticked by servertimer.lua (PTAdm_Tick, once a
-- minute at second 00). Spawns each boss at its VNG schedule minute when it is not alive, detects the
-- kill (the wrapped VNG death script sets GlobalValue(slot) = -1 and stores the killer PlayerIndex),
-- keeps the times in GlobalValue for the token item and writes admin_bridge\worldboss.txt for the web.
dofile("script\\phongthan\\boss\\wb_data.lua")
PTWB_DEATH_SCRIPTS = { "\92script\92npcdeath\92\190\197\211\164.lua", "\92script\92npcdeath\92\187\236\227\231.lua", "\92script\92npcdeath\92\199\238\198\230.lua", "\92script\92npcdeath\92\247\210\247\209.lua", "\92script\92npcdeath\92\151\131\232\187.lua", "\92script\92npcdeath\92\197\204\185\197.lua", "\92script\92npcdeath\92\180\243\197\244.lua", "\92script\92npcdeath\92\209\238\234\175.lua", "\92script\92npcdeath\92\242\212\193\250.lua", "\92script\92npcdeath\92\243\164\193\250.lua", "\92script\92npcdeath\92\242\176\193\250.lua", "\92script\92\185\214\206\239\92\178\187\210\229\186\238.lua" }
PTWB_KILLER = PTWB_KILLER or {}

function PTWB_Min(hm)
	return tonumber(strsub(hm, 1, 2)) * 60 + tonumber(strsub(hm, 4, 5))
end

function PTWB_Next(b, now)
	local best = nil
	local first = nil
	local k = 1
	while b.sched[k] do
		local m = PTWB_Min(b.sched[k])
		if not first or m < first then first = m end
		if m > now and (not best or m < best) then best = m end
		k = k + 1
	end
	if not best then best = first end
	return floor(best / 60) * 100 + mod(best, 60)
end

function PTWB_Alive(b)
	local ni = GetGlobalValue(PTWB_G_NPC + b.i)
	if ni <= 0 then return nil end
	local w = GetNpcPos(ni)
	if w == b.map and GetNpcTemplateID(ni) == b.tpl then return ni end
	return nil
end

function PTWB_Spawn(b, hhmm)
	if PTWB_Alive(b) then SetGlobalValue(b.slot, 1) return 0 end
	local sw = SubWorldID2Idx(b.map)
	if not sw or sw < 0 then return -1 end
	local ni = AddNpc(b.tpl, b.lv, sw, b.x * 32, b.y * 32, 1)
	if not ni or ni <= 0 then ni = AddNpc(b.tpl, b.lv, sw, b.x * 32, b.y * 32, 0) end
	if not ni or ni <= 0 then return -2 end
	SetGlobalValue(b.slot, 1)
	SetGlobalValue(PTWB_G_NPC + b.i, ni)
	SetGlobalValue(PTWB_G_SPAWN + b.i, hhmm)
	SetGlobalValue(PTWB_G_KILLER + b.i, 0)
	AddGlobalNews("Boss th\213 gi\237i <color=yellow>" .. b.name .. "<color> \174\183 xu\202t hi\214n t\185i <color=green>" .. b.mapname .. " [" .. b.dx .. "," .. b.dy .. "]!")
	return ni
end

-- 2026-10-01 loot ("Tang cuong"): given once per kill to the killer's bag (tables in wb_loot.lua):
-- white VNG gear x n, the killer's profession skill book, do luc set pieces of the boss tier, and a
-- chance of phap bao / phap khi / an (announced to the server).
function PTWB_Tier(lv)
	if lv >= 100 then return 100 elseif lv >= 80 then return 80 elseif lv >= 60 then return 60 end
	return 40
end

function PTWB_Pick(list)
	if not list then return nil end
	local n = getn(list)
	if n <= 0 then return nil end
	return list[random(1, n)]
end

function PTWB_GiveCode(pi, code)
	if not code then return 0 end
	return PTAdm_GiveTo(pi, code[1], code[2], code[3], code[4], code[5], 1)
end

-- 2026-10-02 Tu Tuong (tutuong_a): the 4 ma vuong also drop Tinh Phach 3/200..203 (unbound) to the
-- killer, exchanged with the elders of script\phongthan\tutuong\tt_elder*.lua (Thiet Bo -> Tho,
-- Con Boi/Thao Thiet -> Hoa, Lam Ba -> Phong, Kim Trai -> Thuy; material.txt descriptions).
PTWB_TINHPHACH = { thiet_bo = 200, con_boi = 201, lam_ba = 202, kim_trai = 203 }
PTWB_TINHPHACH_N = 2
function PTWB_GiveTinhPhach(b, pi)
	local d = PTWB_TINHPHACH[b.key]
	if not d then return 0 end
	PlayerIndex = pi
	local n = 0
	local k = 1
	while k <= PTWB_TINHPHACH_N do
		local r = AddNormalItemPile(3, d, 0, 0, 0, 0)
		if r and r > 0 then n = n + 1 end
		k = k + 1
	end
	if n > 0 then Msg2Player("Ma v\173\172ng " .. b.name .. " r\172i " .. n .. " Tinh Ph\184ch: mang \174\213n Tr\173\234ng L\183o c\185nh \174\227 \174\211 \174\230i Ng\173ng Ph\184ch.") end
	return n
end

function PTWB_GiveLoot(b, pi)
	if not PTWB_LOOT_COUNT then dofile("script\\phongthan\\boss\\wb_loot.lua") end
	PlayerIndex = pi
	local nm = GetName()
	if not nm or nm == "" then return 0 end
	local t = PTWB_Tier(b.lv)
	local c = PTWB_LOOT_COUNT[t]
	local prof = GetProfession()
	if not prof or prof < 0 or prof > 2 then prof = random(0, 2) end
	local got = 0
	local k = 1
	while k <= c[1] do got = got + PTWB_GiveCode(pi, PTWB_Pick(PTWB_LOOT_WHITE[t])) k = k + 1 end
	k = 1
	while k <= c[2] do got = got + PTWB_GiveCode(pi, PTWB_LOOT_BOOK[prof]) k = k + 1 end
	k = 1
	while k <= c[3] do got = got + PTWB_GiveCode(pi, PTWB_Pick(PTWB_LOOT_GEAR[t][prof])) k = k + 1 end
	local rare = 0
	if random(1, 100) <= c[4] then
		rare = PTWB_GiveCode(pi, PTWB_Pick(PTWB_LOOT_RARE))
		got = got + rare
	end
	got = got + PTWB_GiveTinhPhach(b, pi)
	-- 2026-10-05 thanky: Manh Than Ky + Tui Thuoc Tinh (script\phongthan\thanky\tk_boss.lua, loaded at call time;
	-- protected so an error there cannot stop the world-boss timer / admin bridge tick)
	if not PTTK_BossLoot then dofile("script\\phongthan\\thanky\\tk_boss.lua") end
	if PTTK_BossLoot then
		local tk = call(PTTK_BossLoot, { t, pi }, "x", PTAdm_TickErr)
		if tk then got = got + tk end
	end
	PlayerIndex = pi
	Msg2Player("H\185 boss " .. b.name .. ": nh\203n " .. got .. " v\203t ph\200m v\181o t\243i (\174\229, b\221 k\221p, \174\229 l\244c). T\243i \174\199y s\207 kh\171ng nh\203n \174\173\238c.")
	if rare > 0 then AddGlobalNews("<color=yellow>" .. nm .. "<color> h\185 boss <color=yellow>" .. b.name .. "<color> v\181 nh\203n \174\173\238c <color=orange>b\182o v\203t hi\213m<color>!") end
	return got
end

function PTWB_SpawnKey(key)
	local k = 1
	while PTWB_LIST[k] do
		local b = PTWB_LIST[k]
		if b.key == key then return PTWB_Spawn(b, tonumber(date("%H%M"))) end
		k = k + 1
	end
	return -3
end

function PTWB_Tick()
	if not PTWB_INIT then
		local k = 1
		while PTWB_DEATH_SCRIPTS[k] do ReLoadScript(PTWB_DEATH_SCRIPTS[k]) k = k + 1 end
		PTWB_INIT = 1
	end
	local hm = date("%H:%M")
	local now = PTWB_Min(hm)
	local hhmm = tonumber(date("%H%M"))
	local out = ""
	local k = 1
	while PTWB_LIST[k] do
		local b = PTWB_LIST[k]
		local st = GetGlobalValue(b.slot)
		if PTWB_Alive(b) then
			-- the boss is on its map: alive whatever another script wrote into the VNG slot
			if st ~= 1 then SetGlobalValue(b.slot, 1) end
			st = 1
			PTWB_KILLER[b.key] = nil
		elseif st == 1 then
			-- gone without the death script (admin clear, map reset): count as removed
			SetGlobalValue(b.slot, -1)
			st = -1
		end
		if st == -1 and GetGlobalValue(PTWB_G_DEATH + b.i) == 0 and GetGlobalValue(PTWB_G_SPAWN + b.i) > 0 then
			SetGlobalValue(PTWB_G_DEATH + b.i, hhmm)
		end
		if st == -1 and not PTWB_KILLER[b.key] then
			local pi = GetGlobalValue(PTWB_G_KILLER + b.i)
			local who = ""
			if pi > 0 then
				local old = PlayerIndex
				PlayerIndex = pi
				who = GetName() or ""
				PlayerIndex = old
			end
			PTWB_KILLER[b.key] = who
			if pi > 0 and who ~= "" then PTWB_GiveLoot(b, pi) end
			PlayerIndex = nil
		end
		local j = 1
		while b.sched[j] do
			if b.sched[j] == hm and st ~= 1 then
				if PTWB_Spawn(b, hhmm) > 0 then
					st = 1
					SetGlobalValue(PTWB_G_DEATH + b.i, 0)
					PTWB_KILLER[b.key] = nil
				end
			end
			j = j + 1
		end
		SetGlobalValue(PTWB_G_NEXT + b.i, PTWB_Next(b, now))
		out = out .. b.key .. "\t" .. st .. "\t" .. GetGlobalValue(PTWB_G_SPAWN + b.i) .. "\t" ..
			GetGlobalValue(PTWB_G_DEATH + b.i) .. "\t" .. GetGlobalValue(PTWB_G_NEXT + b.i) .. "\t" ..
			(PTWB_KILLER[b.key] or "") .. "\n"
		k = k + 1
	end
	local f = openfile(PTADM_DIR .. "worldboss.tmp", "w")
	if f then
		write(f, date("%Y-%m-%d %H:%M:%S") .. "\n" .. out)
		closefile(f)
		remove(PTADM_DIR .. "worldboss.txt")
		rename(PTADM_DIR .. "worldboss.tmp", PTADM_DIR .. "worldboss.txt")
	end
end
