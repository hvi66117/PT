TaskVariableID = 2219

gItem = { 6, 1, 1657, 1, 0, 0 }
giftList1 = {
    [1] = { name = "Vi Quang Qu¸i Phï", id = { 3, 374, 0, 0, 0, 0 }, probability = 40, },
    [2] = { name = "Tinh Th¸i Qu¸i Phï", id = { 3, 383, 0, 0, 0, 0 }, probability = 60, },
}

giftList2 = {
    [1] = { name = "Vi Quang Qu¸i Phï", id = { 3, 374, 0, 0, 0, 0 }, probability = 60, },
    [2] = { name = "Tinh Th¸i Qu¸i Phï", id = { 3, 383, 0, 0, 0, 0 }, probability = 35, },
    [3] = { name = "NguyÖt Hoa Qu¸i Phï", id = { 3, 392, 0, 0, 0, 0 }, probability = 5, },
}
function main()
    local button = {
        { "¿ñ»¶ºÃÀñ", "CarnivalGift"; show = 1 },
        { "·âÉñÀí²Æ¿¨", "WealthManagementCard"; show = 1 },
    }
    local info = "¿ñ»¶ºÃÀñËÍ, ³¬ÖµÓÅ»ÝÀ´!\nÄúÃ¿ÈÕCã thÓ nhËn [¿ñ»¶ºÃÀñ] (B¶o H÷u Thanh Lé*1, S¬n Thuû Ch©n KhÝ*1, ThÇn C©u Phï*1, ¾ù°ó¶¨).\n¡°·âÉñÀí²Æ¿¨¡±ÈÈÂôÖÐ, 499 Th«ng B¶o¹ºÂòÒ»·ÝÀí²Æ¿¨, ½«»ñµÃ×Ü¶î600 Linh B¶o hoµn tr¶, »¹½«NhËn ®­îc thªm ÕäÏ¡ØÔ·û.\nÀñºÐ¹ýÆÚºó½«²»ÄÜÁìÈ¡¿ñ»¶ºÃÀñ vµ ¹ºÂòÀí²Æ¿¨."
    SayTask(info, button)
end

function CarnivalGift()
    local dateCarnival = GetTaskByte(TaskVariableID, 1)
    local _, _, DD = GetYMD()
    if (dateCarnival ~= DD) then
        if (GetSpaceRoom(4) < 1) then
            Talk(1, "no", "NhËn Ê§°Ü, ÄúµÄ±³°üÃ»ÓÐ×ã¹»µÄÎ»ÖÃ·ÅÖÃ½±Àø.")
            return
        else
            SetTaskByte(TaskVariableID, 1, DD)
            AddNormalItemBind(8, 198, 3, 0, 0, 0, 1)
            AddNormalItemBind(8, 199, 4, 0, 0, 0, 1)
            AddNormalItemBind(8, 133, 0, 0, 0, 0, 1)
            WriteLog("[·âÉñÀí²Æ¿¨»î¶¯][¿ñ»¶ÀñºÐ][" .. GetName() .. "] NhËn ®­îc ÁËB¶o H÷u Thanh Lé,S¬n Thuû Ch©n KhÝ, ThÇn C©u Phï")
            Talk(1, "no", "Ngµi nhËn ®­îc B¶o H÷u Thanh Lé, S¬n Thuû Ch©n KhÝ, ThÇn C©u Phï!")
        end
    else
        Talk(1, "no", "NhËn Ê§°Ü, Äú½ñÌìÒÑ¾­ÁìÈ¡¹ý½±Àø.")
        return
    end
end

function WealthManagementCard()
    local Cards = GetTaskByte(TaskVariableID, 2)
    local button = {
        { "Mua Àí²Æ¿¨", "BuyWealthManagementCard"; show = 1 },
    }
    local info = "Äú¿ÉÔÚ´Ë¹ºÂò ¡°·âÉñÀí²Æ¿¨¡± (499 Th«ng B¶oÒ»·Ý).Ã¿¹ºÂòÒ»·ÝÀí²Æ¿¨, ¼´¿ÉÔÚ2020Äê12ÔÂ-2021Äê3ÔÂÃ¿ÔÂ·µ»¹150 Linh B¶o, ÀÛ¼Æ¹²·µ»¹600 Linh B¶o.\n¹ºÂòÀí²Æ¿¨µÄÍ¬Ê±, Äú»¹½«100%NhËn ®­îc thªm ¡°Vi Quang Qu¸i Phï/Tinh Th¸i Qu¸i Phï/ÔÂ»ªØÔ·û¡±ÖÐµÄËæ»ú1 c¸i (²»°ó¶¨, ½öÇ°Ê®´Î¹ºÂòÀí²Æ¿¨¿É»ñµÃØÔ·û).\nÄúÒÑ mua " .. Cards .. "·ÝÀí²Æ¿¨. "
    SayTask(info, button)
end

function BuyWealthManagementCard()
    local Cards = GetTaskByte(TaskVariableID, 2)

    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(292)
    if (GetCoin() < Cv) then
        local sShow = "ThËt xin lçi, ngµi ch­a ®ñ Í¨±¦²»×ã" .. Cfs .. "."
        Msg2Player(sShow)
        Talk(1, "no", sShow)
        return
    end

    local str = "ÄúÊÇ·ñÈ·ÈÏÈÏ¹ºÒ»·Ý¡°·âÉñÀí²Æ¿¨¡±, Á¢¼´tiªu phÝ " .. Cfs .. " Th«ng B¶o, nhËn ®­îc ÀÛ¼Æ¼ÛÖµ<c=y>600 Linh B¶o<c>µÄÀí²Æ¿¨£¿ÈÏ¹ººóÀí²Æ¿¨½«ÖÃÓÚÄúµÄ±³°üÄÚ."
    MsgBox(str, "BuyWealthManagementCardYes", "no")
end

function BuyWealthManagementCardYes()
    no()
    local Cname, Cv, Cfs = GetCostCoinInfoByIdx(292)
    if (GetCoin() < Cv) then
        Talk(1, "no", "ThËt xin lçi, ¹ºÂòÀí²Æ¿¨ cÇn " .. Cfs .. " Th«ng B¶o, hiÖn Th«ng B¶o ch­a ®ñ, kh«ng thÓ mua.")
        return
    end

    local _, _, DD = GetYMD()
    local Num = GetTaskByte(TaskVariableID, 2)

    if (Num == 255) then
        Msg2Player("¶Ô²»Æð!ÄãÒÑ´ïµ½¹ºÂòÀí²Æ¿¨µÄÉÏÏÞ!")
        return
    end

    if (CostCoinByIdx(292) ~= 0) then
        SetTaskByte(TaskVariableID, 2, Num + 1)
    else
        Msg2Player(" Th«ng B¶o¿Û³ýÊ§°Ü")
        return
    end

    local itemName = ""
    local playerName = GetName()
    Num = GetTaskByte(TaskVariableID, 2)
    if (Num == 1) then
        if (GetSpaceRoom(2) == 1) then
            itemName = GetNormalItemName(6, 1, 1658, 1)
            AddNormalItemBind(6, 1, 1658, 1, 0, 0, 1)
            Msg2Player("B¹n nhËn ®­îc 1" .. itemName .. ", ÇëÔÚ±³°üÖÐ²é¿´.")
            WriteLog("[·âÉñÀí²Æ¿¨»î¶¯][¿ñ»¶ÀñºÐ][" .. GetName() .. "] NhËn ®­îc ÁË 1 c¸i " .. itemName)
        else
            itemName = GetNormalItemName(6, 1, 1658, 1)
            local g_Text = "¸½¼þÖÐÊÇÄú»ñµÃµÄµÀ¾ß" .. itemName .. ", Çë×¢Òâ²éÊÕ."
            SendSysItemMailToTarget("Hép th­", playerName, "·âÉñÀí²Æ¿¨", g_Text, 6, 1, 1658, 1, 0, 0, 0, 1, 1)
            Msg2Player("ÄúÓÐÒ»·âÐÂµÄÓÊ¼þ, ²¢ nhËn ®­îc 1 c¸i " .. itemName .. ", Çë×¢Òâ²é¿´.")
            WriteLog("[·âÉñÀí²Æ¿¨»î¶¯][¿ñ»¶ÀñºÐ][" .. GetName() .. "]ÊÕµ½ÓÊ¼þ, ²¢ nhËn ®­îc 1 c¸i " .. itemName)
        end
    end

    local rankPos = 0
    local listProbability = 0

    if (Num <= 5 and Num >= 1) then
        rankPos = math.random(1, 100)

        for i = 1, table.getn(giftList1) do
            listProbability = listProbability + giftList1[i].probability

            if (listProbability >= rankPos) then
                if (GetSpaceRoom(2) == 1) then
                    itemName = GetNormalItemName(giftList1[i].id[1], giftList1[i].id[2], giftList1[i].id[3], giftList1[i].id[4])
                    AddNormalItemPile(giftList1[i].id[1], giftList1[i].id[2], giftList1[i].id[3], giftList1[i].id[4], giftList1[i].id[5], giftList1[i].id[6])
                    Msg2Player("B¹n nhËn ®­îc 1" .. itemName .. ", ÇëÔÚ±³°üÖÐ²é¿´.")
                    WriteLog("[·âÉñÀí²Æ¿¨»î¶¯][¿ñ»¶ÀñºÐ][" .. GetName() .. "] NhËn ®­îc ÁË1 c¸i " .. itemName)
                    return

                else
                    itemName = GetNormalItemName(giftList1[i].id[1], giftList1[i].id[2], giftList1[i].id[3], giftList1[i].id[4])
                    local g_Text = "¸½¼þÖÐÊÇÄú»ñµÃµÄµÀ¾ß" .. itemName .. ", Çë×¢Òâ²éÊÕ."
                    SendSysItemMailToTarget("Hép th­", playerName, itemName, g_Text, giftList1[i].id[1], giftList1[i].id[2], giftList1[i].id[3], giftList1[i].id[4], giftList1[i].id[5], giftList1[i].id[6])
                    Msg2Player("ÄúÓÐÒ»·âÐÂµÄÓÊ¼þ, ²¢ nhËn ®­îc 1 c¸i " .. itemName .. ", Çë×¢Òâ²é¿´.")
                    WriteLog("[·âÉñÀí²Æ¿¨»î¶¯][¿ñ»¶ÀñºÐ][" .. GetName() .. "]ÊÕµ½ÓÊ¼þ, ²¢ nhËn ®­îc 1 c¸i " .. itemName)
                    return
                end
            end
        end

    elseif (Num <= 10 and Num > 5) then
        rankPos = math.random(1, 100)
        for i = 1, table.getn(giftList2) do
            listProbability = listProbability + giftList2[i].probability
            if (listProbability >= rankPos) then

                if (GetSpaceRoom(2) == 1) then


                    if ((GetTaskBit(TaskVariableID, 31) == 1) and (i == table.getn(giftList2))) then
                        itemName = GetNormalItemName(giftList2[1].id[1], giftList2[1].id[2], giftList2[1].id[3], giftList2[1].id[4])
                        AddNormalItemPile(giftList2[1].id[1], giftList2[1].id[2], giftList2[1].id[3], giftList2[1].id[4], giftList2[1].id[5], giftList2[1].id[6])

                    elseif (Num == 10 and GetTaskBit(TaskVariableID, 31) == 0) then
                        local MoonLight = table.getn(giftList2)
                        itemName = GetNormalItemName(giftList2[MoonLight].id[1], giftList2[MoonLight].id[2], giftList2[MoonLight].id[3], giftList2[MoonLight].id[4])
                        SetTaskBit(TaskVariableID, 31, 1)
                        AddNormalItemPile(giftList2[MoonLight].id[1], giftList2[MoonLight].id[2], giftList2[MoonLight].id[3], giftList2[MoonLight].id[4], giftList2[MoonLight].id[5], giftList2[MoonLight].id[6])

                    else

                        if (i == table.getn(giftList2)) then
                            SetTaskBit(TaskVariableID, 31, 1)
                        end
                        itemName = GetNormalItemName(giftList2[i].id[1], giftList2[i].id[2], giftList2[i].id[3], giftList2[i].id[4])
                        AddNormalItemPile(giftList2[i].id[1], giftList2[i].id[2], giftList2[i].id[3], giftList2[i].id[4], giftList2[i].id[5], giftList2[i].id[6])
                    end
                    Msg2Player("B¹n nhËn ®­îc 1" .. itemName .. ", ÇëÔÚ±³°üÖÐ²é¿´.")
                    WriteLog("[·âÉñÀí²Æ¿¨»î¶¯][¿ñ»¶ÀñºÐ][" .. GetName() .. "] NhËn ®­îc ÁË1 c¸i " .. itemName)
                    return

                else


                    if ((GetTaskBit(TaskVariableID, 31) == 1) and (i == table.getn(giftList2))) then
                        itemName = GetNormalItemName(giftList2[1].id[1], giftList2[1].id[2], giftList2[1].id[3], giftList2[1].id[4])
                        local g_Text = "¸½¼þÖÐÊÇÄú»ñµÃµÄµÀ¾ß" .. itemName .. ", Çë×¢Òâ²éÊÕ."
                        SendSysItemMailToTarget("Hép th­", playerName, itemName, g_Text, giftList2[1].id[1], giftList2[1].id[2], giftList2[1].id[3], giftList2[1].id[4], giftList2[1].id[5], giftList2[1].id[6])

                    elseif (Num == 10 and GetTaskBit(TaskVariableID, 31) == 0) then
                        local MoonLight = table.getn(giftList2)
                        itemName = GetNormalItemName(giftList2[MoonLight].id[1], giftList2[MoonLight].id[2], giftList2[MoonLight].id[3], giftList2[MoonLight].id[4])
                        SetTaskBit(TaskVariableID, 31, 1)
                        local g_Text = "¸½¼þÖÐÊÇÄú»ñµÃµÄµÀ¾ß" .. itemName .. ", Çë×¢Òâ²éÊÕ."
                        SendSysItemMailToTarget("Hép th­", playerName, itemName, g_Text, giftList2[MoonLight].id[1], giftList2[MoonLight].id[2], giftList2[MoonLight].id[3], giftList2[MoonLight].id[4], giftList2[MoonLight].id[5], giftList2[MoonLight].id[6])
                    else

                        if (i == table.getn(giftList2)) then
                            SetTaskBit(TaskVariableID, 31, 1)
                        end
                        itemName = GetNormalItemName(giftList2[i].id[1], giftList2[i].id[2], giftList2[i].id[3], giftList2[i].id[4])
                        local g_Text = "¸½¼þÖÐÊÇÄú»ñµÃµÄµÀ¾ß" .. itemName .. ", Çë×¢Òâ²éÊÕ."
                        SendSysItemMailToTarget("Hép th­", playerName, itemName, g_Text, giftList2[i].id[1], giftList2[i].id[2], giftList2[i].id[3], giftList2[i].id[4], giftList2[i].id[5], giftList2[i].id[6])
                    end
                    Msg2Player("ÄúÓÐÒ»·âÐÂµÄÓÊ¼þ, ²¢ nhËn ®­îc 1 c¸i " .. itemName .. ", Çë×¢Òâ²é¿´.")
                    WriteLog("[·âÉñÀí²Æ¿¨»î¶¯][¿ñ»¶ÀñºÐ][" .. GetName() .. "]ÊÕµ½ÓÊ¼þ, ²¢ nhËn ®­îc 1 c¸i " .. itemName)
                    return
                end
            end
        end
    end
end

function GetSpaceRoom(spaceRoomCount)
    if (IsHaveSpaceForTreasure(spaceRoomCount) < 1) then
        return 0
    else
        return 1
    end
end

function no()
    CloseDialog()
end
