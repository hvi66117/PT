function GetSkillLevelData(levelname, data, level)

if (levelname == "lightingdamage_v") then
return Getlightingdamage_v(level)
end;

if (levelname == "damage_stun_p") then
return GetStun_p(level)
end;

str1 = ""
return str1
end;

function Param2String(Param1, Param2, Param3)
return Param1..","..Param2..","..Param3
end;

function Getlightingdamage_v(level)
result1 = 500
result2 = 500
return Param2String(result1,0,result2)
end;

function GetStun_p(level)
return Param2String(100, 54, 0)
end
