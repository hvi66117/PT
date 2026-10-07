-- Phong Than 2026-10-03 (congthanh): personal territory ("lanh dia ca nhan") NPCs.
-- servertimer.lua PTAdm_ExtTick() calls PTEXT_congthanh_Tick() once per minute, protected, once the
-- coordinator adds "congthanh" to PTADM_EXT_NAMES (until then this file is never loaded = feature off).
--  1. first tick: ReLoadScript of the loose territory scripts (script\phongthan\congthanh\*.lua);
--  2. keep the territory NPCs alive (idempotent: stored index + name + map check, respawn when gone),
--     re-bind the script every tick;
--  3. the 4 buildings that run the VNG scripts (Dien Phong Than, Trai linh, Phong luyen thuoc, Thao truong)
--     are only spawned when ptfix.pak carries the congthanh patch (marker \script\phongthan\congthanh\
--     ct_pakmark.lua, shipped only inside ptfix by S\ptfix\extra_congthanh.py); without it the VNG
--     scripts would show an empty building panel.
-- Places: Tay Ky (1020) row 10 cells south of the shop row (server Region_S + client Region_C free,
-- connected to the shops), Ve quan in Trieu Ca (1021) north of the medicine shop.
-- congthanh2 (2026-10-03):
--  4. taskinfo 31 "Thao truong thi luyen": the 22 field doctors (VNG \script\long tao\ye wai yi sheng-<map>.lua,
--     task 304 = 5..51 picks one by level) that no map / agent places yet (1014/1015/1016 stand in the region data,
--     1022-1041 are spawned by ext\sudo_dongdi.lua), 5 cells from the main arrival point of each map;
--  5. city defence tick and schedule (ct_def.lua); first tick of a fresh state ends a defence left running by
--     an earlier state and removes its attackers / guards (NpcParam 1 = PTCT_K).
-- Doc: docs\features\cong-thanh-lanh-dia-phong-than-20261003.md
Include("\\script\\phongthan\\congthanh\\ct_def.lua")

PTCT_X_DIR = "\\script\\phongthan\\congthanh\\"
PTCT_X_PAKMARK = "\\script\\phongthan\\congthanh\\ct_pakmark.lua"
PTCT_X_REG = {}
PTCT_X_REG[1] = "ct_steward.lua"
PTCT_X_REG[2] = "ct_muchang.lua"
PTCT_X_REG[3] = "ct_chienxa.lua"
PTCT_X_REG[4] = "ct_herb.lua"
PTCT_X_REG[5] = "ct_hyvien.lua"
PTCT_X_REG[6] = "ct_vequan.lua"
PTCT_X_REG[7] = "ct_mob.lua"
-- VNG building scripts (GBK paths, ptfix.pak)
PTCT_X_SHENDIAN = "\\script\\\188\180\202\177\185\250\213\189\\\201\241\181\238.lua"
PTCT_X_BINGYING = "\\script\\\188\180\202\177\185\250\213\189\\\177\248\211\170.lua"
PTCT_X_LIANDAN = "\\script\\\188\180\202\177\185\250\213\189\\\193\182\181\164\194\175.lua"
PTCT_X_BACHANG = "\\script\\\188\180\202\177\185\250\213\189\\\176\208\179\161.lua"

-- { map, template, mpsX, mpsY, name (TCVN3), script, needs ptfix marker }
PTCT_X_NPCS = {}
PTCT_X_NPCS[1] = { 1020, 768, 49120, 96832, "L\183nh \174\222a quan", PTCT_X_DIR .. "ct_steward.lua", nil }
PTCT_X_NPCS[2] = { 1020, 1130, 48960, 96832, "\167i\214n Phong Th\199n", PTCT_X_SHENDIAN, 1 }
PTCT_X_NPCS[3] = { 1020, 211, 48800, 96832, "Tr\185i l\221nh \174\184nh thu\170", PTCT_X_BINGYING, 1 }
PTCT_X_NPCS[4] = { 1020, 149, 48640, 96832, "Ph\223ng luy\214n thu\232c", PTCT_X_LIANDAN, 1 }
PTCT_X_NPCS[5] = { 1020, 158, 49824, 96832, "Thao tr\173\234ng", PTCT_X_BACHANG, 1 }
PTCT_X_NPCS[6] = { 1020, 151, 49984, 96832, "S\169n luy\214n th\243", PTCT_X_DIR .. "ct_muchang.lua", nil }
PTCT_X_NPCS[7] = { 1020, 157, 50144, 96832, "Ph\223ng chi\213n xa", PTCT_X_DIR .. "ct_chienxa.lua", nil }
PTCT_X_NPCS[8] = { 1020, 2081, 49984, 97152, "H\253 vi\214n", PTCT_X_DIR .. "ct_hyvien.lua", nil }
PTCT_X_NPCS[9] = { 1020, 151, 48640, 97408, "X\221ch \167\229ng Th\182o", PTCT_X_DIR .. "ct_herb.lua", nil }
PTCT_X_NPCS[10] = { 1020, 151, 48800, 97536, "X\221ch \167\229ng Th\182o", PTCT_X_DIR .. "ct_herb.lua", nil }
PTCT_X_NPCS[11] = { 1020, 151, 48640, 97664, "X\221ch \167\229ng Th\182o", PTCT_X_DIR .. "ct_herb.lua", nil }
PTCT_X_NPCS[12] = { 1021, 211, 51904, 94208, "V\214 qu\169n", PTCT_X_DIR .. "ct_vequan.lua", nil }
-- taskinfo 34 "Hoa than bi": one "Hoa than Cuu Di" (tpl 255, kind 3) per map, at the first position of the
-- VNG pos table of its script (server Region_S + client Region_C free 3x3); script = the VNG flower script
-- (GBK path, ptfix; extra_congthanh.py disables its broken move-after-3-picks branch). Needs the marker.
PTCT_X_FLOWER = "Hoa th\199n C\246u Di"
function PTCT_X_DefFlower(map, x, y, gbkname)
	local k = getn(PTCT_X_NPCS) + 1
	PTCT_X_NPCS[k] = { map, 255, x * 32, y * 32, PTCT_X_FLOWER, "\\script\\\201\241\195\216\187\168\187\220\200\206\206\241\\\200\206\206\241-" .. gbkname .. ".lua", 1 }
end
PTCT_X_DefFlower(1016, 1390, 3497, "\200\253\201\189\185\216")   -- task 361
PTCT_X_DefFlower(1015, 1617, 3276, "\195\207\189\242")   -- task 363
PTCT_X_DefFlower(1001, 1673, 3080, "\183\226\201\241\204\168")   -- task 356
PTCT_X_DefFlower(1002, 1543, 3258, "\179\231\179\199\180\243\211\170")   -- task 351
PTCT_X_DefFlower(1005, 1560, 3234, "\179\231\179\199\210\176\205\226")   -- task 359
PTCT_X_DefFlower(1008, 1945, 2851, "\192\165\194\216\201\189\194\180")   -- task 358
PTCT_X_DefFlower(1021, 1563, 3209, "\179\175\184\232")   -- task 353
PTCT_X_DefFlower(1011, 1838, 3587, "\211\206\187\234\185\216")   -- task 360
PTCT_X_DefFlower(1014, 1715, 3668, "\228\252\185\216")   -- task 362
PTCT_X_DefFlower(1003, 1750, 3258, "\211\241\208\233\185\172")   -- task 350
PTCT_X_DefFlower(1052, 1464, 3177, "\209\254\179\216")   -- task 355
PTCT_X_DefFlower(1057, 1599, 2959, "\191\243\179\161")   -- task 357
PTCT_X_DefFlower(1004, 1647, 3162, "\242\191\211\200\196\185")   -- task 352
PTCT_X_DefFlower(1020, 1324, 3216, "\206\247\225\170")   -- task 354
PTCT_X_DefFlower(1065, 1552, 3310, "\179\194\204\193\185\216")   -- task 364
-- taskinfo 31: field doctors (template 149 like ext\sudo_dongdi.lua), cell = world units, GBK script suffix
PTCT_X_DOC = "\167\185i Phu"
PTCT_X_DOCS = {}
function PTCT_X_DefDoc(map, x, y, gbkname)
	local k = getn(PTCT_X_NPCS) + 1
	local p = "\\script\\\193\250\204\215\\\210\176\205\226\210\189\201\250-" .. gbkname .. ".lua"
	PTCT_X_NPCS[k] = { map, 149, x * 32, y * 32, PTCT_X_DOC, p, nil }
	PTCT_X_DOCS[getn(PTCT_X_DOCS) + 1] = p
end
PTCT_X_DefDoc(1005, 1804, 2939, "\179\231\179\199\210\176\205\226")   -- 304 = 5 b3e7b3c7d2b0cde2
PTCT_X_DefDoc(1006, 1918, 2794, "\177\177\186\163")   -- 304 = 6 b1b1baa3
PTCT_X_DefDoc(1007, 1605, 3200, "\209\224\201\189")   -- 304 = 7 d1e0c9bd
PTCT_X_DefDoc(1008, 1680, 3006, "\192\165\194\216\201\189\194\180")   -- 304 = 8 c0a5c2d8c9bdc2b4
PTCT_X_DefDoc(1009, 1839, 3758, "\206\247\192\165\194\216")   -- 304 = 9 cef7c0a5c2d8
PTCT_X_DefDoc(1010, 1588, 3191, "\202\215\209\244\201\189")   -- 304 = 10 cad7d1f4c9bd
PTCT_X_DefDoc(1011, 1822, 3611, "\211\206\187\234\185\216")   -- 304 = 11 d3cebbeab9d8
PTCT_X_DefDoc(1012, 1467, 3033, "\195\231\189\174")   -- 304 = 12 c3e7bdae
PTCT_X_DefDoc(1013, 1580, 3208, "\190\222\194\185")   -- 304 = 13 bedec2b9
PTCT_X_DefDoc(1017, 1923, 3031, "\225\170\201\189")   -- 304 = 17 e1aac9bd
PTCT_X_DefDoc(1018, 1792, 2910, "\196\193\210\176")   -- 304 = 18 c4c1d2b0
PTCT_X_DefDoc(1065, 1510, 3293, "\179\194\204\193\185\216")   -- 304 = 19 b3c2ccc1b9d8
PTCT_X_DefDoc(1019, 1346, 2933, "\190\248\193\250\193\235")   -- 304 = 21 bef8c1fac1eb
PTCT_X_DefDoc(1042, 1660, 3142, "\177\204\211\206\185\172\210\187\178\227")   -- 304 = 42 b1ccd3ceb9acd2bbb2e3
PTCT_X_DefDoc(1043, 1273, 3215, "\177\204\211\206\185\172\182\254\178\227")   -- 304 = 43 b1ccd3ceb9acb6feb2e3
PTCT_X_DefDoc(1044, 1627, 3177, "\177\204\211\206\185\172\200\253\178\227")   -- 304 = 44 b1ccd3ceb9acc8fdb2e3
PTCT_X_DefDoc(1045, 1268, 3271, "\177\204\211\206\185\172\203\196\178\227")   -- 304 = 45 b1ccd3ceb9accbc4b2e3
PTCT_X_DefDoc(1046, 1497, 2801, "\177\204\211\206\185\172\206\229\178\227")   -- 304 = 46 b1ccd3ceb9accee5b2e3
PTCT_X_DefDoc(1047, 1825, 3131, "\192\166\207\201\185\172\210\187\178\227")   -- 304 = 47 c0a6cfc9b9acd2bbb2e3
PTCT_X_DefDoc(1048, 1686, 2943, "\192\166\207\201\185\172\182\254\178\227")   -- 304 = 48 c0a6cfc9b9acb6feb2e3
PTCT_X_DefDoc(1049, 1622, 2971, "\192\166\207\201\185\172\200\253\178\227")   -- 304 = 49 c0a6cfc9b9acc8fdb2e3
PTCT_X_DefDoc(1050, 1629, 2973, "\192\166\207\201\185\172\203\196\178\227")   -- 304 = 50 c0a6cfc9b9accbc4b2e3
PTCT_X_DefDoc(1051, 1629, 2972, "\192\166\207\201\185\172\206\229\178\227")   -- 304 = 51 c0a6cfc9b9accee5b2e3
if PTCT_X_IDX == nil then PTCT_X_IDX = {} end
PTCT_X_MAX_NPC = 48000

function PTCT_X_Log(s)
	if PTAdm_Log then PTAdm_Log("congthanh", "OK", s) end
end
function PTCT_X_Nop() end

function PTCT_X_Register()
	if PTCT_X_REGD then return end
	local i = 1
	while PTCT_X_REG[i] do
		ReLoadScript(PTCT_X_DIR .. PTCT_X_REG[i])
		i = i + 1
	end
	-- field doctors (PAK-only GBK scripts are not registered at start); protected like ext\vienco.lua
	i = 1
	while PTCT_X_DOCS[i] do
		call(ReLoadScript, { PTCT_X_DOCS[i] }, "x", PTCT_X_Nop)
		i = i + 1
	end
	PTCT_X_REGD = 1
end

-- first tick of a fresh state: a defence left running by an earlier state cannot be followed any more
-- (its Lua globals are gone): end it without reward / penalty and remove its attackers and guards.
function PTCT_X_DefReset()
	if PTCT_X_DEFRESET then return end
	PTCT_X_DEFRESET = 1
	if GetGlobalValue(PTCT_GV_STATE) == 1 then
		SetGlobalValue(PTCT_GV_LAST, GetGlobalValue(PTCT_GV_KEY) * 10 + 3)
		SetGlobalValue(PTCT_GV_STATE, 0)
	end
	local n = 0
	local i = 1
	while i < PTCT_X_MAX_NPC do
		if GetNpcParam(i, 1) == PTCT_K and (GetNpcID(i) or 0) ~= 0 then
			local r = GetNpcParam(i, 3)
			if r == PTCT_ROLE_ATK or r == PTCT_ROLE_GUARD then
				SetNpcParam(i, 1, 0)
				DelNpc(i)
				n = n + 1
			end
		end
		i = i + 1
	end
	i = 1
	while i <= PTCT_DEF_NATK do
		SetGlobalValue(PTCT_GV_ATK + i, 0)
		i = i + 1
	end
	i = 1
	while i <= PTCT_DEF_NGUARD do
		SetGlobalValue(PTCT_GV_GUARD + i, 0)
		i = i + 1
	end
	if n > 0 then PTCT_X_Log("removed " .. n .. " city-defence NPCs of an earlier state") end
end

-- ptfix marker: checked on the first tick, then every 30 ticks until found
function PTCT_X_PakOk()
	if PTCT_PAKMARK_OK then return 1 end
	PTCT_X_PAKN = (PTCT_X_PAKN or 0) + 1
	if PTCT_X_PAKN == 1 or mod(PTCT_X_PAKN, 30) == 0 then
		local old = _ERRORMESSAGE
		call(Include, { PTCT_X_PAKMARK }, "x", PTCT_X_Nop)
		_ERRORMESSAGE = old
		if PTCT_PAKMARK and PTCT_PAKMARK >= 1 then
			PTCT_PAKMARK_OK = 1
			PTCT_X_Log("ptfix marker v" .. PTCT_PAKMARK .. " found: VNG buildings enabled")
			return 1
		end
		if PTCT_X_PAKN == 1 then PTCT_X_Log("ptfix marker missing: VNG buildings wait for the new ptfix.pak") end
	end
	return nil
end

function PTCT_X_Alive(ni, s)
	if not ni or ni <= 0 then return nil end
	if GetNpcName(ni) ~= s[5] then return nil end
	if GetNpcPos(ni) ~= s[1] then return nil end
	return 1
end

function PTCT_X_Spawn(s)
	local sw = SubWorldID2Idx(s[1])
	if not sw or sw < 0 then return nil end
	local ni = AddNpc(s[2], 1, sw, s[3], s[4], 0)
	if not ni or ni <= 0 then ni = AddNpc(s[2], 1, sw, s[3] + 64, s[4], 0) end
	if not ni or ni <= 0 then return nil end
	SetNpcName(ni, s[5])
	return ni
end

function PTCT_X_EnsureNpcs()
	local pak = PTCT_X_PakOk()
	local k = 1
	local made = 0
	while PTCT_X_NPCS[k] do
		local s = PTCT_X_NPCS[k]
		if pak or not s[7] then
			local ni = PTCT_X_IDX[k]
			if not PTCT_X_Alive(ni, s) then
				ni = PTCT_X_Spawn(s)
				PTCT_X_IDX[k] = ni
				if ni then made = made + 1 end
			end
			if ni then SetNpcScript(ni, s[6]) end
		end
		k = k + 1
	end
	if made > 0 then PTCT_X_Log("spawned " .. made .. " territory NPCs") end
end

function PTEXT_congthanh_Tick()
	PTCT_X_Register()
	PTCT_X_DefReset()
	PTCT_X_EnsureNpcs()
	PTCT_D_Tick()
end
