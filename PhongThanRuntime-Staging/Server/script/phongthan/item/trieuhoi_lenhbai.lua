-- Phong Than "Lenh Bai Trieu Hoi" (magicscript 61003, 2026-10-01): Di Nhan summons (VNG
-- \settings\summonskill.txt 450-461, not loaded by this engine). Permanent, never consumed.
--  * AddTotemNpc(tpl, level, SubWorld, mpsX, mpsY): owner = player, AiMode 11 (pet AI: follows,
--    attacks the owner's target; KNpcAI::ProcessAIType11 removes it when the owner dies/changes map)
--  * SetNpcOwner(npc, name, 0) copies the owner's damage/defence/speed/life max (0 = keep pet AI)
--  * task 1941 = pet npc index, 1942 = its template (checked before DelNpc so a reused slot is safe)
--  * 2026-10-02: menu row "Hoc ky nang trieu hoi" teaches the summon skills 450-461 (AddMagic lv 1)
--  * 2026-10-03: menu row "Doi hinh dang de tu" = VNG summon-beast appearance (task 254 = template
--    2651-2656, 0 = default). Token pet: re-summoned, then NpcPolyMorph(npc, tpl) before the first
--    sync, so clients load the new look at once; stats/skills stay from the summon template.
--    Skill pet (450-461): KSkill::Cast applies task 254 on every cast; SetSummonBeastMorph = live pet.
--  * 2026-10-03 (petexp): the pet has its own level/exp (\script\phongthan\lib\petexp_lib.lua, task
--    2505/2506, fed by npc_quests\normal.lua).
--  * 2026-10-04 (pet10): pet level 1-10 like VNG. Npc level = PTPE_NpcLevel(learn level, pet level); PTPE_Apply
--    sets the pet's OWN stats (life/AR/defence/damage from its template) and skill level = pet level.
--    SetNpcOwner (which copies the owner's stats) is no longer called: AddTotemNpc already sets the owner.
-- No top-level dofile: loose scripts are registered with cwd = their own folder. Include takes the logical
-- path (KPakFile, PAK-first), independent of cwd; protected so a missing lib never breaks the token.
function PTTH_PEErr(m) end
if Include then call(Include, { "\\script\\phongthan\\lib\\petexp_lib.lua" }, "x", PTTH_PEErr) end
PTTH_PROF = 2
PTTH_LIST = {
	{450, 359, 5, "L\249c S\220 t\213"},
	{451, 360, 15, "Tr\173\234ng Cung t\213"},
	{452, 361, 25, "Thi\170n V\242 t\213"},
	{453, 362, 35, "Li\170n N\231 t\213"},
	{454, 403, 45, "H\225a L\171i t\213"},
	{455, 404, 55, "To\184i C\232t t\213"},
	{456, 405, 65, "L\173u Tinh t\213"},
	{457, 406, 75, "Truy H\229n t\213"},
	{458, 407, 85, "Phong Quy\211n T\181n V\169n"},
	{459, 1345, 95, "Cu\229ng \167\181o t\213"},
	{460, 1346, 105, "Ng\249 S\203u B\185o Phong"},
	{461, 2032, 120, "Huy\210n \182nh T\184n Hoa"},
}
PTTH_MORPH = {
	{2651, "Th\225 V\181ng"},
	{2652, "C\169u Tr\199n V\181ng"},
	{2653, "Ch\243c Th\199n V\181ng"},
	{2654, "T\202t Ph\173\172ng"},
	{2655, "H\185n B\185t"},
	{2656, "H\227a X\181"},
}

function PTTH_IsMorph(t)
	if t ~= nil and t >= 2651 and t <= 2656 then return 1 end
	return nil
end

function PTTH_Owned()
	local idx = GetTask(1941)
	if idx == nil or idx <= 0 then return 0 end
	local st = GetNpcSettingIdx(idx)
	if st ~= GetTask(1942) and PTTH_IsMorph(st) == nil then return 0 end
	if GetNpcOwner(idx) ~= GetName() then return 0 end
	return idx
end

function PTTH_Find(tpl)
	local i = 1
	while PTTH_LIST[i] do
		if PTTH_LIST[i][2] == tpl then return i end
		i = i + 1
	end
	return 0
end

function PTTH_Dismiss()
	local idx = PTTH_Owned()
	if idx > 0 then DelNpc(idx) end
	SetTask(1941, 0)
	SetTask(1942, 0)
	return idx
end

function main(nItemIdx)
	if GetProfession() ~= PTTH_PROF then
		Say("L\214nh b\181i tri\214u h\229i ch\216 d\181nh cho ph\184i D\222 Nh\169n.", 1, "\167\227ng/PTTH_No")
		return 0
	end
	-- coordinator 2026-10-03: the client dialog shows only the first rows, so the 12 summons moved to
	-- two sub-pages and the main menu keeps the functions (morph / learn were cut off before).
	local opts = {}
	local n = 0
	n = n + 1 opts[n] = "G\228i \174\214 t\246 (c\202p 5-55)/PTTH_Page1"
	n = n + 1 opts[n] = "G\228i \174\214 t\246 (c\202p 65-120)/PTTH_Page2"
	n = n + 1 opts[n] = "H\228c k\252 n\168ng tri\214u h\229i/PTTH_LearnMenu"
	n = n + 1 opts[n] = "\167\230i h\215nh d\185ng \174\214 t\246/PTTH_MorphMenu"
	n = n + 1 opts[n] = "G\228i \174\214 t\246 v\210 b\170n c\185nh/PTTH_Recall"
	n = n + 1 opts[n] = "Thu h\229i \174\214 t\246/PTTH_DismissMenu"
	n = n + 1 opts[n] = "\167\227ng/PTTH_No"
	-- petexp: pet level / exp in the dialog text (no extra menu row: the client shows only the first rows)
	local title = "<color=yellow>L\214nh B\181i Tri\214u H\229i<color>: ch\228n \174\214 t\246 \174\211 g\228i ra tr\238 chi\213n. G\228i con m\237i th\215 con c\242 bi\213n m\202t; \174\230i b\182n \174\229 ho\198c t\246 vong th\215 \174\214 t\246 t\249 r\234i \174i, d\239ng l\214nh b\181i g\228i l\185i."
	if PTPE_Info then title = title .. " " .. PTPE_Info() end
	local t = { title, n }
	local k = 1
	while k <= n do t[k + 2] = opts[k] k = k + 1 end
	call(Say, t)
	return 0
end

function PTTH_Page(first, last)
	local lv = GetLevel()
	local opts = {}
	local n = 0
	local i = first
	while i <= last and PTTH_LIST[i] do
		local s = PTTH_LIST[i]
		n = n + 1
		if lv >= s[3] then
			opts[n] = s[4] .. "/PTTH_S" .. i
		else
			opts[n] = s[4] .. " (c\199n c\202p " .. s[3] .. ")/PTTH_S" .. i
		end
		i = i + 1
	end
	n = n + 1 opts[n] = "Quay l\185i/main"
	n = n + 1 opts[n] = "\167\227ng/PTTH_No"
	local t = { "<color=yellow>L\214nh B\181i Tri\214u H\229i<color>: ch\228n \174\214 t\246 \174\211 g\228i ra tr\238 chi\213n. G\228i con m\237i th\215 con c\242 bi\213n m\202t; \174\230i b\182n \174\229 ho\198c t\246 vong th\215 \174\214 t\246 t\249 r\234i \174i, d\239ng l\214nh b\181i g\228i l\185i.", n }
	local k = 1
	while k <= n do t[k + 2] = opts[k] k = k + 1 end
	call(Say, t)
end

function PTTH_Page1() PTTH_Page(1, 6) end
function PTTH_Page2() PTTH_Page(7, 12) end

function PTTH_Summon(k)
	local s = PTTH_LIST[k]
	if s == nil or GetProfession() ~= PTTH_PROF then return end
	if GetLevel() < s[3] then
		Say("Ch\173a \174\241 c\202p \174\211 g\228i \174\214 t\246 n\181y. C\199n c\202p " .. s[3], 1, "\167\227ng/PTTH_No")
		return
	end
	PTTH_Dismiss()
	-- coordinator 2026-10-04: one pet at a time, the summon-skill pet (Npc.m_nPetIdx) goes too
	if DelPet then DelPet() end
	local pn = GetPlayerNpcIdx()
	local w, x, y = GetNpcPos(pn)
	-- petexp: the pet's own level (task 2505, 1-10); npc level from the pet level (pet10). Old behaviour
	-- (owner level + SetNpcOwner) only if the lib is missing.
	local plv = GetLevel()
	local nlv = plv
	if PTPE_Level then
		plv = PTPE_Level()
		nlv = PTPE_NpcLevel(s[3], plv)
	end
	local idx = AddTotemNpc(s[2], nlv, SubWorld, x * 32 + 48, y * 32 + 48)
	if idx == nil or idx <= 0 then
		Say("Kh\171ng g\228i \174\173\238c \174\214 t\246 \235 \174\169y.", 1, "\167\227ng/PTTH_No")
		return
	end
	SetNpcCurCamp(idx, GetCurCamp())
	SetTask(1941, idx)
	SetTask(1942, s[2])
	if PTPE_Apply then
		PTPE_Apply(idx, s[2], plv)
	else
		SetNpcOwner(idx, GetName(), 0)
		SetNpcName(idx, GetName())
	end
	local mt = GetTask(254)
	if PTTH_IsMorph(mt) and NpcPolyMorph then NpcPolyMorph(idx, mt) end
	if PTPE_Level then
		Msg2Player("\167\183 g\228i \174\214 t\246: " .. s[4] .. " (c\202p " .. plv .. ")")
	else
		Msg2Player("\167\183 g\228i \174\214 t\246: " .. s[4])
	end
end

function PTTH_Recall()
	local idx = PTTH_Owned()
	if idx <= 0 then
		Say("B\185n ch\173a g\228i \174\214 t\246 n\181o.", 1, "\167\227ng/PTTH_No")
		return
	end
	local pn = GetPlayerNpcIdx()
	local w, x, y = GetNpcPos(pn)
	SetNpcPos(idx, x + 1, y + 1)
end

function PTTH_DismissMenu()
	if PTTH_Dismiss() > 0 then
		Msg2Player("\167\183 thu h\229i \174\214 t\246.")
	else
		Say("B\185n ch\173a g\228i \174\214 t\246 n\181o.", 1, "\167\227ng/PTTH_No")
	end
end

function PTTH_No()
end

-- 2026-10-02 (petskill): teach the real summon skills 450-461 (skills.txt rows from ptfix plug-in
-- extra_petskill.py, SkillStyle 4 = native KSkill::Cast summon). Level 1, raised with skill points.
-- If the server still runs an older ptfix (no row), AddMagic fails: the empty slot is removed again.
function PTTH_Known(id)
	local l = HaveMagic(id)
	if l == nil or l <= 0 then return 0 end
	return l
end

function PTTH_Learn(k)
	local s = PTTH_LIST[k]
	if s == nil or GetProfession() ~= PTTH_PROF or GetLevel() < s[3] then return 0 end
	if PTTH_Known(s[1]) > 0 then return 0 end
	local r = AddMagic(s[1], 1)
	if r == nil or r <= 0 or PTTH_Known(s[1]) <= 0 then
		DelMagic(s[1])
		return -1
	end
	Msg2Player("\167\183 h\228c k\252 n\168ng tri\214u h\229i: " .. s[4])
	return 1
end

function PTTH_LearnMenu()
	if GetProfession() ~= PTTH_PROF then return end
	local lv = GetLevel()
	local t = { "<color=yellow>H\228c k\252 n\168ng tri\214u h\229i<color>: k\252 n\168ng \174\214 t\246 th\203t c\241a D\222 Nh\169n, g\184n v\181o ph\221m chu\233t \174\211 g\228i \174\214 t\246 m\181 kh\171ng c\199n l\214nh b\181i. Ch\216 hi\214n c\184c k\252 n\168ng \174\183 \174\241 c\202p v\181 ch\173a h\228c.", 0 }
	local n = 0
	local i = 1
	while PTTH_LIST[i] do
		local s = PTTH_LIST[i]
		if lv >= s[3] and PTTH_Known(s[1]) == 0 then
			n = n + 1
			t[n + 2] = s[4] .. "/PTTH_L" .. i
		end
		i = i + 1
	end
	if n == 0 then
		Say("Kh\171ng c\223n k\252 n\168ng tri\214u h\229i n\181o \174\211 h\228c (ch\173a \174\241 c\202p ho\198c \174\183 h\228c h\213t).", 1, "\167\227ng/PTTH_No")
		return
	end
	if n > 1 then n = n + 1 t[n + 2] = "H\228c t\202t c\182/PTTH_LearnAll" end
	n = n + 1 t[n + 2] = "\167\227ng/PTTH_No"
	t[2] = n
	call(Say, t)
end

function PTTH_LearnOne(k)
	local r = PTTH_Learn(k)
	if r > 0 then
		Say("\167\183 h\228c k\252 n\168ng tri\214u h\229i: " .. PTTH_LIST[k][4] .. ". Ch\228n k\252 n\168ng \235 \171 k\252 n\168ng chu\233t (ho\198c b\182ng k\252 n\168ng) \174\211 d\239ng; n\169ng c\202p b\187ng \174i\211m k\252 n\168ng.", 1, "\167\227ng/PTTH_No")
	elseif r < 0 then
		Say("M\184y ch\241 ch\173a c\227 d\247 li\214u k\252 n\168ng tri\214u h\229i (c\199n c\181i b\182n ptfix m\237i r\229i kh\235i \174\233ng l\185i m\184y ch\241).", 1, "\167\227ng/PTTH_No")
	end
end

function PTTH_LearnAll()
	local ok = 0
	local i = 1
	while PTTH_LIST[i] do
		local r = PTTH_Learn(i)
		if r < 0 then
			Say("M\184y ch\241 ch\173a c\227 d\247 li\214u k\252 n\168ng tri\214u h\229i (c\199n c\181i b\182n ptfix m\237i r\229i kh\235i \174\233ng l\185i m\184y ch\241).", 1, "\167\227ng/PTTH_No")
			return
		end
		ok = ok + r
		i = i + 1
	end
	Say("S\232 k\252 n\168ng tri\214u h\229i v\245a h\228c: " .. ok .. ". Ch\228n k\252 n\168ng \235 \171 k\252 n\168ng chu\233t (ho\198c b\182ng k\252 n\168ng) \174\211 d\239ng; n\169ng c\202p b\187ng \174i\211m k\252 n\168ng.", 1, "\167\227ng/PTTH_No")
end

-- 2026-10-03 (petmorph): VNG summon-beast appearance. task 254 = 2651..2656 (VNG items 6/1/1982-1987
-- store the same value), 0 = default look. Free here; only the look changes, never stats or skills.
function PTTH_MorphName(t)
	local i = 1
	while PTTH_MORPH[i] do
		if PTTH_MORPH[i][1] == t then return PTTH_MORPH[i][2] end
		i = i + 1
	end
	return "H\215nh d\185ng m\198c \174\222nh"
end

function PTTH_MorphMenu()
	if GetProfession() ~= PTTH_PROF then return end
	local cur = GetTask(254)
	if PTTH_IsMorph(cur) == nil then cur = 0 end
	local t = { "<color=yellow>\167\230i h\215nh d\185ng \174\214 t\246<color>: ch\228n h\215nh t\173\238ng Tri\214u H\229i Th\243 nh\173 VNG. Ch\216 \174\230i ngo\185i h\215nh, s\248c m\185nh v\181 k\252 n\168ng c\241a \174\214 t\246 gi\247 nguy\170n. H\215nh hi\214n t\185i: " .. PTTH_MorphName(cur) .. ".", 0 }
	local n = 0
	local i = 1
	while PTTH_MORPH[i] do
		local e = PTTH_MORPH[i]
		n = n + 1
		if e[1] == cur then
			t[n + 2] = e[2] .. " (\174ang d\239ng)" .. "/PTTH_M" .. i
		else
			t[n + 2] = e[2] .. "/PTTH_M" .. i
		end
		i = i + 1
	end
	n = n + 1
	if cur == 0 then
		t[n + 2] = "H\215nh d\185ng m\198c \174\222nh" .. " (\174ang d\239ng)" .. "/PTTH_M0"
	else
		t[n + 2] = "Tr\235 v\210 h\215nh d\185ng m\198c \174\222nh/PTTH_M0"
	end
	n = n + 1 t[n + 2] = "\167\227ng/PTTH_No"
	t[2] = n
	call(Say, t)
end

function PTTH_SetMorph(m)
	if GetProfession() ~= PTTH_PROF then return end
	local tpl = 0
	if m > 0 then
		local e = PTTH_MORPH[m]
		if e == nil then return end
		tpl = e[1]
	end
	SetTask(254, tpl)
	local msg = "\167\183 ch\228n h\215nh d\185ng \174\214 t\246: " .. PTTH_MorphName(tpl) .. "."
	-- token pet: a NEW npc gets the look before its first sync (an in-place change is not redrawn
	-- by clients that already see the npc); stats and skills come from the summon template again
	local idx = PTTH_Owned()
	if idx > 0 then
		local k = PTTH_Find(GetTask(1942))
		if k > 0 and GetLevel() >= PTTH_LIST[k][3] then
			PTTH_Summon(k)
			if PTTH_Owned() > 0 then msg = msg .. " \167\214 t\246 l\214nh b\181i \174\183 \174\173\238c g\228i l\185i v\237i h\215nh m\237i." end
		end
	end
	-- skill pet: KSkill::Cast reapplies task 254 on the next cast; also update the live one (server side)
	if tpl > 0 and SetSummonBeastMorph then SetSummonBeastMorph(tpl) end
	msg = msg .. " \167\214 t\246 g\228i b\187ng k\252 n\168ng s\207 mang h\215nh n\181y t\245 l\199n d\239ng k\252 n\168ng tri\214u h\229i ti\213p theo."
	Say(msg, 1, "\167\227ng/PTTH_No")
end

function PTTH_S1() PTTH_Summon(1) end
function PTTH_S2() PTTH_Summon(2) end
function PTTH_S3() PTTH_Summon(3) end
function PTTH_S4() PTTH_Summon(4) end
function PTTH_S5() PTTH_Summon(5) end
function PTTH_S6() PTTH_Summon(6) end
function PTTH_S7() PTTH_Summon(7) end
function PTTH_S8() PTTH_Summon(8) end
function PTTH_S9() PTTH_Summon(9) end
function PTTH_S10() PTTH_Summon(10) end
function PTTH_S11() PTTH_Summon(11) end
function PTTH_S12() PTTH_Summon(12) end
function PTTH_L1() PTTH_LearnOne(1) end
function PTTH_L2() PTTH_LearnOne(2) end
function PTTH_L3() PTTH_LearnOne(3) end
function PTTH_L4() PTTH_LearnOne(4) end
function PTTH_L5() PTTH_LearnOne(5) end
function PTTH_L6() PTTH_LearnOne(6) end
function PTTH_L7() PTTH_LearnOne(7) end
function PTTH_L8() PTTH_LearnOne(8) end
function PTTH_L9() PTTH_LearnOne(9) end
function PTTH_L10() PTTH_LearnOne(10) end
function PTTH_L11() PTTH_LearnOne(11) end
function PTTH_L12() PTTH_LearnOne(12) end
function PTTH_M0() PTTH_SetMorph(0) end
function PTTH_M1() PTTH_SetMorph(1) end
function PTTH_M2() PTTH_SetMorph(2) end
function PTTH_M3() PTTH_SetMorph(3) end
function PTTH_M4() PTTH_SetMorph(4) end
function PTTH_M5() PTTH_SetMorph(5) end
function PTTH_M6() PTTH_SetMorph(6) end
