-- Phong Than 2026-10-03 (daily2): An Hong (Phong Than Dai 190/199) - Sieu Do Linh Hon (taskinfo 48,
-- 5 vong/ngay, 2 loai yeu ma x 3 linh hon, thuong Cap*kinh nghiem hoac Cap*tien).
-- VNG froze the souls with the Chieu Hon Phuon (ÕÐ»êá¦.lua, kill inside the banner's range/time). Here
-- An Hong opens the Chieu Hon Tran at a field spot of a map that fits the level: the souls are
-- separate "Oan Hon" monsters (same templates) counted by daily2\d2_mob.lua, solo-friendly.
-- The original \script\·âÉñÌ¨\Òóºé.lua (flower event) is left untouched; this is a new NPC.
Include("\\script\\phongthan\\daily2\\d2_lib.lua")

PTD2_SD_LEVEL = 20
PTD2_SD_EXP = 2500       -- x level
PTD2_SD_CASH = 150       -- x level

function PTD2_SdNames()
	local sp = PTD2_SD_SPOTS[GetTask(PTD2_T_SD_INFO)]
	if not sp then return "?", "?", nil end
	return PTD2_MobName(sp[2]), PTD2_MobName(sp[6]), sp
end

function main()
	PTD2_CheckDay()
	if GetLevel() < PTD2_SD_LEVEL then
		PTD2_Talk("¢n Hång: O¸n hån ngoµi kia rÊt hung d÷, ®îi ng­¬i ®¹t cÊp " .. PTD2_SD_LEVEL .. " h·y ®Õn gióp ta.")
		return
	end
	local st = GetTask(PTD2_T_SD_STATE)
	local done = GetTask(PTD2_T_SD_DONE)
	if st == 0 then
		local opts = {}
		if done < PTD2_MAX.sd then opts[1] = "NhËn nhiÖm vô Siªu §é Linh Hån/PTD2_SdAccept" end
		PTD2_Say("¢n Hång: Bªn ngoµi cã rÊt nhiÒu yªu ma bÞ giam linh hån. H·y dùng Chiªu Hån TrËn vµ tiªu diÖt chóng ®Ó phãng thÝch linh hån. H«m nay ng­¬i ®· siªu ®é "
			.. PTD2_ColG .. done .. "/" .. PTD2_MAX.sd .. PTD2_ColE .. " lÇn.", opts)
		return
	end
	local na, nb, sp = PTD2_SdNames()
	if st == 1 and sp then
		local c = GetTask(PTD2_T_SD_CNT)
		PTD2_Say("¢n Hång: H·y tíi " .. PTD2_ColG .. PTD2_MapName(sp[1]) .. " " .. PTD2_PosText(sp[4], sp[5]) .. PTD2_ColE
			.. " siªu ®é " .. na .. " (" .. floor(c / 100) .. "/" .. PTD2_SD_NEED .. ") vµ " .. nb .. " (" .. mod(c, 100) .. "/" .. PTD2_SD_NEED .. ").",
			{ "§­a ta tíi Chiªu Hån TrËn/PTD2_SdGo", "Hñy nhiÖm vô lÇn nµy/PTD2_SdCancel" })
		return
	end
	if st == 2 then
		local lv = GetLevel()
		PTD2_Say("¢n Hång: Linh hån ®· ®­îc phãng thÝch, Tö Kim Hå L« l¹i thªm linh khÝ. Ng­¬i muèn nhËn th­ëng g×?",
			{ "NhËn " .. (lv * PTD2_SD_EXP) .. " kinh nghiÖm/PTD2_SdRewardExp", "NhËn " .. (lv * PTD2_SD_CASH) .. " l­îng/PTD2_SdRewardCash" })
		return
	end
	SetTask(PTD2_T_SD_STATE, 0)
	main()
end

-- a map whose two monster kinds fit the level (kind B at most level + 3, kind A not below level - 15)
function PTD2_SdPick(lv)
	local cand = {}
	local best, bestlv = 1, -1
	local i = 1
	while PTD2_SD_SPOTS[i] do
		local s = PTD2_SD_SPOTS[i]
		if s[7] <= lv + 3 and s[3] >= lv - 15 then cand[getn(cand) + 1] = i end
		if s[7] <= lv + 3 and s[7] > bestlv then best, bestlv = i, s[7] end
		i = i + 1
	end
	if getn(cand) > 0 then return cand[random(1, getn(cand))] end
	return best
end

function PTD2_SdAccept()
	PTD2_CheckDay()
	if GetTask(PTD2_T_SD_STATE) ~= 0 then main() return end
	if GetTask(PTD2_T_SD_DONE) >= PTD2_MAX.sd then
		PTD2_Talk("¢n Hång: H«m nay ng­¬i ®· siªu ®é ®ñ " .. PTD2_MAX.sd .. " lÇn, ngµy mai h·y quay l¹i.")
		return
	end
	local k = PTD2_SdPick(GetLevel())
	SetTask(PTD2_T_SD_INFO, k)
	SetTask(PTD2_T_SD_CNT, 0)
	SetTask(PTD2_T_SD_STATE, 1)
	local na, nb, sp = PTD2_SdNames()
	TaskNote(48, 0, na, sp[2], nb, sp[6])
	PTD2_Say("¢n Hång: §èi t­îng cÇn siªu ®é lÇn nµy lµ " .. PTD2_ColR .. na .. PTD2_ColE .. " vµ " .. PTD2_ColR .. nb .. PTD2_ColE
		.. " ë " .. PTD2_MapName(sp[1]) .. ", mçi lo¹i phãng thÝch " .. PTD2_SD_NEED .. " linh hån. Ta cã thÓ ®­a ng­¬i tíi ®ã vµ dùng Chiªu Hån TrËn ngay.",
		{ "§­a ta tíi Chiªu Hån TrËn/PTD2_SdGo", "Ta tù ®i (tíi n¬i trËn sÏ hiÖn trong vßng 1 phót)/PTD2_No" })
end

function PTD2_SdGo()
	if GetTask(PTD2_T_SD_STATE) ~= 1 then main() return end
	local na, nb, sp = PTD2_SdNames()
	if not sp then return end
	CloseDialog()
	NewWorld(sp[1], sp[4], sp[5])
	SetFightState(1)
	if PTD2_SdSpawn(sp[4], sp[5]) > 0 then
		Msg2Player("Chiªu Hån TrËn ®· hiÖn ra, h·y tiªu diÖt O¸n Hån " .. na .. " vµ O¸n Hån " .. nb .. ".")
	end
end

function PTD2_SdCancel()
	if GetTask(PTD2_T_SD_STATE) == 0 then main() return end
	SetTask(PTD2_T_SD_STATE, 0)
	SetTask(PTD2_T_SD_CNT, 0)
	if GetTask(PTD2_T_PK_CODE) == PTD2_CODE_SD then PTD2_DropPack() end
	PTD2_Talk("¢n Hång: §· hñy lÇn siªu ®é nµy.")
end

function PTD2_SdFinish(kind)
	if GetTask(PTD2_T_SD_STATE) ~= 2 then main() return end
	SetTask(PTD2_T_SD_STATE, 0)
	local done = GetTask(PTD2_T_SD_DONE) + 1
	SetTask(PTD2_T_SD_DONE, done)
	local lv = GetLevel()
	local txt
	if kind == 1 then
		txt = PTD2_Exp(lv * PTD2_SD_EXP) .. " kinh nghiÖm"
	else
		Earn(lv * PTD2_SD_CASH)
		txt = (lv * PTD2_SD_CASH) .. " l­îng"
	end
	TaskNote(48, -1)
	Msg2Player(PTD2_ColG .. "Siªu §é Linh Hån vßng " .. done .. "/" .. PTD2_MAX.sd .. " hoµn thµnh:" .. PTD2_ColE .. " nhËn " .. txt .. ".")
	PTD2_Talk("¢n Hång: §a t¹ ng­¬i. §©y lµ phÇn th­ëng: " .. txt .. ".")
end

function PTD2_SdRewardExp()
	PTD2_SdFinish(1)
end

function PTD2_SdRewardCash()
	PTD2_SdFinish(2)
end
