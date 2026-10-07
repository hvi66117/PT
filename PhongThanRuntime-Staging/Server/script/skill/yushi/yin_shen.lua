function GetSkillLevelData(levelname, data, level)

if (levelname == "rangedamagereturn_p") then
return Getrangedamagereturn_p(level)
end;

if (levelname == "stealth_state_v") then
return Getstealth_state_v(level)
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

function Getrangedamagereturn_p(level)
result = math.floor(-2+level/2*1)
return Param2String(result,180,0)
end;

function Getstealth_state_v(level)
    result1 = level
    result2 = 180+level
    return Param2String(result1,result2,0)
end;

function Getskill_cost_v(level)
    result = 60+level
    return Param2String(result, 0, 0)
end;