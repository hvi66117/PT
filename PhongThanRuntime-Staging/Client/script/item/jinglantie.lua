function main()
    if (HaveNormalItem(6, 1, 326, 0) <= 0) then
        return
    end

    local nProb = math.random(1, 100)
    if (nProb <= 2) then
        AddNormalItem(3, 100, 0, 0, 0, 0)
        TopMessage("B¹n nhËn ®­îc 1 <c=g>T­íng Qu©n LÖnh<c>")
        Msg2Player("B¹n nhËn ®­îc 1 T­íng Qu©n LÖnh.")
        WriteLog(GetName() .. "§­îc 1 T­íng Qu©n LÖnh.")
        AddGlobalCountNews("<c=g>" .. GetName() .. "<c>Nhê Kim Lang thiÕp, cã ®­îc 1 <c=g>T­íng Qu©n LÖnh<c> ! T×nh kÕt nghÜa huynh ®Ö ®­îc Trêi phï hé!", 3)
    elseif (nProb <= 12) then
        AddNormalItem(3, 41, 0, 0, 0, 0)
        TopMessage("B¹n nhËn ®­îc 1 viªn <c=g>Lam B¶o Th¹ch<c>")
        Msg2Player("B¹n nhËn ®­îc 1 viªn Lam B¶o Th¹ch.")
        WriteLog(GetName() .. " nhËn ®­îc 1 viªn Lam B¶o Th¹ch.")
    elseif (nProb <= 42) then
        AddNormalItem(8, 198, 3, 0, 0, 0)
        TopMessage("Anh hïng nhËn 1 <c=g>T¸ Thanh lé (tiÓu)<c>")
        Msg2Player("Anh hïng nhËn 1 T¸ Thanh lé (tiÓu). ")
        WriteLog(GetName() .. "NhËn 1 T¸ Thanh lé (tiÓu). ")
    elseif (nProb <= 45) then
        EarnBind(5000000)
        TopMessage("Anh hïng nhËn <c=g>500 v¹n l­îng<c>")
        Msg2Player("Anh hïng nhËn 500 v¹n l­îng. ")
        WriteLog(GetName() .. "NhËn 500 v¹n l­îng. ")
        AddGlobalCountNews("<c=g>" .. GetName() .. "<c>Th«ng qua Kim Lan ThiÖp, nhËn <c=g>500 v¹n l­îng<c>! KÕt nghÜa huynh ®Ö ®­îc trêi cao phï hé!", 3)
    elseif (nProb <= 70) then
        AddNormalItem(3, 1149, 0, 0, 0, 0)
        TopMessage("Anh hïng nhËn <c=g>M¶nh Tö Thuû Tinh<c>")
        Msg2Player("Anh hïng nhËn M¶nh Tö Thuû Tinh. ")
        WriteLog(GetName() .. "NhËn M¶nh Tö Thuû Tinh. ")
    else
        AddNormalItem(8, 29, 4, 0, 0, 0)
        TopMessage("Anh hïng nhËn 1 <c=g>Ch©n KhÝ (nhá)<c>")
        Msg2Player("Anh hïng nhËn 1 Ch©n KhÝ (nhá). ")
        WriteLog(GetName() .. "NhËn 1 Ch©n KhÝ (nhá). ")
    end
    DelNormalItem(6, 1, 326, 0)
end

function no()
    CloseDialog()
end
