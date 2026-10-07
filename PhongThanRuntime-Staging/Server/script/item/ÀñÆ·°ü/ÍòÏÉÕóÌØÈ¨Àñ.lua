function main(nLevel, t, nNpcIdx, nItemId)
    no()
    if (FindAValidItemID(nItemId) <= 0) then
        InfoBox("Kh«ng cã vËt phÈm nµy hoÆc vËt phÈm ®· hÕt h¹n!")
        return
    end
    if (IsHaveSpaceForTreasure(3) <= 0) then
        Talk(1, "no", "Äú±³°üÒÑÂú, xin h·y s¾p xÕp l¹iÁìÈ¡.")
        return
    end

    if (DelNormalItem(6, 1, 1513, 1) > 0) then
        AddNormalItemBind(3, 100, 0, 0, 0, 0, 1)
        AddNormalItemBind(3, 374, 0, 0, 0, 0, 1)
        Msg2Player("Ngµi më Quµ ®Æc biÖt V¹n Tiªn TrËn, nhËn ®­îc °ó¶¨µÄ<c=g>T­íng Qu©n LÖnhx1, Vi Quang Qu¸i Phïx1<c>.")
        WriteLog("[Ho¹t ®éng Boss V¹n Tiªn TrËn][´ò¿ªQuµ ®Æc biÖt V¹n Tiªn TrËn]")
    else
        Talk(1, "no", "Ð¡Ó¢ÐÛ, LÔ bao cña ngµi ®©u?")
        return
    end
end

function no()
    CloseDialog()
end
