-- Phong Than 2026-10-02: Van Tien tran mission 4 (map 1082, Huyen). Replaces the VLTK copy
-- (Tong Kim / Lien Dau / Vuot Ai, backup in _backup\20261002-vantien). The engine calls
-- \script\missions\mission%02d.lua for OpenMission / RunMission / CloseMission and OnLeave.
Include("\\script\\phongthan\\vantien\\vt_lib.lua")

function InitMission(id)
	PTVT_InitMission(4)
end

function RunMission(id)
	PTVT_RunMission(4)
end

function EndMission(id)
	PTVT_EndMission(4)
end

function OnLeave(roleIndex)
	PTVT_OnLeave(4, roleIndex)
end
