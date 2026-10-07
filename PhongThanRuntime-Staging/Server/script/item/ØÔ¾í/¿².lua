gua8_renwu = 1340
gua8_task = 1341

function main()
    if (GetPlayerExtLevel() < 15) then
        Talk(1, "no", "®¼ng cÊp ch­a ®Õn 15")
        return 0
    end

    MsgBox("Kh¶m", "AcceptTask", "no")
end

function AcceptTask()
    CloseDialog()
    local nTaskStatus = GetTaskByte(gua8_renwu, 3)
    if (nTaskStatus == 2 or nTaskStatus == 3) then
        TopMessage("")
        Msg2Player("B¹n ®ang thùc hiÖn nhiÖm vô, kh«ng thÓ sö dông mËt lÖnh nµy!")
        return
    end

    if (HaveNormalItem(6, 1, 460, 0) > 0) then
        DelNormalItem(6, 1, 460, 0)
        set_8gua()
    elseif (HaveNormalItem(6, 1, 452, 0) > 0) then
        DelNormalItem(6, 1, 452, 0)
        set_8gua()
    end
end

function set_8gua()
    SetTaskByte(gua8_renwu, 3, 2)
    SetTaskByte(gua8_renwu, 4, 6)
    SetTask(gua8_task, 30)
    TaskNote(97, 7, 0)
    TopMessage("")
    Msg2Player("")
    Talk(1, "no", "Tiªu diÖt (<c=g>%d<c>/30) ChØ LÖ")
end

function no()
    CloseDialog()
end
