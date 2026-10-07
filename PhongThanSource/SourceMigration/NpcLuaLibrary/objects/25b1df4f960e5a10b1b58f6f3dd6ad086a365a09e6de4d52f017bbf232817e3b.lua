--description: ¹²¹¤Í¼ÌÚ-ÎäÆ÷ÏúÊÛÉÌ
--author: yichuan
--date: 2004/5/15
--35  ò¿ÓÈÉñÆ÷ÈÎÎñ×´Ì¬¿ØÖÆ±äÁ¿
Task_Conflict = 1089
--

---------------------ĞÇ¹â÷öµ­-----------------
Task_star = 1417 -- 1byte: 1:ĞÇ¹Ù´¦½ÓĞÇ¹â÷öµ­ÈÎÎñ£»2:»ÄÄ®Ò½Éú´¦Ìıµ½ËµÃ÷ 3£ºÓë¹íĞ°ÑıÈËµÚÒ»´Î¶Ô»° 4: ĞÇ¹Ù¸æÖªÈ¥ÕÒÎ÷áªÌ«µß 5:Ì«µßÊÚÓèÁ¶ÑıÂ¯
--6: »Ùµô¹íĞ°ÑıÈËµÄÁé»ê 7: ĞÇ¹â÷öµ­ÈÎÎñÍê³É 8:ĞÇ¹Ù´¦½Ó³ı¶ñÎñ¾¡ÈÎÎñ£»9£ºµÃµ½Ë®Ğ¾ 10: ĞÇ¹Ù´¦¸æÖª¹íĞ°ÑıÈËµÄÔªÉñÎ»ÖÃ
--11: Íæ¼ÒÊ¹ÓÃË®Ğ¾Ê¹¹íĞ°ÑıÈËÏÖÉí 12£º³É¹¦É±ËÀ¹íĞ°ÑıÈËµÄÔªÉñ 13: Íê³É³ı¶ñÎñ¾¡ÈÎÎñ
-- 2byte: Á¶»¯É³»ê¸öÊı
-- 3byte: 1£ºÊÕ¼¯µ½º£ĞÄ²İµÄÖÖ×Ó 2: ÖÖÖ²º£ĞÄ²İ 3£ºµÃµ½Ë®Ğ¾

Task_collect = 1418 -- 1byte: 1:ÊÕ¼¯µ½Ë®£» 2byte: 1:ÊÕ¼¯µ½»ğ£» 3byte: 1:ÊÕ¼¯µ½·ç£» 4byte:1£ºÊÕ¼¯µ½ÍÁ£»
---------------------ĞÇ¹â÷öµ­-----------------
-- AS GaoJingwei at 090728 
NpcState = {
    [1] = { state = 3, subState = 0, str = "Vµng më" },
    [2] = { state = 3, subState = 1, str = "Lam më" },
    [3] = { state = 1, subState = 0, str = "Vµng ®ãng" },
    [4] = { state = 1, subState = 1, str = "Lam ®ãng" },
    [5] = { state = 2, subState = 0, str = "X¸m më" },
    [6] = { state = 0, subState = 0, str = "Kh«ng cã nhiÖm vô" },
}

--ËÑË÷ÓÅÏÈ¼¶×î¸ßµÄ×´Ì¬
function searchForIndex(state, subState, index)
    for i = 1, getn(NpcState) do
        if (i > index) then
            break
        end

        if (state == NpcState[i].state) and (subState == NpcState[i].subState) then
            index = i
        end
    end
    return index
end

--½Å±¾ÅĞ¶ÏÍæ¼ÒµÄ×´Ì¬
function GetNpcTaskSatate()
    local state = 0
    local subState = 0
    local index = 10
    local startLevel = 1

    --»¯½âÃ¬¶Ü
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

    --ÑÔ¹éÓÚºÃ
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

    --ò¿ÓÈÉñÆ÷
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

    --ĞÇ¹â÷öµ­
    startLevel = 37
    if (GetLevel() >= startLevel) then
        if (GetLevel() - startLevel <= 5) then
            --½ğÉ«
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

--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    local state, subState = GetNpcTaskSatate()
    return state, subState
end

--Ë¢ĞÂnpcµÄ×´Ì¬
function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end
-- AE GaoJingwei at 090728 end

function main(sel)
    tasks = {
        { "<c=yel>ThÇn Khİ<c>", "renwu1"; show = 0 },
        { "<c=yel>Hßa gi¶i<c>", "ResovleConflict"; show = 0 },
        { "<c=yel>Hoµ thuËn<c>", "makeFriend"; show = 0 },
        { "B¸o danh", "renwu"; show = 0 },
        { "Tinh quang ¶m ®¹m", "star_dark"; show = 0 }, --Add by liuzhiqiang at  2009-5-4
    }
    UTask_25 = GetTask(35);
    if (UTask_25 == 5) and (GetItemCount(28) >= 3) then
        tasks[1].show = 1;
    end ;
    if (UTask_25 == 1) then
        tasks[1].show = 1;
    end ;

    -- add by mayining 2009.2.11
    local L_Resolve = GetTask(Task_Conflict)
    if (L_Resolve == 1) and (GetPlayerType() == 2) then
        tasks[2].show = 1;
    elseif ((L_Resolve == 2) or (L_Resolve == 3)) and (GetPlayerType() == 2) then
        tasks[3].show = 1;
    end ;
    -- end by mayining

    -- Added by liuzhiqiang at 2009-5-4 Begin
    if (GetTaskByte(Task_star, 1) == 5 and GetTaskByte(Task_collect, 1) == 0 and GetLevel() >= 37) then
        tasks[5].show = 1
    end
    -- Added by liuzhiqiang at 2009-5-4 End

    if (GetLevel() < 20) and (SystemTime() > 1111140000) and (SystemTime() < 1111226400) then
        tasks[4].show = 1;
        SayTask(12339, tasks)
    else
        SayTask(10151, tasks)
    end ;
end;

-- add by mayining 2009.2.11
function makeFriend()

    local L_Resolve = GetTask(Task_Conflict)
    if (L_Resolve == 2) then

        MsgBox("Céng C«ng:Ta mÊt <c=g>[5 trang s¸ch r¸ch]<c> vµ <c=g>[1 TuyÕn quyÓn]<c>, nÕu ng­¬i gióp ta t×m l¹i th× sÏ ho¸ gi¶i ®­îc mèi bÊt hoµ víi Chóc Dung!", "makeFriendFinal", "no") --lijin

    elseif (L_Resolve == 3) then

        local nBookPiece = HaveNormalItem(3, 333, 0, 0)
        local nBookThread = HaveNormalItem(3, 334, 0, 0)
        if (nBookPiece >= 5) and (nBookThread >= 1) then
            ClearItem(3, 333, 0, 0)
            ClearItem(3, 334, 0, 0)
            AddNormalItem(3, 335, 0, 0, 0, 0)
            TaskNote(1002, 3)
            SetTask(Task_Conflict, 4)
            --AS GaoJingwei 090728
            refreshNpcTaskState()
            --AE GaoJingwei 090728
            Talk(1, "no", "§©y chİnh lµ nh÷ng trang s¸ch mµ ta ®¸nh mÊt. H·y ®îi ta ®ãng nã l¹i, sau ®ã gióp ta mang ®Õn cho <c=g>Chóc Dung<c>!")--lijin
        else
            Talk(1, "no", "Ng­¬i vÉn ch­a t×m ®ñ <c=g>[5 trang s¸ch r¸ch]<c> vµ <c=g>[1 TuyÕn quyÓn]<c>!") --lijin
        end

    end

end

function makeFriendFinal()

    local L_Resolve = GetTask(Task_Conflict)

    if (L_Resolve == 2) then
        SetTask(Task_Conflict, 3)
        Talk(3, "no", GetName() .. ":VËy «ng cã nhí lµm thÊt l¹c ë ®©u kh«ng? Kh«ng chõng t¹i h¹ cã thÓ gióp!", "Ta nhí lóc ®i ngang qua Miªu C­¬ng, gÆp ph¶i <c=g>Háa DiÖn vµ Cuång §iªu<c> tÊn c«ng, sau ®ã…", GetName() .. ":Xem ra trªn ng­êi <c=g>Háa DiÖn vµ Cuång §iªu<c> cã chót manh mèi.")--lijin
        --AS GaoJingwei 090730
        SetSubTask(1002, 1, 1)
        --AE GaoJingwei 090730
        TaskNote(1002, 0)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    end

end

function ResovleConflict()
    local L_Resolve = GetTask(Task_Conflict)
    if (L_Resolve == 1) then
        AddOwnExp(50)
        TopMessage(12358)
        Msg2Player("B¹n nhËn ®­îc 50 ®iÓm kinh nghiÖm!")
        SetTask(Task_Conflict, 2)
        --AS GaoJingwei 090730
        SetSubTask(999, -1, 1)
        --AE GaoJingwei 090730
        TaskNote(999, -1)
        Talk(1, "makeFriend", 12359)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    end ;
end
-- end by mayining

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
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    end ;

    if (UTask_25 == 1) then
        Talk(1, "no", "<c=r>ThÇn Khİ<c> trong lóc tÕ tæ ®· bŞ <c=g>Th¶o Tiªn bµ bµ<c> dïng H¾c Phong thuËt c­íp ®i, nh­ng Chóc Dung l¹i hiÓu lµm lµ do ta lÊy! NÕu ng­¬i gióp ta t×m ®­îc <c=g>3 m¶nh ThÇn khİ<c> ta sÏ håi phôc ®­îc nguyªn tr¹ng cho nã. §­êng xa hung hiÓm, tÆng ng­¬i <c=g>5 Håi thµnh phï<c> nµy ®Ó tiÖn ®i tiÖn vÒ!")
        Msg2Player("NhËn ®­îc 5 Håi thµnh phï. Tiªu diÖt Th¶o Tiªn bµ bµ, mang 3 m¶nh ThÇn Khİ vÒ cho Céng C«ng!")
        for i = 1, 5 do
            AddNormalItemPile(5, 0, 0, 1, 0, 0)
        end
        TaskNote(17, 11)
        SetTask(35, 2)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
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
        nInterrupt = SetBit(nInterrupt, 1, 1)    --µÇ³ö
        nInterrupt = SetBit(nInterrupt, 2, 1)    --ÒÆ¶¯
        nInterrupt = SetBit(nInterrupt, 3, 1)    --¼¼ÄÜ
        nInterrupt = SetBit(nInterrupt, 4, 1)    --ÊÜÉË
        nInterrupt = SetBit(nInterrupt, 5, 1)    --¿çµØÍ¼
        nInterrupt = SetBit(nInterrupt, 6, 0)    --·¨Æ÷
        nInterrupt = SetBit(nInterrupt, 9, 1)    --½ÇÉ«ËÀÍö
        nInterrupt = SetBit(nInterrupt, 10, 1)    --¹ÖÎïÄ¿±ê¶ªÊ§
        --		SetPlayerTarget(npcindex)				--ÉèÖÃÍæ¼ÒÑ¡ÖĞµÄ½ÇÉ«
        BeginMotion(Task_collect - 500, 0, 5, "\\script\\motion\\ÊÕ¼¯ÁéÆø.lua", nInterrupt)
    end
end;
