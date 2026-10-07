 function GetSkillLevelData(levelname, data, level)

if (levelname == "colddamage_v") then
return Getcolddamage_v(level)
end;

str1 = ""
return str1
end;

function Param2String(Param1, Param2, Param3)
return Param1..","..Param2..","..Param3
end;


function Getcolddamage_v(level)
result1 = 15000
result2 = 20000
return Param2String(result1,0,result2)
end;

