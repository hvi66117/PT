function main()
    if (GetLevel() >= 60) then
        Earn(100000)
        local i = math.random(1, 5)
        local n = GetPlayerType()
        if (n == 0) then
            AddNormalItem(0, 0, 28, 6, 0, 1)
            if (i == 1) then
                AddNormalItem(0, 2, 9, 6, 0, 0)
            elseif (i == 2) then
                AddNormalItem(0, 5, 9, 6, 0, 0)
            elseif (i == 3) then
                AddNormalItem(0, 6, 9, 6, 0, 0)
            elseif (i == 4) then
                AddNormalItem(0, 7, 9, 6, 0, 0)
            else
                AddNormalItem(0, 9, 9, 6, 0, 0)
            end ;
        elseif (n == 1) then
            AddNormalItem(0, 0, 29, 6, 0, 1)
            if (i == 1) then
                AddNormalItem(0, 2, 10, 6, 0, 0)
            elseif (i == 2) then
                AddNormalItem(0, 5, 10, 6, 0, 0)
            elseif (i == 3) then
                AddNormalItem(0, 6, 10, 6, 0, 0)
            elseif (i == 4) then
                AddNormalItem(0, 7, 10, 6, 0, 0)
            else
                AddNormalItem(0, 9, 10, 6, 0, 0)
            end ;
        else
            AddNormalItem(0, 0, 30, 6, 0, 1)
            if (i == 1) then
                AddNormalItem(0, 2, 11, 6, 0, 0)
            elseif (i == 2) then
                AddNormalItem(0, 5, 11, 6, 0, 0)
            elseif (i == 3) then
                AddNormalItem(0, 6, 11, 6, 0, 0)
            elseif (i == 4) then
                AddNormalItem(0, 7, 11, 6, 0, 0)
            else
                AddNormalItem(0, 9, 11, 6, 0, 0)
            end ;
        end ;
        AddNormalItem(8, 229, 0, 0, 0, 1)
        AddNormalItem(8, 270, 2, 0, 0, 1)
        local m = math.random(1, 20000)
        if (m == 1) then
            AddNormalItem(8, 283, 2, 0, 0, 1)
            AddGlobalCountNews("<color=green>" .. GetName() .. "<c> më <color=yellow>LÔ bao Phong ThÇn<c> bÊt ngê nhËn ®­îc <color=yellow>Vò khÝ cao cÊp (nguyªn)<c>!", "no")
        elseif (m == 2) then
            AddNormalItem(8, 284, 2, 0, 0, 1)
            AddGlobalCountNews("<color=green>" .. GetName() .. "<c> më <color=yellow>LÔ bao Phong ThÇn<c> bÊt ngê nhËn ®­îc <color=yellow>Trang bÞ cao cÊp (nguyªn)<c>!", "no")
        end ;
    else
        Talk(1, "no", "Xin lçi, b¹n ph¶i tõ cÊp 60 trë lªn míi më ®­îc <color=yellow>LÔ bao Phong ThÇn<c>")
        AddNormalItem(6, 1, 269, 0, 0, 1)
    end ;
end

function no()
    CloseDialog()
end
