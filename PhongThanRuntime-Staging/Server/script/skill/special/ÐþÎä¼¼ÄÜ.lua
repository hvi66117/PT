function GetSkillLevelData(levelname, data, level)

if (levelname == "physicsenhance_p") then
return Getphysicsenhance_p(level)
end;

if (levelname == "poison_state") then
return Getpoison_state(level)
end;

str1 = ""
return str1
end;

function Param2String(Param1, Param2, Param3)
return Param1..","..Param2..","..Param3
end;

function Getphysicsenhance_p(level)
result = 50+level*10
return Param2String(result,0,0)
end;

function Getpoison_state(level)
result = 20+level*10
return Param2String(result,360,0)
end;
