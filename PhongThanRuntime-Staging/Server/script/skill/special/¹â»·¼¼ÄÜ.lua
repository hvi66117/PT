function GetSkillLevelData(levelname, data, level)

	if (levelname == "magicdamage_v") then
		return Getmagicdamage_v(level)
	end

if (levelname == "attackspeed_v") then
	return attackspeed_v(level)
end;


str1 = ""
return str1
end;

function Param2String(Param1, Param2, Param3)
return Param1..","..Param2..","..Param3
end;

function Getmagicdamage_v(level)
	result1 = 30
	result2 = 40
	return Param2String(result1,0,result2)
end;

function attackspeed_v(level)
	result = -20 * level
	return Param2String(result,54,0)
end;

