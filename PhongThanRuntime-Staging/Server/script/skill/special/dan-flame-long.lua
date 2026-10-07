--太清烈焰丹，伤害上升，防御/魔御下降

function GetSkillLevelData(levelname, data, level)

if (levelname == "addphysicsdamage_v") then
return GetAddPhysicsdamage_v(level)
end;


str1 = ""
return str1
end;

function Param2String(Param1, Param2, Param3)
return Param1..","..Param2..","..Param3
end;

--物理防御降低lv*2，持续60分钟
--function Getaddexdefense_v(level)
--result = -300
--return Param2String(result,5400*12,0)
--end;

--所有抗性下降25%，持续60分钟
--function Getallres_p(level)
--return Param2String(-25,5400*12,0)
--end;

--物理攻击上升200，持续60分钟
function GetAddPhysicsdamage_v(level)
return Param2String(200,5400*12,0)
end;

--魔法属性攻击上升100%，持续60分钟
--function Getfireenhance_v(level)
--return Param2String(10,5400*12,0)
--end;

--function Getcoldenhance_v(level)
--return Param2String(10,5400*12,0)
--end;

--function Getlightingenhance_v(level)
--return Param2String(10,5400*12,0)
--end;

--function Getearthenhance_v(level)
--return Param2String(10,5400*12,0)
--end;


