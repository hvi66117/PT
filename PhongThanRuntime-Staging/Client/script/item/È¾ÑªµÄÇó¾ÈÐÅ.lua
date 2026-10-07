instence_Task = 1606

function main()
    CloseDialog()
    if (GetTaskByte(instence_Task, 2) == 0) then
        Talk(2, "no", GetName() .. ": §©y h×nh nh­ lµ th­ cÇu cøu göi cho Vâ V­¬ng, ch¾c ch¾n lµ do T­íng LÜnh Qu©n Chu bÞ nhèt trong trËn viÕt!", GetName() .. ": Ng­êi nµy ch¾c lµ x«ng vµo ThËp TuyÖt TrËn, bÞ yªu ma v©y khèn, e ®· kh«ng cßn toµn m¹ng!...Ýt nhÊt ta còng cã thÓ gióp y b¸o thï!")
        Msg2Player("C«ng ph¸ Thiªn Tù Tam TrËn, t×m ®­îc ng­êi ®· viÕt th­ cÇu cøu!")
        SetTaskByte(instence_Task, 2, 1)
        TaskNote(1206, 0)
        DelNormalItem(6, 1, 749, 0)
    else
        Talk(1, "no", GetName() .. ": Háng råi! Th­ cÇu cøu ®· bÞ giã thæi bay...")
        DelNormalItem(6, 1, 749, 0)
    end
end

function no()
    CloseDialog()
end
