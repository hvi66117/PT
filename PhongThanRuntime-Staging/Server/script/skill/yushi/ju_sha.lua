function GetSkillLevelData(levelname, data, level)

if (levelname == "physicsenhance_p") then
return Getphysicsenhance_p(level)
end;

if (levelname == "skill_cost_v") then
return Getskill_cost_v(level)
end;

if (levelname == "magic_no_miss_v") then
return Getmagic_no_miss_v(level)
end;

str1 = ""
return str1
end;

function Param2String(Param1, Param2, Param3)
return Param1..","..Param2..","..Param3
end;

function Getphysicsenhance_p(level)
result = 500+level*125
return Param2String(result,0,0)
end;

function Getskill_cost_v(level)
result = 45+level*2
return Param2String(result,0,0)
end;

function Getmagic_no_miss_v(level)
result = 100
return Param2String(result,0,0)
end;
