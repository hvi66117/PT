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

if (levelname == "colddamage_v") then
return Getcolddamage_v(level)
end;

if (levelname == "coldenhance_p") then
return Getcoldenhance_p(level)
end;

str1 = ""
return str1
end;

function Param2String(Param1, Param2, Param3)
return Param1..","..Param2..","..Param3
end;


function Getphysicsenhance_p(level)
result = math.floor((60+level*10)*1.16)
return Param2String(result,0,0)
end;

-- 引爆层数增加
function On_magic_add_boom_layer_b(level)
return Param2String(1,0,1)
end;

function Getskill_cost_v(level)
result = 13+level
return Param2String(result,0,0)
end;

function Getcolddamage_v(level)
result1 = 300
result2 = 300
return Param2String(result1,30,result2)
end;

function Getcoldenhance_p(level)
result = level*5
return Param2String(result,0,0)
end;
