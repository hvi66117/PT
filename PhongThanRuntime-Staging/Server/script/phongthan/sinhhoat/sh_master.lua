-- Phong Than 2026-10-03 (sinhhoat): Sinh Hoat Su (life skill teacher) in Tay Ky, Trieu Ca and the 3 newbie
-- villages (VNG \script\<city>\sheng_huo_ji_neng_lao_shi scripts are missing). Spawned by script\phongthan\ext\sinhhoat.lua.
-- Menu: first-time quests (taskinfo 1200 herbs, 1201 ore, 1202 fishing), teach the two life skill books
-- (62 Ban Co Khai Thien, 128 Ban Mon Long Phu), alchemy / cooking / crystal smelting, daily orders, Ton Su
-- (taskinfo 1509-1513, raises the skill cap 9 -> 10), skill sheet.
Include("\\script\\phongthan\\sinhhoat\\sh_lib.lua")

PTSH_HEAD = "<color=green>Sinh Ho\185t S\173<color>: "

-- first-time quests: { taskinfo id, task var, material (genre 3), title, skill }
PTSH_Q = {}
PTSH_Q[1] = { 1200, PTSH_T_Q1200, 910, "L\199n \167\199u H\184i Thu\232c", 1, "B\185ch Tr\181" }
PTSH_Q[2] = { 1201, PTSH_T_Q1201, 928, "L\199n \167\199u Khai Kho\184ng", 2, "Ho\181ng \174\229ng" }
PTSH_Q[3] = { 1202, PTSH_T_Q1202, 944, "L\199n \167\199u C\169u C\184", 3, "T\171m xanh" }
PTSH_Q_WHERE = { "b\244i th\182o d\173\238c \235 S\239ng Th\181nh d\183 ngo\185i, Ch\169n n\243i C\171n L\171n, Mi\170u C\173\172ng, K\250 S\172n",
	"m\185ch kho\184ng \235 Y\213n S\172n, C\249 L\233c, Th\241 D\173\172ng s\172n", "\174i\211m c\169u c\184 \235 B\190c H\182i, M\185nh T\169n, \167\171ng H\182i Th\241y V\249c" }
-- Ton Su: { taskinfo id, title, material type, id offset }
PTSH_TS = {}
PTSH_TS[1] = { 1510, "Thu Th\203p T\171n S\173", 1, 0, "th\182o d\173\238c" }
PTSH_TS[2] = { 1509, "Khai Kho\184ng T\171n S\173", 2, 0, "kho\184ng th\185ch" }
PTSH_TS[3] = { 1511, "\167i\213u Ng\173 T\171n S\173", 3, 0, "c\184" }
PTSH_TS[4] = { 1512, "Luy\214n \167\172n T\171n S\173", 1, 46, "tinh hoa th\182o d\173\238c" }
PTSH_TS[5] = { 1513, "H\225a Tr\239 T\171n S\173", 3, 28, "th\222t c\184" }
PTSH_TS_CASH = 500000
PTSH_TS_NEED = 10
-- recipes: sk skill, lv level, a / b inputs { type, id offset, tier from, tier to, count }, out { g, d, p, n }
PTSH_REC = {}
local r = {}
r = { sk = 4, lv = 1, name = "Ti\211u H\229ng \167\172n x5", a = { 1, 46, 1, 3, 1 }, out = { 1, 0, 0, 5 } } PTSH_REC[1] = r
r = { sk = 4, lv = 1, name = "Ti\211u Ho\181n \167\172n x5", a = { 1, 46, 1, 3, 1 }, out = { 1, 3, 0, 5 } } PTSH_REC[2] = r
r = { sk = 4, lv = 4, name = "Trung H\229ng \167\172n x5", a = { 1, 46, 4, 6, 1 }, out = { 1, 1, 0, 5 } } PTSH_REC[3] = r
r = { sk = 4, lv = 4, name = "Trung Ho\181n \167\172n x5", a = { 1, 46, 4, 6, 1 }, out = { 1, 4, 0, 5 } } PTSH_REC[4] = r
r = { sk = 4, lv = 7, name = "\167\185i H\229ng \167\172n x5", a = { 1, 46, 7, 10, 1 }, out = { 1, 2, 0, 5 } } PTSH_REC[5] = r
r = { sk = 4, lv = 7, name = "\167\185i Ho\181n \167\172n x5", a = { 1, 46, 7, 10, 1 }, out = { 1, 5, 0, 5 } } PTSH_REC[6] = r
r = { sk = 4, lv = 2, name = "Linh Th\243 \167\172n", a = { 1, 46, 1, 10, 1 }, b = { 3, 28, 1, 10, 1 }, out = { 6, PTLT_I_DON, 0, 1 } } PTSH_REC[7] = r
r = { sk = 5, lv = 3, name = "Canh d\173\236ng linh th\243 (2 Linh Th\243 \167\172n)", a = { 3, 28, 1, 10, 2 }, out = { 6, PTLT_I_DON, 0, 2 } } PTSH_REC[8] = r
r = { sk = 5, lv = 1, name = "M\169m c\231 (\174\230i kinh nghi\214m)", a = { 3, 28, 1, 10, 5 }, out = { 0, 0, 0, 0 } } PTSH_REC[9] = r

function main()
	local t = PTSH_HEAD .. "K\252 n\168ng s\232ng g\229m thu th\203p (h\184i thu\232c, khai kho\184ng, c\169u c\184) v\181 ch\213 t\184c (luy\214n \174\172n, h\225a tr\239). Ng\173\172i mu\232n l\181m g\215?"
	Say(t, 8,
		"Nhi\214m v\244 sinh ho\185t/PTSH_QMenu",
		"H\228c k\252 n\168ng s\232ng/PTSH_TeachMenu",
		"Luy\214n \174\172n, h\225a tr\239/PTSH_CraftMenu",
		"Ch\213 luy\214n Th\241y Tinh Nguy\170n Th\185ch/PTSH_Crystal",
		"\167\172n \174\198t h\181ng h\187ng ng\181y/PTSH_Order",
		"Th\168ng c\202p T\171n S\173/PTSH_TonSuMenu",
		"Xem k\252 n\168ng s\232ng/PTSH_Sheet",
		"\167\227ng/PTSH_No")
end

function PTSH_Sheet()
	local s = PTSH_HEAD .. "K\252 n\168ng s\232ng c\241a ng\173\172i:"
	local k = 1
	while k <= 5 do
		local lv = PTSH_SkillLevel(k)
		s = s .. "\n" .. PTSH_SKILL_NAME[k] .. ": c\202p " .. lv .. "/" .. PTSH_SkillCap(k) .. " (" .. PTSH_SkillExp(k) .. " \174i\211m)"
		k = k + 1
	end
	local b1, b2 = "ch\173a", "ch\173a"
	if PTSH_HasBook(PTSH_BOOK_GATHER) == 1 then b1 = "\174\183" end
	if PTSH_HasBook(PTSH_BOOK_CRAFT) == 1 then b2 = "\174\183" end
	s = s .. "\nB\181n C\230 Khai Thi\170n: " .. b1 .. " l\220nh h\233i. Ban M\171n L\233ng Ph\241: " .. b2 .. " l\220nh h\233i."
	Say(s, 1, "\167\227ng/PTSH_No")
end

-- quests ---------------------------------------------------------------------------------------------------
function PTSH_QMenu()
	local t = { PTSH_HEAD .. "Ta c\227 v\181i vi\214c nh\225 \174\211 ng\173\172i l\181m quen v\237i k\252 n\168ng s\232ng.", 0 }
	local n = 0
	local i = 1
	while i <= 3 do
		local q = PTSH_Q[i]
		local st = GetTask(q[2])
		if st == 0 then
			n = n + 1 t[n + 2] = "Nh\203n: " .. q[4] .. "/PTSH_QA" .. i
		elseif st == 1 then
			n = n + 1 t[n + 2] = "Giao: " .. q[4] .. "/PTSH_QD" .. i
		end
		i = i + 1
	end
	if n == 0 then
		Say(PTSH_HEAD .. "Ng\173\172i \174\183 ho\181n th\181nh m\228i nhi\214m v\244 nh\203p m\171n. H\183y r\204n k\252 n\168ng l\170n c\202p 9 r\229i t\215m ta th\168ng c\202p T\171n S\173.", 1, "\167\227ng/PTSH_No")
		return
	end
	n = n + 1 t[n + 2] = "\167\227ng/PTSH_No"
	t[2] = n
	call(Say, t)
end

function PTSH_QAccept(i)
	local q = PTSH_Q[i]
	if GetTask(q[2]) ~= 0 then return end
	SetTask(q[2], 1)
	local txt = "Mang v\210 1 " .. q[6] .. " cho Sinh Ho\185t S\173. T\215m " .. PTSH_Q_WHERE[i] .. "."
	if i == 2 and PTSH_HasBook(PTSH_BOOK_GATHER) == 0 then txt = txt .. " C\199n l\220nh h\233i B\181n C\230 Khai Thi\170n tr\173\237c." end
	PTSH_Note(q[1], q[4], txt, 1)
	Say(PTSH_HEAD .. txt, 1, "\167\183 hi\211u/PTSH_No")
end

function PTSH_QDeliver(i)
	local q = PTSH_Q[i]
	if GetTask(q[2]) ~= 1 then return end
	local list = { { 3, q[3], 0, 1 } }
	local r = PTSH_TakeAll(list)
	if r ~= 1 then
		Say(PTSH_HEAD .. "Ng\173\172i ch\173a mang " .. q[6] .. " theo trong h\181nh trang.", 1, "\167\227ng/PTSH_No")
		return
	end
	SetTask(q[2], 2)
	AddOwnExp(3000)
	Earn(1000)
	PTSH_AddSkillExp(q[5], 10)
	PTSH_Note(q[1], q[4], "Ho\181n th\181nh", 2)
	Say(PTSH_HEAD .. "T\232t l\190m! Th\173\235ng 3000 kinh nghi\214m, 1000 l\173\238ng v\181 10 \174i\211m k\252 n\168ng " .. PTSH_SKILL_NAME[q[5]] .. ".", 1, "\167\227ng/PTSH_No")
end

function PTSH_QA1() PTSH_QAccept(1) end
function PTSH_QA2() PTSH_QAccept(2) end
function PTSH_QA3() PTSH_QAccept(3) end
function PTSH_QD1() PTSH_QDeliver(1) end
function PTSH_QD2() PTSH_QDeliver(2) end
function PTSH_QD3() PTSH_QDeliver(3) end

-- life skill books ------------------------------------------------------------------------------------------
function PTSH_TeachMenu()
	Say(PTSH_HEAD .. "B\181n C\230 Khai Thi\170n c\199n \174\211 khai kho\184ng, Ban M\171n L\233ng Ph\241 c\199n \174\211 luy\214n \174\172n v\181 h\225a tr\239. M\231i k\252 n\168ng ta d\185y v\237i gi\184 " .. PTSH_TEACH_FEE .. " l\173\238ng (c\242ng c\227 th\211 h\228c b\187ng b\221 k\221p \235 V\226 s\173).", 3,
		"H\228c B\181n C\230 Khai Thi\170n/PTSH_Teach1",
		"H\228c Ban M\171n L\233ng Ph\241/PTSH_Teach2",
		"\167\227ng/PTSH_No")
end

function PTSH_TeachOne(id, name)
	local r = PTSH_Teach(id)
	if r == 1 then
		Say(PTSH_HEAD .. "Ng\173\172i \174\183 l\220nh h\233i " .. name .. ".", 1, "\167\227ng/PTSH_No")
	elseif r == -2 then
		Say(PTSH_HEAD .. "Ng\173\172i kh\171ng \174\241 " .. PTSH_TEACH_FEE .. " l\173\238ng.", 1, "\167\227ng/PTSH_No")
	else
		Say(PTSH_HEAD .. "M\184y ch\241 ch\173a c\227 d\247 li\214u k\252 n\168ng n\181y, kh\171ng d\185y \174\173\238c.", 1, "\167\227ng/PTSH_No")
	end
end

function PTSH_Teach1() PTSH_TeachOne(PTSH_BOOK_GATHER, "B\181n C\230 Khai Thi\170n") end
function PTSH_Teach2() PTSH_TeachOne(PTSH_BOOK_CRAFT, "Ban M\171n L\233ng Ph\241") end

-- crafting -----------------------------------------------------------------------------------------------------
function PTSH_CraftMenu()
	if PTSH_HasBook(PTSH_BOOK_CRAFT) == 0 then
		Say(PTSH_HEAD .. "Mu\232n luy\214n \174\172n, h\225a tr\239 ph\182i l\220nh h\233i <color=yellow>Ban M\171n L\233ng Ph\241<color> tr\173\237c.", 2, "H\228c Ban M\171n L\233ng Ph\241/PTSH_Teach2", "\167\227ng/PTSH_No")
		return
	end
	local t = { PTSH_HEAD .. "Luy\214n \174\172n c\202p " .. PTSH_SkillLevel(4) .. ", h\225a tr\239 c\202p " .. PTSH_SkillLevel(5) .. ". Ch\228n c\171ng th\248c (nguy\170n li\214u ph\182i \174\211 trong h\181nh trang):", 0 }
	local n = 2
	t[3] = "Tinh luy\214n th\182o d\173\238c (2 c\239ng lo\185i -> 1 tinh hoa)/PTSH_Refine"
	t[4] = "S\172 ch\213 c\184 (2 c\239ng lo\185i -> 1 th\222t)/PTSH_Clean"
	local i = 1
	while PTSH_REC[i] do
		n = n + 1
		t[n + 2] = PTSH_REC[i].name .. " [" .. PTSH_SKILL_NAME[PTSH_REC[i].sk] .. " " .. PTSH_REC[i].lv .. "]/PTSH_C" .. i
		i = i + 1
	end
	n = n + 1 t[n + 2] = "\167\227ng/PTSH_No"
	t[2] = n
	call(Say, t)
end

-- 2 of the same raw material (first..last) -> 1 product (id + off); skill k must reach the material tier
function PTSH_Convert(k, typ, off, title)
	if PTSH_HasBook(PTSH_BOOK_CRAFT) == 0 then return end
	if PTSH_Free() < 1 then
		Say(PTSH_HEAD .. "H\181nh trang \174\183 \174\199y.", 1, "\167\227ng/PTSH_No")
		return
	end
	local lv = PTSH_SkillLevel(k)
	local t = 1
	while t <= lv do
		local ids = PTSH_MAT[typ][t]
		local j = 1
		while ids[j] do
			if PTSH_Count(3, ids[j], 0) >= 2 then
				if PTSH_Take(3, ids[j], 0, 2) == 2 then
					PTSH_Give(3, ids[j] + off, 0, 1)
					PTSH_AddSkillExp(k, 2 + floor(t / 2))
					Say(PTSH_HEAD .. title .. " th\181nh c\171ng (nguy\170n li\214u c\202p " .. t .. ").", 2, "L\181m ti\213p/PTSH_" .. (k == 4 and "Refine" or "Clean"), "\167\227ng/PTSH_No")
					return
				end
				Say(PTSH_HEAD .. "Nguy\170n li\214u ph\182i \174\211 trong h\181nh trang.", 1, "\167\227ng/PTSH_No")
				return
			end
			j = j + 1
		end
		t = t + 1
	end
	Say(PTSH_HEAD .. "Kh\171ng c\227 2 nguy\170n li\214u c\239ng lo\185i h\238p v\237i c\202p k\252 n\168ng (c\202p " .. lv .. ") trong h\181nh trang.", 1, "\167\227ng/PTSH_No")
end

function PTSH_Refine() PTSH_Convert(4, 1, 46, "Tinh luy\214n") end
function PTSH_Clean() PTSH_Convert(5, 3, 28, "S\172 ch\213") end

function PTSH_Craft(i)
	local r = PTSH_REC[i]
	if r == nil or PTSH_HasBook(PTSH_BOOK_CRAFT) == 0 then return end
	local lv = PTSH_SkillLevel(r.sk)
	if lv < r.lv then
		Say(PTSH_HEAD .. "C\199n " .. PTSH_SKILL_NAME[r.sk] .. " c\202p " .. r.lv .. " (hi\214n c\202p " .. lv .. ").", 1, "\167\227ng/PTSH_No")
		return
	end
	if PTSH_Free() < 2 then
		Say(PTSH_HEAD .. "C\199n 2 \171 tr\232ng trong h\181nh trang.", 1, "\167\227ng/PTSH_No")
		return
	end
	if PTSH_TierCount(r.a) < r.a[5] or (r.b and PTSH_TierCount(r.b) < r.b[5]) then
		Say(PTSH_HEAD .. "Kh\171ng \174\241 nguy\170n li\214u trong h\181nh trang.", 1, "\167\227ng/PTSH_No")
		return
	end
	if PTSH_TierTake(r.a) ~= 1 then
		Say(PTSH_HEAD .. "Nguy\170n li\214u ph\182i \174\211 trong h\181nh trang.", 1, "\167\227ng/PTSH_No")
		return
	end
	local takenA = PTSH_LAST_TAKEN
	if r.b and PTSH_TierTake(r.b) ~= 1 then
		PTSH_GiveBack(takenA)
		Say(PTSH_HEAD .. "Nguy\170n li\214u ph\182i \174\211 trong h\181nh trang (\174\183 tr\182 l\185i ph\199n \174\199u ti\170n).", 1, "\167\227ng/PTSH_No")
		return
	end
	local o = r.out
	local msg = ""
	if o[1] == 0 then
		local e = GetLevel() * 200 * lv
		AddOwnExp(e)
		msg = "Nh\203n " .. e .. " kinh nghi\214m."
	else
		local got = PTSH_Give(o[1], o[2], o[3], o[4])
		msg = "Nh\203n " .. got .. " " .. r.name .. "."
	end
	PTSH_AddSkillExp(r.sk, 3)
	Say(PTSH_HEAD .. "Ch\213 t\184c th\181nh c\171ng. " .. msg, 2, "L\181m ti\213p/PTSH_C" .. i, "\167\227ng/PTSH_No")
end

function PTSH_C1() PTSH_Craft(1) end
function PTSH_C2() PTSH_Craft(2) end
function PTSH_C3() PTSH_Craft(3) end
function PTSH_C4() PTSH_Craft(4) end
function PTSH_C5() PTSH_Craft(5) end
function PTSH_C6() PTSH_Craft(6) end
function PTSH_C7() PTSH_Craft(7) end
function PTSH_C8() PTSH_Craft(8) end
function PTSH_C9() PTSH_Craft(9) end

-- crystal smelting: 1 Thuy Tinh Nguyen Thach -> 1 manh thuy tinh (needs Khai khoang 4)
function PTSH_Crystal()
	if PTSH_SkillLevel(2) < 4 then
		Say(PTSH_HEAD .. "Ch\213 luy\214n th\241y tinh c\199n Khai kho\184ng c\202p 4.", 1, "\167\227ng/PTSH_No")
		return
	end
	local i = 1
	while PTSH_CRYSTAL[i] do
		local c = PTSH_CRYSTAL[i]
		if PTSH_Count(3, c[1], 0) >= 1 then
			if PTSH_Take(3, c[1], 0, 1) == 1 then
				PTSH_Give(3, c[2], 0, 1)
				PTSH_AddSkillExp(2, 3)
				Say(PTSH_HEAD .. "Ch\213 luy\214n th\181nh c\171ng m\233t m\182nh th\241y tinh.", 2, "L\181m ti\213p/PTSH_Crystal", "\167\227ng/PTSH_No")
				return
			end
		end
		i = i + 1
	end
	Say(PTSH_HEAD .. "Kh\171ng c\227 Th\241y Tinh Nguy\170n Th\185ch trong h\181nh trang (\174\181o \174\173\238c khi khai kho\184ng t\245 c\202p 4).", 1, "\167\227ng/PTSH_No")
end

-- daily orders: 1 = 10 herbs, 2 = 10 ores, 3 = 10 fish (any tier)
function PTSH_Order()
	local d = PTSH_Day()
	if GetTask(PTSH_T_ODAY) ~= d then
		SetTask(PTSH_T_ODAY, d)
		SetTask(PTSH_T_ON, 0)
	end
	local done = GetTask(PTSH_T_ON)
	if done >= 3 then
		Say(PTSH_HEAD .. "H\171m nay ng\173\172i \174\183 giao \174\241 3 \174\172n h\181ng. Mai h\183y quay l\185i.", 1, "\167\227ng/PTSH_No")
		return
	end
	local k = done + 1
	local names = { "10 th\182o d\173\238c", "10 kho\184ng th\185ch", "10 c\184" }
	Say(PTSH_HEAD .. "\167\172n h\181ng th\248 " .. k .. "/3 h\171m nay: giao <color=yellow>" .. names[k] .. "<color> (lo\185i n\181o c\242ng \174\173\238c).", 2, "Giao h\181ng/PTSH_OrderDo", "\167\227ng/PTSH_No")
end

function PTSH_OrderDo()
	local d = PTSH_Day()
	if GetTask(PTSH_T_ODAY) ~= d then return end
	local done = GetTask(PTSH_T_ON)
	if done >= 3 then return end
	local k = done + 1
	local q = { k, 0, 1, 10, 10 }
	local r = PTSH_TierTake(q)
	if r ~= 1 then
		Say(PTSH_HEAD .. "Ng\173\172i ch\173a \174\241 h\181ng trong h\181nh trang.", 1, "\167\227ng/PTSH_No")
		return
	end
	SetTask(PTSH_T_ON, k)
	local lv = GetLevel()
	local e = lv * lv * 12 + 5000
	AddOwnExp(e)
	Earn(lv * 200)
	PTSH_AddSkillExp(k, 5)
	local extra = ""
	if PTSH_Rand(1, 100) <= 30 and PTSH_Give(6, PTLT_I_DON, 0, 1) > 0 then extra = " T\198ng th\170m 1 Linh Th\243 \167\172n." end
	Say(PTSH_HEAD .. "\167a t\185! Th\173\235ng " .. e .. " kinh nghi\214m v\181 " .. (lv * 200) .. " l\173\238ng." .. extra, 1, "\167\227ng/PTSH_No")
end

-- Ton Su -----------------------------------------------------------------------------------------------------
function PTSH_TonSuMenu()
	local t = { PTSH_HEAD .. "K\252 n\168ng \174\185t c\202p 9 c\227 th\211 th\168ng c\202p T\171n S\173 (m\235 c\202p 10): n\233p " .. PTSH_TS_NEED .. " nguy\170n li\214u c\202p 8 tr\235 l\170n c\241a k\252 n\168ng \174\227 v\181 " .. PTSH_TS_CASH .. " l\173\238ng.", 0 }
	local n = 0
	local k = 1
	while k <= 5 do
		if PTSH_Digit(GetTask(PTSH_T_TONSU), k) == 0 then
			n = n + 1 t[n + 2] = PTSH_TS[k][2] .. " (c\202p hi\214n t\185i " .. PTSH_SkillLevel(k) .. ")/PTSH_TS" .. k
		end
		k = k + 1
	end
	if n == 0 then
		Say(PTSH_HEAD .. "Ng\173\172i \174\183 l\181 T\171n S\173 c\241a c\182 n\168m k\252 n\168ng s\232ng!", 1, "\167\227ng/PTSH_No")
		return
	end
	n = n + 1 t[n + 2] = "\167\227ng/PTSH_No"
	t[2] = n
	call(Say, t)
end

function PTSH_TonSu(k)
	local ts = PTSH_TS[k]
	if PTSH_Digit(GetTask(PTSH_T_TONSU), k) == 1 then return end
	if PTSH_SkillLevel(k) < 9 then
		PTSH_Note(ts[1], ts[2], "R\204n " .. PTSH_SKILL_NAME[k] .. " l\170n c\202p 9 r\229i t\215m Sinh Ho\185t S\173.", 1)
		Say(PTSH_HEAD .. PTSH_SKILL_NAME[k] .. " ph\182i \174\185t c\202p 9.", 1, "\167\227ng/PTSH_No")
		return
	end
	local q = { ts[3], ts[4], 8, 10, PTSH_TS_NEED }
	if PTSH_TierCount(q) < PTSH_TS_NEED or GetCash() < PTSH_TS_CASH then
		PTSH_Note(ts[1], ts[2], "N\233p " .. PTSH_TS_NEED .. " " .. ts[5] .. " c\202p 8 tr\235 l\170n v\181 " .. PTSH_TS_CASH .. " l\173\238ng cho Sinh Ho\185t S\173.", 1)
		Say(PTSH_HEAD .. "C\199n " .. PTSH_TS_NEED .. " " .. ts[5] .. " c\202p 8 tr\235 l\170n trong h\181nh trang v\181 " .. PTSH_TS_CASH .. " l\173\238ng.", 1, "\167\227ng/PTSH_No")
		return
	end
	if PTSH_TierTake(q) ~= 1 then
		Say(PTSH_HEAD .. "Nguy\170n li\214u ph\182i \174\211 trong h\181nh trang.", 1, "\167\227ng/PTSH_No")
		return
	end
	if Pay(PTSH_TS_CASH) ~= 1 then
		PTSH_GiveBack(PTSH_LAST_TAKEN)
		Say(PTSH_HEAD .. "Ng\173\172i kh\171ng \174\241 ng\169n l\173\238ng.", 1, "\167\227ng/PTSH_No")
		return
	end
	SetTask(PTSH_T_TONSU, PTSH_SetDigit(GetTask(PTSH_T_TONSU), k, 1))
	PTSH_Note(ts[1], ts[2], "Ho\181n th\181nh", 2)
	AddOwnExp(GetLevel() * GetLevel() * 50)
	Say(PTSH_HEAD .. "Ch\243c m\245ng ng\173\172i tr\235 th\181nh <color=yellow>" .. ts[2] .. "<color>! " .. PTSH_SKILL_NAME[k] .. " c\227 th\211 l\170n c\202p 10.", 1, "\167\227ng/PTSH_No")
end

function PTSH_TS1() PTSH_TonSu(1) end
function PTSH_TS2() PTSH_TonSu(2) end
function PTSH_TS3() PTSH_TonSu(3) end
function PTSH_TS4() PTSH_TonSu(4) end
function PTSH_TS5() PTSH_TonSu(5) end
