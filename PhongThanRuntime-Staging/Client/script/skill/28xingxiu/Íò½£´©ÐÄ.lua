function GetSkillLevelData(levelname, data, level)

if (levelname == "earthdamage_v") then
return Getearthdamage_v(level)
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
result1 = 500
result2 = 500
return Param2String(result1,0,result2)
end;

function GetHurt_p(level)
return Param2String(100, 54, 0)
end
