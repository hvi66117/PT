-- Phong Than 2026-10-03 (botparty): auto party with fake-player bots ("to doi bot"), VNG style.
-- Generated from scratchpad\botparty\src\party.lua by gen.py: strings shown to players are TCVN3 bytes written
-- as \ddd escapes, keep this file ASCII. Doc: docs\features\to-doi-bot-phong-than-20261003.md
--
-- Loaded by bots.lua (Include, servertimer state + the registered OnTimer state) and by party_npc.lua.
-- While a player stands on a map with monsters (PTBP_MAPS), up to N bots (default 4, VNG team max 8 with the
-- player) join him: AddTotemNpc = owner + AiMode 11 (KNpcAI::ProcessAIType11: follows the owner, attacks the
-- owner's target or the nearest enemy, removed by the engine when the owner changes map / dies / hides / logs
-- out). Name "[To doi] <roster name>", level = player level +-2, camp 0 (only monsters are enemies).
--
-- EXP: KNpc::CalcDamage already books every hit of an owned AiMode-11 NPC on its owner (KNpc.cpp
-- "if (Npc[nAttacker].m_nOwnerIdx && Npc[nAttacker].m_AiMode == 11) nAttacker = owner"), so a kill by a party bot
-- is a kill by the player (EXP, drops, quest LastDamage). No Lua credit is added here: it would count twice.
-- Party bonus (VNG +15% per member in range): SetPartyBotBonus(pct) from the botparty C++ patch
-- (scratchpad\botparty\cpp_patch.md); without it the bots still fight for the player, only the bonus is missing.
--
-- Player task variables (range 2070-2079 of agent bots, unused in loose and PAK scripts):
--   2070 mode   0 = server setting (on), 1 = on, 2 = off (menu "Ho Tro To Doi" in the newbie towns)
--   2071 count  0 = server setting, 1..7
--   2072..2078  npc index of party bot 1..7 (checked: template 2703-2720, name tag, GetNpcOwner == player)
-- Lua 4: no true/false, no local function, no string.*/table.*; one small statement per data record.

PTBP_T_MODE = 2070
PTBP_T_COUNT = 2071
PTBP_T_SLOT = 2072
PTBP_MAX = 7                -- VNG team = 8 with the player
PTBP_MAX_TOTAL = 160        -- party bots on the whole server
PTBP_DEF_COUNT = 4
PTBP_DEF_BONUS = 15         -- % EXP per party bot in range (KPlayer k = 100 + 15 * (members - 1))
PTBP_RANGE = 24             -- cells = PLAYER_SHARE_EXP_DISTANCE 768 mps / 32
PTBP_LOST = 34              -- cells: beyond the AI-11 leash (900 mps) for a whole minute = stuck or a corpse
PTBP_TPL_MIN = 2703
PTBP_TPL_MAX = 2720
PTBP_KIND = 4               -- SetNpcParam(npc, 1): chat lines PTBOT_LINES[4] of bots.lua
PTBP_TIMER_SCRIPT = "\\script\\phongthan\\bots\\bots.lua"
PTBP_NPC_SCRIPT = "\\script\\phongthan\\bots\\party_npc.lua"
PTBP_TAG = "[T\230 \174\233i] "
PTBP_NPC_NAME = "H\231 Tr\238 T\230 \167\233i"
PTBP_NPC_TPL = 211

-- 2026-10-04 dinhanbot (user: "Di Nhan bot khong thay danh", "de cua bot Di Nhan cung danh"):
-- * AI 11 only casts skill slot 4. The Di Nhan templates 2715-2720 carry 44 / 45 / 47 / 49 and slot 4 = 49 Tram Tam
--   Chu, a curse (state 14, addphysicsdamage_v < 0 for 72 + 18 * lv frames, no damage attribute), so the bot only
--   debuffed and never hurt anything. Its damage skill is 44 Thoi Than Chu (physicsenhance_p, IsPhysical, missile
--   128 at the target, same shape as Giap Si 41 / missile 123). SetNpcSkill swaps slots 1 and 4 on every Di Nhan
--   party bot (NpcParam 3 = 1 once done): slot 4 = 44, slot 1 = 49. Npcs.txt (loose, shared) stays untouched.
-- * Every Di Nhan party bot calls one de tu (summon template by the player's level, PTTH_LIST of
--   item\trieuhoi_lenhbai.lua, pet level 1-10 like pet10) through AddNpcPet (C++ dinhanbot, PhongThanBotPet.h):
--   owner = the bot NPC, AiMode 11 (follows the bot, attacks its targets / nearest enemy). The engine removes the de
--   tu when the bot dies / is removed / changes map, PTBP_DelBot removes it with the bot, KNpc::CalcDamage books
--   its hits on the player (de tu -> bot -> player). Without that C++ (no AddNpcPet / GetNpcPetIdx) no de tu.
PTBP_DN_MIN = 2715
PTBP_DN_MAX = 2720
PTBP_DN_ATK = 44            -- Thoi Than Chu: damage
PTBP_DN_CURSE = 49          -- Tram Tam Chu: curse
PTBP_DN_SKLV = 10           -- template level of the 4 skills ("10|0")
PTBP_DN_FLAG = 3            -- NpcParam index: 1 = skills swapped
PTBP_PET_MAX_TOTAL = 60     -- bot de tu on the whole server
PTBP_PET_TAG = "[\167\214 t\246] "
PTBP_PET = {}
PTBP_PET[1] = { 359, 5 }
PTBP_PET[2] = { 360, 15 }
PTBP_PET[3] = { 361, 25 }
PTBP_PET[4] = { 362, 35 }
PTBP_PET[5] = { 403, 45 }
PTBP_PET[6] = { 404, 55 }
PTBP_PET[7] = { 405, 65 }
PTBP_PET[8] = { 406, 75 }
PTBP_PET[9] = { 407, 85 }
PTBP_PET[10] = { 1345, 95 }
PTBP_PET[11] = { 1346, 105 }
PTBP_PET[12] = { 2032, 120 }

-- 2026-10-04 bot9x (user: "Bot to doi danh chieu 9x nhe"): slot 4 (the only slot AI 11 casts) = the level-90 skill
-- of the class, VNG skill books vng00.pak \settings\item\001\skillbook.txt ("Sach ky nang <phai> cap 90"):
-- * Giap Si 2703-2708: 42 Khuynh Thanh Nhat Kich (IsPhysical, physicsenhance_p 40 + 4 * lv, AtFirer zone missile 124
--   DmgRange 10 cells + start skill 147, AttackRadius 120: hits every monster around the bot). Was 41 Thien Quan Tram.
-- * Dao Si 2709-2714: 26 Tam Muoi Chan Hoa (firedamage_v 300 + 30 * lv .. 400 + 40 * lv, Wall form at the target,
--   missile 51 DmgRange 15, TimePerCast 40 like the old 18). Player "series" is the class in Phong Than (newbie
--   scripts: 0 Giap Si / 1 Dao Si / 2 Di Nhan); the Npcs.txt Series of a bot is only its ngu hanh and no skill has a
--   Series column, so every class has exactly one level-90 skill whatever the bot series is.
-- * Di Nhan 2715-2720: the level-90 skill 51 Van Cot Toan Kho only has fatallystrike_p (AddBaseDamage 0, IsUseAR 0;
--   KNpc::CalcDamage returns before damage when min + max = 0 and uses bIsFS only on return damage) and is a Line
--   skill with a Stand missile born on the caster: cast by an NPC it never hurts anything. Di Nhan bots keep 44 Thoi
--   Than Chu in slot 4 (dinhanbot) and 49 in slot 1.
-- Skill level: 10 (template level, MaxLevel 10) below bot level 90, then +1 every 3 levels up to 20 at level 120
-- (KSkillManager loads any level < 64 from the level script). Slots 1-3 keep the template skills. Set once per bot:
-- NpcParam 3 = 2 (the dinhanbot value 1 is upgraded on the next tick, so live bots get it after a hot reload).
-- 2026-10-04 bot9x round 2 (user): Dao Si alternates 26 Tam Muoi Chan Hoa / 23 Loi Dong Cuu Thien / 25 Bang Phong Van
-- Ly ("Bang Hong Van Ly"), Di Nhan = 44 in every slot (49 dropped), Giap Si = 42 in every slot. The C++ bot9x patch of
-- KNpcAI::ProcessAIType11 picks at random a slot 1-4 whose attack skill is off cooldown (23 TimePerCast 125, 25 20,
-- 26 40), so a cooling skill never makes the bot stand still. 23: AtTarget, 8 missiles 18 (lightingdamage_v
-- 1 .. 200 + 20 * lv); 25: AtTarget, missile 1 + ring 117 (colddamage_v 120 + 15 * lv .. 200 + 25 * lv). Neither is
-- a Line + Stand skill. Older CoreServer (slot 4 only): Dao Si casts 26, the others 42 / 44, as in round 1.
-- { template min, template max, slot 1, slot 2, slot 3, slot 4 }
PTBP_SK = {}
PTBP_SK[1] = { 2703, 2708, 42, 42, 42, 42 }     -- Giap Si: Khuynh Thanh Nhat Kich (level 90)
PTBP_SK[2] = { 2709, 2714, 26, 23, 25, 26 }     -- Dao Si: Tam Muoi Chan Hoa (90), Loi Dong Cuu Thien (78), Bang Phong Van Ly (86)
-- 2026-10-04 botheal (C1): Di Nhan slot 1 = 45 Bo Tam Chu. The C++ botheal patch of KNpcAI::ProcessAIType11 casts it on
-- the player / another bot / the bot itself below 50% life (PhongThanAi11Heal) and PhongThanAi11PickSkill never picks
-- it as an attack (ally-only skill), so the bot still attacks with 44 from slots 2-4. Older CoreServer: slot 4 only
-- (44) or bot9x (45 is an ally-only Missles skill: FollowAttack would cast it at the bot's feet, a small area heal).
PTBP_SK[3] = { 2715, 2720, 45, 44, 44, 44 }     -- Di Nhan: Bo Tam Chu heal (slot 1) + Thoi Than Chu (51 does no damage when an NPC casts it)
PTBP_SK_FLAG = 3            -- NpcParam index (same as PTBP_DN_FLAG)
PTBP_SK_DONE = 4            -- slots set by botheal (1 = dinhanbot, 2 / 3 = bot9x round 1 / 2: all upgraded)
-- bot9x round 2: the de tu of every Di Nhan bot is Phong Quyen Tan Van (skill 458 -> summon template 407, PTBP_PET[9],
-- learn level 85), pet level by the pet10 rule of PTBP_PetPick. Its attack skill 145 (template slots 1-4, physical
-- spread arrows) is set in the 4 slots at the pet level: AddNpcPet only raised slot 4, and the engine casts the level
-- of the first slot holding the skill id (KSkillList::FindSame -> slot 1, level 1).
PTBP_PET_TPL = 407
PTBP_PET_LEARN = 85
PTBP_PET_SKILL = 145
PTBP_SK_LV0 = 10            -- skill level below bot level 90
PTBP_SK_LVMAX = 20

-- names / templates (roster of bots.lua, one statement per record)
PTBP_N = {}
PTBP_N[1] = { "Thi\170nLong", 2705 }
PTBP_N[2] = { "H\190cPhong", 2716 }
PTBP_N[3] = { "MinhNguy\214t", 2714 }
PTBP_N[4] = { "HoaR\172i", 2706 }
PTBP_N[5] = { "Ng\228cLan", 2719 }
PTBP_N[6] = { "LongV\173\172ng", 2711 }
PTBP_N[7] = { "B\184\167ao", 2704 }
PTBP_N[8] = { "V\171Danh", 2715 }
PTBP_N[9] = { "PhongV\169n", 2710 }
PTBP_N[10] = { "Xu\169nH\185", 2718 }
PTBP_N[11] = { "LyLy", 2712 }
PTBP_N[12] = { "NhuM\215", 2720 }
PTBP_N[13] = { "Ti\211uLong", 2707 }
PTBP_N[14] = { "Ki\213mKh\184ch", 2709 }
PTBP_N[15] = { "Kh\171iNguy\170n", 2703 }
PTBP_N[16] = { "Tuy\213tS\172n", 2713 }
PTBP_N[17] = { "Thi\170nH\185", 2708 }
PTBP_N[18] = { "LongH\230", 2717 }

-- spawn offsets around the player (cells), one per party slot
PTBP_OFF = {}
PTBP_OFF[1] = { 2, 1 }
PTBP_OFF[2] = { -2, 1 }
PTBP_OFF[3] = { 1, -2 }
PTBP_OFF[4] = { -1, 2 }
PTBP_OFF[5] = { 3, -1 }
PTBP_OFF[6] = { -3, -1 }
PTBP_OFF[7] = { 0, 3 }

-- maps with monsters (runtime ids): generated populations script\phongthan\spawn\spawn_<map>.lua + the VNG
-- Region_S monster maps 1014 / 1016. Towns (1002-1004, 1020, 1021) and the arena 1001 are not listed.
PTBP_MAPS = {}
PTBP_MAPS[1005] = 1 PTBP_MAPS[1006] = 1 PTBP_MAPS[1007] = 1 PTBP_MAPS[1008] = 1
PTBP_MAPS[1009] = 1 PTBP_MAPS[1010] = 1 PTBP_MAPS[1011] = 1 PTBP_MAPS[1012] = 1
PTBP_MAPS[1013] = 1 PTBP_MAPS[1014] = 1 PTBP_MAPS[1015] = 1 PTBP_MAPS[1016] = 1
PTBP_MAPS[1017] = 1 PTBP_MAPS[1018] = 1 PTBP_MAPS[1019] = 1 PTBP_MAPS[1022] = 1
PTBP_MAPS[1023] = 1 PTBP_MAPS[1024] = 1 PTBP_MAPS[1025] = 1 PTBP_MAPS[1026] = 1
PTBP_MAPS[1027] = 1 PTBP_MAPS[1028] = 1 PTBP_MAPS[1029] = 1 PTBP_MAPS[1030] = 1
PTBP_MAPS[1031] = 1 PTBP_MAPS[1032] = 1 PTBP_MAPS[1033] = 1 PTBP_MAPS[1034] = 1
PTBP_MAPS[1035] = 1 PTBP_MAPS[1036] = 1 PTBP_MAPS[1037] = 1 PTBP_MAPS[1038] = 1
PTBP_MAPS[1039] = 1 PTBP_MAPS[1040] = 1 PTBP_MAPS[1041] = 1 PTBP_MAPS[1042] = 1
PTBP_MAPS[1043] = 1 PTBP_MAPS[1044] = 1 PTBP_MAPS[1045] = 1 PTBP_MAPS[1046] = 1
PTBP_MAPS[1047] = 1 PTBP_MAPS[1048] = 1 PTBP_MAPS[1049] = 1 PTBP_MAPS[1050] = 1
PTBP_MAPS[1051] = 1 PTBP_MAPS[1053] = 1 PTBP_MAPS[1054] = 1 PTBP_MAPS[1055] = 1
PTBP_MAPS[1056] = 1 PTBP_MAPS[1057] = 1 PTBP_MAPS[1065] = 1 PTBP_MAPS[1072] = 1 PTBP_MAPS[1073] = 1
PTBP_MAPS[1074] = 1 PTBP_MAPS[1075] = 1 PTBP_MAPS[1076] = 1 PTBP_MAPS[1077] = 1
PTBP_MAPS[1078] = 1
-- coordinator 2026-10-03 partytown (user request): the bot party also follows the player in the towns, so
-- going back to town keeps the party and its EXP bonus (the engine removes AI-11 bots on every map change;
-- the minute tick spawns them again on the new map).
PTBP_MAPS[1002] = 1 PTBP_MAPS[1003] = 1 PTBP_MAPS[1004] = 1 PTBP_MAPS[1020] = 1
PTBP_MAPS[1021] = 1 PTBP_MAPS[1052] = 1
-- 2026-10-04 (agent vtcc, user request "bot tu to doi va danh boss cung" in Van Tien tran / Thuong Chu):
-- the 4 Van Tien tran maps (PTVT_MAPS of vt_data.lua: Huyen 1079-1082, monsters / tien / Thong Thien are camp 5 =
-- enemies of the camp-0 bots) and the Thuong Chu battlefield 1071 (armies get camp 1 / 2 by SetNpcCurCamp, so
-- there the bots take the player's side as camp, see PTBP_Camp). Bots are AI-11 NPCs, never mission players
-- (no AddMSPlayer), so PTVT_Inside / rewards / battlefield slots only see real players; their hits are booked on
-- the owner by the engine, like on every other map.
PTBP_MAPS[1079] = 1 PTBP_MAPS[1080] = 1 PTBP_MAPS[1081] = 1 PTBP_MAPS[1082] = 1
PTBP_MAPS[1071] = 1
PTBP_VT_MAP0 = 1078         -- Van Tien tran n is map 1078 + n
PTBP_VT_GV0 = 400           -- GlobalValue state of tran n = 400 + (n - 1) * 5: 1 preparation, 2 fight, 3 cleared
PTBP_TC_MAP = 1071          -- Thuong Chu battlefield (agent vienco)
PTBP_TC_SIDE = 2341         -- task: side 1 Thuong / 2 Chu of the player in the running round (vc_lib.lua)

-- "Ho Tro To Doi" dialog NPC (toggle / count), next to the Quan Su (Tan thu) of the 3 newbie towns
-- { map, template, cell x, cell y }; town grids have no Region_S obstacle there
PTBP_NPCS = {}
PTBP_NPCS[1] = { 1002, PTBP_NPC_TPL, 1635, 3203 }
PTBP_NPCS[2] = { 1003, PTBP_NPC_TPL, 1691, 3123 }
PTBP_NPCS[3] = { 1004, PTBP_NPC_TPL, 1563, 3219 }

PTBP_TXT_HEAD = "<color=yellow>[T\230 \174\233i]<color> "
PTBP_TXT_JOIN = " \174\229ng \174\233i bot \174\183 v\181o t\230 \174\233i, c\239ng b\185n \174\184nh qu\184i."
PTBP_TXT_BONUS = " Kinh nghi\214m t\230 \174\233i: +"
PTBP_TXT_NOBONUS = " (M\184y ch\241 ch\173a c\181i b\182n c\233ng th\170m kinh nghi\214m t\230 \174\233i.)"

-- 2026-10-04 botheal (C3): a dead party bot is replaced 5-10 s later instead of at the next minute tick. The minute
-- tick (PTBP_Player) arms an NPC timer on the player's own NPC (SetNpcTimer, the player's region is always active);
-- it calls OnTimer of the registered party_npc.lua -> PTBP_Watch every PTBP_WATCH_SEC seconds while the player keeps a
-- bot party. PTBP_Watch only looks at that player's slots: a slot that still holds a bot index (wanted at the last
-- minute tick) whose bot is gone (botparty:P3 removes a dead AI-11 bot after its death animation) or a corpse
-- (PTBP_Dead, older engine) for PTBP_REPL_DELAY frames gets a new bot (PTBP_Spawn + PTBP_SkTick + de tu), at most
-- PTBP_REPL_MAX per player per PTBP_REPL_WIN frames. An empty slot is never filled here, so the server limits
-- (PTBP_MAX_TOTAL, PTBP_PET_MAX_TOTAL) stay as the minute tick left them; dismiss, real team, town without party,
-- death and map change still go through the minute tick.
PTBP_WATCH_SEC = 5
PTBP_REPL_DELAY = 90        -- frames (18 per second): a death seen at one timer call is replaced at the next one
PTBP_REPL_MAX = 4           -- replacements per player per window
PTBP_REPL_WIN = 1080        -- frames = 60 s
PTBP_REG_VER = 2            -- PTBP_Register: the registered copies are reloaded once per version (hot reload)
PTBP_TXT_REPL = " \174\229ng \174\233i m\237i v\181o thay \174\229ng \174\233i b\222 tr\228ng th\173\172ng."

function PTBP_IsField(w)
	if not w or w <= 0 then return nil end
	if PTBP_MAPS[w] then return 1 end
	return nil
end

-- Van Tien tran map in preparation (or closed): no bots yet, otherwise they could kill a tien before the fight
-- starts (PTVT_BossDeath ignores kills before state 2 and the bosses never revive). They come at the next minute.
function PTBP_VtWait(w)
	local n = w - PTBP_VT_MAP0
	if n < 1 or n > 4 then return nil end
	local st = GetGlobalValue(PTBP_VT_GV0 + (n - 1) * 5)
	if st == 2 or st == 3 then return nil end
	return 1
end

-- camp of the player's bots on map w: on the battlefield the player's side (camp 1 / 2, enemy of the other army),
-- elsewhere 0 (camp_begin: only camp-5 monsters are enemies)
function PTBP_Camp(w)
	if w == PTBP_TC_MAP then
		local s = GetTask(PTBP_TC_SIDE)
		if s == 1 or s == 2 then return s end
	end
	return 0
end

-- number of party bots the current player (PlayerIndex) should have now
function PTBP_Want(cfg)
	if type(cfg) ~= "table" or cfg.enabled ~= 1 or cfg.party ~= 1 then return 0 end
	local cm, cc = PTBPC_Char()	-- adminops C4: web character row (1 always on, 2 always off)
	if cm == 2 then return 0 end
	if cm ~= 1 and GetTask(PTBP_T_MODE) == 2 then return 0 end
	local w = GetWorldPos()
	if not PTBP_IsField(w) then return 0 end
	if PTBP_VtWait(w) then return 0 end
	if GetTeamSize and GetTeamSize() > 1 then return 0 end
	if IsPlayerInDeath and IsPlayerInDeath() == 1 then return 0 end
	local n = PTBPC_Count(cc)	-- adminops C4: web character row / web count, 0 = as before
	if not n or n <= 0 then n = GetTask(PTBP_T_COUNT) end
	if not n or n <= 0 then n = cfg.partyCount or PTBP_DEF_COUNT end
	if n > PTBP_MAX then n = PTBP_MAX end
	if n < 0 then n = 0 end
	return n
end

function PTBP_Valid(ni, pname)
	if not ni or ni <= 0 then return nil end
	local id = GetNpcID(ni)
	if not id or id == 0 then return nil end
	local t = GetNpcTemplateID(ni)
	if not t or t < PTBP_TPL_MIN or t > PTBP_TPL_MAX then return nil end
	local nm = GetNpcName(ni)
	if type(nm) ~= "string" or strsub(nm, 1, strlen(PTBP_TAG)) ~= PTBP_TAG then return nil end
	if GetNpcOwner(ni) ~= pname then return nil end
	return 1
end

-- dead bot (AiMode 11 has no revive: without the C++ patch the corpse stays). GetNpcEnmityItem returns the
-- last attacker and damage = life max - current life; damage >= life max means current life <= 0.
function PTBP_Dead(ni)
	if not GetNpcEnmityItem then return nil end
	local a, aid, dmg = GetNpcEnmityItem(ni, 0)
	local mx = GetNpcLife(ni)
	if a and a > 0 and dmg and mx and mx > 0 and dmg >= mx then return 1 end
	return nil
end

function PTBP_Dist2(ni, w, x, y)
	local nw, nx, ny = GetNpcPos(ni)
	if nw ~= w or not nx then return 999999 end
	local dx = nx - x
	local dy = ny - y
	return dx * dx + dy * dy
end

-- tracked bot of slot j: 0 when the slot is empty, invalid, not wanted, dead or lost
function PTBP_Check(j, pname, w, x, y, want, seen)
	local var = PTBP_T_SLOT + j - 1
	local ni = GetTask(var)
	if not ni or ni <= 0 then return 0 end
	if seen[ni] or not PTBP_Valid(ni, pname) then
		SetTask(var, 0)
		return 0
	end
	if j > want or PTBP_Dead(ni) or PTBP_Dist2(ni, w, x, y) > PTBP_LOST * PTBP_LOST then
		PTBP_DelBot(ni)
		SetTask(var, 0)
		return 0
	end
	return ni
end

function PTBP_Spawn(j, w, x, y, lv, pi)
	local sw = SubWorldID2Idx(w)
	if not sw or sw < 0 then return 0 end
	local e = PTBPC_Pick(j, pi)	-- adminops C4: class ratio of the web, else the roster mix
	local o = PTBP_OFF[j]
	local l = PTBPC_Level(lv)	-- adminops C4: player level + web offset +- spread (default +-2)
	if l < 1 then l = 1 end
	local ni = AddTotemNpc(e[2], l, sw, (x + o[1]) * 32 + 16, (y + o[2]) * 32 + 16)
	if not ni or ni <= 0 then return 0 end
	SetNpcName(ni, PTBP_TAG .. e[1])
	local camp = PTBP_Camp(w)
	if SetNpcCamp then SetNpcCamp(ni, camp) end
	SetNpcCurCamp(ni, camp)
	SetNpcParam(ni, 1, PTBP_KIND)
	SetNpcParam(ni, 2, 0)
	SetNpcTimer(ni, PTBP_TIMER_SCRIPT, random(20, 60))
	return ni
end

-- dinhanbot: Di Nhan party bot?
function PTBP_IsDn(ni)
	local t = GetNpcTemplateID(ni)
	if t and t >= PTBP_DN_MIN and t <= PTBP_DN_MAX then return 1 end
	return nil
end

-- dinhanbot: live de tu of bot ni (0 = none or the C++ part is missing)
function PTBP_PetOf(ni)
	if not GetNpcPetIdx or not ni or ni <= 0 then return 0 end
	local p = GetNpcPetIdx(ni)
	if not p or p <= 0 then return 0 end
	return p
end

-- dinhanbot: remove a party bot and its de tu
function PTBP_DelBot(ni)
	local p = PTBP_PetOf(ni)
	if p > 0 then DelNpc(p) end
	DelNpc(ni)
end

-- dinhanbot: summon template and levels for player level lv -> template, npc level, pet level 1-10
-- bot9x round 2: always Phong Quyen Tan Van (PTBP_PET_TPL 407, learn level 85) instead of the PTBP_PET row of the
-- player's level; pet level = (lv - 85) / 5 + 1 within 1-10, npc level = 85 + 5 * (pet level - 1), never above lv
function PTBP_PetPick(lv)
	local d = lv - PTBP_PET_LEARN
	if d < 0 then d = 0 end
	local pl = (d - mod(d, 5)) / 5 + 1
	if pl > 10 then pl = 10 end
	local nl = PTBP_PET_LEARN + 5 * (pl - 1)
	if nl > lv then nl = lv end
	if nl < 1 then nl = 1 end
	return PTBP_PET_TPL, nl, pl
end

-- bot9x: skill level for a bot of level lv
function PTBP_SkLevel(lv)
	if not lv or lv < 90 then return PTBP_SK_LV0 end
	local d = lv - 90
	local s = PTBP_SK_LV0 + (d - mod(d, 3)) / 3
	if s > PTBP_SK_LVMAX then s = PTBP_SK_LVMAX end
	return s
end

-- bot9x: slots 1-4 of party bot ni = the PTBP_SK row of its class (once; lv = player level when the engine has no
-- GetNpcLevel). Returns the slot-4 skill id, 0 when nothing changed.
function PTBP_SkTick(ni, lv)
	if not SetNpcSkill then return 0 end
	if GetNpcParam(ni, PTBP_SK_FLAG) == PTBP_SK_DONE then return 0 end
	local t = GetNpcTemplateID(ni)
	if not t then return 0 end
	local e = nil
	local k = 1
	while PTBP_SK[k] do
		if t >= PTBP_SK[k][1] and t <= PTBP_SK[k][2] then e = PTBP_SK[k] end
		k = k + 1
	end
	if not e then return 0 end
	local bl = lv
	if GetNpcLevel then bl = GetNpcLevel(ni) end
	if not bl or bl <= 0 then bl = lv end
	local sl = PTBP_SkLevel(bl)
	local s = 1
	while s <= 4 do
		SetNpcSkill(ni, e[2 + s], sl, s)
		s = s + 1
	end
	SetNpcParam(ni, PTBP_SK_FLAG, PTBP_SK_DONE)
	return e[6]
end

-- dinhanbot: one live party bot ni of the current player (lv = player level, camp = camp of the bots on this map):
-- Di Nhan skill slots, de tu (spawn if missing and the server limit allows it, keep its camp in step with the bot)
-- (bot9x: the Di Nhan skill slots are set by PTBP_SkTick, called just before this function)
function PTBP_DnTick(ni, camp, st, lv)
	if not PTBP_IsDn(ni) then return 0 end
	if not AddNpcPet or not GetNpcPetIdx then return 0 end
	if not st.pets then st.pets = 0 end
	local p = PTBP_PetOf(ni)
	-- bot9x round 2: a de tu of another template (spawned by the dinhanbot party.lua) is replaced by Phong Quyen Tan Van
	if p > 0 and GetNpcTemplateID(p) ~= PTBP_PET_TPL then
		DelNpc(p)
		p = 0
	end
	if p <= 0 then
		local last = PTBOT_S.petLast or 0
		if last < st.pets then last = st.pets end
		if last >= PTBP_PET_MAX_TOTAL then return 0 end
		local tpl, nl, pl = PTBP_PetPick(lv)
		p = AddNpcPet(ni, tpl, nl, pl)
		if not p or p <= 0 then return 0 end
		if SetNpcSkill then
			local s = 1
			while s <= 4 do
				SetNpcSkill(p, PTBP_PET_SKILL, pl, s)
				s = s + 1
			end
		end
		local nm = GetNpcName(ni)
		if type(nm) == "string" and strsub(nm, 1, strlen(PTBP_TAG)) == PTBP_TAG then
			nm = strsub(nm, strlen(PTBP_TAG) + 1)
		end
		if type(nm) ~= "string" then nm = "" end
		SetNpcName(p, PTBP_PET_TAG .. nm)
	end
	SetNpcCurCamp(p, camp)
	st.pets = st.pets + 1
	return p
end

function PTBP_Notice(n, pct)
	local s = PTBP_TXT_HEAD .. n .. PTBP_TXT_JOIN
	if SetPartyBotBonus then
		s = s .. PTBP_TXT_BONUS .. pct .. "%."
	else
		s = s .. PTBP_TXT_NOBONUS
	end
	Msg2Player(s)
end

-- one player (PlayerIndex = pi): drop invalid / dead / lost / extra bots, spawn the missing ones, set the bonus
function PTBP_Player(cfg, pi, pname, st)
	local want = PTBP_Want(cfg)
	if want > 0 and st.alive + want > PTBP_MAX_TOTAL then want = 0 end
	local w, x, y = GetWorldPos()
	local lv = GetLevel() or 1
	local alive = 0
	local near = 0
	local made = 0
	local seen = {}
	local camp = PTBP_Camp(w)
	local j = 1
	while j <= PTBP_MAX do
		local ni = PTBP_Check(j, pname, w, x, y, want, seen)
		if ni > 0 then SetNpcCurCamp(ni, camp) end
		if ni == 0 and j <= want then
			ni = PTBP_Spawn(j, w, x, y, lv, pi)
			if ni > 0 then
				SetTask(PTBP_T_SLOT + j - 1, ni)
				made = made + 1
			end
		end
		if ni > 0 then
			PTBP_SkTick(ni, lv)	-- bot9x
			PTBP_DnTick(ni, camp, st, lv)	-- dinhanbot
			seen[ni] = 1
			alive = alive + 1
			if PTBP_Dist2(ni, w, x, y) <= PTBP_RANGE * PTBP_RANGE then near = near + 1 end
		end
		j = j + 1
	end
	local pct = near * (cfg.partyBonus or 0)
	if want == 0 then pct = 0 end
	if SetPartyBotBonus then SetPartyBotBonus(pct) end
	if alive > 0 then st.players = st.players + 1 end
	st.alive = st.alive + alive
	st.made = st.made + made
	if made > 0 and alive == made then PTBP_Notice(alive, pct) end
	if want > 0 and alive > 0 then PTBP_WatchArm() end	-- botheal C3
	return alive
end

-- remove every party bot of the current player (menu "Tat to doi bot")
function PTBP_DismissAll()
	local pname = GetName()
	local n = 0
	local j = 1
	while j <= PTBP_MAX do
		local var = PTBP_T_SLOT + j - 1
		local ni = GetTask(var)
		if ni and ni > 0 then
			if PTBP_Valid(ni, pname) then
				PTBP_DelBot(ni)
				n = n + 1
			end
			SetTask(var, 0)
		end
		j = j + 1
	end
	if SetPartyBotBonus then SetPartyBotBonus(0) end
	return n
end

-- botheal C3: (re)arm the replacement timer on the current player's NPC; returns that NPC index (0 = not possible)
function PTBP_WatchArm()
	if not SetNpcTimer or not GetPlayerNpcIdx then return 0 end
	local pn = GetPlayerNpcIdx()
	if not pn or pn <= 0 then return 0 end
	SetNpcTimer(pn, PTBP_NPC_SCRIPT, PTBP_WATCH_SEC)
	return pn
end

-- botheal C3: OnTimer of the player's NPC (registered party_npc.lua state). Re-arms itself while the player still has
-- tracked party slots. Returns 1 when re-armed.
function PTBP_Watch(ni)
	if not NpcIdx2PIdx or not ni or ni <= 0 then return 0 end
	local pi = NpcIdx2PIdx(ni)
	if not pi or pi <= 0 then return 0 end
	if not PTBOT_S then PTBOT_S = {} end	-- PTBP_DnTick reads PTBOT_S.petLast (servertimer state only)
	local old = PlayerIndex
	PlayerIndex = pi
	local again = PTBP_WatchPlayer(pi)
	PlayerIndex = old
	if not again then return 0 end
	SetNpcTimer(ni, PTBP_NPC_SCRIPT, PTBP_WATCH_SEC)
	return 1
end

-- botheal C3: replacement pass over the party slots of player pi (= PlayerIndex). nil = nothing to watch any more.
function PTBP_WatchPlayer(pi)
	local pname = GetName()
	if type(pname) ~= "string" or pname == "" then return nil end
	local w, x, y = GetWorldPos()
	if not PTBP_IsField(w) or PTBP_VtWait(w) then return nil end
	if GetTeamSize and GetTeamSize() > 1 then return nil end
	if IsPlayerInDeath and IsPlayerInDeath() == 1 then return nil end
	if not PTBP_WS then PTBP_WS = {} end
	local now = GetGameTime()
	local s = PTBP_WS[pname]
	if not s then
		s = {}
		s.since = {}
		s.t0 = now
		s.n = 0
		PTBP_WS[pname] = s
	end
	if now < s.t0 or now - s.t0 >= PTBP_REPL_WIN then
		s.t0 = now
		s.n = 0
	end
	local any = nil
	local made = 0
	local seen = {}
	local j = 1
	while j <= PTBP_MAX do
		local r = PTBP_WatchSlot(j, pname, w, x, y, pi, s, now, seen)
		if r > 0 then any = 1 end
		if r == 2 then made = made + 1 end
		j = j + 1
	end
	if made > 0 then Msg2Player(PTBP_TXT_HEAD .. made .. PTBP_TXT_REPL) end
	return any
end

-- botheal C3: slot j -> 0 empty, 1 tracked (bot alive, or dead and waiting for PTBP_REPL_DELAY / the limit), 2 replaced
function PTBP_WatchSlot(j, pname, w, x, y, pi, s, now, seen)
	local var = PTBP_T_SLOT + j - 1
	local ni = GetTask(var)
	if not ni or ni <= 0 then
		s.since[j] = nil
		return 0
	end
	local ok = PTBP_Valid(ni, pname)
	if ok and not seen[ni] and not PTBP_Dead(ni) then
		seen[ni] = 1
		s.since[j] = nil
		return 1
	end
	if not s.since[j] then
		s.since[j] = now
		return 1
	end
	if now - s.since[j] < PTBP_REPL_DELAY or s.n >= PTBP_REPL_MAX then return 1 end
	if ok and not seen[ni] then PTBP_DelBot(ni) end	-- corpse of this slot (engine without botparty:P3)
	if PTBPC_Load then PTBPC_Load() end	-- adminops C4: web class ratio / level of the slot
	local lv = GetLevel() or 1
	local nb = PTBP_Spawn(j, w, x, y, lv, pi)
	if not nb or nb <= 0 then
		s.since[j] = now	-- obstacle: try again after PTBP_REPL_DELAY
		return 1
	end
	SetTask(var, nb)
	seen[nb] = 1
	s.since[j] = nil
	s.n = s.n + 1
	PTBP_SkTick(nb, lv)
	local st = {}
	st.pets = 0
	PTBP_DnTick(nb, PTBP_Camp(w), st, lv)
	return 2
end

-- first party tick of a servertimer state (also after a hot reload): register the menu script and refresh the
-- registered bots.lua (OnTimer chat lines of the party bots)
-- botheal: once per PTBP_REG_VER, so a hot reload of this file also reloads the registered party_npc.lua (OnTimer of
-- the replacement timer) and bots.lua (which includes this file)
function PTBP_Register()
	if PTBOT_S.partyReg == PTBP_REG_VER then return end
	ReLoadScript(PTBP_NPC_SCRIPT)
	ReLoadScript(PTBP_TIMER_SCRIPT)
	PTBOT_S.partyReg = PTBP_REG_VER
end

function PTBP_EnsureNpcs()
	local S = PTBOT_S
	if not S.pnpc then S.pnpc = {} end
	local k = 1
	while PTBP_NPCS[k] do
		local s = PTBP_NPCS[k]
		local ni = S.pnpc[k]
		if not (ni and ni > 0 and GetNpcID(ni) ~= 0 and GetNpcTemplateID(ni) == s[2] and GetNpcName(ni) == PTBP_NPC_NAME) then
			local sw = SubWorldID2Idx(s[1])
			if sw and sw >= 0 then
				ni = AddNpc(s[2], 1, sw, s[3] * 32, s[4] * 32, 0)
				if ni and ni > 0 then
					SetNpcName(ni, PTBP_NPC_NAME)
					SetNpcScript(ni, PTBP_NPC_SCRIPT)
					S.pnpc[k] = ni
				end
			end
		end
		k = k + 1
	end
end

-- called once per minute from PTBOT_Tick (servertimer state) and by PTBOT_AdminApply
function PTBP_Tick(cfg)
	local S = PTBOT_S
	local st = { players = 0, alive = 0, made = 0 }
	S.partySt = st
	PTBPC_Load()	-- adminops C4
	PTBP_Register()
	PTBP_EnsureNpcs()
	if not AddTotemNpc then return 0 end
	local maxp = PTADM_MAX_PLAYER or 1200
	local oldPI = PlayerIndex
	local i = 1
	while i <= maxp do
		PlayerIndex = i
		local nm = GetName()
		if nm and nm ~= "" then PTBP_Player(cfg, i, nm, st) end
		i = i + 1
	end
	PlayerIndex = oldPI
	S.petLast = st.pets or 0	-- dinhanbot: de tu alive after this tick (server limit)
	return st.alive
end

-- 2026-10-04 adminops (C4, web admin tab "To doi bot"): admin_bridge\botparty_config.lua, written by the web admin
-- and re-read every tick (PTBP_Tick) and by its bridge command:
--   PTBPC_CFG = { count = 0..7, gs = w, ds = w, dn = w, lvoff = -20..20, lvspread = 0..5,
--                 chars = { { name = "<TCVN3, ASCII lower case>", mode = 0/1/2, count = 0..7 }, ... } }
-- * number of bots: character row count > web count > player menu (task 2071) > tab Bot partyCount;
-- * on / off: character row mode 1 always on / 2 always off, mode 0 = player menu (task 2070). The tab Bot "party"
--   switch (cfg.party) stays the master switch;
-- * class weights gs / ds / dn (Giap Si 2703-2708, Dao Si 2709-2714, Di Nhan 2715-2720): party slot j gets the class of
--   step j of a smooth weighted round robin, so every party size keeps the ratio and a respawned slot keeps its class;
--   all 0 = the roster mix as before;
-- * level = player level + lvoff +- lvspread (default +-2 as before).
-- No file = PTBPC_C nil = the behaviour before this update. A broken file keeps the previous config.
PTBPC_FILE = "botparty_config.lua"
PTBPC_TPL = {}
PTBPC_TPL[1] = { 2703, 2708 }
PTBPC_TPL[2] = { 2709, 2714 }
PTBPC_TPL[3] = { 2715, 2720 }

function PTBPC_Num(v, lo, hi, d)
	if type(v) ~= "number" then return d end
	v = floor(v)
	if v < lo then return lo end
	if v > hi then return hi end
	return v
end

function PTBPC_Err(m)
	PTBPC_ERR = m
end

function PTBPC_Load()
	local path = (PTADM_DIR or "admin_bridge\\") .. PTBPC_FILE
	local fh = openfile(path, "r")
	if not fh then
		PTBPC_C = nil
		return 0
	end
	closefile(fh)
	PTBPC_CFG = nil
	local old = _ERRORMESSAGE
	_ERRORMESSAGE = PTBPC_Err
	dofile(path)
	_ERRORMESSAGE = old
	local c = PTBPC_CFG
	PTBPC_CFG = nil
	if type(c) ~= "table" then return 0 end
	local r = {}
	r.count = PTBPC_Num(c.count, 0, PTBP_MAX, 0)
	r.w = {}
	r.w[1] = PTBPC_Num(c.gs, 0, 10, 0)
	r.w[2] = PTBPC_Num(c.ds, 0, 10, 0)
	r.w[3] = PTBPC_Num(c.dn, 0, 10, 0)
	r.lvoff = PTBPC_Num(c.lvoff, -20, 20, 0)
	r.lvspread = PTBPC_Num(c.lvspread, 0, 5, 2)
	r.chars = {}
	if type(c.chars) == "table" then
		local k = 1
		while c.chars[k] do
			local e = c.chars[k]
			if type(e) == "table" and type(e.name) == "string" and e.name ~= "" then
				local q = {}
				q.mode = PTBPC_Num(e.mode, 0, 2, 0)
				q.count = PTBPC_Num(e.count, 0, PTBP_MAX, 0)
				r.chars[strlower(e.name)] = q
			end
			k = k + 1
		end
	end
	PTBPC_C = r
	return 1
end

-- web row of the current player (PlayerIndex): mode, count (0, 0 = no row / no file)
function PTBPC_Char()
	local c = PTBPC_C
	if not c then return 0, 0 end
	local nm = GetName()
	if type(nm) ~= "string" or nm == "" then return 0, 0 end
	local q = c.chars[strlower(nm)]
	if not q then return 0, 0 end
	return q.mode, q.count
end

-- bots wanted by the web (character row count, else the web count), 0 = not set there
function PTBPC_Count(cc)
	if cc and cc > 0 then return cc end
	if PTBPC_C and PTBPC_C.count > 0 then return PTBPC_C.count end
	return 0
end

-- class (1 Giap Si, 2 Dao Si, 3 Di Nhan) of party slot j, 0 = no weights
function PTBPC_Class(j, w)
	local tot = w[1] + w[2] + w[3]
	if tot <= 0 then return 0 end
	local c1 = 0
	local c2 = 0
	local c3 = 0
	local b = 0
	local s = 1
	while s <= j do
		c1 = c1 + w[1]
		c2 = c2 + w[2]
		c3 = c3 + w[3]
		b = 1
		if c2 > c1 then b = 2 end
		if c3 > c1 and c3 > c2 then b = 3 end
		if b == 1 then c1 = c1 - tot elseif b == 2 then c2 = c2 - tot else c3 = c3 - tot end
		s = s + 1
	end
	return b
end

-- roster entry { name, template } for party slot j of player pi
function PTBPC_Pick(j, pi)
	local d = PTBP_N[mod(pi * 3 + j - 1, getn(PTBP_N)) + 1]
	local c = PTBPC_C
	if not c then return d end
	local cls = PTBPC_Class(j, c.w)
	if cls == 0 then return d end
	local k = 0
	local s = 1
	while s < j do
		if PTBPC_Class(s, c.w) == cls then k = k + 1 end
		s = s + 1
	end
	local lo = PTBPC_TPL[cls][1]
	local hi = PTBPC_TPL[cls][2]
	local list = {}
	local m = 0
	local i = 1
	while PTBP_N[i] do
		if PTBP_N[i][2] >= lo and PTBP_N[i][2] <= hi then
			m = m + 1
			list[m] = PTBP_N[i]
		end
		i = i + 1
	end
	if m == 0 then return d end
	return list[mod(pi + k, m) + 1]
end

-- bot level for a player of level lv
function PTBPC_Level(lv)
	local off = 0
	local sp = 2
	if PTBPC_C then
		off = PTBPC_C.lvoff
		sp = PTBPC_C.lvspread
	end
	local l = lv + off
	if sp > 0 then l = l + random(-sp, sp) end
	if l < 1 then l = 1 end
	if l > 200 then l = 200 end
	return l
end

-- remove the party bots of everyone online (bridge command after a web change: PTBOT_AdminApply spawns them again
-- with the new classes / levels at once). Returns the number removed.
function PTBPC_Rebuild()
	local maxp = PTADM_MAX_PLAYER or 1200
	local oldPI = PlayerIndex
	local n = 0
	local i = 1
	while i <= maxp do
		PlayerIndex = i
		local nm = GetName()
		if nm and nm ~= "" then n = n + PTBP_DismissAll() end
		i = i + 1
	end
	PlayerIndex = oldPI
	return n
end
