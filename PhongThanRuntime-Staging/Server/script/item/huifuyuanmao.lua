function main()
    local i = HaveIBBuff(180)
    local j = HaveIBBuff(181)
    local k = HaveIBBuff(182)
    if (GetMorphType() == -1) then
        AddNormalItem(6, 1, 175, 1, 0, 0)
        Msg2Player("B¹n kh«ng thÓ biÕn thµnh vËt kh¸c, kh«ng cÇn sö dông vËt phÈm nµy!")
    else
        if (i ~= 0) or (j ~= 0) or (k ~= 0) then
            Talk(1, "no", 13194)
        else
            esc()
        end
    end ;
end;

function esc()

    local w, x, y = GetWorldPos()
    if (GetMorphType() == 364) or (GetMorphType() == 420) or (GetMorphType() == 419) or (w == 86) then

        Msg2Player("ë tr¹ng th¸i nµy kh«ng thÓ sö dông biÕn th©n phï.")
        AddNormalItem(6, 1, 175, 1, 0, 0)
    else
        PolyMorph(-1, 0, 2, 10, 1800)
    end ;
    CloseDialog()
end;

function no()
    CloseDialog()
end;
