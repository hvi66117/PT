Task_chongyang = 1581

Task_cy_jiangli = 1582

Task_cy_zhuyuxn = 1583

function main()
    local lasttime = GetTask(Task_cy_zhuyuxn)
    local currenttime = LocalSystemTime()
    local usedtimes = GetTaskByte(Task_cy_jiangli, 2)

    local lastday = GetTaskByte(Task_cy_jiangli, 3)
    local currentday = math.mod(math.floor(LocalSystemTime() / 86400), 255) + 1
    if (lastday ~= currentday) then
        SetTaskByte(Task_cy_jiangli, 2, 0)
        SetTaskByte(Task_cy_jiangli, 3, currentday)
        SetTask(Task_cy_zhuyuxn, 0)
        usedtimes = 0
        lasttime = 0
    end
    if (usedtimes >= 5) then
        Talk(1, "no", "H«m nay ®· sö dông H­¬ng Nang 5 lÇn, ph¸p lùc cña H­¬ng Nang ®· yÕu ®i, ph¶i ngµy mai míi cã thÓ håi phôc!")
        return
    end

    if ((currenttime - lasttime) <= 30 * 60) then
        Msg2Player("H­¬ng Nang vÉn ®ang trong thêi gian chê!")
    else
        AddIBBuff(1048)
        local maxlife = GetNpcLifeMax(PlayerIndexToNpcIndex(PlayerIndex))
        SetNpcLife(PlayerIndexToNpcIndex(PlayerIndex), maxlife)
        Msg2Player("B¹n nhËn ®­îc hiÖu qu¶ H­¬ng Nang!")
        SetTaskByte(Task_cy_jiangli, 2, usedtimes + 1)
        SetTask(Task_cy_zhuyuxn, currenttime)
    end
end

function no()
    CloseDialog()
end
