function GetSkillLevelData(levelname, data, level)
	if (levelname == "physicsdamage_v") then
		return Getphysicsdamage_v()
	end;

        if (levelname == "exdefense_v") then
		return Getexdefense_v()
	end;

	return ""
end;

function Getphysicsdamage_v()
	return Param2String(100,5400,0)
end;

function Getexdefense_v()
	return Param2String(100,5400,0)
end;

function Param2String(Param1, Param2, Param3)
	return Param1..","..Param2..","..Param3
end;

