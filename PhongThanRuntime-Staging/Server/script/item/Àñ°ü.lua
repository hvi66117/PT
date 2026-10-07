function GetPlayerTaskState()
    return 0, 0
end

function main()
    local i = math.random(1, 100)
    if (IsHaveSpaceForTreasure(1) == 0) then
        Msg2Player("Kh«ng ®ñ chç trèng chøa vËt phÈm!")
        return
    end
    if (i <= 5) then
        AddNormalItem(3, 41, 0, 0, 0, 0)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc 1 Lam B¶o Th¹ch")
    elseif (i <= 50 and i > 5) then
        AddNormalItem(8, 383, 3, 0, 0, 0)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc 1 T¸ Thanh Lé (Nh­ ý)")
    elseif (i > 50) then
        AddNormalItem(8, 384, 4, 0, 0, 0)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc 1 Thñy Ch©n KhÝ (Nh­ ý)")
    end
    DelNormalItem(6, 1, 772, 0)
end

function no()
    CloseDialog()
end
