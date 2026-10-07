task_id = 1207;

function main()
    MsgBox("Chóc mõng b¹n ®· ®­îc chän! B¹n ®ång ı gia nhËp ®éi ngò ®i t×m diÖt <c=g>Gi¸p Cèt<c> chø?", "AcceptTask", "no")
end

function AcceptTask()
    if (GetByte(GetTask(task_id), 1) == 0) then

        if HaveNormalItem(6, 1, 353, 1) <= 0 then
            InfoBox("Trong tói kh«ng cã mËt tŞch! Kh«ng thÓ nhËn nhiÖm vô!")
            return
        end

        SetTask(task_id, 1)
        SetTask(task_id, SetByte(GetTask(task_id), 2, 13))
        SetTask(task_id, SetByte(GetTask(task_id), 3, 30))
        TaskNote(920, 0)
        DelNormalItem(6, 1, 353, 1)
        TopMessage("NhiÖm vô Gi¸p Cèt lÖnh:cÇn ph¶i tiªu diÖt 30 Gi¸p Cèt")
        Msg2Player("NhiÖm vô Gi¸p Cèt lÖnh:cÇn ph¶i tiªu diÖt 30 Gi¸p Cèt")
        Talk(1, "no", "Ra ngoµi thµnh tiªu diÖt <c=g>30 Gi¸p Cèt<c>, xong vÒ th«n gÆp <c=r>T¹p hãa Th­¬ng<c> nhËn phÇn th­ëng!")
        return 1;
    end

    if (GetByte(GetTask(task_id), 1) == 1 or GetByte(GetTask(task_id), 1) == 2) then
        TopMessage("B¹n ®ang thùc hiÖn nhiÖm vô: Gi¸p Cèt, kh«ng thÓ sö dông MËt lÖnh kh¸c!")
        Msg2Player("B¹n ®ang thùc hiÖn nhiÖm vô: Gi¸p Cèt, kh«ng thÓ sö dông MËt lÖnh kh¸c!")
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
