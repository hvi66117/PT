-- Permanent Tu Chan state for MagicScript key 6,1,5803.
function GetSkillLevelData(levelname, data, level)
    if levelname == "attackspeed_v" then
        -- The second value must be -1 so the engine stores this as a
        -- persistent state attribute.  A zero marks it as an immediate
        -- attribute and CastStateSkill() has nothing to apply.
        return Param2String(10, -1, 0)
    end

    return ""
end

function Param2String(param1, param2, param3)
    return param1..","..param2..","..param3
end
