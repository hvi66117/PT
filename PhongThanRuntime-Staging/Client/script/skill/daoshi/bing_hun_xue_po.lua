function GetSkillLevelData(levelname, data, level)
    if (levelname == "skill_cost_v") then
        return Getskill_cost_v(level)
    end

    if (levelname == "fasthitrecover_v") then
        return Getfasthitrecover_v(level)
    end

    if (levelname == "mana_drain_v") then
        return Getmana_drain_v(level)
    end

    if (levelname == "magic_auto_activate_skills_v") then
        return Getmagic_auto_activate_skills_v(level)
    end

    str1 = ""
    return str1
end

function Param2String(Param1, Param2, Param3)
    return Param1 .. "," .. Param2 .. "," .. Param3
end

function Getskill_cost_v(level)
    result = 10 + level * 5
    return Param2String(result, 0, 0)
end

function Getfasthitrecover_v(level)
    result = 8 * level
    return Param2String(result, -1, 1)
end

function Getmana_drain_v(level)
    result = 30
    return Param2String(result, -1, 0)
end

function Getmagic_auto_activate_skills_v(level)
    autoActivateSkillId = 0
    if (level == 1) then
        autoActivateSkillId = 1
    elseif (level == 2) then
        autoActivateSkillId = 2
    elseif (level == 3) then
        autoActivateSkillId = 3
    elseif (level == 4) then
        autoActivateSkillId = 4
    else
        autoActivateSkillId = 5
    end
    return Param2String(autoActivateSkillId, -1, 0) -- 第一个参数为 settings/auto_activate_skills.txt 的 AutoActivateSkillId
end
