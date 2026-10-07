task_juanzhoubigxue = 1118;
task_bigxueInfo = 1124;

function main()
    MsgBox(13289, "AcceptTask", "no")

end

function AcceptTask()
    local nTaskStatus = GetTask(task_juanzhoubigxue)
    if (nTaskStatus == 1 or nTaskStatus == 2) then
        TopMessage(13290)
        Msg2Player("§ang nhËn nhiÖm vô TuyÕt Nguyªn Cù Thó, kh«ng thÓ sö dông mËt tŞch.")
        CloseDialog()
        return
    end

    if HaveNormalItem(6, 1, 308, 1) <= 0 then
        InfoBox("Trong tói kh«ng cã mËt tŞch! Kh«ng thÓ nhËn nhiÖm vô!")
        return
    end

    SetTask(task_juanzhoubigxue, 1)
    SetTask(task_juanzhouxue, 1)
    SetTask(task_bigxueInfo, 0)
    SetTask(task_bigxueInfo, SetByte(GetTask(task_bigxueInfo), 1, 8))
    SetTask(task_bigxueInfo, SetByte(GetTask(task_bigxueInfo), 2, 30))
    TaskNote(916, 0)
    DelNormalItem(6, 1, 308, 1)
    TopMessage(13291)
    Msg2Player("NhiÖm vô TuyÕt Nguyªn Cù Thó lÖnh: cÇn ph¶i tiªu diÖt 30 TuyÕt Nguyªn Cù Thó")
    Talk(1, "no", 13292)
end

function no()
    CloseDialog()
end
