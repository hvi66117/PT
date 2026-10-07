function GetSkillLevelData(levelname, data, level)

if (levelname == "earthdamage_v") then
return Getearthdamage_v(level)
end;

if (levelname == "earthres_p") then
return Getearthres_p(level)
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
result1 = floor((120+level*15)*1.18)
result2 = floor((180+level*20)*1.18)
return Param2String(result1,0,result2)
end;

function Getearthres_p(level)
result1 = -30
result2 = 180
return Param2String(result1,result2,0)
end;

function Getskill_cost_v(level)
result = 12+level
return Param2String(result,0,0)
end;
