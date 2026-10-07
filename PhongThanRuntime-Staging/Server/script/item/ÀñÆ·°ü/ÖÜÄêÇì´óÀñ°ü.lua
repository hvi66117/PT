Task_TianShen = 1494
Task_Rb_Day = 1495

Global_Rb_Day = 237
Global_Gift_Num = 238

Team_Task_Type = 3
Team_Task_State = 4

function main()
    local y1, m1, d1 = GetYMD()
    local H, M, S = GetHMS()

    if (d1 < 17) or (d1 >= 23 and H >= 23) then
        Talk(1, "no", "Ho¹t ®éng kÕt thóc, quµ tÆng ®· hÕt hiÖu lùc")
        return
    end

    DelNormalItem(6, 1, 532, 0)

    local pW, pX, pY = GetWorldPos()
    if (pW == 21) then
        Msg2CurMapAnnounce(GetName() .. "Håi hép më Tói C¶m Xóc.")
    end

    local bagNum = GetByte(GetGlobalValue(Global_Gift_Num), 3)

    if (bagNum <= 240) then
        bagNum = bagNum + 1
        SetGlobalValue(Global_Gift_Num, SetByte(GetGlobalValue(Global_Gift_Num), 3, bagNum))
    end

    local trump = GetByte(GetGlobalValue(Global_Gift_Num), 2)
    local log_str = ""
    if (d1 == 17) and (bagNum == 220) and (trump < 4) and (pW == 21) then
        AddNormalItem(0, 4, 38, 1, 0, 0)
        trump = trump + 1
        SetGlobalValue(Global_Gift_Num, SetByte(GetGlobalValue(Global_Gift_Num), 2, trump))
        Talk(1, "no", "NhËn ®­îc 1 Kim S¬n Ph¸p B¶o (B¶n giíi h¹n)")
        Msg2Player("NhËn ®­îc 1 Kim S¬n Ph¸p B¶o (B¶n giíi h¹n)")
        AddGlobalCountNews(GetName() .. "Më Tói C¶m Xóc nhËn ®­îc 1 Kim S¬n Ph¸p B¶o (B¶n giíi h¹n)", 1)
        log_str = "Tói quµ kû niÖm lín:Kim S¬n Ph¸p B¶o (B¶n giíi h¹n)"
        return
    end

    local note = GetByte(GetGlobalValue(Global_Gift_Num), 1)
    if (d1 == 17) and (bagNum == 240) and (note < 1) and (pW == 21) then
        for i = 1, 99 do
            AddNormalItemPile(6, 1, 533, 0, 0, 0)
        end
        note = note + 1
        SetGlobalValue(Global_Gift_Num, SetByte(GetGlobalValue(Global_Gift_Num), 1, note))
        Talk(1, "no", "NhËn ®­îc 99 Mé Danh ThiÕp")
        Msg2Player("NhËn ®­îc 99 Mé Danh ThiÕp")
        AddGlobalCountNews(GetName() .. "Më Tói C¶m Xóc nhËn ®­îc 99 Mé Danh ThiÕp, may m¾n thËt ®Êy!", 1)
        log_str = "Tói quµ kû niÖm lín:99 Mé Danh ThiÕp"
        return
    end

    local a = math.random(1, 10000)
    if (a <= 150) then
        AddNormalItemPile(6, 1, 533, 0, 0, 0)
        Talk(1, "no", "NhËn ®­îc 1 Mé Danh ThiÕp")
        Msg2Player("NhËn ®­îc 1 Mé Danh ThiÕp")
        log_str = "Tói quµ kû niÖm lín:1 Mé Danh ThiÕp"
    elseif (a >= 151 and a <= 200 and note < 1) or (a >= 151 and a <= 230 and note >= 1) then
        for i = 1, 9 do
            AddNormalItemPile(6, 1, 533, 0, 0, 0)
        end
        Talk(1, "no", "NhËn ®­îc 9 Mé Danh ThiÕp")
        Msg2Player("NhËn ®­îc 9 Mé Danh ThiÕp")
        log_str = "Tói quµ kû niÖm lín:9 Mé Danh ThiÕp"
    elseif (a >= 201 and a <= 230 and note < 1) then
        local w, x, y = GetWorldPos()
        if (w == 21) then
            for i = 1, 99 do
                AddNormalItemPile(6, 1, 533, 0, 0, 0)
            end
            note = note + 1
            SetGlobalValue(Global_Gift_Num, SetByte(GetGlobalValue(Global_Gift_Num), 1, note))
            Talk(1, "no", "NhËn ®­îc 99 Mé Danh ThiÕp")
            Msg2Player("NhËn ®­îc 99 Mé Danh ThiÕp")
            log_str = "Tói quµ kû niÖm lín:99 Mé Danh ThiÕp"
            AddGlobalCountNews(GetName() .. "Më Tói C¶m Xóc nhËn ®­îc 99 Mé Danh ThiÕp, may m¾n thËt ®Êy!", 1)
        else
            for i = 1, 9 do
                AddNormalItemPile(6, 1, 533, 0, 0, 0)
            end
            Talk(1, "no", "NhËn ®­îc 9 Mé Danh ThiÕp")
            Msg2Player("NhËn ®­îc 9 Mé Danh ThiÕp")
            log_str = "Tói quµ kû niÖm lín:9 Mé Danh ThiÕp"
        end
    elseif (a >= 231 and a <= 430 and trump < 4) or (a >= 231 and a <= 460 and trump >= 4) then
        AddNormalItem(0, 4, 37, 1, 0, 0)
        Talk(1, "no", "NhËn ®­îc 1 Kim S¬n Ph¸p B¶o")
        Msg2Player("NhËn ®­îc 1 Kim S¬n Ph¸p B¶o")
        log_str = "Tói quµ kû niÖm lín:Kim S¬n Ph¸p B¶o"
    elseif (a >= 431) and (a <= 460) and (trump < 4) then
        local w, x, y = GetWorldPos()
        if (w == 21) then
            AddNormalItem(0, 4, 38, 1, 0, 0)
            trump = trump + 1
            SetGlobalValue(Global_Gift_Num, SetByte(GetGlobalValue(Global_Gift_Num), 2, trump))
            Talk(1, "no", "NhËn ®­îc 1 Kim S¬n Ph¸p B¶o (B¶n giíi h¹n)")
            Msg2Player("NhËn ®­îc 1 Kim S¬n Ph¸p B¶o (B¶n giíi h¹n)")
            AddGlobalCountNews(GetName() .. "Më Tói C¶m Xóc nhËn ®­îc 1 Kim S¬n Ph¸p B¶o (B¶n giíi h¹n), qu¶ lµ may m¾n!", 1)
            log_str = "Tói quµ kû niÖm lín:Kim S¬n Ph¸p B¶o (B¶n giíi h¹n)"
        else
            AddNormalItem(0, 4, 37, 1, 0, 0)
            Talk(1, "no", "NhËn ®­îc 1 Kim S¬n Ph¸p B¶o")
            Msg2Player("NhËn ®­îc 1 Kim S¬n Ph¸p B¶o")
            log_str = "Tói quµ kû niÖm lín:Kim S¬n Ph¸p B¶o"
        end
    elseif (a >= 461 and a <= 1460) then
        AddNormalItem(8, 225, 2, 0, 0, 0)
        Talk(1, "no", "NhËn ®­îc 1 Kh­¬ng Tö Nha biÕn th©n phï")
        Msg2Player("NhËn ®­îc 1 Kh­¬ng Tö Nha biÕn th©n phï")
        log_str = "Tói quµ kû niÖm lín:Kh­¬ng Tö Nha biÕn th©n phï"
    elseif (a >= 1461 and a <= 4460) then
        AddNormalItem(8, 224, 2, 0, 0, 0)
        Talk(1, "no", "NhËn ®­îc 1 Tam Th¸i Tö biÕn th©n phï")
        Msg2Player("NhËn ®­îc 1 Tam Th¸i Tö biÕn th©n phï")
        log_str = "Tói quµ kû niÖm lín:Tam Th¸i Tö biÕn th©n phï"
    elseif (a >= 4461 and a <= 5460) then
        AddNormalItem(8, 52, 2, 1, 0, 0)
        Talk(1, "no", "NhËn ®­îc 1 Long Nh©n biÕn th©n phï")
        Msg2Player("NhËn ®­îc 1 Long Nh©n biÕn th©n phï")
        log_str = "Tói quµ kû niÖm lín:Long Nh©n biÕn th©n phï"
    elseif (a >= 5461 and a <= 6460) then
        AddNormalItem(6, 0, 20, 1, 0, 0)
        AddNormalItem(6, 0, 20, 1, 0, 0)
        Talk(1, "no", "NhËn ®­îc 2 Ph¸o hoa")
        Msg2Player("NhËn ®­îc 2 Ph¸o hoa")
        log_str = "Tói quµ kû niÖm lín:2 Ph¸o hoa"
    elseif (a >= 6461 and a <= 7460) then
        AddNormalItem(6, 0, 345, 1, 0, 1)
        AddNormalItem(6, 0, 345, 1, 0, 1)
        Talk(1, "no", "NhËn ®­îc 2 Hoa Hång")
        Msg2Player("NhËn ®­îc 2 Hoa Hång")
        log_str = "Tói quµ kû niÖm lín:2 Hoa Hång"
    elseif (a >= 7461 and a <= 10000) then
        if (GetSex() == 0) then
            AddIBBuff(528, 30 * 60)
            Talk(1, "no", "NhËn ®­îc hiÖu øng vßng s¸ng T×nh Khiªn")
            Msg2Player("NhËn ®­îc 1 hiÖu øng vßng s¸ng T×nh Khiªn")
            log_str = "Tói quµ kû niÖm lín:HiÖu øng vßng s¸ng T×nh Khiªn"
        else
            AddIBBuff(527, 30 * 60)
            Talk(1, "no", "NhËn ®­îc hiÖu øng vßng s¸ng Méng NhiÔu")
            Msg2Player("NhËn ®­îc 1 hiÖu øng vßng s¸ng Méng NhiÔu")
            log_str = "Tói quµ kû niÖm lín:HiÖu øng vßng s¸ng Méng NhiÔu"
        end
    end

    WriteLog(log_str)
end

function no()
    CloseDialog()
end
