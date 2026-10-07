-- Phong Than fake-player bots (2026-10-02). This runtime file is the source now (gen_bots.py is no
-- longer used); strings shown to players are TCVN3 bytes written as \ddd escapes, keep the file ASCII.
--
-- Web admin (tab "Bot gia nguoi choi", AdminWeb\PhongThan-Admin.ps1 action "bots") writes
-- admin_bridge\bots_config.lua and queues PTBOT_AdminApply() through the bridge:
--   PTBOT_CFG = { enabled = 1, follow = 1, followCount = 40,
--                 spots = { { map = 1002, x = 0, y = 0, count = 10, level = 0 }, ... } }
--   enabled 0 = remove every bot. followCount = free bots: they gather around online players when
--   follow = 1, otherwise (or with nobody online) they roam towns / leveling maps / arena as before.
--   spots = bots kept around map x/y (cells; 0 = default spot of the map from the tables below, else
--   the map centre), level 0 = auto. Total capped at PTBOT_MAX_TOTAL (spots first); slots past the
--   roster size reuse the names with a numeric suffix. No config file = enabled, follow PTBOT_FOLLOW,
--   followCount PTBOT_COUNT, no spots. Each tick writes admin_bridge\bots.txt (status for the web).
--   2026-10-03 (botparty) also: party = 1, partyCount = 4, partyBonus = 15 -> "to doi bot" of party.lua
--   (bots join every player on a monster map, AiMode 11 owned by him, + partyBonus % EXP per bot in range).
--   Free follow bots keep away from players whose bot party is active (no crowd around a party).
--
-- 20-30 NPCs that look like players: Npcs.txt templates 2703-2720 use the player bodies
-- (male/female Giap Si, Thuat Si, Di Nhan) with armor/helm/weapon/horse columns, camp 0 (they fight
-- monsters of camp 5, never players), AIMode 1 (wander around the spawn point, chase monsters in
-- sight) and numeric profession skills.
--
-- What Lua can and cannot drive (Core\Src\ScriptFuns.cpp, KNpcAI.cpp):
--  * there is no "walk to x,y" for NPCs: SetNpcPos teleports and keeps the AI origin, so a bot walks
--    back. Moving a bot to another place = DelNpc + AddNpc at the new spot (new AI origin);
--  * walking/fighting itself is the engine AIMode 1 (ProcessAIType01) inside ActiveRadius 700;
--  * a dead bot is revived by the engine at its spawn point after ReviveFrame (540 = 30 s), name and
--    template kept (KNpc::DoRevive/Revive); this tick only re-creates bots that disappeared;
--  * chat: NpcChat = bubble over the head (near players only); Msg2SubWorld = system line to everyone
--    (the client drops the sender, so the bot name is written into the text).
--
-- Two script states use this file:
--  1. servertimer.lua: dofile("script\\phongthan\\bots\\bots.lua") once, then PTBOT_Tick() every
--     minute (spawn / respawn / relocate / greet players / world chat). State lives in PTBOT_S.
--  2. the registered copy (startup scan, or ReLoadScript from PTBot_Init): OnTimer(npcIndex) for the
--     staggered chat bubbles (SetNpcTimer, template TimerScript).
-- Lua 4: no true/false, no local function, no string.*/table.*.

PTBOT_SCRIPT = "\\script\\phongthan\\bots\\bots.lua"
PTBOT_TPL_MIN = 2703
PTBOT_TPL_MAX = 2720
PTBOT_COUNT = 40            -- bots kept alive (30..50, at most getn(PTBOT_ROSTER))
-- 2026-10-02 follow mode: while players are online the bots gather around them (user: "where I go,
-- 30-50 bots play there"). Bots farther than PTBOT_NEAR cells from every player are moved next to one.
PTBOT_FOLLOW = 1
PTBOT_NEAR = 45             -- cells (GetNpcPos / GetWorldPos units = mps / 32)
PTBOT_RING_MIN = 6          -- spawn ring around the player, in cells
PTBOT_RING_MAX = 28
PTBOT_FOLLOW_MOVES = 50     -- relocations per tick in follow mode (all bots follow within one minute)
PTBOT_MAX_FOLLOWED = 20     -- players considered per tick
PTBOT_MOVE_PER_TICK = 4     -- relocations per minute (DelNpc + AddNpc elsewhere)
PTBOT_STAY_MIN = 8          -- minutes a bot stays on a spot (random STAY_MIN..STAY_MAX)
PTBOT_STAY_MAX = 20
PTBOT_WORLD_CHAT = 1        -- nil: no system-line "world chat"
PTBOT_GREET_CD = 10         -- minutes between two greetings for the same player
PTBOT_ARENA_DUEL = nil      -- 1: arena bots (map 1001) take camp 1/2 and fight each other. They then
                            -- also attack players of another non-zero camp there, so it is off.
PTBOT_MAX_NPC = 48000
PTBOT_TOWN, PTBOT_FIELD_KIND, PTBOT_EVENT = 1, 2, 3
PTBOT_MAX_TOTAL = 100       -- followCount + spot counts are capped here
PTBOT_MAX_SPOTS = 20
PTBOT_SPOT_R = 10           -- spawn square around a spot, in cells
PTBOT_SPOT_MOVES = 30       -- spot bots brought back per tick when farther than PTBOT_NEAR from the spot
PTBOT_TPL_N = PTBOT_TPL_MAX - PTBOT_TPL_MIN + 1
-- 2026-10-03 botparty: bot party (to doi bot) functions PTBP_*, also used by party_npc.lua
Include("\\script\\phongthan\\bots\\party.lua")

-- { name, template, role }  role: 1 town, 2 leveling map, 3 event/PK area
PTBOT_ROSTER = {
	{ "Thi\170nLong", 2705, 2 },
	{ "Ti\211uY\213n", 2713, 1 },
	{ "H\190cPhong", 2716, 2 },
	{ "B\185chV\169n", 2718, 1 },
	{ "\167\233cC\171Ki\213m", 2704, 3 },
	{ "MinhNguy\214t", 2714, 2 },
	{ "T\246Long99", 2709, 1 },
	{ "HoaR\172i", 2706, 2 },
	{ "L\183ngT\246Gi\227", 2717, 1 },
	{ "Ng\228cLan", 2719, 2 },
	{ "Ki\213mTh\199n", 2703, 1 },
	{ "Tuy\213tNhi", 2712, 3 },
	{ "Chi\213nTh\199n", 2705, 2 },
	{ "PhiY\213n", 2707, 1 },
	{ "LongV\173\172ng", 2711, 2 },
	{ "ThanhT\169m", 2720, 1 },
	{ "B\184\167ao", 2704, 2 },
	{ "Kh\227iS\173\172ng", 2713, 3 },
	{ "V\171Danh", 2715, 2 },
	{ "MaiHoa", 2708, 1 },
	{ "PhongV\169n", 2710, 2 },
	{ "B\168ngT\169m", 2714, 1 },
	{ "Th\199nS\202m", 2716, 3 },
	{ "Xu\169nH\185", 2718, 2 },
	{ "Tu\202nKi\214t", 2703, 1 },
	{ "LyLy", 2712, 2 },
	{ "H\230B\184o", 2705, 1 },
	{ "NhuM\215", 2719, 2 },
	{ "S\184tTh\241", 2717, 3 },
	{ "Ti\170nN\247", 2714, 1 },
	{ "Ti\211uLong", 2706, 2 },
	{ "H\190cY", 2715, 2 },
	{ "B\185chH\230", 2703, 2 },
	{ "Ng\228cH\173\172ng", 2719, 1 },
	{ "Ki\213mKh\184ch", 2709, 2 },
	{ "Thi\170nY\213n", 2712, 1 },
	{ "\167\233cH\185c", 2716, 2 },
	{ "MinhCh\169u", 2718, 1 },
	{ "Kh\171iNguy\170n", 2704, 2 },
	{ "Tuy\213tS\172n", 2710, 2 },
	{ "B\168ngB\168ng", 2713, 1 },
	{ "V\171Song", 2705, 2 },
	{ "Thi\170nH\185", 2711, 2 },
	{ "LongH\230", 2717, 2 },
	{ "Ti\211uMai", 2708, 1 },
	{ "LanAnh", 2720, 1 },
}

-- town spots { map, mpsX, mpsY }
PTBOT_TOWNS = {
	{ 1002, 54064, 102320 },
	{ 1002, 52624, 101840 },
	{ 1002, 53376, 103104 },
	{ 1002, 51424, 102272 },
	{ 1003, 56112, 103792 },
	{ 1003, 54992, 103088 },
	{ 1003, 55648, 102624 },
	{ 1003, 54144, 100416 },
	{ 1004, 51696, 104080 },
	{ 1004, 51856, 102864 },
	{ 1004, 50448, 103184 },
	{ 1004, 50336, 103328 },
	{ 1020, 50576, 96976 },
	{ 1020, 49808, 96720 },
	{ 1020, 49296, 97456 },
	{ 1021, 52880, 101328 },
	{ 1021, 53392, 101328 },
	{ 1021, 54608, 101776 },
	{ 1021, 52112, 94640 },
}

-- leveling spots { map, mpsX, mpsY, monster level }
PTBOT_FIELDS = {
	{ 1005, 52144, 98320, 3 },
	{ 1005, 56688, 94544, 12 },
	{ 1006, 57616, 98256, 7 },
	{ 1006, 61008, 102768, 7 },
	{ 1007, 52464, 105168, 5 },
	{ 1007, 54256, 95664, 12 },
	{ 1008, 54000, 98576, 3 },
	{ 1011, 56432, 113584, 8 },
	{ 1011, 53744, 103888, 9 },
	{ 1012, 54704, 98928, 13 },
	{ 1015, 56848, 96752, 20 },
	{ 1015, 44304, 101808, 20 },
	{ 1017, 52496, 102352, 27 },
	{ 1018, 52496, 97264, 25 },
	{ 1065, 50864, 103888, 25 },
	{ 1022, 54448, 109808, 30 },
	{ 1024, 54096, 103888, 36 },
	{ 1027, 52496, 104464, 38 },
	{ 1019, 53360, 98992, 40 },
	{ 1032, 60048, 97648, 45 },
}

-- PK / event stage: Phong Than dai (1001), revive point of revivepos.ini [1]
PTBOT_ARENAS = {
	{ 1001, 49408, 104352 },
	{ 1001, 49664, 104480 },
	{ 1001, 49152, 104224 },
}

-- map centres { map, mpsX, mpsY } from maps\*.wor rect (region 512 x 1024 mps), for spots without x/y
PTBOT_CENTRES = {
	{ 1001, 50176, 102400 },
	{ 1002, 51200, 101888 },
	{ 1003, 55296, 102400 },
	{ 1004, 51200, 101888 },
	{ 1005, 55552, 96768 },
	{ 1006, 55552, 96768 },
	{ 1007, 54016, 105984 },
	{ 1008, 58112, 101888 },
	{ 1009, 54528, 111616 },
	{ 1010, 43008, 101376 },
	{ 1011, 54016, 105984 },
	{ 1012, 51968, 103936 },
	{ 1013, 56832, 96256 },
	{ 1014, 48128, 108544 },
	{ 1015, 51456, 104960 },
	{ 1016, 49408, 105984 },
	{ 1017, 56576, 106496 },
	{ 1018, 52480, 101376 },
	{ 1019, 51200, 102400 },
	{ 1020, 46848, 100352 },
	{ 1021, 55808, 98816 },
	{ 1022, 54016, 105984 },
	{ 1023, 54016, 105984 },
	{ 1024, 52480, 100864 },
	{ 1025, 52480, 100864 },
	{ 1026, 52480, 100864 },
	{ 1027, 58112, 95744 },
	{ 1028, 58112, 93184 },
	{ 1029, 51712, 95232 },
	{ 1030, 51200, 94720 },
	{ 1031, 58368, 93184 },
	{ 1032, 57600, 95232 },
	{ 1033, 55808, 95744 },
	{ 1034, 47104, 100864 },
	{ 1035, 56064, 108544 },
	{ 1036, 45568, 112128 },
	{ 1037, 57856, 98304 },
	{ 1038, 57856, 98304 },
	{ 1039, 58112, 93696 },
	{ 1040, 58112, 93696 },
	{ 1041, 57856, 111104 },
	{ 1042, 58112, 100864 },
	{ 1043, 48896, 104448 },
	{ 1044, 60416, 99840 },
	{ 1045, 48128, 104960 },
	{ 1046, 51968, 95232 },
	{ 1047, 51200, 102400 },
	{ 1048, 51200, 102400 },
	{ 1049, 51200, 102400 },
	{ 1050, 51200, 102400 },
	{ 1051, 51200, 102400 },
	{ 1052, 54016, 105984 },
	{ 1053, 54016, 105984 },
	{ 1054, 55552, 96768 },
	{ 1055, 55552, 96768 },
	{ 1056, 55552, 96768 },
	{ 1057, 49408, 102400 },
	{ 1060, 47104, 100864 },
	{ 1061, 51456, 104960 },
	{ 1062, 52480, 104448 },
	{ 1063, 49152, 104448 },
	{ 1064, 51200, 101888 },
	{ 1065, 50432, 97280 },
	{ 1066, 54016, 105984 },
	{ 1068, 51200, 101888 },
	{ 1071, 60416, 109056 },
	{ 1072, 47104, 100864 },
	{ 1073, 58368, 113152 },
	{ 1074, 60416, 112128 },
	{ 1075, 59648, 111616 },
	{ 1076, 58624, 113664 },
	{ 1077, 58624, 113664 },
	{ 1078, 58880, 90112 },
	{ 1079, 51200, 102400 },
	{ 1080, 54016, 105984 },
	{ 1081, 54016, 105984 },
	{ 1082, 54016, 105984 },
	{ 1086, 41216, 96256 },
	{ 1092, 63232, 117248 },
}

PTBOT_LINES = {}
PTBOT_LINES[1] = {
	"Ai \174i Hi\170n Vi\170n \174\233ng kh\171ng, thi\213u m\233t \167\185o S\220!",
	"B\184n \174\229 gi\184 r\206 \174\169y, ai c\199n nh\190n m\215nh nh\208",
	"Mua ng\249a \235 \174\169u v\203y m\228i ng\173\234i?",
	"T\232i nay \174\184nh boss C\246u Linh kh\171ng anh em?",
	"H\171m nay server \174\171ng vui gh\170",
	"Bang n\181o nh\203n th\170m ng\173\234i kh\171ng?",
	"V\245a l\170n c\202p, vui qu\184!",
	"Nhi\214m v\244 B\182o Th\173\172ng l\181m sao v\203y m\228i ng\173\234i?",
	"Ch\234 b\185n online r\229i \174i luy\214n c\171ng",
	"C\227 ai \174i T\169y K\250 kh\171ng, cho \174i k\208 v\237i",
	"Ai c\227 b\215nh m\184u d\173 b\184n l\185i kh\171ng?",
	"\167i Tri\210u Ca ch\172i kh\171ng m\228i ng\173\234i?",
	"Lag qu\184 tr\234i, ai b\222 gi\232ng m\215nh kh\171ng?",
}
PTBOT_LINES[2] = {
	"Qu\184i \235 \174\169y \174\171ng gh\170",
	"\167\184nh m\183i ch\173a l\170n c\202p, m\214t qu\184",
	"H\213t b\215nh m\184u r\229i, v\210 th\181nh mua \174\183",
	"B\183i n\181y ngon, ai v\181o t\230 \174\233i kh\171ng?",
	"V\245a r\237t \174\173\238c m\227n \174\229 x\222n!",
	"C\200n th\203n \174\184m qu\184i b\170n kia, \174\184nh \174au l\190m",
	"Luy\214n th\170m v\181i c\202p n\247a l\181 \174i Hi\170n Vi\170n \174\173\238c r\229i",
	"Ai l\203p t\230 \174\233i cho m\215nh v\181o v\237i",
	"B\183i n\181y h\213t qu\184i r\229i, qua ch\231 kh\184c th\171i",
}
PTBOT_LINES[3] = {
	"Ai d\184m l\170n \174\181i so t\181i kh\171ng?",
	"Boss s\190p ra r\229i, t\203p trung l\185i anh em \172i!",
	"\167\238i boss \235 \174\169y n\204",
	"PK kh\171ng anh em?",
	"L\199n tr\173\237c b\222 boss \174\184nh v\168ng, l\199n n\181y ph\182i g\236",
	"\167\233i n\181o gi\181nh boss th\215 chia \174\229 nh\208",
	"\167\171ng ng\173\234i qu\184, chen kh\171ng n\230i",
	"Ai th\190ng tr\203n n\181y m\215nh bao c\182 bang",
}
-- 2026-10-03 botparty: party bots (SetNpcParam(npc, 1, PTBP_KIND = 4))
PTBOT_LINES[4] = {
	"\167\185i ca c\248 \174\184nh, \174\211 em y\211m tr\238!",
	"Qu\184i b\170n kia k\215a, x\171ng l\170n anh em!",
	"T\230 \174\233i \174\171ng vui, kinh nghi\214m c\242ng nhi\210u h\172n",
	"Theo s\184t nh\208, \174\245ng ch\185y xa qu\184",
	"B\183i n\181y ngon, luy\214n ti\213p th\171i",
	"H\213t b\215nh m\184u th\215 nh\237 v\210 th\181nh mua nh\208",
	"\167\184nh xong b\183i n\181y qua ch\231 kh\184c kh\171ng?",
	"C\227 em \174i c\239ng, qu\184i n\181o c\242ng h\185 \174\173\238c",
}

-- greeting = prefix .. player name .. suffix
PTBOT_GREETS = {
	{ "Ch\181o ", "!" },
	{ "", " \172i, \174i luy\214n c\171ng chung kh\171ng?" },
	{ "Hello ", ", m\237i online \181?" },
	{ "", " cho m\215nh v\181o t\230 \174\233i v\237i" },
	{ "\163 ", ", nh\215n ng\199u gh\170" },
}

PTBOT_WORLD_LINES = {
	"Tuy\211n th\181nh vi\170n bang, ai v\181o nh\190n m\215nh",
	"Ai b\184n ng\249a c\202p cao kh\171ng?",
	"T\232i nay \174i boss C\246u Linh, ai theo kh\171ng?",
	"C\199n t\230 \174\233i \174i Hi\170n Vi\170n \174\233ng",
	"\167ang luy\214n \235 Hoang M\185c, ai qua ch\172i v\237i",
	"Thu mua nguy\170n li\214u gi\184 cao",
	"Server m\215nh c\181ng ng\181y c\181ng \174\171ng nh\216",
	"C\227 ai \174i Tam S\172n \174\184nh boss kh\171ng?",
	"M\237i v\181o game, xin m\228i ng\173\234i ch\216 gi\184o",
	"\167\229 \174\209p qu\184, ai \208p trang b\222 gi\225i ch\216 m\215nh v\237i",
}
PTBOT_WORLD_HEAD = "<color=yellow>[Th\213 gi\237i] "

-- event bots stand around a world boss at this distance (world units), outside its vision
PTBOT_EVENT_DIRS = { {26, 0}, {-26, 0}, {0, 26}, {0, -26}, {18, 18}, {-18, 18}, {18, -18}, {-18, -18} }
-- AddNpc retries (mps) when the server obstacle rejects a point
PTBOT_OFFS = { {0, 0}, {96, 0}, {-96, 0}, {0, 96}, {0, -96}, {160, 96}, {-160, -96}, {96, -160}, {-96, 160} }

if not PTBOT_S then
	PTBOT_S = { init = nil, minute = 0, bots = {}, greet = {}, nextWorld = 3, bossKey = nil, boss = nil, orphans = 0, spawned = 0, moved = 0 }
end

function PTBot_Pick(t)
	if type(t) ~= "table" then return nil end
	local n = getn(t)
	if n <= 0 then return nil end
	return t[random(1, n)]
end

-- 2026-10-03 (botvisual): every bubble goes through here; never send nil / empty / non-string text
-- (an empty NpcChat would still reserve chat lines over the bot on the client).
function PTBot_Say(ni, s)
	if not ni or ni <= 0 then return nil end
	if type(s) ~= "string" or strlen(s) <= 0 then return nil end
	NpcChat(ni, s)
	return 1
end

-- free (follow / roam) bots of the current plan
function PTBot_Count()
	return PTBOT_S.followN or 0
end

function PTBot_Alive(b)
	local ni = b.ni
	if not ni or ni <= 0 then return nil end
	if GetNpcID(ni) ~= b.id then return nil end
	if GetNpcTemplateID(ni) ~= b.tpl then return nil end
	if GetNpcName(ni) ~= b.name then return nil end
	return 1
end

function PTBot_Add(tpl, lv, sw, x, y)
	local k = 1
	local ni = 0
	while PTBOT_OFFS[k] do
		ni = AddNpc(tpl, lv, sw, x + PTBOT_OFFS[k][1], y + PTBOT_OFFS[k][2], 1)
		if ni and ni > 0 then return ni end
		k = k + 1
	end
	ni = AddNpc(tpl, lv, sw, x, y, 0)
	if ni and ni > 0 then return ni end
	return 0
end

-- world boss whose schedule minute is 10 min ahead .. 15 min past (PTWB_LIST of boss\wb_data.lua)
function PTBot_BossWindow()
	if not PTWB_LIST then
		local fh = openfile("script\\phongthan\\boss\\wb_data.lua", "r")
		if fh then
			closefile(fh)
			dofile("script\\phongthan\\boss\\wb_data.lua")
		end
	end
	if not PTWB_LIST then return nil end
	local now = tonumber(date("%H")) * 60 + tonumber(date("%M"))
	local best = nil
	local k = 1
	while PTWB_LIST[k] do
		local b = PTWB_LIST[k]
		local s = 1
		while b.sched and b.sched[s] do
			local m = tonumber(strsub(b.sched[s], 1, 2)) * 60 + tonumber(strsub(b.sched[s], 4, 5))
			local d = m - now
			if d < -720 then d = d + 1440 end
			if d > 720 then d = d - 1440 end
			if d >= -15 and d <= 10 then
				local sw = SubWorldID2Idx(b.map)
				if sw and sw >= 0 and ((not best) or b.lv > best.lv) then best = b end
			end
			s = s + 1
		end
		k = k + 1
	end
	return best
end

-- returns kind, map, mpsX, mpsY, level
function PTBot_ChooseSpot(b)
	local role = b.role
	if role == PTBOT_EVENT then
		local boss = PTBOT_S.boss
		if boss then
			local d = PTBOT_EVENT_DIRS[mod(b.slot, getn(PTBOT_EVENT_DIRS)) + 1]
			return PTBOT_EVENT, boss.map, (boss.x + d[1]) * 32, (boss.y + d[2]) * 32, boss.lv
		end
		if random(1, 100) <= 70 then
			local a = PTBot_Pick(PTBOT_ARENAS)
			return PTBOT_EVENT, a[1], a[2], a[3], random(60, 90)
		end
		role = PTBOT_TOWN
	elseif role == PTBOT_TOWN then
		if random(1, 100) <= 30 then role = PTBOT_FIELD_KIND end
	else
		if random(1, 100) <= 30 then role = PTBOT_TOWN end
	end
	if role == PTBOT_FIELD_KIND then
		local f = PTBot_Pick(PTBOT_FIELDS)
		return PTBOT_FIELD_KIND, f[1], f[2], f[3], f[4] + random(8, 15)
	end
	local t = PTBot_Pick(PTBOT_TOWNS)
	return PTBOT_TOWN, t[1], t[2], t[3], random(40, 90)
end

function PTBot_Place(b)
	local tries = 1
	while tries <= 6 do
		local kind, map, x, y, lv = PTBot_ChooseSpot(b)
		local sw = SubWorldID2Idx(map)
		if sw and sw >= 0 then
			x = x + random(-6, 6) * 32
			y = y + random(-6, 6) * 32
			local ni = PTBot_Add(b.tpl, lv, sw, x, y)
			if ni > 0 then
				SetNpcName(ni, b.name)
				if PTBOT_ARENA_DUEL and kind == PTBOT_EVENT and map == 1001 then
					SetNpcCamp(ni, 1 + mod(b.slot, 2))
					SetNpcCurCamp(ni, 1 + mod(b.slot, 2))
				end
				SetNpcParam(ni, 1, kind)
				SetNpcParam(ni, 2, b.slot)
				SetNpcTimer(ni, PTBOT_SCRIPT, random(5, 40))
				b.ni = ni
				b.id = GetNpcID(ni)
				b.kind = kind
				b.map = map
				b.untilMin = PTBOT_S.minute + random(PTBOT_STAY_MIN, PTBOT_STAY_MAX)
				PTBOT_S.spawned = PTBOT_S.spawned + 1
				return 1
			end
		end
		tries = tries + 1
	end
	return nil
end

-- online players { w, x, y, lv, party } (cells), at most PTBOT_MAX_FOLLOWED; party = 1 when the player's
-- bot party is active (party.lua PTBP_Want)
function PTBot_Players()
	local list = {}
	local n = 0
	local maxp = PTADM_MAX_PLAYER or 1200
	local oldPI = PlayerIndex
	local i = 1
	while i <= maxp and n < PTBOT_MAX_FOLLOWED do
		PlayerIndex = i
		local nm = GetName()
		if nm and nm ~= "" then
			local w, x, y = GetWorldPos()
			local swi = nil
			if w and w > 0 then swi = SubWorldID2Idx(w) end
			if swi and swi >= 0 then
				n = n + 1
				list[n] = { w = w, x = x, y = y, lv = GetLevel() or 1 }
				if PTBP_Want and AddTotemNpc and PTBP_Want(PTBOT_S.cfg) > 0 then list[n].party = 1 end
			end
		end
		i = i + 1
	end
	PlayerIndex = oldPI
	return list
end

function PTBot_IsTown(map)
	local k = 1
	while PTBOT_TOWNS[k] do
		if PTBOT_TOWNS[k][1] == map then return 1 end
		k = k + 1
	end
	return nil
end

function PTBot_NearAny(b, players)
	local w, x, y = GetNpcPos(b.ni)
	if not w or w <= 0 then return nil end
	local k = 1
	while players[k] do
		local p = players[k]
		if p.w == w then
			local dx = p.x - x
			local dy = p.y - y
			if dx * dx + dy * dy <= PTBOT_NEAR * PTBOT_NEAR then return 1 end
		end
		k = k + 1
	end
	return nil
end

function PTBot_PlaceNear(b, p)
	local sw = SubWorldID2Idx(p.w)
	if not sw or sw < 0 then return nil end
	local kind = PTBOT_FIELD_KIND
	if PTBot_IsTown(p.w) then kind = PTBOT_TOWN end
	local tries = 1
	while tries <= 6 do
		local dx = random(-PTBOT_RING_MAX, PTBOT_RING_MAX)
		local dy = random(-PTBOT_RING_MAX, PTBOT_RING_MAX)
		if dx * dx + dy * dy >= PTBOT_RING_MIN * PTBOT_RING_MIN then
			local lv = p.lv + random(-5, 5)
			if lv < 1 then lv = 1 end
			local ni = PTBot_Add(b.tpl, lv, sw, (p.x + dx) * 32, (p.y + dy) * 32)
			if ni > 0 then
				SetNpcName(ni, b.name)
				SetNpcParam(ni, 1, kind)
				SetNpcParam(ni, 2, b.slot)
				SetNpcTimer(ni, PTBOT_SCRIPT, random(5, 40))
				b.ni = ni
				b.id = GetNpcID(ni)
				b.kind = kind
				b.map = p.w
				b.untilMin = PTBOT_S.minute + random(PTBOT_STAY_MIN, PTBOT_STAY_MAX)
				PTBOT_S.spawned = PTBOT_S.spawned + 1
				return 1
			end
		end
		tries = tries + 1
	end
	return nil
end

function PTBot_Remove(b)
	if PTBot_Alive(b) then DelNpc(b.ni) end
	b.ni = nil
	b.id = nil
end

-- first tick of a fresh servertimer state: register the OnTimer copy, remove bots left by an
-- earlier state (a servertimer reload loses PTBOT_S but not the NPCs).
function PTBot_Init()
	ReLoadScript(PTBOT_SCRIPT)
	local n = 0
	local i = 1
	while i < PTBOT_MAX_NPC do
		local id = GetNpcID(i)
		if id and id ~= 0 then
			local t = GetNpcTemplateID(i)
			if t and t >= PTBOT_TPL_MIN and t <= PTBOT_TPL_MAX then
				DelNpc(i)
				n = n + 1
			elseif PTBP_NPC_TPL and t == PTBP_NPC_TPL and GetNpcName(i) == PTBP_NPC_NAME then
				DelNpc(i)   -- "Ho Tro To Doi" menu NPC of the earlier state (PTBP_EnsureNpcs respawns it)
			end
		end
		i = i + 1
	end
	PTBOT_S.orphans = n
	PTBOT_S.init = 1
end

function PTBot_Greet()
	local S = PTBOT_S
	local pos = {}
	local np = 0
	local k = 1
	while S.bots[k] do
		local b = S.bots[k]
		if PTBot_Alive(b) then
			local w, x, y = GetNpcPos(b.ni)
			if w and w > 0 then
				np = np + 1
				pos[np] = { b.ni, w, x, y }
			end
		end
		k = k + 1
	end
	if np == 0 then return 0 end
	local maxp = PTADM_MAX_PLAYER or 1200
	local oldPI = PlayerIndex
	local said = 0
	local i = 1
	while i <= maxp and said < 3 do
		PlayerIndex = i
		local nm = GetName()
		if nm and nm ~= "" then
			local last = S.greet[nm]
			if (not last) or S.minute - last >= PTBOT_GREET_CD then
				local w, x, y = GetWorldPos()
				k = 1
				while k <= np do
					local p = pos[k]
					if p[2] == w then
						local dx = p[3] - x
						local dy = p[4] - y
						if dx * dx + dy * dy <= 400 and random(1, 100) <= 60 then
							local g = PTBot_Pick(PTBOT_GREETS)
							if g then PTBot_Say(p[1], (g[1] or "") .. nm .. (g[2] or "")) end
							S.greet[nm] = S.minute
							said = said + 1
							k = np
						end
					end
					k = k + 1
				end
			end
		end
		i = i + 1
	end
	PlayerIndex = oldPI
	return said
end

function PTBot_WorldChat()
	local S = PTBOT_S
	local alive = {}
	local n = 0
	local k = 1
	while S.bots[k] do
		if PTBot_Alive(S.bots[k]) then
			n = n + 1
			alive[n] = S.bots[k]
		end
		k = k + 1
	end
	if n == 0 then return nil end
	local b = alive[random(1, n)]
	local line = PTBot_Pick(PTBOT_WORLD_LINES)
	if type(line) ~= "string" or strlen(line) <= 0 then return nil end
	Msg2SubWorld(PTBOT_WORLD_HEAD .. b.name .. "<color>: " .. line)
	return 1
end

-- ---------------------------------------------------------------- web admin configuration
function PTBot_Dir()
	return PTADM_DIR or "admin_bridge\\"
end

function PTBot_Num(v, lo, hi, def)
	if type(v) ~= "number" then v = tonumber(v) end
	if not v then return def end
	v = floor(v)
	if v < lo then v = lo end
	if v > hi then v = hi end
	return v
end

function PTBot_DefaultCfg()
	local f = 0
	if PTBOT_FOLLOW then f = 1 end
	return { enabled = 1, follow = f, followCount = PTBot_Num(PTBOT_COUNT, 0, PTBOT_MAX_TOTAL, 40), spots = {},
		party = 1, partyCount = PTBP_DEF_COUNT or 4, partyBonus = PTBP_DEF_BONUS or 15 }
end

function PTBot_CfgError(m)
	PTBOT_S.cfgErr = m
end

-- admin_bridge\bots_config.lua -> cfg (numbers validated), source "default" / "file" / "error"
function PTBot_ReadCfg()
	local path = PTBot_Dir() .. "bots_config.lua"
	local fh = openfile(path, "r")
	if not fh then return PTBot_DefaultCfg(), "default" end
	closefile(fh)
	PTBOT_CFG = nil
	-- a broken file must not raise an error every minute: catch the parser message here
	local oldErr = _ERRORMESSAGE
	_ERRORMESSAGE = PTBot_CfgError
	dofile(path)
	_ERRORMESSAGE = oldErr
	local c = PTBOT_CFG
	PTBOT_CFG = nil
	if type(c) ~= "table" then
		if PTBOT_S.cfg then return PTBOT_S.cfg, "error" end
		return PTBot_DefaultCfg(), "error"
	end
	local d = PTBot_DefaultCfg()
	local r = { enabled = PTBot_Num(c.enabled, 0, 1, 1), follow = PTBot_Num(c.follow, 0, 1, d.follow),
		followCount = PTBot_Num(c.followCount, 0, PTBOT_MAX_TOTAL, d.followCount), spots = {},
		party = PTBot_Num(c.party, 0, 1, d.party), partyCount = PTBot_Num(c.partyCount, 0, 7, d.partyCount),
		partyBonus = PTBot_Num(c.partyBonus, 0, 50, d.partyBonus) }
	if type(c.spots) == "table" then
		local n = 0
		local k = 1
		while c.spots[k] and n < PTBOT_MAX_SPOTS do
			local s = c.spots[k]
			if type(s) == "table" then
				local map = PTBot_Num(s.map, 0, 99999, 0)
				if map > 0 then
					n = n + 1
					r.spots[n] = { map = map, x = PTBot_Num(s.x, 0, 65535, 0), y = PTBot_Num(s.y, 0, 65535, 0),
						count = PTBot_Num(s.count, 0, PTBOT_MAX_TOTAL, 0), level = PTBot_Num(s.level, 0, 200, 0) }
				end
			end
			k = k + 1
		end
	end
	return r, "file"
end

function PTBot_CfgKey(cfg)
	local s = cfg.enabled .. "|" .. cfg.follow .. "|" .. cfg.followCount
	s = s .. "|p" .. (cfg.party or 0) .. "," .. (cfg.partyCount or 0) .. "," .. (cfg.partyBonus or 0)
	local k = 1
	while cfg.spots[k] do
		local sp = cfg.spots[k]
		s = s .. "|" .. sp.map .. "," .. sp.x .. "," .. sp.y .. "," .. sp.count .. "," .. sp.level
		k = k + 1
	end
	return s
end

-- spot position in mps: x/y given (cells), else the first leveling / town / arena spot of that map,
-- else the map centre. Also returns the monster level of the map's leveling spot (0 = unknown).
function PTBot_SpotPos(sp)
	local lv0 = 0
	local k = 1
	while PTBOT_FIELDS[k] do
		if lv0 == 0 and PTBOT_FIELDS[k][1] == sp.map then lv0 = PTBOT_FIELDS[k][4] end
		k = k + 1
	end
	if sp.x > 0 and sp.y > 0 then return sp.x * 32, sp.y * 32, lv0 end
	local lists = { PTBOT_FIELDS, PTBOT_TOWNS, PTBOT_ARENAS, PTBOT_CENTRES }
	local i = 1
	while lists[i] do
		local t = lists[i]
		k = 1
		while t[k] do
			if t[k][1] == sp.map then return t[k][2], t[k][3], lv0 end
			k = k + 1
		end
		i = i + 1
	end
	return 51200, 102400, lv0
end

-- name / template / role of slot k: roster order, then the roster again with suffix 2, 3...
-- (ASCII digits appended to the TCVN3 name) and templates cycled over 2703..2720
function PTBot_SlotSpec(k)
	local nr = getn(PTBOT_ROSTER)
	local r = PTBOT_ROSTER[mod(k - 1, nr) + 1]
	local c = floor((k - 1) / nr)
	if c == 0 then return r[1], r[2], r[3] end
	return r[1] .. (c + 1), PTBOT_TPL_MIN + mod(k - 1 + c * 7, PTBOT_TPL_N), r[3]
end

-- plan = free bots (slots 1..followN) then each spot's bots; bots whose slot changed are removed
function PTBot_Configure(cfg, src)
	local S = PTBOT_S
	S.cfg = cfg
	S.cfgSrc = src
	local spots = {}
	local plan = {}
	local n = 0
	local spotN = 0
	local followN = 0
	local k = 1
	if cfg.enabled == 1 then
		while cfg.spots[k] do
			local sp = cfg.spots[k]
			local x, y, lv0 = PTBot_SpotPos(sp)
			local kind = PTBOT_FIELD_KIND
			if PTBot_IsTown(sp.map) then kind = PTBOT_TOWN elseif sp.map == 1001 then kind = PTBOT_EVENT end
			local want = sp.count
			if spotN + want > PTBOT_MAX_TOTAL then want = PTBOT_MAX_TOTAL - spotN end
			spotN = spotN + want
			spots[k] = { map = sp.map, x = x, y = y, lv = sp.level, lv0 = lv0, kind = kind, want = want,
				sig = sp.map .. ":" .. x .. ":" .. y .. ":" .. sp.level }
			k = k + 1
		end
		followN = cfg.followCount
		if followN > PTBOT_MAX_TOTAL - spotN then followN = PTBOT_MAX_TOTAL - spotN end
		k = 1
		while k <= followN do
			n = n + 1
			plan[n] = { grp = 0, sig = "f" }
			k = k + 1
		end
		k = 1
		while spots[k] do
			local j = 1
			while j <= spots[k].want do
				n = n + 1
				plan[n] = { grp = k, sig = spots[k].sig }
				j = j + 1
			end
			k = k + 1
		end
	end
	S.spots = spots
	S.plan = plan
	S.followN = followN
	k = 1
	while k <= n do
		local name, tpl, role = PTBot_SlotSpec(k)
		local p = plan[k]
		local b = S.bots[k]
		if b and (b.name ~= name or b.tpl ~= tpl or b.grp ~= p.grp or b.sig ~= p.sig) then
			PTBot_Remove(b)
			b = nil
		end
		if not b then
			S.bots[k] = { slot = k, name = name, tpl = tpl, role = role, grp = p.grp, sig = p.sig, untilMin = 0 }
		end
		k = k + 1
	end
	while S.bots[k] do
		PTBot_Remove(S.bots[k])
		S.bots[k] = nil
		k = k + 1
	end
end

-- re-read the config file; rebuild the plan when it changed (or when forced)
function PTBot_Sync(force)
	local cfg, src = PTBot_ReadCfg()
	local key = PTBot_CfgKey(cfg)
	if force or (not PTBOT_S.plan) or key ~= PTBOT_S.cfgKey then
		PTBOT_S.cfgKey = key
		PTBot_Configure(cfg, src)
	else
		PTBOT_S.cfgSrc = src
	end
end

function PTBot_SpotLevel(sp)
	local lv
	if sp.lv > 0 then
		lv = sp.lv + random(-3, 3)
	elseif sp.lv0 > 0 then
		lv = sp.lv0 + random(8, 15)
	elseif sp.kind == PTBOT_FIELD_KIND then
		lv = random(30, 80)
	else
		lv = random(40, 90)
	end
	if lv < 1 then lv = 1 end
	return lv
end

function PTBot_PlaceSpot(b, sp)
	local sw = SubWorldID2Idx(sp.map)
	if not sw or sw < 0 then return nil end
	local tries = 1
	while tries <= 4 do
		local x = sp.x + random(-PTBOT_SPOT_R, PTBOT_SPOT_R) * 32
		local y = sp.y + random(-PTBOT_SPOT_R, PTBOT_SPOT_R) * 32
		local ni = PTBot_Add(b.tpl, PTBot_SpotLevel(sp), sw, x, y)
		if ni > 0 then
			SetNpcName(ni, b.name)
			SetNpcParam(ni, 1, sp.kind)
			SetNpcParam(ni, 2, b.slot)
			SetNpcTimer(ni, PTBOT_SCRIPT, random(5, 40))
			b.ni = ni
			b.id = GetNpcID(ni)
			b.kind = sp.kind
			b.map = sp.map
			b.untilMin = PTBOT_S.minute + random(PTBOT_STAY_MIN, PTBOT_STAY_MAX)
			PTBOT_S.spawned = PTBOT_S.spawned + 1
			return 1
		end
		tries = tries + 1
	end
	return nil
end

function PTBot_NearSpot(b, sp)
	local w, x, y = GetNpcPos(b.ni)
	if w ~= sp.map then return nil end
	local dx = floor(sp.x / 32) - x
	local dy = floor(sp.y / 32) - y
	if dx * dx + dy * dy <= PTBOT_NEAR * PTBOT_NEAR then return 1 end
	return nil
end

-- spawn missing bots, keep spot bots at their spot, free bots around players (or roaming)
-- 2026-10-03 botparty: split the online players into follow targets and players with an active bot party
function PTBot_SplitParty(all)
	local f = {}
	local p = {}
	local k = 1
	while all[k] do
		if all[k].party then tinsert(p, all[k]) else tinsert(f, all[k]) end
		k = k + 1
	end
	return f, p
end

function PTBot_Balance(evChanged)
	local S = PTBOT_S
	local all = {}
	if S.followN > 0 and (S.cfg.follow == 1 or S.cfg.party == 1) then all = PTBot_Players() end
	local players, avoid = PTBot_SplitParty(all)
	if S.cfg.follow ~= 1 then players = {} end
	local np = getn(players)
	local na = getn(avoid)
	S.players = np
	local moves = 0
	local smoves = 0
	local k = 1
	while S.bots[k] do
		local b = S.bots[k]
		if b.grp and b.grp > 0 then
			local sp = S.spots[b.grp]
			if not PTBot_Alive(b) then
				PTBot_PlaceSpot(b, sp)
			elseif (not PTBot_NearSpot(b, sp)) and smoves < PTBOT_SPOT_MOVES then
				PTBot_Remove(b)
				PTBot_PlaceSpot(b, sp)
				smoves = smoves + 1
				S.moved = S.moved + 1
			end
		elseif na > 0 and moves < PTBOT_FOLLOW_MOVES and PTBot_Alive(b) and PTBot_NearAny(b, avoid) then
			-- a free bot inside a player's bot party area: send it to another player or roam elsewhere
			PTBot_Remove(b)
			if np > 0 then PTBot_PlaceNear(b, players[mod(k - 1, np) + 1]) else PTBot_Place(b) end
			moves = moves + 1
			S.moved = S.moved + 1
		elseif np > 0 then
			-- follow mode: every free bot is assigned to an online player and kept around them
			local p = players[mod(k - 1, np) + 1]
			if not PTBot_Alive(b) then
				PTBot_PlaceNear(b, p)
			elseif (not PTBot_NearAny(b, players)) and moves < PTBOT_FOLLOW_MOVES then
				PTBot_Remove(b)
				PTBot_PlaceNear(b, p)
				moves = moves + 1
				S.moved = S.moved + 1
			elseif S.minute >= b.untilMin and moves < PTBOT_MOVE_PER_TICK then
				PTBot_Remove(b)
				PTBot_PlaceNear(b, p)
				moves = moves + 1
				S.moved = S.moved + 1
			end
		elseif not PTBot_Alive(b) then
			PTBot_Place(b)
		elseif b.role == PTBOT_EVENT and evChanged then
			PTBot_Remove(b)
			PTBot_Place(b)
			S.moved = S.moved + 1
		elseif S.minute >= b.untilMin and moves < PTBOT_MOVE_PER_TICK then
			PTBot_Remove(b)
			PTBot_Place(b)
			moves = moves + 1
			S.moved = S.moved + 1
		end
		k = k + 1
	end
end

-- admin_bridge\bots.txt: time / cfg enabled follow followCount source max / total alive target /
-- follow alive target players / spot i map x y target alive level loaded (x, y in cells)
function PTBot_WriteStatus()
	local S = PTBOT_S
	local cfg = S.cfg
	local alive = 0
	local fAlive = 0
	local sAlive = {}
	local k = 1
	while S.spots[k] do
		sAlive[k] = 0
		k = k + 1
	end
	k = 1
	while S.bots[k] do
		local b = S.bots[k]
		if PTBot_Alive(b) then
			alive = alive + 1
			if b.grp and b.grp > 0 then sAlive[b.grp] = sAlive[b.grp] + 1 else fAlive = fAlive + 1 end
		end
		k = k + 1
	end
	S.alive = alive
	local dir = PTBot_Dir()
	local h = openfile(dir .. "bots.tmp", "w")
	if not h then return alive end
	write(h, date("%Y-%m-%d %H:%M:%S") .. "\n")
	write(h, "cfg\t" .. cfg.enabled .. "\t" .. cfg.follow .. "\t" .. cfg.followCount .. "\t" .. (S.cfgSrc or "") .. "\t" .. PTBOT_MAX_TOTAL .. "\n")
	write(h, "total\t" .. alive .. "\t" .. getn(S.plan) .. "\n")
	write(h, "follow\t" .. fAlive .. "\t" .. S.followN .. "\t" .. (S.players or 0) .. "\n")
	k = 1
	while S.spots[k] do
		local sp = S.spots[k]
		local loaded = 0
		local sw = SubWorldID2Idx(sp.map)
		if sw and sw >= 0 then loaded = 1 end
		write(h, "spot\t" .. k .. "\t" .. sp.map .. "\t" .. floor(sp.x / 32) .. "\t" .. floor(sp.y / 32) .. "\t" .. sp.want .. "\t" .. sAlive[k] .. "\t" .. sp.lv .. "\t" .. loaded .. "\n")
		k = k + 1
	end
	-- 2026-10-03 botparty: party / on / count / bonus % per bot / players with a party / party bots alive /
	-- EXP bonus supported by the server binary (SetPartyBotBonus of the botparty C++ patch)
	local pst = S.partySt or {}
	local cap = 0
	if SetPartyBotBonus then cap = 1 end
	write(h, "party\t" .. (cfg.party or 0) .. "\t" .. (cfg.partyCount or 0) .. "\t" .. (cfg.partyBonus or 0) .. "\t" .. (pst.players or 0) .. "\t" .. (pst.alive or 0) .. "\t" .. cap .. "\n")
	closefile(h)
	remove(dir .. "bots.txt")
	rename(dir .. "bots.tmp", dir .. "bots.txt")
	return alive
end

-- called by servertimer.lua once per minute
function PTBOT_Tick()
	local S = PTBOT_S
	S.minute = S.minute + 1
	if not S.init then PTBot_Init() end
	PTBot_Sync(nil)
	local boss = PTBot_BossWindow()
	local key = nil
	if boss then key = boss.key end
	local evChanged = nil
	if key ~= S.bossKey then evChanged = 1 end
	S.boss = boss
	S.bossKey = key
	PTBot_Balance(evChanged)
	if PTBP_Tick then PTBP_Tick(S.cfg) end
	PTBot_Greet()
	if PTBOT_WORLD_CHAT and S.minute >= S.nextWorld then
		PTBot_WorldChat()
		S.nextWorld = S.minute + random(2, 5)
	end
	PTBot_WriteStatus()
end

-- web admin (bridge pending.lua): re-read admin_bridge\bots_config.lua and rebalance now.
-- Returns the number of bots alive afterwards.
function PTBOT_AdminApply()
	if not PTBOT_S.init then PTBot_Init() end
	PTBot_Sync(1)
	PTBot_Balance(nil)
	if PTBP_Tick then PTBP_Tick(PTBOT_S.cfg) end
	return PTBot_WriteStatus()
end

-- staggered chat bubble; runs in the registered script state (SetNpcTimer / template TimerScript)
function OnTimer(ni)
	local t = GetNpcTemplateID(ni)
	if not t or t < PTBOT_TPL_MIN or t > PTBOT_TPL_MAX then return end
	if random(1, 100) <= 45 then
		local lines = PTBOT_LINES[GetNpcParam(ni, 1) or 0] or PTBOT_LINES[1]
		PTBot_Say(ni, PTBot_Pick(lines))
	end
	SetNpcTimer(ni, PTBOT_SCRIPT, random(25, 75))
end
