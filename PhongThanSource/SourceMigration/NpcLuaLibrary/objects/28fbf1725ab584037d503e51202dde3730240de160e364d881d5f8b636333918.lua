task_id = 1210;
--taskÊéĞ´¸ñÊ½¸Ä°æ  modified by yaoxin at 2009-09-1
function main()
    MsgBox("Chóc mõng b¹n ®· ®­îc chän! B¹n ®ång ı gia nhËp ®éi ngò ®i t×m diÖt <c=g>Giang Quy<c> chø?", "AcceptTask", "no")
end

function AcceptTask()
    if (GetByte(GetTask(task_id), 1) == 0) then
        --Modified By Guoqun for Òì²½ÅĞ¶Ï at 2010-10-18 Begin
        if HaveNormalItem(6, 1, 356, 1) <= 0 then
            InfoBox("Trong tói kh«ng cã mËt tŞch! Kh«ng thÓ nhËn nhiÖm vô!")
            return
        end
        --Modified By Guoqun for Òì²½ÅĞ¶Ï at 2010-10-18 End

        SetTask(task_id, 1)--log¸Ä°æ
        SetTask(task_id, SetByte(GetTask(task_id), 2, 24))
        SetTask(task_id, SetByte(GetTask(task_id), 3, 30))
        TaskNote(923, 0)
        DelNormalItem(6, 1, 356, 1)
        TopMessage("NhiÖm vô Giang Quy lÖnh:cÇn ph¶i tiªu diÖt 30 Giang Quy")
        Msg2Player("NhiÖm vô Giang Quy lÖnh:cÇn ph¶i tiªu diÖt 30 Giang Quy")
        Talk(1, "no", "Ra ngoµi thµnh tiªu diÖt <c=g>30 Giang Quy<c>, xong vÒ th«n gÆp <c=r>T¹p hãa Th­¬ng<c> nhËn phÇn th­ëng!")
        return 1;
    end

    if (GetByte(GetTask(task_id), 1) == 1 or GetByte(GetTask(task_id), 1) == 2) then
        TopMessage("B¹n ®ang thùc hiÖn nhiÖm vô Giang Quy, kh«ng thÓ sö dông MËt lÖnh kh¸c!")
        Msg2Player("B¹n ®ang thùc hiÖn nhiÖm vô Giang Quy, kh«ng thÓ sö dông MËt lÖnh kh¸c!")
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