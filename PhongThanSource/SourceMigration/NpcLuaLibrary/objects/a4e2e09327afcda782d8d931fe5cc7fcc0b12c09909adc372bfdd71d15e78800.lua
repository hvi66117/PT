Task_zhongqiu = 1558

Gloal_zhongqiu_num = 257
TaskNote_zhongqiu = 1103

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
            if (UTask_cg_1 == 0 and GetLevel() >= 43) then
                state = 1
                subState = 0
            end

        else
            if (UTask_cg_1 == 0 and GetLevel() >= 43) then
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
        { "Minh Ch©u", "renwu1"; show = 0 },


    }

    UTask_cg_1 = GetTask(41);
    if (UTask_cg_1 == 0) and (GetLevel() >= 43) then
        tasks[1].show = 1;
    end ;

    SayTask(10036, tasks)
end;

function renwu1()
    Talk(2, "bujie", 10037, 10038)

end;

function bujie()
    Talk(2, "no", 10039, 10040)
    Msg2Player("T×m chñ tiÖm cÇm ®å dß la tin tøc §Þnh H¶i B¶o Ch©u.")
    TaskNote(20, 0)
    SetTask(41, 1)
    refreshNpcTaskState()
end;

function no()
    CloseDialog()
end;













