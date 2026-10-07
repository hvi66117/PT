Task_newer13 = 1416

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

    startLevel = 18
    if (GetLevel() >= startLevel) and (GetPlayerType() == 0) then
        local taskProcess = GetTaskByte(Task_newer13, 2)
        if (GetLevel() - startLevel <= 5) then
            if (GetTaskByte(Task_newer13, 1) == 5) and (taskProcess == 0) then
                state = 1
                subState = 0
            elseif (taskProcess == 6) then
                state = 3
                subState = 0
            elseif (taskProcess >= 1) and (taskProcess <= 5) then
                state = 2
                subState = 0
            end
        else
            if (GetTaskByte(Task_newer13, 1) == 5) and (taskProcess == 0) then
                state = 1
                subState = 1
            elseif (taskProcess == 6) then
                state = 3
                subState = 1
            elseif (taskProcess >= 1) and (taskProcess <= 5) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 25
    if (GetLevel() >= startLevel) and (GetPlayerType() == 0) then
        local taskProcess = GetTask(3)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 0) then
                state = 1
                subState = 0
            elseif (taskProcess == 2) and (HaveEventItem(11) == 1) then
                state = 3
                subState = 0
            elseif (taskProcess == 2) and (taskProcess == 1) then
                state = 2
                subState = 0
            end
        else
            if (taskProcess == 0) then
                state = 1
                subState = 1
            elseif (taskProcess == 2) and (HaveEventItem(11) == 1) then
                state = 3
                subState = 1
            elseif (taskProcess == 2) and (taskProcess == 1) then
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
        { "Trung Thµnh", "renwu1"; show = 0 },

        { "Phôc håi NhiÖm vô", "taskid"; show = 0 },
        { "Gi¶i Trõ HËu Ho¹n.", "renwu18"; show = 0 }
    }
    UTask_Knight = GetTask(3);
    UTask_11 = GetTask(21);

    if (UTask_Knight == 2) and (HaveEventItem(11) == 1) then
        tasks[1].show = 1;
    end ;
    if (GetPlayerType() == 0) and (GetLevel() >= 25) and (UTask_Knight == 0) then
        tasks[1].show = 1;
    end ;

    if (GetPlayerType() == 0) and (GetLevel() >= 18) and (GetTaskByte(Task_newer13, 1) == 5) then
        if (GetTaskByte(Task_newer13, 2) == 0) or (GetTaskByte(Task_newer13, 2) == 6) then
            tasks[3].show = 1;
        end
    end

    SayTask(10242, tasks)
end;

function taskid()
    Talk(1, "no", 11175)
end;

function fangchenmi()
    local state
    local mark

    state = GetWeakState()

    if (state < 2) then
        mark = 1
    else
        mark = 0
    end
    return mark
end

function renwu1()
    local mark = fangchenmi()
    UTask_Knight = GetTask(3);
    if (UTask_Knight == 2) and (HaveEventItem(11) == 1) then
        Talk(3, "no", 10243, 10244, 10245)
        DelEventItem(11)
        AddOwnExp(20000)
        Earn(30000)
        Msg2Player("Chøng minh ®­îc lßng trung thµnh cña TrÞnh Lu©n, nhËn ®­îc 20000 kinh nghiÖm vµ 30000 l­îng.")
        TopMessage(11719)
        SetTask(3, 10)
        TaskNote(27, 2)

        refreshNpcTaskState()

    end ;
    if (GetPlayerType() == 0) and (GetLevel() >= 25) and (UTask_Knight == 0) then
        if (mark == 1) then
            MsgBox(10246, "yes", "no")
        else
            Talk(1, "no", 11718)
        end
    end ;
end;

function renwu2()
    Talk(1, "no", 10247)
    Msg2Player("Sïng HÇu Hæ kh«ng chÞu ®æi nguyªn liÖu, ®i t×m Lç Hïng nghÜ c¸ch.")
    TaskNote(8, 4)
    SetTask(21, 5)
end;

function yes()
    Talk(1, "no", 10248)
    Msg2Player("§i gÆp TrÞnh Lu©n ®Ó th¨m dß t©m ý.")
    SetTask(3, 1)
    TaskNote(27, 0)

    refreshNpcTaskState()

end;

function no()
    CloseDialog()
end;

function renwu18()
    local state18 = GetTaskByte(Task_newer13, 2)

    if (state18 == 0) then
        MsgBox("bæn s­ ®· ®iÒu tra, tªn néi gi¸n ®ã kh«ng ph¶i lµ ng­êi trong thµnh, h¾n lµ ®Ö tö TriÖt Gi¸o hãa thµnh thµnh ng­êi trµ trén vµo trong qu©n li gi¸n néi bé, B¾c H¶i Ph¶n Qu©n còng v× thÕ mµ ph¶n quèc lµm lo¹n. Nay sù t×nh ®· b¹i lé, néi gi¸n ®· cao ch¹y xa bay, mong anh hïng h·y nhanh chèng tiªu diÖt h¾n.", "yes_drug", "no")
    elseif (state18 == 6) then
        Talk(2, "no", GetName() .. " Sïng t­íng qu©n, TriÖt gi¸o ph¶n ®å ®· bÞ ta tiªu diÖt råi.", "Lµm tèt l¾m, ng­¬i ®· lËp c«ng lín lÇn nµy!")

        SetSubTask(210, -1, 1)

        TaskNote(210, -1)
        SetTaskByte(Task_newer13, 2, 7)

        AddOwnExp(13000)
        Msg2Player("NhËn 1 trang bÞ cÊp 20 vµ 13000 kinh nghiÖm. ")
        TaskNote(210, 7)

        if (math.random(1, 2) == 1) then
            AddBlueEquip(0, 2, 0, 2, 0, 1, 1)
        else
            AddBlueEquip(0, 9, 0, 2, 0, 1, 1)
        end

        refreshNpcTaskState()

    end
end

function yes_drug()

    TaskNote(210, -1)
    for i = 1, 5 do
        AddNormalItemBind(3, 10, 0, 0, 0, 0, 1)
        AddNormalItemBind(3, 11, 0, 0, 0, 0, 1)
    end

    Talk(2, "no", GetName() .. " Xin t­íng quan yªn t©m, ta nhÊt ®Þnh tiªu diÖt h¾n ®Ó tÕ vong linh Sïng Thµnh ta.", "Néi gi¸n kh«ng ph¶i phµm nh©n, víi søc cña ng­¬i e r»ng kh«ng ®­îc, anh hïng cã thÓ t×m <c=r>TriÒu §iÒn<c> m­în b¶o vËt <c=g>Tö Hµ phï <c> ®Ó chÕ phôc h¾n.")
    Msg2Player("T×m TriÖu §iÒn m­în Tö Hµ Phï ®Ó tiªu diÖt TriÖt gi¸p ph¶n ®å.")
    SetTaskByte(Task_newer13, 2, 1)
    TaskNote(210, 0)

    refreshNpcTaskState()

    SetSubTask(210, 1, 1)

    TaskNote(210, 0)
end
