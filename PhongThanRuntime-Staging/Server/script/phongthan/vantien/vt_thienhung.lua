-- Phong Than 2026-10-02: Thien Hung (Tay Ky), entry NPC of Van Tien tran. Spawned by the minute tick
-- (vt_timer.lua, PTVT_TH[4] = template 202 passerby054, the immortal look of Da Bao Dao Nhan; before
-- 2026-10-02 vantien2 it was 247 = the VNG gate). Solo friendly: a closed tran is opened on demand.
-- 2026-10-02 (vantien2): VNG daily quest chain of Thien Hung (script b5deef29) ported, functions thq_*;
-- data and kill credit in vt_quest.lua, tasks 2006..2013.
Include("\\script\\phongthan\\vantien\\vt_lib.lua")

function main()
	local opts = {}
	local n = 1
	while n <= 4 do
		local lock = ""
		if not PTVT_Unlocked(n) then lock = ", kh\227a" end
		tinsert(opts, "V\185n Ti\170n tr\203n (" .. PTVT_NAME[n] .. ") c\202p " .. PTVT_MINLV[n] .. "+ [" .. PTVT_StateText(n) .. lock .. "]/th_enter" .. n)
		n = n + 1
	end
	if GetLevel() >= PTVT_MINLV[1] then
		if GetTask(PTVT_T_QLV) == 0 then
			tinsert(opts, "Nhi\214m v\244: \174i\210u tra L\244c H\229n Phi\170n/thq_renwu1")
		else
			tinsert(opts, "Nhi\214m v\244 ng\181y V\185n Ti\170n tr\203n/thq_renwu2")
			tinsert(opts, "\167\188ng c\202p V\185n Ti\170n tr\203n/thq_chaxun")
		end
	end
	tinsert(opts, "Gi\237i thi\214u V\185n Ti\170n tr\203n/th_info")
	tinsert(opts, "K\213t th\243c \174\232i tho\185i/no")
	local t = { "<color=green>Thi\170n H\239ng<color>: Th\171ng Thi\170n Gi\184o Ch\241 b\181y V\185n Ti\170n tr\203n, ma ch\243ng l\233ng h\181nh. Ta chi\170u m\233 d\242ng s\220 t\245 c\202p <color=yellow>30<color> v\181o ph\184 tr\203n. Ng\173\172i mu\232n v\181o tr\203n n\181o?", getn(opts) }
	local i = 1
	while opts[i] do
		t[i + 2] = opts[i]
		i = i + 1
	end
	call(Say, t)
end

function th_enter(n)
	CloseDialog()
	PTVT_EnterRequest(n)
end

function th_enter1() th_enter(1) end
function th_enter2() th_enter(2) end
function th_enter3() th_enter(3) end
function th_enter4() th_enter(4) end

function th_info()
	Say("V\185n Ti\170n tr\203n g\229m 4 tr\203n: <color=yellow>Th\230<color> (c\202p 30+), <color=yellow>Th\241y<color> (51+), <color=yellow>H\225a<color> (71+), <color=yellow>Phong<color> (91+). Ph\184 tr\203n tr\173\237c s\207 m\235 kh\227a tr\203n sau d\239 ch\173a \174\241 c\202p. Trong tr\203n: h\185 <color=green>\164 V\169n, C\199u Th\241, Linh Nha, Kim Quang Ti\170n<color> \174\211 l\202y 4 l\214nh, Th\171ng Thi\170n Gi\184o Ch\241 s\207 xu\202t hi\214n \235 Th\199n B\221 Tr\203n \167i\211m (b\173\237c v\181o tr\203n nh\183n v\237i \174\241 4 l\214nh, ho\198c nh\234 \167\185i phu \174\173a v\181o). Ti\170n, Th\171ng Thi\170n v\181 4 B\182o r\173\172ng r\172i v\203t ph\200m theo b\182ng r\172i VNG (v\242 kh\221, ph\184p b\182o, \174\229 ph\230, b\182o th\185ch, th\241y tinh...) th\188ng v\181o h\181nh trang ng\173\234i h\185. M\231i l\173\238t k\208o d\181i " .. floor(PTVT_FIGHT / 60) .. " ph\243t. M\231i ng\181y ta giao m\233t <color=yellow>nhi\214m v\244 V\185n Ti\170n tr\203n<color>: ho\181n th\181nh \174\211 nh\203n kinh nghi\214m, ng\169n l\173\238ng, t\168ng \174\188ng c\202p V\185n Ti\170n tr\203n v\181 nh\203n trang b\222 b\233 \235 \174\188ng c\202p 1, 4, 7, 9.", 2, "Tr\235 l\185i/main", "K\213t th\243c \174\232i tho\185i/no")
end

function no()
	CloseDialog()
end

-- ------------------------------------------------------------------ daily quest chain (VNG b5deef29)
function thq_say(txt)
	Say("<color=green>Thi\170n H\239ng<color>: " .. txt, 2, "Tr\235 l\185i/main", "K\213t th\243c \174\232i tho\185i/no")
end

-- level shown to the player = task value - 1 (VNG chaxun)
function thq_chaxun()
	local v = GetTask(PTVT_T_QLV)
	if v <= 0 then
		thq_say("Ng\173\172i ch\173a nh\203n nhi\214m v\244 V\185n Ti\170n tr\203n n\181o.")
		return
	end
	local lv = v - 1
	local s = "\167\188ng c\202p V\185n Ti\170n tr\203n c\241a ng\173\172i hi\214n l\181 <color=green>" .. lv .. "<color>. "
	if lv >= 10 then
		s = s .. "\167\183 \174\185t \174\188ng c\202p cao nh\202t!"
	elseif v <= PTVT_Q_LEVELREQ[PTVT_QSuit()] then
		s = s .. "Ho\181n th\181nh th\170m <color=green>" .. GetTask(PTVT_T_QNEED) .. "<color> l\199n nhi\214m v\244 V\185n Ti\170n tr\203n n\247a th\215 c\227 th\211 th\168ng c\202p."
	else
		s = s .. "Ng\173\172i ph\182i \174\241 c\202p v\181o <color=green>V\185n Ti\170n tr\203n cao h\172n m\233t b\203c<color> m\237i c\227 th\211 ti\213p t\244c th\168ng c\202p."
	end
	thq_say(s)
end

-- intro quest: investigate the Luc Hon Phien (ask the Dai phu inside the tran)
function thq_renwu1()
	local st = GetTask(PTVT_T_QSTATE)
	if GetTask(PTVT_T_QLV) ~= 0 then
		thq_renwu2()
		return
	end
	if st == 0 then
		Say("<color=green>Thi\170n H\239ng<color>: Tr\168m n\168m tr\173\237c, Phong Th\199n b\182ng hi\214n th\213 d\201n t\237i m\233t tr\203n h\185o ki\213p. Tri\214t Gi\184o c\241a Th\171ng Thi\170n Gi\184o Ch\241 tr\184i \253 tr\234i, l\203p tr\203n ng\168n c\182n vi\214c Phong Th\199n; Xi\211n Gi\184o li\170n th\241 v\237i T\169y Ph\173\172ng gi\184o ch\241 m\237i ph\184 \174\173\238c tr\203n, \174\184nh b\185i Th\171ng Thi\170n. G\199n \174\169y nghe n\227i ph\184p \174\181n c\241a h\190n treo m\233t l\184 c\234 \184c g\228i l\181 <color=green>L\244c H\229n Phi\170n<color>, kh\171ng r\226 nh\187m m\244c \174\221ch g\215. Ng\173\172i gi\243p ta \174i\210u tra lai l\222ch l\184 c\234 n\181y ch\248?", 2, "Nh\203n nhi\214m v\244/thq_yes1", "\167\211 sau/no")
	elseif st == PTVT_Q_DONE then
		SetTask(PTVT_T_QLV, 1)
		SetTask(PTVT_T_QNEED, 1)
		SetTask(PTVT_T_QSTATE, 0)
		AddOwnExp(5000)
		Msg2Player("B\185n nh\203n \174\173\238c 5000 \174i\211m kinh nghi\214m.")
		thq_say("Th\215 ra <color=green>L\244c H\229n Phi\170n<color> kh\171ng c\227 trong V\185n Ti\170n tr\203n, xem ra v\201n ph\182i ti\213p t\244c t\215m ki\213m. Ph\199n th\173\235ng n\181y ng\173\172i h\183y nh\203n l\202y. V\185n Ti\170n tr\203n l\181 n\172i r\204n luy\214n l\253 t\173\235ng; t\245 nay m\231i ng\181y h\183y \174\213n nh\203n <color=yellow>nhi\214m v\244 V\185n Ti\170n tr\203n<color>.")
	else
		thq_say("C\227 th\211 L\244c H\229n Phi\170n n\187m trong V\185n Ti\170n tr\203n. H\183y v\181o tr\203n v\181 t\215m <color=green>\167\185i phu<color> trong \174\227 h\225i xem.")
	end
end

function thq_yes1()
	SetTask(PTVT_T_QSTATE, 1)
	Msg2Player("Ti\213p nh\203n nhi\214m v\244: \174i\210u tra L\244c H\229n Phi\170n trong V\185n Ti\170n tr\203n (h\225i \167\185i phu trong tr\203n).")
	thq_say("C\227 th\211 L\244c H\229n Phi\170n n\187m trong V\185n Ti\170n tr\203n. Tr\173\237c khi \174i\210u tra, t\232t nh\202t h\183y t\215m <color=green>\167\185i phu<color> trong V\185n Ti\170n tr\203n h\225i xem.")
end

-- normal reward of a finished daily quest: 0 = no level change, 1 = level up, 2 = capped by the tran bracket
function thq_reward_normal()
	if GetTask(PTVT_T_QSTATE) ~= PTVT_Q_DONE then return -1 end
	SetTask(PTVT_T_QSTATE, 0)
	local v = GetTask(PTVT_T_QLV)
	if v < 1 then v = 1 end
	if v > 11 then v = 11 end
	local exp = PTVT_Q_REWARD[v][1] * GetLevel() * 2
	local money = PTVT_Q_REWARD[v][2]
	AddOwnExp(exp)
	Earn(money)
	Msg2Player("B\185n nh\203n \174\173\238c " .. money .. " l\173\238ng v\181 " .. exp .. " \174i\211m kinh nghi\214m.")
	if v <= 10 and v <= PTVT_Q_LEVELREQ[PTVT_QSuit()] then
		local need = GetTask(PTVT_T_QNEED) - 1
		if need <= 0 then
			SetTask(PTVT_T_QLV, v + 1)
			SetTask(PTVT_T_QNEED, PTVT_Q_LEVELUP[v])
			return 1
		end
		SetTask(PTVT_T_QNEED, need)
		return 0
	end
	return 2
end

function thq_reward_text(ret)
	local s = "Ng\173\172i \174\183 ho\181n th\181nh nhi\214m v\244, h\183y nh\203n ph\199n th\173\235ng."
	if ret == 1 then
		s = s .. " \167\188ng c\202p V\185n Ti\170n tr\203n c\241a ng\173\172i t\168ng l\170n <color=green>" .. (GetTask(PTVT_T_QLV) - 1) .. "<color>; nhi\214m v\244 sau s\207 kh\227 h\172n nh\173ng ph\199n th\173\235ng nhi\210u h\172n."
	elseif ret == 2 and GetTask(PTVT_T_QLV) <= 10 then
		s = s .. " Ng\173\172i ph\182i \174\241 c\202p v\181o V\185n Ti\170n tr\203n cao h\172n m\233t b\203c m\237i c\227 th\211 t\168ng \174\188ng c\202p V\185n Ti\170n tr\203n."
	end
	return s
end

-- set reward choice (quest level 2 / 5 / 8 / 10 with one quest left): 5 parts, 3 at level 8
function thq_reward_add()
	local v = GetTask(PTVT_T_QLV)
	local idx = PTVT_Q_SETIDX[v]
	local pt = GetPlayerType()
	if not idx or GetTask(PTVT_T_QSTATE) ~= PTVT_Q_DONE then
		CloseDialog()
		return
	end
	if not pt or pt < 0 or pt > 2 then
		thq_say("Kh\171ng x\184c \174\222nh \174\173\238c h\214 ph\184i c\241a ng\173\172i, ch\173a th\211 trao trang b\222.")
		return
	end
	local opts = {}
	local a = 1
	local b = 5
	if v == 8 then
		a = 2
		b = 4
	end
	local i = a
	while i <= b do
		tinsert(opts, PTVT_Q_SETNAME[pt + 1][idx] .. " " .. PTVT_Q_PARTNAME[pt + 1][i] .. "/thq_item" .. i)
		i = i + 1
	end
	tinsert(opts, "\167\211 sau/no")
	local t = { "<color=green>Thi\170n H\239ng<color>: \167\188ng c\202p V\185n Ti\170n tr\203n c\241a ng\173\172i \174\183 \174\185t <color=green>" .. (v - 1) .. "<color>. Ngo\181i ph\199n th\173\235ng l\199n n\181y, ng\173\172i \174\173\238c ch\228n 1 m\227n trang b\222:", getn(opts) }
	i = 1
	while opts[i] do
		t[i + 2] = opts[i]
		i = i + 1
	end
	call(Say, t)
end

function thq_item(i)
	local v = GetTask(PTVT_T_QLV)
	local slv = PTVT_Q_SETLV[v]
	local idx = PTVT_Q_SETIDX[v]
	local pt = GetPlayerType()
	if not slv or GetTask(PTVT_T_QSTATE) ~= PTVT_Q_DONE or GetTask(PTVT_T_QNEED) ~= 1 or GetTask(PTVT_T_QDAY) ~= PTVT_Today() then
		CloseDialog()
		return
	end
	if (v == 8 and (i < 2 or i > 4)) or i < 1 or i > 5 then
		CloseDialog()
		return
	end
	if not pt or pt < 0 or pt > 2 then
		CloseDialog()
		return
	end
	local name = PTVT_Q_SETNAME[pt + 1][idx] .. " " .. PTVT_Q_PARTNAME[pt + 1][i]
	local it = AddNormalItem(0, PTVT_Q_PART[i], pt + 6, slv, 0, 0, 0)
	if not it or it <= 0 then
		thq_say("H\181nh trang c\241a ng\173\172i \174\183 \174\199y, h\183y d\228n b\237t r\229i quay l\185i nh\203n <color=green>" .. name .. "<color>.")
		return
	end
	AddGlobalCountNews("<color=green>" .. (GetName() or "") .. "<color> \174\185t \174\188ng c\202p V\185n Ti\170n tr\203n " .. (v - 1) .. ", \174\173\238c <color=green>Thi\170n H\239ng<color> t\198ng <color=green>" .. name .. "<color>.", 20)
	Msg2Player("Nh\203n \174\173\238c " .. name .. ".")
	local ret = thq_reward_normal()
	thq_say(thq_reward_text(ret))
end

function thq_item1() thq_item(1) end
function thq_item2() thq_item(2) end
function thq_item3() thq_item(3) end
function thq_item4() thq_item(4) end
function thq_item5() thq_item(5) end

-- Thuong Kim Bai: a new daily quest after today's one, max 2 per day
function thq_cost_ib()
	local today = PTVT_Today()
	if GetTask(PTVT_T_QIBDAY) ~= today then
		SetTask(PTVT_T_QIBDAY, today)
		SetTask(PTVT_T_QIBCNT, 0)
	end
	local it = FindAValidIBItem(PTVT_Q_IB[1], PTVT_Q_IB[2], PTVT_Q_IB[3], PTVT_Q_IB[4])
	if not it or it < 1 then
		thq_say("Ng\173\172i kh\171ng c\227 <color=green>Th\173\235ng Kim B\181i<color>.")
		return
	end
	if GetTask(PTVT_T_QIBCNT) >= 2 then
		thq_say("H\171m nay ng\173\172i \174\183 d\239ng 2 l\199n Th\173\235ng Kim B\181i, ng\181y mai h\183y quay l\185i.")
		return
	end
	if GetTask(PTVT_T_QSTATE) ~= 0 or GetTask(PTVT_T_QDAY) ~= today then
		thq_renwu2()
		return
	end
	if CostIBItem(it) ~= 1 then
		thq_say("Kh\171ng d\239ng \174\173\238c Th\173\235ng Kim B\181i.")
		return
	end
	SetTask(PTVT_T_QIBCNT, GetTask(PTVT_T_QIBCNT) + 1)
	SetTask(PTVT_T_QDAY, 0)
	thq_renwu2()
end

function thq_renwu2()
	local today = PTVT_Today()
	local st = GetTask(PTVT_T_QSTATE)
	if GetTask(PTVT_T_QLV) == 0 then
		thq_renwu1()
		return
	end
	if st == 0 then
		if GetTask(PTVT_T_QDAY) == today then
			Say("<color=green>Thi\170n H\239ng<color>: Nhi\214m v\244 h\171m nay ng\173\172i \174\183 ho\181n th\181nh. N\213u c\227 <color=green>Th\173\235ng Kim B\181i<color> c\227 th\211 \174\230i l\202y nhi\214m v\244 m\237i (t\232i \174a 2 l\199n m\231i ng\181y). Ng\173\172i mu\232n d\239ng Th\173\235ng Kim B\181i kh\171ng?", 3, "D\239ng Th\173\235ng Kim B\181i/thq_cost_ib", "Tr\235 l\185i/main", "K\213t th\243c \174\232i tho\185i/no")
			return
		end
		SetTask(PTVT_T_QDAY, today)
		local v = GetTask(PTVT_T_QLV)
		if v > 11 then v = 11 end
		if v == 8 and GetTask(PTVT_T_QNEED) == 1 then
			SetTask(PTVT_T_QCOUNT, 0)
			SetTask(PTVT_T_QSTATE, 10)
			Msg2Player("Nhi\214m v\244 V\185n Ti\170n tr\203n: v\181o tr\203n h\225i \167\185i phu v\210 l\214nh b\181i \174\198c bi\214t.")
			thq_say("V\185n Ti\170n tr\203n c\227 nh\247ng n\172i ng\173\234i th\173\234ng kh\171ng th\211 \174\213n \174\173\238c, mu\232n \174\213n ph\182i c\227 <color=green>l\214nh b\181i \174\198c bi\214t<color>. Nghe n\227i c\227 k\206 \174\183 bi\213n m\202t khi \174\248ng g\199n v\203t t\230 trong \174\227. H\183y v\181o tr\203n h\225i <color=green>\167\185i phu<color>. Mong ng\173\172i b\215nh an tr\235 v\210.")
			return
		end
		local list = PTVT_Q_TASKS[v]
		local pick = list[random(1, getn(list))]
		local kind = pick[1]
		local count = pick[2]
		if kind <= 3 then
			count = floor(count / PTVT_Q_KILL_DIV)
			if count < 1 then count = 1 end
		end
		SetTask(PTVT_T_QCOUNT, count)
		SetTask(PTVT_T_QSTATE, kind)
		Msg2Player("\167\183 nh\203n nhi\214m v\244 V\185n Ti\170n tr\203n, h\185n trong h\171m nay.")
		thq_say("Nhi\214m v\244 l\199n n\181y: v\181o V\185n Ti\170n tr\203n ti\170u di\214t " .. PTVT_QTarget(kind, count) .. ". Ng\173\172i ph\182i ho\181n th\181nh trong <color=red>h\171m nay<color> m\237i nh\203n \174\173\238c ph\199n th\173\235ng.")
		return
	end
	if st == PTVT_Q_DONE then
		if GetTask(PTVT_T_QDAY) ~= today then
			SetTask(PTVT_T_QCOUNT, 0)
			SetTask(PTVT_T_QSTATE, 0)
			thq_say("Nhi\214m v\244 \174\183 qu\184 th\234i h\185n quy \174\222nh, kh\171ng th\211 nh\203n ph\199n th\173\235ng.")
			return
		end
		local v = GetTask(PTVT_T_QLV)
		if GetTask(PTVT_T_QNEED) == 1 and (v == 2 or v == 5 or v == 10) then
			thq_reward_add()
			return
		end
		if GetTask(PTVT_T_QNEED) == 1 and v == 8 then
			SetTask(PTVT_T_QPASS, 1)
			Say("<color=green>Thi\170n H\239ng<color>: Th\215 ra l\181 v\203y! T\245 nay ng\173\172i kh\171ng c\199n l\214nh b\181i c\242ng c\227 th\211 v\181o Th\199n B\221 Tr\203n \167i\211m (nh\234 \167\185i phu trong tr\203n). Ti\170u di\214t Th\171ng Thi\170n Gi\184o Ch\241 l\181 t\169m nguy\214n c\241a m\228i chi\213n binh, \174i hay kh\171ng t\239y ng\173\172i!", 2, "Nh\203n th\173\235ng/thq_reward_add", "\167\211 sau/no")
			return
		end
		local ret = thq_reward_normal()
		thq_say(thq_reward_text(ret))
		return
	end
	-- quest in progress
	if st ~= 1 and GetTask(PTVT_T_QDAY) ~= today then
		SetTask(PTVT_T_QCOUNT, 0)
		SetTask(PTVT_T_QSTATE, 0)
		thq_say("Nhi\214m v\244 \174\183 qu\184 th\234i h\185n quy \174\222nh, kh\171ng th\211 nh\203n ph\199n th\173\235ng. H\183y nh\203n nhi\214m v\244 m\237i.")
		return
	end
	if st == 10 then
		thq_say("H\183y v\181o V\185n Ti\170n tr\203n h\225i <color=green>\167\185i phu<color> v\210 l\214nh b\181i \174\198c bi\214t. Nghe n\227i c\227 k\206 \174\183 bi\213n m\202t khi \174\248ng g\199n v\203t t\230 trong \174\227.")
		return
	end
	local kind = PTVT_QType(st)
	local count = GetTask(PTVT_T_QCOUNT)
	if kind == 8 then count = 4 - PTVT_CountTien(floor(st / 256)) end
	thq_say("Ng\173\172i h\183y \174i ti\170u di\214t " .. PTVT_QTarget(kind, count) .. ". Mau \174i mau v\210!")
end
