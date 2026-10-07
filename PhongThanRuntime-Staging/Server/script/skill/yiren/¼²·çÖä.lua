function GetSkillLevelData(levelname, data, level)

if (levelname == "attackspeed_v") then
return Getattackspeed_v(level)
end;

if (levelname == "castspeed_v") then
return Getcastspeed_v(level)
end;

str1 = ""
return str1
end;

function Param2String(Param1, Param2, Param3)
return Param1..","..Param2..","..Param3
end;

function Getattackspeed_v(level)
result = 10+level*1
return Param2String(result,60,0)
end;

function Getcastspeed_v(level)
result = 10+level*1
return Param2String(result,60,0)
end;