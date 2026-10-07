function GetSkillLevelData(levelname, data, level)

	if (levelname == "attackspeed_v") then
		return Getattackspeed_v(level)
	end;

	str1 = ""
	return str1
end;

function Param2String(Param1, Param2, Param3)
	return Param1..","..Param2..","..Param3
end;

function Getattackspeed_v(level)
	if(level==1)then
		result = 20
	elseif(level==2)then
		result = 30
	elseif(level==3)then
		result = 30
	elseif(level==4)then
		result = 30
	end
	result = 0
	return Param2String(result,60,0)
end;
