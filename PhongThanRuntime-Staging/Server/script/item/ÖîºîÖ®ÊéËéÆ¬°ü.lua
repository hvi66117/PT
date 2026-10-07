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
    AddNormalItem(8, 193, 5, 0, 0, 0)
    Msg2Player("Ngµi më Tói M¶nh s¸ch Ch­ HÇu, nhËn ®­îc 1 c¸i M¶nh s¸ch Ch­ HÇu.")
end
function no()
    CloseDialog()
end
