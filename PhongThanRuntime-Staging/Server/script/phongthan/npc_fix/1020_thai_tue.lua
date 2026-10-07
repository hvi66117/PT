-- Phong Than npc_fix 2026-09-30: Thai Tue Su (Can Khon Luan), map 1020; original script.pak \script\caipiao\taisui.lua (pinyin of GBK path).
-- changes: Include pt_compat (exit row, multi-use CostIBItem).
-- 2026-10-02: CoreServer has Roulette(k, names) (server-side spin shown as top messages, ~5-6 s; Finished() is
-- called by the engine when the spin stops on sector k; no reward if aborted by logout/death/map change) and
-- RouletteBusy(). On an older engine without Roulette the fallback below gives the reward immediately.
-- 2026-10-03 cankhon2: the "Xoay" row is always shown (below level 40 the NPC explains the level rule);
-- missing Hinh/Cay the than -> explanation (Ky Tran Cac, F2) + money alternative (5/10 van luong);
-- rolling() refuses while a spin runs (no double reward); trace in admin_bridge\cankhon2_trace.log.
-- NPCs: Thai Tue Su (Can Khon Luan) spawned by script\phongthan\ext\cankhon2.lua in Tay Ky + Trieu Ca.
-- 2026-10-04 cankhon3: the buff rewards use the ibitem effects of pt_ibitem_lib.lua (AddIBBuff cast the
-- same-id skill: x2 experience became a marker without end, x1.5 became run speed); danh vong goes to
-- the status page too (AddRepute). Doc: docs\features\can-khon-luan-quay-cpp-phong-than-20261002.md
Include("\\script\\phongthan\\lib\\pt_compat.lua")
Include("\\script\\phongthan\\ibitem\\pt_ibitem_lib.lua")
-- sector names in the order of Finished() (task 72 = k), TCVN3
PT_CKL_NAMES = "Ngò Quû|§¹i Hao|B¹ch Hæ|Thiªn CÈu|B¸ch ViÖt|Tö Vi|Thiªn §øc|Th¸i ¢m|Th¸i D­¬ng|Th¸i TuÕ|TiÓu Hao|DÞch M·"
function PT_CKL_FallbackRoulette(k)
	Finished()
	return 1
end
if not Roulette then
	Roulette = PT_CKL_FallbackRoulette
end
function PT_CKL_Busy()
	if RouletteBusy and RouletteBusy() == 1 then
		Talk(1, "no", "Cµn Kh«n Lu©n ®ang quay, h·y chê kÕt qu¶!")
		return 1
	end
	return nil
end

-- 2026-10-03 cankhon2 ------------------------------------------------------------------
PT_CKL_MINLV = 40
PT_CKL_MONEY1 = 50000    -- spins 2-3 of the day, instead of 1 Hinh the than (8/135, 8/178)
PT_CKL_MONEY2 = 100000   -- spins 4-6 of the day, instead of 1 Cay the than (8/174, 8/179)
PT_CKL_TXT_MONEY1 = "5 v¹n l­îng"
PT_CKL_TXT_MONEY2 = "10 v¹n l­îng"
PT_CKL_TXT_HINH = "ChØ nh©n (H×nh thÕ th©n)"
PT_CKL_TXT_CAY = "Méc nh©n (C©y thÕ th©n)"
PT_CKL_TXT_LV1 = "Cµn Kh«n Lu©n lµ thÇn khÝ th­îng cæ, chØ øng víi ng­êi tõ <color=green>cÊp 40<color> trë lªn. Ng­¬i míi cÊp <color=red>"
PT_CKL_TXT_LV2 = "<color>, h·y luyÖn thªm råi quay l¹i t×m ta!"
PT_CKL_TXT_NEED1 = "H«m nay ng­¬i ®· xoay <color=red>"
PT_CKL_TXT_NEED2 = "<color> lÇn. L­ît tiÕp theo cÇn 1 <color=green>"
PT_CKL_TXT_NEED3 = "<color> ®Ó hÊp thu chÊn ®éng cña Cµn Kh«n Lu©n. Kh«ng cã th× ta nhËn <color=yellow>"
PT_CKL_TXT_NEED4 = "<color> thay cho nã."
PT_CKL_TXT_PAY1 = "Tr¶ "
PT_CKL_TXT_PAY2 = " ®Ó xoay"
PT_CKL_TXT_HOWTO = "C¸ch cã "
PT_CKL_TXT_LATER = "§Ó lóc kh¸c"
PT_CKL_TXT_NOMONEY1 = "Ng­¬i kh«ng mang ®ñ <color=yellow>"
PT_CKL_TXT_NOMONEY2 = "<color>, Cµn Kh«n Lu©n ch­a thÓ chuyÓn ®éng!"
PT_CKL_TXT_MAX = "H«m nay ng­¬i ®· xoay ®ñ <color=red>6 lÇn<color>, thÓ chÊt ®· yÕu, Cµn Kh«n Lu©n kh«ng thÓ chuyÓn ®éng thªm. Ngµy mai h·y quay l¹i!"
PT_CKL_TXT_HOW1 = "L­ît ®Çu tiªn mçi ngµy <color=green>miÔn phÝ<color>. L­ît 2-3 cÇn 1 <color=green>ChØ nh©n<color> (H×nh thÕ th©n), l­ît 4-6 cÇn 1 <color=green>Méc nh©n<color> (C©y thÕ th©n), mçi ngµy tèi ®a 6 l­ît."
PT_CKL_TXT_HOW2 = "ChØ nh©n vµ Méc nh©n b¸n ë <color=yellow>Kú Tr©n C¸c<color> (nhÊn F2), gi¸ 1 xu mçi c¸i; lo¹i 9-10 xu (hiÖu qu¶ cao h¬n) còng dïng ®­îc. Kh«ng cã vËt phÈm th× tr¶ <color=yellow>5 v¹n l­îng<color> (l­ît 2-3) hoÆc <color=yellow>10 v¹n l­îng<color> (l­ît 4-6) ®Ó ta gióp xoay."
PT_CKL_TXT_MENU_HOW = "VËt phÈm ®Ó xoay mua ë ®©u?"

-- 2026-10-04 cankhon3 ------------------------------------------------------------------
-- VNG AddIBBuff(id) = the effect of ibitem 8/id: 12 Dao Linh tan (life regen +10, 1 h), 13 Dao To tan
-- (mana regen +10, 1 h), 175 Nhan doi diem kinh nghiem (+100 %, 1 h), 176 Nhan 1.5 diem kinh nghiem
-- (+50 %, 2 h). The engine (ScriptFuns.cpp ApplyNativeIBBuffState) casts the SKILL with that id instead:
-- 12 passive skill, 13 attack skill, 175 Thai Nguyen Dan marker that never ends, 176 Thai Ngu Dan (run
-- speed). Rewards now use pt_ibitem_lib.lua (experience: tasks 1906-1908, regen: generic slots 1921-1938;
-- servertimer PTAdm_IbTick re-applies after a stat recompute and expires them).
PT_CKL_GEN_LIFE = "Dao Linh t\184n"
PT_CKL_GEN_MANA = "Dao T\244 t\184n"
PT_CKL_OLDIB = { 12, 13, 175, 176 }
PT_CKL_TXT_EXP = "HiÖu qu¶ kinh nghiÖm +"
PT_CKL_TXT_LIFE = "Håi sinh lùc +10"
PT_CKL_TXT_MANA = "Håi néi lùc +10"
PT_CKL_TXT_LEFT = ", thêi h¹n cßn "
PT_CKL_TXT_NONE = "HiÖn ng­¬i ch­a cã hiÖu qu¶ nµo cña Cµn Kh«n Lu©n."
PT_CKL_TXT_HAVE = "HiÖu qu¶ ®ang cã: "
PT_CKL_TXT_REP1 = "B¹n nhËn ®­îc "
PT_CKL_TXT_REP2 = " ®iÓm danh väng, hiÖn cã "
PT_CKL_TXT_REP3 = "Danh väng hiÖn cã: "

-- the ibitem effect library (Included at the top; loaded again at call time if that failed)
function PT_CKL_Lib()
	if not PTIB_Refresh and Include then Include("\\script\\phongthan\\ibitem\\pt_ibitem_lib.lua") end
	if PTIB_Refresh and PTIB_GrantGen and PTIB_GenId and PTIB_TimeText then return 1 end
	return nil
end

-- wrong IB states left by the old rewards (removed on the next spin of this player)
function PT_CKL_PurgeOldIB()
	if not HaveIBBuff or not RemoveIBBuff then return end
	local k = 1
	while PT_CKL_OLDIB[k] do
		if HaveIBBuff(PT_CKL_OLDIB[k]) == 1 then RemoveIBBuff(PT_CKL_OLDIB[k]) end
		k = k + 1
	end
end

-- experience buff in the single ibitem slot; never weaker or shorter than promised, never takes
-- away a running buff: same or stronger buff running -> + secs; weaker running -> new % until
-- max(old end, now + secs). Returns the seconds left.
function PT_CKL_ExpBuff(secs, pct)
	local now = SystemTime()
	local e = GetTask(PTIB_T_EXP_END)
	if e <= now then
		SetTask(PTIB_T_EXP_END, now + secs)
		SetTask(PTIB_T_EXP_PCT, pct)
		SetTask(PTIB_T_EXP_SKILL, 0)
	elseif GetTask(PTIB_T_EXP_PCT) >= pct then
		SetTask(PTIB_T_EXP_END, e + secs)
	else
		SetTask(PTIB_T_EXP_PCT, pct)
		if e < now + secs then SetTask(PTIB_T_EXP_END, now + secs) end
	end
	PTIB_Refresh()
	return GetTask(PTIB_T_EXP_END) - now
end

-- seconds left of a generic ibitem buff (by ibitem name), 0 when not running
function PT_CKL_GenLeft(name)
	local gid = PTIB_GenId(name)
	if not gid then return 0 end
	local now = SystemTime()
	local k = 0
	while k < PTIB_GEN_SLOTS do
		local e = GetTask(PTIB_T_GEN + 2 * k + 1)
		if GetTask(PTIB_T_GEN + 2 * k) == gid and e > now then return e - now end
		k = k + 1
	end
	return 0
end

-- buff sectors: 1 Dai Hao, 2 Bach Ho, 5 Tu Vi, 9 Thai Tue. Returns 1 when the effect is on.
function PT_CKL_Reward(k)
	if not PT_CKL_Lib() then PT_CKL_Trace("reward k=" .. k .. " no pt_ibitem_lib") return 0 end
	local left = 0
	local txt = ""
	if k == 1 or k == 2 then
		local name = PT_CKL_GEN_LIFE
		txt = PT_CKL_TXT_LIFE
		if k == 2 then name = PT_CKL_GEN_MANA txt = PT_CKL_TXT_MANA end
		local gid = PTIB_GenId(name)
		if gid then left = PTIB_GrantGen(gid, 3600) end
	elseif k == 5 then
		left = PT_CKL_ExpBuff(3600, 100)
		txt = PT_CKL_TXT_EXP .. GetTask(PTIB_T_EXP_PCT) .. "%"
	elseif k == 9 then
		left = PT_CKL_ExpBuff(7200, 50)
		txt = PT_CKL_TXT_EXP .. GetTask(PTIB_T_EXP_PCT) .. "%"
	end
	PT_CKL_Trace("reward k=" .. k .. " left=" .. left)
	if left <= 0 then return 0 end
	Msg2Player(txt .. PT_CKL_TXT_LEFT .. PTIB_TimeText(left))
	return 1
end

-- danh vong: the status page shows Repute (task 210). engine2 2026-10-04: AddCredit/GetCredit use the same task 210
-- now (CoreServer engine2, the old credit wallet is moved into it once), so ONE call: AddCredit too would count twice
function PT_CKL_Repute(n)
	if AddRepute then AddRepute(n) end
	local r = 0
	if GetRepute then r = GetRepute() or 0 end
	Msg2Player(PT_CKL_TXT_REP1 .. n .. PT_CKL_TXT_REP2 .. r .. ".")
end

function PT_CKL_Effects()
	local s = ""
	if not PT_CKL_Lib() then return "" end
	local now = SystemTime()
	local e = GetTask(PTIB_T_EXP_END)
	if e > now then s = s .. PT_CKL_TXT_EXP .. GetTask(PTIB_T_EXP_PCT) .. "%" .. PT_CKL_TXT_LEFT .. PTIB_TimeText(e - now) .. " " end
	local l = PT_CKL_GenLeft(PT_CKL_GEN_LIFE)
	if l > 0 then s = s .. PT_CKL_TXT_LIFE .. PT_CKL_TXT_LEFT .. PTIB_TimeText(l) .. " " end
	l = PT_CKL_GenLeft(PT_CKL_GEN_MANA)
	if l > 0 then s = s .. PT_CKL_TXT_MANA .. PT_CKL_TXT_LEFT .. PTIB_TimeText(l) .. " " end
	if s == "" then s = PT_CKL_TXT_NONE else s = PT_CKL_TXT_HAVE .. s end
	local r = 0
	if GetRepute then r = GetRepute() or 0 end
	return s .. " " .. PT_CKL_TXT_REP3 .. r .. "."
end

function PT_CKL_Trace(s)
	if not openfile or not date then return end
	local h = openfile("admin_bridge\\cankhon2_trace.log", "a")
	if not h then return end
	local eng = "cpp"
	if Roulette == PT_CKL_FallbackRoulette then eng = "fallback" end
	local w = 0
	if GetWorldPos then w = GetWorldPos() end
	write(h, date("%Y-%m-%d %H:%M:%S") .. "\t" .. (GetName() or "") .. "\t" .. s .. "\tmap=" .. (w or 0) .. "\tn764=" .. GetTask(764) .. "\troulette=" .. eng .. "\n")
	closefile(h)
end

function PT_CKL_LowLevel()
	Talk(1, "no", PT_CKL_TXT_LV1 .. GetLevel() .. PT_CKL_TXT_LV2)
end

function PT_CKL_Cost(c)
	if c <= 2 then return PT_CKL_MONEY1 end
	return PT_CKL_MONEY2
end

function PT_CKL_CostTxt(c)
	if c <= 2 then return PT_CKL_TXT_MONEY1 end
	return PT_CKL_TXT_MONEY2
end

function PT_CKL_NeedItem(c)
	local item = PT_CKL_TXT_HINH
	if c > 2 then item = PT_CKL_TXT_CAY end
	local ct = PT_CKL_CostTxt(c)
	Say(PT_CKL_TXT_NEED1 .. c .. PT_CKL_TXT_NEED2 .. item .. PT_CKL_TXT_NEED3 .. ct .. PT_CKL_TXT_NEED4, 3,
		PT_CKL_TXT_PAY1 .. ct .. PT_CKL_TXT_PAY2 .. "/PT_CKL_PayMoney",
		PT_CKL_TXT_HOWTO .. item .. "/PT_CKL_HowTo",
		PT_CKL_TXT_LATER .. "/no")
end

function PT_CKL_HowTo()
	Talk(2, "no", PT_CKL_TXT_HOW1, PT_CKL_TXT_HOW2)
end

function PT_CKL_SameDay()
	if ceil(GetTask(73) / 86400) == ceil(SystemTime() / 86400) then return 1 end
	return nil
end

function PT_CKL_PayMoney()
	if PT_CKL_Busy() then return end
	if GetLevel() < PT_CKL_MINLV then PT_CKL_LowLevel() return end
	if not PT_CKL_SameDay() then
		yes_3()   -- a new day started meanwhile: the spin is free
		return
	end
	local c = GetTask(764)
	if c >= 6 then
		Talk(1, "no", PT_CKL_TXT_MAX)
		return
	end
	local cost = PT_CKL_Cost(c)
	if GetCash() < cost or Pay(cost) ~= 1 then
		Talk(1, "no", PT_CKL_TXT_NOMONEY1 .. PT_CKL_CostTxt(c) .. PT_CKL_TXT_NOMONEY2)
		return
	end
	PT_CKL_Trace("pay money " .. cost)
	rolling()
end

--description: Ì«ËêÖ®ÂÖ¡ª¡ªÌ«ËêÖ®ÂÖ
--author:chensong
--date: 2004/7/14
--11079	#Ì«ËêÊ¦£ºÌ«ËêÖ®ÂÖÊÇÉÏ¹ÅÕ½ÕùÒÅÁôÏÂÀ´µÄÉñÆ÷£¬Í¨¹ýËüÄÜÖªµÀÒ»¸ö?µÄÎ´À´¡£µ±ÄãµÈ¼¶´ïµ½40¼¶ÒÔºó,Äã¾Í¿ÉÒÔÊÔ×Å×ª¶¯Ëü¿´¿´ÄãµÄÔËÊÆ±ä»¯£¡
--11080	#Ì«ËêÊ¦£ºÕâ¸öÊÇÉÏ¹ÅÕ½ÕùÒÅÁôÏÂÀ´µÄÉñÆ÷£¬Í¨¹ýËüÄÜÖªµÀÒ»¸ö?µÄÎ´À´¡£¿ÉÏ§Äã·¥ÖÊ»¹²î£¬¾­ÊÜ²»³ÑÉñÆ÷ÁéÁ¦µÄ³å»÷¡£Äã»¹ÊÇÒÔºó²]À´°É£¡
--11081	#Ì«ËêÊ¦£ºÌ«ËêÖ®ÂÖ·ÖÎªÊ®¶þ²¿·Ö£¬·Ö±ð´ú±íÎå¹í¡¢´óºÄ¡¢°×»¢¡¢Ìì¹·¡¢°ÙÔ½¡¢×ÏÎ¢¡¢ÌìµÂ¡¢Ì«Òõ¡¢Ì«Ñô¡¢Ì«Ëê¡¢Ð¡ºÄ¡¢æäÂí£¡
--11082	#Ì«ËêÊ¦£ºÒ»¸ö?×ª¶¯Ì«ËêÖ®ÂÖ£¬µ±ÂÖÉÏµÄºì¹â×îºóÖ¸ÏòÄ³Ò»²¿·Ö£¬Õâ¸ö²¿·Ö¾Í´ú±í³ÑÕâ¸ö?ÔÚÎ´À´Ò»¶ÎÊ±¼äÄÚ»á·¢ÉúµÄÒ»Ð©ÊÂ¡£ÌýÆðÀ´ÊÇ²»ÊÇºÜ²»¿ÉË¼Òé£¬Òª²»ÒªÊÔÊÔ£¿
--11083	#Ì«ËêÊ¦£ºÄã½ñÌìÒÑ¾­³ÐÊÜ³ÑÒ»´ÎÌ«ËêÖ®ÂÖµÄÁéÁ¦³å»÷³Ñ£¬¹ýÒ»ÈÕÉí·¥»Ö¸´³Ñ²]À´°É£¡
--11084	#Ì«ËêÊ¦£ºÄãµÄ·¥ÖÊ»¹ºÜ?£¬¾­ÊÜ²»ÆðÌ«ËêÖ®ÂÖµÄÁéÁ¦³å»÷£¬»¹ÊÇ¹ýÐ©ÈÕ×Ó£¬µÈÄã25¼¶³Ñ²]À´°É£¡
--11085	#Ì«ËêÊ¦£ºÄã×ª¶¯µ½µÄÊÇÎå¹í£¬Äã¿ÉÒÔÖØÐÂ×ª¶¯Ò»´ÎÌ«ËêÖ®ÂÖ¡£
--11086	#Ì«ËêÊ¦£ºÄã×ª¶¯µ½µÄÊÇ´óºÄ£¬Äã½«ÔÚÎ´À´1Ð¡Ê±ÄÚ»ñµÃ¼ÓËÙÉúÃü»Ø¸´ËÙ¶È10µÄ×´Ì¬¡£ÇëÄãºÃºÃ¼ÓÒÔÀûÓÃ¡£
--11088	#Ì«ËêÊ¦£ºÄã×ª¶¯µ½µÄÊÇ°×»¢£¬Äã½«ÔÚÎ´À´1Ð¡Ê±ÄÚ»ñµÃ¼ÓËÙÄÚÁ¦»Ø¸´ËÙ¶È10µÄ×´Ì¬¡£ÇëÄãºÃºÃ¼ÓÒÔÀûÓÃ¡£
--11089	#Ì«ËêÊ¦£ºÄã×ª¶¯µ½µÄÊÇÌì¹·£¬Äã½«»ñµÃ10µÄÉùÍûÖµ£¬ÇëÄãºÃºÃ¼ÓÒÔÀûÓÃ¡£
--11091	#Ì«ËêÊ¦£ºÄã×ª¶¯µ½µÄÊÇ°ÙÔ½£¬Äã½«»ñµÃ15µÄÉùÍûÖµ£¬ÇëÄãºÃºÃ¼ÓÒÔÀûÓÃ¡£
--11092	#Ì«ËêÊ¦£ºÄã×ª¶¯µ½µÄÊÇ×ÏÎ¢£¬Äã½«»ñµÃÔÚÎ´À´1Ð¡Ê±ÄÚ¾­ÑéÖµ2±¶µÄ×´Ì¬¡£ÇëÄãºÃºÃ¼ÓÒÔÀûÓÃ¡£
--11093	#Ì«ËêÊ¦£ºÄã×ª¶¯µ½µÄÊÇÌìµÂ£¬Äã½«Ò»´ÎÐÔ»ñµÃ50000½ðÇ®¡£
--11097	#Ì«ËêÊ¦£ºÄã×ª¶¯µ½µÄÊÇÌ«Òõ£¬ÄãÊÜÌ«ÒõÉñµÄ¸£Ôó£¬½«Ò»´ÎÐÔ»ñµÃ20000½ðÇ®¡£
--11098	#Ì«ËêÊ¦£ºÄã×ª¶¯µ½µÄÊÇÌ«Òõ£¬±¾Ó¦ÊÜµ½Ì«ÒõÉñµÄ¸£Ôó»ñµÃ20000½ðÇ®£¬µ«ÊÇÄãÊÇÄÐµÄ£¬ËùÒÔÖ»ÄÜºÍ»ñ?Ò»°ëµÄ¸£ÔË£¬­âÊÇ¿ÉÏ§¡£
--11099	#Ì«ËêÊ¦£ºÄã×ª¶¯µ½µÄÊÇÌ«Ñô£¬ÄãÊÜÌ«ÑôÉñµÄ¸£Ôó£¬½«Ò»´ÎÐÔ»ñµÃ20000½ðÇ®¡£
--11100	#Ì«ËêÊ¦£ºÄã×ª¶¯µ½µÄÊÇÌ«Ñô£¬±¾Ó¦ÊÜµ½Ì«ÑôÉñµÄ¸£Ôó»ñµÃ20000½ðÇ®£¬µ«ÊÇÄãÊÇÅ®µÄ£¬ËùÒÔÖ»ÄÜºÍ»ñ?Ò»°ëµÄ¸£ÔË£¬­âÊÇ¿ÉÏ§¡£
--11101	#Ì«ËêÊ¦£ºÄã×ª¶¯µ½µÄÊÇÌ«Ëê£¬Äã½«»ñµÃÔÚÎ´À´2Ð¡Ê±ÄÚ¾­ÑéÖµ1.5±¶µÄ×´Ì¬¡£ÇëÄãºÃºÃ¼ÓÒÔÀûÓÃ¡£
--11103	#Ì«ËêÊ¦£ºÄã×ª¶¯µ½µÄÊÇÐ¡ºÄ£¬Äã½«Ò»´ÎÐÔ»ñµÃ30000¾­Ñé¡£
--11104	#Ì«ËêÊ¦£ºÄã×ª¶¯µ½µÄÊÇæäÂí£¬ËùÎ½ºÃÔËµ±Í·£¬¹§Ï²Äã£¬Äã»ñµÃ³Ñ10Íò¾­Ñé°¡£¡
--764,¼ÇÂ¼µ±Ìì×ª¶¯´ÎÊý



function main()
	local UTask_cp_2=GetTask(72)
	tasks = 
			{
			 {"Xoay Cµn Kh«n lu©n","yes_2";show=1},
			 {"Cµn Kh«n Lu©n","yes_1";show=1},
			 {"H×nh thÕ th©n","zhiren";show=1},
			 {"C©y ThÕ th©n","muren";show=1},
			 {PT_CKL_TXT_MENU_HOW,"PT_CKL_HowTo";show=1}
			}
	if(GetLevel()>=40)then
		tasks[1].show=1
	end;
	SayTask(11079,tasks)
end;

function muren()
	Talk(2,"no","Cµn Kh«n Lu©n lµ thÇn khÝ th­îng cæ, tuy h×nh thÕ th©n cã thÓ gióp ng­¬i høng chÞu nh­ng mçi lÇn chuyÓn ®éng søc Ðp t¨ng thªm ta e h×nh thÕ th©n còng kh«ng gióp ®­îc g×!","<color=green>C©y ThÕ th©n<color> cã thÓ høng chÞu søc Ðp lín. Mçi ngµy chØ sö dông ®­îc <color=green>3 lÇn<color> mµ th«i!")
end

function zhiren()
	Talk(2,"no","Cµn Kh«n Lu©n lµ thÇn khÝ th­îng cæ, chuyÓn ®éng 1 lÇn sÏ tiªu hao nguyªn thÇn cña ng­¬i, mét ngµy sau míi håi phôc. Nh­ng ta cã c¸ch gióp ng­¬i quay Cµn Kh«n Lu©n nhiÒu lÇn trong 1 ngµy. Cã muèn thö kh«ng?","Lóc Cµn Kh«n Lu©n chuyÓn ®éng ph¶i cã vËt hÊp thu chÊn ®éng cña nã, <color=green>H×nh thÕ th©n<color> cã thÓ gióp ng­¬i høng chÞu søc m¹nh Êy nh÷ng mçi ngµy chØ dïng ®­îc <color=green>2 lÇn<color> mµ th«i!")
end

function yes_1()
	Talk(3,"no","Cµn Kh«n Lu©n chia lµm 12 phÇn gåm <color=green>Ngò Quû, §¹i Hao, B¹ch Hæ, Thiªn CÈu, B¸ch ViÖt, Tö Vi, Thiªn §øc, Th¸i D­¬ng, Th¸i ¢m, Th¸i TuÕ, TiÓu Hao, DÞch M·<color>!","Cµn Kh«n Lu©n lµ thÇn khÝ l­u l¹i tõ thêi th­îng cæ cã thÓ gióp con ng­êi biÕt ®­îc t­¬ng lai. Khi ng­¬i ®¹t <color=green>cÊp 40<color> cã thÓ thö xoay ®Ó xem sè mÖnh cña m×nh.", PT_CKL_Effects())
end;

function yes_2()
	if PT_CKL_Busy() then return end
	if GetLevel() < PT_CKL_MINLV then PT_CKL_LowLevel() return end
	local count = GetIBBuffCount()
	if(count<16)then
		MsgBox(11082,"yes_3","no")
	else
		Talk(1,"no","Tr¹ng th¸i cña ng­¬i kh«ng phï hîp ¶nh h­ëng ®Õn sù ph¸n ®o¸n cña Cµn Kh«n Lu©n. NÕu muèn thö l¹i t¾t bá nh÷ng tr¹ng th¸i Êy!")
	end
end;

function yes_3()
	if PT_CKL_Busy() then return end
	if GetLevel() < PT_CKL_MINLV then PT_CKL_LowLevel() return end
	if not PT_CKL_SameDay() then
		SetTask(764, 0)
		PT_CKL_Trace("free spin")
		rolling()
		return
	end
	local c = GetTask(764)
	if c >= 6 then
		Talk(1, "no", PT_CKL_TXT_MAX)
		return
	end
	local a, m
	if c <= 2 then
		a = FindAValidIBItem(8, 135, 2, 0)
		m = FindAValidIBItem(8, 178, 2, 0)
	else
		a = FindAValidIBItem(8, 174, 2, 0)
		m = FindAValidIBItem(8, 179, 2, 0)
	end
	if a and a ~= 0 then
		CostIBItem(a)
		PT_CKL_Trace("pay item")
		rolling()
	elseif m and m ~= 0 then
		CostIBItem(m)
		PT_CKL_Trace("pay item+")
		rolling()
	else
		PT_CKL_NeedItem(c)
	end
end

function rolling()
	if PT_CKL_Busy() then return end
	local UTask_cp_2=GetTask(72)
	local buytime=GetTask(73)
	local LastBuyTime = GetTask(73) -- ×îºóÒ»´Î¹ººjÊ±¼ä
	local NowBuyTime = SystemTime()    -- ÏÖÔÚÊ±¼ä
	local t = random(1,100)  -- Éú³ÉÖÐ½±ºÅ
	local k = 0
	if(t<=10)then
		k=0
	elseif(t<=19)then
		k=1
	elseif(t<=28)then
		k=2
	elseif(t<=37)then
		k=3
	elseif(t<=48)then
		k=4
	elseif(t<=55)then
		k=5
	elseif(t<=62)then
		k=6
	elseif(t<=72)then
		k=7
	elseif(t<=82)then
		k=8
	elseif(t<=89)then
		k=9
	elseif(t<=99)then
		k=10
	else
		k=11
	end
	CloseDialog()
	SetTask(73,NowBuyTime) -- ³É¹¦Ê±¼ÇÂ¼ÏÂ×îºóÒ»´Î¹ººjÊ±¼ä
	SetTask(72,k) 
	SetTask(764,GetTask(764)+1)
	PT_CKL_Trace("spin k=" .. k)
	if not Roulette(k, PT_CKL_NAMES) then
		Finished() -- engine refused the spin: give the reward now
	end -- ¿Í»§¶Ë´ò¿ª½çÃæ
end;

function Finished() -- ¿Í»§¶Ë²Ù×÷Íê±Ï
	PT_CKL_Trace("finished k=" .. GetTask(72))
	PT_CKL_PurgeOldIB()
	local UTask_cp_2=GetTask(72)
	local NowTime=SystemTime()
	local UTask_cp_time=GetTask(75)
	local NowTime=SystemTime()
	local Name=GetName()
	local UTask_jingyan=GetTask(8)
	local addexp=GetLevel()*100
	AddOwnExp(addexp)
	TopMessage("Mçi vßng nhËn ®­îc <color=green>"..addexp.."®iÓm kinh nghiÖm.")
	if (UTask_cp_2==0) then
		SetTask(764,GetTask(764)-1)
		MsgBox("Ng­¬i ®· quay ®Õn <color=green>Ngò Quû<color>, cã thÓ quay l¹i mét lÇn!","rolling","no")
		Msg2Player("B¹n nhËn ®­îc thªm 1 l­ît quay")
	elseif (UTask_cp_2==1) then
		local i=PT_CKL_Reward(1)
		if(i==1)then
			Talk(1,"no","Ng­¬i ®· quay ®Õn <color=green>§¹i Hao<color>, nhËn ®­îc: håi sinh lùc + 10 ®iÓm trong 1 giê. H·y tËn dông dÞp may cña m×nh!")
			Msg2Player("B¹n nhËn ®­îc håi sinh lùc + 10 ®iÓm trong 1 giê. ")
		else
			Talk(1,"no","Tr¹ng th¸i cña ng­¬i ®· x¶y ra xung ®ét kh«ng thÓ ph¸t huy t¸c dông!")
		end
	elseif (UTask_cp_2==2) then
		local i=PT_CKL_Reward(2)
		if(i==1)then
			Talk(1,"no","Ng­¬i ®· quay ®Õn <color=green>B¹ch Hæ<color>, nhËn ®­îc Håi Néi lùc + 10 ®iÓm trong 1 giê. H·y tËn dông dÞp may cña m×nh!")
			Msg2Player("B¹n nhËn ®­îc: Håi Néi lùc + 10 ®iÓm trong 1 giê. ")
		else
			Talk(1,"no","Tr¹ng th¸i cña ng­¬i ®· x¶y ra xung ®ét kh«ng thÓ ph¸t huy t¸c dông!")
		end
	elseif (UTask_cp_2==3) then
		Talk(1,"no","B¹n ®· quay ®Õn <color=green>Thiªn CÈu<color>, nhËn ®­îc 15 ®iÓm danh väng.") 
		PT_CKL_Repute(15)
		Msg2Player("B¹n nhËn ®­îc 15 ®iÓm danh väng.")
	elseif (UTask_cp_2==4) then
		Talk(1,"no","B¹n ®· quay ®Õn <color=green>B¸ch ViÖt<color>, nhËn ®­îc 10 ®iÓm danh väng.") 
		PT_CKL_Repute(10)
		Msg2Player("B¹n nhËn ®­îc 10 ®iÓm danh väng.")
	elseif (UTask_cp_2==5) then
		local i=PT_CKL_Reward(5)
		if(i==1)then
			Talk(1,"no","Ng­¬i ®· quay ®Õn <color=green>Tö Vi<color>, nhËn ®­îc nh©n ®«i kinh nghiÖm trong 1 giê.")
			Msg2Player("B¹n nhËn ®­îc nh©n ®«i kinh nghiÖm trong 1 giê.")
		else
			Talk(1,"no","Tr¹ng th¸i cña ng­¬i ®· x¶y ra xung ®ét kh«ng thÓ ph¸t huy t¸c dông!")
		end
	elseif (UTask_cp_2==6) then
		Talk(1,"no","Ng­¬i ®· quay ®Õn <color=green>Thiªn §øc<color>, nhËn ®­îc 5 v¹n l­îng.")
		Earn(50000)
		Msg2Player("B¹n nhËn ®­îc 5 v¹n l­îng.")
	elseif (UTask_cp_2==7) then
		if (GetSex()==1) then
			Earn(20000)
			Talk(1,"no","Ng­¬i ®· quay ®Õn <color=green>Th¸i ¢m<color>, nhËn ®­îc phóc tr¹ch cña Th¸i ¢m thÇn vµ 2 v¹n l­îng.")
			Msg2Player("B¹n nhËn ®­îc 2 v¹n l­îng.")
		else
			Earn(10000)
			Talk(1,"no","Ng­¬i ®· quay ®Õn <color=green>Th¸i ¢m<color>, nhËn ®­îc phóc tr¹ch cña Th¸i ¢m thÇn vµ 2 v¹n l­îng. §¸ng tiÕc b¹n lµ nam nªn chØ nhËn ®­îc mét n÷a phóc tr¹ch!")
			Msg2Player("B¹n nhËn ®­îc 1w l­îng.")
		end;
	elseif (UTask_cp_2==8) then
		if (GetSex()==0) then
			Earn(20000)
			Talk(1,"no","Ng­¬i ®· quay ®Õn <color=green>Th¸i D­¬ng<color>, nhËn ®­îc phóc tr¹ch cña Th¸i D­¬ng thÇn vµ 2 v¹n l­îng.")
			Msg2Player("B¹n nhËn ®­îc 2 v¹n l­îng.")
		else
			Earn(10000)
			Talk(1,"no","Ng­¬i ®· quay ®Õn <color=green>Th¸i D­¬ng<color>, nhËn ®­îc phóc tr¹ch cña Th¸i D­¬ng thÇn vµ 2 v¹n l­îng. §¸ng tiÕc b¹n lµ n÷ chØ nhËn ®­îc mét n÷a phóc tr¹ch.")
			Msg2Player("B¹n nhËn ®­îc 1w l­îng.")
		end;
	elseif (UTask_cp_2==9) then
		local i=PT_CKL_Reward(9)
		if(i==1)then
			Talk(1,"no","Ng­¬i ®· quay ®Õn <color=green>Th¸i TuÕ<color>,  nhËn ®­îc  nh©n 1.5 kinh nghiÖm trong 2 giê.")
			Msg2Player("B¹n nhËn ®­îc nh©n 1.5 kinh nghiÖm trong 2 giê.")
		else
			Talk(1,"no","Tr¹ng th¸i cña ng­¬i ®· x¶y ra xung ®ét kh«ng thÓ ph¸t huy t¸c dông!")
		end
	elseif (UTask_cp_2==10) then
		Talk(1,"no","B¹n ®· quay ®Õn<color=green>TiÓu Hao<color>,  nhËn ®­îc 3 v¹n ®iÓm kinh nghiÖm.")
		AddOwnExp(30000)
		Msg2Player("B¹n nhËn ®­îc 3 v¹n ®iÓm kinh nghiÖm.")
	else
		Talk(1,"no","Ng­¬i ®· quay ®Õn <color=green>DÞch M·<color>,  nhËn ®­îc <color=yellow>10 v¹n ®iÓm kinh nghiÖm<color>!")
		AddOwnExp(100000)
		AddGlobalCountNews("Lóc Cµn Kh«n Lu©n chuyÓn ®éng, <color=green>"..GetName().."<color> nhËn ®­îc <color=yellow>10w ®iÓm kinh nghiÖm<color>, xem ra vËn may cña b¹n ®· ®Õn!",3)
		Msg2Player("B¹n nhËn ®­îc 10w ®iÓm kinh nghiÖm.")
	end;
	SetTask(72,0) 
end;

function no()
		CloseDialog()
end;






