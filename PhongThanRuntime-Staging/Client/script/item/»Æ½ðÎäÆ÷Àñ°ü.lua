tblItem = {
    [1] = {
        { name = "HuyÕt NhÉn §ao (ÈÎÎñ×°±¸)", id = { 0, 0, 101, 10, 0, 0, 0 } },
        { name = "YÓn NguyÖt Phñ (ÈÎÎñ×°±¸)", id = { 0, 0, 102, 10, 0, 0, 0 } },
    },
    [2] = { { name = "Tru Tiªn KiÕm (ÈÎÎñ×°±¸)", id = { 0, 0, 103, 10, 0, 0, 0 } } },
    [3] = { { name = "PhÇn Thiªn ViÖt (ÈÎÎñ×°±¸)", id = { 0, 0, 104, 10, 0, 0, 0 } } },
}
gItemName = "Tói quµ Vò khİ Hoµng Kim"

function main(nLevel, nTime, nTNpcIdx, itemID)
    if (FindAValidItemID(itemID) <= 0) then
        InfoBox("Kh«ng cã vËt phÈm nµy hoÆc vËt phÈm ®· hÕt h¹n!")
        return
    end

    if (IsHaveSpaceForTreasure(1) == 0) then
        InfoBox("Hµnh trang kh«ng cã ®ñ 1 « trèng.")
        return
    end

    local nType = GetPlayerType() + 1
    local item = {}
    if (nType == 1) then
        SetTask(140, itemID)
        Say("H·y chän lo¹i vËt phÈm ng­¬i muèn nhËn: ", 2, tblItem[nType][1].name .. "/YesItem", tblItem[nType][2].name .. "/YesItem")
    else
        DelItemByID(itemID)
        item = tblItem[nType][1].id
        AddNormalItemBind(item[1], item[2], item[3], item[4], item[5], item[6], item[7])
        Msg2Player("Ngµi më " .. gItemName .. ", nhËn" .. tblItem[nType][1].name .. ".")
        WriteLog("[KhuyÕn m¹i n¹p thÎ][NhËn ®­îc]:" .. tblItem[nType][1].name)
    end
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

    local nType = GetPlayerType() + 1
    local item = {}
    DelItemByID(itemID)
    item = tblItem[nType][nIndex].id
    AddNormalItemBind(item[1], item[2], item[3], item[4], item[5], item[6], item[7])
    Msg2Player("Ngµi më " .. gItemName .. ", nhËn" .. tblItem[nType][nIndex].name .. ".")
    WriteLog("[KhuyÕn m¹i n¹p thÎ][NhËn ®­îc]:" .. tblItem[nType][nIndex].name)
end

function no()
    CloseDialog()
end
