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

    startLevel = 25
    if (GetLevel() >= startLevel) and (GetPlayerType() == 1) then
        local taskProcess = GetTask(1)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 0) then
                state = 1
                subState = 0
            end
        else
            if (taskProcess == 0) then
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
        { "Chinh §å", "renwu1"; show = 0 },

    }
    UTask_Wizard = GetTask(1);
    if (GetPlayerType() == 1) and (GetLevel() >= 25) and (UTask_Wizard == 0) then
        tasks[1].show = 1;
    end ;

    SayTask(10555, tasks)
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
        MsgBox(10556, "yes", "no")
    else
        Talk(1, "no", 11718)
    end


end;

function renwu2()
    Talk(1, "no", 10557)
    TaskNote(2, 1)
    Msg2Player("§­îc sù chØ dÉn cña Hoµng Long ch©n nh©n ®i ch©n nói C«n L«n thu thËp B¨ng C¬.")
    SetTask(11, 2)
end;

function yes()
    Talk(1, "no", 10558)
    AddEventItem(0)
    Msg2Player("§­îc th­ tiÕn cö cña Hoµng Long ch©n nh©n chuÈn bÞ ®i T©y Kú gÆp Kh­¬ng Tö Nha.")
    SetTask(1, 1)
    TaskNote(28, 0)

    refreshNpcTaskState()

end;

function no()
    CloseDialog()
end;
