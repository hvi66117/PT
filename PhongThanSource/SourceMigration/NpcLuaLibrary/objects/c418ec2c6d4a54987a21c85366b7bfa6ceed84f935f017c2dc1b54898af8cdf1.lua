Task_HelpScore = 1491
SCORE_LIMIT = 100 --Ã¿ÖÜ»ñµÃ»ı·ÖÉÏÏŞ

--AS GaoJingwei 090813
Task_LongAgo = 1529        --1byte: 1ÕÒ³à¾«×Ó£¬2ÕÒ¸ßÃ÷   2byte 1ÁË½âÏÉÄ§½ç  2ÁìÈ¡É±ÁúÈÎÎñ 3³É¹¦É±Áú  4ÁìÈ¡½±Àø
--AE GaoJingwei 090813

function OnDeath(npcidx)
    SetGlobalValue(109, 0)
    local i = GetName()
    AddGlobalCountNews("H¬i thë cña <c=g>Giao Long<c> ®· t¾t, thñ cÊp treo trªn vò khİ cña <c=g>" .. i .. "<c>.", 20)

    local w, x, y = GetWorldPos()
    local lvl = GetNpcLevel(npcidx)
    if (GetTeam() ~= 0) then
        local succeed = 0
        local addScore = 0
        local array = {}
        local help_num = 1

        -- ¦³¶¤¥î(¥]¬A¥u¦³¦Û¤v¤@­Ó¤Hªº)
        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()
        -- ¹M¾ú¶¤¤¤¶¤­û
        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)
            --city_shouji(w)
            succeed = renwu110(w)
            if (succeed == 1) then
                addScore = addScore + 3
                array[help_num] = GetName()
                help_num = help_num + 1
            end
        end
        PlayerIndex = oldPlayer

        -----------------Add by liuzhiqiang at 2009/7/2 start------------------°ïÖú»ı·Ö
        local scoreLimit = GetTaskByte(Task_HelpScore, 3)
        if (addScore > 0) then
            if (GetTask(3) >= 123 or GetTask(1) >= 123 or GetTask(2) >= 123) then
                if (scoreLimit < SCORE_LIMIT) then
                    scoreLimit = scoreLimit + addScore
                    if (scoreLimit > SCORE_LIMIT) then
                        addScore = SCORE_LIMIT - GetTaskByte(Task_HelpScore, 3)
                    end
                    SetTaskByte(Task_HelpScore, 3, scoreLimit)
                    AddHelpScore(addScore)
                    local str = ""
                    for i = 1, help_num - 1 do
                        str = str .. "<c=g><RoleName=\"" .. array[i] .. "\"><c> "
                    end
                    AddEvent("%s ®· thµnh c«ng ®¸nh b¹i <c=g>Giao Long<c>, gióp ®ì " .. str .. "Khiªu chiÕn nhiÖm vô chñ tuyÕn cÊp 110, nhËn ®­îc ®iÓm Nh©n NghÜa" .. addScore .. "§iÓm kinh nghiÖm.", 1)  --¶ÔºÃÓÑ·¢³öÏûÏ¢
                    Msg2Player("Chóc mõng! B¹n nhËn ®­îc" .. addScore .. " ®iÓm Nh©n NghÜa!")
                    WriteLog(GetName() .. "NhËn ®­îc" .. addScore .. " ®iÓm Nh©n NghÜa.")
                else
                    Msg2Player("Ng¹i qu¸! Mçi ng­êi mçi tuÇn chØ cã thÓ nhËn ®­îc " .. SCORE_LIMIT .. " ®iÓm Nh©n NghÜa, tuÇn nµy b¹n ®· nhËn tèi ®a råi.")
                end
            end
        end
        -----------------Add by liuzhiqiang at 2009/7/2 end  ------------------°ïÖú»ı·Ö
        --modified by liujifang for ¸ß¼¶³È×° at 2013-1-31 begin
        Throw_Equip(npcidx, PlayerIndex)
        --modified by liujifang for ¸ß¼¶³È×° at 2013-1-31 end
    else
        -- µL¶¤¥î
        --city_shouji(w)
        renwu110(w)
        --modified by liujifang for ¸ß¼¶³È×° at 2013-1-31 begin
        Throw_Equip(npcidx, PlayerIndex)
        --modified by liujifang for ¸ß¼¶³È×° at 2013-1-31 end
    end ;

    if (IsWorldEventExist(1) == 0) then
        CreateWorldEvent(1, 1, 0, 1)--ÊÀ½çÊÂ¼ş´´½¨
        WriteLog("S¸ng lËp mét sù kiÖn thÕ giíi")
    else
        local prog = GetWorldEventProgress(1)
        if (prog < 3) then
            --3Ê±,Ë¢npc,5Ê±Ë¢ÍêÉùÍû 6Ê±ÒÑ¾­¿ªÆô,
            beginWorldevent()--ÊÀ½çÊÂ¼ş¿ªÆô
        elseif (prog == 5) then
            if (GetTaskByte(1296, 1) >= 1) then
                --? ÊÇ·ñÔÚÑş³ØÎåÏÔÁé¹Ù±¨Ãû
                beginWorldevent()--µØÍ¼¿ªÆô
            else
                WriteLog("Ng­¬i ch­a b¸o danh s¸t Rång")
            end
        end
    end
    DelNpc(npcidx)
end;

--function city_shouji(world)--4¼¶ÊÕ¼¯Ôİ²»¿ª·Å
--	local w,x,y=GetWorldPos()
--	if (w == world) then
--		local task_id = 866
--		local item_id = 173
--		local type_id = 18
--		local item_name = "òÔÁúµÄÍ·Â­"
--		local task_val = GetTask(task_id)
--		local type1 = GetByte(task_val,1)
--		local count1=	GetByte(task_val,2)
--		local type2 = GetByte(task_val,3)
--		local count2= GetByte(task_val,4)
--
--		local item_count =IsExistItem(4,item_id,0,1)
--		if (type1 == type_id)then
--			if(item_count < count1) then
--				AddNormalItem(4,item_id,0,0,0,0)
--				item_count = item_count + 1
--			end
--			if(item_count < count1) then
--				Msg2Player("»¹ĞèÒªÊÕ¼¯"..item_name..(count1-item_count).."¸ö")
--			else
--				Msg2Player("Íê³ÉÁËÊÕ¼¯"..item_name.."µÄÈÎÎñ")
--			end
--		end
--		if (type2 == type_id)then
--			if(item_count < count2) then
--				AddNormalItem(4,item_id,0,0,0,0)
--				item_count = item_count + 1
--			end
--			if(item_count < count2) then
--				Msg2Player("»¹ĞèÒªÊÕ¼¯"..item_name..(count2-item_count).."¸ö")
--			else
--				Msg2Player("Íê³ÉÁËÊÕ¼¯"..item_name.."µÄÈÎÎñ")
--			end
--		end
--	end
--end

function renwu110(world)
    local w, x, y = GetWorldPos()
    if (w == world) then
        local taskval1 = GetTask(1)
        local taskval2 = GetTask(2)
        local taskval3 = GetTask(3)
        local pt = GetPlayerType()
        if (taskval1 == 115) or (taskval2 == 115) or (taskval3 == 115) then
            Msg2Player("B¹n ®· chinh phôc thµnh c«ng Giao Long, Ngò HiÖn Linh Quan ®· ®­îc gi¶i tho¸t")

            local pt = GetPlayerType()
            if (pt == 0) then
                SetTask(3, 116)
                TaskNote(27, 45)
            elseif (pt == 1) then
                SetTask(1, 116)
                TaskNote(28, 49)
            else
                SetTask(2, 116)
                TaskNote(29, 44)
            end ;
            return 1  --Add by liuzhiqiang
        elseif (taskval1 == 117) or (taskval2 == 117) or (taskval3 == 117) then
            Msg2Player("B¹n ®· chinh phôc thµnh c«ng Giao Long, Ngò HiÖn Linh Quan ®· ®­îc gi¶i tho¸t")
            local pt = GetPlayerType()
            if (pt == 0) then
                SetTask(3, 118)
                TaskNote(27, 47)
            elseif (pt == 1) then
                SetTask(1, 118)
                TaskNote(28, 51)
            else
                SetTask(2, 118)
                TaskNote(29, 46)
            end ;
            return 1  --Add by liuzhiqiang
        elseif (GetTaskByte(Task_LongAgo, 2) == 2) then
            Msg2Player("B¹n ®· chinh phôc thµnh c«ng Giao Long, Ngò HiÖn Linh Quan ®· ®­îc gi¶i tho¸t")
            SetTaskByte(Task_LongAgo, 2, 3)

            if (GetTaskByte(Task_LongAgo, 1) == 1) then
                if (GetPlayerType() == 0) then
                    TaskNote(27, 45)
                elseif (GetPlayerType() == 1) then
                    TaskNote(28, 49)
                elseif (GetPlayerType() == 2) then
                    TaskNote(29, 44)
                end
            elseif (GetTaskByte(Task_LongAgo, 1) == 2) then
                if (GetPlayerType() == 0) then
                    TaskNote(27, 47)
                elseif (GetPlayerType() == 1) then
                    TaskNote(28, 51)
                elseif (GetPlayerType() == 2) then
                    TaskNote(29, 46)
                end
            end
            return 1
        end
    end
    return 0  --Add by liuzhiqiang
end

--------------------------ÊÀ½çÊÂ¼ş---------------------
--nEventID 1 : ÊÀ½ç¿ªÆôÊÂ¼şÏµÁĞ
--ValueIdx ¼ûÏÂ
--1 : ´òËÀĞ¡ÁúµÄÊ±¼ä
--2 : ´òËÀÖĞÁúµÄÊ±¼ä
--3 : ´òËÀ´óÁúµÄÊ±¼ä
--Progress 1µÚÒ»ÌìË³É±3Áú 2Á¬ĞøÁ½Ìì,3 Á¬Ğø3ÌìÈÎÎñÍê³É,4Ë¢³önpc,5Ê±Ë¢ÍêÉùÍû 6Ê±ÒÑ¾­¿ªÆô,
function beginWorldevent()
    local today = floor(LocalSystemTime() / 86400)
    SetWorldEventValue(1, 1, today)
end

--modified by liujifang for ¸ß¼¶³È×° at 2013-1-31 begin
function Throw_Equip(nNpcIdx, nPlayerIdx)
    local nFlag = 4
    local nDetailType = { 2, 5, 6, 7, 9 }
    local nParticularType = { 42, 43, 44 }
    for i = 1, nFlag do
        --¹Ì¶¨ÂÖÑ¯
        ThrowItem(nNpcIdx, nPlayerIdx, 0, nDetailType[random(1, getn(nDetailType))], nParticularType[random(1, getn(nParticularType))], 1, 0, 0)

        --Ëæ»úÂÖÑ¯
        if (random(1, 100) <= 50) then
            ThrowItem(nNpcIdx, nPlayerIdx, 0, nDetailType[random(1, getn(nDetailType))], nParticularType[random(1, getn(nParticularType))], 1, 0, 0)
        end
    end
    WriteLog("Trang bŞ cam cao cÊp: rít trang bŞ tr¾ng" .. nFlag .. ",npcID:Giao Long")
end
--modified by liujifang for ¸ß¼¶³È×° at 2013-1-31 end