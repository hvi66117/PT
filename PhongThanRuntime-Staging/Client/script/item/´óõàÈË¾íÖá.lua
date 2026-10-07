Task_DzrRell = 1126;

function main()
    MsgBox(13200, "AcceptTask", "RefuseTask")
end

function AcceptTask()
    if (GetByte(GetTask(Task_DzrRell), 1) == 0) then

        if HaveNormalItem(6, 1, 305, 1) <= 0 then
            InfoBox("Trong tói kh«ng cã mËt tÞch! Kh«ng thÓ nhËn nhiÖm vô!")
            return
        end

        SetTask(Task_DzrRell, 1)
        SetTask(Task_DzrRell, SetByte(GetTask(Task_DzrRell), 2, 2))
        SetTask(Task_DzrRell, SetByte(GetTask(Task_DzrRell), 3, 20))
        TaskNote(1009, 0)
        TopMessage(13201)
        Msg2Player("NhiÖm vô §¹i Chñng Nh©n lÖnh: cÇn ph¶i tiªu diÖt 20 §¹i Chñng Nh©n")
        Talk(1, "no", 13202)
        DelNormalItem(6, 1, 305, 1)
        return 1;
    end

    if (GetByte(GetTask(Task_DzrRell), 1) == 1 or GetByte(GetTask(Task_DzrRell), 1) == 2) then
        TopMessage(13203)
        Msg2Player("§ang nhËn nhiÖm vô §¹i Chñng Nh©n, kh«ng thÓ sö dông mËt tÞch!")
        CloseDialog()
        return 1
    end
end

function RefuseTask()
    CloseDialog()
end

function no()
    CloseDialog()
end
