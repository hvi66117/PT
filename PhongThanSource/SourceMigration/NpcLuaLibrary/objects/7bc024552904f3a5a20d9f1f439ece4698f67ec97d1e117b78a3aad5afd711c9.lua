Task_Variety_Process = 1389

function OnDeath(npcindex)
    local pid = GetNpcTask(npcindex, 4)
    if (pid == GetPlayerID(PlayerIndex)) then

        AddNormalItem(6, 1, 489, 1, 0, 0)
        ScrollMessage("Cã ®­îc B¨ng Linh Gia Th­, më ra xem thö")
        Msg2Player("B¹n ®­îc B¨ng Linh Gia Th­, më ra xem bªn trong viÕt gØ.")
        SetTaskByte(Task_Variety_Process, 1, 20)
        ClearItem(6, 1, 487, 1)
        TaskNote(1047, 3)
    else
        local pidx = SearchPlayerById(pid)
        if (pidx ~= 0) then
            PlayerIndex = pidx
            Msg2Player("§Çu LÜnh B¨ng Linh b¹n gäi ra ®· bÞ ng­êi kh¸c tiªu diÖt, ®îi L«i §iÖn Th¸p t¾t h¼n råi trë vÒ t×m Kh­¬ng Tö Nha nghÜ c¸ch.")
        end
    end

    local towerNpcidx = GetNpcTask(npcindex, 1)
    if (towerNpcidx ~= 0 and GetNpcTask(towerNpcidx, 5) == npcindex) then
        SetNpcTask(towerNpcidx, 5, 0)
    end

    DelNpc(npcindex)
end;

function no()
    CloseDialog()
end;
