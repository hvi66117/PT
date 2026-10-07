function GetSkillLevelData(levelname, data, level)

if (levelname == "physic_deadly_strike_damage_r") then
return Getphysic_deadly_strike_damage_r(level)
end;

str1 = ""
return str1
end;

function Param2String(Param1, Param2, Param3)
return Param1..","..Param2..","..Param3
end;

function Getphysic_deadly_strike_damage_r(level)
result = 5+level*2
return Param2String(result,-1,0)
end;