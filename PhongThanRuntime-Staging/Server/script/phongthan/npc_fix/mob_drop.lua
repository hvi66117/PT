-- Phong Than npc_fix 2026-09-29: quest item drops for ordinary monsters (ASCII file).
-- This server build never reads DropRateFile and the VNG \script\npcdeath\*.lua files are
-- missing, so collection quests could not be finished. Bound by spawn_main.lua
-- (PTSpawn_BindDrop) to every spawned monster whose template has a rule below; the engine
-- calls LastDamage(npc) with PlayerIndex = the kill owner.
-- Items only drop while the killer is on the matching quest step (VNG task values), up to
-- the count the quest asks for. Source: VNG npc_fix consumers + droprate ini + pak3
-- \script\[guaiwu]\*.lua (yichuan 2004); see docs\features\roi-vat-pham-nhiem-vu-phong-than-20260929.md
-- questfix3 2026-10-04: Yem Hoa (8) / Tuyet Nguyen Cu Thu (103) kills move task 15 5 -> 6 (PTDrop_Task15);
-- PTDrop_Special now also runs for templates that have a material rule. See
-- docs\features\questfix3-phong-than-20261004.md
Include("\\script\\phongthan\\lib\\vng_tasknote.lua")

-- percent chance per kill for genre-3 materials (VNG ini used 2%; raised for a small server)
PTDROP_RATE = 35

-- template -> { detail of (3,detail,0), cap, { {task, value}, ... } }
PTDROP_MAT = {
	[0] = { 10, 10, { {21, 3}, {26, 10}, {321, 10} } },           -- Kiem Nhan -> Doan Kiem
	[3] = { 11, 10, { {23, 1}, {26, 11}, {321, 11} } },           -- Xa Than (Bac Hai phan quan) -> Manh Giap
	[2] = { 12, 10, { {31, 5}, {36, 12}, {321, 12} } },           -- Hoa Dien -> Mat Quy
	[1] = { 13, 10, { {11, 2}, {16, 13}, {321, 13} } },           -- Tuyet Quai -> Bang Co
	[4] = { 9, 10, { {14, 1}, {13, 1}, {16, 9}, {321, 9} } },     -- Bang Lang -> Ngoc Cot
	[8] = { 9, 10, { {14, 1}, {13, 1}, {16, 9}, {321, 9} } },     -- Yem Hoa (Tay Con Lon) -> Ngoc Cot
	[6] = { 8, 10, { {33, 1}, {36, 8}, {321, 8} } },              -- Cuong Dieu -> Hoa Vu
}

PTDROP_FULL = "H\181nh trang kh\171ng \174\241 ch\231 tr\232ng."

function PTDrop_Mat(rule)
	local ok = 0
	local i = 1
	while rule[3][i] do
		if GetTask(rule[3][i][1]) == rule[3][i][2] then ok = 1 end
		i = i + 1
	end
	if ok == 0 then return end
	if HaveNormalItem(3, rule[1], 0, 0) >= rule[2] then return end
	if random(1, 100) > PTDROP_RATE then return end
	AddNormalItem(3, rule[1], 0, 1, 0, 0)
end

-- Khao nghiem of Van Trung Tu (Dao Si, task 15) step 5 -> 6: VNG template 8 Yem Hoa carries DeathScript
-- \script\npcdeath\xue_yuan_ju_shou.lua (GBK name; missing from every PAK, same body as
-- \script\guai_wu\xue_yuan_ju_shou.lua): task 15 == 5 -> 6, message, TaskNote(5,3). F11 (taskinfo 5): kill
-- Yem Hoa on Thu Duong son [168,192]. Template 103 (Tuyet Nguyen Cu Thu, Yem Hoa art, the 'Tuyet Nguyen'
-- named by Van Trung Tu) counts too: one is spawned on Tay Con Lon by spawn_1009.lua.
function PTDrop_Task15()
	if GetTask(15) == 5 then
		SetTask(15, 6)
		Msg2Player("\167\183 di\214t \174\173\238c Y\211m H\225a, quay v\210 ph\244c m\214nh V\169n Trung T\246.")
		TaskNote(5, 3)
	end
end

-- boss-type quest monsters (event items), logic of the VNG pak3 death scripts
function PTDrop_Special(tid)
	if tid == 8 or tid == 103 then
		PTDrop_Task15()
	elseif tid == 102 then
		-- Kiem Nhan tuong quan (Yen Son): blade / body / hilt for Giap Si task 25
		if GetTask(25) == 1 and GetPlayerType() == 0 then
			local r = random(1, 6)
			if r <= 3 and HaveEventItem(20 + r) < 1 then
				AddEventItem(20 + r)
			end
		end
	elseif tid == 101 then
		-- Phan quan doi truong (Yen Son): Thu tao phan for task 24
		if GetTask(24) == 2 then
			if QuestExchange(24, 2, 3, {}, {{4, 25, 0, 0, 0, 0, 1}}) == 1 then
				TaskNote(24, 3)
			else
				Msg2Player(PTDROP_FULL)
			end
		end
	elseif tid == 105 then
		-- Thao Tien ba ba (Mieu Cuong): Than Khi pieces for Di Nhan task 35
		local t = GetTask(35)
		if t >= 3 and t <= 5 and GetPlayerType() == 2 and HaveEventItem(28) <= 2 then
			if QuestExchange(35, t, t + 1, {}, {{4, 28, 0, 0, 0, 0, 1}}) ~= 1 then Msg2Player(PTDROP_FULL) end
		end
	elseif tid == 114 then
		-- Thi Thu (Bich Du Cung tang 2): Con Lon kinh for Xich Tinh Tu (task 50 == 5, task 52 == 1), 1/3
		if GetTask(50) == 5 and GetTask(52) == 1 and HaveEventItem(40) < 1 and random(1, 3) == 1 then
			AddEventItem(40)
		end
	elseif tid == 106 then
		-- Doc Dai yeu (Cu Loc): food of the lost tribesman for Di Nhan task 34
		if GetTask(34) == 3 and GetPlayerType() == 2 then
			if QuestExchange(34, 3, 4, {}, {{4, 30, 0, 0, 0, 0, 1}}) ~= 1 then Msg2Player(PTDROP_FULL) end
		end
	end
end

-- Thien Thu seed (no VNG source survives): level 35+, Thien Thu not started (tasks 321/322 = 0),
-- no seed held -> PTDROP_SEED_RATE % per kill gives Mam cay than bi (event 49) and marks task
-- 804 = 1 (seed type read by Sung Ung Buu / Linh Bao / Cao Giac / Ba Giam).
PTDROP_SEED_RATE = 3
function PTDrop_Seed()
	if GetLevel() < 35 or GetTask(321) ~= 0 or GetTask(322) ~= 0 or GetTask(804) ~= 0 then return end
	if HaveEventItem(49) >= 1 or HaveEventItem(164) >= 1 then return end
	if random(1, 100) > PTDROP_SEED_RATE then return end
	AddEventItem(49)
	SetTask(804, 1)
	Msg2Player("Nh\198t \174\173\238c M\199m c\169y th\199n b\221, h\183y mang \174\213n tr\229ng c\169y.")
end

function PTDrop_Death(npcIndex)
	local killer = PlayerIndex
	if (killer == nil) or (killer <= 0) then return end
	local tid = GetNpcTemplateID(npcIndex)
	if tid == nil then return end
	PTDrop_Seed()
	PlayerIndex = killer
	local rule = PTDROP_MAT[tid]
	if rule then
		PTDrop_Mat(rule)
		PlayerIndex = killer
	end
	PTDrop_Special(tid)
	PlayerIndex = killer
end

function LastDamage(npcIndex)
	PTDrop_Death(npcIndex)
end

function OnDeath(npcIndex)
end

function Revive(npcIndex)
end

function DeathSelf(npcIndex)
end
