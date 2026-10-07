-- ct_chienxa.lua (Lua 4, Phong Than GameServer) - 2026-10-03 congthanh
-- "Phong chien xa" of the personal territory: taskinfo 78 "Thu thap Xich Dong Thao" (20 rounds a day).
-- The VNG building script (\script\<GBK>\bing gong chang.lua) has no quest; written after the taskinfo
-- text: pick Xich Dong Thao at the herb patches (ct_herb.lua) outside the territory and bring it back.
-- congthanh2: building level 3 / 5 -> one herb less per round; +10% hung thinh chance per level above 1.
Include("\\script\\phongthan\\lib\\pt_compat.lua")
Include("\\script\\phongthan\\congthanh\\ct_lib.lua")
PTCT_78_BID = 4

function main()
	if not PTCT_Owns() then
		Talk(1, "PTCT_No", PTCT_TXT.not_owner)
		return
	end
	local rows = {}
	local n = 0
	if PTCT_Built(PTCT_78_BID) then
		if GetTask(PTCT_T_78) == 0 then
			n = n + 1 rows[n] = { "Nh\203n nhi\214m v\244 Thu th\203p X\221ch \167\229ng Th\182o", "PTCT_78_Get" }
		else
			n = n + 1 rows[n] = { "Giao X\221ch \167\229ng Th\182o", "PTCT_78_Done" }
		end
	end
	n = n + 1 rows[n] = { "Thuy\213t minh ki\213n tr\243c", "PTCT_78_Info" }
	n = n + 1 rows[n] = { PTCT_TXT.exit, "PTCT_No" }
	local head = "<color=yellow>Ph\223ng chi\213n xa<color> (" .. PTCT_CityName() .. ")"
	if not PTCT_Built(PTCT_78_BID) then head = head .. "\n" .. PTCT_TXT.not_built .. "Ph\223ng chi\213n xa" .. PTCT_TXT.not_built2 end
	SayTask(head, rows)
end

function PTCT_78_Info()
	Talk(1, "PTCT_No", "Ph\223ng chi\213n xa c\199n nhi\210u <color=green>X\221ch \167\229ng Th\182o<color>. B\183i X\221ch \167\229ng Th\182o \235 r\215a t\169y nam T\169y K\250. M\231i l\199n h\184i \174\241 <color=green>" .. PTCT_78_Need() .. "<color> b\244i r\229i mang v\210; m\231i ng\181y t\232i \174a " .. PTCT_78_MAX .. " l\199n.")
end

function PTCT_78_DayReset()
	if GetTask(PTCT_T_78DAY) ~= PTCT_Today() then
		SetTask(PTCT_T_78DAY, PTCT_Today())
		SetTask(PTCT_T_78N, 0)
	end
end

function PTCT_78_Get()
	if not PTCT_Owns() or not PTCT_Built(PTCT_78_BID) or GetTask(PTCT_T_78) ~= 0 then return end
	PTCT_78_DayReset()
	if GetTask(PTCT_T_78N) >= PTCT_78_MAX then
		PTCT_Say1("H\171m nay ng\173\172i \174\183 l\181m \174\241 <color=green>" .. PTCT_78_MAX .. "<color> l\199n.")
		return
	end
	SetTask(PTCT_T_78, SetByte(SetByte(0, 1, 1), 2, 0))
	TaskNote(78, 0)
	PTCT_Say1("\167\213n b\183i X\221ch \167\229ng Th\182o ngo\181i th\181nh h\184i <color=green>" .. PTCT_78_Need() .. "<color> b\244i r\229i mang v\210 \174\169y.")
end

function PTCT_78_Done()
	local v = GetTask(PTCT_T_78)
	if v == 0 then return end
	local got = GetByte(v, 2)
	if got < PTCT_78_Need() then
		PTCT_Say1("M\237i h\184i \174\173\238c <color=green>" .. got .. "/" .. PTCT_78_Need() .. "<color> b\244i X\221ch \167\229ng Th\182o.")
		return
	end
	SetTask(PTCT_T_78, 0)
	PTCT_78_DayReset()
	SetTask(PTCT_T_78N, GetTask(PTCT_T_78N) + 1)
	local exp = GetLevel() * 300
	AddOwnExp(exp)
	PTCT_AddRes(3, 1)
	local s = "Nh\203n <color=red>" .. exp .. "<color> kinh nghi\214m v\181 1 X\221ch \174\229ng"
	if random(1, 100) <= 30 + 10 * PTCT_BBonus(PTCT_78_BID) then
		SetTask(PTCT_T_HUNG, GetTask(PTCT_T_HUNG) + 1)
		s = s .. ", may m\190n \174\173\238c th\170m 1 \174i\211m H\173ng th\222nh"
	end
	TaskNote(78, -1)
	PTCT_Say1(s .. ". (H\171m nay " .. GetTask(PTCT_T_78N) .. "/" .. PTCT_78_MAX .. ")")
end
