function main()
    if (GetLevel() >= 30) then
        Earn(20000)
        local i = math.random(1, 5)
        local n = GetPlayerType()
        if (n == 0) then
            AddNormalItem(0, 0, 28, 3, 0, 1)
            if (i == 1) then
                AddNormalItem(0, 2, 9, 4, 0, 0)
            elseif (i == 2) then
                AddNormalItem(0, 5, 9, 4, 0, 0)
            elseif (i == 3) then
                AddNormalItem(0, 6, 9, 4, 0, 0)
            elseif (i == 4) then
                AddNormalItem(0, 7, 9, 4, 0, 0)
            else
                AddNormalItem(0, 9, 9, 4, 0, 0)
            end ;
        elseif (n == 1) then
            AddNormalItem(0, 0, 29, 3, 0, 1)
            if (i == 1) then
                AddNormalItem(0, 2, 10, 4, 0, 0)
            elseif (i == 2) then
                AddNormalItem(0, 5, 10, 4, 0, 0)
            elseif (i == 3) then
                AddNormalItem(0, 6, 10, 4, 0, 0)
            elseif (i == 4) then
                AddNormalItem(0, 7, 10, 4, 0, 0)
            else
                AddNormalItem(0, 9, 10, 4, 0, 0)
            end ;
        else
            AddNormalItem(0, 0, 30, 3, 0, 1)
            if (i == 1) then
                AddNormalItem(0, 2, 11, 4, 0, 0)
            elseif (i == 2) then
                AddNormalItem(0, 5, 11, 4, 0, 0)
            elseif (i == 3) then
                AddNormalItem(0, 6, 11, 4, 0, 0)
            elseif (i == 4) then
                AddNormalItem(0, 7, 11, 4, 0, 0)
            else
                AddNormalItem(0, 9, 11, 4, 0, 0)
            end ;
        end ;
        AddNormalItem(8, 239, 2, 0, 0, 1)
        AddNormalItem(8, 35, 2, 0, 0, 1)
        AddNormalItem(8, 28, 3, 1, 0, 0)
        AddNormalItem(8, 29, 4, 1, 0, 0)
        local m = math.random(1, 4000)
        if (m == 1) then
            AddNormalItem(8, 189, 2, 0, 0, 1)
            AddGlobalCountNews("<color=green>" .. GetName() .. "<c> më <color=yellow>LÔ bao ThÇn Hùu<c> bÊt ngê nhËn ®­îc <color=yellow>Vò khÝ s¬ cÊp (nguyªn)<c>!", "no")
        elseif (m == 2) then
            AddNormalItem(8, 190, 2, 0, 0, 1)
            AddGlobalCountNews("<color=green>" .. GetName() .. "<c> më <color=yellow>LÔ bao ThÇn Hùu<c> bÊt ngê nhËn ®­îc <color=yellow>Trang bÞ s¬ cÊp (nguyªn)<c>!", "no")
        end ;
    else
        Talk(1, "no", "Xin lçi, b¹n ph¶i tõ cÊp 30 trë lªn míi më ®­îc <color=yellow>LÔ bao ThÇn B¶o<c>")
        AddNormalItem(6, 1, 268, 0, 0, 1)
    end ;
end

function no()
    CloseDialog()
end
