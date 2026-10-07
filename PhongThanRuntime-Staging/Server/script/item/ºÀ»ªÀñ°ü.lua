function GetPlayerTaskState()
    return 0, 0
end

function main()
    local i = math.random(1, 100)
    if (IsHaveSpaceForTreasure(1) == 0) then
        Msg2Player("Kh«ng ®ñ chç trèng chøa vËt phÈm!")
        return
    end
    if (i <= 50) then
        AddNormalItem(0, 12, 0, 2, 0, 0)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc 1 Thanh Linh Ngäc Béi cÊp 2")
        AddGlobalCountNews("<c=g>" .. GetName() .. "<c> më <c=g>tói Hµo Hoa<c> may m¾n nhËn ®­îc 1 <c=r>Thanh Linh Ngäc Béi cÊp 2<c>, xin chóc mõng!", 20)
    elseif (i <= 95 and i > 50) then
        AddNormalItem(3, 554, 0, 0, 0, 0)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc Néi §¬n (thÊp)")
        AddGlobalCountNews("<c=g>" .. GetName() .. "<c> më <c=g>tói Hµo Hoa<c> may m¾n nhËn ®­îc 1 <c=r>Néi §¬n (thÊp)<c>, xin chóc mõng!", 20)
    else
        AddNormalItem(3, 555, 0, 0, 0, 0)
        Msg2Player("Chóc mõng b¹n nhËn ®­îc 1 Néi §¬n (trung)")
        AddGlobalCountNews("<c=g>" .. GetName() .. "<c> më <c=g>tói Hµo Hoa<c> may m¾n nhËn ®­îc 1 <c=r>Néi §¬n (trung)<c>, xin chóc mõng!", 20)
    end
    DelNormalItem(6, 1, 775, 0)
end

function no()
    CloseDialog()
end
