-- Phong Than 2026-10-03 (daily2): ext tick of the newer-era daily quests (Thien Cong, Thien Cuong Hon,
-- Sieu Do, Hap Hon, Van chuyen). servertimer.lua calls PTEXT_daily2_Tick() once per minute (protected).
-- Work: register the loose scripts once per server start (ReLoadScript), keep the 11 giver NPCs alive
-- (idempotent: indices kept, checked by name/template, respawned when gone), and give a new field pack
-- to players standing on the map of an active round whose monsters are gone.
Include("\\script\\phongthan\\daily2\\d2_core.lua")

PTD2X_MAX_PLAYER = 1200
PTD2X_SCRIPTS = {
	"\\script\\phongthan\\daily2\\d2_tinhquan.lua",
	"\\script\\phongthan\\daily2\\d2_anhong.lua",
	"\\script\\phongthan\\daily2\\d2_angiao.lua",
	"\\script\\phongthan\\daily2\\d2_thuyenphu.lua",
	"\\script\\phongthan\\daily2\\d2_tapthuong.lua",
	"\\script\\phongthan\\daily2\\d2_mob.lua",
}
-- { map, template, x, y (NewWorld units = taskinfo mappos), name, script }
PTD2X_NPCS = {
	{ 1021, 202, 1797, 3046, "Tinh Quan", "\\script\\phongthan\\daily2\\d2_tinhquan.lua" },
	{ 1020, 202, 1424, 3000, "Tinh Quan", "\\script\\phongthan\\daily2\\d2_tinhquan.lua" },
	{ 1001, 165, 1516, 3192, "¢n Hång", "\\script\\phongthan\\daily2\\d2_anhong.lua" },
	{ 1001, 164, 1472, 3088, "¢n Giao", "\\script\\phongthan\\daily2\\d2_angiao.lua" },
	{ 1055, 160, 1780, 3166, "ThuyÒn Phu", "\\script\\phongthan\\daily2\\d2_thuyenphu.lua" },
	{ 1056, 160, 1807, 3188, "ThuyÒn Phu", "\\script\\phongthan\\daily2\\d2_thuyenphu.lua" },
	{ 1002, 158, 1745, 3154, "T¹p Th­¬ng", "\\script\\phongthan\\daily2\\d2_tapthuong.lua" },
	{ 1003, 158, 1608, 3209, "T¹p Th­¬ng", "\\script\\phongthan\\daily2\\d2_tapthuong.lua" },
	{ 1004, 158, 1560, 3332, "T¹p Th­¬ng", "\\script\\phongthan\\daily2\\d2_tapthuong.lua" },
	{ 1020, 158, 1567, 3025, "T¹p Th­¬ng", "\\script\\phongthan\\daily2\\d2_tapthuong.lua" },
	{ 1021, 158, 1776, 3169, "T¹p Th­¬ng", "\\script\\phongthan\\daily2\\d2_tapthuong.lua" },
}
if PTD2X_IDX == nil then PTD2X_IDX = {} end

function PTD2X_Register()
	if PTD2X_REGISTERED then return end
	local i = 1
	while PTD2X_SCRIPTS[i] do
		ReLoadScript(PTD2X_SCRIPTS[i])
		i = i + 1
	end
	PTD2X_REGISTERED = 1
end

function PTD2X_EnsureNpcs()
	local k = 1
	while PTD2X_NPCS[k] do
		local p = PTD2X_NPCS[k]
		local ni = PTD2X_IDX[k]
		if not (ni and ni > 0 and GetNpcName(ni) == p[5] and GetNpcTemplateID(ni) == p[2]) then
			local sw = SubWorldID2Idx(p[1])
			if sw and sw >= 0 then
				ni = AddNpc(p[2], 1, sw, p[3] * 32, p[4] * 32, 0)
				if ni and ni > 0 then
					SetNpcName(ni, p[5])
					SetNpcScript(ni, p[6])
					PTD2X_IDX[k] = ni
				end
			end
		end
		k = k + 1
	end
end

function PTD2X_Err(m)
end

function PTEXT_daily2_Tick()
	PTD2X_Register()
	PTD2X_EnsureNpcs()
	local old = PlayerIndex
	local i = 1
	while i <= PTD2X_MAX_PLAYER do
		PlayerIndex = i
		local nm = GetName()
		if nm and nm ~= "" then
			call(PTD2_TickPlayer, {}, "x", PTD2X_Err)
		end
		i = i + 1
	end
	PlayerIndex = old
end
