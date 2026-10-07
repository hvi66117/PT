function GetSkillLevelData(levelname, data, level)
	
	if (levelname == "magic_no_miss_v") then
		return get_magic_no_miss_v(level)
	end;

	if (levelname == "fastwalkrun_p") then
		return get_fastwalkrun_p(level, data)
	end;
	
	if (levelname == "magic_move_back_b") then
		return get_magic_move_back_b(level)
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

-- 命中加成
function get_magic_no_miss_v(level)

	-- 比率（100 倍）
	ratio = 100

	return Param2String(ratio, 0, 0)
end;

-- 减速
function get_fastwalkrun_p(level, data)

	-- 比率（100 倍）
	ratio = -100

	-- 持续时间，帧（1秒=18帧）
	duration = 2 * 18

	return Param2String(ratio, duration, 0)
end;

-- 击退
function get_magic_move_back_b(level)

	-- 击退距离（像素）
	distance = 100 + (110 * level)

	-- 击退类型（暂时没有用）
	type = 1

	return Param2String(distance, 0, type)
end;

-- 施法消耗值
function get_skill_cost_v(level)
	local result = 1
	return Param2String(result, 0, 0)
end;
