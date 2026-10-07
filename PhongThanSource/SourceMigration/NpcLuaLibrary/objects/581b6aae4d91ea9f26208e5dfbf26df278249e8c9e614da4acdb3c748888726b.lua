function GetSkillLevelData(levelname, data, level)

if (levelname == "lightingdamage_v") then
return Getlightingdamage_v(level)
end;

if (levelname == "lightingres_p") then
return Getlightingres_p(level)
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

function Getlightingdamage_v(level)
result1 = 1
result2 = floor((200+level*20)*1.22)
return Param2String(result1,0,result2)
end;

function Getlightingres_p(level)
result1 = -30
result2 = 180
return Param2String(result1,result2,0)
end;

function Getskill_cost_v(level)
result = 30+level*3
return Param2String(result,0,0)
end;

function Getmagic_attrib_base_damage_p(level)
result1 = 3
result2 = 3
result3 = 100
return Param2String(result1,result2,result3)
end;