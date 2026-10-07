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

    startLevel = 43
    if (GetLevel() >= startLevel) then
        local UTask_cg_1 = GetTask(41)
        if (GetLevel() - startLevel <= 5) then
            if (UTask_cg_1 == 1 and GetLevel() >= 43) then
                state = 3
                subState = 0
            end

        else
            if (UTask_cg_1 == 1 and GetLevel() >= 43) then
                state = 3
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

function main(sel)
    tasks = {
        { "Minh Ch©u", "renwu1"; show = 0 }
    }

    UTask_cg_1 = GetTask(41);
    if (UTask_cg_1 == 1) then
        tasks[1].show = 1;
    end ;
    if (UTask_cg_1 == 10) then
        tasks[1].show = 1;
    end ;
    SayTask(10029, tasks)
end;

function renwu1()

    if (UTask_cg_1 == 10) then
        Talk(3, "no", 10030, 10031, 10032)
        AddEventItem(33)
        Msg2Player("Mang B¶o ch©u ®Õn Ngäc H­ Cung nhê Cï L­u T«n gi¸m ®Þnh.")
        TaskNote(20, 2)
        SetTask(41, 11)
        refreshNpcTaskState()
    end ;
    if (UTask_cg_1 == 1) then
        Talk(3, "no", 10033, 10034, 10035)
        AddEventItem(33)
        SetTask(41, 2)
        Msg2Player("§Õn Vâ s­ ë Phong ThÇn ®µi hái lai lÞch §Þnh H¶i B¶o Ch©u.")
        TaskNote(20, 1)
        refreshNpcTaskState()
    end ;
end;

function no()
    CloseDialog()
end;
