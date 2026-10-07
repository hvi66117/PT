--description: ±ùÁé
--author: yaoxin
--date: 2008/07/29

-----------jiangshanyijiu add by gongpeng at 2009.05.04---------
-- 1Byte 0Î´½øĞĞ¾íÒ»£»1 ¾íÒ»Íê³É£»2 ¾í¶şÍê³É£»3 ¾íÈıÍê³É
-- 2Byte 0³õÊ¼£»1 »ÃÏó1Íê³É£»2 »ÃÏó2Íê³É£»...ÒÀ´ÎÀàÍÆ
TASK_JIANGSHAN = 1426
TASK_JS_BOOK2 = 1433 -- 1Byte:¼ÆÊı; 2Byte:×´Ì¬; 3Byte: ÊÇ·ñÍê³Éµ±Ç°µÄ»ÃÏë
TASK_ITEM_IDX = 1434 -- item's index, GetNpcWorldPos(GetTask(TASK_ITEM_IDX))
TASK_JS_HX_TIME = 1435 -- ÁìÈ¡µØÍ¼µÄÊ±¼ä
TASK_JS_DIST = 1436 -- ½­É½ÒÀ¾É »ÃÏó ÉÏÒ»´ÎµÄ¾àÀë
TASK_JS_COUNT = 1437 -- 1Byte: Ò³4µÄ¼ÆÊıÆ÷


Task_hengcai = 1214;
--1bitÎªÊÇ·ñ½ÓÌì½µºá²ÆÈÎÎñ;2bitÎªÊÇ·ñÍê³ÉÌì½µºá²ÆÈÎÎñ;3bitÎªÊÇ·ñ½«µÀ¾ß½»¸ø³¯¸èØÔÊ¦;4bitÎªÊÇ·ñ½«µÀ¾ß½»¸øÎ÷áªØÔÊ¦;5bitÎªÊÇ·ñÒÑ½ÓÅ£µ¶Ğ¡ÊÔ;6bitÎªÊÇ·ñÍê³ÉÅ£µ¶Ğ¡ÊÔ

-----------³õÏÖ¶ËÄß ÈıÓãÖ®ÂÒ¡¢»ğÀëĞ¡Ñı¡¢±³ºóÖ÷Ä±-----------------
Task_Variety_Process = 1389        --1byte: 0Ã»ÁìÈÎÎñ£¬1ÁìÁËÈÎÎñ 2ÔÚĞÇ¹Ù´¦ÁìÈ¡ÁË½±Àø 3ÁìÈ¡ÁËÌ½ÖªÉ³»êµÄÈÎÎñ 4³É¹¦Óëµ¥´¿É³»ê¶Ô»° 5ÔÚ»ÆÌì»¯´¦ÁìÈ¡ÁË½±Àø
--6ÁìÈ¡ÁËÉ±ÈıÓãµÄÈÎÎñ  7ÓëÒ½Éú¶Ô»° 8Óë´óÍ·Óã¶Ô»° 9ÓëÕÛÂŞÓã¶Ô»° 10Óë¾Ş¹ÇÉàÓã¶Ô»° 11ÔÚ»ÆÌì»¯´¦½±Àø

--12¼ûÍê×£ÈÚ£¬13É±Íê15¸ö»ğÀëĞ¡Ñı£¬14µÃµ½½õ²¯£¬15×£ÈÚÔÄ¶Á¼ÇÒäºó£¬16ÁìÈ¡»ÆÌì»¯½±Àø    -----»ğÀë¾«ÆÇ
--17¸Õ½ÓÊÜÁË»ÆÌì»¯µÄÄ»ºóÖ÷Ä±ÈÎÎñ£¬18É±¼¸¸ö±ùÁéºó£¬19µÃµ½ÈıÕÅ±ÜÀ×·ûºó£¬									-----±³ºóÖ÷Ä±

--2byte: 1½Óµ½¹ı³õ¼û¶ËÄßµÄÍ¨Öª 2½Óµ½¹ıÈıÓãÖ®ÂÒµÄÍ¨Öª 3½Óµ½¹ı»ğÀë¾«ÆÇµÄÍ¨Öª 4 ½Óµ½¹ı±³ºóÖ÷Ä±µÄÍ¨Öª
--3byte£º±¾´ÎÉ±ËÀ»ğÀëĞ¡ÑıµÄÊıÄ¿
--4Byte:±¾´ÎÉ±ËÀ¾úÈËµÄÊıÄ¿


npc_name = {
    [28] = "B¨ng Linh",
    [33] = "Phi Gi¸p",
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

    -------------------------ÒÔÉÏÎª¹²ÏíµÄ±äÁ¿ ½ûÖ¹ÖØĞÂ¸³Öµ----------------------
    if (npcchr >= 0) and (npcchr <= 7) then
        local i = GetLevel() - 50
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

            if (GetTask(897) == 28) then
                local mark = judge_relation()
                if (mark > -1) then
                    mission_PR(w, mark)    --Ê¦Í½ÁÔÉ±ÈÎÎñ
                end
            end
        end
        PlayerIndex = oldPlayer
    else
        -- ÎŞ¶ÓÎé
        --Ó¶±øÓªÁÔÉ±ÈÎÎñ
        if (GetTask(854) > 0) then
            liesha_city(w)
        end
    end ;

    -------------------------------------------------------------------------------------
    if (SystemTime() <= (GetTask(969) + 200)) then
        if (GetTask(966) == mapgid) then
            Frenwu40(px, py, 28)--Áé»ê³¬¶ÈÈÎÎñ£¨40¼¶£©--·âÉñÌ¨Òóºé
        end
    end ;

    if (HaveIBBuff(293) >= 1) then
        if (mapgid >= 32) and (mapgid < 37) then
            Frenwu31()--ËÄÏóÊÕ¼¯ ÔªËØÌ½Ë÷ 31¼¶
        end
    end

    if (GetTask(936) == 5) then
        Frenwu42()--ÕòÔ­´óÏÉ  ³È×°ºÏ³É  42¼¶
    end

    if (suanming(GetByte(GetTask(1022), 1), GetLevel()) == 1) then
        Frenwu65(mapgid)--   ËãÃüÏÈÉú----ËÄÏóÁéÏ¬ÈÎÎñ----65¼¶
    end

    --------------------±³ºóÖ÷Ä± Added by Laiyongcong 2009-04-20 begin--------------
    local m_step = GetTaskByte(Task_Variety_Process, 1)
    if (m_step == 17 or m_step == 18) then
        ProcessVariety(m_step)
    end
    --------------------±³ºóÖ÷Ä± Added by Laiyongcong 2009-04-20 end----------------


    -----------jiangshanyijiu add by gongpeng at 2009.05.04 begin---------
    if ((mapgid >= 32) and (mapgid <= 36)) then
        if (GetTeam() ~= 0) then
            -- ÓĞ¶ÓÎé(°üÀ¨Ö»ÓĞ×Ô¼ºÒ»¸öÈËµÄ)
            local oldPlayer = PlayerIndex
            local membercount = GetTeamSize()

            for i = 1, membercount do
                PlayerIndex = GetTeamMember(i)

                if ((GetTaskByte(TASK_JIANGSHAN, 1) == 1) and (GetTaskByte(TASK_JS_BOOK2, 3) == 1)) then
                    jsyj(mapgid)
                end
            end

            PlayerIndex = oldPlayer

        else
            -- ÎŞ¶ÓÎé
            if ((GetTaskByte(TASK_JIANGSHAN, 1) == 1) and (GetTaskByte(TASK_JS_BOOK2, 3) == 1)) then
                jsyj(mapgid)
            end
        end
    end
    -----------jiangshanyijiu add by gongpeng at 2009.05.04 end-----------
    -- Added by Zhaoqingsong at 2009-6-5 Begin
    processJiangshan(mapgid)
    -- Added by Zhaoqingsong at 2009-6-5 End

    --²¢·ş»î¶¯ 2009/10/27
    --	taskPeace()
    --²¢·ş»î¶¯ 2009/10/27

end

-----------jiangshanyijiu add by gongpeng at 2009.05.04 begin---------
function jsyj(world)
    local js_w, js_x, js_y = GetWorldPos()
    if (js_w ~= world) then
        return
    end

    local js_n = GetTaskByte(TASK_JS_COUNT, 1)
    if (js_n == 49) then
        SetTaskByte(TASK_JS_COUNT, 1, 50)
        TopMessage("B¨ng Linh: Xin anh hïng tha m¹ng!")
        Msg2Player("§· chøng thùc sù anh dòng cña D­ Kh¸nh n¨m x­a khi tiªu diÖt B¨ng Linh, vÒ phôc mÖnh D­ Kh¸nh")
        FinishNpcCollection(12)
        TaskNote(1057, 1)
    elseif (js_n < 49) then
        SetTaskByte(TASK_JS_COUNT, 1, js_n + 1)
        ScrollMessage("Giang S¬n Y Cùu: Hµng phôc" .. (js_n + 1) .. " B¨ng Linh")
        TaskNote(1057, 0, js_n + 1)
    end
end
-----------jiangshanyijiu add by gongpeng at 2009.05.04 end-----------


--------------------±³ºóÖ÷Ä± Added by Laiyongcong 2009-04-20 begin--------------
function ProcessVariety(step)
    if (step == 17) then
        if (random(1, 100) <= 50) then
            ScrollMessage("B¨ng Linh kh«ng dÔ hµng phôc, ph¶i t×m c¸ch kh¸c vËy")
            Msg2Player("§i t×m Kh­¬ng Tö Nha, cã thÓ «ng ta sÏ cã c¸ch hµng B¨ng Linh")
            SetTaskByte(Task_Variety_Process, 1, 18)
            TaskNote(1047, 1)
        end
    else
        ScrollMessage("B¨ng Linh kh«ng dÔ hµng phôc, ph¶i t×m c¸ch kh¸c vËy")
    end
end
--------------------±³ºóÖ÷Ä± Added by Laiyongcong 2009-04-20 end----------------

--Ê¦Í½ÁÔÉ±ÈÎÎñ
function judge_relation()
    --Âú×ãÊ¦Í½2ÈË¶Ó
    local mark = -1
    if (GetTeam() ~= 0) then
        -- ÓĞ¶ÓÎé
        if (GetTeamSize() == 2) then
            --2ÈË¶Ó
            local n = 0
            if (IsCaptain() == 0) then
                n = GetTeamMember(1)
            else
                n = GetTeamMember(2)
            end

            if (IsMasterPRRelation(n) == 1) then
                local oldPlayer = PlayerIndex
                local w1, x1, y1, w, x, y
                w, x, y = GetWorldPos()

                PlayerIndex = n
                mark = n --·µ»Ø¶ÓÓÑµÄplayerindex
                w1, x1, y1 = GetWorldPos()
                if (w1 ~= w) then
                    mark = -1
                end
                PlayerIndex = oldPlayer
            end
        end
    end
    return mark
end

function mission_PR(world, masterindex)
    local count = GetTask(898)
    local mark = HaveIBBuff(215)    --ÅĞ¶ÏÁÔÉ±ÈÎÎñµÄ±êÖ¾buff
    local w, x, y = GetWorldPos()
    if (world == w) then
        if (mark ~= 0) then
            if (count > 1) then
                SetTask(898, count - 1)
                Msg2Player("Trõ Yªu: B¹n cßn ph¶i diÖt " .. (count - 1) .. "B¨ng Linh!")
                if (mod(count, 50) == 0) then
                    local oldplayer = PlayerIndex
                    PlayerIndex = masterindex
                    Msg2Player("Trõ Yªu: B¹n cßn ph¶i diÖt " .. (count - 1) .. "B¨ng Linh!")
                    PlayerIndex = oldplayer
                end
            elseif (count == 1) then
                SetTask(898, 0)
                TaskNote(42, 8)
                Msg2Player("Trõ Yªu: §· hoµn thµnh tiªu diÖt B¨ng Linh!")
            end
        else
            if (count > 0) then
                Msg2Player("Trõ Yªu: Vßng s¸ng trõ yªu biÕn mÊt, nhiÖm vô Trõ yªu thÊt b¹i.")
            end
        end
    end
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

    if (type1 == 28 and count1 > 0) then
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
    elseif (type2 == 28 and count2 > 0) then
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

function no()
    CloseDialog()
end;

------------------------------------ËÄÏóÊÕ¼¯ ÔªËØÌ½Ë÷ 31¼¶------------------------
function Frenwu31()
    --mapgid µØÍ¼ĞòºÅ
    if (GetTask(55) ~= 23) then
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
                TopMessage("May m¾n nhËn ®­îc 1 Phong LÖ")
                AddNormalItemPile(3, 23, 1, 0, 0, 0)
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
                TopMessage("Gi¶i tho¸t linh hån B¨ng Linh thµnh c«ng")
                Msg2Player("Chiªu Hån Ph­ín:Phãng thİch thµnh c«ng!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", B¨ng Linh ®· gi¶i tho¸t" .. (dd2 + 1) .. ".")
                TaskNote(48, 1, npc_name[d1], GetTask(970), "B¨ng Linh", GetTask(971))
            else
                Msg2Player("Th¶ thÊt b¹i!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", B¨ng Linh ®· gi¶i tho¸t" .. dd2 .. ".")
            end
        elseif (dd1 < 3) and (templateID == d1) then
            if (p ~= 2) then
                SetTask(970, dd1 + 1)
                TopMessage("Gi¶i tho¸t linh hån B¨ng Linh thµnh c«ng")
                Msg2Player("Chiªu Hån ph­ín: Th¶ thµnh c«ng! B¨ng Linh ®· gi¶i tho¸t" .. (dd1 + 1) .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
                TaskNote(48, 1, "B¨ng Linh", GetTask(970), npc_name[d2], GetTask(971))
            else
                Msg2Player("Chiªu Hån ph­ín: Th¶ thÊt b¹i! B¨ng Linh ®· gi¶i tho¸t" .. dd1 .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
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
            local level_add = { 20, 20, 15, 15, 15 }--Ç§·ÖÖ®Ò»
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

-- Added by Zhaoqingsong at 2009-6-5 begin 

TASK_JIANGSHAN_ONE_TWO = 1475
TASK_JIANGSHAN_ONE_TWO_INFO = 1081

CONST_JS_XIANGSHU = {
    { name = "Th­ hµng cña B¨ng Linh", boss = "B¨ng Linh B¨ng Xuyªn", item = { 4, 258, 0, 1 } }, -- ±ùÁéµÄ½µÊé
    { name = "Th­ hµng cña Háa Ma", boss = "Háa Ma Hiªn Viªn §éng", item = { 4, 259, 0, 1 } }, -- ÑÒ½¬ÊŞµÄ½µÊé
}

CONST_JS_DROP_RAND = {
    { name = "X¸c suÊt thÊp", total = 1000, ratio = 1 }, -- µÍ¸ÅÂÊ
    { name = "X¸c suÊt cao", total = 1000, ratio = 30 }, -- ¸ß¸ÅÂÊ
}

function processJiangshan(mapgid)

    local taskStatus = GetTaskByte(TASK_JIANGSHAN_ONE_TWO, 1)
    local bossIndex = GetTaskByte(TASK_JIANGSHAN_ONE_TWO, 2)

    if (taskStatus ~= 1 or bossIndex ~= 1) then
        return
    end
    local class, detail, particular, level = myunpack(CONST_JS_XIANGSHU[bossIndex].item)
    local haveItem = HaveNormalItem(class, detail, particular, level)
    if (haveItem == 0) then
        return
    end
    if (GetBoxSize(0, 2) <= 0) then
        return 0
    end

    local randIndex = 1
    if (suanming(GetByte(GetTask(1022), 1), GetLevel()) == 1) then
        local gmapIdx1 = GetByte(GetTask(1022), 1)
        if (gmapIdx1 == mapgid) then
            local guanKey = mod((gmapIdx1 - 22), 5) + 1
            if (guanKey == 1) or ((GetIBBuffTimes(305 + gmapIdx1 - 22) >= 1) and (guanKey > 1)) then
                -- ËÄÏóÁéÏ¬ÈÎÎñ
                randIndex = 2
            end
        end
    end
    if (randIndex == 1) then
        if (GetLevel() < 55) then
            return
        end
    end

    local rand = random(1, CONST_JS_DROP_RAND[randIndex].total)
    if (rand <= CONST_JS_DROP_RAND[randIndex].ratio) then
        DelNormalItem(class, detail, particular, level)
        SetTaskByte(TASK_JIANGSHAN_ONE_TWO, 1, 2)
        AddNormalItem(4, 260, 0, 1, 0, 0)  -- ½µ±í
        TaskNote(TASK_JIANGSHAN_ONE_TWO_INFO, 1)
        TopMessage("NhËn 1 <c=yel>Hµng biÓu")
        Msg2Player("NhËn 1 Hµng biÓu, cã thÓ ®­a cho D­ Kh¸nh ë TriÒu Ca.")
    end
end

function myunpack(t, i)
    i = i or 1
    if t[i] then
        return t[i], myunpack(t, i + 1)
    end
end
-- Added by Zhaoqingsong at 2009-6-5 end 
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

----²¢·ş»î¶¯ 2009/10/27
--Task_Peace_Day = 1595			--½ÓÈÎÎñµÄÈÕÆÚ
--Task_Peace_Process = 1596		--1byte£ºÃÔ¹¬ÀàĞÍ 1É³Ä®£¬2±ù´¨ 3ĞùÔ¯¶´ 4¶«º££» 2byte£ºÃÔ¹¬µÚ¼¸²ã£¬·¶Î§1~4£» 2World É±¹Ö¸öÊı
--BuffIndex = 1091					--buff±àºÅ
--function taskPeace()
--	
--	local today = floor(LocalSystemTime()/86400)
--	if (GetTask(Task_Peace_Day) ~= today) or (GetTaskByte(Task_Peace_Process, 1) ~= 2) or (GetTaskByte(Task_Peace_Process, 2) ~= 1) then
--		return
--	end
--	
--	local w,x,y=GetWorldPos() --Íæ¼ÒµØÍ¼¼°×ø±ê
--	if (w ~= 32) then --ÅĞ¶Ï´ò¹ÖÊÇ·ñÔÚ¸ÃµØÍ¼
--		return 0
--	end
--
--	if (GetTeam() ~= 0) then
--		local oldPlayer = PlayerIndex
--		
--		for i=1, GetTeamSize() do
--			PlayerIndex = GetTeamMember(i)
--			if (GetTask(Task_Peace_Day) == today) and (GetTaskByte(Task_Peace_Process, 1) == 2) and (GetTaskByte(Task_Peace_Process, 2) == 1) and (HaveIBBuff(BuffIndex) > 0) then 
--				
--				
--				local killNum = GetTaskWord(Task_Peace_Process, 2)
--				if ((HaveIBBuff(BuffIndex) > 0 ) ) then
--					killNum = killNum + 1
--					SetTaskWord(Task_Peace_Process, 2, killNum)
--					if (killNum < 550) then							--???É±¹Ö¸öÊıĞèÒªĞŞ¸Ä
--						ScrollMessage("×îµÍ»÷É±ÊıÁ¿»¹²î"..(550-killNum).."Ö»")
--						TaskNote(1501, 1, "±ùÁé", killNum, 550)
--					elseif (killNum == 550) and (HaveIBBuff(BuffIndex) > 0) then
--						Msg2Player("ÄúÒÑ¾­Íê³É×îµÍ»÷É±ÊıÁ¿£¬µÚ¶şµµ×îµÍ»÷É±ÊıÁ¿Îª700Ö»£¬Çë×¢ÒâÊ±¼ä")
--						ScrollMessage("×îµÍ»÷É±Íê³É£¬µÚ¶şµµ×îµÍ»÷É±700Ö»£¬Çë×¢Òâ")
--						TaskNote(1501, 3, "±ùÁé", killNum, 700)
--					elseif (killNum < 700) then
--						ScrollMessage("µÚ¶şµµ»÷É±ÊıÁ¿»¹²î"..(700-killNum).."Ö»")
--						TaskNote(1501, 3, "±ùÁé", killNum, 700)
--					elseif (killNum == 700) and (HaveIBBuff(BuffIndex) > 0) then
--						Msg2Player("ÄúÒÑ¾­Íê³ÉµÚ¶şµµ»÷É±ÊıÁ¿£¬µÚÈıµµ×îµÍ»÷É±ÊıÁ¿Îª1500Ö»£¬Çë×¢ÒâÊ±¼ä")
--						ScrollMessage("µÚ¶şµµÍê³É£¬µÚÈıµµ×îµÍ»÷É±1500Ö»£¬Çë×¢Òâ")
--						TaskNote(1501, 3, "±ùÁé", killNum, 1500)
--					elseif (killNum < 1500) then
--						ScrollMessage("µÚÈıµµ»÷É±ÊıÁ¿»¹²î"..(1500-killNum).."Ö»")
--						TaskNote(1501, 4, "±ùÁé", killNum, 1500)
--					elseif (killNum == 1500) and (HaveIBBuff(BuffIndex) > 0) then
--						Msg2Player("ÄúÒÑ¾­Íê³ÉÈ«²¿µµ´ÎµÄ»÷É±ÊıÁ¿£¬Çë×¢Òâ½»¸¶ÈÎÎñµÄ¼ÆÊ±ÏŞÖÆ")
--						ScrollMessage("Íê³ÉÈÎÎñ£¬Çë×¢Òâ½»¸¶ÈÎÎñµÄÊ±ÏŞ")
--						TaskNote(1501, 7)
--					elseif (killNum >= 1501) and (HaveIBBuff(BuffIndex) > 0) then
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
--		if (GetTask(Task_Peace_Day) == today) and (GetTaskByte(Task_Peace_Process, 1) == 2) and (GetTaskByte(Task_Peace_Process, 2) == 1) and (HaveIBBuff(BuffIndex) > 0) then 
--			
--			
--			local killNum = GetTaskWord(Task_Peace_Process, 2)
--			if ((HaveIBBuff(BuffIndex) > 0) ) then
--				killNum = killNum + 1
--				SetTaskWord(Task_Peace_Process, 2, killNum)
--					if (killNum < 550) then							--???É±¹Ö¸öÊıĞèÒªĞŞ¸Ä
--						ScrollMessage("×îµÍ»÷É±ÊıÁ¿»¹²î"..(550-killNum).."Ö»")
--						TaskNote(1501, 1, "±ùÁé", killNum, 550)
--					elseif (killNum == 550) and (HaveIBBuff(BuffIndex) > 0) then
--						Msg2Player("ÄúÒÑ¾­Íê³É×îµÍ»÷É±ÊıÁ¿£¬µÚ¶şµµ×îµÍ»÷É±ÊıÁ¿Îª700Ö»£¬Çë×¢ÒâÊ±¼ä")
--						ScrollMessage("×îµÍ»÷É±Íê³É£¬µÚ¶şµµ×îµÍ»÷É±700Ö»£¬Çë×¢Òâ")
--						TaskNote(1501, 3, "±ùÁé", killNum, 700)
--					elseif (killNum < 700) then
--						ScrollMessage("µÚ¶şµµ»÷É±ÊıÁ¿»¹²î"..(700-killNum).."Ö»")
--						TaskNote(1501, 3, "±ùÁé", killNum, 700)
--					elseif (killNum == 700) and (HaveIBBuff(BuffIndex) > 0) then
--						Msg2Player("ÄúÒÑ¾­Íê³ÉµÚ¶şµµ»÷É±ÊıÁ¿£¬µÚÈıµµ×îµÍ»÷É±ÊıÁ¿Îª1500Ö»£¬Çë×¢ÒâÊ±¼ä")
--						ScrollMessage("µÚ¶şµµÍê³É£¬µÚÈıµµ×îµÍ»÷É±1500Ö»£¬Çë×¢Òâ")
--						TaskNote(1501, 3, "±ùÁé", killNum, 1500)
--					elseif (killNum < 1500) then
--						ScrollMessage("µÚÈıµµ»÷É±ÊıÁ¿»¹²î"..(1500-killNum).."Ö»")
--						TaskNote(1501, 4, "±ùÁé", killNum, 1500)
--					elseif (killNum == 1500) and (HaveIBBuff(BuffIndex) > 0) then
--						Msg2Player("ÄúÒÑ¾­Íê³ÉÈ«²¿µµ´ÎµÄ»÷É±ÊıÁ¿£¬Çë×¢Òâ½»¸¶ÈÎÎñµÄ¼ÆÊ±ÏŞÖÆ")
--						ScrollMessage("Íê³ÉÈÎÎñ£¬Çë×¢Òâ½»¸¶ÈÎÎñµÄÊ±ÏŞ")
--						TaskNote(1501, 7)
--					elseif (killNum >= 1501) and (HaveIBBuff(BuffIndex) > 0) then
--						Msg2Player("ÄúÒÑ¾­Íê³ÉÈ«²¿µµ´ÎµÄ»÷É±ÊıÁ¿£¬Çë×¢Òâ½»¸¶ÈÎÎñµÄ¼ÆÊ±ÏŞÖÆ")
--						ScrollMessage("Íê³ÉÈÎÎñ£¬Çë×¢Òâ½»¸¶ÈÎÎñµÄÊ±ÏŞ")
--						TaskNote(1501, 7)
--					end
--			end
--		end
--	end
--	
--	
--end
----²¢·ş»î¶¯ 2009/10/27
