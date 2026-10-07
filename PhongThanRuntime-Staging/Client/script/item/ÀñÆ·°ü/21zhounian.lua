Task_Kingsoft = 1624

function main()
    local w, x, y = GetWorldPos()
    if (w ~= 21) then
        AddNormalItem(6, 1, 763, 0, 0, 0)
        Talk(1, "no", "Tói quµ chØ sö dông ë TriÒu Ca!")
        return
    end

    Msg2CurMapAnnounce("<c=g>" .. GetName() .. "<c> Håi hép më Tói quµ kh¸nh lÔ Kim S¬n 21 n¨m.")
    local num_open = LoadIniInteger("Save_Kingsoft_Gift_Num", 1)
    SaveIniInteger("Save_Kingsoft_Gift_Num", 1, num_open + 1)

    local level = GetLevel()
    local possibility = math.random(1, 1000)
    if (level <= 49) then
        if (possibility <= 250) then
            AddNormalItemPile(6, 0, 764, 1, 0, 0)
            Msg2Player("B¹n nhËn ®­îc phong Ph¸o.")
        elseif (possibility <= 500) then
            if (AddIBBuff(1126) == 0) then
                AddNormalItemPile(6, 0, 764, 1, 0, 0)
                Msg2Player("B¹n nhËn ®­îc phong Ph¸o.")
            end
        elseif (possibility <= 750) then
            if (AddIBBuff(1127) == 0) then
                AddNormalItemPile(6, 0, 764, 1, 0, 0)
                Msg2Player("B¹n nhËn ®­îc phong Ph¸o.")
            end
        else
            if (AddIBBuff(1128) == 0) then
                AddNormalItemPile(6, 0, 764, 1, 0, 0)
                Msg2Player("B¹n nhËn ®­îc phong Ph¸o.")
            end
        end

    else
        local num_5 = LoadIniInteger("Save_Kingsoft_Gift_Num", 2)
        local num_10 = LoadIniInteger("Save_Kingsoft_Gift_Num", 3)
        local num_50 = LoadIniInteger("Save_Kingsoft_Gift_Num", 4)

        if ((num_open >= 99) and (num_50 == 0) and (level > 61)) then
            AddItemPileNum(3, 138, 0, 1, 50)
            SaveIniInteger("Save_Kingsoft_Gift_Num", 4, 1)
            Msg2Player("B¹n nhËn ®­îc 50 ThiÖp Nh­ ý.")
            AddGlobalNews("Chóc mõng <c=g>" .. GetName() .. "<c> më Kim S¬n LÔ Bao nhËn ®­îc <c=g>50<c> ThiÖp Nh­ ý")
        else
            if (possibility <= 200) then
                AddNormalItemPile(6, 0, 764, 1, 0, 0)
                Msg2Player("B¹n nhËn ®­îc phong Ph¸o.")
            elseif (possibility <= 400) then
                if (AddIBBuff(1126) == 0) then
                    AddNormalItemPile(6, 0, 764, 1, 0, 0)
                    Msg2Player("B¹n nhËn ®­îc phong Ph¸o.")
                end
            elseif (possibility <= 600) then
                if (AddIBBuff(1127) == 0) then
                    AddNormalItemPile(6, 0, 764, 1, 0, 0)
                    Msg2Player("B¹n nhËn ®­îc phong Ph¸o.")
                end
            elseif (possibility <= 750) then
                if (AddIBBuff(1128) == 0) then
                    AddNormalItemPile(6, 0, 764, 1, 0, 0)
                    Msg2Player("B¹n nhËn ®­îc phong Ph¸o.")
                end
            elseif (possibility <= 814) then
                AddNormalItem(8, 383, 3, 1, 0, 0)
                Msg2Player("B¹n nhËn ®­îc T¸ Thanh Lé (Nh­ ý).")
                WriteLog("NhËn ®­îc T¸ Thanh Lé (Nh­ ý).")
            elseif (possibility <= 878) then
                AddNormalItem(8, 382, 4, 1, 0, 0)
                Msg2Player("B¹n nhËn ®­îc Ch©n KhÝ (Nh­ ý).")
                WriteLog("NhËn ®­îc Ch©n KhÝ (Nh­ ý).")
            elseif (possibility <= 923) then
                if (num_5 <= 4) then
                    AddItemPileNum(3, 138, 0, 1, 5)
                    SaveIniInteger("Save_Kingsoft_Gift_Num", 2, num_5 + 1)
                    Msg2Player("B¹n nhËn ®­îc 5 ThiÖp Nh­ ý.")
                    AddGlobalNews("Chóc mõng <c=g>" .. GetName() .. "<c> më Kim S¬n LÔ Bao nhËn ®­îc <c=g>5<c> ThiÖp Nh­ ý")
                else
                    AddNormalItemPile(6, 0, 764, 1, 0, 0)
                    Msg2Player("B¹n nhËn ®­îc phong Ph¸o.")
                end
            elseif (possibility <= 968) then
                if (num_10 <= 3) then
                    AddItemPileNum(3, 138, 0, 1, 10)
                    SaveIniInteger("Save_Kingsoft_Gift_Num", 3, num_10 + 1)
                    Msg2Player("B¹n nhËn ®­îc 10 ThiÖp Nh­ ý.")
                    AddGlobalNews("Chóc mõng <c=g>" .. GetName() .. "<c> më Kim S¬n LÔ Bao nhËn ®­îc <c=g>10<c> ThiÖp Nh­ ý")
                else
                    AddNormalItemPile(6, 0, 764, 1, 0, 0)
                    Msg2Player("B¹n nhËn ®­îc phong Ph¸o.")
                end
            elseif (possibility <= 989) then
                AddNormalItem(0, 4, 37, 1, 0, 0)
                Msg2Player("NhËn ®­îc 1 Kim S¬n Ph¸p B¶o.")
                WriteLog("NhËn ®­îc Kim S¬n Ph¸p B¶o")
            elseif (possibility <= 999) then
                AddNormalItem(0, 4, 38, 1, 0, 0)
                Msg2Player("NhËn ®­îc 1 Kim S¬n Ph¸p B¶o (B¶n giíi h¹n).")
                WriteLog("NhËn ®­îc Kim S¬n Ph¸p B¶o (B¶n giíi h¹n)")
            else
                if (num_50 == 0) then
                    AddItemPileNum(3, 138, 0, 1, 50)
                    SaveIniInteger("Save_Kingsoft_Gift_Num", 4, 1)
                    Msg2Player("B¹n nhËn ®­îc 50 ThiÖp Nh­ ý.")
                    AddGlobalNews("Chóc mõng <c=g>" .. GetName() .. "<c> më Kim S¬n LÔ Bao nhËn ®­îc <c=g>50<c> ThiÖp Nh­ ý")
                else
                    AddNormalItem(0, 4, 38, 1, 0, 0)
                    Msg2Player("NhËn ®­îc 1 Kim S¬n Ph¸p B¶o (B¶n giíi h¹n).")
                    WriteLog("NhËn ®­îc Kim S¬n Ph¸p B¶o (B¶n giíi h¹n)")
                end
            end
        end
    end
end

function no()
    CloseDialog()
end
