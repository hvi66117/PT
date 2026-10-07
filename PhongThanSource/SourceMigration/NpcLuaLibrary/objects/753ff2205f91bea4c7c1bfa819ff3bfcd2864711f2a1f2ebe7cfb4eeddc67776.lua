NpcChr_idx = { [0] = 15, [1] = 17, [2] = 16, [3] = 21, [4] = 18, [5] = 20, [6] = 19, [7] = 19 }

JECT_TASK_STATE = 1291

Task_colorrenwu = 1355

Task_id = 1358;

Buff_danfang = 626;
Idx_danfang = 1360;
ID_danfang = 1361;

back_cele = 1379

back_numbers = 1381

function OnDeath(npcindex)

    local npcchr = GetHardNpcAttrib(npcindex)
    local mob_lvl = GetNpcLevel(npcindex)
    local mapid, x, y = GetNpcWorldPos(npcindex)
    if (npcchr >= 0) and (npcchr <= 7) then
        local i = GetPlayerExtLevel() - mob_lvl
        if (i <= 10) then
            ThrowItem(npcindex, PlayerIndex, 3, NpcChr_idx[npcchr], 0, 1, 0, 0)
        end
    end ;

    if (GetTaskByte(JECT_TASK_STATE, 1) ~= 0) and (GetTaskByte(JECT_TASK_STATE, 2) == 0) and (GetTaskByte(JECT_TASK_STATE, 4) == 11) then
        jeCreditTask()
    end

    processTopTower(npcindex)

    if (GetTaskByte(Task_colorrenwu, 4) == 3) and (GetTaskByte(Task_colorrenwu, 3) < 6) and (HaveIBBuff(569) > 0) then
        renwu31_fivecolor(x, y, mob_lvl)
    end

    if (HaveIBBuff(641) ~= 0 and GetTaskByte(back_cele, 1) ~= 0) then
        processBack_celestial(npcindex)
    end

    danfang()

    processThunder(npcindex)


end;

function processBack_celestial(npcindex)
    if (GetTaskByte(back_numbers, 3) ~= 2) then
        return
    end

    local nNpcidx = GetTask(1382)
    local nNpcId = GetNpcID(nNpcidx)
    if (nNpcId == GetTask(1383)) and (nNpcId ~= 0) then
        return
    end

    local zhenying = GetJusticEvilCredit()
    if (zhenying == 0) then
        return
    end

    local shilang_num = math.min(GetTaskByte(back_numbers, 4), 100)
    SetTaskByte(back_numbers, 4, shilang_num + 1)
    local singleordouble = GetTaskByte(back_cele, 3)
    local id, x, y = GetNpcWorldPos(npcindex)

    local rate = 0
    if (singleordouble == 2) then
        rate = 5 + shilang_num
        rate = (rate < 21) and rate or 21
    else
        rate = 3 + math.floor(shilang_num * 2 / 3)
        rate = (rate < 15) and rate or 15
    end

    if (math.random(1, 100) <= rate) then
        local m_npcIdx = 861
        local npcType = -1
        local msg = "Du hån D­¬ng S©m"
        if (zhenying > 0) then
            m_npcIdx = 862
            msg = "Du hån Kim Tra"
            TaskNote(1040, 4)
            npcType = 1
        else
            TaskNote(1041, 4)
        end

        local monsterNpcIdx = AddNpc(m_npcIdx, 40, SubWorldID2Idx(id), x * 32, y * 32)
        SetNpcScript(monsterNpcIdx, "\\script\\²»ÖÜÉ½\\ÓÎÀëÖ®ÆÇ.lua")
        SetNpcTimer(monsterNpcIdx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 300)
        SetNpcName(monsterNpcIdx, msg)
        TopMessage("<c=g>" .. msg .. "<c> xuÊt hiÖn")
        Msg2Player(msg .. " xuÊt hiÖn, hái h¾n vÒ tin tøc c¸c hån ph¸ch lang thang xem sao!")
        SetTask(1382, monsterNpcIdx)
        SetTask(1383, GetNpcID(monsterNpcIdx))
        SetNpcTask(monsterNpcIdx, 1, npcType)
    end
end

function danfang()

    local status = GetTaskByte(Task_id, 1)
    if ((status >= 1) and (status <= 3)) then
        if (GetTaskByte(Task_id, 3) == 0) then
            return
        end

        if (GetJusticEvilCredit() < 0) then
            Msg2Player("ChØ cã thÓ tiªu diÖt Phong thó s¬n hån phe Tiªn giíi.")
            return
        end

        if (HaveIBBuff(Buff_danfang) <= 0) then
            TopMessage("<c=g>Thiªn Hµnh ThuËn NghÞch<c> - nhiÖm vô thÊt b¹i")
            Msg2Player("§· qu¸ thêi gian, ch­a t×m ®ñ vËt liÖu.")
            SetTaskByte(Task_id, 3, 0)
            SetTaskByte(Task_id, 2, 0)
            SetTaskByte(Task_id, 1, 2)
            TaskNote(1036, 11)
            return
        end

        local n = GetTaskByte(Task_id, 2)
        if (n < 39) then
            ScrollMessage("Tiªu diÖt " .. (n + 1) .. " <c=g>Phong thó s¬n hån<c>")
            TaskNote(1036, 1, n + 1)
        elseif (n == 39) then
            TopMessage("Hoµn thµnh <c=g>Thiªn Hµnh ThuËn NghÞch<c>")
            Msg2Player("Hoµn thµnh nhiÖm vô tiªu diÖt <c=g>Phong thó s¬n hån<c>, vÒ phôc mÖnh VÞ TÕ L­.")
            TaskNote(1036, 2)
        end

        SetTaskByte(Task_id, 2, n + 1)
    end

end

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

        local nRand = math.random(1, 100)
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
            ScrollMessage("Thu thËp m¶nh ChiÕn kú (Tiªn) (" .. nCount .. "/5)")

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

        local nRand = math.random(1, 100)
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
            ScrollMessage("Thu thËp m¶nh ChiÕn kú (Ma) (" .. nCount .. "/5)")

            if (nRand <= nLimite) then
                Msg2Player("nhÆt 1 m¶nh ChiÕn kú (Ma), cÇn cã 5 m¶nh míi cã thÓ may thµnh Ma giíi ChiÕn kú!")
            end

        end

    end

end

Task_Tower_Status = 1347

Global_Tower = 177

Task_Info_Tower = 1032

Tower_Boss_Idx = 5

Tower_Boss = {
    { name = "Tiªn Phong Yªu" },
    { name = "Ma Phong Yªu" },
    { name = "Sãi" },
    { name = "Tiªn Phong thó s¬n hån" },
    { name = "Ma Phong thó s¬n hån" },
    { name = "HuyÕt Yªu" },
}

Tower_Obtain = {
    { desc = "Khèng chÕ 1 th¸p", total = 100, ratio = 10 },
    { desc = "Khèng chÕ 2 th¸p", total = 100, ratio = 20 },
    { desc = "Khèng chÕ 3 th¸p", total = 100, ratio = 40 },
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

    local rand = math.random(1, 100)
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
            ScrollMessage("NhËn ®­îc 1 BÊt Chu S¬n th¹ch, tæng céng ®· cã" .. getStore .. " /10 m¶nh")
        end
    end
end

function renwu31_fivecolor(px, py, npclvl)
    local state = GetTaskByte(Task_colorrenwu, 3)
    if (state >= 6) or (state <= 0) then
        return 0
    end

    local r = math.random(1, 5)
    if (r <= 1) then
        local list = {}
        local j = 0
        for i = 1, 5 do
            if (HaveEventItem(223 + i) == 0) then
                list[j] = i
                j = j + 1
            end
        end

        local rcolor = math.random(0, j - 1)
        local bossnpcidx = AddNpc(list[rcolor] + 907, npclvl, SubWorld, px * 32, py * 32)
        if (bossnpcidx > 0) then
            SetNpcScript(bossnpcidx, "\\script\\¹ÖÎï\\ÍÁ»ê.lua")
            SetNpcTask(bossnpcidx, 1, GetPlayerID())
            SetNpcName(bossnpcidx, "<c=g>Hung thó Phong thó s¬n hån<c>")
            ScrollMessage("Phãng thÝch 1 Hung thó.")
            Msg2Player("Phãng thÝch 1 Hung thó, c¨n cø thuéc tÝnh tÊn c«ng cña nã lùa chän c¸ch b¾t thÝch hîp.")
        end
    end
end

Task_Thunder_Status = 1469
Task_Thunder_Time = 1470

Global_Thunder = 210

Task_Info_Thunder = 1079

Thunder_Boss_Idx = 1

Thunder_Obtain = {
    { desc = "Phong thó s¬n hån", total = 100, ratio = 5 },
    { desc = "HuyÕt Yªu", total = 100, ratio = 2 },
}

function processThunder(npcindex)
    local extLevel = GetPlayerExtLevel()
    if (extLevel < 50) then
        return
    end
    local credit = GetJusticEvilCredit()
    credit = math.abs(credit)
    if (credit < 43000) then
        return
    end
    local taskStatus = GetTaskByte(Task_Thunder_Status, 1)
    if (taskStatus ~= 0) then
        return
    end
    if (GetBoxSize(0, 2) <= 0) then
        return 0
    end

    local rand = math.random(1, 100)
    if (rand <= Thunder_Obtain[Thunder_Boss_Idx].ratio) then
        SetTaskByte(Task_Thunder_Status, 1, 1)
        AddNormalItem(6, 1, 520, 1, 0, 0)
        TaskNote(Task_Info_Thunder, 0)
        ScrollMessage("NhËn 1 quyÓn s¸ch l¹")
        Msg2Player("NhËn 1 quyÓn s¸ch l¹.")
    end
end


