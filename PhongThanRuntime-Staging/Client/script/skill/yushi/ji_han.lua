-- 极寒技能脚本

function GetSkillLevelData(attrname, data, level)
    -- if (attrname == "magic_active_ji_han_boom_layer_b") then
    if (attrname == "magic_active_boom_layer_b") then
        return On_magic_active_boom_layer_b(level)
    end

    if (attrname == "skill_cost_v") then
        return On_skill_cost_v(level)
    end;

    if (attrname == "magic_set_skill_cd_v") then
		return On_magic_set_skill_cd_v(level)
	end;

    return ""
end;

function Param2String(Param1, Param2, Param3)
    return Param1..","..Param2..","..Param3
end;

function On_magic_active_boom_layer_b(level)
    local nBuffID = 8831 -- 目前支持：2399-电光叠加态;2400-极寒叠加态;2401-羽毒叠加态;如果需要增加新的叠加态，则需要改C++代码;
    local nDuration = 15 -- 15秒
    return Param2String(nBuffID, nDuration * 18, nDuration)
end

function On_skill_cost_v(level)
    local nCostValue = 30 + level * 3
    return Param2String(nCostValue, 0, 0)
end;

-- 根据技能等级计算的CD帧
function On_magic_set_skill_cd_v(level)
	local cd = math.floor((288+180) - level * 18) -- 180帧（10秒）
	return Param2String(cd, 0, 0)
end;
