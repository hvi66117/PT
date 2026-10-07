task_juanzhouhuan = 1116;
task_huanInfo = 1122;

function main()
    MsgBox(13217, "AcceptTask", "no")
end

function AcceptTask()
    local nTaskStatus = GetTask(task_juanzhouhuan)
    if (nTaskStatus == 1 or nTaskStatus == 2) then
        TopMessage(13218)
        Msg2Player("§ang nhËn nhiÖm vô Hoµn CÈu, kh«ng thÓ sö dông mËt tÞch!")
        CloseDialog()
        return
    end

    if HaveNormalItem(6, 1, 304, 1) <= 0 then
        InfoBox("Trong tói kh«ng cã mËt tÞch! Kh«ng thÓ nhËn nhiÖm vô!")
        return
    end

    SetTask(task_juanzhouhuan, 1)
    SetTask(task_huanInfo, 0)
    SetTask(task_huanInfo, SetByte(GetTask(task_huanInfo), 1, 7))
    SetTask(task_huanInfo, SetByte(GetTask(task_huanInfo), 2, 30))
    TaskNote(914, 0)
    DelNormalItem(6, 1, 304, 1)
    TopMessage(13219)
    Msg2Player("NhiÖm vô Hoµn CÈu lÖnh:cÇn ph¶i tiªu diÖt 30 Hoµn CÈu")
    Talk(1, "no", 13220)
end
function no()
    CloseDialog()
end
