function GetSkillLevelData(levelname, data, level)

if (levelname == "addphysicsdamage_p") then
return Getaddphysicsdamage_p(level)
end;

if (levelname == "deadlystrikeenhance_p") then
return Getdeadlystrikeenhance_p(level)
end;

if (levelname == "magic_skill_cost_life_p") then
return Getmagic_skill_cost_life_p(level)
end;

str1 = ""
return str1
end;

function Param2String(Param1, Param2, Param3)
return Param1..","..Param2..","..Param3
end;

function Getaddphysicsdamage_p(level)
result = 33+level*3
return Param2String(result,-1,0)
end;

function Getdeadlystrikeenhance_p(level)
result = 3+level/2
return Param2String(result,-1,0)
end;

function Getmagic_skill_cost_life_p(level)
result = 15
return Param2String(result,-1,0)
end;