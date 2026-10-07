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

    if (DelNormalItem(6, 1, 1512, 1) > 0) then
        for i = 1, 10 do
            AddNormalItemBind(6, 1, 1062, 1, 0, 0, 1)
        end
        AddNormalItemBind(3, 100, 0, 0, 0, 0, 1)
        Msg2Player("Ngµi më Quµ dµnh riªng V¹n Tiªn TrËn, nhËn ®­îc °ó¶¨µÄ<c=g>Kinh NghiÖm §¬nx10, T­íng Qu©n LÖnhx1<c>.")
        WriteLog("[Ho¹t ®éng Boss V¹n Tiªn TrËn][´ò¿ªQuµ dµnh riªng V¹n Tiªn TrËn]")
    else
        Talk(1, "no", "Ð¡Ó¢ÐÛ, LÔ bao cña ngµi ®©u?")
        return
    end
end

function no()
    CloseDialog()
end
