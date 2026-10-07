Task__Wellthought = 1033;
Task_Destroy = 1038;
Destroy_Ani1 = 1039;
Destroy_Ani2 = 1040;
Destroy_Ani3 = 1041;
Destroy_Ani4 = 1042
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
    local startLevel = 10

    startLevel = 10
    if (GetLevel() >= startLevel) and (GetPlayerType() == 0) then
        local taskProcess = GetTask(1033)
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

    startLevel = 10
    if (GetLevel() >= startLevel) and (GetPlayerType() == 0) then
        if (GetLevel() - startLevel <= 5) then
            local taskProcess = GetTask(25)
            if (taskProcess == 0) then
                state = 1
                subState = 0
            elseif (taskProcess == 1) and (HaveEventItem(21) >= 1) and (HaveEventItem(22) >= 1) and (HaveEventItem(23) >= 1) then
                state = 3
                subState = 0
            elseif (taskProcess == 3) and (HaveEventItem(24) >= 1) then
                state = 3
                subState = 0
            elseif (taskProcess == 4) then
                state = 0
                subState = 0
            else
                state = 2
                subState = 0
            end
        else
            local taskProcess = GetTask(25)
            if (taskProcess == 0) then
                state = 1
                subState = 1
            elseif (taskProcess == 1) and (HaveEventItem(21) >= 1) and (HaveEventItem(22) >= 1) and (HaveEventItem(23) >= 1) then
                state = 3
                subState = 1
            elseif (taskProcess == 3) and (HaveEventItem(24) >= 1) then
                state = 3
                subState = 1
            elseif (taskProcess == 4) then
                state = 0
                subState = 0
            else
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 10
    if (GetLevel() >= startLevel) and (GetPlayerType() == 0) then
        local taskProcess = GetTask(1038)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 0) then
                state = 1
                subState = 0
            elseif (taskProcess == 1) then
                state = 2
                subState = 0
            elseif (taskProcess == 10) then
                state = 3
                subState = 0
            end
        else
            if (taskProcess == 0) then
                state = 1
                subState = 1
            elseif (taskProcess == 1) then
                state = 2
                subState = 0
            elseif (taskProcess == 10) then
                state = 3
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 18
    if (GetLevel() >= 10) and (GetPlayerType() == 0) then
        local taskProcess = GetTaskByte(Task_newer13, 2)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 1) then
                state = 3
                subState = 0
            elseif (taskProcess == 2) and (HaveNormalItem(3, 11, 0, 0) >= 5) and (HaveNormalItem(3, 10, 0, 0) >= 5) then
                state = 3
                subState = 0
            elseif (taskProcess == 2) then
                state = 2
                subState = 0
            elseif (taskProcess == 3) or (taskProcess == 4) then
                state = 0
                subState = 0
            end
        else
            if (taskProcess == 1) then
                state = 3
                subState = 1
            elseif (taskProcess == 2) and (HaveNormalItem(3, 11, 0, 0) >= 5) and (HaveNormalItem(3, 10, 0, 0) >= 5) then
                state = 3
                subState = 1
            elseif (taskProcess == 2) then
                state = 2
                subState = 0
            elseif (taskProcess == 3) or (taskProcess == 4) then
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

function main(sel)
    tasks = {

        { "<c=yel>M­u l­îc<c>", "SubmitThought"; show = 0 },
        { "<c=yel>Dòng §ao<c>", "renwu2"; show = 0 },
        { "<c=yel>Trõ yªu<c>", "AcceptDestroy"; show = 0 },
        { "Bá nhiÖm vô Trõ yªu", "giveup_Des"; show = 0 },
        { "<c=yel>VÜnh Trõ HËu Ho¹n<c>", "renwu18"; show = 0 }
    }

    UTask_15 = GetTask(25);

    if (GetTask(Task__Wellthought) == 1 and GetLevel() >= 10) then
        tasks[1].show = 1
    end
    if (HaveEventItem(24) >= 1) and (UTask_15 == 3) then
        tasks[2].show = 1;
    end ;
    if (HaveEventItem(21) >= 1) and (HaveEventItem(22) >= 1) and (HaveEventItem(23) >= 1) and (UTask_15 == 1) then
        tasks[2].show = 1;
    end ;
    if (UTask_15 == 0) and (GetPlayerType() == 0) and (GetLevel() >= 10) then
        tasks[2].show = 1;
    end ;
    local nTask_Des = GetTask(Task_Destroy)
    if ((nTask_Des == 0 and GetLevel() >= 10 and GetPlayerType() == 0) or nTask_Des == 10) then
        tasks[3].show = 1
    end
    if (HaveIBBuff(333) == 0 and nTask_Des > 0 and nTask_Des <= 10) then
        tasks[4].show = 1
    end
    if (GetPlayerType() == 0) then
        if ((GetTaskByte(Task_newer13, 2) == 2) or (GetTaskByte(Task_newer13, 2) == 5) or (GetTaskByte(Task_newer13, 2) == 1)) then
            tasks[5].show = 1;
        end
    end
    SayTask(10231, tasks)
end;

function SubmitThought()
    AddOwnExp(500)
    AddNormalItem(0, 0, 0, 1, 0, 0)
    SetTask(Task__Wellthought, 2)

    SetSubTask(905, -1, 1)

    TaskNote(905, -1)
    TopMessage(12577)
    Msg2Player("NhËn ®­îc 500 ®iÓm kinh nghiÖm, 1 Tr¶m T­íng §ao")

    refreshNpcTaskState()

    if (GetTask(Task__Wellthought) == 2) then
        SyncBibleState(905, 0, 1)
    end ;
    if (GetTask(25) == 0) then
        Talk(1, "TaskCourage", 12578)

    else
        Talk(1, "no", 12579)
    end
end
function TaskCourage()
    Task2 = {
        { "Dòng §ao", "renwu2"; show = 1 }
    }
    SayTask(10231, Task2)
end

function renwu1()
    UTask_10 = GetTask(20);
    if (UTask_10 == 10) then
        Talk(1, "no", 10232)
        Msg2Player("§· th«ng b¸o cho TriÒu §iÒn.")
        TaskNote(7, 4)
        SetTask(20, UTask_10 + 4)
    end ;
    if (UTask_10 == 11) then
        Talk(1, "no", 10232)
        Msg2Player("§· th«ng b¸o cho TriÒu §iÒn.")
        TaskNote(7, 7)
        SetTask(20, UTask_10 + 4)
    end ;
    if (UTask_10 == 12) then
        Talk(1, "no", 10232)
        Msg2Player("§· th«ng b¸o cho TriÒu §iÒn.")
        TaskNote(7, 6)
        SetTask(20, UTask_10 + 4)
    end ;
    if (UTask_10 == 13) then
        Talk(1, "no", 10232)
        Msg2Player("§· th«ng b¸o cho TriÒu §iÒn.")
        TaskNote(7, 8)
        SetTask(20, UTask_10 + 4)
    end ;
end;

function renwu2()
    UTask_15 = GetTask(25);
    if (HaveEventItem(24) >= 1) and (UTask_15 == 3) then
        Talk(1, "no", 10233)
        DelEventItem(24)
        AddOwnExp(1000)
        TopMessage(12580)
        Msg2Player("NhËn ®­îc 1000 ®iÓm kinh nghiÖm!")
        Msg2Player("Dòng ®ao ®· t¸i xuÊt thiªn h¹. NhËn ®­îc phÇn th­ëng cña TriÒu §iÒn.")

        SetSubTask(11, -1, 1)

        TaskNote(11, -1)
        SetTask(25, 4)
        if (GetTask(25) == 4) then
            SyncBibleState(11, 0, 1)
        end ;

        refreshNpcTaskState()

    end ;
    if (HaveEventItem(21) >= 1) and (HaveEventItem(22) >= 1) and (HaveEventItem(23) >= 1) and (UTask_15 == 1) then


        AddOwnExp(3800)

        TopMessage(12581)
        Msg2Player("NhËn 3800 kinh nghiÖm")
        Talk(1, "no", 10234)
        Msg2Player("Nhê T« Toµn Trung kh«i phôc linh lùc cho b¶o ®ao!")
        TaskNote(11, 8)
        SetTask(25, 2)

        refreshNpcTaskState()

    end ;
    if (UTask_15 == 0) and (GetPlayerType() == 0) and (GetLevel() >= 10) then
        MsgBox(10235, "yes_2", "no")
    end ;
end;
function Destroyer()
    task4 = {
        { "<c=yel>Trõ yªu<c>", "AcceptDestroy"; show = 1 }
    }
    SayTask(12582, task4)
end
function AcceptDestroy()
    local nTask_Des = GetTask(Task_Destroy)
    if (nTask_Des == 0 and GetPlayerType() == 0 and GetLevel() >= 10) then
        MsgBox(12583, "Yes_Destroy", "no")
    elseif (nTask_Des == 10) then
        SetTask(Task_Destroy, 11)
        AddOwnExp(2000)

        SetSubTask(903, -1, 1)

        TaskNote(903, -1)
        AddNormalItem(0, 2, 0, 1, 0, 0)
        TopMessage(12584)
        Msg2Player("NhËn ®­îc 2000 kinh nghiÖm vµ Hoµng ®ång HuyÒn Vò Gi¸p.")
        Talk(1, "no", 12585)
        if (GetTask(Task_Destroy) == 11) then
            SyncBibleState(903, 0, 1)
        end ;

        refreshNpcTaskState()

    end

end

function Yes_Destroy()
    CloseDialog()
    local nTask_Des = GetTask(Task_Destroy)
    if (nTask_Des == 0 and GetPlayerType() == 0 and GetLevel() >= 10) then
        SetTask(Task_Destroy, 1)

        SetSubTask(903, 1, 1)

        TaskNote(903, 0)
        AddNormalItem(6, 1, 275, 1, 0, 0)
        Msg2Player("B¹n nhËn ®­îc l­¬ng thùc")

        Talk(1, "no", 12586)

        refreshNpcTaskState()

    end
end

function yes_2()
    Talk(1, "no", "M¶nh ®ao gåm 3 bé phËn <c=g>l­ìi ®ao, th©n ®ao, c¸n ®ao<c>, cã thÓ ®Õn <c=g>YÕn S¬n<c> t×m <c=r>TÜnh Nh©n t­íng qu©n<c> ®o¹t vÒ, chØ cÇn tiªu diÖt TÜnh Nh©n t­íng qu©n, sÏ nhËn ®­îc <c=g>m¶nh ®ao<c>. §­êng ®i nguy hiÓm, ta tÆng ng­¬i <c=g>5 Håi thµnh phï<c>.")
    Msg2Player("NhËn ®­îc 5 Håi thµnh phï. §Õn YÕn S¬n tiªu diÖt TÜnh Nh©n t­íng qu©n, nhËn ®­îc m¶nh ®ao.")

    SetSubTask(11, 1, 1)

    TaskNote(11, 0)
    SetTask(25, 1)
    for i = 1, 5 do
        AddNormalItemPile(5, 0, 0, 1, 0, 0)
    end

    refreshNpcTaskState()

end;

function giveup_Des()
    SetTask(Task_Destroy, 0)
    SetTask(Destroy_Ani1, 0)
    SetTask(Destroy_Ani2, 0)
    SetTask(Destroy_Ani3, 0)
    SetTask(Destroy_Ani4, 0)
    TaskNote(903, -1)
    if (HaveNormalItem(6, 1, 275, 1) >= 1) then
        DelNormalItem(6, 1, 275, 1)
    end
    TopMessage(12142)
    CloseDialog()

    refreshNpcTaskState()

end
function no()
    CloseDialog()
end;

function renwu18()
    CloseDialog()
    local state18 = GetTaskByte(Task_newer13, 2)
    if (state18 == 1) then
        Talk(1, "renwu18", "<c=g>Tö Hµ phï <c> ®­¬ng nhiªn cã thÓ cho ng­¬i m­în, nh­ng hiÖn giê linh lùc cña nã kh«ng ®ñ, ta cÇn 5 <c=g>§o¶n kiÕm<c>, 5 <c=g>To¸i Gi¸p<c> míi cã thÓ gióp nã gia t¨ng linh lùc, ng­¬i h·y nhanh chãng t×m nguyªn liÖu vÒ ®i.")
        Msg2Player("T×m gióp TriÒu §iÒn 5 §o¹n KiÕm, 5 To¸i Gi¸p gia t¨ng linh lùc Tö Hµ Phï.")
        TaskNote(210, 1)
        SetTaskByte(Task_newer13, 2, 2)

        refreshNpcTaskState()

    elseif (state18 == 2) then
        MsgBox("Ta cÇn 5 <c=g>§o¶n kiÕm<c>, 5 <c=g>To¸i Gi¸p<c> míi cã thÓ gia t¨ng linh lùc <c=g>Tö Hµ phï <c>, ng­¬i mang nguyªn liÖu ®Õn ch­a?", "yes_drug", "no")
    elseif (state18 == 5) then
        local key = GetTaskWord(Task_newer13, 2)
        local nowtime = math.mod(SystemTime(), 2 ^ 16)
        if (key + 3 * 60 >= nowtime) then
            Talk(1, "no", "Ta cÇn ph¶i nghÜ ng¬i l©y l¹i søc míi cã thÓ tiÕp tôc phôc håi linh lùc <c=g>Tö Hµ phï <c>, anh hïng h·y quay l¹i sau.")
        else
            MsgBox("Phôc håi linh lùc <c=g>Tö Hµ phï <c> lÇn n÷a vÉn ph¶i cÇn 5 <c=g>§o¶n kiÕm<c> 5 <c=g>To¸i Gi¸p<c> ng­¬i chuÈn bÞ ®ñ ch­a?", "yes_drug1", "no")
        end
    end
end

function yes_drug()
    if (IsHaveSpaceForTreasure(1) < 1) then
        Talk(1, "no", "Hµnh trang cña ng­¬i ®· ®Çy, ta kh«ng thÓ giao <c=g>Tö Hµ phï <c> cho ng­¬i!")
        return 0
    end

    if (HaveNormalItem(3, 11, 0, 0) >= 5) and (HaveNormalItem(3, 10, 0, 0) >= 5) then
        for i = 1, 5 do
            DelNormalItem(3, 10, 0, 0)
            DelNormalItem(3, 11, 0, 0)
        end

        AddNormalItem(6, 1, 496, 0, 0, 0)
        SetTaskByte(Task_newer13, 2, 3)
        SetTaskWord(Task_newer13, 2, 0)
        Msg2Player("§Õn B¾c H¶i t×m §¹i Phu hái xem tung tÝch cña néi gi¸n.")
        Talk(1, "no", "xong råi, <c=g>Tö Hµ phï <c> ®· ®Çy ®ñ linh lùc. VÒ tung tÝch cña tªn néi gi¸n, ta nghÜ <c=r>§¹i phu B¾c h¶i<c> cã nhiÒu th«ng tin h¬n.")
        TaskNote(210, 2)

        refreshNpcTaskState()

    else
        Talk(1, "no", "Ta cÇn 5 <c=g>§o¶n kiÕm<c>, 5 <c=g>To¸i Gi¸p<c> míi cã thÓ bæ xung linh lùc <c=g>Tö Hµ phï <c>, ng­¬i h·y nhanh chãng t×m nguyªn liÖu vÒ ®i!")
    end
end

function yes_drug1()
    if (IsHaveSpaceForTreasure(1) < 1) then
        Talk(1, "no", "Hµnh trang cña ng­¬i ®· ®Çy, ta kh«ng thÓ giao <c=g>Tö Hµ phï <c> cho ng­¬i!")
        return 0
    end

    if (HaveNormalItem(3, 11, 0, 0) >= 5) and (HaveNormalItem(3, 10, 0, 0) >= 5) then
        for i = 1, 5 do
            DelNormalItem(3, 10, 0, 0)
            DelNormalItem(3, 11, 0, 0)
        end

        AddNormalItem(6, 1, 496, 0, 0, 0)
        SetTaskWord(Task_newer13, 2, 0)
        SetTaskByte(Task_newer13, 2, 4)
        Msg2Player("Tö Hµ Phï ®Çy ®ñ linh lùc råi, h·y mau ®i tiªu diÖt TriÖt gi¸p ph¶n ®å ®i.")
        Talk(1, "no", "xong råi, <c=g>Tö Hµ phï <c> ®· ®Çy ®ñ linh lùc råi, h·y mau ®i tiªu diÖt TriÖt gi¸p ph¶n ®å ®i.")
        TaskNote(210, 3)

        refreshNpcTaskState()

    else
        Talk(1, "no", "Ta cÇn 5 <c=g>§o¶n kiÕm<c>, 5 <c=g>To¸i Gi¸p<c> míi cã thÓ bæ sung linh lùc <c=g>Tö Hµ phï <c>, ng­¬i h·y mau ®i t×m nguyªn liÖu ®i!")
    end
end
