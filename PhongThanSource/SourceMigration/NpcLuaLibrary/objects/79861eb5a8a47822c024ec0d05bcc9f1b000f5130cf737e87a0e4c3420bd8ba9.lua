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

    startLevel = 57
    if (GetLevel() >= startLevel) then
        local UTask_xq_0 = GetTask(50)
        if (GetLevel() - startLevel <= 5) then
            if (UTask_xq_0 == 3) and (HaveEventItem(38) >= 1) then
                state = 3
                subState = 0
            elseif (UTask_xq_0 == 6) and (HaveEventItem(39) >= 1) and (HaveEventItem(40) >= 1) and (GetItemCount(41) >= 1) then
                state = 3
                subState = 0
            elseif (UTask_xq_0 == 8) then
                state = 1
                subState = 0
            elseif ((UTask_xq_0 == 4) or (UTask_xq_0 == 5)) then
                state = 2
                subState = 0
            end

        else
            if (UTask_xq_0 == 3) and (HaveEventItem(38) >= 1) then
                state = 3
                subState = 1
            elseif (UTask_xq_0 == 6) and (HaveEventItem(39) >= 1) and (HaveEventItem(40) >= 1) and (GetItemCount(41) >= 1) then
                state = 3
                subState = 1
            elseif (UTask_xq_0 == 8) then
                state = 1
                subState = 1
            elseif ((UTask_xq_0 == 4) or (UTask_xq_0 == 5)) then
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
        { "Vi Lao", "renwu1"; show = 0 }
    }
    UTask_xq_0 = GetTask(50);
    if (UTask_xq_0 == 8) then
        tasks[1].show = 1;
    end ;
    if (UTask_xq_0 == 6) and (HaveEventItem(39) >= 1) and (HaveEventItem(40) >= 1) and (GetItemCount(41) >= 1) then
        tasks[1].show = 1;
    end ;
    if (UTask_xq_0 == 3) and (HaveEventItem(38) >= 1) then
        tasks[1].show = 1;
    end ;
    SayTask(10476, tasks)
end;

function renwu1()
    UTask_xq_0 = GetTask(50);
    if (UTask_xq_0 == 8) then
        MsgBox(10477, "yes", "no")
    end ;
    if (UTask_xq_0 == 6) and (HaveEventItem(39) >= 1) and (HaveEventItem(40) >= 1) and (GetItemCount(41) >= 1) then
        Talk(1, "no", 10478)
        DelEventItem(39)
        DelEventItem(40)
        DelEventItem(41)
        Msg2Player("Cøu Vâ C¸t, quay vÒ phôc mÖnh XÝch Tinh Tö.")
        TaskNote(21, 6)
        SetTask(50, 7)
        refreshNpcTaskState()
    end ;
    if (UTask_xq_0 == 3) and (HaveEventItem(38) >= 1) then
        Talk(2, "yes_1", 10479, 10480)
        DelEventItem(38)
        Msg2Player("BiÕt Vâ C¸t ®ang muèn vÒ th¨m mÑ. §Õn Ngäc H­ Cung thØnh gi¸o XÝch Tinh Tö")
        TaskNote(21, 3)
        SetTask(50, 4)
        refreshNpcTaskState()
    end ;
end;

function yes()
    Msg2Player("§i t×m XÝch Tinh Tö")
    TaskNote(21, 7)
    SetTask(50, 4)
    CloseDialog()
    refreshNpcTaskState()
end;

function yes_1()
    Talk(3, "no", 10481, 10482, 10483)
end;

function no()
    CloseDialog()
end;


