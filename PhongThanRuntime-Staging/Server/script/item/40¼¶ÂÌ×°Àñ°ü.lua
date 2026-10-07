GItemID = { 6, 1, 1424, 1 }
GItemName = "Trang bÞ lôc cÊp 40Àñ°ü"

ItemTable = {

    [1] = {
        [1] = { name = "Vò Khóc Kh«i", ID = { 0, 7, 3, 4, 0, 0 } },
        [2] = { name = "Vò Khóc Yªu §¸i", ID = { 0, 6, 3, 4, 0, 0 } },
        [3] = { name = "Vò Khóc ChiÕn Ngoa", ID = { 0, 5, 3, 4, 0, 0 } },
        [4] = { name = "Vò Khóc phi phong", ID = { 0, 9, 3, 4, 0, 0 } },
        [5] = { name = "Vò Khóc Gi¸p", ID = { 0, 2, 3, 4, 0, 0 } },
    },

    [2] = {
        [1] = { name = "XÝch Tïng Qu¸n", ID = { 0, 7, 4, 3, 0, 0 } },
        [2] = { name = "XÝch Tïng C©n", ID = { 0, 6, 4, 3, 0, 0 } },
        [3] = { name = "XÝch Tïng Lý", ID = { 0, 5, 4, 3, 0, 0 } },
        [4] = { name = "XÝch Tïng lÖnh", ID = { 0, 9, 4, 3, 0, 0 } },
        [5] = { name = "XÝch Tïng §¹o Bµo", ID = { 0, 2, 4, 3, 0, 0 } },
    },

    [3] = {
        [1] = { name = "B¸o ThÇn Trô", ID = { 0, 7, 5, 3, 0, 0 } },
        [2] = { name = "B¸o ThÇn Yªu §¸i", ID = { 0, 6, 5, 3, 0, 0 } },
        [3] = { name = "B¸o ThÇn Ngoa", ID = { 0, 5, 5, 3, 0, 0 } },
        [4] = { name = "B¸o ThÇn kÕt", ID = { 0, 9, 5, 3, 0, 0 } },
        [5] = { name = "B¸o ThÇn Hé Gi¸p", ID = { 0, 2, 5, 3, 0, 0 } },
    },
}

function no()
    CloseDialog()
end

function main(nLevel, nTime, nTNpcIdx, itemID)
    CloseDialog()
    if (HaveNormalItem(GItemID[1], GItemID[2], GItemID[3], GItemID[4]) <= 0) then
        return
    end
    if (IsHaveSpaceForTreasure(6) == 0) then
        Talk(1, "no", "ThËt xin lçi, ±³°ü¿Õ¼ä²»×ã5¸ñ, xin h·y s¾p xÕp l¹i.")
        return
    end
    local UserType = GetPlayerType() + 1
    if (UserType < 1 or UserType > 3) then
        Talk(1, "no", "Xin lçi, nghÒ nghiÖp chän sai, h·y chän l¹i. ")
        return
    end

    if (DelNormalItem(GItemID[1], GItemID[2], GItemID[3], GItemID[4]) > 0) then
        for i = 1, table.getn(ItemTable[UserType]) do
            local ItemID = ItemTable[UserType][i].ID
            local nItemID = AddNormalItem4(ItemID[1], ItemID[2], ItemID[3], ItemID[4], ItemID[5], ItemID[6], ItemID[7], ItemID[8], ItemID[9])
            SetItemBind(nItemID, 1)
        end

        Msg2Player("Chóc mõng ngµi nhËn ®­îc Trang bÞ lôc cÊp 40Ò»Ì×.")

    end

end
