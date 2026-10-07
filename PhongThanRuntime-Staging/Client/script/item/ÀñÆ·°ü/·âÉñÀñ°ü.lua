function main()
    if (HaveNormalItem(6, 1, 875, 0) <= 0) then
        return
    end

    if (IsHaveSpaceForTreasure(5) == 0) then
        Talk(1, "no", "Hµnh trang kh«ng ®ñ chç trèng, h·y chõa trèng 5 «.")
    else
        DelNormalItem(6, 1, 875, 0)

        AddNormalItem(3, 90, 0, 0, 0, 0)
        AddNormalItem(8, 193, 5, 0, 0, 0)
        AddNormalItem(3, 100, 0, 0, 0, 1)
        AddNormalItem(3, 1149, 0, 0, 0, 0)
        AddNormalItem(3, 374, 0, 0, 0, 0)

        TopMessage("B¹n nhËn ®­îc mãn quµ hËu hÜnh")
        Msg2Player("B¹n më LÔ bao Phong ThÇn nhËn ®­îc mãn quµ hËu hÜnh!")
    end

end

function no()
    CloseDialog()
end
