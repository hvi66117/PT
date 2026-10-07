TASK_CRLH = 1513
TASK_CRLH_CALLTIME = 1515

function OnDeath(npcindex)


    local pidx = GetNpcTask(npcindex, 1)
    local pid = GetNpcTask(npcindex, 2)

    local oldpidx = PlayerIndex
    PlayerIndex = pidx

    if (GetPlayerID() == pid) then
        SetTask(TASK_CRLH_CALLTIME, 0)

    end

    PlayerIndex = oldpidx

    DelNpc(npcindex)

end
