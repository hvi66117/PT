-- Phong Than 2026-10-03 (daily3): ext tick of Ma De (81), Phuc Kim (71) and Luc Lam Hao Han.
-- servertimer.lua calls PTEXT_daily3_Tick() once per minute (protected, PTAdm_ExtTick). Idempotent:
--  1. first tick: ReLoadScript of the loose scripts + the GBK Hao Han path (ptfix forwarder);
--  2. keep the 2 Nha chiem tinh alive (indices kept, checked by name/template, respawned when gone);
--  3. re-bind daily2's An Hong (map 1001, template 165) to d3_anhong.lua and the VNG map NPC \194\204\193\214\186\195\186\186 (Tam Son)
--     to d3_luclam.lua (found by name; spawned at the VNG placement when the map has none);
--  4. every online player: bandit title expiry, convoy job timeout / respawn, Ma De pack respawn.
Include("\\script\\phongthan\\daily2\\d2_core.lua")
Include("\\script\\phongthan\\daily3\\d3_core.lua")

PTD3X_MAX_PLAYER = 1200
PTD3X_MAX_NPC = 48000
PTD3X_SCRIPTS = {
	"\\script\\phongthan\\daily3\\d3_anhong.lua",
	"\\script\\phongthan\\daily3\\d3_chiemtinh.lua",
	"\\script\\phongthan\\daily3\\d3_luclam.lua",
	"\\script\\phongthan\\daily3\\d3_mob.lua",
	"\\script\\\212\203\239\218\\\194\204\193\214\186\195\186\186.lua",
}
PTD3X_ANHONG = { 1001, 165, "¢n Hång", "\\script\\phongthan\\daily3\\d3_anhong.lua" }
PTD3X_LUCLAM_SCRIPT = "\\script\\phongthan\\daily3\\d3_luclam.lua"
PTD3X_LUCLAM_GBK = "\194\204\193\214\186\195\186\186"
PTD3X_LUCLAM_NAME = "Lôc L©m H¶o H¸n"
-- { map, template, x, y (NewWorld units = taskinfo mappos), name, script }
PTD3X_NPCS = {
	{ 1021, 202, 1724, 3018, "Nhµ Chiªm Tinh", "\\script\\phongthan\\daily3\\d3_chiemtinh.lua" },
	{ 1020, 202, 1434, 3049, "Nhµ Chiªm Tinh", "\\script\\phongthan\\daily3\\d3_chiemtinh.lua" },
}
if PTD3X_IDX == nil then PTD3X_IDX = {} end
PTD3X_TICKS = 0

function PTD3X_Register()
	if PTD3X_REGISTERED then return end
	local i = 1
	while PTD3X_SCRIPTS[i] do
		ReLoadScript(PTD3X_SCRIPTS[i])
		i = i + 1
	end
	PTD3X_REGISTERED = 1
end

function PTD3X_EnsureNpcs()
	local k = 1
	while PTD3X_NPCS[k] do
		local p = PTD3X_NPCS[k]
		local ni = PTD3X_IDX[k]
		if not (ni and ni > 0 and GetNpcName(ni) == p[5] and GetNpcTemplateID(ni) == p[2]) then
			local sw = SubWorldID2Idx(p[1])
			if sw and sw >= 0 then
				ni = AddNpc(p[2], 1, sw, p[3] * 32, p[4] * 32, 0)
				if ni and ni > 0 then
					SetNpcName(ni, p[5])
					SetNpcScript(ni, p[6])
					PTD3X_IDX[k] = ni
				end
			end
		end
		k = k + 1
	end
end

function PTD3X_OnMap(ni, map)
	local w = GetNpcWorldPos(ni)
	return PTD2_MapId(w) == map
end

-- one scan over the NPC table finds both An Hong and the Hao Han
function PTD3X_Scan()
	local ah, ll = 0, 0
	local i = 1
	while i < PTD3X_MAX_NPC do
		local nm = GetNpcName(i)
		if nm and nm ~= "" then
			if ah == 0 and nm == PTD3X_ANHONG[3] and GetNpcTemplateID(i) == PTD3X_ANHONG[2] and PTD3X_OnMap(i, PTD3X_ANHONG[1]) then ah = i end
			if ll == 0 and (nm == PTD3X_LUCLAM_GBK or nm == PTD3X_LUCLAM_NAME) and PTD3X_OnMap(i, PTD3_LL_NPC[1]) then ll = i end
			if ah > 0 and ll > 0 then break end
		end
		i = i + 1
	end
	return ah, ll
end

function PTD3X_BindNpcs()
	local ah = PTD3X_AH
	local ll = PTD3X_LL
	local okah = ah and ah > 0 and GetNpcName(ah) == PTD3X_ANHONG[3] and GetNpcTemplateID(ah) == PTD3X_ANHONG[2]
	local okll = ll and ll > 0 and GetNpcName(ll) == PTD3X_LUCLAM_NAME
	-- full scan: first tick, every 5 ticks while one is missing, every 30 ticks otherwise (safety re-bind)
	local every = 30
	if not (okah and okll) then every = 5 end
	if PTD3X_TICKS ~= 1 and mod(PTD3X_TICKS, every) ~= 1 then return end
	local a, l = PTD3X_Scan()
	if a > 0 then
		SetNpcScript(a, PTD3X_ANHONG[4])
		PTD3X_AH = a
	end
	if l == 0 then
		local sw = SubWorldID2Idx(PTD3_LL_NPC[1])
		if sw and sw >= 0 then
			l = AddNpc(PTD3_LL_NPC[2], 1, sw, PTD3_LL_NPC[3] * 32, PTD3_LL_NPC[4] * 32, 0)
			if not l then l = 0 end
		end
	end
	if l > 0 then
		SetNpcName(l, PTD3X_LUCLAM_NAME)
		SetNpcScript(l, PTD3X_LUCLAM_SCRIPT)
		PTD3X_LL = l
	end
end

function PTD3X_Err(m)
end

function PTEXT_daily3_Tick()
	PTD3X_TICKS = PTD3X_TICKS + 1
	PTD3X_Register()
	PTD3X_EnsureNpcs()
	call(PTD3X_BindNpcs, {}, "x", PTD3X_Err)
	local old = PlayerIndex
	local i = 1
	while i <= PTD3X_MAX_PLAYER do
		PlayerIndex = i
		local nm = GetName()
		if nm and nm ~= "" then
			call(PTD3_TickPlayer, {}, "x", PTD3X_Err)
		end
		i = i + 1
	end
	PlayerIndex = old
end
