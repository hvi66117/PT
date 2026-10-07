-- Phong Than 2026-10-03 (daily3): Nha chiem tinh (Trieu Ca 1724/3018, Tay Ky 1434/3049; taskinfo 71 mappos) -
-- Phuc Kim: "Thap Nhi Tinh Quan giup Tay Vuong Mau thu thap cac loai danh ma, neu nguoi co Ba Lac Nhan mang den cho
-- Tinh Quan se nhan duoc rat nhieu tien thuong". One request at a time: Ba Lac Nhan level 1..5 (material 3/29..33),
-- reward at least the promised van luong (+0..50%). 5 deliveries a day, request change 20.000 luong.
Include("\\script\\phongthan\\daily3\\d3_lib.lua")

function PTD3_PkName(k)
	return "B¸ L¹c Nh·n cÊp " .. k
end

function main()
	PTD3_CheckDay()
	if GetLevel() < PTD3_PK_LEVEL then
		PTD2_Talk("Nhµ chiªm tinh: ThËp NhÞ Tinh Qu©n chØ giao viÖc cho ng­êi tõ cÊp " .. PTD3_PK_LEVEL .. " trë lªn.")
		return
	end
	local k = GetTask(PTD3_T_PK_REQ)
	local done = GetTask(PTD3_T_PK_DONE)
	if k == 0 then
		local opts = {}
		if done < PTD3_PK_MAX then opts[1] = "NhËn nhiÖm vô Phóc Kim/PTD3_PkAccept" end
		opts[getn(opts) + 1] = "B¸ L¹c Nh·n kiÕm ë ®©u?/PTD3_PkInfo"
		PTD2_Say("Nhµ chiªm tinh: ThËp NhÞ Tinh Qu©n ®ang gióp T©y V­¬ng MÉu thu thËp c¸c lo¹i danh m·. Ai mang " .. PTD2_ColG .. "B¸ L¹c Nh·n" .. PTD2_ColE
			.. " ®Õn sÏ nhËn ®­îc " .. PTD2_ColY .. "rÊt nhiÒu tiÒn th­ëng" .. PTD2_ColE .. ". H«m nay ng­¬i ®· giao " .. PTD2_ColG .. done .. "/" .. PTD3_PK_MAX .. PTD2_ColE .. " lÇn.", opts)
		return
	end
	local g = GetTask(PTD3_T_PK_GOLD)
	PTD2_Say("Nhµ chiªm tinh: LÇn nµy ng­¬i ph¶i mang " .. PTD2_ColG .. PTD3_PkName(k) .. PTD2_ColE .. " ®Õn, sÏ nhËn ®­îc Ýt nhÊt "
		.. PTD2_ColG .. g .. PTD2_ColE .. " v¹n l­îng.",
		{ "Giao " .. PTD3_PkName(k) .. "/PTD3_PkGive", "§æi yªu cÇu kh¸c (" .. PTD3_PK_REROLL_COST .. " l­îng)/PTD3_PkReroll", "Hñy nhiÖm vô lÇn nµy/PTD3_PkCancel" })
end

function PTD3_PkInfo()
	PTD2_Say("Nhµ chiªm tinh: B¸ L¹c Nh·n cã 5 cÊp. Hoµng Minh ë TriÒu Ca biÕt dïng B¸ L¹c KÝnh hoµn nguyªn thó c­ìi thµnh B¸ L¹c Nh·n. CÊp cµng cao, Tinh Qu©n tr¶ cµng hËu: "
		.. "cÊp 1 tõ 5 v¹n, cÊp 2 tõ 12 v¹n, cÊp 3 tõ 25 v¹n, cÊp 4 tõ 50 v¹n, cÊp 5 tõ 100 v¹n l­îng.", { "Trë l¹i/main" })
end

function PTD3_PkRoll()
	local r = random(1, 100)
	local k = 5
	if r <= 40 then k = 1 elseif r <= 70 then k = 2 elseif r <= 88 then k = 3 elseif r <= 97 then k = 4 end
	SetTask(PTD3_T_PK_REQ, k)
	SetTask(PTD3_T_PK_GOLD, PTD3_PK_GOLD[k])
	TaskNote(71, 0, PTD3_PkName(k), PTD3_PK_GOLD[k])
	return k
end

function PTD3_PkAccept()
	PTD3_CheckDay()
	if GetTask(PTD3_T_PK_REQ) ~= 0 then main() return end
	if GetLevel() < PTD3_PK_LEVEL then main() return end
	if GetTask(PTD3_T_PK_DONE) >= PTD3_PK_MAX then
		PTD2_Talk("Nhµ chiªm tinh: H«m nay Tinh Qu©n ®· nhËn ®ñ " .. PTD3_PK_MAX .. " lÇn cña ng­¬i, ngµy mai h·y quay l¹i.")
		return
	end
	local k = PTD3_PkRoll()
	PTD2_Talk("Nhµ chiªm tinh: LÇn nµy ng­¬i ph¶i mang " .. PTD2_ColG .. PTD3_PkName(k) .. PTD2_ColE .. " ®Õn cho Tinh Qu©n, sÏ nhËn ®­îc Ýt nhÊt "
		.. PTD2_ColG .. PTD3_PK_GOLD[k] .. PTD2_ColE .. " v¹n l­îng!")
end

function PTD3_PkGive()
	local k = GetTask(PTD3_T_PK_REQ)
	if k < 1 or k > 5 then main() return end
	local g = GetTask(PTD3_T_PK_GOLD)
	if not PTD2_GiveGuarded(PTD3_T_PK_REQ, k, 0, { { 3, 28 + k, 0, 0, 0, 0, 1 } }, {}) then
		PTD2_Talk("Nhµ chiªm tinh: Ng­¬i ch­a cã " .. PTD3_PkName(k) .. ".")
		return
	end
	local bonus = random(0, floor(g / 2))
	local cash = (g + bonus) * 10000
	Earn(cash)
	SetTask(PTD3_T_PK_GOLD, 0)
	local done = GetTask(PTD3_T_PK_DONE) + 1
	SetTask(PTD3_T_PK_DONE, done)
	TaskNote(71, -1)
	Msg2Player(PTD2_ColG .. "Phóc Kim lÇn " .. done .. "/" .. PTD3_PK_MAX .. ":" .. PTD2_ColE .. " giao " .. PTD3_PkName(k) .. ", nhËn " .. cash .. " l­îng.")
	PTD2_Talk("Nhµ chiªm tinh: Tinh Qu©n rÊt hµi lßng. §©y lµ " .. (g + bonus) .. " v¹n l­îng, ng­¬i cÇm lÊy!")
end

function PTD3_PkReroll()
	if GetTask(PTD3_T_PK_REQ) == 0 then main() return end
	if Pay(PTD3_PK_REROLL_COST) ~= 1 then
		PTD2_Talk("Nhµ chiªm tinh: Ng­¬i kh«ng ®ñ " .. PTD3_PK_REROLL_COST .. " l­îng.")
		return
	end
	SetTask(PTD3_T_PK_REROLL, GetTask(PTD3_T_PK_REROLL) + 1)
	PTD3_PkRoll()
	main()
end

function PTD3_PkCancel()
	if GetTask(PTD3_T_PK_REQ) == 0 then main() return end
	SetTask(PTD3_T_PK_REQ, 0)
	SetTask(PTD3_T_PK_GOLD, 0)
	PTD2_Talk("Nhµ chiªm tinh: §· hñy yªu cÇu lÇn nµy.")
end
