-- Phong Than 2026-10-03 (daily3): Luc Lam Hao Han (Tam Son 1016, 1373/3465), the bandit side of Van Luong.
-- VNG \script\\212\203\239\218\\194\204\193\214\186\195\186\186.lua (loose GBK file the engine cannot open) paid robbers who carried the IB buff 302
-- "Luc lam dao tac" (1306 "Kim Bai") after robbing a grain cart: level x random(250,500) luong, x4 for the first
-- robbery of the day, Kim Bai also +2 guild prosperity. Here (no usable IB buffs, see d3_core.lua):
--   * the Hao Han gives a robbery job: an official grain convoy (cart + guards) stops 30-40 cells away; whoever
--     of the team destroys the cart, the job owner gets the flag (task 2318) + the title "Luc Lam Dao Tac"
--     (army convoy from level 50: "Kim Bai Luc Lam Dao Tac"), valid 60 minutes;
--   * back at the Hao Han: the VNG reward, flag and title removed.
-- The map NPC (VNG placement) is re-bound to this file by ext\daily3.lua; ptfix extra_daily3.py also turns the
-- GBK path into a forwarder to this file.
Include("\\script\\phongthan\\daily3\\d3_lib.lua")

PTD3_LL_HEAD = "<color=green>Lôc L©m H¶o H¸n<color>: "

function main()
	PTD3_CheckDay()
	local flag = GetTask(PTD3_T_LL_FLAG)
	if flag > 0 and SystemTime() > GetTask(PTD3_T_LL_EXPIRE) then
		PTD3_LL_DropFlag()
		flag = 0
	end
	local opts = {}
	if flag == 1 then opts[getn(opts) + 1] = "Lôc l©m: giao danh hiÖu Lôc L©m §¹o TÆc nhËn th­ëng/PTD3_LlReward" end
	if flag == 2 then opts[getn(opts) + 1] = "Kim Bµi Lôc L©m §¹o TÆc: nhËn th­ëng/PTD3_LlReward" end
	if GetTask(PTD3_T_LL_JOB) == 1 then
		opts[getn(opts) + 1] = "§oµn xe l­¬ng ë ®©u?/PTD3_LlWhere"
		opts[getn(opts) + 1] = "Bá lÇn chÆn ®­êng nµy/PTD3_LlCancel"
	elseif flag == 0 then
		opts[getn(opts) + 1] = "ChÆn ®­êng c­íp xe l­¬ng quan phñ/PTD3_LlTake1"
		if GetLevel() >= PTD3_LL_LEVEL2 then opts[getn(opts) + 1] = "C­íp xe qu©n l­¬ng TriÒu Ca (khã, Kim Bµi)/PTD3_LlTake2" end
	end
	opts[getn(opts) + 1] = "Lôc l©m lµ g×?/PTD3_LlInfo"
	PTD2_Say(PTD3_LL_HEAD .. "Huynh ®Ö lôc l©m chóng ta chØ c­íp cña quan phñ bÊt nh©n. H«m nay ng­¬i ®· chÆn ®­êng "
		.. PTD2_ColG .. GetTask(PTD3_T_LL_DONE) .. "/" .. PTD3_LL_MAX .. PTD2_ColE .. " lÇn.", opts)
end

function PTD3_LlInfo()
	PTD2_Say(PTD3_LL_HEAD .. "§oµn xe l­¬ng cña quan phñ hay dõng ch©n quanh Tam S¬n. Ph¸ ®­îc xe l­¬ng (®ång ®éi ®¸nh gióp còng tÝnh) th× ng­¬i mang danh hiÖu "
		.. PTD2_ColR .. "Lôc L©m §¹o TÆc" .. PTD2_ColE .. " trong 60 phót. VÒ ®©y gÆp ta nhËn th­ëng: cÊp x 250-500 l­îng, lÇn ®Çu mçi ngµy gÊp 4. "
		.. "Xe qu©n l­¬ng TriÒu Ca cã cÊm qu©n hé tèng (tõ cÊp " .. PTD3_LL_LEVEL2 .. "), ph¸ ®­îc th× thµnh " .. PTD2_ColR .. "Kim Bµi Lôc L©m §¹o TÆc" .. PTD2_ColE .. ", th­ëng gÊp r­ìi vµ l·nh ®Þa thªm 2 ®iÓm H­ng thÞnh.",
		{ "Trë l¹i/main" })
end

function PTD3_LlTake(kind)
	PTD3_CheckDay()
	local need = PTD3_LL_LEVEL
	if kind == 2 then need = PTD3_LL_LEVEL2 end
	if GetLevel() < need then
		PTD2_Talk(PTD3_LL_HEAD .. "Vâ nghÖ cña ng­¬i cßn non, ®¹t cÊp " .. need .. " h·y quay l¹i.")
		return
	end
	if GetTask(PTD3_T_LL_JOB) == 1 or GetTask(PTD3_T_LL_FLAG) > 0 then main() return end
	if GetTask(PTD3_T_LL_DONE) >= PTD3_LL_MAX then
		PTD2_Talk(PTD3_LL_HEAD .. "H«m nay ng­¬i ®· chÆn ®­êng ®ñ " .. PTD3_LL_MAX .. " lÇn, quan phñ ®ang lïng sôc, mai h·y quay l¹i.")
		return
	end
	local m = PTD2_MyPos()
	SetTask(PTD3_T_LL_JOB, 1)
	SetTask(PTD3_T_LL_KIND, kind)
	SetTask(PTD3_T_LL_SPOT, random(1, getn(PTD3_LL_SPOTS)))
	SetTask(PTD3_T_LL_DEADLINE, SystemTime() + PTD3_LL_TIME)
	SetTask(PTD3_T_LL_DONE, GetTask(PTD3_T_LL_DONE) + 1)
	if m == PTD3_LL_MAP then PTD3_LlSpawn() end
	local sp = PTD3_LL_SPOTS[GetTask(PTD3_T_LL_SPOT)]
	local what = "Xe L­¬ng Quan Phñ"
	if kind == 2 then what = "Xe Qu©n L­¬ng TriÒu Ca" end
	if AddNote then AddNote(28, 1, "<color=Yellow>Lôc L©m H¶o H¸n<color>: Ph¸ <color=Red>" .. what .. "<color> ë <color=Green>Tam S¬n " .. PTD2_PosText(sp[1], sp[2]) .. "<color> trong 15 phót.", 0) end
	PTD2_Talk(PTD3_LL_HEAD .. "§oµn " .. PTD2_ColR .. what .. PTD2_ColE .. " ®ang dõng ch©n ë " .. PTD2_ColG .. "Tam S¬n " .. PTD2_PosText(sp[1], sp[2]) .. PTD2_ColE
		.. ". Trong 15 phót ph¸ ®­îc xe l­¬ng th× vÒ ®©y gÆp ta. Coi chõng quan binh hé tèng!")
end

function PTD3_LlTake1()
	PTD3_LlTake(1)
end

function PTD3_LlTake2()
	PTD3_LlTake(2)
end

function PTD3_LlWhere()
	if GetTask(PTD3_T_LL_JOB) ~= 1 then main() return end
	local sp = PTD3_LL_SPOTS[GetTask(PTD3_T_LL_SPOT)] or PTD3_LL_SPOTS[1]
	local left = floor((GetTask(PTD3_T_LL_DEADLINE) - SystemTime() + 59) / 60)
	if left < 0 then left = 0 end
	if PTD2_MyPos() == PTD3_LL_MAP and not PTD3_PackLive(PTD3_CODE_LL) then PTD3_LlSpawn() end
	PTD2_Talk(PTD3_LL_HEAD .. "§oµn xe l­¬ng ë " .. PTD2_ColG .. "Tam S¬n " .. PTD2_PosText(sp[1], sp[2]) .. PTD2_ColE .. ", cßn kho¶ng " .. left .. " phót.")
end

function PTD3_LlCancel()
	if GetTask(PTD3_T_LL_JOB) ~= 1 then main() return end
	PTD3_LL_ClearJob()
	PTD2_Talk(PTD3_LL_HEAD .. "Kh«ng d¸m ra tay th× th«i, lÇn sau h·y m¹nh d¹n h¬n.")
end

function PTD3_LlReward()
	local flag = GetTask(PTD3_T_LL_FLAG)
	if flag == 0 then main() return end
	if SystemTime() > GetTask(PTD3_T_LL_EXPIRE) then
		PTD3_LL_DropFlag()
		PTD2_Talk(PTD3_LL_HEAD .. "Danh hiÖu cña ng­¬i ®· hÕt h¹n, lÇn sau vÒ sím h¬n.")
		return
	end
	local lv = GetLevel()
	local m1 = lv * random(250, 500)
	if flag == 2 then m1 = floor(m1 * 3 / 2) end
	local first = nil
	local d = PTD2_Today()
	if GetTask(PTD3_T_LL_BONUS) ~= d then
		SetTask(PTD3_T_LL_BONUS, d)
		m1 = m1 * 4
		first = 1
	end
	PTD3_LL_DropFlag()
	Earn(m1)
	local name = PTD3_LL_NAMES[flag]
	if first then
		PTD2_Talk(PTD3_LL_HEAD .. "Kh«ng hæ danh " .. name .. "! LÇn chÆn ®­êng ®Çu tiªn h«m nay lµm rÊt tèt, " .. PTD2_ColR .. m1 .. PTD2_ColE .. " l­îng, h·y nhËn chót t©m ý cña ta!")
	else
		PTD2_Talk(PTD3_LL_HEAD .. "Kh«ng hæ danh " .. name .. "! §©y " .. PTD2_ColR .. m1 .. PTD2_ColE .. " l­îng, h·y nhËn chót t©m ý cña ta!")
	end
	if TopMessage then TopMessage("B¹n nhËn ®­îc phÇn th­ëng " .. m1 .. " l­îng.") end
	Msg2Player("B¹n nhËn ®­îc " .. m1 .. " l­îng, ®ång thêi mÊt danh hiÖu " .. name .. ".")
	if AddNote then AddNote(28, 2, "<color=Yellow>Lôc L©m H¶o H¸n<color>: NhiÖm vô hoµn thµnh, nhËn " .. m1 .. " l­îng.", 0) end
	if flag == 2 and IsTongMember and IsTongMember() > 0 and AddTongAttr then
		AddTongAttr(0, 2)
		if Msg2TongMember then Msg2TongMember(GetName() .. " mang danh hiÖu Kim Bµi Lôc L©m §¹o TÆc vÒ cho Lôc L©m H¶o H¸n, l·nh ®Þa nhËn ®­îc 2 ®iÓm H­ng thÞnh.") end
	end
end
