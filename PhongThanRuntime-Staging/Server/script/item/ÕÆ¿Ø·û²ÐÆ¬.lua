function no()
    CloseDialog()
end
itemSuiPianName = "Æ÷Áé²ÐÆ¬"
itemSuiPianID = { 6, 1, 1181, 1 }
itemName = "KhÝ Linh Tinh Tóy"
itemID = { 3, 1242, 0, 0 }
itemCount = 20

function main()
    no()
    if (HaveNormalItem(itemSuiPianID[1], itemSuiPianID[2], itemSuiPianID[3], itemSuiPianID[4]) <= 0) then
        Talk(1, "no", "GhÐp 1 " .. itemName .. " cÇn " .. itemCount .. " " .. itemSuiPianName .. ".")
        return
    end

    MsgBox("Hîp thµnh " .. itemName .. " cÇn <c=g>" .. itemCount .. " " .. itemSuiPianName .. "<c>, Anh hïng ®ång ý ghÐp kh«ng?", "Yes_Item", "no")
end

function Yes_Item()
    CloseDialog()
    if (HaveNormalItem(itemSuiPianID[1], itemSuiPianID[2], itemSuiPianID[3], itemSuiPianID[4]) < itemCount) then
        Talk(1, "no", "Xin lçi, trªn ngµy" .. itemSuiPianName .. "kh«ng ®ñ <c=g>" .. itemCount .. "<c>.")
        return
    end

    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "Xin lçi, tói ®Çy, h·y s¾p xÕp råi ghÐp. ")
        return
    end

    for i = 1, itemCount do
        DelNormalItem(itemSuiPianID[1], itemSuiPianID[2], itemSuiPianID[3], itemSuiPianID[4])
    end

    AddNormalItemBind(itemID[1], itemID[2], itemID[3], itemID[4], 0, 0, 1)
    Msg2Player("B¹n nh©n ®­îc " .. itemName .. ".")
    WriteLog("Hîp thµnh" .. itemName .. ".")
end
