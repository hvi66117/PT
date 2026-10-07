task_id = 1209;

function main()
    MsgBox("Chóc mõng b¹n ®· ®­îc chän! B¹n ®ång ı gia nhËp ®éi ngò ®i t×m diÖt <c=g>H¾c Phong<c> chø?", "AcceptTask", "no")
end

function AcceptTask()
    if (GetByte(GetTask(task_id), 1) == 0) then

        if HaveNormalItem(6, 1, 354, 1) <= 0 then
            InfoBox("Trong tói kh«ng cã mËt tŞch! Kh«ng thÓ nhËn nhiÖm vô!")
            return
        end

        SetTask(task_id, 1)
        SetTask(task_id, SetByte(GetTask(task_id), 2, 18))
        SetTask(task_id, SetByte(GetTask(task_id), 3, 30))
        TaskNote(922, 0)
        DelNormalItem(6, 1, 354, 1)
        TopMessage("NhiÖm vô H¾c Phong LÖnh:cÇn ph¶i tiªu diÖt 30 H¾c Phong")
        Msg2Player("NhiÖm vô H¾c Phong LÖnh:cÇn ph¶i tiªu diÖt 30 H¾c Phong")
        Talk(1, "no", "Ra ngoµi thµnh tiªu diÖt <c=g>30 H¾c Phong<c>, xong vÒ th«n gÆp <c=r>T¹p hãa Th­¬ng<c> nhËn phÇn th­ëng!")
        return 1;
    end

    if (GetByte(GetTask(task_id), 1) == 1 or GetByte(GetTask(task_id), 1) == 2) then
        TopMessage("B¹n ®ang thùc hiÖn nhiÖm vô H¾c Phong, kh«ng thÓ sö dông MËt lÖnh kh¸c!")
        Msg2Player("B¹n ®ang thùc hiÖn nhiÖm vô H¾c Phong, kh«ng thÓ sö dông MËt lÖnh kh¸c!")
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
