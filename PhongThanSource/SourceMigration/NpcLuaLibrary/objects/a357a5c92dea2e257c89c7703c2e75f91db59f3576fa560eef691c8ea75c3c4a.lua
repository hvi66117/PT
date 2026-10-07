--description: »ğÓã
--author: yaoxin
--date: 2008/07/29

Task_hengcai = 1214;
--1bitÎªÊÇ·ñ½ÓÌì½µºá²ÆÈÎÎñ;2bitÎªÊÇ·ñÍê³ÉÌì½µºá²ÆÈÎÎñ;3bitÎªÊÇ·ñ½«µÀ¾ß½»¸ø³¯¸èØÔÊ¦;4bitÎªÊÇ·ñ½«µÀ¾ß½»¸øÎ÷áªØÔÊ¦;5bitÎªÊÇ·ñÒÑ½ÓÅ£µ¶Ğ¡ÊÔ;6bitÎªÊÇ·ñÍê³ÉÅ£µ¶Ğ¡ÊÔ

----½µÄ§»¤µÀ------------
T_unattack = 1197 -- byte 1 ÔÂ·İ ,2 ÈÕÆÚ,  3,Íæ¼ÒµÄµÈ¼¶, 4Ö¸¶¨µØÍ¼ºÅ,
TUAtt_nums = 1198 --½µÄ§»¤µÀÁÔÉ±µÄ×Ü¸öÊı

------------add by liujifang for ÁùÒ»»î¶¯ at 10-05-13 begin------------
Task_ChildrensDayReceive = 1703          --ÅĞ¶Ïµ±ÌìÊÇ·ñÁìÈ¡ÀñÎïºÍ½±Àø(0·ñ1ÊÇ)£¬1byte:ÁùÒ»ÀñÎï£»2byte:ĞíÔ¸Ê÷½±Àø£»3byte:½ÚÈÕÑÌ»¨£»4byte:ĞíÔ¸Ê÷´ó½±
Task_ChildrensDayReceiveNum = 1704       --¼ÇÂ¼ÁìÈ¡ÀñÎïºÍ½±ÀøµÄ´ÎÊı£¬1byte:ÁùÒ»ÀñÎï£»2byte:ĞíÔ¸Ê÷½±Àø£» 3byte:ÑÌ»¨½±Àø£»4byte:´«ÇéÀñºĞ
Task_ChildrensDayReceiveTodayNum = 1705  --¼ÇÂ¼µ±ÈÕÁìÈ¡ÀñÎïºÍ½±ÀøµÄ´ÎÊı£¬1byte:ÁùÒ»ÀñÎï£»2byte:ĞíÔ¸Ê÷£»
Task_ChildrensDay = 1706                 --1byte:¼ÇÂ¼ÈÎÎñ²½Öè£º0=Î´½ÓÈÎÎñ£»1=½Óµ½ÈÎÎñÉ±¹Ö£»2=É±Íê¹Ö½»ÈÎÎñ£»3=Íê³ÉÍĞ¸¶ÈÎÎñ£»4=ÖÖÖ²ÁËĞíÔ¸Ê÷(Ğ¡Ê÷Ãç)£»5=Ğ¡Ê÷£»6=´óÊ÷£»7=¿ÉÒÔĞíÔ¸£»8=Íê³ÉĞíÔ¸Ê÷ÈÎÎñ£»(step:10=Íê³ÉĞíÔ¸Ê÷ÈÎÎñ£¬¿ÉÒÔÈ¥Áì½±Àø)
--3byte:ÅĞ¶Ïµ±Ç°Íæ¼ÒÊÇ·ñ¿ÉÒÔ´ò¿ªÀñºĞ(¼ÇÍæ¼ÒµÄÀñºĞÊı)
Task_ChildrensToday = 1707               --¼ÇÂ¼ÊÇ·ñµ±Ìì

Glocal_ChildrenGiftNum = 373            --È«¾Ö±äÁ¿£¬¼ÇÂ¼µ±ÌìÈ«·ş²ú³öµÄ´«ÇéÀñºĞµÄÊıÁ¿
Save_ChilrensDayTree_Num = "Save_ChilrensDay_Tree_Num"          -- ×Ö·û´®£¬1id£ºÓÃÀ´ÏòÎÄ¼şÖĞ¼ÇÂ¼ĞíÔ¸Ê÷ÖÖÖ²µÄÈËÊı£¬ÒÔ±ãµÃµ½ÌØÊâÍæ¼Ò£»2-4id£º·Ö±ğ¼ÇÂ¼Èı¸öÌØÊâÍæ¼ÒµÄId
------------add by liujifang for ÁùÒ»»î¶¯ at 10-05-13 end------------

npc_name = {
    [20] = "Lôc Quy",
    [22] = "Háa Ng­",
    [27] = "ThiÕt Ng­",
}

mapname = {
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

NpcChr_idx = { [0] = 15, [1] = 17, [2] = 16, [3] = 21, [4] = 18, [5] = 20, [6] = 19, [7] = 19 } --À¶¹ÖµôØÔ ÊôĞÔºÅ¶ÔÓ¦ØÔË÷Òı

function OnDeath(npcindex)
    -- Add By Zhang Jin for ¹úÇì½Ú»î¶¯2010 at 2010-09 Begin
    --local nYear, nMonth, nDay = GetYMD()
    --if ( nYear == 2010 and ( (nMonth == 9 and nDay >= 28) or (nMonth == 10 and nDay <= 7 ) ) ) then
    --	NationalDay_Activity()
    --end
    -- Add By Zhang Jin for ¹úÇì½Ú»î¶¯2010 at 2010-09 End

    --¸÷Àà°´µØÍ¼×é¶Ó¹²Ïí³É¹ûµÄÈÎÎñ
    local w, x, y = GetWorldPos() --Íæ¼ÒµØÍ¼¼°×ø±ê
    local mapgid, px, py = GetNpcWorldPos(npcindex) --npcµØÍ¼¼°×ø±ê
    if (w ~= mapgid) then
        return 0
    end

    local npcchr = GetHardNpcAttrib(npcindex)--À¶¹ÖÊôĞÔ
    local att_pmidx = GetByte(GetTask(T_unattack), 4) --½µÄ§»¤µÀ Ö¸¶¨µØÍ¼ºÅ

    -------------------------ÒÔÉÏÎª¹²ÏíµÄ±äÁ¿ ½ûÖ¹ÖØĞÂ¸³Öµ----------------------
    if (npcchr >= 0) and (npcchr <= 7) then
        local i = GetLevel() - 45
        if (i <= 10) then
            ThrowItem(npcindex, PlayerIndex, 3, NpcChr_idx[npcchr], 0, 1, 0, 0) --µôØÔ
            if (GetBit(GetTask(Task_hengcai), 1) == 0 and HaveNormalItem(6, 1, 358, 1) == 0) then
                AddNormalItem(6, 1, 358, 1, 0, 0)
                TopMessage("B¹n nhËn ®­îc 1 <c=yel>Viªn Bån<c>")
                Msg2Player("B¹n bÊt ngê nhËn ®­îc 1 <cViªn Bån")
            end ;
        end ;
    end ;

    if (GetTeam() ~= 0) then
        -- ÓĞ¶ÓÎé(°üÀ¨Ö»ÓĞ×Ô¼ºÒ»¸öÈËµÄ)
        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()

        -- ±éÀú¶ÓÖĞ¶ÓÔ±
        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)
            --Ó¶±øÓªÁÔÉ±ÈÎÎñ
            if (GetTask(854) > 0) then
                liesha_city(w)
            end

            --¹ÖÎïÄÁ³¡
            if (HaveIBBuff(360) >= 1) and (w == 38) then
                ogre_field(w)
            end

            --½µÄ§»¤µÀ
            if (att_pmidx == w) or (att_pmidx - 100 == w) then
                if (PlayerIndex == oldPlayer) and (att_pmidx == w) then
                    fteam_attack(1, w)
                else
                    fteam_attack(2, w)
                end
            end

            --add by liujifang for ÁùÒ»»î¶¯ at 10-05-13 begin------------
            --			if GetTaskByte(Task_ChildrensDay, 1) == 15 then
            --				ChildrensDay()
            --			end
            --add by liujifang for ÁùÒ»»î¶¯ at 10-05-13 end-----------

        end
        PlayerIndex = oldPlayer
    else
        -- ÎŞ¶ÓÎé
        --Ó¶±øÓªÁÔÉ±ÈÎÎñ
        if (GetTask(854) > 0) then
            liesha_city(w)
        end

        --¹ÖÎïÄÁ³¡
        if (HaveIBBuff(360) >= 1) and (w == 38) then
            ogre_field(w)
        end

        --½µÄ§»¤µÀ
        if (att_pmidx == w) then
            fteam_attack(1, w)
        end

        --add by liujifang for ÁùÒ»»î¶¯ at 10-05-13 begin------------
        --		if GetTaskByte(Task_ChildrensDay, 1) == 15 then
        --			ChildrensDay()
        --		end
        --add by liujifang for ÁùÒ»»î¶¯ at 10-05-13 end-----------

    end ;

    -------------------------------------------------------------------------------------
    if (SystemTime() <= (GetTask(969) + 200)) then
        if (GetTask(966) == mapgid) then
            Frenwu40(px, py, 22)--Áé»ê³¬¶ÈÈÎÎñ£¨40¼¶£©--·âÉñÌ¨Òóºé
        end
    end ;

    if (HaveIBBuff(293) >= 1) then
        if (mapgid >= 37) and (mapgid <= 41) then
            Frenwu31()--ËÄÏóÊÕ¼¯ ÔªËØÌ½Ë÷ 31¼¶
        end
    end

    if (GetTask(936) == 5) then
        Frenwu42()--ÕòÔ­´óÏÉ  ³È×°ºÏ³É  42¼¶
    end

    if (suanming(GetByte(GetTask(1022), 1), GetLevel()) == 1) then
        Frenwu65(mapgid)--   ËãÃüÏÈÉú----ËÄÏóÁéÏ¬ÈÎÎñ----65¼¶
    end

    --²¢·ş»î¶¯ 2009/10/27
    --taskPeace()
    --²¢·ş»î¶¯ 2009/10/27

    --Add By Guoqun for ÇåÁ¹ÏÄÈÕ at 2010-07-12 Begin
    --if mapgid == 37 then
    --	Cool_Summer()
    --	Cool_Summer_Task2()
    --end
    --Add By Guoqun for ÇåÁ¹ÏÄÈÕ at 2010-07-12 End
end

--Ó¶±øÓªÁÔÉ±ÈÎÎñ
function liesha_city(world)
    local w, x, y = GetWorldPos()
    if (w ~= world) then
        return 0
    end

    local task_id = 854
    local task_val = GetTask(task_id)
    local type1 = GetByte(task_val, 1)
    local count1 = GetByte(task_val, 2)
    local type2 = GetByte(task_val, 3)
    local count2 = GetByte(task_val, 4)

    if (type1 == 22 and count1 > 0) then
        count1 = count1 - 1
        if (count1 > 0) then
            ScrollMessage("NhiÖm vô Lİnh ®¸nh thuª: tiªu diÖt" .. npc_name[type1] .. "(" .. (50 - count1) .. "/50)")
        else
            count1 = 0
            ScrollMessage(" Hoµn thµnh Truy s¸t" .. npc_name[type1] .. ".")
        end
        SetTask(task_id, SetByte(task_val, 2, count1))
        if (count1 == 0 and count2 == 0) then
            TaskNote(task_id, 1)
        else
            TaskNote(task_id, 0, npc_name[type1], (50 - count1), npc_name[type2], (50 - count2))
        end
    elseif (type2 == 22 and count2 > 0) then
        count2 = count2 - 1
        if (count2 > 0) then
            ScrollMessage("NhiÖm vô Lİnh ®¸nh thuª: tiªu diÖt" .. npc_name[type2] .. "(" .. (50 - count2) .. "/50)")
        else
            count2 = 0
            ScrollMessage(" Hoµn thµnh Truy s¸t" .. npc_name[type2] .. ".")
        end
        SetTask(task_id, SetByte(task_val, 4, count2))
        if (count1 == 0 and count2 == 0) then
            TaskNote(task_id, 1)
        else
            TaskNote(task_id, 0, npc_name[type1], (50 - count1), npc_name[type2], (50 - count2))
        end
    end
end

--¹ÖÎïÄÁ³¡
function ogre_field(WorldID)
    local mapid = GetByte(GetTask(1077), 2)
    local w, x, y = GetWorldPos()
    if (WorldID == mapid) and (w == WorldID) then
        local kind = GetByte(GetTask(1077), 1)
        if (22 == kind) then
            local count = GetTask(1078) - 1
            if (count > 0) then
                SetTask(1078, count)
                ScrollMessage("Trõ Ma: Cßn ph¶i tiªu diÖt " .. count .. " Háa Ng­")
                TaskNote(69, 0, "Long Cung", "Háa Ng­", count)
            else
                RemoveIBBuff(360)
                SetTask(1078, 0)
                TaskNote(69, 1)
                ScrollMessage("Trõ ma: Hoµn thµnh")
            end
        end
    end
end

function no()
    CloseDialog()
end;

----½µÄ§»¤µÀ------------
--½µÄ§»¤µÀ modified by yaoxin for 2009-12-03
function fteam_attack(key, world)
    -- 1Îª×Ô¼º£¬ÆäËüÎª¹²ÏíÈË
    if (GetLevel() < 60) or (IsTongMember() <= 0) then
        return 0
    end

    local w, x, y = GetWorldPos()
    if (w == world) then
        local att_pmidx = GetByte(GetTask(T_unattack), 4)
        if (att_pmidx == world) then
            local nums = GetTask(TUAtt_nums) + 1
            if (key == 1) then
                SetTask(TUAtt_nums, nums)
                ScrollMessage("Hé §¹o: §· tiªu diÖt " .. nums .. ".")
                TaskNote(72, 0, "Long Cung", nums, 30000)
            else
                --local r = random(1,1)--?
                --if (r == 1) then
                SetTask(TUAtt_nums, nums)
                ScrollMessage("Hé §¹o: §· tiªu diÖt " .. nums .. ".")
                TaskNote(72, 0, "Long Cung", nums, 30000)
                --else
                --	return 0
                --end
            end

            if (nums >= 30000) then
                SetTask(T_unattack, SetByte(GetTask(T_unattack), 4, 100 + att_pmidx))
                ScrollMessage("Hé §¹o: <c=g>hoµn thµnh nhiÖm vô<c>")
                TaskNote(72, 1)
            end

            if (mod(nums, 2000) == 0) then
                fteam_luckbuff()
            end
        end
    end
end

function fteam_luckbuff()
    --½µÄ§»¤µÀËÍ½µÄ§Áî
    local fteam_list = {--µÈ¼¶·¶Î§ÏÂÏŞ buff¸øµÄ¸öÊı£¨1µµ£¬2µµ£© buff1µµ»ñµÃ¸ÅÂÊ(100)
        [1] = { 120, 1, 2, 90 },
        [2] = { 100, 1, 2, 90 },
        [3] = { 80, 1, 2, 80 },
        [4] = { 60, 1, 2, 70 },
    }
    local lvl = GetLevel()
    for i = 1, 4 do
        if (lvl >= fteam_list[i][1]) then
            local r = random(1, 100)
            local nb = fteam_list[i][2]
            if (r > fteam_list[i][4]) then
                nb = fteam_list[i][3]
            end

            for i = 1, nb do
                AddIBBuff(1157)
            end
            ScrollMessage("Hé §¹o: NhËn ®­îc <c=yel>Hµng Ma LÖnh<c>")
            break
        end
    end
end
--½µÄ§»¤µÀ modified by yaoxin for 2009-12-03

------------------------------------ËÄÏóÊÕ¼¯ ÔªËØÌ½Ë÷ 31¼¶------------------------
function Frenwu31()
    --mapgid µØÍ¼ĞòºÅ
    if (GetTask(55) ~= 24) then
        -- Èç¹ûºÍ½ÓµÄÈÎÎñ²»¶ÔÓ¦Ôò²»ÄÜµô
        return 0
    end

    local r_sx = random(1, 100)
    local plvl = GetLevel()
    item_four = {--µÈ¼¶(<=) ¸ÅÂÊ
        [1] = { 50, 50 },
        [2] = { 90, 30 },
        [3] = { 300, 20 },
    }
    for i = 1, 3 do
        if (plvl <= item_four[i][1]) then
            if (r_sx <= item_four[i][2]) then
                TopMessage("May m¾n nhËn ®­îc 1 Thñy Hån")
                AddNormalItemPile(3, 24, 1, 0, 0, 0)
            end
            return 0
        end
    end
end

--Áé»ê³¬¶ÈÈÎÎñ£¨40¼¶£©--·âÉñÌ¨Òóºé
--964 ¹ÖÎï1±êºÅ
--965 ¹ÖÎï2±êºÅ
--966 ÕĞ»ê·«ËùÔÚµØÍ¼id
--967 ÕĞ»ê·«µÄÖĞĞÄÎ»ÖÃx
--968 ÕĞ»ê·«µÄÖĞĞÄÎ»ÖÃy
--969 ÕĞ»ê·«µÄÉèÖÃÆğÊ¼Ê±¼ä
--970 ¹ÖÎï1µÄÁé»ê¸öÊı
--971 ¹ÖÎï2µÄÁé»ê¸öÊı
function Frenwu40(px, py, templateID)
    local px1, py1 = GetTask(967), GetTask(968)
    local rv = (px - px1) ^ 2 + (py - py1) ^ 2

    if (rv <= 200) then
        local p = random(1, 3) --µôÂäÁé»ê¸ÅÂÊ33%
        local dd1 = GetTask(970)
        local dd2 = GetTask(971)
        local d1 = GetTask(964)
        local d2 = GetTask(965)

        if (dd2 < 3) and (templateID == d2) then
            if (p ~= 3) then
                SetTask(971, dd2 + 1)
                TopMessage("Th¶ thµnh c«ng linh hån Háa Ng­")
                Msg2Player("Chiªu Hån Ph­ín:Phãng thİch thµnh c«ng!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", Háa Ng­ ®· gi¶i tho¸t" .. (dd2 + 1) .. ".")
                TaskNote(48, 1, npc_name[d1], GetTask(970), "Háa Ng­", GetTask(971))
            else
                Msg2Player("Th¶ thÊt b¹i!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", Háa Ng­ ®· gi¶i tho¸t" .. dd2 .. ".")
            end
        elseif (dd1 < 3) and (templateID == d1) then
            if (p ~= 2) then
                SetTask(970, dd1 + 1)
                TopMessage("Th¶ thµnh c«ng linh hån Háa Ng­")
                Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thµnh c«ng. Háa Ng­ ®· gi¶i tho¸t" .. (dd1 + 1) .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
                TaskNote(48, 1, "Háa Ng­", GetTask(970), npc_name[d2], GetTask(971))
            else
                Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thÊt b¹i. Háa Ng­ ®· gi¶i tho¸t" .. dd1 .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
            end
        end

        if (GetTask(971) >= 3) and (GetTask(970) >= 3) then
            Msg2Player("Siªu ®é thµnh c«ng! B¹n h·y quay vÒ Phong ThÇn ®µi gÆp ¢n Hång nhËn th­ëng!")
            TaskNote(48, 2)
            SetTask(966, 0)
        end
    else
        Msg2Player("Yªu qu¸i kh«ng ë trong ph¹m vi Chiªu Hån trËn")
    end ;
end

-------------------------------ÕòÔ­´óÏÉ  ³È×°ºÏ³É  42¼¶-----------------------------
function Frenwu42()
    --991	»ñµÃ¼ÓÕòÔ­ÉùÍûbuffµÄÊ±¼ä,¾«È·µ½Ìì
    local rand_buff = random(1, 1000)--
    local today_buff = floor(LocalSystemTime() / 86400)
    if (today_buff ~= GetTask(991)) and (rand_buff >= 990) then
        AddIBBuff(369)
        TopMessage(11647)
        SetTask(991, today_buff)
    end
end

--------------   ËãÃüÏÈÉú----ËÄÏóÁéÏ¬ÈÎÎñ----65¼¶---------------------------------
--mapgid µØÍ¼ĞòºÅ
--1022 1=¹ÖÎïµØÍ¼ºÅ 2=´ò¹Ö¸öÊı
--1023 ÁéÏ¬Öµ
function Frenwu65(mapgid)
    local gmapIdx1 = GetByte(GetTask(1022), 1)
    if (gmapIdx1 == mapgid) then
        local guanKey = mod((gmapIdx1 - 22), 5) + 1

        if (guanKey == 1) or ((GetIBBuffTimes(305 + gmapIdx1 - 22) >= 1) and (guanKey > 1)) then
            local level_add = { 20, 20, 15, 15, 10 }--Ç§·ÖÖ®Ò» hai
            local mgshu = GetByte(GetTask(1022), 2) + 1
            local sgzxs = level_add[guanKey]--Ôö³¤ÏµÊı(Y)
            local r_Luck = random(1, 1000)

            if (r_Luck <= (sgzxs * mgshu)) then
                if (guanKey == 5) then
                    SetTask(1022, 0)
                    RemoveIBBuff(305 + gmapIdx1 - 22)
                    AddIBBuff(305 + gmapIdx1 - 21)
                    TaskNote(54, 2)
                    Msg2Player("Chóc mõng! B¹n ®· gi¶i phãng ®­îc c¸c tinh linh trong mª cung! Mau quay vÒ phôc mÖnh!")
                    TopMessage("Th«ng qua Tø Linh, v­ît qua cöa kh¶o nghiÖm thø <c=g>" .. guanKey .. "<c>.")
                else
                    if (guanKey > 1) then
                        RemoveIBBuff(305 + gmapIdx1 - 22)
                    end
                    AddIBBuff(305 + gmapIdx1 - 21)
                    SetTask(1022, SetByte(GetTask(1022), 1, (gmapIdx1 + 1)))
                    SetTask(1022, SetByte(GetTask(1022), 2, 0))

                    local mw0 = mapname[gmapIdx1]
                    local mw1 = mapname[(gmapIdx1 + 1)]
                    Msg2Player("Chóc mõng b¹n ®· phãng thİch thµnh c«ng" .. mw0 .. "Tø Tinh trong mª cung, b¹n cã thÓ vµo" .. mw1 .. "mª cung tiÕp theo gi¶i cøu Tø tinh cao cÊp h¬n!")
                    TopMessage("Th«ng qua Tø Linh, v­ît qua cöa kh¶o nghiÖm thø <c=g>" .. guanKey .. "<c>.")
                    TaskNote(54, 1, mw0, mw1)
                end
            else
                SetTask(1022, SetByte(GetTask(1022), 2, mgshu))
            end
        end
    else
        local mw0 = mapname[gmapIdx1]
        Msg2Player("Ng­¬i cÇn ph¶i ®Õn " .. mw0 .. " §Ó gi¶i cøu Tø T­îng Tinh Linh! Thêi gian rÊt gÊp! Xin h·y nhanh chãng khëi hµnh!")
    end
end

function suanming(gmapIdx1, plvl)
    if (gmapIdx1 < 22) or (gmapIdx1 > 41) then
        return 0
    end

    local nkey = 0
    map_idx = {
        [1] = { 331, 326, 327, 328 }, --tu	, "É³Ä®"
        [2] = { 351, 342, 343, 344 }, --huo, "ĞùÔ¯¶´"
        [3] = { 352, 345, 346, 347 }, --bing, "±ù´¨"
        [4] = { 353, 348, 349, 350 }--hai, "¶«º£"
    }
    local gmapIdx2 = floor((gmapIdx1 - 22) / 5) + 1
    local lvl = 4
    if (plvl < 100) then
        if (plvl >= 95) then
            lvl = 3
        elseif (plvl >= 65) then
            lvl = floor((plvl - 55) / 10)
        end
    end

    if (HaveIBBuff(map_idx[gmapIdx2][lvl]) > 0) then
        nkey = 1
    end
    return nkey
end


-- Add By Zhang Jin for ¹úÇì½Ú»î¶¯2010 at 2010-09 Begin
NationalDay_Info = {
    -- ÈÎÎñ±äÁ¿¼ÇÂ¼{ÈÕÆÚ£¬µôÂä¸öÊı} µØÍ¼±àºÅ¼¯ºÏ(1µ½5²ã) µôÂä¸ÅÂÊ(¶ÔÓ¦1µ½5²ã){µÚÒ»¸ö£¬µÚ¶ş¸ö} µôÂäÎïÆ·±àºÅ  µôÂäÎïÆ·Ãû×Ö
    { nTaskID = { 1731, 1732 }, mapList = { 27, 28, 29, 30, 31 }, upperLimit = { { 4, 1 }, { 5, 2 }, { 6, 3 }, { 7, 4 }, { 8, 5 } }, itemInfo = { 3, 1136, 0, 0, }, itemName = "V¹n Viªm Ch©u", }, -- »ğ1byte
    { nTaskID = { 1731, 1732 }, mapList = { 22, 23, 24, 25, 26 }, upperLimit = { { 4, 1 }, { 5, 2 }, { 6, 3 }, { 7, 4 }, { 8, 5 } }, itemInfo = { 3, 1134, 0, 0, }, itemName = "HuyÒn Hoang Th¸p", }, -- ÍÁ2byte
    { nTaskID = { 1731, 1732 }, mapList = { 32, 33, 34, 35, 36 }, upperLimit = { { 4, 1 }, { 5, 2 }, { 6, 3 }, { 7, 4 }, { 8, 5 } }, itemInfo = { 3, 1137, 0, 0, }, itemName = "Tö Yªu LÖnh", }, -- ±ù3byte
    { nTaskID = { 1731, 1732 }, mapList = { 37, 38, 39, 40, 41 }, upperLimit = { { 4, 1 }, { 5, 2 }, { 6, 3 }, { 7, 4 }, { 8, 5 } }, itemInfo = { 3, 1135, 0, 0, }, itemName = "H¶i ThÇn Ch©m", }, -- Ë®4byte
}

function NationalDay_Activity()
    local nYear, nMonth, nDay = GetYMD()
    local mapID, nX, nY = GetWorldPos()

    for i = 1, getn(NationalDay_Info) do
        local taskInfo = NationalDay_Info[i]
        local mapList = taskInfo.mapList
        for j = 1, getn(mapList) do
            if (mapID == mapList[j]) then
                local nRand = random(1, 100)
                local nTaskDay = GetTaskByte(taskInfo.nTaskID[1], i)
                local nFlopItem = GetTaskByte(taskInfo.nTaskID[2], i)

                if (IsHaveSpaceForTreasure(2) == 0) then
                    Msg2Player("Hµnh trang ®· ®Çy")
                    ScrollMessage("Hµnh trang ®· ®Çy")
                    return 0
                end

                if (nDay ~= nTaskDay and nRand <= taskInfo.upperLimit[j][1]) then
                    AddNormalItem(taskInfo.itemInfo[1], taskInfo.itemInfo[2], taskInfo.itemInfo[3], taskInfo.itemInfo[4], 0, 0)
                    SetTaskByte(taskInfo.nTaskID[1], i, nDay)
                    SetTaskByte(taskInfo.nTaskID[2], i, 1)
                    Msg2Player("NhËn ®­îc 1" .. taskInfo.itemName .. "Cã thÓ vÒ TriÒu Ca t×m N÷ Oa ®Ó nhËn phÇn th­ëng")
                    ScrollMessage("NhËn ®­îc 1" .. taskInfo.itemName .. "Cã thÓ vÒ TriÒu Ca t×m N÷ Oa ®Ó nhËn phÇn th­ëng")
                    WriteLog(GetName() .. "NhËn ®­îc 1" .. taskInfo.itemName)
                elseif (nDay == nTaskDay and nFlopItem == 1 and nRand <= taskInfo.upperLimit[j][2]) then
                    AddNormalItem(taskInfo.itemInfo[1], taskInfo.itemInfo[2], taskInfo.itemInfo[3], taskInfo.itemInfo[4], 0, 0)
                    SetTaskByte(taskInfo.nTaskID[2], i, nFlopItem + 1)
                    Msg2Player("NhËn ®­îc 1" .. taskInfo.itemName .. "Cã thÓ vÒ TriÒu Ca t×m N÷ Oa ®Ó nhËn phÇn th­ëng")
                    ScrollMessage("NhËn ®­îc 1" .. taskInfo.itemName .. "Cã thÓ vÒ TriÒu Ca t×m N÷ Oa ®Ó nhËn phÇn th­ëng")
                    WriteLog(GetName() .. "NhËn ®­îc 1" .. taskInfo.itemName)
                end
                return 0
            end
        end
    end
end
-- Add By Zhang Jin for ¹úÇì½Ú»î¶¯2010 at 2010-09 End

--²¢·ş»î¶¯ 2009/10/27
--Task_Peace_Day = 1595			--½ÓÈÎÎñµÄÈÕÆÚ
--Task_Peace_Process = 1596		--1byte£ºÃÔ¹¬ÀàĞÍ 1É³Ä®£¬2±ù´¨ 3ĞùÔ¯¶´ 4¶«º££» 2byte£ºÃÔ¹¬µÚ¼¸²ã£¬·¶Î§1~4£» 2World É±¹Ö¸öÊı
--BuffIndex = 1091					--buff±àºÅ
--function taskPeace()

--	local today = floor(LocalSystemTime()/86400)
--	if (GetTask(Task_Peace_Day) ~= today) or (GetTaskByte(Task_Peace_Process, 1) ~= 4) or (GetTaskByte(Task_Peace_Process, 2) ~= 2) then
--		return
--	end

--	local w,x,y=GetWorldPos() --Íæ¼ÒµØÍ¼¼°×ø±ê
--	if (w ~= 38) then --ÅĞ¶Ï´ò¹ÖÊÇ·ñÔÚ¸ÃµØÍ¼
--		return 0
--	end

--	if (GetTeam() ~= 0) then
--		local oldPlayer = PlayerIndex

--		for i=1, GetTeamSize() do
--			PlayerIndex = GetTeamMember(i)
--			if (GetTask(Task_Peace_Day) == today) and (GetTaskByte(Task_Peace_Process, 1) == 4) and (GetTaskByte(Task_Peace_Process, 2) == 2) and (HaveIBBuff(BuffIndex) > 0) then


--				local killNum = GetTaskWord(Task_Peace_Process, 2)
--				if ((HaveIBBuff(BuffIndex) > 0) ) then
--					killNum = killNum + 1
--					SetTaskWord(Task_Peace_Process, 2, killNum)
--					if (killNum < 800) then							--???É±¹Ö¸öÊıĞèÒªĞŞ¸Ä
--						ScrollMessage("×îµÍ»÷É±ÊıÁ¿»¹²î"..(800-killNum).."Ö»")
--						TaskNote(1501, 1, "»ğÓã", killNum, 800)
--					elseif (killNum == 800) and (HaveIBBuff(BuffIndex) > 0) then
--						Msg2Player("ÄúÒÑ¾­Íê³É×îµÍ»÷É±ÊıÁ¿£¬µÚ¶şµµ×îµÍ»÷É±ÊıÁ¿Îª1500Ö»£¬Çë×¢ÒâÊ±¼ä")
--						ScrollMessage("×îµÍ»÷É±Íê³É£¬µÚ¶şµµ×îµÍ»÷É±1500Ö»£¬Çë×¢Òâ")
--						TaskNote(1501, 3, "»ğÓã", killNum, 1500)
--					elseif (killNum < 1500) then
--						ScrollMessage("µÚ¶şµµ»÷É±ÊıÁ¿»¹²î"..(1500-killNum).."Ö»")
--						TaskNote(1501, 3, "»ğÓã", killNum, 1500)
--					elseif (killNum == 1500) and (HaveIBBuff(BuffIndex) > 0) then
--						Msg2Player("ÄúÒÑ¾­Íê³ÉµÚ¶şµµ»÷É±ÊıÁ¿£¬µÚÈıµµ×îµÍ»÷É±ÊıÁ¿Îª2500Ö»£¬Çë×¢ÒâÊ±¼ä")
--						ScrollMessage("µÚ¶şµµÍê³É£¬µÚÈıµµ×îµÍ»÷É±Îª2500Ö»£¬Çë×¢Òâ")
--						TaskNote(1501, 3, "»ğÓã", killNum, 2500)
--					elseif (killNum < 2500) then
--						ScrollMessage("µÚÈıµµ»÷É±ÊıÁ¿»¹²î"..(2500-killNum).."Ö»")
--						TaskNote(1501, 4, "»ğÓã", killNum, 2500)
--					elseif (killNum == 2500) and (HaveIBBuff(BuffIndex) > 0) then
--						Msg2Player("ÄúÒÑ¾­Íê³ÉÈ«²¿µµ´ÎµÄ»÷É±ÊıÁ¿£¬Çë×¢Òâ½»¸¶ÈÎÎñµÄ¼ÆÊ±ÏŞÖÆ")
--						ScrollMessage("Íê³ÉÈÎÎñ£¬Çë×¢Òâ½»¸¶ÈÎÎñµÄÊ±ÏŞ")
--						TaskNote(1501, 7)
--					elseif (killNum >= 2501) and (HaveIBBuff(BuffIndex) > 0) then
--						Msg2Player("ÄúÒÑ¾­Íê³ÉÈ«²¿µµ´ÎµÄ»÷É±ÊıÁ¿£¬Çë×¢Òâ½»¸¶ÈÎÎñµÄ¼ÆÊ±ÏŞÖÆ")
--						ScrollMessage("Íê³ÉÈÎÎñ£¬Çë×¢Òâ½»¸¶ÈÎÎñµÄÊ±ÏŞ")
--						TaskNote(1501, 7)
--					end
--				end
--			end
--		end
--
--		PlayerIndex = oldPlayer
--	else
--		--local killNum = GetTaskWord(Task_Peace_Process, 2)
--		if (GetTask(Task_Peace_Day) == today) and (GetTaskByte(Task_Peace_Process, 1) == 4) and (GetTaskByte(Task_Peace_Process, 2) == 2) and (HaveIBBuff(BuffIndex) > 0) then


--			local killNum = GetTaskWord(Task_Peace_Process, 2)
--			if ((HaveIBBuff(BuffIndex) > 0) ) then
--				killNum = killNum + 1
--				SetTaskWord(Task_Peace_Process, 2, killNum)
--					if (killNum < 800) then							--???É±¹Ö¸öÊıĞèÒªĞŞ¸Ä
--						ScrollMessage("×îµÍ»÷É±ÊıÁ¿»¹²î"..(800-killNum).."Ö»")
--						TaskNote(1501, 1, "»ğÓã", killNum, 800)
--					elseif (killNum == 800) and (HaveIBBuff(BuffIndex) > 0) then
--						Msg2Player("ÄúÒÑ¾­Íê³É×îµÍ»÷É±ÊıÁ¿£¬µÚ¶şµµ×îµÍ»÷É±ÊıÁ¿Îª1500Ö»£¬Çë×¢ÒâÊ±¼ä")
--						ScrollMessage("×îµÍ»÷É±Íê³É£¬µÚ¶şµµ×îµÍ»÷É±1500Ö»£¬Çë×¢Òâ")
--						TaskNote(1501, 3, "»ğÓã", killNum, 1500)
--					elseif (killNum < 1500) then
--						ScrollMessage("µÚ¶şµµ»÷É±ÊıÁ¿»¹²î"..(1500-killNum).."Ö»")
--						TaskNote(1501, 3, "»ğÓã", killNum, 1500)
--					elseif (killNum == 1500) and (HaveIBBuff(BuffIndex) > 0) then
--						Msg2Player("ÄúÒÑ¾­Íê³ÉµÚ¶şµµ»÷É±ÊıÁ¿£¬µÚÈıµµ×îµÍ»÷É±ÊıÁ¿Îª2500Ö»£¬Çë×¢ÒâÊ±¼ä")
--						ScrollMessage("µÚ¶şµµÍê³É£¬µÚÈıµµ×îµÍ»÷É±Îª2500Ö»£¬Çë×¢Òâ")
--						TaskNote(1501, 3, "»ğÓã", killNum, 2500)
--					elseif (killNum < 2500) then
--						ScrollMessage("µÚÈıµµ»÷É±ÊıÁ¿»¹²î"..(2500-killNum).."Ö»")
--						TaskNote(1501, 4, "»ğÓã", killNum, 2500)
--					elseif (killNum == 2500) and (HaveIBBuff(BuffIndex) > 0) then
--						Msg2Player("ÄúÒÑ¾­Íê³ÉÈ«²¿µµ´ÎµÄ»÷É±ÊıÁ¿£¬Çë×¢Òâ½»¸¶ÈÎÎñµÄ¼ÆÊ±ÏŞÖÆ")
--						ScrollMessage("Íê³ÉÈÎÎñ£¬Çë×¢Òâ½»¸¶ÈÎÎñµÄÊ±ÏŞ")
---                        TaskNote(1501, 7)
--					elseif (killNum >= 2501) and (HaveIBBuff(BuffIndex) > 0) then
--						Msg2Player("ÄúÒÑ¾­Íê³ÉÈ«²¿µµ´ÎµÄ»÷É±ÊıÁ¿£¬Çë×¢Òâ½»¸¶ÈÎÎñµÄ¼ÆÊ±ÏŞÖÆ")
--						ScrollMessage("Íê³ÉÈÎÎñ£¬Çë×¢Òâ½»¸¶ÈÎÎñµÄÊ±ÏŞ")
--						TaskNote(1501, 7)
--					end
--			end
--		end
--	end


--end
--²¢·ş»î¶¯ 2009/10/27

--add by liujifang for ÁùÒ»»î¶¯ at 10-05-13 begin------------
--function ChildrensDay()
--	local num = GetTaskByte(Task_ChildrensDay, 2) + 1
--	local name = "»ğÓã"
--	if num < 61 then
--		ScrollMessage("ÄÄß¸µÄÍĞ¸¶£ºÒÑÁÔÉ±»ğÓã"..num.."Ö»¡£")
--		SetTaskByte(Task_ChildrensDay, 2, num)
--		TaskNote(1605, 1, num, name)
--	elseif num == 61 then
--		ScrollMessage("ÄÄß¸µÄÍĞ¸¶£ºÍê³ÉÈÎÎñ")
--		SetTaskByte(Task_ChildrensDay, 2, num)
--		SetTaskByte(Task_ChildrensDay, 1, 2)
--		TaskNote(1605, 2)
--	end
--end
--add by liujifang for ÁùÒ»»î¶¯ at 10-05-13 end-----------


--Add By Guoqun for ÊîÆÚ»î¶¯ at 2010-07-09 Begin
Task_State = 1710    -- ¼ÇÂ¼ÈÎÎñ×´Ì¬
-- 1Byte£ºÈÎÎñ±àºÅ (10-12) < 10 ´ú±í  0ºÅ£º´ú±íµÚÒ»¸öÈÎÎñ 10ºÅ´ú±íµÚ¶ş¸ö~11ºÅ´ú±íµÚ¶ş¸ö
-- 2Byte:  ÈÎÎñ²½Öè
-- 3Byte:  ½ÓÈÎÎñÊ±¼ä
-- 4Byte:  ÊÍ·Å·¨ÕóµÄ×´Ì¬¡£0 and Iscaption : ¿É·Å¡£1£º¿É·Å¡£2£º´ı·Å¡£3£ºÒÑ·Å¡£

Pos_TaskValue = { 1711, 1712, 1713 }

Fazhen_Item = { 6, 1, 841, 0 }

Task_MapID = 37        --¶«º£Ë®Óò

Fazhen_Index = 1714
Fazhen_ID = 1715

Ninety_SecondBuff = 1310    --·É»ê·¨ÕóBuff ID

--Add By Guoqun for ÊîÆÚ»î¶¯ at 2010-07-09 End

function Cool_Summer()

    if HaveIBBuff(Ninety_SecondBuff) > 0 then
        local mapid, x, y = GetWorldPos()
        if Is_InArea(mapid, x, y) == 1 then
            if random(1, 100) <= 10 then
                local nCount = GetTaskByte(Task_State, 1);
                if IsHaveSpaceForTreasure(1) == 0 then
                    Msg2Player("Hµnh trang ®· ®Çy, kh«ng thÓ nhËn ®­îc Tş Thö Ch©u")
                else
                    if nCount >= 1 and nCount < 6 then
                        SetTaskByte(Task_State, 1, nCount + 1)
                        AddNormalItem(3, 1124, 0, 0, 0, 0);
                        ScrollMessage("NhËn ®­îc Tş Thö Ch©u");
                        Msg2Player("NhËn ®­îc Tş Thö Ch©u");
                        WriteLog("NhËn ®­îc 1 Tş Thö Ch©u")
                        if nCount >= 5 then
                            RemoveIBBuff(Ninety_SecondBuff)
                            TaskNote(1606, -1)
                            SetTaskByte(Task_State, 1, 9)
                        end
                    end
                end
            else
                ScrollMessage("VËn khİ kh«ng tèt, ch­a thÓ nhËn ®­îc Tş Thö Ch©u, h·y tiÕp tôc nç lùc!")
                Msg2Player("VËn khİ kh«ng tèt, ch­a thÓ nhËn ®­îc Tş Thö Ch©u, h·y tiÕp tôc nç lùc!");
            end
        else
            Msg2Player("Xin tiªu diÖt qu¸i vËt trong ph¹m vi h×nh tam gi¸c mµ b¹n vµ tæ ®éi t¹o ra!");
        end
    end

end

function Is_InArea(mapid, x, y)
    local item = {
        [1] = {},
        [2] = {},
        [3] = {},
    }

    item[1][1] = GetTaskWord(Pos_TaskValue[1], 1);
    item[1][2] = GetTaskWord(Pos_TaskValue[1], 2);

    item[2][1] = GetTaskWord(Pos_TaskValue[2], 1);
    item[2][2] = GetTaskWord(Pos_TaskValue[2], 2);

    item[3][1] = GetTaskWord(Pos_TaskValue[3], 1);
    item[3][2] = GetTaskWord(Pos_TaskValue[3], 2);

    local temp = {}
    local k, x1, key = 0, 0, 0

    if mapid ~= 37 then
        return 0
    end

    temp = item

    for j = 1, getn(temp) do
        k = mod(j + 1, getn(temp) + 1)
        if (k == 0) then
            k = 1
        end
        if (temp[j][2] ~= temp[k][2]) then
            -- p1p2 Óë y=p0.yÆ½ĞĞ
            if (y >= min(temp[j][2], temp[k][2])) then
                --½»µãÔÚp1p2ÑÓ³¤ÏßÉÏ
                if (y < max(temp[j][2], temp[k][2])) then
                    --½»µãÔÚp1p2ÑÓ³¤ÏßÉÏ
                    --Çó½»µãx×ø±ê
                    if (temp[k][2] - temp[j][2] == 0) then
                        return 0
                    end

                    x1 = (y - temp[j][2]) * (temp[k][1] - temp[j][1]) / (temp[k][2] - temp[j][2]) + temp[j][1]

                    if (x1 > x) then
                        key = key + 1 --Ö»Í³¼Æµ¥±ß½»µã
                    end
                end
            end
        end
    end
    if (mod(key, 2) == 1) then
        return 1
    end
    return 0
end

function Cool_Summer_Task2()

    if HaveIBBuff(1311) > 0 then
        local nType = GetTaskByte(Task_State, 4);
        --if nType == 1 then
        nRand = 10
        --elseif nType == 2 then
        --	nRand = 100
        --elseif nType == 3 then
        --	nRand = 3
        --end

        if random(1, 1000) <= nRand then
            local nCount = GetTaskByte(Task_State, 1);
            if IsHaveSpaceForTreasure(1) == 0 then
                Msg2Player("Hµnh trang ®· ®Çy, kh«ng thÓ nhËn ®­îc Thanh L­¬ng T¸n")
            else
                if nCount >= 10 and nCount < 15 then
                    AddNormalItem(3, 1125, 0, 0, 0, 0);
                    ScrollMessage("NhËn ®­îc Thanh L­¬ng T¸n");
                    Msg2Player("NhËn ®­îc Thanh L­¬ng T¸n");
                    WriteLog("NhËn ®­îc 1 Thanh L­¬ng T¸n")
                    SetTaskByte(Task_State, 1, nCount + 1);
                end

                if (nCount + 1) > 12 then
                    SetTaskByte(Task_State, 4, 3)    --¸ÅÂÊ±äÎª1%
                end
            end
        else
            ScrollMessage("Ch­a thÓ nhËn ®­îc Thanh L­¬ng T¸n, h·y tiÕp tôc nç lùc!");
        end
    end
end
