Task_BeCare = 1025;
Task__Wellthought = 1033;
Task_ReadBook = 1035;

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
    local startLevel = 3

    if (GetLevel() >= 3) and (GetPlayerType() == 0) then
        if (GetLevel() - startLevel <= 5) then
            local taskProcess = GetTask(1025)
            if (HaveEventItem(188) > 0) and (taskProcess == 1) then
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
            local taskProcess = GetTask(1025)
            if (HaveEventItem(188) > 0) and (taskProcess == 1) then
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
    if (GetLevel() >= 6) and (GetPlayerType() == 0) then
        if (GetLevel() - startLevel <= 5) then
            local taskProcess = GetTask(20)
            if (taskProcess == 0) then
                state = 1
                subState = 0
            elseif (taskProcess == 14) and (HaveEventItem(26) >= 1) then
                state = 3
                subState = 0
            elseif (taskProcess == 20) then
                state = 0
                subState = 0
            else
                state = 2
                subSta = 0
            end
        else
            local taskProcess = GetTask(20)
            if (taskProcess == 0) then
                state = 1
                subState = 1
            elseif (taskProcess == 14) and (HaveEventItem(26) >= 1) then
                state = 3
                subState = 1
            elseif (taskProcess == 20) then
                state = 0
                subState = 0
            else
                state = 2
                subSta = 0
            end
        end
        index = searchForIndex(state, subState, index)
    end

    startLevel = 6
    if (GetLevel() >= startLevel) and (GetPlayerType() == 0) then
        if (GetLevel() - startLevel <= 5) then
            local taskProcess = GetTask(Task_ReadBook)
            if (taskProcess == 0) then
                state = 1
                subState = 0
            elseif (taskProcess == 1) and (HaveNormalItem(7, 24, 27, 0) >= 1 or IsSkillActived(27) >= 1) then
                state = 3
                subState = 0
            elseif (taskProcess == 2) then
                state = 0
                subState = 0
            else
                state = 2
                subState = 0
            end
        else
            local taskProcess = GetTask(Task_ReadBook)
            if (taskProcess == 0) then
                state = 1
                subState = 1
            elseif (taskProcess == 1) and (HaveNormalItem(7, 24, 27, 0) >= 1 or IsSkillActived(27) >= 1) then
                state = 3
                subState = 1
            elseif (taskProcess == 2) then
                state = 0
                subState = 0
            else
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    startLevel = 6
    if (GetLevel() >= startLevel) and (GetPlayerType() == 0) then
        if (GetLevel() - startLevel <= 5) then
            local taskProcess = GetTask(1033)
            if (taskProcess == 0) and (GetTask(20) == 20) then
                state = 1
                subState = 0
            end
        else
            local taskProcess = GetTask(Task_ReadBook)
            if (taskProcess == 0) and (GetTask(20) == 20) then
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
        { "<c=yel>CÈn thËn<c>", "BeCare"; show = 0 },
        { "<c=yel>Hép gÊm<c>", "renwu1"; show = 0 },
        { "<c=yel>CÇn mÉn<c>", "ReadBook"; show = 0 },
        { "<c=yel>M­u l­îc<c>", "AcceptThought"; show = 0 },
        { "<c=yel>ĞÂµÄÆğµã<c>", "NewLifeMain"; show = 0 },
    }
    UTask_10 = GetTask(20);
    if (UTask_10 == 14) and (HaveEventItem(26) >= 1) then
        tasks[2].show = 1;
    end ;
    if (UTask_10 == 0 and GetLevel() >= 6 and GetPlayerType() == 0) then
        tasks[2].show = 1;
    end ;
    if (UTask_10 == 20 and GetTask(Task__Wellthought) == 0 and GetPlayerType() == 0) then
        tasks[4].show = 1
    end
    if (GetTask(Task_BeCare) == 1 and HaveEventItem(188) >= 1) then
        tasks[1].show = 1
    end
    local UTask_Read = GetTask(Task_ReadBook)
    if ((GetLevel() >= 6 and GetPlayerType() == 0 and UTask_Read == 0) or (UTask_Read == 1 and (HaveNormalItem(7, 24, 27, 0) >= 1 or IsSkillActived(27) >= 1))) then
        tasks[3].show = 1
    end

    if (GetPlayerType() == 0 and GetNewBirthTimes() == 1) then
        tasks[5].show = 1
        if (GetTaskBit(2089, 18) == 1) then
            tasks[5].show = 0
        end
    end

    SayTask(10271, tasks)
end;
function ReadBook()
    local UTask_Read = GetTask(Task_ReadBook)
    if (UTask_Read == 0) then
        MsgBox(12494, "AcceptRead", "no")

    elseif (UTask_Read == 1 and (HaveNormalItem(7, 24, 27, 0) >= 1 or IsSkillActived(27) >= 1)) then


        AddOwnExp(1200)
        Msg2Player("NhËn 1200 kinh nghiÖm")

        SetTask(Task_ReadBook, 2)
        TaskNote(904, -1)

        SetSubTask(904, -1, 1)

        TopMessage(11947)
        Talk(1, "no", 12495)
        if (GetTask(Task_ReadBook) == 2) then
            SyncBibleState(904, 0, 1)
        end ;

        refreshNpcTaskState()

    end

end
function AcceptRead()

    SetSubTask(904, 1, 1)

    TaskNote(904, 0)
    SetTask(Task_ReadBook, 1)
    Msg2Player("§Õn Vâ s­ mua TÕ HuyÕt Tr¶m.")

    Earn(1)

    Talk(1, "no", 12496)

    refreshNpcTaskState()


end
function BeCare()
    if (GetTask(Task_BeCare) == 1 and HaveEventItem(188) >= 1) then
        DelEventItem(188)
        AddOwnExp(100)

        SetSubTask(906, -1, 1)

        TaskNote(906, -1)
        SetTask(Task_BeCare, 2)
        TopMessage(12130)
        Msg2Player("Hoµn thµnh nhiÖm vô, nhËn ®­îc 100 ®iÓm kinh nghiÖm")
        if (GetTask(Task_BeCare) == 2) then
            SyncBibleState(906, 0, 1)
        end ;
        if (GetTask(20) == 0 and GetLevel() >= 6) then
            Talk(1, "AcceptRain", 12497)

        else
            Talk(1, "no", 12498)
        end

        refreshNpcTaskState()

    end

end
function AcceptRain()
    tasks1 = {
        { "<c=yel>Hép gÊm<c>", "renwu1"; show = 1 },
        { "<c=yel>CÇn mÉn<c>", "ReadBook"; show = 1 }
    }
    SayTask(10271, tasks1)
end
function renwu1()
    UTask_10 = GetTask(20);
    if (UTask_10 == 14) and (HaveEventItem(26) >= 1) then
        DelEventItem(26)
        AddNormalItem(1, 0, 1, 1, 0, 0)
        AddNormalItem(1, 0, 1, 1, 0, 0)
        AddNormalItem(1, 0, 1, 1, 0, 0)
        AddNormalItem(1, 3, 1, 1, 0, 0)
        AddNormalItem(1, 3, 1, 1, 0, 0)
        AddNormalItem(1, 3, 1, 1, 0, 0)
        AddNormalItem(0, 5, 0, 1, 0, 0)

        AddOwnExp(1000)

        Talk(1, "Wellthought", 12499)
        TopMessage(12500)
        Msg2Player("LÊy gióp hép gÊm cho T« Hé, nhËn ®­îc HuyÒn Vò ChiÕn Ngoa cña T« Hé. NhËn ®­îc 1000 kinh nghiÖm. ")

        SetSubTask(7, -1, 1)

        TaskNote(7, -1)
        SetTask(20, 20)
        if (GetTask(20) == 15) then
            SyncBibleState(7, 0, 1)
        end ;

        refreshNpcTaskState()

    end ;
    if (UTask_10 == 0) then
        MsgBox(10273, "yes_1", "no")
    end ;
end;

function yes_1()
    Talk(1, "no", 10274)
    Msg2Player("§Õn Thñ khè lÊy hép gÊm vÒ cho T« Hé.")

    SetSubTask(7, 1, 1)

    TaskNote(7, 0)
    SetTask(20, 1)

    refreshNpcTaskState()

end;

function Wellthought()
    Task1 = {
        { "<c=yel>M­u l­îc<c>", "AcceptThought"; show = 1 },
        { "<c=yel>CÇn mÉn<c>", "ReadBook"; show = 0 }
    }
    local UTask_Read = GetTask(Task_ReadBook)
    if ((GetLevel() >= 6 and GetPlayerType() == 0 and UTask_Read == 0) or (UTask_Read == 1 and (HaveNormalItem(7, 24, 27, 0) >= 1 or IsSkillActived(27) >= 1))) then
        tasks[2].show = 1
    end
    SayTask(12501, Task1)
end
function AcceptThought()
    MsgBox(12502, "YesThought", "no")
end
function YesThought()
    SetTask(Task__Wellthought, 1)

    SetSubTask(905, 1, 1)

    TaskNote(905, 0)
    Talk(1, "no", 12503)

    refreshNpcTaskState()

end

function no()
    CloseDialog()
end;

function NewLifeMain()
    local menu = {
        { "ËÙÕ½ËÙ¾ö", "QuickOver"; show = 1 },
        { "Hoµn thµnh nhiÖm vô", "QuickOverComplete"; show = 0 },
        { "Rêi khái", "no"; show = 1 },
    }
    if (GetTaskByte(2089, 4) >= 20) then
        menu[1].show = 0
        menu[2].show = 1
    end
    local info = "×ªÑÛÒ»±ğÒÑÊÇÊıÄê, µ±ÄêÔÚ´óÓª±¼²¨Ã¦ÂµµÄĞ¡¼×Ê¿¾ÓÈ»ÒÑ¾­³ÉÏÉ·âÉñ, nhËn ®­îc Èç´Ë³É¾Í, ÕæÊÇÁîÈËÔŞÌ¾.ÀÏ·òËäÃ»ÓĞÉñ±øÀûÆ÷, µ«Ò²Ô¸ÖúÄãÒ»±ÛÖ®Á¦.ÄãÏÈÈ¥³ç³ÇÒ°Íâ´ò°Ü 20 c¸i ¾¸ÈËÊÊÓ¦Ò»ÏÂ·âÉñºóµÄÉñÌå, ÎÒÈ¥°ïÄã×¼±¸Ò»Ğ©×°±¸µ¤Ò©, ÄãÎÒÉÔºóÔÚ´ËÏà¼û."
    SayTask(info, menu)
end
function QuickOver()
    SetTaskBit(2089, 17, 1)
    TaskNote(2044, 1)
    Talk(1, "no", "Ç°Íù³ç³ÇÒ°Íâ´ò°Ü 20 c¸i ¾¸ÈËÊÊÓ¦Ò»ÏÂ·âÉñºóµÄÉñÌå")
end
function QuickOverComplete()
    if (GetTaskByte(2089, 4) >= 20) then
        TaskNote(2044, 3)
        local menu = {
            { "½ÓÊÜÀ¡Ôù", "AcceptItem"; show = 1 },
            { "Rêi khái", "no"; show = 1 },
        }
        local info = "Õâ¸ö°ü¹üÄÚÓĞCè Nguyªn §anÒ»Ã¶, ¿ÉÒÔ°ïÖúÄã»Ö¸´²¿·ÖÊµÁ¦, »¹ÓĞ´óÓª½«Ê¿ÃÅ´ÕµÄÒ»Ğ©×°±¸, Äã¿ÉÔÚÇ°ÆÚÊ¹ÓÃ.ÁíÍâ»¹ÓĞ3±¾S¸ch kü n¨ng ChuyÓn sinh¸øÄã, ¹ØÓÚS¸ch kü n¨ng ChuyÓn sinh, Äã¿ÉÒÔÔÚÎÒÕâÀïÏêÏ¸ÁË½â»ñµÃ vµ Ê¹ÓÃ·½·¨."
        SayTask(info, menu)
    else
        Talk(1, "no", "Äú»¹Î´Hoµn thµnh nhiÖm vô ´ò°Ü 20 c¸i ¾¸ÈËµÄ.")
    end

end
function AcceptItem()
    if (IsHaveSpaceForTreasure(7) == 0) then
        Talk(1, "no", "Hµnh trang ®· ®Çy, h·y s¾p xÕp l¹i hµnh trang.")
        return
    end
    SetTaskBit(2089, 18, 1)
    AddNormalItemBind(6, 1, 1412, 0, 0, 0, 1)
    AddNormalItemBind(6, 1, 1416, 0, 0, 0, 1)
    AddNormalItemBind(6, 1, 1420, 0, 0, 0, 1)

    AddNormalItemBind(8, 1831, 2, 1, 0, 0, 1)

    AddNormalItemBind(6, 1, 1424, 1, 0, 0, 1)

    local plr = GetPlayerType()
    if (plr == 0) then
        AddNormalItemBind(0, 0, 4 + plr, 5, 0, 0, 1)
    else
        AddNormalItemBind(0, 0, 5 + plr, 5, 0, 0, 1)
    end
    Talk(1, "no", "Chóc mõng ngµi nhËn ®­îc ³õ¼¶¡¤°ÙÁ¶¶ÍÌå, ³õ¼¶¡¤Ò»ÎÅÇ§Îò, ³õ¼¶¡¤·âÉñÖ®Á¦¼¼ÄÜÊé, Cè Nguyªn §an*1, Trang bŞ lôc cÊp 40Àñ°ü vµ Vò khİ Hoµng Kim cÊp 50.")
    TaskNote(2044, -1)
end


