function GetSkillLevelData(levelname, data, level)

if (levelname == "addphysicsdamage_v") then
return Getaddphysicsdamage_v(level)
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

function Getaddphysicsdamage_v(level)
result1 = -(20+level*5)
result2 = 72+18*level
return Param2String(result1,result2,0)
end;

function Getskill_cost_v(level)
result = 12+level*2
return Param2String(result,0,0)
end;

