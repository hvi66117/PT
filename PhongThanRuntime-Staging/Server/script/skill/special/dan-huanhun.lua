function GetSkillLevelData(levelname, data, level)
	if (levelname == "life_v") then
		return Getlife_v()
	end;

        if (levelname == "mana_v") then
		return Getmana_v()
	end;

	return ""
end;

function Getlife_v()
	return Param2String(9999,1,0)
end;

function Getmana_v()
	return Param2String(9999,1,0)
end;

function Param2String(Param1, Param2, Param3)
	return Param1..","..Param2..","..Param3
end;

