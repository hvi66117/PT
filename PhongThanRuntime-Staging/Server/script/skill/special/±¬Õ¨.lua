function GetSkillLevelData(levelname, data, level)

if (levelname == "life_v") then
return Getlife_v(level)
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

function Getlife_v(level)
result = -3000
return Param2String(result,0,0)
end;

function GetStun_p(level)
return Param2String(100, 120, 0)
end
