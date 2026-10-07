-- Phong Than 2026-10-03 (daily2): Tap Thuong (beside the Tap hoa of Sung Thanh, Ngoc Hu, Xi Vuu, Tay Ky,
-- Trieu Ca) - Nhiem vu van chuyen (taskinfo 61, 7 vong/ngay, thuong Cap*kinh nghiem + tien, may man
-- Manh Lam thuy tinh). Not the Van Luong / Van Tieu system (agent vantieu): a city-to-city delivery.
-- The merchant hands over his city's specialty (a stackable material) against a deposit; the merchant
-- of the destination city takes the goods, refunds the deposit and pays the reward.
Include("\\script\\phongthan\\daily2\\d2_lib.lua")

PTD2_VC_LEVEL = 10
PTD2_VC_EXP = 1500       -- x level
PTD2_VC_CASH = 60        -- x level

function PTD2_VcDecode(info)
	local dest = floor(info / 100000)
	local goods = floor(mod(info, 100000) / 1000)
	local cnt = mod(info, 1000)
	return dest, goods, cnt
end

function main()
	PTD2_CheckDay()
	local m = PTD2_MyPos()
	local city = PTD2_CityIdx(m)
	if city == 0 then city = 1 end
	local cname = PTD2_VC_CITIES[city][2]
	if GetLevel() < PTD2_VC_LEVEL then
		PTD2_Talk(cname .. "-T¹p th­¬ng: §­êng xa nguy hiÓm, ®îi ng­¬i ®¹t cÊp " .. PTD2_VC_LEVEL .. " h·y gióp ta vËn chuyÓn hµng.")
		return
	end
	local info = GetTask(PTD2_T_VC_INFO)
	local done = GetTask(PTD2_T_VC_DONE)
	if info == 0 then
		local opts = {}
		if done < PTD2_MAX.vc then opts[1] = "NhËn nhiÖm vô vËn chuyÓn/PTD2_VcAccept" end
		PTD2_Say(cname .. "-T¹p th­¬ng: Mçi thµnh thÞ cã ®Æc s¶n riªng, ta th­êng nhê ng­êi mang hµng tíi c¸c t¹p th­¬ng kh¸c. H«m nay ng­¬i ®· gióp "
			.. PTD2_ColG .. done .. "/" .. PTD2_MAX.vc .. PTD2_ColE .. " chuyÕn.", opts)
		return
	end
	local dest, goods, cnt = PTD2_VcDecode(info)
	local dn = PTD2_VC_CITIES[dest]
	local g = PTD2_VC_GOODS[goods]
	if not dn or not g then SetTask(PTD2_T_VC_INFO, 0) main() return end
	if dest == city then
		PTD2_Say(cname .. "-T¹p th­¬ng: Ng­¬i mang " .. cnt .. " " .. g[2] .. " tíi cho ta ®Êy µ?",
			{ "Giao " .. cnt .. " " .. g[2] .. "/PTD2_VcDeliver", "Hñy nhiÖm vô (mÊt tiÒn cäc)/PTD2_VcCancel" })
		return
	end
	PTD2_Say(cname .. "-T¹p th­¬ng: " .. dn[2] .. "-T¹p th­¬ng ®ang chê " .. PTD2_ColG .. cnt .. PTD2_ColE .. " " .. PTD2_ColR .. g[2] .. PTD2_ColE
		.. ". Giao xong sÏ ®­îc hoµn " .. (cnt * PTD2_VC_DEPOSIT) .. " l­îng tiÒn cäc.", { "Hñy nhiÖm vô (mÊt tiÒn cäc)/PTD2_VcCancel" })
end

function PTD2_VcAccept()
	PTD2_CheckDay()
	if GetTask(PTD2_T_VC_INFO) ~= 0 then main() return end
	if GetTask(PTD2_T_VC_DONE) >= PTD2_MAX.vc then
		PTD2_Talk("T¹p th­¬ng: H«m nay ng­¬i ®· gióp ®ñ " .. PTD2_MAX.vc .. " chuyÕn, ngµy mai h·y quay l¹i.")
		return
	end
	local m = PTD2_MyPos()
	local city = PTD2_CityIdx(m)
	if city == 0 then city = 1 end
	local n = getn(PTD2_VC_CITIES)
	local dest = random(1, n - 1)
	if dest >= city then dest = dest + 1 end
	local goods = city
	local cnt = random(3, 5)
	local dep = cnt * PTD2_VC_DEPOSIT
	if GetCash() < dep or Pay(dep) ~= 1 then
		PTD2_Talk("T¹p th­¬ng: Muèn nhËn hµng ph¶i ®Æt cäc " .. dep .. " l­îng.")
		return
	end
	local info = dest * 100000 + goods * 1000 + cnt
	local g = PTD2_VC_GOODS[goods]
	if not PTD2_GiveGuarded(PTD2_T_VC_INFO, 0, info, {}, { { 3, g[1], 0, 0, 0, 0, cnt } }) then
		Earn(dep)
		PTD2_Talk("T¹p th­¬ng: Hµnh trang cña ng­¬i cÇn " .. cnt .. " « trèng ®Ó chøa hµng. TiÒn cäc ®· tr¶ l¹i.")
		return
	end
	SetTask(PTD2_T_VC_FROM, city)
	local dn = PTD2_VC_CITIES[dest][2]
	TaskNote(61, 1, dn, cnt, g[2])
	PTD2_Talk("T¹p th­¬ng: §©y lµ " .. cnt .. " " .. g[2] .. ", h·y mang tíi " .. PTD2_ColG .. dn .. "-T¹p th­¬ng" .. PTD2_ColE
		.. ". Ta ®· gi÷ " .. dep .. " l­îng tiÒn cäc, giao hµng xong sÏ ®­îc hoµn l¹i.")
end

function PTD2_VcDeliver()
	local info = GetTask(PTD2_T_VC_INFO)
	if info == 0 then main() return end
	local dest, goods, cnt = PTD2_VcDecode(info)
	local m = PTD2_MyPos()
	if PTD2_CityIdx(m) ~= dest then main() return end
	local g = PTD2_VC_GOODS[goods]
	local done = GetTask(PTD2_T_VC_DONE) + 1
	local gifts = {}
	local lucky = nil
	if done >= PTD2_MAX.vc or random(1, 100) <= 15 then
		gifts = { { 3, 78, 0, 0, 0, 0, 1 } }
		lucky = 1
	end
	if not PTD2_GiveGuarded(PTD2_T_VC_INFO, info, 0, { { 3, g[1], 0, 0, 0, 0, cnt } }, gifts) then
		if HaveNormalItem(3, g[1], 0, -1) < cnt then
			PTD2_Talk("T¹p th­¬ng: Hµng ch­a ®ñ, ta cÇn " .. cnt .. " " .. g[2] .. ".")
		else
			PTD2_Talk("T¹p th­¬ng: Hµnh trang cña ng­¬i kh«ng cßn chç trèng, h·y s¾p xÕp l¹i råi quay l¹i.")
		end
		return
	end
	SetTask(PTD2_T_VC_DONE, done)
	SetTask(PTD2_T_VC_FROM, 0)
	local lv = GetLevel()
	local cash = cnt * PTD2_VC_DEPOSIT + lv * PTD2_VC_CASH
	Earn(cash)
	local exp = PTD2_Exp(lv * PTD2_VC_EXP)
	TaskNote(61, -1)
	Msg2Player(PTD2_ColG .. "VËn chuyÓn chuyÕn " .. done .. "/" .. PTD2_MAX.vc .. " hoµn thµnh:" .. PTD2_ColE .. " nhËn " .. exp .. " kinh nghiÖm, " .. cash .. " l­îng (gåm tiÒn cäc).")
	if lucky then Msg2Player("PhÇn th­ëng may m¾n: 1 M¶nh Lam thñy tinh.") end
	PTD2_Talk("T¹p th­¬ng: Hµng tíi ®óng lóc l¾m, ®a t¹ ng­¬i!")
end

function PTD2_VcCancel()
	if GetTask(PTD2_T_VC_INFO) == 0 then main() return end
	SetTask(PTD2_T_VC_INFO, 0)
	SetTask(PTD2_T_VC_FROM, 0)
	PTD2_Talk("T¹p th­¬ng: §· hñy chuyÕn hµng, tiÒn cäc kh«ng ®­îc hoµn l¹i (hµng ng­¬i cø gi÷).")
end
