function GetSkillLevelData(levelname, data, level)

if (levelname == "freezetimereduce_p") then
return Getfreezetimereduce_p(level)
end;

if (levelname == "fasthitrecover_v") then
return Getfasthitrecover_v(level)
end;

str1 = ""
return str1
end;

function Param2String(Param1, Param2, Param3)
return Param1..","..Param2..","..Param3
end;

function Getfreezetimereduce_p(level)
result = 7+level*3
return Param2String(result,60,0)
end;

function Getfasthitrecover_v(level)
result = 7+level*3
return Param2String(result,60,0)
end;