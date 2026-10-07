function GetPlayerTaskState()
    return 0, 0
end

function main()
    local i = math.random(1, 100)
    if (IsHaveSpaceForTreasure(1) == 0) then
        Msg2Player("Kh«ng ®ñ chç trèng chøa vËt phÈm!")
        return
    end
    if (i <= 10) then
        Earn(2000000)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc 2000000 b¹c")
        AddGlobalCountNews("<c=g>" .. GetName() .. "<c> më <c=g>Tói Quµ Lín<c> cña h«n lÔ bÊt ngê nhËn ®­îc <c=r>200 v¹n<c> b¹c, xin chóc mõng!", 20)
    elseif (i <= 50 and i > 10) then
        AddNormalItem(8, 374, 0, 0, 0, 0)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc 1 Dao Tiªn T¸n")
        AddGlobalCountNews("<c=g>" .. GetName() .. "<c> më <c=g>Tói Quµ Lín<c> cña h«n lÔ bÊt ngê nhËn ®­îc 1 <c=r>Dao Tiªn T¸n<c>, xin chóc mõng!", 20)
    elseif (i > 50 and i < 60) then
        AddNormalItem(3, 100, 0, 0, 0, 0)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc 1 T­íng Qu©n LÖnh")
        AddGlobalCountNews("<c=g>" .. GetName() .. "<c> më <c=g>Tói Quµ Lín<c> cña h«n lÔ bÊt ngê nhËn ®­îc 1 <c=r>T­íng Qu©n LÖnh<c>, xin chóc mõng!", 20)
    else
        EarnBind(4000000)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc 400 v¹n b¹c khãa")
        AddGlobalCountNews("<c=g>" .. GetName() .. "<c> më <c=g>Tói Quµ Lín<c> cña h«n lÔ bÊt ngê nhËn ®­îc <c=r>400 v¹n<c> b¹c khãa!", 20)
    end
    DelNormalItem(6, 1, 773, 0)
end

function no()
    CloseDialog()
end
