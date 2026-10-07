-- Phong Than 2026-10-03 (agent sinhhoat): ext tick of Le Quan events, Sinh hoat and Linh thu. servertimer.lua
-- calls PTEXT_sinhhoat_Tick() once per minute (protected). Work:
--   * register the loose scripts once per server start (ReLoadScript);
--   * keep 12 city NPCs alive (Le Quan x5, Sinh Hoat Su x5, Linh Thu Su x2; idempotent: indices kept, checked by
--     name + template + npc param, respawned when gone);
--   * keep 30 gather nodes (herb / ore / fishing) alive, a depleted node comes back after PTSHX_NODE_DELAY minutes;
--   * announce the Le Quan event hours (12:00-13:59, 19:00-22:59);
--   * pet minute tick for every online player who has a pet out (pet exp, owner exp, re-summon after map change).
-- Positions: taskinfo (Le Quan), next to the daily2 Tap Thuong (Sinh Hoat Su), walkable cells of the generated
-- monster spawns (gather nodes, checked on the Region_S grids by scratchpad\sinhhoat\pos.py).
Include("\\script\\phongthan\\sinhhoat\\sh_lib.lua")

PTSHX_MAX_PLAYER = 1200
PTSHX_NODE_DELAY = 3
PTSHX_SCRIPTS = { "sh_master", "sh_node", "lq_npc", "lq_tree", "lq_mob", "lq_hatgiong", "lq_chienthu",
	"lt_npc", "lt_lenh", "lt_don", "lt_trung_1", "lt_trung_2", "lt_trung_3", "lt_trung_4", "lt_trung_5",
	"lt_trung_6", "lt_trung_7", "lt_trung_8" }
-- city NPCs: { map, template, cell x, cell y, name, script }
PTSHX_NPCS = {}
PTSHX_NPCS[1] = { 1020, 154, 1472, 3052, "L\212 Quan", PTSH_S_LQ }
PTSHX_NPCS[2] = { 1021, 154, 1757, 3066, "L\212 Quan", PTSH_S_LQ }
PTSHX_NPCS[3] = { 1002, 154, 1599, 3159, "L\212 Quan", PTSH_S_LQ }
PTSHX_NPCS[4] = { 1003, 154, 1767, 3160, "L\212 Quan", PTSH_S_LQ }
PTSHX_NPCS[5] = { 1004, 154, 1606, 3322, "L\212 Quan", PTSH_S_LQ }
PTSHX_NPCS[6] = { 1020, 167, 1571, 3032, "Sinh Ho\185t S\173", PTSH_S_MASTER }
PTSHX_NPCS[7] = { 1021, 167, 1782, 3175, "Sinh Ho\185t S\173", PTSH_S_MASTER }
PTSHX_NPCS[8] = { 1002, 167, 1751, 3160, "Sinh Ho\185t S\173", PTSH_S_MASTER }
PTSHX_NPCS[9] = { 1003, 167, 1614, 3215, "Sinh Ho\185t S\173", PTSH_S_MASTER }
PTSHX_NPCS[10] = { 1004, 167, 1566, 3338, "Sinh Ho\185t S\173", PTSH_S_MASTER }
PTSHX_NPCS[11] = { 1020, 181, 1478, 3060, "Linh Th\243 S\248", PTSH_S_LT }
PTSHX_NPCS[12] = { 1021, 181, 1763, 3074, "Linh Th\243 S\248", PTSH_S_LT }
-- gather nodes: { type (1 herb, 2 ore, 3 fish), map, cell x, cell y }
PTSHX_NODE_TPL = { 1870, 1738, 1456 }
PTSHX_NODE_NAME = { "B\244i Th\182o D\173\238c", "M\185ch Kho\184ng", "\167i\211m C\169u C\184" }
PTSHX_NODES = {}
local n = PTSHX_NODES
n[1] = { 1, 1005, 1826, 2962 } n[2] = { 1, 1005, 1799, 2947 } n[3] = { 1, 1005, 1800, 2906 }
n[4] = { 1, 1008, 1610, 3127 } n[5] = { 1, 1008, 1707, 3038 } n[6] = { 1, 1008, 1623, 3163 }
n[7] = { 1, 1012, 1484, 3028 } n[8] = { 1, 1012, 1499, 2993 } n[9] = { 1, 1012, 1478, 3081 }
n[10] = { 1, 1017, 1586, 3612 } n[11] = { 1, 1017, 1630, 3611 } n[12] = { 1, 1017, 1615, 3585 }
n[13] = { 2, 1007, 1623, 3196 } n[14] = { 2, 1007, 1620, 3235 } n[15] = { 2, 1007, 1620, 3149 }
n[16] = { 2, 1013, 1594, 3227 } n[17] = { 2, 1013, 1600, 3177 } n[18] = { 2, 1013, 1632, 3220 }
n[19] = { 2, 1010, 1586, 3179 } n[20] = { 2, 1010, 1621, 3206 } n[21] = { 2, 1010, 1564, 3157 }
n[22] = { 3, 1006, 1913, 2788 } n[23] = { 3, 1006, 1914, 2843 } n[24] = { 3, 1006, 1922, 2749 }
n[25] = { 3, 1015, 1425, 3598 } n[26] = { 3, 1015, 1576, 2981 } n[27] = { 3, 1015, 1388, 3578 }
n[28] = { 3, 1037, 1611, 3353 } n[29] = { 3, 1037, 1577, 3334 } n[30] = { 3, 1037, 1587, 3388 }

if PTSHX_IDX == nil then PTSHX_IDX = {} end
if PTSHX_NIDX == nil then PTSHX_NIDX = {} end
if PTSHX_GONE == nil then PTSHX_GONE = {} end
if PTSHX_MIN == nil then PTSHX_MIN = 0 end
PTSHX_LAST = { npcs = 0, nodes = 0, pets = 0, news = "" }

function PTSHX_Register()
	if PTSHX_REGISTERED then return end
	local i = 1
	while PTSHX_SCRIPTS[i] do
		ReLoadScript(PTSH_DIR .. PTSHX_SCRIPTS[i] .. ".lua")
		i = i + 1
	end
	PTSHX_REGISTERED = 1
end

function PTSHX_EnsureNpcs()
	local made = 0
	local k = 1
	while PTSHX_NPCS[k] do
		local p = PTSHX_NPCS[k]
		local ni = PTSHX_IDX[k]
		if not (ni and ni > 0 and GetNpcName(ni) == p[5] and GetNpcTemplateID(ni) == p[2]) then
			local sw = SubWorldID2Idx(p[1])
			if sw and sw >= 0 then
				ni = AddNpc(p[2], 1, sw, p[3] * 32, p[4] * 32, 0)
				if ni and ni > 0 then
					SetNpcName(ni, p[5])
					SetNpcScript(ni, p[6])
					PTSHX_IDX[k] = ni
					made = made + 1
				end
			end
		end
		k = k + 1
	end
	return made
end

function PTSHX_NodeAlive(k)
	local ni = PTSHX_NIDX[k]
	if ni == nil or ni <= 0 then return 0 end
	local typ = PTSHX_NODES[k][1]
	if GetNpcTemplateID(ni) ~= PTSHX_NODE_TPL[typ] then return 0 end
	if GetNpcParam(ni, 0) ~= PTSH_MG_NODE + typ then return 0 end
	return 1
end

function PTSHX_EnsureNodes()
	local made = 0
	local k = 1
	while PTSHX_NODES[k] do
		if PTSHX_NodeAlive(k) == 0 then
			local g = PTSHX_GONE[k]
			if g == nil and PTSHX_NIDX[k] then
				PTSHX_GONE[k] = PTSHX_MIN
			elseif g == nil or PTSHX_MIN - g >= PTSHX_NODE_DELAY then
				local p = PTSHX_NODES[k]
				local sw = SubWorldID2Idx(p[2])
				if sw and sw >= 0 then
					local ni = AddNpc(PTSHX_NODE_TPL[p[1]], 1, sw, p[3] * 32, p[4] * 32, 0)
					if ni and ni > 0 then
						SetNpcName(ni, PTSHX_NODE_NAME[p[1]])
						SetNpcScript(ni, PTSH_S_NODE)
						SetNpcParam(ni, 0, PTSH_MG_NODE + p[1])
						SetNpcParam(ni, 1, PTSH_NODE_USES)
						PTSHX_NIDX[k] = ni
						PTSHX_GONE[k] = nil
						made = made + 1
					end
				end
			end
		end
		k = k + 1
	end
	return made
end

function PTSHX_News()
	if not date then return end
	local hm = date("%H:%M")
	if hm == PTSHX_LAST.news then return end
	local msg = nil
	if hm == "12:00" or hm == "19:00" then
		msg = "L\212 h\233i \174\183 m\235! G\198p L\212 Quan (T\169y K\250, Tri\210u Ca, c\184c th\171n t\169n th\241) nh\203n H\185t Gi\232ng K\250 S\172n v\181 Chi\213n Th\173 Khi\170u Chi\213n."
	elseif hm == "13:55" or hm == "22:55" then
		msg = "L\212 h\233i s\190p k\213t th\243c, h\183y nhanh ch\227ng g\198p L\212 Quan nh\203n h\185t gi\232ng v\181 chi\213n th\173."
	end
	if msg then
		PTSHX_LAST.news = hm
		AddGlobalNews(msg)
	end
end

function PTSHX_Err(m)
end

function PTEXT_sinhhoat_Tick()
	PTSHX_MIN = PTSHX_MIN + 1
	PTSHX_Register()
	PTSHX_LAST.npcs = PTSHX_EnsureNpcs()
	PTSHX_LAST.nodes = PTSHX_EnsureNodes()
	PTSHX_News()
	local old = PlayerIndex
	local pets = 0
	local i = 1
	while i <= PTSHX_MAX_PLAYER do
		PlayerIndex = i
		local nm = GetName()
		if nm and nm ~= "" and GetTask(PTLT_T_NPC) ~= 0 then
			pets = pets + 1
			call(PTLT_TickPlayer, {}, "x", PTSHX_Err)
		end
		i = i + 1
	end
	PlayerIndex = old
	PTSHX_LAST.pets = pets
end
