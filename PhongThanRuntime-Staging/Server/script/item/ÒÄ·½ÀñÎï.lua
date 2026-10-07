function main()
    CloseDialog()
    if (DelNormalItem(6, 1, 789, 0) == 0) then
        DelNormalItemInQuick(6, 1, 789, 0)
    end
    local r = math.random(1, 100)

    if (r <= 65) then
        local key = math.random(5, 9)
        local ty = GetPlayerType()

        if (key == 8) then
            key = 2
        end

        AddBlueEquip(0, key, 18 + ty, 1, 0, 0, 1)
        Msg2Player("NhËn ®­îc 1 trang bÞ xanh.")
    else
        if (math.random(1, 2) == 1) then
            AddNormalItemPile(8, 961, 0, 0, 0, 0)
            Msg2Player("NhËn ®­îc 1 *V­ît Vò M«n*")
        else
            AddNormalItemPile(8, 962, 0, 0, 0, 0)
            Msg2Player("NhËn ®­îc 1 *Canh B¸ch Bæ*")
        end
    end
end;

function no()
    CloseDialog()
end;
