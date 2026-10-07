function GetSkillLevelData(levelname, data, level)
    if (levelname == "adddefense_v") then
        return Getadddefense_v(level)
    end

    if (levelname == "fastwalkrun_p") then
        return Getfastwalkrun_p(level)
    end

    if (levelname == "fasthitrecover_v") then
        return Getfasthitrecover_v(level)
    end

    str1 = ""
    return str1
end

function Param2String(Param1, Param2, Param3)
    return Param1 .. "," .. Param2 .. "," .. Param3
end

function Getadddefense_v(level)
    result = 40 + level * 10
    return Param2String(result, -1, 0)
end

function Getfastwalkrun_p(level)
    result1 = 6
    result2 = 180
    return Param2String(result1,result2,0)
end

function Getfasthitrecover_v(level)
    result = 30
    return Param2String(result, -1, 1)
end
