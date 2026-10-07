--description: ¿ñÄñ
--author: yaoxin 
--date: 2008/07/14

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

    if (GetLevel() <= 20) then
        MonsterDropScroll()
    end

    if (GetTask(955) == 7) and (GetTask(956) < 20) then
        Frenwu18()--½ÌÑµ¹ÖÎïÈÎÎñ£¨30¼¶ÒÔÏÂ£©--ĞÂÊÖ´å ÔÓ»õÉÌ
    end

    if (GetByte(GetTask(993), 1) == 7) then
        Frenwu1()--ĞÂÊÖ´åÒ½Éú 1¼¶ÒÔÉÏ Ê¹ÃüÕÙ»½
    end ;

    if (GetTask(936) == 5) then
        Frenwu42()--ÕòÔ­´óÏÉ  ³È×°ºÏ³É  42¼¶
    end

    -- add by mayining 2009.2.11
    if (GetTask(1089) == 3) then
        Frenwu100()
    end
    -- end by mayining
end

-- add by mayining 2009.2.11
function Frenwu100()

    local nRank = random(1, 100)
    if (nRank <= 20) then
        local nBookThread = HaveNormalItem(3, 334, 0, 0)
        if (nBookThread < 1) then
            AddNormalItem(3, 334, 0, 0, 0, 0)
            nBookThread = nBookThread + 1
            ScrollMessage("NhËn ®­îc" .. nBookThread .. "/1 TuyÕn quyÓn") -- lijin
            Msg2Player("NhËn ®­îc" .. nBookThread .. "/1 TuyÕn quyÓn") -- lijin
            TaskNote(1002, 2, nBookThread)
        end
    end

end
-- end by mayining

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

    if (type1 == 7 and count1 > 0) then
        count1 = count1 - 1
        if (count1 > 0) then
            ScrollMessage("NhiÖm vô Lİnh ®¸nh thuª: tiªu diÖt" .. npc_name[type1] .. "(" .. (50 - count1) .. "/50)")
        else
            count1 = 0
            ScrollMessage(" Hoµn thµnh Truy s¸t" .. npc_name[type1] .. ".")
        end
        SetTask(task_id, SetByte(task_val, 2, count1))
        TaskNote(task_id, 0, npc_name[type1], (50 - count1), npc_name[type2], (50 - count2))
    elseif (type2 == 7 and count2 > 0) then
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

--------------------ĞÂÊÖ´åÒ½Éú 1¼¶ÒÔÉÏ Ê¹ÃüÕÙ»½-----------------------------------
function Frenwu1()
    local testNums = GetTask(994) + 1
    local L_nums = GetByte(GetTask(993), 2) * 10
    if (testNums < L_nums) then
        SetTask(994, testNums)
        ScrollMessage("KÕ Tôc: Cßn ph¶i tiªu diÖt " .. (L_nums - testNums) .. " Cuång §iªu")
        TaskNote(51, 1, "Cuång §iªu", testNums, L_nums)
    elseif (testNums == L_nums) then
        SetTask(994, testNums)--¹Ø±Õ
        ScrollMessage(11643)
        TaskNote(51, 2)
    end

    if (testNums <= L_nums) then
        local task_rand = random(1, 100)

        if (GetTeam() ~= 0) then
            local membercount1 = GetTeamSize()

            if (task_rand <= (40 + membercount1 * 10)) then
                TopMessage("KÕ Tôc: May m¾n nhËn ®­îc 1 <c=g>Háa vò<c>")
                AddNormalItemPile(3, 8, 1, 0, 0, 0)
            end
        else
            if (task_rand > 50) then
                TopMessage("KÕ Tôc: May m¾n nhËn ®­îc 1 <c=g>Háa vò<c>")
                AddNormalItemPile(3, 8, 1, 0, 0, 0)
            end
        end ;
    elseif (testNums <= L_nums + 30) and (testNums > L_nums) then
        SetTask(994, testNums)
        if (mod(testNums, 10) == 0) then
            ScrollMessage(11643)
        end
    end
end

--½ÌÑµ¹ÖÎïÈÎÎñ£¨30¼¶ÒÔÏÂ£©--ĞÂÊÖ´å ÔÓ»õÉÌ-----------------------------------------
function Frenwu18()
    local nums = GetTask(956) + 1
    if (nums < 20) then
        SetTask(956, nums)
        ScrollMessage("Gi¸o HuÊn: Cßn ph¶i gi¸o huÊn Cuång §iªu" .. (20 - nums) .. ".")
        TaskNote(50, 1, "Cuång §iªu", nums)
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