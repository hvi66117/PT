 function GetSkillLevelData(levelname, data, level)

if (levelname == "colddamage_v") then
return Getcolddamage_v(level)
end;


if (levelname == "attackrating_v") then
return Getattackrating_v(level)
end;


str1 = ""
return str1
end;

function Param2String(Param1, Param2, Param3)
return Param1..","..Param2..","..Param3
end;


function Getcolddamage_v(level)
result1 = 200+level*20
result2 = 300+level*30
return Param2String(result1,0,result2)
end;

function Getattackrating_v(level)
result1 = 1500

return Param2String(result1,0,0)
end;