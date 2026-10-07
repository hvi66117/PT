function GetSkillLevelData(levelname, data, level)

if (levelname == "addphysicsdamage_p") then
return Getaddphysicsdamage_p(level)
end;

if (levelname == "ignoreexdefence") then
return Getignoreexdefence(level)
end;

str1 = ""
return str1
end;

function Param2String(Param1, Param2, Param3)
return Param1..","..Param2..","..Param3
end;

function Getaddphysicsdamage_p(level)
result = 27+level*3
return Param2String(result,-1,0)
end;

function Getignoreexdefence(level)
result = 110+level*0
return Param2String(result,-1,0)
end;
