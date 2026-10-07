Task_NewPlayer = 1067

Task_Book = 1090

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

    if (GetLevel() >= 1) and (GetPlayerType() == 2) then
        if (GetLevel() - startLevel <= 5) then
            local taskProcess = GetTask(Task_NewPlayer)
            if (taskProcess == 1) then
                state = 3
                subState = 0
            elseif (taskProcess == 2) then
                state = 1
                subState = 0
            elseif (taskProcess == 3) then
                state = 2
                subState = 0
            elseif (taskProcess == 6) then
                state = 3
                subState = 0
            elseif (taskProcess == 7) then
                state = 0
                subState = 0
            end
        else
            local taskProcess = GetTask(Task_NewPlayer)
            if (taskProcess == 1) then
                state = 3
                subState = 1
            elseif (taskProcess == 2) then
                state = 1
                subState = 1
            elseif (taskProcess == 3) then
                state = 2
                subState = 1
            elseif (taskProcess == 6) then
                state = 3
                subState = 1
            elseif (taskProcess == 7) then
                state = 0
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 1
    if (GetLevel() >= startLevel) and (GetPlayerType() == 2) then
        if (GetLevel() - startLevel <= 5) then
            local taskProcess = GetTask(30)
            if (taskProcess == 0) then
                state = 1
                subState = 0
            elseif (taskProcess == 1) then
                state = 1
                subState = 0
            elseif (taskProcess == 2) then
                state = 0
                subState = 0
            end
        else
            local taskProcess = GetTask(30)
            if (taskProcess == 0) then
                state = 1
                subState = 1
            elseif (taskProcess == 1) then
                state = 1
                subState = 1
            elseif (taskProcess == 2) then
                state = 0
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 4
    if (GetLevel() >= startLevel) and (GetPlayerType() == 2) then
        if (GetLevel() - startLevel <= 5) then
            local taskProcess = GetTask(Task_Book)
            if (taskProcess == 0) then
                state = 1
                subState = 0
            elseif (taskProcess == 1) and ((HaveNormalItem(7, 49, 450, 0) >= 1) or IsSkillActived(450) >= 1) then
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
            elseif (taskProcess == 1) and ((HaveNormalItem(7, 49, 450, 0) >= 1) or IsSkillActived(450) >= 1) then
                state = 3
                subState = 1
            elseif (taskProcess == 1) then
                state = 2
                subState = 1
            elseif (taskProcess == 2) then
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
        { "<c=yel>Mao L≠<c>", "newplayer"; show = 0 },
        { "<c=yel>Khai Tr›<c>", "renwu1"; show = 0 },
        { "<c=yel>C«n m…n<c>", "LikeBook"; show = 0 },
    }

    local UTask_NewPlayer = GetTask(Task_NewPlayer);
    if ((UTask_NewPlayer == 1 or UTask_NewPlayer == 2 or UTask_NewPlayer == 6) and GetPlayerType() == 2) then
        tasks[1].show = 1
    end ;

    local UTask_20 = GetTask(30);
    if ((UTask_20 == 0 or UTask_20 == 1) and GetPlayerType() == 2) then
        tasks[2].show = 1;
    end ;

    local L_LikeBook = GetTask(Task_Book)
    if (L_LikeBook == 0 and GetLevel() >= 4 and GetPlayerType() == 2) then
        tasks[3].show = 1;
    end ;

    if (L_LikeBook == 1 and ((HaveNormalItem(7, 49, 450, 0) >= 1) or IsSkillActived(450) >= 1)) then
        tasks[3].show = 1;
    end ;
    SayTask(10162, tasks)
end;

function newplayer()
    local UTask_NewPlayer = GetTask(Task_NewPlayer);
    if (UTask_NewPlayer == 1) then
        SetTask(Task_NewPlayer, 2)
        SetSubTask(1000, 1, 1)
        AddOwnExp(45)
        TopMessage(12151)
        Msg2Player("NhÀn Æ≠Óc 45 Æi”m kinh nghi÷m.")

        refreshNpcTaskState()

        MsgBox(12321, "yes_newplayer", "no")
    end ;

    if (UTask_NewPlayer == 2) then
        MsgBox(12321, "yes_newplayer", "no")
    end

    if (UTask_NewPlayer == 6) then
        SetTask(Task_NewPlayer, 7)
        AddOwnExp(100)
        TopMessage(12322)
        Msg2Player("NhÀn Æ≠Óc 100 Æi”m kinh nghi÷m.")

        SetSubTask(1000, -1, 1)

        TaskNote(1000, -1)
        Talk(1, "no", 12323)

        refreshNpcTaskState()

    end ;
end;

function yes_newplayer()
    Talk(1, "no", 12324)
    SetTask(Task_NewPlayer, 3)
    TaskNote(1000, 1)

    refreshNpcTaskState()

end

function yes_strong()
    tasks_strong = {
        { "<c=yel>Khai Tr›<c>", "renwu1"; show = 1 },
    }
    SayTask(12325, tasks_strong)
end;

function renwu1()


    local UTask_20 = GetTask(30)
    if (UTask_20 == 0 and GetPlayerType() == 2) then

        SetTask(30, 1)
        Msg2Player("T◊m Khoa PhÙ vµ HÀu ThÊ nhÍ chÿ Æi”m")
        MsgBox(12326, "yes_lookfor", "no");

        refreshNpcTaskState()

    end ;

    if (UTask_20 == 1) then
        MsgBox(12326, "yes_lookfor", "no");
    end
end;

function yes_lookfor()
    Talk(1, "no", 12327)
    SetTask(30, 2)

    SetSubTask(13, 1, 1)

    TaskNote(13, 10)

    refreshNpcTaskState()

end

function no()
    CloseDialog()
end;

function LikeBook()
    local L_LikeBook = GetTask(Task_Book)
    if (L_LikeBook == 0 and GetLevel() >= 4 and GetPlayerType() == 2) then
        MsgBox(12341, "yes_book", "no")

    elseif (L_LikeBook == 1 and (HaveNormalItem(7, 49, 450, 0) >= 1 or IsSkillActived(450) >= 1)) then

        Talk(1, "no", 12342)
        AddOwnExp(400)
        TopMessage(12343)
        Msg2Player("Bπn nhÀn Æ≠Óc 400 Æi”m kinh nghi÷m!")
        SetTask(Task_Book, 2)

        SetSubTask(1003, -1, 1)

        TaskNote(1003, -1)

        refreshNpcTaskState()

    end ;
end;

function yes_book()
    Talk(1, "no", 12344)
    SetTask(Task_Book, 1)
    Msg2Player("ß’n V‚ s≠ mua 1 quy”n L˘c S‹ T’ cho Thi’u Hπo xem thˆ!")

    Earn(1)

    SetSubTask(1003, 1, 1)

    TaskNote(1003, 0)

    refreshNpcTaskState()

end
