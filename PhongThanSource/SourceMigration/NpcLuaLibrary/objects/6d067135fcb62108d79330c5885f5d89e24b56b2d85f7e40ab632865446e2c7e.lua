gua8_renwu = 1340
gua8_task = 1341

function OnDeath(npcidx)
    local pid = GetNpcTask(npcidx, 1)
    if (GetPlayerID() == pid) then
        if (GetTaskByte(gua8_renwu, 3) == 2) and (GetTaskByte(gua8_renwu, 4) == 5) then
            Msg2Player("B¹n ®· ®¸nh b¹i Thùc D­îc thó, h·y vÒ b¸o tin cho Chóc Dung!")
            SetTask(gua8_task, 0)
            SetTaskByte(gua8_renwu, 3, 3)
            TaskNote(97, 1)
        end
    end
    DelNpc(npcidx)
end;
