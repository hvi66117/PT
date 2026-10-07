require("common.luax")

function main(sel)

    if (COMMON.isWildSuperTrap(1) == 1) then

        Say(10286, 5, "Thñy Vùc/v1", "Long Cung/v2", "H¶i C©u/v3", "Long Vùc/v4", "Long Uyªn/v5")
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
    local i = FindAValidIBItem(8, 122, 2, 0)
    if (i ~= 0) then
        OutofMine()
        NewWorld(37, 1851, 2998)
        SetFightState(1)
        CostIBItem(i)
        CloseDialog()
    else
        Talk(1, "no", 13155)
    end ;
end;

function v2()
    local i = FindAValidIBItem(8, 122, 2, 0)
    if (i ~= 0) then
        OutofMine()
        NewWorld(38, 1828, 2983)
        SetFightState(1)
        CostIBItem(i)
        CloseDialog()
    else
        Talk(1, "no", 13155)
    end ;
end;

function v3()
    local i = FindAValidIBItem(8, 122, 2, 0)
    if (i ~= 0) then
        OutofMine()
        NewWorld(39, 1879, 2878)
        SetFightState(1)
        CostIBItem(i)
        CloseDialog()
    else
        Talk(1, "no", 13155)
    end ;
end;

function v4()
    local i = FindAValidIBItem(8, 122, 2, 0)
    if (i ~= 0) then
        OutofMine()
        NewWorld(40, 1976, 3056)
        SetFightState(1)
        CostIBItem(i)
        CloseDialog()
    else
        Talk(1, "no", 13155)
    end ;
end;

function v5()
    local i = FindAValidIBItem(8, 122, 2, 0)
    if (i ~= 0) then
        OutofMine()
        NewWorld(41, 1890, 3394)
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
