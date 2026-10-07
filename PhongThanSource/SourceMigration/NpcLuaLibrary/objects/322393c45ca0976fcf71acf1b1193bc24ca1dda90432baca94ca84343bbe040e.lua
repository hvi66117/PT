Task_Boss_Item = 1844

function main()
    local nTimes = GetNpcTask(DialogNpcIdx, 1)
    local nExtLevel = GetPlayerExtLevel()
    local nToday = math.mod(math.floor(LocalSystemTime() / 86400), 256)
    local nLastDay = GetTaskByte(Task_Boss_Item, 1)
    if (nToday ~= nLastDay) then
        SetTaskByte(Task_Boss_Item, 1, nToday)
        SetTaskByte(Task_Boss_Item, 2, 0)
        SetTaskByte(Task_Boss_Item, 3, 0)
    end

    if (nTimes >= 12) then
        Talk(1, "no", "BÝ b¶o ®· bÞ do th¸m 12 lÇn, ph¸p lùc cña nã ®· mÊt vµ biÕn mÊt råi.")
        DelNpc(DialogNpcIdx)
        return
    end

    if (nExtLevel < 15) then
        Talk(1, "no", "CÊp ®é Tiªn Ma ch­a ®¹t cÊp 15, kh«ng thÓ dß th¸m bÝ b¶o.")
        return
    end

    if (GetTaskByte(Task_Boss_Item, 3) > 0) then
        Talk(1, "no", " B¹n ®· tõng do th¸m bÝ b¶o, kh«ng cÇn dß th¸m n÷a.")
        return
    end

    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "Tói cña b¹n kh«ng ®ñ chç, h·y dän dÑp råi ®Õn nhÐ.")
        return
    end

    local nInterrupt = 0
    nInterrupt = SetBit(nInterrupt, 1, 1)
    nInterrupt = SetBit(nInterrupt, 2, 1)
    nInterrupt = SetBit(nInterrupt, 3, 1)
    nInterrupt = SetBit(nInterrupt, 4, 1)
    nInterrupt = SetBit(nInterrupt, 5, 1)
    nInterrupt = SetBit(nInterrupt, 6, 0)
    nInterrupt = SetBit(nInterrupt, 7, 1)
    nInterrupt = SetBit(nInterrupt, 9, 1)
    nInterrupt = SetBit(nInterrupt, 11, 1)

    SetTask(140, GetNpcID(DialogNpcIdx))
    BeginMotion(DialogNpcIdx, 0, 10, "\\script\\¹ÖÎï\\É½ÉñÃØ±¦.lua", nInterrupt)
end;

function EndMotion(npcIdx)
    no()
    local nTimes = GetNpcTask(npcIdx, 1)
    local nExtLevel = GetPlayerExtLevel()

    if (npcIdx <= 0 or GetNpcTemplateID(npcIdx) ~= 1942 or GetNpcID(npcIdx) ~= GetTask(140)) then
        Talk(1, "no", "B¹n dß th¸m qu¸ muén, bÝ b¶o bÞ S¬n ThÇn triÖu håi råi.")
        return
    end

    if (nTimes >= 12) then
        Talk(1, "no", "BÝ b¶o ®· bÞ do th¸m 12 lÇn, ph¸p lùc cña nã ®· mÊt vµ biÕn mÊt råi.")
        DelNpc(npcIdx)
        return
    end

    if (nExtLevel < 15) then
        Talk(1, "no", "CÊp ®é Tiªn Ma ch­a ®¹t cÊp 15, kh«ng thÓ dß th¸m bÝ b¶o.")
        return
    end

    if (GetTaskByte(Task_Boss_Item, 3) > 0) then
        Talk(1, "no", " B¹n ®· tõng do th¸m bÝ b¶o, kh«ng cÇn dß th¸m n÷a.")
        return
    end

    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "Tói cña b¹n kh«ng ®ñ chç, h·y dän dÑp råi ®Õn nhÐ.")
        return
    end
    SetTaskByte(Task_Boss_Item, 3, 1)
    SetNpcTask(npcIdx, 1, nTimes + 1)

    local nRand = math.random(1, 1000)
    local str = ""

    if (nRand <= 15) then
        if (GetNpcTask(npcIdx, 3) == 0) then
            AddNormalItemBind(3, 374, 0, 0, 0, 0, 0)
            str = "1 Vi Quang Qu¸i Phï."
            SetNpcTask(npcIdx, 3, 1)
        else
            AddNormalItemBind(3, 448, 0, 0, 0, 0, 1)
            str = "1 Th­¬ng Long gi¸c"
        end
    elseif (nRand <= 20) then
        if (GetNpcTask(npcIdx, 4) == 0) then
            AddNormalItemBind(3, 383, 0, 0, 0, 0, 0)
            str = "1 Tinh Th¸i Qu¸i Phï ."
            SetNpcTask(npcIdx, 4, 1)
        else
            AddNormalItemBind(3, 448, 0, 0, 0, 0, 1)
            str = "1 Th­¬ng Long gi¸c"
        end
    elseif (nRand <= 80) then
        if (GetNpcTask(npcIdx, 5) == 0) then
            local nItem = {
                { "XÝch Viªm Ngäc Tinh (ch­a mµi) ", 257 },
                { "Thanh Minh Ngäc Tinh (ch­a mµi) ", 264 },
                { "Tö Hµ Ngäc Tinh (ch­a mµi) ", 271 },
            }
            local nId = math.random(1, 3)
            AddNormalItemBind(3, nItem[nId][2], 0, 0, 0, 0, 0)
            str = "1" .. nItem[nId][1] .. "."
            SetNpcTask(npcIdx, 5, 1)
        else
            AddNormalItemBind(3, 448, 0, 0, 0, 0, 1)
            str = "1 Th­¬ng Long gi¸c"
        end

    elseif (nRand <= 230) then
        for i = 1, 20 do
            AddNormalItem(3, 115, 0, 0, 0, 0)
        end
        str = "20 Tø T­îng Tinh Hoa."
    elseif (nRand <= 380) then
        for i = 1, 20 do
            AddNormalItem(3, 114, 0, 0, 0, 0)
        end
        str = "20 Lôc §¹o Tinh Hoa."
    elseif (nRand <= 600) then
        if (GetJusticEvilCredit() > 0) then
            for i = 1, 10 do
                AddNormalItem(3, 428, 0, 0, 0, 0)
            end
            str = "10 Tôc MÖnh Hoa."
        else
            for i = 1, 10 do
                AddNormalItem(3, 427, 0, 0, 0, 0)
            end
            str = "10 Du Th­¬ng Th¶o,"
        end
    elseif (nRand <= 800) then
        for i = 1, 10 do
            AddNormalItem(6, 1, 587, 1, 0, 0)
        end
        str = "10 Thiªn Linh Th¹ch."

    elseif (nRand <= 850) then
        local nItem = {
            { "XÝch Viªm L­¬ng Ngäc (ch­a mµi) ", 255 },
            { "Thanh Minh L­¬ng Ngäc (ch­a mµi) ", 262 },
            { "Tö Hµ L­¬ng Ngäc (ch­a mµi) ", 269 },
        }
        local nId = math.random(1, 3)
        AddNormalItemBind(3, nItem[nId][2], 0, 0, 0, 0, 0)
        str = "1" .. nItem[nId][1] .. "."
    else
        AddNormalItemBind(3, 448, 0, 0, 0, 0, 1)
        str = "1 Th­¬ng Long gi¸c"
    end

    Msg2Player("Ng­¬i ®· nhËn ®­îc " .. str)
    WriteLog("BÝ B¶o S¬nh ThÇn: nhËn" .. str)
    local nLeftTime = 12 - nTimes - 1
    if (nLeftTime == 0) then
        DelNpc(npcIdx)
        Msg2CurMapAnnounce(GetName() .. "§i th¸m thÝnh bÝ b¶o S¬n ThÇn, nhËn ®­îc " .. str .. "sau 12 lÇn ®iÒu tra ph¸p lùc cña bÝ b¶o mÊt dÇn.")
    elseif (nLeftTime <= 3) then
        Msg2CurMapAnnounce(GetName() .. "§i th¸m thÝnh bÝ b¶o S¬n ThÇn, nhËn ®­îc " .. str .. "BÝ b¶o cßn" .. nLeftTime .. "®Õn kiÓm tra th¸m thÝnh,")
    else
        Msg2CurMapAnnounce(GetName() .. "§i th¸m thÝnh bÝ b¶o S¬n ThÇn, nhËn ®­îc " .. str)
    end
end

function InteruptMotion(MotionID)
end

function no()
    CloseDialog()
end
