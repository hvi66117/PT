--description: »·¹·
--author: yaoxin 
--date: 2008/07/14

Task_DefectorPlan = 1043;
Task_DefectNum = 1044;
Task_HelpDoctor = 1099;
Task_DeliverCarbon = 1045;
Task_DriveOutNum = 1046; --   Ñ©ÖĞËÍÌ¿ÈÎÎñ¿ØÖÆ±äÁ¿
Task_hengcai = 1214;--1bitÎªÊÇ·ñ½ÓÌì½µºá²ÆÈÎÎñ;2bitÎªÊÇ·ñÍê³ÉÌì½µºá²ÆÈÎÎñ;3bitÎªÊÇ·ñ½«µÀ¾ß½»¸ø³¯¸èØÔÊ¦;4bitÎªÊÇ·ñ½«µÀ¾ß½»¸øÎ÷áªØÔÊ¦;5bitÎªÊÇ·ñÒÑ½ÓÅ£µ¶Ğ¡ÊÔ;6bitÎªÊÇ·ñÍê³ÉÅ£µ¶Ğ¡ÊÔ

npc_name = {
    [1] = "KiÕm Nh©n",
    [4] = "X¹ Nh©n",
    [8] = "Hoµn CÈu",
    [14] = "Gi¸p Cèt",
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
        end
        PlayerIndex = oldPlayer
    else
        -- ÎŞ¶ÓÎé
        --Ó¶±øÓªÁÔÉ±ÈÎÎñ
        if (GetTask(852) > 0) then
            liesha_city(w)
        end
    end ;

    ---µôÂäÈÎÎñ¾íÖáµôÂä
    if (GetLevel() <= 20) then
        MonsterDropScroll()
    end

    if (GetTask(1116) == 1) and (GetByte(GetTask(1122), 1) == 7) then
        MonsterTip()
    end

    if (GetPlayerType() < 2) then
        -----------ÅÑ¾ü¼Æ»®ÈÎÎñ
        if (GetTask(Task_DefectorPlan) == 1) and (GetByte(GetTask(Task_DefectNum), 1) == 7) then
            FNewPlan(w, x, y)
        end

        --Çı³ıÒş»¼
        if (GetTask(Task_DeliverCarbon) == 3) then
            if (GetByte(GetTask(Task_DriveOutNum), 1) == 7) then
                FNewquzhu()
            end
        end
    else
        local L_HelpDoctor = GetTask(Task_HelpDoctor)
        if (GetByte(L_HelpDoctor, 1) == 5) then
            if (GetByte(L_HelpDoctor, 2) == 7) then
                FNewquzhu()
            end
        end
    end

    if (GetTask(955) == 8) and (GetTask(956) < 20) then
        Frenwu18()--½ÌÑµ¹ÖÎïÈÎÎñ£¨30¼¶ÒÔÏÂ£©--ĞÂÊÖ´å ÔÓ»õÉÌ
    end

    if (GetTask(936) == 5) then
        Frenwu42()--ÕòÔ­´óÏÉ  ³È×°ºÏ³É  42¼¶
    end
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

    if (type1 == 8 and count1 > 0) then
        count1 = count1 - 1
        if (count1 > 0) then
            ScrollMessage("NhiÖm vô Lİnh ®¸nh thuª: tiªu diÖt" .. npc_name[type1] .. "(" .. (50 - count1) .. "/50)")
        else
            count1 = 0
            ScrollMessage(" Hoµn thµnh Truy s¸t" .. npc_name[type1] .. ".")
        end
        SetTask(task_id, SetByte(task_val, 2, count1))
        TaskNote(task_id, 0, npc_name[type1], (50 - count1), npc_name[type2], (50 - count2))
    elseif (type2 == 8 and count2 > 0) then
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

--½ÌÑµ¹ÖÎïÈÎÎñ£¨30¼¶ÒÔÏÂ£©--ĞÂÊÖ´å ÔÓ»õÉÌ-----------------------------------------
function Frenwu18()
    local nums = GetTask(956) + 1
    if (nums < 20) then
        SetTask(956, nums)
        ScrollMessage("Gi¸o HuÊn: Cßn ph¶i gi¸o huÊn Hoµn CÈu" .. (20 - nums) .. ".")
        TaskNote(50, 1, "Hoµn CÈu", nums)
    elseif (nums == 20) then
        SetTask(956, 21)
        ScrollMessage(" Hoµn thµnh nhiÖm vô Gi¸o huÊn")
        TaskNote(50, 2)
    end
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

function MonsterDropScroll()
    if (GetTask(1116) == 0) and (HaveNormalItem(6, 1, 304, 1) < 1) then
        local nProp = random(1, 100)
        if (nProp <= 4) then
            AddNormalItem(6, 1, 304, 1, 0, 0) --»·¹·ÁÔÉ±¾íÖá
            TopMessage(11613)
            Msg2Player("B¹n may m¾n nhËn ®­îc 1 Hoµn CÈu MËt tŞch")
        end
    end

    if (GetTask(1119) == 0 and HaveNormalItem(6, 1, 309, 1) < 1) then
        local nProp = random(1, 100)
        if (nProp <= 1) then
            AddNormalItem(6, 1, 309, 1, 0, 0)
            ---ÊÕ¼¯¾íÖá
            TopMessage(11612)
            Msg2Player("B¹n bÊt ngê nhËn ®­îc 1 Thu thËp mËt tŞch.")
        end
    end
end

function MonsterTip()
    local nTaskInfo = GetTask(1122)
    local nNeedNum = GetByte(nTaskInfo, 2)
    local nReaNum = GetByte(nTaskInfo, 3)
    if (nReaNum < nNeedNum) then
        nReaNum = nReaNum + 1
        SetTask(1122, SetByte(nTaskInfo, 3, nReaNum))
        if (nReaNum >= nNeedNum) then
            SetTask(1116, 2)
            TaskNote(914, 2)
            TopMessage(11619)
            Msg2Player("Hoµn thµnh nhiÖm vô Hoµn CÈu, cã thÓ t×m T¹p hãa Th­¬ng l·nh th­ëng!")
        else
            TaskNote(914, 1, nReaNum, nNeedNum)
            TopMessage("Tiªu diÖt Hoµn CÈu" .. nReaNum .. "/" .. nNeedNum .. ".")
            Msg2Player("Tiªu diÖt Hoµn CÈu" .. nReaNum .. "/" .. nNeedNum .. ".")
        end
    end
end
-----------ÅÑ¾ü¼Æ»®ÈÎÎñ
function FNewPlan(w, x, y)
    local nTaskInfo = GetTask(Task_DefectNum)
    local nNum = GetByte(nTaskInfo, 2)
    local nRealNum = GetByte(nTaskInfo, 3) + 1
    local membercount = GetTeamSize()

    SetTask(Task_DefectNum, SetByte(GetTask(Task_DefectNum), 3, nRealNum))
    if (membercount == 0) then
        if (nRealNum < nNum) then
            TaskNote(902, "Hoµn CÈu", nRealNum, nNum)
            Msg2Player("Ph¶n Qu©n KÕ: Cßn ph¶i tiªu diÖt " .. (nNum - nRealNum) .. " Hoµn CÈu")
        else
            SetTask(Task_DefectorPlan, 2)
            local newnpcidx = AddNpc(575, 20, SubWorld, x * 32, y * 32)
            SetNpcName(newnpcidx, "<c=g>Hoµn CÈu V­¬ng<c>")
            TopMessage(11626)
            Msg2Player("Hoµn CÈu V­¬ng xuÊt hiÖn.")
            SetTask(Task_DefectNum, SetByte(nTaskInfo, 3, 0))
        end

    else
        local nCountTmp = 0
        local oldPlayer = PlayerIndex
        local wX, xX, yX
        local nTempRealNum = 0
        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)
            wX, xX, yX = GetWorldPos()

            nTempRealNum = GetByte(GetTask(Task_DefectNum), 3)
            if (wX == w) then
                nCountTmp = nCountTmp + nTempRealNum
            end
        end
        PlayerIndex = oldPlayer

        if (nCountTmp < nNum) then
            oldPlayer = PlayerIndex
            for i = 1, membercount do
                PlayerIndex = GetTeamMember(i)
                wX, xX, yX = GetWorldPos()
                if (wX == w) then
                    Msg2Player("Ph¶n Qu©n KÕ: Cßn ph¶i tiªu diÖt " .. (nNum - nCountTmp) .. " Hoµn CÈu")
                end
            end
            PlayerIndex = oldPlayer
        else
            local newnpcidx = AddNpc(575, 20, SubWorld, x * 32, y * 32)
            SetNpcName(newnpcidx, "<c=g>Hoµn CÈu V­¬ng<c>")
            for i = 1, membercount do
                PlayerIndex = GetTeamMember(i)
                wX, xX, yX = GetWorldPos()
                if (wX == w) then
                    SetTask(Task_DefectNum, SetByte(GetTask(Task_DefectNum), 3, 0))
                    if (GetTask(Task_DefectorPlan) == 1) then
                        SetTask(Task_DefectorPlan, 2)
                        TopMessage(11626)
                        Msg2Player("Hoµn CÈu V­¬ng xuÊt hiÖn.")
                    end
                end
            end
            PlayerIndex = oldPlayer
        end
    end
end

--ÇıÖğÒş»¼
function FNewquzhu()
    local nGoodCount = HaveEventItemCount(191)
    if (nGoodCount >= 5) then
        return 0
    end

    local nProp = random(1, 5)
    if (nProp <= 2) then
        AddIBBuff(335)
        TopMessage(11631)
        Msg2Player("B¹n nhËn ®­îc Hoµn CÈu Ên Kı.")
    end
end