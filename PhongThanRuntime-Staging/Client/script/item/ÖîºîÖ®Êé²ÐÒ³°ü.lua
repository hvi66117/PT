function main(nLevel, nTime, nTNpcIdx, itemID)
    if (FindAValidItemID(itemID) <= 0) then
        InfoBox("Kh«ng cã vËt phÈm nµy hoÆc vËt phÈm ®· hÕt h¹n!")
        return
    end

    if (IsHaveSpaceForTreasure(2) == 0) then
        InfoBox("Hµnh trang kh«ng cã ®ñ 1 « trèng.")
        return
    end

    DelItemByID(itemID)
    AddNormalItem(8, 1422, 5, 0, 0, 0)
    Msg2Player("Ngµi më S¸ch Ch­ HÇu (Tµn trang)°ü, nhËn ®­îc 1 c¸i S¸ch Ch­ HÇu (Tµn trang).")
end
function no()
    CloseDialog()
end
