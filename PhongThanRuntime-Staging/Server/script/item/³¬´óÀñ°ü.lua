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
        AddNormalItem(3, 100, 0, 0, 0, 0)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc T­íng Qu©n LÖnh")
        AddGlobalCountNews("<c=g>" .. GetName() .. "<c> më <c=g>Tói siªu cÊp<c> may m¾n nhËn ®­îc 1 <c=r>T­íng Qu©n LÖnh<c>, xin chóc mõng!", 20)
    elseif (i <= 50 and i > 10) then
        AddNormalItem(8, 252, 0, 0, 0, 0)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc NhËt NguyÖt §¬n")
        AddGlobalCountNews("<c=g>" .. GetName() .. "<c> më <c=g>Tói siªu cÊp<c> may m¾n nhËn ®­îc 1 <c=r>NhËt NguyÖt §¬n<c>, xin chóc mõng!", 20)
    elseif (i > 50 and i <= 70) then
        Earn(4000000)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc 4000000 l­îng")
        AddGlobalCountNews("<c=g>" .. GetName() .. "<c> më <c=g>Tói siªu cÊp<c> may m¾n nhËn ®­îc <c=r>4000000<c> l­îng, xin chóc mõng!", 20)
    else
        AddNormalItem(8, 288, 2, 0, 0, 0)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc tói ThÊt Qu¶i")
        AddGlobalCountNews("<c=g>" .. GetName() .. "<c> më <c=g>Tói siªu cÊp<c> may m¾n nhËn ®­îc <c=r>tói ThÊt Qu¶i<c>, xin chóc mõng!", 20)
    end
    DelNormalItem(6, 1, 774, 0)
end

function no()
    CloseDialog()
end
