--description: ×£ÈÚÍ¼ÌÚ-½ÌÁ·-ò¿ÓÈÄ¹10¼¶ÈÎÎñ
--author: yichuan
--date: 2004/5/15

--1089»¯½âÃ¬¶ÜÈÎÎñ¿ØÖÆ±äÁ¿
--35 ò¿ÓÈÉñÆ÷ÈÎÎñ¿ØÖÆ±äÁ¿
--Task_Body	 ¾£¼¬Ö®Â·¿ØÖÆ±äÁ¿
Task_Conflict = 1089
--
Task_Body = 1091
--

-----------³õÏÖ¶ËÄß ÈýÓãÖ®ÂÒ¡¢»ðÀëÐ¡Ñý¡¢±³ºóÖ÷Ä±-----------------
Task_Variety_Process = 1389        --1byte: 0Ã»ÁìÈÎÎñ£¬1ÁìÁËÈÎÎñ 2ÔÚÐÇ¹Ù´¦ÁìÈ¡ÁË½±Àø 3ÁìÈ¡ÁËÌ½ÖªÉ³»êµÄÈÎÎñ 4³É¹¦Óëµ¥´¿É³»ê¶Ô»° 5ÔÚ»ÆÌì»¯´¦ÁìÈ¡ÁË½±Àø
--6ÁìÈ¡ÁËÉ±ÈýÓãµÄÈÎÎñ  7ÓëÒ½Éú¶Ô»° 8Óë´óÍ·Óã¶Ô»° 9ÓëÕÛÂÞÓã¶Ô»° 10Óë¾Þ¹ÇÉàÓã¶Ô»° 11ÔÚ»ÆÌì»¯´¦½±Àø

--12¼ûÍê×£ÈÚ£¬13É±Íê15¸ö»ðÀëÐ¡Ñý£¬14µÃµ½½õ²¯£¬15×£ÈÚÔÄ¶Á¼ÇÒäºó£¬16ÁìÈ¡»ÆÌì»¯½±Àø    -----»ðÀë¾«ÆÇ

--2byte: 1½Óµ½¹ý³õ¼û¶ËÄßµÄÍ¨Öª 2½Óµ½¹ýÈýÓãÖ®ÂÒµÄÍ¨Öª 3½Óµ½¹ý»ðÀë¾«ÆÇµÄÍ¨Öª 4 ½Óµ½¹ý±³ºóÖ÷Ä±µÄÍ¨Öª

---------------------ÐÇ¹â÷öµ­-----------------
Task_star = 1417 -- 1byte: 1:ÐÇ¹Ù´¦½ÓÐÇ¹â÷öµ­ÈÎÎñ£»2:»ÄÄ®Ò½Éú´¦Ìýµ½ËµÃ÷ 3£ºÓë¹íÐ°ÑýÈËµÚÒ»´Î¶Ô»° 4: ÐÇ¹Ù¸æÖªÈ¥ÕÒÎ÷áªÌ«µß 5:Ì«µßÊÚÓèÁ¶ÑýÂ¯
--6: »Ùµô¹íÐ°ÑýÈËµÄÁé»ê 7: ÐÇ¹â÷öµ­ÈÎÎñÍê³É 8:ÐÇ¹Ù´¦½Ó³ý¶ñÎñ¾¡ÈÎÎñ£»9£ºµÃµ½Ë®Ð¾ 10: ÐÇ¹Ù´¦¸æÖª¹íÐ°ÑýÈËµÄÔªÉñÎ»ÖÃ
--11: Íæ¼ÒÊ¹ÓÃË®Ð¾Ê¹¹íÐ°ÑýÈËÏÖÉí 12£º³É¹¦É±ËÀ¹íÐ°ÑýÈËµÄÔªÉñ 13: Íê³É³ý¶ñÎñ¾¡ÈÎÎñ
-- 2byte: Á¶»¯É³»ê¸öÊý
-- 3byte: 1£ºÊÕ¼¯µ½º£ÐÄ²ÝµÄÖÖ×Ó 2: ÖÖÖ²º£ÐÄ²Ý 3£ºµÃµ½Ë®Ð¾

Task_collect = 1418 -- 1byte: 1:ÊÕ¼¯µ½Ë®£» 2byte: 1:ÊÕ¼¯µ½»ð£» 3byte: 1:ÊÕ¼¯µ½·ç£» 4byte:1£ºÊÕ¼¯µ½ÍÁ£»
---------------------ÐÇ¹â÷öµ­-----------------
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
    local startLevel = 1

    --ÑÔ¹éÓÚºÃ
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

    --ò¿ÓÈÉñÆ÷
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

    --¾£¼¬Ö®Â·
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

    --»ðÀë¾«ÆÇ
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

    --ÐÇ¹â÷öµ­
    startLevel = 37
    if (GetLevel() >= startLevel) then
        if (GetLevel() - startLevel <= 5) then
            --½ðÉ«
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

function main(sel)
    tasks = {
        { "<c=yel>Hßa gi¶i<c>", "ResovleConflict"; show = 0 },
        { "<c=yel>ThÇn KhÝ<c>", "renwu2"; show = 0 },
        { "<c=yel>Bôi gai<c>", "renwu1"; show = 0 },
        { "<c=yel>Hoµ thuËn<c>", "makeFriend"; show = 0 },
        { "Háa Ly Tinh Ph¸ch", "fireSoul"; show = 0 },
        { "Tinh quang ¶m ®¹m", "star_dark"; show = 0 }, --Add by liuzhiqiang at  2009-5-4
    }

    --	UTask_20 = GetTask(30);
    --	if (UTask_20==1) or (UTask_20==3)or (UTask_20==5)or(UTask_20==7)then
    --			tasks[1].show=1;
    --	end;
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

    ----------------Added by Laiyongcong 2009-04-20 begin---------»ðÀë¾«ÆÇ
    local Variety_Step = GetTaskByte(Task_Variety_Process, 1)
    if (GetTaskByte(Task_Variety_Process, 2) == 3) and ((Variety_Step >= 11 and Variety_Step < 15) or Variety_Step == 30) then
        tasks[5].show = 1
    end
    ----------------Added by Laiyongcong 2009-04-20 end-----------»ðÀë¾«ÆÇ

    -- Added by liuzhiqiang at 2009-5-4 Begin
    if (GetTaskByte(Task_star, 1) == 5 and GetTaskByte(Task_collect, 2) == 0 and GetLevel() >= 37) then
        tasks[6].show = 1
    end
    -- Added by liuzhiqiang at 2009-5-4 End

    SayTask(10218, tasks)
end;

----------------Added by liuzhiqiang at 2009-5-4 Begin---------------ÐÇ¹â÷öµ­

function star_dark()
    CloseDialog()

    if (GetTaskByte(Task_star, 1) == 5 and GetTaskByte(Task_collect, 2) == 0 and GetLevel() >= 37) then

        TopMessage("§ang thu thËp linh khÝ")
        Msg2Player("§ang thu thËp linh khÝ.")
        local nInterrupt = 0
        nInterrupt = SetBit(nInterrupt, 1, 1)    --µÇ³ö
        nInterrupt = SetBit(nInterrupt, 2, 1)    --ÒÆ¶¯
        nInterrupt = SetBit(nInterrupt, 3, 1)    --¼¼ÄÜ
        nInterrupt = SetBit(nInterrupt, 4, 1)    --ÊÜÉË
        nInterrupt = SetBit(nInterrupt, 5, 1)    --¿çµØÍ¼
        nInterrupt = SetBit(nInterrupt, 6, 0)    --·¨Æ÷
        nInterrupt = SetBit(nInterrupt, 9, 1)    --½ÇÉ«ËÀÍö
        nInterrupt = SetBit(nInterrupt, 10, 1)    --¹ÖÎïÄ¿±ê¶ªÊ§
        --		SetPlayerTarget(npcindex)				--ÉèÖÃÍæ¼ÒÑ¡ÖÐµÄ½ÇÉ«
        BeginMotion(Task_collect - 501, 0, 5, "\\script\\motion\\ÊÕ¼¯ÁéÆø.lua", nInterrupt)
    end
end

----------------Added by liuzhiqiang at 2009-5-4 End---------------ÐÇ¹â÷öµ­

----------------Added by Laiyongcong 2009-04-20 begin---------»ðÀë¾«ÆÇ
function find_fireSoul()
    NewWorld(21, 1955, 3345) --ÅÉµ½ÐùÔ¯¶´ÅÔ
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
        Talk(1, "no", "Kh«ng hái ®­îc tin g× tõ L·o Hå L« µ? H·y ®Õn TÇng 1 Hiªn Viªn §éng t×m §¹i Phu hái th¨m")
        return
    elseif (step == 14) then
        if (HaveNormalItem(6, 1, 486, 0) > 0) then
            talk(1, "no", "Sö dông Hån B¹ch, cã thÓ t×m manh mèi tõ L·o Hå l«")
        elseif (HaveNormalItem(4, 234, 1, 1) > 0) then
            --Íæ¼ÒÕÒ»ØÁË»ðÀë¾«ÆÇ
            Talk(1, "no", "Th× ra yªu vËt trong Hiªn Viªn ®éng kh«ng biÕt c¸i g× lµ Háa Linh, nh­ng cã ng­êi cho chóng Háa Linh, vµ d¹y chóng sö dông tiªn thuËt. Háa Linh cña ta cã lÏ ®· bÞ chia nhá ra ph¸t cho c¸c tiÓu yªu trong Hiªn Viªn ®éng råi, ng­¬i mau vÒ b¸o t×nh h×nh nµy cho Hoµng Thiªn Hãa.")
            ClearItem(4, 234, 1, 1) --¿Û³ýÍæ¼ÒÉíÉÏµÄ»ðÀë¾«ÆÇ
            Msg2Player("B¹n mÊt Háa Ly Tinh Ph¸ch")
            SetTaskByte(Task_Variety_Process, 1, 15)
            refreshNpcTaskState()
            TaskNote(1046, 5)
        else
            Talk(1, "no", "Ng­¬i t×m ®­îc manh mèi cña Háa Linh ch­a? Ta cÇn <c=g>Háa Ly Tinh Ph¸ch<c>, dïng Hån B¹ch cã thÓ hót Háa Ly Tinh Ph¸ch tõ ng­êi L·o Hå l«.") --
            --SetTaskByte(Task_Variety_Process,1,13)						--È·±£ÍòÎÞÒ»Ê§,»ØÍËµ½È¥ÕÒÒ½ÉúÌÖÒª»ê²¯
            --TaskNote(1046,2)
        end
        return
    end
end
----------------Added by Laiyongcong 2009-04-20 end-----------»ðÀë¾«ÆÇ


function renwu1()
    MsgBox(12354, "yes_rode", "no")
end;

function yes_rode()
    Talk(1, "no", 12355)
    SetTask(Task_Body, 1)
    Msg2Player("Sau cÊp 10 ®i t×m Phong B¸!")
    --AS GaoJingwei 090730
    SetSubTask(1006, 1, 1)
    --AE GaoJingwei 090730
    TaskNote(1006, 0)
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end
--function   renwu1()
--	UTask_20 = GetTask(30);
--	if(UTask_20==1)then
--			Talk(1,"no",10219)
--			Msg2Player("Óë×£ÈÚÍ¼ÌÚ½»Ì¸£¬µÃµ½×£ÈÚµÄÖ¸µã¡£")
--			TaskNote(13,2)
--			SetTask(30,UTask_20+8)
--	end;
--	if(UTask_20==3)then
--			Talk(1,"no",10219)
--			Msg2Player("Óë×£ÈÚÍ¼ÌÚ½»Ì¸£¬µÃµ½×£ÈÚµÄÖ¸µã¡£")
--			TaskNote(13,6)
--			SetTask(30,UTask_20+8)
--	end;
--	if(UTask_20==5)then
--			Talk(1,"no",10219)
--			Msg2Player("Óë×£ÈÚÍ¼ÌÚ½»Ì¸£¬µÃµ½×£ÈÚµÄÖ¸µã¡£")
--			TaskNote(13,4)
--			SetTask(30,UTask_20+8)
--	end;
--	if(UTask_20==7)then
--			Talk(1,"no",10219)
--			Msg2Player("Óë×£ÈÚÍ¼ÌÚ½»Ì¸£¬µÃµ½×£ÈÚµÄÖ¸µã¡£")
--			TaskNote(13,7)
--			SetTask(30,UTask_20+8)
--	end;
--end;
--
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
        --AS GaoJingwei 090730
        SetSubTask(17, -1, 1)
        --AE GaoJingwei 090730
        TaskNote(17, -1)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    elseif (UTask_25 == 0) and (GetPlayerType() == 2) and (GetLevel() >= 10) then
        MsgBox(12357, "yes_1", "no")
    end ;
end;

function yes_1()
    Talk(1, "no", 10222)
    SetTask(35, 1)
    Msg2Player("§i t×m Céng C«ng hái tin tøc cña  ThÇn KhÝ")
    --AS GaoJingwei 090730
    SetSubTask(17, 1, 1)
    --AE GaoJingwei 090730
    TaskNote(17, 10)
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end;

--function ResovleConflict()
--   local L_Resolve = GetTask(Task_Conflict)
--   if ( L_Resolve == 1 )then
-- modify by mayining 2009.2.11
--AddOwnExp(50)
--TopMessage(12358)
--Msg2Player("Äã»ñµÃÁË50¾­Ñé£¡")
--SetTask(Task_Conflict,2)
--TaskNote(1002,-1)
--Talk(1,"no",12359)
--   	Talk(1,"no","ÕÒ±ðÈËÈ¥£¡") --lijin
-- end by mayining
--   end;
--end;

-- modify by mayining 2009.2.11
function makeFriend()

    local L_Resolve = GetTask(Task_Conflict)
    if (L_Resolve == 4) then

        local nBookPiece = HaveNormalItem(3, 335, 0, 0)
        if (nBookPiece >= 1) then
            AddOwnExp(800)
            ClearItem(3, 335, 0, 0)
            AddNormalItem(7, 40, 43, 0, 0, 0)
            TopMessage("B¹n nhËn ®­îc 1 Kim Cang Chó")
            Msg2Player("B¹n nhËn ®­îc 800 kinh nghiÖm vµ Kim Cang Chó")
            --AS GaoJingwei 090730
            SetSubTask(1002, -1, 1)
            --AE GaoJingwei 090730
            TaskNote(1002, -1)
            SetTask(Task_Conflict, 5)
            refreshNpcTaskState()
            Talk(3, "no", "§©y ch¼ng ph¶i lµ quyÓn Kim Cang Chó cña Céng C«ng sao? LÏ nµo ®· t×m ®­îc råi?", GetName() .. ":§óng vËy, Céng C«ng v× chuyÖn nµy lu«n tù tr¸ch, ®å vËt ®· t×m ®­îc, chi b»ng c¸c ng­êi h·y b¾t tay lµm lµnh víi nhau.", " ThËt ra ta ®· quªn chuyÖn nµy tõ l©u råi! QuyÓn Kim Cang Chó nµy tÆng cho ng­¬i. Sau cÊp <c=g>10<c> h·y quay l¹i gÆp ta!") --lijin
            --AS GaoJingwei 090728
            refreshNpcTaskState()
            --AE GaoJingwei 090728
        else
            Talk(1, "no", "T×m ta cã viÖc g× kh«ng?") --lijin
        end

    end

end
-- end by mayining

function yes_god()
    tasks_god = {
        { "<c=yel>ThÇn KhÝ<c>", "renwu2"; show = 1 },
    }
    SayTask(10218, tasks_god)
end;

function no()
    CloseDialog()
end;
