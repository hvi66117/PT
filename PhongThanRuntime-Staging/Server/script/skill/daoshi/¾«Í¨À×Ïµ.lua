function GetSkillLevelData(levelname, data, level)

if (levelname == "lightingenhance_p") then
return Getlightingenhance_p(level)
end;

str1 = ""
return str1
end;

function Param2String(Param1, Param2, Param3)
return Param1..","..Param2..","..Param3
end;

function Getlightingenhance_p(level)
result = 10+level*5
return Param2String(result,-1,0)
end;

