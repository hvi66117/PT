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

    startLevel = 45
    if (GetLevel() >= startLevel) and (GetPlayerType() == 2) then
        local taskProcess = GetTask(2)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 20) then
                state = 1
                subState = 0
            elseif (taskProcess == 22) then
                state = 3
                subState = 0
            elseif (taskProcess == 21) then
                state = 2
                subState = 0
            end
        else
            if (taskProcess == 20) then
                state = 1
                subState = 1
            elseif (taskProcess == 22) then
                state = 3
                subState = 1
            elseif (taskProcess == 21) then
                state = 2
                subState = 0
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
        { "Cæ §ao", "renwu1"; show = 0 }
    }
    UTask_Druid = GetTask(2);
    if (GetLevel() >= 45) and (UTask_Druid == 22) and (GetPlayerType() == 2) then
        tasks[1].show = 1;
    end ;

    if (GetPlayerType() == 2) and (GetLevel() >= 45) and (UTask_Druid == 20) then
        tasks[1].show = 1;
    end ;
    SayTask(10343, tasks)
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
    UTask_Druid = GetTask(2);
    local mark = fangchenmi()
    if (GetLevel() >= 45) and (UTask_Druid == 22) and (GetPlayerType() == 2) then
        Talk(1, "no", 10344)
        AddEventItem(17)
        AddNormalItem(0, 0, 34, 4, 1, 0)
        SetTask(2, 30)
        TaskNote(29, 9)
        AddOwnExp(240000)
        TopMessage(13586)
        Msg2Player("Cøu ®­îc dÞ nh©n, nhËn ®­îc Phôc ThÕ phñ vµ 240000 kinh nghiÖm.")

        refreshNpcTaskState()

    end ;
    if (GetPlayerType() == 2) and (GetLevel() >= 45) and (UTask_Druid == 20) then
        if (mark == 1) then
            Talk(3, "no", 10345, 10346, 10347)
            SetTask(2, 21)
            TaskNote(29, 7)
            Msg2Player("Tiªu diÖt t­íng qu©n phãng ho¶ trong s¬n ®éng, cøu ®­îc DÞ Nh©n.")

            refreshNpcTaskState()

        else
            Talk(1, "no", 11718)
        end
    end ;
end;

function no()
    CloseDialog()
end;
