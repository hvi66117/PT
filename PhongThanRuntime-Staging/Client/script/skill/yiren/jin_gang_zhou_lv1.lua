function GetSkillLevelData(levelname, data, level)

if (levelname == "addexdefense_v") then
return Getaddexdefense_v(level)
end;

if (levelname == "allres_p") then
return Getallres_p(level)
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

function Getaddexdefense_v(level)
result = 7+level*3
return Param2String(result,60,0)
end;

function Getallres_p(level)
result = 2
return Param2String(result,60,0)
end;

function Getfasthitrecover_v(level)
result = 3
return Param2String(result,60,0)
end;