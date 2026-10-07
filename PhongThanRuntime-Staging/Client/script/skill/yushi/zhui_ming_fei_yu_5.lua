function GetSkillLevelData(levelname, data, level)

if (levelname == "coldenhance_p") then
return Getcoldenhance_p(level)
end;

if (levelname == "skill_eventskilllevel") then
return Getskill_eventskilllevel(level)
end;

if (levelname == "colddamage_v") then
return Getcolddamage_v(level)
end;

str1 = ""
return str1
end;

function Param2String(Param1, Param2, Param3)
return Param1..","..Param2..","..Param3
end;

function Getcoldenhance_p(level)
result = level*5
return Param2String(result,0,0)
end;

function Getskill_eventskilllevel(level)
result = level
return Param2String(result,0,0)
end;

function Getcolddamage_v(level)
result1 = 180
result2 = 180
return Param2String(result1,30,result2)
end;