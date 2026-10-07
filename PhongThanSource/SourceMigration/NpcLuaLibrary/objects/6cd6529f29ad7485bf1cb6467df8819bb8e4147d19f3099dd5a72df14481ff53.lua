Task_newer13 = 1416

function OnDeath(npcidx)
    if (GetPlayerID() == GetNpcTask(npcidx, 1)) then
        local ty = GetPlayerType()
        local w, x, y = GetWorldPos()
        if (w == 12) and (ty == 2) and (GetTaskByte(Task_newer13, 2) == 5) then
            Msg2Player("Mang Ph¶n §å TriÖt Gi¸o thu phôc vµo Thiªn Niªn B¶o T©n §¬n thËt sù, h·y vÒ giao cho VËt Tæ Phong B¸ ®i.")
            SetTaskByte(Task_newer13, 2, 6)
            AddEventItem(237)
            TaskNote(206, 5)
        elseif (w == 9) and (ty == 1) and (GetTaskByte(Task_newer13, 2) == 5) then
            Msg2Player("§o¹t ®­îc Tiªn C¬ Häa trªn ng­êi Ph¶n §å TriÖt Gi¸o, mang vÒ giao cho ph¸p s­ HuyÒn §«.")
            SetTaskByte(Task_newer13, 2, 6)
            TaskNote(208, 5)
            AddEventItem(241)
        elseif (w == 6) and (ty == 0) and (GetTaskByte(Task_newer13, 2) == 5) then
            Msg2Player("Ph¶n §å TriÖt Gi¸o ®· bÞ tiªu diÖt, vÒ b¸o c¸o víi Sïng HÇu hæ#")
            SetTaskByte(Task_newer13, 2, 6)
            TaskNote(210, 5)
        end
    end
    DelNpc(npcidx)
end;

function no()
    CloseDialog()
end;
