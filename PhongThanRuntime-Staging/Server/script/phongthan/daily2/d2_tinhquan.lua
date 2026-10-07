-- Phong Than 2026-10-03 (daily2): Tinh Quan (Trieu Ca 224/190, Tay Ky 178/188) - Thien Cong
-- (taskinfo 56, "Giup thu thap Than khi", 5 vong/ngay, thuong Cap*kinh nghiem, may man Hong thuy tinh).
-- The VNG script of ÐÇ¹Ù is lost. Requests follow the taskinfo steps that name stackable materials
-- (24..28, 30); the phap bao steps 0..5 are not used (equipment cannot be counted/taken safely).
-- Solo-friendly: a request can be changed (fee) or paid in silver instead of items (no lucky gift).
Include("\\script\\phongthan\\daily2\\d2_lib.lua")

PTD2_TC_LEVEL = 40
-- { taskinfo step, material detail (genre 3), count, name, silver instead }
PTD2_TC_REQ = {
	{ 24, 116, 1, "§¹i §Þa nh·n", 30000 },
	{ 25, 117, 1, "Hoµn Quan nh·n", 30000 },
	{ 26, 118, 1, "LiÖt DiÖm nh·n", 30000 },
	{ 27, 119, 1, "Phong B¹o nh·n", 30000 },
	{ 28, 82, 3, "S¬n th¹ch", 20000 },
	{ 30, 3, 50, "§ång thau", 20000 } }
PTD2_TC_REROLL_FEE = 10000
PTD2_TC_EXP = 3000       -- x level

function main()
	PTD2_CheckDay()
	if GetLevel() < PTD2_TC_LEVEL then
		PTD2_Talk("Tinh Quan: Thiªn Cèng lµ viÖc hÖ träng, ®îi ng­¬i ®¹t cÊp " .. PTD2_TC_LEVEL .. " råi h·y ®Õn t×m ta.")
		return
	end
	local r = PTD2_TC_REQ[GetTask(PTD2_T_TC_STEP)]
	local done = GetTask(PTD2_T_TC_DONE)
	if r == nil then
		local opts = {}
		if done < PTD2_MAX.tc then
			opts[1] = "NhËn nhiÖm vô Thiªn Cèng/PTD2_TcAccept"
		end
		opts[getn(opts) + 1] = "Thiªn Cèng lµ g×?/PTD2_TcAbout"
		PTD2_Say("Tinh Quan: Th­îng giíi cÇn thu thËp ThÇn khÝ ®Ó d©ng lªn Thiªn ®×nh. H«m nay ng­¬i ®· gióp ta "
			.. PTD2_ColG .. done .. "/" .. PTD2_MAX.tc .. PTD2_ColE .. " lÇn.", opts)
		return
	end
	local opts = {
		"Giao " .. r[3] .. " " .. r[4] .. "/PTD2_TcGive",
		"Nép " .. r[5] .. " l­îng thay cho vËt phÈm/PTD2_TcPay",
		"§æi yªu cÇu kh¸c (" .. PTD2_TC_REROLL_FEE .. " l­îng)/PTD2_TcReroll",
		"Hñy nhiÖm vô lÇn nµy/PTD2_TcCancel" }
	PTD2_Say("Tinh Quan: Ng­¬i ®· t×m ®­îc " .. PTD2_ColY .. r[3] .. " " .. r[4] .. PTD2_ColE
		.. " cho ta ch­a? (vßng " .. (done + 1) .. "/" .. PTD2_MAX.tc .. ")", opts)
end

function PTD2_TcAbout()
	PTD2_Say("Tinh Quan: Mçi ngµy ng­¬i cã thÓ gióp ta " .. PTD2_MAX.tc .. " lÇn. Mçi lÇn ta cÇn mét lo¹i vËt phÈm: "
		.. "§¹i §Þa nh·n, Hoµn Quan nh·n, LiÖt DiÖm nh·n, Phong B¹o nh·n, 3 S¬n th¹ch hoÆc 50 §ång thau. "
		.. "Hoµn thµnh ®­îc th­ëng kinh nghiÖm theo cÊp, vßng cuèi mçi ngµy tÆng thªm Hång thñy tinh.", { "NhËn nhiÖm vô Thiªn Cèng/PTD2_TcAccept" })
end

function PTD2_TcAccept()
	PTD2_CheckDay()
	if GetTask(PTD2_T_TC_STEP) ~= 0 then main() return end
	if GetTask(PTD2_T_TC_DONE) >= PTD2_MAX.tc then
		PTD2_Talk("Tinh Quan: H«m nay ng­¬i ®· gióp ta ®ñ " .. PTD2_MAX.tc .. " lÇn, ngµy mai h·y quay l¹i.")
		return
	end
	local k = random(1, getn(PTD2_TC_REQ))
	SetTask(PTD2_T_TC_STEP, k)
	local r = PTD2_TC_REQ[k]
	TaskNote(56, r[1])
	PTD2_Talk("Tinh Quan: LÇn nµy h·y t×m gióp ta " .. PTD2_ColY .. r[3] .. " " .. r[4] .. PTD2_ColE .. ".")
end

function PTD2_TcReward(k, viaItems)
	local done = GetTask(PTD2_T_TC_DONE) + 1
	SetTask(PTD2_T_TC_DONE, done)
	local exp = PTD2_Exp(GetLevel() * PTD2_TC_EXP)
	TaskNote(56, 29)
	Msg2Player(PTD2_ColG .. "Thiªn Cèng vßng " .. done .. "/" .. PTD2_MAX.tc .. " hoµn thµnh:" .. PTD2_ColE .. " nhËn " .. exp .. " kinh nghiÖm.")
end

function PTD2_TcGive()
	local k = GetTask(PTD2_T_TC_STEP)
	local r = PTD2_TC_REQ[k]
	if r == nil then main() return end
	local gifts = {}
	local lucky = nil
	if GetTask(PTD2_T_TC_DONE) + 1 >= PTD2_MAX.tc or random(1, 100) <= 10 then
		gifts = { { 3, 28, 0, 0, 0, 0, 1 } }
		lucky = 1
	end
	if not PTD2_GiveGuarded(PTD2_T_TC_STEP, k, 0, { { 3, r[2], 0, 0, 0, 0, r[3] } }, gifts) then
		if HaveNormalItem(3, r[2], 0, -1) < r[3] then
			PTD2_Talk("Tinh Quan: Ng­¬i ch­a mang ®ñ " .. r[3] .. " " .. r[4] .. " (vËt phÈm khãa hoÆc ®Ó trong r­¬ng kh«ng tÝnh).")
		else
			PTD2_Talk("Tinh Quan: Hµnh trang cña ng­¬i kh«ng cßn chç trèng, h·y s¾p xÕp l¹i råi quay l¹i.")
		end
		return
	end
	PTD2_TcReward(k, 1)
	if lucky then Msg2Player("Tinh Quan tÆng thªm 1 Hång thñy tinh.") end
	PTD2_Talk("Tinh Quan: Tèt l¾m, " .. r[4] .. " nµy ®óng lµ thø Thiªn ®×nh cÇn.")
end

function PTD2_TcPay()
	local k = GetTask(PTD2_T_TC_STEP)
	local r = PTD2_TC_REQ[k]
	if r == nil then main() return end
	if GetCash() < r[5] or Pay(r[5]) ~= 1 then
		PTD2_Talk("Tinh Quan: Ng­¬i kh«ng mang ®ñ " .. r[5] .. " l­îng.")
		return
	end
	SetTask(PTD2_T_TC_STEP, 0)
	PTD2_TcReward(k, nil)
	PTD2_Talk("Tinh Quan: §­îc, ta sÏ tù ®i mua " .. r[4] .. ".")
end

function PTD2_TcReroll()
	local k = GetTask(PTD2_T_TC_STEP)
	if k == 0 then main() return end
	if GetCash() < PTD2_TC_REROLL_FEE or Pay(PTD2_TC_REROLL_FEE) ~= 1 then
		PTD2_Talk("Tinh Quan: §æi yªu cÇu cÇn " .. PTD2_TC_REROLL_FEE .. " l­îng.")
		return
	end
	SetTask(PTD2_T_TC_REROLL, GetTask(PTD2_T_TC_REROLL) + 1)
	local n = getn(PTD2_TC_REQ)
	local j = random(1, n - 1)
	if j >= k then j = j + 1 end
	SetTask(PTD2_T_TC_STEP, j)
	local r = PTD2_TC_REQ[j]
	TaskNote(56, r[1])
	PTD2_Talk("Tinh Quan: VËy h·y t×m gióp ta " .. PTD2_ColY .. r[3] .. " " .. r[4] .. PTD2_ColE .. ".")
end

function PTD2_TcCancel()
	if GetTask(PTD2_T_TC_STEP) == 0 then main() return end
	SetTask(PTD2_T_TC_STEP, 0)
	PTD2_Talk("Tinh Quan: §· hñy yªu cÇu lÇn nµy. Ng­¬i cã thÓ nhËn l¹i bÊt cø lóc nµo.")
end
