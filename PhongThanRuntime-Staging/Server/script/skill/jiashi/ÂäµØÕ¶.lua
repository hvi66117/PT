function GetSkillLevelData(levelname, data, level)

if (levelname == "earthdamage_v") then
return Getearthdamage_v(level)
end;

if (levelname == "physicsenhance_p") then
return Getphysicsenhance_p(level)
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

function Getearthdamage_v(level)
result1 = 280+level*20
result2 = 350+level*30
return Param2String(result1,0,result2)
end;

function Getphysicsenhance_p(level)
result = 10+level*4
return Param2String(result,0,0)
end;

function Getskill_cost_v(level)
result = 10+level
return Param2String(result,0,0)
end;

