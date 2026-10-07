function GetSkillLevelData(levelname, data, level)

	if (levelname == "additionalheal") then
		return Getadditionalheal(level)
	end

	if (levelname == "attackratingenhance_v") then
		return Getattackratingenhance_v(level)
	end;
  if (levelname == "lifereplenish_v") then
		return Getlifereplenish_v(level)
	end;
	if (levelname == "addexdefense_v") then
		return Getaddexdefense_v(level)
	end;

	str1 = ""
	return str1
end;

function Param2String(Param1, Param2, Param3)
	return Param1..","..Param2..","..Param3
end;

function Getadditionalheal(level)
	result = 5+level*5
	return Param2String(result,60,0)
end;

function Getattackratingenhance_v(level)
	result = 25+level*25
	return Param2String(result,60,0)
end;

function Getlifereplenish_v(level)
	result = 5+level*5
	return Param2String(result,60,0)
end;

function Getaddexdefense_v(level)
	result = 20+level*10
	return Param2String(result,60,0)
end;


