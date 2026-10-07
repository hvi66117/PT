function main()
    local name = GetName()
    local moneyrate = math.random(1, 2)
    local money = 0
    local losttime = GetTask(932)
    local sexal = GetSex()
    local plr = GetPlayerType()
    if (moneyrate == 1) then
        money = 2000
    else
        money = 20000
    end
    Earn(money)
    local horserate = math.random(1, 100)
    local swordrate = math.random(1, 10000) + losttime * 5
    if (horserate == 1) then
        AddNormalItem(0, 10, 18 + plr, 1, 0, 0)
        TopMessage("B¹n nhËn ®­îc <c=yel>C¸t T­êng thó<c> vµ" .. money .. "tiÒn l× x×")
        AddGlobalCountNews("<c=g>" .. name .. "<c> t¹i <c=g>" .. name .. "<c>.", 20)
    elseif (swordrate >= 9980) then
        SetTask(932, 0)
        local k = math.random(1, 10)
        if (k <= 3) then
            AddNormalItem(0, 0, 5 + plr, 3, 1, 0)
            TopMessage("B¹n nhËn ®­îc <c=yel>Vò khÝ Hoµng Kim cÊp 30<c> vµ" .. money .. "tiÒn l× x×")
            if (sexal == 0) then
                AddGlobalCountNews("<c=g>" .. name .. "<c> më Quµ xu©n nhËn ®­îc <c=blue>Vò khÝ Hoµng Kim cÊp 30<c>! Xin chóc mõng!", 20)
            else
                AddGlobalCountNews("<c=g>" .. name .. "<c> më Quµ xu©n nhËn ®­îc <c=blue>Vò khÝ Hoµng Kim cÊp 30<c>! Xin chóc mõng!", 20)
            end
        elseif (k <= 6) then
            AddNormalItem(0, 0, 5 + plr, 4, 0, 0)
            if (sexal == 0) then
                AddGlobalCountNews("<c=g>" .. name .. "<c> më Quµ xu©n nhËn ®­îc <c=yel>Vò khÝ Hoµng Kim cÊp 40<c>. Xin chóc mõng!", 20)
            else
                AddGlobalCountNews("<c=g>" .. name .. "<c> më Quµ xu©n nhËn ®­îc <c=yel>Vò khÝ Hoµng Kim cÊp 40<c>. Xin chóc mõng!", 20)
            end
            TopMessage("B¹n nhËn ®­îc <c=yel>Vò khÝ Hoµng Kim cÊp 40<c> vµ" .. money .. "tiÒn l× x×")
        elseif (k <= 9) then
            AddNormalItem(0, 0, 5 + plr, 5, 0, 0)
            if (sexal == 0) then
                AddGlobalCountNews("<c=g>" .. name .. "<c> më Quµ xu©n nhËn ®­îc <c=yel>Vò khÝ Hoµng Kim cÊp 50<c>. Xin chóc mõng!", 20)
            else
                AddGlobalCountNews("<c=g>" .. name .. "<c> më Quµ xu©n nhËn ®­îc <c=yel>Vò khÝ Hoµng Kim cÊp 50<c>. Xin chóc mõng!", 20)
            end
            TopMessage("B¹n nhËn ®­îc <c=yel>Vò khÝ Hoµng Kim cÊp 50<c> vµ" .. money .. "tiÒn l× x×")
        else
            AddNormalItem(0, 0, 5 + plr, 6, 0, 0)
            if (sexal == 0) then
                AddGlobalCountNews("<c=g>" .. name .. "<c> më Quµ xu©n nhËn ®­îc<c=yel>Vò khÝ Hoµng Kim cÊp 60<c>. Xin chóc mõng!", 20)
            else
                AddGlobalCountNews("<c=g>" .. name .. "<c> më Quµ xu©n nhËn ®­îc<c=yel>Vò khÝ Hoµng Kim cÊp 60<c>. Xin chóc mõng!", 20)
            end
            TopMessage("B¹n nhËn ®­îc <c=yel>Vò khÝ Hoµng Kim cÊp 60<c> vµ" .. money .. "tiÒn l× x×")
        end
    else
        SetTask(932, losttime + 1)
        AddNormalItemPile(6, 0, 184, 1, 0, 0)
        TopMessage("B¹n nhËn ®­îc <c=yel>Ph¸o hoa<c> vµ" .. money .. "tiÒn l× x×")
    end
end

function no()
    CloseDialog()
end
