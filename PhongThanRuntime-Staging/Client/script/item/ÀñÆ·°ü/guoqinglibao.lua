Task_guoqing = 1559

Global_guoqing_num = 258
Global_guoqing_wancheng = 259
Team_Task_Type = 1
Team_id1 = 3

function main()

    local PlayerLevel = GetLevel()
    local w, x, y = GetWorldPos()
    local num_gift_open = LoadIniInteger("Save_Open_num_guoqing", 1)

    if (w ~= 21) then
        Talk(1, "no", "Tói quµ nµy chØ ®­îc më ë TriÒu Ca.")
        return
    end
    Msg2CurMapAnnounce("<RoleName=\"" .. GetName() .. "\"> håi hép më Tói quµ Quèc Kh¸nh!")
    DelNormalItem(6, 1, 586, 0)
    local posability = math.random(1, 1000)
    if (PlayerLevel <= 49) then
        if (posability <= 160) then
            AddNormalItem(6, 0, 580, 1, 0, 0)
            Msg2Player("B¹n nhËn ®­îc Ph¸o hoa.")
        elseif (posability <= 320) then
            AddNormalItem(6, 0, 581, 1, 0, 0)
            Msg2Player("B¹n nhËn ®­îc Ph¸o hoa.")
        elseif (posability <= 480) then
            AddNormalItem(6, 0, 582, 1, 0, 0)
            Msg2Player("B¹n nhËn ®­îc Ph¸o hoa.")
        elseif (posability <= 660) then
            AddIBBuff(884)
            Msg2Player("B¹n nhËn ®­îc 1 tr¹ng th¸i ®Æc thï.")
        elseif (posability <= 830) then
            AddIBBuff(882)
            Msg2Player("B¹n nhËn ®­îc 1 tr¹ng th¸i ®Æc thï.")
        else
            AddIBBuff(883)
            Msg2Player("B¹n nhËn ®­îc 1 tr¹ng th¸i ®Æc thï.")
        end
    else
        local num_gift_ruyi = LoadIniInteger("Save_Open_num_guoqing", 2)
        local Y, M, D = GetYMD()
        if (((Y == 2009) and (M == 9) and (D == 29)) or ((Y == 2009) and (M == 10) and (D == 1))) then
            if ((num_gift_open >= 100) and (num_gift_ruyi == 0) and (GetLevel() >= 60)) then
                AddItemPileNum(3, 138, 0, 1, 100)
                Msg2Player("B¹n nhËn ®­îc <c=g>100 ThiÖp Nh­ ý<c>")
                SaveIniInteger("Save_Open_num_guoqing", 1, num_gift_open + 1)
                SaveIniInteger("Save_Open_num_guoqing", 2, 1)
                AddGlobalNews("<color=green>" .. GetName() .. "<color> më Tói quµ Quèc Kh¸nh nhËn ®­îc <c=g>100 ThiÖp Nh­ ý<c>.")
                WriteLog("NhËn ®­îc 100 ThiÖp Nh­ ý")
                return
            end
        end
        if (posability <= 150) then
            AddNormalItem(6, 0, 580, 1, 0, 0)
            Msg2Player("B¹n nhËn ®­îc Ph¸o hoa.")
        elseif (posability <= 300) then
            AddNormalItem(6, 0, 581, 1, 0, 0)
            Msg2Player("B¹n nhËn ®­îc Ph¸o hoa.")
        elseif (posability <= 450) then
            AddNormalItem(6, 0, 582, 1, 0, 0)
            Msg2Player("B¹n nhËn ®­îc Ph¸o hoa.")
        elseif (posability <= 540) then
            AddIBBuff(884)
            Msg2Player("B¹n nhËn ®­îc 1 tr¹ng th¸i ®Æc thï.")
        elseif (posability <= 650) then
            AddIBBuff(882)
            Msg2Player("B¹n nhËn ®­îc 1 tr¹ng th¸i ®Æc thï.")
        elseif (posability <= 750) then
            AddIBBuff(883)
            Msg2Player("B¹n nhËn ®­îc 1 tr¹ng th¸i ®Æc thï.")
        elseif (posability <= 800) then
            AddNormalItem(8, 383, 3, 1, 0, 0)
            Msg2Player("B¹n nhËn ®­îc T¸ Thanh Lé (Nh­ ý).")
            WriteLog("NhËn ®­îc T¸ Thanh Lé (Nh­ ý)")
        elseif (posability <= 849) then
            AddNormalItem(8, 382, 4, 1, 0, 0)
            Msg2Player("B¹n nhËn ®­îc Ch©n KhÝ (Nh­ ý).")
            WriteLog("NhËn ®­îc Ch©n KhÝ (Nh­ ý)")
        elseif (posability <= 989) then
            local sex = GetSex()
            if (sex == 0) then
                RemoveIBBuff(528)
                AddIBBuff(528, 30 * 60)
                Msg2Player("B¹n nhËn ®­îc hiÖu øng vßng s¸ng T×nh Khiªn")
                WriteLog("NhËn ®­îc hiÖu øng vßng s¸ng T×nh Khiªn")
            else
                RemoveIBBuff(527)
                AddIBBuff(527, 30 * 60)
                Msg2Player("B¹n nhËn ®­îc hiÖu øng vßng s¸ng Méng NhiÔu")
                WriteLog("NhËn ®­îc hiÖu øng vßng s¸ng Méng NhiÔu")
            end
        elseif (posability <= 999) then
            AddNormalItem(0, 4, 37, 1, 0, 0)
            Msg2Player("B¹n nhËn ®­îc 1 Ph¸p b¶o LOGO Kim S¬n.")
            WriteLog("NhËn ®­îc 1 Ph¸p b¶o LOGO Kim S¬n")
        else
            if ((num_gift_ruyi == 0) and (GetLevel() >= 60)) then
                AddItemPileNum(3, 138, 0, 1, 100)
                Msg2Player("B¹n nhËn ®­îc <c=g>100 ThiÖp Nh­ ý<c>")
                SaveIniInteger("Save_Open_num_guoqing", 2, 1)
                AddGlobalNews("<color=green>" .. GetName() .. "<color> më Tói quµ Quèc Kh¸nh nhËn ®­îc <c=g>100 ThiÖp Nh­ ý<c>.")
                WriteLog("NhËn ®­îc 100 ThiÖp Nh­ ý")
            else
                AddNormalItem(8, 382, 4, 1, 0, 0)
                Msg2Player("B¹n nhËn ®­îc Ch©n KhÝ (Nh­ ý).")
                WriteLog("NhËn ®­îc Ch©n KhÝ (Nh­ ý)")
            end
        end
    end

    SaveIniInteger("Save_Open_num_guoqing", 1, num_gift_open + 1)
end

function no()
    CloseDialog()
end
