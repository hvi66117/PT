--description: É½ÉñÃØ±¦
--author: liujifang
--date: 2013-1-5

Task_Boss_Item = 1844    --1byte¼ÇÂ¼Ê±¼ä
--2byte¿ªÆôÃ÷ÒÄÃØ±¦
--3byte¿ªÆôÉ½ÉñÃØ±¦
--NpcTask:1task¼ÇÂ¼¿ªÆô±¦ÏäµÄ´ÎÊı
--2task¼ÇÂ¼²ÔÁú½ÇµÄ¿ªÆô¸öÊı
--3task¼ÇÂ¼Î¢¹âØÔ·ûµÄ¿ªÆô¸öÊı
--4task¼ÇÂ¼ĞÇ²ÊØÔ·ûµÄ¿ªÆô¸öÊı

function main()
    local nTimes = GetNpcTask(DialogNpcIdx, 1)
    local nExtLevel = GetPlayerExtLevel()
    local nToday = mod(floor(LocalSystemTime() / 86400), 256)
    local nLastDay = GetTaskByte(Task_Boss_Item, 1)
    if (nToday ~= nLastDay) then
        SetTaskByte(Task_Boss_Item, 1, nToday)
        SetTaskByte(Task_Boss_Item, 2, 0)
        SetTaskByte(Task_Boss_Item, 3, 0)
    end

    if (nTimes >= 12) then
        Talk(1, "no", "Bİ b¶o ®· bŞ do th¸m 12 lÇn, ph¸p lùc cña nã ®· mÊt vµ biÕn mÊt råi.")
        DelNpc(DialogNpcIdx)
        return
    end

    if (nExtLevel < 15) then
        Talk(1, "no", "CÊp ®é Tiªn Ma ch­a ®¹t cÊp 15, kh«ng thÓ dß th¸m bİ b¶o.")
        return
    end

    if (GetTaskByte(Task_Boss_Item, 3) > 0) then
        Talk(1, "no", " B¹n ®· tõng do th¸m bİ b¶o, kh«ng cÇn dß th¸m n÷a.")
        return
    end

    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "Tói cña b¹n kh«ng ®ñ chç, h·y dän dÑp råi ®Õn nhĞ.")
        return
    end

    local nInterrupt = 0
    nInterrupt = SetBit(nInterrupt, 1, 1)    --µÇ³ö
    nInterrupt = SetBit(nInterrupt, 2, 1)    --ÒÆ¶¯
    nInterrupt = SetBit(nInterrupt, 3, 1)    --¼¼ÄÜ
    nInterrupt = SetBit(nInterrupt, 4, 1)    --ÊÜÉË
    nInterrupt = SetBit(nInterrupt, 5, 1)    --¿çµØÍ¼
    nInterrupt = SetBit(nInterrupt, 6, 0)    --·¨Æ÷
    nInterrupt = SetBit(nInterrupt, 7, 1)
    nInterrupt = SetBit(nInterrupt, 9, 1)    --ËÀÍö
    nInterrupt = SetBit(nInterrupt, 11, 1)    --¿Í»§¶Ë°´ESC

    SetTask(140, GetNpcID(DialogNpcIdx))
    BeginMotion(DialogNpcIdx, 0, 10, "\\script\\¹ÖÎï\\É½ÉñÃØ±¦.lua", nInterrupt)
end;

function EndMotion(npcIdx)
    no()
    local nTimes = GetNpcTask(npcIdx, 1)
    local nExtLevel = GetPlayerExtLevel()

    if (npcIdx <= 0 or GetNpcTemplateID(npcIdx) ~= 1942 or GetNpcID(npcIdx) ~= GetTask(140)) then
        Talk(1, "no", "B¹n dß th¸m qu¸ muén, bİ b¶o bŞ S¬n ThÇn triÖu håi råi.")
        return
    end

    if (nTimes >= 12) then
        Talk(1, "no", "Bİ b¶o ®· bŞ do th¸m 12 lÇn, ph¸p lùc cña nã ®· mÊt vµ biÕn mÊt råi.")
        DelNpc(npcIdx)
        return
    end

    if (nExtLevel < 15) then
        Talk(1, "no", "CÊp ®é Tiªn Ma ch­a ®¹t cÊp 15, kh«ng thÓ dß th¸m bİ b¶o.")
        return
    end

    if (GetTaskByte(Task_Boss_Item, 3) > 0) then
        Talk(1, "no", " B¹n ®· tõng do th¸m bİ b¶o, kh«ng cÇn dß th¸m n÷a.")
        return
    end

    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "Tói cña b¹n kh«ng ®ñ chç, h·y dän dÑp råi ®Õn nhĞ.")
        return
    end
    SetTaskByte(Task_Boss_Item, 3, 1)
    SetNpcTask(npcIdx, 1, nTimes + 1)

    local nRand = random(1, 1000)
    local str = ""
    --modified by liujifang for 3ÔÂ´ı´ğ¸´ÕûÌåÓÅ»¯ at 2013-02-28 begin
    if (nRand <= 20) then
        if (GetNpcTask(npcIdx, 3) == 0) then
            AddNormalItemBind(3, 374, 0, 0, 0, 0, 1)
            str = "1 Vi Quang Qu¸i Phï."
            SetNpcTask(npcIdx, 3, 1)
        else
            AddNormalItemBind(3, 448, 0, 0, 0, 0, 1)
            str = "1 Th­¬ng Long gi¸c"
        end
    elseif (nRand <= 25) then
        if (GetNpcTask(npcIdx, 4) == 0) then
            AddNormalItemBind(3, 383, 0, 0, 0, 0, 1)
            str = "1 Tinh Th¸i Qu¸i Phï ."
            SetNpcTask(npcIdx, 4, 1)
        else
            AddNormalItemBind(3, 448, 0, 0, 0, 0, 1)
            str = "1 Th­¬ng Long gi¸c"
        end
    elseif (nRand <= 175) then
        AddNormalItemBind(3, 448, 0, 0, 0, 0, 1)
        str = "1 Th­¬ng Long gi¸c"
        --modified by liujifang for 3ÔÂ´ı´ğ¸´ÕûÌåÓÅ»¯ at 2013-02-28 end
    elseif (nRand <= 375) then
        for i = 1, 20 do
            AddNormalItemBind(3, 115, 0, 0, 0, 0, 1)
        end
        str = "20 Tø T­îng Tinh Hoa."
    elseif (nRand <= 575) then
        for i = 1, 20 do
            AddNormalItemBind(3, 114, 0, 0, 0, 0, 1)
        end
        str = "20 Lôc §¹o Tinh Hoa."
    elseif (nRand <= 775) then
        if (GetJusticEvilCredit() > 0) then
            --ÏÉ
            for i = 1, 10 do
                AddNormalItemBind(3, 428, 0, 0, 0, 0, 1)
            end
            str = "10 Tôc MÖnh Hoa."
        else
            --Ä§
            for i = 1, 10 do
                AddNormalItemBind(3, 427, 0, 0, 0, 0, 1)
            end
            str = "10 Du Th­¬ng Th¶o,"
        end
    elseif (nRand <= 975) then
        for i = 1, 10 do
            AddNormalItemBind(6, 1, 587, 1, 0, 0, 1)
        end
        str = "10 Thiªn Linh Th¹ch."
    else
        local nItem = {
            { "Xİch Viªm Danh Ngäc (Ch­a mµi)", 256 },
            { "Thanh Minh Danh Ngäc (Ch­a mµi)", 263 },
            { "Tö Hµ Danh Ngäc (Ch­a mµi)", 270 },
        }
        local nId = random(1, 3)
        AddNormalItemBind(3, nItem[nId][2], 0, 0, 0, 0, 1)
        str = "1" .. nItem[nId][1] .. "."
    end

    Msg2Player("Ng­¬i ®· nhËn ®­îc " .. str)
    WriteLog("Bİ B¶o S¬nh ThÇn: nhËn" .. str)
    local nLeftTime = 12 - nTimes - 1
    if (nLeftTime == 0) then
        DelNpc(npcIdx)
        Msg2CurMapAnnounce(GetName() .. "§i th¸m thİnh bİ b¶o S¬n ThÇn, nhËn ®­îc" .. str .. "sau 12 lÇn ®iÒu tra ph¸p lùc cña bİ b¶o mÊt dÇn.")
    elseif (nLeftTime <= 3) then
        Msg2CurMapAnnounce(GetName() .. "§i th¸m thİnh bİ b¶o S¬n ThÇn, nhËn ®­îc" .. str .. "Bİ b¶o cßn" .. nLeftTime .. "®Õn kiÓm tra th¸m thİnh,")
    else
        Msg2CurMapAnnounce(GetName() .. "§i th¸m thİnh bİ b¶o S¬n ThÇn, nhËn ®­îc" .. str)
    end
end

function InteruptMotion(MotionID)
end

function no()
    CloseDialog()
end