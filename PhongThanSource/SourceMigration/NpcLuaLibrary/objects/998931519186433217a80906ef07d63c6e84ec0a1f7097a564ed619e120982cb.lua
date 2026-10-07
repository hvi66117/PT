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
    if (GetLevel() >= startLevel) and (GetPlayerType() == 0) then
        local taskProcess = GetTask(3)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 1) then
                state = 3
                subState = 0
            end
        else
            if (taskProcess == 1) then
                state = 3
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 67
    if (GetLevel() >= startLevel) then
        local taskStatus = GetByte(GetTask(1233), 1)
        if (GetLevel() - startLevel <= 5) then
            if (taskStatus == 2 or taskStatus == 4) then
                state = 3
                subState = 0
            elseif (taskStatus == 5 or taskStatus == 3) then
                state = 0
                subState = 0
            end
        else
            if (taskStatus == 2 or taskStatus == 4) then
                state = 3
                subState = 1
            elseif (taskStatus == 5 or taskStatus == 3) then
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
    tasks = {
        { "Trung Thµnh", "renwu1"; show = 0 },
        { "Hanh C¸p NhÞ T­íng", "processHHEJ"; show = 0 },
    }
    UTask_Knight = GetTask(3);
    if (GetPlayerType() == 0) and (UTask_Knight == 1) then
        tasks[1].show = 1
    end ;
    if (isViewHHEJ() == 1) then
        tasks[2].show = 1;
    end
    SayTask(10284, tasks)
end;

function renwu1()
    Talk(1, "no", 10285)
    AddEventItem(11)
    SetTask(3, 2)
    Msg2Player("Mang huyÕt th­ cña TrÞnh Lu©n vÒ cho Sïng HÇu Hæ.")
    TaskNote(27, 1)

    refreshNpcTaskState()

end;

function no()
    CloseDialog()
end;

function isViewHHEJ()
    local taskStatus = GetByte(GetTask(1233), 1)
    if (taskStatus == 2 or taskStatus == 4) then
        return 1
    else
        return 0
    end
end

function processHHEJ()
    local taskStatus = GetByte(GetTask(1233), 1)
    local fixVoiceBead = HaveNormalItem(3, 235, 0, 0)
    if (fixVoiceBead == 0) then
        Talk(2, "no", 14444, GetName() .. ":…ChØ ®Õn th¨m T­íng qu©n th«i (quªn mang theo §Þnh ¢m Ch©u råi…)")
    elseif (taskStatus == 2) then
        Talk(4, "hengdone", GetName() .. ": T­íng qu©n! Cã viÖc khÈn cÊp!", "ChuyÖn g×?", GetName() .. ":TiÓu nh©n v« t×nh nghe ®­îc TrÇn Kú T­íng qu©n nãi: 'TrÞnh t­íng qu©n ch¼ng qua nhê may m¾n mµ th¾ng ®­îc nhiÒu trËn th«i, chø thùc ra ch¶ cã tµi c¸n g×…", "C¸i g×? TrÇn Kú d¸m khinh th­êng ta vËy sao? Sím muén g× ta còng tÝnh sæ nã! <c=g>Hõ!<c>")
    else
        Talk(4, "alldone", GetName() .. ": T­íng qu©n! Cã viÖc khÈn cÊp!", "ChuyÖn g×?", GetName() .. ":TiÓu nh©n v« t×nh nghe ®­îc TrÇn Kú T­íng qu©n nãi: 'TrÞnh t­íng qu©n ch¼ng qua nhê may m¾n mµ th¾ng ®­îc nhiÒu trËn th«i, chø thùc ra ch¶ cã tµi c¸n g×…", "C¸i g×? TrÇn Kú d¸m khinh th­êng ta vËy sao? Sím muén g× ta còng tÝnh sæ nã! <c=g>Hõ!<c>")
    end
end

function hengdone()
    SetTask(1233, SetByte(GetTask(1233), 1, 3))
    Talk(1, "no", GetName() .. ": (§· hót ®­îc chót Ýt ph¸p lùc råi, r¸ng thªm chót n÷a…haha..)")
    refreshNpcTaskState()
end

function alldone()
    local taskStatus = GetByte(GetTask(1233), 1)
    local fixVoiceBead = HaveNormalItem(3, 235, 0, 0)
    if (fixVoiceBead ~= 0 and (taskStatus == 4)) then
        DelNormalItem(3, 235, 0, 0)
        AddNormalItem(6, 1, 363, 0, 0, 0)
        SetTask(1233, SetByte(GetTask(1233), 1, 5))
        TaskNote(1013, 2)
        Talk(1, "no", GetName() .. ":( Ph¸p lùc ®· sung m·n råi, ta vÒ phôc mÖnh th«i! Haha!)")
        refreshNpcTaskState()
    end
end

