-- Npc Level Script B×nh th­êng
function GetParam(strParam, index)
	nLastBegin = 1
	for i=1, index - 1 do
	nBegin = strfind(strParam, "|", nLastBegin)
	if nBegin == nil then 
		return strParam
	end
	nLastBegin = nBegin + 1
	end;
	num = 1

	strnum = strsub(strParam, nLastBegin)
	nEnd = strfind(strnum, "|")
	if nEnd == nil then 
		return strnum
	end
	str1 = strsub(strnum,1,nEnd -1);
	return str1
end;

function GetNpcLevelData(Series, Level, StyleName, ParamStr)
	Param1 = GetParam(ParamStr,1);
	Param2 = GetParam(ParamStr,2);
	
	if(StyleName=="Skill1") then
		return floor(Param1)
	end
	if(StyleName=="Level1") then
		return floor(Param1)
	end
	if(StyleName=="Skill2") then
		return floor(Param1)
	end
	if(StyleName=="Level2") then
		return floor(Param1)
	end
	if(StyleName=="Skill3") then
		return floor(Param1)
	end
	if(StyleName=="Level3") then
		return floor(Param1)
	end
	if(StyleName=="Skill4") then
		return floor(Param1)
	end
	if(StyleName=="Level4") then
		return floor(Param1)
	end
	
	if(StyleName=="AIMode") then
		return floor(Param1)
	end
	if(StyleName=="AIParam1") then
		return floor(Param1)
	end
	if(StyleName=="AIParam2") then
		return floor(Param1)
	end
	if(StyleName=="AIParam3") then
		return floor(Param1)
	end
	if(StyleName=="AIParam4") then
		return floor(Param1)
	end
	if(StyleName=="AIParam5") then
		return floor(Param1)
	end
	if(StyleName=="AIParam6") then 
		return floor(Param1)
	end
	if(StyleName=="AIParam7") then
		return floor(Param1)
	end
	if(StyleName=="AIParam8") then
		return floor(Param1)
	end
	if(StyleName=="AIParam9") then
		return floor(Param1)
	end

	result = GetData(Level, Param1, Param2);
	return result;
end;

function GetNpcKeyData(Series, Level, StyleName, Param1, Param2, Param3)
	if (StyleName == "Exp") then
		return GetExp(Level, Param1, Param2);
	end;

	if (StyleName == "Life") then
		return GetLife(Level, Param1, Param2);
	end;

	if (StyleName == "AR") then
		return GetAttackRating(Level, Param1, Param2);
	end;

	if (StyleName == "Defense") then
		return GetDefense(Level, Param1, Param2);
	end;

	if (StyleName == "ExDefense") then
		return GetExDefense(Level, Param1, Param2);
	end;

	if (StyleName == "MinDamage") then
		return GetMinDamage(Level, Param1, Param2);
	end;

	if (StyleName == "MaxDamage") then
		return GetMaxDamage(Level, Param1, Param2);
	end;

	result = Param1 * Level * Level + Param2 * Level + Param3;
	return result;
end;

function GetData(Level, Param1, Param2)
	result = Param2 * Level + Param1;
	return floor(result);
end;

function GetExp(Level, Param1, Param2)
	result = Param2 * Level + Param1;
	return floor(result);
end;


function GetLife(Level, Param1, Param2)
	result = Param2 * Level + Param1;
	return floor(result);
end;

function GetAttackRating(Level, Param1, Param2)
	result = Param2 * Level + Param1;
	return floor(result);
end;

function GetDefense(Level, Param1, Param2)
	result = Param2 * Level + Param1;
	return floor(result);
end;

function GetExDefense(Level, Param1, Param2)
	result = Param2 * Level + Param1;
	return floor(result);
end;

function GetMinDamage(Level, Param1, Param2)
	result = Param2 * Level + Param1;
	return floor(result);
end;


function GetMaxDamage(Level, Param1, Param2)
	result = Param2 * Level + Param1;
	return floor(result);
end;


