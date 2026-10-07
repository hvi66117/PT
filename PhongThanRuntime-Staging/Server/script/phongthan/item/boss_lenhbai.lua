-- Phong Than "Lenh Bai Boss The Gioi" (magicscript 61001, 2026-09-30): permanent, unlimited uses
-- (KItemList::ExecuteScript only calls main; this script never removes the item).
-- Shows each world boss with its state and teleports to a point 10 cells from the spawn.
-- The data table is loaded on first use: while the engine registers scripts at startup the working
-- directory is the script's own folder, so a top-level relative dofile fails and the whole item
-- script is left unregistered ("script not found" -> nothing happens on right click).
function PTWB_Load()
	if not PTWB_LIST then dofile("script\\phongthan\\boss\\wb_data.lua") end
end

function PTWB_HM(v)
	if not v or v <= 0 then return "--:--" end
	local h = floor(v / 100)
	local m = mod(v, 100)
	local s = ""
	if h < 10 then s = "0" end
	s = s .. h .. ":"
	if m < 10 then s = s .. "0" end
	return s .. m
end

function PTWB_Line(b)
	local st = GetGlobalValue(b.slot)
	local nx = PTWB_HM(GetGlobalValue(PTWB_G_NEXT + b.i))
	if st == 1 then
		return b.name .. ": \174ang xu\202t hi\214n [" .. b.dx .. "," .. b.dy .. "]"
	elseif st == -1 and GetGlobalValue(PTWB_G_DEATH + b.i) > 0 then
		return b.name .. ": \174\183 b\222 di\214t l\243c " .. PTWB_HM(GetGlobalValue(PTWB_G_DEATH + b.i)) .. ", l\199n t\237i " .. nx
	end
	return b.name .. ": ch\173a xu\202t hi\214n, l\199n t\237i " .. nx
end

function PTWB_Say(title, o)
	local n = getn(o)
	if n == 9 then Say(title, n, o[1], o[2], o[3], o[4], o[5], o[6], o[7], o[8], o[9])
	elseif n == 8 then Say(title, n, o[1], o[2], o[3], o[4], o[5], o[6], o[7], o[8])
	else Say(title, n, o[1], o[2], o[3], o[4], o[5], o[6], o[7]) end
end

function PTWB_Page1()
	PTWB_Load()
	local o = {}
	local k = 1
	while k <= 6 and PTWB_LIST[k] do
		tinsert(o, PTWB_Line(PTWB_LIST[k]) .. "/PTWB_Go" .. k)
		k = k + 1
	end
	tinsert(o, "Trang sau (boss 7-12)/PTWB_Page2")
	tinsert(o, "K\213t th\243c \174\232i tho\185i/PTWB_No")
	PTWB_Say("<color=yellow>L\214nh B\181i Boss Th\213 Gi\237i<color>: ch\228n boss \174\211 \174i \174\213n boss. Boss ch\173a xu\202t hi\214n s\207 \174\173\238c g\228i ra ngay.", o)
end

function PTWB_Page2()
	PTWB_Load()
	local o = {}
	local k = 7
	while k <= 12 and PTWB_LIST[k] do
		tinsert(o, PTWB_Line(PTWB_LIST[k]) .. "/PTWB_Go" .. k)
		k = k + 1
	end
	tinsert(o, "Trang tr\173\237c (boss 1-6)/PTWB_Page1")
	tinsert(o, "K\213t th\243c \174\232i tho\185i/PTWB_No")
	PTWB_Say("<color=yellow>L\214nh B\181i Boss Th\213 Gi\237i<color>: ch\228n boss \174\211 \174i \174\213n boss. Boss ch\173a xu\202t hi\214n s\207 \174\173\238c g\228i ra ngay.", o)
end

-- the boss npc if it is alive on its map (same checks as wb_lib PTWB_Alive), with its world position
function PTWB_NpcOf(b)
	local ni = GetGlobalValue(PTWB_G_NPC + b.i)
	if ni and ni > 0 then
		local w, x, y = GetNpcPos(ni)
		if w == b.map and GetNpcTemplateID(ni) == b.tpl then return ni, x, y end
	end
	return nil
end

-- summon the boss now at its VNG spawn point (token holder, any time); keeps the timer's GlobalValue
-- bookkeeping so the web admin and the minute tick see it as alive
function PTWB_Summon(b)
	local sw = SubWorldID2Idx(b.map)
	if not sw or sw < 0 then return nil end
	local ni = AddNpc(b.tpl, b.lv, sw, b.x * 32, b.y * 32, 1)
	if not ni or ni <= 0 then ni = AddNpc(b.tpl, b.lv, sw, b.x * 32, b.y * 32, 0) end
	if not ni or ni <= 0 then return nil end
	SetGlobalValue(b.slot, 1)
	SetGlobalValue(PTWB_G_NPC + b.i, ni)
	SetGlobalValue(PTWB_G_KILLER + b.i, 0)
	SetGlobalValue(PTWB_G_DEATH + b.i, 0)
	if date then SetGlobalValue(PTWB_G_SPAWN + b.i, tonumber(date("%H%M"))) end
	AddGlobalNews("Boss th\213 gi\237i <color=yellow>" .. b.name .. "<color> \174\173\238c <color=yellow>" .. (GetName() or "") .. "<color> tri\214u h\229i t\185i <color=green>" .. b.mapname .. " [" .. b.dx .. "," .. b.dy .. "]!")
	return ni
end

-- alive: go to the boss (its current position if it walked > 30 cells from the spawn);
-- not alive (before its hour or killed): summon it, then go to the teleport point next to it
function PTWB_Teleport(k)
	PTWB_Load()
	local b = PTWB_LIST[k]
	if not b then return end
	local ni, x, y = PTWB_NpcOf(b)
	local called = nil
	if not ni then
		ni = PTWB_Summon(b)
		if not ni then
			Msg2Player("Kh\171ng g\228i \174\173\238c boss " .. b.name)
			return
		end
		called = 1
	end
	local tx, ty = b.tpx, b.tpy
	if x and y and (abs(x - b.x) > 30 or abs(y - b.y) > 30) then tx, ty = x, y end
	if GetFightState() == 0 then SetFightState(1) end
	NewWorld(b.tpmap, tx, ty)
	SetFightState(1)
	if called then
		Msg2Player("\167\183 g\228i v\181 d\222ch chuy\211n \174\213n boss " .. b.name .. " - " .. b.mapname .. " [" .. b.dx .. "," .. b.dy .. "]")
	else
		Msg2Player("\167\183 d\222ch chuy\211n \174\213n boss " .. b.name .. " - " .. b.mapname .. " [" .. floor(tx / 8) .. "," .. floor(ty / 16) .. "]")
	end
end

function PTWB_Go1() PTWB_Teleport(1) end
function PTWB_Go2() PTWB_Teleport(2) end
function PTWB_Go3() PTWB_Teleport(3) end
function PTWB_Go4() PTWB_Teleport(4) end
function PTWB_Go5() PTWB_Teleport(5) end
function PTWB_Go6() PTWB_Teleport(6) end
function PTWB_Go7() PTWB_Teleport(7) end
function PTWB_Go8() PTWB_Teleport(8) end
function PTWB_Go9() PTWB_Teleport(9) end
function PTWB_Go10() PTWB_Teleport(10) end
function PTWB_Go11() PTWB_Teleport(11) end
function PTWB_Go12() PTWB_Teleport(12) end

function PTWB_No()
end

function main(nItemIdx)
	PTWB_Load()
	PTWB_Page1()
	return 0
end
