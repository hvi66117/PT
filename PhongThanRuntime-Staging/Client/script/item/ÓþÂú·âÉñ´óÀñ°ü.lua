g_BoxID = { 6, 1, 1350, 0 }

g_BianLiang = 1936

g_BianLiangBitIndex = 3

g_Time = {
    [1] = { nYear = 2015, nMonth = 10, nDay = 6 },
    [2] = { nYear = 2015, nMonth = 12, nDay = 31 },
}

g_NewServerName = ""

g_Items = {
    [1] = { ItemName = "Cµn Kh«n §¬n", ItemCount = 1, ItemType = 2, ItemId_1 = { 8, 1549, 2, 0, 0, 0 }, ItemId_7 = "." },
    [2] = { ItemName = "Lôc B¶o th¹ch", ItemCount = 1, ItemType = 2, ItemId_1 = { 3, 250, 0, 0, 0, 0 }, ItemId_7 = "." },
    [3] = { ItemName = "ThÎ Kim DËt", ItemCount = 1, ItemType = 2, ItemId_1 = { 8, 1316, 6, 0, 0, 0 }, ItemId_7 = "." },
    [4] = { ItemName = "Phï nhiÖm vô chñ ®Ò ngµy", ItemCount = 4, ItemType = 2, ItemId_1 = { 6, 1, 1005, 0, 0, 0 }, ItemId_7 = "." },
    [5] = { ItemName = "96 giêË«±¶¾­ÑéBUFF", ItemCount = 1, ItemType = 3, ItemId_1 = { 175, 96, 0, 0, 0, 0 }, ItemId_7 = "" },
    [6] = { ItemName = "588 v¹n b¹c kho¸", ItemCount = 1, ItemType = 4, ItemId_1 = { 5880000, 0, 0, 0, 0, 0 }, ItemId_7 = "" },
    [7] = { ItemName = "§Æc QuyÒn B¹ch Hæ (3 ngµy ×ð¹óÌåÑé)", ItemCount = 3, ItemType = 2, ItemId_1 = { 6, 1, 1084, 1, 0, 0 }, ItemId_7 = "." },
    [8] = { ItemName = "×¿Ô½ÌÚÎí»ÆæôÂí(30 ngµy )", ItemCount = 1, ItemType = 6, ItemId_1 = { 0, 10, 24, 1, 0, 30 }, ItemId_7 = "." },
    [9] = { ItemName = "×¿Ô½ÌÚÎíÁÖ¼äÈ¸(30 ngµy )", ItemCount = 1, ItemType = 6, ItemId_1 = { 0, 10, 25, 1, 1, 30 }, ItemId_7 = "." },
    [10] = { ItemName = "×¿Ô½ÌÚÎíºûµû³á(30 ngµy )", ItemCount = 1, ItemType = 6, ItemId_1 = { 0, 10, 26, 1, 2, 30 }, ItemId_7 = "." },
}

g_ItemsCount = table.getn(g_Items)

g_ItemsCountAdd = 9

function main(nLevel, nTime, nTNpcIdx, itemID)

    if (FindAValidItemID(itemID) <= 0) then
        InfoBox("Kh«ng cã vËt phÈm nµy hoÆc vËt phÈm ®· hÕt h¹n!")
        return
    end

    if (IsHaveSpaceForTreasure(g_ItemsCountAdd) == 0) then
        InfoBox("ThËt xin lçi, ÄúµÄ±³°ü²»×ã" .. g_ItemsCountAdd .. " c¸i¿Õ¼ä, ÇëÕûÀíºóÔÙÁìÈ¡.")
        return
    end

    if (GetTaskBit(g_BianLiang, g_BianLiangBitIndex) == 1) then
        InfoBox("ThËt xin lçi, ÄãÒÑ¾­ÁìÈ¡¹ý¸ÃÀàÐÍÀñ°ü, ²»¿ÉÖØ¸´ÁìÈ¡.")
        return
    end

    DelItemByID(itemID)

    SetTaskBit(g_BianLiang, g_BianLiangBitIndex, 1)

    local strValue = ""
    local strBs = 0
    local BiaoDian = ""
    local countAdd = 1

    for i = 1, g_ItemsCount do


        for j = 1, g_Items[i].ItemCount do

            if (Add(g_Items[i].ItemName, g_Items[i].ItemCount, g_Items[i].ItemType,
                    g_Items[i].ItemId_1[1], g_Items[i].ItemId_1[2], g_Items[i].ItemId_1[3], g_Items[i].ItemId_1[4],
                    g_Items[i].ItemId_1[5], g_Items[i].ItemId_1[6]
            ) > 0
            ) then

                if (strBs == 0) then
                    strBs = 1
                    strValue = "¹§Ï²Äú¿ªÆôÁËÓþÂú·âÉñ´óÀñ°ü, nhËn ®­îc "
                end
            end
        end

        if (strBs == 1 and g_Items[i].ItemCount > 0) then


            if (g_Items[i].ItemType ~= 6 or (g_Items[i].ItemType == 6 and g_Items[i].ItemId_1[5] == GetPlayerType())) then


                if (countAdd == g_ItemsCountAdd) then
                    BiaoDian = "."
                    countAdd = countAdd + 1
                else
                    BiaoDian = ","
                    countAdd = countAdd + 1
                end

                strValue = AddString(strValue, g_Items[i].ItemName, g_Items[i].ItemCount, g_Items[i].ItemId_7, BiaoDian)
            end
        end
    end

    if (strBs == 1) then
        Msg2Player(strValue)
    end
end;

function AddString(strValue, ItemName, ItemCount, ItemId_7, BiaoDian)

    if (ItemId_7 ~= "") then

        return strValue .. ItemCount .. ItemId_7 .. ItemName .. BiaoDian
    else

        return strValue .. ItemName .. BiaoDian
    end
end

function Add(ItemName, ItemCount, ItemType, ItemId_1, ItemId_2, ItemId_3, ItemId_4, ItemId_5, ItemId_6)


    if (ItemType == 1) then
        AddNormalItem(ItemId_1, ItemId_2, ItemId_3, ItemId_4, ItemId_5, ItemId_6)
        return ItemType
    end

    if (ItemType == 2) then
        AddNormalItemBind(ItemId_1, ItemId_2, ItemId_3, ItemId_4, ItemId_5, ItemId_6, 1)
        return ItemType
    end

    if (ItemType == 3) then
        AddIBBuff(ItemId_1, 3600 * ItemId_2)
        return ItemType
    end

    if (ItemType == 4) then
        EarnBind(ItemId_1)
        return ItemType
    end

    if (ItemType == 5) then
        SetPlayerVipLevel(ItemId_1, ItemId_2)
        return ItemType
    end

    if (ItemType == 6) then
        if (GetPlayerType() == ItemId_5) then
            local zuoqi = AddNormalItem4(ItemId_1, ItemId_2, ItemId_3, ItemId_4, 0, 0, 0, ItemId_6, 0)
            SetItemBind(zuoqi, 1)
            return ItemType
        end
    end

    return 0
end

function no()
    CloseDialog()
end;
