--description: ²İÏÉ
--author: yaoxin 
--date: 2008/07/14

Task_PrepareMaterial = 1049;
Task_PrepareMaterNum = 1050;

Task_hengcai = 1214;--1bitÎªÊÇ·ñ½ÓÌì½µºá²ÆÈÎÎñ;2bitÎªÊÇ·ñÍê³ÉÌì½µºá²ÆÈÎÎñ;3bitÎªÊÇ·ñ½«µÀ¾ß½»¸ø³¯¸èØÔÊ¦;4bitÎªÊÇ·ñ½«µÀ¾ß½»¸øÎ÷áªØÔÊ¦;5bitÎªÊÇ·ñÒÑ½ÓÅ£µ¶Ğ¡ÊÔ;6bitÎªÊÇ·ñÍê³ÉÅ£µ¶Ğ¡ÊÔ

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

    if (GetByte(GetTask(1127), 1) == 1 and GetByte(GetTask(1127), 2) == 9) then
        MonsterTip()
    end

    ---Ô¤±¸Îï×Ê
    if (GetTask(Task_PrepareMaterial) == 1) then
        if (GetPlayerType() == 2) and (GetByte(GetTask(Task_PrepareMaterNum), 1) == 9) then
            FPreGoodsNew()
        end
    end

    if (GetTask(955) == 10) and (GetTask(956) < 20) then
        Frenwu18()--½ÌÑµ¹ÖÎïÈÎÎñ£¨30¼¶ÒÔÏÂ£©--ĞÂÊÖ´å ÔÓ»õÉÌ
    end

    if (GetTask(936) > 0) then
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

    if (type1 == 10 and count1 > 0) then
        count1 = count1 - 1
        if (count1 > 0) then
            ScrollMessage("NhiÖm vô Lİnh ®¸nh thuª: tiªu diÖt" .. npc_name[type1] .. "(" .. (50 - count1) .. "/50)")
        else
            count1 = 0
            ScrollMessage(" Hoµn thµnh Truy s¸t" .. npc_name[type1] .. ".")
        end
        SetTask(task_id, SetByte(task_val, 2, count1))
        TaskNote(task_id, 0, npc_name[type1], (50 - count1), npc_name[type2], (50 - count2))
    elseif (type2 == 10 and count2 > 0) then
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
        ScrollMessage("Gi¸o HuÊn: Cßn ph¶i gi¸o huÊn Th¶o Tiªn" .. (20 - nums) .. ".")
        TaskNote(50, 1, "Th¶o Tiªn", nums)
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
        local zyCNums = GetByte(GetTask(938), 3) + 1
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
            AddNormalItemPile(3, 101, 1, 0, 0, 0)
            TopMessage(11645)
            SetTask(938, SetByte(GetTask(938), 3, zyCNums))
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

function MonsterDropScroll()
    if (GetTask(1127) == 0) and (HaveNormalItem(6, 1, 306, 1) < 1) then
        local nProp = random(1, 100)
        local nlv = GetLevel()
        if (nlv >= 9) and (nlv <= 13) then
            if (nProp <= 10) then
                AddNormalItem(6, 1, 306, 1, 0, 0)        --²İÏÉ¾íÖá
                TopMessage(11617)
                Msg2Player("B¹n bÊt ngê nhËn ®­îc 1 Th¶o Tiªn mËt tŞch")
            end
        else
            if (nProp <= 4) then
                AddNormalItem(6, 1, 306, 1, 0, 0)        --²İÏÉ¾íÖá
                TopMessage(11617)
                Msg2Player("B¹n bÊt ngê nhËn ®­îc 1 Th¶o Tiªn mËt tŞch")
            end
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

---ÊÕ¼¯¹ÖÎïÁÔÉ±ÌáÊ¾
function MonsterTip()
    local val = GetTask(1127)
    local L_DzrNum = GetByte(val, 3)
    local L_KillNum = GetByte(val, 4) + 1

    SetTask(1127, SetByte(val, 4, L_KillNum))
    if (L_KillNum >= L_DzrNum) then
        SetTask(1127, SetByte(val, 1, 2))
        TaskNote(1010, 2)
        TopMessage(11623)
        Msg2Player("Hoµn thµnh nhiÖm vô Th¶o Tiªn mËt tŞch, cã thÓ t×m T¹p hãa Th­¬ng l·nh th­ëng!")
    else
        TaskNote(1010, 1, L_KillNum, L_DzrNum)
        TopMessage("Tiªu diÖt Th¶o Tiªn" .. L_KillNum .. "/" .. L_DzrNum .. ".")
        Msg2Player("Tiªu diÖt Th¶o Tiªn" .. L_KillNum .. "/" .. L_DzrNum .. ".")
    end
end

--Ô¤±¸Îï×Ê
function FPreGoodsNew()
    local L_TaskInfo = GetTask(Task_PrepareMaterNum)
    local L_ObjectNum = GetByte(L_TaskInfo, 2)
    local L_RealNum = HaveNormalItem(3, 146, 0, 0)
    if (L_RealNum < L_ObjectNum) then
        local nProp = random(1, 10)
        if (nProp <= 3) then
            AddNormalItemPile(3, 146, 0, 0, 0, 0)
            ----Áú¹«Öñ
            L_RealNum = L_RealNum + 1
            if (L_RealNum >= L_ObjectNum) then
                TopMessage(11635)
                Msg2Player("B¹n ®· thu thËp ®ñ <c=g>Tróc<c>.")
            else
                TopMessage(11636)
                Msg2Player("B¹n nhËn ®­îc 1 Tróc.")
            end
        end
    end
end