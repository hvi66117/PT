function main()
    local f = GetCompeteFlag()
    if (f == 1 or CanPolyMorph() == 1) then
        Msg2Player("Tr¹ng th¸i chiÕn ®Êu kh«ng thÓ sö dông BiÕn Th©n Phï.")
    else
        if (GetSex() == 0) then
            MsgBox(13357, "yes", "no")
        else
            Talk(1, "no", 13358)
        end
    end
end

function yes()
    if (DelNormalItem(6, 1, 155, 1) ~= 0) then
        Y, M, D = Time2LocalYMD(SystemTime() + 2592000)
        PolyMorph(454, 1, 0, -1, 43200)
        AddNormalItem(6, 1, 159, 1, 0, 0, 0)
        Talk(1, "no", "Trang phôc nµy ®Õn" .. Y .. "N¨m" .. M .. "Th¸ng" .. D .. "lµ hÕt h¹n. Mçi lÇn ®æi trang phôc kÐo dµi trong 12 giê. B¹n cã thÓ ®æi trang phôc tr­íc ®ã bÊt kú lóc nµo.")
    end
end

function no()
    CloseDialog()
end
