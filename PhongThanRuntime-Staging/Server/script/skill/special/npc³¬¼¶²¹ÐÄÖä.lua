function GetSkillLevelData(levelname, data, level)

if (levelname == "lifepotion_v") then
return Getlifepotion_v(level)
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

function Getlifepotion_v(level)
result = level*6000
return Param2String(result,10,0)
end;

function Getskill_cost_v(level)
result = 1+level*1
return Param2String(result,0,0)
end;

