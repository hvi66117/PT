-- Phong Than 2026-10-02 (tutuong_b): Tu Linh / Tu Tuong Linh Te (VNG daily quest, server script lost).
-- Included by the Thay tuong so scripts (Trieu Ca / Tay Ky, ptfix), by \script\npcdeath\normal.lua
-- (kill counting), by the Chia khoa Linh Te item script and by the minute tick. Lua 4.0.
-- Rules: from level 65, 4 runs a day (+1 per Chia khoa Linh Te 8/329, at most 4 extra); one run =
-- 6 rounds; each round opens Linh Te mon to one maze (Hoang mac / Hien Vien / Bang Xuyen / Dong Hai,
-- the deeper layer the higher the round) where the player kills the Ma Vuong's minions to free a
-- Tu Tinh before the Linh Te timer (buff 8/326-328, 342-350: 600/480/360 s) ends.
-- Rewards: EXP + money each round; after round 6 the player reports back to the Thay tuong so for a
-- bigger reward, 1 random Tinh Phach (3/200-203) and a chance of Lam Tien Lo (8/330).
-- 2026-10-02 (tutuong2):
--  * The Linh Tª timer is no longer shown with AddIBBuff(326..350): this engine's AddIBBuff casts the
--    state of the SKILL with the same id, and skills 326-350 are 28 Tó boss debuffs (326: ngo¹i phßng
--    -350, 342: kh¸ng L«i -10%, ...). The deadline (task 2048) is the timer, as before; PTTL_ClearBuffs
--    still removes such a state left over from the first build.
--  * Tier-4 reward buffs (8/331 Thæ, 351 Háa, 352 Phong, 353 Thñy: kh¸ng tÊt c¶ +20% for 600 s, the
--    attributes of their ibitem rows): finishing round 4, 5 or 6 grants the tier-4 buff of the maze
--    just cleared, through the pt_ibitem generic buff slots (PTIB_GrantGen, re-applied by PTAdm_IbTick).
--    Only one tier-4 buff is kept: a new maze's buff replaces another maze's (same maze = +600 s).
Include("\\script\\phongthan\\tutuong\\tt_common.lua")
Include("\\script\\phongthan\\ibitem\\pt_ibitem_lib.lua")

PTTL_MINLV = 65
PTTL_TIER4_FROM = 4           -- rounds 4..6 grant the tier-4 Linh Tª buff
PTTL_TIER4 = { "Linh Tª_Thæ 4", "Linh Tª_Háa 4", "Linh Tª_Phong 4", "Linh Tª_Thñy 4" }   -- by zone
PTTL_DAILY = 4
PTTL_EXTRA_MAX = 4
PTTL_LAMTIENLO_PCT = 30
PTTL_TIER_SECS = { 600, 480, 360 }
-- per round: maze layer (1..5), kills needed, Linh Te tier (timer)
PTTL_ROUNDS = {
	{ 1, 10, 1 },
	{ 2, 12, 1 },
	{ 3, 15, 2 },
	{ 4, 18, 2 },
	{ 5, 20, 3 },
	{ 5, 25, 3 },
}
-- zones: name, Ma Vuong, Linh Te buff ids (tier 1..3), maps { id, x, y } (x/y = NewWorld units,
-- entry points taken from the VNG travel scripts in the PAK)
PTTL_ZONES = {
	{ "Hoang m¹c", "ThiÕt Bè", { 326, 327, 328 }, {
		{ 1022, 1625, 3265, "Hoang m¹c" }, { 1023, 1621, 3353, "Thæ Thµnh" }, { 1024, 1608, 3181, "Phong Than" },
		{ 1025, 1608, 3145, "Lôc Ch©u" }, { 1026, 1459, 3433, "Sa M¹c chÕt" } } },
	{ "Hiªn Viªn", "C«n Bèi", { 342, 343, 344 }, {
		{ 1027, 1823, 2975, "Hiªn Viªn tÇng 1" }, { 1028, 1822, 2894, "Hiªn Viªn tÇng 2" }, { 1029, 1538, 2918, "Hiªn Viªn tÇng 3" },
		{ 1030, 1595, 2976, "Hiªn Viªn tÇng 4" }, { 1031, 1613, 2632, "Hiªn Viªn tÇng 5" } } },
	{ "B¨ng Xuyªn", "Lam B¸", { 345, 346, 347 }, {
		{ 1032, 1848, 2913, "Ngäc TuyÒn" }, { 1033, 1753, 3044, "TuyÕt Cèc" }, { 1034, 1488, 3168, "§¹i Phong" },
		{ 1035, 1763, 3382, "§¹i Th¹ch" }, { 1036, 1594, 3763, "B¨ng Xuyªn Cùc" } } },
	{ "§«ng H¶i", "Kim Tr¹i", { 348, 349, 350 }, {
		{ 1037, 1851, 2998, "Thñy Vùc" }, { 1038, 1828, 2983, "Long Cung" }, { 1039, 1879, 2878, "H¶i C©u" },
		{ 1040, 1723, 2734, "Long Vùc" }, { 1041, 1606, 3749, "Long Uyªn" } } },
}

function PTTL_Sync()
	local d = PTTT_Today()
	if GetTask(PTTT_T_TL_DAY) ~= d then
		SetTask(PTTT_T_TL_DAY, d)
		SetTask(PTTT_T_TL_USED, 0)
		SetTask(PTTT_T_TL_EXTRA, 0)
	end
end

function PTTL_Left()
	PTTL_Sync()
	local n = PTTL_DAILY + GetTask(PTTT_T_TL_EXTRA) - GetTask(PTTT_T_TL_USED)
	if n < 0 then n = 0 end
	return n
end

-- current round data: round, zone table, map row, buff id
function PTTL_Cur()
	local r = GetTask(PTTT_T_TL_ROUND)
	local z = PTTL_ZONES[GetTask(PTTT_T_TL_ZONE)]
	if r < 1 or r > 6 or z == nil then return r, nil, nil, 0 end
	local rd = PTTL_ROUNDS[r]
	return r, z, z[4][rd[1]], z[3][rd[3]]
end

function PTTL_ClearBuffs()
	local k = 1
	while PTTL_ZONES[k] do
		local b = PTTL_ZONES[k][3]
		local j = 1
		while b[j] do
			if HaveIBBuff(b[j]) == 1 then RemoveIBBuff(b[j]) end
			j = j + 1
		end
		k = k + 1
	end
end

-- 1 = the active round ran out of time (now marked as round 8)
function PTTL_CheckExpire()
	local r = GetTask(PTTT_T_TL_ROUND)
	if r >= 1 and r <= 6 and PTTT_Now() > GetTask(PTTT_T_TL_DEADLINE) then
		SetTask(PTTT_T_TL_ROUND, 8)
		PTTL_ClearBuffs()
		Msg2Player("<color=yellow>Tø Linh: Linh Tª m«n ®· ®ãng, vßng " .. r .. " thÊt b¹i. H·y vÒ gÆp ThÇy t­íng sè tr¶ nhiÖm vô.<color>")
		return 1
	end
	return 0
end

-- start round r in a random zone (another zone than prev when possible)
function PTTL_NewRound(r, prev)
	local zone = random(1, 4)
	if zone == prev then zone = mod(zone, 4) + 1 end
	local rd = PTTL_ROUNDS[r]
	local z = PTTL_ZONES[zone]
	local m = z[4][rd[1]]
	local secs = PTTL_TIER_SECS[rd[3]]
	SetTask(PTTT_T_TL_ROUND, r)
	SetTask(PTTT_T_TL_ZONE, zone)
	SetTask(PTTT_T_TL_MAP, m[1])
	SetTask(PTTT_T_TL_KILLS, 0)
	SetTask(PTTT_T_TL_NEED, rd[2])
	SetTask(PTTT_T_TL_DEADLINE, PTTT_Now() + secs)
	PTTL_ClearBuffs()
	Msg2Player("<color=green>Tø Linh vßng " .. r .. "/6:<color> Linh Tª m«n më ®Õn mª cung <color=yellow>" .. z[1] .. " - " .. m[4] .. "<color>. Tiªu diÖt " .. rd[2] .. " l©u la cña Ma V­¬ng " .. z[2] .. " trong " .. PTTT_TimeText(secs) .. " ®Ó gi¶i tho¸t Tø Tinh.")
end

function PTTL_Go()
	local r, z, m = PTTL_Cur()
	if m == nil then return end
	if PTTL_CheckExpire() == 1 then return end
	NewWorld(m[1], m[2], m[3])
	SetFightState(1)
end

-- ---------------------------------------------------------------- dialog (Thay tuong so)
function PTTL_Menu()
	PTTL_Sync()
	PTTL_CheckExpire()
	local r = GetTask(PTTT_T_TL_ROUND)
	if r == 0 then
		local left = PTTL_Left()
		PTTT_Say("Thæ, Thñy, Háa, Phong lµ nÒn t¶ng cña thÕ giíi vËt chÊt. Nay 4 Tø Linh ®· bÞ 4 Ma V­¬ng Hçn §én, Khèn Kú, Thao ThiÕt, §µo C¬ khèng chÕ. Ta cã thÓ më <color=yellow>Linh Tª m«n<color> ®­a ng­¬i vµo mª cung gi¶i tho¸t Tø Tinh. H«m nay ng­¬i cßn <color=yellow>" .. left .. "<color> l­ît.",
			{ "Më Linh Tª m«n (nhËn Tø Linh)/PTTL_Start", "T×m hiÓu nhiÖm vô Tø Linh/PTTL_Info" })
	elseif r >= 1 and r <= 6 then
		local rr, z, m = PTTL_Cur()
		local left = GetTask(PTTT_T_TL_DEADLINE) - PTTT_Now()
		PTTT_Say("Tø Linh vßng <color=yellow>" .. r .. "/6<color>: mª cung <color=yellow>" .. z[1] .. " - " .. m[4] .. "<color>, ®· diÖt <color=yellow>" .. GetTask(PTTT_T_TL_KILLS) .. "/" .. GetTask(PTTT_T_TL_NEED) .. "<color> l©u la. Linh Tª m«n cßn më " .. PTTT_TimeText(left) .. ".",
			{ "§­a ta qua Linh Tª m«n ®Õn mª cung/PTTL_Go", "Hñy nhiÖm vô Tø Linh/PTTL_AskCancel" })
	elseif r == 7 then
		PTTT_Say("Ng­¬i ®· gi¶i tho¸t toµn bé Tø Tinh trong 6 mª cung. Giái l¾m! §©y lµ phÇn th­ëng cña ng­¬i.",
			{ "Phôc mÖnh, nhËn th­ëng/PTTL_Finish" })
	else
		PTTT_Say("Linh Tª m«n ®· ®ãng tr­íc khi ng­¬i gi¶i tho¸t Tø Tinh. PhÇn th­ëng cña c¸c vßng ®· xong ng­¬i ®· nhËn råi.",
			{ "Tr¶ nhiÖm vô Tø Linh/PTTL_Close" })
	end
end

function PTTL_Info()
	PTTT_Say("Tø Linh (tõ cÊp " .. PTTL_MINLV .. "): mçi ngµy " .. PTTL_DAILY .. " l­ît, mçi Ch×a khãa Linh Tª thªm 1 l­ît. Mét l­ît gåm 6 vßng; mçi vßng ta më Linh Tª m«n ®Õn mét mª cung (Hoang m¹c, Hiªn Viªn, B¨ng Xuyªn hoÆc §«ng H¶i), ng­¬i ph¶i diÖt ®ñ l©u la tr­íc khi Linh Tª hÕt h¹n (10, 8 råi 6 phót). Xong mçi vßng nhËn kinh nghiÖm vµ ng©n l­îng, tõ vßng 4 cßn ®­îc Tø Tinh ban phóc (kh¸ng tÊt c¶ +20% trong 10 phót); xong c¶ 6 vßng vÒ ®©y nhËn th­ëng lín, Tinh Ph¸ch vµ cã thÓ cã L©m Tiªn Lé. §i cïng tæ ®éi th× mäi thµnh viªn ë cïng mª cung ®Òu ®­îc tÝnh.",
		{ "Quay l¹i/PTTL_Menu" })
end

function PTTL_Start()
	PTTL_Sync()
	if GetTask(PTTT_T_TL_ROUND) ~= 0 then PTTL_Menu() return end
	if GetLevel() < PTTL_MINLV then
		PTTT_Say("§Õn cÊp " .. PTTL_MINLV .. " ng­¬i míi ®ñ søc ph¸ gi¶i Tø Linh bÞ ma hãa.", {})
		return
	end
	if PTTL_Left() <= 0 then
		PTTT_Say("H«m nay Linh Tª m«n ®· më ®ñ l­ît cho ng­¬i. Dïng <color=yellow>Ch×a khãa Linh Tª<color> ®Ó cã thªm l­ît, hoÆc ngµy mai h·y quay l¹i.", {})
		return
	end
	SetTask(PTTT_T_TL_USED, GetTask(PTTT_T_TL_USED) + 1)
	PTTL_NewRound(1, 0)
	PTTT_Say("Linh Tª m«n ®· më. §i ngay chø?", { "§­a ta ®Õn mª cung/PTTL_Go" })
end

function PTTL_AskCancel()
	PTTT_Say("Hñy nhiÖm vô th× l­ît h«m nay vÉn bÞ tÝnh. Ng­¬i ch¾c chø?", { "Hñy nhiÖm vô/PTTL_Close" })
end

function PTTL_Close()
	SetTask(PTTT_T_TL_ROUND, 0)
	SetTask(PTTT_T_TL_KILLS, 0)
	SetTask(PTTT_T_TL_NEED, 0)
	SetTask(PTTT_T_TL_MAP, 0)
	PTTL_ClearBuffs()
	Msg2Player("Tø Linh: ®· kÕt thóc nhiÖm vô.")
end

function PTTL_RoundExp(r)
	return GetLevel() * 1500 * r
end

function PTTL_Finish()
	if GetTask(PTTT_T_TL_ROUND) ~= 7 then PTTL_Menu() return end
	local k = random(0, 3)
	-- compare-and-set 7 -> 0 with the Tinh Phach: a full bag changes nothing
	if QuestExchange(PTTT_T_TL_ROUND, 7, 0, {}, { { 3, 200 + k, 0, 0, 0, 0, 1 } }) ~= 1 then
		PTTT_Say("Hµnh trang cña ng­¬i kh«ng ®ñ chç trèng, h·y dän bít råi quay l¹i nhËn th­ëng.", {})
		return
	end
	local lv = GetLevel()
	AddOwnExp(lv * 20000)
	Earn(20000)
	local names = { "Thæ", "Háa", "Phong", "Thñy" }
	Msg2Player("<color=green>Tø Linh hoµn thµnh!<color> NhËn " .. (lv * 20000) .. " kinh nghiÖm, 20000 l­îng vµ 1 Tinh Ph¸ch " .. names[k + 1] .. ".")
	if random(1, 100) <= PTTL_LAMTIENLO_PCT then
		if PTTT_GiveIB(330, 0) == 1 then Msg2Player("May m¾n nhËn ®­îc <color=yellow>L©m Tiªn Lé<color>!") end
	end
	SetTask(PTTT_T_TL_KILLS, 0)
	SetTask(PTTT_T_TL_NEED, 0)
	SetTask(PTTT_T_TL_MAP, 0)
end

-- ---------------------------------------------------------------- kill counting (normal.lua)
-- tier-4 Linh Tª buff of a zone (1..4); returns the seconds left, 0 when the buff data is missing
function PTTL_GiveTier4(zone)
	local name = PTTL_TIER4[zone]
	if name == nil or PTIB_GenId == nil then return 0 end
	local gid = PTIB_GenId(name)
	if gid == nil then return 0 end
	-- one tier-4 buff at a time: the buff of another maze is ended (its slot freed) first
	local k = 0
	while k < PTIB_GEN_SLOTS do
		local sg = GetTask(PTIB_T_GEN + 2 * k)
		if sg ~= 0 and sg ~= gid then
			local z = 1
			while PTTL_TIER4[z] do
				if PTIB_GenId(PTTL_TIER4[z]) == sg then
					SetTask(PTIB_T_GEN + 2 * k, 0)
					SetTask(PTIB_T_GEN + 2 * k + 1, 0)
				end
				z = z + 1
			end
		end
		k = k + 1
	end
	local left = PTIB_GrantGen(gid)
	if left > 0 then
		Msg2Player("<color=yellow>Tø Tinh ban phóc: nhËn " .. name .. "<color> (kh¸ng tÊt c¶ +20%), thêi h¹n cßn " .. PTTT_TimeText(left) .. ".")
	end
	return left
end

function PTTL_RoundDone(r)
	local exp = PTTL_RoundExp(r)
	local money = 1000 * r
	AddOwnExp(exp)
	Earn(money)
	local rr, z, m = PTTL_Cur()
	Msg2Player("<color=green>Tø Linh vßng " .. r .. "/6 hoµn thµnh:<color> Tø Tinh ë " .. z[1] .. " ®· ®­îc gi¶i tho¸t. NhËn " .. exp .. " kinh nghiÖm, " .. money .. " l­îng.")
	if r >= PTTL_TIER4_FROM then PTTL_GiveTier4(GetTask(PTTT_T_TL_ZONE)) end
	if r < 6 then
		PTTL_NewRound(r + 1, GetTask(PTTT_T_TL_ZONE))
		local r2, z2, m2 = PTTL_Cur()
		Say("Tø Tinh ®­îc gi¶i tho¸t, Linh Tª m«n më tiÕp ®Õn <color=yellow>" .. z2[1] .. " - " .. m2[4] .. "<color>. §i ngay chø?", 2, "§i qua Linh Tª m«n/PTTL_Go", "§Ó ta tù ®i/PTTT_No")
	else
		SetTask(PTTT_T_TL_ROUND, 7)
		PTTL_ClearBuffs()
		Msg2Player("<color=yellow>§· gi¶i tho¸t Tø Tinh ë c¶ 6 mª cung! H·y vÒ gÆp ThÇy t­íng sè (TriÒu Ca hoÆc T©y Kú) phôc mÖnh nhËn th­ëng.<color>")
	end
end

function PTTL_Credit(world)
	local r = GetTask(PTTT_T_TL_ROUND)
	if r < 1 or r > 6 then return end
	if PTTL_CheckExpire() == 1 then return end
	local target = GetTask(PTTT_T_TL_MAP)
	if PTTT_MyMap() ~= target or PTTT_MapId(world) ~= target then return end
	local k = GetTask(PTTT_T_TL_KILLS) + 1
	local need = GetTask(PTTT_T_TL_NEED)
	SetTask(PTTT_T_TL_KILLS, k)
	if k >= need then
		PTTL_RoundDone(r)
	else
		Msg2Player("Tø Linh: ®· diÖt " .. k .. "/" .. need .. " l©u la.")
	end
end

-- \script\npcdeath\normal.lua OnDeath: PlayerIndex = kill owner
function PTTL_OnKill(npcIndex)
	local killer = PlayerIndex
	if killer == nil or killer <= 0 then return end
	local world = GetNpcWorldPos(npcIndex)
	if world == nil or world <= 0 then return end
	local members = PTTT_Members()
	local i = 1
	while members[i] do
		PlayerIndex = members[i]
		PTTL_Credit(world)
		i = i + 1
	end
	PlayerIndex = killer
end

-- minute tick, per online player
function PTTL_TickPlayer()
	local r = GetTask(PTTT_T_TL_ROUND)
	if r >= 1 and r <= 6 then PTTL_CheckExpire() end
end
