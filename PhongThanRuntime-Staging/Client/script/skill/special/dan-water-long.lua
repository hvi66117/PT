--太清玉晶丹，生命最大值上升，速度下降。

function GetSkillLevelData(levelname, data, level)
	if (levelname == "lifemax_p") then
		return LifeMax_p()
    end;


    str = ""
	return ""
end;
--最大生命值上升200%，持续60分钟
function LifeMax_p()
	return Param2String(200,5400*12,0)
end;

function Param2String(Param1, Param2, Param3)
	return Param1..","..Param2..","..Param3
end;
