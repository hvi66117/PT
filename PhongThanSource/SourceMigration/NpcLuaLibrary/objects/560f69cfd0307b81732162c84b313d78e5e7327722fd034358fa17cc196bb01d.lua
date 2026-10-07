gItemGen = 8
gItemDetail = 1452
gItemPart = 2
Task_ItemNum = 1853
Task_KillNum = 1854

Task_GetReward = 1907
TableReward = {
    [1] = { count = 5, taskstep = 1, nextstep = 8, },
    [2] = { count = 8, taskstep = 2, nextstep = 15, },
    [3] = { count = 15, taskstep = 3, nextstep = 20, },
    [4] = { count = 20, taskstep = 4, nextstep = 30, },
    [5] = { count = 30, taskstep = 5, nextstep = 40, },
    [6] = { count = 40, taskstep = 6, nextstep = 50, },
    [7] = { count = 50, taskstep = 7, nextstep = 60, },
    [8] = { count = 60, taskstep = 8, nextstep = 80, },
    [9] = { count = 80, taskstep = 9, nextstep = 90, },
    [10] = { count = 90, taskstep = 10, nextstep = 100, },
    [11] = { count = 100, taskstep = 11, nextstep = 120, },
    [12] = { count = 120, taskstep = 12, nextstep = 180, },
    [13] = { count = 180, taskstep = 13, nextstep = 400, },
    [14] = { count = 400, taskstep = 14, nextstep = 0, },
}

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

    ThrowItem(nNpcIdx, PlayerIndex, 6, 1, 953, 1, 0, 0, 1)

    AddIBBuff(1455)
    if (HaveIBBuff(1455) >= 1 and GetIBBuffTimes(1455) >= 10) then
        AddNormalItemBind(6, 1, 942, 1, 0, 0, 1)
        Msg2Player("NhËn thªm 1 Linh Hån TÕ PhÈm.")
        ScrollMessage("NhËn thªm 1 Linh Hån TÕ PhÈm.")
        Msg2CurMapAnnounce("<c=g><RoleName=\"" .. GetName() .. "\"><c> Siªu ®é Phong Nhai trong TÕ Uyªn Cèc, nhËn ®­îc 1 Linh Hån TÕ PhÈm.")
        logStr = logStr .. "Linh Hån TÕ PhÈm"
        for i = 1, 10 do
            RemoveIBBuff(1455)
        end
    end

    local nKillCount = GetTask(Task_KillNum)
    local nTaskStep = GetTaskByte(Task_GetReward, 1) + 1
    if (nKillCount <= 0) then
        TaskNote(Task_GetReward, 0, nKillCount, TableReward[1].count)
    elseif (nKillCount >= 400 and nTaskStep >= 12) then
        TaskNote(Task_GetReward, -1)
    else
        if (nTaskStep > 0 and nTaskStep <= table.getn(TableReward)) then


            if (nTaskStep <= 7) then
                TaskNote(Task_GetReward, 0, nKillCount, TableReward[nTaskStep].count)
            else
                TaskNote(Task_GetReward, 1, nKillCount, TableReward[nTaskStep].count)
            end


        end
    end

    WriteLog("¼ÀÔ¨¹È: ½µ·þ" .. nKillNum .. ".")
end;

function RndProbabilityTable(t)
    if type(t) == "table" then
        local count = table.getn(t)
        local sum = 0
        local rnd = math.random(1, 10000)
        for i = 1, count do
            local probability = t[i][1]
            sum = sum + probability
            if rnd <= sum then
                return i
            end
        end
        return 0
    else
        return nil
    end
end
