require("common.luax")
IsSpecialMorph = COMMON.IsSpecialMorph

function main(itemID)
    if (IsSpecialMorph() == true) then
        Msg2Player("Tr¹ng th¸i nµy kh«ng thÓ sö dông BiÕn Th©n Phï.")
        return
    end
    local f = GetCompeteFlag()
    if (f == 1) then
        Msg2Player("Tr¹ng th¸i chiÕn ®Êu kh«ng thÓ sö dông BiÕn Th©n Phï.")
    else
        if (GetMorphType() == 364) or (GetMorphType() == 17) or (GetMorphType() == 420) or (GetMorphType() == 419) then
            Msg2Player("ë tr¹ng th¸i nµy kh«ng thÓ sö dông biÕn th©n phï.")
        else
            PolyMorph(17, 1, 0, -1, 1800)
            CostIBItem(itemID)
        end ;
        CloseDialog()
    end
end;

function no()
    CloseDialog()
end;
