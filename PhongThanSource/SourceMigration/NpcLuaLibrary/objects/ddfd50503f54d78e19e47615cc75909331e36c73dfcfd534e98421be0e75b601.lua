function GetParam(strParam, index)
    nLastBegin = 1
    for i = 1, index - 1 do
        nBegin = string.find(strParam, "|", nLastBegin)
        nLastBegin = nBegin + 1
    end ;
    num = 1

    strnum = string.sub(strParam, nLastBegin)
    nEnd = string.find(strnum, "|")
    if nEnd == nil then
        return strnum
    end
    str1 = string.sub(strnum, 1, nEnd - 1);
    return str1
end;

function GetNpcLevelData(Level, StyleName, ParamStr)
    Param1 = GetParam(ParamStr, 1);
    Param2 = GetParam(ParamStr, 2);

    result = GetData(Level, Param1, Param2);
    return result;
end;

function GetNpcKeyData(Level, StyleName, Param1, Param2, Param3)
    if (StyleName == "Exp") then
        return GetExp1(Level, Param1, Param2);
    end ;

    if (StyleName == "Life") then
        return GetLife1(Level, Param1, Param2);
    end ;

    if (StyleName == "AR") then
        return GetAttackRating(Level, Param1, Param2);
    end ;

    if (StyleName == "Defense") then
        return GetDefense(Level, Param1, Param2);
    end ;

    if (StyleName == "ExDefense") then
        return GetExDefense(Level, Param1, Param2);
    end ;

    if (StyleName == "MinDamage") then
        return GetMinDamage(Level, Param1, Param2);
    end ;

    if (StyleName == "MaxDamage") then
        return GetMaxDamage(Level, Param1, Param2);
    end ;

    result = Param1 * Level * Level + Param2 * Level + Param3;
    return result;
end;

function GetData(Level, Param1, Param2)
    local skilllv = Param2 * Level + Param1
    result = skilllv / 3 - 3;
    return math.max(0, math.floor(result));
end;

function GetExp1(Level, Param1, Param2)

    result = Param2 * Level + Param1;
    return math.floor(result);
end;

function GetLife1(Level, Param1, Param2)

    result = Param2 * Level * Level + Param1;

    return math.floor(result);
end;

function GetAttackRating(Level, Param1, Param2)
    local Lv1 = Level + 10
    result = Param2 * Lv1 + Param1;
    return math.floor(result);
end;

function GetDefense(Level, Param1, Param2)
    local Lv1 = Level + 10
    result = Param2 * Lv1 + Param1;
    return math.floor(result);
end;

function GetExDefense(Level, Param1, Param2)
    local Lv1 = Level + 10
    result = Param2 * Lv1 + Param1;
    return math.floor(result);
end;

function GetMinDamage(Level, Param1, Param2)
    local Lv1 = Level + 10
    result = Param2 * Lv1 + Param1;
    return math.floor(result);
end;

function GetMaxDamage(Level, Param1, Param2)
    local Lv1 = Level + 10
    result = Param2 * Lv1 + Param1;
    return math.floor(result);
end;


