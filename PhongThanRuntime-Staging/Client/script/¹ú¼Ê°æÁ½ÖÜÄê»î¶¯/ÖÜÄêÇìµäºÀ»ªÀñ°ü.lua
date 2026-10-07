Task_prepare = 1537

Task_anotherID = 1538
Task_item = 1539
Task_stage = 1540

function main()


    Msg2CurMapAnnounce("<RoleName=\"" .. GetName() .. "\">Håi hép më Hµo Hoa LÔ Bao!")

    DelNormalItem(6, 1, 573, 1)

    local PlayerLevel = GetLevel()
    local y1, m1, d1 = GetYMD()
    local num1 = LoadIniInteger("Save_Gift_Open_num", 1)
    local num2 = LoadIniInteger("Save_Gift_Open_num", 2)
    local num3 = LoadIniInteger("Save_Gift_Open_num", 3)
    local num4 = LoadIniInteger("Save_Gift_Open_num", 4)
    local gift1 = GetTaskBit(Task_stage, 31)
    local gift2 = GetTaskBit(Task_stage, 32)
    local w, x, y = GetWorldPos()
    if (w == 21) then
        if ((y1 == 2009) and (m1 == 9) and (d1 == 1)) then
            if ((num1 >= 99) and (num4 == 0) and (PlayerLevel >= 120)) then
                if (gift2 ~= 1) then
                    Earn(50000000)
                    Msg2CurMapAnnounce("<RoleName=\"" .. GetName() .. "\"> Më Hµo Hoa LÔ Bao nhËn ®­îc <color=green>5000 v¹n<color> b¹c.")
                    AddGlobalNews("<color=green>" .. GetName() .. "<color>Më Hµo Hoa LÔ Bao nhËn ®­îc <color=green>5000 v¹n<color> b¹c.")
                    SaveIniInteger("Save_Gift_Open_num", 4, 1)
                    SaveIniInteger("Save_Gift_Open_num", 1, num1 + 1)
                    Msg2Player("B¹n nhËn ®­îc 5000 v¹n b¹c.")
                    WriteLog("NhËn ®­îc 5000 v¹n b¹c.")
                    AddEvent("%s më Hµo Hoa LÔ Bao nhËn ®­îc 5000 v¹n b¹c!", 1)
                    SetTaskBit(Task_stage, 32, 1)
                elseif (gift1 ~= 1) then
                    Earn(10000000)
                    Msg2CurMapAnnounce("<RoleName=\"" .. GetName() .. "\">Më Hµo Hoa LÔ Bao nhËn ®­îc <color=green>1000 v¹n<color> b¹c.")
                    AddGlobalNews("<color=green>" .. GetName() .. "<color>Më Hµo Hoa LÔ Bao nhËn ®­îc <color=green>1000 v¹n<color> b¹c.")
                    SaveIniInteger("Save_Gift_Open_num", 2, 1)
                    SaveIniInteger("Save_Gift_Open_num", 1, num1 + 1)
                    Msg2Player("B¹n nhËn ®­îc phÇn th­ëng 1000 v¹n b¹c.")
                    WriteLog("NhËn ®­îc 1000 v¹n b¹c.")
                    AddEvent("%s më Hµo Hoa LÔ Bao nhËn ®­îc 1000 v¹n b¹c!", 1)
                    SetTaskBit(Task_stage, 31, 1)
                    return
                elseif (num3 < 11) then
                    Msg2CurMapAnnounce("<RoleName=\"" .. GetName() .. "\">Më Hµo Hoa LÔ Bao nhËn ®­îc <color=green>100 v¹n<color> b¹c.")
                    Earn(1000000)
                    SaveIniInteger("Save_Gift_Open_num", 3, num3 + 1)
                    Msg2Player("B¹n nhËn ®­îc 100 v¹n b¹c.")
                    WriteLog("NhËn ®­îc 100 v¹n b¹c.")
                    AddEvent("%s më Hµo Hoa LÔ Bao nhËn ®­îc 100 v¹n b¹c!", 1)
                    return
                else
                    AddNormalItem(8, 381, 3, 1, 0, 0)
                    Msg2Player("B¹n nhËn ®­îc Thanh Lé (Nh­ ý).")
                    WriteLog("NhËn ®­îc Thanh Lé (Nh­ ý).")
                    AddEvent("%s më Hµo Hoa LÔ Bao nhËn ®­îc Thanh Lé (Nh­ ý)!", 1)
                    return
                end
            end
        end

        if ((y1 == 2009) and (m1 == 8) and (d1 == 28)) then
            if ((num1 >= 99) and (num2 == 0) and (PlayerLevel >= 100)) then
                if (gift1 ~= 1) then
                    Earn(10000000)
                    Msg2CurMapAnnounce("<RoleName=\"" .. GetName() .. "\">Më Hµo Hoa LÔ Bao nhËn ®­îc <color=green>1000 v¹n<color> b¹c.")
                    AddGlobalNews("<color=green>" .. GetName() .. "<color>Më Hµo Hoa LÔ Bao nhËn ®­îc <color=green>1000 v¹n<color> b¹c.")
                    SaveIniInteger("Save_Gift_Open_num", 2, 1)
                    SaveIniInteger("Save_Gift_Open_num", 1, num1 + 1)
                    Msg2Player("B¹n nhËn ®­îc phÇn th­ëng 1000 v¹n b¹c.")
                    WriteLog("NhËn ®­îc 1000 v¹n b¹c.")
                    AddEvent("%s më Hµo Hoa LÔ Bao nhËn ®­îc 1000 v¹n b¹c!", 1)
                    SetTaskBit(Task_stage, 31, 1)
                    return
                elseif (num3 < 11) then
                    Msg2CurMapAnnounce("<RoleName=\"" .. GetName() .. "\">Më Hµo Hoa LÔ Bao nhËn ®­îc <color=green>100 v¹n<color> b¹c.")
                    Earn(1000000)
                    SaveIniInteger("Save_Gift_Open_num", 3, num3 + 1)
                    Msg2Player("B¹n nhËn ®­îc 100 v¹n b¹c.")
                    WriteLog("NhËn ®­îc 100 v¹n b¹c.")
                    AddEvent("%s më Hµo Hoa LÔ Bao nhËn ®­îc 100 v¹n b¹c!", 1)
                    return
                else
                    AddNormalItem(8, 381, 3, 1, 0, 0)
                    Msg2Player("B¹n nhËn ®­îc Thanh Lé (Nh­ ý).")
                    WriteLog("NhËn ®­îc Thanh Lé (Nh­ ý).")
                    AddEvent("%s më Hµo Hoa LÔ Bao nhËn ®­îc Thanh Lé (Nh­ ý)!", 1)
                    return
                end
            end
        end
    end

    local r = math.random(1, 1000)

    if (r <= 10) then
        Msg2Player("B¹n nhËn ®­îc Dao Tiªn t¸n (Nh­ ý).")
        AddNormalItem(8, 385, 0, 1, 0, 0)
        WriteLog("NhËn ®­îc Dao Tiªn t¸n (Nh­ ý).")
        AddEvent("%s më Hµo Hoa LÔ Bao nhËn ®­îc Dao Tiªn t¸n (Nh­ ý)!", 1)
    elseif (r <= 30) then
        AddNormalItem(8, 384, 4, 1, 0, 0)
        Msg2Player("B¹n nhËn ®­îc Thñy Ch©n KhÝ (Nh­ ý).")
        WriteLog("NhËn ®­îc Thñy Ch©n KhÝ (Nh­ ý).")
        AddEvent("%s më Hµo Hoa LÔ Bao nhËn ®­îc Thñy Ch©n KhÝ (Nh­ ý)!", 1)
    elseif (r <= 50) then
        AddNormalItem(8, 383, 3, 1, 0, 0)
        Msg2Player("B¹n nhËn ®­îc T¸ Thanh Lé (Nh­ ý).")
        WriteLog("NhËn ®­îc T¸ Thanh Lé (Nh­ ý).")
        AddEvent("%s më Hµo Hoa LÔ Bao nhËn ®­îc T¸ Thanh Lé (Nh­ ý)!", 1)
    elseif (r <= 70) then
        AddNormalItem(8, 389, 2, 1, 0, 0)
        Msg2Player("B¹n nhËn ®­îc Nh­ ý Hµnh Qu©n LÖnh.")
        WriteLog("NhËn ®­îc Nh­ ý Hµnh Qu©n LÖnh.")
        AddEvent("%s më Hµo Hoa LÔ Bao nhËn ®­îc Nh­ ý Hµnh Qu©n LÖnh!", 1)
    elseif (r <= 100) then
        AddNormalItem(8, 382, 4, 1, 0, 0)
        Msg2Player("B¹n nhËn ®­îc Ch©n KhÝ (Nh­ ý).")
        WriteLog("NhËn ®­îc Ch©n KhÝ (Nh­ ý).")
        AddEvent("%s më Hµo Hoa LÔ Bao nhËn ®­îc Ch©n KhÝ (Nh­ ý)!", 1)
    elseif (r <= 140) then
        AddNormalItem(8, 782, 0, 1, 0, 0)
        Msg2Player("B¹n nhËn ®­îc Nh­ ý L©m Tiªn Lé.")
        WriteLog("NhËn ®­îc Nh­ ý L©m Tiªn Lé.")
        AddEvent("%s më Hµo Hoa LÔ Bao nhËn ®­îc Nh­ ý L©m Tiªn Lé!", 1)
    elseif (r <= 180) then
        AddNormalItem(8, 634, 2, 1, 0, 0)
        Msg2Player("B¹n nhËn ®­îc Nh­ ý ChØ Nh©n.")
        WriteLog("NhËn ®­îc Nh­ ý ChØ Nh©n.")
        AddEvent("%s më Hµo Hoa LÔ Bao nhËn ®­îc Nh­ ý ChØ Nh©n!", 1)
    elseif (r <= 280) then
        AddNormalItem(8, 781, 2, 1, 0, 0)
        Msg2Player("B¹n nhËn ®­îc Nh­ ý Håi Quèc Phï.")
        WriteLog("NhËn ®­îc Nh­ ý Håi Quèc Phï.")
        AddEvent("%s më Hµo Hoa LÔ Bao nhËn ®­îc Nh­ ý Håi Quèc Phï!", 1)
    elseif (r <= 390) then
        AddNormalItem(8, 733, 2, 1, 0, 0)
        Msg2Player("B¹n nhËn ®­îc Siªu cÊp Håi Thµnh Phï-nhá.")
        WriteLog("NhËn ®­îc Siªu cÊp Håi Thµnh Phï-nhá.")
        AddEvent("%s më Hµo Hoa LÔ Bao nhËn ®­îc Siªu cÊp Håi Thµnh Phï-nhá!", 1)
    elseif (r <= 570) then
        AddNormalItem(8, 779, 3, 1, 0, 0)
        Msg2Player("B¹n nhËn ®­îc Nh­ ý Thanh Lé (tiÓu).")
        WriteLog("NhËn ®­îc Nh­ ý Thanh Lé (tiÓu).")
        AddEvent("%s më Hµo Hoa LÔ Bao nhËn ®­îc Nh­ ý Thanh Lé (tiÓu)!", 1)
    elseif (r <= 750) then
        AddNormalItem(8, 780, 4, 1, 0, 0)
        Msg2Player("B¹n nhËn ®­îc Nh­ ý Ch©n KhÝ (tiÓu).")
        WriteLog("NhËn ®­îc Nh­ ý Ch©n KhÝ (tiÓu).")
        AddEvent("%s më Hµo Hoa LÔ Bao nhËn ®­îc Nh­ ý Ch©n KhÝ (tiÓu)!", 1)
    elseif (r <= 930) then
        AddNormalItem(8, 567, 2, 1, 0, 0)
        Msg2Player("B¹n nhËn ®­îc Nh­ ý Di Ngo¹i Phï.")
        WriteLog("NhËn ®­îc Nh­ ý Di Ngo¹i Phï.")
        AddEvent("%s më Hµo Hoa LÔ Bao nhËn ®­îc Nh­ ý Di Ngo¹i Phï!", 1)
    elseif ((PlayerLevel >= 120) and (num4 == 0) and (r > 997) and (w == 21)) then
        if (gift2 ~= 1) then
            Earn(50000000)
            Msg2CurMapAnnounce("<RoleName=\"" .. GetName() .. "\">Më Hµo Hoa LÔ Bao nhËn ®­îc <color=green>5000 v¹n<color> b¹c.")
            AddGlobalNews("<color=green>" .. GetName() .. "<color>Më Hµo Hoa LÔ Bao nhËn ®­îc <color=green>5000 v¹n<color> b¹c.")
            SaveIniInteger("Save_Gift_Open_num", 4, 1)
            SaveIniInteger("Save_Gift_Open_num", 1, num1 + 1)
            Msg2Player("B¹n nhËn ®­îc 5000 v¹n b¹c.")
            WriteLog("NhËn ®­îc 5000 v¹n b¹c.")
            AddEvent("%s më Hµo Hoa LÔ Bao nhËn ®­îc 5000 v¹n b¹c!", 1)
            SetTaskBit(Task_stage, 32, 1)
        elseif (gift1 ~= 1) then
            Earn(10000000)
            Msg2CurMapAnnounce("<RoleName=\"" .. GetName() .. "\">Më Hµo Hoa LÔ Bao nhËn ®­îc <color=green>1000 v¹n<color> b¹c.")
            AddGlobalNews("<color=green>" .. GetName() .. "<color>Më Hµo Hoa LÔ Bao nhËn ®­îc <color=green>1000 v¹n<color> b¹c.")
            SaveIniInteger("Save_Gift_Open_num", 2, 1)
            SaveIniInteger("Save_Gift_Open_num", 1, num1 + 1)
            Msg2Player("B¹n nhËn ®­îc phÇn th­ëng 1000 v¹n b¹c.")
            WriteLog("NhËn ®­îc 1000 v¹n b¹c.")
            AddEvent("%s më Hµo Hoa LÔ Bao nhËn ®­îc 1000 v¹n b¹c!", 1)
            SetTaskBit(Task_stage, 31, 1)
            return
        elseif (num3 < 11) then
            Msg2CurMapAnnounce("<RoleName=\"" .. GetName() .. "\">Më Hµo Hoa LÔ Bao nhËn ®­îc <color=green>100 v¹n<color> b¹c.")
            Earn(1000000)
            SaveIniInteger("Save_Gift_Open_num", 3, num3 + 1)
            Msg2Player("B¹n nhËn ®­îc 100 v¹n b¹c.")
            WriteLog("NhËn ®­îc 100 v¹n b¹c.")
            AddEvent("%s më Hµo Hoa LÔ Bao nhËn ®­îc 100 v¹n b¹c!", 1)
            return
        else
            AddNormalItem(8, 381, 3, 1, 0, 0)
            Msg2Player("B¹n nhËn ®­îc Thanh Lé (Nh­ ý).")
            WriteLog("NhËn ®­îc Thanh Lé (Nh­ ý).")
            AddEvent("%s më Hµo Hoa LÔ Bao nhËn ®­îc Thanh Lé (Nh­ ý)!", 1)
            return
        end
    elseif ((PlayerLevel >= 100) and (num2 < 3) and (r > 990) and (r <= 997) and (w == 21)) then
        if (gift1 ~= 1) then
            Earn(10000000)
            Msg2CurMapAnnounce("<RoleName=\"" .. GetName() .. "\">Më Hµo Hoa LÔ Bao nhËn ®­îc <color=green>1000 v¹n<color> b¹c.")
            AddGlobalNews("<color=green>" .. GetName() .. "<color>Më Hµo Hoa LÔ Bao nhËn ®­îc <color=green>1000 v¹n<color> b¹c.")
            SaveIniInteger("Save_Gift_Open_num", 2, 1)
            SaveIniInteger("Save_Gift_Open_num", 1, num1 + 1)
            Msg2Player("B¹n nhËn ®­îc phÇn th­ëng 1000 v¹n b¹c.")
            WriteLog("NhËn ®­îc 1000 v¹n b¹c.")
            AddEvent("%s më Hµo Hoa LÔ Bao nhËn ®­îc 1000 v¹n b¹c!", 1)
            SetTaskBit(Task_stage, 31, 1)
            return
        elseif (num3 < 11) then
            Msg2CurMapAnnounce("<RoleName=\"" .. GetName() .. "\">Më Hµo Hoa LÔ Bao nhËn ®­îc <color=green>100 v¹n<color> b¹c.")
            Earn(1000000)
            SaveIniInteger("Save_Gift_Open_num", 3, num3 + 1)
            Msg2Player("B¹n nhËn ®­îc 100 v¹n b¹c.")
            WriteLog("NhËn ®­îc 100 v¹n b¹c.")
            AddEvent("%s më Hµo Hoa LÔ Bao nhËn ®­îc 100 v¹n b¹c!", 1)
            return
        else
            AddNormalItem(8, 381, 3, 1, 0, 0)
            Msg2Player("B¹n nhËn ®­îc Thanh Lé (Nh­ ý).")
            WriteLog("NhËn ®­îc Thanh Lé (Nh­ ý).")
            AddEvent("%s më Hµo Hoa LÔ Bao nhËn ®­îc Thanh Lé (Nh­ ý)!", 1)
            return
        end
    elseif ((PlayerLevel >= 70) and (num3 < 11) and (r > 960) and (r <= 990) and (w == 21)) then
        Msg2CurMapAnnounce("<RoleName=\"" .. GetName() .. "\">Më Hµo Hoa LÔ Bao nhËn ®­îc <color=green>100 v¹n<color> b¹c.")
        Earn(1000000)
        SaveIniInteger("Save_Gift_Open_num", 3, num3 + 1)
        Msg2Player("B¹n nhËn ®­îc 100 v¹n b¹c.")
        WriteLog("NhËn ®­îc 100 v¹n b¹c.")
        AddEvent("%s më Hµo Hoa LÔ Bao nhËn ®­îc 100 v¹n b¹c!", 1)
    else
        AddNormalItem(8, 381, 3, 1, 0, 0)
        Msg2Player("B¹n nhËn ®­îc Thanh Lé (Nh­ ý).")
        WriteLog("NhËn ®­îc Thanh Lé (Nh­ ý).")
        AddEvent("%s më Hµo Hoa LÔ Bao nhËn ®­îc Thanh Lé (Nh­ ý)!", 1)
    end

    SaveIniInteger("Save_Gift_Open_num", 1, num1 + 1)
end

function no()
    CloseDialog()
end
