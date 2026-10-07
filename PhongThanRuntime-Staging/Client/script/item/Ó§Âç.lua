Family_hrzq = 50

Task_hrzq = 1610

Task_hrzq_ylt = 1611
Task_hrzq_yl = 1612

Task_ibyq = 1613
Task_yq = 1614

function main()
    local lasttime = GetTask(Task_hrzq_ylt)
    local currenttime = LocalSystemTime()
    local usedtimes = GetTaskByte(Task_hrzq_yl, 2)

    local lastday = GetTaskByte(Task_hrzq_yl, 1)
    local currentday = math.mod(math.floor(LocalSystemTime() / 86400), 255) + 1
    if (lastday ~= currentday) then
        SetTaskByte(Task_hrzq_yl, 2, 0)
        SetTaskByte(Task_hrzq_yl, 1, currentday)

        usedtimes = 0
        lasttime = 0
    end
    if (usedtimes >= 5) then
        Talk(1, "no", "H«m nay b¹n ®· sö dông X©u chuçi 5 lÇn, ngµy mai míi cã thÓ håi phôc.")
        return
    end

    if ((currenttime - lasttime) <= 30 * 60) then
        Msg2Player("Ph¸p lùc cña X©u chuçi vÉn ch­a håi phôc.")
    else
        AddIBBuff(1092)
        local maxlife = GetNpcLifeMax(PlayerIndexToNpcIndex(PlayerIndex))
        SetNpcLife(PlayerIndexToNpcIndex(PlayerIndex), maxlife)
        Msg2Player("B¹n nhËn ®­îc hiÖu qu¶ X©u chuçi!")
        SetTaskByte(Task_hrzq_yl, 2, usedtimes + 1)
        SetTask(Task_hrzq_ylt, currenttime)
    end
end

function no()
    CloseDialog()
end
