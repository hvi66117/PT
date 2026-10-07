--description: PolyMorph
--author: yichuan
--date: 2004/11/18

function main(itemID)
    local f = GetCompeteFlag()
    if (f == 1) then
        Msg2Player("Tr¹ng th¸i chiÕn ®Êu kh«ng thÓ sö dông BiÕn Th©n Phï.")
    else
        if (GetMorphType() == 364) or (GetMorphType() == 96) or (GetMorphType() == 420) or (GetMorphType() == 419) then
            Msg2Player("ë tr¹ng th¸i nµy kh«ng thÓ sö dông biÕn th©n phï.")
        else
            PolyMorph(96, 1, 0, -1, 1800, 1, 1)
            CostIBItem(itemID)
        end ;
        CloseDialog()
    end
end;

function no()
    CloseDialog()
end;
