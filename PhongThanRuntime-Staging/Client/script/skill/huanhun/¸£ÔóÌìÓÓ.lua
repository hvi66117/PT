--福泽天佑.lua
--author:laiyongcong
--date:2009/10/20

function GetSkillLevelData(levelname, data, level)

	if (levelname == "magic_bless_summon_p") then
		return magic_bless_summon_p(level)
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

function magic_bless_summon_p(level)
	local result = 20+10*level --补心效果提升多少百分比
	--第二个参数为状态持续时间3分钟
	return Param2String(result,540,0)
end;


function Getskill_cost_v(level)
	result = 30+10*level
	return Param2String(result,0,0)
end;
