function GetSkillLevelData(levelname, data, level)

    if (levelname == "physicsenhance_p") then
        return Getphysicsenhance_p(level)
    end;

    if (levelname == "skill_cost_v") then
        return Getskill_cost_v(level)
    end;

    if (levelname == "magic_boom_stun_v") then
        return On_magic_boom_stun_v(level)
    end

    if (levelname == "magic_boom_freeze_v") then
        return On_magic_boom_freeze_v(level)
    end

    if (levelname == "magic_boom_fatally_strike_p") then
        return On_magic_boom_fatally_strike_p(level)
    end

    return ""
end;

function Param2String(Param1, Param2, Param3)
    return Param1..","..Param2..","..Param3
end;

function Getphysicsenhance_p(level)
    result = math.floor((90+level*10)*1.1)
    return Param2String(result, 0, 0)
end;

function Getskill_cost_v(level)
    result = 30+level/2
    return Param2String(result, 0, 0)
end;

function On_magic_boom_stun_v(level)
    local nDuration = 1 * 18 -- 1Ãë
    local nBuffID = 8842 -- 10²ãµç¹â
    return Param2String(nDuration, 0, nBuffID)
end

function On_magic_boom_freeze_v(level)
    local nDuration = 3 * 18 -- 3Ãë
    local nBuffID = 8852 -- 10²ã¼«º®
    return Param2String(nDuration, 0, nBuffID)
end

function On_magic_boom_fatally_strike_p(level)
    local nPercent = 10 -- 10%
    local nBuffID = 8862 -- 10²ãÓð¶¾
    return Param2String(nPercent, 0, nBuffID)
end
