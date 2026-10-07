function main(sel)
    if (GetMorphType() == 367) or (GetMorphType() == 412) then
        AddNormalItem(6, 1, 102, 1, 0, 0)
        Msg2Player("Trong tr¹ng th¸i nµy kh«ng thÓ sö dông Hång bao.")
    else
        local k = math.random(1, 99)
        if (k >= 1) and (k <= 27) then
            local i = math.random(1, 18000)
            Earn(2000 + i)
            Msg2Player("NhËn ®­îc tiÒn th­ëng.")
        elseif (k >= 28) and (k <= 47) then
            AddNormalItem(6, 1, 12, 0, 0, 0)
            Msg2Player("NhËn ®­îc mét l¸ th¨m.")
        elseif (k >= 48) and (k <= 57) then
            for a = 1, 5 do
                AddNormalItem(1, 1, 0, 0, 0, 0)
            end ;
            Msg2Player("NhËn ®­îc 5 Trung Hång ®¬n.")
        elseif (k >= 58) and (k <= 67) then
            for a = 1, 5 do
                AddNormalItem(1, 4, 0, 0, 0, 0)
            end ;
            Msg2Player("NhËn ®­îc 5 Trung Hoµn ®¬n.")
        elseif (k >= 68) and (k <= 77) then
            AddNormalItem(3, 78, 0, 0, 0, 0)
            Msg2Player("NhËn ®­îc 1 m¶nh Lam Thñy tinh.")
        elseif (k >= 78) and (k <= 87) then
            AddNormalItem(3, 77, 0, 0, 0, 0)
            Msg2Player("NhËn ®­îc 1 m¶nh Hång Thñy tinh.")
        elseif (k == 88) and (k <= 97) then
            AddNormalItem(3, 82, 0, 0, 0, 0)
            Msg2Player("NhËn ®­îc 1 Tha S¬n Th¹ch.")
        elseif (k == 98) then
            AddNormalItem(3, 28, 0, 0, 0, 0)
            Msg2Player("NhËn ®­îc 1 Hång Thñy tinh.")
        elseif (k == 99) then
            AddNormalItem(3, 80, 0, 0, 0, 0)
            Msg2Player("NhËn ®­îc 1 Lam Thñy tinh.")


        end ;
    end ;
end;
