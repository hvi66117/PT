require("common.luax")

function main(sel)

    if (COMMON.isWildSuperTrap(1) == 1) then

        Say(10286, 5, "Khæn Tiªn tÇng 1/v1", "Khæn Tiªn tÇng 2/v2", "Khæn Tiªn tÇng 3/v3", "Khæn Tiªn tÇng 4/v4", "Khæn Tiªn tÇng 5/v5")
    end ;
end;

function OutofMine()
    local mapid, x, y = GetWorldPos()
    if (mapid == 57) then
        SetGlobalValue(141, GetGlobalValue(141) - 1)
        if (HaveIBBuff(709) > 0) then
            RemoveIBBuff(709)
        end
    end

    if (mapid == 83) then
        local nNum = GetWorldEventValue(8, 1)
        if (nNum < 1) then
            nNum = 1
        end
        SetWorldEventValue(8, 1, nNum - 1)
        SetTaskByte(1855, 4, 0)
        LockCamp(0)
        SetLogoutRV(0)
        SetTeamFreezeFlag(0)
        TaskNote(1631, -1)

        Task_GetReward = 1907
        TaskNote(Task_GetReward, -1)

    end

end

function v1()
    local i = FindAValidIBItem(8, 124, 2, 0)
    if (i ~= 0) then
        OutofMine()
        NewWorld(47, 1597, 3141)
        SetFightState(1)
        CostIBItem(i)
        CloseDialog()
    else
        Talk(1, "no", 13155)
    end ;
end;

function v2()
    local i = FindAValidIBItem(8, 124, 2, 0)
    if (i ~= 0) then
        OutofMine()
        NewWorld(48, 1578, 3151)
        SetFightState(1)
        CostIBItem(i)
        CloseDialog()
    else
        Talk(1, "no", 13155)
    end ;
end;

function v3()
    local i = FindAValidIBItem(8, 124, 2, 0)
    if (i ~= 0) then
        OutofMine()
        NewWorld(49, 1559, 3151)
        SetFightState(1)
        CostIBItem(i)
        CloseDialog()
    else
        Talk(1, "no", 13155)
    end ;
end;

function v4()
    local i = FindAValidIBItem(8, 124, 2, 0)
    if (i ~= 0) then
        OutofMine()
        NewWorld(50, 1603, 3156)
        SetFightState(1)
        CostIBItem(i)
        CloseDialog()
    else
        Talk(1, "no", 13155)
    end ;
end;

function v5()
    local i = FindAValidIBItem(8, 124, 2, 0)
    if (i ~= 0) then
        OutofMine()
        NewWorld(51, 1506, 3161)
        SetFightState(1)
        CostIBItem(i)
        CloseDialog()
    else
        Talk(1, "no", 13155)
    end ;
end;

function no()
    CloseDialog()
end;

