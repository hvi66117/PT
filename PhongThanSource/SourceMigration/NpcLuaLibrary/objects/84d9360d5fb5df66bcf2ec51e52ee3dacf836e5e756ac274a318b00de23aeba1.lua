Task_Zongxian = 1072;
Task_qianxin = 1104;
Task_Book = 1073;

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

    startLevel = 1
    if (GetLevel() >= startLevel) and (GetPlayerType() == 1) then
        if (GetLevel() - startLevel <= 5) then
            local taskProcess = GetTask(10)
            if (taskProcess == 1) or (taskProcess == 2) then
                state = 3
                subState = 0
            elseif (taskProcess == 3) or (taskProcess == 4) then
                state = 0
                subState = 0
            end
        else
            local taskProcess = GetTask(10)
            if (taskProcess == 1) or (taskProcess == 2) then
                state = 3
                subState = 1
            elseif (taskProcess == 3) or (taskProcess == 4) then
                state = 0
                subState = 0
            end
        end
        index = searchForIndex(state, subState, index)
    end

    startLevel = 3
    if (GetLevel() >= startLevel) and (GetPlayerType() == 1) then
        if (GetLevel() - startLevel <= 5) then
            local taskProcess = GetTask(Task_Zongxian)
            if (taskProcess == 1) and (HaveNormalItem(3, 141, 0, 0)) then
                state = 3
                subState = 0
            elseif (taskProcess == 2) then
                state = 0
                subState = 0
            end
        else
            local taskProcess = GetTask(Task_Zongxian)
            if (taskProcess == 1) and (HaveNormalItem(3, 141, 0, 0)) then
                state = 3
                subState = 1
            elseif (taskProcess == 2) then
                state = 0
                subState = 0
            end
        end
        index = searchForIndex(state, subState, index)
    end

    startLevel = 3
    if (GetLevel() >= 3) and (GetPlayerType() == 1) then
        if (GetLevel() - startLevel <= 5) then
            local taskProcess = GetTask(Task_Book)
            if (taskProcess == 0) then
                state = 1
                subState = 0
            elseif (taskProcess == 1) and (HaveNormalItem(7, 0, 3, 0) >= 1 or IsSkillActived(3) >= 1) then
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
            local taskProcess = GetTask(Task_Book)
            if (taskProcess == 0) then
                state = 1
                subState = 1
            elseif (taskProcess == 1) and (HaveNormalItem(7, 0, 3, 0) >= 1 or IsSkillActived(3) >= 1) then
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

    startLevel = 6
    if (GetLevel() >= startLevel) and (GetPlayerType() == 1) then
        local taskProcess = GetTask(15)

        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 0) then
                state = 1
                subState = 0
            end
        else
            if (taskProcess == 0) then
                state = 1
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 10
    if (GetLevel() >= startLevel) and (GetTask(15) >= 2) and (GetPlayerType() == 1) then
        local taskProcess = GetTask(15)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 2) then
                state = 1
                subState = 0
            elseif (taskProcess == 6) then
                state = 3
                subState = 0
            elseif (taskProcess == 5) then
                state = 2
                subState = 0
            end
        else
            if (taskProcess == 2) then
                state = 1
                subState = 1
            elseif (taskProcess == 6) then
                state = 3
                subState = 1
            elseif (taskProcess == 5) then
                state = 2
                subState = 0
            end
        end
        index = searchForIndex(state, subState, index)
    end

    startLevel = 6
    if (GetLevel() >= startLevel) and (GetPlayerType() == 1) then
        if (GetLevel() - startLevel <= 5) then
            local taskProcess = GetTask(Task_qianxin)
            if (taskProcess == 0) and (GetTask(15) == 7) then
                state = 1
                subState = 0
            elseif (taskProcess == 1) then
                state = 0
                subState = 0
            end
        else
            local taskProcess = GetTask(Task_qianxin)
            if (taskProcess == 0) and (GetTask(15) == 7) then
                state = 1
                subState = 1
            elseif (taskProcess == 1) then
                state = 0
                subState = 0
            end
        end
        index = searchForIndex(state, subState, index)
    end

    startLevel = 73
    if (GetLevel() >= startLevel) then
        local taskStatus = GetByte(GetTask(TASK_ID_LEAK), 1)
        if (GetLevel() - startLevel <= 5) then
            if (taskStatus == 2) then
                state = 3
                subState = 0
            elseif (taskStatus == 4) then
                state = 3
                subState = 0
            elseif (taskStatus > 2 and taskStatus < 4) then
                state = 2
                subState = 0
            end
        else
            if (taskStatus == 2) then
                state = 3
                subState = 1
            elseif (taskStatus == 4) then
                state = 3
                subState = 1
            elseif (taskStatus > 2 and taskStatus < 4) then
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
        { "<c=yel>B¸ch Lý<c>", "renwu2"; show = 0 },
        { "<c=yel>Kh¶o nghiÖm míi<c>", "renwuNewTest"; show = 0 },
        { "<c=yel>Kh¶o nghiÖm<c>", "renwu1"; show = 0 },
        { "<c=yel>Tu luyÖn<c>", "qianxin"; show = 0 },
        { "MËt LÖnh", "processLeakOrder"; show = 0 },
        { "<c=yel>CÇn mÉn<c>", "zizibujuan"; show = 0 },
    }
    local UTask_00 = GetTask(10);
    if (UTask_00 == 1) or (UTask_00 == 2) then
        tasks[1].show = 1;
    end ;
    UTask_05 = GetTask(15);
    if (GetPlayerType() == 1) and (UTask_05 == 6) then
        tasks[3].show = 1;
    end ;
    if (GetPlayerType() == 1) and (UTask_05 == 2) then
        tasks[3].show = 1;
    end ;
    if (UTask_05 == 0) and (GetPlayerType() == 1) and (GetLevel() >= 6) then
        tasks[3].show = 1;
    end ;
    if (GetTask(Task_Zongxian) == 1 and HaveNormalItem(3, 141, 0, 0) >= 1) then
        tasks[2].show = 1
    end
    if (UTask_05 == 7 and GetTask(Task_qianxin) == 0) then
        tasks[4].show = 1
    end
    if (isViewLeakOrder() == 1) then
        tasks[5].show = 1;
    end ;

    if (GetPlayerType() == 1) then
        local nTaskStatus = GetTask(Task_Book)
        if ((nTaskStatus == 0 and GetLevel() >= 3) or (nTaskStatus == 1 and (HaveNormalItem(7, 0, 3, 0) >= 1 or IsSkillActived(3) >= 1))) then
            tasks[6].show = 1
        end
    end
    SayTask(10519, tasks)
end;

function qianxin()
    MsgBox(12128, "AcceptQianxin", "no")
end
function AcceptQianxin()
    SetTask(Task_qianxin, 1)

    SetSubTask(911, 1, 1)

    TaskNote(911, 0)
    Talk(1, "no", 12129)

    refreshNpcTaskState()


end
function ARenwuWenru()
    Tasks3 = {
        { "<c=yel>Kh¶o nghiÖm<c>", "renwu1"; show = 0 }
    }
    if (GetTask(15) == 0) and (GetPlayerType() == 1) and (GetLevel() >= 6) then
        Tasks3[1].show = 1;
    end ;
    SayTask(10519, Tasks3)

end
function renwuNewTest()
    DelNormalItem(3, 141, 0, 0)
    AddOwnExp(100)
    TopMessage(12130)
    Msg2Player("NhËn ®­îc 100 ®iÓm kinh nghiÖm.")
    SetTask(Task_Zongxian, 2)
    TaskNote(895, -1)

    SetSubTask(895, -1, 1)

    if (GetTask(15) == 0 and GetLevel() >= 6) then
        Talk(1, "ARenwuWenru", 12131)
    else
        Talk(1, "no", 12132)
    end

    refreshNpcTaskState()

end
function renwu2()
    local UTask_00 = GetTask(10);
    if (UTask_00 == 1) then
        AddOwnExp(50)
        TopMessage(12133)
        Msg2Player("NhËn ®­îc 50 ®iÓm kinh nghiÖm.")
        Talk(1, "no", 10539)
        TaskNote(1, 2)
        Msg2Player("V©n Trung Tö ®· chän ®­îc ®Ö tö t©m ®¾c.")
        SetTask(10, 3)

        refreshNpcTaskState()

    end ;
    if (UTask_00 == 2) then
        AddOwnExp(50)
        TopMessage(12133)
        Msg2Player("NhËn ®­îc 50 ®iÓm kinh nghiÖm.")
        Talk(1, "no", 10539)
        TaskNote(1, 3)
        Msg2Player("V©n Trung Tö ®· chän ®­îc ®Ö tö t©m ®¾c! H·y b¸o cho Tõ Hµng ®¹o nh©n biÕt chuyÖn!")
        SetTask(10, 4)

        refreshNpcTaskState()

    end ;
end
function AskQianxin()
    local tasks20 = {
        { "<c=yel>Tu luyÖn<c>", "qianxin"; show = 1 }
    }
    SayTask(10519, tasks20)

end
function renwu1()
    UTask_05 = GetTask(15);
    if (GetPlayerType() == 1) and (UTask_05 == 6) then
        AddNormalItem(0, 5, 1, 1, 0, 0)
        AddOwnExp(1200)

        SetTask(15, 7)
        TopMessage("NhËn ®­îc Thiªn QuyÒn Lý+1200 kinh nghiÖm")
        Msg2Player("Hoµn thµnh kh¶o nghiÖm cña V©n Trung Tö, nhËn ®­îc Thiªn QuyÒn Lý vµ 1200 kinh nghiÖm")

        SetSubTask(5, -1, 1)

        TaskNote(5, -1)
        Talk(1, "AskQianxin", "V¨n ®¸p Vâ ®Êu ng­¬i ®Òu ®· th«ng qua. Xem ra ng­¬i còng cã chót tu hµnh nhÊt ®Þnh<enter><c=r>Quªn n÷a! Håi thµnh phï cã thÓ mau ë T¹p hãa Th­¬ng trong c¸c thµnh thÞ, cã ®i ®i vÒ sÏ rÊt thuËn tiÖn!")

        refreshNpcTaskState()

    end ;
    if (GetPlayerType() == 1) and (UTask_05 == 2) then
        if (GetLevel() >= 10) then
            Talk(1, "no", "V¨n ®· th«ng. B©y giê ®Õn vâ. Tr­íc kia ta ®· th¶ ë <c=r>Thñ D­¬ng s¬n<c> 1 con <c=r>TuyÕt Nguyªn Cù Thó<c>, h·y ®i b¾t nã vÒ! §­êng xa nguy hiÓm, tÆng ng­¬i <c=g>5 Håi thµnh phï<c> nµy ®Ó tiÖn ®i l¹i!")
            SetTask(15, 5)
            for i = 1, 5 do
                AddNormalItemPile(5, 0, 0, 1, 0, 0)
            end
            Msg2Player("NhËn ®­îc 5 Håi thµnh phï. TiÕp nhËn thö th¸ch cña V©n Trung Tö, ®i Thñ D­¬ng S¬n b¾t TuyÕt Nguyªn Cù Thó.")
            TaskNote(5, 2)

            refreshNpcTaskState()

        else
            Talk(1, "no", "Vâ kh¶o t­¬ng ®èi nguy hiÓm, kiÕn nghÞ ng­¬i sau cÊp 10 h·y ®Õn khiªu chiÕn!")
        end
    end ;
    if (UTask_05 == 0) and (GetPlayerType() == 1) and (GetLevel() >= 6) then
        MsgBox(10522, "yes_1", "no")
    end ;
end;

function yes_1()
    MsgBox(10523, "no")
    SetTask(15, 1)
    Msg2Player("NhËn kh¶o nghiÖm cña V©n Trung Tö, t×m Linh B¶o ®¹i ph¸p s­ thi v¨n!")

    SetSubTask(5, 1, 1)

    TaskNote(5, 0)

    refreshNpcTaskState()

end;

function no()
    CloseDialog()
end;

TASK_ID_LEAK = 1234
TASK_INFO_ID_LEAK = 1015
MOVE_POS_ARRAY = {
    { map = 23, x = 1528, y = 3030 },
    { map = 23, x = 1519, y = 3019 },
}

function isViewLeakOrder()
    local taskStatus = GetByte(GetTask(TASK_ID_LEAK), 1)
    if (taskStatus == 2 or taskStatus == 3 or taskStatus == 4) then
        return 1
    else
        return 0
    end
end

function processLeakOrder()
    local taskStatus = GetByte(GetTask(TASK_ID_LEAK), 1)
    if (taskStatus == 2) then
        Talk(2, "indroLeakOrder", 14586, "Ph¸p b¶o sÏ gióp ng­¬i t¨ng n¨ng lùc, nh­ng thêi gian vµ sè lÇn sö dông cã h¹n. Ng­¬i cÇn ph¶i cã sù tÝnh to¸n khi sö dông!")
    elseif (taskStatus == 3) then
        MsgBox(14587, "reAcceptLeakOrder", "no")
    else
        return finishLeakOrder()
    end
end

function indroLeakOrder()
    MsgBox(14588, "acceptLeakOrder", "no")
end

function acceptLeakOrder()
    local taskStatus = GetByte(GetTask(TASK_ID_LEAK), 1)
    if (taskStatus == 2) then
        SetTask(TASK_ID_LEAK, SetByte(GetTask(TASK_ID_LEAK), 1, 3))
        SetTask(TASK_ID_LEAK, SetByte(GetTask(TASK_ID_LEAK), 2, 0))
        TaskNote(TASK_INFO_ID_LEAK, 2)
        AddNormalItem(6, 1, 364, 0, 0, 0)
        Msg2Player("B¹n nhËn ®­îc 1 Khoa Nga Linh Ch©u!")
        TopMessage(14589)
        SetFightState(1)
        local rand = math.random(1, 2)
        NewWorld(MOVE_POS_ARRAY[rand].map, MOVE_POS_ARRAY[rand].x, MOVE_POS_ARRAY[rand].y)
        refreshNpcTaskState()
    end
end

function reAcceptLeakOrder()
    local taskStatus = GetByte(GetTask(TASK_ID_LEAK), 1)
    if (taskStatus == 3 and GetCash() >= 200000) then
        Pay(200000)
        Msg2Player("B¹n chi ra 20 v¹n l­îng!")
        SetTask(TASK_ID_LEAK, SetByte(GetTask(TASK_ID_LEAK), 2, 0))
        if (HaveNormalItem(6, 1, 364, 0) >= 1) then
            for i = 1, HaveNormalItem(6, 1, 364, 0) do
                DelNormalItem(6, 1, 364, 0)
            end
        end
        if (HaveNormalItemInQuick(6, 1, 364, 0) >= 1) then
            for i = 1, HaveNormalItemInQuick(6, 1, 364, 0) do
                DelNormalItemInQuick(6, 1, 364, 0)
            end
        end
        AddNormalItem(6, 1, 364, 0, 0, 0)
        Msg2Player("B¹n nhËn ®­îc <c=g>Khoa Nga Linh Ch©u<c>!")
        TopMessage(14589)
        SetFightState(1)
        local rand = math.random(1, 2)
        NewWorld(MOVE_POS_ARRAY[rand].map, MOVE_POS_ARRAY[rand].x, MOVE_POS_ARRAY[rand].y)
        refreshNpcTaskState()
    else
        Talk(1, "no", 14590)
    end
end

function finishLeakOrder()
    local taskStatus = GetByte(GetTask(TASK_ID_LEAK), 1)
    if (taskStatus == 4) then
        SetTask(TASK_ID_LEAK, SetByte(GetTask(TASK_ID_LEAK), 1, 10))
        TaskNote(TASK_INFO_ID_LEAK, -1)
        if (HaveNormalItem(6, 1, 364, 0) >= 1) then
            for i = 1, HaveNormalItem(6, 1, 364, 0) do
                DelNormalItem(6, 1, 364, 0)
            end
        end
        if (HaveNormalItemInQuick(6, 1, 364, 0) >= 1) then
            for i = 1, HaveNormalItemInQuick(6, 1, 364, 0) do
                DelNormalItemInQuick(6, 1, 364, 0)
            end
        end
        AddOwnExp(1500000)
        AddItemPileNum(3, 82, 0, 0, 10)
        local rand = math.random(1, 4)
        local symbolArr = { [1] = "§Þa Linh", [2] = "LiÖu Nguyªn", [3] = "Truy Phong", [4] = "H¶i Hån" }
        AddNormalItem(8, (rand + 118), 2, 0, 0, 0)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc 1500000 kinh nghiÖm")
        Msg2Player("Chóc mõng b¹n nhËn ®­îc 10 Tha S¬ Th¹ch!")
        Msg2Player("Chóc mõng b¹n nhËn ®­îc 1" .. symbolArr[rand] .. " phï!")
        TopMessage(14591)

        Talk(1, "no", 14592)
        refreshNpcTaskState()
    end
end

function zizibujuan()
    local nTaskStatus = GetTask(Task_Book)
    if (nTaskStatus == 0) then
        MsgBox(11946, "AcceptBook", "no")

    elseif (nTaskStatus == 1 and (HaveNormalItem(7, 0, 3, 0) >= 1 or IsSkillActived(3) >= 1)) then

        SetTask(Task_Book, 2)
        AddOwnExp(400)

        SetSubTask(910, -1, 1)

        TaskNote(910, -1)
        TopMessage(11947)
        AddNormalItem(7, 1, 4, 0, 0, 0)
        Msg2Player("NhËn ®­îc L­u Tinh Th¹ch vµ 400 kinh nghiÖm")
        Talk(1, "no", 11948)

        refreshNpcTaskState()

    end
end

function AcceptBook()
    SetTask(Task_Book, 1)

    SetSubTask(910, 1, 1)

    TaskNote(910, 0)
    Talk(1, "no", 11949)

    Earn(1)

    refreshNpcTaskState()

end
