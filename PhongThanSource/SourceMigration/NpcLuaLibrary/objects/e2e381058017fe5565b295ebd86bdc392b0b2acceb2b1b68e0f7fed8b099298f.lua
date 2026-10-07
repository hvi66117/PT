--description: ÍÁĞĞËï-µÀÊ¿Ö÷Ïß?Îñ
--author: yichuan
--date:2004/4/29
--899,ı®1368Ê¦ÃÅ»ÄÄ®ÊÔÁ¶
Task_xianguo = 1211;
--·ÃÇóÏÉ¹ûÈÎÎñ±äÁ¿£º1Bit±íÊ¾½ÓÊÜÈÎÎñ,2Bit±íÊ¾ÈÎÎñ´ı½»,3Bit±íÊ¾ËÕæ§¼º´¦Íê³É,4Bit±íÊ¾ÄÏ¼«ÏÉÎÌ´¦Íê³É,5Bit±íÊ¾¿ä¸¸Í¼ÌÚ´¦Íê³É,6Bit±íÊ¾ÍÁĞĞËï´¦Íê³É,7Bit±íÊ¾²®ÒØ¿¼´¦Íê³É,8Bit±íÊ¾ÈÎÎñ½áÊø
Task_wugu1 = 1352;
--Î×¹ÆÖ®¶¾µÚÒ»²½ÈÎÎñ±äÁ¿
Task_wugu2 = 1353;
--Î×¹ÆÖ®¶¾µÚ¶ş²½ÈÎÎñ±äÁ¿
Task_count = 1349
--¼ÇÂ¼Î×¹ÆÖ®¶¾É±ËÀ¹ÖÎïÊıÁ¿

-------------------- Á½ÖÜÄêÇìµä added by yangtao 2009.8.19 ----------------
Task_prepare = 1537    -- 1byte£º1£º¶Ô¼×Ê¿Íæ¼ÒÊ¹ÓÃ¹ı 2£º¶ÔµÀÊ¿Íæ¼ÒÊ¹ÓÃ¹ı 3£º¶ÔÒìÈËÍæ¼ÒÊ¹ÓÃ¹ı
-- 2byte£ºµÀ¾ß±»Ê¹ÓÃ´ÎÊı
-- 3byte: ÈÎÎñ½ø¶È
Task_anotherID = 1538    -- ¼ÇÂ¼Ê¹ÓÃ¡¾ÖÜÄêÇìÑûÇëº¯¡¿Ê±¶Ô·½µÄPlayerID
Task_item = 1539
Task_stage = 1540
--2009.8.28 - 2009.8.29		-- 1byte:1-5¼ÇÂ¼ÊÇ·ñÒÑ½«ºØ¿¨ËÍÍù¶ÔÓ¦NPC´¦
-- 2byte:¼ÇÂ¼ÈÎÎñ½ø¶È	1:ÒÑ¾­ÔÚÀñ¹Ù´¦ÁìÈ¡ÎïÆ·£¬¿ªÊ¼»î¶¯ 2-5:ÒÑ¾­ËÍºØ¿¨¸ø¼¸¸öNPC 6:Íê³ÉÈÎÎñ
-- 3byte:1-5¼ÇÂ¼ºØ¿¨Õâ´ÎÓ¦¸ÃËÍ¸øË­
--2009.8.30 - 2009.8.31		-- 1byte:ÓÃÓÚÅĞ¶ÏÊÇ·ñ²ÄÁÏÆëÈ«
-- 2byte:ÈÎÎñ½ø¶È		1:ÒÑ¾­¿ªÊ¼ÈÎÎñ 2:ÒÑ¾­ÁìÈ¡ÎïÆ· 3:ÒÑ¾­Íê³ÉÈÎÎñ
--2009.9.1 - 2009.9.3		-- 1byte:ÓÃÓÚ¼ÇÂ¼ÈÎÎñ½ø¶È 0:»¹Ã»ÓĞ½ÓÈÎÎñ 1: ÒÑ¾­¿ªÊ¼ÈÎÎñ£¬Î´²É¼¯×£¸£ 2:ÒÑ¾­²É¼¯ÁË×£¸£ 3:ÒÑ¾­Íê³ÉÈÎÎñ

----------------------------- Á½ÖÜÄêÇìµä end of add ------------------------


-------------added by hongliang for ÈıÖÜÄê»î¶¯ 10/8/12 begin----------------

--~ TASK_ThreeYears_Fireworks = 1724;
--~ --1st byte ÈÎÎñ²½Öè: 0-Î´½Ó 1-ÒÑ½Ó 2-Íê³É; 2nd byte ½ÓÈÎÎñÊ±¼ä; 
--~ --3rd byte µÚÒ»¸öNPCµÄÌâÄ¿£¨0Î´½ÓÈÎÎñ£¬1-5±íÊ¾ÌâÄ¿ĞòºÅ£¬6±íÊ¾ÒÑÔÚ¸ÃNPC´¦»Ø´ğÍê£©; 4th byte µÚ¶ş¸öNPCµÄÌâÄ¿

--~ TASK_ThreeYears_Questions = 1725;--1st~3rd bytes µÚÈı¡«Îå¸öNPCµÄÌâÄ¿; 4th byte ÒÑ¾­Íê³ÉµÄ´ğÌâÊıÄ¿

--~ G_ThreeYears_1stFireworksId = 1318;

--~ ---------------------------------------------------------------------------

--~ TASK_ThreeYears_Blessing = 1726; --1st byte ÈÎÎñ²½Öè: 0-Î´½Ó 1-ÒÑ½Ó 2-Íê³É; 2nd byte ½ÓÈÎÎñÊ±¼ä; 3rd byte ×î½üÊÕÓÊ¼şÊ±¼ä£¨Á½¸ö»î¶¯¹²ÓÃ£©

--~ BUFF_ThreeYears_Blessing_1stBuff = 773; --¸÷µØ×£¸£buff
--~ BUFF_ThreeYears_Blessing_Effect = 1324; --½ÓÊÜ×£¸£ÌØĞ§

--~ BUFF_ThreeYears_Clear = 1325; --ÇåÀí
-------------added by hongliang for ÈıÖÜÄê»î¶¯ 10/8/12 end------------------


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

    --·ÃÇóÏÊ¹û
    startLevel = 19
    if (GetLevel() >= startLevel) then
        if (GetLevel() - startLevel <= 5) then
            --½ğÉ«
            if (GetTaskBit(Task_xianguo, 1) == 1) and (GetTaskBit(Task_xianguo, 2) == 0) and ((GetTaskBit(Task_xianguo, 6) == 0) or (GetTaskBit(Task_xianguo, 6) == 1 and (HaveNormalItem(3, 222, 0, 0) == 0))) then
                state = 3
                subState = 0
            elseif (GetTaskBit(Task_xianguo, 6) == 1) and (HaveNormalItem(3, 222, 0, 0) > 0) then
                state = 0
                subState = 0
            end
        else
            --À¶É«
            if (GetTaskBit(Task_xianguo, 1) == 1) and (GetTaskBit(Task_xianguo, 2) == 0) and ((GetTaskBit(Task_xianguo, 6) == 0) or (GetTaskBit(Task_xianguo, 6) == 1 and (HaveNormalItem(3, 222, 0, 0) == 0))) then
                state = 3
                subState = 1
            elseif (GetTaskBit(Task_xianguo, 6) == 1) and (HaveNormalItem(3, 222, 0, 0) > 0) then
                state = 0
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --Î×¹ÆÖ®¶¾
    startLevel = 26
    if (GetLevel() >= startLevel) then
        local wg = GetTask(Task_wugu1)
        if (GetLevel() - startLevel <= 5) then
            --½ğÉ«
            if (wg == 0 and GetLevel() >= 26) then
                state = 1
                subState = 0
                --elseif(wg == 2 and HaveEventItem(219)==1 and HaveEventItem(220)==1 and GetLevel() >= 26)then
                --state = 3
                --subState = 0
            elseif (wg == 5 and HaveEventItem(223) == 1 and GetLevel() >= 26) then
                state = 3
                subState = 0
                --elseif(wg >= 1 and wg <= 5 and  GetLevel() >= 26) then
                --state = 2
                --subState = 0
            end
        else
            if (wg == 0 and GetLevel() >= 26) then
                state = 1
                subState = 1
                --elseif(wg == 2 and HaveEventItem(219)==1 and HaveEventItem(220)==1 and GetLevel() >= 26)then
                --state = 3
                --subState = 1
            elseif (wg == 5 and HaveEventItem(223) == 1 and GetLevel() >= 26) then
                state = 3
                subState = 1
                --elseif(wg >= 1 and wg <= 5 and  GetLevel() >= 26) then
                --state = 2
                --subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --Î×¹ÆÖ®¶¾2
    startLevel = 28
    if (GetLevel() >= startLevel) then
        local wg = GetTask(Task_wugu1)
        local wg2 = GetTask(Task_wugu2)
        if (GetLevel() - startLevel <= 5) then
            if (wg == 6 and wg2 == 0 and GetLevel() >= 28) then
                state = 1
                subState = 0
            elseif (wg2 == 4 and GetLevel() >= 28) then
                state = 3
                subState = 0
            elseif (wg2 >= 1 and wg2 < 4 and GetLevel() >= 28) then
                state = 2
                subState = 0
            end
        else
            if (wg == 6 and wg2 == 0 and GetLevel() >= 28) then
                state = 1
                subState = 1
            elseif (wg2 == 4 and GetLevel() >= 28) then
                state = 3
                subState = 1
            elseif (wg2 >= 1 and wg2 < 4 and GetLevel() >= 28) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --´óĞËÍÁÄ¾
    startLevel = 35
    if (GetLevel() >= startLevel) then
        local today = mod(floor(LocalSystemTime() / 86400), 255) + 1
        local lastday = GetByte(GetTask(build_renwu), 1)
        if (GetLevel() - startLevel <= 5) then
            if (today ~= lastday and GetLevel() >= 35) then
                state = 1
                subState = 0

            end
        else
            if (today ~= lastday and GetLevel() >= 35) then
                state = 1
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --½ğÑÛÉñİº
    startLevel = 45
    if (GetLevel() >= startLevel) and (GetPlayerType() == 1) then
        local taskProcess = GetTask(1)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 23) and (HaveEventItem(1) >= 1) then
                state = 3
                subState = 0
            elseif (taskProcess == 23) then
                state = 2
                subState = 0
            end
        else
            if (taskProcess == 23) and (HaveEventItem(1) >= 1) then
                state = 3
                subState = 1
            elseif (taskProcess == 23) then
                state = 2
                subState = 0
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --²»ËÀÉñÄ¾
    startLevel = 55
    if (GetLevel() >= startLevel) and (GetPlayerType() == 1) then
        local taskProcess = GetTask(1)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 30) then
                state = 1
                subState = 0
            end
        else
            if (taskProcess == 30) then
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
        { "ThÇn Oanh", "renwu2"; show = 0 },
        { "ThÇn Méc", "renwu3"; show = 0 },
        { "Hoang m¹c thİ luyÖn", "shitu_1"; show = 0 },
        { "Hñy bá nhiÖm vô Sa M¹c Thİ luyÖn", "shitu_1_cancel"; show = 0 },
        { "Hoµn thµnh nhiÖm vô Hoang M¹c Thİ LuyÖn", "shitu_1"; show = 0 },
        { "<c=yel>CÇu Tiªn qu¶<c>", "xianguo"; show = 0 },
        { "<c=g>§¹i H­ng Méc <c>", "construction"; show = 0 },
        { "<c=yel>§éc Cæ<c>", "wugu1"; show = 0 },
        { "<c=yel>§éc Cæ<c>", "wugu2"; show = 0 },
        -- Added by yangtao 2009.8.19 Á½ÖÜÄêÇìµä»î¶¯
        --{"¶şÖÜÄêÇìµä","twoyearcel";show = 0},
        -- end of add yangtao 2009.8.19
        -- added by hongliang for ÈıÖÜÄê»î¶¯ 10/8/12 begin
        --{"½ÓÊÜ×£¸£", "ThreeYears_FireWorks"; show = 0},--10
        -- added by hongliang for ÈıÖÜÄê»î¶¯ 10/8/12 end

    }
    UTask_Wizard = GetTask(1);
    if (GetPlayerType() == 1) and (UTask_Wizard == 23) and (HaveEventItem(1) >= 1) then
        tasks[1].show = 1;
    end ;
    if (GetLevel() >= 55) and (UTask_Wizard == 30) then
        tasks[2].show = 1;
    end ;
    if (GetLevel() > 25) and (GetLevel() <= 45) and (GetTask(899) <= 7) then
        --®{§Ìµ¥¯Åok¡A®{§Ì¨S¦³§¹¦¨¹L
        tasks[3].show = 1;
    end ;
    if (GetLevel() > 45) then
        if (GetTask(899) ~= 0) and (GetTask(899) < 6) then
            tasks[4].show = 1;
        elseif (GetTask(899) == 6) then
            tasks[5].show = 1;
        end ;
    end ;

    local xg = GetTask(Task_xianguo)

    if (GetBit(xg, 1) == 1 and GetBit(xg, 2) == 0 and GetBit(xg, 6) == 0) then
        tasks[6].show = 1
        -- modified by yaoxin for bug 2011-4
    elseif (GetBit(xg, 1) == 1 and GetBit(xg, 2) == 0 and GetBit(xg, 6) == 1 and IsExistItem(3, 222, 0, 0) == 0) then
        tasks[6].show = 1    --Èç¹ûÖ®Ç°µÄÈÎÎñÒÑ¾­Íê³É µ«ÊÇÈÎÎñÎïÆ·»¹ÏûÊ§ÁË.. ÄÇÃ´Ò»Ñù¿ÉÒÔÊ¹ÓÃÒ¹Ã÷ÖéÖØĞÂÁìÈ¡
    end

    if (GetLevel() >= 35) then
        --´óĞËÍÁÄ¾
        tasks[7].show = 1
    end

    local wg = GetTask(Task_wugu1)
    local wg2 = GetTask(Task_wugu2)
    if (wg == 0 and GetLevel() >= 26) then
        tasks[8].show = 1
    end

    if (wg == 5) then
        tasks[8].show = 1
    end

    if (wg == 6 and GetLevel() >= 28) then
        tasks[9].show = 1
    end
    if (wg2 == 4 and GetLevel() >= 28) then
        tasks[9].show = 1
    end
    -- Added by yangtao 2009.8.19 Á½ÖÜÄêÇìµä»î¶¯
    --local y1, m1, d1 = GetYMD()
    --local H,M,S = Time2LocalHMS(nSysTaskTime)
    --if(y1 == 2009) and (m1 == 8) and (d1 == 28) and (GetTaskByte(Task_stage, 2) >= 1) and (GetTaskBit(Task_stage, 1) == 0) and (GetTaskBit(Task_stage, 17) == 1)then 
    --	tasks[10].show = 1
    --end
    -- end of add yangtao 2009.8.19


    --added by hongliang for ÈıÖÜÄê»î¶¯ 10/8/12 begin
    --~                     local year, month, day = GetYMD();
    --~                     local hour, min, second = GetHMS();
    --~                     local today = mod(floor(LocalSystemTime()/86400), 255) + 1;

    --~                     local TaskStep = GetTaskByte(TASK_ThreeYears_Fireworks, 1);
    --~                     local TaskTime = GetTaskByte(TASK_ThreeYears_Fireworks, 2);
    --~                     
    --~                     --Çå¿ÕÖ®Ç°µÄÈÎÎñ£¬ÒÔ·ÀbuffendÎ´Ö´ĞĞ
    --~                     if (TaskTime > 0 and TaskTime ~= today) then
    --~                         TaskStep = 0;
    --~                         TaskTime = 0;
    --~                         SetTask(TASK_ThreeYears_Fireworks, 0);
    --~                         SetTask(TASK_ThreeYears_Questions, 0);
    --~                     end
    --~                     
    --~                      if (year == 2010 and month == 8 and day == 28
    --~                             and hour >= 19 and hour <= 21
    --~                             and TaskStep == 1) then
    --~                         tasks[10].show = 1;
    --~                     end
    --added by hongliang for ÈıÖÜÄê»î¶¯ 10/8/12 end

    SayTask(10109, tasks)

end;
-----------------------------------Add by yangmeng   2009/10/20   begin   
function wugu2()
    local wg2 = GetTask(Task_wugu2)
    if (wg2 == 0) then
        --ÁìÈ¡ÈÎÎñ
        Talk(2, "no", "Anh hïng ®Õn ®óng hÑn, gióp ta b¸o thï, c¶m kİch bÊt tËn. Ta ®· nghe ngãng ®­îc <c=g>Phong L©m<c> quanh n¨m trÊn thñ M¹nh T©n, ch¾c biÕt n¬i cña <c=r>B¸ch Niªn Gi¸p Cèt<c>, ng­êi cã thÓ ®Õn dß hái thö xem.", GetName() .. "Thæ ®¹i ca ®îi trong gi©y l¸t, ta ®i sÏ vÒ ngay.")
        SetTask(Task_wugu2, 1)
        SetTask(Task_wugu1, 7)
        TaskNote(200, -1)
        TaskNote(201, 0)
        SetSubTask(201, 1, 1)
        refreshNpcTaskState()
    elseif (wg2 == 4) then
        --Íê³ÉÈÎÎñ
        Talk(2, "no", GetName() .. "Thæ ®¹i ca, ta ®· d¹y cho <c=r>B¸ch Niªn Gi¸p Cèt<c> 1 bµi häc.", "§a t¹! §a t¹! Xin nhËn chót phÇn th­ëng nhá nµy!")
        AddOwnExp(40000)
        SetTask(Task_wugu2, 5)
        TaskNote(201, -1)
        SetSubTask(201, -1, 1)
        TopMessage("NhiÖm vô hoµn thµnh, nhËn ®­îc 40000 kinh nghiÖm")
        Msg2Player("NhiÖm vô hoµn thµnh, nhËn ®­îc 40000 kinh nghiÖm")
        refreshNpcTaskState()
    end
end

function wugu1()
    local wg = GetTask(Task_wugu1)
    if (wg == 0) then
        Talk(2, "no", "Ta vèn ®Şnh ®Õn Tam S¬n th¨m <c=g>§Æng ThiÒn Ngäc<c>, kh«ng ngê bŞ ng­êi m­u s¸t ë M¹nh T©n, ®· tróng cùc ®éc, mÊt hÕt ph¸p lùc. Kh«ng biÕt anh hïng cã b»ng lßng ®Õn Tam S¬n th¨m ThiÒn Ngäc thay ta.", GetName() .. "Xin cø yªn t©m, t¹i h¹ ®­¬ng næi träng tr¸ch nµy!")
        SetTask(Task_wugu1, 1)
        SetSubTask(200, 1, 1)
        TaskNote(200, 0)
        refreshNpcTaskState()
    end
    --if(wg == 2 and HaveEventItem(219)==1 and HaveEventItem(220)==1)then
    --Talk(2,"no",GetName().."£ºÍÁ´ó¸ç£¬ÎÒÀ´È¡Ğ©<c=yel>¶¾Ñª<c>½»Óè<c=g>Î÷áªÃûÒ½<c>£¬Ñ°Çó½â¶¾Ö®·¨¡£","ÍÁĞĞËï£º¸ĞĞ»Ó¢ĞÛÎªÎÒ±¼²¨¡£")
    --DelEventItem(219)
    --DelEventItem(220)
    -- AddEventItem(221)
    -- TopMessage("Äã»ñµÃÁË<c=yel>¶¾Ñª<c>¡£")
    --Msg2Player("»ñµÃÍÁĞĞËïµÄ¶¾Ñª¡£")
    --AddOwnExp(10000)
    --TopMessage("»ñµÃ10000¾­Ñé¡£")
    --SetTask(Task_wugu1,3)
    -- TaskNote(200,2)
    -- refreshNpcTaskState()
    --end 
    --if(wg == 3 and HaveEventItem(221)==0)then
    --Talk(2,"no",GetName().."£ºÍÁ´ó¸ç£¬ÎÒ²»É÷ÒÅÊ§ÁË¶¾Ñª¡£","ÍÁĞĞËï£º¶¾ÑªÓĞµÄÊÇ£¬Ó¢ĞÛÒª¶àÉÙÓĞ¶àÉÙ£¡")
    --AddEventItem(221)
    --TopMessage("Äã»ñµÃÁË<c=yel>¶¾Ñª<c>¡£")
    --Msg2Player("»ñµÃÍÁĞĞËïµÄ¶¾Ñª¡£")
    --		TaskNote(35,2)		
    --end
    ----------------------Add       by  yangmeng   2009/10/20   end
    if (wg == 5 and HaveEventItem(223) == 1) then
        Talk(2, "no", "Thæ Hµnh T«n:ThiÕu hiÖp cøu m¹ng ta, sè ®iÓm kinh nghiÖm nµy xin tÆng ng­¬i.", GetName() .. "TiÒn bèi qu¸ khen, ta ®· th¸m thİnh ®­îc kÎ m­u s¸t tiÒn bèi lµ <c=r>B¸ch Niªn Gi¸p Cèt<c> ë M¹nh T©n.")
        DelEventItem(223)
        DelEventItem(221)
        AddOwnExp(32000)
        TopMessage("NhËn ®­îc 32000 kinh nghiÖm.")
        SetTask(Task_wugu1, 6)
        SetSubTask(200, -1, 1)
        TaskNote(200, 5)
        refreshNpcTaskState()
        Talk(1, "no", "Qu©n tö b¸o thñ 10 n¨m ch­a muén, <c=r>B¸ch Niªn Gi¸p Cèt<c> ph¸p lùc cao c­êng. TiÓu anh hïng ®îi ®Õn cÊp 28 h·y ®Õn ®Ó gióp ta röa huyÕt hËn!")
    end ;
end;

function shitu_1()
    local mark = judge_relation()
    if (mark == 1) then
        --º¡¨¬®v®{2¤H¶¤ 
        if (GetTask(899) == 0) then
            --±µ¥ô°È
            MsgBox(14152, "shitu_1_begin", "no")
        elseif (GetTask(899) == 6) then
            --§¹¦¨¥ô°È
            MsgBox(14153, "shitu_1_end", "no")
        elseif (GetTask(899) >= 7) then
            Talk(1, "no", 14154)
        else
            --©ñ±ó¥ô°È
            MsgBox(14155, "shitu_1_cancel", "no")
        end
    else
        if (GetTask(899) == 0) then
            Talk(1, "no", 14156)
        elseif (GetTask(899) == 6) then
            Talk(1, "no", 14157)
        elseif (GetTask(899) >= 7) then
            Talk(1, "no", 14158)
        else
            MsgBox(14155, "shitu_1_cancel", "no")
        end
    end
end

function shitu_1_begin()
    local mark = judge_relation()
    if (mark == 1) then
        --º¡¨¬®v®{2¤H¶¤ 
        RemoveIBBuff(216)
        local done = AddIBBuff(216)
        if (done == 1) then
            SetTask(899, 1)
            TaskNote(43, 5)
            if (GetTask(900) < 7) then
                SetTask(900, 0)
                TaskNote(44, -1)
            end
            if (GetTask(901) < 7) then
                SetTask(901, 0)
                TaskNote(45, -1)
            end
            if (GetTask(902) < 7) then
                SetTask(902, 0)
                TaskNote(46, -1)
            end
            Talk(2, "no", 14159, "§õng ®Ó vßng s¸ng biÕn mÊt vµ ph¶i cïng ®i víi s­ phô cña m×nh. §¹i phu mçi tÇng sÏ gióp ng­¬i trŞ liÖu vÕt th­¬ng.")
        else
            Talk(1, "no", 14160)
        end
    else
        Talk(1, "no", 14157)
    end
end

function shitu_1_end()
    if (step_complete() == 0) and (GetTask(907) == 0) then
        Say("Chóc mõng ng­êi ®· hoµn thµnh luyÖn tËp th¸m hiÓm lµn nµy, hiÖn giê ma vËt hoµnh hµnh, ta tÆng ng­¬i 1 ThÇn Gi¸p hé thÓ, ng­¬i xin chän ®i.", 3, "§Çu kh«i/shitu_1_end_yes", "Yªu ®¸i/shitu_1_end_yes", "Giµy/shitu_1_end_yes")
    else
        shitu_1_end_yes(10)
    end
end

function shitu_1_end_yes(nums)
    local mark = judge_relation()
    if (mark == 1) then
        --º¡¨¬®v®{2¤H¶¤
        local name = GetName()
        local masterid = -1
        local oldPlayer = PlayerIndex
        if (GetTeamSize() == 2) then
            --2¤H¶¤
            if (IsCaptain() == 0) then
                n = GetTeamMember(1)
            else
                n = GetTeamMember(2)
            end ;
            PlayerIndex = n
            shitu_1_end_M(name)
            masterid = GetPlayerID()
        end
        PlayerIndex = oldPlayer
        shitu_1_end_P(nums, masterid)
    else
        Talk(1, "no", 14157)
    end
end

function step_complete()
    local mark = 0
    for i = 1, 4 do
        if (GetTask(898 + i) > 6) then
            mark = mark + 1
        end
    end
    return mark
end

function shitu_1_end_P(nums, masterid)
    local exp1 = GetNextExp() - GetExp()
    local exp2 = 75000
    if (exp1 < exp2) then
        AddOwnExp(exp1)
        AddOwnExp(exp2 - exp1)
    else
        AddOwnExp(exp2)
    end
    RemoveIBBuff(216)
    SetTask(899, 7)
    SetTask(1368, masterid)
    TaskNote(43, 6)
    TopMessage(14161)
    Msg2Player("§é th©n mËt gi÷a ng­¬i vµ s­ phô ®· t¨ng lªn.")
    local mark = step_complete()
    if (mark == 1) and (GetTask(907) == 0) and (nums ~= 10) then
        --§¹¦¨¤F¤@¦¸±´ÀI¥ô°È¥B¨S¦³»â¨ú¹Lºñ¦âÀY²¯
        local ty = GetPlayerType()
        AddNormalItem(0, 7 - nums, ty + 6, 4, 0, 0)
        SetTask(907, 1)
        Talk(1, "no", 14162)
        local item_name = { [0] = { "Vò Khóc Kh«i", "Vò Khóc Yªu §¸i", "Vò Khóc ChiÕn Ngoa" },
                            [1] = { "Xİch Tïng Qu¸n", "Xİch Tïng C©n", "Xİch Tïng Lı" },
                            [2] = { "B¸o ThÇn Trô", "B¸o ThÇn Yªu §¸i", "B¸o ThÇn Ngoa" },
        }
        TopMessage("NhËn ®­îc <c=g>" .. item_name[ty][nums + 1] .. "<c>")
        AddGlobalCountNews("<c=g>" .. GetName() .. "<c>cïng s­ phô hiÖp lùc hoµn thµnh nhiÖm vô s­ ®å th¸m hiÓm, nhËn ®­îc vËt quİ b¸u <c=g>" .. item_name[ty][nums + 1] .. "<c>", 20)
        --	elseif(mark==2)and(GetTask(903)==0)then		--§¹¦¨¤F¤G¦¸±´ÀI¥ô°È¥B¨S¦³»â¨ú¹LÂÅ¦â§¤ÃM
        --		AddNormalItem(3,14,0,0,0,0)
        --		SetTask(903,1)
        --		Talk(1,"no","¤g¦æ®]¡G¯u¬O¤£Â²³æ¡A§A¤w¸g§¹¦¨¤F¨â¶µ«iÂô°g®cªº¸Õ½m¡A§Ú³o¸Ì¦³¤@¤Ç¯«¾s¡A´NÃØ»P§A¤F¡I")
    elseif (mark == 4) and (GetTask(904) == 0) then
        --§¹¦¨¤F¥|¦¸±´ÀI¥ô°È¥B¨S¦³»â¨ú¹L50ÂÅ§¤ÃM
        AddNormalItem2(0, 10, GetPlayerType() + 15, 9, 0, 0)
        SetTask(904, 1)
        Talk(1, "no", 14163)
        AddGlobalCountNews("<color=green>" .. GetName() .. "<c>vµ s­ phô hoµn thµnh nhiÖm vô th¸m hiÓm, nhËn ®­îc <c=g>thó c­ìi cÊp 50<c>", 20)
    else
        Talk(1, "no", 14164)
    end
end

function shitu_1_end_M(pname)
    local step = GetTask(899)
    local key = GetFriendFellowShipValue(pname)
    if (step < 100) or (key >= 720 * 100) then
        local addPRValue = AddMasterPRValue(5)
        SetTask(899, 100)
        --TopMessage(11770)
        TopMessage("Chóc mõng! B¹n nhËn ®­îc <c=g>" .. addPRValue .. " ®iÓm s­ ®å")
    else
        local addPRValue = AddMasterPRValue(2)
        --TopMessage(12119)
        TopMessage("Chóc mõng! B¹n nhËn ®­îc <c=g>" .. addPRValue .. " ®iÓm s­ ®å")
        Talk(1, "no", 14165)
    end
    SetFriendFellowShipValue(pname, 50 * 100)
    Msg2Player("§é th©n mËt gi÷a b¹n vµ §å ®Ö t¨ng thªm")
end

function shitu_1_cancel()
    RemoveIBBuff(216)
    SetTask(899, 0)
    TaskNote(43, -1)
    Talk(1, "no", 14166)
end

function judge_relation()
    --Âú×ãÊ¦Í½2ÈË¶Ó
    local mark = 0
    if (GetTeam() ~= 0) then
        -- ÓĞ¶ÓÎé	
        if (GetTeamSize() == 2) then
            --2ÈË¶Ó
            local n = 0
            if (IsCaptain() == 0) then
                n = GetTeamMember(1)
            else
                n = GetTeamMember(2)
            end ;
            mark = IsMasterPRRelation(n)

            if (mark == 1) then
                local oldPlayer = PlayerIndex
                local w1, x1, y1, w, x, y
                w, x, y = GetWorldPos()

                PlayerIndex = n
                w1, x1, y1 = GetWorldPos()
                if (w1 ~= w) then
                    mark = 0
                end
                PlayerIndex = oldPlayer
            end
        end
    end
    return mark
end

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

function renwu2()
    Talk(1, "no", 10114)
    DelEventItem(1)
    Msg2Player("ThÇn Oanh kh«ng cã t¸c dông. §Õn t×m Hoµng Thiªn Hãa!")
    SetTask(1, 24)            --Íê³ÉµÀÊ¿25¼¶?Îñ
    TaskNote(28, 14)
    --AS GaoJingwei 090728
    refreshNpcTaskState()
    --AE GaoJingwei 090728
end;

function renwu3()
    local mark = fangchenmi()
    if (mark == 1) then
        Talk(3, "no", 10115, 10116, 10117)
        Msg2Player("§Õn D­îc ®iÕm t×m Hå Hû MŞ nghÜ c¸ch.")
        SetTask(1, 31)            --½ÓµÀÊ¿35¼¶?Îñ
        TaskNote(28, 16)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728
    else
        Talk(1, "no", 11718)
    end
end;

function no()
    CloseDialog()
end;

function xianguo()
    local str = "§Õn Hoµn s©m còng kh«ng thÓ lµm cho nµng vui vÎ! …NÕu ng­¬i cã b¸u vËt nµo khiÕn cho nµng cã thÓ në nô c­êi, ta sÏ tÆng Hoµn s©m cho ng­¬i!"
    if (HaveNormalItem(3, 218, 0, 0) > 0) then
        if (IsHaveSpaceForTreasure(1) == 0) then
            Msg2Player("Hµnh trang kh«ng ®ñ chç trèng, kh«ng thÓ nhËn.")
            return
        end

        Talk(3, "no", str, GetName() .. ": Ta cã 1 viªn D¹ Minh Ch©u, ng­¬i kh«ng chª chø?", "Chİnh lµ thø nµy! Thóy Hoa nhÊt ®Şnh sÏ rÊt thİch! Nh­ng ng­¬i ®õng nãi chuyÖn nµy cho §Æng ThiÒn Ngäc tiÓu th­ biÕt nhĞ!")
        --¼õµôÒ»¿Å
        DelNormalItem(3, 218, 0, 0)
        --Ôö¼ÓÒ»¿ÅÎßİ¼
        AddNormalItem(3, 222, 0, 0, 0, 0)

        if (GetBit(GetTask(Task_xianguo), 6) ~= 1) then
            AddOwnExp(1000)
            TopMessage(14443)
            Msg2Player("B¹n nhËn ®­îc 1000 ®iÓm kinh nghiÖm")
        end

        SetTask(Task_xianguo, SetBit(GetTask(Task_xianguo), 6, 1))
        if (GetTask(Task_xianguo) == 125) then
            SetTask(Task_xianguo, SetBit(GetTask(Task_xianguo), 8, 1))
            TaskNote(73, 1)
            --AS by hyz 090713 for ĞÂÊÖÓÅ»¯(taskinfo×Ô¶¯ÅĞ¶Ï)
        else
            local count = 0
            local tb = GetTask(Task_xianguo)
            local tmp_t = {
                "Sïng Thµnh ®¹i doanh-T« §¾c Kû (192,198)", "Ngäc H­ Cung-Nam Cùc Tiªn ¤ng (209,191)", "Xi V­u mé-VËt tæ Khoa phô (199,204)", "TriÒu Ca-Thæ Hµnh T«n (214,184)", "T©y Kú-B¸ Êp Kh¶o (168,195)"
            }
            local tmp_num = {}

            for i = 3, 7 do
                if (GetBit(tb, i) == 0) then
                    count = count + 1
                    tmp_num[count] = i - 2
                end
            end

            if (count == 1) then
                TaskNote(73, count + 1, tmp_t[tmp_num[1]])
            elseif (count == 2) then
                TaskNote(73, count + 1, tmp_t[tmp_num[1]], tmp_t[tmp_num[2]])
            elseif (count == 3) then
                TaskNote(73, count + 1, tmp_t[tmp_num[1]], tmp_t[tmp_num[2]], tmp_t[tmp_num[3]])
            elseif (count == 4) then
                TaskNote(73, count + 1, tmp_t[tmp_num[1]], tmp_t[tmp_num[2]], tmp_t[tmp_num[3]], tmp_t[tmp_num[4]])
            else
                TaskNote(73, 1)
                SetTask(Task_xianguo, SetBit(GetTask(Task_xianguo), 8, 1))
            end

            --AE by hyz 090713 for ĞÂÊÖÓÅ»¯(taskinfo×Ô¶¯ÅĞ¶Ï)
            --AS GaoJingwei 090728
            refreshNpcTaskState()
            --AE GaoJingwei 090728
        end
    else
        Talk(1, "no", str, GetName() .. ": HiÖn t¹i ta ch­a cã.SÏ quay l¹i sau nhĞ!")
    end
end;

----------´óĞËÍÁÄ¾ yaoxin Ğ´ÓÚ08.10.07
build_renwu = 1255 --1byte Ê±¼ä 2byte ÊÇ·ñÁì¹ıÈÎÎñ 3byte ×ö¶ÓÓÑµÄ´ÎÊı 4byte Íê³É½×¶Î,1ÊÇÊÕ¼¯²ÄÁÏ1,2ÊÇÊÕ¼¯²ÄÁÏ2,3ÊÇ¶ÓÓÑÍê³É, 3ÒÔÉÏÊÇ¶Ó³¤3+Ğ¡¶ÓÈËÊı
build_npcIdx = 1256 --Í¶·ÅnpcË÷Òı
build_npcId = 1257 --Í¶·ÅnpcµÄid
build_nums = 1258 --¶Ó³¤Îª»¹ĞèÊÕ¼¯²ÄÁÏµÄ¸öÊı,¶ÓÓÑÎª½ÓÈÎÎñµÄÊ±¼ä´Á

function construction()
    local today = mod(floor(LocalSystemTime() / 86400), 255) + 1
    local lastday = GetByte(GetTask(build_renwu), 1)
    if (today ~= lastday) then
        SetTask(build_renwu, today)
        SetTask(build_npcIdx, 0)
        SetTask(build_npcId, 0)
        SetTask(build_nums, 0)
        refreshNpcTaskState()
    end

    if (GetByte(GetTask(build_renwu), 2) == 0) then
        MsgBox(14495, "constr_yes", "no")
    else
        Talk(1, "no", 14496)
    end
end

function constr_yes()
    if (GetByte(GetTask(build_renwu), 2) == 0) then
        AddNormalItem(6, 1, 389, 0, 0, 0)
        TaskNote(83, 0)
        SetTask(build_renwu, SetByte(GetTask(build_renwu), 2, 1))
        SetTask(build_renwu, SetByte(GetTask(build_renwu), 4, 0))
        SetTask(build_npcIdx, 0)
        SetTask(build_npcId, 0)
        SetTask(build_nums, 0)
        SyncBibleState(83, 2, 1)
        refreshNpcTaskState()
        Talk(3, "no", 14497, GetName() .. ": Kh«ng vÊn ®Ò g×! Nh­ng sau nµy ®õng cã ®a t×nh phong l­u n÷a!", "Ta sÏ dïng ph©n th©n vµ Thiªn Lı TruyÒn ©m h­íng dÉn cho ng­¬i. Nhí kü: ng­¬i ph¶i lµ <c=r>®éi tr­ëng<c> th× míi cã thÓ ®èi tho¹i víi ph©n th©n cña ta, vµ còng chØ cã thÓ ®èi tho¹i víi 1 ph©n th©n mµ th«i!...")
    else
        Talk(1, "no", 14496)
    end
end
---------------------------------------------

-- Added by yangtao 2009.8.19 Á½ÖÜÄêÇìµä»î¶¯
--function twoyearcel()
--	local ran = 1
--	if( IsHaveSpaceForTreasure (1) == 0 ) then
--		ran = 30
--	end
--	local Npcs_zhaoge = 
--	{
--		"ÍÁĞĞËï",
--		"ºúÏ²ÃÄ",
--		"ËÎÒìÈË",
--		"ÓàÇì",
--		"ĞÇ¹Ù"
--	}
--	local task_process	= GetTaskByte(Task_stage, 2)
--	SetTaskBit(Task_stage, 17, 0)
--	SetTaskBit(Task_stage, 1, 1)
--	local j = random(ran, 100)
--	if(j > 20) then
--		if(task_process == 5) then			-- ×îºóÒ»ÕÅºØ¿¨£¬ÈÎÎñÍê³É£¬»¹ĞèÒªÌí¼ÓµÀ¾ßÃ»Íê³É£¬»¹ÓĞ¸ÅÂÊ½±Àø
--			Talk(2,"no","ÍÁĞĞËï£ººÃ¾Ã²»¼û£¬Ó¢ĞÛ×î½ü¹ıµÃ¿ÉºÃ£¿Ïëµ±ÄêÈô²»ÊÇÓ¢ĞÛ°ïĞÖµÜÕÒµ½½â¶¾Ò©£¬ĞÖµÜÏÖÔÚ¹À¼Æ²»ËÀÒ²²ĞÁË¡£àÅ£¿·âÉñ¹ú¼ÊÁ½ÖÜÄêÇìµä»î¶¯£¬ËµÀ´»¹Õæ¿ì°¡£¬¶¼ÒÑ¾­Á½ÖÜÄêÁË£¬ÕæÊÇËêÔÂÈçËó°¡£¬ÎÒÒ»¶¨»áºÃºÃÇì×£Ò»·¬µÄ¡£","ÍÁĞĞËï£ºĞÖµÜÎÒÒ»Ö±ÏëÎªÓ¢ĞÛ×öµãÊ²Ã´£¬²»Èç¾ÍÓÉÎÒÀ´Í¨ÖªÊ£ÏÂµÄÈË°É£¬Ó¢ĞÛ¿É»ØÈ¥¸æËßÀñ¹Ù£¬´ó¼Ò¶¼»áÈ«Á¦ÒÔ¸°µÄ£¡")
--			SetTaskByte(Task_stage, 2, 6)
--			DelNormalItem(3, 471, 0, 0)
--			TaskNote(1094, 1)
--		else
--			local next = 0
--			local i
--			while(next == 0) do 
--				i = random(1, 5)
--				if(GetTaskBit(Task_stage, i) == 0) then
--					next = 1
--				end			
--			end
--			Talk(2,"no","ÍÁĞĞËï£ººÃ¾Ã²»¼û£¬Ó¢ĞÛ×î½ü¹ıµÃ¿ÉºÃ£¿Ïëµ±ÄêÈô²»ÊÇÓ¢ĞÛ°ïĞÖµÜÕÒµ½½â¶¾Ò©£¬ĞÖµÜÏÖÔÚ¹À¼Æ²»ËÀÒ²²ĞÁË¡£àÅ£¿·âÉñ¹ú¼ÊÁ½ÖÜÄêÇìµä»î¶¯£¬ËµÀ´»¹Õæ¿ì°¡£¬¶¼ÒÑ¾­Á½ÖÜÄêÁË£¬ÕæÊÇËêÔÂÈçËó°¡£¬ÎÒÒ»¶¨»áºÃºÃÇì×£Ò»·¬µÄ¡£","ÍÁĞĞËï£º³¯¸è³ÇµÄ<c=g>"..Npcs_zhaoge[i].."<c>Ó¦¸ÃÒ²²»ÖªµÀÕâ¸öÏûÏ¢£¬Ó¢ĞÛÇë¿ì¿ìÈ¥Í¨ÖªËû¡£")
--			SetTaskByte(Task_stage, 2, task_process + 1)
--			SetTaskBit(Task_stage, 16 + i, 1)	
--			TaskNote(1094, 0, Npcs_zhaoge[i])
--		end
--	else
--		if(task_process == 5) then			-- ×îºóÒ»ÕÅºØ¿¨£¬ÈÎÎñÍê³É£¬»¹ĞèÒªÌí¼ÓµÀ¾ßÃ»Íê³É£¬»¹ÓĞ¸ÅÂÊ½±Àø
--			Talk(3,"no","ÍÁĞĞËï£ººÃ¾Ã²»¼û£¬Ó¢ĞÛ×î½ü¹ıµÃ¿ÉºÃ£¿Ïëµ±ÄêÈô²»ÊÇÓ¢ĞÛ°ïĞÖµÜÕÒµ½½â¶¾Ò©£¬ĞÖµÜÏÖÔÚ¹À¼Æ²»ËÀÒ²²ĞÁË¡£àÅ£¿·âÉñ¹ú¼ÊÁ½ÖÜÄêÇìµä»î¶¯£¬ËµÀ´»¹Õæ¿ì°¡£¬¶¼ÒÑ¾­Á½ÖÜÄêÁË£¬ÕæÊÇËêÔÂÈçËó°¡£¬ÎÒÒ»¶¨»áºÃºÃÇì×£Ò»·¬µÄ¡£","ÍÁĞĞËï£ºÕâ¸öÊÇÓñ²õÎª¸ĞĞ»Ó¢ĞÛ¶ø×¨ÃÅ×¼±¸µÄÀñÎï£¬¿ìµãÊÕÏÂ°É¡£","ÍÁĞĞËï£ºĞÖµÜÎÒÒ»Ö±ÏëÎªÓ¢ĞÛ×öµãÊ²Ã´£¬²»Èç¾ÍÓÉÎÒÀ´Í¨ÖªÊ£ÏÂµÄÈË°É£¬Ó¢ĞÛ¿É»ØÈ¥¸æËßÀñ¹Ù£¬´ó¼Ò¶¼»áÈ«Á¦ÒÔ¸°µÄ£¡")
--			SetTaskByte(Task_stage, 2, 6)
--			DelNormalItem(3, 471, 0, 0)
--			TaskNote(1094, 1)
--		else
--			local next = 0
--			local i
--			while(next == 0) do 
--				i = random(1, 5)
--				if(GetTaskBit(Task_stage, i) == 0) then
--					next = 1
--				end			
--			end
--			Talk(3,"no","ÍÁĞĞËï£ººÃ¾Ã²»¼û£¬Ó¢ĞÛ×î½ü¹ıµÃ¿ÉºÃ£¿Ïëµ±ÄêÈô²»ÊÇÓ¢ĞÛ°ïĞÖµÜÕÒµ½½â¶¾Ò©£¬ĞÖµÜÏÖÔÚ¹À¼Æ²»ËÀÒ²²ĞÁË¡£àÅ£¿·âÉñ¹ú¼ÊÁ½ÖÜÄêÇìµä»î¶¯£¬ËµÀ´»¹Õæ¿ì°¡£¬¶¼ÒÑ¾­Á½ÖÜÄêÁË£¬ÕæÊÇËêÔÂÈçËó°¡¡£","ÍÁĞĞËï£ºÕâ¸öÊÇÓñ²õÎª¸ĞĞ»Ó¢ĞÛ¶ø×¨ÃÅ×¼±¸µÄÀñÎï£¬¿ìµãÊÕÏÂ°É¡£","ÍÁĞĞËï£º³¯¸è³ÇµÄ<c=g>"..Npcs_zhaoge[i].."<c>Ó¦¸ÃÒ²²»ÖªµÀÕâ¸öÏûÏ¢£¬Ó¢ĞÛÇë¿ì¿ìÈ¥Í¨ÖªËû¡£")
--			SetTaskByte(Task_stage, 2, task_process + 1)
--			SetTaskBit(Task_stage, 16 + i, 1)	
--			TaskNote(1094, 0, Npcs_zhaoge[i])
--		end

--		local k = random(1,100)
--		if(k <= 5) then
--			AddNormalItem(8, 733, 2, 1, 0, 0)
--			Msg2Player("Äã»ñµÃÁËÃÔÄã³¬¼¶»Ø³Ç·û¡£")
--			WriteLog("»ñµÃÃÔÄã³¬¼¶»Ø³Ç·û¡£")
--		elseif(k <= 17) then
--			AddNormalItem(8, 567, 2, 1, 0, 0)
--			Msg2Player("Äã»ñµÃÁËÈçÒâÒ°Íâ´«ËÍ·û¡£")
--			WriteLog("»ñµÃÈçÒâÒ°Íâ´«ËÍ·û¡£")
--		elseif(k <= 30) then
--			AddNormalItem(8, 781, 2, 1, 0, 0)
--			Msg2Player("Äã»ñµÃÁËÈçÒâ»Ø¹ú·û¡£")
--			WriteLog("»ñµÃÈçÒâ»Ø¹ú·û¡£")
--		elseif(k <= 65) then
--			AddNormalItem(8, 780, 4, 1, 0, 0)
--			Msg2Player("Äã»ñµÃÁËÈçÒâĞ¡ÈÕÔÂÕæÆø¡£")
--			WriteLog("»ñµÃÈçÒâĞ¡ÈÕÔÂÕæÆø¡£")
--		else
--			AddNormalItem(8, 779, 3, 1, 0, 0)
--			Msg2Player("Äã»ñµÃÁËÈçÒâĞ¡ÉúÃüÇåÂ¶¡£")
--			WriteLog("»ñµÃÈçÒâĞ¡ÉúÃüÇåÂ¶¡£")
--		end
--	end
--end
-- end of add yangtao 2009.8.19


--added by hongliang for ÈıÖÜÄê»î¶¯ 10/8/12 begin
--~ function ThreeYears_FireWorks()
--~     CloseDialog();

--~     local idx = GetTaskByte(TASK_ThreeYears_Fireworks, 3); --µ±Ç°NPCµÄÌâÄ¿
--~     local num = GetTaskByte(TASK_ThreeYears_Questions, 4); --µ±Ç°´ğÌâÊıÁ¿

--~     if (HaveNormalItem(8, G_ThreeYears_1stFireworksId + num, 2, 0) == 0) then
--~         Talk(1, "no", "ÍÁĞĞËï£ºÓ¢ĞÛ±³°üÖĞÃ»ÓĞĞ¯´øÇìµäÀñ»¨£¬Çë°ÑËü´øÔÚÉíÉÏÔÙÀ´ÕÒÎÒ°É¡£");
--~         return
--~     end
--~     
--~     if (idx == 6) then
--~         Talk(1, "no", "ÍÁĞĞËï£º¸Õ²ÅÄãÒÑ¾­µÃµ½ÎÒµÄ×£¸£ÁË£¬Èç¹û½ñÌìÀÛ»ıµÃµ½ÁË5´Î×£¸££¬ÇëÇ°Íù³¯¸èÇìµäÍ¼ÌÚ¸½½üÈ¼·ÅÂúÔØ×£¸£µÄÇìµäÀñ»¨¡£");
--~         return
--~     end

--~     MsgBox("ÍÁĞĞËï£ººÃ¾Ã²»¼û£¬Ó¢ĞÛ×î½ü¹ıµÃ¿ÉºÃ£¿¿´µ½ÏÖÔÚµÄÄã£¬¾ÍÏëÆğµ±ÄêÓ¢ĞÛÊ¦Í½¶şÈËÒ»Í¬½øĞĞÊ¦ÃÅ»ÄÄ®ÊÔÁ¶£¬ÄÇÊ±Ó¢ĞÛ¿´ÆğÀ´»¹ÊÇÄÇÃ´ÖÉÄÛ£¬Èç½ñÒÑ¾­³É³¤ºÜ¶àÁË¡£½ñÈÕÓ¢ĞÛÈôÄÜ»Ø´ğÎÒµÄÎÊÌâ£¬ÎÒ¿ÉÒÔËÍÒ»µÀ×£¸£¸øÓ¢ĞÛ¡£", "Accept_ThreeYears_FireWorks", "no");
--~ end


--~ function Accept_ThreeYears_FireWorks()
--~     CloseDialog();
--~     
--~     local idx = GetTaskByte(TASK_ThreeYears_Fireworks, 3); --µ±Ç°NPCµÄÌâÄ¿
--~     
--~     local TABLE_Ques = {
--~         [1] = { quest = "Ê®¾øÕóÖĞ£¬ÒÔÏÂÄÄ¸öÕóµôÂäÒìÈË140¼¶¼¼ÄÜÊé±©·çÖèÓê£¿", 
--~                     option = { [1]  = "ºìË®Õó", [2] = "º®±ùÕó", [3] = "»¯ÑªÕó", }, },
--~         [2] = { quest = "Íê³É¸ß¼¶Ê¦ÃÅÈÎÎñ¿ÉÒÔ»ñµÃÒÔÏÂÄÄ¸öÎïÆ·£¿", 
--~                     option = { [1]  = "Í½µÜ¿¨", [2] = "Á½ÒÇ¹éÕæ¾µ", [3] = "Ê¦¶÷Áî", }, },
--~         [3] = { quest = "Ò©²Ä¼Ó¹¤¼¼ÄÜ¿ÉÒÔÔÚÄÄÀïÑ§Ï°£¿", 
--~                     option = { [1]  = "ÓñĞé¹¬Éú»î¼¼Ê¦", [2] = "³¯¸èÉú»î¼¼Ê¦", [3] = "Î÷áªÉú»î¼¼Ê¦", }, },
--~         [4] = { quest = "ÁÙÏÉÂ¶¼ÆÊ±Ğ§¹ûÈçºÎÔİÍ££¿", 
--~                     option = { [1]  = "Ctrl+Êó±ê×ó¼ü", [2] = "Shift+Êó±ê×ó¼ü", [3] = "Alt+Êó±ê×ó¼ü", }, },
--~         [5] = { quest = "²ÎÓëÊ²Ã´»î¶¯¿ÉÒÔ»ñµÃ´ß·æÁî£¿", 
--~                     option = { [1]  = "ÉÌÖÜÕ½³¡", [2] = "¼´Ê±Õ½³¡", [3] = "Ô¶¹ÅÕ½³¡", }, },
--~     }
--~     
--~     local seq = {1,2,3};
--~     local i, j = 0, 0;
--~     local temp = 0;
--~     for i = 1, 2 do
--~         j = random(i, 3);
--~         temp = seq[i];
--~         seq[i] = seq[j];
--~         seq[j] = temp;
--~     end
--~     
--~     local opt1 = TABLE_Ques[idx].option[seq[1]].."/ThreeYears_FireWorks_Option"..seq[1];
--~     local opt2 = TABLE_Ques[idx].option[seq[2]].."/ThreeYears_FireWorks_Option"..seq[2];
--~     local opt3 = TABLE_Ques[idx].option[seq[3]].."/ThreeYears_FireWorks_Option"..seq[3];
--~     
--~     Say("ÍÁĞĞËï£º\n"..TABLE_Ques[idx].quest, 4, opt1, opt2, opt3, "È¡Ïû/no");

--~ end


--~ function ThreeYears_FireWorks_Option1()
--~     CloseDialog();
--~     
--~     ThreeYears_FireWorks_Judge(1);
--~ end


--~ function ThreeYears_FireWorks_Option2()
--~     CloseDialog();
--~     
--~     ThreeYears_FireWorks_Judge(2);
--~ end


--~ function ThreeYears_FireWorks_Option3()
--~     CloseDialog();
--~     
--~     ThreeYears_FireWorks_Judge(3);
--~ end


--~ function ThreeYears_FireWorks_Judge(choice)
--~     CloseDialog();

--~     local idx = GetTaskByte(TASK_ThreeYears_Fireworks, 3); --µ±Ç°NPCµÄÌâÄ¿
--~     local TABLE_Key = {[1] = 1, [2] = 3, [3] = 3, [4] = 1, [5] = 2,};
--~     
--~     if (TABLE_Key[idx] == choice) then
--~     
--~         local num = GetTaskByte(TASK_ThreeYears_Questions, 4);

--~         if (HaveNormalItem(8, G_ThreeYears_1stFireworksId + num, 2, 0) == 0) then
--~             Talk(1, "no", "ÍÁĞĞËï£ºÓ¢ĞÛËäÈ»´ğ¶ÔÁËÌâÄ¿£¬µ«±³°üÖĞÃ»ÓĞĞ¯´øÇìµäÀñ»¨£¬Çë°ÑËü´øÔÚÉíÉÏÔÙÀ´ÕÒÎÒ°É¡£");
--~             return
--~         end

--~         Talk(1, "no", "ÍÁĞĞËï£ºÓ¢ĞÛ¹ûÈ»²ÅÖÇ¹ıÈË£¬ÕâµÀ×£¸£¾ÍËÍÓèÓ¢ĞÛÁË¡£");
--~         
--~         SetTaskByte(TASK_ThreeYears_Fireworks, 3, 6);
--~         
--~         SetTaskByte(TASK_ThreeYears_Questions, 4, num + 1);

--~         DelNormalItem(8, G_ThreeYears_1stFireworksId + num, 2, 0); 
--~         AddNormalItem(8, G_ThreeYears_1stFireworksId + num + 1, 2, 0, 0, 0);

--~         if (num + 1 < 5) then
--~             TopMessage("ÄúµÄÀñ»¨µÃµ½ÁË"..(num + 1).."·İ×£¸£");
--~         else
--~             TopMessage("ÄúµÄÀñ»¨µÃµ½ÁË×ã¹»µÄ×£¸£");
--~             WriteLog("»ñµÃÒ»¸öÂúÔØ×£¸£µÄÀñ»¨¡£");
--~             TaskNote(1610, 1);
--~         end
--~         
--~     else
--~         Talk(1, "no", "ÍÁĞĞËï£ºÄãµÄ´ğ°¸²»¶Ô£¬ÇëÖØĞÂ×÷´ğ¡£");
--~     end

--~ end
--added by hongliang for ÈıÖÜÄê»î¶¯ 10/8/12 end


