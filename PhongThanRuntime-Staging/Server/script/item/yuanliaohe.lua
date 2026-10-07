function main()

    local k = math.random(1, 100)
    if (k >= 1 and k <= 30) then
        AddNormalItemPile(3, 314, 0, 0, 0, 0)
        Msg2Player("B¹n nhËn ®­îc 1 NÕp")
        TopMessage("B¹n nhËn ®­îc 1 NÕp")
    elseif (k >= 31 and k <= 60) then
        AddNormalItemPile(3, 315, 0, 0, 0, 0)
        Msg2Player("B¹n nhËn ®­îc 1 §Ëu xanh")
        TopMessage("B¹n nhËn ®­îc 1 §Ëu xanh")
    elseif (k >= 61 and k <= 90) then
        AddNormalItemPile(3, 316, 0, 0, 0, 0)
        Msg2Player("B¹n nhËn ®­îc thŞt n¹c")
        TopMessage("B¹n nhËn ®­îc thŞt n¹c")
    else
        Msg2Player("VËn khİ cña b¹n kh«ng tèt! Hép quµ nµy trèng rçng!")
        TopMessage("VËn khİ cña b¹n kh«ng tèt! Hép quµ nµy trèng rçng!")
    end
    DelNormalItem(6, 1, 432, 0)
end
