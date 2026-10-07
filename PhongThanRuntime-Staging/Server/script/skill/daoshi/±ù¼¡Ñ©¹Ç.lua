function GetSkillLevelData(levelname, data, level)

if (levelname == "manashield_p") then
return Getmanashield_p(level)
end;

if (levelname == "adddefence_v") then
return Getadddefence_v(level)
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

function Getmanashield_p(level)
result1 = 15+level*3
result2 = 1500+150*level
return Param2String(result1,result2,0)
end;


function Getadddefence_v(level)
result1 = 50+level*5
result2 = 1500+150*level
return Param2String(result1,result2,0)
end;

function Getskill_cost_v(level)
result = 30+level*3
return Param2String(result,0,0)
end;
