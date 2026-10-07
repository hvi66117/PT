--description: ·ç²®Í¼ÌÚ-ò¿ÓÈÄ¹
--author: yichuan
--date: 2004/5/15
--34Óª¾È×åÈËÈÎÎñ¿ØÖÆ±äÁ¿
--	  ¾£¼¬Ö®Â·µÄÈÎÎñ¿ØÖÆ±äÁ¿
Task_Body = 1091
--    ½µÑı³ıÄ§µÄÈÎÎñ¿ØÖÆ±äÁ¿
Task_KillDevil = 1092
--
--	  Ì¦ÑıÖ®»¼µÄÈÎÎñ¿ØÖÆ±äÁ¿
Task_DevilDisaster = 1097
Task_DevilNum = 1098
Task_DevilMonster = {
    { name = "Lôc Qu¸i", id = 5, num = 12 },
}
--yaoxin 13-18Ö§Ïß ÒìÈË
Task_newer13 = 1416 --1byte Â÷Ìì¹ıº£ÈÎÎñ²½Öè£¨1·ç²®Í¼ÌÚ½ÓÈÎÎñ2È¥ÕÒÓÎ»ê¹ØµÄÒ½Éú3»¹¸øÕÅÌì¾ı4ò¿ÓÈÄ¹Ò½Éú5¸æÖ®ÕÅÌì¾ı6ÕÒ·ç²®Í¼ÌÚ7»Ø¸´ÕÇÌì¾ı8Íê³É£©
--2byteÖØ»ñÏÉµ¤ÈÎÎñ²½Öè (1ÕÒ¿ä¸¸Í¼ÌÚ2±¸×ã²ÄÁÏ3Ãç½®Ò½Éú4½Ø½ÌÅÑÍ½ÒÑ¾­Ò×Èİ³É²İÏÉ5²İÏÉÏÖ³öÔ­ĞÎ6»Ø·ç²®Í¼ÌÚ¸´Ãü,7Íê³É)

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
    local startLevel = 10

    --½µÑı³ıÄ§
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

    --¾£¼¬Ö®Â·
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

    --Â÷Ìì¹ıº£
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

    --Óª¾È×åÈË
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

    --Ì¦ÑıÖ®»¼
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

    --ÖØ»ñÏÉµ¤
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


    --ĞÇ¹â÷öµ­
    startLevel = 37
    if (GetLevel() >= startLevel) then
        if (GetLevel() - startLevel <= 5) then
            --½ğÉ«
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
        { "<c=yel>Bôi gai<c>", "renwu1"; show = 0 },
        { "<c=yel>Trõ yªu<c>", "KillDevil"; show = 0 },
        { "<c=yel>Cøu tÕ<c>", "renwu2"; show = 0 },
        { "<c=yel>Lôc Qu¸i Chi Ho¹n<c>", "DevilDisaster"; show = 0 },
        { "<c=yel>Hñy n/v Trõ yªu<c>", "GiveUpKillDevil"; show = 0 },
        { "<c=yel>M·nThiªnQu¸H¶i<c>", "renwu13"; show = 0 },
        { "<c=yel>Trïng Ho¹ch Tiªn §¬n<c>", "renwu18"; show = 0 },
        { "Tinh quang ¶m ®¹m", "star_dark"; show = 0 }, --Add by liuzhiqiang at  2009-5-4
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

    -- Added by liuzhiqiang at 2009-5-4 Begin
    if (GetTaskByte(Task_star, 1) == 5 and GetTaskByte(Task_collect, 3) == 0 and GetLevel() >= 37) then
        tasks[8].show = 1
    end
    -- Added by liuzhiqiang at 2009-5-4 End

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
    --AS GaoJingwei 090730
    SetSubTask(1006, -1, 1)
    --AE GaoJingwei 090730
    TaskNote(1006, -1)
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
    --	MsgBox("¸ÉµÄºÃ£¬Äã½«À´±Ø¶¨ÄÜÓĞËù³É¾ÍµÄ£¡","EnterKillDevil","no")
end;

--function  renwu1()
--	UTask_20 = GetTask(30);
--	if (UTask_20==1) then
--			Talk(1,"no",10138)
--			Msg2Player("Óë·ç²®Í¼ÌÚ½»Ì¸£¬µÃµ½·ç²®µÄÖ¸µã¡£")
--			TaskNote(13,1)
--			SetTask(30,UTask_20+2)
--	end;
--	if (UTask_20==5) then
--			Talk(1,"no",10138)
--			Msg2Player("Óë·ç²®Í¼ÌÚ½»Ì¸£¬µÃµ½·ç²®µÄÖ¸µã¡£")
--			TaskNote(13,5)
--			SetTask(30,UTask_20+2)
--	end;
--	if(UTask_20==9)then
--			Talk(1,"no",10138)
--			Msg2Player("Óë·ç²®Í¼ÌÚ½»Ì¸£¬µÃµ½·ç²®µÄÖ¸µã¡£")
--			TaskNote(13,6)
--			SetTask(30,UTask_20+2)
--	end;
--	if(UTask_20==13)then
--			Talk(1,"no",10138)
--			Msg2Player("Óë·ç²®Í¼ÌÚ½»Ì¸£¬µÃµ½·ç²®µÄÖ¸µã¡£")
--			TaskNote(13,7)
--			SetTask(30,UTask_20+2)
--	end;
--end;

function renwu2()
    UTask_24 = GetTask(34);
    if (UTask_24 >= 4 and UTask_24 < 15) then
        --AS GaoJingwei 090730
        SetSubTask(16, -1, 1)
        --AE GaoJingwei 090730
        TaskNote(16, -1)
        SetTask(34, 15)
        AddOwnExp(2000)
        TopMessage(12308)
        --for i=1,5 do
        --AddNormalItem(5,0,1,0,0,0)
        --end
        --Msg2Player("½±Àø2000¾­Ñé¡¢10ÕÅ»Ø³Ç·û£¡")
        AddItemPileNum(5, 0, 0, 1, 10)        --added by hyz for ÓÅ»¯ 090709
        Msg2Player(" phÇn th­ëng 2000 kinh nghiÖm, 10 Håi thµnh phï!")
        Talk(1, "Revenge", 12309)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    end ;

    if (UTask_24 == 0) and (GetPlayerType() == 2) and (GetLevel() >= 14) then
        MsgBox(10140, "yes_1", "no")

    end ;
end;

function yes_1()
    Talk(1, "no", 10141)
    SetTask(34, 1)
    Msg2Player("§Õn Cù Léc t×m Thñ lÜnh téc nh©n bŞ mÊt tİch!")
    --AS GaoJingwei 090730
    SetSubTask(16, 1, 1)
    --AE GaoJingwei 090730
    TaskNote(16, 10)
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end;

--Ñ¡ÔñÊÇ·ñ½Ó½µÑı·üÄ§µÄÈÎÎñ
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
        AddOwnExp(2000)
        AddNormalItem(0, 2, 2, 1, 0, 0)
        SetTask(Task_KillDevil, 11)
        TopMessage(12312)
        Msg2Player("B¹n nhËn ®­îc 2000 ®iÓm kinh nghiÖm vµ 1 Lang Nha Hé Gi¸p.")
        --AS GaoJingwei 090730
        SetSubTask(1004, -1, 1)
        --AE GaoJingwei 090730
        TaskNote(1004, -1)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    end ;
end;

function Yes_KillDevil()
    if (GetTask(Task_KillDevil) == 0) then
        Talk(1, "no", 12313)
        SetTask(Task_KillDevil, 1)
        --AS GaoJingwei 090730
        SetSubTask(1004, 1, 1)
        --AE GaoJingwei 090730
        TaskNote(1004, 0)
        Msg2Player("B¹n nhËn ®­îc l­¬ng thùc")
        AddNormalItem(6, 1, 275, 1, 0, 0)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    end
end

function Revenge()
    taskrevenge = {
        { "<c=yel>Lôc Qu¸i Chi Ho¹n<c>", "DevilDisaster"; show = 1 },
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
        local prop = random(35, 59)
        AddNormalItem(6, 1, prop, 1, 0, 0, 0)
        AddOwnExp(5000)
        TopMessage(12317)
        Msg2Player("NhËn ®­îc 5000 kinh nghiÖm.")
        SetTask(Task_DevilDisaster, 10)
        --AS GaoJingwei 090730
        SetSubTask(1007, -1, 1)
        --AE GaoJingwei 090730
        TaskNote(1007, -1)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    end ;
end;

function yes_Kill()
    Talk(1, "no", 12318)
    Msg2Player("Thu phôc 12 Lôc Qu¸i dÉn dô Lôc Qu¸i V­¬ng, ®o¹t ®­îc 3 LÖnh bµi.")
    SetTask(Task_DevilDisaster, 1)
    SetTask(Task_DevilNum, 0)
    SetTask(Task_DevilNum, SetByte(GetTask(Task_DevilNum), 1, Task_DevilMonster[1].id))
    SetTask(Task_DevilNum, SetByte(GetTask(Task_DevilNum), 2, Task_DevilMonster[1].num))
    --AS GaoJingwei 090730
    SetSubTask(1007, 1, 1)
    --AE GaoJingwei 090730
    TaskNote(1007, 0)
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end
--

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

----------------13,18ĞÂÊÖÈÎÎñ----yaoxin 09/04/28
function renwu13()
    CloseDialog()
    if (GetLevel() < 13) then
        Talk(1, "no", "Víi n¨ng lùc hiÖn t¹i cña anh hïng e lµ ch­a gióp ®­îc ta, ®Õn cÊp 13 h·y ®Õn.")
        return 0
    end

    local state13 = GetTaskByte(Task_newer13, 1)
    if (state13 == 0) then
        MsgBox("Tr­¬ng Thiªn Qu©n cã gëi 1 linh ®an diÖu d­îc <c=g>Thiªn Niªn B¶o T©n §an <c> ë chç ta, nh­ng h«m qua bŞ kÎ trém lÊy mÊt, nay Tr­¬ng Thiªn Qu©n muèn lÊy b¸u vËt vÒ, nh­ng nay ®· bŞ mÊt, hy väng anh hïng cã thÓ gióp ta.", "yes_sea", "no")
    elseif (state13 == 6) then
        Talk(2, "no", GetName() .. "T×m ®Õn VËt tæ Phong B¸, b¸o thuèc lµ gi¶.", "VÉn bŞ c¸c ng­êi ph¸t hiÖn, tuy h×nh d¸ng thuèc nµy gièng thuèc cña Tr­¬ng Thiªn Qu©n, nh­ng bªn trong l¹i kh¸c, ta kh«ng muèn g¹t c¸c ng­¬i, chØ lµ muèn t¹m thêi thay thÕ thuèc thËt tr¶ cho Tr­¬ng Thiªn Qu©n, nh­ vËy ta sÏ cã thêi gian t×m kÎ trém thuèc, lóc ®ã sÏ hoµn tr¶.")
        SetTaskByte(Task_newer13, 1, 7)
        Msg2Player("Nãi cho Tr­¬ng Thiªn Qu©n biÕt c¸ch nghÜ cña VËt tæ Phong B¸.")
        TaskNote(205, 6)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    end
end

function yes_sea()
    Talk(2, "no", GetName() .. "Lµm sao ®Ó gióp ®­îc ng­êi, xin h·y nãi râ.", "Phong B¸ VËt tæ:ChÕ luyÖn l¹i ®¬n d­îc cÇn ®i <c=r>Du Hån<c> thu thËp<c=g>má Cuång §iªu<c> vµ <c=g>n­íc m¾t Lôc Qu¸i<c> lµm nguyªn liÖu. §¹i Phu ë Du Hån cã thÓ dïng Tam Muéi Ch©n Háa luyÖn c¸c vËt phÈm Êy thµnh linh ®¬n diÖu d­îc.")
    SetTaskByte(Task_newer13, 1, 1)
    Msg2Player("§Õn ¶i Du Hån thu thËp má Cuång §iªu vµ n­íc m¾t Lôc Qu¸i.")
    --AS GaoJingwei 090730
    SetSubTask(205, 1, 1)
    --AE GaoJingwei 090730
    TaskNote(205, 0)
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end

function CompleteMission()

    AddItemPileNum(1, 0, 0, 0, 10)                --Ôö¼Ó10¸öĞ¡ºìµ¤
    AddItemPileNum(1, 3, 0, 0, 10)                --Ôö¼Ó10¸öĞ¡»¹µ¤
    Msg2Player("NhËn ®­îc 10 TiÓu Hång §¬n vµ 10 TiÓu Hoµn §¬n.")

    Talk(1, "no", "§a t¹ anh hïng gióp ®ì, gióp ta vµ Tr­¬ng Thiªn Qu©n khái sù hiÓu lÇm, ta sÏ tr¶ thuèc b¸u cho Tr­¬ng Thiªn Qu©n. §©y cã trang bŞ cÊp 20, xem nh­ phÇn th­ëng ta tÆng ng­êi.")
    SetTaskByte(Task_newer13, 2, 7)
    DelEventItem(237)
    Msg2Player("NhËn ®­îc trang bŞ cÊp 20 vµ 3000 ®iÓm kinh nghiÖm.")
    AddOwnExp(3000)
    --AS GaoJingwei 090730
    SetSubTask(206, -1, 1)
    --AE GaoJingwei 090730
    TaskNote(206, -1)
    if (random(1, 2) == 1) then
        AddBlueEquip(0, 2, 2, 2, 0, 1, 1)--À¶×°
    else
        AddBlueEquip(0, 9, 2, 2, 0, 1, 1)--À¶×°
    end
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728

end

function renwu18()
    CloseDialog()
    local state18 = GetTaskByte(Task_newer13, 2)
    if (state18 == 0) then
        MsgBox("Ta ®· t×m ®­îc tung tİch cña thuèc b¸u råi, 1 tªn ph¶n ®å TriÖt gi¸o muèn ®éc chiÕm thuèc nµy ®Ó tu luyÖn, nay h¾n ®· ®em thuèc cao ch¹y xa bay råi, anh hïng mau ®i thu phôc h¾n, lÊy l¹i thuèc b¸u.", "yes_drug", "no")
    elseif (state18 == 6) then

        if (HaveNormalItem(1, 0, 0, 0) == 0 and HaveNormalItem(1, 3, 0, 0) == 0) then

            if (IsHaveSpaceForTreasure(3) > 0) then
                --±³°üÖĞÃ»ÓĞĞ¡ºìµ¤ºÍĞ¡»¹µ¤ »¹Ğè¶îÍâÅĞ¶ÏÊÇ·ñ¿ÉÒÔ·ÅÏÂ½±ÀøµÄ×°±¸

                CompleteMission()                            --Íê³ÉÈÎÎñ

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
        --Talk(1,"no","·ç²®Í¼ÌÚ£º¶àĞ»Ó¢ĞÛ°ïÃ¦£¬²ÅÊ¹ÎÒÄÜÓëÕÅÌì¾ı»¯¸É¸êÎªÓñ²¯£¬ÎÒ»á°Ñ±¦Ò©»¹¸øÕÅÌì¾ıµÄ¡£ÕâÀïÓĞÒ»¼ş20¼¶×°±¸£¬¾ÍËÍ¸øÄã×öÎª½±ÀøÁË¡£")
        --SetTaskByte(Task_newer13,2,7)
        --DelEventItem(237)
        --Msg2Player("»ñµÃÒ»¼ş20¼¶×°±¸ºÍ3000¾­Ñé½±Àø¡£")
        --AddOwnExp(3000)
        --TaskNote(206,-1)
        --if (random(1,2) == 1) then
        --AddBlueEquip(0,2,2,2,0,1,1)--À¶×°
        --else
        --AddBlueEquip(0,9,2,2,0,1,1)--À¶×°
        --end
    end
end

function yes_drug()
    Talk(2, "no", GetName() .. "V× chİnh ®¹o, ta nguyÖn tr¶m yªu trõ ma, nh­ng lµm c¸ch nµo ®Ó thu phôc ng­êi nµy mong c¸c h¹ chØ b¶o.", "H¾n kh«ng ph¶i kÎ tÇm th­êng, víi n¨ng lùc ng­¬i hiÖn nay th× kh«ng ®­îc, anh hïng cã thÓ t×m <c=r>VËt Tæ Khoa Phô<c> m­în b¸u vËt <c=g>Tô Hån Th¸nh<c>, thu phôc h¾n.")
    SetTaskByte(Task_newer13, 2, 1)
    Msg2Player("T×m VËt Tæ Khoa Phô m­în Tô Hån Th¸nh, thu phôc ph¶n ®å TriÖt gi¸o.")
    --AS GaoJingwei 090730
    SetSubTask(206, 1, 1)
    --AE GaoJingwei 090730
    TaskNote(206, 0)
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end
---------end

----------------Added by liuzhiqiang at 2009-5-4 Begin---------------ĞÇ¹â÷öµ­

function star_dark()
    CloseDialog()

    if (GetTaskByte(Task_star, 1) == 5 and GetTaskByte(Task_collect, 3) == 0 and GetLevel() >= 37) then

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
        BeginMotion(Task_collect - 502, 0, 5, "\\script\\motion\\ÊÕ¼¯ÁéÆø.lua", nInterrupt)
    end
end

----------------Added by liuzhiqiang at 2009-5-4 End---------------ĞÇ¹â÷öµ­
