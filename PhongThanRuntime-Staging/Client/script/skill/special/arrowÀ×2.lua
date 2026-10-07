function GetSkillLevelData(levelname, data, level)

if (levelname == "lightingdamage_v") then
return Getlightingdamage_v(level)
end;

if (levelname == "lightingenhance_p") then
return Getlightingenhance_p(level)
end;

str1 = ""
return str1
end;

function Param2String(Param1, Param2, Param3)
return Param1..","..Param2..","..Param3
end;

function Getlightingdamage_v(level)
result1 = 100+level*10
result2 = 200+level*40
return Param2String(result1,0,result2)
end;

function Getlightingenhance_p(level)
result = level*5
return Param2String(result,0,0)
end;
