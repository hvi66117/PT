function GetSkillLevelData(levelname, data, level)

    if (levelname == "allmagicdeadlystirke") then
        return Getallmagicdeadlystirke(level)
    end ;

    if (levelname == "deadlystrikeenhance_p") then
        return Getdeadlystrikeenhance_p(level)
    end ;

    if (levelname == "physicsenhance_p") then
        return Getphysicsenhance_p(level)
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

function Getallmagicdeadlystirke(level)
    result1 = -(5 + level)
    result2 = 108
    return Param2String(result1, result2, 0)
end;

function Getdeadlystrikeenhance_p(level)
    result1 = -(15 + level * 3)
    result2 = 108
    return Param2String(result1, result2, 0)
end;

function Getphysicsenhance_p(level)
    result = 25
    return Param2String(result, 0, 0)
end;

function Getskill_cost_v(level)
    result = 25 + level * 4
    return Param2String(result, 0, 0)
end;

