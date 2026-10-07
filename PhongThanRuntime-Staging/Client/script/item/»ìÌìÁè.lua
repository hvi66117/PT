Task_Ring_Status = 1277
Task_Ring_Accept_Time = 1278
Task_Ring_BindingIndex = 1279
Task_Ring_BindingID = 1280

Task_Ring_NPC_FreezeTime = 1
Task_Ring_NPC_BuffATime = 2
Task_Ring_NPC_BuffBTime = 3
Task_Ring_NPC_BuffCTime = 4
Task_Ring_NPC_BuffDTime = 5

Global_Ring_EntryCount = 164

Buff_Ring_Going = 487
Buff_Ring_BuffA = 488
Buff_Ring_BuffB = 489
Buff_Ring_BuffC = 490
Buff_Ring_BuffD = 491

Task_Info_Ring = 1020

Task_Ring_Match_Second = 600

Ring_XY = {
    { x = 217 * 32, y = 191 * 32, desc = "[217.191]" },
    { x = 218 * 32, y = 191 * 32, desc = "[218.191]" },
    { x = 219 * 32, y = 191 * 32, desc = "[219.191]" },
    { x = 220 * 32, y = 191 * 32, desc = "[220.191]" },
    { x = 221 * 32, y = 191 * 32, desc = "[221.191]" },
    { x = 217 * 32, y = 190 * 32, desc = "[217.190]" },
    { x = 218 * 32, y = 190 * 32, desc = "[218.190]" },
    { x = 219 * 32, y = 190 * 32, desc = "[219.190]" },
    { x = 220 * 32, y = 190 * 32, desc = "[220.190]" },
    { x = 221 * 32, y = 190 * 32, desc = "[221.190]" },
}

Noon_Active_Event = 7
Noon_Active_Event_Day = 1
Noon_Active_Event_Num = 2

function Check_NoonActive_ON(nNum)
    if (IsWorldEventExist(Noon_Active_Event) == 0) then
        return 0
    end
    local nCurDay = math.floor(LocalSystemTime() / 86400);

    if GetWorldEventValue(Noon_Active_Event, Noon_Active_Event_Day) == nCurDay
            and GetWorldEventValue(Noon_Active_Event, Noon_Active_Event_Num) == nNum then
        return 1
    end

    return 0
end

function main()
    local weekDay = GetWeekDay()
    local H, M, S = GetHMS()

    local nNoonActiveOn = Check_NoonActive_ON(1);
    if nNoonActiveOn > 0 then
        if (H < 11 or H >= 14) then
            return
        end
    else
        if (weekDay ~= 1 or H < 19 or H >= 22) then
            DelNpc(TrapNpcIdx)
            return
        end
    end

    local mapid, x, y = GetWorldPos()
    if (mapid ~= 21) then
        Talk(1, "no", "VËt nµy chØ cã thÓ sö dông ë <c=g>TriÒu Ca<c>!")
        return
    end

    local localTime = LocalSystemTime()

    local nStartHour = 19
    if nNoonActiveOn > 0 then
        nStartHour = 11
    end
    local taskTime = math.mod(localTime, 86400) - 3600 * nStartHour

    local taskNumber = math.floor(taskTime / Task_Ring_Match_Second) + 1
    local taskGotime = math.mod(taskTime, Task_Ring_Match_Second)

    local taskStatus = GetTaskByte(Task_Ring_Status, 1)
    local taskStep = GetTaskByte(Task_Ring_Status, 2)
    if (taskStatus == 0) then
        Talk(1, "no", "VËt nµy chØ cã ng­êi nµo ®· ®· b¸o danh tham gia <c=g>Phong Háa L«i ®µi<c> ë LÔ quan (TriÒu Ca)míi cã thÓ sö dông!")
        return
    else
        local lastEntryTime = GetTask(Task_Ring_Accept_Time)

        local entryNumber = math.floor((math.mod(lastEntryTime, 86400) - 3600 * nStartHour) / Task_Ring_Match_Second) + 1
        if (math.floor(localTime / 86400) ~= math.floor(lastEntryTime / 86400)) then

            Talk(1, "no", "Hçn Thiªn L¨ng: §· qu¸ thêi h¹n <c=g>trËn Phong H¶o L«i §µi mµ b¹n<c> ®¨ng ký, h·y sö dông vµo lÇn sau.")
            return
        elseif (entryNumber < taskNumber) then
            Talk(1, "no", "Hçn Thiªn L¨ng: §· qu¸ thêi h¹n thi ®Êu cña <c=g>trËn Phong H¶o L«i §µi mµ b¹n<c> ®¨ng ký, h·y sö dông vµo lÇn sau.")
            return
        elseif (taskStep > 0) then
            Talk(1, "no", "TrËn thi ®Êu nµy b¹n ®· sö dông Hçn Thiªn L¨ng, kh«ng thÓ sö dông tiÕp!")
            return
        elseif (GetIBBuffCount() >= 26) then
            Talk(1, "no", "Trªn ng­êi b¹n cã qu¸ nhiÒu tr¹ng th¸i, kh«ngthÓ më Hçn Thiªn L¨ng nµy! Xin sö dông trang bÞ kh¸c vµo thi ®Êu!")
            return
        else
            local xyIdx = GetTaskByte(Task_Ring_Status, 3)
            local remainSecond = Task_Ring_Match_Second - taskGotime - 1
            if (HaveNormalItem(6, 1, 398, 1) > 0) then
                DelNormalItem(6, 1, 398, 1)
            else
                DelNormalItemInQuick(6, 1, 398, 1)
            end
            SetTaskByte(Task_Ring_Status, 2, 1)
            AddIBBuff(Buff_Ring_Going, remainSecond)
            TaskNote(Task_Info_Ring, 1)
            TopMessage("Mau mang Phong Háa lu©n ®Õn T©y m«n gÆp §¹i phu")
            Msg2Player("B¹n ®· cã thÓ kÝch ho¹t Phong Háa lu©n råi, mau mang nã ®Õn T©y m«n gÆp §¹i phu. Phong Háa lu©n cña b¹n ®ang ë täa ®é" .. Ring_XY[xyIdx].desc .. ".")
            Talk("B¹n ®· cã thÓ kÝch ho¹t Phong Háa lu©n råi, mau mang nã ®Õn T©y m«n gÆp §¹i phu. Phong Háa lu©n cña b¹n ®ang ë täa ®é" .. Ring_XY[xyIdx].desc .. ".")
        end
    end
end

function no()
    CloseDialog()
end
