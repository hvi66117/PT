-- ct_hyvien.lua (Lua 4, Phong Than GameServer) - 2026-10-03 congthanh
-- "Hy vien" of the personal territory (city level 4): taskinfo 79 "Nhiem vu Diep bao" (5 rounds a day).
-- The VNG script (\script\<GBK>\xi yuan.lua) is missing. Solo version of the taskinfo chain:
-- step 0 talk to the Ve quan of Trieu Ca (ct_vequan.lua) -> step 4 destroy Xich Dong Thao (ct_herb.lua)
-- -> step 5 report back here.
-- congthanh2: building level -> +1 round a day and +20% exp per level above 1.
Include("\\script\\phongthan\\lib\\pt_compat.lua")
Include("\\script\\phongthan\\congthanh\\ct_lib.lua")
PTCT_79_BID = 7

function main()
	if not PTCT_Owns() then
		Talk(1, "PTCT_No", PTCT_TXT.not_owner)
		return
	end
	local rows = {}
	local n = 0
	local st = GetTask(PTCT_T_79)
	if PTCT_Built(PTCT_79_BID) then
		if st == 0 then
			n = n + 1 rows[n] = { "Nh\203n nhi\214m v\244 \167i\214p b\184o", "PTCT_79_Get" }
		elseif st == 3 then
			n = n + 1 rows[n] = { "Ph\244c m\214nh \167i\214p b\184o", "PTCT_79_Done" }
		else
			n = n + 1 rows[n] = { "H\241y nhi\214m v\244 \167i\214p b\184o", "PTCT_79_Cancel" }
		end
	end
	n = n + 1 rows[n] = { "Thuy\213t minh ki\213n tr\243c", "PTCT_79_Info" }
	n = n + 1 rows[n] = { PTCT_TXT.exit, "PTCT_No" }
	local head = "<color=yellow>H\253 vi\214n<color> (" .. PTCT_CityName() .. ")"
	if not PTCT_Built(PTCT_79_BID) then head = head .. "\n" .. PTCT_TXT.not_built .. "H\253 vi\214n" .. PTCT_TXT.not_built2 end
	SayTask(head, rows)
end

function PTCT_79_Info()
	Talk(1, "PTCT_No", "H\253 vi\214n l\181 n\172i t\244 t\203p c\241a m\203t th\184m. Nhi\214m v\244 \167i\214p b\184o: \174\213n Tri\210u Ca g\198p <color=green>V\214 qu\169n<color> d\223 qu\169n t\215nh, ph\184 ho\185i <color=green>X\221ch \167\229ng Th\182o<color> r\229i v\210 ph\244c m\214nh. M\231i ng\181y " .. PTCT_79_Max() .. " l\199n.")
end

function PTCT_79_Max() return PTCT_79_MAX + PTCT_BBonus(PTCT_79_BID) end

function PTCT_79_DayReset()
	if GetTask(PTCT_T_79DAY) ~= PTCT_Today() then
		SetTask(PTCT_T_79DAY, PTCT_Today())
		SetTask(PTCT_T_79N, 0)
	end
end

function PTCT_79_Get()
	if not PTCT_Owns() or not PTCT_Built(PTCT_79_BID) or GetTask(PTCT_T_79) ~= 0 then return end
	PTCT_79_DayReset()
	if GetTask(PTCT_T_79N) >= PTCT_79_Max() then
		PTCT_Say1("H\171m nay ng\173\172i \174\183 l\181m \174\241 <color=green>" .. PTCT_79_Max() .. "<color> l\199n \167i\214p b\184o.")
		return
	end
	SetTask(PTCT_T_79, 1)
	TaskNote(79, 0)
	PTCT_Say1("H\183y l\206n v\181o <color=green>Tri\210u Ca<color>, \174\232i tho\185i v\237i <color=green>V\214 qu\169n<color> \174\211 d\223 la qu\169n t\215nh.")
end

function PTCT_79_Done()
	if GetTask(PTCT_T_79) ~= 3 then return end
	SetTask(PTCT_T_79, 0)
	PTCT_79_DayReset()
	SetTask(PTCT_T_79N, GetTask(PTCT_T_79N) + 1)
	local exp = floor(GetLevel() * 1500 * (10 + 2 * PTCT_BBonus(PTCT_79_BID)) / 10)
	AddOwnExp(exp)
	PTCT_AddContri(1)
	local k = random(1, 4)
	PTCT_AddRes(k, 1)
	TaskNote(79, -1)
	PTCT_Say1("\167i\214p b\184o th\181nh c\171ng! Nh\203n <color=red>" .. exp .. "<color> kinh nghi\214m, 1 \174i\211m c\232ng hi\213n v\181 1 " .. PTCT_RESNAME[k] .. ".")
end

function PTCT_79_Cancel()
	if GetTask(PTCT_T_79) == 0 then return end
	SetTask(PTCT_T_79, 0)
	TaskNote(79, -1)
	PTCT_Say1("\167\183 h\241y nhi\214m v\244 \167i\214p b\184o.")
end
