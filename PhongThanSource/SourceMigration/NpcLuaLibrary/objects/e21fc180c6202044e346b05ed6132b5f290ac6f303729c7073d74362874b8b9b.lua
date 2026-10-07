function GetSkillLevelData(levelname, data, level)

if (levelname == "firedamage_v") then
return Getfiredamage_v(level)
end;

if (levelname == "fireres_p") then
return Getfireres_p(level)
end;

if (levelname == "skill_cost_v") then
return Getskill_cost_v(level)
end;

if (levelname == "magic_attrib_base_damage_p") then
return Getmagic_attrib_base_damage_p(level)
end;

str1 = ""
return str1
end;

function Param2String(Param1, Param2, Param3)
return Param1..","..Param2..","..Param3
end;

function Getfiredamage_v(level)
result1 = floor((80+level*25)*1.3)
result2 = floor((150+level*35)*1.3)
return Param2String(result1,0,result2)
end;

function Getfireres_p(level)
result1 = -30
result2 = 180
return Param2String(result1,result2,0)
end;

function Getskill_cost_v(level)
result = 8+level
return Param2String(result,0,0)
end;

function Getmagic_attrib_base_damage_p(level)
result1 = 3
result2 = 1
result3 = 100
return Param2String(result1,result2,result3)
end;