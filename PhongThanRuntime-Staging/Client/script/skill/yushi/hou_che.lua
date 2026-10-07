function GetSkillLevelData(levelname, data, level)

    if (levelname == "physicsenhance_p") then
        return Getphysicsenhance_p(level)
    end;

    if (levelname == "skill_cost_v") then
        return Getskill_cost_v(level)
    end;

    if (levelname == "magic_go_back_b") then
        return get_magic_go_back_b(level)
    end

    if (levelname == "adddefense_v") then
        return Getadddefense_v(level)
    end;

    str1 = ""
    return str1
end;

function Param2String(Param1, Param2, Param3)
    return Param1..","..Param2..","..Param3
end;

function Getphysicsenhance_p(level)
    result = 90+level*10
    return Param2String(result,0,0)
end;

function Getskill_cost_v(level)
    result = 56+level
    return Param2String(result,0,0)
end;

function get_magic_go_back_b(level)
	-- ×îÔ¶³å´Ì¾àÀë(µ¥Î»£ºÏñËØ)
	local distance = 500 + (10 * level)

	-- ³å´ÌËÙ¶È£¬ÏñËØ/Ö¡
	local speed = 20

	return Param2String(distance, 0, speed)
end;

function Getadddefense_v(level)
    result = 1000
    return Param2String(result,3,0)
end;