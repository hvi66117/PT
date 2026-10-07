function GetSkillLevelData(levelname, data, level)
	
	if (levelname == "magic_set_skill_cd_v") then
		return Getmagic_set_skill_cd_v(level)
	end;

	if (levelname == "magic_move_creature_b") then
		return Getmagic_move_creature_b(level)
	end;

	if (levelname == "skill_cost_v") then
		return Getskill_cost_v(level)
	end;

	str1 = ""
	return str1
end;

function Param2String(Param1, Param2, Param3)
	return Param1..","..Param2..","..Param3
end;

-- 根据技能等级计算的CD，帧
function Getmagic_set_skill_cd_v(level)
	-- 根据等级动态计算的 CD 值	
	cd = math.floor(594 - level * 36)
	return Param2String(cd, 0, 0)
end;

-- 瞬移召唤兽到身边
function Getmagic_move_creature_b(level)
	-- 固定这么写，不要动
	return Param2String(1, 0, 1)
end;

-- 施法消耗值
function Getskill_cost_v(level)
	local result = 10 + level * 1
	return Param2String(result, 0, 0)
end;
