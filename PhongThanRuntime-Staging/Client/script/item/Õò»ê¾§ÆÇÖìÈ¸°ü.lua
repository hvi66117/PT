function main(nLevel, nTime, nTNpcIdx, itemID)
    if (FindAValidItemID(itemID) <= 0) then
        InfoBox("Kh«ng cã vËt phÈm nµy hoÆc vËt phÈm ®· hÕt h¹n!")
        return
    end

    if (IsHaveSpaceForTreasure(3) == 0) then
        InfoBox("Hµnh trang kh«ng cã ®ñ 2 « trèng.")
        return
    end

    DelItemByID(itemID)
    AddNormalItemBind(3, 1237, 0, 0, 0, 0, 1)
    AddNormalItemBind(8, 1732, 2, 0, 0, 0, 1)
    Msg2Player("Ngµi më lÔ bao, nhËn ®­îc 1 c¸i TrÊn Hån Tinh Ph¸ch, 1 c¸i Linh sñng Chu T­íc biÕn th©n phï.")
end

function no()
    CloseDialog()
end
