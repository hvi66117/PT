task_juanzhouxue = 1117;
task_xueInfo = 1123;

function main()
    MsgBox(13163, "AcceptTask", "no")

end

function AcceptTask()
    local nTaskStatus = GetTask(task_juanzhouxue)
    if (nTaskStatus == 1 or nTaskStatus == 2) then
        TopMessage(13164)
        Msg2Player("§ang nhËn nhiÖm vô TuyÕt Yªu, kh«ng thÓ sö dông mËt tÞch.")
        CloseDialog()
        return
    end

    if HaveNormalItem(6, 1, 307, 1) <= 0 then
        InfoBox("Trong tói kh«ng cã mËt tÞch! Kh«ng thÓ nhËn nhiÖm vô!")
        return
    end

    SetTask(task_juanzhouxue, 1)
    SetTask(task_xueInfo, 0)
    SetTask(task_xueInfo, SetByte(GetTask(task_xueInfo), 1, 1))
    SetTask(task_xueInfo, SetByte(GetTask(task_xueInfo), 2, 20))
    TaskNote(915, 0)
    DelNormalItem(6, 1, 307, 1)
    TopMessage(13165)
    Msg2Player("NhiÖm vô TuyÕt Yªu lÖnh:cÇn ph¶i tiªu diÖt 20 TuyÕt Yªu")
    Talk(1, "no", 13166)
end

function no()
    CloseDialog()
end
