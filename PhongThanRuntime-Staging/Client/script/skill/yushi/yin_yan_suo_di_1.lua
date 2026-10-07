function GetSkillLevelData(levelname, data, level)

if (levelname == "deadlystrikeenhance_p") then
return Getdeadlystrikeenhance_p(level)
end;

if (levelname == "attackratingenhance_p") then
return Getattackratingenhance_p(level)
end;

str1 = ""
return str1
end;

function Param2String(Param1, Param2, Param3)
return Param1..","..Param2..","..Param3
end;

function Getdeadlystrikeenhance_p(level)
result = math.floor(1+level/3*1)
return Param2String(result,-1,0)
end;

function Getattackratingenhance_p(level)
result = 6+level*0
return Param2String(result,-1,0)
end;
