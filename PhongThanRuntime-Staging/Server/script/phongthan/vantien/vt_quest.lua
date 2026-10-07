-- Phong Than 2026-10-02 (agent vantien2): Thien Hung daily quest chain, port of the VNG script b5deef29
-- ("Van Tien tran linh nhiem vu xu", lixuewu). Shared data + kill credit, included by vt_lib.lua, so the
-- boss / mob / Dai phu scripts can credit the quest. The dialog lives in vt_thienhung.lua.
-- VNG used tasks 405..409, bit 1 of 404 and 767/768; the loose VNG npcdeath scripts of templates 53..60
-- still touch 407..409, so the port uses the Van Tien task range 2006..2013 instead:
PTVT_T_QLV = 2006      -- VNG 405: Van Tien level + 1 (0 = intro not done, 1 = level 0 ... 11 = level 10)
PTVT_T_QNEED = 2007    -- VNG 406: quests still needed for the next level
PTVT_T_QCOUNT = 2008   -- VNG 407: kills left (quest type 2 / 3)
PTVT_T_QSTATE = 2009   -- VNG 408: 0 none, 1 intro (ask the Dai phu), 2 / 3 kill mobs, 4..7 kill tien k-3,
                       --          8 + 256 * mask kill the 4 tien, 9 Thong Thien, 10 ask the Dai phu, 100000 done
PTVT_T_QDAY = 2010     -- VNG 409: day (YYYYMMDD) of the current daily quest
PTVT_T_QPASS = 2011    -- VNG 404 bit 1: 1 = Dai phu may send the player to Than Bi Tran Diem without the 4 lenh
PTVT_T_QIBDAY = 2012   -- VNG 767: day of the Thuong Kim Bai counter
PTVT_T_QIBCNT = 2013   -- VNG 768: Thuong Kim Bai used today (max 2)
PTVT_Q_DONE = 100000
PTVT_Q_KILL_DIV = 5    -- solo balance: VNG asked 50..500 kills, here 10..100 (12 mobs per tran, they revive)
PTVT_Q_IB = {8, 138, 2, 0}    -- Thuong Kim Bai (IB item): resets the daily quest, max 2 per day

-- VNG tables (index = value of PTVT_T_QLV)
PTVT_Q_REWARD = {{400,5000},{500,5000},{500,5000},{600,5000},{600,10000},{700,10000},
	{700,20000},{800,20000},{800,30000},{900,40000},{1000,50000}}
PTVT_Q_LEVELUP = {3,5,8,12,18,25,35,50,100,0}
PTVT_Q_LEVELREQ = {2,5,8,10}                -- max quest level per tran bracket (player level 30/51/71/91+)
PTVT_Q_TASKS = {
	{{2,50}},{{2,100}},{{2,100},{3,100}},{{4,1},{5,1},{6,1},{7,1}},
	{{2,150},{3,150}},{{2,200},{3,200},{4,1},{5,1},{6,1},{7,1}},{{2,300},{3,300}},
	{{2,400},{3,400},{8,1},{9,1}},{{2,500},{3,500},{8,1},{9,1}},
	{{2,500},{3,500},{8,1},{9,1}},{{2,500},{3,500},{8,1},{9,1}}
}
-- set reward: quest level -> item level / set index (VNG task_lvl_2_sel_lvl / sel_idx)
PTVT_Q_SETLV = {[2] = 3, [5] = 5, [8] = 7, [10] = 9}
PTVT_Q_SETIDX = {[2] = 1, [5] = 2, [8] = 3, [10] = 4}
PTVT_Q_PART = {2, 5, 6, 7, 9}               -- detail: armor, boot, belt, helm, pendant (item 0, d, type + 6, lv)
PTVT_Q_SETNAME = {
	{"V\242 Kh\243c", "Tinh Cang", "Khai Thi\170n", "Ch\202n \167\184n"},
	{"X\221ch T\239ng", "Th\184i \202t", "Th\171ng Thi\170n", "H\229ng Qu\169n"},
	{"B\184o Th\199n", "Gi\184c Th\243", "Lam \167i\170u", "Kh\184ng Long"}
}
PTVT_Q_PARTNAME = {
	{"Gi\184p", "Chi\213n Ngoa", "Y\170u \167\184i", "Kh\171i", "Phi Phong"},
	{"\167\185o B\181o", "L\253", "C\169n", "Qu\184n", "L\214nh"},
	{"H\233 Gi\184p", "Ngoa", "Y\170u \167\184i", "Tr\244", "K\213t"}
}
-- quest target names: [2] / [3] by tran bracket (mob templates 53/55/57/59 and 54/56/58/60)
PTVT_Q_MOBNAME = {
	[2] = {{"Thi\213t Tr\239ng", "sinh l\249c r\202t m\185nh, h\233 gi\184p L\171i y\213u"}, {"Ng\228c N\247", "sinh l\249c r\202t m\185nh, h\233 gi\184p Th\230 y\213u"}, {"Lam C\232t", "sinh l\249c v\181 t\202n c\171ng c\172 b\182n cao"}, {"\167\237i Tr\185i", "sinh l\249c v\181 ph\223ng th\241 ma ph\184p cao"}},
	[3] = {{"Phi Gi\184p", "sinh l\249c v\181 t\202n c\171ng c\172 b\182n cao"}, {"D\183 Mao", "sinh l\249c r\202t cao, h\233 gi\184p H\225a y\213u"}, {"Ma N\247", "sinh l\249c r\202t m\185nh, kh\171ng d\212 ph\184t hi\214n"}, {"L\244c Ng\171 Th\199n", "sinh l\249c v\181 ph\223ng th\241 ma ph\184p cao"}}
}

function PTVT_QSuit()
	local lv = GetLevel()
	if lv > 90 then return 4 end
	if lv > 70 then return 3 end
	if lv > 50 then return 2 end
	return 1
end

function PTVT_QType(state)
	return mod(state or 0, 256)
end

-- text of a quest target (kind 2..9), count included when > 1
function PTVT_QTarget(kind, count)
	local s = "<color=red>"
	if count and count > 1 then s = s .. count .. " " end
	if kind == 2 or kind == 3 then
		local m = PTVT_Q_MOBNAME[kind][PTVT_QSuit()]
		return s .. m[1] .. "<color> (" .. m[2] .. ")"
	end
	if kind >= 4 and kind <= 7 then
		return s .. PTVT_BOSS_NAME[kind - 3] .. "<color> (m\233t trong t\248 ti\170n c\241a V\185n Ti\170n tr\203n, r\202t gi\225i ma ph\184p)"
	end
	if kind == 8 then
		return s .. "4 ti\170n th\241 tr\203n<color> (\164 V\169n, C\199u Th\241, Linh Nha, Kim Quang Ti\170n; n\170n l\203p \174\233i c\239ng t\184c chi\213n)"
	end
	return s .. PTVT_BOSS_NAME[5] .. "<color> (\174\248ng \174\199u ma ch\243ng trong V\185n Ti\170n tr\203n, ph\184p l\249c v\171 bi\170n)"
end

-- 1 = the daily quest of the current player is still valid today; otherwise it is cleared (VNG: expired)
function PTVT_QAlive()
	if GetTask(PTVT_T_QDAY) == PTVT_Today() then return 1 end
	SetTask(PTVT_T_QCOUNT, 0)
	SetTask(PTVT_T_QSTATE, 0)
	Msg2Player("Nhi\214m v\244 V\185n Ti\170n tr\203n \174\183 qu\184 h\185n, h\183y g\198p Thi\170n H\239ng nh\203n nhi\214m v\244 m\237i.")
	return nil
end

function PTVT_QFinish(txt)
	SetTask(PTVT_T_QCOUNT, 0)
	SetTask(PTVT_T_QSTATE, PTVT_Q_DONE)
	Msg2Player(txt .. " H\183y v\210 g\198p Thi\170n H\239ng (T\169y K\250) nh\203n th\173\235ng.")
end

-- kill of a quest mob (kind 2 / 3) for the current player
function PTVT_QMob(kind)
	if GetTask(PTVT_T_QSTATE) ~= kind then return 0 end
	if not PTVT_QAlive() then return 0 end
	local c = GetTask(PTVT_T_QCOUNT)
	if c <= 0 then return 0 end
	c = c - 1
	SetTask(PTVT_T_QCOUNT, c)
	local nm = PTVT_Q_MOBNAME[kind][PTVT_QSuit()][1]
	if c == 0 then
		PTVT_QFinish("Ho\181n th\181nh nhi\214m v\244 di\214t " .. nm .. ".")
	else
		Msg2Player("Nhi\214m v\244 V\185n Ti\170n tr\203n: c\223n ph\182i di\214t " .. c .. " " .. nm .. ".")
	end
	return 1
end

-- kill of tien k (1..4) for the current player
function PTVT_QTien(k)
	local st = GetTask(PTVT_T_QSTATE)
	local t = PTVT_QType(st)
	if t == k + 3 then
		if not PTVT_QAlive() then return 0 end
		PTVT_QFinish("Ho\181n th\181nh nhi\214m v\244 h\185 " .. PTVT_BOSS_NAME[k] .. ".")
		return 1
	end
	if t == 8 and st ~= PTVT_Q_DONE then
		if not PTVT_QAlive() then return 0 end
		local mask = floor(st / 256)
		local b = PTVT_Pow2(k)
		if PTVT_Bit(mask, b) == 0 then mask = mask + b end
		local c = PTVT_CountTien(mask)
		if c >= 4 then
			PTVT_QFinish("\167\183 h\185 \174\241 4 ti\170n th\241 tr\203n.")
		else
			SetTask(PTVT_T_QSTATE, 8 + mask * 256)
			Msg2Player("Nhi\214m v\244 V\185n Ti\170n tr\203n: \174\183 h\185 " .. PTVT_BOSS_NAME[k] .. ", c\223n " .. (4 - c) .. " ti\170n th\241 tr\203n.")
		end
		return 1
	end
	return 0
end

function PTVT_QTT()
	if GetTask(PTVT_T_QSTATE) ~= 9 then return 0 end
	if not PTVT_QAlive() then return 0 end
	PTVT_QFinish("\167\183 chi\213n th\190ng Th\171ng Thi\170n Gi\184o Ch\241.")
	return 1
end

-- Dai phu inside the tran: intro (1) and the level 8 "special token" quest (10). 1 = done now.
function PTVT_QDoctor()
	local st = GetTask(PTVT_T_QSTATE)
	if st == 1 then
		SetTask(PTVT_T_QSTATE, PTVT_Q_DONE)
		Msg2Player("\167\185i phu: L\244c H\229n Phi\170n kh\171ng c\227 trong V\185n Ti\170n tr\203n. H\183y v\210 b\184o cho Thi\170n H\239ng.")
		return 1
	end
	if st == 10 then
		if not PTVT_QAlive() then return 0 end
		SetTask(PTVT_T_QSTATE, PTVT_Q_DONE)
		SetTask(PTVT_T_QPASS, 1)
		Msg2Player("\167\185i phu: v\203t t\230 trong tr\203n \174\173a ng\173\234i t\237i Th\199n B\221 Tr\203n \167i\211m. T\245 nay ta c\227 th\211 \174\173a ng\173\172i v\181o \174\227 kh\171ng c\199n l\214nh b\181i. H\183y v\210 b\184o cho Thi\170n H\239ng.")
		return 1
	end
	return 0
end

-- credit a quest mob kill to the kill owner and his team members standing on the same map
function PTVT_QMobCredit(kind, w)
	local owner = PlayerIndex
	local seen = {}
	if owner and owner > 0 then
		seen[owner] = 1
		PTVT_QMob(kind)
		PlayerIndex = owner
		if GetTeam() then
			local size = GetTeamSize() or 0
			local i = 1
			while i <= size do
				PlayerIndex = owner
				local pi = GetTeamMember(i)
				if pi and pi > 0 and not seen[pi] then
					seen[pi] = 1
					PlayerIndex = pi
					local mw = GetWorldPos()
					if mw == w then PTVT_QMob(kind) end
				end
				i = i + 1
			end
		end
	end
	PlayerIndex = owner
end

-- LastDamage of a tran mob (templates 53..60, spawned by PTVT_InitMission)
function PTVT_MobDeath(ni)
	local tpl = GetNpcTemplateID(ni)
	if not tpl or tpl < 53 or tpl > 60 then return 0 end
	local w = GetNpcWorldPos(ni)
	if not PTVT_MapToN(w) then return 0 end
	local kind = 3
	if mod(tpl, 2) == 1 then kind = 2 end
	PTVT_QMobCredit(kind, w)
	return kind
end
