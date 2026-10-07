--ÇàÁ«¶É¶ò(µÀÊ¿).lua
--author:ÀµÓÀ´Ï
--date:2009/7/24

function GetSkillLevelData(levelname, data, level)

	if (levelname == "attackratingenhance_p") then
		return attackratingenhance_p(level)
	end;

	if (levelname == "rangedamagereturn_p") then
		return rangedamagereturn_p(level)
	end;

	str1 = ""
	return str1
end

function Param2String(Param1, Param2, Param3)
	return Param1..","..Param2..","..Param3
end;

function attackratingenhance_p(level)
	local result = -10-level*5
	return Param2String(result,60,0)
end;

function rangedamagereturn_p(level)
	return Param2String(level*5,60,0)
end;
