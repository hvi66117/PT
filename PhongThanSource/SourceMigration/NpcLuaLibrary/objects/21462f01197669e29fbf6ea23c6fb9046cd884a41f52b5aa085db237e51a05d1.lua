Task_DefectorPlan = 1043;
Task_DefectNum = 1044;

NpcState = {
    [1] = { state = 3, subState = 0, str = "Vµng mÎ" },
    [2] = { state = 3, subState = 1, str = "Lam mÎ" },
    [3] = { state = 1, subState = 0, str = "Vµng Æ„ng" },
    [4] = { state = 1, subState = 1, str = "Lam Æ„ng" },
    [5] = { state = 2, subState = 0, str = "X∏m mÎ" },
    [6] = { state = 0, subState = 0, str = "Kh´ng c„ nhi÷m vÙ" },
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

    startLevel = 14
    if (GetLevel() >= startLevel) and (GetPlayerType() == 0) then
        local taskProcess = GetTask(24)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 0) then
                state = 1
                subState = 0
            elseif (taskProcess == 5) and (HaveEventItemCount(189) >= 1) then
                state = 3
                subState = 0
            elseif (taskProcess == 20) then
                state = 0
                subState = 0
            else
                state = 2
                subState = 0
            end
        else
            if (taskProcess == 0) then
                state = 1
                subState = 1
            elseif (taskProcess == 5) and (HaveEventItemCount(189) >= 1) then
                state = 3
                subState = 1
            elseif (taskProcess == 20) then
                state = 0
                subState = 0
            else
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 14
    if (GetLevel() >= startLevel) and (GetPlayerType() == 0) and (GetTask(24) == 20) then
        local taskProcess = GetTask(Task_DefectorPlan)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 0) then
                state = 1
                subState = 0
            elseif (taskProcess == 9) and (HaveEventItemCount(190) >= 3) then
                state = 3
                subState = 0
            elseif (taskProcess == 10) then
                state = 0
                subState = 0
            else
                state = 2
                subState = 0
            end
        else
            if (taskProcess == 0) then
                state = 1
                subState = 1
            elseif (taskProcess == 9) and (HaveEventItemCount(190) >= 3) then
                state = 3
                subState = 1
            elseif (taskProcess == 10) then
                state = 0
                subState = 0
            else
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

function main(sel)
    tasks = {

        { "<c=yel>Kim ∏i<c>", "renwu2"; show = 0 },
        { "<c=yel>Ph∂n qu©n k’<c>", "DefectorPlan"; show = 0 }
    }

    UTask_14 = GetTask(24);

    if (UTask_14 == 5 and HaveEventItemCount(189) >= 1) then
        tasks[1].show = 1;
    end
    if (UTask_14 == 0) and (GetPlayerType() == 0) and (GetLevel() >= 14) then
        tasks[1].show = 1;
    end ;
    local nDefectorPlan = GetTask(Task_DefectorPlan)
    if ((UTask_14 == 20 and nDefectorPlan == 0) or (nDefectorPlan == 9 and HaveEventItemCount(190) >= 3)) then
        tasks[2].show = 1
    end

    if (GetTaskByte(1416, 1) == 5 and GetPlayerType() == 0) then
        TaskNote(209, -1)
    end

    if (GetTask(Task_DefectorPlan) == 10) then
        for i = 1, 3 do
            DelNormalItem(4, 190, 0, 1)
        end
    end

    SayTask(10251, tasks)
end;
function DefectorPlan()
    local nDefectorPlan = GetTask(Task_DefectorPlan)
    if (nDefectorPlan == 0) then
        MsgBox(12588, "AcceptDefectorP", "no")
    else


        local nExp = 5000
        AddOwnExp(nExp)
        TopMessage("NhÀn Æ≠Óc " .. nExp .. " kinh nghi÷m")
        Msg2Player("NhÀn Æ≠Óc " .. nExp .. " kinh nghi÷m.")
        SetTask(Task_DefectorPlan, 10)
        for i = 1, 3 do
            DelNormalItem(4, 190, 0, 1)
        end

        SetSubTask(902, -1, 1)

        TaskNote(902, -1)

        TaskNote(902, 3)

        MsgBox(12589, "new")
        if (GetTask(Task_DefectorPlan) == 10) then
            SyncBibleState(902, 0, 1)
        end ;

        refreshNpcTaskState()

    end
end;
function new()
    Talk(1, "no", 12590)
end;

function AcceptDefectorP()
    SetTask(Task_DefectorPlan, 1)
    SetTask(Task_DefectNum, 0)
    SetTask(Task_DefectNum, SetByte(GetTask(Task_DefectNum), 1, 7))

    SetTask(Task_DefectNum, SetByte(GetTask(Task_DefectNum), 2, 4))

    SetSubTask(902, 1, 1)

    TaskNote(902, 0)
    Talk(1, "no", 12591)

    refreshNpcTaskState()

end

function renwu1()
    UTask_10 = GetTask(20);
    if (UTask_10 == 10) then
        Talk(1, "no", 10252)
        Msg2Player("ß∑ th´ng b∏o cho SÔng ¯ng Loan.")
        TaskNote(7, 2)
        SetTask(20, UTask_10 + 1)
    end ;
    if (UTask_10 == 12) then
        Talk(1, "no", 10252)
        Msg2Player("ß∑ th´ng b∏o cho SÔng ¯ng Loan.")
        TaskNote(7, 5)
        SetTask(20, UTask_10 + 1)
    end ;
    if (UTask_10 == 14) then
        Talk(1, "no", 10252)
        Msg2Player("ß∑ th´ng b∏o cho SÔng ¯ng Loan.")
        TaskNote(7, 7)
        SetTask(20, UTask_10 + 1)
    end ;
    if (UTask_10 == 16) then
        Talk(1, "no", 10252)
        Msg2Player("ß∑ th´ng b∏o cho SÔng ¯ng Loan.")
        TaskNote(7, 8)
        SetTask(20, UTask_10 + 1)
    end ;
end;

function renwu2()
    UTask_14 = GetTask(24);

    if (UTask_14 == 0) then
        if ((GetMorphType() == 364 or GetMorphType() == 420 or GetMorphType() == 419)) then
            Talk(1, "no", 14279)
        else
            PolyMorph(3, 1, 0, -1, 1800)
            Talk(1, "no", 12592)
            TopMessage(12593)
        end

        SetTask(24, 1)

        SetSubTask(10, 1, 1)

        TaskNote(209, -1)

        TaskNote(10, 0)

        refreshNpcTaskState()

    elseif (UTask_14 == 5 and HaveEventItemCount(189) >= 1) then
        DelEventItem(189)
        if (GetMorphType() == 3) then
            PolyMorph(-1, 0, 0, 0, 0)
        end
        SetTask(24, 20)

        SetSubTask(10, -1, 1)

        TaskNote(10, -1)

        local prop1 = math.random(1, 2)

        AddOwnExp(3000)

        AddItemPileNum(5, 0, 0, 1, 10)
        TopMessage(12594)

        Msg2Player("NhÀn Æ≠Óc 3000 kinh nghi÷m, 10 HÂi thµnh phÔ.")

        Talk(1, "no", 12595)
        if (GetTask(24) == 5) then
            SyncBibleState(10, 0, 1)
        end ;

        refreshNpcTaskState()


    end
end;

function no()
    CloseDialog()
end;
