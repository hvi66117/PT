function main(sel)
    local k = math.random(1, 10)
    if (k >= 1) and (k <= 5) then
        AddNormalItem(3, 62, 0, 0, 0, 0)
        Msg2Player("NhËn ®­îc 1 Thæ Linh phï.")
    elseif (k >= 6) and (k <= 8) then
        AddNormalItem(3, 63, 0, 0, 0, 0)
        Msg2Player("NhËn ®­îc 1 Thñy Linh phï.")
    elseif (k >= 9) and (k <= 10) then
        AddNormalItem(3, 64, 0, 0, 0, 0)
        Msg2Player("NhËn ®­îc 1 Háa Linh phï.")
    end ;

    AddNormalItem(6, 0, 1, 1, 0, 0)
    AddNormalItem(6, 0, 2, 1, 0, 0)
    AddNormalItem(6, 0, 3, 1, 0, 0)
    AddNormalItem(6, 0, 4, 1, 0, 0)
    Msg2Player("NhËn ®­îc 1 hép Th¸i Thanh ®¬n.")

    AddNormalItem(3, 81, 0, 0, 0, 0)
    Msg2Player("NhËn ®­îc mét qu¶ Nh©n s©m.")

    local p = math.random(1, 100)
    if (p == 1) then
        AddNormalItem(3, 41, 0, 0, 0, 0)
        Msg2Player("NhËn ®­îc 1 Lam B¶o th¹ch.")
    elseif (p == 2) then
        AddNormalItem(3, 79, 0, 0, 0, 0)
        Msg2Player("NhËn ®­îc 1 Hång B¶o th¹ch.")
    end ;
end;
