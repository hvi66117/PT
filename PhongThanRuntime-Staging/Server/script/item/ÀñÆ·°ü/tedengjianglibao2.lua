function main()
    local n = GetPlayerType()
    if (n == 0) then
        AddNormalItem(0, 2, 9, 6, 0, 0)
        AddNormalItem(0, 5, 9, 6, 0, 0)
        AddNormalItem(0, 6, 9, 6, 0, 0)
        AddNormalItem(0, 7, 9, 6, 0, 0)
        AddNormalItem(0, 9, 9, 6, 0, 0)
        AddNormalItem(0, 0, 28, 6, 0, 0)
        Msg2Player("B¹n nhËn ®­îc bé Lôc trang Tinh Cang!")
        Msg2Player("B¹n nhËn ®­îc 1 Vò khÝ Hoµng Kim cÊp 60")
    elseif (n == 1) then
        AddNormalItem(0, 2, 10, 6, 0, 0)
        AddNormalItem(0, 5, 10, 6, 0, 0)
        AddNormalItem(0, 6, 10, 6, 0, 0)
        AddNormalItem(0, 7, 10, 6, 0, 0)
        AddNormalItem(0, 9, 10, 6, 0, 0)
        AddNormalItem(0, 0, 29, 6, 0, 0)
        Msg2Player("B¹n nhËn ®­îc bé Lôc trang Th¸i Êt")
        Msg2Player("B¹n nhËn ®­îc 1 Vò khÝ Hoµng Kim cÊp 60")
    else
        AddNormalItem(0, 2, 11, 6, 0, 0)
        AddNormalItem(0, 5, 11, 6, 0, 0)
        AddNormalItem(0, 6, 11, 6, 0, 0)
        AddNormalItem(0, 7, 11, 6, 0, 0)
        AddNormalItem(0, 9, 11, 6, 0, 0)
        AddNormalItem(0, 0, 30, 6, 0, 0)
        Msg2Player("B¹n nhËn ®­îc bé trang bÞ lôc Gi¸c Thó")
        Msg2Player("B¹n nhËn ®­îc 1 Vò khÝ Hoµng Kim cÊp 60")
    end ;
    AddNormalItem(8, 294, 2, 0, 0, 0)
    Msg2Player("B¹n nhËn ®­îc 1 Cöu chuyÓn Cµn Kh«n ®¬n")
end

function no()
    CloseDialog()
end
