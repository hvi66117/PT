function GetSkillLevelData(levelname, data, level)

	if (levelname == "addexdefense_v") then
		return Getaddexdefense_v(level)
	end;

	if (levelname == "attackspeed_v") then
		return Getattackspeed_v(level)
	end;

	if (levelname == "castspeed_v") then
		return Getcastspeed_v(level)
	end;

	str1 = ""
	return str1
end;

function Param2String(Param1, Param2, Param3)
	return Param1..","..Param2..","..Param3
end;


--modify by wingbear 法器数值优化 begin
function Getaddexdefense_v(level)
--result = -80-level*20
	if(level==1)then
		result = -100
	elseif(level==2)then
		result = -140
	elseif(level==3)then
		result = -200
	else
		result = -280
	end
	return Param2String(result,60,0)
end;

function Getattackspeed_v(level)
	if(level==1)then
		result = -30
	elseif(level==2)then
		result = -40
	elseif(level==3)then
		result = -50
	elseif(level==4)then
		result = -50
	end
	return Param2String(result,60,0)
end;

function Getcastspeed_v(level)
	if(level==1)then
		result = -30
	elseif(level==2)then
		result = -40
	elseif(level==3)then
		result = -50
	elseif(level==4)then
		result = -50
	end
	return Param2String(result,60,0)
end;
--modify by wingbear 法器数值优化 end