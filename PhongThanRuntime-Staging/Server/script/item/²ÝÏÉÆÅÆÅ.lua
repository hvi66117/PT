Task_CxppRell = 1127;

function main()
    MsgBox(13196, "AcceptTask", "RefuseTask")
end

function AcceptTask()
    if (GetByte(GetTask(Task_CxppRell), 1) == 0) then
        SetTask(Task_CxppRell, 1)
        SetTask(Task_CxppRell, SetByte(GetTask(Task_CxppRell), 2, 9))
        SetTask(Task_CxppRell, SetByte(GetTask(Task_CxppRell), 3, 30))
        TaskNote(1010, 0)
        TopMessage(13197)
        Msg2Player("NhiÖm vô Th¶o Tiªn lÖnh:cÇn ph¶i tiªu diÖt 30 Th¶o Tiªn")
        Talk(1, "no", 13198)
        DelNormalItem(6, 1, 306, 1)
        return 1;
    end

    if (GetByte(GetTask(Task_CxppRell), 1) == 1 or GetByte(GetTask(Task_CxppRell), 1) == 2) then
        TopMessage(13199)
        Msg2Player("CÇn tiªu diÖt 50 Th¶o Tiªn.")
        CloseDialog()
        return 1;
    end
end

function RefuseTask()
    CloseDialog()
end

function no()
    CloseDialog()
end
