function GetSkillLevelData(levelname, data, level)

if (levelname == "magicdamage_v") then
return Getmagicdamage_v(level)
end;

if (levelname == "skill_misslenum_v") then
return Getskill_misslenum_v(level)
end;

str1 = ""
return str1
end;

function Param2String(Param1, Param2, Param3)
return Param1..","..Param2..","..Param3
end;

function Getmagicdamage_v(level)
local cityLevel = math.floor((level-1)/3)
result1 = 1000 + (cityLevel-1)*(cityLevel)*800
result2 = 1000 + (cityLevel-1)*(cityLevel)*1000
return Param2String(result1,0,result2)
end;

function Getskill_misslenum_v(level)
local tech = math.mod(level,3)
tech = (tech == 0) and 3 or tech
result = 1
if (tech == 1) then
result = 0
elseif (tech == 2) then
result = 2
elseif (tech == 3) then
result = 3
end
return Param2String(result,0,0)
end;
