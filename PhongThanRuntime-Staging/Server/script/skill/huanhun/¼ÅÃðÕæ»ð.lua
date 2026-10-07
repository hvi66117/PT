function GetSkillLevelData(levelname, data, level)

if (levelname == "firedamage_v") then
return Getfiredamage_v(level)
end;

if (levelname == "fireres_p") then
return Getfireres_p(level)
end;

if (levelname == "skill_misslenum_v") then
return Getskill_misslenum_v(level)
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

function Getfiredamage_v(level)
result1 = 500+level*60
result2 = 600+level*100
return Param2String(result1,0,result2)
end;

function Getfireres_p(level)
result1 =  -(10+level*4)
result2 =  180
return Param2String(result1,result2 ,0)
end;

function Getskill_misslenum_v(level)
result = level+4
return Param2String(result,0,0)
end;


function Getskill_cost_v(level)
result = 18+6*level
return Param2String(result,0,0)
end;

