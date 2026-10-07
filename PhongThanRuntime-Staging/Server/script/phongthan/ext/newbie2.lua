-- Phong Than 2026-10-03 (newbie2): minute tick of the new-era newbie chain (taskinfo 894-925, 999-1010,
-- 3003-3005). servertimer.lua PTAdm_ExtTick() loads this file and calls PTEXT_newbie2_Tick() once per minute,
-- protected. Work:
--  1. first tick: ReLoadScript of the loose NPC/mob scripts and of the 14 mat tich stubs (GBK paths, ptfix only);
--  2. keep the 3 Quan Su (Tan thu) and the 2 field doctors alive (idempotent: index + name check), re-arm the
--     Quan Su poll timer (SetNpcTimer 3 s, OnTimer in quan_su.lua);
--  3. bind newbie2\nb2_mob.lua to the target monsters once the field population is placed (PT_SPAWN_DONE):
--     spawn_main monsters (PT_SPAWN_NPCS) + VNG region monsters of 1014/1016; full pass again every 30 min;
--  4. fallback poll of every online player (proximity steps, level gates, chest spawns, hints).
-- Doc: docs\features\tan-thu-moi-phong-than-20261003.md
Include("\\script\\phongthan\\newbie2\\nb2_lib.lua")

PTNB2_QS_SCRIPT = "\\script\\phongthan\\newbie2\\quan_su.lua"
PTNB2_DP_SCRIPT = "\\script\\phongthan\\newbie2\\nb2_dp.lua"
PTNB2_REG_SCRIPTS = {
	"\\script\\phongthan\\newbie2\\quan_su.lua",
	"\\script\\phongthan\\newbie2\\nb2_dp.lua",
	"\\script\\phongthan\\newbie2\\nb2_mob.lua",
	-- mat tich / lenh stubs (ptfix, GBK paths of settings\item\001\magicscript.txt rows 6/1/303-309, 350-356)
	"\\script\\item\\\190\184\200\203\190\237\214\225.lua",
	"\\script\\item\\\187\183\185\183\190\237\214\225.lua",
	"\\script\\item\\\180\243\245\224\200\203\190\237\214\225.lua",
	"\\script\\item\\\178\221\207\201\198\197\198\197.lua",
	"\\script\\item\\\209\169\209\253\190\237\214\225.lua",
	"\\script\\item\\\209\169\212\173\190\222\202\222\190\237\214\225.lua",
	"\\script\\item\\\202\213\188\175\190\237\214\225.lua",
	"\\script\\item\\\190\237\214\225\185\198\181\241.lua",
	"\\script\\item\\\190\237\214\225\207\196\184\251\202\172.lua",
	"\\script\\item\\\190\237\214\225\186\236\201\183.lua",
	"\\script\\item\\\190\237\214\225\188\215\191\199\200\203.lua",
	"\\script\\item\\\190\237\214\225\186\218\201\183\183\228.lua",
	"\\script\\item\\\190\237\214\225\185\237\212\166.lua",
	"\\script\\item\\\190\237\214\225\186\181\185\234.lua",
}
-- { map, template, level, cell x, cell y, name, script, poll timer }
PTNB2_NPCS = {
	{ 1002, 211, 1, 1632, 3200, PTNB2_TXT.qs_name, PTNB2_QS_SCRIPT, 1 },  -- taskinfo 3003 [2,204,200]
	{ 1003, 211, 1, 1688, 3120, PTNB2_TXT.qs_name, PTNB2_QS_SCRIPT, 1 },  -- taskinfo 3004 [3,211,195]
	{ 1004, 211, 1, 1560, 3216, PTNB2_TXT.qs_name, PTNB2_QS_SCRIPT, 1 },  -- taskinfo 3005 [4,195,201]
	{ 1016, 149, 1, 1511, 3122, PTNB2_N_DPTS, PTNB2_DP_SCRIPT, nil },    -- Tam Son, walkable cell near the north gate
	{ 1014, 149, 1, 1368, 3106, PTNB2_N_DPDQ, PTNB2_DP_SCRIPT, nil },    -- Dong Quan, walkable cell near the north-west gate
}
-- templates (Npcs.txt row, 0-based) counted by the chain / mat tich: Kiem Nhan 0, Tuyet Quai 1, Hoa Dien 2,
-- Bang Lang 4, Luc Quai 5, Cuong Dieu 6, Hoan Cau 7, Yem Hoa 8, Thao Tien 9, Co Dieu 10, Cot Tinh 11, Nguu Sat 12,
-- Giap Cot 13, Da Xoa 15, Hac Phong 18, Giang Quy 24, Xa Than 3 (Manh Giap of the "Thu thap" mat tich)
PTNB2_BIND_TID = { [0] = 1, [1] = 1, [2] = 1, [3] = 1, [4] = 1, [5] = 1, [6] = 1, [7] = 1, [8] = 1, [9] = 1, [10] = 1,
	[11] = 1, [12] = 1, [13] = 1, [15] = 1, [18] = 1, [24] = 1 }
PTNB2_BIND_REGION_MAPS = { [1014] = 1, [1016] = 1 }   -- original VNG Region_S monsters (not in PT_SPAWN_NPCS)
PTNB2_BIND_BUDGET = 8000
PTNB2_BIND_REPEAT = 30 * 60 * 18
if PTNB2_NPC_IDX == nil then PTNB2_NPC_IDX = {} end
if PTNB2_BOUND == nil then PTNB2_BOUND = {} end

function PTNB2_Register()
	if PTNB2_REGISTERED then return end
	local i = 1
	while PTNB2_REG_SCRIPTS[i] do
		ReLoadScript(PTNB2_REG_SCRIPTS[i])
		i = i + 1
	end
	PTNB2_REGISTERED = 1
end

function PTNB2_EnsureNpcs()
	local k = 1
	while PTNB2_NPCS[k] do
		local s = PTNB2_NPCS[k]
		local ni = PTNB2_NPC_IDX[k]
		if not (ni and ni > 0 and GetNpcName(ni) == s[6]) then
			ni = nil
			local sw = SubWorldID2Idx(s[1])
			if sw and sw >= 0 then
				local x = AddNpc(s[2], s[3], sw, s[4] * 32, s[5] * 32, 0)
				if x and x > 0 then
					SetNpcName(x, s[6])
					SetNpcScript(x, s[7])
					PTNB2_NPC_IDX[k] = x
					ni = x
				end
			end
		end
		if ni and s[8] then SetNpcTimer(ni, s[7], 3) end
		k = k + 1
	end
end

function PTNB2_BindMobs()
	if not PT_SPAWN_DONE then return end
	local now = GetGameTime()
	if PTNB2_BIND_I == nil then
		if PTNB2_BIND_TM and now >= PTNB2_BIND_TM and now - PTNB2_BIND_TM < PTNB2_BIND_REPEAT then return end
		PTNB2_BIND_I = 1
		PTNB2_BIND_N = 0
		PTNB2_SPAWNSET = {}
		local k = 1
		while PT_SPAWN_NPCS and k <= (PT_SPAWN_NPCN or 0) do
			if PT_SPAWN_NPCS[k] then PTNB2_SPAWNSET[PT_SPAWN_NPCS[k]] = 1 end
			k = k + 1
		end
	end
	local i = PTNB2_BIND_I
	local last = i + PTNB2_BIND_BUDGET - 1
	if last > PTNB2_MAX_NPC then last = PTNB2_MAX_NPC end
	while i <= last do
		local id = GetNpcID(i)
		if id and id > 0 and PTNB2_BOUND[i] ~= id then
			local tid = GetNpcTemplateID(i)
			if tid and PTNB2_BIND_TID[tid] then
				local w = GetNpcPos(i)
				if PTNB2_SPAWNSET[i] or PTNB2_BIND_REGION_MAPS[w] then
					SetNpcScript(i, PTNB2_MOB_SCRIPT)
					PTNB2_BOUND[i] = id
					PTNB2_BIND_N = PTNB2_BIND_N + 1
				end
			end
		end
		i = i + 1
	end
	PTNB2_BIND_I = i
	if i > PTNB2_MAX_NPC then
		PTNB2_BIND_I = nil
		PTNB2_BIND_TM = now
		if PTAdm_Log then PTAdm_Log("newbie2", "OK", "bound " .. PTNB2_BIND_N .. " monsters") end
	end
end

function PTEXT_newbie2_Tick()
	PTNB2_Register()
	PTNB2_EnsureNpcs()
	PTNB2_BindMobs()
	PTNB2_ScanNpcs(PTNB2_MAX_NPC)
	PTNB2_PollAll()
end
