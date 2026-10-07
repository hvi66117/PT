function GetSkillLevelData(levelname, data, level)

if (levelname == "magic_rangedamagereturndefence_p") then
return Getmagic_rangedamagereturndefence_p(level)
end;

if (levelname == "freezetimereduce_p") then
return Getfreezetimereduce_p(level)
end;

str1 = ""
return str1
end;

function Param2String(Param1, Param2, Param3)
return Param1..","..Param2..","..Param3
end;

function Getmagic_rangedamagereturndefence_p(level)
result = math.floor(3+level/2*1)
return Param2String(result,0,0)
end;

function Getfreezetimereduce_p(level)
result = 15
return Param2String(result,60,0)
end;