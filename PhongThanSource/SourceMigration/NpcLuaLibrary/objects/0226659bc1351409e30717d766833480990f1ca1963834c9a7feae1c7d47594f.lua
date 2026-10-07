function GetSkillLevelData(levelname, data, level)

    if (levelname == "colddamage_v") then
        return Getcolddamage_v(level)
    end ;

    if (levelname == "skill_cost_v") then
        return Getskill_cost_v(level)
    end ;

    if (levelname == "coldres_p") then
        return Getcoldres_p(level)
    end ;

    str1 = ""
    return str1
end;

function Param2String(Param1, Param2, Param3)
    return Param1 .. "," .. Param2 .. "," .. Param3
end;

function Getcolddamage_v(level)
    result1 = math.floor((200 + level * 15) * 1.33)
    result2 = math.floor((250 + level * 25) * 1.33)
    result3 = 4 + level * 4
    return Param2String(result1, result3, result2)
end;

function Getcoldres_p(level)
    result1 = -5
    result2 = 72
    return Param2String(result1, result2, 0)
end;

function Getskill_cost_v(level)
    result = 8 + level
    return Param2String(result, 0, 0)
end;

