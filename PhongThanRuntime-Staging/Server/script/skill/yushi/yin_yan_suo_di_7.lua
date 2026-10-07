function GetSkillLevelData(levelname, data, level)

if (levelname == "deadlystrikeenhance_p") then
return Getdeadlystrikeenhance_p(level)
end;

if (levelname == "attackratingenhance_p") then
return Getattackratingenhance_p(level)
end;

if (levelname == "addcolddamage_v") then
return Getcolddamage_v(level)
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
result = 12+level*0
return Param2String(result,-1,0)
end;

function Getcolddamage_v(level)
result = 15+level*0
return Param2String(result,-1,0)
end;
