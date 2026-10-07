NpcChr_idx = { [0] = 15, [1] = 17, [2] = 16, [3] = 21, [4] = 18, [5] = 20, [6] = 19, [7] = 19 } --À¶¹ÖµôØÔ ÊôÐÔºÅ¶ÔÓ¦ØÔË÷Òý

Task_Process = 1345      --1byte: 1:ÒÑÓÚÐÞÐÐÊ¦¶Ô»°£»2~8£ºÓë7¸öÉñ¶Ô»°£»9£ºÁìÈ¡ÁË½±Àø£¬µÚÒ»²½ÈÎÎñ½áÊø£»
--10£ºÁìÈ¡ÁÔÉ±·çÑýµÄÈÎÎñ£»11£ºÁÔÉ±Íê³É£»12£ºÁìÈ¡½±Àø£¬Õû¸öÈÎÎñ½áÊø

JECT_TASK_STATE = 1291 -- byte1:type byte2:state

--ÎåÉ«»ê
Task_colorrenwu = 1355 --1byte Ê±¼ä 2byte ´ÎÊý 3byteÈÎÎñ×´Ì¬1½Ó 2-6(×½µ½¼¸Ö»ÍÁ»ê(½ðÄ¾Ë®»ðÍÁ)) 4byte Ö¸¶¨¹ÖÎï

function OnDeath(npcindex)
    -- Added by Zhaoqingsong at 2009-3-11 Begin
    processSpiritRay(npcindex)
    -- Added by Zhaoqingsong at 2009-3-11 End
    -- Added by Zhaoqingsong at 2009-3-18 Begin
    processTopTower(npcindex)
    -- Added by Zhaoqingsong at 2009-3-18 End

    --ÁìÃü¹éÕæ
    if (GetTaskByte(Task_Process, 1) == 10 and GetJusticEvilCredit() > 0) then
        local r = random(1, 100)
        if (r >= 1 and r <= 3) then
            SetTaskByte(Task_Process, 1, 11)
            Msg2Player("Xem ra b¹n ®· cã duyªn, lÜnh ngé ®­îc huyÒn c¬ nµy! H·y mau ®i thØnh gi¸o Tu Hµnh S­")
            TopMessage("VÒ gÆp <c=g>Tu Hµnh S­<c>")
            TaskNote(1031, 6)
        end
    end
    --ÁìÃü¹éÕæ

    -- µôØÔ
    local npcchr = GetHardNpcAttrib(npcindex)--À¶¹ÖÊôÐÔ
    local mob_lvl = GetNpcLevel(npcindex) --¹ÖÎïµÈ¼¶
    local mapid, x, y = GetNpcWorldPos(npcindex)
    if (npcchr >= 0) and (npcchr <= 7) then
        local i = GetPlayerExtLevel() - mob_lvl
        if (i <= 10) then
            ThrowItem(npcindex, PlayerIndex, 3, NpcChr_idx[npcchr], 0, 1, 0, 0) --µôØÔ
        end
    end ;

    if (GetTaskByte(JECT_TASK_STATE, 1) ~= 0) and (GetTaskByte(JECT_TASK_STATE, 2) == 0) and (GetTaskByte(JECT_TASK_STATE, 4) == 12) then
        jeCreditTask()--ÏÉÄ§ÉùÍûÈÎÎñ
    end

    --ÎåÉ«»ê
    if (GetTaskByte(Task_colorrenwu, 4) == 1) and (GetTaskByte(Task_colorrenwu, 3) < 6) and (HaveIBBuff(569) > 0) then
        renwu31_fivecolor(x, y, mob_lvl)
    end
end;

--ÏÉÄ§ÉùÍûÈÎÎñ
function jeCreditTask()

    local nType = GetTaskByte(JECT_TASK_STATE, 1)
    if (nType == 1) then

        local nLimite = 0

        if (GetCamp() ~= 3) then
            Msg2Player("Phe PK l·nh ®Þa cña b¹n ph¶i lµ mµu xanh míi cã thÓ nhËn ®­îc m¶nh ChiÕn kú (Tiªn).")
        else
            if (HaveIBBuff(565) == 1) then
                nLimite = 80
            elseif (HaveIBBuff(564) == 1) then
                nLimite = 40
            elseif (HaveIBBuff(563) == 1) then
                nLimite = 20
            else
                Msg2Player("B¹n ph¶i cã ®­îc tr¹ng th¸i Chóc Dung míi cã thÓ nhËn ®­îc m¶nh ChiÕn kú (Tiªn).")
            end
        end

        local nRand = random(1, 100)
        if (nRand <= nLimite) then
            AddNormalItem(6, 1, 433, 1, 0, 0, 0)
        end

        local nCount = HaveNormalItem(6, 1, 433, 1)
        if (nCount >= 5) then
            SetTaskByte(JECT_TASK_STATE, 2, 1)
            TaskNote(1021, 1)
            ScrollMessage("Thu thËp m¶nh ChiÕn kú (Tiªn) (hoµn thµnh)")
            Msg2Player("M¶nh ChiÕn kú ®· thu thËp ®ñ, ®· cã thÓ may thµnh Tiªn giíi ChiÕn kú.")
        else
            ScrollMessage("Thu thËp m¶nh ChiÕn kú (Tiªn) (" .. nCount .. "/ 5 )")

            if (nRand <= nLimite) then
                Msg2Player("nhÆt 1 m¶nh ChiÕn kú (Tiªn), cÇn cã 5 m¶nh míi cã thÓ may thµnh Tiªn giíi ChiÕn kú!")
            end

        end

    elseif (nType == 2) then

        local nLimite = 0

        if (GetCamp() ~= 4) then
            Msg2Player("Phe PK l·nh ®Þa cña b¹n ph¶i lµ mµu vµng míi cã thÓ nhËn ®­îc m¶nh ChiÕn kú (Ma).")
        else
            if (HaveIBBuff(565) == 1) then
                nLimite = 80
            elseif (HaveIBBuff(564) == 1) then
                nLimite = 40
            elseif (HaveIBBuff(563) == 1) then
                nLimite = 20
            else
                Msg2Player("B¹n ph¶i cã ®­îc tr¹ng th¸i Chóc Dung míi cã thÓ nhËn ®­îc m¶nh ChiÕn kú (Ma).")
            end
        end

        local nRand = random(1, 100)
        if (nRand <= nLimite) then
            AddNormalItem(6, 1, 434, 1, 0, 0, 0)
        end

        local nCount = HaveNormalItem(6, 1, 434, 1)
        if (nCount >= 5) then
            SetTaskByte(JECT_TASK_STATE, 2, 1)
            TaskNote(1022, 1)
            ScrollMessage("Thu thËp m¶nh ChiÕn kú (Ma) (hoµn thµnh)")
            Msg2Player("M¶nh ChiÕn kú ®· thu thËp ®ñ, ®· cã thÓ may thµnh Ma giíi ChiÕn kú.")
        else
            ScrollMessage("Thu thËp m¶nh ChiÕn kú (Ma) (" .. nCount .. "/ 5 )")

            if (nRand <= nLimite) then
                Msg2Player("nhÆt 1 m¶nh ChiÕn kú (Ma), cÇn cã 5 m¶nh míi cã thÓ may thµnh Ma giíi ChiÕn kú!")
            end

        end

    end

end

-- Added by zhaoqingsong at 2009-3-11 Begin
-- ·¨Æ÷¿ª¹â£¬Áé¹âÕ§ÏÖ

Task_SpiritRay = 1338 -- Áé¹âÕ§ÏÖ 1byte ÈÎÎñ×´Ì¬£»2byte ÌìµØÈËÈý»êÖé»ñµÃ±êÖ¾
F11_SpiritRay = 1030   -- Áé¹âÕ§ÏÖF11

Bead_Obtain_Idx = 2

Bead_Obtain = {
    { name = "Ninh Miªu", obtainBit = 8 + 1, total = 40, ratio = 1, gen = { 4, 215, 0, 0, 0, 0 }, item = "<c=yel>Nh©n Hån Ch©u<c>" },
    { name = "Phong Yªu", obtainBit = 8 + 2, total = 20, ratio = 1, gen = { 4, 216, 0, 0, 0, 0 }, item = "<c=yel>§Þa Hån Ch©u<c>" },
    { name = "Sãi", obtainBit = 8 + 3, total = 8, ratio = 1, gen = { 4, 217, 0, 0, 0, 0 }, item = "<c=yel>Thiªn Hån Ch©u<c>" },
}

function processSpiritRay(npcindex)
    local taskStatus = GetTaskByte(Task_SpiritRay, 1)
    local obtainFlag = GetTaskBit(Task_SpiritRay, Bead_Obtain[Bead_Obtain_Idx].obtainBit)
    if (taskStatus ~= 1 or obtainFlag == 1) then
        return
    end
    local rand = random(1, Bead_Obtain[Bead_Obtain_Idx].total)
    if (rand <= Bead_Obtain[Bead_Obtain_Idx].ratio) then
        SetTaskBit(Task_SpiritRay, Bead_Obtain[Bead_Obtain_Idx].obtainBit, 1)
        local obtainTotal = GetTaskByte(Task_SpiritRay, 2)
        TaskNote(F11_SpiritRay, obtainTotal)
        local p1, p2, p3, p4, p5, p6 = myunpack(Bead_Obtain[Bead_Obtain_Idx].gen)
        AddNormalItem(p1, p2, p3, p4, p5, p6)
        TopMessage("NhËn ®­îc" .. Bead_Obtain[Bead_Obtain_Idx].item .. "!")
        Msg2Player("NhËn ®­îc 1 viªn" .. Bead_Obtain[Bead_Obtain_Idx].item .. ".")
    end
end

-- ·µ»ØÊý×éµÄËùÓÐÔªËØ,×Ô¶¨Òåº¯Êý
function myunpack(t, i)
    i = i or 1
    if t[i] then
        return t[i], myunpack(t, i + 1)
    end
end

-- Added by zhaoqingsong at 2009-3-11 end

-- Added by zhaoqingsong at 2009-3-18 Begin
-- Ã¿ÈÕÑ­»·ÈÎÎñ£¬ÇæÌìÖ®Ëþ

-- ÈÎÎñ×´Ì¬±äÁ¿
-- 1 Byte ÈÎÎñ×´Ì¬£¬0 Î´½ÓÈÎÎñ£¬1 ½ÓÈÎÎñ£¬2 ÈÎÎñÍê³É
-- 2 Byte ÈÎÎñÀàÐÍ£¬1 Õ½±¸Îï×Ê£¬2 À©³ä¾ü±¸
-- 3 Byte ÁÔÉ±¹ÖÎï±àºÅ
-- 4 Byte »ñµÃ²»ÖÜÉ½Ê¯ÊýÁ¿
Task_Tower_Status = 1347

Task_Info_Tower = 1032    -- F11

Tower_Boss_Idx = 1

Tower_Boss = {
    { name = "Tiªn Phong Yªu" }, --1
    { name = "Ma Phong Yªu" }, --2
    { name = "Sãi" }, --3
    { name = "Tiªn Phong thó s¬n hån" }, --4
    { name = "Ma Phong thó s¬n hån" }, --5
    { name = "HuyÕt Yªu" }, --6
}

Tower_Obtain = {
    { desc = "Khèng chÕ 1 th¸p", total = 100, ratio = 10 },
    { desc = "Khèng chÕ 2 th¸p", total = 100, ratio = 20 },
    { desc = "Khèng chÕ 3 th¸p", total = 100, ratio = 40 }, --songlei by 2009.9.23 µôÂä¸ÅÂÊÓÉ80µ÷ÕûÎª40
}

Tower_Rule = {
    { desc = "NhiÖm vô Tiªn giíi", name = "VËt t­ chiÕn bÞ", symbol = 1, gd = "Tiªn", npc = "Phï BËt §¹o Nh©n", camp = 3, campName = "Lam", award = "BÊt Chu HuyÒn ThiÕt", gen = { 3, 361 } },
    { desc = "NhiÖm vô Ma giíi", name = "T¨ng qu©n bÞ", symbol = -1, gd = "Ma", npc = "Lý H­ng B¸", camp = 4, campName = "Hoµng", award = "BÊt Chu Tinh Cang", gen = { 3, 362 } },
}

Tower_Buff_Rule = {
    { desc = "Tiªn ph¸i", name = "", gtask = 177 },
    { desc = "Ma ph¸i", name = "", gtask = 178 },
}

function processTopTower(npcindex)
    local taskStatus = GetTaskByte(Task_Tower_Status, 1)
    local taskType = GetTaskByte(Task_Tower_Status, 2)
    local taskBossIdx = GetTaskByte(Task_Tower_Status, 3)
    local getStore = GetTaskByte(Task_Tower_Status, 4)
    if (taskStatus ~= 1 or taskBossIdx ~= Tower_Boss_Idx) then
        return
    end
    if (GetCamp() ~= Tower_Rule[taskType].camp) then
        Msg2Player("Phe PK l·nh ®Þa cña b¹n ph¶i thuéc" .. Tower_Rule[taskType].campName .. ", míi cã thÓ nhËn ®­îc BÊt Chu S¬n th¹ch")
        return
    end
    local gdCamp = 1
    local credit = GetJusticEvilCredit()
    if (credit < 0) then
        gdCamp = 2
    end
    local controlTower = GetGlobalValue(Tower_Buff_Rule[gdCamp].gtask)
    if (controlTower == 0) then
        Msg2Player("B¹n ph¶i nhËn ®­îc tr¹ng th¸i cña Chóc Dung míi cã thÓ nhËn ®­îc BÊt Chu S¬n th¹ch")
        return
    end

    local rand = random(1, 100)
    controlTower = (controlTower > 3 and 3) or controlTower
    if (rand <= Tower_Obtain[controlTower].ratio) then
        getStore = getStore + 1
        SetTaskByte(Task_Tower_Status, 4, getStore)
        AddNormalItemPile(4, 218, 0, 0, 0, 0)
        if (getStore >= 10) then
            SetTaskByte(Task_Tower_Status, 1, 2)
            TaskNote(Task_Info_Tower + taskType, 1)
            ScrollMessage("BÊt Chu S¬n th¹ch ®· thu thËp ®Çy ®ñ!")
            Msg2Player("§· nhËn ®­îc " .. getStore .. " m¶nh BÊt Chu S¬n Th¹ch, cã thÓ quay vÒ" .. Tower_Rule[taskType].npc .. "!")
        else
            TaskNote(Task_Info_Tower + taskType, 0, Tower_Boss[taskBossIdx].name, getStore)
            ScrollMessage("NhËn ®­îc 1 BÊt Chu S¬n th¹ch, tæng céng ®· cã" .. getStore .. " / 10 m¶nh")
        end
    end
end

-- Added by zhaoqingsong at 2009-3-18 end

--ÎåÉ«»ê
function renwu31_fivecolor(px, py, npclvl)
    local state = GetTaskByte(Task_colorrenwu, 3)
    if (state >= 6) or (state <= 0) then
        return 0
    end

    local r = random(1, 6)
    if (r <= 1) then
        --1/6
        local list = {}
        local j = 0
        for i = 1, 5 do
            if (HaveEventItem(223 + i) == 0) then
                list[j] = i
                j = j + 1
            end
        end

        local rcolor = random(0, j - 1)
        local bossnpcidx = AddNpc(list[rcolor] + 897, npclvl, SubWorld, px * 32, py * 32)
        if (bossnpcidx > 0) then
            SetNpcScript(bossnpcidx, "\\script\\¹ÖÎï\\ÍÁ»ê.lua")
            SetNpcTask(bossnpcidx, 1, GetPlayerID())
            SetNpcName(bossnpcidx, "<c=g>Hung thó Phong yªu<c>")
            ScrollMessage("Phãng thÝch 1 Hung thó.")
            Msg2Player("Phãng thÝch 1 Hung thó, c¨n cø thuéc tÝnh tÊn c«ng cña nã lùa chän c¸ch b¾t thÝch hîp.")
        end
    end
end
