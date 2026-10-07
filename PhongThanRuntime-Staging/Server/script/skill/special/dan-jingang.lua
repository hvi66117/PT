function GetSkillLevelData(levelname, data, level)
	if (levelname == "allres_p") then
		return Getallres_p()
	end;

	return ""
end;

function Getallres_p()
	return Param2String(30,5400,0)
end;

function Param2String(Param1, Param2, Param3)
	return Param1..","..Param2..","..Param3
end;

