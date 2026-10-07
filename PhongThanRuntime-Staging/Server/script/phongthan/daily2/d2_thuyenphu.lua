-- Phong Than 2026-10-03 (daily2): Thuyen phu (Dong Doanh 1055 222/197, Phuong Truong 1056 225/199) -
-- Hap Hon Am Sat (taskinfo 70, 4 vong/ngay, thuong kinh nghiem + Chan Thien Tien hoac Tam Tiem Xoa).
-- VNG: the Hap Hon Phu (6/1/344, Îü»ê·û.lua) raised a Hap Hon Tran (templates 672..676) on the island
-- and the souls of one of six island spirits were drawn while it stood. Here the Thuyen phu raises the
-- trËn at the island's field spot; the six "Am Hon" monsters are counted by daily2\d2_mob.lua.
Include("\\script\\phongthan\\daily2\\d2_lib.lua")

PTD2_HH_LEVEL = 80
PTD2_HH_EXP = 5000       -- x level

function PTD2_HhIsland()
	local m = PTD2_MyPos()
	if m == 1056 then return 2 end
	return 1
end

function PTD2_HhInfo()
	local info = GetTask(PTD2_T_HH_INFO)
	return PTD2_HH_TARGETS[floor(info / 10)], PTD2_HH_ISLANDS[mod(info, 10)]
end

function main()
	PTD2_CheckDay()
	local here = PTD2_HhIsland()
	local other = 3 - here
	local ferry = "§­a ta sang ®¶o " .. PTD2_HH_ISLANDS[other][2] .. "/PTD2_HhFerry"
	if GetLevel() < PTD2_HH_LEVEL then
		PTD2_Say("ThuyÒn phu: ¢m khÝ trªn ®¶o rÊt nÆng, ®îi ng­¬i ®¹t cÊp " .. PTD2_HH_LEVEL .. " h·y nhËn viÖc HÊp Hån.", { ferry })
		return
	end
	local st = GetTask(PTD2_T_HH_STATE)
	local done = GetTask(PTD2_T_HH_DONE)
	if st == 0 then
		local opts = {}
		if done < PTD2_MAX.hh then opts[1] = "NhËn nhiÖm vô HÊp Hån ¢m S¸t/PTD2_HhAccept" end
		opts[getn(opts) + 1] = ferry
		PTD2_Say("ThuyÒn phu: Dïng HÊp Hån TrËn cã thÓ ®o¹t hån cña yªu qu¸i trªn ®¶o. H«m nay ng­¬i ®· lµm "
			.. PTD2_ColG .. done .. "/" .. PTD2_MAX.hh .. PTD2_ColE .. " lÇn.", opts)
		return
	end
	local t, isl = PTD2_HhInfo()
	if st == 1 and t and isl then
		PTD2_Say("ThuyÒn phu: Ng­¬i ®· ®o¹t " .. GetTask(PTD2_T_HH_CNT) .. "/" .. PTD2_HH_NEED .. " hån ph¸ch cña " .. PTD2_ColG .. t[2] .. PTD2_ColE
			.. " (®¶o " .. isl[2] .. ").", { "LËp HÊp Hån TrËn/PTD2_HhGo", "Hñy nhiÖm vô lÇn nµy/PTD2_HhCancel", ferry })
		return
	end
	if st == 2 then
		PTD2_Say("ThuyÒn phu: Hån ph¸ch ®· ®ñ, giao cho ta ®i.", { "Giao hån ph¸ch/PTD2_HhFinish", ferry })
		return
	end
	SetTask(PTD2_T_HH_STATE, 0)
	main()
end

function PTD2_HhAccept()
	PTD2_CheckDay()
	if GetTask(PTD2_T_HH_STATE) ~= 0 then main() return end
	if GetTask(PTD2_T_HH_DONE) >= PTD2_MAX.hh then
		PTD2_Talk("ThuyÒn phu: H«m nay ng­¬i ®· lµm ®ñ " .. PTD2_MAX.hh .. " lÇn, ngµy mai h·y quay l¹i.")
		return
	end
	local k = random(1, getn(PTD2_HH_TARGETS))
	local isl = PTD2_HhIsland()
	SetTask(PTD2_T_HH_INFO, k * 10 + isl)
	SetTask(PTD2_T_HH_CNT, 0)
	SetTask(PTD2_T_HH_STATE, 1)
	local t, i = PTD2_HhInfo()
	TaskNote(70, 0, t[2])
	PTD2_Say("ThuyÒn phu: LÇn nµy ph¶i hót hån cña " .. PTD2_ColG .. t[2] .. PTD2_ColE .. ", ®ñ " .. PTD2_HH_NEED
		.. " hån ph¸ch. Sau khi HÊp Hån TrËn mÊt th× kh«ng thÓ ®o¹t hån n÷a.",
		{ "LËp HÊp Hån TrËn ngay/PTD2_HhGo", "§Ó l¸t n÷a (lªn ®¶o trËn sÏ hiÖn trong vßng 1 phót)/PTD2_No" })
end

function PTD2_HhGo()
	if GetTask(PTD2_T_HH_STATE) ~= 1 then main() return end
	local t, isl = PTD2_HhInfo()
	if not t or not isl then return end
	CloseDialog()
	NewWorld(isl[1], isl[3], isl[4])
	SetFightState(1)
	if PTD2_HhSpawn(isl[3], isl[4]) > 0 then
		Msg2Player("HÊp Hån TrËn ®· lËp, h·y tiªu diÖt ¢m Hån " .. t[2] .. ".")
	end
end

function PTD2_HhCancel()
	if GetTask(PTD2_T_HH_STATE) == 0 then main() return end
	SetTask(PTD2_T_HH_STATE, 0)
	SetTask(PTD2_T_HH_CNT, 0)
	if GetTask(PTD2_T_PK_CODE) == PTD2_CODE_HH then PTD2_DropPack() end
	PTD2_Talk("ThuyÒn phu: §· hñy lÇn HÊp Hån nµy.")
end

function PTD2_HhFinish()
	if GetTask(PTD2_T_HH_STATE) ~= 2 then main() return end
	local k = random(0, 1)
	local names = { "ChÊn Thiªn TiÔn", "Tam Tiªm Xoa" }
	if not PTD2_GiveGuarded(PTD2_T_HH_STATE, 2, 0, {}, { { 3, 177 + k, 0, 0, 0, 0, 1 } }) then
		PTD2_Talk("ThuyÒn phu: Hµnh trang cña ng­¬i kh«ng cßn chç trèng, h·y s¾p xÕp l¹i råi quay l¹i.")
		return
	end
	local done = GetTask(PTD2_T_HH_DONE) + 1
	SetTask(PTD2_T_HH_DONE, done)
	SetTask(PTD2_T_HH_CNT, 0)
	local exp = PTD2_Exp(GetLevel() * PTD2_HH_EXP)
	TaskNote(70, -1)
	Msg2Player(PTD2_ColG .. "HÊp Hån ¢m S¸t vßng " .. done .. "/" .. PTD2_MAX.hh .. " hoµn thµnh:" .. PTD2_ColE .. " nhËn " .. exp .. " kinh nghiÖm vµ 1 " .. names[k + 1] .. ".")
	PTD2_Talk("ThuyÒn phu: Hån ph¸ch nµy ®ñ cho ta dïng mét thêi gian. CÇm lÊy " .. names[k + 1] .. ".")
end

function PTD2_HhFerry()
	local other = 3 - PTD2_HhIsland()
	local isl = PTD2_HH_ISLANDS[other]
	CloseDialog()
	NewWorld(isl[1], PTD2_HH_FERRY[other][1], PTD2_HH_FERRY[other][2])
end

-- landing points beside the Thuyen phu of each island (taskinfo 70 mappos; walkable cells checked
-- on the Region_S obstacle grid)
PTD2_HH_FERRY = { { 1777, 3168 }, { 1804, 3190 } }
