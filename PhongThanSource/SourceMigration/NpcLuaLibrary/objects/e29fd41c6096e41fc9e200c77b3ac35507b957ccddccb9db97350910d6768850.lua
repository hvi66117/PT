Task_KillNum = 1915

function OnDeath(nNpcIdx)
    if (PlayerIndex <= 0) then
        return
    end

    local nKillNum = GetTask(Task_KillNum) + 1
    local logStr = ""
    SetTask(Task_KillNum, nKillNum)

    CancelNpcBelonger(nNpcIdx)
    NpcPolyMorph(nNpcIdx, -1)
    NpcRemoveIBBuff(nNpcIdx, 1459)

    ThrowItem(nNpcIdx, PlayerIndex, 6, 1, 1158, 1, 0, 0, 1)
    WriteLog("[Linh TÞch][" .. nKillNum .. "´ÎÊý]")
end
