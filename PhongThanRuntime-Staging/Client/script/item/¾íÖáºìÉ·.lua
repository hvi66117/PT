task_id = 1206;

function main()
    MsgBox("Chóc mõng b¹n ®· ®­îc chän! B¹n ®ång ı gia nhËp ®éi ngò ®i t×m diÖt <c=g>Hång S¸t<c> chø?", "AcceptTask", "no")
end

function AcceptTask()
    if (GetByte(GetTask(task_id), 1) == 0) then

        if HaveNormalItem(6, 1, 352, 1) <= 0 then
            InfoBox("Trong tói kh«ng cã mËt tŞch! Kh«ng thÓ nhËn nhiÖm vô!")
            return
        end

        SetTask(task_id, 1)
        SetTask(task_id, SetByte(GetTask(task_id), 2, 12))
        SetTask(task_id, SetByte(GetTask(task_id), 3, 30))
        TaskNote(921, 0)
        DelNormalItem(6, 1, 352, 1)
        TopMessage("NhiÖm vô Hång S¸t lÖnh:cÇn ph¶i tiªu diÖt 30 Hång S¸t")
        Msg2Player("NhiÖm vô Hång S¸t lÖnh:cÇn ph¶i tiªu diÖt 30 Hång S¸t")
        Talk(1, "no", "Ra ngoµi thµnh tiªu diÖt <c=g>30 Hång S¸t<c>, xong vÒ th«n gÆp <c=r>T¹p hãa Th­¬ng<c> nhËn phÇn th­ëng!")
        return 1;
    end

    if (GetByte(GetTask(task_id), 1) == 1 or GetByte(GetTask(task_id), 1) == 2) then
        TopMessage("B¹n hiÖn t¹i ®ang trong tr¹ng th¸i nhiÖm vô diÖt Hång S¸t, kh«ng thÓ më thÎ nhiÖm vô kh¸c!")
        Msg2Player("B¹n hiÖn t¹i ®ang trong tr¹ng th¸i nhiÖm vô diÖt Hång S¸t, kh«ng thÓ më thÎ nhiÖm vô kh¸c!")
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
