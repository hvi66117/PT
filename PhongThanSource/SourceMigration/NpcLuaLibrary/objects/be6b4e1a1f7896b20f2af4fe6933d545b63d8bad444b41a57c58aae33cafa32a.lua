Task_NewPlayer = 1069;

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

    if (GetLevel() >= startLevel) and (GetPlayerType() == 1) then
        if (GetLevel() - startLevel <= 5) then
            local taskProcess = GetTask(Task_NewPlayer)
            if (taskProcess == 0) then
                state = 1
                subState = 0
            elseif (taskProcess == 1) then
                state = 0
                subState = 0
            end
        else
            local taskProcess = GetTask(Task_NewPlayer)
            if (taskProcess == 0) then
                state = 1
                subState = 1
            elseif (taskProcess == 1) then
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

    if (GetPlayerType() == 1) then
        tasks[1].show = 1
        if (GetTask(Task_NewPlayer) == 0) then
            tasks[2].show = 1
        end
    end
    SayTask(12150, tasks)
end;
function renwu()
    local nTaskStatus = GetTask(10);
    if (nTaskStatus > 4 and nTaskStatus < 16) then
        SetTask(10, 4)
        TaskNote(1, 3)
    elseif (nTaskStatus == 4) then
        TaskNote(1, 3)
    elseif (nTaskStatus == 3) then
        TaskNote(1, 2)
    elseif (nTaskStatus == 2) then
        TaskNote(1, 1)
    elseif (nTaskStatus == 16) then
        TaskNote(1, -1)
    end
    nTaskStatus = GetTask(11)
    if (nTaskStatus == 2) then
        TaskNote(2, 2)
    elseif (nTaskStatus == 3) then
        TaskNote(2, 1)
    end

    nTaskStatus = GetTask(14)
    if (nTaskStatus == 2) then
        TaskNote(4, -1)
    end
    CloseDialog()

end
function Chuchu()
    MsgBox(11693, "AcceptTask", "no")
end

function AcceptTask()
    SetTask(Task_NewPlayer, 1)

    SetSubTask(897, 1, 1)

    TaskNote(897, 0)

    Talk(1, "no", "<c=r>Tõ Hµng §¹o Nh©n<c> ë phİa T©y b¶n ®å nhÊp <c=g>phİm Tab<c> sÏ nh×n thÊy. <enter><enter>Th«ng b¸o: NhÊp F4 më tói, <c=g>Anh Hïng Phong ThÇn-§¹i LÔ Bao<c> cã nhiÒu phÇn th­ëng phong phó!")

    refreshNpcTaskState()

end
function no()
    CloseDialog()
end;
