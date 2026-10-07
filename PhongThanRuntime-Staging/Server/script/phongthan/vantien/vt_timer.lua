-- Phong Than 2026-10-02: Van Tien tran minute tick. Hook (servertimer.lua, once a minute):
--   function PTAdm_VtTick()
--     if not PTVT_Tick then dofile("script\\phongthan\\vantien\\vt_timer.lua") end
--     if PTVT_Tick then PTVT_Tick() end
--   end
-- (called from PTAdm_Tick after PTAdm_WbTick)
-- Jobs: register the scripts once (loose + the 8 VNG trap scripts of the Huyen maps), keep Thien Hung
-- in Tay Ky, open the 4 tran at the VNG hours, repair stale states and sweep players (logout inside,
-- leftover flags).
Include("\\script\\phongthan\\vantien\\vt_lib.lua")

PTVT_SCRIPTS = {
	"\\script\\phongthan\\vantien\\vt_thienhung.lua",
	"\\script\\phongthan\\vantien\\vt_daiphu.lua",
	"\\script\\phongthan\\vantien\\vt_boss.lua",
	"\\script\\phongthan\\vantien\\vt_chest.lua",
	"\\script\\phongthan\\vantien\\vt_mob.lua",
	"\\script\\missions\\mission01.lua",
	"\\script\\missions\\mission02.lua",
	"\\script\\missions\\mission03.lua",
	"\\script\\missions\\mission04.lua",
	"\\script\\timertask\\task01.lua",
	"\\script\\timertask\\task02.lua",
	"\\script\\timertask\\task03.lua",
	"\\script\\timertask\\task04.lua",
	"\\script\\timertask\\task05.lua",
	"\\script\\timertask\\task06.lua",
	"\\script\\timertask\\task07.lua",
	"\\script\\timertask\\task08.lua",
	"\\script\\timertask\\task09.lua",
}

function PTVT_Register()
	local k = 1
	while PTVT_SCRIPTS[k] do
		ReLoadScript(PTVT_SCRIPTS[k])
		k = k + 1
	end
	k = 1
	while PTVT_TRAP_SCRIPTS[k] do
		ReLoadScript(PTVT_TRAP_SCRIPTS[k])
		k = k + 1
	end
end

function PTVT_EnsureThienHung()
	local ni = PTVT_TH_NI
	if ni and ni > 0 and GetNpcName(ni) == PTVT_TH_NAME then
		local w = GetNpcPos(ni)
		if w == PTVT_TH[1] then
			if GetNpcTemplateID(ni) == PTVT_TH[4] then return ni end
			-- 2026-10-02 (vantien2): template changed (old gate look 247) -> replace the NPC
			DelNpc(ni)
		end
	end
	local sw = SubWorldID2Idx(PTVT_TH[1])
	if not sw or sw < 0 then return 0 end
	ni = AddNpc(PTVT_TH[4], 1, sw, PTVT_TH[2], PTVT_TH[3], 0)
	if ni and ni > 0 then
		SetNpcName(ni, PTVT_TH_NAME)
		SetNpcScript(ni, PTVT_TH_SCRIPT)
		PTVT_TH_NI = ni
		return ni
	end
	return 0
end

-- coordinator 2026-10-03: a second Thien Hung in Trieu Ca (user request), next to the Thai Tue Su square
PTVT_TH2 = {1021, 55216, 96608, 202}
function PTVT_EnsureThienHung2()
	local ni = PTVT_TH2_NI
	if ni and ni > 0 and GetNpcName(ni) == PTVT_TH_NAME and GetNpcPos(ni) == PTVT_TH2[1] then return ni end
	local sw = SubWorldID2Idx(PTVT_TH2[1])
	if not sw or sw < 0 then return 0 end
	ni = AddNpc(PTVT_TH2[4], 1, sw, PTVT_TH2[2], PTVT_TH2[3], 0)
	if ni and ni > 0 then
		SetNpcName(ni, PTVT_TH_NAME)
		SetNpcScript(ni, PTVT_TH_SCRIPT)
		PTVT_TH2_NI = ni
		return ni
	end
	return 0
end

function PTVT_Schedule(hm)
	local h = 1
	while PTVT_SCHED[h] do
		local base = tonumber(strsub(PTVT_SCHED[h], 1, 2)) * 60 + tonumber(strsub(PTVT_SCHED[h], 4, 5))
		local n = 1
		while n <= 4 do
			local m = base + PTVT_SCHED_OFFSET[n]
			local slot = format("%02d:%02d", floor(m / 60), mod(m, 60))
			if slot == hm and PTVT_IsOpen(n) == 0 then
				if PTVT_Open(n, PTVT_PREP_SCHED) == 1 then
					AddGlobalNews("V\185n Ti\170n tr\203n (" .. PTVT_NAME[n] .. ") m\235 theo gi\234, " .. floor(PTVT_PREP_SCHED / 60) .. " ph\243t n\247a b\190t \174\199u. G\198p Thi\170n H\239ng \235 T\169y K\250 \174\211 v\181o tr\203n.")
				end
			end
			n = n + 1
		end
		h = h + 1
	end
end

-- players: back to Tay Ky when standing in a closed tran; re-registered after a relog inside an open
-- tran; logout-revive flag cleared once they are outside.
function PTVT_Sweep()
	local inside = {}
	local open = {}
	local n = 1
	while n <= 4 do
		open[n] = PTVT_IsOpen(n)
		if open[n] == 1 then
			if PTVT_GV(n, 0) == 0 then PTVT_SetGV(n, 0, 1) end
			local l = PTVT_Inside(n)
			local s = {}
			local i = 1
			while l[i] do
				s[l[i]] = 1
				i = i + 1
			end
			inside[n] = s
		else
			if PTVT_GV(n, 0) ~= 0 then PTVT_SetGV(n, 0, 0) end
			inside[n] = {}
		end
		n = n + 1
	end
	local moved = 0
	local i = 1
	while i <= PTVT_MAX_PLAYER do
		PlayerIndex = i
		local nm = GetName()
		if nm and nm ~= "" then
			local w = GetWorldPos()
			local t = PTVT_MapToN(w)
			if t then
				if open[t] ~= 1 then
					Msg2Player("V\185n Ti\170n tr\203n (" .. PTVT_NAME[t] .. ") \174\183 \174\227ng, \174\173a v\210 T\169y K\250.")
					PTVT_ToTown()
					moved = moved + 1
				elseif not inside[t][i] then
					PTVT_UseWorld(t)
					AddMSPlayer(t, 1)
					PlayerIndex = i
					SetLogoutRV(1)
					SetTask(PTVT_T_INMAP, w)
					if PTVT_GV(t, 0) >= 2 then SetFightState(1) else SetFightState(0) end
					inside[t][i] = 1
				end
			elseif GetTask(PTVT_T_INMAP) ~= 0 then
				SetTask(PTVT_T_INMAP, 0)
				SetLogoutRV(0)
				PTVT_ClearTokens()
			end
		end
		i = i + 1
	end
	PlayerIndex = nil
	return moved
end

function PTVT_Tick()
	local oldSubWorld = SubWorld
	if not PTVT_REGISTERED then
		PTVT_Register()
		PTVT_REGISTERED = 1
	end
	PTVT_EnsureThienHung()
	PTVT_EnsureThienHung2()
	PTVT_Schedule(date("%H:%M"))
	PTVT_Sweep()
	PTVT_WriteStatus()
	PlayerIndex = nil
	SubWorld = oldSubWorld
end

-- 2026-10-02 (vantien2): status for the web admin, admin_bridge\vantien.txt (only in the servertimer
-- state, where PTADM_DIR is defined). Line 1 = time, then per tran:
--   n, state (0 closed, 1 preparation, 2 fighting, 3 cleared), kill mask, players inside, seconds left, session key
function PTVT_WriteStatus()
	if not PTADM_DIR then return 0 end
	local out = ""
	local n = 1
	while n <= 4 do
		local st = 0
		local inside = 0
		local rest = 0
		if PTVT_IsOpen(n) == 1 then
			st = PTVT_GV(n, 0)
			inside = getn(PTVT_Inside(n))
			rest = PTVT_RestSeconds(n)
		end
		out = out .. n .. "\t" .. st .. "\t" .. PTVT_GV(n, 1) .. "\t" .. inside .. "\t" .. rest .. "\t" .. PTVT_GV(n, 2) .. "\n"
		n = n + 1
	end
	PlayerIndex = nil
	local f = openfile(PTADM_DIR .. "vantien.tmp", "w")
	if not f then return 0 end
	write(f, date("%Y-%m-%d %H:%M:%S") .. "\n" .. out)
	closefile(f)
	remove(PTADM_DIR .. "vantien.txt")
	rename(PTADM_DIR .. "vantien.tmp", PTADM_DIR .. "vantien.txt")
	return 1
end

-- admin helper (web admin "Mo Van Tien tran", bridge pending.lua): open tran n now with the scheduled
-- preparation time. Returns 1 opened, 2 already open, 0 failed (bad n / map not loaded), -1 bad n.
function PTVT_AdminOpen(n, prep)
	n = tonumber(n)
	if not n or not PTVT_D[n] then return -1 end
	local oldSubWorld = SubWorld
	local oldPlayer = PlayerIndex
	if not prep or prep < 5 then prep = PTVT_PREP_SCHED end
	local r = PTVT_Open(n, prep)
	if r == 1 then
		AddGlobalNews("V\185n Ti\170n tr\203n (" .. PTVT_NAME[n] .. ") \174\183 \174\173\238c m\235, " .. floor(prep / 60) .. " ph\243t n\247a b\190t \174\199u. G\198p Thi\170n H\239ng \235 T\169y K\250 \174\211 v\181o tr\203n.")
	end
	PTVT_WriteStatus()
	PlayerIndex = oldPlayer
	SubWorld = oldSubWorld
	return r
end
