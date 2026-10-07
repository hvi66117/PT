--description: À’ª§
--author: yichuan
--date: 2004/5/14
Task_BeCare = 1025;
Task__Wellthought = 1033;
Task_ReadBook = 1035;

-- AS GaoJingwei at 090728 
NpcState = {
    [1] = { state = 3, subState = 0, str = "Vµng mÎ" },
    [2] = { state = 3, subState = 1, str = "Lam mÎ" },
    [3] = { state = 1, subState = 0, str = "Vµng Æ„ng" },
    [4] = { state = 1, subState = 1, str = "Lam Æ„ng" },
    [5] = { state = 2, subState = 0, str = "X∏m mÎ" },
    [6] = { state = 0, subState = 0, str = "Kh´ng c„ nhi÷m vÙ" },
}

--À—À˜”≈œ»º∂◊Ó∏ﬂµƒ◊¥Ã¨
function searchForIndex(state, subState, index)
    for i = 1, getn(NpcState) do
        if (i > index) then
            break
        end

        if (state == NpcState[i].state) and (subState == NpcState[i].subState) then
            index = i
        end
    end
    return index
end

--Ω≈±æ≈–∂œÕÊº“µƒ◊¥Ã¨
function GetNpcTaskSatate()
    local state = 0
    local subState = 0
    local index = 10
    local startLevel = 3

    --–°–ƒ“Ì“Ì
    if (GetLevel() >= 3) and (GetPlayerType() == 0) then
        if (GetLevel() - startLevel <= 5) then
            local taskProcess = GetTask(1025)
            if (HaveEventItem(188) > 0) and (taskProcess == 1) then
                state = 3
                subState = 0
            elseif (taskProcess == 1) then
                state = 2
                subState = 0
            elseif (taskProcess == 2) then
                state = 0
                subState = 0
            end
        else
            local taskProcess = GetTask(1025)
            if (HaveEventItem(188) > 0) and (taskProcess == 1) then
                state = 3
                subState = 1
            elseif (taskProcess == 1) then
                state = 2
                subState = 0
            elseif (taskProcess == 2) then
                state = 0
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --±©”Í÷Æ∫Û
    startLevel = 6
    if (GetLevel() >= 6) and (GetPlayerType() == 0) then
        if (GetLevel() - startLevel <= 5) then
            local taskProcess = GetTask(20)
            if (taskProcess == 0) then
                state = 1
                subState = 0
            elseif (taskProcess == 14) and (HaveEventItem(26) >= 1) then
                state = 3
                subState = 0
            elseif (taskProcess == 20) then
                state = 0
                subState = 0
            else
                state = 2
                subSta = 0
            end
        else
            local taskProcess = GetTask(20)
            if (taskProcess == 0) then
                state = 1
                subState = 1
            elseif (taskProcess == 14) and (HaveEventItem(26) >= 1) then
                state = 3
                subState = 1
            elseif (taskProcess == 20) then
                state = 0
                subState = 0
            else
                state = 2
                subSta = 0
            end
        end
        index = searchForIndex(state, subState, index)
    end

    --◊Œ◊Œ≤ªæÎ
    startLevel = 6
    if (GetLevel() >= startLevel) and (GetPlayerType() == 0) then
        if (GetLevel() - startLevel <= 5) then
            local taskProcess = GetTask(Task_ReadBook)
            if (taskProcess == 0) then
                state = 1
                subState = 0
            elseif (taskProcess == 1) and (HaveNormalItem(7, 24, 27, 0) >= 1) then
                state = 3
                subState = 0
            elseif (taskProcess == 2) then
                state = 0
                subState = 0
            else
                state = 2
                subState = 0
            end
        else
            local taskProcess = GetTask(Task_ReadBook)
            if (taskProcess == 0) then
                state = 1
                subState = 1
            elseif (taskProcess == 1) and (HaveNormalItem(7, 24, 27, 0) >= 1) then
                state = 3
                subState = 1
            elseif (taskProcess == 2) then
                state = 0
                subState = 0
            else
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --–ÿ”–≥…÷Ò
    startLevel = 6
    if (GetLevel() >= startLevel) and (GetPlayerType() == 0) then
        if (GetLevel() - startLevel <= 5) then
            local taskProcess = GetTask(1033)
            if (taskProcess == 0) and (GetTask(20) == 20) then
                state = 1
                subState = 0
            end
        else
            local taskProcess = GetTask(Task_ReadBook)
            if (taskProcess == 0) and (GetTask(20) == 20) then
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

--»°µ√npcµƒ◊¥Ã¨
function GetPlayerTaskState()
    local state, subState = GetNpcTaskSatate()
    return state, subState
end

--À¢–¬npcµƒ◊¥Ã¨
function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end
-- AE GaoJingwei at 090728 end	

function main(sel)
    tasks = {
        { "<c=yel>C»n thÀn<c>", "BeCare"; show = 0 },
        { "<c=yel>HÈp g m<c>", "renwu1"; show = 0 },
        { "<c=yel>C«n m…n<c>", "ReadBook"; show = 0 },
        { "<c=yel>M≠u l≠Óc<c>", "AcceptThought"; show = 0 }
    }
    UTask_10 = GetTask(20);
    if (UTask_10 == 14) and (HaveEventItem(26) >= 1) then
        tasks[2].show = 1;
    end ;
    if (UTask_10 == 0 and GetLevel() >= 6 and GetPlayerType() == 0) then
        tasks[2].show = 1;
    end ;
    if (UTask_10 == 20 and GetTask(Task__Wellthought) == 0 and GetPlayerType() == 0) then
        tasks[4].show = 1
    end
    if (GetTask(Task_BeCare) == 1 and HaveEventItem(188) >= 1) then
        tasks[1].show = 1
    end
    local UTask_Read = GetTask(Task_ReadBook)
    if ((GetLevel() >= 6 and GetPlayerType() == 0 and UTask_Read == 0) or (UTask_Read == 1 and HaveNormalItem(7, 24, 27, 0) >= 1)) then
        tasks[3].show = 1
    end
    SayTask(10271, tasks)
end;
function ReadBook()
    local UTask_Read = GetTask(Task_ReadBook)
    if (UTask_Read == 0) then
        MsgBox(12494, "AcceptRead", "no")

    elseif (UTask_Read == 1 and HaveNormalItem(7, 24, 27, 0) >= 1) then
        AddOwnExp(400)
        SetTask(Task_ReadBook, 2)
        TaskNote(904, -1)
        --AS GaoJingwei 090730
        SetSubTask(904, -1, 1)
        --AE GaoJingwei 090730
        TopMessage(11947)
        Talk(1, "no", 12495)
        if (GetTask(Task_ReadBook) == 2) then
            SyncBibleState(904, 0, 1)
        end ;
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    end

end
function AcceptRead()
    --AS GaoJingwei 090730
    SetSubTask(904, 1, 1)
    --AE GaoJingwei 090730
    TaskNote(904, 0)
    SetTask(Task_ReadBook, 1)
    Msg2Player("ß’n V‚ s≠ mua T’ Huy’t Tr∂m.")
    Talk(1, "no", 12496)
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
    --						AddEventItem(26)
    --						
end
function BeCare()
    if (GetTask(Task_BeCare) == 1 and HaveEventItem(188) >= 1) then
        DelEventItem(188)
        AddOwnExp(100)
        --AS GaoJingwei 090730
        SetSubTask(906, -1, 1)
        --AE GaoJingwei 090730
        TaskNote(906, -1)
        SetTask(Task_BeCare, 2)
        TopMessage(12130)
        Msg2Player("Hoµn thµnh nhi÷m vÙ, nhÀn Æ≠Óc 100 Æi”m kinh nghi÷m")
        if (GetTask(Task_BeCare) == 2) then
            SyncBibleState(906, 0, 1)
        end ;
        if (GetTask(20) == 0 and GetLevel() >= 6) then
            Talk(1, "AcceptRain", 12497)

        else
            Talk(1, "no", 12498)
        end
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    end

end
function AcceptRain()
    tasks1 = {
        { "<c=yel>HÈp g m<c>", "renwu1"; show = 1 },
        { "<c=yel>C«n m…n<c>", "ReadBook"; show = 1 }
    }
    SayTask(10271, tasks1)
end
function renwu1()
    UTask_10 = GetTask(20);
    if (UTask_10 == 14) and (HaveEventItem(26) >= 1) then
        DelEventItem(26)
        AddNormalItem(1, 0, 1, 1, 0, 0)
        AddNormalItem(1, 0, 1, 1, 0, 0)
        AddNormalItem(1, 0, 1, 1, 0, 0)
        AddNormalItem(1, 3, 1, 1, 0, 0)
        AddNormalItem(1, 3, 1, 1, 0, 0)
        AddNormalItem(1, 3, 1, 1, 0, 0)
        AddNormalItem(0, 5, 0, 1, 0, 0)
        AddOwnExp(500)
        Talk(1, "Wellthought", 12499)
        TopMessage(12500)
        Msg2Player("GiÛp T´ HÈ l y hÈp g m v“, nhÀn Æ≠Óc Huy“n VÚ Chi’n Ngoa!")
        --AS GaoJingwei 090730
        SetSubTask(7, -1, 1)
        --AE GaoJingwei 090730
        TaskNote(7, -1)
        SetTask(20, 20)
        if (GetTask(20) == 15) then
            SyncBibleState(7, 0, 1)
        end ;
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    end ;
    if (UTask_10 == 0) then
        MsgBox(10273, "yes_1", "no")
    end ;
end;

function yes_1()
    Talk(1, "no", 10274)
    Msg2Player("ß’n ThÒ khË l y hÈp g m v“ cho T´ HÈ.")
    --AS GaoJingwei 090730
    SetSubTask(7, 1, 1)
    --AE GaoJingwei 090730
    TaskNote(7, 0)
    SetTask(20, 1)
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end;

function Wellthought()
    Task1 = {
        { "<c=yel>M≠u l≠Óc<c>", "AcceptThought"; show = 1 },
        { "<c=yel>C«n m…n<c>", "ReadBook"; show = 0 }
    }
    local UTask_Read = GetTask(Task_ReadBook)
    if ((GetLevel() >= 6 and GetPlayerType() == 0 and UTask_Read == 0) or (UTask_Read == 1 and HaveNormalItem(7, 24, 27, 0) >= 1)) then
        tasks[2].show = 1
    end
    SayTask(12501, Task1)
end
function AcceptThought()
    MsgBox(12502, "YesThought", "no")
end
function YesThought()
    SetTask(Task__Wellthought, 1)
    --AS GaoJingwei 090730
    SetSubTask(905, 1, 1)
    --AE GaoJingwei 090730
    TaskNote(905, 0)
    Talk(1, "no", 12503)
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end

function no()
    CloseDialog()
end;
