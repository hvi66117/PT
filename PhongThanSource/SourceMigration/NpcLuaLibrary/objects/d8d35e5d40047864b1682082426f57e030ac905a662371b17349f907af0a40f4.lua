--description: ÎäÊ¿¹ê
--author: yaoxin
--date: 2008/07/29

---------------------ĞÇ¹â÷öµ­-----------------
Task_star = 1417 -- 1byte: 1:ĞÇ¹Ù´¦½ÓĞÇ¹â÷öµ­ÈÎÎñ£»2:»ÄÄ®Ò½Éú´¦Ìıµ½ËµÃ÷ 3£ºÓë¹íĞ°ÑıÈËµÚÒ»´Î¶Ô»° 4: ĞÇ¹Ù¸æÖªÈ¥ÕÒÎ÷áªÌ«µß 5:Ì«µßÊÚÓèÁ¶ÑıÂ¯
--6: »Ùµô¹íĞ°ÑıÈËµÄÁé»ê 7: ĞÇ¹â÷öµ­ÈÎÎñÍê³É 8:ĞÇ¹Ù´¦½Ó³ı¶ñÎñ¾¡ÈÎÎñ£»9£ºµÃµ½Ë®Ğ¾ 10: ĞÇ¹Ù´¦¸æÖª¹íĞ°ÑıÈËµÄÔªÉñÎ»ÖÃ
--11: Íæ¼ÒÊ¹ÓÃË®Ğ¾Ê¹¹íĞ°ÑıÈËÏÖÉí 12£º³É¹¦É±ËÀ¹íĞ°ÑıÈËµÄÔªÉñ 13: Íê³É³ı¶ñÎñ¾¡ÈÎÎñ
-- 2byte: Á¶»¯É³»ê¸öÊı
-- 3byte: 1£ºÊÕ¼¯µ½º£ĞÄ²İµÄÖÖ×Ó 2: ÖÖÖ²º£ĞÄ²İ 3£ºµÃµ½Ë®Ğ¾

---------------------ĞÇ¹â÷öµ­-----------------

Task_hengcai = 1214;
--1bitÎªÊÇ·ñ½ÓÌì½µºá²ÆÈÎÎñ;2bitÎªÊÇ·ñÍê³ÉÌì½µºá²ÆÈÎÎñ;3bitÎªÊÇ·ñ½«µÀ¾ß½»¸ø³¯¸èØÔÊ¦;4bitÎªÊÇ·ñ½«µÀ¾ß½»¸øÎ÷áªØÔÊ¦;5bitÎªÊÇ·ñÒÑ½ÓÅ£µ¶Ğ¡ÊÔ;6bitÎªÊÇ·ñÍê³ÉÅ£µ¶Ğ¡ÊÔ

-------------ĞÇÃÎÆæÔµ Added by Laiyongcong 2009/05/04 start-----
star_dream = 1419            --ĞÇÃÎÆæÔµÈÎÎñ±äÁ¿£¬1Byte£ºÈÎÎñ²½Öè,1½Óµ½ÈÎÎñ,2ÌáÊ¾ÕÒÒ½Éú£¬3È¡µÃĞÇÏóÍ¼£¬4»ÃÏñ³öÏÖ,5ÈÎÎñÍê³É
--  2Byte£ºÉ±ËÀÎäÊ¿¹êµÄÊıÄ¿
star_dream2 = 1607        --¼ÇÂ¼ÕÙ»½³öµÄÎäÊ¿¹ê»½ĞÑµÄNpcidx
-------------ĞÇÃÎÆæÔµ Added by Laiyongcong 2009/05/04 end-----

npc_name = {
    [20] = "Lôc Quy",
    [22] = "Háa Ng­",
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
        local i = GetLevel() - 40
        if (i <= 10) then
            ThrowItem(npcindex, PlayerIndex, 3, NpcChr_idx[npcchr], 0, 1, 0, 0) --µôØÔ
            if (GetBit(GetTask(Task_hengcai), 1) == 0 and HaveNormalItem(6, 1, 358, 1) == 0) then
                AddNormalItem(6, 1, 358, 1, 0, 0)
                TopMessage("B¹n nhËn ®­îc 1 <c=yel>Viªn Bån<c>")
                Msg2Player("B¹n bÊt ngê nhËn ®­îc 1 <cViªn Bån")
            end ;
        end ;
    end ;

    --Add By Guoqun for ÊîÆÚ»î¶¯ at 2010-07-09 Begin
    --if mapgid == 37 then
    --	Cool_Summer()
    --	Cool_Summer_Task2()
    --end
    --Add By Guoqun for ÊîÆÚ»î¶¯ at 2010-07-09 End

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

            if (GetTask(897) == 20) then
                local mark = judge_relation()
                if (mark > -1) then
                    mission_PR(w, mark)    --Ê¦Í½ÁÔÉ±ÈÎÎñ
                end
            end

            -- Added by Zhaoqingsong at 2009-5-5 Begin ½­É½ÒÀ¾É
            local mapid2, x2, y2 = GetWorldPos()
            if (mapgid == mapid2) then
                processJiangshan(npcindex)
            end
            -- Added by Zhaoqingsong at 2009-5-5 End
        end
        PlayerIndex = oldPlayer
    else
        -- ÎŞ¶ÓÎé
        --Ó¶±øÓªÁÔÉ±ÈÎÎñ
        if (GetTask(854) > 0) then
            liesha_city(w)
        end

        -- Added by Zhaoqingsong at 2009-5-5 Begin ½­É½ÒÀ¾É
        processJiangshan(npcindex, mapgid)
        -- Added by Zhaoqingsong at 2009-5-5 End
    end ;

    -------------------------------------------------------------------------------------
    if (SystemTime() <= (GetTask(969) + 200)) then
        if (GetTask(966) == mapgid) then
            Frenwu40(px, py, 20)--Áé»ê³¬¶ÈÈÎÎñ£¨40¼¶£©--·âÉñÌ¨Òóºé
        end
    end ;

    if (HaveIBBuff(293) >= 1) then
        if (mapgid >= 37) and (mapgid < 42) then
            Frenwu31()--ËÄÏóÊÕ¼¯ ÔªËØÌ½Ë÷ 31¼¶
        end
    end

    if (GetTask(936) == 5) then
        Frenwu42()--ÕòÔ­´óÏÉ  ³È×°ºÏ³É  42¼¶
    end

    if (suanming(GetByte(GetTask(1022), 1), GetLevel()) == 1) then
        Frenwu65(mapgid)--   ËãÃüÏÈÉú----ËÄÏóÁéÏ¬ÈÎÎñ----65¼¶
    end

    ----------------Added by liuzhiqiang at 2009-5-5 Begin---------------³ı¶ñÎñ¾¡
    if (GetTaskByte(Task_star, 1) == 8 and GetLevel() >= 39 and GetTaskByte(Task_star, 3) == 0) then
        chuewujin()
    end
    ----------------Added by liuzhiqiang at 2009-5-5 End-----------------³ı¶ñÎñ¾¡

    -- Added by Zhaoqingsong at 2009-5-5 Begin ½­É½ÒÀ¾É
    processJiangshanNote(npcindex, mapgid)
    -- Added by Zhaoqingsong at 2009-5-5 End

    ------------ĞÇÃÎÆæÔµ  Added by Laiyongcong 2009-05-04 start------
    if (GetTaskByte(star_dream, 1) == 3 and HaveIBBuff(660) > 0 and HaveItemInAllRoom(4, 246, 0, 1, 0, 0, 0) == 0) then
        ----------------------IBBUFF²ÎÊıĞèÒªĞŞ¸Ä
        StarDream(npcindex)
    end
    ------------ĞÇÃÎÆæÔµ  Added by Laiyongcong 2009-05-04 end--------
    --²¢·ş»î¶¯ 2009/10/27
    --taskPeace()
    --²¢·ş»î¶¯ 2009/10/27

end

------------ĞÇÃÎÆæÔµ  Added by Laiyongcong 2009-05-04 start------
function StarDream(npcidx)
    local wushiguiIdx = GetTask(star_dream2)
    if (wushiguiIdx > 0 and GetPlayerID() == GetNpcTask(wushiguiIdx, 2)) then
        return
    end

    local killNum = GetTaskByte(star_dream, 2) --É±ËÀÎäÊ¿¹êµÄÊıÄ¿
    if (killNum < 31) then
        -----ÏŞÖÆ×î´óÊıÄ¿£¬·ÀÖ¹Òç³ö
        killNum = killNum + 1
        SetTaskByte(star_dream, 2, killNum)
    end

    --¼ÆËã¸ÅÂÊ
    local rate = 20
    if (killNum > 10 and killNum < 21) then
        rate = 40
    elseif (killNum > 20 and killNum < 31) then
        rate = 60
    elseif (killNum > 30) then
        rate = 100
    end

    if (random(1, 100) <= rate) then
        --µÚÒ»¸ö»ÃÏó³öÏÖ
        local _, x, y = GetNpcWorldPos(npcidx)
        local idx = AddNpc(990, 40, SubWorld, x * 32, y * 32)--------------------------NPCµÄ±àºÅĞèÒªĞŞ¸Ä
        local PID = GetPlayerID() --»ñµÃµ±Ç°Íæ¼ÒµÄÉí·İ±êÊ¶
        if (idx ~= 0) then
            Msg2Player("¶o c¶nh Lôc Quy ®· xuÊt hiÖn")
            SetNpcTask(idx, 1, 1)
            -------------------------------------------------±ê¼Ç×Ô¼ºÎªµÚÒ»¸ö»ÃÏó
            SetNpcTask(idx, 2, PID)
            -----------------------------------------------±ê¼Ç¸ÃÎäÊ¿¹êÊÇË­ÕÙ»½³öÀ´µÄ
            local mtimes = 600
            if (mtimes > GetIBBuffLeftTimes(660)) then
                mtimes = GetIBBuffLeftTimes(660)
            end
            SetNpcTimer(idx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", mtimes)
            ScrollMessage("¶o c¶nh Lôc Quy ®· xuÊt hiÖn")
            SetTask(star_dream2, idx)
        else
            ScrollMessage("Thªm ¶o c¶nh Lôc Quy thÊt b¹i!")----------------------------------²âÊÔÓÃ
        end
        --SetTaskByte(star_dream,1,4)
    else
        ScrollMessage("¶o c¶nh Lôc Quy vÉn ch­a xuÊt hiÖn, h·y tiÕp tôc cè g¾ng!")
    end

end
------------ĞÇÃÎÆæÔµ  Added by Laiyongcong 2009-05-04 end--------

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
                Msg2Player("Trõ Yªu: B¹n cßn ph¶i diÖt " .. (count - 1) .. "Lôc Quy!")
                if (mod(count, 50) == 0) then
                    local oldplayer = PlayerIndex
                    PlayerIndex = masterindex
                    Msg2Player("Trõ Yªu: B¹n cßn ph¶i diÖt " .. (count - 1) .. "Lôc Quy!")
                    PlayerIndex = oldplayer
                end
            elseif (count == 1) then
                SetTask(898, 0)
                TaskNote(42, 8)
                Msg2Player("Trõ Yªu: §· hoµn thµnh tiªu diÖt Lôc Quy!")
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

    if (type1 == 20 and count1 > 0) then
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
    elseif (type2 == 20 and count2 > 0) then
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
                TopMessage("Th¶ thµnh c«ng linh hån cña Lôc Quy")
                Msg2Player("Chiªu Hån Ph­ín:Phãng thİch thµnh c«ng!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", Vâ sÜ Giang Quy ®· gi¶i tho¸t" .. (dd2 + 1) .. ".")
                TaskNote(48, 1, npc_name[d1], GetTask(970), "Lôc Quy", GetTask(971))
            else
                Msg2Player("Th¶ thÊt b¹i!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", Vâ sÜ Giang Quy ®· gi¶i tho¸t" .. dd2 .. ".")
            end
        elseif (dd1 < 3) and (templateID == d1) then
            if (p ~= 2) then
                SetTask(970, dd1 + 1)
                TopMessage("Th¶ thµnh c«ng linh hån cña Lôc Quy")
                Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thµnh c«ng. Vâ sÜ Giang Quy ®· gi¶i tho¸t" .. (dd1 + 1) .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
                TaskNote(48, 1, "Lôc Quy", GetTask(970), npc_name[d2], GetTask(971))
            else
                Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thÊt b¹i. Vâ sÜ Giang Quy ®· gi¶i tho¸t" .. dd1 .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
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

----------------Added by liuzhiqiang at 2009-5-5 Begin---------------³ı¶ñÎñ¾¡
function chuewujin()
    if (GetTaskByte(Task_star, 1) == 8 and GetLevel() >= 39 and GetTaskByte(Task_star, 3) == 0) then
        local rand = random(1, 100)
        if (rand > 15) then
            return
        end

        if (IsHaveSpaceForTreasure(1) ~= 1) then
            Msg2Player("Hµnh trang cña b¹n ®· ®Çy, kh«ng thÓ lÊy [H¹t H¶i T©m Th¶o]") --que
            return
        end

        Msg2Player("§­îc h¹t H¶i T©m Th¶o.")
        TopMessage("§­îc h¹t H¶i T©m Th¶o")
        AddNormalItem(6, 1, 512, 0, 0, 0)  -- º£ĞÄ²İµÄÖÖ×Ó
        SetTaskByte(Task_star, 3, 1)
    end
end
----------------Added by liuzhiqiang at 2009-5-5 End-----------------³ı¶ñÎñ¾¡

-- Added by Zhaoqingsong at 2009-5-5 Begin  ½­É½ÒÀ¾É 5-15 ÉÏÏß

-- 1Byte 0Î´½øĞĞ¾íÒ»£»1 ¾íÒ»Íê³É£»2 ¾í¶şÍê³É£»3 ¾íÈıÍê³É
-- 2Byte 0Î´¿ªÊ¼£»1 »ÃÏó1Íê³É£»2 »ÃÏó2Íê³É£»...ÒÀ´ÎÀàÍÆ
TASK_JIANGSHAN = 1426

TASK_JIANGSHAN_ONE_STEP = 1427
TASK_JIANGSHAN_ONE_STATUS = 1428
TASK_JIANGSHAN_ONE_DATE = 1429
TASK_JIANGSHAN_ONE_COORD = 1430
TASK_JIANGSHAN_ONE_DIST = 1431

Task_Info_JIANGSHAN_ONE = 1053
Task_Info_JIANGSHAN_TWO = 1054
Task_Info_JIANGSHAN_IDOLUM = 1055

-- µ÷Õû¸ÅÂÊÓÅ»¯ 2009-6-5
RAND_JS_NOTE = {
    { total = 100, ratio = 2, desc = "Bót Kı 1" },
    { total = 100, ratio = 3, desc = "Bót Kı 2" },
}

RAND_JS_NOTE_INDEX = 2

function processJiangshanNote(npcindex, mapgid)
    if ((HaveIBBuff(293) >= 1) and (mapgid >= 37) and (mapgid <= 42) and (GetTask(55) == 24)) then
    else
        return 0
    end
    if (GetLevel() < 40) then
        return 0
    end
    local mainStatus = GetTaskByte(TASK_JIANGSHAN, 1)
    local oneStep = GetTaskByte(TASK_JIANGSHAN_ONE_STEP, 1)
    if (mainStatus > 0 or oneStep > 0) then
        return 0
    end
    if (GetBoxSize(0, 2) <= 0) then
        return 0
    end

    local rand = random(1, 100)
    if (rand <= RAND_JS_NOTE[RAND_JS_NOTE_INDEX].ratio) then
        SetTaskByte(TASK_JIANGSHAN_ONE_STEP, 1, 2)
        AddNormalItem(4, 244, 0, 0, 0, 0)  -- ²ĞÆÆµÄ±Ê¼Ç2
        TaskNote(Task_Info_JIANGSHAN_TWO, 0)
        TopMessage("NhËn <c=yel>Bót Kı 2")
        Msg2Player("NhËn Bót Kı 2, xem trªn ®ã viÕt g×.")
    end
end

function processJiangshan(npcindex)
    if (GetLevel() < 35) then
        return 0
    end
    local mainStatus = GetTaskByte(TASK_JIANGSHAN, 1)
    local oneStep = GetTaskByte(TASK_JIANGSHAN_ONE_STEP, 1)
    local page2Step = GetTaskByte(TASK_JIANGSHAN_ONE_STEP, 3)
    if (mainStatus > 0 or oneStep ~= 3 or page2Step ~= 1) then
        return 0
    end
    local twoStepStatus = GetTaskByte(TASK_JIANGSHAN_ONE_STATUS, 3)
    if (twoStepStatus ~= 1) then
        return 0
    end
    local killCount = GetTaskByte(TASK_JIANGSHAN_ONE_STATUS, 4)
    killCount = killCount + 1
    SetTaskByte(TASK_JIANGSHAN_ONE_STATUS, 4, killCount)
    if (killCount >= 50) then
        SetTaskByte(TASK_JIANGSHAN_ONE_STATUS, 3, 2)
        TaskNote(Task_Info_JIANGSHAN_TWO, 2)
        FinishNpcCollection(4)
        TopMessage("Lôc Quy: Anh hïng dòng m·nh kh«ng kĞm D­ t­íng qu©n n¨m x­a")
        Msg2Player("Xin chóc mõng, tõ Lôc Quy ®· chøng thùc ®­îc sù anh dòng cña D­ Kh¸nh n¨m x­a, cã thÓ vÒ TriÒu Ca phôc mÖnh D­ Kh¸nh.")
    else
        TaskNote(Task_Info_JIANGSHAN_TWO, 1, killCount)
        ScrollMessage("Giang S¬n Y Cùu: Hµng phôc" .. killCount .. "Lôc Quy")
    end
end

-- Added by Zhaoqingsong at 2009-5-5 End

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
--	if (GetTask(Task_Peace_Day) ~= today) or (GetTaskByte(Task_Peace_Process, 1) ~= 4) or (GetTaskByte(Task_Peace_Process, 2) ~= 1) then
--		return
--	end

--	local w,x,y=GetWorldPos() --Íæ¼ÒµØÍ¼¼°×ø±ê
--	if (w ~= 37) then --ÅĞ¶Ï´ò¹ÖÊÇ·ñÔÚ¸ÃµØÍ¼
--		return 0
--	end

--	if (GetTeam() ~= 0) then
--		local oldPlayer = PlayerIndex

--		for i=1, GetTeamSize() do
--			PlayerIndex = GetTeamMember(i)
--			if (GetTask(Task_Peace_Day) == today) and (GetTaskByte(Task_Peace_Process, 1) == 4) and (GetTaskByte(Task_Peace_Process, 2) == 1) and (HaveIBBuff(BuffIndex) > 0) then


--				local killNum = GetTaskWord(Task_Peace_Process, 2)
--				if ((HaveIBBuff(BuffIndex) > 0) ) then
--					killNum = killNum + 1
--					SetTaskWord(Task_Peace_Process, 2, killNum)
--					if (killNum < 550) then							--???É±¹Ö¸öÊıĞèÒªĞŞ¸Ä
--						ScrollMessage("×îµÍ»÷É±ÊıÁ¿»¹²î"..(550-killNum).."Ö»")
--						TaskNote(1501, 1, "ÎäÊ¿¹ê", killNum, 550)
--					elseif (killNum == 550) and (HaveIBBuff(BuffIndex) > 0) then
--						Msg2Player("ÄúÒÑ¾­Íê³É×îµÍ»÷É±ÊıÁ¿£¬µÚ¶şµµ×îµÍ»÷É±ÊıÁ¿Îª700Ö»£¬Çë×¢ÒâÊ±¼ä")
--						ScrollMessage("×îµÍ»÷É±Íê³É£¬µÚ¶şµµ×îµÍ»÷É±700Ö»£¬Çë×¢Òâ")
--						TaskNote(1501, 3, "ÎäÊ¿¹ê", killNum, 700)
--					elseif (killNum < 700) then
--						ScrollMessage("µÚ¶şµµ»÷É±ÊıÁ¿»¹²î"..(700-killNum).."Ö»")
--						TaskNote(1501, 3, "ÎäÊ¿¹ê", killNum, 700)
--					elseif (killNum == 700) and (HaveIBBuff(BuffIndex) > 0) then
--						Msg2Player("ÄúÒÑ¾­Íê³ÉµÚ¶şµµ»÷É±ÊıÁ¿£¬µÚÈıµµ×îµÍ»÷É±ÊıÁ¿Îª1500Ö»£¬Çë×¢ÒâÊ±¼ä")
--						ScrollMessage("µÚ¶şµµÍê³É£¬µÚÈıµµ×îµÍ»÷É±1500Ö»£¬Çë×¢Òâ")
--						TaskNote(1501, 3, "ÎäÊ¿¹ê", killNum, 1500)
--					elseif (killNum < 1500) then
--						ScrollMessage("µÚÈıµµ»÷É±ÊıÁ¿»¹²î"..(1500-killNum).."Ö»")
--						TaskNote(1501, 4, "ÎäÊ¿¹ê", killNum, 1500)
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

--		PlayerIndex = oldPlayer
--	else
--		--local killNum = GetTaskWord(Task_Peace_Process, 2)
--		if (GetTask(Task_Peace_Day) == today) and (GetTaskByte(Task_Peace_Process, 1) == 4) and (GetTaskByte(Task_Peace_Process, 2) == 1) and (HaveIBBuff(BuffIndex) > 0) then


--			local killNum = GetTaskWord(Task_Peace_Process, 2)
--			if ((HaveIBBuff(BuffIndex) > 0) ) then
--				killNum = killNum + 1
--				SetTaskWord(Task_Peace_Process, 2, killNum)
--					if (killNum < 550) then							--???É±¹Ö¸öÊıĞèÒªĞŞ¸Ä
--						ScrollMessage("×îµÍ»÷É±ÊıÁ¿»¹²î"..(550-killNum).."Ö»")
--						TaskNote(1501, 1, "ÎäÊ¿¹ê", killNum, 550)
--					elseif (killNum == 550) and (HaveIBBuff(BuffIndex) > 0) then
--						Msg2Player("ÄúÒÑ¾­Íê³É×îµÍ»÷É±ÊıÁ¿£¬µÚ¶şµµ×îµÍ»÷É±ÊıÁ¿Îª700Ö»£¬Çë×¢ÒâÊ±¼ä")
--						ScrollMessage("×îµÍ»÷É±Íê³É£¬µÚ¶şµµ×îµÍ»÷É±700Ö»£¬Çë×¢Òâ")
--						TaskNote(1501, 3, "ÎäÊ¿¹ê", killNum, 700)
--					elseif (killNum < 700) then
--						ScrollMessage("µÚ¶şµµ»÷É±ÊıÁ¿»¹²î"..(700-killNum).."Ö»")
--						TaskNote(1501, 3, "ÎäÊ¿¹ê", killNum, 700)
--					elseif (killNum == 700) and (HaveIBBuff(BuffIndex) > 0) then
--						Msg2Player("ÄúÒÑ¾­Íê³ÉµÚ¶şµµ»÷É±ÊıÁ¿£¬µÚÈıµµ×îµÍ»÷É±ÊıÁ¿Îª1500Ö»£¬Çë×¢ÒâÊ±¼ä")
--						ScrollMessage("µÚ¶şµµÍê³É£¬µÚÈıµµ×îµÍ»÷É±1500Ö»£¬Çë×¢Òâ")
--						TaskNote(1501, 3, "ÎäÊ¿¹ê", killNum, 1500)
--					elseif (killNum < 1500) then
--						ScrollMessage("µÚÈıµµ»÷É±ÊıÁ¿»¹²î"..(1500-killNum).."Ö»")
--						TaskNote(1501, 4, "ÎäÊ¿¹ê", killNum, 1500)
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


--end
--²¢·ş»î¶¯ 2009/10/27

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
                        --´Ó1¿ªÊ¼¼ÆÊıµÄ£¬1¾ÍÏàµ±ÓÚ0
                        SetTaskByte(Task_State, 1, nCount + 2)
                        AddNormalItem(3, 1124, 0, 0, 0, 0);
                        ScrollMessage("NhËn ®­îc Tş Thö Ch©u");
                        Msg2Player("NhËn ®­îc Tş Thö Ch©u");
                        WriteLog("NhËn ®­îc 1 Tş Thö Ch©u")
                    end

                    if nCount >= 5 then
                        RemoveIBBuff(Ninety_SecondBuff)
                        TaskNote(1606, -1)
                        SetTaskByte(Task_State, 1, 9)
                    end
                end
            else
                ScrollMessage("VËn khİ kh«ng tèt, ch­a thÓ nhËn ®­îc Tş Thö Ch©u, h·y tiÕp tôc nç lùc!")
                Msg2Player("VËn khİ kh«ng tèt, ch­a thÓ nhËn ®­îc Tş Thö Ch©u, h·y tiÕp tôc nç lùc!")
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

--Add By Guoqun for ÊîÆÚ»î¶¯ at 2010-07-09 End
