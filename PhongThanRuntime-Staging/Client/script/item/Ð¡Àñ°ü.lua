function GetPlayerTaskState()
    return 0, 0
end

function main()
    if (IsHaveSpaceForTreasure(1) == 0) then
        Msg2Player("Kh«ng ®ñ chç trèng chøa vËt phÈm!")
        return
    end
    local i = math.random(1, 100)
    if (i <= 80) then
        AddNormalItem(8, 567, 2, 0, 0, 0)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc 1 Nh­ ý Di ngo¹i phï")
    elseif (i <= 90 and i > 80) then
        AddNormalItem(3, 80, 0, 0, 0, 0)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc 1 Lam Thñy tinh")
    elseif (i > 90) then
        Earn(200000)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc 200000 b¹c")
    end
    DelNormalItem(6, 1, 771, 0)
end

function no()
    CloseDialog()
end
