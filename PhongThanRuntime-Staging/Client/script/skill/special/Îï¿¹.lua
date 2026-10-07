--description: 噬狼头目的光环作用范围
--author: lisuhui
--date: 2009.08.18

function GetSkillLevelData(levelname, data, level)

	if (levelname == "adddefense_v") then
		return Getadddefense_v(level)
	end;

end

function Param2String(Param1, Param2, Param3)
	return Param1..","..Param2..","..Param3
end;

function Getadddefense_v(level)
	result = 0
	return Param2String(result,60,0)
end;
