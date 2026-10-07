GItemID = { 6, 1, 1461, 1 }
GItemName = "Trang bÞ lôc cÊp 20Àñ°ü"

ItemTable = {

    [1] = {
        [1] = { name = "Cù §Êu Kh«i", ID = { 0, 7, 3, 1, 0, 0 } },
        [2] = { name = "Cù §Êu Yªu §¸i", ID = { 0, 6, 3, 1, 0, 0 } },
        [3] = { name = "Cù §Êu ChiÕn Ngoa", ID = { 0, 5, 3, 1, 0, 0 } },
        [4] = { name = "Cù §Êu phi phong", ID = { 0, 9, 3, 1, 0, 0 } },
        [5] = { name = "Cù §Êu Gi¸p", ID = { 0, 2, 3, 1, 0, 0 } },
    },

    [2] = {
        [1] = { name = "V©n Trung Qu¸n", ID = { 0, 7, 4, 1, 0, 0 } },
        [2] = { name = "V©n Trung C©n", ID = { 0, 6, 4, 1, 0, 0 } },
        [3] = { name = "V©n Trung Lý", ID = { 0, 5, 4, 1, 0, 0 } },
        [4] = { name = "V©n Trung lÖnh", ID = { 0, 9, 4, 1, 0, 0 } },
        [5] = { name = "V©n Trung §¹o Bµo", ID = { 0, 2, 4, 1, 0, 0 } },
    },

    [3] = {
        [1] = { name = "KhuyÓn V¨n Trô", ID = { 0, 7, 5, 1, 0, 0 } },
        [2] = { name = "KhuyÓn V¨n Yªu §¸i", ID = { 0, 6, 5, 1, 0, 0 } },
        [3] = { name = "KhuyÓn V¨n Ngoa", ID = { 0, 5, 5, 1, 0, 0 } },
        [4] = { name = "KhuyÓn V¨n kÕt", ID = { 0, 9, 5, 1, 0, 0 } },
        [5] = { name = "KhuyÓn V¨n Hé Gi¸p", ID = { 0, 2, 5, 1, 0, 0 } },
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

        Msg2Player("Chóc mõng ngµi nhËn ®­îc Trang bÞ lôc cÊp 20Ò»Ì×.")

    end

end
