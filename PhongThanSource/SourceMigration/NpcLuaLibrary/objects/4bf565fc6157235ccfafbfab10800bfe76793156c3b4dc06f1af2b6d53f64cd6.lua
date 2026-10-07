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

if (levelname == "adddefense_p") then
return Getadddefense_p(level)
end;

str1 = ""
return str1
end;

function Param2String(Param1, Param2, Param3)
return Param1..","..Param2..","..Param3
end;

function Getaddexdefense_v(level)
result1 = -floor((30+level*2)*1.2)
result2 = 72+18*level
return Param2String(result1,result2,0)
end;

function Getallres_p(level)
result1 = -floor((15+level*1)*1.2)
result2 = 72+18*level
return Param2String(result1,result2,0)
end;

function Getskill_cost_v(level)
result = 10+level*2
return Param2String(result,0,0)
end;

function Getadddefense_p(level)
result1 = -8
result2 = 72+18*level
return Param2String(result1,result2,0)
end;