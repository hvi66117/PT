function GetSkillLevelData(levelname, data, level)

if (levelname == "magic_immunity_poison") then
return Getmagic_immunity_poison(level)
end;

if (levelname == "magic_immunity_cold_effect") then
return Getmagic_immunity_cold_effect(level)
end;

if (levelname == "magic_immunity_confuse") then
return Getmagic_immunity_confuse(level)
end;

if (levelname == "magic_immunity_stun") then
return Getmagic_immunity_stun(level)
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

function Getmagic_immunity_poison(level)
result = 144+18*level
return Param2String(100,result,0)
end;

function Getmagic_immunity_cold_effect(level)
result = 144+18*level
return Param2String(100,result,0)
end;

function Getmagic_immunity_confuse(level)
result = 144+18*level
return Param2String(100,result,0)
end;
function Getmagic_immunity_stun(level)
result = 144+18*level
return Param2String(100,result,0)
end;

function Getskill_cost_v(level)
result = 30+level*5
return Param2String(result,0,0)
end;
