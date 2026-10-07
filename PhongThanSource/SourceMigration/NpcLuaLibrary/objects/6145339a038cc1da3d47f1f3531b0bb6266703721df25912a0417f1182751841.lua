--计算NPC属性
--可以计算的属性包括：
--Exp、Life、LifeReplenish、AttackRating、Defense、ExDefense、MinDamage、MaxDamage；
--Level1、Level2、Level3、Level4。



--取得用|分割的参数的函数。

function GetParam(strParam, index)
    nLastBegin = 1
    for i = 1, index - 1 do
        nBegin = strfind(strParam, "|", nLastBegin)
        nLastBegin = nBegin + 1
    end ;
    num = 1

    strnum = strsub(strParam, nLastBegin)
    nEnd = strfind(strnum, "|")
    if nEnd == nil then
        return strnum
    end
    str1 = strsub(strnum, 1, nEnd - 1);
    return str1
end;



--入口主函数，第一个参数为NPC等级，等二个参数为数据类型，第三个参数是传入的npcs中的字符串。
--被一个npc单独用的脚本可以不考虑第三个参数的输入。
function GetNpcLevelData(Level, StyleName, ParamStr)
    Param1 = GetParam(ParamStr, 1);
    Param2 = GetParam(ParamStr, 2);

    result = GetData(Level, Param1, Param2);
    return result;
end;

--关键数据的计算函数
function GetNpcKeyData(Level, StyleName, Param1, Param2, Param3)
    if (StyleName == "Exp") then
        return GetExp(Level, Param1, Param2);
    end ;

    if (StyleName == "Life") then
        return GetLife(Level, Param1, Param2);
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

--通用的线性计算公式。
function GetData(Level, Param1, Param2)
    result = Param2 * Level + Param1;
    return floor(result);
end;

--以下的DataPara1表示线性函数y=kx+b中的b，DataPara2表示k。
--经验值计算公式
function GetExp(Level, Param1, Param2)

    result = Param2 * Level + Param1;
    return floor(result);
end;


--生命值计算函数
function GetLife(Level, Param1, Param2)

    result = Param2 * Level + Param1;
    return floor(result);
end;



--命中率计算函数
function GetAttackRating(Level, Param1, Param2)

    result = Param2 * Level + Param1;
    return floor(result);
end;



--闪避率计算函数。
function GetDefense(Level, Param1, Param2)

    result = Param2 * Level + Param1;
    return floor(result);
end;

--防御力计算函数。
function GetExDefense(Level, Param1, Param2)

    result = Param2 * Level + Param1;
    return floor(result);
end;

--最小伤害计算函数
function GetMinDamage(Level, Param1, Param2)

    result = Param2 * Level + Param1;
    return floor(result);
end;


--最大伤害计算函数
function GetMaxDamage(Level, Param1, Param2)

    result = Param2 * Level + Param1;
    return floor(result);
end;


