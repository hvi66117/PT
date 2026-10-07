SKILL_EXP = {1450,2900,4600,6400,8400,10600,13500,17000,20000,24500,30000, 0}
-- Chóc Dung Ch©n KhÝ
function GetSkillLevelData(levelname, data, level)
	if (levelname == "castspeed_v") then
		return Getcastspeed_v(level)
	end;

	if (levelname == "skill_cost_v") then
		return Getskill_cost_v(level)
	end;
	
	if (levelname == "skill_statetime") then
		return Getskill_statetime(level)
	end;

	if (levelname == "skill_skillexp_v") then
		return Getskill_skillexp_v(level)
	end;

	str1 = ""
	return str1
end;

function Param2String(Param1, Param2, Param3)
	return Param1..","..Param2..","..Param3
end;

function Getcastspeed_v(level)
	result1 = 10+level*1
	result2 = 1500+150*level
	return Param2String(result1,result2,0)
end;


function Getskill_cost_v(level)
	result = 40+level*2
	return Param2String(result,0,0)
end;

function Getskill_statetime(level)
	result = 1500+150*level
	return Param2String(result,0,0)
end;

function Getskill_skillexp_v(level)
	result = SKILL_EXP[level]
	return Param2String(result,0,22)
end;
