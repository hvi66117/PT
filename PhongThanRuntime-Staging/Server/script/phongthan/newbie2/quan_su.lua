-- Phong Than 2026-10-03 (newbie2): "Quan Su (Tan thu)", hub NPC of the new-era newbie chain (taskinfo 3003-3005:
-- Sung Thanh [2,204,200], Ngoc Hu [3,211,195], Xi Vuu [4,195,201]); spawned and bound by ext\newbie2.lua.
-- main: take the chain (Mao Lu), status, report turn-in steps, mat tich turn-in, bi kip shop (Sale 66/67/68).
-- OnTimer (SetNpcTimer, every PTNB2_POLL_SEC s): proximity / level / chest poll of every online player.
Include("\\script\\phongthan\\newbie2\\nb2_lib.lua")

PTNB2_POLL_SEC = 3
PTNB2_QS_SCRIPT = "\\script\\phongthan\\newbie2\\quan_su.lua"

function main(sel)
	local now = GetGameTime()
	PTNB2_ScanNpcs(PTNB2_MAX_NPC)
	PTNB2_Protected(PTNB2_PollPlayer, { now })
	local o = {}
	local qi = GetTask(PTNB2_T_Q)
	if qi == 0 then
		tinsert(o, PTNB2_TXT.opt_start .. "/PTNB2_QsStart")
	else
		tinsert(o, PTNB2_TXT.opt_status .. "/PTNB2_QsStatus")
		tinsert(o, PTNB2_TXT.opt_report .. "/PTNB2_QsReport")
	end
	tinsert(o, PTNB2_TXT.opt_scroll .. "/PTNB2_QsScroll")
	tinsert(o, PTNB2_TXT.opt_book .. "/PTNB2_QsBook")
	tinsert(o, PTNB2_TXT.opt_info .. "/PTNB2_QsInfo")
	tinsert(o, PTNB2_TXT.opt_exit .. "/no")
	local n = getn(o)
	if n == 6 then
		Say(PTNB2_TXT.qs_hello, n, o[1], o[2], o[3], o[4], o[5], o[6])
	else
		Say(PTNB2_TXT.qs_hello, n, o[1], o[2], o[3], o[4], o[5])
	end
end

function PTNB2_QsStart()
	if PTNB2_Start() ~= 1 then
		Talk(1, "no", PTNB2_TXT.not_started)
	end
end

function PTNB2_QsStatus()
	local q, s, st, qi = PTNB2_Cur()
	if q == nil then
		if GetTask(PTNB2_T_Q) > 0 then Talk(1, "no", PTNB2_TXT.done_all) else Talk(1, "no", PTNB2_TXT.not_started) end
		return
	end
	if s == 0 then
		Talk(1, "no", PTNB2_TXT.status_none .. PTNB2_Title(q.id) .. ". " .. PTNB2_TXT.wait_lv .. q.lv .. ".")
		return
	end
	PTNB2_StepNote(q, s)
	Talk(1, "no", PTNB2_TXT.status_none .. PTNB2_Title(q.id) .. ": " .. PTNB2_StatusText(q, s))
end

function PTNB2_QsReport()
	if PTNB2_Report() ~= 1 then
		Talk(1, "no", PTNB2_TXT.no_report)
	end
end

function PTNB2_QsScroll()
	if PTNB2_ScrollTurnin(1) <= 0 then
		Talk(1, "no", PTNB2_TXT.sc_none)
	end
end

function PTNB2_QsBook()
	local p = PTNB2_Prof()
	if p == nil then return end
	CloseDialog()
	Sale(66 + p)
end

function PTNB2_QsInfo()
	Talk(1, "no", PTNB2_TXT.info)
end

function no()
	CloseDialog()
end

-- NPC timer: one poll every PTNB2_POLL_SEC seconds for all three Quan Su (same script state)
function OnTimer(npc)
	local now = GetGameTime()
	if PTNB2_LASTPOLL == nil or now < PTNB2_LASTPOLL or now - PTNB2_LASTPOLL >= (PTNB2_POLL_SEC - 1) * 18 then
		PTNB2_LASTPOLL = now
		call(PTNB2_ScanNpcs, { 8000 }, "x", PTNB2_Err)
		PTNB2_PollAll()
	end
	SetNpcTimer(npc, PTNB2_QS_SCRIPT, PTNB2_POLL_SEC)
end
