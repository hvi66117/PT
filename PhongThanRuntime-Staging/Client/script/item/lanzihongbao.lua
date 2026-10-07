function main(sel)
    local lr = math.random(1, 100)
    if (lr <= 50) then
        AddNormalItemPile(3, 78, 0, 0, 0, 0)
        TopMessage("B¹n nhËn ®­îc <c=g>1 m¶nh Lam Thñy Tinh<c>")
        Msg2Player("B¹n nhËn ®­îc 1 m¶nh Lam Thñy Tinh!")
    elseif (lr <= 95) then
        AddNormalItemPile(3, 80, 0, 0, 0, 0)
        TopMessage("B¹n nhËn ®­îc <c=g>1 Lam Thñy Tinh<c>")
        Msg2Player("B¹n nhËn ®­îc 1 Lam Thñy Tinh!")
    else
        AddNormalItemPile(3, 41, 0, 0, 0, 0)
        TopMessage("B¹n nhËn ®­îc <c=g>1 Lam B¶o Th¹ch<c>")
        Msg2Player("B¹n nhËn ®­îc 1 Lam B¶o Th¹ch!")
        local strMsg = GetName() .. "Lam Bao Lam B¶o Th¹ch"
        WriteLog(strMsg)
        AddGlobalCountNews("<c=g>" .. GetName() .. "<c> më Lam Bao cña LÔ Quan nhËn ®­îc <c=b> Lam B¶o Th¹ch<c>!", 3)
    end
end;
