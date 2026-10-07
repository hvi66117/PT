--description:Ëï×ÓÓð
--author: yangfeng
--date:2005/10/18

--¶«ÒÄÖ÷ÏßÈÎÎñ±äÁ¿£º583
--µËæ¿ÓñÉ±ËÀÁéÈÎÎñ¼ÆÊý£º584
--°Ý·ÃÄ§¼ÒËÄ½«ÈÎÎñ±äÁ¿£º585  1Îª¸Õ½ÓÈÎÎñ·ÃÎÊÁËÒ»ÈË  2£¬4£¬6 Îª·ÃÎÊÁËÁ½ÈË  5£¬7£¬9 Îª·ÃÎÊÁËÈýÈË 10 Îª·ÃÎÊÍê±Ï(ºìÈ¨ÖµÎª1 º£È¨ÖµÎª3 ÇàÈ¨ÖµÎª5)
--Ä§ÀñÊÙÉ±¶úÊóÈÎÎñ¼ÆÊý£º586 
--Ñ¯ÎÊÎäÍõæûÍõÈÎÎñ±äÁ¿£º587	1Îª¸Õ¸Õ½ÓÁËÈÎÎñ ÎäÍõÈ¨ÖµÎª1£¬æûÍõÈ¨ÖµÎª3
--Ñ°ÕÒÒÄÏÉ²ÝµÄÏÂÂä±äÁ¿£º588
--ÙÈÁúÈÎÎñ±äÁ¿£º589
--ÙÈ»¢ÈÎÎñ±äÁ¿£º590
--ÙÈÀÇÈÎÎñ±äÁ¿£º591
--ÎäÍõÔÄÐÅ£º592
--æûÍõÔÄÐÅ£º593
--µË¾Å¹«´ðÌâ²½Öè£º594
--ÒÄ×åÅ®×ÓËµ»°²½Öè£º595
--Àî¾¸¶Ô»°²½Öè£º596

--jiaruoting 13-18Ö§Ïß
Task_newer13 = 1416
--1byte ·´¿ÍÎªÖ÷ÈÎÎñ²½Öè£¨1½ÓÈÎÎñ£¬2ÕÒËï×ÓÓð£¬3µÃµ½ÐÅ´òÃºÓÍ£¬4ÉÕËþ£¬5Íê³É£©
--2byte ÓÀ³ýºó»¼ÈÎÎñ²½Öè£¨1½ÓÈÎÎñ£¬2ÕÒêËÌï£¬3ÄÃµÀ¾ß£¬4ÕÒÒ½Éú£¬5±ä²ÝÏÉ£¬6Íê³É£©

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

--½Å±¾ÅÐ¶ÏÍæ¼ÒµÄ×´Ì¬
function GetNpcTaskSatate()
    local state = 0
    local subState = 0
    local index = 10
    local startLevel = 10

    -- ·´¿ÍÎªÖ÷
    startLevel = 13
    if (GetLevel() >= startLevel) and (GetPlayerType() == 0) then
        local taskProcess = GetTaskByte(Task_newer13, 1)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 1) then
                state = 3
                subState = 0
            elseif (taskProcess == 2) and (HaveEventItem(242) >= 1) then
                state = 3
                subState = 0
            elseif (taskProcess == 2) then
                state = 2
                subState = 0
            elseif (taskProcess == 3) then
                state = 0
                subState = 0
            end
        else
            if (taskProcess == 1) then
                state = 3
                subState = 1
            elseif (taskProcess == 2) and (HaveEventItem(242) >= 1) then
                state = 3
                subState = 1
            elseif (taskProcess == 2) then
                state = 2
                subState = 0
            elseif (taskProcess == 3) then
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

--È¡µÃnpcµÄ×´Ì¬
function GetPlayerTaskState()
    local state, subState = GetNpcTaskSatate()
    return state, subState
end

--Ë¢ÐÂnpcµÄ×´Ì¬
function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end
-- AE GaoJingwei at 090728 end

function main()
    tasks = {
        { "Chiªu mé", "zhaomu1"; show = 0 },
        { "<c=yel>Ph¶n Kh¸ch Vi Chñ<c>", "renwu13"; show = 0 }
    }
    --	if(GetTask(597)==0)then
    --		tasks[1].show=1
    --	end;
    if (GetPlayerType() == 0 and GetLevel() >= 13) then
        local state13 = GetTaskByte(Task_newer13, 1)
        if (state13 == 1 or state13 == 2) then
            tasks[2].show = 1
        end
    end

    SayTask(11160, tasks)
end;

function zhaomu1()
    MsgBox(12609, "yes", "no")
end;

function yes()
    if (GetLevel() >= 70) then
        --		SetTask(597,1)
        --		Talk(3,"no","<color=green>"..GetName().."<color>¡G°ê®a¦³Ãø¡A¤Ç¤Ò¦³³d¡C¦óªp¤E¤½«Â¦W¡A¥@¤H¬Òª¾¡C¦b¤UÄ@·N«e©¹¡I","®]¤l¦Ð¡G§Ú´Nª¾¹D­^¶¯§A¬O¤£·|©Úµ´ªº¡C§A²{¦b³t¥h<color=red>¤T¤sÃö<color>§ä<color=green>¾H¤E¤½<color>¤j¤H§a¡C","<color=green>"..GetName().."<color>¡G¦nªº¡C¦b¤U°¨¤W´N°Ê¨­¡C")
        --		Msg2Player("«e©¹¤T¤sÃö»P¾H¤E¤½¹ï¸Ü¡C")
        --		TaskNote(35,0) 
    else
        Talk(2, "no", 12610, "<color=green>" .. GetName() .. "<c>:Uhm! Xem ra ta cÇn ph¶i luyÖn tËp thªm!")
    end ;
end;

function no()
    CloseDialog()
end;

function renwu13()
    if (GetPlayerType() == 0) then
        local state13 = GetTaskByte(Task_newer13, 1)
        if (state13 == 1) then
            Talk(2, "no", "Trong thµnh qu¶ nhiªn cã ng­êi t­ th«ng ngo¹i ®Þch, hiÖn giê d­êng nh­ ph¶n qu©n s¾p cã hµnh ®éng, <c=r>X¹ Nh©n ®Çu lÜnh<c> sÏ th©n chinh ®­a mËt tÝn ®Õn cho néi gi¸n, trao ®æi t×nh b¸o 2 bªn. HiÖn h¾n ®· ®Õn <c=r>B¾c H¶i<c>, hy väng anh hïng cã thÓ ®o¹t lÊy <c=g>mËt th­<c> gióp ta tr­íc khi nã ®Õn tay néi gi¸n.", GetName() .. " : Xin yªn t©m, t¹i h¹ nhÊt ®Þnh sÏ ®o¹t lÊy <c=g>mËt th­<c>.")
            Msg2Player("Tiªu diÖt ph¶n qu©n ®Çu lÜnh, nhËn ®­îc mËt th­.")
            SetTaskByte(Task_newer13, 1, 2)
            TaskNote(209, 1)
            --AS GaoJingwei 090728
            refreshNpcTaskState()
            --AE GaoJingwei 090728
        elseif (state13 == 2) then
            if (HaveEventItem(242) >= 1) then
                SetTaskByte(Task_newer13, 1, 3)
                ClearItem(4, 242, 1, 1)
                Talk(3, "no", "Tõ t×nh b¸o trong th­ xem ra ph¶n qu©n ®· chiÕm cø <c=r>B¾c H¶i<c> råi. Mét trong 6 tßa tiªu th¸p bªn ngoµi. §Ó phßng chèng t×nh huèng kÎ thï th©m nhËp Sïng Thµnh, hy vong anh hïng cã thÓ nhanh chèng ®i ph¸ ho¹i tßa Tiªu Th¸p nµy.", GetName() .. " §Ó b¶o vÖ Sïng Thµnh, ta ®ång ý gióp ®ì.", "Muèn ph¸ hñy Tiªu Th¸p cÇn sö dông DÇu löa, nh÷ng tªn <c=r>X¹ Nh©n<c> xuÊt hiÖn trong khu vùc B¾c H¶i lu«n mang theo bªn ng­êi nh÷ng <c=g>DÇu löa <c> dïng ®Ó c«ng thµnh, v× thÕ tr­íc tiªn ng­¬i h·y ®Õn B¾c H¶i tiªu diÖt chóng ®Ó thu thËp <c=g>DÇu löa<c>.")
                TaskNote(209, 3)
                --AS GaoJingwei 090728
                refreshNpcTaskState()
                --AE GaoJingwei 090728
            else
                Talk(1, "no", "Thêi gian cÊp b¸ch, anh hïng h·y mau ®o¹t lÊy <c=g>mËt th­<c>.")
            end
        end
    end
end
