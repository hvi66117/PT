function GetSkillLevelData(levelname, data, level)

if (levelname == "lifepotion_v") then
return Getlifepotion_v(level)
end;

if (levelname == "lifereplenish_v") then
return Getlifereplenish_v(level)
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
result = 100+level*20
return Param2String(result,10,0)
end;

function Getlifereplenish_v(level)
result = 20+level*4
return Param2String(result,900,0)
end;

function Getskill_cost_v(level)
result = 20+level
return Param2String(result,0,0)
end;

