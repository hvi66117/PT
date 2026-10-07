function GetSkillLevelData(levelname, data, level)

if (levelname == "earthdamage_v") then
return Getearthdamage_v(level)
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

function Getearthdamage_v(level)
result1 = 300+level*50
result2 = 400+level*80
return Param2String(result1,0,result2)
end;

function Getskill_cost_v(level)
result = 30+level*6
return Param2String(result,0,0)
end;

function Getmagic_attrib_base_damage_p(level)
result1 = 3
result2 = 2
result3 = 150
return Param2String(result1,result2,result3)
end;