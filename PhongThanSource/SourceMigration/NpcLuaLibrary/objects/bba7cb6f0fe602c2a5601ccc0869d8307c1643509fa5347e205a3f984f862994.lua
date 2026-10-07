Task_Conflict = 1089

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
            if (taskProcess == 1) then
                state = 3
                subState = 0
            elseif (taskProcess == 2) then
                state = 0
                subState = 0
            end
        else
            local taskProcess = GetTask(Task_Conflict)
            if (taskProcess == 1) then
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
    if (GetLevel() >= startLevel) and (GetPlayerType() == 2) then
        if (GetLevel() - startLevel <= 5) then
            local taskProcess = GetTask(Task_Conflict)
            if (taskProcess == 2) then
                state = 1
                subState = 0
            elseif (taskProcess == 3) and (HaveNormalItem(3, 333, 0, 0) >= 5) and (HaveNormalItem(3, 334, 0, 0) >= 1) then
                state = 3
                subState = 0
            elseif (taskProcess == 3) then
                state = 2
                subState = 0
            elseif (taskProcess == 4) then
                state = 0
                subState = 0
            end
        else
            local taskProcess = GetTask(Task_Conflict)
            if (taskProcess == 2) then
                state = 1
                subState = 1
            elseif (taskProcess == 3) and (HaveNormalItem(3, 333, 0, 0) >= 5) and (HaveNormalItem(3, 334, 0, 0) >= 1) then
                state = 3
                subState = 1
            elseif (taskProcess == 3) then
                state = 2
                subState = 1
            elseif (taskProcess == 4) then
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
            if (taskProcess == 1) then
                state = 3
                subState = 0
            elseif ((taskProcess >= 2) and (taskProcess < 5)) or (taskProcess == 5 and GetItemCount(28) < 3) then
                state = 2
                subState = 0
            elseif (taskProcess == 5) and (GetItemCount(28) >= 3) then
                state = 3
                subState = 0
            elseif (taskProcess == 7) then
                state = 0
                subState = 0
            end
        else
            if (taskProcess == 1) then
                state = 3
                subState = 1
            elseif ((taskProcess >= 2) and (taskProcess < 5)) or (taskProcess == 5 and GetItemCount(28) < 3) then
                state = 2
                subState = 0
            elseif (taskProcess == 5) and (GetItemCount(28) >= 3) then
                state = 3
                subState = 1
            elseif (taskProcess == 7) then
                state = 0
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 37
    if (GetLevel() >= startLevel) then
        if (GetLevel() - startLevel <= 5) then
            if (GetTaskByte(Task_star, 1) == 5 and GetTaskByte(Task_collect, 1) == 0 and GetLevel() >= 37) then
                state = 3
                subState = 0
            end
        else
            if (GetTaskByte(Task_star, 1) == 5 and GetTaskByte(Task_collect, 1) == 0 and GetLevel() >= 37) then
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
        { "<c=yel>ThÇn Khİ<c>", "renwu1"; show = 0 },
        { "<c=yel>Hßa gi¶i<c>", "ResovleConflict"; show = 0 },
        { "<c=yel>Hoµ thuËn<c>", "makeFriend"; show = 0 },
        { "B¸o danh", "renwu"; show = 0 },
        { "Tinh quang ¶m ®¹m", "star_dark"; show = 0 },
    }
    UTask_25 = GetTask(35);
    if (UTask_25 == 5) and (GetItemCount(28) >= 3) then
        tasks[1].show = 1;
    end ;
    if (UTask_25 == 1) then
        tasks[1].show = 1;
    end ;

    local L_Resolve = GetTask(Task_Conflict)
    if (L_Resolve == 1) and (GetPlayerType() == 2) then
        tasks[2].show = 1;
    elseif ((L_Resolve == 2) or (L_Resolve == 3)) and (GetPlayerType() == 2) then
        tasks[3].show = 1;
    end ;

    if (GetTaskByte(Task_star, 1) == 5 and GetTaskByte(Task_collect, 1) == 0 and GetLevel() >= 37) then
        tasks[5].show = 1
    end

    if (GetLevel() < 20) and (SystemTime() > 1111140000) and (SystemTime() < 1111226400) then
        tasks[4].show = 1;
        SayTask(12339, tasks)
    else
        SayTask(10151, tasks)
    end ;
end;

function makeFriend()

    local L_Resolve = GetTask(Task_Conflict)
    if (L_Resolve == 2) then

        MsgBox("Céng C«ng:Ta mÊt <c=g>[5 trang s¸ch r¸ch]<c> vµ <c=g>[1 TuyÕn quyÓn]<c>, nÕu ng­¬i gióp ta t×m l¹i th× sÏ ho¸ gi¶i ®­îc mèi bÊt hoµ víi Chóc Dung!", "makeFriendFinal", "no")

    elseif (L_Resolve == 3) then

        local nBookPiece = HaveNormalItem(3, 333, 0, 0)
        local nBookThread = HaveNormalItem(3, 334, 0, 0)
        if (nBookPiece >= 5) and (nBookThread >= 1) then
            ClearItem(3, 333, 0, 0)
            ClearItem(3, 334, 0, 0)
            AddNormalItem(3, 335, 0, 0, 0, 0)
            TaskNote(1002, 3)
            SetTask(Task_Conflict, 4)

            refreshNpcTaskState()

            Talk(1, "no", "§©y chİnh lµ nh÷ng trang s¸ch mµ ta ®¸nh mÊt. H·y ®îi ta ®ãng nã l¹i, sau ®ã gióp ta mang ®Õn cho <c=g>Chóc Dung<c>!")
        else
            Talk(1, "no", "Ng­¬i vÉn ch­a t×m ®ñ <c=g>[5 trang s¸ch r¸ch]<c> vµ <c=g>[1 TuyÕn quyÓn]<c>!")
        end

    end

end

function makeFriendFinal()

    local L_Resolve = GetTask(Task_Conflict)

    if (L_Resolve == 2) then
        SetTask(Task_Conflict, 3)
        Talk(3, "no", GetName() .. ":VËy «ng cã nhí lµm thÊt l¹c ë ®©u kh«ng? Kh«ng chõng t¹i h¹ cã thÓ gióp!", "Ta nhí lóc ®i ngang qua Miªu C­¬ng, gÆp ph¶i <c=g>§¹i Chñng Nh©n vµ Cuång §iªu<c> tÊn c«ng, sau ®ã…", GetName() .. ": Xem ra trªn ng­êi <c=g>§¹i Chñng Nh©n vµ Cuång §iªu<c> cã chót manh mèi.")

        SetSubTask(1002, 1, 1)

        TaskNote(1002, 0)

        refreshNpcTaskState()

    end

end

function ResovleConflict()
    local L_Resolve = GetTask(Task_Conflict)
    if (L_Resolve == 1) then
        AddOwnExp(50)
        TopMessage(12358)
        Msg2Player("B¹n nhËn ®­îc 50 ®iÓm kinh nghiÖm!")
        SetTask(Task_Conflict, 2)

        SetSubTask(999, -1, 1)

        TaskNote(999, -1)
        Talk(1, "makeFriend", 12359)

        refreshNpcTaskState()

    end ;
end

function renwu1()
    UTask_25 = GetTask(35);
    if (UTask_25 == 5 or UTask_25 == 6) and (GetItemCount(28) >= 3) then
        Talk(1, "no", " May qu¸! 3 m¶nh ThÇn khİ vÉn con ®©y, ®Ó ta gióp kh«i phôc nguyªn tr¹ng cho ThÇn khİ. <enter><c=r>Quªn n÷a, Håi thµnh phï cã thÓ mua t¹i c¸c T¹p hãa trong thµnh thŞ! Cã nã ®i-vÒ sÏ rÊt thuËn lîi!")
        DelEventItem(28)
        DelEventItem(28)
        DelEventItem(28)
        AddEventItem(27)
        AddOwnExp(600)
        SetTask(35, 7)
        TopMessage(12340)
        Msg2Player("B¹n nhËn ®­îc 600 ®iÓm kinh nghiÖm vµ ThÇn Khİ, cã thÓ luyÖn nã råi ®­a cho Chóc Dung")
        TaskNote(17, 15)

        refreshNpcTaskState()

    end ;

    if (UTask_25 == 1) then
        Talk(1, "no", "<c=r>ThÇn Khİ<c> trong lóc tÕ tæ ®· bŞ <c=g>Th¶o Tiªn bµ bµ<c> dïng H¾c Phong thuËt c­íp ®i, nh­ng Chóc Dung l¹i hiÓu lµm lµ do ta lÊy! NÕu ng­¬i gióp ta t×m ®­îc <c=g>3 m¶nh ThÇn khİ<c> ta sÏ håi phôc ®­îc nguyªn tr¹ng cho nã. §­êng xa hung hiÓm, tÆng ng­¬i <c=g>5 Håi thµnh phï<c> nµy ®Ó tiÖn ®i tiÖn vÒ!")
        Msg2Player("NhËn ®­îc 5 Håi thµnh phï. Tiªu diÖt Th¶o Tiªn bµ bµ, mang 3 m¶nh ThÇn Khİ vÒ cho Céng C«ng!")
        for i = 1, 5 do
            AddNormalItemPile(5, 0, 0, 1, 0, 0)
        end
        TaskNote(17, 11)
        SetTask(35, 2)

        refreshNpcTaskState()

    end ;
end;

function no()
    CloseDialog()
end;

function renwu()
    if (GetTask(330) == 0) then
        for a = 1, 3 do
            AddNormalItem(1, 0, 0, 0, 1, 0)
            AddNormalItem(1, 3, 0, 0, 1, 0)
        end ;
        SetTask(330, 1)
        Talk(1, "no", 12345)
    else
        Talk(1, "no", 12346)
    end ;
end;

function star_dark()
    CloseDialog()

    if (GetTaskByte(Task_star, 1) == 5 and GetTaskByte(Task_collect, 1) == 0 and GetLevel() >= 37) then

        TopMessage("§ang thu thËp linh khİ")
        Msg2Player("§ang thu thËp linh khİ.")
        local nInterrupt = 0
        nInterrupt = SetBit(nInterrupt, 1, 1)
        nInterrupt = SetBit(nInterrupt, 2, 1)
        nInterrupt = SetBit(nInterrupt, 3, 1)
        nInterrupt = SetBit(nInterrupt, 4, 1)
        nInterrupt = SetBit(nInterrupt, 5, 1)
        nInterrupt = SetBit(nInterrupt, 6, 0)
        nInterrupt = SetBit(nInterrupt, 9, 1)
        nInterrupt = SetBit(nInterrupt, 10, 1)

        BeginMotion(Task_collect - 500, 0, 5, "\\script\\motion\\ÊÕ¼¯ÁéÆø.lua", nInterrupt)
    end
end;
