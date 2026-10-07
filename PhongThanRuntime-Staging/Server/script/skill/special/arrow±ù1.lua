function GetSkillLevelData(levelname, data, level)

if (levelname == "physicsdamage_v") then
return Getphysicsdamage_v(level)
end;

if (levelname == "coldenhance_p") then
return Getcoldenhance_p(level)
end;

str1 = ""
return str1
end;

function Param2String(Param1, Param2, Param3)
return Param1..","..Param2..","..Param3
end;

function Getphysicsdamage_v(level)
result1 = 250+level*10
result2 = 400+level*20
return Param2String(result1,0,result2)
end;

function Getcoldenhance_p(level)
result = level*5
return Param2String(result,0,0)
end;
