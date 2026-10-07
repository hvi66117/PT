function GetSkillLevelData(levelname, data, level)

if (levelname == "colddamage_v") then
return Getcolddamage_v(level)
end;

if (levelname == "damage_freeze_p") then
return GetFreeze_p(level)
end;

str1 = ""
return str1
end;

function Param2String(Param1, Param2, Param3)
return Param1..","..Param2..","..Param3
end;

function Getcolddamage_v(level)
result1 = 500
result2 = 500
return Param2String(result1,0,result2)
end;

function GetFreeze_p(level)
return Param2String(100, 54, 0)
end
