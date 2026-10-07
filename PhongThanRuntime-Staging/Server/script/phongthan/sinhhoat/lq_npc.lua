-- Phong Than 2026-10-03 (sinhhoat): Le Quan (festival official). The VNG scripts \script\<city>\li_guan (Le Quan).lua were
-- 189-byte stubs ("Ta phu trach cong bo cac su kien moi nhat"); the ptfix plug-in extra_sinhhoat.py turns them
-- into forwarders to this file, and script\phongthan\ext\sinhhoat.lua spawns a Le Quan in Tay Ky, Trieu Ca and
-- the 3 newbie villages at the taskinfo positions.
-- Activities (event hours 12:00-13:59 and 19:00-22:59, announced by the ext tick):
--   * daily festival gift (any time, once a day);
--   * Tam Nguyet Ky Son (taskinfo 1029 / 1617): a Hat Giong Ky Son, planted on Ky Son (1017), ripe after 5 min;
--   * Khieu chien cuc han (taskinfo 204 / 1615): a Chien Thu Khieu Chien, right click outside town = 7 challenge
--     boars around the player (lq_chienthu.lua), kill all in 10 min (lq_mob.lua).
Include("\\script\\phongthan\\sinhhoat\\sh_lib.lua")

PTLQ_HEAD = "<color=green>L\212 Quan<color>: "

function main()
	local st = "\167ang \174\227ng (m\235 12:00-13:59 v\181 19:00-22:59)."
	if PTLQ_Open() == 1 then st = "<color=yellow>\167ang m\235!<color>" end
	Say(PTLQ_HEAD .. "L\183o phu ph\244 tr\184ch c\184c l\212 h\233i. Ho\185t \174\233ng l\212 h\233i: " .. st, 7,
		"Nh\203n l\212 v\203t h\187ng ng\181y/PTLQ_Gift",
		"Tam Nguy\214t K\250 S\172n (nh\203n h\185t gi\232ng)/PTLQ_Seed",
		"Khi\170u chi\213n c\249c h\185n/PTLQ_Chal",
		"L\222ch v\181 gi\182i th\221ch ho\185t \174\233ng/PTLQ_Info",
		"Qu\181 \174\168ng nh\203p 7 ng\181y/PTLQ_LoginGift",
		"B\182ng th\181nh t\221ch/PTLQ_Achv",
		"\167\227ng/PTSH_No")
end

function PTLQ_Info()
	Say(PTLQ_HEAD .. "L\212 v\203t h\187ng ng\181y: m\231i ng\181y m\233t l\199n. Tam Nguy\214t K\250 S\172n: nh\203n t\232i \174a " .. PTLQ_SEED_MAX .. " H\185t Gi\232ng K\250 S\172n m\231i ng\181y, \174\213n <color=yellow>K\250 S\172n<color> nh\202p ph\182i \174\211 tr\229ng, 5 ph\243t sau c\169y ch\221n th\215 h\184i qu\182. Khi\170u chi\213n c\249c h\185n: nh\203n Chi\213n Th\173 Khi\170u Chi\213n (t\232i \174a " .. PTLQ_CHAL_MAX .. " m\231i ng\181y), ra ngo\181i th\181nh nh\202p ph\182i, " .. PTLQ_CHAL_KILLS .. " con heo th\246 th\184ch xu\202t hi\214n quanh ng\173\172i, h\185 h\213t trong 10 ph\243t s\207 c\227 th\173\235ng. Ph\199n th\173\235ng c\227 th\211 c\227 Tr\248ng Linh Th\243.", 1, "\167\227ng/PTSH_No")
end

function PTLQ_Gift()
	local d = PTSH_Day()
	if GetTask(PTLQ_T_GIFT) == d then
		Say(PTLQ_HEAD .. "H\171m nay ng\173\172i \174\183 nh\203n l\212 v\203t r\229i.", 1, "\167\227ng/PTSH_No")
		return
	end
	if PTSH_Free() < 3 then
		Say(PTLQ_HEAD .. "C\199n 3 \171 tr\232ng trong h\181nh trang.", 1, "\167\227ng/PTSH_No")
		return
	end
	SetTask(PTLQ_T_GIFT, d)
	local lv = GetLevel()
	local e = lv * lv * 10 + 2000
	AddOwnExp(e)
	PTSH_Give(6, PTLT_I_DON, 0, 2)
	PTSH_Give(3, PTSH_Pick(PTSH_MAT[1][1]), 0, 1)
	Say(PTLQ_HEAD .. "L\212 v\203t h\171m nay: " .. e .. " kinh nghi\214m, 2 Linh Th\243 \167\172n v\181 1 th\182o d\173\238c.", 1, "\167\227ng/PTSH_No")
end

function PTLQ_Seed()
	if PTLQ_Open() == 0 then
		Say(PTLQ_HEAD .. "Tam Nguy\214t K\250 S\172n ch\216 m\235 12:00-13:59 v\181 19:00-22:59.", 1, "\167\227ng/PTSH_No")
		return
	end
	if PTLQ_DayCount(PTLQ_T_SEED) >= PTLQ_SEED_MAX then
		Say(PTLQ_HEAD .. "H\171m nay ng\173\172i \174\183 nh\203n \174\241 " .. PTLQ_SEED_MAX .. " h\185t gi\232ng.", 1, "\167\227ng/PTSH_No")
		return
	end
	if PTSH_Free() < 1 or PTSH_Give(6, PTLQ_I_SEED, 0, 1) < 1 then
		Say(PTLQ_HEAD .. "H\181nh trang \174\183 \174\199y.", 1, "\167\227ng/PTSH_No")
		return
	end
	PTLQ_DayInc(PTLQ_T_SEED)
	local id = PTLQ_TaskId(1029, 1617)
	PTSH_Note(id, "Tam Nguy\214t K\250 S\172n", "Mang H\185t Gi\232ng K\250 S\172n \174\213n K\250 S\172n, nh\202p ph\182i \174\211 tr\229ng; 5 ph\243t sau h\184i qu\182.", 1)
	Say(PTLQ_HEAD .. "\167\169y l\181 m\199m c\169y th\199n b\221 t\245 Thi\170n cung, ch\216 h\238p \174\202t K\250 S\172n. H\183y \174\213n <color=yellow>K\250 S\172n<color> nh\202p ph\182i h\185t gi\232ng \174\211 tr\229ng, 5 ph\243t sau quay l\185i h\184i qu\182.", 1, "\167\227ng/PTSH_No")
end

function PTLQ_Chal()
	local s = PTLQ_ChalRunning()
	if s > 0 then
		local left = PTLQ_CHAL_SEC - (PTSH_Now() - s)
		Say(PTLQ_HEAD .. "Th\246 th\184ch \174ang di\212n ra: \174\183 h\185 " .. GetTask(PTLQ_T_KILL) .. "/" .. PTLQ_CHAL_KILLS .. ", c\223n " .. floor(left / 60) .. " ph\243t.", 2, "B\225 th\246 th\184ch/PTLQ_ChalStop", "\167\227ng/PTSH_No")
		return
	end
	if PTLQ_Open() == 0 then
		Say(PTLQ_HEAD .. "Khi\170u chi\213n c\249c h\185n ch\216 m\235 12:00-13:59 v\181 19:00-22:59.", 1, "\167\227ng/PTSH_No")
		return
	end
	if PTLQ_DayCount(PTLQ_T_CDAY) >= PTLQ_CHAL_MAX then
		Say(PTLQ_HEAD .. "H\171m nay ng\173\172i \174\183 nh\203n \174\241 " .. PTLQ_CHAL_MAX .. " Chi\213n Th\173.", 1, "\167\227ng/PTSH_No")
		return
	end
	if PTSH_Free() < 1 or PTSH_Give(6, PTLQ_I_SCROLL, 0, 1) < 1 then
		Say(PTLQ_HEAD .. "H\181nh trang \174\183 \174\199y.", 1, "\167\227ng/PTSH_No")
		return
	end
	PTLQ_DayInc(PTLQ_T_CDAY)
	local id = PTLQ_TaskId(204, 1615)
	PTSH_Note(id, "Khi\170u chi\213n c\249c h\185n", "Ra ngo\181i th\181nh, nh\202p ph\182i Chi\213n Th\173 Khi\170u Chi\213n r\229i h\185 " .. PTLQ_CHAL_KILLS .. " heo th\246 th\184ch trong 10 ph\243t.", 1)
	Say(PTLQ_HEAD .. "C\199m l\202y <color=yellow>Chi\213n Th\173 Khi\170u Chi\213n<color>. Ra ngo\181i th\181nh nh\202p ph\182i, " .. PTLQ_CHAL_KILLS .. " con heo th\246 th\184ch s\207 xu\202t hi\214n quanh ng\173\172i; h\185 h\213t trong 10 ph\243t \174\211 nh\203n th\173\235ng.", 1, "\167\227ng/PTSH_No")
end

function PTLQ_ChalStop()
	SetTask(PTLQ_T_CHAL, 0)
	SetTask(PTLQ_T_KILL, 0)
	Msg2Player("\167\183 b\225 th\246 th\184ch. Heo th\246 th\184ch s\207 t\249 bi\213n m\202t.")
end

-- 2026-10-04 content E2/E4: daily login gift and achievements board (rows added to main above). The libs
-- are loaded at dialog time (cwd = Server), never at the top level of this script.
function PTLQ_LoginGift()
	if not PTDG_Menu then dofile("script\\phongthan\\content\\dg_lib.lua") end
	if PTDG_Menu then PTDG_Menu() end
end

function PTLQ_Achv()
	if not PTAC_Menu then dofile("script\\phongthan\\content\\ac_lib.lua") end
	if PTAC_Menu then PTAC_Menu() end
end
