--description:npcdeath
--author: huyuzhang
--date:2009/7/29

TASK_CRLH = 1513            --第一位 任务部分 第二位 每个部分的具体步骤
TASK_CRLH_CALLTIME = 1515

function OnDeath(npcindex)

    --if( GetTaskByte(TASK_CRLH, 1) == 1 and GetTaskByte(TASK_CRLH, 2) == 4 ) then
    local pidx = GetNpcTask(npcindex, 1)
    local pid = GetNpcTask(npcindex, 2)

    local oldpidx = PlayerIndex
    PlayerIndex = pidx

    if (GetPlayerID() == pid) then
        SetTask(TASK_CRLH_CALLTIME, 0)

    end

    PlayerIndex = oldpidx

    --end

    DelNpc(npcindex)

end