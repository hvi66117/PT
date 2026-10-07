Task_Conflict = 1089

Task_star = 1417

Task_collect = 1418

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

    if (GetLevel() >= startLevel) and (GetPlayerType() == 2) then
        if (GetLevel() - startLevel <= 5) then
            local taskProcess = GetTask(30)
            if (taskProcess == 2) or (taskProcess == 3) then
                state = 3
                subState = 0
            elseif (taskProcess == 4) or (taskProcess == 15) then
                state = 0
                subState = 0
            end
        else
            local taskProcess = GetTask(30)
            if (taskProcess == 2) or (taskProcess == 3) then
                state = 3
                subState = 1
            elseif (taskProcess == 4) or (taskProcess == 15) then
                state = 0
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 3
    if (GetLevel() >= startLevel) and (GetPlayerType() == 2) then
        if (GetLevel() - startLevel <= 5) then
            local taskProcess = GetTask(31)
            if (taskProcess == 0) then
                state = 1
                subState = 0
            elseif (taskProcess == 1) then
                state = 2
                subState = 0
            elseif (taskProcess == 3) then
                state = 3
                subState = 0
            elseif (taskProcess == 15) then
                state = 0
                subState = 0
            end
        else
            local taskProcess = GetTask(31)
            if (taskProcess == 0) then
                state = 1
                subState = 1
            elseif (taskProcess == 1) then
                state = 2
                subState = 1
            elseif (taskProcess == 3) then
                state = 3
                subState = 1
            elseif (taskProcess == 15) then
                state = 0
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 3
    if (GetLevel() >= startLevel) and (GetPlayerType() == 2) then
        if (GetLevel() - startLevel <= 5) then
            local taskProcess = GetTask(Task_Conflict)
            if (taskProcess == 0) and (GetTask(31) == 15) then
                state = 1
                subState = 0
            elseif (taskProcess == 1) then
                state = 0
                subState = 0
            end
        else
            local taskProcess = GetTask(Task_Conflict)
            if (taskProcess == 0) and (GetTask(31) == 15) then
                state = 1
                subState = 0
            elseif (taskProcess == 1) then
                state = 0
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 37
    if (GetLevel() >= startLevel) then
        if (GetLevel() - startLevel <= 5) then
            if (GetTaskByte(Task_star, 1) == 5 and GetTaskByte(Task_collect, 4) == 0 and GetLevel() >= 37) then
                state = 3
                subState = 0
            end
        else
            if (GetTaskByte(Task_star, 1) == 5 and GetTaskByte(Task_collect, 4) == 0 and GetLevel() >= 37) then
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
        { "<c=yel>Khai Tr›<c>", "strongman"; show = 0 },
        { "<c=yel>Trang bﬁ mÌi<c>", "renwu1"; show = 0 },
        { "<c=yel>Hﬂa gi∂i<c>", "ResolveConflict"; show = 0 },
        { "Tinh quang ∂m Æπm", "star_dark"; show = 0 },
    }
    UTask_20 = GetTask(30);
    if (((UTask_20 == 2) or (UTask_20 >= 3 and UTask_20 < 15 and UTask_20 ~= 4)) and GetPlayerType() == 2) then
        tasks[1].show = 1;
    end ;
    UTask_21 = GetTask(31);
    if (UTask_21 >= 3 and UTask_21 < 15) then
        tasks[2].show = 1;
    end ;
    if (UTask_21 == 0 and GetLevel() >= 3 and GetPlayerType() == 2) then
        tasks[2].show = 1;
    end ;

    local L_Resolve = GetTask(Task_Conflict)
    if (UTask_21 == 15 and L_Resolve == 0 and GetPlayerType() == 2) then
        tasks[3].show = 1;
    end ;

    if (GetTaskByte(Task_star, 1) == 5 and GetTaskByte(Task_collect, 4) == 0 and GetLevel() >= 37) then
        tasks[4].show = 1
    end

    SayTask(10154, tasks)
end;

function renwu1()
    UTask_21 = GetTask(31);
    if (UTask_21 >= 3 and UTask_21 < 15) then
        Earn(600)
        AddOwnExp(600)
        AddNormalItem(0, 6, 2, 1, 1, 0)
        TopMessage(12396)
        Msg2Player("GiÛp HÀu ThÊ t◊m nguy™n li÷u nhÀn Æ≠Óc 600 l≠Óng, 600 Æi”m kinh nghi÷m vµ Lang Nha Y™u ß∏i.")
        SetTask(31, 15)

        SetSubTask(14, -1, 1)

        TaskNote(14, -1)
        Talk(1, "yes_look", 12397)

        refreshNpcTaskState()

    end ;

    if (UTask_21 == 0) and (GetLevel() >= 3) then
        MsgBox(10156, "yes_1", "no")
    end ;
end;

function yes_look()
    task_Resolve = {
        { "<c=yel>Hﬂa gi∂i<c>", "ResolveConflict"; show = 1 },
    }
    SayTask(10154, task_Resolve)
end
function yes_1()
    MsgBox(10157, "no")
    Msg2Player("T◊m ThÓ ÆÂng h·i nguy™n li÷u th›ch hÓp cÒa trang bﬁ Dﬁ Nh©n")

    SetSubTask(14, 1, 1)

    TaskNote(14, 10)
    SetTask(31, 1)

    for i = 1, 2 do
        AddNormalItemBind(3, 12, 0, 0, 0, 0, 1)
    end
    Msg2Player("ChÛc mıng anh hÔng nhÀn Æ≠Óc 2 Qu˚ Di÷n")

    refreshNpcTaskState()

end;

function strongman()
    UTask_20 = GetTask(30);
    if (UTask_20 == 2) then
        Talk(1, "no", 10161)
        TaskNote(13, 11)
        SetTask(30, UTask_20 + 2)
        AddOwnExp(100)
        TopMessage(12130)
        AddNormalItem(0, 7, 2, 1, 1, 0)
        Msg2Player("NhÀn Æ≠Óc 100 Æi”m kinh nghi÷m vµ Lang Nha TrÙ")

        refreshNpcTaskState()

    end ;

    if (UTask_20 >= 3 and UTask_20 < 15 and UTask_20 ~= 4) then
        Talk(1, "no", 12398)

        SetSubTask(13, -1, 1)

        TaskNote(13, -1)
        SetTask(30, 15)
        AddOwnExp(100)
        TopMessage(12130)
        AddNormalItem(0, 7, 2, 1, 1, 0)
        Msg2Player("NhÀn Æ≠Óc 100 Æi”m kinh nghi÷m vµ Lang Nha TrÙ")

        refreshNpcTaskState()

    end ;

    if (GetLevel() >= 3 and GetTask(30) == 5) then
        Talk(1, "no", 12399)
        Msg2Player("Hoµn thµnh nhi÷m vÙ Khai Tr›")
        TopMessage(12400)
        if (GetTask(31) == 0) then
            Talk(1, "yes_NewWeapon", 12399)
        end
    end
end;

function yes_NewWeapon()
    task_NewWeapon = {
        { "<c=yel>Trang bﬁ mÌi<c>", "renwu1"; show = 1 },
    }
    SayTask(12401, task_NewWeapon)
end

function ResolveConflict()
    MsgBox(12402, "yes_conflict", "no")
end;

function yes_conflict()
    Talk(1, "no", 12403)
    Msg2Player("G∆p CÈng C´ng t◊m hi”u nguy™n nh©n b t hoµ.")
    SetTask(Task_Conflict, 1)

    SetSubTask(999, 1, 1)

    TaskNote(999, 0)

    refreshNpcTaskState()

end;

function no()
    CloseDialog()
end;

function star_dark()
    CloseDialog()

    if (GetTaskByte(Task_star, 1) == 5 and GetTaskByte(Task_collect, 4) == 0 and GetLevel() >= 37) then

        TopMessage("ßang thu thÀp linh kh›")
        Msg2Player("ßang thu thÀp linh kh›.")
        local nInterrupt = 0
        nInterrupt = SetBit(nInterrupt, 1, 1)
        nInterrupt = SetBit(nInterrupt, 2, 1)
        nInterrupt = SetBit(nInterrupt, 3, 1)
        nInterrupt = SetBit(nInterrupt, 4, 1)
        nInterrupt = SetBit(nInterrupt, 5, 1)
        nInterrupt = SetBit(nInterrupt, 6, 0)
        nInterrupt = SetBit(nInterrupt, 9, 1)
        nInterrupt = SetBit(nInterrupt, 10, 1)

        BeginMotion(Task_collect - 503, 0, 5, "\\script\\motion\\ ’ºØ¡È∆¯.lua", nInterrupt)
    end
end


