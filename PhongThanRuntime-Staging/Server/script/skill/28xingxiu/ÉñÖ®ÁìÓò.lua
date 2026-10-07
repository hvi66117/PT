function GetSkillLevelData(levelname, data, level)

if (levelname == "staminareplenish_v") then
return Getstaminareplenish_v(level)
end;

if (levelname == "manareplenish_v") then
return Getmanareplenish_v(level)
end;

if (levelname == "allres_p") then
return Getallres_p(level)
end;

str1 = ""
return str1
end;

function Param2String(Param1, Param2, Param3)
return Param1..","..Param2..","..Param3
end;

function Getstaminareplenish_v(level)
result = -10
return Param2String(result,60,0)
end;

function Getmanareplenish_v(level)
result = -10
return Param2String(result,60,0)
end;
function Getallres_p(level)
result = -15
return Param2String(result,60,0)
end;