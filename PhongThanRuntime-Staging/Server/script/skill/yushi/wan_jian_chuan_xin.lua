function GetSkillLevelData(levelname, data, level)

if (levelname == "addexdefense_v") then
return Getaddexdefense_v(level)
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
result1 = -500
result2 = 144
return Param2String(result1,result2,0)
end;


function Getskill_cost_v(level)
result = 20+level*2
return Param2String(result,0,0)
end;

