--太清御风丹，移动速度上升，伤害下降。

function GetSkillLevelData(levelname, data, level)
	if (levelname == "fastwalkrun_p") then
		return FastWalkRun_p()
	end;

	str=""
	return str

end;
--移动速度上升50%，持续5分钟
function FastWalkRun_p()
	return Param2String(50,5400,0)
end;

function Param2String(Param1, Param2, Param3)
	return Param1..","..Param2..","..Param3
end;

