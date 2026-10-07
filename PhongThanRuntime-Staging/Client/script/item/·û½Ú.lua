TASK_CRLH = 1513
TASK_NOTEID = 1091

function main()

    if (GetTaskByte(TASK_CRLH, 1) == 0 and GetTaskByte(TASK_CRLH, 2) == 0) then

        MsgBox("Trªn thÎ phï viÕt: §a B¶o §¹o Nh©n chi b¶o, cã thÓ tù do ra vµo BÝch Du cung!", "accept", "no")
    end

end

function no()
    CloseDialog()

end

function accept()
    CloseDialog()
    Talk(1, "no", "NÕu ®· lµ b¶o vËt cña §a B¶o §¹o Nh©n, th× kh«ng ®­îc chËm trÔ, h·y mau tr¶ vÒ chç cò!")
    Msg2Player("TiÕp nhËn: Tr¶ l¹i thÎ phï cho §a B¶o §¹o Nh©n.")

    SetTaskByte(TASK_CRLH, 1, 1)
    SetTaskByte(TASK_CRLH, 2, 1)
    TaskNote(TASK_NOTEID, 0)

end
