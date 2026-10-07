function GetSkillLevelData(levelname, data, level)

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

function Getearthdamage_v(level)
result1 = 20+level*6
result2 = 60+level*12
return Param2String(result1,0,result2)
end;

function Getskill_cost_v(level)
result = 2+level/3
return Param2String(result,0,0)
end;

