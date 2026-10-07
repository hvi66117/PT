function GetSkillLevelData(levelname, data, level)

    if (levelname == "earthdamage_v") then
        return Getearthdamage_v(level)
    end ;

    if (levelname == "earthres_p") then
        return Getearthres_p(level)
    end ;

    if (levelname == "skill_cost_v") then
        return Getskill_cost_v(level)
    end ;

    str1 = ""
    return str1
end;

function Param2String(Param1, Param2, Param3)
    return Param1 .. "," .. Param2 .. "," .. Param3
end;

function Getearthdamage_v(level)
    result1 = math.floor((160 + level * 30) * 1.2)
    result2 = math.floor((200 + level * 50) * 1.2)
    return Param2String(result1, 0, result2)
end;

function Getearthres_p(level)
    result1 = -(10 + level * 4)
    result2 = 180
    return Param2String(result1, result2, 0)
end;

function Getskill_cost_v(level)
    result = 20 + level * 5
    return Param2String(result, 0, 0)
end;
