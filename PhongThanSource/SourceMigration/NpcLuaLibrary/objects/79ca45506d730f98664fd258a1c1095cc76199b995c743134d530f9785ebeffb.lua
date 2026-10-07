--description:item
--author: huyuzhang
--date:2009/7/29

TASK_CRLH_CALLTIME = 1515

function OnTimer(npcidx)
    failed(npcidx)

    DelNpc(npcidx)
end

function failed(npcindex)
    local pidx = GetNpcTask(npcindex, 1)
    local pid = GetNpcTask(npcindex, 2)

    local tmp_pidx = PlayerIndex
    PlayerIndex = pidx

    local tmp_pid = GetPlayerID()

    if (tmp_pid == pid) then
        Msg2Player("Qu∏i vÀt Æ∑ bi’n m t! Anh hÔng xin h∑y ti’p tÙc!")
        SetTask(TASK_CRLH_CALLTIME, 0)

    end

    PlayerIndex = tmp_pidx

end