Task_HorseGift = 1908
ActivityHorseStart = 109
gItemName = "空间匣碎片"
function GetPlayerTaskState()
    return 0, 0
end
function main()
    local npcidx = GetPlayerTarget()
    if (GetLevel() < 65) then
        return
    end

    if (ClearHorseTodayTask() <= 0) then
        return
    end

    if (GetTaskBit(Task_HorseGift, 28) == 1 or HaveNormalItem(3, 1226, 0, 0) >= 1 or HaveNormalItem(6, 1, 1080, 1) >= 50) then
        return
    end
    if (GetPlayerID() ~= GetNpcTask(npcidx, 1)) then
        Msg2Player("该" .. gItemName .. "不属于你, 你无法拾取.")
        return
    end

    local nInterrupt = 0
    nInterrupt = SetBit(nInterrupt, 1, 1)
    nInterrupt = SetBit(nInterrupt, 2, 1)
    nInterrupt = SetBit(nInterrupt, 3, 1)
    nInterrupt = SetBit(nInterrupt, 4, 0)
    nInterrupt = SetBit(nInterrupt, 5, 1)
    nInterrupt = SetBit(nInterrupt, 6, 0)
    BeginMotion(npcidx, 0, 1, "\\script\\npcdeath\\马上有四碎片.lua", nInterrupt, "收集" .. gItemName)
end;

function EndMotion(npcidx)
    local nNpcIdx = GetPlayerTarget()
    if (nNpcIdx <= 0) or (npcidx ~= nNpcIdx) then
        Talk(1, "no", gItemName .. "凌空消失了, 下次请抓紧时间拾取.")
        return
    end
    if (GetLevel() < 65) then
        return
    end

    if (ClearHorseTodayTask() <= 0) then
        return
    end

    if (GetTaskBit(Task_HorseGift, 28) == 1 or HaveNormalItem(3, 1226, 0, 0) >= 1 or HaveNormalItem(6, 1, 1080, 1) >= 50) then
        return
    end
    if (GetPlayerID() ~= GetNpcTask(npcidx, 1)) then
        Msg2Player("该" .. gItemName .. "不属于你, 你无法采集.")
        return
    end

    AddNormalItemBind(6, 1, 1080, 1, 0, 0, 1)
    Msg2Player("您采集到了 1 c竔 " .. gItemName .. ".")

    DelNpc(npcidx)
end

function InteruptMotion(MotionID)
end

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
function no()
    CloseDialog()
end
