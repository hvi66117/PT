task_collect = 1119;
task_collectInfo = 1120;
function main()
    MsgBox(13132, "AcceptTask", "no")

end

function AcceptTask()
    no()
    if (GetTask(task_collect) == 1) then
        TopMessage(13133)
        Msg2Player("§ang nhËn nhiÖm vô Thu thËp, kh«ng thÓ sö dông mËt tÞch!")
        CloseDialog()
        return
    end

    if HaveNormalItem(6, 1, 309, 1) <= 0 then
        InfoBox("Trong tói kh«ng cã mËt tÞch! Kh«ng thÓ nhËn nhiÖm vô!")
        return
    end

    SetTask(task_collect, 1)
    if (GetPlayerType() == 0) then
        SetTask(task_collectInfo, 0)
        SetTaskByte(task_collectInfo, 2, 2)
        TaskNote(917, 0)
        TopMessage(13134)
        DelNormalItem(6, 1, 309, 1)
        Talk(1, "no", 13135)
        return
    elseif (GetPlayerType() == 1) then
        SetTask(task_collectInfo, 0)
        SetTaskByte(task_collectInfo, 2, 2)
        TaskNote(917, 2)
        TopMessage(13138)
        DelNormalItem(6, 1, 309, 1)
        Talk(1, "no", 13139)
        return
    elseif (GetPlayerType() == 2) then
        SetTask(task_collectInfo, 0)
        SetTaskByte(task_collectInfo, 2, 2)
        TaskNote(917, 5)
        TopMessage(13142)
        DelNormalItem(6, 1, 309, 1)
        Talk(1, "no", 13143)
        return
    end
end

function no()
    CloseDialog()
end
