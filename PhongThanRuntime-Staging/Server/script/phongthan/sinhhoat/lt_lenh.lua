-- Phong Than 2026-10-03 (sinhhoat): item 6/1/61370 "Linh Thu Lenh" (permanent, never consumed). Right click:
-- summon / dismiss the active pet, call it back, choose another owned pet, feed a Linh Thu Don, status.
-- The pet follows its owner (AddTotemNpc). Behaviour, chosen here (2026-10-03 cppbatch, sh_lib.lua PTLT_Mode):
-- companion (AiMode 13 on a cppbatch CoreServer, never fights) or combat (AiMode 11 + melee skill 63). The minute
-- tick (script\phongthan\ext\sinhhoat.lua) gives pet exp and owner exp while fighting and re-summons it after a
-- map change or death.
Include("\\script\\phongthan\\sinhhoat\\sh_lib.lua")

PTLT_HEAD = "<color=yellow>Linh Th\243 L\214nh<color>: "

function main(nItemIdx)
	if PTLT_OwnedCount() == 0 then
		Say(PTLT_HEAD .. "Ng\173\172i ch\173a c\227 linh th\243 n\181o. H\183y g\198p Linh Th\243 S\248 \235 T\169y K\250 ho\198c Tri\210u Ca \174\211 nh\203n linh th\243 \174\199u ti\170n.", 1, "\167\227ng/PTSH_No")
		return 0
	end
	local k = GetTask(PTLT_T_ACT)
	if PTLT_Stage(k) <= 0 then
		k = 1
		while k <= 8 and PTLT_Stage(k) <= 0 do k = k + 1 end
		SetTask(PTLT_T_ACT, k)
	end
	local out = PTLT_Owned()
	local t = { PTLT_HEAD .. "Linh th\243 hi\214n t\185i: <color=yellow>" .. PTLT_Label(k) .. "<color>.", 0 }
	local n = 0
	if out > 0 then
		n = n + 1 t[n + 2] = "Thu h\229i linh th\243/PTLT_Off"
		n = n + 1 t[n + 2] = "G\228i linh th\243 v\210 b\170n c\185nh/PTLT_Recall"
	else
		n = n + 1 t[n + 2] = "Tri\214u h\229i linh th\243/PTLT_On"
	end
	n = n + 1 t[n + 2] = "Ch\213 \174\233: " .. PTLT_ModeName(PTLT_Mode()) .. "/PTLT_ModeMenu"
	n = n + 1 t[n + 2] = "\167\230i linh th\243 kh\184c/PTLT_ChooseMenu"
	n = n + 1 t[n + 2] = "Cho \168n Linh Th\243 \167\172n/PTLT_FeedMenu"
	n = n + 1 t[n + 2] = "Xem tr\185ng th\184i/PTLT_Status"
	n = n + 1 t[n + 2] = "\167\227ng/PTSH_No"
	t[2] = n
	call(Say, t)
	return 0
end

function PTLT_On()
	if PTLT_Summon() > 0 then
		Msg2Player("\167\183 tri\214u h\229i linh th\243 " .. PTLT_PET[GetTask(PTLT_T_ACT)][1] .. ".")
	else
		Say(PTLT_HEAD .. "Kh\171ng tri\214u h\229i \174\173\238c linh th\243 \235 \174\169y.", 1, "\167\227ng/PTSH_No")
	end
end

function PTLT_Off()
	PTLT_Dismiss(0)
	Msg2Player("\167\183 thu h\229i linh th\243.")
end

function PTLT_Recall()
	local idx = PTLT_Owned()
	if idx <= 0 then return end
	local pw, x, y = GetNpcPos(GetPlayerNpcIdx())
	SetNpcPos(idx, x + 1, y + 1)
end

function PTLT_ModeName(m)
	if m == 1 then return "Chi\213n \174\202u" end
	return "B\185n \174\229ng h\181nh"
end

function PTLT_ModeMenu()
	local s = PTLT_HEAD .. "Ch\213 \174\233 hi\214n t\185i: <color=yellow>" .. PTLT_ModeName(PTLT_Mode()) .. "<color>."
	s = s .. "\n- B\185n \174\229ng h\181nh: linh th\243 ch\216 \174i theo, kh\171ng \174\184nh qu\184i."
	s = s .. "\n- Chi\213n \174\202u: linh th\243 c\239ng ng\173\172i \174\184nh qu\184i (\174\223n c\203n chi\213n, s\248c m\185nh theo ch\241). B\222 qu\184i h\185 th\215 m\233t ph\243t sau linh th\243 t\249 quay l\185i."
	if PTLT_HasCompanionAI() == nil then
		s = s .. "\n<color=red>M\184y ch\241 ch\173a c\203p nh\203t: \235 ch\213 \174\233 B\185n \174\229ng h\181nh, linh th\243 v\201n ch\185y theo qu\184i nh\173ng kh\171ng g\169y s\184t th\173\172ng.<color>"
	end
	Say(s, 3, "B\185n \174\229ng h\181nh/PTLT_Mode0", "Chi\213n \174\202u/PTLT_Mode1", "\167\227ng/PTSH_No")
end

function PTLT_ModeSet(m)
	PTLT_SetMode(m)
	if PTLT_Owned() > 0 then PTLT_Summon() end
	Msg2Player("Ch\213 \174\233 linh th\243: " .. PTLT_ModeName(m) .. ".")
end

function PTLT_Mode0() PTLT_ModeSet(0) end
function PTLT_Mode1() PTLT_ModeSet(1) end

function PTLT_ChooseMenu()
	local t = { PTLT_HEAD .. "Ch\228n linh th\243:", 0 }
	local n = 0
	local k = 1
	while k <= 8 do
		if PTLT_Stage(k) > 0 then
			n = n + 1 t[n + 2] = PTLT_Label(k) .. "/PTLT_S" .. k
		end
		k = k + 1
	end
	n = n + 1 t[n + 2] = "\167\227ng/PTSH_No"
	t[2] = n
	call(Say, t)
end

function PTLT_Choose(k)
	if PTLT_Stage(k) <= 0 then return end
	local was = PTLT_Owned()
	SetTask(PTLT_T_ACT, k)
	if was > 0 then PTLT_Summon() end
	Msg2Player("Linh th\243 hi\214n t\185i: " .. PTLT_Label(k) .. ".")
end

function PTLT_FeedMenu()
	local have = PTSH_Count(6, PTLT_I_DON, 0)
	Say(PTLT_HEAD .. "M\231i Linh Th\243 \167\172n cho linh th\243 hi\214n t\185i " .. PTLT_FOOD_EXP .. " \174i\211m kinh nghi\214m. Ng\173\172i c\227 " .. have .. " vi\170n.", 3, "Cho \168n 1 vi\170n/PTLT_Feed1", "Cho \168n 10 vi\170n/PTLT_Feed10", "\167\227ng/PTSH_No")
end

function PTLT_FeedN(n)
	local done = 0
	while done < n do
		if PTSH_Take(6, PTLT_I_DON, 0, 1) < 1 then break end
		local r = PTLT_Feed()
		if r <= 0 then
			PTSH_Give(6, PTLT_I_DON, 0, 1)
			break
		end
		done = done + 1
	end
	local k = GetTask(PTLT_T_ACT)
	if done == 0 then
		Say(PTLT_HEAD .. "Kh\171ng cho \168n \174\173\238c (kh\171ng c\227 Linh Th\243 \167\172n trong h\181nh trang, ho\198c linh th\243 \174\183 \174\185t gi\237i h\185n c\202p c\241a giai \174o\185n).", 1, "\167\227ng/PTSH_No")
		return
	end
	Msg2Player("\167\183 cho \168n " .. done .. " Linh Th\243 \167\172n. " .. PTLT_Label(k) .. ".")
end

function PTLT_Feed1() PTLT_FeedN(1) end
function PTLT_Feed10() PTLT_FeedN(10) end

function PTLT_Status()
	local s = PTLT_HEAD .. "Linh th\243 c\241a ng\173\172i:"
	local k = 1
	while k <= 8 do
		if PTLT_Stage(k) > 0 then
			local lv = PTLT_Level(k)
			local e = GetTask(PTLT_T_EXP0 + k) - PTLT_ExpFor(lv)
			s = s .. "\n" .. PTLT_Label(k) .. " (" .. e .. "/" .. PTLT_Need(lv) .. ")"
		end
		k = k + 1
	end
	Say(s, 1, "\167\227ng/PTSH_No")
end

function PTLT_S1() PTLT_Choose(1) end
function PTLT_S2() PTLT_Choose(2) end
function PTLT_S3() PTLT_Choose(3) end
function PTLT_S4() PTLT_Choose(4) end
function PTLT_S5() PTLT_Choose(5) end
function PTLT_S6() PTLT_Choose(6) end
function PTLT_S7() PTLT_Choose(7) end
function PTLT_S8() PTLT_Choose(8) end
