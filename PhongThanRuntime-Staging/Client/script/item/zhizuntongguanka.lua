--description: ÖÁ×ðÍ¨¹Ø¿¨
--author: lilingxu
--date: 2006/4/19
--modify: lilingxu

function main()


    local k = random(1, 3)
    if (k < 2) then
        AddNormalItemPile(8, 266, 2, 0, 0, 1)
        Msg2Player("B¹n nhËn ®­îc Hoa Thanh lé!")
    else
        AddNormalItemPile(8, 206, 5, 0, 0, 1)
        Msg2Player("B¹n nhËn ®­îc Thiªn Tiªn Thñy!")
    end

    local t = random(1, 4)
    if (t < 2) then
        AddNormalItemPile(8, 257, 2, 0, 0, 1)
        Msg2Player("B¹n nhËn ®­îc Tö Kim Hå l«!")
    elseif (t < 3) then
        AddNormalItemPile(8, 138, 2, 0, 0, 1)
        Msg2Player("B¹n nhËn ®­îc Th­ëng Kim bµi!")
    else
        AddNormalItemPile(8, 137, 2, 0, 0, 1)
        Msg2Player("B¹n nhËn ®­îc Tói hµng!")

    end

    DelNormalItem(6, 1, 265, 0)
    CloseDialog()

end;

function no()
    CloseDialog()
end;
