--description: æ∆µÍ¿œªŒ-“Ï?÷˜œﬂ?ŒÒ
--author: yichuan
--date:2004/5/13

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
    local startLevel = 1

    --æ∆≤ª◊Ì»À
    startLevel = 35
    if (GetLevel() >= startLevel) and (GetPlayerType() == 2) then
        local taskProcess = GetTask(2)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 12) then
                state = 3
                subState = 0
            end
        else
            if (taskProcess == 12) then
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

function main()
    tasks = {
        { "B t TÛy", "renwu1"; show = 0 }
    }
    UTask_Druid = GetTask(2);
    if (GetLevel() >= 35) and (UTask_Druid == 12) then
        tasks[1].show = 1;
    end ;
    SayTask(11123, tasks)
end;

function renwu1()

    Talk(1, "no", 11124)
    AddEventItem(16)
    SetTask(2, 13)
    TaskNote(29, 5)
    Msg2Player("NhÀn Æ≠Óc 1 ch–n canh tÿnh r≠Óu.")
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end;

function no()
    CloseDialog()
end;
