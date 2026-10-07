CostIndex_1 = 257
CostIndex_2 = 258
CostIndex_3 = 259
CostIndex_4 = 295
CostIndex_5 = 296
CostIndex_6 = 297

GiftTable = {
    [1] = { itemid = { 8, 1716, 2, 1 }, count = 1 },
    [2] = { itemid = { 8, 2031, 2, 1 }, count = 1 },
    [3] = { itemid = { 8, 1717, 2, 1 }, count = 1 },
    [4] = { itemid = { 8, 2032, 2, 1 }, count = 1 },
    [5] = { itemid = { 8, 1718, 2, 1 }, count = 1 },
    [6] = { itemid = { 8, 2033, 2, 1 }, count = 1 },
}

function main()

    local str = "Ph¸p b¶o Chİ T«nÖúÁ¦°ü,ÖúÄú·¨±¦³É¹¦Éı¼¶100%³É¹¦.\n"
    str = str .. "Ó¢ĞÛÔÚ´Ë¹ºÂòµÄµÀ¾ß¾ùÎª°ó¶¨µÀ¾ß,¿Éµã»÷ÒÔÏÂ°´Å¥²é¿´µÀ¾ßÏêÇé.\n"

    local tasks = {
        { "Chİ T«n¾«İÍ", "page1"; show = 1 },
        { "Chİ T«n¾«Ôª", "page2"; show = 1 },
        { "Chİ T«n¾«»ª", "page3"; show = 1 },
    }
    SayTask(str, tasks)
end

function page1()

    local str = "S¬ cÊp Chİ T«n Tinh tuş: Éı¼¶³õ¼¶Ph¸p b¶o Chİ T«nµÚ4.5.6´Î, ¿É±£ÕÏ100%Éı¼¶³É¹¦.\n"
    str = str .. "Cao cÊp Chİ T«n Tinh Tuş: Éı¼¶¸ß¼¶Ph¸p b¶o Chİ T«nµÚ4.5.6´Î, ¿É±£ÕÏ100%Éı¼¶³É¹¦."

    local operator = {
        "S¬ cÊp Chİ T«n Tinh tuş/OperatLow_1",
        "Cao cÊp Chİ T«n Tinh Tuş/OperatHigh_1",
        "Quay l¹i/main",
    }

    Say(str, table.getn(operator), operator)
end

function page2()

    local str = "S¬ cÊp Chİ T«n Tinh nguyªn: Éı¼¶³õ¼¶Ph¸p b¶o Chİ T«nµÚ7.8.9´Î, ¿É±£ÕÏ100%Éı¼¶³É¹¦.\n"
    str = str .. "Cao cÊp Chİ T«n Tinh nguyªn: Éı¼¶¸ß¼¶Ph¸p b¶o Chİ T«nµÚ7.8.9´Î, ¿É±£ÕÏ100%Éı¼¶³É¹¦."

    local operator = {
        "S¬ cÊp Chİ T«n Tinh nguyªn/OperatLow_2",
        "Cao cÊp Chİ T«n Tinh nguyªn/OperatHigh_2",
        "Quay l¹i/main",
    }

    Say(str, table.getn(operator), operator)
end

function page3()

    local str = "S¬ cÊp Chİ T«n Tinh hoa: Éı¼¶³õ¼¶Ph¸p b¶o Chİ T«nµÚ10.11.12´Î, ¿É±£ÕÏ100%Éı¼¶³É¹¦.\n"
    str = str .. "Cao cÊp Chİ T«n Tinh hoa: Éı¼¶¸ß¼¶Ph¸p b¶o Chİ T«nµÚ10.11.12´Î, ¿É±£ÕÏ100%Éı¼¶³É¹¦."

    local operator = {
        "S¬ cÊp Chİ T«n Tinh hoa/OperatLow_3",
        "Cao cÊp Chİ T«n Tinh hoa/OperatHigh_3",
        "Quay l¹i/main",
    }

    Say(str, table.getn(operator), operator)
end

function OperatLow_1()

    local _, costvalue, _ = GetCostCoinInfoByIdx(257)
    costvalue = costvalue / 100
    MsgBox("ÄúÈ·¶¨Òª»¨·Ñ<c=g>" .. costvalue .. " Th«ng B¶o<c>¹ºÂòS¬ cÊp Chİ T«n Tinh tuşÃ´?", "OperatLow_1_Yes", "page1")
end

function OperatHigh_1()

    local _, costvalue, _ = GetCostCoinInfoByIdx(295)
    costvalue = costvalue / 100
    MsgBox("ÄúÈ·¶¨Òª»¨·Ñ<c=g>" .. costvalue .. " Th«ng B¶o<c>¹ºÂòCao cÊp Chİ T«n Tinh TuşÃ´?", "OperatHgih_1_Yes", "page1")
end

function OperatLow_1_Yes()

    AddSuperItem(CostIndex_1, GiftTable[1])
end

function OperatHgih_1_Yes()

    AddSuperItem(CostIndex_4, GiftTable[2])
end

function OperatLow_2()

    local _, costvalue, _ = GetCostCoinInfoByIdx(258)
    costvalue = costvalue / 100
    MsgBox("ÄúÈ·¶¨Òª»¨·Ñ<c=g>" .. costvalue .. " Th«ng B¶o<c>¹ºÂòS¬ cÊp Chİ T«n Tinh nguyªnÃ´?", "OperatLow_2_Yes", "page2")
end

function OperatHigh_2()

    local _, costvalue, _ = GetCostCoinInfoByIdx(296)
    costvalue = costvalue / 100
    MsgBox("ÄúÈ·¶¨Òª»¨·Ñ<c=g>" .. costvalue .. " Th«ng B¶o<c>¹ºÂòCao cÊp Chİ T«n Tinh nguyªnÃ´?", "OperatHigh_2_Yes", "page2")
end

function OperatLow_2_Yes()

    AddSuperItem(CostIndex_2, GiftTable[3])
end

function OperatHigh_2_Yes()

    AddSuperItem(CostIndex_5, GiftTable[4])
end

function OperatLow_3()

    local _, costvalue, _ = GetCostCoinInfoByIdx(259)
    costvalue = costvalue / 100
    MsgBox("ÄúÈ·¶¨Òª»¨·Ñ<c=g>" .. costvalue .. " Th«ng B¶o<c>¹ºÂòS¬ cÊp Chİ T«n Tinh hoaÃ´?", "OperatLow_3_Yes", "page3")
end

function OperatHigh_3()

    local _, costvalue, _ = GetCostCoinInfoByIdx(297)
    costvalue = costvalue / 100
    MsgBox("ÄúÈ·¶¨Òª»¨·Ñ<c=g>" .. costvalue .. " Th«ng B¶o<c>¹ºÂòCao cÊp Chİ T«n Tinh hoaÃ´?", "OperatHigh_3_Yes", "page3")
end

function OperatLow_3_Yes()

    AddSuperItem(CostIndex_3, GiftTable[5])
end

function OperatHigh_3_Yes()

    AddSuperItem(CostIndex_6, GiftTable[6])
end

function AddSuperItem(costIndex, gift)

    local _, costvalue, _ = GetCostCoinInfoByIdx(costIndex)
    if (GetCoin() < costvalue * gift.count) then
        Talk(1, "no", "ThËt xin lçi, Äúµ±Ç°µÄÍ¨±¦²»×ã.")
        return
    end

    if (IsHaveSpaceForTreasure(gift.count + 1) == 0) then
        Talk(1, "no", "ThËt xin lçi, Äúµ±Ç°±³°ü²»×ã.")
        return
    end

    local nRet = CostCoinByIdx(costIndex)
    if (nRet ~= 0) then
        for i = 1, gift.count do
            AddNormalItemBind(gift.itemid[1], gift.itemid[2], gift.itemid[3], gift.itemid[4], 0, 0, 1)
        end

        local itemName = GetNormalItemName(gift.itemid[1], gift.itemid[2], gift.itemid[3], gift.itemid[4])
        WriteLog("[NhËn ®­îc µÀ¾ß][Íæ¼Ò" .. GetName() .. "»ñÈ¡µÀ¾ß" .. itemName .. "x" .. gift.count .. "!")
        Talk(1, "no", "Chóc mõng ngµi nhËn ®­îc " .. itemName .. "x" .. gift.count .. ".")
    end
end

function no()

    CloseDialog()
end
