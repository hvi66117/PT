tblItem = {
    [1] = { name = "Ph¸p b¶o Phong ThÇn ThËp Chu Niªn (VËt lý Gi¶m th­¬ng)", id = { 0, 4, 89, 2, 0, 0, 0 } },
    [2] = { name = "Ph¸p b¶o Phong ThÇn ThËp Chu Niªn (Ph¸p thuËt Gi¶m th­¬ng)", id = { 0, 4, 90, 2, 0, 0, 0 } },
}
gItemName = "LÔ bao Ph¸p b¶o Phong ThÇn Chu Niªn"

function main(nLevel, nTime, nTNpcIdx, itemID)
    if (FindAValidItemID(itemID) <= 0) then
        InfoBox("Kh«ng cã vËt phÈm nµy hoÆc vËt phÈm ®· hÕt h¹n!")
        return
    end

    if (IsHaveSpaceForTreasure(1) == 0) then
        InfoBox("Hµnh trang kh«ng cã ®ñ 1 « trèng.")
        return
    end

    local item = {}
    for i = 1, table.getn(tblItem) do
        item[i] = tblItem[i].name .. "/YesItem"
    end

    SetTask(140, itemID)
    Say("H·y chän lo¹i vËt phÈm ng­¬i muèn nhËn: ", table.getn(item), item)

end

function YesItem(nIndex)
    CloseDialog()
    local itemID = GetTask(140)
    nIndex = nIndex + 1
    if (nIndex <= 0 or nIndex > table.getn(tblItem)) then
        return
    end

    if (FindAValidItemID(itemID) <= 0) then
        InfoBox("Kh«ng cã vËt phÈm nµy hoÆc vËt phÈm ®· hÕt h¹n!")
        return
    end

    DelItemByID(itemID)
    item = tblItem[nIndex].id
    AddNormalItemBind(item[1], item[2], item[3], item[4], item[5], item[6], item[7])
    Msg2Player("Ngµi më " .. gItemName .. ", nhËn " .. tblItem[nIndex].name .. ".")
    WriteLog("[KhuyÕn m¹i n¹p thÎ][nhËn ®­îc ]:" .. tblItem[nIndex].name)
end

function no()
    CloseDialog()
end
