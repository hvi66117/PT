function main()
    Earn(2000)
    local i = math.random(1, 6)
    if (i == 1) then
        AddNormalItem(0, 4, 0, 0, 0, 1)
    elseif (i == 2) then
        AddNormalItem(0, 4, 1, 0, 0, 1)
    elseif (i == 3) then
        AddNormalItem(0, 4, 2, 0, 0, 1)
    elseif (i == 4) then
        AddNormalItem(0, 4, 3, 0, 0, 1)
    elseif (i == 5) then
        AddNormalItem(0, 4, 4, 0, 0, 1)
    else
        AddNormalItem(0, 4, 5, 0, 0, 1)
    end ;
    local n = GetPlayerType()
    if (n == 0) then
        AddNormalItem(0, 5, 0, 1, 0, 1)
        AddNormalItem(0, 6, 0, 1, 0, 1)
        AddNormalItem(0, 7, 0, 1, 0, 1)
    elseif (n == 1) then
        AddNormalItem(0, 5, 1, 1, 0, 1)
        AddNormalItem(0, 6, 1, 1, 0, 1)
        AddNormalItem(0, 7, 1, 1, 0, 1)
    else
        AddNormalItem(0, 5, 2, 1, 0, 1)
        AddNormalItem(0, 6, 2, 1, 0, 1)
        AddNormalItem(0, 7, 2, 1, 0, 1)
    end ;
    local m = math.random(1, 20)
    if (m == 1) then
        if (n == 0) then
            AddNormalItem(0, 10, 24, 1, 0, 0)
            AddGlobalCountNews("<color=green>" .. GetName() .. "<c> Më <c=yel>LÔ bao may m¾n<c> nhËn ®­îc <c=yel>Tr¸c M·<c>! Chóc mõng.", "no")
        elseif (n == 1) then
            AddNormalItem(0, 10, 25, 1, 0, 0)
            AddGlobalCountNews("<color=green>" .. GetName() .. "<c> Më <c=yel>LÔ bao may m¾n<c> nhËn ®­îc <color=yellow>Tr¸c T­íc<c>! Chóc mõng.", "no")
        else
            AddNormalItem(0, 10, 26, 1, 0, 0)
            AddGlobalCountNews("<color=green>" .. GetName() .. "<c> Më <c=yel>LÔ bao may m¾n<c> nhËn ®­îc <color=yellow>Tr¸c ®iÖp<c>! Chóc mõng.", "no")
        end ;
    end ;
    AddNormalItem(8, 296, 2, 0, 0, 1)
end

function no()
    CloseDialog()
end
