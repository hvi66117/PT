function main(sel)
    local k = math.random(1, 5)
    if (k == 1) then
        for a = 1, 10 do
            AddNormalItem(3, 70, 0, 1, 0, 0)
        end ;
    elseif (k == 2) then
        local i = math.random(1, 2)
        if (i == 1) then
            for a = 1, 10 do
                AddNormalItem(3, 71, 0, 1, 0, 0)
            end ;
        elseif (i == 2) then
            for b = 1, 10 do
                AddNormalItem(3, 72, 0, 1, 0, 0)
            end ;
        end ;
    elseif (k == 3) then
        AddNormalItem(3, 41, 0, 1, 0, 0)
    elseif (k == 4) then
        AddEventItem(48)
    elseif (k == 5) then
        AddNormalItem(1, 6, 0, 1, 1, 0)
    end ;
end;
