function GetSkillLevelData(levelname, data, level)
    if (levelname == "skill_cost_v") then
        return Getskill_cost_v(level)
    end

    if (levelname == "magic_set_skill_cd_v") then
		return Getmagic_set_skill_cd_v(level)
	end;

    
    if (levelname == "magic_extra_real_damage_with_short_weapon_v") then
        return Getmagic_extra_real_damage_with_short_weapon_v(level)
    end

    if (levelname == "magic_damage_ratio_by_short_weapon_p") then
        return Getmagic_damage_ratio_by_short_weapon_p(level)
    end

    if (levelname == "magic_damage_ratio_by_long_weapon_p") then
        return Getmagic_damage_ratio_by_long_weapon_p(level)
    end

    str1 = ""
    return str1
end

function Param2String(Param1, Param2, Param3)
    return Param1 .. "," .. Param2 .. "," .. Param3
end

-- 根据技能等级计算的CD帧
function Getmagic_set_skill_cd_v(level)
	cd = math.floor(180 - level * 18)
	return Param2String(cd, 0, 0)
end;

function Getskill_cost_v(level)
    result = 3 + level / 3
    return Param2String(result, 0, 0)
end

function Getmagic_extra_real_damage_with_short_weapon_v(level)
    damage_to_player = 0 + level * 0 -- 对玩家的真实伤害
    damage_to_monster = 200 + level * 200 -- 对怪物的真实伤害

    return Param2String(damage_to_player, 540, damage_to_monster) -- (对玩家的真实伤害；持续时间；对怪物的真实伤害) --
end

function Getmagic_damage_ratio_by_short_weapon_p(level)
    result = 3
    return Param2String(result, 540, 1) -- (短兵器伤害系数,持续时间，1) --
end

function Getmagic_damage_ratio_by_long_weapon_p(level)
    return Param2String(80, 540, 1) -- (长兵器伤害系数,持续时间，1) --
end
