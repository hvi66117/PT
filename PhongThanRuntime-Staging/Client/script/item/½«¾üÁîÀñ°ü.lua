function main(nLevel, nTime, nTNpcIdx, itemID)
    if (FindAValidItemID(itemID) <= 0) then
        InfoBox("Kh«ng cã vËt phÈm nµy hoÆc vËt phÈm ®· hÕt h¹n!")
        return
    end

    DelItemByID(itemID)
    for i = 1, 10 do
        AddNormalItemPile(3, 100, 0, 0, 0, 0)
    end
    Msg2Player("Ngµi nhËn ®­îc 10 c¸i T­íng Qu©n LÖnh.")
    WriteLog("[KhuyÕn m¹i n¹p thÎ][Më][T­íng Qu©n LÖnhÀñ°ü]")
end

function no()
    CloseDialog()
end
