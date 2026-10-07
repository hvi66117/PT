gua8_renwu = 1340
gua8_task = 1341

function OnDeath(npcidx)
    local pid = GetNpcTask(npcidx, 1)
    if (GetPlayerID() == pid) then
        if (GetTaskByte(gua8_renwu, 3) == 2) and (GetTaskByte(gua8_renwu, 4) == 7) then
            Msg2Player("B¹n ®· tiªu diÖt Ma Kh©m Nguyªn (S¬n), h·y vÒ b¸o tin cho Chóc Dung!")
            SetTask(gua8_task, 0)
            SetTaskByte(gua8_renwu, 3, 3)
            TaskNote(97, 1)
            DelNpc(npcidx)
            return
        end
    end

    local oldPlayer = PlayerIndex
    PlayerIndex = GetNpcTask(npcidx, 2)

    if (GetPlayerID() == pid) then
        SetTaskByte(gua8_renwu, 4, 7)
        SetTaskByte(gua8_renwu, 3, 2)
        SetTask(gua8_task, 0)
        Msg2Player("Ma Kh©m Nguyªn (S¬n) cña b¹n bÞ ng­êi kh¸c tiªu diÖt, tiÕp tôc hµng phôc Ma Kh©m Nguyªn sÏ khiÕn Ma Kh©m Nguyªn (S¬n) xuÊt hiÖn.")
        TaskNote(97, 12)
    end

    PlayerIndex = oldPlayer
    DelNpc(npcidx)
end;
