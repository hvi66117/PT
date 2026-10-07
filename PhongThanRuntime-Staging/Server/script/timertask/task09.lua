-- Phong Than 2026-10-02: Van Tien tran 4, mission timer 9 = start (end of preparation -> RunMission).
-- The engine calls \script\timertask\task%02d.lua:OnMissionTimer(timerId) with SubWorld set.
Include("\\script\\phongthan\\vantien\\vt_lib.lua")

function OnMissionTimer(timerId)
	PTVT_OnStartTimer(4, timerId)
end

function OnTimer()
	StopTimer()
end
