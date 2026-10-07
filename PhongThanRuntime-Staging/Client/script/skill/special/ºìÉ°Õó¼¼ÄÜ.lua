function GetSkillLevelData(levelname, data, level)

if (levelname == "earthdamage_v") then
return Getearthdamage_v(level)
end;

if (levelname == "skill_cost_v") then
return Getskill_cost_v(level)
end;

if (levelname == "damage_hurt_p") then
return GetHurt_p(level)
end;

str1 = ""
return str1
end;

function Param2String(Param1, Param2, Param3)
return Param1..","..Param2..","..Param3
end;

function Getearthdamage_v(level)
result1 = 1000+500*level
result2 = 1200+520*level
return Param2String(result1,0,result2)
end;


function Getskill_cost_v(level)
result = 0
return Param2String(result,0,0)
end;

function GetHurt_p(level)
return Param2String(100, 18, 0)
end
