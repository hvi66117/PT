task_juanzhoujing = 1115;
task_jingInfo = 1121;

function main()
    MsgBox(13222, "AcceptTask", "no")

end

function AcceptTask()
    local nTaskStatus = GetTask(task_juanzhoujing)
    if (nTaskStatus == 1 or nTaskStatus == 2) then
        TopMessage(13223)
        Msg2Player("§ang nhËn nhiÖm vô TÜnh Nh©n, kh«ng thÓ sö dông mËt tÞch.")
        CloseDialog()
        return
    end

    if HaveNormalItem(6, 1, 303, 1) <= 0 then
        InfoBox("Trong tói kh«ng cã mËt tÞch! Kh«ng thÓ nhËn nhiÖm vô!")
        return
    end

    SetTask(task_juanzhoujing, 1)
    SetTask(task_jingInfo, 0)
    SetTask(task_jingInfo, SetByte(GetTask(task_jingInfo), 1, 0))
    SetTask(task_jingInfo, SetByte(GetTask(task_jingInfo), 2, 20))
    TaskNote(918, 0)
    DelNormalItem(6, 1, 303, 1)
    TopMessage(13224)
    Msg2Player("NhiÖm vô TÜnh Nh©n lÖnh:cÇn ph¶i tiªu diÖt 20 TÜnh Nh©n")
    Talk(1, "no", 13225)
end

function no()
    CloseDialog()
end
