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
        AddNormalItem(6, 1, 100, 39, 1, 1)
        return
    end

    local f = GetCompeteFlag()
    if (f == 1) then
        Msg2Player("Tr¹ng th¸i chiÕn ®Êu kh«ng thÓ sö dông BiÕn Th©n Phï.")
    else
        if (GetMorphType() == 364) or (GetMorphType() == 367) or (GetMorphType() == 420) or (GetMorphType() == 419) then
            Msg2Player("ë tr¹ng th¸i nµy kh«ng thÓ sö dông biÕn th©n phï.")
            AddNormalItem(6, 1, 100, 39, 1, 1)
        elseif (GetSex() == 0) then
            Msg2Player("Trêi ®Êt! Con trai mµ ®ßi lµm T©n n­¬ng!")
            AddNormalItem(6, 1, 100, 39, 1, 1)
        else
            PolyMorph(367, 0, 0, -1, 1800)
        end ;
        CloseDialog()
    end
end;

function no()
    CloseDialog()
end;
