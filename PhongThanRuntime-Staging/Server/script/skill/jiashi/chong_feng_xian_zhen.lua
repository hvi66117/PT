function GetSkillLevelData(levelname, data, level)
	
	if (levelname == "magic_forward_shield_p") then
		return get_magic_forward_shield_p(level)
	end;

	if (levelname == "magic_forward_move_b") then
		return get_magic_forward_move_b(level)
	end;
	
	if (levelname == "skill_cost_v") then
		return get_skill_cost_v(level)
	end;

	str1 = ""
	return str1
end;

function Param2String(Param1, Param2, Param3)
	return Param1..","..Param2..","..Param3
end;

-- 355 技能，冲锋陷阵，护盾（基础值+最大生命百分比）
-- 传入 
--	level - 技能等级
function get_magic_forward_shield_p(level)
	-- 盾，基础值
	shield_value_base = level * 100

	-- 盾，持续时间（单位：帧，18帧 == 1秒）
	duration = 90 + (36 * level)

	-- 盾，与最大血量的比率，如果希望设定比率为 0.5，那么实际赋值为 0.5 * 100 = 50
	shield_value_ratio = 0 + level * 3

	return Param2String(shield_value_base, duration, shield_value_ratio)
end;

-- 356 技能，冲锋陷阵，冲刺
-- 传入 
--	level - 技能等级
function get_magic_forward_move_b(level)
	-- 最远冲刺距离(单位：像素)
	distance = 550 + (0 * level)

	-- 冲刺速度，像素/帧
	speed = 20

	return Param2String(distance, 0, speed)
end;

-- 施法消耗值
function get_skill_cost_v(level)
	result = 10 + level
	return Param2String(result, 0, 0)
end;

