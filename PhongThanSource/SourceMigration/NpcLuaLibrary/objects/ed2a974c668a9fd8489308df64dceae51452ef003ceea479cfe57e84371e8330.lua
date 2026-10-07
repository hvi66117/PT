Task_Body = 1091

Task_KillDevil = 1092

Task_DevilDisaster = 1097
Task_DevilNum = 1098
Task_DevilMonster = {
    { name = "§µi Yªu", id = 5, num = 4 },
}

Task_newer13 = 1416

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
    local startLevel = 10

    startLevel = 10
    if (GetLevel() >= 10) and (GetPlayerType() == 2) then
        local taskProcess = GetTask(Task_KillDevil)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 0) then
                state = 1
                subState = 0
            elseif (taskProcess == 10) then
                state = 3
                subState = 0
            elseif (taskProcess == 1) then
                state = 2
                subState = 0
            end
        else
            if (taskProcess == 0) then
                state = 1
                subState = 1
            elseif (taskProcess == 10) then
                state = 3
                subState = 1
            elseif (taskProcess == 1) then
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
            if (taskProcess == 1) then
                state = 1
                subState = 0
            elseif (taskProcess == 2) then
                state = 0
                subState = 0
            end
        else
            if (taskProcess == 1) then
                state = 1
                subState = 1
            elseif (taskProcess == 2) then
                state = 0
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 13
    if (GetLevel() >= startLevel) and (GetPlayerType() == 2) then
        local taskProcess = GetTaskByte(Task_newer13, 1)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 0) then
                state = 1
                subState = 0
            elseif (taskProcess == 6) then
                state = 3
                subState = 0
            elseif (taskProcess == 7) then
                state = 0
                subState = 0
            elseif (taskProcess > 0) and (taskProcess < 6) then
                state = 2
                subState = 0
            end
        else
            if (taskProcess == 0) then
                state = 1
                subState = 1
            elseif (taskProcess == 6) then
                state = 3
                subState = 1
            elseif (taskProcess == 7) then
                state = 0
                subState = 0
            elseif (taskProcess > 0) and (taskProcess < 6) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 14
    if (GetLevel() >= startLevel) and (GetPlayerType() == 2) then
        local taskProcess = GetTask(34)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 0) then
                state = 1
                subState = 0
            elseif (taskProcess == 4) then
                state = 3
                subState = 0
            elseif (taskProcess == 15) then
                state = 0
                subState = 0
            elseif (taskProcess >= 1) and (taskProcess <= 3) then
                state = 2
                subState = 0
            end
        else
            if (taskProcess == 0) then
                state = 1
                subState = 1
            elseif (taskProcess == 4) then
                state = 3
                subState = 1
            elseif (taskProcess == 15) then
                state = 0
                subState = 0
            elseif (taskProcess >= 1) and (taskProcess <= 3) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 14
    if (GetLevel() >= startLevel) and (GetPlayerType() == 2) then
        local taskProcess = GetTask(Task_DevilDisaster)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 0) and (GetTask(34) == 15) then
                state = 1
                subState = 0
            elseif (taskProcess == 8) and (HaveNormalItem(3, 140, 0, 0) >= 3) then
                state = 3
                subState = 0
            elseif (taskProcess == 10) then
                state = 0
                subState = 0
            else
                state = 2
                subState = 0
            end
        else
            if (taskProcess == 0) and (GetTask(34) == 15) then
                state = 1
                subState = 1
            elseif (taskProcess == 8) and (HaveNormalItem(3, 140, 0, 0) >= 3) then
                state = 3
                subState = 1
            elseif (taskProcess == 10) then
                state = 0
                subState = 0
            else
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 18
    if (GetLevel() >= startLevel) and (GetPlayerType() == 2) then
        taskProcess = GetTaskByte(Task_newer13, 2)
        if (GetLevel() - startLevel <= 5) then
            if (GetTaskByte(Task_newer13, 1) == 8) and (taskProcess == 0) then
                state = 1
                subState = 0
            elseif (taskProcess == 6) then
                state = 3
                subState = 0
            elseif (taskProcess == 7) then
                state = 0
                subState = 0
            elseif (taskProcess >= 1) and (taskProcess <= 5) then
                state = 2
                subState = 0
            end
        else
            if (GetTaskByte(Task_newer13, 1) == 8) and (taskProcess == 0) then
                state = 1
                subState = 0
            elseif (taskProcess == 6) then
                state = 3
                subState = 0
            elseif (taskProcess == 7) then
                state = 0
                subState = 0
            elseif (taskProcess >= 1) and (taskProcess <= 5) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 37
    if (GetLevel() >= startLevel) then
        if (GetLevel() - startLevel <= 5) then
            if (GetTaskByte(Task_star, 1) == 5 and GetTaskByte(Task_collect, 3) == 0 and GetLevel() >= 37) then
                state = 3
                subState = 0
            end
        else
            if (GetTaskByte(Task_star, 1) == 5 and GetTaskByte(Task_collect, 3) == 0 and GetLevel() >= 37) then
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
        { "<c=yel>Bôi gai<c>", "renwu1"; show = 0 },
        { "<c=yel>Trõ yªu<c>", "KillDevil"; show = 0 },
        { "<c=yel>Cøu tÕ<c>", "renwu2"; show = 0 },
        { "<c=yel>§µi Yªu Chi Ho¹n<c>", "DevilDisaster"; show = 0 },
        { "<c=yel>Hñy n/v Trõ yªu<c>", "GiveUpKillDevil"; show = 0 },
        { "<c=yel>M·nThiªnQu¸H¶i<c>", "renwu13"; show = 0 },
        { "<c=yel>Trïng Ho¹ch Tiªn §¬n<c>", "renwu18"; show = 0 },
        { "Tinh quang ¶m ®¹m", "star_dark"; show = 0 },
    }
    local UTask_20 = GetTask(Task_Body);
    local UTask_24 = GetTask(34);
    if (UTask_20 == 1 and GetPlayerType() == 2 and GetLevel() >= 10) then
        tasks[1].show = 1;
    end ;

    local L_KillDevil = GetTask(Task_KillDevil)
    if (L_KillDevil == 0 and GetPlayerType() == 2 and GetLevel() >= 10) then
        tasks[2].show = 1;
    end ;

    if (L_KillDevil == 10) then
        tasks[2].show = 1;
    end ;

    if (L_KillDevil > 0 and L_KillDevil < 10) then
        tasks[5].show = 1;
    end ;

    if (UTask_24 >= 4 and UTask_24 < 15) then
        tasks[3].show = 1;
    end ;
    if (UTask_24 == 0) and (GetPlayerType() == 2) and (GetLevel() >= 14) then
        tasks[3].show = 1;
    end ;

    if (L_KillDevil == 11 and GetPlayerType() == 2) then
        TaskNote(1004, -1)
    end

    local L_KillDevil = GetTask(34)
    local L_DevilDisaster = GetTask(Task_DevilDisaster)
    if (L_KillDevil == 15 and L_DevilDisaster == 0 and GetPlayerType() == 2) then
        tasks[4].show = 1;
    end ;

    if (L_DevilDisaster == 8 and HaveNormalItem(3, 140, 0, 0) >= 3) then
        tasks[4].show = 1;
    end ;

    if (GetPlayerType() == 2) then
        local state13 = GetTaskByte(Task_newer13, 1)
        local state18 = GetTaskByte(Task_newer13, 2)
        if (GetLevel() >= 10) and (state13 == 0 or state13 == 6) then
            tasks[6].show = 1
        elseif (GetLevel() >= 18) and (state13 == 8) and (state18 == 0 or state18 == 6) then
            tasks[7].show = 1
        end
    end

    if (GetTaskByte(Task_star, 1) == 5 and GetTaskByte(Task_collect, 3) == 0 and GetLevel() >= 37) then
        tasks[8].show = 1
    end

    if (GetTaskByte(1416, 2) == 7 and GetPlayerType() == 2) then
        TaskNote(206, -1)
    end

    if (GetTask(34) >= 1 and GetPlayerType() == 2) then
        TaskNote(205, -1)
    end

    SayTask(10138, tasks)
end;

function renwu1()
    Talk(1, "no", 12306)
    AddOwnExp(800)
    TopMessage(12307)
    for i = 1, 10 do
        AddNormalItemPile(1, 0, 1, 1, 0, 0)
        AddNormalItemPile(1, 3, 1, 1, 0, 0)
    end
    SetTask(Task_Body, 2)

    SetSubTask(1006, -1, 1)

    TaskNote(1006, -1)

    refreshNpcTaskState()


end;

function renwu2()
    UTask_24 = GetTask(34);
    if (UTask_24 >= 4 and UTask_24 < 15) then

        SetSubTask(16, -1, 1)

        TaskNote(16, 15)

        SetTask(34, 15)
        AddOwnExp(2500)
        TopMessage(12308)

        AddItemPileNum(5, 0, 0, 1, 10)
        Msg2Player("PhÇn th­ëng 2500 kinh nghiÖm, 10 Håi Thµnh Phï!")
        Talk(1, "Revenge", 12309)

        refreshNpcTaskState()

    end ;

    if (UTask_24 == 0) and (GetPlayerType() == 2) and (GetLevel() >= 14) then
        MsgBox(10140, "yes_1", "no")
    end ;
end;

function yes_1()

    TaskNote(205, -1)

    Talk(1, "no", 10141)
    SetTask(34, 1)
    Msg2Player("§Õn Cù Léc t×m Thñ lÜnh téc nh©n bÞ mÊt tÝch!")

    SetSubTask(16, 1, 1)

    TaskNote(16, 10)

    refreshNpcTaskState()

end;

function EnterKillDevil()
    task_devil = {
        { "<c=yel>Trõ yªu<c>", "KillDevil"; show = 1 }
    }
    SayTask(10137, task_devil)
end;

function KillDevil()
    local L_KillDevil = GetTask(Task_KillDevil)
    if (L_KillDevil == 0 and GetPlayerType() == 2 and GetLevel() >= 10) then
        MsgBox(12310, "Yes_KillDevil", "no")
    elseif (L_KillDevil == 10) then
        Talk(1, "no", 12311)

        AddOwnExp(4300)
        AddNormalItem(0, 2, 2, 1, 0, 0)
        SetTask(Task_KillDevil, 11)
        TopMessage(12312)

        Msg2Player("Anh hïng ®· nhËn 4300 kinh nghiÖm vµ 1 Lang Nha Hé Gi¸p. ")

        SetSubTask(1004, -1, 1)

        TaskNote(1004, 3)

        refreshNpcTaskState()

    end ;
end;

function Yes_KillDevil()
    if (GetTask(Task_KillDevil) == 0) then
        Talk(1, "no", 12313)
        SetTask(Task_KillDevil, 1)

        SetSubTask(1004, 1, 1)

        TaskNote(1004, 0)
        Msg2Player("B¹n nhËn ®­îc l­¬ng thùc")
        AddNormalItem(6, 1, 275, 1, 0, 0)

        refreshNpcTaskState()

    end
end

function Revenge()
    taskrevenge = {
        { "<c=yel>§µi Yªu Chi Ho¹n<c>", "DevilDisaster"; show = 1 },
    }
    SayTask(12314, taskrevenge)
end;

function DevilDisaster()
    local L_KillDevil = GetTask(34)
    local L_DevilDisaster = GetTask(Task_DevilDisaster)
    if (L_KillDevil == 15 and L_DevilDisaster == 0) then
        MsgBox(12315, "yes_Kill", "no")
    elseif (L_DevilDisaster == 8 and HaveNormalItem(3, 140, 0, 0) >= 3) then
        Talk(1, "no", 12316)
        for i = 1, 3 do
            DelNormalItem(3, 140, 0, 0)
        end

        AddOwnExp(5000)
        TopMessage(12317)
        Msg2Player("NhËn ®­îc 5000 kinh nghiÖm.")
        SetTask(Task_DevilDisaster, 10)

        SetSubTask(1007, -1, 1)

        TaskNote(1007, -1)

        refreshNpcTaskState()

    end ;
end;

function yes_Kill()
    Talk(1, "no", 12318)

    Msg2Player("Tiªu diÖt 4 §µi Yªu dÉn dô ra §µi Yªu V­¬ng, ®o¹t lÊy 3 lÖnh bµi. ")

    SetTask(Task_DevilDisaster, 1)
    SetTask(Task_DevilNum, 0)
    SetTask(Task_DevilNum, SetByte(GetTask(Task_DevilNum), 1, Task_DevilMonster[1].id))
    SetTask(Task_DevilNum, SetByte(GetTask(Task_DevilNum), 2, Task_DevilMonster[1].num))

    SetSubTask(1007, 1, 1)

    TaskNote(1007, 0)

    refreshNpcTaskState()

end

function GiveUpKillDevil()
    if (GetTask(Task_KillDevil) > 0 and GetTask(Task_KillDevil) < 10) then
        if (HaveNormalItem(6, 1, 275, 1) >= 1) then
            DelNormalItem(6, 1, 275, 1)
        end
        SetTask(Task_KillDevil, 0)
        TaskNote(1007, -1)
        TopMessage("Huû nhiÖm vô Trõ yªu")
        Talk(1, "no", 12319)
        Msg2Player("B¹n huû nhiÖm vô Trõ yªu")
    end
end

function no()
    CloseDialog()
end;

function renwu13()
    CloseDialog()
    if (GetLevel() < 13) then
        Talk(1, "no", "Víi n¨ng lùc hiÖn t¹i cña anh hïng e lµ ch­a gióp ®­îc ta, ®Õn cÊp 13 h·y ®Õn.")
        return 0
    end

    local state13 = GetTaskByte(Task_newer13, 1)
    if (state13 == 0) then
        MsgBox("Tr­¬ng Thiªn Qu©n cã gëi 1 linh ®an diÖu d­îc <c=g>Thiªn Niªn B¶o T©n §an <c> ë chç ta, nh­ng h«m qua bÞ kÎ trém lÊy mÊt, nay Tr­¬ng Thiªn Qu©n muèn lÊy b¸u vËt vÒ, nh­ng nay ®· bÞ mÊt, hy väng anh hïng cã thÓ gióp ta.", "yes_sea", "no")
    elseif (state13 == 6) then
        Talk(2, "no", GetName() .. "T×m ®Õn VËt tæ Phong B¸, b¸o thuèc lµ gi¶.", "VÉn bÞ c¸c ng­êi ph¸t hiÖn, tuy h×nh d¸ng thuèc nµy gièng thuèc cña Tr­¬ng Thiªn Qu©n, nh­ng bªn trong l¹i kh¸c, ta kh«ng muèn g¹t c¸c ng­¬i, chØ lµ muèn t¹m thêi thay thÕ thuèc thËt tr¶ cho Tr­¬ng Thiªn Qu©n, nh­ vËy ta sÏ cã thêi gian t×m kÎ trém thuèc, lóc ®ã sÏ hoµn tr¶.")
        SetTaskByte(Task_newer13, 1, 7)
        Msg2Player("Nãi cho Tr­¬ng Thiªn Qu©n biÕt c¸ch nghÜ cña VËt tæ Phong B¸.")
        TaskNote(205, 6)

        refreshNpcTaskState()

    end
end

function yes_sea()

    TaskNote(1004, -1)

    Talk(2, "no", GetName() .. "Lµm sao ®Ó gióp ®­îc ng­êi, xin h·y nãi râ.", "Phong B¸ VËt tæ:ChÕ luyÖn l¹i ®¬n d­îc cÇn ®i <c=r>Du Hån<c> thu thËp<c=g>má Cuång §iªu<c> vµ <c=g>n­íc m¾t §µi Yªu<c> lµm nguyªn liÖu. §¹i Phu ë Du Hån cã thÓ dïng Tam Muéi Ch©n Háa luyÖn c¸c vËt phÈm Êy thµnh linh ®¬n diÖu d­îc.")
    SetTaskByte(Task_newer13, 1, 1)
    Msg2Player("§Õn ¶i Du Hån thu thËp má Cuång §iªu vµ n­íc m¾t §µi Yªu.")

    SetSubTask(205, 1, 1)

    TaskNote(205, 0)

    refreshNpcTaskState()

end

function CompleteMission()

    AddItemPileNum(1, 0, 0, 0, 10)
    AddItemPileNum(1, 3, 0, 0, 10)
    Msg2Player("NhËn ®­îc 10 TiÓu Hång §¬n vµ 10 TiÓu Hoµn §¬n.")

    Talk(1, "no", "§a t¹ anh hïng gióp ®ì, gióp ta vµ Tr­¬ng Thiªn Qu©n khái sù hiÓu lÇm, ta sÏ tr¶ thuèc b¸u cho Tr­¬ng Thiªn Qu©n. §©y cã trang bÞ cÊp 20, xem nh­ phÇn th­ëng ta tÆng ng­êi.")
    SetTaskByte(Task_newer13, 2, 7)
    DelEventItem(237)

    AddOwnExp(13000)
    Msg2Player("NhËn 1 trang bÞ cÊp 20 vµ 13000 kinh nghiÖm. ")

    SetSubTask(206, -1, 1)

    TaskNote(206, 7)

    if (math.random(1, 2) == 1) then
        AddBlueEquip(0, 2, 2, 2, 0, 1, 1)
    else
        AddBlueEquip(0, 9, 2, 2, 0, 1, 1)
    end

    refreshNpcTaskState()


end

function renwu18()
    CloseDialog()
    local state18 = GetTaskByte(Task_newer13, 2)
    if (state18 == 0) then
        MsgBox("Ta ®· t×m ®­îc tung tÝch cña thuèc b¸u råi, 1 tªn ph¶n ®å TriÖt gi¸o muèn ®éc chiÕm thuèc nµy ®Ó tu luyÖn, nay h¾n ®· ®em thuèc cao ch¹y xa bay råi, anh hïng mau ®i thu phôc h¾n, lÊy l¹i thuèc b¸u.", "yes_drug", "no")
    elseif (state18 == 6) then

        if (HaveNormalItem(1, 0, 0, 0) == 0 and HaveNormalItem(1, 3, 0, 0) == 0) then
            if (IsHaveSpaceForTreasure(3) > 0) then
                CompleteMission()
            else
                Msg2Player("Hµnh trang kh«ng ®ñ chç trèng, kh«ng thÓ hoµn thµnh nhiÖm vô.")
            end

        elseif ((HaveNormalItem(1, 0, 0, 0) > 0 and HaveNormalItem(1, 3, 0, 0) == 0) or (HaveNormalItem(1, 0, 0, 0) == 0 and HaveNormalItem(1, 3, 0, 0) > 0)) then

            if (IsHaveSpaceForTreasure(2) > 0) then

                CompleteMission()

            else

                Msg2Player("Hµnh trang kh«ng ®ñ chç trèng, kh«ng thÓ hoµn thµnh nhiÖm vô.")

            end

        else

            if (IsHaveSpaceForTreasure(1) > 0) then

                CompleteMission()

            else

                Msg2Player("Hµnh trang kh«ng ®ñ chç trèng, kh«ng thÓ hoµn thµnh nhiÖm vô.")

            end

        end


    end
end

function yes_drug()

    TaskNote(206, -1)
    for i = 1, 5 do
        AddNormalItemBind(3, 12, 0, 0, 0, 0, 1)
        AddNormalItemBind(3, 8, 0, 0, 0, 0, 1)
    end

    Talk(2, "no", GetName() .. "V× chÝnh ®¹o, ta nguyÖn tr¶m yªu trõ ma, nh­ng lµm c¸ch nµo ®Ó thu phôc ng­êi nµy mong c¸c h¹ chØ b¶o.", "H¾n kh«ng ph¶i kÎ tÇm th­êng, víi n¨ng lùc ng­¬i hiÖn nay th× kh«ng ®­îc, anh hïng cã thÓ t×m <c=r>VËt Tæ Khoa Phô<c> m­în b¸u vËt <c=g>Tô Hån Th¸nh<c>, thu phôc h¾n.")
    SetTaskByte(Task_newer13, 2, 1)
    Msg2Player("T×m VËt Tæ Khoa Phô m­în Tô Hån Th¸nh, thu phôc ph¶n ®å TriÖt gi¸o.")

    SetSubTask(206, 1, 1)

    TaskNote(206, 0)

    refreshNpcTaskState()

end

function star_dark()
    CloseDialog()

    if (GetTaskByte(Task_star, 1) == 5 and GetTaskByte(Task_collect, 3) == 0 and GetLevel() >= 37) then

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

        BeginMotion(Task_collect - 502, 0, 5, "\\script\\motion\\ÊÕ¼¯ÁéÆø.lua", nInterrupt)
    end
end


