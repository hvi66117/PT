function GetSkillLevelData(levelname, data, level)

if (levelname == "colddamage_v") then
return Getcolddamage_v(level)
end;

if (levelname == "coldres_p") then
return Getcoldres_p(level)
end;

if (levelname == "skill_eventskilllevel") then
return Getskill_eventskilllevel(level)
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

function Getcolddamage_v(level)
result1 = floor((120+level*15)*1.15)
result2 = floor((200+level*25)*1.15)
result3 = 15+level*4
return Param2String(result1,result3,result2)
end;

function Getcoldres_p(level)
result1 = -30
result2 = 180
return Param2String(result1,result2,0)
end;

function Getskill_eventskilllevel(level)
result = level
return Param2String(result,0,0)
end;

function Getskill_cost_v(level)
result = 26+level*2
return Param2String(result,0,0)
end;
