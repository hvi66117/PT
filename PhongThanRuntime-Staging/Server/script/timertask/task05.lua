-- Phong Than 2026-10-02: Van Tien tran 4, mission timer 5 = end (fight time over -> CloseMission).
-- The engine calls \script\timertask\task%02d.lua:OnMissionTimer(timerId) with SubWorld set.
Include("\\script\\phongthan\\vantien\\vt_lib.lua")

function OnMissionTimer(timerId)
	PTVT_OnEndTimer(4, timerId)
end

function OnTimer()
	StopTimer()
end
