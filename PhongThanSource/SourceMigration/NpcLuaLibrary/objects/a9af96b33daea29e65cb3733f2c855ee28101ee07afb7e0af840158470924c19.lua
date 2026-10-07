Task_HorseGift = 1908
ActivityHorseStart = 109
gItemName = "Ma Thπch Th t Lπc"
function OnDeath(nNpcIdx)
    if (GetLevel() < 65) then
        return
    end

    if (ClearHorseTodayTask() <= 0) then
        return
    end

    if (GetTaskBit(Task_HorseGift, 27) == 1 or HaveNormalItem(3, 1225, 0, 0) >= 1 or HaveNormalItem(6, 1, 1079, 1) >= 50) then
        return
    end

    AddNormalItemBind(6, 1, 1079, 1, 0, 0, 1)
    Msg2Player("ƒ˙ªÒ¡À" .. gItemName .. ".")
    DelNpc(nNpcIdx)
end;

function ClearHorseTodayTask()


    local nYear, nMon, nDay = GetYMD()
    local nToday = math.mod(math.floor(LocalSystemTime() / 86400), 254) + 1
    if (nYear == 2015 and nMon == 1 and nDay >= 16 and nDay <= 28) then
        if (GetTaskByte(Task_HorseGift, 3) ~= ActivityHorseStart) then
            SetTask(Task_HorseGift, 0)
            SetTaskBit(Task_HorseGift, 29, 1)
            SetTaskByte(Task_HorseGift, 1, nToday)
            SetTaskByte(Task_HorseGift, 3, ActivityHorseStart)
        else
            local nTaskDay = GetTaskByte(Task_HorseGift, 1)
            if (nTaskDay ~= nToday) then
                SetTaskByte(Task_HorseGift, 4, 0)
                SetTaskByte(Task_HorseGift, 1, nToday)
            end
        end
        return 1
    end
    return 0
end
