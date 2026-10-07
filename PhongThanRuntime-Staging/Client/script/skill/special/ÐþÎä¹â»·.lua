function GetSkillLevelData(levelname, data, level)

if (levelname == "lifemax_p") then
return Getlifemax_p(level)
end;

if (levelname == "allres_p") then
return Getallres_p(level)
end;


if (levelname == "manareplenish_v") then
return Getmanareplenish_v(level)
end;

str1 = ""
return str1
end;

function Param2String(Param1, Param2, Param3)
return Param1..","..Param2..","..Param3
end;

function Getlifemax_p(level)
result = -25
return Param2String(result,60,0)
end;

function Getallres_p(level)
result = -25
return Param2String(result,60,0)
end;

function Getmanareplenish_v(level)
result = -30
return Param2String(result,18,0)
end;