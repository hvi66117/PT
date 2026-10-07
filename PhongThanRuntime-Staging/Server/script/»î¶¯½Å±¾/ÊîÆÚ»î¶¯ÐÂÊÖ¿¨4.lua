function main(nLevel, t, nTNpcIdx, nItemId)
    if (IsHaveSpaceForTreasure(6) == 0) then
        Talk(1, "no", "´ò¿ª´ËÀñ°üÐèÒªÎå¸ö±³°ü¿Õ¸ñ, ÇëÇåÀí±³°ü!")
        return
    end
    if (HaveNormalItem(6, 1, 883, 0) == 0) then
        return
    end

    local itemTable = { { 8, 35, 2, "Di ngo¹i phï" }, { 8, 374, 0, "Dao Tiªn t¸n" }, { 8, 162, 3, "Thanh Lé" }, { 8, 163, 4, "Ch©n KhÝ" }, { 8, 1397, 2, "Linh Thó Kim Thè biÕn th©n phï" } }
    for i = 1, 5 do
        AddNormalItemBind(itemTable[i][1], itemTable[i][2], itemTable[i][3], 0, 0, 0, 1)
        Msg2Player("B¹n nhËn ®­îc " .. itemTable[i][4] .. ".")
    end

    DelItemByID(nItemId)
end

function no()
    CloseDialog()
end
