function main()
    local f = GetCompeteFlag()
    if (f == 1) then
        Msg2Player("Tr¹ng th¸i chiÕn ®Êu kh«ng thÓ sö dông BiÕn Th©n Phï.")
    else
        MsgBox(13238, "fs", "no")
    end
end;

function fs()
    local i = math.random(0, 9)
    if (GetMorphType() == 364) then
        Msg2Player("ë tr¹ng th¸i nµy kh«ng thÓ sö dông biÕn th©n phï.")
        AddNormalItem(6, 1, 32, 1, 0, 0)
    elseif (i == 0) then
        PolyMorph(99, 0, 2, 10, 3600)
    elseif (i >= 1) then
        PolyMorph(84, 0, 2, 10, 3600)
    end ;
    CloseDialog()
end;

function no()
    CloseDialog()
    AddNormalItem(6, 1, 32, 1, 0, 0)
end;
