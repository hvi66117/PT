function GetSkillLevelData(levelname, data, level)
	
	if (levelname == "magic_life_kmfc_dot_by_level_v") then
		return Getmagic_life_kmfc_dot_by_level_v(level)
	end;

	if (levelname == "magic_life_kmfc_dot_by_self_p") then
		return Getmagic_life_kmfc_dot_by_self_p(level)
	end;
	
	if (levelname == "magic_life_kmfc_dot_by_casterpower_p") then
		return Getmagic_life_kmfc_dot_by_casterpower_p(level)
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

-- 348 枯木逢春技能，持续治疗，根据施法者技能等级得到的数值
-- 传入 
--	level - 技能等级
function Getmagic_life_kmfc_dot_by_level_v(level)
	-- 根据技能等级计算的回复血量
	hp_for_level = level * 140

	-- 持续时间，帧（1秒=18帧）
	duration = 1 * 18

	-- 回血间隔，帧（1秒=18帧）
	interval = 18

	return Param2String(hp_for_level, duration, interval)
end;

-- 349 枯木逢春技能，持续治疗，根据被救治者损失血量进行比率计算
-- 传入 
--	level - 技能等级
function Getmagic_life_kmfc_dot_by_self_p(level)
	-- 回血比率，如果希望设定比率为 0.5，那么实际赋值为 0.5 * 100 = 50
	ratio = 10 + level * 2

	-- 持续时间，帧（1秒=18帧）
	duration = 1 * 18

	-- 回血间隔，帧（1秒=18帧）
	interval = 18

	return Param2String(ratio, duration, interval)
end;

-- 350 枯木逢春技能，持续治疗，根据施法者治疗效果进行比率计算
-- 传入 
--	level - 技能等级
function Getmagic_life_kmfc_dot_by_casterpower_p(level)
	-- 回血比率，如果希望设定比率为 0.5，那么实际赋值为 0.5 * 100 = 50
	ratio = 50

	-- 持续时间，帧（1秒=18帧）
	duration = 1 * 18

	-- 回血间隔，帧（1秒=18帧）
	interval = 18

	return Param2String(ratio, duration, interval)
end;

-- 施法消耗值
function Getskill_cost_v(level)
	local result = 10 + level * 5
	return Param2String(result, 0, 0)
end;
