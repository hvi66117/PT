function GetSkillLevelData(levelname, data, level)
	
	if (levelname == "fastwalkrun_p") then
		return get_fastwalkrun_p(level)
	end;

	if (levelname == "attackslowhitrecover_v") then
		return get_attackslowhitrecover_v(level)
	end;
	
	if (levelname == "skill_cost_v") then
		return get_skill_cost_v(level)
	end;

	if (levelname == "skill_eventskilllevel") then
		return get_skill_eventskilllevel(level)
	end;

	str1 = ""
	return str1
end;

function Param2String(Param1, Param2, Param3)
	return Param1..","..Param2..","..Param3
end;

-- 减速
function get_fastwalkrun_p(level, data)

	-- 比率（100 倍）
	ratio = -70 - (10 *level)

	return Param2String(ratio, 27, 0)
end;

-- 增伤
function get_attackslowhitrecover_v(level)
	result = 10 * level
	return Param2String(result, 27, 0)
end;

-- 施法消耗值
function get_skill_cost_v(level)
	result = 5 * level
	return Param2String(result, 0, 0)
end;

-- 技能级别传递
function get_skill_eventskilllevel(level)
	result = level
	return Param2String(result,0,0)
end;

