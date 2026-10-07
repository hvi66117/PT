function GetSkillLevelData(levelname, data, level)

if (levelname == "firedamage_v") then
return Getfiredamage_v(level)
end;

if (levelname == "skill_misslenum_v") then
return Getskill_misslenum_v(level)
end;

if (levelname == "fireenhance_p") then
return Getfireenhance_p(level)
end;

str1 = ""
return str1
end;

function Param2String(Param1, Param2, Param3)
return Param1..","..Param2..","..Param3
end;

function Getfiredamage_v(level)
result1 = 200+level*20
result2 = 300+level*30
return Param2String(result1,0,result2)
end;

function Getskill_misslenum_v(level)
result = level+1
return Param2String(result,0,0)
end;

function Getfireenhance_p(level)
result = level*5
return Param2String(result,0,0)
end;