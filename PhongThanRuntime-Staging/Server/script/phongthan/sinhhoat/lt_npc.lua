-- Phong Than 2026-10-03 (sinhhoat): Linh Thu Su (pet keeper) in Tay Ky and Trieu Ca. Gives the Linh Thu Lenh,
-- the first pet (free), pet eggs for Linh Thu Don + silver, and the growth stages of taskinfo 2035-2070
-- (4 stages per pet; stage s caps the pet at level s*10; each evolution swaps the VNG pet template).
Include("\\script\\phongthan\\sinhhoat\\sh_lib.lua")

PTLT_HEAD = "<color=green>Linh Th\243 S\248<color>: "
-- evolution from stage s: essence (tinh hoa) / meat (thit) tiers, extra item, silver
PTLT_EVO = {}
PTLT_EVO[1] = { q1 = { 1, 46, 1, 3, 10 }, q2 = { 3, 28, 1, 3, 10 }, cash = 50000 }
PTLT_EVO[2] = { q1 = { 1, 46, 4, 6, 10 }, q2 = { 3, 28, 4, 6, 10 }, x = { 3, 88, 0, 1 }, xname = "M\182nh Ho\181ng th\241y tinh", cash = 200000 }
PTLT_EVO[3] = { q1 = { 1, 46, 7, 10, 10 }, q2 = { 3, 28, 7, 10, 10 }, x = { 3, 89, 0, 1 }, xname = "Ho\181ng th\241y tinh", cash = 500000 }
PTLT_EVO_TIER = { "c\202p 1-3", "c\202p 4-6", "c\202p 7 tr\235 l\170n" }

function main()
	local t = { PTLT_HEAD .. "Linh th\243 \174i theo ch\241 nh\169n khi chi\213n \174\202u s\207 l\170n c\202p, gi\243p ch\241 nh\169n th\170m kinh nghi\214m v\181 tha v\210 nguy\170n li\214u. Ng\173\172i c\199n g\215?", 0 }
	local n = 0
	if PTLT_OwnedCount() == 0 then
		n = n + 1 t[n + 2] = "Nh\203n linh th\243 \174\199u ti\170n (mi\212n ph\221)/PTLT_FirstMenu"
	end
	n = n + 1 t[n + 2] = "Nh\203n Linh Th\243 L\214nh/PTLT_GiveLenh"
	n = n + 1 t[n + 2] = "Ti\213n h\227a linh th\243/PTLT_EvoMenu"
	n = n + 1 t[n + 2] = "\167\230i Tr\248ng Linh Th\243/PTLT_EggMenu"
	n = n + 1 t[n + 2] = "Gi\237i thi\214u linh th\243/PTLT_Info"
	n = n + 1 t[n + 2] = "\167\227ng/PTSH_No"
	t[2] = n
	call(Say, t)
end

function PTLT_Info()
	Say(PTLT_HEAD .. "C\227 8 linh th\243: H\229 H\251 M\222, Na Tra, L\171i Ch\202n T\246, Th\185ch C\172, Th\184i \202t, \167\190c K\251, Th\169n C\171ng B\184o, Ho\181ng Phi H\230. M\231i con c\227 4 giai \174o\185n tr\173\235ng th\181nh, giai \174o\185n s gi\237i h\185n c\202p s x 10. Linh th\243 l\170n c\202p khi \174i theo ng\173\172i chi\213n \174\202u (m\231i ph\243t) ho\198c \168n Linh Th\243 \167\172n (Sinh Ho\185t S\173 ch\213, L\212 Quan t\198ng). Tr\248ng c\227 th\211 \174\230i \235 \174\169y ho\198c nh\203n t\245 ho\185t \174\233ng L\212 Quan.", 1, "\167\227ng/PTSH_No")
end

function PTLT_GiveLenh()
	if PTSH_Count(6, PTLT_I_LENH, 0) > 0 then
		Say(PTLT_HEAD .. "Ng\173\172i \174\183 c\227 Linh Th\243 L\214nh r\229i.", 1, "\167\227ng/PTSH_No")
		return
	end
	if PTSH_Free() < 1 or PTSH_Give(6, PTLT_I_LENH, 0, 1) < 1 then
		Say(PTLT_HEAD .. "H\181nh trang \174\183 \174\199y.", 1, "\167\227ng/PTSH_No")
		return
	end
	Say(PTLT_HEAD .. "C\199m l\202y Linh Th\243 L\214nh: nh\202p ph\182i \174\211 tri\214u h\229i, \174\230i, cho \168n v\181 xem linh th\243.", 1, "\167\227ng/PTSH_No")
end

function PTLT_PetMenu(head, prefix, mode)
	local t = { head, 0 }
	local n = 0
	local k = 1
	while k <= 8 do
		local s = PTLT_Stage(k)
		if (mode == 0 and s == 0) or (mode == 1 and s > 0) or mode == 2 then
			n = n + 1
			local lab = PTLT_PET[k][1]
			if s > 0 then lab = PTLT_Label(k) end
			t[n + 2] = lab .. "/" .. prefix .. k
		end
		k = k + 1
	end
	if n == 0 then
		Say(PTLT_HEAD .. "Kh\171ng c\227 linh th\243 n\181o ph\239 h\238p.", 1, "\167\227ng/PTSH_No")
		return
	end
	n = n + 1 t[n + 2] = "\167\227ng/PTSH_No"
	t[2] = n
	call(Say, t)
end

-- first pet --------------------------------------------------------------------------------------------------
function PTLT_FirstMenu()
	if PTLT_OwnedCount() > 0 then return end
	PTLT_PetMenu(PTLT_HEAD .. "Ch\228n linh th\243 \174\199u ti\170n c\241a ng\173\172i:", "PTLT_F", 0)
end

function PTLT_First(k)
	if PTLT_OwnedCount() > 0 or k < 1 or k > 8 then return end
	PTLT_SetStage(k, 1)
	SetTask(PTLT_T_EXP0 + k, 0)
	SetTask(PTLT_T_ACT, k)
	if PTSH_Count(6, PTLT_I_LENH, 0) <= 0 then PTSH_Give(6, PTLT_I_LENH, 0, 1) end
	PTSH_Note(PTLT_PET[k][6], PTLT_STAGE_NAME[k][1], "Nh\203n linh th\243 " .. PTLT_PET[k][1] .. ". Cho \174i theo khi chi\213n \174\202u \174\213n c\202p 10 r\229i t\215m Linh Th\243 S\248 ti\213n h\227a.", 1)
	Say(PTLT_HEAD .. "Ng\173\172i \174\183 nh\203n <color=yellow>" .. PTLT_PET[k][1] .. "<color>. Nh\202p ph\182i Linh Th\243 L\214nh \174\211 tri\214u h\229i.", 1, "\167\227ng/PTSH_No")
end

-- eggs -----------------------------------------------------------------------------------------------------------
function PTLT_EggMenu()
	PTLT_PetMenu(PTLT_HEAD .. "M\231i tr\248ng gi\184 " .. PTLT_EGG_DON .. " Linh Th\243 \167\172n v\181 " .. PTLT_EGG_CASH .. " l\173\238ng. Ch\228n tr\248ng:", "PTLT_E", 2)
end

function PTLT_Egg(k)
	if k < 1 or k > 8 then return end
	if PTSH_Free() < 1 then
		Say(PTLT_HEAD .. "H\181nh trang \174\183 \174\199y.", 1, "\167\227ng/PTSH_No")
		return
	end
	if GetCash() < PTLT_EGG_CASH or PTSH_Count(6, PTLT_I_DON, 0) < PTLT_EGG_DON then
		Say(PTLT_HEAD .. "C\199n " .. PTLT_EGG_DON .. " Linh Th\243 \167\172n trong h\181nh trang v\181 " .. PTLT_EGG_CASH .. " l\173\238ng.", 1, "\167\227ng/PTSH_No")
		return
	end
	local list = { { 6, PTLT_I_DON, 0, PTLT_EGG_DON } }
	if PTSH_TakeAll(list) ~= 1 then
		Say(PTLT_HEAD .. "Linh Th\243 \167\172n ph\182i \174\211 trong h\181nh trang.", 1, "\167\227ng/PTSH_No")
		return
	end
	if Pay(PTLT_EGG_CASH) ~= 1 then
		PTSH_Give(6, PTLT_I_DON, 0, PTLT_EGG_DON)
		return
	end
	PTSH_Give(6, PTLT_I_EGG0 + k, 0, 1)
	Say(PTLT_HEAD .. "\167\169y l\181 <color=yellow>Tr\248ng Linh Th\243 " .. PTLT_PET[k][1] .. "<color>, nh\202p ph\182i \174\211 \202p n\235.", 1, "\167\227ng/PTSH_No")
end

-- evolution ----------------------------------------------------------------------------------------------------------
function PTLT_EvoMenu()
	PTLT_PetMenu(PTLT_HEAD .. "Ch\228n linh th\243 mu\232n ti\213n h\227a:", "PTLT_V", 1)
end

function PTLT_EvoNeed(k, s)
	local e = PTLT_EVO[s]
	local txt = "\167\185t c\202p " .. (s * 10) .. ", n\233p 10 tinh hoa th\182o d\173\238c " .. PTLT_EVO_TIER[s] .. ", 10 th\222t c\184 " .. PTLT_EVO_TIER[s]
	if e.x then txt = txt .. ", 1 " .. e.xname end
	return txt .. " v\181 " .. e.cash .. " l\173\238ng."
end

function PTLT_Evo(k)
	local s = PTLT_Stage(k)
	if s <= 0 then return end
	if s >= 4 then
		Say(PTLT_HEAD .. PTLT_PET[k][1] .. " \174\183 \174\185t giai \174o\185n cu\232i: " .. PTLT_STAGE_NAME[k][4] .. ".", 1, "\167\227ng/PTSH_No")
		return
	end
	local e = PTLT_EVO[s]
	local need = PTLT_EvoNeed(k, s)
	local tid = PTLT_PET[k][6] + s
	if PTLT_Level(k) < s * 10 then
		PTSH_Note(tid, PTLT_STAGE_NAME[k][s + 1], need, 1)
		Say(PTLT_HEAD .. PTLT_PET[k][1] .. " ph\182i \174\185t c\202p " .. (s * 10) .. " (hi\214n c\202p " .. PTLT_Level(k) .. "). \167i\210u ki\214n: " .. need, 1, "\167\227ng/PTSH_No")
		return
	end
	local ok = 1
	if PTSH_TierCount(e.q1) < 10 or PTSH_TierCount(e.q2) < 10 or GetCash() < e.cash then ok = 0 end
	if e.x and PTSH_Count(e.x[1], e.x[2], e.x[3]) < e.x[4] then ok = 0 end
	if ok == 0 then
		PTSH_Note(tid, PTLT_STAGE_NAME[k][s + 1], need, 1)
		Say(PTLT_HEAD .. "Ch\173a \174\241 \174i\210u ki\214n (nguy\170n li\214u \174\211 trong h\181nh trang). " .. need, 1, "\167\227ng/PTSH_No")
		return
	end
	if PTSH_TierTake(e.q1) ~= 1 then
		Say(PTLT_HEAD .. "Nguy\170n li\214u ph\182i \174\211 trong h\181nh trang.", 1, "\167\227ng/PTSH_No")
		return
	end
	local t1 = PTSH_LAST_TAKEN
	if PTSH_TierTake(e.q2) ~= 1 then
		PTSH_GiveBack(t1)
		Say(PTLT_HEAD .. "Nguy\170n li\214u ph\182i \174\211 trong h\181nh trang.", 1, "\167\227ng/PTSH_No")
		return
	end
	local t2 = PTSH_LAST_TAKEN
	if e.x and PTSH_TakeAll({ e.x }) ~= 1 then
		PTSH_GiveBack(t1)
		PTSH_GiveBack(t2)
		Say(PTLT_HEAD .. e.xname .. " ph\182i \174\211 trong h\181nh trang.", 1, "\167\227ng/PTSH_No")
		return
	end
	if Pay(e.cash) ~= 1 then
		PTSH_GiveBack(t1)
		PTSH_GiveBack(t2)
		if e.x then PTSH_Give(e.x[1], e.x[2], e.x[3], e.x[4]) end
		return
	end
	PTLT_SetStage(k, s + 1)
	PTSH_Note(tid, PTLT_STAGE_NAME[k][s + 1], "Ho\181n th\181nh", 2)
	if s + 1 < 4 then PTSH_Note(tid + 1, PTLT_STAGE_NAME[k][s + 2], PTLT_EvoNeed(k, s + 1), 1) end
	if GetTask(PTLT_T_ACT) == k and PTLT_Owned() > 0 then PTLT_Summon() end
	Say(PTLT_HEAD .. PTLT_PET[k][1] .. " ti\213n h\227a th\181nh c\171ng: <color=yellow>" .. PTLT_STAGE_NAME[k][s + 1] .. "<color>! Gi\237i h\185n c\202p m\237i: " .. ((s + 1) * 10) .. ".", 1, "\167\227ng/PTSH_No")
end

function PTLT_F1() PTLT_First(1) end
function PTLT_F2() PTLT_First(2) end
function PTLT_F3() PTLT_First(3) end
function PTLT_F4() PTLT_First(4) end
function PTLT_F5() PTLT_First(5) end
function PTLT_F6() PTLT_First(6) end
function PTLT_F7() PTLT_First(7) end
function PTLT_F8() PTLT_First(8) end
function PTLT_E1() PTLT_Egg(1) end
function PTLT_E2() PTLT_Egg(2) end
function PTLT_E3() PTLT_Egg(3) end
function PTLT_E4() PTLT_Egg(4) end
function PTLT_E5() PTLT_Egg(5) end
function PTLT_E6() PTLT_Egg(6) end
function PTLT_E7() PTLT_Egg(7) end
function PTLT_E8() PTLT_Egg(8) end
function PTLT_V1() PTLT_Evo(1) end
function PTLT_V2() PTLT_Evo(2) end
function PTLT_V3() PTLT_Evo(3) end
function PTLT_V4() PTLT_Evo(4) end
function PTLT_V5() PTLT_Evo(5) end
function PTLT_V6() PTLT_Evo(6) end
function PTLT_V7() PTLT_Evo(7) end
function PTLT_V8() PTLT_Evo(8) end
