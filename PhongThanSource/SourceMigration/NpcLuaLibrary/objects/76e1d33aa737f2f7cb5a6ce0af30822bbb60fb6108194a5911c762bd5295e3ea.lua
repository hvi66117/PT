--description: æ§¼º-Ö÷Ïß?Îñ
--author: yichuan
--date:2004/5/8

-- AS GaoJingwei at 090728 
NpcState = {
    [1] = { state = 3, subState = 0, str = "Vµng më" },
    [2] = { state = 3, subState = 1, str = "Lam më" },
    [3] = { state = 1, subState = 0, str = "Vµng ®ãng" },
    [4] = { state = 1, subState = 1, str = "Lam ®ãng" },
    [5] = { state = 2, subState = 0, str = "X¸m më" },
    [6] = { state = 0, subState = 0, str = "Kh«ng cã nhiÖm vô" },
}

--ËÑË÷ÓÅÏÈ¼¶×î¸ßµÄ×´Ì¬
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

--½Å±¾ÅÐ¶ÏÍæ¼ÒµÄ×´Ì¬
function GetNpcTaskSatate()
    local state = 0
    local subState = 0
    local index = 10
    local startLevel = 1

    --¹ÅÍù½ñÀ´
    startLevel = 80
    if (GetLevel() >= startLevel) then
        local taskKnight = GetTask(3)
        local taskWizard = GetTask(1)
        local taskDruid = GetTask(2)

        if (GetLevel() - startLevel <= 5) then
            if (taskKnight == 71) or (taskWizard == 71) or (taskDruid == 71) then
                state = 3
                subState = 0
            end
        else
            if (taskKnight == 71) or (taskWizard == 71) or (taskDruid == 71) then
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

--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    local state, subState = GetNpcTaskSatate()
    return state, subState
end

--Ë¢ÐÂnpcµÄ×´Ì¬
function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end
-- AE GaoJingwei at 090728 end

function main()
    tasks = {
        { "Cæ Kim", "renwu1"; show = 0 },
        { "§Õn Diªu Tr×", "renwu2"; show = 1 }
    }
    UTask_Wizard = GetTask(1);
    UTask_Knight = GetTask(3);
    UTask_Druid = GetTask(2);
    if (GetLevel() >= 80) then

        if (UTask_Wizard == 71) or (UTask_Druid == 71) or (UTask_Knight == 71) then
            tasks[1].show = 1
        end ;
    end ;

    SayTask(10375, tasks)
end;

function renwu1()
    Talk(1, "no", 10376)
    Msg2Player("§Õn Ngäc H­ Cung 10 n¨m tr­íc ®Ó t×m Nguyªn Thñy Thiªn T«n")
    if (GetPlayerType() == 2) then
        SetTask(2, 72)
        TaskNote(29, 27)
    end ;
    if (GetPlayerType() == 1) then
        SetTask(1, 72)
        TaskNote(28, 32)
    end ;
    if (GetPlayerType() == 0) then
        SetTask(3, 72)
        TaskNote(27, 28)
    end ;

    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end;

function no()
    CloseDialog()
end;

function renwu2()
    local i = random(1, 3)
    if (i == 1) then
        NewWorld(52, 1541, 3190)
    end ;
    if (i == 2) then
        NewWorld(52, 1556, 3202)
    end ;
    if (i == 3) then
        NewWorld(52, 1540, 3205)
    end ;
    SetFightState(0)
    CloseDialog()
end;
