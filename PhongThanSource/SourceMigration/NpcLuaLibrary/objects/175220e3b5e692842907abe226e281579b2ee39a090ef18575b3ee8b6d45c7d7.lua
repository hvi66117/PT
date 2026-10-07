--description: ¼×¿ÇÈË
--author: yaoxin 
--date: 2008/07/14

Task_DeliverCarbon = 1045;
Task_DriveOutNum = 1046;
Task_HelpDoctor = 1099 --   Ñ©ÖÐËÍÌ¿ÈÎÎñ¿ØÖÆ±äÁ¿
Task_PrepareMaterial = 1049;
Task_PrepareMaterNum = 1050;
Task_wugu2 = 1353;
--Î×¹ÆÖ®¶¾µÚ¶þ²½ÈÎÎñ±äÁ¿
Task_count = 1349
--¼ÇÂ¼Î×¹ÆÖ®¶¾É±ËÀ¹ÖÎïÊýÁ¿
Task_hengcai = 1214;
--1bitÎªÊÇ·ñ½ÓÌì½µºá²ÆÈÎÎñ;2bitÎªÊÇ·ñÍê³ÉÌì½µºá²ÆÈÎÎñ;3bitÎªÊÇ·ñ½«µÀ¾ß½»¸ø³¯¸èØÔÊ¦;4bitÎªÊÇ·ñ½«µÀ¾ß½»¸øÎ÷áªØÔÊ¦;5bitÎªÊÇ·ñÒÑ½ÓÅ£µ¶Ð¡ÊÔ;6bitÎªÊÇ·ñÍê³ÉÅ£µ¶Ð¡ÊÔ

TASK_lateral = 1200 --30-50Ö§Ïß, 10bit¿ªÆôÎªÃñ³ýº¦,11bitÊÇ·ñÍê³ÉÎªÃñ³ýº¦, 12bitÊÇ·ñ½ÓÁËÒ½ÕßÈÊÐÄ,13bitÊÇ·ñÍê³ÉÒ½ÕßÈÊÐÄ£¬14bitÊÇ·ñ½ÓÀ§ÊÞÓÌ¶·,15bitÊÇ·ñÍê³ÉÀ§ÊÞÓÌ¶·,16bit¿ªÆôÕ¶²Ý³ý¸ù,17bitÊÇ·ñÍê³ÉÕ¶²Ý³ý¸ù, 20bit¿ªÆôÁéÆøÈáºÍ,21bitÊÇ·ñÍê³ÉÁéÆøÈáºÍ, 26bit¿ªÆôºìÉ·Ö®»¼,27bitÊÇ·ñÍê³ÉºìÉ·Ö®»¼,,30bitÊÇ·ñ¼¤»îÀ§ÊÞÓÌ¶·,29bitÊÇ·ñÍê³ÉËÍ»õÉÏÃÅ
TASK_lateral_1 = 1201 -- 2byteÎªÃñ³ýº¦µÄ¼×¿Ç³æ¸öÊý£¬3byteÎªÃñ³ýº¦µÄºµ¹ê¸öÊý,4byteºìÉ·Ö®»¼µÄ¸öÊý,


npc_name = {
    [8] = "Hoµn CÈu",
    [14] = "Gi¸p Cèt",
    [17] = "Thiªn H¹o",
    [25] = "Giang Quy",
}

NpcChr_idx = { [0] = 15, [1] = 17, [2] = 16, [3] = 21, [4] = 18, [5] = 20, [6] = 19, [7] = 19 } --À¶¹ÖµôØÔ ÊôÐÔºÅ¶ÔÓ¦ØÔË÷Òý
function OnDeath(npcindex)
    --¸÷Àà°´µØÍ¼×é¶Ó¹²Ïí³É¹ûµÄÈÎÎñ
    local w, x, y = GetWorldPos() --Íæ¼ÒµØÍ¼¼°×ø±ê
    local mapgid, px, py = GetNpcWorldPos(npcindex) --npcµØÍ¼¼°×ø±ê
    if (w ~= mapgid) then
        return 0
    end

    local npcchr = GetHardNpcAttrib(npcindex)--À¶¹ÖÊôÐÔ

    ---------Î×¹ÆºóÐø-------
    local wg = GetTask(Task_wugu2)
    if (wg == 2) or (wg == 3) then
        wugu2(npcindex)
    end

    ----------Î×¹ÆºóÐøend---------

    -------------------------ÒÔÉÏÎª¹²ÏíµÄ±äÁ¿ ½ûÖ¹ÖØÐÂ¸³Öµ----------------------
    if (npcchr >= 0) and (npcchr <= 7) then
        local i = GetLevel() - 20
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
        -- ÓÐ¶ÓÎé(°üÀ¨Ö»ÓÐ×Ô¼ºÒ»¸öÈËµÄ)
        local oldPlayer = PlayerIndex
        local membercount = GetTeamSize()

        -- ±éÀú¶ÓÖÐ¶ÓÔ±
        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)
            --Ó¶±øÓªÁÔÉ±ÈÎÎñ
            if (GetTask(852) > 0) then
                liesha_city(w)
            end

            --¿ªÆô»¨»ÜÈÎÎñÓÃµÄÁÔÉ±ÈÎÎñ			
            if (GetTask(888) > 0) and (GetTask(888) < 12) then
                huahui_open_task(w, GetTask(894))
            end

            if (w == 18) then
                renwu_lateral(w)
            end

            if (GetByte(GetTask(1207), 1) == 1 and GetByte(GetTask(1207), 2) == 13) then
                NewMonsterTip(w)
            end
        end
        PlayerIndex = oldPlayer
    else
        -- ÎÞ¶ÓÎé
        --Ó¶±øÓªÁÔÉ±ÈÎÎñ
        if (GetTask(852) > 0) then
            liesha_city(w)
        end

        --¿ªÆô»¨»ÜÈÎÎñÓÃµÄÁÔÉ±ÈÎÎñ			
        if (GetTask(888) > 0) and (GetTask(888) < 12) then
            huahui_open_task(w, GetTask(894))
        end

        if (w == 18) then
            renwu_lateral(w)
        end

        if (GetByte(GetTask(1207), 1) == 1 and GetByte(GetTask(1207), 2) == 13) then
            NewMonsterTip(w)
        end
    end ;

    ---ÐÂÔö7¹ÖÎï¾íÖáµôÂä
    if (GetLevel() <= 30) then
        if (GetByte(GetTask(1207), 1) == 0 and HaveNormalItem(6, 1, 353, 1) < 1) then
            NewMonsterDropScroll()
        end
    end

    --Çý³ýÒþ»¼
    if (GetPlayerType() < 2) then
        if (GetTask(Task_DeliverCarbon) == 3) then
            if (GetByte(GetTask(Task_DriveOutNum), 2) == 13) then
                FNewquzhu(900, npcindex)
            end
        end
    else
        local L_HelpDoctor = GetTask(Task_HelpDoctor)
        if (GetByte(L_HelpDoctor, 1) == 5) then
            if (GetByte(GetTask(Task_HelpDoctor), 3) == 13) then
                FNewquzhu(1005, npcindex)
            end
        end
    end

    ---Ô¤±¸Îï×Ê
    if (GetTask(Task_PrepareMaterial) == 5) then
        if (GetByte(GetTask(Task_PrepareMaterNum), 1) == 13) then
            FPreGoods()
        end
    end

    if (SystemTime() <= (GetTask(969) + 200)) then
        if (GetTask(966) == mapgid) then
            Frenwu40(px, py, 14)--Áé»ê³¬¶ÈÈÎÎñ£¨40¼¶£©--·âÉñÌ¨Òóºé
        end
    end ;

    if (GetTask(955) == 14) and (GetTask(956) < 20) then
        Frenwu18()--½ÌÑµ¹ÖÎïÈÎÎñ£¨30¼¶ÒÔÏÂ£©--ÐÂÊÖ´å ÔÓ»õÉÌ
    end

    if (GetTask(936) == 5) then
        Frenwu42()--ÕòÔ­´óÏÉ  ³È×°ºÏ³É  42¼¶
    end

    -- Added by Zhaoqingsong at 2009-4-23 begin
    processChallenge()
    -- Added by Zhaoqingsong at 2009-4-23 end
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

    if (type1 == 14 and count1 > 0) then
        count1 = count1 - 1
        if (count1 > 0) then
            ScrollMessage("NhiÖm vô LÝnh ®¸nh thuª: tiªu diÖt" .. npc_name[type1] .. "(" .. (50 - count1) .. "/50)")
        else
            count1 = 0
            ScrollMessage(" Hoµn thµnh Truy s¸t" .. npc_name[type1] .. ".")
        end
        SetTask(task_id, SetByte(task_val, 2, count1))
        TaskNote(task_id, 0, npc_name[type1], (50 - count1), npc_name[type2], (50 - count2))
    elseif (type2 == 14 and count2 > 0) then
        count2 = count2 - 1
        if (count2 > 0) then
            ScrollMessage("NhiÖm vô LÝnh ®¸nh thuª: tiªu diÖt" .. npc_name[type2] .. "(" .. (50 - count2) .. "/50)")
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

--¿ªÆô»¨»ÜÈÎÎñÓÃµÄÁÔÉ±ÈÎÎñ
function huahui_open_task(world, task_target)
    local w, x, y = GetWorldPos()
    if (w == world) then
        local task_val = GetTask(889)
        local param = { 894, floor(GetTask(888) / 2) + 1 }
        for i = 1, 4 do
            local t = GetByte(task_target, i)
            local c = GetByte(task_val, i)
            if (t ~= 0) then
                if (t == 14 and c < 50) then
                    c = c + 1
                    if (c < 50) then
                        ScrollMessage("T×m hoa: §· tiªu diÖt Gi¸p Cèt (" .. c .. "/50)")
                    else
                        ScrollMessage("T×m hoa: §· hoµn thµnh tiªu diÖt Gi¸p Cèt")
                    end
                    SetTask(889, SetByte(task_val, i, c))
                end
                param[getn(param) + 1] = c
            end
        end
        TaskNote(894, -1)
        call(TaskNote, param)
    end
end

function no()
    CloseDialog()
end;

--30-50Ö§Ïß
function renwu_lateral(WorldID)
    local w, x, y = GetWorldPos()
    if (w == WorldID) then
        local val = GetTask(TASK_lateral)
        local val1 = GetTask(TASK_lateral_1)

        if (GetBit(val, 11) == 0) and (GetBit(val, 10) == 1) then
            local count1 = GetByte(val1, 2) - 1
            if (count1 >= 1) then
                SetTask(TASK_lateral_1, SetByte(val1, 2, count1))
                TaskNote(702, 1, count1, GetByte(val1, 3))
                ScrollMessage("V× d©n trõ h¹i: B¹n cßn ph¶i diÖt " .. count1 .. " Gi¸p Cèt")
            elseif (count1 == 0) then
                SetTask(TASK_lateral_1, SetByte(val1, 2, 0))
                TaskNote(702, 1, 0, GetByte(val1, 3))
                ScrollMessage("V× d©n trõ h¹i: hoµn thµnh tiªu diÖt Gi¸p Cèt")
                if (GetByte(val1, 3) == 0) then
                    TaskNote(702, 2)
                end
            end
        end
    end
end

function NewMonsterDropScroll()
    local nProp = random(1, 100)
    if (nProp <= 4) then
        AddNormalItem(6, 1, 353, 1, 0, 0)
        TopMessage("B¹n bÊt ngê nhËn ®­îc 1 <c=g>Gi¸p Cèt mËt tÞch<c>.")
        Msg2Player("B¹n bÊt ngê nhËn ®­îc 1 Gi¸p Cèt mËt tÞch.")
    end
end

function NewMonsterTip(world)
    local w, x, y = GetWorldPos()
    if (w == world) then
        local var = GetTask(1207)
        local Num = GetByte(var, 3)
        local KillNum = GetByte(var, 4) + 1
        SetTask(1207, SetByte(var, 4, KillNum))
        if (KillNum >= Num) then
            SetTask(1207, SetByte(GetTask(1207), 1, 2))
            TaskNote(920, 2)
            TopMessage("Hoµn thµnh tiªu diÖt Gi¸p Cèt, cã thÓ t×m T¹p hãa Th­¬ng l·nh th­ëng!")
            Msg2Player("Hoµn thµnh nhiÖm vô Gi¸p Cèt lÖnh, cã thÓ t×m T¹p hãa Th­¬ng l·nh th­ëng!")
        else
            TaskNote(920, 1, KillNum, Num)
            TopMessage("Tiªu diÖt Gi¸p Cèt" .. KillNum .. "/" .. Num .. ".")
            Msg2Player("Tiªu diÖt Gi¸p Cèt" .. KillNum .. "/" .. Num .. ".")
        end
    end
end

--½ÌÑµ¹ÖÎïÈÎÎñ£¨30¼¶ÒÔÏÂ£©--ÐÂÊÖ´å ÔÓ»õÉÌ-----------------------------------------
function Frenwu18()
    local nums = GetTask(956) + 1
    if (nums < 20) then
        SetTask(956, nums)
        ScrollMessage("Gi¸o HuÊn: Cßn ph¶i gi¸o huÊn Gi¸p Cèt" .. (20 - nums) .. ".")
        TaskNote(50, 1, "Gi¸p Cèt", nums)
    elseif (nums == 20) then
        SetTask(956, 21)
        ScrollMessage(" Hoµn thµnh nhiÖm vô Gi¸o huÊn")
        TaskNote(50, 2)
    end
end

--Áé»ê³¬¶ÈÈÎÎñ£¨40¼¶£©--·âÉñÌ¨Òóºé
--964 ¹ÖÎï1±êºÅ
--965 ¹ÖÎï2±êºÅ
--966 ÕÐ»ê·«ËùÔÚµØÍ¼id
--967 ÕÐ»ê·«µÄÖÐÐÄÎ»ÖÃx
--968 ÕÐ»ê·«µÄÖÐÐÄÎ»ÖÃy
--969 ÕÐ»ê·«µÄÉèÖÃÆðÊ¼Ê±¼ä
--970 ¹ÖÎï1µÄÁé»ê¸öÊý
--971 ¹ÖÎï2µÄÁé»ê¸öÊý
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
                TopMessage("Th¶ thµnh c«ng linh hån Gi¸p Cèt")
                Msg2Player("Chiªu Hån Ph­ín:Phãng thÝch thµnh c«ng!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", Gi¸p Cèt ®· gi¶i tho¸t" .. (dd2 + 1) .. ".")
                TaskNote(48, 1, npc_name[d1], GetTask(970), "Gi¸p Cèt", GetTask(971))
            else
                Msg2Player("Th¶ thÊt b¹i!" .. npc_name[d1] .. "§· siªu ®é" .. dd1 .. ", Gi¸p Cèt ®· gi¶i tho¸t" .. dd2 .. ".")
            end
        elseif (dd1 < 3) and (templateID == d1) then
            if (p ~= 2) then
                SetTask(970, dd1 + 1)
                TopMessage("Th¶ thµnh c«ng linh hån Gi¸p Cèt")
                Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thµnh c«ng. Gi¸p Cèt ®· gi¶i tho¸t" .. (dd1 + 1) .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
                TaskNote(48, 1, "Gi¸p Cèt", GetTask(970), npc_name[d2], GetTask(971))
            else
                Msg2Player("Chiªu Hån ph­ín: gi¶i tho¸t thÊt b¹i. Gi¸p Cèt ®· gi¶i tho¸t" .. dd1 .. "." .. npc_name[d2] .. "§· siªu ®é" .. dd2 .. ".")
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

--ÇýÖðÒþ»¼
function FNewquzhu(note, npcindex)
    local nGoodCount = HaveEventItemCount(191)
    if (nGoodCount >= 5) then
        return 0
    end

    if (HaveIBBuff(335) ~= 0) then
        AddNormalItemPile(4, 191, 0, 1, 0, 0)
        nGoodCount = nGoodCount + 1
        if (nGoodCount >= 5) then
            TaskNote(note, 2)
            TopMessage(11632)
            Msg2Player("Thu thËp ®ñ 5 H¹p ®»ng, trë vÒ phôc mÖnh!")
            --AS GaoJingwei 090808
            RefreshAllNpcTask()
            --AE GaoJingwei 090808
        else
            TopMessage(11633)
            Msg2Player("NhËn ®­îc 1 H¹p ®»ng.")
        end
    end
end

--Ô¤±¸Îï×Ê
function FPreGoods()
    local L_TaskInfo = GetTask(Task_PrepareMaterNum)
    local L_ObjectNum = GetByte(L_TaskInfo, 2)
    local nRealNum = HaveEventItemCount(196)

    if (nRealNum < L_ObjectNum) then
        local nProp = random(1, 10)
        if (nProp <= 5) then
            AddNormalItemPile(4, 196, 0, 1, 0, 0)
            nRealNum = nRealNum + 1
            if (nRealNum >= L_ObjectNum) then
                TopMessage("B¹n ®· thu thËp ®ñ <c=g>D¹ Quang Ch©u")
                Msg2Player("B¹n ®· thu thËp ®ñ <c=g>D¹ Quang Ch©u")
            else
                TopMessage("B¹n nhËn ®­îc 1 D¹ Quang Ch©u")
                Msg2Player("B¹n nhËn ®­îc 1 D¹ Quang Ch©u")
            end
        end
    end
end
-------------------------------------Add by yangmeng   2009/10/20   begin  
function wugu2(npcindex)
    local ncount = GetTask(Task_count)
    local wugu = GetTask(Task_wugu2)

    local nWorldID, x, y = GetWorldPos()
    ncount = ncount + 1
    if (ncount < 50) then
        SetTask(1349, ncount)
        ScrollMessage("§éc Cæ: Cßn ph¶i tiªu diÖt Gi¸p Cèt " .. (50 - ncount) .. ".")
    end
    if (wugu == 2) then
        if (ncount == 50) then
            local newnpcidx = AddNpc(897, 25, SubWorld, x * 32, y * 32)
            SetNpcName(newnpcidx, "<c=g>B¸ch Niªn Gi¸p Cèt<c>")
            SetNpcScript(newnpcidx, "\\script\\npcdeath\\°ÙÄê¼×¿ÇÈË.lua")
            SetNpcTimer(newnpcidx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 600)
            Msg2Player("B¸ch Niªn Gi¸p Cèt xuÊt hiÖn")
            SetTask(Task_wugu2, 3)
            TaskNote(201, 2)
            SetTask(Task_count, SystemTime())
        end
    elseif (wugu == 3) then
        if (SystemTime() - GetTask(Task_count) > 40) then
            local rate = random(1, 3)
            if (rate == 3) then
                local newnpcidx = AddNpc(897, 25, SubWorld, x * 32, y * 32)
                SetNpcName(newnpcidx, "<c=g>B¸ch Niªn Gi¸p Cèt<c>")
                SetNpcScript(newnpcidx, "\\script\\npcdeath\\°ÙÄê¼×¿ÇÈË.lua")
                SetNpcTimer(newnpcidx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 600)
                Msg2Player("B¸ch Niªn Gi¸p Cèt l¹i xuÊt hiÖn")
                SetTask(Task_count, SystemTime())
            end
        end
    end
end
------------------------------------------Add by yangmeng   2009/10/20   end 
-- Added by Zhaoqingsong at 2009-4-23 begin
-- ÌôÕ½¼«ÏÞ

Task_Challenge_Accept = 1396  -- 1W ÁìÆ±Ê±¼ä 3B ÁìÆ±´ÎÊý 4B Ãâ·ÑÁìÆ±
Task_Challenge_Enter = 1397  -- 1W ²ÎÈüÊ±¼ä 3B ²ÎÈü´ÎÊý 4B ²ÎÈü×´Ì¬
Task_Challenge_Growth = 1398  -- 1B ³É³¤¶È 2B ³äÆøÍ°Ê¹ÓÃ 3B ³äÆøboss
Task_Challenge_Kill = 1399  -- É±¹ÖÊ±¼ä
Task_Challenge_Begin = 1400  -- ±ÈÈü¿ªÊ¼Ê±¼ä

Task_Info_Challenge = 204
Buff_Challenge = 649
Const_Kill_Burst = 4
Const_Kill_Interval = 3

Const_Challenge_Balloon_Begin = 964
Const_Challenge_Balloon_End = 969

Challenge_Burst = {
    { low = 0, high = 30, total = 1000, ratio = 0, balloon = 964, desc = "" },
    { low = 31, high = 50, total = 1000, ratio = 8, balloon = 965, desc = "" },
    { low = 51, high = 70, total = 1000, ratio = 17, balloon = 966, desc = "" },
    { low = 71, high = 90, total = 1000, ratio = 58, balloon = 967, desc = "" },
    { low = 91, high = 100, total = 1000, ratio = 120, balloon = 968, desc = "" },
}

Challenge_Buff = {
    { buffid = 647, total = 1000, ratio = 10, desc = "Ngµn c©n treo sîi tãc" },
    { buffid = 648, total = 1000, ratio = -10, desc = "KhÝ ®Þnh thÇn nhµn" },
    { buffid = 647, total = 1000, ratio = 10, desc = "Ngäc Phong Ch©m" },
    { buffid = 648, total = 1000, ratio = -10, desc = "D­¬ng Chi Lé" },
}


-- ÊÇ·ñÏÔÊ¾ÌôÕ½¼«ÏÞ
function processChallenge()
    local w, x, y = GetWorldPos()
    if (w ~= 18) then
        return
    end
    local taskDate = GetTaskWord(Task_Challenge_Enter, 1)
    local taskCount = GetTaskByte(Task_Challenge_Enter, 3)
    local taskStatus = GetTaskByte(Task_Challenge_Enter, 4)
    if (taskStatus ~= 1 or HaveIBBuff(Buff_Challenge) == 0) then
        return
    end
    local growth = GetTaskByte(Task_Challenge_Growth, 1)
    local useFill = GetTaskByte(Task_Challenge_Growth, 2)
    local useFillCount = GetTaskByte(Task_Challenge_Growth, 3)
    local preTime = GetTask(Task_Challenge_Kill)
    local localTime = LocalSystemTime()

    local hardBurst = 1000
    if (useFill == 1 and useFillCount < 10) then
        hardBurst = 0
        SetTaskByte(Task_Challenge_Growth, 3, useFillCount + 1)
    end

    local curBurst = 0
    local growthLevel = 1
    local growthLevel2 = 1
    for i = 1, 5 do
        if (growth >= Challenge_Burst[i].low and growth <= Challenge_Burst[i].high) then
            growthLevel = i
            growthLevel2 = i
            if (growth == Challenge_Burst[i].high) then
                growthLevel2 = i + 1
            end
            break
        end
    end
    curBurst = curBurst + Challenge_Burst[growthLevel].ratio
    local buffIdx = 0
    for i = 1, 4 do
        if (HaveIBBuff(Challenge_Buff[i].buffid) > 0) then
            buffIdx = i
            break
        end
    end
    if (buffIdx > 0) then
        curBurst = curBurst + Challenge_Buff[buffIdx].ratio
    end

    local isAdded = 0
    if (hardBurst ~= 0 and growth > Challenge_Burst[1].high) then
        if ((localTime - preTime) < Const_Kill_Interval) then
            isAdded = 1
            curBurst = curBurst + Const_Kill_Burst
        end
    end
    curBurst = (curBurst < 0) and 0 or curBurst
    if (hardBurst == 0) then
        curBurst = 0
    end
    local burstStr = (curBurst == 0) and ("Kh«ng") or (curBurst .. "/1000")

    local rand = random(1, 1000)
    if (rand <= curBurst) then
        -- É¾³ýÆøÇò
        ClearEffectNpc()
        if (buffIdx > 0) then
            RemoveIBBuff(Challenge_Buff[buffIdx].buffid)
        end
        RemoveIBBuff(Buff_Challenge)
        ClearItem(6, 1, 492, 0) -- É¾³ýµÀ¾ß ³äÆøÍ²
        ClearItem(6, 1, 493, 0) -- É¾³ýµÀ¾ß Óñ·äÕë
        ClearItem(6, 1, 494, 0) -- É¾³ýµÀ¾ß ÑòÖ¬Â¶
        if (growth >= 60) then
            SetTaskByte(Task_Challenge_Enter, 4, 3)
            TaskNote(Task_Info_Challenge, 2, growth)
            Msg2Player("ThËt tiÕc, KhÝ CÇu cña b¹n ®· bÓ, nh­ng ®é lín KhÝ CÇu ®· ®¹t ®Õn" .. growth .. " §iÓm, vÉn cã thÓ ®Õn gÆp ®¹i phu nhËn th­ëng.")
            TopMessage("KhÝ CÇu cña b¹n bÞ bÓ")
        else
            SetTaskByte(Task_Challenge_Enter, 4, 0)
            TaskNote(Task_Info_Challenge, -1)
            Msg2Player("ThËt tiÕc, KhÝ CÇu cña b¹n ch­a ®¹t 60 ®iÓm ®· bÓ, cuéc thi thÊt b¹i.")
            TopMessage("KhÝ CÇu cña b¹n bÞ bÓ")
        end
        return
    end

    growth = growth + 1
    SetTaskByte(Task_Challenge_Growth, 1, growth)
    SetTask(Task_Challenge_Kill, localTime)
    TaskNote(Task_Info_Challenge, 0, growth, burstStr)

    if (growthLevel ~= growthLevel2 or growth == 100) then
        if (growth == 100) then
            local ballName = GetName() .. "_KhÝ CÇu"

            -- add by mayining 2009.6.16 Ö»ÊÇ±äÉí
            --SetEffectNpc(ballName,Const_Challenge_Balloon_End,0)	
            ModifyEffectNpc(Const_Challenge_Balloon_End)
            -- end by mayining 2009.6.16	

            SetTaskByte(Task_Challenge_Enter, 4, 2)
            TaskNote(Task_Info_Challenge, 1)
            Msg2Player("Xin chóc mõng, ®é lín KhÝ CÇu cña b¹n ®· ®¹t tèi ®a, mau ®Õn chç ®¹i phu nhËn th­ëng.")
        else
            -- ÆøÇò±äÉí
            local ballName = GetName() .. "_KhÝ CÇu"

            -- add by mayining 2009.6.16 Ö»ÊÇ±äÉí
            --SetEffectNpc(ballName,Challenge_Burst[growthLevel2].balloon,0)	
            ModifyEffectNpc(Challenge_Burst[growthLevel2].balloon)
            -- end by mayining 2009.6.16

            Msg2Player("§é lín KhÝ CÇu cña b¹n ®¹t giai ®o¹n thø" .. growthLevel2 .. ", x¸c suÊt bÓ t¨ng lªn.")
        end
    elseif (isAdded == 1) then
        Msg2Player("Tèc ®é giÕt qu¸i qu¸ nhanh lµm t¨ng x¸c suÊt bÓ cña KhÝ CÇu.")
    end

    ScrollMessage("§é lín cña KhÝ CÇu ®· t¨ng ®Õn <c=g>" .. growth .. "<c>")

end

-- Added by Zhaoqingsong at 2009-4-23 end
