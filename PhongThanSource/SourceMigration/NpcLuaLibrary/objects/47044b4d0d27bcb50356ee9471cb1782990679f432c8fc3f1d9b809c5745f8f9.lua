Task_prepare = 1537

Task_anotherID = 1538
Task_item = 1539
Task_stage = 1540

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

    startLevel = 27
    if (GetLevel() >= startLevel) then
        local UTask_world_2 = GetTask(92)
        if (GetLevel() - startLevel <= 5) then
            if (UTask_world_2 == 0) then
                state = 1
                subState = 0
            elseif (UTask_world_2 == 5 and GetMorphType() == 249) then
                state = 3
                subState = 0
            elseif (UTask_world_2 >= 1 and UTask_world_2 <= 5) then
                state = 2
                subState = 0

            end
        else
            if (UTask_world_2 == 0) then
                state = 1
                subState = 1
            elseif (UTask_world_2 == 5 and GetMorphType() == 249) then
                state = 3
                subState = 1
            elseif (UTask_world_2 >= 1 and UTask_world_2 <= 5) then
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
        { "Phu Thª", "renwu1"; show = 0 },
        { "Hñy bá nhiÖm vô Phu Thª", "renwu2"; show = 0 },

    }
    UTask_world_2 = GetTask(92);
    if (UTask_world_2 == 5) and (GetMorphType() == 249) then
        tasks[1].show = 1;
    end ;
    if (UTask_world_2 == 0) and (GetLevel() >= 27) then
        tasks[1].show = 1;
    end ;

    if (UTask_world_2 ~= 0) and (UTask_world_2 ~= 6) then
        tasks[2].show = 1;
    end

    SayTask(10436, tasks)
end;

function renwu1()
    UTask_world_2 = GetTask(92);
    if (UTask_world_2 == 5) then
        if (GetMorphType() == 249) then
            Talk(1, "no", 10437)
            AddWeightMax(20)
            AddOwnExp(50000)
            Msg2Player("Gióp v¬ chång NhËm §¹i Ca, nhËn ®­îc 50000 ®iÓm kinh nghiÖm vµ 20 ®iÓm søc lùc!")
            TopMessage(11926)

            SetSubTask(26, -1, 1)
            TaskNote(26, -1)
            SetTask(92, 6)
            refreshNpcTaskState()
        end ;
    end ;
    if (UTask_world_2 == 0) and (GetLevel() >= 17) then

        Talk(3, "func_check", 10438, GetName() .. ":§¹i tÈu cã viÖc xin cø nãi. ChØ cÇn lµm ®­îc, ta nhÊt ®Þnh kh«ng chèi tõ.", 10440)

    end ;
end;

function renwu2()
    Msg2Player("§· hñy bá nhiÖm vô Phu Thª")
    TaskNote(26, -1)
    SetTask(92, 0)
    CloseDialog()
    refreshNpcTaskState()
end

function func_check()

    Talk(2, "func_check1", GetName() .. ":§¹i tÈu, víi n¨ng lùc cña ta hiÖn t¹i kh«ng thÓ ch÷a khái cho ®¹i ca.", 10442)

end;

function func_check1()

    MsgBox(GetName() .. "T×m 1 <color=yellow>Phi Thè<color> vµ 1 <color=yellow>Ngäc N÷<color> kh«ng ph¶i chuyÖn dÔ. Cã thËt ®ång ý gióp NhËm ®¹i tÈu kh«ng?", "yes_1", "no")

end;

function yes_1()

    Talk(1, "no", GetName() .. ":§¹i tÈu yªn t©m, ta ®i t×m D­¬ng TiÔn huynh ®Ö, nhÊt ®Þnh nhanh chãng t×m ®­îc <color=yellow>Phi Thè<color> vµ <color=yellow>Ngäc N÷<color>.")

    Msg2Player("Lµm sao ®Ó b¾t Phi Thè vµ Ngäc N÷? Ph¶i ®i thØnh gi¸o D­¬ng TiÔn th«i.")
    TaskNote(26, 0)
    SetTask(92, 1)
    SetSubTask(26, 1, 1)
end;

function no()
    CloseDialog()
end;






















































































