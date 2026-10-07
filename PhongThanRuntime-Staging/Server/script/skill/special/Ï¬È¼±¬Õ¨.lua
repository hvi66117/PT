function GetSkillLevelData(levelname, data, level)

	if (levelname == "firedamage_v") then
		return Getfiredamage_v(level)
	end;

	if (levelname == "earthdamage_v") then
		return Getearthdamage_v(level)
	end;

	if (levelname == "skill_cost_v") then
		return Getskill_cost_v(level)
	end;

	str1 = ""

	return str1
end;

function Param2String(Param1, Param2, Param3)
	return Param1..","..Param2..","..Param3
end;

function Getfiredamage_v(level)
	result1 = 500
	result2 = 750

	return Param2String(result1,0,result2)
end;

function Getearthdamage_v(level)
	result1 = 3000
	result2 = 3000

	return Param2String(result1,0,result2)
end;

function Getskill_cost_v(level)
	result = 0

	return Param2String(result,0,0)
end;