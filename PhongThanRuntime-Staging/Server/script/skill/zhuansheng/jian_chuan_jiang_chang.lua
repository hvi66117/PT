function GetSkillLevelData(levelname, data, level)

if (levelname == "enhance_life_rate_damage") then
return Getenhance_life_rate_damage(level)
end;

if (levelname == "attackspeed_v") then
return Getattackspeed_v(level)
end;


str1 = ""
return str1
end;

function Param2String(Param1, Param2, Param3)
return Param1..","..Param2..","..Param3
end;

function Getenhance_life_rate_damage(level)
result = 1*level
return Param2String(result,-1,0)
end;

function Getattackspeed_v(level)
result = 2*level
return Param2String(result,-1,0)
end;

