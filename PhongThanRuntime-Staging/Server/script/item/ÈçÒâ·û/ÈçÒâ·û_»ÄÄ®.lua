require("common.luax")

function main(sel)

    if (COMMON.isWildSuperTrap(1) == 1) then

        Say(10286, 5, "Hoang m¹c/v1", "Thæ Thµnh/v2", "Phong ThÇn/v3", "Lôc Ch©u/v4", "Sa M¹c chÕt/v5")
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
    local i = FindAValidIBItem(8, 119, 2, 0)
    if (i ~= 0) then
        OutofMine()
        NewWorld(22, 1625, 3265)
        SetFightState(1)
        CostIBItem(i)
        CloseDialog()
    else
        Talk(1, "no", 13155)
    end ;
end;

function v2()
    local i = FindAValidIBItem(8, 119, 2, 0)
    if (i ~= 0) then
        OutofMine()
        NewWorld(23, 1621, 3353)
        SetFightState(1)
        CostIBItem(i)
        CloseDialog()
    else
        Talk(1, "no", 13155)
    end ;
end;

function v3()
    local i = FindAValidIBItem(8, 119, 2, 0)
    if (i ~= 0) then
        OutofMine()
        NewWorld(24, 1608, 3190)
        SetFightState(1)
        CostIBItem(i)
        CloseDialog()
    else
        Talk(1, "no", 13155)
    end ;
end;

function v4()
    local i = FindAValidIBItem(8, 119, 2, 0)
    if (i ~= 0) then
        OutofMine()
        NewWorld(25, 1608, 3145)
        SetFightState(1)
        CostIBItem(i)
        CloseDialog()
    else
        Talk(1, "no", 13155)
    end ;
end;

function v5()
    local i = FindAValidIBItem(8, 119, 2, 0)
    if (i ~= 0) then
        OutofMine()
        NewWorld(26, 1658, 3180)
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
