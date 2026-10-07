function GetSkillLevelData(levelname, data, level)

if (levelname == "physic_deadly_strike_damage_p") then
return Getphysic_deadly_strike_damage_p(level)
end;

if (levelname == "ignorephysicsresist") then
return Getignorephysicsresist(level)
end;
str1 = ""
return str1
end;

function Param2String(Param1, Param2, Param3)
return Param1..","..Param2..","..Param3
end;

function Getphysic_deadly_strike_damage_p(level)
result1 = math.floor(3+level/3*1)
return Param2String(result1,-1,0)
end;

function Getignorephysicsresist(level)
result = 6+0*level
return Param2String(result,-1,0)
end;
