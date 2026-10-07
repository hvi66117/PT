-- ct_boss.lua (Lua 4, Phong Than GameServer) - 2026-10-03 congthanh2
-- Taskinfo 908 "Phuong phap moi" step 1 asks for the world boss Cuu Linh (VNG \script\npcdeath\<GBK jiu ying>.lua
-- sets task 908 = 2 for the killer and his team on the map; that path still works for the scheduled boss).
-- Solo option: a personal Cuu Linh, scaled to the player, summoned at the Lanh dia quan or the Phong luyen thuoc
-- while task 908 = 1. Template 123 (same ani039 body as the world boss 86) with a normal death script, so the
-- world-boss system (GlobalValue 101 / 4161, wb_lib.lua loot) never sees it. Kill counted by ct_mob.lua:
-- LastDamage (player kill: killer + team on the map) or Revive (killed by someone else: the summoner is credited).
-- Included by ct_steward.lua, ct_api.lua (Phong luyen thuoc) and ct_mob.lua.
Include("\\script\\phongthan\\congthanh\\ct_lib.lua")

if PTCT_BOSS_LOADED == nil then
PTCT_BOSS_LOADED = 1
PTCT_BOSS_TASK = 908
PTCT_BOSS_TPL = 123
PTCT_BOSS_MAP = 1020
PTCT_BOSS_X = 1509           -- open ground west of the territory row (server + client grid free 5x5)
PTCT_BOSS_Y = 3047
PTCT_BOSS_PX = 1514          -- the summoner is moved next to it
PTCT_BOSS_PY = 3042
PTCT_BOSS_CD = 5             -- minutes between two summons
PTCT_BOSS_LIFE = 15 * 60 * 18  -- frames before an unbeaten shadow leaves
PTCT_BOSS_MINLV = 40
PTCT_BOSS_NAME = "C\246u Linh (b\227ng)"
end

function PTCT_B_Now() return floor(SystemTime() / 60) end
function PTCT_B_Id()
	local id = GetPlayerID()
	if id == nil then return 0 end
	return mod(id, 1000000)
end

-- PlayerIndex = the player to credit; 1 when 908 went 1 -> 2
function PTCT_B_Credit()
	if GetTask(PTCT_BOSS_TASK) ~= 1 then return 0 end
	Msg2Player("B\185n \174\183 h\185 s\184t th\181nh c\171ng C\246u Linh ")
	SetTask(PTCT_BOSS_TASK, 2)
	TaskNote(908, 2)
	return 1
end

-- the shadow died once (killer = 1 when PlayerIndex is the player who landed the last hit)
function PTCT_B_Killed(npc, killer)
	if GetNpcParam(npc, 4) ~= 0 then return 0 end
	SetNpcParam(npc, 4, 1)
	local old = PlayerIndex
	local n = 0
	if killer and PlayerIndex and PlayerIndex > 0 then
		local w = GetWorldPos()
		n = n + PTCT_B_Credit()
		if GetTeam() ~= 0 then
			local m = GetTeamSize()
			local i = 1
			while i <= m do
				PlayerIndex = GetTeamMember(i)
				if PlayerIndex and PlayerIndex > 0 and GetWorldPos() == w then n = n + PTCT_B_Credit() end
				PlayerIndex = old
				i = i + 1
			end
		end
	end
	-- the summoner keeps the credit when a bot, a guard or a stranger finished his shadow
	local p = GetNpcParam(npc, 5)
	if p > 0 then
		local id = GetPlayerID(p)
		if id ~= nil and mod(id, 1000000) == GetNpcParam(npc, 6) then
			PlayerIndex = p
			n = n + PTCT_B_Credit()
		end
	end
	PlayerIndex = old
	return n
end

-- spawn the personal shadow; returns the NPC index or a negative code
--   -1 step 1 not active, -2 cooldown (second return = minutes left), -3 map / AddNpc failed
function PTCT_B_Summon()
	if GetTask(PTCT_BOSS_TASK) ~= 1 then return -1 end
	local now = PTCT_B_Now()
	local last = GetTask(PTCT_T_BOSS)
	if last > 0 and now >= last and now - last < PTCT_BOSS_CD then return -2, PTCT_BOSS_CD - (now - last) end
	local sw = SubWorldID2Idx(PTCT_BOSS_MAP)
	if not sw or sw < 0 then return -3 end
	local lv = GetLevel()
	if lv < PTCT_BOSS_MINLV then lv = PTCT_BOSS_MINLV end
	local ni = AddNpc(PTCT_BOSS_TPL, lv, sw, PTCT_BOSS_X * 32, PTCT_BOSS_Y * 32, 0)
	if not ni or ni <= 0 then ni = AddNpc(PTCT_BOSS_TPL, lv, sw, (PTCT_BOSS_X + 1) * 32, PTCT_BOSS_Y * 32, 0) end
	if not ni or ni <= 0 then return -3 end
	SetNpcName(ni, PTCT_BOSS_NAME)
	SetNpcLife(ni, lv * 900, 1)
	SetNpcDamage(ni, lv * 2, lv * 3)
	SetNpcCurCamp(ni, 5)
	SetNpcRevTime(ni, 36)
	SetNpcScript(ni, PTCT_MOB_SCRIPT)
	SetNpcParam(ni, 1, PTCT_K)
	SetNpcParam(ni, 2, now)
	SetNpcParam(ni, 3, PTCT_ROLE_BOSS)
	SetNpcParam(ni, 4, 0)
	SetNpcParam(ni, 5, PlayerIndex)
	SetNpcParam(ni, 6, PTCT_B_Id())
	SetNpcTimeout(ni, PTCT_BOSS_LIFE)
	SetTask(PTCT_T_BOSS, now)
	return ni
end

function PTCT_B_Ask()
	if GetTask(PTCT_BOSS_TASK) ~= 1 then
		Talk(1, "PTCT_No", "Ch\216 khi \174ang l\181m b\173\237c <color=green>di\214t C\246u Linh<color> c\241a nhi\214m v\244 Ph\173\172ng ph\184p m\237i m\237i c\227 th\211 khi\170u chi\213n b\227ng C\246u Linh.")
		return
	end
	MsgBox("Tri\214u h\229i <color=green>b\227ng C\246u Linh<color> (s\248c m\185nh theo c\202p c\241a ng\173\172i) \235 b\183i \174\202t tr\232ng ph\221a t\169y l\183nh \174\222a? H\185 n\227 c\242ng \174\173\238c t\221nh nh\173 h\185 C\246u Linh. Boss th\213 gi\237i C\246u Linh \235 Tam S\172n v\201n \174\173\238c t\221nh nh\173 c\242.", "PTCT_B_Ok", "PTCT_No")
end

function PTCT_B_Ok()
	local ni, left = PTCT_B_Summon()
	if ni == -1 then return end
	if ni == -2 then
		PTCT_Say1("B\227ng C\246u Linh v\245a \174\173\238c tri\214u h\229i. H\183y \174\238i th\170m <color=green>" .. left .. "<color> ph\243t.")
		return
	end
	if ni < 0 then
		PTCT_Say1("Kh\171ng th\211 tri\214u h\229i l\243c n\181y, h\183y th\246 l\185i sau.")
		return
	end
	NewWorld(PTCT_BOSS_MAP, PTCT_BOSS_PX, PTCT_BOSS_PY)
	SetFightState(1)
	Msg2Player("B\227ng C\246u Linh \174\183 hi\214n ra ph\221a t\169y l\183nh \174\222a. H\185 n\227 trong 15 ph\243t!")
end
