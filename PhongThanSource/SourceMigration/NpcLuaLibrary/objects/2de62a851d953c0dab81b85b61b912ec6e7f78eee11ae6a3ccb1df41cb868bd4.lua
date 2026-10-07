--description: ½ª×ÓÑÀ-µÀÊ¿Ö÷Ïß?Îñ
--author: yichuan
--date:2004/4/27

-- Added by zhaoqingsong at 2008-7-23 begin
-- ºß¹ş¶ş½«¼°¼«º®¶³ÆøÈÎÎñÉèÖÃ

CONFIG_LEVEL_HHEJ = 67      -- ºß¹ş¶ş½«ÈÎÎñµÈ¼¶
CONFIG_LEVEL_JHDQ = 68      -- ¼«º®¶³ÆøÈÎÎñµÈ¼¶

-- ºß¹ş¶ş½«ÈÎÎñ±äÁ¿ID
-- 1 byte ÈÎÎñ×´Ì¬:
-- 0,Î´ÉêÁì; 1,ÒÑÉêÁìºß¹ş¶ş½«ÈÎÎñ; 2,´òÄ¥¶¨ÒôÖé³É¹¦;
-- 3,ÕÒÖ£Â××¢Òô,Î´ÕÒ³ÂÆæ×¢Òô; 4,ÕÒ³ÂÆæ×¢Òô,Î´ÕÒÖ£Â××¢Òô;
-- 5,×¢ÒôÍê³É; 6,ÕÒ½ª×ÓÑÀ½»ÈÎÎñÍê³É;
-- 11, ½Ó¼«º®¶³ÆøÈÎÎñ; 12, ´ò¹ÖÍê³É; 13,¼«º®¶³ÆøÈÎÎñÈ¡Ïû; 14, ¼«º®¶³ÆøÈÎÎñÍê³É
TASK_ID_HHEJ = 1233
TASK_INFO_ID_HHEJ = 1013
TASK_INFO_ID_JHDQ = 1014

BUFF_ID_JHDQ = 459   -- ¼«º®¶³ÆøBuff ID £¨ĞèÒª¸ü¸Ä£©
-- Added by zhaoqingsong at 2008-7-23 end
-- Added by yaoxin at 2008-7-23 begin
Task_water = 1237 -- Èı¹âÉñË® 1½ÓÁË,2È¼µÆ,3Ìú¿øÓãÍõ,4É±Óã,5É±Íê,6ÅÜÉÌ,7È¡Ïû,10ÎªÈÎÎñÓÀ¾ÃÍê³É
-- Added by yaoxin at 2008-7-24 end

-----------³õÏÖ¶ËÄß ÈıÓãÖ®ÂÒ¡¢»ğÀëĞ¡Ñı¡¢±³ºóÖ÷Ä±-----------------
Task_Variety_Process = 1389        --1byte: 0Ã»ÁìÈÎÎñ£¬1ÁìÁËÈÎÎñ 2ÔÚĞÇ¹Ù´¦ÁìÈ¡ÁË½±Àø 3ÁìÈ¡ÁËÌ½ÖªÉ³»êµÄÈÎÎñ 4³É¹¦Óëµ¥´¿É³»ê¶Ô»° 5ÔÚ»ÆÌì»¯´¦ÁìÈ¡ÁË½±Àø
--6ÁìÈ¡ÁËÉ±ÈıÓãµÄÈÎÎñ  7ÓëÒ½Éú¶Ô»° 8Óë´óÍ·Óã¶Ô»° 9ÓëÕÛÂŞÓã¶Ô»° 10Óë¾Ş¹ÇÉàÓã¶Ô»° 11ÔÚ»ÆÌì»¯´¦½±Àø

--12¼ûÍê×£ÈÚ£¬13É±Íê15¸ö»ğÀëĞ¡Ñı£¬14µÃµ½½õ²¯£¬15×£ÈÚÔÄ¶Á¼ÇÒäºó£¬16ÁìÈ¡»ÆÌì»¯½±Àø    -----»ğÀë¾«ÆÇ
--17¸Õ½ÓÊÜÁË»ÆÌì»¯µÄÄ»ºóÖ÷Ä±ÈÎÎñ£¬18É±¼¸¸ö±ùÁéºó£¬19µÃµ½ÈıÕÅ±ÜÀ×·ûºó£¬									-----±³ºóÖ÷Ä±

--2byte: 1½Óµ½¹ı³õ¼û¶ËÄßµÄÍ¨Öª 2½Óµ½¹ıÈıÓãÖ®ÂÒµÄÍ¨Öª 3½Óµ½¹ı»ğÀë¾«ÆÇµÄÍ¨Öª 4 ½Óµ½¹ı±³ºóÖ÷Ä±µÄÍ¨Öª
--3byte£º±¾´ÎÉ±ËÀ»ğÀëĞ¡ÑıµÄÊıÄ¿
--4Byte:±¾´ÎÉ±ËÀ¾úÈËµÄÊıÄ¿
PlayerLightIndex = 1393 --¼ÇÂ¼Íæ¼ÒÕ¼ÓÃµÄµÆËşnpcindex

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

    --Èı²ßÆ½ÌìÏÂ
    startLevel = 75
    if (GetLevel() >= startLevel) then
        local taskKnight = GetTask(3)
        local taskWizard = GetTask(1)
        local taskDruid = GetTask(2)

        if (GetLevel() - startLevel <= 5) then
            if (taskKnight == 61) or (taskWizard == 61) or (taskDruid == 61) then
                state = 3
                subState = 0
            end
        else
            if (taskKnight == 61) or (taskWizard == 61) or (taskDruid == 61) then
                state = 3
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --Ì¤ÉÏÕ÷³Ì
    startLevel = 25
    if (GetLevel() >= startLevel) and (GetPlayerType() == 1) then
        local taskProcess = GetTask(1)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 1) and (HaveEventItem(0) >= 1) then
                state = 3
                subState = 0
            elseif (taskProcess == 1) then
                state = 2
                subState = 0
            end
        else
            if (taskProcess == 1) and (HaveEventItem(0) >= 1) then
                state = 3
                subState = 1
            elseif (taskProcess == 1) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --½ğÑÛÉñİº
    startLevel = 45
    if (GetLevel() >= startLevel) and (GetPlayerType() == 1) then
        local taskProcess = GetTask(1)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 20) then
                state = 1
                subState = 0
            end
        else
            if (taskProcess == 20) then
                state = 1
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --Æú°µÍ¶Ã÷
    startLevel = 45
    if (GetLevel() >= startLevel) and (GetPlayerType() == 0) then
        local taskProcess = GetTask(3)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 27) then
                state = 3
                subState = 0
            end
        else
            if (taskProcess == 27) then
                state = 3
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)
    end


    --Èı¹âÉñË®
    startLevel = 63
    if (GetLevel() >= startLevel) then
        local val = GetTask(Task_water)
        if (GetLevel() - startLevel <= 5) then
            if (val == 0) then
                state = 1
                subState = 0
            elseif (val == 6 and GetMorphType() == 364) then
                state = 3
                subState = 0
            elseif (val >= 1 and val <= 6) then
                state = 2
                subState = 0
            end
        else
            if (val == 0) then
                state = 1
                subState = 1
            elseif (val == 6 and GetMorphType() == 364) then
                state = 3
                subState = 1
            elseif (val >= 1 and val <= 6) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --ºß¹ş¶ş½«
    startLevel = 67
    if (GetLevel() >= startLevel) then
        local taskStatus = GetByte(GetTask(TASK_ID_HHEJ), 1)
        if (GetLevel() - startLevel <= 5) then
            if (taskStatus == 0) then
                state = 1
                subState = 0
            elseif (taskStatus == 5) then
                state = 3
                subState = 0
            elseif (taskStatus >= 1 and taskStatus < 5) then
                state = 2
                subState = 0
            end
        else
            if (taskStatus == 0) then
                state = 1
                subState = 1
            elseif (taskStatus == 5) then
                state = 3
                subState = 1
            elseif (taskStatus >= 1 and taskStatus < 5) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end
    --¼«º®¶³Æø
    startLevel = 68
    if (GetLevel() >= startLevel) then
        local taskStatus = GetByte(GetTask(TASK_ID_HHEJ), 1)
        if (GetLevel() - startLevel <= 5) then
            if (taskStatus == 6) then
                state = 1
                subState = 0
            elseif (taskStatus == 12) then
                state = 3
                subState = 0
            elseif (taskStatus > 6 and taskStatus < 12) then
                state = 2
                subState = 0
            end
        else
            if (taskStatus == 6) then
                state = 1
                subState = 1
            elseif (taskStatus == 12) then
                state = 3
                subState = 1
            elseif (taskStatus > 6 and taskStatus < 12) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --±³ºóÖ÷Ä±
    startLevel = 46
    if (GetLevel() >= startLevel) then
        local step = GetTaskByte(Task_Variety_Process, 1)
        if (GetLevel() - startLevel <= 5) then
            if (step == 18) then
                state = 3
                subState = 0
            end
        else
            if (step == 18) then
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


function main()
    tasks = {
        { "Khuyªn hµng", "renwu1"; show = 0 },
        { "Chinh §å", "renwu2"; show = 0 },
        { "ThÇn Oanh", "renwu3"; show = 0 },
        { "Tam s¸ch", "renwu4"; show = 0 },
        { "TÊn CÊp", "renwu"; show = 0 },
        { "§«ng Di", "dongyi"; show = 0 },
        { "Tam Quang", "Lwater"; show = 0 },
        { "Hanh C¸p NhŞ T­íng", "processHHEJ"; show = 0 },
        { "Hµn Khİ", "processJHDQ"; show = 0 },
        { "KÎ Chñ m­u", "conspiracy"; show = 0 },
    }
    UTask_Wizard = GetTask(1);
    UTask_Knight = GetTask(3);
    UTask_Druid = GetTask(2);
    if (UTask_Wizard == 61) or (UTask_Knight == 61) or (UTask_Druid == 61) then
        tasks[4].show = 1;
    end ;
    if (GetPlayerType() == 1) and (UTask_Wizard == 1) and (HaveEventItem(0) >= 1) then
        tasks[2].show = 1;
    end ;
    if (GetLevel() >= 45) and (UTask_Wizard == 20) and (GetPlayerType() == 1) then
        tasks[3].show = 1;
    end ;
    if (GetPlayerType() == 0) and (UTask_Knight == 27) then
        --Íê³É¼×Ê¿25¼¶?Îñ
        tasks[1].show = 1;
    end ;
    if (GetLevel() >= 20) and (GetTask(330) == 1) and (SystemTime() < 1111917600) then
        tasks[5].show = 1;
    end ;
    if (28 == GetTask(597)) or (31 == GetTask(597)) then
        tasks[6].show = 1;
    end ;

    if (GetLevel() >= 63) then
        local renwu_key = GetTask(Task_water)
        if (renwu_key <= 1) or (renwu_key == 6) then
            tasks[7].show = 1
        end
    end

    if (isViewHHEJ() == 1) then
        tasks[8].show = 1;
    end
    if (isViewJHDQ() == 1) then
        tasks[9].show = 1;
    end

    -------------------±³ºóÖ÷Ä± Added by Laiyongcong 2009-04-20 begin -------------
    local step = GetTaskByte(Task_Variety_Process, 1)
    if (step >= 18 and step < 20) then
        --É±ÍêÁË±ùÁéºó,È¡µÃ¼ÒÊéÇ°
        tasks[10].show = 1
    end
    -------------------±³ºóÖ÷Ä± Added by Laiyongcong 2009-04-20 end   -------------
    SayTask(10395, tasks)
end;

-------------------±³ºóÖ÷Ä± Added by Laiyongcong 2009-04-20 begin -------------
function conspiracy()
    local PID = GetPlayerID(PlayerIndex) --»ñµÃµ±Ç°Íæ¼ÒµÄÉí·İ±êÊ¶
    local bind_npcidx = GetTask(PlayerLightIndex)
    if (HaveIBBuff(645) ~= 0) then
        Talk(1, "no", "B¹n ë Ngäc TuyÒn B¨ng Xuyªn ®· thÊp s¸ng §iÖn L«i Th¸p, mau ®i xem thö.")
        return
    end

    ClearItem(6, 1, 487, 1)
    if (IsHaveSpaceForTreasure(3) == 0) then
        Talk(1, "no", "Hµnh trang kh«ng ®ñ kho¶ng trèng, kh«ng thÓ ®­a vµo 3 Bİch L«i Phï.")
        return
    end
    AddNormalItem(6, 1, 487, 1, 0, 0)
    AddNormalItem(6, 1, 487, 1, 0, 0)
    AddNormalItem(6, 1, 487, 1, 0, 0)

    Msg2Player("B¹n ®· kiÕm ®ñ 3 Bİch L«i Phï.")
    SetTaskByte(Task_Variety_Process, 1, 19)

    TaskNote(1047, 2)
    Talk(1, "no", "Muèn t×m nguyªn nh©n B¨ng Linh dŞ ®oan, ph¶i t×m thñ lÜnh cña B¨ng Linh, thñ lÜnh B¨ng Linh linh lùc cao siªu, cã thÓ dÉn ®éng léi ®iÖn Ğp thñ lÜnh B¨ng Linh ra. §Ó tr¸nh l«i ®iÖn s¸t th­¬ng ng­¬i, 3 Bİch L«i Phï, sö dông ë §iÖn L«i Th¸p chç Ngäc TuyÒn B¨ng Xuyªn.")
    refreshNpcTaskState()

end
-------------------±³ºóÖ÷Ä± Added by Laiyongcong 2009-04-20 end   -------------

function fangchenmi()
    --if  it return 0, the 5-hour limit rules executed
    local state
    local mark
    --	if  you don't want this function executed then	you can set state equal to zero
    --		state=0
    --	else
    state = GetWeakState()    --state=0, not in limited time; state=1, in 3 hours-limit; state=2, in 5 hours limit
    --	end
    if (state < 2) then
        mark = 1
    else
        mark = 0
    end
    return mark
end

function renwu4()
    Talk(1, "yes_4", 10396)
end;

function renwu2()
    Talk(3, "yes_1", 10397, 10398, 10399)
end;

function renwu3()
    local mark = fangchenmi()
    if (mark == 1) then
        Talk(3, "yes_2", 10400, 10401, 10402)--½ÓµÀÊ¿25¼¶?Îñ
    else
        Talk(1, "no", 11718)
    end
end;

function renwu1()
    Talk(2, "yes_3", 10403, 10404)
end;

function func_leave()
    MsgBox(10405, "yes", "no")
end;

function yes()
    Talk(1, "no", 10406)
    Msg2Player("NhËn lÖnh cña Kh­¬ng Tö Nha ®Õn TriÒu Ca cïng Hoµng Thiªn Hãa vµ Thæ Hµnh T«n lÊy l¹i Phong ThÇn b¶ng.")
    SetTask(1, 21)
    TaskNote(28, 11)
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end;

function yes_1()
    Talk(2, "no", 10407, 10408)
    DelEventItem(0)
    AddOwnExp(20000)
    Earn(30000)
    Msg2Player("§­a th­ tiÕn cö cho Kh­¬ng Tö Nha, nhËn ®­îc 20000 kinh nghiÖm vµ 30000 l­îng.")
    TopMessage(11719)

    SetTask(1, 2)    --Íê³ÉµÀÊ¿5¼¶?Îñ
    TaskNote(28, 1)
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end;

function yes_2()
    Talk(2, "func_leave", 10409, 10410)
end;

function yes_3()
    Talk(1, "no", 10411)
    local i = random(1, 2)
    AddNormalItem(0, 0, 30 + i, 4, 1, 0)
    AddOwnExp(240000)
    if (i == 1) then
        Msg2Player("Khuyªn Hoµng Phi Hæ hµng Chu, nhËn ®­îc xİch §ång ®ao vµ 240000 kinh nghiÖm.")
        TopMessage(11720)
    else
        Msg2Player("Khuyªn Hoµng Phi Hæ hµng Chu, nhËn ®­îc TiÕu Thiªn ®ao vµ 240000 kinh nghiÖm.")
        TopMessage(11721)
    end
    SetTask(3, 30)
    TaskNote(27, 12)
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end;

function yes_4()
    Talk(2, "yes_5", 10412, 10413)
end;

function yes_5()
    Talk(2, "no", 10414, 10415)
    if (GetPlayerType() == 1) then
        SetTask(1, 62)
        TaskNote(28, 28)
    end ;
    if (GetPlayerType() == 0) then
        SetTask(3, 62)
        TaskNote(27, 24)
    end ;
    if (GetPlayerType() == 2) then
        SetTask(2, 62)
        TaskNote(29, 23)
    end ;
    Msg2Player("§· hiÓu ®­îc chİ lín cña Kh­¬ng Tö Nha, ®i t×m Vâ V­¬ng. B¹n ®· b¾t ®Çu sø mÖnh cña m×nh!")
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end;

function no()
    CloseDialog()
end;

function renwu()
    if (GetTask(330) == 1) then
        if (GetSeries() == 0) then
            local i = random(1, 2)
            if (i == 1) then
                AddNormalItem(0, 0, 4, 2, 0, 0)
            elseif (i == 2) then
                AddNormalItem(0, 0, 5, 2, 0, 0)
            end ;
        elseif (GetSeries() == 1) then
            AddNormalItem(0, 0, 6, 2, 0, 0)
        elseif (GetSeries() == 2) then
            AddNormalItem(0, 0, 7, 2, 0, 0)
        end ;
        SetTask(330, 2)
        Talk(2, "no", 11722, "<c=r>Vâ V­¬ng<c> ®ang ®iÓm danh t­íng sÜ. Nh÷ng ng­êi trªn cÊp 35 sÏ ®­îc ®i tiªn phong! H·y cè g¾ng nhiÒu h¬n n÷a nhĞ!")
    else
        Talk(1, "no", 11723)
    end ;
end;

function dongyi()
    if (28 == GetTask(597)) then
        Talk(2, "no", 11724, "<color=green>" .. GetName() .. "<c>:NhËn ñy th¸c cña Kh­¬ng thõa t­íng!")
        SetTask(597, 29)
        TaskNote(35, 36)
        Msg2Player("§Õn gÆp thñ lÜnh §«ng Di t×m hiÓu lai lŞch cña ma thó.")
    elseif (31 == GetTask(597)) then
        if (GetItemCount(114) >= 7) then
            for i = 1, 7 do
                DelEventItem(114)
            end ;
            SetTask(597, 32)
            TaskNote(35, 39)
            TaskNote(36, 0)
            AddCredit(35)--ÉùÍû½±Àø
            local exp = GetNextExp() - GetExp()
            if (exp >= 150000) then
                AddOwnExp(150000) --¾­Ñé½±Àø
            else
                AddOwnExp(exp)
                AddOwnExp(150000 - exp)
            end ;
            Msg2Player("NhËn ®­îc 150000 ®iÓm kinh nghiÖm vµ 35 ®iÓm danh väng!")
            TopMessage(11725)
            Talk(2, "no", "<color=green>" .. GetName() .. "<c>:M¶nh Ph¸p khİ nµy t¹i h¹ ®em vÒ tõ D«ng Di, xin thõa t­íng xem!", "M¶nh Ph¸p Khİ nµy ®· bŞ mÊt tİch sau V¹n Tiªn trËn, sao b©y giê l¹i xuÊt hiÖn ë ®©y. Ta ph¶i lËp tøc vÒ ®éng thØnh gi¸o s­ phô. <c=g>Ng­¬i ®îi ë ®©y!<c>")
        else
            Talk(1, "no", 11726)
        end ;
    end ;
end;

--
--function fabao1()
--		SetTask(597,32)
--		TaskNote(36,30)
--		AddCredit(35)--ÉùÍû½±Àø
--		local exp=GetNextExp()-GetExp()
--		if(exp>=150000)then
--			AddOwnExp(150000) --¾­Ñé½±Àø
--		else
--			AddOwnExp(exp)
--			AddOwnExp(150000-exp)
--		end;
--		Msg2Player("»ñµÃ150000¾­ÑéºÍ35µãÉùÍû£¡")
--		TopMessage("½±Àø£º<color=green>150000<color>¾­ÑéºÍ<color=green>35µã<color>ÉùÍû£¡")
--		AddNormalItem(0,4,30,1,0,0)
--		Msg2Player("»ñµÃÀëµØÑæ¹âÆì£¡")
--		Talk(1,"no","½ª×ÓÑÀ£ºÕâĞ©·¨Æ÷ÊÇ½Ø½ÌÃÅÍ½×÷·¨ËùÓÃ£¬Í¨Ìì½ÌÖ÷×ÔÍòÏÉÕóÒ»ÒÛºóºØÉùÄä¼££¬Äª­ãËû½èÖúÚæ?Ö®µØÒª¾íÍÁÖØÀ´£¡´ËÊÂ­ã»êĞ¡¿É£¬ÎÒĞèÂíÉÏ·µ»ØÊ¦ÃÅÙ÷±¨Ê¦¸µ¡£<color=green>ÄãÇÒÔÚ´ËµÈÎÒ»ØÀ´£¬²]Òé¶Ô²ß¡£<color>")
--end;

--function fabao2()
--		SetTask(597,32)
--		TaskNote(36,30)
--		AddCredit(35)--ÉùÍû½±Àø
--		local exp=GetNextExp()-GetExp()
--		if(exp>=150000)then
--			AddOwnExp(150000) --¾­Ñé½±Àø
--		else
--			AddOwnExp(exp)
--			AddOwnExp(150000-exp)
--		end;
--		Msg2Player("»ñµÃ150000¾­ÑéºÍ35µãÉùÍû£¡")
--		TopMessage("½±Àø£º<color=green>150000<color>¾­ÑéºÍ<color=green>35µã<color>ÉùÍû£¡")
--		AddNormalItem(0,4,31,1,0,0)
--		Msg2Player("»ñµÃÇàÁ«±¦É«Æì£¡")
--		Talk(1,"no","½ª×ÓÑÀ£ºÕâĞ©·¨Æ÷ÊÇ½Ø½ÌÃÅÍ½×÷·¨ËùÓÃ£¬Í¨Ìì½ÌÖ÷×ÔÍòÏÉÕóÒ»ÒÛºóºØÉùÄä¼££¬Äª­ãËû½èÖúÚæ?Ö®µØÒª¾íÍÁÖØÀ´£¡´ËÊÂ­ã»êĞ¡¿É£¬ÎÒĞèÂíÉÏ·µ»ØÊ¦ÃÅÙ÷±¨Ê¦¸µ¡£<color=green>ÄãÇÒÔÚ´ËµÈÎÒ»ØÀ´£¬²]Òé¶Ô²ß¡£<color>")
--end;
--
--]]

-- Added by zhaoqingsong at 2008-7-23 begin

-- ÊÇ·ñÏÔÊ¾ºß¹ş¶ş½«°´Å¥
function isViewHHEJ()
    local playerLevel = GetLevel()
    local taskStatus = GetByte(GetTask(TASK_ID_HHEJ), 1)
    if (playerLevel >= 67 and taskStatus < 6) then
        return 1
    else
        return 0
    end
end

-- ÊÇ·ñÏÔÊ¾¼«º®¶³Æø°´Å¥
function isViewJHDQ()
    local playerLevel = GetLevel()
    local taskStatus = GetByte(GetTask(TASK_ID_HHEJ), 1)
    if (playerLevel >= 68 and taskStatus >= 6 and taskStatus < 13) then
        return 1
    else
        return 0
    end
end

-- ´¦Àíºß¹ş¶ş½«
function processHHEJ()
    local taskStatus = GetByte(GetTask(TASK_ID_HHEJ), 1)
    local fixVoiceBead = HaveItemInAllRoom(3, 235, 0, 0, 0, 0, 0)
    local fixVoiceBeadWithPower = HaveItemInAllRoom(6, 1, 363, 0, 0, 0, 0)
    if (taskStatus == 0) then
        MsgBox(14680, "acceptTaskHHEJ", "no")
    elseif (fixVoiceBead == 0 and fixVoiceBeadWithPower == 0) then
        local navigation = {}
        navigation[1] = { "Hanh C¸p NhŞ T­íng", "reAcceptTaskHHEJ"; show = 1 }
        SayTask(14681, navigation)
    elseif (taskStatus == 1) then
        Talk(1, "no", 14682)
    elseif (taskStatus == 2 or taskStatus == 3 or taskStatus == 4) then
        Talk(2, "no", 14683, GetName() .. ": Xin Thõa t­íng yªn t©m. Cø giao viÖc nµy cho t¹i h¹!")
    else
        return finishTaskHHEJ()
    end
end

-- ÁìÈ¡ºß¹ş¶ş½«ÈÎÎñ
function acceptTaskHHEJ()
    SetTask(TASK_ID_HHEJ, SetByte(GetTask(TASK_ID_HHEJ), 1, 1))
    SetSubTask(1013, 1, 1)
    AddNormalItem(3, 235, 0, 0, 0, 0)
    TaskNote(TASK_INFO_ID_HHEJ, 0)
    Msg2Player("B¹n nhËn ®­îc 1 §Şnh ¢m Ch©u.")
    TopMessage(14684)
    Talk(4, "hengha", 14685, GetName() .. ": Ta nghe Sïng Thµnh ®ang bŞ v©y khèn. ThuËt ph©n th©n cña NhŞ t­íng e lµ...", "kh«ng lo! Ta cã Ph¸p b¶o <c=g>§Şnh ¢m Ch©u<c> nµy th× kh«ng sî yªu ph¸p! Cã ®iÒu ph¶i ®em Ph¸p b¶o nµy mµi s¸ng l¹i th× míi ph¸t huy ®­îc hiÖu lùc, nghe nãi Gi¸p x¸c cña Ngäc N÷ rÊt hîp víi §Şnh ¢m Ch©u nµy!...", "Kh­¬ng Tö Nha:ChØ cã 1 m¶nh vá cña Ngäc N÷ míi cã thÓ ph¸t ra linh khİ, nh­ng tØ lÖ thµnh c«ng kh«ng cao, lÇn nµy tiÓu anh hïng ph¶i hÕt søc cÈn thËn. Sau khi mµi s¸ng thµnh c«ng h·y ®i t×m Hanh C¸p NhŞ T­íng.")
    refreshNpcTaskState()
end

-- ÁìÈ¡ºß¹ş¶ş½«ÈÎÎñ
function reAcceptTaskHHEJ()
    SetTask(TASK_ID_HHEJ, SetByte(GetTask(TASK_ID_HHEJ), 1, 1))
    AddNormalItem(3, 235, 0, 0, 0, 0)
    TaskNote(TASK_INFO_ID_HHEJ, 0)
    Msg2Player("B¹n nhËn ®­îc 1 §Şnh ¢m Ch©u.")
    TopMessage(14684)
    Talk(1, "no", GetName() .. ". §a t¹ Thõa t­íng!")
    refreshNpcTaskState()
end
--ÁìÈ¡ºß¹ş¶ş½«ÈÎÎñ2
function hengha()
    Talk(1, "no", GetName() .. ": (Nghe nãi Hanh C¸p NhŞ T­íng lu«n ®è kŞ lÉn nhau, m×nh ph¶i thö hä mét phen míi ®­îc)")
end

-- Íê³Éºß¹ş¶ş½«ÈÎÎñ£¬ÁìÈ¡½±Àø
function finishTaskHHEJ()
    local taskStatus = GetByte(GetTask(TASK_ID_HHEJ), 1)
    if (taskStatus == 5) then
        SetTask(TASK_ID_HHEJ, SetByte(GetTask(TASK_ID_HHEJ), 1, 6))
        AddOwnExp(400000)
        TaskNote(TASK_INFO_ID_HHEJ, -1)
        SetSubTask(1013, -1, 1)
        WriteLog("Hoµn thµnh <Hanh C¸p NhŞ T­íng>")
        Msg2Player("B¹n nhËn ®­îc 400000 kinh nghiÖm")
        Talk(1, "main", 14686)
        refreshNpcTaskState()
    end
end

-- ´¦Àí¼«º®¶³Æø
function processJHDQ()
    local taskStatus = GetByte(GetTask(TASK_ID_HHEJ), 1)
    local fixVoiceBead = HaveItemInAllRoom(6, 1, 363, 0, 0, 0, 0)
    local fixVoiceBeadInBag = HaveNormalItem(6, 1, 363, 0)
    local killCount = GetByte(GetTask(TASK_ID_HHEJ), 2)
    if (fixVoiceBead == 0) then
        MsgBox(14687, "cancelTaskJHDQ", "no")
    elseif (fixVoiceBeadInBag == 0) then
        Talk(1, "no", 14688)
    elseif (taskStatus == 6) then
        MsgBox(14689, "acceptTaskJHDQ", "no")
    elseif (killCount < 50) then
        Talk(1, "no", "Kh­¬ng Tö Nha:Cßn ph¶i thu phôc" .. (50 - killCount) .. " Hµ Cèt míi cã thÓ lµm ng­ng kÕt §Şnh ¢m Ch©u , mau ®i ®¸nh b¹i Hµ Cèt.")
    else
        return finishTaskJHDQ()
    end
end

-- ÁìÈ¡¼«º®¶³ÆøÈÎÎñ
function acceptTaskJHDQ()
    SetTask(TASK_ID_HHEJ, SetByte(GetTask(TASK_ID_HHEJ), 1, 11))
    SetTask(TASK_ID_HHEJ, SetByte(GetTask(TASK_ID_HHEJ), 2, 0))
    TaskNote(TASK_INFO_ID_JHDQ, 0, 50)
    SetSubTask(1214, 1, 1)
    Talk(2, "no", 14690, GetName() .. ": NÕu nh­ ph¶i t×m §«ng khİ…th× m×nh ph¶i cã tr¹ng th¸i §«ng khİ míi ®­îc…(Sö dông <c=g>§Şnh ¢m Ch©u<c> nµy lµ ®­îc råi!)")
    refreshNpcTaskState()
end

-- Íê³É¼«º®¶³ÆøÈÎÎñ£¬ÁìÈ¡½±Àø
function finishTaskJHDQ()
    local taskStatus = GetByte(GetTask(TASK_ID_HHEJ), 1)
    if (taskStatus == 12) then
        DelNormalItem(6, 1, 363, 0)
        RemoveIBBuff(BUFF_ID_JHDQ)
        SetTask(TASK_ID_HHEJ, SetByte(GetTask(TASK_ID_HHEJ), 1, 14))
        AddOwnExp(800000)
        SetSubTask(1014, -1, 1)
        TaskNote(TASK_INFO_ID_JHDQ, -1)
        WriteLog("Hoµn thµnh <Hµn Khİ>")
        Msg2Player("B¹n nhËn ®­îc 800000 kinh nghiÖm")
        Talk(1, "no", 14691)
        refreshNpcTaskState()
    end
end

-- Íê³É¼«º®¶³ÆøÈÎÎñ£¬ÁìÈ¡½±Àø
function cancelTaskJHDQ()
    RemoveIBBuff(BUFF_ID_JHDQ)
    SetTask(TASK_ID_HHEJ, SetByte(GetTask(TASK_ID_HHEJ), 1, 13))
    TaskNote(TASK_INFO_ID_JHDQ, -1)
    Msg2Player("b¹n hñy bá nhiÖm vô Hµn Khİ")
    Talk(1, "no", 14692)
    refreshNpcTaskState()
end


-- Added by zhaoqingsong at 2008-7-23 end

-- Added by yaoxin at 2008-7-24 begin
--Èı¹âÉñË®
function Lwater()
    CloseDialog()
    local val = GetTask(Task_water)
    if (val == 0) then
        MsgBox(14693, "yes_water", "no")
    elseif (val == 1) then
        yes_water()
    elseif (val == 6) then
        if (GetMorphType() == 364) then
            SetTask(Task_water, 10) --ÈÎÎñÍê³É¸ø½±Àø
            AddOwnExp(600000)
            PolyMorph(-1, 1, 0, 6, 0)--ÊÕ»ØÂæÍÕ
            local r = random(10, 13)
            AddNormalItem(0, 4, r, 1, 0, 0)--50¼¶·¨±¦
            SetSubTask(82, -1, 1)
            TaskNote(82, -1)
            WriteLog("Hoµn thµnh <Tam Quang>")
            Msg2Player("Hoµn thµnh nhiÖm vô Tam Quang, nhËn ®­îc 1 Ph¸p b¶o vµ 600000 kinh nghiÖm")--xiaoque
            TopMessage(14694)
            Talk(1, "no", 14695)
            refreshNpcTaskState()
        else
            Talk(1, "no", 14696)
            SetTask(Task_water, 7) --ÈÎÎñÊ§°Ü,ÖØĞÂ½ÓÈÎÎñ
            TaskNote(82, 7)
            refreshNpcTaskState()
        end
    end
end

function yes_water()
    if (HaveNormalItem(3, 112, 0, 0) >= 5) and (GetTask(Task_water) <= 1) then
        SetTask(Task_water, 2) -- ½ÓÁËÈÎÎñ
        SetSubTask(82, 1, 1)
        for i = 1, 5 do
            DelNormalItem(3, 112, 0, 0)
        end
        TaskNote(82, 1)
        Msg2Player("Giao nép 5 Thñy Hån")--xiaoque
        Talk(1, "no", 14697)
        refreshNpcTaskState()
    else
        Talk(1, "no", 14698)
        SetTask(Task_water, 1) -- ½ÓÁËÈÎÎñ
        TaskNote(82, 0)
        refreshNpcTaskState()
    end
end
-- Added by yaoxin at 2008-7-24 end
