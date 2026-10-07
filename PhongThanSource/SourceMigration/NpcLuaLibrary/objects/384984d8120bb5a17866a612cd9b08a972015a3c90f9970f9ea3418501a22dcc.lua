Task_BattleField_Glory = 1062

function OnGetBattleFieldGlory()
    local tBattleFieldGlory = GetTask(Task_BattleField_Glory)
    return tBattleFieldGlory
end

function OnWasteBattleFieldGlory(nWaste)
    local tBattleFieldGlory = GetTask(Task_BattleField_Glory)
    if (tBattleFieldGlory < nWaste) then
        return -1
    end

    SetTask(Task_BattleField_Glory, tBattleFieldGlory - nWaste)

    return tBattleFieldGlory - nWaste
end

function OnGetBattleTokenNum()
    local tBattleTokenNum = HaveNormalItem(3, 174, 0, 0)
    return tBattleTokenNum
end

function OnWasteBattleTokenNum(nWaste)
    local tBattleTokenNum = HaveNormalItem(3, 174, 0, 0)
    if (tBattleTokenNum < nWaste) then
        return 0
    end

    for i = 1, nWaste do
        DelNormalItem(3, 174, 0, 0)
    end
    return 1
end
