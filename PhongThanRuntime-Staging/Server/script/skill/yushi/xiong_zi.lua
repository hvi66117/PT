function GetSkillLevelData(levelname, data, level)

if (levelname == "lifemax_v") then
return Getlifemax_v(level)
end;

str1 = ""
return str1
end;

function Param2String(Param1, Param2, Param3)
return Param1..","..Param2..","..Param3
end;

function Getlifemax_v(level)
result = 180+level*20
return Param2String(result,-1,0)
end;
