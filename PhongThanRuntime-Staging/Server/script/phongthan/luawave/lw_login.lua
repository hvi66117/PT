-- Phong Than 2026-10-05 (luawave #1): what the login hook does. No main() here: dofile'd at call time into the
-- state of script\player\playerlogin.lua / playerlogout.lua (each engine script has its own Lua state, so the
-- libraries below are loaded once per state). Current PlayerIndex = the player that logs in.
-- The same libraries keep their minute ticks in servertimer.lua; at login the player gets the same work at once:
--  1. daily login gift: content\dg_lib.lua PTDG_Player (counts the day, delivers queued gifts);
--  2. tokens: newbie\starter_gear.lua (starter weapon + horse, task 1950), item\luyencong_give.lua (Lenh Bai
--     Luyen Cong, task 2610), item\nhiemvu_give.lua (Lenh Bai Nhiem Vu / Tiep Te, tasks 2611 / 2612);
--  3. item\lbdaosi_lib.lua PTLB_TickOne: admin sets waiting in admin_bridge\lbdaosi_pending.txt, profession
--     tokens, tasks 2613 / 2614 / 2619 / 2617 sent to the client (the file is re-read here; ext\luawave.lua makes
--     the servertimer copy re-read it every minute, so a set applied here is not applied twice);
--  4. item\hanhtrang_lib.lua PTHT_SyncAll: pickup filter 2640, clock 2645 and the IB buff tasks sent to the client;
--  5. one line in admin_bridge\login.log.
-- Each step runs under call(): an error is logged in admin_bridge\login_error.log and the next step still runs.
-- ASCII only.

PTLW_LOGFILE = "admin_bridge\\login.log"
PTLW_ERRFILE = "admin_bridge\\login_error.log"

function PTLW_Err(m)
	local h = openfile(PTLW_ERRFILE, "a")
	if h then
		write(h, date("%Y-%m-%d %H:%M:%S ") .. "lw " .. tostring(m) .. "\n")
		closefile(h)
	end
end

function PTLW_Safe(fn)
	if fn then call(fn, {}, "x", PTLW_Err) end
end

function PTLW_Line(what)
	local h = openfile(PTLW_LOGFILE, "a")
	if not h then return end
	local w, x, y = GetWorldPos()
	local tl = 0
	if GetTranslife then tl = GetTranslife() or 0 end
	write(h, date("%Y-%m-%d %H:%M:%S ") .. what .. " " .. tostring(GetName()) .. " acc=" .. tostring(GetAccount()) ..
		" lv=" .. tostring(GetLevel()) .. " tl=" .. tl .. " map=" .. tostring(w) .. " " .. tostring(x) .. "," .. tostring(y) .. "\n")
	closefile(h)
end

function PTLW_LogIn() PTLW_Line("login") end
function PTLW_LogOut() PTLW_Line("logout") end
function PTLW_LogOff() PTLW_Line("offline") end

-- 1. daily login gift
function PTLW_Gift()
	if not PTDG_Player then dofile("script\\phongthan\\content\\dg_lib.lua") end
	PTDG_LoadCfg()
	if PTDG_CFG and PTDG_CFG.enabled == 1 then
		PTDG_TICKS = (PTDG_TICKS or 0) + 30
		PTDG_Player(tonumber(date("%Y%m%d")), GetName())
	end
end

-- 2. starter gear + Luyen Cong / Nhiem Vu tokens (same rules as the minute ticks)
function PTLW_Starter()
	if not PTNB_GivePlayer then dofile("script\\phongthan\\newbie\\starter_gear.lua") end
	if GetTask(PTNB_TASK) == 0 then
		if GetLevel() <= PTNB_MAXLV then
			PTNB_GivePlayer(GetName())
		else
			SetTask(PTNB_TASK, 2)
		end
	end
end

function PTLW_LuyenCong()
	if not PTLC_GiveOne then dofile("script\\phongthan\\item\\luyencong_give.lua") end
	PTLC_GiveOne()
end

function PTLW_NhiemVu()
	if not PTNV_GiveOneToken then dofile("script\\phongthan\\item\\nhiemvu_give.lua") end
	PTNV_GiveOneToken(1)
	PTNV_GiveOneToken(2)
end

-- 3. Lenh Bai Dao Si / Giap Si / Di Nhan: pending admin set, token, client task sync
function PTLW_Lbdaosi()
	if not PTLB_TickOne then dofile("script\\phongthan\\item\\lbdaosi_lib.lua") end
	PTLB_Load()
	PTLB_PEND = nil
	PTLB_LoadPend()
	PTLB_TickOne(GetName())
end

-- 4. Lenh Bai Hanh Trang: client task sync only (pickup filter, clock, IB buff bar)
function PTLW_Hanhtrang()
	if not PTHT_SyncAll then dofile("script\\phongthan\\item\\hanhtrang_lib.lua") end
	PTHT_SyncAll()
end

function PTLW_Login()
	PTLW_Safe(PTLW_LogIn)
	PTLW_Safe(PTLW_Starter)
	PTLW_Safe(PTLW_LuyenCong)
	PTLW_Safe(PTLW_NhiemVu)
	PTLW_Safe(PTLW_Lbdaosi)
	PTLW_Safe(PTLW_Hanhtrang)
	PTLW_Safe(PTLW_Gift)
end

function PTLW_Logout()
	PTLW_Safe(PTLW_LogOut)
end

function PTLW_Offline()
	PTLW_Safe(PTLW_LogOff)
end
