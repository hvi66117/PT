Task_Time = 1646
Task_UseTimes = 1647

function main()
    local lastTime = GetTask(Task_Time)
    local curTime = LocalSystemTime()
    local nTimes = GetTask(Task_UseTimes)

    if (math.floor(LocalSystemTime() / 86400) ~= math.floor(lastTime / 86400)) then
        SetTask(Task_Time, LocalSystemTime())
        SetTask(Task_UseTimes, 0)
        nTimes = 0
    end

    if (nTimes >= 5) then
        Talk(1, "no", "H«m nay ®· dïng 5 lÇn <c=yel>T­ LÔ B¶o Gi¸m<c>, ph¸p lùc <c=yel>T­ LÔ B¶o Gi¸m<c> ®· c¹n, ngµy mai míi kh«i phôc.")
        return
    end

    if ((curTime - lastTime) <= 30 * 60) then
        Msg2Player("T­ LÔ B¶o Gi¸m ®ang trong thêi gian chê!")
    else
        AddIBBuff(1227)
        local maxLife = GetNpcLifeMax(PlayerIndexToNpcIndex(PlayerIndex))
        SetNpcLife(PlayerIndexToNpcIndex(PlayerIndex), maxLife)
        Msg2Player("B¹n nhËn ®­îc hiÖu øng T­ LÔ B¶o Gi¸m!")
        SetTask(Task_UseTimes, nTimes + 1)
        SetTask(Task_Time, curTime)
    end
end

function no()
    CloseDialog()
end

