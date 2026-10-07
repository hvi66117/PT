--description: ºóÍÁÍ¼ÌÚ-×°±¸ÏúÊÛÉÌ-ò¿ÓÈÄ¹1¼¶ÈÎÎñ
--author: yichuan
--date: 2004/6/29
--31 ĞÂÊ½×°±¸ÈÎÎñ¿ØÖÆ±äÁ¿

--1089 »¯½âÃ¬¶ÜÈÎÎñ¿ØÖÆ±äÁ¿
Task_Conflict = 1089

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

    --Ç¿ÕßÖ®Â·
    if (GetLevel() >= startLevel) and (GetPlayerType() == 2) then
        if (GetLevel() - startLevel <= 5) then
            local taskProcess = GetTask(30)
            if (taskProcess == 2) or (taskProcess == 3) then
                state = 3
                subState = 0
            elseif (taskProcess == 4) or (taskProcess == 15) then
                state = 0
                subState = 0
            end
        else
            local taskProcess = GetTask(30)
            if (taskProcess == 2) or (taskProcess == 3) then
                state = 3
                subState = 1
            elseif (taskProcess == 4) or (taskProcess == 15) then
                state = 0
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --ĞÂÊ½×°±¸
    startLevel = 3
    if (GetLevel() >= startLevel) and (GetPlayerType() == 2) then
        if (GetLevel() - startLevel <= 5) then
            local taskProcess = GetTask(31)
            if (taskProcess == 0) then
                state = 1
                subState = 0
            elseif (taskProcess == 1) then
                state = 2
                subState = 0
            elseif (taskProcess == 3) then
                state = 3
                subState = 0
            elseif (taskProcess == 15) then
                state = 0
                subState = 0
            end
        else
            local taskProcess = GetTask(31)
            if (taskProcess == 0) then
                state = 1
                subState = 1
            elseif (taskProcess == 1) then
                state = 2
                subState = 1
            elseif (taskProcess == 3) then
                state = 3
                subState = 1
            elseif (taskProcess == 15) then
                state = 0
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --»¯½âÃ¬¶Ü
    startLevel = 3
    if (GetLevel() >= startLevel) and (GetPlayerType() == 2) then
        if (GetLevel() - startLevel <= 5) then
            local taskProcess = GetTask(Task_Conflict)
            if (taskProcess == 0) and (GetTask(31) == 15) then
                state = 1
                subState = 0
            elseif (taskProcess == 1) then
                state = 0
                subState = 0
            end
        else
            local taskProcess = GetTask(Task_Conflict)
            if (taskProcess == 0) and (GetTask(31) == 15) then
                state = 1
                subState = 0
            elseif (taskProcess == 1) then
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
            if (GetTaskByte(Task_star, 1) == 5 and GetTaskByte(Task_collect, 4) == 0 and GetLevel() >= 37) then
                state = 3
                subState = 0
            end
        else
            if (GetTaskByte(Task_star, 1) == 5 and GetTaskByte(Task_collect, 4) == 0 and GetLevel() >= 37) then
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
        { "<c=yel>Khai Trİ<c>", "strongman"; show = 0 },
        { "<c=yel>Trang bŞ míi<c>", "renwu1"; show = 0 },
        { "<c=yel>Hßa gi¶i<c>", "ResolveConflict"; show = 0 },
        { "Tinh quang ¶m ®¹m", "star_dark"; show = 0 }, --Add by liuzhiqiang at  2009-5-4
    }
    UTask_20 = GetTask(30);
    if (((UTask_20 == 2) or (UTask_20 >= 3 and UTask_20 < 15 and UTask_20 ~= 4)) and GetPlayerType() == 2) then
        tasks[1].show = 1;
    end ;
    UTask_21 = GetTask(31);
    if (UTask_21 >= 3 and UTask_21 < 15) then
        tasks[2].show = 1;
    end ;
    if (UTask_21 == 0 and GetLevel() >= 3 and GetPlayerType() == 2) then
        tasks[2].show = 1;
    end ;

    local L_Resolve = GetTask(Task_Conflict)
    if (UTask_21 == 15 and L_Resolve == 0 and GetPlayerType() == 2) then
        tasks[3].show = 1;
    end ;

    -- Added by liuzhiqiang at 2009-5-4 Begin
    if (GetTaskByte(Task_star, 1) == 5 and GetTaskByte(Task_collect, 4) == 0 and GetLevel() >= 37) then
        tasks[4].show = 1
    end
    -- Added by liuzhiqiang at 2009-5-4 End

    SayTask(10154, tasks)
end;

function renwu1()
    UTask_21 = GetTask(31);
    if (UTask_21 >= 3 and UTask_21 < 15) then
        Earn(600)
        AddOwnExp(600)
        AddNormalItem(0, 6, 2, 1, 1, 0)
        TopMessage(12396)
        Msg2Player("Gióp HËu Thæ t×m nguyªn liÖu nhËn ®­îc 600 l­îng, 600 ®iÓm kinh nghiÖm vµ Lang Nha Yªu §¸i.")
        SetTask(31, 15)
        --AS GaoJingwei 090730
        SetSubTask(14, -1, 1)
        --AE GaoJingwei 090730
        TaskNote(14, -1)
        Talk(1, "yes_look", 12397)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    end ;

    if (UTask_21 == 0) and (GetLevel() >= 3) then
        MsgBox(10156, "yes_1", "no")
    end ;
end;

function yes_look()
    task_Resolve = {
        { "<c=yel>Hßa gi¶i<c>", "ResolveConflict"; show = 1 },
    }
    SayTask(10154, task_Resolve)
end
function yes_1()
    MsgBox(10157, "no")
    Msg2Player("T×m Thî ®ång hái nguyªn liÖu thİch hîp cña trang bŞ DŞ Nh©n")
    --AS GaoJingwei 090730
    SetSubTask(14, 1, 1)
    --AE GaoJingwei 090730
    TaskNote(14, 10)
    SetTask(31, 1)
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end;

--Ç¿ÕßÖ®Â·
function strongman()
    UTask_20 = GetTask(30);
    if (UTask_20 == 2) then
        Talk(1, "no", 10161)
        TaskNote(13, 11)
        SetTask(30, UTask_20 + 2)
        AddOwnExp(100)
        TopMessage(12130)
        AddNormalItem(0, 7, 2, 1, 1, 0)
        Msg2Player("NhËn ®­îc 100 ®iÓm kinh nghiÖm vµ Lang Nha Trô")
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    end ;

    if (UTask_20 >= 3 and UTask_20 < 15 and UTask_20 ~= 4) then
        Talk(1, "no", 12398)
        --AS GaoJingwei 090730
        SetSubTask(13, -1, 1)
        --AE GaoJingwei 090730
        TaskNote(13, -1)
        SetTask(30, 15)
        AddOwnExp(100)
        TopMessage(12130)
        AddNormalItem(0, 7, 2, 1, 1, 0)
        Msg2Player("NhËn ®­îc 100 ®iÓm kinh nghiÖm vµ Lang Nha Trô")
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    end ;

    if (GetLevel() >= 3 and GetTask(30) == 5) then
        Talk(1, "no", 12399)
        Msg2Player("Hoµn thµnh nhiÖm vô Khai Trİ")
        TopMessage(12400)
        if (GetTask(31) == 0) then
            Talk(1, "yes_NewWeapon", 12399)
        end
    end
end;

function yes_NewWeapon()
    task_NewWeapon = {
        { "<c=yel>Trang bŞ míi<c>", "renwu1"; show = 1 },
    }
    SayTask(12401, task_NewWeapon)
end

function ResolveConflict()
    MsgBox(12402, "yes_conflict", "no")
end;

function yes_conflict()
    Talk(1, "no", 12403)
    Msg2Player("GÆp Céng C«ng t×m hiÓu nguyªn nh©n bÊt hoµ.")
    SetTask(Task_Conflict, 1)
    --AS GaoJingwei 090730
    SetSubTask(999, 1, 1)
    --AE GaoJingwei 090730
    TaskNote(999, 0)
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end;

function no()
    CloseDialog()
end;

----------------Added by liuzhiqiang at 2009-5-4 Begin---------------ĞÇ¹â÷öµ­

function star_dark()
    CloseDialog()

    if (GetTaskByte(Task_star, 1) == 5 and GetTaskByte(Task_collect, 4) == 0 and GetLevel() >= 37) then

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
        BeginMotion(Task_collect - 503, 0, 5, "\\script\\motion\\ÊÕ¼¯ÁéÆø.lua", nInterrupt)
    end
end

----------------Added by liuzhiqiang at 2009-5-4 End---------------ĞÇ¹â÷öµ­
