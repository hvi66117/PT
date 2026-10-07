function GetSkillLevelData(levelname, data, level)
	if (levelname == "magic_disable_skill_by_lrinfo_v") then
		return Getmagic_disable_skill_by_lrinfo_v(level)
	end;

	if (levelname == "magic_set_skill_cd_v") then
		return Getmagic_set_skill_cd_v(level)
	end;
	
	if (levelname == "skill_cost_v") then
		return Getskill_cost_v(level)
	end;

	if (levelname == "magic_trans_to_creature_v") then
		return Getmagic_trans_to_creature_v(level)
	end;

	if (levelname == "magic_immune_control_state_v") then
		return Getmagic_immune_control_state_v(level)
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
	cd = math.floor(180 - level * 18)
	return Param2String(cd, 0, 0)
end;

function Getmagic_disable_skill_by_lrinfo_v(level)
	local result = 144 + level * 72 
	return Param2String(1,result,1) -- 禁用类型（）；持续时间；必须为1--
end;

function Getmagic_trans_to_creature_v(level)
	local result = 144 + level * 72 
	return Param2String(level,result,1) -- (trans_to_creature.txt id；持续时间；必须为1) --
end;

function Getskill_cost_v(level)
	return Param2String(19,0,0)
end;

function Getmagic_immune_control_state_v(level)
	local result2 = 144 + level * 72 
	return Param2String(1,result2,1)
end;

