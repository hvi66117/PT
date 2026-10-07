-- ct_steward.lua (Lua 4, Phong Than GameServer) - 2026-10-03 congthanh
-- "Lanh dia quan" (Tay Ky 1020): found a personal territory, build the territory buildings, raise the
-- city level, donate money for contribution, collect the daily tax, courier for the mercenary letters.
-- congthanh2: building upgrades (levels 1..5), city defence (join / start now, ct_def.lua), personal Cuu Linh
-- for task 908 step 1 (ct_boss.lua). Spawned by script\phongthan\ext\congthanh.lua. Doc: docs\features\cong-thanh-lanh-dia-phong-than-20261003.md
Include("\\script\\phongthan\\lib\\pt_compat.lua")
Include("\\script\\phongthan\\congthanh\\ct_lib.lua")
Include("\\script\\phongthan\\congthanh\\ct_def.lua")
Include("\\script\\phongthan\\congthanh\\ct_boss.lua")

function PTCT_S_Head()
	local s = "<color=yellow>L\183nh \174\222a quan<color>: "
	if PTCT_Owns() then
		return s .. PTCT_CityName() .. " - " .. PTCT_TXT.lv .. PTCT_Level() .. ", c\232ng hi\213n <color=green>" .. PTCT_Contri() .. "<color>."
	end
	return s .. "Th\234i lo\185n, bang h\233i tan t\184c. Ai c\227 ch\221 c\227 th\211 t\249 l\203p m\233t <color=green>l\183nh \174\222a ri\170ng<color>, x\169y c\171ng tr\215nh v\181 nh\203n nhi\214m v\244 l\183nh \174\222a."
end

function main()
	local rows = {}
	if not PTCT_Owns() then
		rows[1] = { "L\203p l\183nh \174\222a ri\170ng", "PTCT_S_Found" }
		rows[2] = { "Gi\237i thi\214u l\183nh \174\222a", "PTCT_S_Intro" }
		rows[3] = { PTCT_TXT.exit, "PTCT_No" }
	else
		local n = 0
		n = n + 1 rows[n] = { "T\215nh h\215nh l\183nh \174\222a", "PTCT_S_Status" }
		if PTCT_D_On() then
			n = n + 1 rows[n] = { "Th\241 th\181nh: \174ang c\227 qu\169n c\171ng th\181nh!", "PTCT_S_Def" }
		end
		if GetTask(PTCT_BOSS_TASK) == 1 then
			n = n + 1 rows[n] = { PTCT_TXT.boss_row, "PTCT_B_Ask" }
		end
		n = n + 1 rows[n] = { "X\169y d\249ng c\171ng tr\215nh", "PTCT_S_Build" }
		n = n + 1 rows[n] = { "N\169ng c\202p c\171ng tr\215nh", "PTCT_S_BUp" }
		n = n + 1 rows[n] = { "N\169ng c\202p th\181nh th\222", "PTCT_S_Up" }
		if not PTCT_D_On() then
			n = n + 1 rows[n] = { "Th\241 th\181nh (b\182o v\214 l\183nh \174\222a)", "PTCT_S_Def" }
		end
		n = n + 1 rows[n] = { "Quy\170n g\227p (nh\203n c\232ng hi\213n)", "PTCT_S_Donate" }
		n = n + 1 rows[n] = { "Thu thu\213 l\183nh \174\222a h\171m nay", "PTCT_S_Tax" }
		n = n + 1 rows[n] = { "Nh\234 tr\185m d\222ch \174\173a th\173", "PTCT_S_Mail" }
		n = n + 1 rows[n] = { "Gi\237i thi\214u l\183nh \174\222a", "PTCT_S_Intro" }
		n = n + 1 rows[n] = { PTCT_TXT.exit, "PTCT_No" }
	end
	SayTask(PTCT_S_Head(), rows)
end

function PTCT_S_Intro()
	Talk(4, "PTCT_No",
		"L\183nh \174\222a ri\170ng: c\202p " .. PTCT_REG_LEVEL .. " tr\235 l\170n, n\233p " .. PTCT_REG_MONEY .. " l\173\238ng. L\183nh \174\222a c\227 4 c\202p th\181nh th\222; m\231i c\202p m\235 th\170m c\171ng tr\215nh.",
		"C\202p 1: \167i\214n Phong Th\199n (Kh\182o nghi\214m, Hoa th\199n b\221), Tr\185i l\221nh (l\221nh \174\184nh thu\170), S\169n luy\214n th\243 (Tr\245 ma), Ph\223ng chi\213n xa (X\221ch \167\229ng Th\182o). C\202p 2: Ph\223ng luy\214n thu\232c. C\202p 3: Thao tr\173\234ng. C\202p 4: H\253 vi\214n.",
		"N\169ng c\202p c\199n c\232ng hi\213n, s\232 l\199n nhi\214m v\244 l\221nh \174\184nh thu\170, t\181i nguy\170n (H\173\172ng li\214u t\245 Hoa th\199n b\221, G\231 t\245 Luy\214n ti\170n \174\172n) v\181 ng\169n l\173\238ng. C\171ng tr\215nh \174\248ng ngay b\170n c\185nh ta.",
		"M\231i c\171ng tr\215nh c\227 5 c\202p (t\232i \174a b\187ng c\202p th\181nh th\222 c\233ng 1), n\169ng b\187ng ng\169n l\173\238ng, X\221ch \174\229ng v\181 L\173\172ng th\182o. H\187ng ng\181y l\243c 12:30 v\181 20:30 qu\169n c\171ng th\181nh t\202n c\171ng; c\242ng c\227 th\211 khi\170u chi\213n ngay \174\211 th\241 th\181nh m\233t m\215nh.")
end

-- found -------------------------------------------------------------------------------------
function PTCT_S_Found()
	if PTCT_Owns() then return main() end
	if GetLevel() < PTCT_REG_LEVEL then
		PTCT_Say1("Ng\173\172i c\199n \174\185t c\202p <color=green>" .. PTCT_REG_LEVEL .. "<color> m\237i c\227 th\211 l\203p l\183nh \174\222a.")
		return
	end
	if GetCash() < PTCT_REG_MONEY then
		PTCT_Say1("L\203p l\183nh \174\222a c\199n <color=green>" .. PTCT_REG_MONEY .. "<color> l\173\238ng.")
		return
	end
	MsgBox("N\233p <color=green>" .. PTCT_REG_MONEY .. "<color> l\173\238ng \174\211 l\203p l\183nh \174\222a ri\170ng?", "PTCT_S_FoundOk", "PTCT_No")
end

function PTCT_S_FoundOk()
	if PTCT_Owns() or GetLevel() < PTCT_REG_LEVEL then return end
	if GetCash() < PTCT_REG_MONEY or Pay(PTCT_REG_MONEY) ~= 1 then
		PTCT_Say1("Ng\169n l\173\238ng kh\171ng \174\241.")
		return
	end
	SetTask(PTCT_T_OWN, 1)
	SetTask(PTCT_T_LEVEL, 1)
	SetTask(PTCT_T_REGDAY, PTCT_Today())
	PTCT_AddContri(PTCT_REG_CONTRI)
	Msg2Player("Ng\173\172i \174\183 l\203p " .. PTCT_CityName() .. " (Th\181nh th\222 c\202p 1), nh\203n " .. PTCT_REG_CONTRI .. " \174i\211m c\232ng hi\213n.")
	PTCT_Say1("Ch\243c m\245ng! L\183nh \174\222a \174\183 \174\173\238c l\203p. H\183y <color=green>x\169y d\249ng c\171ng tr\215nh<color> \174\211 nh\203n nhi\214m v\244 l\183nh \174\222a.")
end

-- status ------------------------------------------------------------------------------------
function PTCT_S_Status()
	local s = PTCT_CityName() .. " - " .. PTCT_TXT.lv .. PTCT_Level() .. "\n"
	s = s .. "C\232ng hi\213n: <color=green>" .. PTCT_Contri() .. "<color>, H\173ng th\222nh: <color=green>" .. GetTask(PTCT_T_HUNG) .. "<color>, L\221nh \174\184nh thu\170: <color=green>" .. PTCT_MercTotal() .. "<color> l\199n\n"
	local k = 1
	while k <= 4 do
		s = s .. PTCT_RESNAME[k] .. ": <color=green>" .. PTCT_Res(k) .. "<color>  "
		k = k + 1
	end
	s = s .. "\n"
	local i = 1
	while i <= PTCT_NB do
		local b = PTCT_B[i]
		if PTCT_Built(i) then
			s = s .. b.name .. ": <color=green>c\202p " .. PTCT_BLevel(i) .. "<color>; "
		else
			s = s .. b.name .. ": " .. PTCT_TXT.notyet .. " (c\202p " .. b.lvl .. "); "
		end
		i = i + 1
	end
	s = s .. "\nTh\241 th\181nh h\171m nay: " .. PTCT_DayN(PTCT_T_DEF) .. "/" .. PTCT_DEF_MAXDAY .. " l\199n th\173\235ng."
	Talk(1, "PTCT_No", s)
end

-- build -------------------------------------------------------------------------------------
function PTCT_S_Build()
	if not PTCT_Owns() then return end
	local rows = {}
	local n = 0
	local lock = ""
	local i = 1
	while i <= PTCT_NB do
		local b = PTCT_B[i]
		if not PTCT_Built(i) then
			if b.lvl <= PTCT_Level() then
				n = n + 1
				rows[n] = { b.name .. " (" .. b.cost .. " l\173\238ng)", "PTCT_S_B" .. i }
			else
				lock = lock .. b.name .. " (c\202p " .. b.lvl .. ") "
			end
		end
		i = i + 1
	end
	n = n + 1
	rows[n] = { PTCT_TXT.exit, "PTCT_No" }
	local head = "Ch\228n c\171ng tr\215nh mu\232n x\169y."
	if n == 1 then head = "M\228i c\171ng tr\215nh c\241a c\202p th\181nh th\222 hi\214n t\185i \174\183 x\169y xong." end
	if lock ~= "" then head = head .. "\nCh\173a m\235: " .. lock end
	SayTask(head, rows)
end

function PTCT_S_BuildAsk(id)
	local b = PTCT_B[id]
	if not b or PTCT_Built(id) or not PTCT_Owns() then return end
	MsgBox("X\169y <color=green>" .. b.name .. "<color> t\232n <color=green>" .. b.cost .. "<color> l\173\238ng?\n" .. b.desc, "PTCT_S_BOk" .. id, "PTCT_No")
end

function PTCT_S_BuildOk(id)
	local b = PTCT_B[id]
	if not b or PTCT_Built(id) or not PTCT_Owns() or b.lvl > PTCT_Level() then return end
	if GetCash() < b.cost or Pay(b.cost) ~= 1 then
		PTCT_Say1("Ng\169n l\173\238ng kh\171ng \174\241.")
		return
	end
	SetTask(PTCT_T_BLD0 + id, 1)
	Msg2Player("\167\183 x\169y xong " .. b.name .. " trong " .. PTCT_CityName() .. ".")
	PTCT_Say1("<color=green>" .. b.name .. "<color> \174\183 x\169y xong. C\171ng tr\215nh \174\248ng ngay c\185nh L\183nh \174\222a quan \235 T\169y K\250.")
end

function PTCT_S_B1() PTCT_S_BuildAsk(1) end
function PTCT_S_B2() PTCT_S_BuildAsk(2) end
function PTCT_S_B3() PTCT_S_BuildAsk(3) end
function PTCT_S_B4() PTCT_S_BuildAsk(4) end
function PTCT_S_B5() PTCT_S_BuildAsk(5) end
function PTCT_S_B6() PTCT_S_BuildAsk(6) end
function PTCT_S_B7() PTCT_S_BuildAsk(7) end
function PTCT_S_BOk1() PTCT_S_BuildOk(1) end
function PTCT_S_BOk2() PTCT_S_BuildOk(2) end
function PTCT_S_BOk3() PTCT_S_BuildOk(3) end
function PTCT_S_BOk4() PTCT_S_BuildOk(4) end
function PTCT_S_BOk5() PTCT_S_BuildOk(5) end
function PTCT_S_BOk6() PTCT_S_BuildOk(6) end
function PTCT_S_BOk7() PTCT_S_BuildOk(7) end

-- city level --------------------------------------------------------------------------------
-- returns missing-requirements text ("" = all met)
function PTCT_S_UpMissing(r)
	local m = ""
	if GetLevel() < r.plv then m = m .. "c\202p nh\169n v\203t " .. r.plv .. "; " end
	if PTCT_Contri() < r.contri then m = m .. "c\232ng hi\213n " .. PTCT_Contri() .. "/" .. r.contri .. "; " end
	if PTCT_MercTotal() < r.merc then m = m .. "l\221nh \174\184nh thu\170 " .. PTCT_MercTotal() .. "/" .. r.merc .. " l\199n; " end
	if PTCT_Res(1) < r.r1 then m = m .. PTCT_RESNAME[1] .. " " .. PTCT_Res(1) .. "/" .. r.r1 .. "; " end
	if PTCT_Res(2) < r.r2 then m = m .. PTCT_RESNAME[2] .. " " .. PTCT_Res(2) .. "/" .. r.r2 .. "; " end
	if GetCash() < r.money then m = m .. r.money .. " l\173\238ng; " end
	return m
end

function PTCT_S_Up()
	if not PTCT_Owns() then return end
	local l = PTCT_Level()
	if l >= 4 then
		PTCT_Say1("L\183nh \174\222a \174\183 \174\185t Th\181nh th\222 c\202p 4, c\202p cao nh\202t.")
		return
	end
	local r = PTCT_LV[l + 1]
	local need = "L\170n Th\181nh th\222 c\202p " .. (l + 1) .. " c\199n: c\202p nh\169n v\203t " .. r.plv .. ", c\232ng hi\213n " .. r.contri .. ", l\221nh \174\184nh thu\170 " .. r.merc .. " l\199n, " .. PTCT_RESNAME[1] .. " " .. r.r1 .. ", " .. PTCT_RESNAME[2] .. " " .. r.r2 .. ", " .. r.money .. " l\173\238ng (t\181i nguy\170n v\181 ng\169n l\173\238ng b\222 tr\245)."
	local m = PTCT_S_UpMissing(r)
	if m ~= "" then
		Talk(1, "PTCT_No", need .. "\nC\223n thi\213u: <color=red>" .. m .. "<color>")
		return
	end
	MsgBox(need .. "\nN\169ng c\202p ngay?", "PTCT_S_UpOk", "PTCT_No")
end

function PTCT_S_UpOk()
	if not PTCT_Owns() then return end
	local l = PTCT_Level()
	if l >= 4 then return end
	local r = PTCT_LV[l + 1]
	if PTCT_S_UpMissing(r) ~= "" then return PTCT_S_Up() end
	if Pay(r.money) ~= 1 then
		PTCT_Say1("Ng\169n l\173\238ng kh\171ng \174\241.")
		return
	end
	PTCT_AddRes(1, -r.r1)
	PTCT_AddRes(2, -r.r2)
	SetTask(PTCT_T_LEVEL, l + 1)
	Msg2Player(PTCT_CityName() .. " \174\183 l\170n Th\181nh th\222 c\202p " .. (l + 1) .. ".")
	PTCT_Say1("Ch\243c m\245ng! L\183nh \174\222a \174\183 l\170n <color=green>Th\181nh th\222 c\202p " .. (l + 1) .. "<color>, m\235 th\170m c\171ng tr\215nh v\181 nhi\214m v\244 l\221nh \174\184nh thu\170 c\202p cao h\172n.")
end

-- donation ----------------------------------------------------------------------------------
function PTCT_S_Donate()
	if not PTCT_Owns() then return end
	local left = PTCT_DONATE_MAX - PTCT_DayN(PTCT_T_DONATE)
	local rows = {}
	rows[1] = { "Quy\170n " .. PTCT_DONATE_UNIT .. " l\173\238ng (1 \174i\211m)", "PTCT_S_D1" }
	rows[2] = { "Quy\170n " .. (PTCT_DONATE_UNIT * 5) .. " l\173\238ng (5 \174i\211m)", "PTCT_S_D5" }
	rows[3] = { "Quy\170n " .. (PTCT_DONATE_UNIT * 10) .. " l\173\238ng (10 \174i\211m)", "PTCT_S_D10" }
	rows[4] = { PTCT_TXT.exit, "PTCT_No" }
	SayTask("Quy\170n g\227p ng\169n l\173\238ng cho l\183nh \174\222a \174\211 nh\203n \174i\211m c\232ng hi\213n. H\171m nay c\223n nh\203n \174\173\238c <color=green>" .. left .. "<color> \174i\211m.", rows)
end

function PTCT_S_DonateN(n)
	if not PTCT_Owns() then return end
	local done = PTCT_DayN(PTCT_T_DONATE)
	local left = PTCT_DONATE_MAX - done
	if n > left then
		PTCT_Say1("H\171m nay ch\216 c\223n nh\203n \174\173\238c <color=green>" .. left .. "<color> \174i\211m c\232ng hi\213n t\245 quy\170n g\227p.")
		return
	end
	local cost = n * PTCT_DONATE_UNIT
	if GetCash() < cost or Pay(cost) ~= 1 then
		PTCT_Say1("Ng\169n l\173\238ng kh\171ng \174\241.")
		return
	end
	PTCT_DaySet(PTCT_T_DONATE, done + n)
	PTCT_AddContri(n)
	PTCT_Say1("\167a t\185! Ng\173\172i nh\203n \174\173\238c <color=green>" .. n .. "<color> \174i\211m c\232ng hi\213n (hi\214n c\227 " .. PTCT_Contri() .. ").")
end
function PTCT_S_D1() PTCT_S_DonateN(1) end
function PTCT_S_D5() PTCT_S_DonateN(5) end
function PTCT_S_D10() PTCT_S_DonateN(10) end

-- tax ---------------------------------------------------------------------------------------
function PTCT_S_TaxValue()
	local h = GetTask(PTCT_T_HUNG)
	if h > 100 then h = 100 end
	return PTCT_TAX_BASE * PTCT_Level() + h * 500
end

function PTCT_S_Tax()
	if not PTCT_Owns() then return end
	if GetTask(PTCT_T_TAX) == PTCT_Today() then
		PTCT_Say1("H\171m nay ng\173\172i \174\183 thu thu\213 r\229i, ng\181y mai h\183y quay l\185i.")
		return
	end
	local v = PTCT_S_TaxValue()
	SetTask(PTCT_T_TAX, PTCT_Today())
	Earn(v)
	PTCT_Say1("Thu thu\213 l\183nh \174\222a h\171m nay: <color=green>" .. v .. "<color> l\173\238ng (theo c\202p th\181nh th\222 v\181 h\173ng th\222nh).")
end

-- courier for the mercenary letters (VNG task values 868/870/872/874, byte 3 bits 7 and 8) ----
PTCT_MAIL_TASKS = { 868, 870, 872, 874 }
function PTCT_S_MailNeed()
	local n = 0
	local i = 1
	while PTCT_MAIL_TASKS[i] do
		local v = GetTask(PTCT_MAIL_TASKS[i])
		if v ~= 0 then
			local f = GetByte(v, 3)
			if GetBit(f, 7) == 0 then n = n + 1 end
			if GetBit(f, 8) == 0 then n = n + 1 end
		end
		i = i + 1
	end
	return n
end

function PTCT_S_MailLeft()
	return PTCT_MAIL_MAX - PTCT_DayN(PTCT_T_MAIL)
end

function PTCT_S_Mail()
	if not PTCT_Owns() then return end
	local n = PTCT_S_MailNeed()
	if n == 0 then
		PTCT_Say1("Ng\173\172i kh\171ng c\227 th\173 l\221nh \174\184nh thu\170 n\181o c\199n \174\173a. Nh\203n nhi\214m v\244 <color=green>\167\173a tin<color> \235 Tr\185i l\221nh tr\173\237c.")
		return
	end
	if n > PTCT_S_MailLeft() then
		PTCT_Say1("H\171m nay tr\185m d\222ch ch\216 nh\203n th\170m <color=green>" .. PTCT_S_MailLeft() .. "<color> th\173.")
		return
	end
	MsgBox("Tr\185m d\222ch s\207 \174\173a <color=green>" .. n .. "<color> th\173 thay ng\173\172i, ph\221 <color=green>" .. (n * PTCT_MAIL_COST) .. "<color> l\173\238ng. V\203t ph\200m ph\182i mang v\210 v\201n c\199n t\249 t\215m.", "PTCT_S_MailOk", "PTCT_No")
end

function PTCT_S_MailOk()
	if not PTCT_Owns() then return end
	local n = PTCT_S_MailNeed()
	if n == 0 or n > PTCT_S_MailLeft() then return end
	if GetCash() < n * PTCT_MAIL_COST or Pay(n * PTCT_MAIL_COST) ~= 1 then
		PTCT_Say1("Ng\169n l\173\238ng kh\171ng \174\241.")
		return
	end
	local i = 1
	while PTCT_MAIL_TASKS[i] do
		local t = PTCT_MAIL_TASKS[i]
		local v = GetTask(t)
		if v ~= 0 then
			local f = SetBit(SetBit(GetByte(v, 3), 7, 1), 8, 1)
			SetTask(t, SetByte(v, 3, f))
		end
		i = i + 1
	end
	PTCT_DaySet(PTCT_T_MAIL, PTCT_DayN(PTCT_T_MAIL) + n)
	PTCT_Say1("Th\173 \174\183 \174\173\238c \174\173a \174\213n n\172i. H\183y mang \174\241 v\203t ph\200m v\210 Tr\185i l\221nh ph\244c m\214nh.")
end

-- building upgrades (congthanh2) -------------------------------------------------------------
-- returns missing-requirements text ("" = all met)
function PTCT_S_BUpMissing(id, l)
	local money, r3, r4, contri = PTCT_UpCost(id, l)
	local m = ""
	if PTCT_Contri() < contri then m = m .. "c\232ng hi\213n " .. PTCT_Contri() .. "/" .. contri .. "; " end
	if PTCT_Res(3) < r3 then m = m .. PTCT_RESNAME[3] .. " " .. PTCT_Res(3) .. "/" .. r3 .. "; " end
	if PTCT_Res(4) < r4 then m = m .. PTCT_RESNAME[4] .. " " .. PTCT_Res(4) .. "/" .. r4 .. "; " end
	if GetCash() < money then m = m .. money .. " l\173\238ng; " end
	return m
end

function PTCT_S_BUp()
	if not PTCT_Owns() then return end
	local rows = {}
	local n = 0
	local mx = PTCT_BMaxLv()
	local i = 1
	while i <= PTCT_NB do
		local l = PTCT_BLevel(i)
		if l > 0 and l < mx then
			n = n + 1
			rows[n] = { PTCT_B[i].name .. ": c\202p " .. l .. " l\170n " .. (l + 1), "PTCT_S_U" .. i }
		end
		i = i + 1
	end
	n = n + 1
	rows[n] = { PTCT_TXT.exit, "PTCT_No" }
	local head = "C\171ng tr\215nh l\170n c\202p t\232i \174a <color=green>" .. mx .. "<color> (c\202p th\181nh th\222 + 1, t\232i \174a " .. PTCT_BMAX .. "). Chi ph\221: ng\169n l\173\238ng, X\221ch \174\229ng (Ph\223ng chi\213n xa), L\173\172ng th\182o (S\169n luy\214n th\243); c\199n \174\241 c\232ng hi\213n."
	if n == 1 then head = head .. "\nKh\171ng c\227 c\171ng tr\215nh n\181o n\169ng \174\173\238c l\243c n\181y." end
	SayTask(head, rows)
end

function PTCT_S_UpAsk(id)
	local b = PTCT_B[id]
	local l = PTCT_BLevel(id)
	if not b or l < 1 or l >= PTCT_BMaxLv() or not PTCT_Owns() then return end
	local money, r3, r4, contri = PTCT_UpCost(id, l)
	local need = "N\169ng <color=green>" .. b.name .. "<color> l\170n c\202p " .. (l + 1) .. ": " .. money .. " l\173\238ng, " .. r3 .. " " .. PTCT_RESNAME[3] .. ", " .. r4 .. " " .. PTCT_RESNAME[4] .. " (c\199n " .. contri .. " c\232ng hi\213n).\nHi\214u qu\182: " .. PTCT_BEFF[id] .. "."
	local m = PTCT_S_BUpMissing(id, l)
	if m ~= "" then
		Talk(1, "PTCT_No", need .. "\nC\223n thi\213u: <color=red>" .. m .. "<color>")
		return
	end
	MsgBox(need, "PTCT_S_UOk" .. id, "PTCT_No")
end

function PTCT_S_UpDo(id)
	local b = PTCT_B[id]
	local l = PTCT_BLevel(id)
	if not b or l < 1 or l >= PTCT_BMaxLv() or not PTCT_Owns() then return end
	if PTCT_S_BUpMissing(id, l) ~= "" then return PTCT_S_UpAsk(id) end
	local money, r3, r4, contri = PTCT_UpCost(id, l)
	if Pay(money) ~= 1 then
		PTCT_Say1("Ng\169n l\173\238ng kh\171ng \174\241.")
		return
	end
	PTCT_AddRes(3, -r3)
	PTCT_AddRes(4, -r4)
	SetTask(PTCT_T_BLD0 + id, l + 1)
	Msg2Player(b.name .. " c\241a " .. PTCT_CityName() .. " \174\183 l\170n c\202p " .. (l + 1) .. ".")
	PTCT_Say1("<color=green>" .. b.name .. "<color> \174\183 l\170n c\202p " .. (l + 1) .. ". " .. PTCT_BEFF[id] .. ".")
end

function PTCT_S_U1() PTCT_S_UpAsk(1) end
function PTCT_S_U2() PTCT_S_UpAsk(2) end
function PTCT_S_U3() PTCT_S_UpAsk(3) end
function PTCT_S_U4() PTCT_S_UpAsk(4) end
function PTCT_S_U5() PTCT_S_UpAsk(5) end
function PTCT_S_U6() PTCT_S_UpAsk(6) end
function PTCT_S_U7() PTCT_S_UpAsk(7) end
function PTCT_S_UOk1() PTCT_S_UpDo(1) end
function PTCT_S_UOk2() PTCT_S_UpDo(2) end
function PTCT_S_UOk3() PTCT_S_UpDo(3) end
function PTCT_S_UOk4() PTCT_S_UpDo(4) end
function PTCT_S_UOk5() PTCT_S_UpDo(5) end
function PTCT_S_UOk6() PTCT_S_UpDo(6) end
function PTCT_S_UOk7() PTCT_S_UpDo(7) end

-- city defence (congthanh2, ct_def.lua) ------------------------------------------------------
function PTCT_S_Def()
	if not PTCT_Owns() then return end
	local rows = {}
	local n = 0
	local head = "<color=yellow>Th\241 th\181nh<color>: " .. PTCT_D_Status() .. "\nL\222ch: h\187ng ng\181y 12:30 v\181 20:30 (t\203p h\238p " .. PTCT_DEF_GATHER .. " ph\243t), " .. PTCT_DEF_WAVES .. " \174\238t, m\231i \174\238t " .. PTCT_DEF_WAVE_MIN .. " ph\243t. Th\173\235ng h\171m nay c\223n " .. (PTCT_DEF_MAXDAY - PTCT_DayN(PTCT_T_DEF)) .. " l\199n. Thua: H\173ng th\222nh -1."
	if PTCT_D_On() then
		n = n + 1 rows[n] = { "Tham gia th\241 th\181nh", "PTCT_S_DefJoin" }
	else
		n = n + 1 rows[n] = { "Khi\170u chi\213n ngay (qu\169n c\171ng th\181nh t\202n c\171ng)", "PTCT_S_DefNow" }
	end
	n = n + 1 rows[n] = { PTCT_TXT.exit, "PTCT_No" }
	SayTask(head, rows)
end

function PTCT_S_DefJoin()
	if not PTCT_Owns() then return end
	local r = PTCT_D_Join()
	if r == 0 then
		PTCT_Say1("Hi\214n kh\171ng c\227 tr\203n th\241 th\181nh n\181o.")
	elseif r < 0 then
		PTCT_Say1("\167\183 \174\241 " .. PTCT_DEF_SLOTS .. " l\183nh ch\243a th\241 th\181nh.")
	else
		PTCT_Say1("Ng\173\172i \174\183 v\181o tr\203n th\241 th\181nh (\174\183 b\203t chi\213n \174\202u). " .. PTCT_D_Status() .. " \167\245ng r\234i T\169y K\250!")
	end
end

function PTCT_S_DefNow()
	if not PTCT_Owns() then return end
	if PTCT_D_On() then return PTCT_S_DefJoin() end
	if GetLevel() < PTCT_REG_LEVEL then return end
	MsgBox("G\228i qu\169n c\171ng th\181nh t\202n c\171ng l\183nh \174\222a ngay? " .. PTCT_DEF_WAVES .. " \174\238t qu\169n theo c\202p c\241a ng\173\172i s\207 xu\202t hi\214n quanh d\183y c\171ng tr\215nh; h\233 v\214 l\183nh \174\222a s\207 gi\243p s\248c. Thua s\207 m\202t 1 H\173ng th\222nh.", "PTCT_S_DefNowOk", "PTCT_No")
end

function PTCT_S_DefNowOk()
	if not PTCT_Owns() or PTCT_D_On() then return PTCT_S_DefJoin() end
	if not PTCT_D_Start(2) then return end
	PTCT_D_Join()
	local n = PTCT_D_NextWave()
	if n <= 0 then
		PTCT_D_End(3)
		PTCT_Say1("Qu\169n c\171ng th\181nh kh\171ng xu\202t hi\214n \174\173\238c, h\183y th\246 l\185i sau.")
		return
	end
	CloseDialog()
end
