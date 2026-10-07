-- Phong Than 2026-10-03 (daily2): An Giao (Phong Than Dai 184/193) - Thien Cuong Hon (taskinfo 53,
-- 6 vong/ngay, tieu diet Thien Cuong Tinh o Bich Du Cung / Khon Tien Cung, thuong Cap*kinh nghiem).
-- Each round: 5 Anh Tu (template Ììî¸ÐÇµÄÓ°×Ó) appear at the chosen floor; when all 5 fall the Thien
-- Cuong Tinh (template Ììî¸ÐÇ) appears; defeating it gives the soul, An Giao pays. The VNG lucky prize
-- "trang bi luc cap 80" is replaced by a Lam thuy tinh (25%) because no safe equipment roll exists.
-- The VNG \script\·âÉñÌ¨\Òó½¼.lua is a 148-byte stub; extra_daily2.py points it at this file.
Include("\\script\\phongthan\\daily2\\d2_lib.lua")

PTD2_TCH_LEVEL = 60
PTD2_TCH_EXP = 4000      -- x level
PTD2_TCH_MAPS = { 1042, 1043, 1044, 1045, 1046, 1047, 1048, 1049, 1050, 1051 }

function PTD2_TchInfo()
	local info = GetTask(PTD2_T_TCH_INFO)
	local map = mod(info, 10000)
	local star = floor(info / 10000)
	return map, (PTD2_STARS[star] or "Thiªn C­¬ng") .. " Tinh"
end

function main()
	PTD2_CheckDay()
	if GetLevel() < PTD2_TCH_LEVEL then
		PTD2_Talk("¢n Giao: Thiªn C­¬ng Tinh kh«ng ph¶i h¹ng tÇm th­êng, ®îi ng­¬i ®¹t cÊp " .. PTD2_TCH_LEVEL .. " h·y ®Õn.")
		return
	end
	local st = GetTask(PTD2_T_TCH_STATE)
	local done = GetTask(PTD2_T_TCH_DONE)
	if st == 0 then
		local opts = {}
		if done < PTD2_MAX.tch then opts[1] = "NhËn nhiÖm vô Thiªn C­¬ng Hån/PTD2_TchAccept" end
		PTD2_Say("¢n Giao: 36 Thiªn C­¬ng Tinh ®ang Èn n¸u ë BÝch Du Cung vµ Khæn Tiªn Cung. H·y hµng phôc chóng, ®em ch©n hån vÒ ®©y. H«m nay ng­¬i ®· lµm "
			.. PTD2_ColG .. done .. "/" .. PTD2_MAX.tch .. PTD2_ColE .. " vßng.", opts)
		return
	end
	local map, sname = PTD2_TchInfo()
	if st == 1 or st == 2 then
		local txt
		if st == 1 then
			txt = "®· diÖt " .. GetTask(PTD2_T_TCH_KILL) .. "/" .. PTD2_TCH_SHADOWS .. " ¶nh Tö cña " .. sname
		else
			txt = sname .. " ®· hiÖn th©n, ph¶i ®Ých th©n hµng phôc nã"
		end
		PTD2_Say("¢n Giao: Tíi " .. PTD2_ColG .. PTD2_MapName(map) .. PTD2_ColE .. ", " .. txt .. ".",
			{ "§­a ta tíi " .. PTD2_MapName(map) .. "/PTD2_TchGo", "Hñy nhiÖm vô lÇn nµy/PTD2_TchCancel" })
		return
	end
	if st == 3 then
		PTD2_Say("¢n Giao: Ng­¬i ®· thu ®­îc ch©n hån cña " .. sname .. "?", { "Giao Hån cho ¢n Giao/PTD2_TchFinish" })
		return
	end
	SetTask(PTD2_T_TCH_STATE, 0)
	main()
end

-- floors whose monsters are not above the player's level; the highest few are preferred
function PTD2_TchPick(lv)
	local cand = {}
	local i = 1
	while PTD2_TCH_MAPS[i] do
		local m = PTD2_TCH_MAPS[i]
		local ml = PTD2_TCH_MAPLV[m] or 99
		if ml <= lv and ml >= lv - 12 then cand[getn(cand) + 1] = m end
		i = i + 1
	end
	if getn(cand) == 0 then
		i = 1
		local best, bl = 1042, -1
		while PTD2_TCH_MAPS[i] do
			local m = PTD2_TCH_MAPS[i]
			local ml = PTD2_TCH_MAPLV[m] or 99
			if ml <= lv and ml > bl then best, bl = m, ml end
			i = i + 1
		end
		return best
	end
	return cand[random(1, getn(cand))]
end

function PTD2_TchAccept()
	PTD2_CheckDay()
	if GetTask(PTD2_T_TCH_STATE) ~= 0 then main() return end
	if GetTask(PTD2_T_TCH_DONE) >= PTD2_MAX.tch then
		PTD2_Talk("¢n Giao: H«m nay ng­¬i ®· lµm ®ñ " .. PTD2_MAX.tch .. " vßng, ngµy mai h·y quay l¹i.")
		return
	end
	local map = PTD2_TchPick(GetLevel())
	local star = random(1, getn(PTD2_STARS))
	SetTask(PTD2_T_TCH_INFO, star * 10000 + map)
	SetTask(PTD2_T_TCH_KILL, 0)
	SetTask(PTD2_T_TCH_STATE, 1)
	local m, sname = PTD2_TchInfo()
	TaskNote(53, 0, PTD2_TCH_MOB[map] or "Lam Cèt", 0)
	PTD2_Say("¢n Giao: " .. sname .. " ®ang Èn ë " .. PTD2_ColG .. PTD2_MapName(map) .. PTD2_ColE .. ". Tíi ®ã h¹ "
		.. PTD2_TCH_SHADOWS .. " ¶nh Tö cña nã, " .. sname .. " sÏ xuÊt hiÖn. Ph¶i ®Ých th©n hµng phôc nã míi lÊy ®­îc ch©n hån.",
		{ "§­a ta tíi " .. PTD2_MapName(map) .. "/PTD2_TchGo", "Ta tù ®i (tíi n¬i ¶nh Tö sÏ hiÖn trong vßng 1 phót)/PTD2_No" })
end

function PTD2_TchGo()
	local st = GetTask(PTD2_T_TCH_STATE)
	if st ~= 1 and st ~= 2 then main() return end
	local map, sname = PTD2_TchInfo()
	local p = PTD2_TCH_POS[map]
	if not p then return end
	CloseDialog()
	NewWorld(map, p[1], p[2])
	SetFightState(1)
	if PTD2_TchSpawn(p[1], p[2]) > 0 then
		if st == 1 then Msg2Player("¶nh Tö cña " .. sname .. " ®· xuÊt hiÖn quanh ng­¬i.") else Msg2Player(sname .. " ®· xuÊt hiÖn!") end
	end
end

function PTD2_TchCancel()
	if GetTask(PTD2_T_TCH_STATE) == 0 then main() return end
	SetTask(PTD2_T_TCH_STATE, 0)
	SetTask(PTD2_T_TCH_KILL, 0)
	if GetTask(PTD2_T_PK_CODE) == PTD2_CODE_TCH then PTD2_DropPack() end
	PTD2_Talk("¢n Giao: §· hñy vßng nµy.")
end

function PTD2_TchFinish()
	if GetTask(PTD2_T_TCH_STATE) ~= 3 then main() return end
	local lucky = nil
	if random(1, 100) <= 25 then
		if not PTD2_GiveGuarded(PTD2_T_TCH_STATE, 3, 0, {}, { { 3, 80, 0, 0, 0, 0, 1 } }) then
			PTD2_Talk("¢n Giao: Hµnh trang cña ng­¬i kh«ng cßn chç trèng, h·y s¾p xÕp l¹i råi quay l¹i.")
			return
		end
		lucky = 1
	else
		SetTask(PTD2_T_TCH_STATE, 0)
	end
	local done = GetTask(PTD2_T_TCH_DONE) + 1
	SetTask(PTD2_T_TCH_DONE, done)
	SetTask(PTD2_T_TCH_KILL, 0)
	local exp = PTD2_Exp(GetLevel() * PTD2_TCH_EXP)
	TaskNote(53, -1)
	Msg2Player(PTD2_ColG .. "Thiªn C­¬ng Hån vßng " .. done .. "/" .. PTD2_MAX.tch .. " hoµn thµnh:" .. PTD2_ColE .. " nhËn " .. exp .. " kinh nghiÖm.")
	if lucky then Msg2Player("PhÇn th­ëng may m¾n: 1 Lam thñy tinh.") end
	PTD2_Talk("¢n Giao: Ch©n hån nµy ta xin nhËn. PhÇn th­ëng xøng ®¸ng ®©y.")
end
