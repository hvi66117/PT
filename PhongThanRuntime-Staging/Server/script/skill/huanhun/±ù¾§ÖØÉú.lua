--冰晶重生.lua
--author:laiyongcong
--date:2009/10/20

function GetSkillLevelData(levelname, data, level)

	if (levelname == "magic_icerebirth") then
		return magic_icerebirth(level)
	end;

	if (levelname == "physicsres_p") then
		return physicsres_p(level)
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

function magic_icerebirth(level)
	local result = level
	--第二个参数为状态持续时间30秒
	-----------------------------------------第一个参数技能编号需要修改
	return Param2String(411,540,result)--第一个参数为反弹技能编号，第三个参数为，反弹技能等级
end;

function physicsres_p(level)
	local result = 3+level*1
	return Param2String( result ,540 ,0)
end

function Getskill_cost_v(level)
	result = 40+10*level
	return Param2String(result,0,0)
end;
