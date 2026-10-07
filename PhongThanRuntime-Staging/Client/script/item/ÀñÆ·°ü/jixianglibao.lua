function main()
    if (GetLevel() >= 10) then
        Earn(5000)
        local i = math.random(1, 5)
        local n = GetPlayerType()
        if (n == 0) then
            AddNormalItem(0, 10, 0, 1, 0, 0)
            if (i == 1) then
                AddNormalItem(0, 2, 9, 2, 0, 0)
            elseif (i == 2) then
                AddNormalItem(0, 5, 9, 2, 0, 0)
            elseif (i == 3) then
                AddNormalItem(0, 6, 9, 2, 0, 0)
            elseif (i == 4) then
                AddNormalItem(0, 7, 9, 2, 0, 0)
            else
                AddNormalItem(0, 9, 9, 2, 0, 0)
            end ;
        elseif (n == 1) then
            AddNormalItem(0, 10, 1, 1, 0, 0)
            if (i == 1) then
                AddNormalItem(0, 2, 10, 2, 0, 0)
            elseif (i == 2) then
                AddNormalItem(0, 5, 10, 2, 0, 0)
            elseif (i == 3) then
                AddNormalItem(0, 6, 10, 2, 0, 0)
            elseif (i == 4) then
                AddNormalItem(0, 7, 10, 2, 0, 0)
            else
                AddNormalItem(0, 9, 10, 2, 0, 0)
            end ;
        else
            AddNormalItem(0, 10, 2, 1, 0, 0)
            if (i == 1) then
                AddNormalItem(0, 2, 11, 2, 0, 0)
            elseif (i == 2) then
                AddNormalItem(0, 5, 11, 2, 0, 0)
            elseif (i == 3) then
                AddNormalItem(0, 6, 11, 2, 0, 0)
            elseif (i == 4) then
                AddNormalItem(0, 7, 11, 2, 0, 0)
            else
                AddNormalItem(0, 9, 11, 2, 0, 0)
            end ;
        end ;
        AddNormalItem(8, 11, 0, 1, 0, 0)
        for i = 1, 10 do
            AddNormalItemPile(5, 0, 0, 0, 0, 0)
        end ;
        local m = math.random(1, 200)
        if (m == 1) then
            if (n == 0) then
                AddNormalItem(0, 10, 24, 2, 0, 0)
                AddGlobalCountNews("<color=green>" .. GetName() .. "<c> Më <color=yellow>LÔ bao C¸t T­êng<c> nhËn ®­îc <color=yellow>Tr¸c Lang<c>! Chóc mõng", "no")
            elseif (n == 1) then
                AddNormalItem(0, 10, 25, 2, 0, 0)
                AddGlobalCountNews("<color=green>" .. GetName() .. "<c> Më <color=yellow>LÔ bao C¸t T­êng<c> nhËn ®­îc <color=yellow>Tr¸c ¦ng<c>! Chóc mõng", "no")
            else
                AddNormalItem(0, 10, 26, 2, 0, 0)
                AddGlobalCountNews("<color=green>" .. GetName() .. "<c> Më <color=yellow>LÔ bao C¸t T­êng<c> nhËn ®­îc <color=yellow>Tr¸c ®iÖp<c>! Chóc mõng", "no")
            end ;
        end ;
        local a = math.random(1, 10000)
        if (a == 1) then
            AddNormalItem(8, 294, 2, 0, 0, 0)
            AddGlobalCountNews("<color=green>" .. GetName() .. "<c> më <color=yellow>LÔ bao C¸t T­êng<c> bÊt ngê nhËn ®­îc <color=yellow>1 viªn Cöu chuyÓn Cµn Kh«n ®¬n<c>!", "no")
        end ;
    else
        Talk(1, "no", "Xin lçi, b¹n ph¶i tõ cÊp 10 trë lªn míi më ®­îc <color=yellow>LÔ bao C¸t T­êng<c>")
        AddNormalItem(6, 1, 267, 0, 0, 1)
    end ;
end;

function no()
    CloseDialog()
end
