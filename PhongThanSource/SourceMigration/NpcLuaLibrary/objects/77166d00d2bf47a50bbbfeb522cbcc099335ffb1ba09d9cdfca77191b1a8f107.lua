--description: ËãÃüÏÈÉú-×°±¸Á¶»¯ÈÎÎñ
--author: chensong
--date: 2004/7/12
--taskÊéĞ´¸ñÊ½¸Ä°æ  modified by yaoxin at 2009-08-21

--------------------------------------------------------------------------
--1167 Áé³è±äÉíÃû ÒÔÏÂÊı×éºÅ¾ÍÊÇ±äÉíµÄbitÖÃÎ»¶ÔÓ¦µÄindex(1-31),ºóÃæµÄ¿ÉÒÔÍùºóĞøĞ´
Include("\\script\\gvn\\events\\top_consumecoin\\event_topconsume.lua")

--Áé³èÖ®Ô¸
Task_lingchong = 1395 -- 1byte: 1:½ÓÁé³èÖ®Ô¸ÈÎÎñ£»2:³èÎïĞéÈõ×´Ì¬ 3£ºÍê³ÉÈÎÎñ
-- 2byte: 1£ºÁé³èÖ®Ô¸Ö®³èÎïĞéÈõ£»2£ºÁé³èÖ®Ô¸Ö®³èÎï»Ö¸´
-- 3byte: 1:½Ó¹ıÁé³èÖ®Ô¸ÈÎÎñ£»2£ºÂòÁËµ°£»3£º´øµ°Íæ¹»24Ğ¡Ê±£»

Task_Pet_name = {
    [1] = "Lôc Phi Phi",
    [2] = "TuyÕt Linh Thö",
    [3] = "TiÕu Thiªn KhuyÓn",
    [4] = "Ngäc Thè",
    [5] = "§¹i NhÜ",
    [6] = "Phi Thiªn Linh Miªu",
    [7] = "Phông hoµng",
    [8] = "",
    [9] = "B¹ch Tr­",
    [10] = "Hång Tr­",
    [11] = "Kim Tr­",
    [12] = "Ng­u B¶o B¶o",
    --add by lisuhui at 2009.09.23 begin for ĞÂ³èÎï
    [13] = "§Ëu §Ëu Hå",
    [14] = "§Ëu §Ëu Hå (biÕn dŞ)",
    [15] = "Tinh Minh Quy",
    [16] = "Tinh Minh Quy (biÕn dŞ)",
    [17] = "Tra Tra §iÓu",
    [18] = "Tra Tra §iÓu (biÕn dŞ)",
    [19] = "Rång ®æi mµu",
    [20] = "Rång ®æi mµu (biÕn dŞ)",
    --add by lisuhui end
}
--------------------------------------------------------------------------

-- Add By Zhang Jin for Ë«±¶¾­ÑéÓÅ»¯ at 2010-04-19 Begin
TaskTimes = {
    [1] = { totalTimes = 620, awardsTimes = 5, },
    [2] = { totalTimes = 380, awardsTimes = 4, },
    [3] = { totalTimes = 260, awardsTimes = 3, },
    [4] = { totalTimes = 200, awardsTimes = 2, },
    [5] = { totalTimes = 170, awardsTimes = 1, },
    [6] = { totalTimes = 0, awardsTimes = 0, },
}
Double_Optimization = 1696 -- Ë«±¶¾­ÑéÓÅ»¯ 1Byte£ºÒÑ¾­ÁìÈ¡µÄË«±¶¾­Ñé´ÎÊı 2Byte£º¿ÉÁìÈ¡µÄË«±¶¾­Ñé×Ü´ÎÊı
G_Double = 370 -- È«¾Ö±äÁ¿
-- Add By Zhang Jin for Ë«±¶¾­ÑéÓÅ»¯ at 2010-04-19 End

-- AS GaoJingwei at 090728
NpcState = {
    [1] = { state = 3, subState = 0, str = "Vµng më" },
    [2] = { state = 3, subState = 1, str = "Lam më" },
    [3] = { state = 1, subState = 0, str = "Vµng ®ãng" },
    [4] = { state = 1, subState = 1, str = "Lam ®ãng" },
    [5] = { state = 2, subState = 0, str = "X¸m më" },
    [6] = { state = 0, subState = 0, str = "Kh«ng cã nhiÖm vô" },
}

------Add by liuzhiqiang at 2009/8/14---------ÒåÆø
Task_Yiqi = 1532


-------------added by hongliang for ÈıÖÜÄê»î¶¯ 10/8/12 begin----------------

--~ TASK_ThreeYears_Fireworks = 1724;
--~ --1st byte ÈÎÎñ²½Öè: 0-Î´½Ó 1-ÒÑ½Ó 2-Íê³É; 2nd byte ½ÓÈÎÎñÊ±¼ä;
--~ --3rd byte µÚÒ»¸öNPCµÄÌâÄ¿£¨0Î´½ÓÈÎÎñ£¬1-5±íÊ¾ÌâÄ¿ĞòºÅ£¬6±íÊ¾ÒÑÔÚ¸ÃNPC´¦»Ø´ğÍê£©; 4th byte µÚ¶ş¸öNPCµÄÌâÄ¿

--~ TASK_ThreeYears_Questions = 1725;--1st~3rd bytes µÚÈı¡«Îå¸öNPCµÄÌâÄ¿; 4th byte ÒÑ¾­Íê³ÉµÄ´ğÌâÊıÄ¿

--~ G_ThreeYears_1stFireworksId = 1318;

--~ ----------------------------------------------------------------------------

--~ TASK_ThreeYears_Blessing = 1726; --1st byte ÈÎÎñ²½Öè: 0-Î´½Ó 1-ÒÑ½Ó 2-Íê³É; 2nd byte ½ÓÈÎÎñÊ±¼ä; 3rd byte ×î½üÊÕÓÊ¼şÊ±¼ä£¨Á½¸ö»î¶¯¹²ÓÃ£©

--~ BUFF_ThreeYears_Blessing_1stBuff = 773; --¸÷µØ×£¸£buff
--~ BUFF_ThreeYears_Blessing_Effect = 1324; --½ÓÊÜ×£¸£ÌØĞ§

--~ BUFF_ThreeYears_Clear = 1325; --ÇåÀí
-------------added by hongliang for ÈıÖÜÄê»î¶¯ 10/8/12 end------------------



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

    --ÑÉÖª·Ç¸£
    startLevel = 23
    if (GetLevel() >= startLevel) then
        local taskProcess = GetTask(91)
        if (GetLevel() - startLevel <= 5) then
            if (taskProcess == 1) then
                state = 3
                subState = 0
            elseif (taskProcess == 3) and (HaveNormalItem(6, 1, 12, 1) >= 1) then
                state = 3
                subState = 0
            elseif (taskProcess == 4) then
                state = 0
                subState = 0
            end
        else
            if (taskProcess == 1) then
                state = 3
                subState = 1
            elseif (taskProcess == 3) and (HaveNormalItem(6, 1, 12, 1) >= 1) then
                state = 3
                subState = 1
            elseif (taskProcess == 4) then
                state = 0
                subState = 0
            end

        end

        index = searchForIndex(state, subState, index)
    end

    --Õô·¢ÃÜÁî
    startLevel = 73
    if (GetLevel() >= startLevel) then
        local taskStatus = GetByte(GetTask(TASK_ID_LEAK), 1)
        if (GetLevel() - startLevel <= 5) then
            if (taskStatus == 1) then
                state = 1
                subState = 0
            end
        else
            if (taskStatus == 1) then
                state = 1
                subState = 1
            end
        end

        index = searchForIndex(state, subState, index)
    end

    --ËÄÏóÁéÏ¬
    startLevel = 65
    if (GetLevel() >= startLevel) then
        local key = tongguanjiangli()
        local temp = GetTaskByte(1021, 2) + 1
        local times, addtimes = todayfreetimes(temp)
        local thisday = mod(floor(LocalSystemTime() / 86400), 256)
        local lastday = GetTaskByte(1021, 1)
        local alltimes = GetTaskByte(1477, 3)
        if (GetLevel() - startLevel <= 5) then
            if (key == 0 and thisday ~= lastday) then
                state = 1
                subState = 0
            elseif (key == 2 and times == 1) then
                state = 3
                subState = 0
            elseif (key == 1 and times == 1) then
                state = 2
                subState = 0
            end
        else
            if (key == 0 and thisday ~= lastday) then
                state = 1
                subState = 1
            elseif (key == 2 and times == 1) then
                state = 3
                subState = 1
            elseif (key == 1 and times == 1) then
                state = 2
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

--Ë¢ĞÂnpcµÄ×´Ì¬
function refreshNpcTaskState()
    local state, subState = GetNpcTaskSatate()
    SetPlayerTaskState(state, subState)
end
-- AE GaoJingwei at 090728 end

function main(sel)
    tasks = {
        { "Yªn Phóc", "renwu1"; show = 0 },
        { "Tø Linh", "sixiang"; show = 0 },
        { "MËt LÖnh", "processLeakOrder"; show = 0 },
        --{"<c=g>ËÄÏó¾§Ê¯<c>","renwu2_1";show=0},
        --{"¹ØÓÚËÄÏóÁéÏ¬","into_sxlx";show=1},
        { "<c=g>Linh thó chi nguyÖn<c>", "pet_wish"; show = 0 }, ---- Added by liuzhiqiang at 2009-4-21
        { "<c=g>Tu luyÖn Linh lùc<c>", "magic_learn"; show = 0 }, ---- Added by liuzhiqiang at 2009-4-22
        { "Nu«i d­ìng", "GetPet"; show = 1 },
        { "H« ho¸n", "bs"; show = 0 },
        { "Linh Thó håi sinh", "PetReborn"; show = 0 }, --add by luoyixuan

        -- added by hongliang for ÈıÖÜÄê»î¶¯ 10/8/12 begin
        --{"½ÓÊÜ×£¸£", "ThreeYears_FireWorks"; show = 0},
        -- added by hongliang for ÈıÖÜÄê»î¶¯ 10/8/12 end
    }

    UTask_world_1 = GetTask(91)
    UTask_cg_0 = GetTask(40);

    if (UTask_world_1 == 3) then
        tasks[1].show = 1;
    end ;
    if (UTask_world_1 == 1) then
        tasks[1].show = 1;
    end ;
    if (GetPlayerType() == 2) then
        tasks[7].show = 1;
    end ;

    if (GetLevel() >= 65) then
        tasks[2].show = 1;
        --if (GetTask(1023) > task_yuansu[1][1]) then
        --	tasks[4].show=1
        --end
    end ;

    if (isViewLeakOrder() == 1) then
        tasks[3].show = 1;
    end ;

    -- Added by liuzhiqiang at 2009-4-21 Begin
    local lingchongstate = GetTaskByte(Task_lingchong, 1)
    if ((PetIsAdd() == 0 and GetIBBuffTimes(418) > 0) or (PetIsAdd() == 1 and PetGetType() == 0) or (PetIsAdd() == 1 and PetGetType() > 0 and lingchongstate >= 1 and lingchongstate <= 2) or GetTaskByte(Task_lingchong, 3) == 1) then
        tasks[4].show = 1
    end

    local petspirit = PetGetSpirit()
    if (PetIsAdd() == 1 and PetGetType() > 0 and petspirit == 0) then
        if (lingchongstate ~= 0) then
            if (lingchongstate == 3) then
                tasks[5].show = 1
            end
        elseif (GetTaskByte(Task_lingchong, 3) ~= 1) then
            tasks[5].show = 1
        end
    end

    if (PetIsAdd() == 1 and PetGetType() > 0 and lingchongstate == 4) then
        tasks[5].show = 1
    end
    -- Added by liuzhiqiang at 2009-4-21 end
    -- add by luoyixuan
    if (PetIsSleep() == 1) then
        tasks[8].show = 1
    end

    if (tasks[8].show == 1) then
        tasks[6].show = 0
    end
    --add by luoyixuan

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
    --~                      if (year == 2010 and month == 8 and day == 30
    --~                             and hour >= 19 and hour <= 21
    --~                             and TaskStep == 1) then
    --~                         tasks[9].show = 1;
    --~                     end
    --added by hongliang for ÈıÖÜÄê»î¶¯ 10/8/12 end

    SayTask(14498, tasks)
end;

function sixiang()
    local tasksSixiang = {
        { "Tø Linh", "renwu2"; show = 1 },
        { "<c=g>Tø T­îng Tinh Th¹ch<c>", "renwu2_1"; show = 0 },
        { "T×m HiÓu", "into_sxlx"; show = 1 },

    }
    if (GetTask(1023) > task_yuansu[1][1]) then
        tasksSixiang[2].show = 1
    end

    -- Add By Zhang Jin for Ë«±¶¾­ÑéÓÅ»¯ at 2010-04-19 Begin
    local index = 6
    for i = 1, 6 do
        if (GetTask(1023) >= TaskTimes[i].totalTimes) then
            SetTaskByte(Double_Optimization, 2, TaskTimes[i].awardsTimes)
            index = i
            break
        end
    end

    local str = "Tø Tinh ®ang bŞ Ma v­¬ng ThiÕt Bè, Kim Tr¹i, C«n Bèi, Lam B¸ khèng chÕ! Ng­¬i cã thÓ gãp chót c«ng søc ®Ó gi÷ cho nh©n thÕ nµy ®­îc th¸i b×nh! NÕu ng­¬i mang ®Õn cho ta 1 <c=g>Tha S¬n Th¹ch<c> vµ İt b¹c, ta sÏ gióp ng­¬i më Linh Tª m«n, ®Ó ®i gi¶i cøu Tø Tinh!"
    if (GetGlobalValueByte(G_Double, 1) == 1) then
        if (index > 1) then
            str = str .. "B¹n ®· hoµn thµnh nhiÖm vô thø <c=g>" .. GetTask(1023) .. "<c>, <c=r>nÕu sè nhiÖm vô hoµn thµnh ®¹t" .. TaskTimes[index - 1].totalTimes .. " lÇn, b¹n sÏ nhËn ®­îc phÇn th­ëng hÊp dÉn h¬n.<c>"
        else
            str = str .. "<c=r>TuÇn nµy b¹n cã 5 ngµy cã thÓ nh©n ®«i phÇn th­ëng!<c>"
        end
    end
    SayTask(str, tasksSixiang)
    -- Add By Zhang Jin for Ë«±¶¾­ÑéÓÅ»¯ at 2010-04-19 End

end

-- Added by liuzhiqiang at 2009-4-21 Begin
function pet_wish()
    CloseDialog()

    if (PetIsAdd() == 0 and GetIBBuffTimes(418) > 0 and GetIBBuffTimes(418) < 30) then
        SetTaskByte(Task_lingchong, 1, 1)
        refreshNpcTaskState()
        Talk(1, "no", "Anh hïng thu thËp ®ñ 30 Linh thó chi nguyÖn h·y ®Õn t×m ta.")
        return
    end

    if (((PetIsAdd() == 0 and GetIBBuffTimes(418) >= 30) or (PetIsAdd() == 1)) and GetTaskByte(Task_lingchong, 3) == 1) then
        SetTaskByte(Task_lingchong, 1, 1)
        refreshNpcTaskState()
        SetTaskByte(Task_lingchong, 3, 0)
        refreshNpcTaskState()
        Talk(1, "no", "Chóc mõng ng­êi thu thËp ®ñ Linh thó chi nguyÖn, nÕu anh hïng cã thêi gian, h·y trë l¹i lÇn n÷a, l·o phu cßn cã viÖc yªu cÇu.")
        TaskNote(1048, -1)
        return
    end

    if (PetIsAdd() == 0 and GetIBBuffTimes(418) >= 30 and GetTaskByte(Task_lingchong, 3) == 0) then
        SetTaskByte(Task_lingchong, 1, 1)
        refreshNpcTaskState()
        SetTaskByte(Task_lingchong, 3, 2) --Add by liuzhiqiang at 2009/4/23
        Talk(1, "no", "L·o phu hy väng ng­êi nhËn 1 trøng linh thó chç ta vÒ nu«i, l·o phu sÏ truyÒn bİ quyÕt cho ng­êi.")
        TaskNote(1048, 2)
        return
    elseif (PetIsAdd() == 0 and GetIBBuffTimes(418) >= 30 and GetTaskByte(Task_lingchong, 3) == 2) then
        Talk(1, "no", "L·o phu hy väng ng­êi nhËn 1 trøng linh thó chç ta vÒ nu«i, l·o phu sÏ truyÒn bİ quyÕt cho ng­êi.")
        return
    end

    if (PetIsAdd() == 1 and GetTaskByte(Task_lingchong, 3) == 2) then
        SetTaskByte(Task_lingchong, 1, 1)
        SetTaskByte(Task_lingchong, 3, 0)
        Talk(1, "no", "Trøng Linh thó do linh khİ trêi ®Êt t¹o thµnh, cÇn dç dµnh ch¨m sãc chu ®¸o, nÕu anh hïng cã thêi gian, h·y nghe l·o phu nãi qua.")
        TaskNote(1048, -1)
        return
    end

    if (PetIsAdd() == 1 and PetGetType() == 0 and GetTaskByte(Task_lingchong, 3) == 0) then
        SetTaskByte(Task_lingchong, 1, 1)
        SetTaskByte(Task_lingchong, 3, 3)
        Talk(1, "no", "ViÖc cÇn lµm cña ng­êi b©y giê lµ dÉn Linh thó ®i ch¬i, sau khi nã në h·y l¹i ®©y t×m  ta.<enter><enter>Bİ quyÕt:Sau khi tİch lòy 1 thêi gian trªn m¹ng Linh thó sÏ në ra.")
        TaskNote(1048, 3)
        return
    elseif (PetIsAdd() == 1 and PetGetType() == 0 and GetTaskByte(Task_lingchong, 3) == 3) then
        Talk(1, "no", "ViÖc cÇn lµm cña ng­êi b©y giê lµ dÉn Linh thó ®i ch¬i, sau khi nã në h·y l¹i ®©y t×m  ta.<enter><enter>Bİ quyÕt:Sau khi tİch lòy 1 thêi gian trªn m¹ng Linh thó sÏ në ra.")
        return
    end

    if (PetIsAdd() == 1 and PetGetType() > 0 and GetTaskByte(Task_lingchong, 3) == 3) then

        if (PetIsSleep() == 1) then
            Talk(1, "no", "Linh thó cña ng­êi ®ang ngñ, gäi nã dËy h·y ®Õn t×m ta.")
            return
        end

        SetTaskByte(Task_lingchong, 1, 1)
        SetTaskByte(Task_lingchong, 3, 0)
        Talk(1, "no", "Chóc mõng ng­êi, Linh thó ®· në thµnh h×nh råi. L·o phu sÏ truyÒn hÕt bİ quyÕt c¶ ®êi cho ng­êi, nÕu anh hïng cã thêi gian, h·y nghe ta nãi.")
        TaskNote(1048, -1)
        return
    end

    if (PetIsAdd() == 1 and PetGetType() > 0 and GetTaskByte(Task_lingchong, 1) == 1 and GetTaskByte(Task_lingchong, 3) == 0) then

        if (PetIsSleep() == 1) then
            Talk(1, "no", "Linh thó cña ng­êi ®ang ngñ, gäi nã dËy h·y ®Õn t×m ta.")
            return
        end

        --if( IsHaveSpaceForTreasure(1) ~= 1 ) then
        --	Talk(1, "no", "ËãÃüÏÈÉú£ºÄúµÄ±³°ü¿Õ¼ä²»¹»£¬ÇëÁôÒ»¸ö¿Õ¼äÎ»ÖÃÔÙÀ´ÕÒÎÒ¡£")
        --	return
        --end

        local PetStrength = PetGetStrength()
        if (PetStrength + 36000 >= 360000) then
            PetModifyStrength(-(PetGetStrength() - 323999))
        end

        --AddNormalItem( 3, 114, 0, 0, 0, 0 ) --ÁùµÀ¾«»ª

        SetTaskByte(Task_lingchong, 1, 2)
        SetTaskByte(Task_lingchong, 2, 1)
        refreshNpcTaskState()
        TaskNote(1048, 4)

        Talk(2, "no", " Linh thó cña ng­êi míi në kh«ng l©u, xem ra suy yÕu kh¸c th­êng, mau dïng <c=g>Lôc §¹o, Tø Tinh hoÆc Ph¸c Ngäc<c> ®Ó trŞ liÖu cho nã.", " <c=g>Lôc §¹o<c> vµ <c=g>Tø Tinh<c> cã thÓ ®Õn chç Xİch Tïng Tö dïng nguyªn liÖu Lôc §¹o hoÆc Tø T­îng ®Ó hîp thµnh.")

        return
    end

    if (PetIsAdd() == 1 and PetGetType() > 0 and GetTaskByte(Task_lingchong, 1) == 2) then

        if (PetIsSleep() == 1) then
            Talk(1, "no", "Linh thó cña ng­êi ®ang ngñ, gäi nã dËy h·y ®Õn t×m ta.")
            return
        end

        if (GetTaskByte(Task_lingchong, 2) == 2) then
            AddOwnExp(5000)
            TopMessage("NhËn ®­îc <c=g>5000<c> kinh nghiÖm.")
            Msg2Player("Hoµn thµnh Linh thó chi nguyÖn, nhËn ®­îc 5000 kinh nghiÖm.")
            SetTaskByte(Task_lingchong, 1, 3)
            Talk(1, "bianshen", "Xem ra ng­¬i ®· lÜnh héi hÕt ph­¬ng ph¸p ta truyÒn ®¹t, nÕu linh lùc Linh thó cña ng­êi ch­a cã, l·o phu sÏ gióp ng­êi 1 tay.")
            TaskNote(1048, -1)
        else
            Talk(1, "no", " Linh thó cña ng­¬i ®· suy yÕu, h·y mau dïng Lôc §¹o, Tø Tinh hoÆc Ph¸c Ngäc ®Ó trŞ liÖu cho nã.")
        end
    end
end

function bianshen()

    CloseDialog()

    if (PetIsSleep() == 1) then
        Talk(1, "no", "Sao t«i chÕt råi!")
        return
    end

    if (PetIsAdd() == 1 and PetGetType() > 0 and GetTaskByte(Task_lingchong, 1) == 3) then
        if (PetGetType() == 1 or PetGetType() == 2) then
            --Èç¹û³èÎïÊÇÂÌ·É·É»òÑ©ÁéÊó
            MsgBox("Chñ nh©n ta häc ®­îc chiªu thøc míi råi, ta sÏ lµm cho chñ nh©n biÕn thµnh h×nh d¸ng cña ta, nh­ng do n¨ng lùc cã h¹n, nªn chØ duy tr× ®­îc 30 phót.", "change_type", "no")
        end
    end
end

function change_type()
    CloseDialog()

    if (PetIsSleep() == 1) then
        Talk(1, "no", "Sao t«i chÕt råi!")
        return
    end

    if (PetIsAdd() == 1 and PetGetType() > 0 and GetTaskByte(Task_lingchong, 1) == 3) then

        if (PetGetType() ~= 1 and PetGetType() ~= 2) then
            --Èç¹û³èÎï²»ÊÇÂÌ·É·ÉºÍÑ©ÁéÊó
            Talk(1, "no", "BiÕn th©n thÊt b¹i, ch¼ng lÏ do linh lùc cña ta ch­a ®ñ sao?")
            return
        end

        if (((GetMorphType() >= 363 and GetMorphType() <= 366) or GetMorphType() == 420 or GetMorphType() == 419)) then
            Talk(1, "no", "Chñ nh©n ®· biÕn th©n råi, n¨ng lùc ta kh«ng ®ñ ®Ó gióp ng­êi biÕn th©n tiÕp.")
        else
            if (PetGetType() == 1) then
                PolyMorph(435, 1, 0, -1, 1800)
            elseif (PetGetType() == 2) then
                PolyMorph(436, 1, 0, -1, 1800)
            end
        end
    end
end

function magic_learn()
    CloseDialog()

    if (PetIsSleep() == 1) then
        Talk(1, "no", "Linh thó cña ng­êi ®· ngñ, gäi nã dËy h·y ®Õn t×m ta")
        return
    end

    local lingchongstate = GetTaskByte(Task_lingchong, 1)
    local petspirit = PetGetSpirit()

    if (PetIsAdd() == 1 and PetGetType() > 0 and lingchongstate == 4) then

        if (petspirit == 0) then
            Talk(1, "no", " Båi d­ìng linh lùc cho Linh thó: cã thÓ x«ng pha vµo V¹n Tiªn trËn t×m c¸c lo¹i TrËn Nh·n hoÆc sö dông MËt b¶o Tô Linh Ch©u tiÕn hµnh båi d­ìng linh lùc.")
        else
            SetTaskByte(Task_lingchong, 1, 5)
            AddOwnExp(10000)
            Msg2Player("Tu luyÖn Linh lùc hoµn thµnh, nhËn ®­îc 10000 kinh nghiÖm.")
            TopMessage("NhËn ®­îc <c=g>10000<c> kinh nghiÖm.")
            Talk(1, "no", " L·o phu ®· khai më linh lùc cho Linh thó, sau nµy ch¨m sãc nhiÒu cho nã, sÏ cã thªm sù ng¹c nhiªn, nÕu cã vÊn ®Ò vÒ nu«i d­ìng Linh thó, cø ®Õn t×m l·o phu.")
            TaskNote(1049, -1)
        end
        return
    end

    if (PetIsAdd() == 1 and PetGetType() > 0 and petspirit == 0) then
        if (lingchongstate ~= 0) then
            if (lingchongstate == 3) then
                SetTaskByte(Task_lingchong, 1, 4)
                Talk(1, "no", " L·o phu sÏ d¹y ng­êi c¸ch ®Ó Tu luyÖn Linh lùc, viÖc nµy kh¸ gian nan, cÇn ®Õn V¹n Tiªn trËn thu phôc yªu ma, lÊy ®­îc §¹i §Şa Nh·n, Hoµn Quan Nh·n, LiÖt DiÖm Nh·n, Phong B¹o Nh·n, hoÆc cã thÓ vµo Kú Tr©n C¸c mua MËt b¶o Tô Linh Ch©u cho Linh thó ¨n míi cã thÓ t¨ng linh lùc. Sau khi Linh thó t¨ng tr­ëng linh lùc, th× quay l¹i t×m ta.")
                TaskNote(1049, 0)
            end
        else
            SetTaskByte(Task_lingchong, 1, 4)
            Talk(1, "no", " L·o phu sÏ d¹y ng­êi c¸ch ®Ó Tu luyÖn Linh lùc, viÖc nµy kh¸ gian nan, cÇn ®Õn V¹n Tiªn trËn thu phôc yªu ma, lÊy ®­îc §¹i §Şa Nh·n, Hoµn Quan Nh·n, LiÖt DiÖm Nh·n, Phong B¹o Nh·n, hoÆc cã thÓ vµo Kú Tr©n C¸c mua MËt b¶o Tô Linh Ch©u cho Linh thó ¨n míi cã thÓ t¨ng linh lùc. Sau khi Linh thó t¨ng tr­ëng linh lùc, th× quay l¹i t×m ta.")
            TaskNote(1049, 0)
        end
    end

end

-- Added by liuzhiqiang at 2009-4-21 end
--add by luoyixuan
function PetReborn()
    CloseDialog()
    MsgBox("Mang ®Õn cho ta 1 Phôc Ma Linh hoÆc 9.9 tiÒn ®ång, ta cã thÓ ®¸nh thøc l¹i Linh Thó cña ng­¬i!", "Yes_Reborn", "no")
end

function Yes_Reborn()
    CloseDialog()
    local i = FindAValidIBItem(8, 414, 2, 0)
    local costName, uCost, uCostForShow
    costName, uCost, uCostForShow = GetCostCoinInfoByIdx(132)
    if (i > 0) then
        CostIBItem(i)
        PetWake()
        PetModifyStrength(360000 - PetGetStrength())
        PetModifySpirit(-PetGetSpirit())
        PetModifyProtect(-PetGetProtect() + 1)
        PetModifyTrain(-PetGetTrain() + 1)
        Msg2Player(" ®· sö dông Phôc Ma Linh, Linh thó cña b¹n ®· thøc giÊc!")
    else
        if (GetCoin() >= uCost) then
            if (CostCoinByIdx(132) == 0) then
                Talk(1, "no", 11736)
                return
            end
            PetWake()
            PetModifyStrength(360000 - PetGetStrength())
            PetModifySpirit(-PetGetSpirit())
            PetModifyProtect(-PetGetProtect() + 1)
            PetModifyTrain(-PetGetTrain() + 1)
            Msg2Player("B¹n giao cho ThÇy t­íng sè 9.9 tiÒn ®ång, Linh thó cña b¹n ®· thøc giÊc!")
        else
            Talk(1, "no", "CÇn cã Phôc Ma Linh hoÆc 9.9 tiÒn ®ång míi cã thÓ ®¸nh thøc Linh Thó.")
        end
    end
end
--add by luoyixuan
function GetPet()
    tasksPet = {
        { "NhËn nu«i", "AdoptionPet"; show = 0 },
        { "Lµm ®Ñp", "Hairdresspet"; show = 0 },
        { "BiÕn h×nh", "PetHairChange"; show = 0 },
        { "Giíi thiÖu", "PetIntroduction"; show = 1 },
    }
    if (PetIsAdd() == 0) then
        tasksPet[1].show = 1;
    else
        tasksPet[2].show = 1;
    end ;

    if (GetTask(1167) > 0) then
        tasksPet[3].show = 1;
    end

    SayTask(14499, tasksPet)
end

function PetIntroduction()
    local tasksPetIntro = {
        { "Cho ¨n", "FeedPet"; show = 1 },
        { "B¶n lÜnh", "PetSkill"; show = 1 },
        { "Tr¹ng th¸i", "PetStatus"; show = 0 },
        { "Lµm ®Ñp", "PetAppearance"; show = 1 },
        { "BiÕn h×nh", "PetChange"; show = 0 },
        { "Linh NguyÖn", "PetHope"; show = 0 },
    }
    SayTask(14500, tasksPetIntro)
end
function FeedPet()
    CloseDialog()
    Talk(1, "FeedPet1", 14501)
end
function FeedPet1()
    CloseDialog()
    Talk(2, "PetIntroduction", 14502, "<c=g>[Cho ¨n]<c><enter><c=y>Lôc §¹o<c> vµ <c=y>Tø Tinh<c> cã thÓ ®Õn chç <c=g>Xİch Tïng Tö<c> dïng nguyªn liÖu Lôc §¹o hoÆc Tø T­îng ®Ó hîp thµnh. <c=y>Ph¸c Ngäc, Tô Linh Ch©u<c> cã thÓ mua ë <c=g>Kú Tr©n C¸c<c>.")
end

function PetSkill()
    CloseDialog()
    Talk(2, "PetSkill1", 14503, "<c=g>[Tù nu«i]<c><enter>Sau khi më, khi ®iÓm søc kháe cña Linh Thó thÊp h¬n 40, sÏ tù ®éng khÊu trõ thøc ¨n cña ng­êi ch¬i trong hµnh trang, ®Ó nu«i Linh Thó.")
end

function PetSkill1()
    CloseDialog()
    Talk(1, "PetSkill2", 14504)
end

function PetSkill2()
    CloseDialog()
    Talk(1, "PetSkill3", "<c=g>[T¸n gÉu]<c><enter><c=yel>T¸n gÉu<c>: Online <c=g>15 giê<c> sÏ më. Linh Thó sÏ cïng nãi chuyÖn víi chñ nh©n, gióp chñ nh©n cã thªm ng­êi b¹n ®ång hµnh trong lóc tu luyÖn, ®ång thêi khi BOSS xuÊt hiÖn vµ V¹n Tiªn TrËn më, còng sÏ nh¾c nhë chñ nh©n.")
end
function PetSkill3()
    CloseDialog()
    Talk(1, "PetSkill4", "<c=g>[NhÆt vËt phÈm]<c><enter><c=yel>NhÆt vËt phÈm<c>: Online <c=g>20 giê<c> sÏ më. Linh Thó sÏ tù ®éng gióp chñ nh©n nhÆt c¸c vËt phÈm qu¸i r¬i ra. Th«ng qua thiÕt lËp nhÆt vËt phÈm trong giao diÖn Linh Thó, sÏ chØ nhËn nh÷ng vËt phÈm mµ chñ nh©n muèn nhÆt.")
end

function PetSkill4()
    CloseDialog()
    Talk(1, "PetSkill5", "<c=g>[Thanh lı vËt phÈm]<c><enter><c=yel>Thanh lı vËt phÈm<c>: Online <c=g>25 giê<c> sÏ më. Linh Thó sÏ tù ®éng gióp chñ nh©n b¸n c¸c trang bŞ, vËt phÈm kh«ng cÇn thiÕt. Th«ng qua thiÕt lËp Thanh lı vËt phÈm trong giao diÖn Linh Thó, sÏ chØ gi÷ l¹i vËt phÈm tèt cho chñ nh©n!")
end

function PetSkill5()
    CloseDialog()
    Talk(1, "PetSkill6", "<c=g>[Phôc håi linh lùc]<c><enter><c=yel>Phôc håi linh lùc<c>: Online <c=g>30 giê<c> sÏ më. Khi ®é cøng trang bŞ gi¶m xuèng cßn 5, Linh Thó sÏ tù ®éng gióp chñ nh©n phôc håi, gióp trang bŞ kh«ng h­ h¹i!")
end

function PetSkill6()
    CloseDialog()
    Talk(1, "PetSkill7", 14505, "<c=g>[Linh Nh·n]<c><enter><c=yel>Linh Nh·n<c>: Khi Linh lùc ®¹t <c=g>150<c> sÏ häc ®­îc kü n¨ng nµy. Linh Thó cã thÓ gióp chñ nh©n xem ®iÓm sinh lùc cña ng­êi ch¬i kh¸c, ®iÒu nµy rÊt h÷u hiÖu khi chñ nh©n PK víi ng­êi kh¸c!")
end

function PetSkill7()
    CloseDialog()
    Talk(3, "PetIntroduction", 14506, 14507, 14508)
end

function PetStatus()
    CloseDialog()
    Talk(1, "PetStatus1", 14507)
end

function PetStatus1()
    CloseDialog()
    Talk(1, "PetIntroduction", 14508)
end

function PetAppearance()
    CloseDialog()
    Talk(1, "PetAppearance1", 14509)
end

function PetAppearance1()
    CloseDialog()
    Talk(1, "PetChange", 14510)
end

function PetChange()
    CloseDialog()
    Talk(1, "PetIntroduction", 14511)
end

function PetHope()
    CloseDialog()
    Talk(1, "PetIntroduction", 14512)
end

function AdoptionPet()
    if (PetIsAdd() == 1) then
        Talk(1, "no", 14513)
    else
        MsgBox(14514, "lingyang", "no")
    end

end
function lingyang()
    if (GetCash() >= 1000000) then
        if (GetIBBuffTimes(418) >= 30) then
            Pay(1000000)
            RemoveIBBuff(418)
            PetAdd()
            Msg2Player("B¹n nhËn ®­îc 1 trøng linh thó!")
            Talk(1, "no", 14515)---¸ø³èÎïµ°£¬µ¯³öF3Ãæ°å

        else
            Talk(1, "no", 14516)
        end
    else
        Talk(1, "no", 14517)
    end
end

function Hairdresspet()
    local ChangePetAppearance = {
        "Lôc Phi Phi/ChangePetApp",
        "TuyÕt Linh Thö/ChangePetApp",
        --"Ğ¥ÌìÈ®/ChangePetAppChangePetApp",
        --"ÓñÍÃ/ChangePetApp",
        --"´ó¶ú¶ä/ChangePetApp",
        --"À¶¾«Áé/ChangePetApp",
        --"·ï»Ë/ChangePetApp",
    }
    if (PetIsAdd() == 0) then
        Talk(1, "no", 14518)
    elseif (PetIsAdd() == 1 and PetGetType() == 0) then
        Talk(1, "no", 14519)
    else
        Say(14520, getn(ChangePetAppearance), ChangePetAppearance)
    end
end

function ChangePetApp(n1)
    local n = n1 + 1
    if (PetIsAdd() == 0) then
        Talk(1, "no", 14521)
    elseif (PetIsSleep() == 1) then
        Msg2Player("Linh thó ®ang ngñ, kh«ng thÓ biÕn h×nh!")
        Talk(1, "no", 14522)
    else

        if (HaveNormalItem(3, 100, 0, 0) < 20) then
            Talk(1, "no", 14523)

        elseif (n == 1) then
            if (PetGetType() == 1) then
                Talk(1, "no", 14524)
            else
                for i = 1, 20 do
                    DelNormalItem(3, 100, 0, 0)
                end
                if (PetGetType() == 2) then
                    SetTask(1167, SetBit(GetTask(1167), 2, 1))
                end
                PetSetType(n)
                SetTask(1167, SetBit(GetTask(1167), 1, 1))
                Msg2Player("Linh thó ®· biÕn thµnh Lôc Phi Phi")
                Talk(1, "no", 14525)    --±äÂÌ·É·É
            end

        elseif (n == 2) then
            if (PetGetType() == 2) then
                Talk(1, "no", 14526)
            else
                for i = 1, 20 do
                    DelNormalItem(3, 100, 0, 0)
                end
                PetSetType(n)
                SetTask(1167, SetBit(GetTask(1167), 2, 1))
                Msg2Player("Linh thó ®· biÕn thµnh TuyÕt Linh Thö.")
                Talk(1, "no", 14527)    --±äÑ©ÁéÊó
            end
        elseif (n == 3) then
            if (PetGetType() == 3) then
                Talk(1, "no", 14528)
            else
                for i = 1, 20 do
                    DelNormalItem(3, 100, 0, 0)
                end
                if (PetGetType() == 2) then
                    SetTask(1167, SetBit(GetTask(1167), 2, 1))
                end
                PetSetType(n)
                SetTask(1167, SetBit(GetTask(1167), 3, 1))
                Msg2Player("Linh thó ®· biÕn thµnh TiÕu Thiªn KhuyÓn")
                Talk(1, "no", 14529)    --±äÏôÌìÈ®
            end
        elseif (n == 4) then
            if (PetGetType() == 4) then
                Talk(1, "no", 14530)
            else
                for i = 1, 20 do
                    DelNormalItem(3, 100, 0, 0)
                end
                if (PetGetType() == 2) then
                    SetTask(1167, SetBit(GetTask(1167), 2, 1))
                end
                PetSetType(n)
                SetTask(1167, SetBit(GetTask(1167), 4, 1))
                Msg2Player("Linh thó ®· biÕn thµnh Ngäc Thè")
                Talk(1, "no", 14531)        --±äÍÃ
            end
        elseif (n == 5) then
            if (PetGetType() == 5) then
                Talk(1, "no", 14532)
            else
                for i = 1, 20 do
                    DelNormalItem(3, 100, 0, 0)
                end
                if (PetGetType() == 2) then
                    SetTask(1167, SetBit(GetTask(1167), 2, 1))
                end
                PetSetType(n)
                SetTask(1167, SetBit(GetTask(1167), 5, 1))
                Msg2Player("Linh thó ®· biÕn thµnh §¹i NhÜ")
                Talk(1, "no", 14533)
            end
        elseif (n == 6) then
            if (PetGetType() == 6) then
                Talk(1, "no", 14534)
            else
                for i = 1, 20 do
                    DelNormalItem(3, 100, 0, 0)
                end
                if (PetGetType() == 2) then
                    SetTask(1167, SetBit(GetTask(1167), 2, 1))
                end
                PetSetType(n)
                SetTask(1167, SetBit(GetTask(1167), 6, 1))
                Msg2Player("Linh thó ®· biÕn thµnh Lam Tinh Linh")
                Talk(1, "no", 14535)
            end
        elseif (n == 7) then
            if (PetGetType() == 7) then
                Talk(1, "no", 14536)
            else
                for i = 1, 20 do
                    DelNormalItem(3, 100, 0, 0)
                end
                if (PetGetType() == 2) then
                    SetTask(1167, SetBit(GetTask(1167), 2, 1))
                end
                PetSetType(n)
                SetTask(1167, SetBit(GetTask(1167), 7, 1))
                Msg2Player("Linh thó ®· biÕn thµnh Ph­îng Hoµng")
                Talk(1, "no", 14537)
            end
        else
            Talk(1, "no", 14538)
        end
    end
end

function PetHairChange()

    if (PetIsAdd() == 0) then
        CloseDialog()
        Talk(1, "no", "Ng¹i qu¸! B¹n hiÖn ch­a cã thó nu«i nµo, kh«ng thÓ biÕn th©n cho thó nu«i cña b¹n ®­îc!")
        return
    end

    local petTy = PetGetType()
    if (petTy >= 3) and (GetTaskBit(1167, petTy) == 0) then
        SetTaskBit(1167, petTy, 1)
    end

    local list = {}
    local j = 1

    for i = 1, 12 do
        if (GetBit(GetTask(1167), i) == 1) then
            list[j] = Task_Pet_name[i] .. "/PetHairReSet"
            j = j + 1
        end
    end

    --add by lisuhui 2009.09.23 begin for ĞÂ³èÎï
    local newPetName = {
        [1] = "§Ëu §Ëu Hå",
        [2] = "Tinh Minh Quy",
        [3] = "Tra Tra §iÓu",
        [4] = "Rång ®æi mµu",
    }
    for i = 13, 20 do
        SetTask(1167, SetBit(GetTask(1167), i, 0))
    end

    local nPetKind = CheckPetKind()
    local nVariation = GetPetVariation()
    if (nPetKind > 0) then
        list[j] = newPetName[nPetKind] .. "/PetHairReSet"
        SetTask(1167, SetBit(GetTask(1167), 13 + 2 * (nPetKind - 1) + nVariation, 1))
    end
    --add by lisuhui 2009.09.23 end

    Say(14539, getn(list), list)
end

function PetHairReSet(nIndex)
    if (GetCash() >= 500000) then
        local name = ""
        local j = 0
        local nID = 0

        for i = 1, getn(Task_Pet_name) do
            if (GetBit(GetTask(1167), i) == 1) then
                j = j + 1
            end

            if (j == nIndex + 1) then
                name = Task_Pet_name[i]
                nID = i
                break
            end
        end

        if (PetGetType() == nID) then
            Talk(1, "no", "Linh thó ®· biÕn thµnh <c=g>" .. name .. "<c>, kh«ng thÓ biÕn h×nh n÷a!")
        elseif (PetIsSleep() == 1) then
            Msg2Player("Linh thó ®ang ngñ, kh«ng thÓ biÕn h×nh!")
            Talk(1, "no", 14522)
        else
            Pay(500000)
            PetSetType(nID)
            SetTask(1167, SetBit(GetTask(1167), nID, 1))
            Msg2Player("Linh thó ®· biÕn thµnh" .. name)
            Talk(1, "no", "Linh thó ®· biÕn thµnh <c=g>" .. name .. "<c> xanh nµo!")
        end
    else
        Talk(1, "no", 14540)
    end
end
-----------------------------------------------------------------------------------------------------
function renwu1()

    UTask_world_1 = GetTask(91)
    if (UTask_world_1 == 3) then
        if (HaveNormalItem(6, 1, 12, 1) < 1) then
            Talk(1, "no", 14541)
            return
        end

        DelNormalItem(6, 1, 12, 1)
        Talk(5, "no", 10098, 10099, 10100, 10101, 10102)
        SetTask(91, 4)
        --AddOwnExp(30000)
        AddOwnExp(10000)
        Msg2Player("NhËn ®­îc 10000 kinh nghiÖm")
        TopMessage(14542)
        --AS GaoJingwei 090730
        SetSubTask(25, -1, 1)
        --AE GaoJingwei 090730
        TaskNote(25, -1)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728

    end ;
    if (UTask_world_1 == 1) then
        Talk(3, "no", 10103, 10104, 10105)
        SetTask(91, 2)
        Msg2Player("Th× ra Tèng DŞ nh©n ®ang ®­îc vËn may nµy, nãi cho «ng ta biÕt? Hay lµ......")
        TaskNote(25, 1)
        --AS GaoJingwei 090728
        refreshNpcTaskState()
        --AE GaoJingwei 090728

    end ;
end;

function no()
    CloseDialog()
end;

function bs()
    Say(10106, 3, "Hoµng Kim Cù Nh©n/m1", "ThiÕt Thè/m2", "Anh Vò/m3")
end;

function m1()
    local skill, type = GetCreatureInfo()
    if (type < 0) then
        Talk(1, "no", 10107)
    else
        if (GetCash() >= 9000) then
            Pay(9000)
            SetCreatureType(skill, 359)
            CloseDialog()
        else
            Talk(1, "no", 10108)
        end ;
    end ;
end;

function m2()
    local skill, type = GetCreatureInfo()
    if (type < 0) then
        Talk(1, "no", 10107)
    else
        if (GetCash() >= 9000) then
            Pay(9000)
            SetCreatureType(skill, 408)
            CloseDialog()
        else
            Talk(1, "no", 10108)
        end ;
    end ;
end;

function m3()
    local skill, type = GetCreatureInfo()
    if (type < 0) then
        Talk(1, "no", 10107)
    else
        if (GetCash() >= 9000) then
            Pay(9000)
            SetCreatureType(skill, 409)
            CloseDialog()
        else
            Talk(1, "no", 10108)
        end ;
    end ;
end;

--------------------------------------------------------------------------------------------
--author: yaoxin
--date: 2007/6/29
--1021 1=ÈÎÎñÊ±¼äÒ²ÊÇÃâ·ÑµÄ´ÎÊı£¬ 2=ÊÕ·Ñ´ÎÊı (6,7,8bit¼ÇÂ¼Ê¹ÓÃ¶îÍâ´ÎÊı),3=¶Ò»»ÔªËØÖ®ĞÄµÄÊ±¼ä
--1022 1=¹ÖÎïµØÍ¼ºÅ 2=´ò¹Ö¸öÊı  3=ÃÔ¹¬Ñ¡Ôñ£¨ÍÁ£¬»ğ£¬·ç£¬º££©
--1023 ÁéÏ¬Öµ
--1024 µÃ¼¼ÄÜµÃĞÒÔË¸ÅÂÊ
--1186 --µÃÔªËØÖ®ĞÄµÄĞÒÔËÖµ

exp_jiangli = { 1000, 2000, 3000, 4000, 6000 }
--level_add = {50, 50, 30, 30, 25}--Ç§·ÖÖ®Ò»
task_time = { "Duy tr× trong 10 phót", "Duy tr× trong 8 phót", "Duy tr× 6 phót" }
task_lingxi = { 10, 5 }--³õÊ¼¸ÅÂÊÎª1%£¬Ã¿¶àÍê³ÉÒ»´ÎÈÎÎñ£¬Èç¹ûÃ»ÓĞ»ñµÃ¸ÃÎïÆ·£¬Ôò¸ÅÂÊÔö³¤0.5%
task_sel = 300    --×ÔÑ¡ÃÔ¹¬µÄ·§Öµ
task_yuansu = {
    [1] = { 200, 30, 3 }, --ÁéÏ¬Öµ·§Öµ,³õÊ¼´¥·¢¸ÅÂÊ,´¥·¢¸ÅÂÊÌá¸ß(Ç§·ÖÖ®Ò»)
    [2] = { 450, 70, 3 },
}
map_idx = {
    [1] = { 22, 23, 24, 25, 26, { 331, 326, 327, 328 }, "Sa m¹c" }, --tu
    [2] = { 27, 28, 29, 30, 31, { 351, 342, 343, 344 }, "Hiªn Viªn §éng" }, --huo
    [3] = { 32, 33, 34, 35, 36, { 352, 345, 346, 347 }, "B¨ng Xuyªn" }, --bing
    [4] = { 37, 38, 39, 40, 41, { 353, 348, 349, 350 }, "§«ng H¶i" }, --hai
}
mapname = {
    [0] = "Mª Cung", --²âÊÔ
    [22] = "Hoang m¹c",
    [23] = "Thæ Thµnh",
    [24] = "Phong Than",
    [25] = "Lôc Ch©u",
    [26] = "Sa M¹c chÕt",
    [27] = "Hiªn Viªn tÇng 1",
    [28] = "Hiªn Viªn tÇng 2",
    [29] = "Hiªn Viªn tÇng 3",
    [30] = "Hiªn Viªn tÇng 4",
    [31] = "Hiªn Viªn tÇng 5",
    [32] = "Ngäc TuyÒn",
    [33] = "TuyÕt Cèc",
    [34] = "§¹i Phong",
    [35] = "§¹i Th¹ch",
    [36] = "B¨ng Xuyªn Cùc",
    [37] = "Thñy Vùc",
    [38] = "Long Cung",
    [39] = "H¶i C©u",
    [40] = "Long Vùc",
    [41] = "Long Uyªn",
}
function into_sxlx()
    Talk(3, "no", 11940, " Muèn gi¶i cøu c¸c Tø Tinh cÇn ph¶i më <c=g>Linh Tª m«n<c>, vµo ma giíi cña ma v­¬ng tiªu diÖt hÕt bän l©u la, míi cã c¬ héi gi¶i tho¸t Tø Tinh. Më Linh Tª m«n ph¶i dïng 1 <c=yel>Tha S¬n Th¹ch vµ l­îng lín b¹c.", "Linh Tª m«n chØ duy tr× trong thêi gian nhÊt ®Şnh, B¹n cã thÓ lµm theo chØ dÉn vµ khiªu chiÕn yªu ma trong 5 tÇng Mª Cung. §¼ng cÊp nguyªn linh ®­îc phãng thİch cµng cao, phÇn th­ëng ng­¬i nhËn ®­îc cµng nhiÒu. Mçi ngµy Linh Tª m«n chØ më 1 lÇn nh­ng cã <c=yel>ch×a khãa Linh Tª<c> sÏ gióp ng­¬i më Linh Tª m«n ®­îc nhiÒu lÇn h¬n!")
end

function renwu2()
    if (GetLevel() < 65) then
        CloseDialog()
        return 0
    end

    local key = tongguanjiangli()
    local temp = GetTaskByte(1021, 2) + 1
    local times, addtimes = todayfreetimes(temp)
    local thisday = mod(floor(LocalSystemTime() / 86400), 256)
    local lastday = GetTaskByte(1021, 1)
    local alltimes = GetTaskByte(1477, 3)

    if (key > 0) then
        --½»ÈÎÎñ
        if (key == 2) then
            MsgBox(11941, "jiangli", "no")
        else
            local w_map = mapname[GetTaskByte(1022, 1)]
            Talk(1, "no", "Linh Tª m«n chØ më trong thêi gian nhÊt ®Şnh! HiÖn ng­¬i cÇn ®i <c=r>" .. w_map .. "<c>, tiªu diÖt c¸c qu¸i vËt xung quanh, gi¶i tho¸t c¸c nguyªn linh bŞ chóng giam gi÷!")
        end
    elseif (times >= 4 and alltimes < addtimes) and (thisday == lastday) then
        --²»ÄÜÔÙ×ö
        Talk(1, "no", 11942)
        TaskNote(54, -1)
        SyncBibleState(54, 3, 1)
        refreshNpcTaskState()
        -- Modified By Zhang Jin for Ë«±¶¾­ÑéÓÅ»¯ at 2010-04-19 Begin
    else
        local taskDay = GetWeekDay()
        if (GetGlobalValueByte(G_Double, 1) == 0) then
            -- ·ÇÈÎÎñÖÜ½«ÈÎÎñ±äÁ¿ÇåÁã
            SetTask(Double_Optimization, 0)
        end
        if (GetGlobalValueByte(G_Double, 1) == 1 and taskDay > GetTaskByte(Double_Optimization, 3)) then
            SetTaskByte(Double_Optimization, 3, 0) -- ÈÎÎñÖÜ£ºÃ¿Ìì½ÓÈÎÎñÊ±±£Ö¤½«¸Ã×Ö½ÚÇåÁã
        end

        if (GetGlobalValueByte(G_Double, 1) == 1 and GetTaskByte(Double_Optimization, 4) ~= taskDay and GetTaskByte(Double_Optimization, 1) < GetTaskByte(Double_Optimization, 2)) then
            MsgBox(" Ng­¬i tuÇn nµy cã <c=g>" .. GetTaskByte(Double_Optimization, 2) .. "<c> ngµy cã thÓ nh©n ®«i kinh nghiÖm, ®· hÕt <c=g>" .. GetTaskByte(Double_Optimization, 1) .. "<c> ngµy. <c=r>H«m nay b¹n cã muèn nhËn phÇn th­ëng nh©n ®«i kh«ng?<c>", "Yes_AcceptDouble", "No_AcceptDouble")
            return 0
        end

        Accept_renwu2()
    end
    -- Modified By Zhang Jin for Ë«±¶¾­ÑéÓÅ»¯ at 2010-04-19 End
end

-- Add By Zhang Jin for Ë«±¶¾­ÑéÓÅ»¯ at 2010-04-19 Begin
function No_AcceptDouble()
    Talk(1, "Accept_renwu2", " NÕu ng­¬i kh«ng nhËn phÇn th­ëng nh©n ®«i tuÇn nµy, th× phÇn th­ëng nh©n ®«i cña ng­¬i sÏ tù ®éng mÊt ®i!")
end

function Yes_AcceptDouble()
    local nTimes = GetTaskByte(Double_Optimization, 1)
    local taskDay = GetWeekDay()

    SetTaskByte(Double_Optimization, 1, nTimes + 1)
    SetTaskByte(Double_Optimization, 3, taskDay) -- ÁìÈ¡ÁËË«±¶½±ÀøÈÎÎñ
    Accept_renwu2()
    AddGlobalCountNews(GetName() .. " gi¶i cøu v« sè Tinh Linh, ®­îc ThÇy t­íng sè tÆng cho phÇn th­ëng nh©n ®«i kinh nghiÖm! Xin chóc mõng!", 1)
end

function Accept_renwu2()
    CloseDialog()
    local key = tongguanjiangli()
    local temp = GetTaskByte(1021, 2) + 1
    local times, addtimes = todayfreetimes(temp)
    local thisday = mod(floor(LocalSystemTime() / 86400), 256)
    local lastday = GetTaskByte(1021, 1)
    local alltimes = GetTaskByte(1477, 3)

    local taskDay = GetWeekDay()
    SetTaskByte(Double_Optimization, 4, taskDay) -- ÌáÊ¾ÊÇ·ñÁìÈ¡½±Àø
    if (GetTask(1023) > task_sel) then
        local task1 = {
            "Sa m¹c/item_maze",
            "Hiªn Viªn §éng/item_maze",
            "B¨ng Xuyªn/item_maze",
            "§«ng H¶i/item_maze",
        }
        Say(" Sau khi hoµn thµnh <c=g>" .. task_sel .. "<c>, b¹n cã thÓ tïy ı chän nhiÖm vô", 4, task1)
    else
        local pm = payMoney()
        if (thisday ~= lastday) then
            --½ÓÈÎÎñµÄÊ±ºò
            MsgBox(" §ång ı ®­a ta 1 <c=g>Tha S¬n Th¹ch<c> vµ " .. pm .. " b¹c ®Ó ®i gi¶i cøu cho nguyªn linh chø?", "yiqiBuff_1", "no")
        else
            --¿ªÊ¼ÊÕ·Ñ
            local pm_free = payMoneyfree(addtimes)
            local task = {
                { "N¹pTµiTuLuyÖn", "yiqiBuff_3"; show = 0 },
                { "Ch×a khãa Linh Tª", "coin_renwu"; show = 0 },
            }
            if (alltimes >= addtimes) then
                task[1].show = 1
            else
                coin_renwu()
                return 0
            end

            if (times <= 5) then
                task[2].show = 1
            end
            SayTask("HiÖn t¹i ng­êi tæng céng" .. (alltimes - addtimes + 1) .. "LÇn, nhiÒu h¬n quy ®Şnh. NÕu cã" .. pm_free .. "TiÒn vµng, lµ cã thÓ nhËn thªm sè lÇn nhiÖm vô, nhiÖm vô nµy kh«ng tİnh vµo chi tiÕt thu phİ. NhÊn chän n¹p tµi tu luyÖn nhËn ­u ®·i dßng nµy, ®­¬ng nhiªn nh»m ®Ó më Linh tª m«n 1 <c=g>S¬n th¹ch<c> vµ" .. pm .. "TiÒn vµng còng lµ thø kh«ng thÓ thiÕu råi.", task)
        end ;
    end
end
-- Add By Zhang Jin for Ë«±¶¾­ÑéÓÅ»¯ at 2010-04-19 End

function coin_renwu()
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(59)
    TaskNote(54, -1)
    local pm = payMoney()

    ----------------------Add by liuzhiqiang at 2009/8/14 begin -----------------------ÒåÆø
    local lastMoney = pm
    if (HaveIBBuff(767) > 0 or GetHelpScore() > 0) then
        pm = pm * 0.9
    end
    ----------------------Add by liuzhiqiang at 2009/8/14 end   -----------------------ÒåÆø

    if (HaveNormalItem(8, 329, 2, 0) >= 1) and (HaveNormalItem(3, 82, 0, 0) >= 1) and (GetCash() >= pm) then
        MsgBox("Ph¸p lùc cña ta cã h¹n, kh«ng thÓ më cöa thø hai cña Linh Tª m«n, trõ khi cã <c=g>Tha S¬n Th¹ch<c> vµ" .. lastMoney .. ", nÕu cã <c=yel>Ch×a khãa Linh Tª<c>, ta cã thÓ gióp ng­¬i!", "yiqiBuff_2", "no")
    elseif (GetCoin() >= Cv) and (HaveNormalItem(3, 82, 0, 0) >= 1) and (GetCash() >= pm) then
        MsgBox("Ph¸p lùc cña ta cã h¹n, kh«ng thÓ më cöa thø hai cña Linh Tª m«n, trõ khi cã <c=g>Tha S¬n Th¹ch<c> vµ" .. lastMoney .. ", nÕu cã <c=yel>Ch×a khãa Linh Tª<c>, ta cã thÓ gióp ng­¬i, chØ cÇn phİ dông <c=yel>" .. Cfs .. "TiÒn ®ång<c>, ta sÏ dïng ch×a khãa thÇn bİ gióp ng­¬i!", "yiqiBuff_2", "no")
    else
        Talk(1, "no", "Muèn tiÕp tôc më Linh Tª m«n cÇn cã <c=g>Tha S¬n Th¹ch<c> vµ" .. lastMoney .. ", ngoµi ra cÇn cã <c=yel>Ch×a khãa Linh Tª hoÆc" .. Cfs .. "TiÒn ®ång<c>, chuÈn bŞ ®ñ vËt liÖu nhĞ!")
    end
end

function item_maze(nIdx)
    nIdx = nIdx + 1
    SetTaskByte(1022, 3, nIdx)
    refreshNpcTaskState()

    local thisday = mod(floor(LocalSystemTime() / 86400), 256)
    local lastday = GetTaskByte(1021, 1)
    if (thisday ~= lastday) then
        yiqiBuff_1()
    else
        local temp = GetTaskByte(1021, 2)
        local times, addtimes = todayfreetimes(temp)
        local alltimes = GetTaskByte(1477, 3)
        local pm_free = payMoneyfree(addtimes)
        local pm = payMoney()
        local task = {
            { "N¹pTµiTuLuyÖn", "yiqiBuff_3"; show = 0 }, --modified by liuzhiqiang
            { "Ch×a khãa Linh Tª", "coin_renwu"; show = 0 },
        }
        if (alltimes >= addtimes) then
            task[1].show = 1
        else
            coin_renwu()
            return 0
        end

        if (times <= 5) then
            task[2].show = 1
        end
        SayTask("HiÖn t¹i ng­êi tæng céng" .. (alltimes - addtimes + 1) .. "LÇn, nhiÒu h¬n quy ®Şnh. NÕu cã" .. pm_free .. "TiÒn vµng, lµ cã thÓ nhËn thªm sè lÇn nhiÖm vô, nhiÖm vô nµy kh«ng tİnh vµo chi tiÕt thu phİ. NhÊn chän n¹p tµi tu luyÖn nhËn ­u ®·i dßng nµy, ®­¬ng nhiªn nh»m ®Ó më Linh tª m«n 1 <c=g>S¬n th¹ch<c> vµ" .. pm .. "TiÒn vµng còng lµ thø kh«ng thÓ thiÕu råi.", task)
    end
end

----------------------------------Add by liuzhiqiang at 2009/8/14 begin ----------------------------ÒåÆøÖµ½»»»
function yiqiBuff_1()
    CloseDialog()

    if (HaveIBBuff(767) > 0 or GetHelpScore() > 0) then
        --que
        MsgBox("Cã thÓ dïng <c=g>tr¹ng th¸i nghÜa khİ<c> hoÆc <c=g>1 ®iÓm Nh©n NghÜa<c> ®Ó tiÕt kiÖm 10% b¹c! §ång ı chø?", "costYiqi_1", "yes1")
    else
        yes1()
    end
end

function costYiqi_1()
    CloseDialog()

    if (HaveIBBuff(767) > 0 or GetHelpScore() > 0) then
        --que
        SetTaskByte(Task_Yiqi, 1, 1)
        refreshNpcTaskState()
        yes1()
    else
        Talk(1, "no", " Xin lçi! Ng­¬i kh«ng cã Tr¹ng th¸i nghÜa khİ hoÆc §iÓm nh©n nghÜa.")
    end
end

function yiqiBuff_2()
    CloseDialog()

    if (HaveIBBuff(767) > 0 or GetHelpScore() > 0) then
        --que
        MsgBox(" Ng­¬i cã thÓ dïng <c=g>tr¹ng th¸i nghÜa khİ<c> hoÆc <c=g>1 ®iÓm Nh©n NghÜa<c> ®Ó tiÕt kiÖm 10% b¹c! §ång ı chø?", "costYiqi_2", "yes2")
    else
        yes2()
    end
end

function costYiqi_2()
    CloseDialog()

    if (HaveIBBuff(767) > 0 or GetHelpScore() > 0) then
        --que
        SetTaskByte(Task_Yiqi, 1, 1)
        refreshNpcTaskState()
        yes2()
    else
        Talk(1, "no", " Xin lçi! Ng­¬i kh«ng cã Tr¹ng th¸i nghÜa khİ hoÆc §iÓm nh©n nghÜa.")
    end
end

function yiqiBuff_3()
    CloseDialog()

    if (HaveIBBuff(767) > 0 or GetHelpScore() > 0) then
        --que
        MsgBox(" Ng­¬i cã thÓ dïng <c=g>tr¹ng th¸i nghÜa khİ<c> hoÆc <c=g>1 ®iÓm Nh©n NghÜa<c> ®Ó tiÕt kiÖm 10% b¹c! §ång ı chø?", "costYiqi_3", "yes_freefsb")
    else
        yes_freefsb()
    end
end

function costYiqi_3()
    CloseDialog()

    if (HaveIBBuff(767) > 0 or GetHelpScore() > 0) then
        --que
        SetTaskByte(Task_Yiqi, 1, 1)
        refreshNpcTaskState()
        yes_freefsb()
    else
        Talk(1, "no", " Xin lçi! Ng­¬i kh«ng cã Tr¹ng th¸i nghÜa khİ hoÆc §iÓm nh©n nghÜa.")
    end
end
----------------------------------Add by liuzhiqiang at 2009/8/14 end ------------------------------ÒåÆøÖµ½»»»

function yes1()
    local pm = payMoney()

    ----------------------Add by liuzhiqiang at 2009/8/14 begin -----------------------ÒåÆø
    if ((HaveIBBuff(767) > 0 or GetHelpScore() > 0) and GetTaskByte(Task_Yiqi, 1) == 1) then
        --que
        pm = pm * 0.9
    end
    ----------------------Add by liuzhiqiang at 2009/8/14 end   -----------------------ÒåÆø

    if (GetLevel() >= 65) and (HaveNormalItem(3, 82, 0, 0) >= 1) and (GetCash() >= pm) then
        if (GetIBBuffCount() >= 31) then
            Talk(1, "no", 14543)
            return 0
        end

        local temp = GetTaskByte(1021, 2) + 1
        local times, addtimes = todayfreetimes(temp)
        local thisday = mod(floor(LocalSystemTime() / 86400), 256)
        local lastday = GetTaskByte(1021, 1)
        if (thisday ~= lastday) then
            SetTaskByte(1021, 1, thisday)
            refreshNpcTaskState()
            SetTaskByte(1021, 2, 0)
            refreshNpcTaskState()
            offlineTotimes()
            times = 1
        else
            SetTaskByte(1021, 2, temp)
            refreshNpcTaskState()
            times = times + 1
        end
        ----------------------Add by liuzhiqiang at 2009/8/14 begin -----------------------ÒåÆø
        if (HaveIBBuff(767) > 0 and GetTaskByte(Task_Yiqi, 1) == 1) then
            --que
            CostIBBuff(767, 1)
            SetTaskByte(Task_Yiqi, 1, 0)
            refreshNpcTaskState()
            local change = payMoney() - pm
            WriteLog(GetName() .. "Trõ tr¹ng th¸i nghÜa khİ ®Ó hñy nhiÖm vô Tø Linh" .. change .. ".")
            Msg2Player("Trõ tr¹ng th¸i nghÜa khİ ®Ó hñy nhiÖm vô Tø Linh" .. change .. ".")
        elseif (GetHelpScore() > 0 and GetTaskByte(Task_Yiqi, 1) == 1) then
            PayHelpScore(1)
            SetTaskByte(Task_Yiqi, 1, 0)
            refreshNpcTaskState()
            local change = payMoney() - pm
            WriteLog(GetName() .. "Trõ ®iÓm Nh©n NghÜa ®Ó hñy nhiÖm vô Tø Linh" .. change .. ".")
            Msg2Player("Trõ ®iÓm Nh©n NghÜa ®Ó hñy nhiÖm vô Tø Linh" .. change .. ".")
        end
        ----------------------Add by liuzhiqiang at 2009/8/14 end   -----------------------ÒåÆø
        Pay(pm)
        DelNormalItem(3, 82, 0, 0)

        local w, mr, pl, mi, s1, t1
        if (GetTask(1023) > task_sel) then
            mr = GetTaskByte(1022, 3)
        else
            mr = random(1, 4)
            if (mr == 1) or (mr == 3) then
                mr = mr + 1
            end
        end

        local targname = ""
        targname = map_idx[mr][7]
        mi = map_idx[mr][1]--¹ÖÎïµØÍ¼
        w = mapname[mi]--mapname
        SetTaskByte(1022, 1, mi)
        refreshNpcTaskState()
        SetTaskByte(1022, 2, 0)
        refreshNpcTaskState()

        if (GetLevel() >= 100) then
            t1 = map_idx[mr][6][4]
            AddIBBuff(t1)
            s1 = task_time[3]
        elseif (GetLevel() >= 85) then
            t1 = map_idx[mr][6][3]
            AddIBBuff(t1)
            s1 = task_time[2]
        elseif (GetLevel() >= 75) then
            t1 = map_idx[mr][6][2]
            AddIBBuff(t1)
            s1 = task_time[1]
        elseif (GetLevel() >= 65) then
            t1 = map_idx[mr][6][1]
            AddIBBuff(t1)
            s1 = task_time[1]
        end

        Msg2Player("§©y lµ nhiÖm vô thø" .. times .. "lÇn nhËn nhiÖm vô Tø Linh.")
        TaskNote(54, 0, w)

        if (times <= 5) then
            SyncBibleState(54, 2, 1)
        else
            SyncBibleState(54, 3, 1)
        end ;

        Talk(1, "no", "Linh Tª m«n ®· më! LÇn nµy ng­¬i cÇn" .. w .. "phãng thİch <c=g>" .. targname .. "<c> nguyªn linh, ta sÏ ngÉu nhiªn h­íng dÉn. Ng­¬i cã thÓ gi¶i phãng cho nguyªn linh ë 5 tÇng mª cung, cøu ®­îc bao nhiªu cßn tïy vµo n¨ng lùc cña ng­¬i!")    --ÒÑ¾­ÁìÈ¡
        return 1
    else
        Talk(1, "no", "Më Linh Tª m«n cÇn cã 1 <c=g>Tha S¬n Th¹ch<c> vµ" .. pm .. ", cã ®ñ råi quay l¹i t×m ta nhĞ!")    --È±¶«Î÷
        return 0
    end
end

function yes2()
    CloseDialog()
    local _, Cv, Cfs = GetCostCoinInfoByIdx(59)
    local i = FindAValidIBItem(8, 329, 2, 0)
    if (i ~= 0) then
        if (yes1() ~= 1) then
            return 0
        end

        CostIBItem(i)
        Msg2Player("Nép ch×a khãa Linh Tª cho ThÇy t­íng sè, nhËn 1 lÇn nhiÖm vô Tø Linh")
        --local strMsg = "ËãÃüÏÈÉú»ØÊÕÒ»¸ö"
        --	WriteLog(strMsg)
    elseif (GetCoin() >= Cv) then
        if (yes1() ~= 1) then
            return 0
        end

        CostCoinByIdx(59)
        EventTopConsume:AddConsumeValue(Cfs, "NhiÖm Vô TuÇn Hoµn")
        Msg2Player("B¹n ®· tÆng cho ¢n Hång" .. Cfs .. " TiÒn ®ång cho ThÇy t­íng sè, nhËn 1 lÇn nhiÖm vô Tø Linh.")
    else
        Talk(1, "no", "Muèn tiÕp tôc më Linh Tª m«n cÇn cã <c=g>ch×a khãa Linh Tª<c> hoÆc <c=g>" .. Cfs .. "<c>®ñ tiÒn ®ång h·y ®Õn t×m ta.")    --tb¿Û³ıÊ§°Ü
    end
end

function payMoney()
    local m = 50000
    if (GetLevel() > 74) then
        m = m + floor((GetLevel() - 65) / 10) * 50000
        --	m = min(m,600000)
    end
    return m
end

function tongguanjiangli()
    for i = 1, 4 do
        for j = 1, 5 do
            if (GetIBBuffTimes(300 + i * 5 + j) > 0) then
                return 2
            end
        end
    end

    local nkey = 0
    if (HaveIBBuff(326) > 0) or (HaveIBBuff(327) > 0) or (HaveIBBuff(328) > 0) or (HaveIBBuff(331) > 0) then
        nkey = 1
    else
        for k = 1, 12 do
            if (HaveIBBuff(341 + k) > 0) then
                nkey = 1
                break ;
            end
        end
    end

    return nkey
end

function jiangli()
    CloseDialog()
    if (tongguanjiangli() == 2) then
        local nLuckyNum = GetTask(1024)
        local rluck = random(1, 1000)
        local lingxi = GetTask(1023) + 1
        SetTask(1023, lingxi)
        refreshNpcTaskState()

        local expl = 0
        local mapidx = 0
        for i = 1, 4 do
            for j = 1, 5 do
                if (GetIBBuffTimes(300 + i * 5 + j) > 0) then
                    CostIBBuff(300 + i * 5 + j, 1)
                    expl = GetLevel() * exp_jiangli[j]
                    if (j == 5) then
                        mapidx = i
                    end
                    break ;
                end
            end
            if (expl > 0) then
                break ;
            end
        end

        -- Add By Zhang Jin for Ë«±¶¾­ÑéÓÅ»¯ at 2010-04-19 Begin
        if (GetTaskByte(Double_Optimization, 3) > 0 and GetTaskByte(Double_Optimization, 3) < 8) then
            expl = expl * 2
        elseif (GetTaskByte(Double_Optimization, 3) >= 8) then
            local nTemp = GetTaskByte(Double_Optimization, 3)
            nTemp = SetBit(nTemp, 6, 0)
            SetTaskByte(Double_Optimization, 3, nTemp)
        end
        -- Add By Zhang Jin for Ë«±¶¾­ÑéÓÅ»¯ at 2010-04-19 End

        if (expl == 0) then
            Talk(1, "no", 11943)
            return 0
        end

        RemoveIBBuff(326)
        RemoveIBBuff(327)
        RemoveIBBuff(328)
        RemoveIBBuff(331)
        SetTaskWord(1022, 2, 0)--log¸Ä°æ

        for k = 1, 12 do
            RemoveIBBuff(341 + k)
        end

        -----------------------------------
        --³èÎï»î¶¯
        if (PetIsAdd() == 0) and (GetIBBuffTimes(418) < 30) then
            local pr = random(1, 5)
            if (pr == 5) then
                AddIBBuff(418)
                AddIBBuff(418)

                -- Added by liuzhiqiang at 2009-4-21 Begin
                if (GetIBBuffTimes(418) == 2) then
                    TopMessage("ThÇy t­íng sè t¹i TriÒu Ca cã viÖc cÇn nhê, h·y ®i t×m «ng ta!")
                else
                    TopMessage(14422)
                end

                if (GetIBBuffTimes(418) > 0 and GetIBBuffTimes(418) < 30) then
                    TaskNote(1048, 0, GetIBBuffTimes(418))
                end

                if (GetIBBuffTimes(418) >= 30) then
                    TaskNote(1048, 1)
                end

                SetTaskByte(Task_lingchong, 3, 1)
                refreshNpcTaskState()
                -- Added by liuzhiqiang at 2009-4-21 end

                Msg2Player("B¹n nhËn ®­îc 2 Linh NguyÖn,ThÇy t­íng sè TriÒu Ca sÏ cho b¹n biÕt ®iÒu thÇn kú cña nã!")
                Msg2Player("Khi ®iÓm Linh nguyÖn cña b¹n kh«ng d­íi 30 Linh nguyÖn, cã thÓ ®Õn TriÒu Ca gÆp ThÇy t­íng sè nhËn Thó nu«i!")

            else
                AddIBBuff(418)

                -- Added by liuzhiqiang at 2009-4-21 Begin
                if (GetIBBuffTimes(418) == 1) then
                    TopMessage("ThÇy t­íng sè t¹i TriÒu Ca cã viÖc cÇn nhê, h·y ®i t×m «ng ta!")
                else
                    TopMessage(14423)
                end

                if (GetIBBuffTimes(418) > 0 and GetIBBuffTimes(418) < 30) then
                    TaskNote(1048, 0, GetIBBuffTimes(418))
                end

                if (GetIBBuffTimes(418) >= 30) then
                    TaskNote(1048, 1)
                end

                SetTaskByte(Task_lingchong, 3, 1)
                refreshNpcTaskState()
                -- Added by liuzhiqiang at 2009-4-21 end

                Msg2Player("B¹n nhËn ®­îc Linh NguyÖn,ThÇy t­íng sè TriÒu Ca sÏ cho b¹n biÕt ®iÒu thÇn kú cña nã!")
                Msg2Player("Khi ®iÓm Linh nguyÖn cña b¹n kh«ng d­íi 30 Linh nguyÖn, cã thÓ ®Õn TriÒu Ca gÆp ThÇy t­íng sè nhËn Thó nu«i!")

            end

        end
        ------------------------------------

        ------------------------------------
        --100¼¶Îü»êÒõÉ·
        if (GetLevel() >= 100) and (GetIBBuffTimes(426) < 24) then
            AddIBBuff(426)
            Msg2Player("B¹n nhËn ®­îc Cá May M¾n, thuyÒn phu ë  §«ng Doanh §¶o vµ Ph­¬ng Tr­îng §¶o sÏ cho b¹n biÕt sù kú diÖu cña nã")
        end
        ---------------------------------------

        AddOwnExp(expl)
        TaskNote(54, -1)
        Msg2Player("B¹n nhËn ®­îc" .. expl .. "§iÓm kinh nghiÖm.")

        if (nLuckyNum == 0) then
            nLuckyNum = task_lingxi[1]
            SetTask(1024, nLuckyNum)
            refreshNpcTaskState()
        end

        local str1 = ""
        if (rluck <= nLuckyNum) then
            AddNormalItem(8, 330, 0, 0, 0, 0)
            SetTask(1024, task_lingxi[1])
            refreshNpcTaskState()
            Msg2Player("B¹n nhËn ®­îc 1 L©m Tiªn Lé.")
            TopMessage(11944)
            str1 = "Ngoµi ra n¬i nµy cã <c=yel>L©m Tiªn Lé<c>, gióp t¨ng 0.5 kinh nghiÖm"
            AddGlobalCountNews("<c=g>" .. GetName() .. "<c> hoµn thµnh nhiÖm vô Tø Linh nhËn ®­îc 1 <c=r>L©m Tiªn Lé<c> cña ThÇy t­íng sè!", 20)
        else
            SetTask(1024, (nLuckyNum + task_lingxi[2]))
            refreshNpcTaskState()
        end

        local nLuckyNum1 = GetTask(1186)
        local nlvl = 0
        if (lingxi >= task_yuansu[1][1]) then
            for i = getn(task_yuansu), 1, -1 do
                if (lingxi >= task_yuansu[i][1]) then
                    if (nLuckyNum1 == 0) then
                        nLuckyNum1 = task_yuansu[i][2]
                        SetTask(1186, nLuckyNum1)
                        refreshNpcTaskState()
                    end
                    nlvl = i
                    break
                end
            end
        end

        if (nlvl > 0) and (mapidx > 0) then
            rluck = random(1, 1000)
            if (rluck <= nLuckyNum1) then
                local mname = map_idx[mapidx][7]
                AddNormalItemPile(3, 199 + mapidx, 0, 0, 0, 0)
                SetTask(1186, task_yuansu[nlvl][2])
                refreshNpcTaskState()
                Msg2Player("Chóc mõng B¹n nhËn ®­îc 1 Tø T­îng Tinh Ph¸ch.")
                TopMessage(14544)
                str1 = "Ngoµi ra n¬i nµy cã <c=g>" .. mname .. "<c> Mª Cung <c=yel>Tø T­îng Tinh Ph¸ch<c>, ng­¬i ®em ®i gÆp Tø T­îng Nguyªn Tè Tr­ëng l·o trong Mª Cung, «ng ta sÏ nãi cho ng­¬i biÕt c¸ch sö dông."
                --				AddGlobalCountNews("<c=g>"..GetName().."<c>ÔÚÍê³ÉËÄÏóÁéÏ¬ÈÎÎñµÄÊ±ºò£¬ËãÃüÏÈÉúÔùÓèËûÒ»¸ö<c=r>ÔªËØÖ®ĞÄ<c>£¬×£ËûĞŞÁ¶Â·ÉÏÊÂ°ë¹¦±¶£¡",3)
            else
                SetTask(1186, (nLuckyNum1 + task_yuansu[nlvl][3]))
                refreshNpcTaskState()
            end
        end

        -- Added by zhaoqingsong at 2008-7-24 begin
        -- Õô·¢ÃÜÁîÈÎÎñ´¥·¢

        local playerLevel = GetLevel()
        local leakTaskStatus = GetByte(GetTask(TASK_ID_LEAK), 1)
        local nextFunc = "no"
        if (leakTaskStatus == 0 and playerLevel >= 73 and lingxi > 10) then
            local rand = random(1, 100)
            if (rand <= 30) then
                SetTask(TASK_ID_LEAK, SetByte(GetTask(TASK_ID_LEAK), 1, 1))
                TaskNote(TASK_INFO_ID_LEAK, 0)
                nextFunc = "leakOrderGuide"
                refreshNpcTaskState()
            end
        end

        -- Added by zhaoqingsong at 2008-7-24 end
        -- Add By Zhang Jin for Ë«±¶¾­ÑéÓÅ»¯ at 2010-04-19 Begin
        local str = ""
        local taskDay = GetWeekDay()
        local index = 6
        for i = 1, 6 do
            if (GetTask(1023) == TaskTimes[i].totalTimes) then
                index = i
                break
            end
        end

        if (GetGlobalValueByte(370, 1) == 1 and index < 6) then
            if (taskDay < 7) then
                str = "B¹n ®· më x2 kinh nghiÖm trong " .. TaskTimes[index].awardsTimes .. " ngµy, ngµy mai ®Õn nhËn nhĞ!"
            else
                str = "B¹n ®· më x2 kinh nghiÖm trong " .. TaskTimes[index].awardsTimes .. "PhÇn th­ëng nh©n ®«i kinh nghiÖm trong ngµy, ®Õn ®ît gi¶i cøu nguyªn linh tuÇn sau xin ®Õn nhËn nhĞ!"
            end
        end
        -- Add By Zhang Jin for Ë«±¶¾­ÑéÓÅ»¯ at 2010-04-19 End

        Talk(1, nextFunc, "NhiÖm vô hoµn thµnh, ng­¬i nhËn ®­îc <c=g>" .. expl .. "<c> kinh nghiÖm," .. str1 .. "Hi väng anh hïng sau nµy cã thÓ tiÕp tôc t¹o phóc cho thiªn h¹!" .. str)
    else
        Talk(1, "no", 11943)    --Ã»ÓĞÍê³ÉÈÎÎñ
    end
end

function renwu2_1()
    local tasks = {
        { "Tø T­îng Ng­ng Ph¸ch", "yuansu_1"; show = 0 },
        { "Tø t­îng tinh th¹ch", "yuansu_2"; show = 0 },
        --		{"¹ØÓÚËÄÏóÄıÆÇ","into_sxlx1";show=1}
    }
    local key = 0
    for i = 0, 3 do
        if (HaveNormalItem(3, 204 + i, 0, 0) >= 1) then
            key = key + 1
        end
    end

    if (key >= 1) then
        tasks[1].show = 1;
    end ;

    if (key >= 4) then
        tasks[2].show = 1;
    end ;

    SayTask(14545, tasks)
end

function yuansu_1()
    local task1 = {
        "Thæ Ng­ng Ph¸ch/item_yuansu",
        "Háa Ng­ng Ph¸ch/item_yuansu",
        "Phong Ng­ng Ph¸ch/item_yuansu",
        "Thñy Ng­ng Ph¸ch/item_yuansu",

    }
    local exp1 = GetLevel() * 18000
    Say("HÊp thô Linh lùc mét viªnTø T­îng Ng­ng Ph¸ch, cã thÓ gióp ng­¬i n©ng cao tu hµnh, ®¹t ®­îc <c=g>" .. exp1 .. "<c> kinh nghiÖm, ng­¬i x¸c ®Şnh hÊp thô Linh lùc cña viªn Ng­ng Ph¸ch nµy?", 4, task1)
end

function item_yuansu(n)
    local thisday = mod(floor(LocalSystemTime() / 86400), 256)
    local lastday = GetTaskByte(1021, 3)
    if (thisday ~= lastday) then
        if (HaveNormalItem(3, 204 + n, 0, 0) > 0) then
            SetTaskByte(1021, 3, thisday)
            refreshNpcTaskState()
            DelNormalItem(3, 204 + n, 0, 0)
            local exp1 = GetLevel() * 18000
            AddOwnExp(exp1)
            Msg2Player("B¹n ®· hÊp thô" .. map_idx[n + 1][7] .. " Ng­ng Ph¸ch, ®¹t ®­îc" .. exp1 .. "kinh nghiÖm")
            TopMessage("B¹n nhËn ®­îc <c=g>" .. exp1 .. "<c> ®iÓm kinh nghiÖm.")
            AddGlobalCountNews("<c=g>" .. GetName() .. "<c> ®· hÊp thô Linh lùc cña <c=r>Tø T­îng Ng­ng Ph¸ch<c>, nhËn ®­îc <c=g>" .. exp1 .. "<c> ®iÓm kinh nghiÖm.", 3)
            no()
        else
            Talk(1, "no", 14546)
        end
    else
        Talk(1, "no", 14547)
    end
end

function yuansu_2()
    local thisday = mod(floor(LocalSystemTime() / 86400), 256)
    local lastday = GetTaskByte(1021, 3)
    if (thisday ~= lastday) then
        SetTaskByte(1021, 3, thisday)
        refreshNpcTaskState()

        for i = 0, 3 do
            if (HaveNormalItem(3, 204 + i, 0, 0) == 0) then
                Talk(1, "no", 14548)
                return 0
            end
        end

        for i = 0, 3 do
            DelNormalItem(3, 204 + i, 0, 0)
            AddNormalItemPile(3, 208, 0, 0, 0, 0)
        end
        Msg2Player("LuyÖn Tø T­îng Ng­ng Ph¸ch, nhËn ®­îc 4 viªn Tø T­îng Tinh Th¹ch")
        TopMessage(14549)
        Talk(1, "no", 14550)
    else
        Talk(1, "no", 14547)
    end
end

-- Added by zhaoqingsong at 2008-7-24 begin
-- Õô·¢ÃÜÁîÈÎÎñ

-- Õô·¢ÃÜÁîÈÎÎñID
-- 1 Byte ÈÎÎñ×´Ì¬
-- 2 Byte ·¨±¦Ê¹ÓÃ´ÎÊı
TASK_ID_LEAK = 1234
TASK_INFO_ID_LEAK = 1015

-- Õô·¢ÃÜÁîµ¼º½,ËÄÏóÁéÏ¬ÈÎÎñÍê³Éºóµ¼º½
function leakOrderGuide()
    Talk(1, "main", 14551)
    refreshNpcTaskState()
end

-- ÊÇ·ñÏÔÊ¾Õô·¢ÃÜÁîÖ÷°´Å¥
function isViewLeakOrder()
    local taskStatus = GetByte(GetTask(TASK_ID_LEAK), 1)
    if (taskStatus == 1) then
        return 1
    else
        return 0
    end
end

-- ÃÜÁîÕô·¢Ö÷´¦Àíº¯Êı
function processLeakOrder()
    refreshNpcTaskState()
    local taskStatus = GetByte(GetTask(TASK_ID_LEAK), 1)
    if (taskStatus == 1) then
        SetTask(TASK_ID_LEAK, SetByte(GetTask(TASK_ID_LEAK), 1, 2))
        TaskNote(TASK_INFO_ID_LEAK, 1)
        Talk(4, "no", 14552, GetName() .. ": Xin…xin cøu ta víi…", "Theo quÎ nµy….nªn ®Õn Ngäc H­ Cung gÆp tiªn nh©n, ¾t cã c¬ duyªn", GetName() .. ":§a t¹ tiªn sinh!")
        refreshNpcTaskState()
    else
        no()
    end
end

-- Added by zhaoqingsong at 2008-7-24 end

---yaoxin Ñ­»·ÈÎÎñ¸ÄÔì, Í³¼ÆÀëÏß´ÎÊı»ıÔÜ,ÓÃÆäÊıÖµµÄµÚ6,7,8bit¼ÇÂ¼Î´Ê¹ÓÃµÄÀëÏß»ıÀÛ´ÎÊı
function offlineTotimes()
    -- modified by yaoxin for 2010-10
    local localday = floor(LocalSystemTime() / 86400)
    local lastday = GetTaskWord(1477, 1)
    local today = mod(localday, 2 ^ 16)
    if (lastday ~= today) then
        SetTask(1477, today)
        local offday = floor((GetOfflineTime() - 28800) / 86400)
        local timecha = offday
        local daytimes = 0
        for i = (localday - 1), (offday + 1), -1 do
            if (mod(i, 2 ^ 16) == lastday) then
                timecha = i
                break
            end
        end
        daytimes = localday - timecha - 1-- modified by yaoxin for 2010-12

        if (daytimes > 7) then
            daytimes = 7
        elseif (daytimes < 0) then
            daytimes = 0
        end
        SetTaskByte(1477, 3, daytimes)
        refreshNpcTaskState()
    end
end

function todayfreetimes(value)
    local free = 1
    if (value >= 2 ^ 5) then
        free = GetBit(value, 6) + 2 * GetBit(value, 7) + 4 * GetBit(value, 8) + 1
        for i = 6, 8 do
            value = SetBit(value, i, 0)
        end
    end
    return value, free
end

function payMoneyfree(nums)
    if (nums > 7) then
        nums = 7
    end
    local n_times = { 50, 50, 50, 100, 100, 100, 100 }
    local m = 60 * n_times[nums] * GetLevel() --»ùÊı6000*lv
    return m
end

function yes_freefsb()
    CloseDialog()
    local temp = GetTaskByte(1021, 2)
    local times, addtimes = todayfreetimes(temp)
    if (GetTaskByte(1477, 3) < addtimes) then
        return 0
    end

    local apm = payMoneyfree(addtimes)
    ----------------------Add by liuzhiqiang at 2009/8/14 begin -----------------------ÒåÆø
    local pm = payMoney()
    if ((HaveIBBuff(767) > 0 or GetHelpScore() > 0) and GetTaskByte(Task_Yiqi, 1) == 1) then
        --que
        pm = pm * 0.9
    end
    pm = pm + apm
    ----------------------Add by liuzhiqiang at 2009/8/14 end   -----------------------ÒåÆø
    if (GetLevel() >= 65) and (HaveNormalItem(3, 82, 0, 0) >= 1) and (GetCash() >= pm) then
        if (GetIBBuffCount() >= 31) then
            Talk(1, "no", 14543)
            return 0
        end

        local thisday = mod(floor(LocalSystemTime() / 86400), 256)
        local lastday = GetTaskByte(1021, 1)
        if (thisday ~= lastday) then
            yiqiBuff_1()
            return 1
        else
            for i = 1, 3 do
                if (GetBit(addtimes, i) == 1) then
                    temp = SetBit(temp, 5 + i, 1)
                else
                    temp = SetBit(temp, 5 + i, 0)
                end
            end
            SetTaskByte(1021, 2, temp)
            refreshNpcTaskState()
        end
        ----------------------Add by liuzhiqiang at 2009/8/14 begin -----------------------ÒåÆø
        if (HaveIBBuff(767) > 0 and GetTaskByte(Task_Yiqi, 1) == 1) then
            CostIBBuff(767, 1)
            SetTaskByte(Task_Yiqi, 1, 0)
            refreshNpcTaskState()
            local change = payMoney() + apm - pm
            WriteLog(GetName() .. "Trõ ®iÓm Nh©n NghÜa ®Ó hñy nhiÖm vô Tø Linh" .. change .. ".")
            Msg2Player("Trõ tr¹ng th¸i nghÜa khİ ®Ó hñy nhiÖm vô Tø Linh" .. change .. ".")
        elseif (GetHelpScore() > 0 and GetTaskByte(Task_Yiqi, 1) == 1) then
            PayHelpScore(1)
            SetTaskByte(Task_Yiqi, 1, 0)
            refreshNpcTaskState()
            local change = payMoney() + apm - pm
            WriteLog(GetName() .. "Trõ ®iÓm Nh©n NghÜa ®Ó hñy nhiÖm vô Tø Linh" .. change .. ".")
            Msg2Player("Trõ ®iÓm Nh©n NghÜa ®Ó hñy nhiÖm vô Tø Linh" .. change .. ".")
        end
        ----------------------Add by liuzhiqiang at 2009/8/14 end   -----------------------ÒåÆø
        Pay(pm)
        DelNormalItem(3, 82, 0, 0)

        local w, mr, pl, mi, s1, t1
        if (GetTask(1023) > task_sel) then
            mr = GetTaskByte(1022, 3)
        else
            mr = random(1, 4)
            if (mr == 1) or (mr == 3) then
                mr = mr + 1
            end
        end

        local targname = ""
        targname = map_idx[mr][7]
        mi = map_idx[mr][1]--¹ÖÎïµØÍ¼
        w = mapname[mi]--mapname
        SetTaskWord(1022, 1, mi)--log¸Ä°æ

        if (GetLevel() >= 100) then
            t1 = map_idx[mr][6][4]
            AddIBBuff(t1)
            s1 = task_time[3]
        elseif (GetLevel() >= 85) then
            t1 = map_idx[mr][6][3]
            AddIBBuff(t1)
            s1 = task_time[2]
        elseif (GetLevel() >= 75) then
            t1 = map_idx[mr][6][2]
            AddIBBuff(t1)
            s1 = task_time[1]
        elseif (GetLevel() >= 65) then
            t1 = map_idx[mr][6][1]
            AddIBBuff(t1)
            s1 = task_time[1]
        end

        -- Add By Zhang Jin for ¾­ÑéË«±¶ÓÅ»¯ at 2010/04/21 Begin
        local nTemp = GetTaskByte(Double_Optimization, 3)
        nTemp = SetBit(nTemp, 6, 1)
        SetTaskByte(Double_Optimization, 3, nTemp)
        -- Add By Zhang Jin for ¾­ÑéË«±¶ÓÅ»¯ at 2010/04/21 End

        Msg2Player("N¹p tµi" .. apm .. "H­ëng thô lÇn thø" .. addtimes .. " ­u ®·i rêi game tİch lòy")
        Msg2Player("§©y lµ ­u ®·i tİch lòy rêi game lÇn thø" .. addtimes .. "lÇn nhËn nhiÖm vô Tø Linh.")
        TaskNote(54, 0, w)

        Talk(1, "no", "Linh Tª m«n ®· më! LÇn nµy ng­¬i cÇn" .. w .. "phãng thİch <c=g>" .. targname .. "<c> nguyªn linh, ta sÏ ngÉu nhiªn h­íng dÉn. Ng­¬i cã thÓ gi¶i phãng cho nguyªn linh ë 5 tÇng mª cung, cøu ®­îc bao nhiªu cßn tïy vµo n¨ng lùc cña ng­¬i!")    --ÒÑ¾­ÁìÈ¡
        return 1
    else
        Talk(1, "no", "Më Linh Tª m«n cÇn cã 1 <c=g>Tha S¬n Th¹ch<c> vµ" .. pm .. ", cã ®ñ råi quay l¹i t×m ta nhĞ!")    --È±¶«Î÷
        return 0
    end
end


--added by hongliang for ÈıÖÜÄê»î¶¯ 10/8/12 begin
--~ function ThreeYears_FireWorks()
--~     CloseDialog();

--~     local idx = GetTaskByte(TASK_ThreeYears_Questions, 2); --µ±Ç°NPCµÄÌâÄ¿
--~     local num = GetTaskByte(TASK_ThreeYears_Questions, 4); --µ±Ç°´ğÌâÊıÁ¿

--~     if (HaveNormalItem(8, G_ThreeYears_1stFireworksId + num, 2, 0) == 0) then
--~         Talk(1, "no", "ËãÃüÏÈÉú£ºÓ¢ĞÛ±³°üÖĞÃ»ÓĞĞ¯´øÇìµäÀñ»¨£¬Çë°ÑËü´øÔÚÉíÉÏÔÙÀ´ÕÒÎÒ°É¡£");
--~         return
--~     end
--~
--~     if (idx == 6) then
--~         Talk(1, "no", "ËãÃüÏÈÉú£º¸Õ²ÅÄãÒÑ¾­µÃµ½ÎÒµÄ×£¸£ÁË£¬Èç¹û½ñÌìÀÛ»ıµÃµ½ÁË5´Î×£¸££¬ÇëÇ°Íù³¯¸èÇìµäÍ¼ÌÚ¸½½üÈ¼·ÅÂúÔØ×£¸£µÄÇìµäÀñ»¨¡£");
--~         return
--~     end

--~     MsgBox("ËãÃüÏÈÉú£ºÓ¢ĞÛ¶Ô´ÓÎÒÕâÀïÁìÑøµÄÁé³èÂúÒâÂğ£¿Ò»¶¨ÒªºÃºÃÕÕ¹ËÁé³è£¬ÎÒ×¼±¸ÁË¼¸¸öÎÊÌâ£¬Ó¢ĞÛÈôÄÜ»Ø´ğÆäÖĞµÄÒ»¸ö£¬ÎÒ¿ÉÒÔËÍ¸øÓ¢ĞÛÒ»µÀ×£¸£¡£", "Accept_ThreeYears_FireWorks", "no");
--~ end


--~ function Accept_ThreeYears_FireWorks()
--~     CloseDialog();
--~
--~     local idx = GetTaskByte(TASK_ThreeYears_Questions, 2); --µ±Ç°NPCµÄÌâÄ¿
--~
--~     local TABLE_Ques = {
--~         [1] = { quest = "ÓñÅåÈ¡Ëè¿ÉÒÔÔÚÄÄÀï½øĞĞ£¿",
--~                     option = { [1]  = "Ñş³Ø³àËÉ×Ó", [2] = "Ñş³ØÕÔ¹«Ã÷", [3] = "Ñş³ØÀ×Õğ×Ó", }, },
--~         [2] = { quest = "¡¶·âÉñÑİÒå¡·ÖĞ¡°Ê®¶ş½ğÏÉ¡±²»°üÀ¨ÒÔÏÂÄÄÎ»£¿",
--~                     option = { [1]  = "µÀµÂÕæ¾ı", [2] = "ÄÏ¼«ÏÉÎÌ", [3] = "Ì«ÒÒÕæÈË", }, },
--~         [3] = { quest = "ÒÔÏÂÄÄÖÖ²ÄÁÏ¿ÉÒÔÎª»êÖä¼¼ÄÜÔö¼ÓÁéÆø£¿",
--~                     option = { [1]  = "·çÁéÊ¯", [2] = "Ë®ÁéÊ¯", [3] = "ÌìÁéÊ¯", }, },
--~         [4] = { quest = "°Ù¸£ÁÙÃÅÀñ°ü100¼¶ÀñÎïÊÇÊ²Ã´£¿",
--~                     option = { [1]  = "ÈçÒâÈ¯", [2] = "½«¾üÁî", [3] = "ÃûÓñÒ»¿Å", }, },
--~         [5] = { quest = "Ê¹ÓÃÊ²Ã´¹¤¾ß¿ÉÒÔÔÚ¹ú¼ÒÀïĞŞ½¨Ó¶±øÓª£¿",
--~                     option = { [1]  = "º××ì³ú", [2] = "Â³°à¸«", [3] = "³úÍ·", }, },
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
--~     Say("ËãÃüÏÈÉú£º\n"..TABLE_Ques[idx].quest, 4, opt1, opt2, opt3, "È¡Ïû/no");

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

--~     local idx = GetTaskByte(TASK_ThreeYears_Questions, 2); --µ±Ç°NPCµÄÌâÄ¿
--~     local TABLE_Key = {[1] = 3, [2] = 2, [3] = 3, [4] = 1, [5] = 2,};
--~
--~     if (TABLE_Key[idx] == choice) then
--~
--~         local num = GetTaskByte(TASK_ThreeYears_Questions, 4);

--~         if (HaveNormalItem(8, G_ThreeYears_1stFireworksId + num, 2, 0) == 0) then
--~             Talk(1, "no", "ËãÃüÏÈÉú£ºÓ¢ĞÛËäÈ»´ğ¶ÔÁËÌâÄ¿£¬µ«±³°üÖĞÃ»ÓĞĞ¯´øÇìµäÀñ»¨£¬Çë°ÑËü´øÔÚÉíÉÏÔÙÀ´ÕÒÎÒ°É¡£");
--~             return
--~         end

--~         Talk(1, "no", "ËãÃüÏÈÉú£ºÓ¢ĞÛ¹ûÈ»²ÅÖÇ¹ıÈË£¬ÕâµÀ×£¸£¾ÍËÍÓèÓ¢ĞÛÁË¡£");
--~
--~         SetTaskByte(TASK_ThreeYears_Questions, 2, 6); --µ±Ç°NPCµÄÌâÄ¿
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
--~         Talk(1, "no", "ËãÃüÏÈÉú£ºÄãµÄ´ğ°¸²»¶Ô£¬ÇëÖØĞÂ×÷´ğ¡£");
--~     end

--~ end
--added by hongliang for ÈıÖÜÄê»î¶¯ 10/8/12 end



