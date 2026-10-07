-- Phong Than 2026-10-02: Van Tien tran mission 1 (map 1079, Huyen). Replaces the VLTK copy
-- (Tong Kim / Lien Dau / Vuot Ai, backup in _backup\20261002-vantien). The engine calls
-- \script\missions\mission%02d.lua for OpenMission / RunMission / CloseMission and OnLeave.
Include("\\script\\phongthan\\vantien\\vt_lib.lua")

function InitMission(id)
	PTVT_InitMission(1)
end

function RunMission(id)
	PTVT_RunMission(1)
end

function EndMission(id)
	PTVT_EndMission(1)
end

function OnLeave(roleIndex)
	PTVT_OnLeave(1, roleIndex)
end
