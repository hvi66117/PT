function GetSkillLevelData(levelname, data, level)


if (levelname == "physicsenhance_p") then
return Getphysicsenhance_p(level)
end;

if (levelname == "magic_add_boom_layer_b") then
return On_magic_add_boom_layer_b(level)
end

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
result = 65+level*15
return Param2String(result,0,0)
end;

-- 引爆层数增加
function On_magic_add_boom_layer_b(level)
return Param2String(1,0,1)
end;

function Getskill_cost_v(level)
result = 14+level
return Param2String(result,0,0)
end;
