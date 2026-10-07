function GetSkillLevelData(levelname, data, level)

if (levelname == "magic_rangedamagereturndefence_p") then
return Getmagic_rangedamagereturndefence_p(level)
end;

str1 = ""
return str1
end;

function Param2String(Param1, Param2, Param3)
return Param1..","..Param2..","..Param3
end;

function Getmagic_rangedamagereturndefence_p(level)
result = math.floor(3+level/2*1)
return Param2String(result,-1,0)
end;