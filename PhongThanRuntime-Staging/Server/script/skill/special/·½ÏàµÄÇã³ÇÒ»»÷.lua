function GetSkillLevelData(levelname, data, level)

if (levelname == "physicsenhance_p") then
return Getphysicsenhance_p(level)
end;

if (levelname == "addexdefense_v") then
return Getaddexdefense_v(level)
end;

if (levelname == "fireres_p") then
return Getfireres_p(level)
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
result = 50*level
return Param2String(result,18*60,0)
end;

function Getaddexdefense_v(level)
result = -100*level
return Param2String(result,18*10,0)
end;

function Getfireres_p(level)
result = -100*level
return Param2String(result,18*10,0)
end;

function Getskill_cost_v(level)
result = 10+level
return Param2String(result,0,0)
end;

