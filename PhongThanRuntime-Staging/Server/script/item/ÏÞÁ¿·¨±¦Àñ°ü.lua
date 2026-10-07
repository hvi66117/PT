tblItem = {
    [1] = { name = "LÔ bao Ph¸p B¶o TruyÒn ThuyÕt", id = { 6, 1, 1310, 1, 0, 0, 0 } },
    [2] = { name = "LÔ bao Ph¸p b¶o Phong ThÇn Chu Niªn", id = { 6, 1, 1335, 1, 0, 0, 0 } },
}
gItemName = "LÔ bao Ph¸p B¶o Giíi H¹n"

function main(nLevel, nTime, nTNpcIdx, itemID)
    if (FindAValidItemID(itemID) <= 0) then
        InfoBox("Kh«ng cã vËt phÈm nµy hoÆc vËt phÈm ®· hÕt h¹n!")
        return
    end
    if (IsHaveSpaceForTreasure(1) == 0) then
        InfoBox("Hµnh trang kh«ng cã ®ñ 1 « trèng.")
        return
    end
    SetTask(140, itemID)
    Say("H·y chän lo¹i h×nh ph¸p b¶o ngµi muèn nhËn: ", 2, tblItem[1].name .. "/YesItem", tblItem[2].name .. "/YesItem")
end

function YesItem(nIndex)
    no()
    local itemID = GetTask(140)
    nIndex = nIndex + 1
    if (nIndex <= 0 or nIndex > 2) then
        return
    end

    if (FindAValidItemID(itemID) <= 0) then
        InfoBox("Kh«ng cã vËt phÈm nµy hoÆc vËt phÈm ®· hÕt h¹n!")
        return
    end
    local item = {}
    DelItemByID(itemID)
    item = tblItem[nIndex].id
    AddNormalItem(item[1], item[2], item[3], item[4], item[5], item[6], item[7])
    Msg2Player("Ngµi më " .. gItemName .. ", nhËn " .. tblItem[nIndex].name .. ".")
    WriteLog("[KhuyÕn m¹i n¹p thÎ][NhËn ®­îc]:" .. tblItem[nIndex].name)
end

function no()
    CloseDialog()
end
