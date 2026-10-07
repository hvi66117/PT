--description: ÏÄ¸ûÊ¬
--author: yaoxin 
--date: 2008/07/14

Task_hengcai = 1214;
--1bitÎªÊÇ·ñ½ÓÌì½µºá²ÆÈÎÎñ;2bitÎªÊÇ·ñÍê³ÉÌì½µºá²ÆÈÎÎñ;3bitÎªÊÇ·ñ½«µÀ¾ß½»¸ø³¯¸èØÔÊ¦;4bitÎªÊÇ·ñ½«µÀ¾ß½»¸øÎ÷áªØÔÊ¦;5bitÎªÊÇ·ñÒÑ½ÓÅ£µ¶Ğ¡ÊÔ;6bitÎªÊÇ·ñÍê³ÉÅ£µ¶Ğ¡ÊÔ
--------------------------- ÖĞÇï»î¶¯ added by yangtao 2009.9.14 -------------------------------
Task_zhongqiu = 1558    -- 1byte:¼ÇÂ¼ÈÎÎñ½ø¶È 1:È¥¶ÄÍ½ÁìÈ¡Ä£¾ß 2:È¥²É¼¯3ÖÖ¹ûÊµ£¬È»ºóÈ¥³¯¸èÀñ¹Ù´¦¶Ò»»ÔÂ±ıÏÚ 
--                    3:È¥ÈıÉ½¹Ø´òÃæ·Û 4:È¥³¬¼¶ÔÂ±ı´¦ÁìÈ¡½±Àø 5:ÈÎÎñÍê³É
-- 2byte:¼ÇÂ¼ÈÎÎñ´ÎÊı
-- 3byte:Ê±¼ä´Á
-- 4byte:¼ÇÂ¼ÊÇ·ñÒÑ¾­ÔÚ³¬¼¶ÔÂ±ı´¦ÁìÈ¡¹ıÌØÊâ½±Àø
Gloal_zhongqiu_num = 257    -- ¼ÇÂ¼·şÎñÆ÷ËùÓĞÍæ¼ÒÒÑ¾­Íê³ÉµÄÈÎÎñ´ÎÊı
TaskNote_zhongqiu = 1103
--------------------------- ÖĞÇï»î¶¯ end of add yangtao 2009.9.14 -----------------------------
npc_name = {
    [12] = "Cèt Tinh",
    [16] = "D¹ Xoa",
    [19] = "H¾c Phong",
}

NpcChr_idx = { [0] = 15, [1] = 17, [2] = 16, [3] = 21, [4] = 18, [5] = 20, [6] = 19, [7] = 19 } --À¶¹ÖµôØÔ ÊôĞÔºÅ¶ÔÓ¦ØÔË÷Òı
function OnDeath(npcindex)
    --¸÷Àà°´µØÍ¼×é¶Ó¹²Ïí³É¹ûµÄÈÎÎñ
    local w, x, y = GetWorldPos() --Íæ¼ÒµØÍ¼¼°×ø±ê
    local mapgid, px, py = GetNpcWorldPos(npcindex) --npcµØÍ¼¼°×ø±ê
    if (w ~= mapgid) then
        return 0
    end

    local npcchr = GetHardNpcAttrib(npcindex)--À¶¹ÖÊôĞÔ

    -------------------------ÒÔÉÏÎª¹²ÏíµÄ±äÁ¿ ½ûÖ¹ÖØĞÂ¸³Öµ----------------------
    if (npcchr >= 0) and (npcchr <= 7) then
        local i = GetLevel() - 15
        if (i <= 10) then
            ThrowItem(npcindex, PlayerIndex, 3, NpcChr_idx[npcchr], 0, 1, 0, 0) --µôØÔ
            if (GetBit(GetTask(Task_hengcai), 1) == 0 and HaveNormalItem(6, 1, 358, 1) == 0) then
                AddNormalItem(6, 1, 358, 1, 0, 0)
                TopMessage("B¹n nhËn ®­îc 1 <c=yel>Viªn Bån<c>")
                Msg2Player("B¹n bÊt ngê nhËn ®­îc 1 <cViªn Bån")
            end ;
        end ;
    end ;
    -- ÖĞÇï»î¶¯ Added by yangtao 2009.9.14
    --local probability	= random(1, 100)
    --local mianfen_num	= HaveNormalItem(4, 273, 0, 1)
    --local progress		= GetTaskByte(Task_zhongqiu, 1)
    --if((progress == 3) and (probability <= 33) and (mianfen_num < 10) and (mapgid == 16)) then
    -- Ìí¼ÓÃæ·Û
    --	if(IsHaveSpaceForTreasure (1) ~= 0) then	
    --		AddNormalItemPile(4, 273, 0, 1, 0, 0)
    --		if(mianfen_num == 9) then
    --			Msg2Player("Äã»ñµÃÁË×ã¹»µÄÃæ·Û¡£")
    --			TopMessage("Äã»ñµÃÁË×ã¹»µÄÃæ·Û")	
    --			SetTaskByte(Task_zhongqiu, 1, 4)
    --			TaskNote(TaskNote_zhongqiu, 3)
    --		else
    --			Msg2Player("Äã»ñµÃÁËÒ»´üÃæ·Û¡£")
    --			TopMessage("Äã»ñµÃÁËÒ»´üÃæ·Û")	
    --			TaskNote(TaskNote_zhongqiu, 2, mianfen_num + 1)						
    --		end
    --	end
    --elseif(mianfen_num >= 10) then
    --	Msg2Player("ÄãÒÑ¾­»ñµÃÁË×ã¹»µÄÃæ·Û¡£")
    --	SetTaskByte(Task_zhongqiu, 1, 4)
    --	TaskNote(TaskNote_zhongqiu, 3)
    --end
    -- ÖĞÇï»î¶¯ end of add yangtao 2009.9.14
    if (GetTeam() ~= 0) then
        -- ÓĞ¶ÓÎé(°üÀ¨Ö»ÓĞ×Ô¼ºÒ»¸öÈËµÄ)
        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()

        -- ±éÀú¶ÓÖĞ¶ÓÔ±
        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)
            --Ó¶±øÓªÁÔÉ±ÈÎÎñ
            if (GetTask(852) > 0) then
                liesha_city(w)
            end

            if (GetByte(GetTask(1205), 1) == 1 and GetByte(GetTask(1205), 2) == 11) then
                NewMonsterTip(w)
            end
        end
        PlayerIndex = oldPlayer
    else
        -- ÎŞ¶ÓÎé
        --Ó¶±øÓªÁÔÉ±ÈÎÎñ
        if (GetTask(852) > 0) then
            liesha_city(w)
        end

        if (GetByte(GetTask(1205), 1) == 1 and GetByte(GetTask(1205), 2) == 11) then
            NewMonsterTip(w)
        end
    end ;

    ---ĞÂÔö7¹ÖÎï¾íÖáµôÂä
    if (GetLevel() <= 30) then
        if (GetByte(GetTask(1205), 1) == 0 and HaveNormalItem(6, 1, 351, 1) < 1) then
            NewMonsterDropScroll()
        end
    end

    if (GetTask(955) == 12) and (GetTask(956) < 20) then
        Frenwu18()--½ÌÑµ¹ÖÎïÈÎÎñ£¨30¼¶ÒÔÏÂ£©--ĞÂÊÖ´å ÔÓ»õÉÌ
    end

    if (GetTask(936) >= 1) then
        Frenwu42()--ÕòÔ­´óÏÉ  ³È×°ºÏ³É  42¼¶
    end

    -- ÖĞÇï»î¶¯ Added by yangtao 2009.9.14
    --if((progress == 3) and (mianfen_num < 10) and (mapgid == 16)) then
    -- Ëæ»ú»ñµÃÒâÍâÎïÆ·
    --	local probability_special = random(1, 1000)
    --	if(probability_special <= 3) then
    --		AddNormalItemPile(6, 1, 583, 1, 0, 0)
    --		WriteLog("»ñµÃĞ¡ºËÌÒÔÂ±ı")
    --		Msg2Player("Äã»ñµÃÁËÒ»¸öĞ¡ºËÌÒÔÂ±ı¡£")
    --		TopMessage("Äã»ñµÃÁËÒ»¸öĞ¡ºËÌÒÔÂ±ı")	
    --	elseif(probability_special <= 4) then
    --		AddNormalItemPile(6, 1, 584, 1, 0, 0)
    --		WriteLog("»ñµÃº£ÏÊ¿ÚÎ¶ÔÂ±ı")
    --		Msg2Player("Äã»ñµÃÁËÒ»¸öº£ÏÊ¿ÚÎ¶ÔÂ±ı¡£")
    --		TopMessage("Äã»ñµÃÁËÒ»¸öº£ÏÊ¿ÚÎ¶ÔÂ±ı")	
    --	else
    --		local level = GetLevel()
    --		if((level > 70) and (probability_special <= 54)) then
    --			AddNormalItemPile(6, 1, 585, 1, 0, 0)
    --			Msg2Player("Äã»ñµÃÁËÒ»¸öºìÃµ¹åÔÂ±ı¡£")
    --			TopMessage("Äã»ñµÃÁËÒ»¸öºìÃµ¹åÔÂ±ı")	
    --		end
    --		if((level >= 50) and (level <= 70) and (probability_special <= 14)) then
    --			AddNormalItemPile(6, 1, 585, 1, 0, 0)
    --			Msg2Player("Äã»ñµÃÁËÒ»¸öºìÃµ¹åÔÂ±ı¡£")
    --			TopMessage("Äã»ñµÃÁËÒ»¸öºìÃµ¹åÔÂ±ı")	
    --		end

    --	end
    --end
    -- ÖĞÇï»î¶¯ end of add yangtao 2009.9.14
end

--Ó¶±øÓªÁÔÉ±ÈÎÎñ
function liesha_city(world)
    local w, x, y = GetWorldPos()
    if (w ~= world) then
        return 0
    end

    local task_id = 852
    local task_val = GetTask(task_id)
    local type1 = GetByte(task_val, 1)
    local count1 = GetByte(task_val, 2)
    local type2 = GetByte(task_val, 3)
    local count2 = GetByte(task_val, 4)

    if (type1 == 12 and count1 > 0) then
        count1 = count1 - 1
        if (count1 > 0) then
            ScrollMessage("NhiÖm vô Lİnh ®¸nh thuª: tiªu diÖt" .. npc_name[type1] .. "(" .. (50 - count1) .. "/50)")
        else
            count1 = 0
            ScrollMessage(" Hoµn thµnh Truy s¸t" .. npc_name[type1] .. ".")
        end
        SetTask(task_id, SetByte(task_val, 2, count1))
        TaskNote(task_id, 0, npc_name[type1], (50 - count1), npc_name[type2], (50 - count2))
    elseif (type2 == 12 and count2 > 0) then
        count2 = count2 - 1
        if (count2 > 0) then
            ScrollMessage("NhiÖm vô Lİnh ®¸nh thuª: tiªu diÖt" .. npc_name[type2] .. "(" .. (50 - count2) .. "/50)")
        else
            count2 = 0
            ScrollMessage(" Hoµn thµnh Truy s¸t" .. npc_name[type2] .. ".")
        end
        SetTask(task_id, SetByte(task_val, 4, count2))
        TaskNote(task_id, 0, npc_name[type1], (50 - count1), npc_name[type2], (50 - count2))
    end

    if (count1 == 0 and count2 == 0) then
        TaskNote(task_id, 1)
    end
end

function no()
    CloseDialog()
end;

function NewMonsterDropScroll()
    local nProp = random(1, 100)
    if (nProp <= 4) then
        AddNormalItem(6, 1, 351, 1, 0, 0)
        TopMessage("B¹n bÊt ngê nhËn ®­îc 1 <c=g>Cèt Tinh mËt tŞch<c>.")
        Msg2Player("B¹n bÊt ngê nhËn ®­îc 1 Cèt Tinh mËt tŞch.")
    end
end

function NewMonsterTip(world)
    local w, x, y = GetWorldPos()
    if (w == world) then
        local var = GetTask(1205)
        local Num = GetByte(var, 3)
        local KillNum = GetByte(var, 4) + 1
        SetTask(1205, SetByte(var, 4, KillNum))
        if (KillNum >= Num) then
            SetTask(1205, SetByte(GetTask(1205), 1, 2))
            TaskNote(919, 2)
            TopMessage("Hoµn thµnh tiªu diÖt Cèt Tinh, cã thÓ t×m T¹p hãa Th­¬ng l·nh th­ëng!")
            Msg2Player("Hoµn thµnh nv MËt TŞch Cèt Tinh, cã thÓ t×m T¹p hãa Th­¬ng l·nh th­ëng!")
        else
            TaskNote(919, 1, KillNum, Num)
            TopMessage("Tiªu diÖt Cèt Tinh" .. KillNum .. "/" .. Num .. ".")
            Msg2Player("Tiªu diÖt Cèt Tinh" .. KillNum .. "/" .. Num .. ".")
        end
    end
end

--½ÌÑµ¹ÖÎïÈÎÎñ£¨30¼¶ÒÔÏÂ£©--ĞÂÊÖ´å ÔÓ»õÉÌ-----------------------------------------
function Frenwu18()
    local nums = GetTask(956) + 1
    if (nums < 20) then
        SetTask(956, nums)
        ScrollMessage("Gi¸o HuÊn: Cßn ph¶i gi¸o huÊn Cèt Tinh" .. (20 - nums) .. ".")
        TaskNote(50, 1, "Cèt Tinh", nums)
    elseif (nums == 20) then
        SetTask(956, 21)
        ScrollMessage(" Hoµn thµnh nhiÖm vô Gi¸o huÊn")
        TaskNote(50, 2)
    end
end

-------------------------------ÕòÔ­´óÏÉ  ³È×°ºÏ³É  42¼¶-----------------------------
function Frenwu42()
    if (GetTask(936) < 5) then
        local r = random(1, 10000)
        local zyCNums = GetByte(GetTask(938), 4) + 1
        local key = 0
        if (zyCNums == 1) and (r <= 100) then
            ---1%
            key = 1
        elseif (zyCNums == 2) and (r >= 100) and (r <= 110) then
            ---0.1%
            key = 1
        elseif (zyCNums >= 3) and (r == 5000) then
            --0.01%
            key = 1
        end
        if (key == 1) then
            AddNormalItemPile(3, 103, 1, 0, 0, 0)
            TopMessage(11646)
            SetTask(938, SetByte(GetTask(938), 4, zyCNums))
        end
    else
        --991	»ñµÃ¼ÓÕòÔ­ÉùÍûbuffµÄÊ±¼ä,¾«È·µ½Ìì
        local rand_buff = random(1, 1000)--
        local today_buff = floor(LocalSystemTime() / 86400)
        if (today_buff ~= GetTask(991)) and (rand_buff >= 990) then
            AddIBBuff(369)
            TopMessage(11647)
            SetTask(991, today_buff)
        end
    end
end