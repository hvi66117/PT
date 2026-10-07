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

    DelNormalItem(6, 1, 531, 0)

    local pW, pX, pY = GetWorldPos()
    if (pW == 21) then
        Msg2CurMapAnnounce(GetName() .. "CÈn thËn më Tói quµ H¹ NhËt.")
    end

    local bagNum = GetByte(GetGlobalValue(Global_Gift_Num), 3)

    if (bagNum <= 220) then
        bagNum = bagNum + 1
        SetGlobalValue(Global_Gift_Num, SetByte(GetGlobalValue(Global_Gift_Num), 3, bagNum))
    end

    local log_str = ""
    local trump = GetByte(GetGlobalValue(Global_Gift_Num), 2)
    if (d1 == 17) and (bagNum == 220) and (trump < 4) and (pW == 21) then
        AddNormalItem(0, 4, 38, 1, 0, 0)
        trump = trump + 1
        SetGlobalValue(Global_Gift_Num, SetByte(GetGlobalValue(Global_Gift_Num), 2, trump))
        Talk(1, "no", "NhËn ®­îc 1 Kim S¬n Ph¸p B¶o (B¶n giíi h¹n)")
        Msg2Player("NhËn ®­îc 1 Kim S¬n Ph¸p B¶o (B¶n giíi h¹n)")
        AddGlobalCountNews(GetName() .. " më Tói quµ H¹ NhËt nhËn ®­îc 1 Kim S¬n Ph¸p B¶o (B¶n giíi h¹n), may m¾n thËt ®Êy!", 1)
        log_str = "Tói quµ kû niÖm:Kim S¬n Ph¸p B¶o (B¶n giíi h¹n)"
        return
    end

    local a = math.random(1, 10000)
    if (a <= 150) then
        AddNormalItemPile(6, 1, 533, 0, 0, 0)
        Talk(1, "no", "NhËn ®­îc 1 Mé Danh ThiÕp")
        Msg2Player("NhËn ®­îc 1 Mé Danh ThiÕp")
        log_str = "Tói quµ kû niÖm:1 Mé Danh ThiÕp"
    elseif (a >= 151 and a <= 200) then
        for i = 1, 9 do
            AddNormalItemPile(6, 1, 533, 0, 0, 0)
        end
        Talk(1, "no", "NhËn ®­îc 9 Mé Danh ThiÕp")
        Msg2Player("NhËn ®­îc 9 Mé Danh ThiÕp")
        log_str = "Tói quµ kû niÖm:9 Mé Danh ThiÕp"
    elseif (a >= 201 and a <= 400 and trump < 4) or (a >= 201 and a <= 430 and trump >= 4) then
        AddNormalItem(0, 4, 37, 1, 0, 0)
        Talk(1, "no", "NhËn ®­îc 1 Kim S¬n Ph¸p B¶o")
        Msg2Player("NhËn ®­îc 1 Kim S¬n Ph¸p B¶o")
        log_str = "Tói quµ kû niÖm:Kim S¬n Ph¸p B¶o"
    elseif (a >= 401) and (a <= 430) and (trump < 4) then
        local w, x, y = GetWorldPos()
        if (w == 21) then
            AddNormalItem(0, 4, 38, 1, 0, 0)
            trump = trump + 1
            SetGlobalValue(Global_Gift_Num, SetByte(GetGlobalValue(Global_Gift_Num), 2, trump))
            Talk(1, "no", "NhËn ®­îc 1 Kim S¬n Ph¸p B¶o (B¶n giíi h¹n)")
            Msg2Player("NhËn ®­îc 1 Kim S¬n Ph¸p B¶o (B¶n giíi h¹n)")
            AddGlobalCountNews(GetName() .. " më Tói quµ H¹ NhËt nhËn ®­îc 1 Kim S¬n Ph¸p B¶o (B¶n giíi h¹n), may m¾n thËt ®Êy!", 1)
            log_str = "Tói quµ kû niÖm:Kim S¬n Ph¸p B¶o (B¶n giíi h¹n)"
        else
            AddNormalItem(0, 4, 37, 1, 0, 0)
            Talk(1, "no", "NhËn ®­îc 1 Kim S¬n Ph¸p B¶o")
            Msg2Player("NhËn ®­îc 1 Kim S¬n Ph¸p B¶o")
            log_str = "Tói quµ kû niÖm:Kim S¬n Ph¸p B¶o"
        end
    elseif (a >= 431 and a <= 1430) then
        AddNormalItem(8, 225, 2, 0, 0, 0)
        Talk(1, "no", "NhËn ®­îc 1 Kh­¬ng Tö Nha biÕn th©n phï")
        Msg2Player("NhËn ®­îc 1 Kh­¬ng Tö Nha biÕn th©n phï")
        log_str = "Tói quµ kû niÖm:Kh­¬ng Tö Nha biÕn th©n phï"
    elseif (a >= 1431 and a <= 4430) then
        AddNormalItem(8, 224, 2, 0, 0, 0)
        Talk(1, "no", "NhËn ®­îc 1 Tam Th¸i Tö biÕn th©n phï")
        Msg2Player("NhËn ®­îc 1 Tam Th¸i Tö biÕn th©n phï")
        log_str = "Tói quµ kû niÖm:Tam Th¸i Tö biÕn th©n phï"
    elseif (a >= 4431 and a <= 5930) then
        AddNormalItem(8, 52, 2, 1, 0, 0)
        Talk(1, "no", "NhËn ®­îc 1 Long Nh©n biÕn th©n phï")
        Msg2Player("NhËn ®­îc 1 Long Nh©n biÕn th©n phï")
        log_str = "Tói quµ kû niÖm:Long Nh©n biÕn th©n phï"
    elseif (a >= 5931 and a <= 7430) then
        AddNormalItem(6, 0, 345, 1, 0, 1)
        Talk(1, "no", "NhËn ®­îc 1 Hoa Hång")
        Msg2Player("NhËn ®­îc 1 Hoa Hång")
        log_str = "Tói quµ kû niÖm:1 Hoa Hång"
    elseif (a >= 7431 and a <= 10000) then
        if (GetSex() == 0) then
            AddIBBuff(528, 30 * 60)
            Talk(1, "no", "NhËn ®­îc hiÖu øng vßng s¸ng T×nh Khiªn")
            Msg2Player("NhËn ®­îc 1 hiÖu øng vßng s¸ng T×nh Khiªn")
            log_str = "Tói quµ kû niÖm:HiÖu øng vßng s¸ng T×nh Khiªn"
        else
            AddIBBuff(527, 30 * 60)
            Talk(1, "no", "NhËn ®­îc hiÖu øng vßng s¸ng Méng NhiÔu")
            Msg2Player("NhËn ®­îc 1 hiÖu øng vßng s¸ng Méng NhiÔu")
            log_str = "Tói quµ kû niÖm:HiÖu øng vßng s¸ng Méng NhiÔu"
        end
    end

    WriteLog(log_str)
end

function no()
    CloseDialog()
end
