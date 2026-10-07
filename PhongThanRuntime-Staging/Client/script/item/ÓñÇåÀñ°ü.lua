function main(nLevel, nTime, nTNpcIdx, itemID)
    if (FindAValidItemID(itemID) <= 0) then
        InfoBox("Kh«ng cã vËt phÈm nµy hoÆc vËt phÈm ®· hÕt h¹n!")
        return
    end

    if (IsHaveSpaceForTreasure(2) == 0) then
        InfoBox("Hµnh trang kh«ng cã ®ñ 1 « trèng.")
        return
    end

    local item = { 20, 21, 22 }
    local name = { "Ngäc Tr¶m t¸n", "Ngäc DiÖm t¸n", "Ngäc Hµn t¸n" }
    local id = math.random(1, 3)
    DelItemByID(itemID)
    AddNormalItem(8, item[id], 0, 0, 0, 0)
    Msg2Player("Ngµi më Ngäc Thanh LÔ Bao, nhËn ®­îc " .. name[id] .. ".")
end
function no()
    CloseDialog()
end
