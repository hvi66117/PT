function GetSkillLevelData(levelname, data, level)

if (levelname == "colddamage_v") then
return Getcolddamage_v(level)
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

function Getcolddamage_v(level)
result1 = 200+level*10
result2 = 300+level*20
result3 = 8+level*2
return Param2String(result1,result3,result2)
end;

function Getphysicsenhance_p(level)
result = 10+level*4
return Param2String(result,0,0)
end;

function Getskill_cost_v(level)
result = 6+level
return Param2String(result,0,0)
end;

