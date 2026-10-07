function GetSkillLevelData(levelname, data, level)

if (levelname == "physicsenhance_p") then
return Getphysicsenhance_p(level)
end;

	if (levelname == "fastwalkrun_p") then
		return get_fastwalkrun_p(level)
	end;
    
	if (levelname == "fastwalkrun_p") then
		return get_fastwalkrun_p(level)
	end;

    if (levelname == "magic_add_lifepotion_effect") then
        return Getmagic_add_lifepotion_effect(level)
    end;

str1 = ""
return str1
end;

function Param2String(Param1, Param2, Param3)
return Param1..","..Param2..","..Param3
end;

function Getphysicsenhance_p(level)
result = level*1.1
return Param2String(result,0,0)
end;

function get_fastwalkrun_p(level, data)

	-- ±ÈÂÊ£¨100 ±¶£©
	ratio = -50

	return Param2String(ratio, 27, 0)
end;

function Getmagic_add_lifepotion_effect(level)
result = -20
return Param2String(result,90,0)
end;