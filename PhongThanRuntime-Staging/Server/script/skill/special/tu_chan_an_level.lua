function GetSkillLevelData(levelname, data, level)
    local value = tonumber(data) or 0
    return Param2String(value, -1, 0)
end

function Param2String(param1, param2, param3)
    return param1..","..param2..","..param3
end
