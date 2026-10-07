function GetSkillLevelData(levelname, data, level)

if (levelname == "physicsdamage_v") then
return Getphysicsdamage_v(level)
end;

str1 = ""
return str1
end;

function Param2String(Param1, Param2, Param3)
return Param1..","..Param2..","..Param3
end;

-- π•¥Ú≥«√≈
function Getphysicsdamage_v(level)
result1 = level*20000
result2 = level*40000
return Param2String(result1,0,result2)
end;
