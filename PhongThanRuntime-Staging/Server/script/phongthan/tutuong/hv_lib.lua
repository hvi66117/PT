-- Phong Than 2026-10-02 (tutuong_b): Thu Thach Huyen Vu (Tu Tuong Than Vuc), solo-friendly rebuild.
-- The VNG scripts (the GBK si_xiang_shen_yu folder, npcdeath\xuanwu_lv1..6, ontimer\xuan_wu) are lost; a new
-- design on the existing data: map 86 -> runtime 1084 (Huyen Vu Than Vuc, MapList 1084=xuan_wu_shen_yu;
-- 2026-10-02 questfix: 1086 was Tu Huyen Dong Thien), NPC templates of Npcs.txt,
-- buffs 8/8691 (dang ky), 8692 (dang thu thach), 8706/8716 (ket thuc).
-- Per player, no Mission API (see the feature doc): state lives in task vars 2049-2068, every spawned
-- NPC carries its owner in NPC params (0 = owner PlayerIndex, 1 = run serial, 2 = wave), the minute
-- tick (PTTT_Tick in tt_tick.lua) handles the 19:20 start, the timer and players who left the map.
-- Waves: 1 = 4 Vat To Huyen Vu (tpl 2065-2068), 2..7 = Huyen Vu So/Trung/Cao/Vuong/Hoang/Than Hon
-- (tpl 2085-2090), 8 = Huyen Vu (tpl 2124) shown as "Huyen Vu Than Hon"; then a reward chest
-- (tpl 1759) for the owner. Life is set per player level (PTHV_Life) so one player can finish.
Include("\\script\\phongthan\\tutuong\\tt_common.lua")

PTHV_MAP = 1084
-- NewWorld units (= obstacle cells). VNG minimap xuan_wu_shen_yu24.jpg (16 px/pixel, rect 72,87..88,100)
-- shows the Thi Luyen Than Su at about pixel (118,96) = cell (1211,2880); the entry is on the open floor
-- right of it. Regions (75..77, 89..91) have no Region_S file = no server obstacle (KRegion::LoadObject).
PTHV_ENTRY = { 1226, 2906 }
PTHV_CITY = { 1021, 1717, 3129 }      -- Trieu Ca, next to the Thay tuong so (fallback return point)
PTHV_MINLV = 70
PTHV_TIME = 900                       -- seconds for all 8 waves
PTHV_CHEST_GRACE = 300                -- seconds to open the chest before it is opened automatically
PTHV_MAX = 2                          -- runs per day (scheduled and solo together)
PTHV_REG_FROM = 1850                  -- registration window for the 19:20 session
PTHV_START = 1920
PTHV_START_LAST = 1930                -- registered players are pulled in until 19:30 (tick drift)
PTHV_ANYTIME = 1                      -- 1 = "vao ngay" (solo, any time) is offered
PTHV_TPL_TOTEM = { 2065, 2066, 2067, 2068 }
PTHV_TPL_SOUL = { 2085, 2086, 2087, 2088, 2089, 2090 }
PTHV_TPL_BOSS = 2124
PTHV_TPL_CHEST = 1759
PTHV_WAVES = 8
PTHV_SOUL_NAMES = { "HuyÒn Vò S¬ Hån", "HuyÒn Vò Trung Hån", "HuyÒn Vò Cao Hån", "HuyÒn Vò V­¬ng Hån", "HuyÒn Vò Hoµng Hån", "HuyÒn Vò ThÇn Hån (hån thø 6)" }
PTHV_BOSS_NAME = "HuyÒn Vò ThÇn Hån"
PTHV_CHEST_NAME = "HuyÒn Vò B¶o R­¬ng"
PTHV_MOB_SCRIPT = "\\script\\phongthan\\tutuong\\hv_mob.lua"
PTHV_CHEST_SCRIPT = "\\script\\phongthan\\tutuong\\hv_chest.lua"
PTHV_BUFF_REG = 8691
PTHV_BUFF_ON = 8692
PTHV_BUFF_END = 8716
-- 2026-10-02 (tutuong2): ThÊt Tinh HuyÒn Vò. The six "HuyÒn Vò PhÇn" items 6/1/1284..1289 set task
-- 2028 bits 1..6 (VNG rule; item scripts in ptfix via extra_tutuong_a.py). Source: every chest of this
-- trial gives one star the player still lacks (random one once all are placed). The full set is
-- exchanged here (ThÝ LuyÖn ThÇn Sø): bits 1..6 are cleared by QuestExchange (compare-and-set on task
-- 2028, so a full bag changes nothing) for 1 HuyÒn Vò ThÇn Hån B¶o R­¬ng (6/1/1291), 1 Tø T­îng Tinh
-- Th¹ch (3/208) and level x 50000 EXP; repeatable. Task 2022 counts the exchanges (Tø T­îng range).
PTHV_TT_TASK = 2028
PTHV_TT_COUNT = 2022
PTHV_TT_MASK = 63
PTHV_TT_PART = 1283                   -- star bit b = item 6/1/(1283 + b)
PTHV_TT_STARS = { "Ng­u", "N÷", "H­", "Nguy", "ThÊt", "BÝch" }
PTHV_TT_REWARD = { { 6, 1, 1291, 0, 0, 0, 1 }, { 3, 208, 0, 0, 0, 0, 1 } }
PTHV_TT_EXP = 50000

function PTHV_Life(wave, lv)
	if wave == 1 then return lv * 300 end
	if wave >= PTHV_WAVES then return lv * 3000 end
	return lv * (600 + 300 * (wave - 2))
end

function PTHV_NpcLevel()
	local lv = GetLevel()
	if lv < 60 then lv = 60 end
	if lv > 120 then lv = 120 end
	return lv
end

function PTHV_Sync()
	local d = PTTT_Today()
	if GetTask(PTTT_T_HV_DAY) ~= d then
		SetTask(PTTT_T_HV_DAY, d)
		SetTask(PTTT_T_HV_RUNS, 0)
		if GetTask(PTTT_T_HV_STATE) == 1 then SetTask(PTTT_T_HV_STATE, 0) end
	end
end

function PTHV_InArena()
	if PTTT_MyMap() == PTHV_MAP then return 1 end
	return 0
end

-- ---------------------------------------------------------------- NPCs of a run
function PTHV_Tag(ni, wave)
	SetNpcScript(ni, PTHV_MOB_SCRIPT)
	SetNpcTimeout(ni, (PTHV_TIME + PTHV_CHEST_GRACE + 300) * 18)
	SetNpcParam(ni, 0, PlayerIndex)
	SetNpcParam(ni, 1, GetTask(PTTT_T_HV_SERIAL))
	SetNpcParam(ni, 2, wave)
end

function PTHV_Add(tpl, lv, x, y)
	local sw = SubWorldID2Idx(PTHV_MAP)
	if sw == nil or sw < 0 then return 0 end
	local ni = AddNpc(tpl, lv, sw, x * 32, y * 32, 0)
	if ni == nil or ni <= 0 then ni = AddNpc(tpl, lv, sw, (x + 4) * 32, y * 32, 0) end
	if ni == nil or ni <= 0 then ni = AddNpc(tpl, lv, sw, x * 32, (y + 8) * 32, 0) end
	if ni == nil then ni = 0 end
	return ni
end

function PTHV_Cleanup()
	local serial = GetTask(PTTT_T_HV_SERIAL)
	local i = 1
	while PTTT_T_HV_SLOTS[i] do
		local ni = GetTask(PTTT_T_HV_SLOTS[i])
		if ni > 0 and serial > 0 and GetNpcParam(ni, 1) == serial then DelNpc(ni) end
		SetTask(PTTT_T_HV_SLOTS[i], 0)
		i = i + 1
	end
end

-- spawn wave w around (x, y); returns the number of NPCs spawned
function PTHV_SpawnWave(w, x, y)
	local lv = PTHV_NpcLevel()
	local life = PTHV_Life(w, GetLevel())
	local n = 0
	if w == 1 then
		local off = { { -8, -16 }, { 8, -16 }, { -8, 16 }, { 8, 16 } }
		local i = 1
		while i <= 4 do
			local ni = PTHV_Add(PTHV_TPL_TOTEM[i], lv, x + off[i][1], y + off[i][2])
			if ni > 0 then
				PTHV_Tag(ni, w)
				SetNpcLife(ni, life, 1)
				n = n + 1
				SetTask(PTTT_T_HV_SLOTS[n], ni)
			end
			i = i + 1
		end
	else
		local tpl = PTHV_TPL_BOSS
		if w < PTHV_WAVES then tpl = PTHV_TPL_SOUL[w - 1] end
		local ni = PTHV_Add(tpl, lv, x + 6, y + 12)
		if ni > 0 then
			PTHV_Tag(ni, w)
			SetNpcLife(ni, life, 1)
			if w == PTHV_WAVES then SetNpcName(ni, PTHV_BOSS_NAME) else SetNpcName(ni, PTHV_SOUL_NAMES[w - 1]) end
			n = 1
			SetTask(PTTT_T_HV_SLOTS[1], ni)
		end
	end
	SetTask(PTTT_T_HV_WAVE, w)
	SetTask(PTTT_T_HV_LEFT, n)
	return n
end

function PTHV_WaveText(w)
	if w == 1 then return "ph¸ hñy 4 VËt Tæ HuyÒn Vò" end
	if w < PTHV_WAVES then return "®¸nh b¹i " .. PTHV_SOUL_NAMES[w - 1] end
	return "®¸nh b¹i " .. PTHV_BOSS_NAME
end

-- ---------------------------------------------------------------- run flow
function PTHV_Begin()
	PTHV_Sync()
	if GetTask(PTTT_T_HV_RUNS) >= PTHV_MAX then
		Msg2Player("Thö Th¸ch HuyÒn Vò: h«m nay ng­¬i ®· tham gia ®ñ " .. PTHV_MAX .. " lÇn.")
		SetTask(PTTT_T_HV_STATE, 0)
		return 0
	end
	local w, x, y = GetWorldPos()
	w = PTTT_MapId(w)
	if w == PTHV_MAP then w = PTHV_CITY[1] x = PTHV_CITY[2] y = PTHV_CITY[3] end
	SetTask(PTTT_T_HV_RETMAP, w)
	SetTask(PTTT_T_HV_RETX, x)
	SetTask(PTTT_T_HV_RETY, y)
	SetTask(PTTT_T_HV_RUNS, GetTask(PTTT_T_HV_RUNS) + 1)
	SetTask(PTTT_T_HV_SERIAL, PTTT_Now())
	SetTask(PTTT_T_HV_STATE, 2)
	SetTask(PTTT_T_HV_DEADLINE, PTTT_Now() + PTHV_TIME)
	if HaveIBBuff(PTHV_BUFF_REG) == 1 then RemoveIBBuff(PTHV_BUFF_REG) end
	AddIBBuff(PTHV_BUFF_ON, PTHV_TIME)
	NewWorld(PTHV_MAP, PTHV_ENTRY[1], PTHV_ENTRY[2])
	SetFightState(1)
	SetLogoutRV(1)
	local n = PTHV_SpawnWave(1, PTHV_ENTRY[1], PTHV_ENTRY[2])
	if n <= 0 then
		Msg2Player("Thö Th¸ch HuyÒn Vò: kh«ng gäi ®­îc VËt Tæ, thö th¸ch hñy (l­ît ®­îc hoµn l¹i).")
		SetTask(PTTT_T_HV_RUNS, GetTask(PTTT_T_HV_RUNS) - 1)
		PTHV_Leave()
		return 0
	end
	Msg2Player("<color=green>Thö Th¸ch HuyÒn Vò b¾t ®Çu!<color> Cã " .. floor(PTHV_TIME / 60) .. " phót ®Ó v­ît " .. PTHV_WAVES .. " ®ît. §ît 1: " .. PTHV_WaveText(1) .. ".")
	return 1
end

-- back to the saved point (or Trieu Ca)
function PTHV_Return()
	local m = GetTask(PTTT_T_HV_RETMAP)
	local x = GetTask(PTTT_T_HV_RETX)
	local y = GetTask(PTTT_T_HV_RETY)
	if m <= 0 or m == PTHV_MAP or x <= 0 or y <= 0 then m = PTHV_CITY[1] x = PTHV_CITY[2] y = PTHV_CITY[3] end
	SetLogoutRV(0)
	if PTHV_InArena() == 1 then
		NewWorld(m, x, y)
		SetFightState(0)
	end
end

function PTHV_End()
	PTHV_Cleanup()
	SetTask(PTTT_T_HV_STATE, 0)
	SetTask(PTTT_T_HV_WAVE, 0)
	SetTask(PTTT_T_HV_LEFT, 0)
	if HaveIBBuff(PTHV_BUFF_ON) == 1 then RemoveIBBuff(PTHV_BUFF_ON) end
	AddIBBuff(PTHV_BUFF_END, 300)
end

function PTHV_Leave()
	if GetTask(PTTT_T_HV_STATE) == 3 then
		if PTHV_Claim() == 1 then return end
	end
	PTHV_End()
	PTHV_Return()
end

function PTHV_Fail(reason)
	Msg2Player("<color=yellow>Thö Th¸ch HuyÒn Vò kÕt thóc: " .. reason .. "<color>")
	PTHV_End()
	PTHV_Return()
end

-- a wave NPC died (death script / DeathSelf). Credits the OWNER (NPC param 0), whoever killed it.
-- Returns 1 when the NPC belongs to a run (it is then removed), 0 for region-placed copies.
function PTHV_MobDeath(npc)
	local owner = GetNpcParam(npc, 0)
	local serial = GetNpcParam(npc, 1)
	local w = GetNpcParam(npc, 2)
	if serial == nil or serial == 0 or owner == nil or owner <= 0 then return 0 end
	SetNpcParam(npc, 1, 0)
	DelNpc(npc)
	local old = PlayerIndex
	PlayerIndex = owner
	local nm = GetName()
	if nm and nm ~= "" and GetTask(PTTT_T_HV_SERIAL) == serial and GetTask(PTTT_T_HV_STATE) == 2 and GetTask(PTTT_T_HV_WAVE) == w then
		local i = 1
		while PTTT_T_HV_SLOTS[i] do
			if GetTask(PTTT_T_HV_SLOTS[i]) == npc then SetTask(PTTT_T_HV_SLOTS[i], 0) end
			i = i + 1
		end
		local left = GetTask(PTTT_T_HV_LEFT) - 1
		SetTask(PTTT_T_HV_LEFT, left)
		if left <= 0 then
			PTHV_WaveDone(w)
		else
			Msg2Player("Thö Th¸ch HuyÒn Vò: cßn " .. left .. " VËt Tæ.")
		end
	end
	PlayerIndex = old
	return 1
end

function PTHV_WaveDone(w)
	local exp = GetLevel() * 800 * w
	AddOwnExp(exp)
	local x = PTHV_ENTRY[1]
	local y = PTHV_ENTRY[2]
	local m, px, py = GetWorldPos()
	if PTTT_MapId(m) == PTHV_MAP then x = px y = py end
	if w < PTHV_WAVES then
		local n = PTHV_SpawnWave(w + 1, x, y)
		if n <= 0 then
			PTHV_Fail("kh«ng gäi ®­îc ®ît " .. (w + 1) .. ".")
			return
		end
		local left = GetTask(PTTT_T_HV_DEADLINE) - PTTT_Now()
		Msg2Player("<color=green>V­ît ®ît " .. w .. "/" .. PTHV_WAVES .. "<color> (+" .. exp .. " kinh nghiÖm). §ît " .. (w + 1) .. ": " .. PTHV_WaveText(w + 1) .. ". Cßn " .. PTTT_TimeText(left) .. ".")
	else
		SetTask(PTTT_T_HV_STATE, 3)
		SetTask(PTTT_T_HV_DEADLINE, PTTT_Now() + PTHV_CHEST_GRACE)
		if HaveIBBuff(PTHV_BUFF_ON) == 1 then RemoveIBBuff(PTHV_BUFF_ON) end
		local ni = PTHV_Add(PTHV_TPL_CHEST, 1, x + 4, y + 8)
		if ni > 0 then
			PTHV_Tag(ni, 0)
			SetNpcName(ni, PTHV_CHEST_NAME)
			SetNpcScript(ni, PTHV_CHEST_SCRIPT)
			SetTask(PTTT_T_HV_SLOTS[1], ni)
			Msg2Player("<color=green>HuyÒn Vò ThÇn Hån ®· bÞ ®¸nh b¹i!<color> (+" .. exp .. " kinh nghiÖm). H·y më <color=yellow>" .. PTHV_CHEST_NAME .. "<color> bªn c¹nh ®Ó nhËn th­ëng.")
		else
			Msg2Player("<color=green>HuyÒn Vò ThÇn Hån ®· bÞ ®¸nh b¹i!<color> PhÇn th­ëng ®­îc trao ngay.")
			PTHV_Claim()
		end
	end
end

-- star bits 1..6 of task 2028 that are set
function PTHV_TT_Count()
	local n = 0
	local b = 1
	while b <= 6 do
		if GetTaskBit(PTHV_TT_TASK, b) > 0 then n = n + 1 end
		b = b + 1
	end
	return n
end

-- the star given by a chest: one the player still lacks, any once all six are placed
function PTHV_TT_PickStar()
	local miss = {}
	local b = 1
	while b <= 6 do
		if GetTaskBit(PTHV_TT_TASK, b) == 0 then miss[getn(miss) + 1] = b end
		b = b + 1
	end
	if getn(miss) == 0 then return random(1, 6) end
	return miss[random(1, getn(miss))]
end

-- chest reward; compare-and-set state 3 -> 0 with the items (full bag = nothing changes).
-- QuestExchange puts every unit in its own cell: 2 + 5 + 1 = 8 free cells.
function PTHV_Claim()
	if GetTask(PTTT_T_HV_STATE) ~= 3 then return 0 end
	local mat = 22 + random(0, 3)
	local star = PTHV_TT_PickStar()
	if QuestExchange(PTTT_T_HV_STATE, 3, 0, {}, { { 3, 115, 0, 0, 0, 0, 2 }, { 3, mat, 0, 0, 0, 0, 5 }, { 6, 1, PTHV_TT_PART + star, 0, 0, 0, 1 } }) ~= 1 then
		Msg2Player("Hµnh trang kh«ng ®ñ chç trèng (cÇn 8 «) ®Ó nhËn " .. PTHV_CHEST_NAME .. ".")
		return 0
	end
	local lv = GetLevel()
	AddOwnExp(lv * 20000)
	Earn(30000)
	local names = { "§Þa T©m", "Phong LÖ", "Thñy Hån", "Háa Linh" }
	Msg2Player("<color=green>" .. PTHV_CHEST_NAME .. ":<color> " .. (lv * 20000) .. " kinh nghiÖm, 30000 l­îng, 2 Tø T­îng Tinh Hoa, 5 " .. names[mat - 21] .. ", 1 HuyÒn Vò PhÇn " .. PTHV_TT_STARS[star] .. " (ThÊt Tinh HuyÒn Vò).")
	PTHV_End()
	PTHV_Return()
	return 1
end

-- ---------------------------------------------------------------- dialog (Thi Luyen Than Su)
function PTHV_Menu(npc)
	PTHV_Sync()
	local st = GetTask(PTTT_T_HV_STATE)
	if PTHV_InArena() == 1 then
		if st == 2 then
			local left = GetTask(PTTT_T_HV_DEADLINE) - PTTT_Now()
			local w = GetTask(PTTT_T_HV_WAVE)
			PTTT_Say("Thö th¸ch ®ang diÔn ra: ®ît <color=yellow>" .. w .. "/" .. PTHV_WAVES .. "<color> (" .. PTHV_WaveText(w) .. "), cßn " .. PTTT_TimeText(left) .. ".",
				{ "Rêi ThÇn Vùc (bá cuéc)/PTHV_AskLeave" })
		elseif st == 3 then
			PTTT_Say("Ng­¬i ®· chinh phôc HuyÒn Vò ThÇn Vùc. H·y më B¶o R­¬ng, hoÆc ®Ó ta trao th­ëng vµ ®­a ng­¬i vÒ.",
				{ "NhËn th­ëng vµ rêi ®i/PTHV_Leave" })
		else
			PTTT_Say("Thö th¸ch ®· kÕt thóc. Ta ®­a ng­¬i vÒ nhÐ?", { "Rêi HuyÒn Vò ThÇn Vùc/PTHV_Leave" })
		end
		return
	end
	if st == 2 or st == 3 then
		-- left the map without the NPC (death, relog): close the old run
		PTHV_Fail("ng­¬i ®· rêi HuyÒn Vò ThÇn Vùc.")
		st = 0
	end
	local opts = {}
	local hhmm = PTTT_HHMM()
	local left = PTHV_MAX - GetTask(PTTT_T_HV_RUNS)
	if st == 1 then
		opts[getn(opts) + 1] = "Hñy ®¨ng ký/PTHV_Unregister"
	elseif left > 0 and hhmm >= PTHV_REG_FROM and hhmm < PTHV_START then
		opts[getn(opts) + 1] = "§¨ng ký thö th¸ch 19:20/PTHV_Register"
	end
	if PTHV_ANYTIME == 1 and left > 0 then
		opts[getn(opts) + 1] = "Vµo thö th¸ch ngay (mét m×nh)/PTHV_EnterNow"
	end
	opts[getn(opts) + 1] = "§æi th­ëng ThÊt Tinh HuyÒn Vò/PTHV_ThatTinh"
	opts[getn(opts) + 1] = "T×m hiÓu Thö Th¸ch HuyÒn Vò/PTHV_Info"
	local s = "Ta lµ ThÝ LuyÖn ThÇn Sø, canh gi÷ cöa vµo <color=yellow>HuyÒn Vò ThÇn Vùc<color>. Mçi ngµy lóc <color=yellow>19:20<color> ThÇn Vùc më cho nh÷ng ai ®· ®¨ng ký (®¨ng ký tõ 18:50). H«m nay ng­¬i cßn <color=yellow>" .. left .. "<color> l­ît."
	if st == 1 then s = s .. " Ng­¬i ®· ®¨ng ký, h·y chê ®Õn 19:20." end
	PTTT_Say(s, opts)
end

function PTHV_Info()
	PTTT_Say("Thö Th¸ch HuyÒn Vò (tõ cÊp " .. PTHV_MINLV .. "): trong " .. floor(PTHV_TIME / 60) .. " phót ph¶i ph¸ 4 VËt Tæ HuyÒn Vò, råi lÇn l­ît ®¸nh b¹i HuyÒn Vò qua 6 cÊp hån (S¬, Trung, Cao, V­¬ng, Hoµng, ThÇn Hån) vµ cuèi cïng lµ HuyÒn Vò ThÇn Hån. Mçi ®ît nhËn kinh nghiÖm; v­ît hÕt sÏ cã HuyÒn Vò B¶o R­¬ng (Tø T­îng Tinh Hoa, nguyªn liÖu Tø T­îng, 1 sao ThÊt Tinh HuyÒn Vò, kinh nghiÖm, ng©n l­îng). Søc m¹nh qu¸i tÝnh theo cÊp cña ng­êi tham gia, mét m×nh còng v­ît ®­îc. ChÕt, tho¸t game hoÆc rêi b¶n ®å th× thö th¸ch kÕt thóc.",
		{ "Quay l¹i/PTHV_MenuBack" })
end

function PTHV_MenuBack()
	PTHV_Menu(0)
end

-- ---------------------------------------------------------------- ThÊt Tinh HuyÒn Vò exchange
function PTHV_ThatTinh()
	local n = PTHV_TT_Count()
	local have = ""
	local miss = ""
	local b = 1
	while b <= 6 do
		if GetTaskBit(PTHV_TT_TASK, b) > 0 then
			if have ~= "" then have = have .. ", " end
			have = have .. PTHV_TT_STARS[b]
		else
			if miss ~= "" then miss = miss .. ", " end
			miss = miss .. PTHV_TT_STARS[b]
		end
		b = b + 1
	end
	local reward = "1 HuyÒn Vò ThÇn Hån B¶o R­¬ng, 1 Tø T­îng Tinh Th¹ch vµ " .. (GetLevel() * PTHV_TT_EXP) .. " kinh nghiÖm"
	if n < 6 then
		local s = "ThÊt Tinh HuyÒn Vò cña ng­¬i míi cã <color=yellow>" .. n .. "/6<color> sao"
		if have ~= "" then s = s .. " (" .. have .. ")" end
		s = s .. ", cßn thiÕu sao <color=yellow>" .. miss .. "<color>. Mçi HuyÒn Vò B¶o R­¬ng cña Thö Th¸ch HuyÒn Vò cã 1 HuyÒn Vò PhÇn; bÊm chuét ph¶i ®Ó ®Æt sao vµo vÞ trÝ. §ñ 6 sao, ta ®æi cho ng­¬i " .. reward .. "."
		PTTT_Say(s, { "Quay l¹i/PTHV_MenuBack" })
		return
	end
	local done = GetTask(PTHV_TT_COUNT)
	local s = "ThÊt Tinh HuyÒn Vò ®· ®ñ <color=yellow>6/6<color> sao. Ta cã thÓ ®æi cho ng­¬i <color=yellow>" .. reward .. "<color> (cÇn 2 « trèng). Sau khi ®æi, 6 sao ®­îc thu l¹i ®Ó ng­¬i s­u tÇm lÇn n÷a."
	if done > 0 then s = s .. " Ng­¬i ®· ®æi " .. done .. " lÇn." end
	PTTT_Say(s, { "§æi th­ëng ThÊt Tinh HuyÒn Vò/PTHV_ThatTinhDo", "Quay l¹i/PTHV_MenuBack" })
end

function PTHV_ThatTinhDo()
	if PTHV_TT_Count() < 6 then PTHV_ThatTinh() return end
	local cur = GetTask(PTHV_TT_TASK)
	if QuestExchange(PTHV_TT_TASK, cur, cur - PTHV_TT_MASK, {}, PTHV_TT_REWARD) ~= 1 then
		PTTT_Say("Hµnh trang cña ng­¬i kh«ng ®ñ chç trèng (cÇn 2 «), h·y s¾p xÕp l¹i råi quay l¹i ®æi th­ëng.", {})
		return
	end
	local exp = GetLevel() * PTHV_TT_EXP
	AddOwnExp(exp)
	SetTask(PTHV_TT_COUNT, GetTask(PTHV_TT_COUNT) + 1)
	WriteLog("[That Tinh Huyen Vu] " .. GetName() .. " exchange #" .. GetTask(PTHV_TT_COUNT))
	Msg2Player("<color=green>ThÊt Tinh HuyÒn Vò:<color> nhËn 1 HuyÒn Vò ThÇn Hån B¶o R­¬ng, 1 Tø T­îng Tinh Th¹ch vµ " .. exp .. " kinh nghiÖm.")
	PTTT_Say("ThÊt Tinh HuyÒn Vò quy vÞ, HuyÒn Vò ban th­ëng cho ng­¬i. H·y tiÕp tôc s­u tÇm 6 sao ®Ó ®æi lÇn sau.", {})
end

function PTHV_CheckEntry()
	if GetLevel() < PTHV_MINLV then
		PTTT_Say("§Õn cÊp " .. PTHV_MINLV .. " ng­¬i míi ®ñ søc b­íc vµo HuyÒn Vò ThÇn Vùc.", {})
		return 0
	end
	if GetTask(PTTT_T_HV_RUNS) >= PTHV_MAX then
		PTTT_Say("H«m nay ng­¬i ®· tham gia ®ñ " .. PTHV_MAX .. " lÇn, ngµy mai h·y quay l¹i.", {})
		return 0
	end
	return 1
end

function PTHV_Register()
	PTHV_Sync()
	if PTHV_CheckEntry() == 0 then return end
	local hhmm = PTTT_HHMM()
	if hhmm < PTHV_REG_FROM or hhmm >= PTHV_START then
		PTTT_Say("ChØ nhËn ®¨ng ký tõ 18:50 ®Õn tr­íc 19:20.", {})
		return
	end
	SetTask(PTTT_T_HV_STATE, 1)
	local mins = (floor(PTHV_START / 100) * 60 + mod(PTHV_START, 100)) - (floor(hhmm / 100) * 60 + mod(hhmm, 100))
	if mins < 1 then mins = 1 end
	AddIBBuff(PTHV_BUFF_REG, mins * 60)
	Msg2Player("<color=green>§· ®¨ng ký Thö Th¸ch HuyÒn Vò.<color> §óng 19:20 ng­¬i sÏ ®­îc ®­a vµo HuyÒn Vò ThÇn Vùc (cÇn ®ang trùc tuyÕn).")
end

function PTHV_Unregister()
	if GetTask(PTTT_T_HV_STATE) == 1 then SetTask(PTTT_T_HV_STATE, 0) end
	if HaveIBBuff(PTHV_BUFF_REG) == 1 then RemoveIBBuff(PTHV_BUFF_REG) end
	Msg2Player("§· hñy ®¨ng ký Thö Th¸ch HuyÒn Vò.")
end

function PTHV_EnterNow()
	PTHV_Sync()
	if PTHV_CheckEntry() == 0 then return end
	local st = GetTask(PTTT_T_HV_STATE)
	if st ~= 0 and st ~= 1 then return end
	PTHV_Begin()
end

function PTHV_AskLeave()
	PTTT_Say("Rêi ThÇn Vùc b©y giê th× thö th¸ch kÕt thóc vµ l­ît h«m nay vÉn bÞ tÝnh. Ng­¬i ch¾c chø?", { "Rêi ®i/PTHV_Leave" })
end

-- ---------------------------------------------------------------- minute tick, per online player
function PTHV_TickPlayer(hhmm)
	local st = GetTask(PTTT_T_HV_STATE)
	if st == 0 then return end
	PTHV_Sync()
	st = GetTask(PTTT_T_HV_STATE)
	if st == 1 then
		if hhmm >= PTHV_START and hhmm <= PTHV_START_LAST then
			if GetLevel() >= PTHV_MINLV then PTHV_Begin() else SetTask(PTTT_T_HV_STATE, 0) end
		elseif hhmm > PTHV_START_LAST then
			SetTask(PTTT_T_HV_STATE, 0)
		end
		return
	end
	local left = GetTask(PTTT_T_HV_DEADLINE) - PTTT_Now()
	if st == 2 then
		if PTHV_InArena() == 0 then
			PTHV_Fail("ng­¬i ®· rêi HuyÒn Vò ThÇn Vùc.")
		elseif left <= 0 then
			PTHV_Fail("hÕt thêi gian ë ®ît " .. GetTask(PTTT_T_HV_WAVE) .. "/" .. PTHV_WAVES .. ".")
		else
			Msg2Player("Thö Th¸ch HuyÒn Vò: ®ît " .. GetTask(PTTT_T_HV_WAVE) .. "/" .. PTHV_WAVES .. ", cßn " .. PTTT_TimeText(left) .. ".")
		end
	elseif st == 3 then
		if left <= 0 or PTHV_InArena() == 0 then
			if PTHV_Claim() ~= 1 then PTHV_End() PTHV_Return() end
		end
	end
end
