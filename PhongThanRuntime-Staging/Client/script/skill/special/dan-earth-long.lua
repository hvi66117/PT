--太清玄黄丹，防御上升，最大生命值下降。

function GetSkillLevelData(levelname, data, level)
	if (levelname == "addexdefense_v") then
		return AddDefense_v()
	end;

	if (levelname == "allres_p") then
		return AllRes_p()
	end;

	str=""
	return str

end;

--物理防御升高100，持续60分钟
function AddDefense_v()
	return Param2String(100,5400*12,0)
end;
--所有抗性升高20%，持续60分钟
function AllRes_p()
	return Param2String(20,5400*12,0)
end;

function Param2String(Param1, Param2, Param3)
	return Param1..","..Param2..","..Param3
end;
