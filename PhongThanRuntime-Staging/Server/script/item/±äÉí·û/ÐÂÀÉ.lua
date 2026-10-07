require("common.luax")
IsSpecialMorph = COMMON.IsSpecialMorph

function main(itemID)
    if (IsSpecialMorph() == true) then
        Msg2Player("Tr¹ng th¸i nµy kh«ng thÓ sö dông BiÕn Th©n Phï.")
        return
    end

    local w, x, y = GetWorldPos()
    if (w == 85) then
        Msg2Player("Tr¹ng th¸i chiÕn ®Êu kh«ng thÓ sö dông BiÕn Th©n Phï.")
        AddNormalItem(6, 1, 99, 39, 1, 1)
        return
    end

    local f = GetCompeteFlag()
    if (f == 1) then
        Msg2Player("Tr¹ng th¸i chiÕn ®Êu kh«ng thÓ sö dông BiÕn Th©n Phï.")
    else
        if (GetMorphType() == 364) or (GetMorphType() == 412) or (GetMorphType() == 420) or (GetMorphType() == 419) then
            Msg2Player("ë tr¹ng th¸i nµy kh«ng thÓ sö dông biÕn th©n phï.")
            AddNormalItem(6, 1, 99, 39, 1, 1)
        elseif (GetSex() == 1) then
            Msg2Player("Trêi ®Êt! Con g¸i mµ ®ßi lµm T©n lang!")
            AddNormalItem(6, 1, 99, 39, 1, 1)
        else
            PolyMorph(412, 0, 0, -1, 1800)
        end ;
        CloseDialog()
    end
end;

function no()
    CloseDialog()
end;
