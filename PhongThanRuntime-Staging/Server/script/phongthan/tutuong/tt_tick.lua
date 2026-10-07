-- Phong Than 2026-10-02 (tutuong_b): minute tick for Tu Linh and Thu Thach Huyen Vu.
-- servertimer.lua (once per minute):
--   function PTAdm_TtTick()
--     if not PTTT_Tick then dofile("script\\phongthan\\tutuong\\tt_tick.lua") end
--     if PTTT_Tick then PTTT_Tick() end
--   end
-- Work: register the loose NPC/item/death scripts once per server start (ReLoadScript), keep the two
-- Thi Luyen Than Su NPCs alive (Trieu Ca + inside map 1084), news before 19:20, and per online
-- player: Tu Linh timer, Huyen Vu 19:20 start / timer / left-the-map / unopened chest.
Include("\\script\\phongthan\\tutuong\\tl_lib.lua")
Include("\\script\\phongthan\\tutuong\\hv_lib.lua")

PTTT_MAX_PLAYER = 1200
PTTT_TPL_SU = 2064
PTTT_NAME_SU = "ThÝ LuyÖn ThÇn Sø"
PTTT_NPC_SCRIPT = "\\script\\phongthan\\tutuong\\hv_npc.lua"
-- { map, x, y } NewWorld units: Trieu Ca beside the Thay tuong so (1717/3129), inside Huyen Vu Than Vuc
-- (1084) at the minimap position of the Thi Luyen Than Su (2026-10-02 questfix: was map 1086)
PTTT_SU_POS = { { 1021, 1723, 3121 }, { 1084, 1211, 2880 } }
PTTT_SCRIPTS = {
	"\\script\\phongthan\\tutuong\\hv_npc.lua",
	"\\script\\phongthan\\tutuong\\hv_mob.lua",
	"\\script\\phongthan\\tutuong\\hv_chest.lua",
	"\\script\\phongthan\\tutuong\\tl_chiakhoa.lua",
	"\\script\\npcdeath\\xuanwu_lv1.lua",
	"\\script\\npcdeath\\xuanwu_lv2.lua",
	"\\script\\npcdeath\\xuanwu_lv3.lua",
	"\\script\\npcdeath\\xuanwu_lv4.lua",
	"\\script\\npcdeath\\xuanwu_lv5.lua",
	"\\script\\npcdeath\\xuanwu_lv6.lua",
	"\\script\\npcdeath\\xuan_wu.lua",
}
if PTTT_SU_IDX == nil then PTTT_SU_IDX = {} end

function PTTT_Register()
	if PTTT_REGISTERED then return end
	local i = 1
	while PTTT_SCRIPTS[i] do
		ReLoadScript(PTTT_SCRIPTS[i])
		i = i + 1
	end
	PTTT_REGISTERED = 1
end

function PTTT_EnsureNpcs()
	local k = 1
	while PTTT_SU_POS[k] do
		local p = PTTT_SU_POS[k]
		local ni = PTTT_SU_IDX[k]
		if not (ni and ni > 0 and GetNpcName(ni) == PTTT_NAME_SU) then
			local sw = SubWorldID2Idx(p[1])
			if sw and sw >= 0 then
				ni = AddNpc(PTTT_TPL_SU, 1, sw, p[2] * 32, p[3] * 32, 0)
				if not ni or ni <= 0 then ni = AddNpc(PTTT_TPL_SU, 1, sw, (p[2] + 4) * 32, p[3] * 32, 0) end
				if ni and ni > 0 then
					SetNpcName(ni, PTTT_NAME_SU)
					SetNpcScript(ni, PTTT_NPC_SCRIPT)
					PTTT_SU_IDX[k] = ni
				end
			end
		end
		k = k + 1
	end
end

function PTTT_News(hhmm)
	local d = PTTT_Today()
	if hhmm >= PTHV_REG_FROM and hhmm < PTHV_START and PTTT_NEWS_REG ~= d then
		PTTT_NEWS_REG = d
		AddGlobalNews("ThÝ LuyÖn ThÇn Sø (TriÒu Ca) ®ang nhËn ®¨ng ký Thö Th¸ch HuyÒn Vò, 19:20 HuyÒn Vò ThÇn Vùc më cöa!")
	end
	if hhmm >= PTHV_START and hhmm <= PTHV_START_LAST and PTTT_NEWS_START ~= d then
		PTTT_NEWS_START = d
		AddGlobalNews("Thö Th¸ch HuyÒn Vò b¾t ®Çu: c¸c hiÖp sÜ ®· ®¨ng ký ®­îc ®­a vµo HuyÒn Vò ThÇn Vùc.")
	end
end

function PTTT_Tick()
	PTTT_Register()
	PTTT_EnsureNpcs()
	local hhmm = PTTT_HHMM()
	PTTT_News(hhmm)
	local i = 1
	while i <= PTTT_MAX_PLAYER do
		PlayerIndex = i
		local nm = GetName()
		if nm and nm ~= "" then
			PTTL_TickPlayer()
			PTHV_TickPlayer(hhmm)
		end
		i = i + 1
	end
	PlayerIndex = nil
end
