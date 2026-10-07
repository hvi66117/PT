function main()
    if (HaveNormalItem(6, 1, 949, 1) <= 0) then
        return
    end

    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "H·y kiÓm tra tói tèi thiÓu cßn 1 «.")
        return
    end

    local nTask = {
        "ThÊt TrÇn Trai Ph¸p B¶o (ThÇn) (khãa)(90 ngµy)/item_1",
        "ThÊt TrÇn Trai Ph¸p B¶o (Ma) (khãa)(90 ngµy)/item_1",
        "ThÊt TrÇn Trai Ph¸p B¶o (VËt) (12 söa,90 ngµy)/item_1",
        "ThÊt TrÇn Trai Ph¸p B¶o ThuËt (Söa 12,90 ngµy)/item_1",
        "Kim S¬n Ph¸p B¶o (Söa 12, 90 ngµy)/item_1",
        "Tam Sinh Th¹ch Ph¸p B¶o (Söa 12, 90 ngµy)/item_1",
    }

    Say("H·y chän lo¹i Ph¸p B¶o muèn nhËn:", table.getn(nTask), nTask)
end

function item_1(nIndex)
    CloseDialog()
    local nTask = {
        "ThÊt TrÇn Trai Ph¸p B¶o(90 ngµy)",
        "ThÊt TrÇn Trai Ph¸p B¶o (Ma)(90 ngµy)",
        "ThÊt TrÇn Trai Ph¸p B¶o (VËt)(Söa 12, 90 ngµy)",
        "ThÊt TrÇn Trai Ph¸p B¶o (ThuËt)(Söa 12, 90 ngµy)",
        "Kim S¬n Ph¸p B¶o(Söa 12, 90 ngµy)",
        "Tam Sinh Th¹ch Ph¸p B¶o(Söa 12, 90 ngµy)",
    }
    SetTask(140, nIndex)
    if (nIndex == 0 and GetJusticEvilCredit() < 0) then
        MsgBox("Phe hiÖn t¹i lµ <c=g> Phe Ma<c>, muèn chän <c=g>ThÊt TrÇn Trai Ph¸p B¶o <c> kh«ng?", "item_1_Yes", "no")
    elseif (nIndex == 1 and GetJusticEvilCredit() > 0) then
        MsgBox("Phe hiÖn t¹i lµ <c=g> Phe Tiªn<c>, muèn chän <c=g>ThÊt TrÇn Trai Ph¸p B¶o (Ma) <c>##", "item_1_Yes", "no")
    else
        MsgBox(" Muèn chän" .. nTask[nIndex + 1] .. " kh«ng? sau khi chän Ph¸p B¶o nµy kh«ng thÓ chän Ph¸p B¶o kh¸c.", "item_1_Yes", "no")
    end
end

function item_1_Yes()
    CloseDialog()
    local nIndex = GetTask(140)
    if (HaveNormalItem(6, 1, 949, 1) <= 0 or nIndex < 0 or nIndex >= 6) then
        return
    end

    if (IsHaveSpaceForTreasure(2) == 0) then
        Talk(1, "no", "H·y kiÓm tra tói tèi thiÓu cßn 1 «.")
        return
    end

    if (DelNormalItem(6, 1, 949, 1) > 0) then
        local nItemName = ""
        if (nIndex == 0) then
            AddNormalItem(0, 4, 68, 8, 0, 0)
            nItemName = "ThÊt TrÇn Trai Ph¸p B¶o(90 ngµy)"
        elseif (nIndex == 1) then
            AddNormalItem(0, 4, 69, 8, 0, 0)
            nItemName = "ThÊt TrÇn Trai Ph¸p B¶o (Ma)(90 ngµy)"
        elseif (nIndex == 2) then
            AddNormalItem4(0, 4, 64, 10, 1, 2024, 12)
            nItemName = "ThÊt TrÇn Trai Ph¸p B¶o (VËt)(Söa 12, 90 ngµy)"
        elseif (nIndex == 3) then
            AddNormalItem4(0, 4, 65, 10, 1, 2025, 12)
            nItemName = "ThÊt TrÇn Trai Ph¸p B¶o (ThuËt)(Söa 12, 90 ngµy)"
        elseif (nIndex == 4) then
            AddNormalItem4(0, 4, 37, 8, 1, 2023, 12)
            nItemName = "Kim S¬n Ph¸p B¶o(Söa 12, 90 ngµy)"
        elseif (nIndex == 5) then
            AddNormalItem4(0, 4, 36, 8, 1, 2029, 12)
            nItemName = "Tam Sinh Th¹ch Ph¸p B¶o(Söa 12, 90 ngµy)"
        end

        WriteLog("Ph¸p B¶o b¹ch kim vip quay vÒ:" .. nItemName)
        Msg2Player("B¹n sö dông lÔ bao Ph¸p B¶o b¹ch kim, nhËn ®­îc 1" .. nItemName .. ", h·y nhËn lÊy!")
    end
end

function no()
    CloseDialog()
end
