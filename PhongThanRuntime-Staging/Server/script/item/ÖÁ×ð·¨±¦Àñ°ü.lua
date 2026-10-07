function main()
    if (HaveNormalItem(6, 1, 951, 1) <= 0) then
        return
    end

    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "H·y kiÓm tra tói tèi thiÓu cßn 1 «.")
        return
    end

    local nTask = {
        "ThÊt TrÇn Trai Ph¸p B¶o (180 ngµy)/item_1",
        "ThÊt TrÇn Trai Ph¸p B¶o (Ma)(180 ngµy)/item_1",
        "ThÊt TrÇn Trai Ph¸p B¶o (VËt)(Söa 12, 180 ngµy)/item_1",
        "ThÊt TrÇn Trai Ph¸p B¶o (ThuËt)(Söa 12, 180 ngµy)/item_1",
        "Kim S¬n Ph¸p B¶o(Söa 12, 180 ngµy)/item_1",
        "Tam Sinh Th¹ch Ph¸p B¶o(Söa 12, 180 ngµy)/item_1",
        "ÉñÆíPh¸p b¶o Kim S¬nÎïÀí (thêi h¹n 30 ngµy)/item_1",
        "ÉñÆíPh¸p b¶o Kim S¬n·¨Êõ (thêi h¹n 30 ngµy)/item_1",
        "Ä§ÓÓPh¸p b¶o Kim S¬nÎïÀí (thêi h¹n 30 ngµy)/item_1",
        "Ä§ÓÓPh¸p b¶o Kim S¬n·¨Êõ (thêi h¹n 30 ngµy)/item_1",
    }

    Say("H·y chän lo¹i Ph¸p B¶o muèn nhËn:", table.getn(nTask), nTask)
end

function item_1(nIndex)
    CloseDialog()
    local nTask = {
        "ThÊt TrÇn Trai Ph¸p B¶o(180 ngµy)",
        "ThÊt TrÇn Trai Ph¸p B¶o (Ma)(180 ngµy)",
        "ThÊt TrÇn Trai Ph¸p B¶o (VËt)(Söa 12, 180 ngµy)",
        "ThÊt TrÇn Trai Ph¸p B¶o (ThuËt)(Söa 12, 180 ngµy)",
        "Kim S¬n Ph¸p B¶o(Söa 12, 180 ngµy)",
        "Tam Sinh Th¹ch Ph¸p B¶o(Söa 12, 180 ngµy)",
        "ÉñÆíPh¸p b¶o Kim S¬nÎïÀí (thêi h¹n 30 ngµy)",
        "ÉñÆíPh¸p b¶o Kim S¬n·¨Êõ (thêi h¹n 30 ngµy)",
        "Ä§ÓÓPh¸p b¶o Kim S¬nÎïÀí (thêi h¹n 30 ngµy)",
        "Ä§ÓÓPh¸p b¶o Kim S¬n·¨Êõ (thêi h¹n 30 ngµy)",
    }
    SetTask(140, nIndex)
    if (nIndex == 0 and GetJusticEvilCredit() < 0) then
        MsgBox("Phe hiÖn t¹i lµ <c=g> Phe Ma<c>, muèn chän <c=g>ThÊt TrÇn Trai Ph¸p B¶o <c> kh«ng?", "item_1_Yes", "no")
    elseif (nIndex == 1 and GetJusticEvilCredit() > 0) then
        MsgBox("Phe hiÖn t¹i lµ <c=g> Phe Tiªn<c>, muèn chän <c=g>ThÊt TrÇn Trai Ph¸p B¶o (Ma) <c>##", "item_1_Yes", "no")
    elseif ((nIndex == 6 or nIndex == 7) and GetJusticEvilCredit() < 0) then
        MsgBox("Äãµ±Ç°ÕóÓªÎª<c=g>Ä§ÕóÓª<c>,È·¶¨ÒªÑ¡Ôñ<c=g>ÉñÆíPh¸p b¶o Kim S¬n<c> sao?", "item_1_Yes", "no")
    elseif ((nIndex == 8 or nIndex == 9) and GetJusticEvilCredit() > 0) then
        MsgBox("Äãµ±Ç°ÕóÓªÎª<c=g>ÏÉÕóÓª<c>,È·¶¨ÒªÑ¡Ôñ<c=g>Ä§ÓÓPh¸p b¶o Kim S¬n<c> sao?", "item_1_Yes", "no")
    else
        MsgBox(" Muèn chän" .. nTask[nIndex + 1] .. " kh«ng? sau khi chän Ph¸p B¶o nµy kh«ng thÓ chän Ph¸p B¶o kh¸c.", "item_1_Yes", "no")
    end
end

function item_1_Yes()
    CloseDialog()
    local nIndex = GetTask(140)
    if (HaveNormalItem(6, 1, 951, 1) <= 0 or nIndex < 0 or nIndex >= 10) then
        return
    end

    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "H·y kiÓm tra tói tèi thiÓu cßn 1 «.")
        return
    end

    if (DelNormalItem(6, 1, 951, 1) > 0) then
        local nItemName = ""
        if (nIndex == 0) then
            AddNormalItem(0, 4, 68, 10, 0, 0)
            nItemName = "ThÊt TrÇn Trai Ph¸p B¶o(180 ngµy)"
        elseif (nIndex == 1) then
            AddNormalItem(0, 4, 69, 10, 0, 0)
            nItemName = "ThÊt TrÇn Trai Ph¸p B¶o (Ma)(180 ngµy)"
        elseif (nIndex == 2) then
            AddNormalItem4(0, 4, 70, 10, 1, 2024, 12)
            nItemName = "ThÊt TrÇn Trai Ph¸p B¶o (VËt)(Söa 12, 180 ngµy)"
        elseif (nIndex == 3) then
            AddNormalItem4(0, 4, 71, 10, 1, 2025, 12)
            nItemName = "ThÊt TrÇn Trai Ph¸p B¶o (ThuËt)(Söa 12, 180 ngµy)"
        elseif (nIndex == 4) then
            AddNormalItem4(0, 4, 37, 10, 1, 2023, 12)
            nItemName = "Kim S¬n Ph¸p B¶o(Söa 12, 180 ngµy)"
        elseif (nIndex == 5) then
            AddNormalItem4(0, 4, 36, 10, 1, 2029, 12)
            nItemName = "Tam Sinh Th¹ch Ph¸p B¶o(Söa 12, 180 ngµy)"
        elseif (nIndex == 6) then
            AddNormalItem(0, 4, 80, 9, 0, 0)
            nItemName = "ÉñÆíPh¸p b¶o Kim S¬nÎïÀí (thêi h¹n 30 ngµy)"
        elseif (nIndex == 7) then
            AddNormalItem(0, 4, 81, 9, 0, 0)
            nItemName = "ÉñÆíPh¸p b¶o Kim S¬n·¨Êõ (thêi h¹n 30 ngµy)"
        elseif (nIndex == 8) then
            AddNormalItem(0, 4, 82, 9, 0, 0)
            nItemName = "Ä§ÓÓPh¸p b¶o Kim S¬nÎïÀí (thêi h¹n 30 ngµy)"
        elseif (nIndex == 9) then
            AddNormalItem(0, 4, 83, 9, 0, 0)
            nItemName = "Ä§ÓÓPh¸p b¶o Kim S¬n·¨Êõ (thêi h¹n 30 ngµy)"
        end

        WriteLog("Ph¸p b¶o ChÝ Tèn vip quay vÒ:" .. nItemName)
        Msg2Player("Sö dông Ph¸p B¶o ChÝ T«n nhËn ®­îc 1" .. nItemName .. ", h·y nhËn lÊy!")
    end
end

function no()
    CloseDialog()
end
