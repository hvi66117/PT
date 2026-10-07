function GetSkillLevelData(levelname, data, level)
	
	if (levelname == "physicsenhance_p") then
		return Getphysicsenhance_p(level)
	end;

	if (levelname == "skill_misslenum_v") then
		return Getskill_misslenum_v(level, data)
	end;
	
	if (levelname == "firedamage_v") then
		return Getfiredamage_v(level)
	end;

	if (levelname == "magic_damage_ratio_p") then
		return Getmagic_damage_ratio_p(level)
	end;

	if (levelname == "magic_damage_unchange_status_b") then
		return Getmagic_damage_unchange_status_b(level)
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

function Getphysicsenhance_p(level)
	result = 50 + level * 10
	return Param2String(result, 0, 0)
end;

function Getskill_misslenum_v(level, data)
	result = data + level/2
	return Param2String(result,0,0)
end;

function Getfiredamage_v(level)
	result1 = 200+level*100
	result2 = 400+level*200
	return Param2String(result1, 0, result2)
end;

-- 351 南明离火技能，设定 PVP、PVE 伤害率
-- 传入 
--	level - 技能等级
function Getmagic_damage_ratio_p(level)
	-- 伤害比率，取值范围：[1, 100]，100 即为 100%
	ratio_pvp = 20
	ratio_pve = 100
	return Param2String(ratio_pvp, ratio_pve, 0)
end;

-- 352 南明离火技能，设定是否不改变状态
-- 传入 
--	level - 技能等级
function Getmagic_damage_unchange_status_b(level)
	-- 1-不改变 0-改变
	unchange = 1
	return Param2String(unchange, 0, 0)
end;

-- 施法消耗值
function Getskill_cost_v(level)
	local result = 10 + level * 2
	return Param2String(result, 0, 0)
end;
