Task_Challenge_Accept = 1396
Task_Challenge_Enter = 1397
Task_Challenge_Growth = 1398
Task_Challenge_Kill = 1399
Task_Challenge_Begin = 1400

Task_Info_Challenge = 204
Buff_Challenge = 649
Const_Kill_Burst = 10
Const_Kill_Interval = 3

function main(l, t, TargetNpcIndex)

    local w, x, y = GetWorldPos()
    if (w ~= 18) then
        Talk(1, "no", "ChØ sö dông t¹i Môc D·.")
        return
    end

    local localTime = LocalSystemTime()
    local currentDay = math.floor(localTime / 86400)
    local taskDate = GetTaskWord(Task_Challenge_Enter, 1)
    local taskCount = GetTaskByte(Task_Challenge_Enter, 3)
    local taskStatus = GetTaskByte(Task_Challenge_Enter, 4)

    local growth = GetTaskByte(Task_Challenge_Growth, 1)
    local useFill = GetTaskByte(Task_Challenge_Growth, 2)
    local useFillCount = GetTaskByte(Task_Challenge_Growth, 3)
    local enterRound = GetTaskByte(Task_Challenge_Growth, 4)
    local preTime = GetTask(Task_Challenge_Kill)
    local localTime = LocalSystemTime()

    if (taskStatus == 0) then
        Talk(1, "no", "ChØ sö dông trong thi ®Êu Cùc H¹n.")
        return
    end
    if (TargetNpcIndex == 0) then
        Talk(1, "no", "ChØ sö dông sau khi chän ng­êi ch¬i kh¸c trong thi ®Êu (®­a chuét vµo ng­êi ch¬i kh¸c, dïng phÝm t¾t).")
        return
    end
    local targetPlayerIndex = NpcIdx2PIdx(TargetNpcIndex)
    if (targetPlayerIndex == 0) then
        Talk(1, "no", "ChØ sö dông sau khi chän ng­êi ch¬i kh¸c trong thi ®Êu (®­a chuét vµo ng­êi ch¬i kh¸c, dïng phÝm t¾t).")
        return
    end
    if (targetPlayerIndex == PlayerIndex) then
        return
    end
    local useok = 0
    local srcPlayerName = GetName()
    local cachePlayerIndex = PlayerIndex
    PlayerIndex = targetPlayerIndex
    local taskDate2 = GetTaskWord(Task_Challenge_Enter, 1)
    local taskCount2 = GetTaskByte(Task_Challenge_Enter, 3)
    local taskStatus2 = GetTaskByte(Task_Challenge_Enter, 4)
    local enterRound2 = GetTaskByte(Task_Challenge_Growth, 4)
    local taskTop = GetTaskByte(Task_Challenge_Accept, 4)
    local targetPlayerName = GetName()
    if ((taskStatus ~= 0 or taskTop == 4) and taskStatus ~= 3 and taskDate2 == currentDay and enterRound2 == enterRound) then
        useok = 1
        AddIBBuff(648)
        TopMessage("B¹n bÞ ng­êi ch¬i kh¸c sö dông D­¬ng Chi Lé")
        Msg2Player("" .. srcPlayerName .. " Sö dông D­¬ng Chi Lé víi b¹n, lµm t¨ng tr¹ng th¸i KhÝ ®Þnh thÇn nhµn.")
    end
    PlayerIndex = cachePlayerIndex

    if (useok == 0) then
        Talk(1, "no", "ChØ sö dông sau khi chän ng­êi ch¬i kh¸c trong thi ®Êu (®­a chuét vµo ng­êi ch¬i kh¸c, dïng phÝm t¾t).")
        return
    end
    ClearItem(6, 1, 494, 0)
    TopMessage(" Sö dông Ngäc Phong Ch©m víi" .. targetPlayerName .. "Sö dông D­¬ng Chi Lé")
    Msg2Player("B¹n sö dông Ngäc Phong Ch©m víi" .. targetPlayerName .. " Sö dông D­¬ng Chi Lé, lµm t¨ng tr¹ng th¸i KhÝ ®Þnh thÇn nhµn.")
end

function no()
    CloseDialog()
end;
