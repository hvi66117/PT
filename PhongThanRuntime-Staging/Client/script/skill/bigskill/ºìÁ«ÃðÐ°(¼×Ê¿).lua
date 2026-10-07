--ÇàÁ«¶É¶ò(¼×Ê¿).lua
--author:laiyongcong
--date:2009/7/24

function GetSkillLevelData(levelname, data, level)

	if (levelname == "castspeed_v") then
		return castspeed_v(level)
	end;

	if (levelname == "magic_deadly_strike_damage_p") then
		return magic_deadly_strike_damage_p(level)
	end;

	str1 = "0,60,0"
	return str1
end;

function Param2String(Param1, Param2, Param3)
	return Param1..","..Param2..","..Param3
end;


function castspeed_v(level)
	if(level==1)then
		result = -20
	elseif(level==2)then
		result = -30
	elseif(level==3)then
		result = -40
	elseif(level==4)then
		result = -40
	end
	return Param2String(result,60,0)
end;

function magic_deadly_strike_damage_p(level)
	local result = -2-level*2
	return Param2String(result,60,0)
end;
