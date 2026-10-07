function GetSkillLevelData(levelname, data, level)

if (levelname == "firedamage_v") then
return Getfiredamage_v(level)
end;

if (levelname == "skill_cost_v") then
return Getskill_cost_v(level)
end;

if (levelname == "damage_confuse_p") then
return GetConfuse_p(level)
end;

str1 = ""
return str1
end;

function Param2String(Param1, Param2, Param3)
return Param1..","..Param2..","..Param3
end;

function Getfiredamage_v(level)
result1 = 500
result2 = 500
return Param2String(result1,0,result2)
end;


function Getskill_cost_v(level)
result = 0
return Param2String(result,0,0)
end;

function GetConfuse_p(level)
return Param2String(100, 18, 0)
end
