function GetSkillLevelData(levelname, data, level)

if (levelname == "physicsenhance_p") then
return Getphysicsenhance_p(level)
end;

if (levelname == "deadlystrike_p") then
return Getdeadlystrike_p(level)
end;

if (levelname == "skill_costtype_v") then
return Getskill_costtype_v(level)
end;


if (levelname == "skill_cost_v") then
return Getskill_cost_v(level)
end;

str1 = ""
return str1
end;

function Param2String(Param1, Param2, Param3)
return Param1..","..Param2..","..Param3
end;

function Getphysicsenhance_p(level)
result = 31+4*level
return Param2String(result,0,0)
end;

function Getdeadlystrike_p(level)
result = 9+level
return Param2String(result,0,0)
end;

function Getskill_costtype_v(level)
result = 2
return Param2String(result,0,0)
end;

function Getskill_cost_v(level)
result = 1+level/3
return Param2String(result,0,0)
end;

