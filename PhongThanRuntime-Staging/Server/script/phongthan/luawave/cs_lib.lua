-- Phong Than 2026-10-05 (luawave #6): Chuyen sinh (VNG "xian mo zhuan sheng"). No main() here: dofile'd at call
-- time into the state of the NPC scripts Xich Tinh Tu (npc_fix\1003_xich_tinh_tu.lua, Tien gioi), Cao Minh
-- (npc_fix\1004_cao_minh.lua, Ma gioi) and the 5 "Chuyen Sinh Lao Lao" of the cities (npc_restore\*.lua).
-- VNG sources (PAK): string table 6f91bd22 - Xich Tinh Tu / Cao Minh are the "jie yin ren" (level 121 + 5000
-- reputation of the side, "zhuan sheng hou huo de 20 dian qian neng dian"); serverlist.pak
-- \settings\npc\player\zhuan_sheng_chu_shi_shu_xing_she_ding.ini (47742f27: MAXREBIRTHTIMES=3, +50/+20/+20 to each
-- base attribute for rebirth 1/2/3) and 62e777bc (new base attributes per class after rebirth, NewBirthPoint=20);
-- vng00.pak skills ini (NewBirthSkill=1 + PlayerLevel 60/120 on 1478-1526: the level is counted again after the
-- rebirth) and the level tables (newbirthexp column) - so VNG starts the level again from 1.
-- Rules here: level >= PTCS_LV[n] (VNG 121), at most 3 times; AddTranslife(1); SetLevel(1); every skill and the
-- unspent skill points are kept; the four base attributes become the VNG class values + the rebirth bonus; free
-- points = 20 (VNG) + the bonus points the character had beyond the 5 per level (items / quests), so nothing paid
-- is lost. The VNG side reputation (5000) does not exist on this server and is not asked.
-- Tasks 2800 (side 1 Tien / 2 Ma), 2801 (level before the last rebirth), 2802 (yyyymmdd); 2252 (Tien Ma gioi
-- faction of tienma) is only read. Every rebirth writes a before/after line to admin_bridge\chuyensinh.log
-- (level, exp, attributes, points, skills) so an admin can rebuild a character by hand. ASCII only.

PTCS_T_SIDE = 2800
PTCS_T_PRELV = 2801
PTCS_T_DATE = 2802
PTCS_T_TMPHE = 2252
PTCS_MAX = 3
PTCS_LV = { 121, 121, 121 }
PTCS_POINT = 20
PTCS_BONUS = { 50, 20, 20 }
PTCS_LVPOINT = 5
PTCS_BASE = { [0] = { 350, 200, 300, 150 }, [1] = { 250, 150, 200, 400 }, [2] = { 300, 200, 250, 250 } }
PTCS_SKMAX = 2000
PTCS_LOG = "admin_bridge\\chuyensinh.log"
if not PTCS_PICK then PTCS_PICK = {} end

PTCS_HEAD = "<color=yellow>Chuy\211n sinh<color>: "

function PTCS_No()
	CloseDialog()
end

function PTCS_Log(s)
	local h = openfile(PTCS_LOG, "a")
	if h then
		write(h, date("%Y-%m-%d %H:%M:%S ") .. s .. "\n")
		closefile(h)
	end
end

function PTCS_TL()
	if GetTranslife then return GetTranslife() or 0 end
	return 0
end

function PTCS_SideName(s)
	if s == 1 then return "Ti\170n gi\237i" end
	if s == 2 then return "Ma gi\237i" end
	return "?"
end

function PTCS_NpcName(s)
	if s == 1 then return "X\221ch Tinh T\246 \235 Ng\228c H\173 cung" end
	return "Cao Minh \235 Xi V\173u m\233"
end

function PTCS_Stats()
	return "Str " .. GetStrg(1) .. " / Dex " .. GetDex(1) .. " / Vit " .. GetVit(1) .. " / Eng " .. GetEng(1)
end

-- reason why the current player cannot be reborn on side (0 = not chosen yet), nil when he can
function PTCS_Why(side)
	local n = PTCS_TL()
	if n >= PTCS_MAX then
		return PTCS_HEAD .. "Ng\173\172i \174\183 chuy\211n sinh " .. n .. " l\199n, \174\183 \174\185t t\232i \174a."
	end
	local need = PTCS_LV[n + 1] or 121
	if GetLevel() < need then
		return PTCS_HEAD .. "C\199n \174\185t c\202p " .. need .. " m\237i chuy\211n sinh \174\173\238c (hi\214n c\202p " .. GetLevel() .. ")."
	end
	local mine = GetTask(PTCS_T_SIDE)
	if mine > 0 and side > 0 and mine ~= side then
		return PTCS_HEAD .. "Ng\173\172i \174\183 chuy\211n sinh theo " .. PTCS_SideName(mine) .. ", h\183y t\215m " .. PTCS_NpcName(mine) .. "."
	end
	local tm = GetTask(PTCS_T_TMPHE)
	if tm > 0 and side > 0 and tm ~= side then
		return PTCS_HEAD .. "Ng\173\172i \174\183 theo phe " .. PTCS_SideName(tm) .. " \235 Ti\170n Ma gi\237i, h\183y t\215m " .. PTCS_NpcName(tm) .. "."
	end
	return nil
end

-- side: 1 Xich Tinh Tu, 2 Cao Minh, 0 Chuyen Sinh Lao Lao (lets the player choose when he has no side yet)
function PTCS_Main(side)
	local nm = GetName()
	if side == 0 then side = GetTask(PTCS_T_SIDE) end
	if side == 0 then side = GetTask(PTCS_T_TMPHE) end
	if side ~= 1 and side ~= 2 then side = 0 end
	PTCS_PICK[nm] = side
	local n = PTCS_TL()
	local need = PTCS_LV[n + 1] or 121
	local s = PTCS_HEAD .. "Mu\232n tho\184t ph\181m thai nh\203p Ti\170n Ma gi\237i, tr\173\237c ph\182i c\227 ch\243t th\181nh t\249u \235 nh\169n gi\237i. " .. "Hi\214n ng\173\172i \174\183 chuy\211n sinh " .. n .. " l\199n, c\202p " .. GetLevel() .. "."
	if n < PTCS_MAX then s = s .. " L\199n chuy\211n sinh t\237i c\199n c\202p " .. need .. "." end
	if side == 0 then
		Say(s .. " Ng\173\172i mu\232n theo Ti\170n gi\237i hay Ma gi\237i?", 4, "Theo Ti\170n gi\237i/PTCS_Tien", "Theo Ma gi\237i/PTCS_Ma", "\167i\210u ki\214n v\181 ph\199n th\173\235ng/PTCS_Info", "\167\211 sau/PTCS_No")
	else
		Say(s, 3, "Ta mu\232n chuy\211n sinh/PTCS_Ask", "\167i\210u ki\214n v\181 ph\199n th\173\235ng/PTCS_Info", "\167\211 sau/PTCS_No")
	end
end

function PTCS_Tien()
	PTCS_PICK[GetName()] = 1
	PTCS_Ask()
end

function PTCS_Ma()
	PTCS_PICK[GetName()] = 2
	PTCS_Ask()
end

function PTCS_Info()
	local prof = GetProfession()
	local t = PTCS_BASE[prof] or PTCS_BASE[0]
	Say(PTCS_HEAD .. "C\199n c\202p 121, t\232i \174a 3 l\199n. Sau khi chuy\211n sinh: v\210 c\202p 1, kinh nghi\214m v\210 0; gi\247 nguy\170n m\228i k\252 n\168ng v\181 \174i\211m k\252 n\168ng ch\173a c\233ng; 4 thu\233c t\221nh g\232c \174\198t l\185i theo ph\184i c\241a ng\173\172i l\181 " .. t[1] .. "/" .. t[2] .. "/" .. t[3] .. "/" .. t[4] .. " (s\248c m\185nh/th\169n ph\184p/ngo\185i c\171ng/n\233i c\171ng), c\233ng th\170m 50 m\231i thu\233c t\221nh \235 l\199n 1, 20 \235 l\199n 2 v\181 l\199n 3; nh\203n 20 \174i\211m ti\210m n\168ng, \174i\211m th\173\235ng ngo\181i c\202p v\201n gi\247. Trang b\222 y\170u c\199u c\202p cao ph\182i luy\214n l\185i m\237i d\239ng \174\173\238c.", 2, "Quay l\185i/PTCS_Back", "\167\227ng/PTCS_No")
end

function PTCS_Back()
	PTCS_Main(PTCS_PICK[GetName()] or 0)
end

function PTCS_Ask()
	local side = PTCS_PICK[GetName()] or 0
	local why = PTCS_Why(side)
	if why then
		Say(why, 1, "\167\227ng/PTCS_No")
		return
	end
	local n = PTCS_TL() + 1
	local prof = GetProfession()
	local t = PTCS_BASE[prof] or PTCS_BASE[0]
	local b = PTCS_BonusSum(n)
	Say(PTCS_HEAD .. "Chuy\211n sinh l\199n " .. n .. " theo " .. PTCS_SideName(side) .. ": v\210 c\202p 1, gi\247 k\252 n\168ng, thu\233c t\221nh g\232c th\181nh " .. (t[1] + b) .. "/" .. (t[2] + b) .. "/" .. (t[3] + b) .. "/" .. (t[4] + b) .. ", +20 \174i\211m ti\210m n\168ng. Trang b\222 c\202p cao s\207 ch\173a d\239ng \174\173\238c. Kh\171ng th\211 ho\181n t\184c. X\184c nh\203n?", 2, "X\184c nh\203n chuy\211n sinh/PTCS_Yes", "Th\171i/PTCS_No")
end

function PTCS_Yes()
	PTCS_Do(PTCS_PICK[GetName()] or 0)
end

function PTCS_BonusSum(n)
	local b = 0
	local k = 1
	while k <= n do
		b = b + (PTCS_BONUS[k] or 0)
		k = k + 1
	end
	return b
end

-- raise one base attribute to target (AddStrg & co take the amount from the free points)
function PTCS_Raise(cur, target, fn)
	local d = target - cur
	if d > 0 then
		AddProp(d)
		fn(d)
	end
end

function PTCS_Do(side)
	local nm = GetName()
	if side ~= 1 and side ~= 2 then
		CloseDialog()
		return 0
	end
	local why = PTCS_Why(side)
	if why then
		Say(why, 1, "\167\227ng/PTCS_No")
		return 0
	end
	local n0 = PTCS_TL()
	local L0 = GetLevel()
	local S0 = GetStrg(1) + GetDex(1) + GetVit(1) + GetEng(1)
	local P0 = GetProp()
	local SP0 = GetMagicPoint()
	local sk = {}
	local txt = ""
	local s = 1
	while s <= PTCS_SKMAX do
		local l = GetMagicLevel(s)
		if l and l > 0 then
			sk[s] = l
			txt = txt .. s .. ":" .. l .. " "
		end
		s = s + 1
	end
	PTCS_Log(nm .. " before tl=" .. n0 .. " lv=" .. L0 .. " exp=" .. GetExp() .. " " .. PTCS_Stats() .. " ap=" .. P0 .. " sp=" .. SP0 .. " side=" .. side .. " skills=" .. txt)
	AddTranslife(1)
	if PTCS_TL() ~= n0 + 1 then
		PTCS_Log(nm .. " FAIL AddTranslife tl=" .. PTCS_TL())
		Say(PTCS_HEAD .. "Chuy\211n sinh th\202t b\185i, kh\171ng c\227 g\215 thay \174\230i.", 1, "\167\227ng/PTCS_No")
		return 0
	end
	SetTask(PTCS_T_SIDE, side)
	SetTask(PTCS_T_PRELV, L0)
	SetTask(PTCS_T_DATE, tonumber(date("%Y%m%d")))
	SetLevel(1)
	s = 1
	while s <= PTCS_SKMAX do
		if sk[s] then
			SetSkillLevel(s, sk[s])
			AddMagic(s, sk[s])
		end
		s = s + 1
	end
	AddMagicPoint(SP0 - GetMagicPoint())
	local prof = GetProfession()
	local t = PTCS_BASE[prof] or PTCS_BASE[0]
	-- bonus points beyond what levels and rebirths gave (items, quests) are kept as free points
	local base0 = GetStrg(1) + GetDex(1) + GetVit(1) + GetEng(1)
	local given = (L0 - 1) * PTCS_LVPOINT
	if n0 > 0 then
		base0 = t[1] + t[2] + t[3] + t[4] + 4 * PTCS_BonusSum(n0)
		given = given + PTCS_POINT
	end
	local extra = S0 + P0 - base0 - given
	if extra < 0 then extra = 0 end
	AddProp(-GetProp())
	local b = PTCS_BonusSum(n0 + 1)
	PTCS_Raise(GetStrg(1), t[1] + b, AddStrg)
	PTCS_Raise(GetDex(1), t[2] + b, AddDex)
	PTCS_Raise(GetVit(1), t[3] + b, AddVit)
	PTCS_Raise(GetEng(1), t[4] + b, AddEng)
	AddProp(PTCS_POINT + extra)
	PTCS_Log(nm .. " after tl=" .. PTCS_TL() .. " lv=" .. GetLevel() .. " " .. PTCS_Stats() .. " ap=" .. GetProp() .. " sp=" .. GetMagicPoint() .. " extra=" .. extra)
	Msg2Player(PTCS_HEAD .. "Ch\243c m\245ng, ng\173\172i \174\183 chuy\211n sinh l\199n " .. PTCS_TL() .. " theo " .. PTCS_SideName(side) .. ".")
	Say(PTCS_HEAD .. "Ch\243c m\245ng, ng\173\172i \174\183 chuy\211n sinh l\199n " .. PTCS_TL() .. " theo " .. PTCS_SideName(side) .. ". Thu\233c t\221nh g\232c: " .. PTCS_Stats() .. ", \174i\211m ti\210m n\168ng: " .. GetProp() .. ". H\183y tho\184t game v\181o l\185i \174\211 th\202y bi\211u t\173\238ng chuy\211n sinh.", 1, "\167\227ng/PTCS_No")
	return 1
end
