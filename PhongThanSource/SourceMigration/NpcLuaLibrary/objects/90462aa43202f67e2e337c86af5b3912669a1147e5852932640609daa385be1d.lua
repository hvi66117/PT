Task_thatch = 1019;

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

    startLevel = 1
    if (GetLevel() >= startLevel) and (GetPlayerType() == 0) then
        if (GetLevel() - startLevel <= 5) then
            if (GetTask(Task_thatch) == 0) then
                state = 1
                subState = 0
            elseif (GetTask(Task_thatch) == 1) then
                state = 0
                subState = 0
            end
        else
            if (GetTask(Task_thatch) == 0) then
                state = 1
                subState = 1
            elseif (GetTask(Task_thatch) == 1) then
                state = 0
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
    local tasks = {
        { "NhiÖm vô khëi ®Çu", "renwu"; show = 0 },
        { "Mao L­", "Chuchu"; show = 0 }
    }
    if (GetPlayerType() == 0) then
        tasks[1].show = 1
        if (GetTask(Task_thatch) == 0) then
            tasks[2].show = 1
        end
    end
    SayTask(12607, tasks)
end

function Chuchu()
    MsgBox(11691, "AcceptTask", "no")
end

function renwu()
    local nTaskStatus = GetTask(21)
    if (nTaskStatus >= 4 and nTaskStatus < 9) then
        SetTask(21, 4)
        TaskNote(8, 2)
    elseif (nTaskStatus == 3) then
        SetTask(21, 2)
        TaskNote(8, 1)
    elseif (nTaskStatus == 9) then
        TaskNote(8, -1)
    end

    nTaskStatus = GetTask(20);
    if (nTaskStatus >= 14 and nTaskStatus < 19) then
        SetTask(20, 14)
        TaskNote(7, 5)

        Talk(1, "no", 12608)
        return
    elseif (nTaskStatus == 11) then
        TaskNote(7, 2)
    elseif (nTaskStatus == 12) then
        TaskNote(7, 3)
    elseif (nTaskStatus == 13) then
        TaskNote(7, 4)
    elseif (nTaskStatus == 19) then
        TaskNote(7, -1)
    end

    nTaskStatus = GetTask(24);
    if (nTaskStatus == 3) then
        Talk(1, "no", 12608)
        SetTask(24, 5)
        TaskNote(10, 1)
        return
    elseif (nTaskStatus == 2) then
        TaskNote(10, 0)
    elseif (nTaskStatus == 4) then
        TaskNote(10, -1)
    end
    CloseDialog()
end

function AcceptTask()
    SetTask(Task_thatch, 1)

    SetSubTask(909, 1, 1)

    TaskNote(909, 0)

    Talk(1, "no", "<c=r>T¹p Hãa<c> ë phİa ®«ng b¶n ®å, nhÊp <c=g>phİm Tab<c> sÏ nh×n thÊy. <enter><enter>Th«ng b¸o: NhÊp F4 më tói, <c=g>Anh Hïng Phong ThÇn-§¹i LÔ Bao<c> cã nhiÒu phÇn th­ëng phong phó!")

    refreshNpcTaskState()

end

function no()
    CloseDialog()
end;
