function main()
    if (HaveNormalItem(6, 1, 952, 1) <= 0) then
        return
    end

    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "H·y kiÓm tra tói tèi thiÓu cßn 1 «.")
        return
    end

    local nTask = {
        "ThÊt TrÇn Trai Ph¸p B¶o(VÜnh viÔn)/item_1",
        "Ä§ÓÓPh¸p b¶o ThÊt TrÇn Trai (ÓĞĞ§ÆÚÓÀ¾Ã)/item_1",
        "ÉñÆíPh¸p b¶o Kim S¬nÎïÀí (thêi h¹n 60 ngµy)/item_1",
        "ÉñÆíPh¸p b¶o Kim S¬n·¨Êõ (thêi h¹n 60 ngµy)/item_1",
        "Ä§ÓÓPh¸p b¶o Kim S¬nÎïÀí (thêi h¹n 60 ngµy)/item_1",
        "Ä§ÓÓPh¸p b¶o Kim S¬n·¨Êõ (thêi h¹n 60 ngµy)/item_1",
    }

    Say("H·y chän lo¹i Ph¸p B¶o muèn nhËn:", table.getn(nTask), nTask)
end

function item_1(nIndex)
    no()
    local nTask = {
        "ÉñÆíPh¸p b¶o ThÊt TrÇn Trai (ÓĞĞ§ÆÚÓÀ¾Ã)",
        "Ä§ÓÓPh¸p b¶o ThÊt TrÇn Trai (ÓĞĞ§ÆÚÓÀ¾Ã)",
        "ÉñÆíPh¸p b¶o Kim S¬nÎïÀí (thêi h¹n 60 ngµy)",
        "ÉñÆíPh¸p b¶o Kim S¬n·¨Êõ (thêi h¹n 60 ngµy)",
        "Ä§ÓÓPh¸p b¶o Kim S¬nÎïÀí (thêi h¹n 60 ngµy)",
        "Ä§ÓÓPh¸p b¶o Kim S¬n·¨Êõ (thêi h¹n 60 ngµy)",
    }
    SetTask(140, nIndex)
    if (nIndex == 0 and GetJusticEvilCredit() < 0) then
        MsgBox("Phe hiÖn t¹i lµ <c=g> Phe Ma<c>, muèn chän <c=g>ThÊt TrÇn Trai Ph¸p B¶o <c> kh«ng?", "item_1_Yes", "no")
    elseif (nIndex == 1 and GetJusticEvilCredit() > 0) then
        MsgBox("Phe hiÖn t¹i lµ <c=g> Phe Tiªn<c>, muèn chän <c=g>ThÊt TrÇn Trai Ph¸p B¶o (Ma) <c>##", "item_1_Yes", "no")
    elseif ((nIndex == 2 or nIndex == 3) and GetJusticEvilCredit() < 0) then
        MsgBox("Äãµ±Ç°ÕóÓªÎª<c=g>Ä§ÕóÓª<c>,È·¶¨ÒªÑ¡Ôñ<c=g>ÉñÆíPh¸p b¶o Kim S¬n<c> sao?", "item_1_Yes", "no")
    elseif ((nIndex == 4 or nIndex == 5) and GetJusticEvilCredit() > 0) then
        MsgBox("Äãµ±Ç°ÕóÓªÎª<c=g>ÏÉÕóÓª<c>,È·¶¨ÒªÑ¡Ôñ<c=g>Ä§ÓÓPh¸p b¶o Kim S¬n<c> sao?", "item_1_Yes", "no")
    else
        MsgBox(" Muèn chän" .. nTask[nIndex + 1] .. " kh«ng? sau khi chän Ph¸p B¶o nµy kh«ng thÓ chän Ph¸p B¶o kh¸c.", "item_1_Yes", "no")
    end
end

function item_1_Yes()
    CloseDialog()
    local nIndex = GetTask(140)
    if (HaveNormalItem(6, 1, 952, 1) <= 0) then
        return
    end

    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "H·y kiÓm tra tói tèi thiÓu cßn 1 «.")
        return
    end

    if (DelNormalItem(6, 1, 952, 1) > 0) then
        local nItemName = ""
        if (nIndex == 0) then
            AddNormalItem(0, 4, 75, 1, 0, 0)
            nItemName = "ÉñÆíPh¸p b¶o ThÊt TrÇn Trai (ÓĞĞ§ÆÚÓÀ¾Ã)"
        elseif (nIndex == 1) then
            AddNormalItem(0, 4, 76, 1, 0, 0)
            nItemName = "Ä§ÓÓPh¸p b¶o ThÊt TrÇn Trai (ÓĞĞ§ÆÚÓÀ¾Ã)"
        elseif (nIndex == 2) then
            AddNormalItem(0, 4, 80, 10, 0, 0)
            nItemName = "ÉñÆíPh¸p b¶o Kim S¬nÎïÀí (thêi h¹n 60 ngµy)"
        elseif (nIndex == 3) then
            AddNormalItem(0, 4, 81, 10, 0, 0)
            nItemName = "ÉñÆíPh¸p b¶o Kim S¬n·¨Êõ (thêi h¹n 60 ngµy)"
        elseif (nIndex == 4) then
            AddNormalItem(0, 4, 82, 10, 0, 0)
            nItemName = "Ä§ÓÓPh¸p b¶o Kim S¬nÎïÀí (thêi h¹n 60 ngµy)"
        elseif (nIndex == 5) then
            AddNormalItem(0, 4, 83, 10, 0, 0)
            nItemName = "Ä§ÓÓPh¸p b¶o Kim S¬n·¨Êõ (thêi h¹n 60 ngµy)"
        end

        WriteLog("vip»ØÀ¡³¬¼¶Ph¸p b¶o Chİ T«n: " .. nItemName)
        Msg2Player("Ngµi sö dông ³¬¼¶LÔ bao Ph¸p b¶o Chİ T«n, nhËn ®­îc  x1" .. nItemName .. ", h·y nhËn lÊy!")
    end
end

function no()
    CloseDialog()
end
