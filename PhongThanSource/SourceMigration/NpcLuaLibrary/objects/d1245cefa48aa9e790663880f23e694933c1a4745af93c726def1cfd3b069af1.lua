--description: Ì¦Ñı
--author: yaoxin 
--date: 2008/07/14

Task_DevilDisaster = 1097--   ÒìÈËÌ¦ÑıÖ®»¼ÈÎÎñ¿ØÖÆ±äÁ¿ 
Task_DevilNum = 1098--	 ÒìÈËÉ±ËÀÌ¦ÑıÊıÄ¿

--yaoxin 13-18Ö§Ïß ÒìÈË
Task_newer13 = 1416 --1byte Â÷Ìì¹ıº£ÈÎÎñ²½Öè£¨1·ç²®Í¼ÌÚ½ÓÈÎÎñ2È¥ÕÒÓÎ»ê¹ØµÄÒ½Éú3»¹¸øÕÅÌì¾ı4ò¿ÓÈÄ¹Ò½Éú5¸æÖ®ÕÅÌì¾ı6ÕÒ·ç²®Í¼ÌÚ£©

npc_name = {
    [3] = "Háa DiÖn",
    [6] = "Lôc Qu¸i",
    [7] = "Cuång §iªu",
    [10] = "Th¶o Tiªn",
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
        local i = GetLevel() - 10
        if (i <= 10) then
            ThrowItem(npcindex, PlayerIndex, 3, NpcChr_idx[npcchr], 0, 1, 0, 0) --µôØÔ
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

    if (GetPlayerType() == 2) then
        --  Ì¦ÑıÖ®»¼ 
        if (GetTask(Task_DevilDisaster) >= 1 and GetTask(Task_DevilDisaster) <= 6
        ) and (GetByte(GetTask(Task_DevilNum), 1) == 5) then
            FNewPlan(w, x, y)
        end

        if (w == 11) and (GetTaskByte(Task_newer13, 1) == 1) and (HaveEventItem(236) == 0) then
            FNewPlan13()--Â÷Ìì¹ıº£
        end
    end

    if (GetTask(955) == 6) and (GetTask(956) < 20) then
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

    if (type1 == 6 and count1 > 0) then
        count1 = count1 - 1
        if (count1 > 0) then
            ScrollMessage("NhiÖm vô Lİnh ®¸nh thuª: tiªu diÖt" .. npc_name[type1] .. "(" .. (50 - count1) .. "/50)")
        else
            count1 = 0
            ScrollMessage(" Hoµn thµnh Truy s¸t" .. npc_name[type1] .. ".")
        end
        SetTask(task_id, SetByte(task_val, 2, count1))
        TaskNote(task_id, 0, npc_name[type1], (50 - count1), npc_name[type2], (50 - count2))
    elseif (type2 == 6 and count2 > 0) then
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
        ScrollMessage("Gi¸o HuÊn: Cßn ph¶i gi¸o huÊn Lôc Qu¸i" .. (20 - nums) .. ".")
        TaskNote(50, 1, "Lôc Qu¸i", nums)
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

--  Ì¦ÑıÖ®»¼
function FNewPlan(w, x, y)
    local nTaskInfo = GetTask(Task_DevilNum)
    local nNum = GetByte(nTaskInfo, 2)
    local nRealNum = GetByte(nTaskInfo, 3) + 1
    local membercount = GetTeamSize()

    SetTask(Task_DevilNum, SetByte(GetTask(Task_DevilNum), 3, nRealNum))
    if (membercount == 0) then
        if (nRealNum < nNum) then
            TaskNote(1007, "Lôc Qu¸i", nRealNum, nNum)
            Msg2Player("NhiÖm vô Lôc Qu¸i: Cßn ph¶i tiªu diÖt " .. (nNum - nRealNum) .. " Lôc Qu¸i.")
        else
            if (GetTask(Task_DevilDisaster) == 1) or (GetTask(Task_DevilDisaster) == 3) or (GetTask(Task_DevilDisaster) == 5) then
                SetTask(Task_DevilDisaster, GetTask(Task_DevilDisaster) + 1)
            end
            local newnpcidx = AddNpc(607, 20, SubWorld, x * 32, y * 32)
            SetNpcName(newnpcidx, "<c=g>Lôc Qu¸i V­¬ng<c>")
            TopMessage(11630)
            Msg2Player("Lôc Qu¸i V­¬ng xuÊt hiÖn")
            SetTask(Task_DevilNum, SetByte(nTaskInfo, 3, 0))
        end

    else
        local nCountTmp = 0
        local oldPlayer = PlayerIndex
        local wX, xX, yX
        local nTempRealNum = 0
        for i = 1, membercount do
            PlayerIndex = GetTeamMember(i)
            wX, xX, yX = GetWorldPos()
            nTempRealNum = GetByte(GetTask(Task_DevilNum), 3)
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
                    Msg2Player("NhiÖm vô Lôc Qu¸i: Cßn ph¶i tiªu diÖt " .. (nNum - nCountTmp) .. " Lôc Qu¸i.")
                end
            end
            PlayerIndex = oldPlayer
        else
            local newnpcidx = AddNpc(607, 20, SubWorld, x * 32, y * 32)
            SetNpcName(newnpcidx, "<c=g>Lôc Qu¸i V­¬ng<c>")
            for i = 1, membercount do
                PlayerIndex = GetTeamMember(i)
                wX, xX, yX = GetWorldPos()
                if (wX == w) then
                    SetTask(Task_DevilNum, SetByte(GetTask(Task_DevilNum), 3, 0))
                    TopMessage(11630)
                    Msg2Player("Lôc Qu¸i V­¬ng xuÊt hiÖn")
                    if (GetTask(Task_DevilDisaster) == 1) or (GetTask(Task_DevilDisaster) == 3) or (GetTask(Task_DevilDisaster) == 5) then
                        SetTask(Task_DevilDisaster, GetTask(Task_DevilDisaster) + 1)
                    end
                end
            end
            PlayerIndex = oldPlayer
        end
    end
end

--Â÷Ìì¹ıº£
function FNewPlan13()
    local r = random(1, 10)
    if (r <= 3) and (GetTaskByte(Task_newer13, 1) == 1) and (HaveEventItem(236) == 0) then
        if (HaveEventItem(235) == 0) then
            Msg2Player("Thu thËp ®­îc n­íc m¾t Lôc Qu¸i, cßn thiÕu má Cuång §iªu")
        else
            SetTaskByte(Task_newer13, 1, 2)
            Msg2Player("§i t×m §¹i Phu ë Du Hån dïng Tam Muéi Ch©n Háa nÊu vËt phÈm nµy thµnh Linh ®¬n!")
            TaskNote(205, 1)
        end
        AddEventItem(236)
        TopMessage("NhËn 1 giät n­íc m¾t Lôc Qu¸i")
    end
end