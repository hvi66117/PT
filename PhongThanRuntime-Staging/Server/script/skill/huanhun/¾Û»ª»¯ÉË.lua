--聚华化伤.lua
--author:laiyongcong
--date:2009/10/20

function GetSkillLevelData(levelname, data, level)

	if (levelname == "magic_buffrank") then
		return magic_buffrank(level)
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

function magic_buffrank(level)
	local result = 400+200*level + 5 --物理伤害每提升一级则提升20%，持续五个buff
	--第二个参数为状态持续时间30秒
	------------------------------------------必须填写连续的五个buff，这里buff需要更改
	return Param2String(1049,720,result)--第一个参数为起始buff，第三个参数为，连续多少个buff，爆击率多少
end;


function Getskill_cost_v(level)
	result = 20+5*level
	return Param2String(result,0,0)
end;
