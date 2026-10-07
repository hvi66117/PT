function main()
    local f = GetCompeteFlag()
    local w, x, y = GetWorldPos()
    if (f == 1) then
        Msg2Player("Tr¹ng th¸i chiÕn ®Êu kh«ng thÓ sö dông BiÕn Th©n Phï.")
    else
        if (GetMorphType() == 364) then
            Msg2Player("ë tr¹ng th¸i nµy kh«ng thÓ sö dông mò Gi¸ng Sinh")
            AddNormalItem(6, 1, 17, 1, 0, 0)
        elseif (w == 71) then
            Msg2Player("Kh«ng thÓ sö dông biÕn th©n phï ë ®©y.")
            AddNormalItem(6, 1, 17, 1, 0, 0)
        else
            PolyMorph(357, 0, 2, 10, 1800)
        end ;
        CloseDialog()
    end
end;

function no()
    AddNormalItem(6, 1, 17, 1, 0, 0)
    CloseDialog()
end;
