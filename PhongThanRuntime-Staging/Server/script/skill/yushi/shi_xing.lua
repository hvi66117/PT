function GetSkillLevelData(levelname, data, level)

if (levelname == "fireres_p") then
return Getfireres_p(level)
end;

if (levelname == "lightingres_p") then
return Getlightingres_p(level)
end;

if (levelname == "coldres_p") then
return Getcoldres_p(level)
end;

if (levelname == "earthres_p") then
return Getearthres_p(level)
end;

if (levelname == "magic_modify_add_monster_pkrate") then
return Getmagic_modify_add_monster_pkrate(level)
end;

str1 = ""
return str1
end;

function Param2String(Param1, Param2, Param3)
return Param1..","..Param2..","..Param3
end;

function Getfireres_p(level)
result1 = 4+level*1
return Param2String(result1,-1,0)
end;

function Getlightingres_p(level)
result1 = 4+level*1
return Param2String(result1,-1,0)
end;

function Getcoldres_p(level)
result1 = 4+level*1
return Param2String(result1,-1,0)
end;

function Getearthres_p(level)
result1 = 4+level*1
return Param2String(result1,-1,0)
end;

function Getmagic_modify_add_monster_pkrate(level)
result1 = 400
return Param2String(result1,-1,0)
end;