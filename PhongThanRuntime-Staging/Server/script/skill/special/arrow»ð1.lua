function GetSkillLevelData(levelname, data, level)

if (levelname == "physicsdamage_v") then
return Getphysicsdamage_v(level)
end;

if (levelname == "skill_misslenum_v") then
return Getskill_misslenum_v(level)
end;

if (levelname == "earthenhance_p") then
return Getearthenhance_p(level)
end;

str1 = ""
return str1
end;

function Param2String(Param1, Param2, Param3)
return Param1..","..Param2..","..Param3
end;

function Getphysicsdamage_v(level)
result1 = 30+level*3
result2 = 60+level*6
return Param2String(result1,0,result2)
end;

function Getskill_misslenum_v(level)
result = level/2+3
return Param2String(result,0,0)
end;

function Getearthenhance_p(level)
result = level*5
return Param2String(result,0,0)
end;
