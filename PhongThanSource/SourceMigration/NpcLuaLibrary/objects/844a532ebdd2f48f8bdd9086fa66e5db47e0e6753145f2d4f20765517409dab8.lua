NpcState = {
    [1] = { state = 3, subState = 0, str = "Vµng më" },
    [2] = { state = 3, subState = 1, str = "Lam më" },
    [3] = { state = 1, subState = 0, str = "Vµng ®ãng" },
    [4] = { state = 1, subState = 1, str = "Lam ®ãng" },
    [5] = { state = 2, subState = 0, str = "X¸m më" },
    [6] = { state = 0, subState = 0, str = "Kh«ng cã nhiÖm vô" },
}

function searchForIndex(state, subState, index)
    for i = 1, table.getn(NpcState) do
        if (i > index) then
            break
        end

        if (state == NpcState[i].state) and (subState == NpcState[i].subState) then
            index = i
        end
    end
    return index
end

function GetNpcTaskSatate()
    local state = 0
    local subState = 0
    local index = 10
    local startLevel = 1

    startLevel = 35
    if (GetLevel() >= startLevel) and (GetPlayerType() == 0) then
        local taskProcess = GetTask(3)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 10) then
                state = 1
                subState = 0
            end
        else
            if (taskProcess == 10) then
                state = 1
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)
    end
    if (index <= 6) then
        state = NpcState[index].state
        subState = NpcState[index].subState
        return state, subState
    end
end

function GetPlayerTaskState()
    local state, subState = GetNpcTaskSatate()
    return state, subState
end

function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end

function main()
    tasks = {
        { "TrÇm H­¬ng", "renwu1"; show = 0 },

        { "V¹n Tiªn", "renwu3"; show = 0 }
    }

    UTask_Knight = GetTask(3);

    if (GetPlayerType() == 0) and (GetLevel() >= 35) and (UTask_Knight == 10) then
        tasks[1].show = 1;
    end ;

    SayTask(10238, tasks)
end;

function fangchenmi()
    local state
    local mark

    state = GetWeakState()

    if (state < 2) then
        mark = 1
    else
        mark = 0
    end
    return mark
end

function renwu1()
    local mark = fangchenmi()
    if (mark == 1) then
        MsgBox(10239, "yes", "no")
    else
        Talk(1, "no", 11718)
    end
end;

function yes()
    Talk(1, "no", 10241)
    Msg2Player("NhËn lÖnh Sïng H¾c Hæ ®em 10 xe TrÇm H­¬ng Méc ®Õn TriÒu Ca cho Hoµng Phi Hæ.")
    AddEventItem(45)
    SetTask(3, 11)
    TaskNote(27, 3)

    refreshNpcTaskState()

end;

function no()
    CloseDialog()
end;

function renwu3()
    idx = SubWorldID2Idx(67);
    if (idx == -1) then
        return
    end ;
    SubWorld = idx;
    if (GetMorphType() == 364) or (IsPlayerInsideWeapon(PlayerIndex) > 0) then
        Talk(1, "no", 12510)
    elseif (GetLevel() <= 29) or (GetLevel() >= 51) then
        Talk(1, "no", 12511)
    elseif (HaveNormalItem(3, 62, 0, 0) >= 1) or (GetTask(421) == GetMissionV(1, 1)) then
        MsgBox(12512, "yes_wxz", "no")
    else
        Talk(1, "no", 12513)
    end ;
end;

function yes_wxz()
    idx = SubWorldID2Idx(67);
    if (idx == -1) then
        return
    end ;
    SubWorld = idx;
    if (GetGlobalValue(1) == 1) and (GetMSPlayerCount(1, 1) < 50) and (GetTask(421) ~= GetMissionV(1, 1)) then

        DelNormalItem(3, 62, 0, 0)
        DelHandItem(3, 66, 0, 0)
        DelHandItem(3, 67, 0, 0)
        DelHandItem(3, 68, 0, 0)
        DelHandItem(3, 69, 0, 0)
        for i = 1, 60 do
            if (HaveNormalItem(3, 66, 0, 0) >= 1) then
                DelNormalItem(3, 66, 0, 0)
            elseif (HaveNormalItem(3, 67, 0, 0) >= 1) then
                DelNormalItem(3, 67, 0, 0)
            elseif (HaveNormalItem(3, 68, 0, 0) >= 1) then
                DelNormalItem(3, 68, 0, 0)
            elseif (HaveNormalItem(3, 69, 0, 0) >= 1) then
                DelNormalItem(3, 69, 0, 0)
            else
                break ;
            end ;
        end ;

        SetFightState(0)
        AddMSPlayer(1, 1)
        SetLogoutRV(1)
        SetTask(421, GetMissionV(1, 1))
        NewWorld(67, 1325, 3280)
        StopUsePills()
        Msg2Player("Tr¹ng th¸i tu luyÖn tù ®éng t¾t!")
        CloseDialog()
    elseif (GetGlobalValue(1) == 1) and (GetMSPlayerCount(1, 1) < 55) and (GetTask(421) == GetMissionV(1, 1)) then
        DelHandItem(3, 66, 0, 0)
        DelHandItem(3, 67, 0, 0)
        DelHandItem(3, 68, 0, 0)
        DelHandItem(3, 69, 0, 0)
        for i = 1, 60 do
            if (HaveNormalItem(3, 66, 0, 0) >= 1) then
                DelNormalItem(3, 66, 0, 0)
            elseif (HaveNormalItem(3, 67, 0, 0) >= 1) then
                DelNormalItem(3, 67, 0, 0)
            elseif (HaveNormalItem(3, 68, 0, 0) >= 1) then
                DelNormalItem(3, 68, 0, 0)
            elseif (HaveNormalItem(3, 69, 0, 0) >= 1) then
                DelNormalItem(3, 69, 0, 0)
            else
                break ;
            end ;
        end ;

        SetFightState(0)
        AddMSPlayer(1, 1)
        SetLogoutRV(1)
        SetTask(421, GetMissionV(1, 1))
        NewWorld(67, 1325, 3280)
        StopUsePills()
        Msg2Player("Tr¹ng th¸i tu luyÖn tù ®éng t¾t!")
        CloseDialog()
    elseif (GetGlobalValue(1) == 2) and (GetMSPlayerCount(1, 1) < 55) and (GetTask(421) == GetMissionV(1, 1)) then
        DelHandItem(3, 66, 0, 0)
        DelHandItem(3, 67, 0, 0)
        DelHandItem(3, 68, 0, 0)
        DelHandItem(3, 69, 0, 0)
        for i = 1, 60 do
            if (HaveNormalItem(3, 66, 0, 0) >= 1) then
                DelNormalItem(3, 66, 0, 0)
            elseif (HaveNormalItem(3, 67, 0, 0) >= 1) then
                DelNormalItem(3, 67, 0, 0)
            elseif (HaveNormalItem(3, 68, 0, 0) >= 1) then
                DelNormalItem(3, 68, 0, 0)
            elseif (HaveNormalItem(3, 69, 0, 0) >= 1) then
                DelNormalItem(3, 69, 0, 0)
            else
                break ;
            end ;
        end ;

        SetFightState(1)
        AddMSPlayer(1, 1)
        SetLogoutRV(1)
        SetTask(421, GetMissionV(1, 1))
        NewWorld(67, 1325, 3280)
        StopUsePills()
        Msg2Player("Tr¹ng th¸i tu luyÖn tù ®éng t¾t!")
        CloseDialog()
    elseif (GetGlobalValue(1) == 2) then
        Talk(1, "no", 12514)
    elseif (GetMSPlayerCount(1, 1) >= 50) then
        Talk(1, "no", 12515)
    else
        Talk(1, "no", 12516)
    end ;
end;
