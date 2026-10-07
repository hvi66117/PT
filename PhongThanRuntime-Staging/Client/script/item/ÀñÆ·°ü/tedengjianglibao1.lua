function main()
    local n = GetPlayerType()
    if (n == 0) then
        AddNormalItem(0, 2, 9, 8, 0, 0)
        AddNormalItem(0, 5, 9, 8, 0, 0)
        AddNormalItem(0, 6, 9, 8, 0, 0)
        AddNormalItem(0, 7, 9, 8, 0, 0)
        AddNormalItem(0, 9, 9, 8, 0, 0)
        AddNormalItem(0, 0, 16, 1, 0, 0)
        Msg2Player("B¹n nhËn ®­îc bé Lôc trang Khai Thiªn!")
        Msg2Player("B¹n nhËn ®­îc 1 thanh vò khÝ cÊp 75--B¹ch §iªu")
    elseif (n == 1) then
        AddNormalItem(0, 2, 10, 8, 0, 0)
        AddNormalItem(0, 5, 10, 8, 0, 0)
        AddNormalItem(0, 6, 10, 8, 0, 0)
        AddNormalItem(0, 7, 10, 8, 0, 0)
        AddNormalItem(0, 9, 10, 8, 0, 0)
        AddNormalItem(0, 0, 19, 1, 0, 0)
        Msg2Player("B¹n nhËn ®­îc bé Lôc trang Th«ng Thiªn!")
        Msg2Player("B¹n nhËn ®­îc 1 thanh vò khÝ cÊp 75--Nh©n Gian")
    else
        AddNormalItem(0, 2, 11, 8, 0, 0)
        AddNormalItem(0, 5, 11, 8, 0, 0)
        AddNormalItem(0, 6, 11, 8, 0, 0)
        AddNormalItem(0, 7, 11, 8, 0, 0)
        AddNormalItem(0, 9, 11, 8, 0, 0)
        AddNormalItem(0, 0, 22, 1, 0, 0)
        Msg2Player("B¹n nhËn ®­îc bé Lôc trang Lam §iªu!")
        Msg2Player("B¹n nhËn ®­îc 1 thanh vò khÝ cÊp 75--NguyÖt ¶nh")
    end ;
    AddNormalItem(8, 294, 2, 0, 0, 0)
    Msg2Player("B¹n nhËn ®­îc 1 Cöu chuyÓn Cµn Kh«n ®¬n")
end

function no()
    CloseDialog()
end
