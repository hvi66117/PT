Task_Conflict = 1089

Task_Body = 1091

Task_Variety_Process = 1389

Task_star = 1417

Task_collect = 1418

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

    startLevel = 3
    if (GetLevel() >= startLevel) and (GetPlayerType() == 2) then
        if (GetLevel() - startLevel <= 5) then
            local taskProcess = GetTask(Task_Conflict)
            if (taskProcess == 4) and (HaveNormalItem(3, 335, 0, 0)) then
                state = 3
                subState = 0
            elseif (taskProcess == 4) then
                state = 2
                subState = 0
            elseif (taskProcess == 5) then
                state = 0
                subState = 0
            end
        else
            local taskProcess = GetTask(Task_Conflict)
            if (taskProcess == 4) and (HaveNormalItem(3, 335, 0, 0)) then
                state = 3
                subState = 1
            elseif (taskProcess == 4) then
                state = 2
                subState = 1
            elseif (taskProcess == 5) then
                state = 0
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 10
    if (GetLevel() >= startLevel) and (GetPlayerType() == 2) then
        local taskProcess = GetTask(35)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 0) then
                state = 1
                subState = 0
            elseif (taskProcess == 7) and (HaveEventItem(27) >= 1) then
                state = 3
                subState = 0
            elseif (taskProcess == 8) then
                state = 0
                subState = 0
            elseif (taskProcess >= 1) and (taskProcess <= 6) then
                state = 2
                subState = 0
            end
        else
            if (taskProcess == 0) then
                state = 1
                subState = 1
            elseif (taskProcess == 7) and (HaveEventItem(27) >= 1) then
                state = 3
                subState = 1
            elseif (taskProcess == 8) then
                state = 0
                subState = 0
            elseif (taskProcess >= 1) and (taskProcess <= 6) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 10
    if (GetLevel() >= startLevel) and (GetPlayerType() == 2) then
        local taskProcess = GetTask(Task_Body)
        if (GetLevel() - startLevel <= 5) then
            if (GetTask(35) == 8) and (taskProcess == 0) then
                state = 1
                subState = 0
            elseif (taskProcess == 1) then
                state = 0
                subState = 0
            end
        else
            if (GetTask(35) == 8) and (taskProcess == 0) then
                state = 1
                subState = 1
            elseif (taskProcess == 1) then
                state = 0
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 41
    if (GetLevel() >= startLevel) then
        local step = GetTaskByte(Task_Variety_Process, 1)
        if (GetLevel() - startLevel <= 5) then
            if (GetTaskByte(Task_Variety_Process, 2) == 3) and ((step == 11) or (step == 30)) then
                state = 3
                subState = 0
            elseif (step == 14 and HaveNormalItem(4, 234, 1, 1) > 0) then
                state = 3
                subState = 0
            elseif ((step >= 12 and step <= 14) or (step == 30)) then
                state = 2
                subState = 0
            end
        else
            if ((GetTaskByte(Task_Variety_Process, 2) == 3) and ((step == 11) or (step == 30))) then
                state = 3
                subState = 1
            elseif (step == 14 and HaveNormalItem(4, 234, 1, 1) > 0) then
                state = 3
                subState = 1
            elseif ((step >= 12 and step <= 14) or (step == 30)) then
                state = 2
                subState = 0

            end
        end
        index = searchForIndex(state, subState, index)
    end

    startLevel = 37
    if (GetLevel() >= startLevel) then
        if (GetLevel() - startLevel <= 5) then
            if (GetTaskByte(Task_star, 1) == 5 and GetTaskByte(Task_collect, 2) == 0 and GetLevel() >= 37) then
                state = 3
                subState = 0
            end
        else
            if (GetTaskByte(Task_star, 1) == 5 and GetTaskByte(Task_collect, 2) == 0 and GetLevel() >= 37) then
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
        { "<c=yel>Hßa gi¶i<c>", "ResovleConflict"; show = 0 },
        { "<c=yel>ThÇn KhÝ<c>", "renwu2"; show = 0 },
        { "<c=yel>Bôi gai<c>", "renwu1"; show = 0 },
        { "<c=yel>Hoµ thuËn<c>", "makeFriend"; show = 0 },
        { "Háa Ly Tinh Ph¸ch", "fireSoul"; show = 0 },
        { "Tinh quang ¶m ®¹m", "star_dark"; show = 0 },
    }

    local L_StrongMan = GetTask(Task_Body)
    local L_Resolve = GetTask(Task_Conflict)
    UTask_25 = GetTask(35);

    if (UTask_25 == 8 and L_StrongMan == 0 and GetPlayerType() == 2 and GetLevel() >= 10) then
        tasks[3].show = 1;
    end ;

    if (UTask_25 == 7) and (HaveEventItem(27) >= 1) then
        tasks[2].show = 1;
    end ;

    if ((UTask_25 == 0) and (GetPlayerType() == 2) and (GetLevel() >= 10)) then
        tasks[2].show = 1;
    end ;

    if (L_Resolve == 4) and (GetPlayerType() == 2) then
        tasks[4].show = 1;
    end ;

    local Variety_Step = GetTaskByte(Task_Variety_Process, 1)
    if (GetTaskByte(Task_Variety_Process, 2) == 3) and ((Variety_Step >= 11 and Variety_Step < 15) or Variety_Step == 30) then
        tasks[5].show = 1
    end

    if (GetTaskByte(Task_star, 1) == 5 and GetTaskByte(Task_collect, 2) == 0 and GetLevel() >= 37) then
        tasks[6].show = 1
    end

    SayTask(10218, tasks)
end;

function star_dark()
    CloseDialog()

    if (GetTaskByte(Task_star, 1) == 5 and GetTaskByte(Task_collect, 2) == 0 and GetLevel() >= 37) then

        TopMessage("§ang thu thËp linh khÝ")
        Msg2Player("§ang thu thËp linh khÝ.")
        local nInterrupt = 0
        nInterrupt = SetBit(nInterrupt, 1, 1)
        nInterrupt = SetBit(nInterrupt, 2, 1)
        nInterrupt = SetBit(nInterrupt, 3, 1)
        nInterrupt = SetBit(nInterrupt, 4, 1)
        nInterrupt = SetBit(nInterrupt, 5, 1)
        nInterrupt = SetBit(nInterrupt, 6, 0)
        nInterrupt = SetBit(nInterrupt, 9, 1)
        nInterrupt = SetBit(nInterrupt, 10, 1)

        BeginMotion(Task_collect - 501, 0, 5, "\\script\\motion\\ÊÕ¼¯ÁéÆø.lua", nInterrupt)
    end
end

function find_fireSoul()
    NewWorld(21, 1955, 3345)
    Msg2Player("B¹n ®­îc ph¸i ®Õn chç vµo Hiªn Viªn ®éng, ®i vµo Hiªn Viªn ®éng ®iÒu tra cÆn kÏ")
    SetTaskByte(Task_Variety_Process, 1, 12)
    refreshNpcTaskState()
    Talk(1, "no", "Háa Linh cã thÓ trªn minh yªu vËt ë Hiªn Viªn ®éng, b¹n h·y ®iÒu tra kü l­ìng")
    TaskNote(1046, 1)
    CloseDialog()
end

function fireSoul()
    local step = GetTaskByte(Task_Variety_Process, 1)
    if ((step == 11) or (step == 30)) then
        MsgBox("Háa Linh cña ta bÞ trém råi, b©y giê ta cã thÓ c¶m nhËn ®­îc Háa Linh cã thÓ ë trong Hiªn Viªn ®éng phÝa T©y TriÒu Ca, hy väng ng­¬i cã thÓ gióp ta t×m Háa Linh vÒ.", "find_fireSoul", "no")
        return
    elseif (step == 12) then
        Talk(1, "no", "Háa Linh cã lÏ ë trong Hiªn Viªn ®éng, mau t×m gióp ta.")
        return
    elseif (step == 13) then
        Talk(1, "no", "Kh«ng hái ®­îc tin g× tõ Ho¶ Ly TiÓu Yªu µ? H·y ®Õn TÇng 1 Hiªn Viªn §éng t×m §¹i Phu hái th¨m")
        return
    elseif (step == 14) then
        if (HaveNormalItem(6, 1, 486, 0) > 0) then
            talk(1, "no", "Sö dông Hån B¹ch, cã thÓ t×m manh mèi tõ Ho¶ Ly TiÓu Yªu")
        elseif (HaveNormalItem(4, 234, 1, 1) > 0) then
            Talk(1, "no", "Th× ra yªu vËt trong Hiªn Viªn ®éng kh«ng biÕt c¸i g× lµ Háa Linh, nh­ng cã ng­êi cho chóng Háa Linh, vµ d¹y chóng sö dông tiªn thuËt. Háa Linh cña ta cã lÏ ®· bÞ chia nhá ra ph¸t cho c¸c tiÓu yªu trong Hiªn Viªn ®éng råi, ng­¬i mau vÒ b¸o t×nh h×nh nµy cho Hoµng Thiªn Hãa.")
            ClearItem(4, 234, 1, 1)
            Msg2Player("B¹n mÊt Háa Ly Tinh Ph¸ch")
            SetTaskByte(Task_Variety_Process, 1, 15)
            refreshNpcTaskState()
            TaskNote(1046, 5)
        else
            Talk(1, "no", "Ng­¬i t×m ®­îc manh mèi cña Háa Linh ch­a? Ta cÇn <c=g>Háa Ly Tinh Ph¸ch<c>, dïng Hån B¹ch cã thÓ hót Háa Ly Tinh Ph¸ch tõ ng­êi Ho¶ Ly TiÓu Yªu.")


        end
        return
    end
end

function renwu1()
    MsgBox(12354, "yes_rode", "no")
end;

function yes_rode()
    Talk(1, "no", 12355)
    SetTask(Task_Body, 1)
    Msg2Player("Sau cÊp 10 ®i t×m Phong B¸!")

    SetSubTask(1006, 1, 1)

    TaskNote(1006, 0)

    refreshNpcTaskState()

end

function renwu2()
    UTask_25 = GetTask(35);
    if (UTask_25 == 7) and (HaveEventItem(27) >= 1) then
        Talk(1, "no", 10220)
        DelEventItem(27)
        AddNormalItem(0, 5, 2, 1, 0, 0)
        AddOwnExp(1200)
        SetTask(35, 8)
        TopMessage("B¹n nhËn ®­îc 1200 kinh nghiÖm vµ Lang Nha Ngoa")
        Msg2Player("NhËn ®­îc 1 Lang Nha Ngoa")

        SetSubTask(17, -1, 1)

        TaskNote(17, -1)

        refreshNpcTaskState()

    elseif (UTask_25 == 0) and (GetPlayerType() == 2) and (GetLevel() >= 10) then
        MsgBox(12357, "yes_1", "no")
    end ;
end;

function yes_1()
    Talk(1, "no", 10222)
    SetTask(35, 1)
    Msg2Player("§i t×m Céng C«ng hái tin tøc cña  ThÇn KhÝ")

    SetSubTask(17, 1, 1)

    TaskNote(17, 10)

    refreshNpcTaskState()

end;

function makeFriend()

    local L_Resolve = GetTask(Task_Conflict)
    if (L_Resolve == 4) then

        local nBookPiece = HaveNormalItem(3, 335, 0, 0)
        if (nBookPiece >= 1) then


            AddOwnExp(2000)
            ClearItem(3, 335, 0, 0)
            AddNormalItem(7, 40, 43, 0, 0, 0)
            TopMessage("B¹n nhËn ®­îc 1 Kim Cang Chó")

            Msg2Player("Anh hïng ®· nhËn 2000 kinh nghiÖm vµ Kim Cang Chó. ")

            SetSubTask(1002, -1, 1)

            TaskNote(1002, -1)
            SetTask(Task_Conflict, 5)
            refreshNpcTaskState()
            Talk(3, "no", "§©y ch¼ng ph¶i lµ quyÓn Kim Cang Chó cña Céng C«ng sao? LÏ nµo ®· t×m ®­îc råi?", GetName() .. ":§óng vËy, Céng C«ng v× chuyÖn nµy lu«n tù tr¸ch, ®å vËt ®· t×m ®­îc, chi b»ng c¸c ng­êi h·y b¾t tay lµm lµnh víi nhau.", " ThËt ra ta ®· quªn chuyÖn nµy tõ l©u råi! QuyÓn Kim Cang Chó nµy tÆng cho ng­¬i. Sau cÊp <c=g>10<c> h·y quay l¹i gÆp ta!")

            refreshNpcTaskState()

        else
            Talk(1, "no", "T×m ta cã viÖc g× kh«ng?")
        end

    end

end

function yes_god()
    tasks_god = {
        { "<c=yel>ThÇn KhÝ<c>", "renwu2"; show = 1 },
    }
    SayTask(10218, tasks_god)
end;

function no()
    CloseDialog()
end;
