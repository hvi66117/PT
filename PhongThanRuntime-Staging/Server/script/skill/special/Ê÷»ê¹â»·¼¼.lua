--«‡¡´∂…∂Ú(“Ï»À).lua
--author:laiyongcong
--date:2009/7/24

function GetSkillLevelData(levelname, data, level)

	if (levelname == "attackspeed_v") then
		return attackspeed_v(level)
	end;

	if (levelname == "physic_deadly_strike_damage_p") then
		return physic_deadly_strike_damage_p(level)
	end;

	str1 = "0,60,0"
	return str1
end

function Param2String(Param1, Param2, Param3)
	return Param1..","..Param2..","..Param3
end;

function attackspeed_v(level)

	result = -20 * level

	return Param2String(result,60,0)

end;

function physic_deadly_strike_damage_p(level)
	local result = -2-level*2
	result = 0
	return Param2String(result,60,0)
end;
