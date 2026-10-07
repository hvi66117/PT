-- Phong Than 2026-10-03 (daily3): An Hong (Phong Than Dai 1516/3192) with Ma De (taskinfo 81 "An Hong bao ban lien
-- tuc di sieu do linh hon de bo sung linh khi cho Tu Kim Ho Lo").
-- The An Hong NPC is spawned by daily2 (ext\daily2.lua, template 165) with daily2\d2_anhong.lua. The daily3 ext
-- tick re-binds that NPC to this file; daily2's dialog is Included unchanged (read only) and stays the first row.
-- Ma De = extra Sieu Do rounds after the 5 daily ones: same Chieu Hon Tran, 2 kinds x 3 souls ("Oan Linh"),
-- 10 rounds a day, reward level x 2500 exp +10% per round already done today, crystal on rounds 5 and 10.
Include("\\script\\phongthan\\daily2\\d2_anhong.lua")
Include("\\script\\phongthan\\daily3\\d3_core.lua")

PTD3_SdMain = main

function main()
	PTD3_CheckDay()
	local st = GetTask(PTD3_T_MD_STATE)
	if GetLevel() < PTD3_MD_LEVEL and st == 0 then
		PTD3_SdMain()
		return
	end
	local row = "M· §Õ: liªn tôc siªu ®é cho Tö Kim Hå L«/PTD3_MdMenu"
	if st == 1 then row = "M· §Õ: tiÕn ®é siªu ®é/PTD3_MdMenu" end
	if st == 2 then row = "M· §Õ: giao linh khÝ cho Tö Kim Hå L«/PTD3_MdMenu" end
	PTD2_Say("¢n Hång: Tö Kim Hå L« cÇn rÊt nhiÒu linh khÝ. Ngoµi " .. PTD2_ColG .. "Siªu §é Linh Hån" .. PTD2_ColE
		.. " h»ng ngµy, ng­¬i cã thÓ liªn tôc siªu ®é thªm (" .. PTD2_ColG .. "M· §Õ" .. PTD2_ColE .. ").",
		{ "Siªu §é Linh Hån (h»ng ngµy)/PTD3_SdMain", row })
end

function PTD3_MdNames()
	local sp = PTD2_SD_SPOTS[GetTask(PTD3_T_MD_INFO)]
	if not sp then return "?", "?", nil end
	return PTD2_MobName(sp[2]), PTD2_MobName(sp[6]), sp
end

function PTD3_MdMenu()
	PTD3_CheckDay()
	local st = GetTask(PTD3_T_MD_STATE)
	local done = GetTask(PTD3_T_MD_DONE)
	if st == 0 then
		if GetLevel() < PTD3_MD_LEVEL then
			PTD2_Talk("¢n Hång: §¹t cÊp " .. PTD3_MD_LEVEL .. " h·y ®Õn gióp ta bæ sung linh khÝ cho Tö Kim Hå L«.")
			return
		end
		local opts = {}
		if done < PTD3_MD_MAX then opts[1] = "NhËn nhiÖm vô M· §Õ/PTD3_MdAccept" end
		PTD2_Say("¢n Hång: Muèn bæ sung linh khÝ cho Tö Kim Hå L« th× ph¶i siªu ®é liªn tôc. H«m nay ng­¬i ®· siªu ®é thªm "
			.. PTD2_ColG .. done .. "/" .. PTD3_MD_MAX .. PTD2_ColE .. " lÇn. Lµm liªn tôc th× phÇn th­ëng mçi lÇn mét t¨ng (thªm 10% mçi lÇn), lÇn thø 5 vµ thø 10 cã quµ.", opts)
		return
	end
	local na, nb, sp = PTD3_MdNames()
	if st == 1 and sp then
		local c = GetTask(PTD3_T_MD_CNT)
		PTD2_Say("¢n Hång: H·y tíi " .. PTD2_ColG .. PTD2_MapName(sp[1]) .. " " .. PTD2_PosText(sp[4], sp[5]) .. PTD2_ColE
			.. " siªu ®é " .. na .. " (" .. floor(c / 100) .. "/" .. PTD3_MD_NEED .. ") vµ " .. nb .. " (" .. mod(c, 100) .. "/" .. PTD3_MD_NEED .. ").",
			{ "§­a ta tíi Chiªu Hån TrËn/PTD3_MdGo", "Hñy lÇn M· §Õ nµy/PTD3_MdCancel" })
		return
	end
	if st == 2 then
		PTD2_Say("¢n Hång: Linh khÝ ®· ®Çy thªm mét phÇn. NhËn th­ëng chø?", { "NhËn th­ëng M· §Õ/PTD3_MdFinish" })
		return
	end
	SetTask(PTD3_T_MD_STATE, 0)
end

function PTD3_MdAccept()
	PTD3_CheckDay()
	if GetTask(PTD3_T_MD_STATE) ~= 0 then PTD3_MdMenu() return end
	if GetLevel() < PTD3_MD_LEVEL then PTD3_MdMenu() return end
	if GetTask(PTD3_T_MD_DONE) >= PTD3_MD_MAX then
		PTD2_Talk("¢n Hång: H«m nay ng­¬i ®· siªu ®é thªm ®ñ " .. PTD3_MD_MAX .. " lÇn, ngµy mai h·y quay l¹i.")
		return
	end
	local sd = PTD3_SdDoneToday()
	if sd < PTD2_MAX.sd then
		PTD2_Talk("¢n Hång: H·y lµm xong " .. PTD2_MAX.sd .. " lÇn Siªu §é Linh Hån h«m nay tr­íc (®· lµm " .. sd .. "), råi míi siªu ®é liªn tôc cho Tö Kim Hå L«.")
		return
	end
	SetTask(PTD3_T_MD_INFO, PTD2_SdPick(GetLevel()))
	SetTask(PTD3_T_MD_CNT, 0)
	SetTask(PTD3_T_MD_STATE, 1)
	local na, nb, sp = PTD3_MdNames()
	TaskNote(81, 0, na, nb)
	PTD2_Say("¢n Hång: §èi t­îng cÇn siªu ®é lÇn nµy lµ " .. PTD2_ColR .. na .. PTD2_ColE .. " vµ " .. PTD2_ColR .. nb .. PTD2_ColE
		.. " ë " .. PTD2_MapName(sp[1]) .. ", mçi lo¹i " .. PTD3_MD_NEED .. " linh hån.",
		{ "§­a ta tíi Chiªu Hån TrËn/PTD3_MdGo", "Ta tù ®i (tíi n¬i trËn sÏ hiÖn trong vßng 1 phót)/PTD2_No" })
end

function PTD3_MdGo()
	if GetTask(PTD3_T_MD_STATE) ~= 1 then PTD3_MdMenu() return end
	local na, nb, sp = PTD3_MdNames()
	if not sp then return end
	CloseDialog()
	NewWorld(sp[1], sp[4], sp[5])
	SetFightState(1)
	if PTD3_MdSpawn(sp[4], sp[5]) > 0 then
		Msg2Player("Chiªu Hån TrËn ®· hiÖn ra, h·y tiªu diÖt O¸n Linh " .. na .. " vµ O¸n Linh " .. nb .. ".")
	end
end

function PTD3_MdCancel()
	if GetTask(PTD3_T_MD_STATE) == 0 then PTD3_MdMenu() return end
	SetTask(PTD3_T_MD_STATE, 0)
	SetTask(PTD3_T_MD_CNT, 0)
	if GetTask(PTD3_T_FK_CODE) == PTD3_CODE_MD then PTD3_DropPack() end
	PTD2_Talk("¢n Hång: §· hñy lÇn M· §Õ nµy. Chuçi liªn tôc vÉn ®­îc gi÷.")
end

function PTD3_MdFinish()
	if GetTask(PTD3_T_MD_STATE) ~= 2 then PTD3_MdMenu() return end
	local before = GetTask(PTD3_T_MD_DONE)
	local done = before + 1
	local gifts = {}
	local gname = ""
	if done == 5 then gifts = { { 3, 78, 0, 0, 0, 0, 1 } } gname = ", 1 M¶nh Lam thñy tinh" end
	if done == 10 then gifts = { { 3, 80, 0, 0, 0, 0, 1 } } gname = ", 1 Lam thñy tinh" end
	if getn(gifts) > 0 then
		if not PTD2_GiveGuarded(PTD3_T_MD_STATE, 2, 0, {}, gifts) then
			PTD2_Talk("¢n Hång: Hµnh trang cña ng­¬i ®· ®Çy, h·y dän bít råi quay l¹i nhËn th­ëng.")
			return
		end
	else
		SetTask(PTD3_T_MD_STATE, 0)
	end
	SetTask(PTD3_T_MD_DONE, done)
	local lv = GetLevel()
	local exp = floor(lv * PTD3_MD_EXP * (10 + before) / 10)
	PTD2_Exp(exp)
	TaskNote(81, -1)
	Msg2Player(PTD2_ColG .. "M· §Õ lÇn " .. done .. "/" .. PTD3_MD_MAX .. " hoµn thµnh:" .. PTD2_ColE .. " nhËn " .. exp .. " kinh nghiÖm" .. gname .. ".")
	PTD2_Talk("¢n Hång: Tö Kim Hå L« l¹i thªm linh khÝ. §©y lµ phÇn th­ëng: " .. exp .. " kinh nghiÖm" .. gname .. ".")
end
