-- ct_muchang.lua (Lua 4, Phong Than GameServer) - 2026-10-03 congthanh
-- "San luyen thu" of the personal territory: taskinfo 69 "Tru ma" (2 rounds a day). The VNG building
-- script (\script\<GBK>\guai wu mu chang.lua) only has the info/demolish rows, so the quest is written
-- here after the taskinfo text: defeat maze monsters and bring back their trophies.
-- congthanh2: building level -> +1 round a day and +25% money per level above 1.
Include("\\script\\phongthan\\lib\\pt_compat.lua")
Include("\\script\\phongthan\\congthanh\\ct_lib.lua")

-- trophies (monster drops, same tuples as the VNG mercenary "Thu thap" list)
PTCT_69_ITEM = {}
PTCT_69_ITEM[1] = { "H\225a v\242", 3, 8 }
PTCT_69_ITEM[2] = { "Ng\228c c\232t", 3, 9 }
PTCT_69_ITEM[3] = { "\167o\182n Ki\213m", 3, 10 }
PTCT_69_ITEM[4] = { "M\182nh Gi\184p", 3, 11 }
PTCT_69_ITEM[5] = { "M\198t Qu\251", 3, 12 }
PTCT_69_ITEM[6] = { "B\168ng c\172", 3, 13 }
PTCT_69_BID = 3

function main()
	if not PTCT_Owns() then
		Talk(1, "PTCT_No", PTCT_TXT.not_owner)
		return
	end
	local rows = {}
	local n = 0
	if PTCT_Built(PTCT_69_BID) then
		if GetTask(PTCT_T_69) == 0 then
			n = n + 1 rows[n] = { "Nh\203n nhi\214m v\244 Tr\245 ma", "PTCT_69_Get" }
		else
			n = n + 1 rows[n] = { "Ph\244c m\214nh Tr\245 ma", "PTCT_69_Done" }
			n = n + 1 rows[n] = { "H\241y nhi\214m v\244 Tr\245 ma", "PTCT_69_Cancel" }
		end
	end
	n = n + 1 rows[n] = { "Thuy\213t minh ki\213n tr\243c", "PTCT_69_Info" }
	n = n + 1 rows[n] = { PTCT_TXT.exit, "PTCT_No" }
	local head = "<color=yellow>S\169n luy\214n th\243<color> (" .. PTCT_CityName() .. ")"
	if not PTCT_Built(PTCT_69_BID) then head = head .. "\n" .. PTCT_TXT.not_built .. "S\169n luy\214n th\243" .. PTCT_TXT.not_built2 end
	SayTask(head, rows)
end

function PTCT_69_Info()
	Talk(1, "PTCT_No", "Theo tinh t\173\238ng, qu\184i v\203t trong m\170 cung s\190p t\202n c\171ng th\181nh th\222. M\231i ng\181y nh\203n <color=green>" .. PTCT_69_Max() .. "<color> l\199n Tr\245 ma: h\185 qu\184i v\181 mang ch\248ng v\203t v\210 \174\169y. Th\173\235ng: kinh nghi\214m, ng\169n qu\252, c\232ng hi\213n v\181 L\173\172ng th\182o.")
end

function PTCT_69_Max() return PTCT_69_MAX + PTCT_BBonus(PTCT_69_BID) end
function PTCT_69_Money() return 50000 + 12500 * PTCT_BBonus(PTCT_69_BID) end

function PTCT_69_DayReset()
	if GetTask(PTCT_T_69DAY) ~= PTCT_Today() then
		SetTask(PTCT_T_69DAY, PTCT_Today())
		SetTask(PTCT_T_69N, 0)
	end
end

function PTCT_69_Pick()
	local lv = GetLevel()
	if lv < 40 then return random(1, 3) end
	if lv < 60 then return random(2, 5) end
	return random(4, 6)
end

function PTCT_69_Get()
	if not PTCT_Owns() or not PTCT_Built(PTCT_69_BID) or GetTask(PTCT_T_69) ~= 0 then return end
	PTCT_69_DayReset()
	if GetTask(PTCT_T_69N) >= PTCT_69_Max() then
		PTCT_Say1("H\171m nay ng\173\172i \174\183 l\181m \174\241 <color=green>" .. PTCT_69_Max() .. "<color> l\199n Tr\245 ma.")
		return
	end
	local k = PTCT_69_Pick()
	local it = PTCT_69_ITEM[k]
	SetTask(PTCT_T_69, SetByte(SetByte(0, 1, k), 2, PTCT_69_COUNT))
	TaskNote(69, 0, it[1], "", PTCT_69_COUNT)
	PTCT_Say1("Mau \174i h\185 qu\184i v\203t m\170 cung, mang v\210 <color=green>" .. it[1] .. "<color> <color=red>" .. PTCT_69_COUNT .. "<color> c\184i l\181m ch\248ng!")
end

function PTCT_69_Done()
	local v = GetTask(PTCT_T_69)
	if v == 0 then return end
	local k = GetByte(v, 1)
	local cnt = GetByte(v, 2)
	local it = PTCT_69_ITEM[k]
	if not it then
		SetTask(PTCT_T_69, 0)
		return
	end
	local have = HaveNormalItem(it[2], it[3], 0, 0)
	if have < cnt then
		TaskNote(69, 0, it[1], "", cnt - have)
		PTCT_Say1("C\223n thi\213u <color=green>" .. it[1] .. "<color> <color=red>" .. (cnt - have) .. "<color> c\184i.")
		return
	end
	local i = 1
	while i <= cnt do
		DelNormalItem(it[2], it[3], 0, 0)
		i = i + 1
	end
	SetTask(PTCT_T_69, 0)
	PTCT_69_DayReset()
	SetTask(PTCT_T_69N, GetTask(PTCT_T_69N) + 1)
	local exp = GetLevel() * 1000
	AddOwnExp(exp)
	local money = PTCT_69_Money()
	Earn(money)
	PTCT_AddContri(1)
	PTCT_AddRes(4, 1)
	TaskNote(69, -1)
	PTCT_Say1("Tr\245 ma th\181nh c\171ng! Nh\203n <color=red>" .. exp .. "<color> kinh nghi\214m, <color=red>" .. money .. "<color> l\173\238ng ng\169n qu\252, 1 \174i\211m c\232ng hi\213n v\181 1 L\173\172ng th\182o.")
end

function PTCT_69_Cancel()
	if GetTask(PTCT_T_69) == 0 then return end
	SetTask(PTCT_T_69, 0)
	TaskNote(69, -1)
	PTCT_Say1("\167\183 h\241y nhi\214m v\244 Tr\245 ma (v\201n t\221nh v\181o s\232 l\199n h\171m nay).")
	PTCT_69_DayReset()
	SetTask(PTCT_T_69N, GetTask(PTCT_T_69N) + 1)
end
