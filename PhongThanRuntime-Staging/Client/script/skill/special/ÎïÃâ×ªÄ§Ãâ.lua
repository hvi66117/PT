function GetSkillLevelData(levelname, data, level)

if (levelname == "addexdefense_v") then
return Getaddexdefense_v(level)
end;

if (levelname == "allres_p") then
return Getallres_p(level)
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

function Getaddexdefense_v(level)
result = -level*1000
return Param2String(result,180,0)
end;


function Getallres_p(level)
result = level*10
return Param2String(result,0,0)
end;


function Getskill_cost_v(level)
result = 6+level
return Param2String(result,0,0)
end;