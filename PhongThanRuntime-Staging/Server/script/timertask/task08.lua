-- Phong Than 2026-10-02: Van Tien tran 3, mission timer 8 = start (end of preparation -> RunMission).
-- The engine calls \script\timertask\task%02d.lua:OnMissionTimer(timerId) with SubWorld set.
Include("\\script\\phongthan\\vantien\\vt_lib.lua")

function OnMissionTimer(timerId)
	PTVT_OnStartTimer(3, timerId)
end

function OnTimer()
	StopTimer()
end
