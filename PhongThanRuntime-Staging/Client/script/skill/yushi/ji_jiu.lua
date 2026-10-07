function GetSkillLevelData(levelname, data, level)

if (levelname == "magic_add_lifepotion_effect") then
return Getmagic_add_lifepotion_effect(level)
end;

str1 = ""
return str1
end;

function Param2String(Param1, Param2, Param3)
return Param1..","..Param2..","..Param3
end;

function Getmagic_add_lifepotion_effect(level)
result1 = 1+level
return Param2String(result1,-1,0)
end;