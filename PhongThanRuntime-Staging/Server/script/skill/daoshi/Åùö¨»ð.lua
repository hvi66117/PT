function GetSkillLevelData(levelname, data, level)

if (levelname == "firedamage_v") then
return Getfiredamage_v(level)
end;

if (levelname == "castspeed_p") then
return Getcastspeed_p(level)
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
result1 = 15+level*14
result2 = 30+level*18
return Param2String(result1,0,result2)
end;

function Getcastspeed_p(level)
result1 = -20
return Param2String(result1,0,0)
end;


function Getskill_cost_v(level)
result = 4+level/2
return Param2String(result,0,0)
end;
