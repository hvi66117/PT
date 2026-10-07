Task_Kite_Status = 1365
Task_Kite_Accept_Time = 1366
Task_Kite_Height = 1367

Global_Kite_EntryCount = 181
Global_Kite_Circle = 182

Task_Kite_Match_Second = 300
Half_Match = 150
Match_loops = 36
Initial_Height = 100
Limit_Height = 2500

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
    local m, x, y = GetWorldPos()

    if (m ~= 11) then
        Msg2Player("VËt phÈm nµy chØ sö dông t¹i Du Hån Quan!")
        return
    end

    midx = SubWorldID2Idx(11);
    if (midx == -1) then
        return
    end ;
    SubWorld = midx

    local idx = 0;
    local nLastIdx = -1
    local nNotKickPlayer = 0
    local flag = 0
    while 1 do
        idx, pidx = GetNextPlayer(10, nNotKickPlayer, 0);
        if (idx == 0) then
            break ;
        end ;

        if (nLastIdx == pidx) then
            nNotKickPlayer = idx
        else
            nLastIdx = pidx
            if (PlayerIndex == pidx) then
                flag = 1
            end
        end
    end ;

    if (flag == 0) then
        Msg2Player("Ph¶i th«ng qua LÔ Quan vµo khu thi th¶ diÒu míi cã thÓ sö dông ®¹o cô")
        return
    end

    local nHour = 19
    if Check_NoonActive_ON(6) > 0 then
        nHour = 11
    end

    local taskStatus = GetTaskByte(Task_Kite_Status, 1)
    local localTime = LocalSystemTime()
    local taskTime = math.mod(localTime, 86400) - 3600 * nHour
    local taskGotime = math.mod(taskTime, Task_Kite_Match_Second)
    local remainSecond = Task_Kite_Match_Second - taskGotime - 1

    if (taskStatus == 1 and remainSecond > 0 and remainSecond < Task_Kite_Match_Second) then
        ClearItem(6, 1, 473, 0)
        SetTaskByte(Task_Kite_Status, 1, 2)
        SetTaskWord(Task_Kite_Height, 1, Initial_Height)
        SetTaskWord(Task_Kite_Height, 2, Initial_Height)
        AddIBBuff(627, remainSecond)
        PlayerCastSkill(1, 221, 1)
        SetTaskByte(1365, 2, 100)
        ScrollMessage("DiÒu ®ang bay rÊt tèt, cè g¾ng ®iÒu khiÓn cho nã bay cao thªm nhÐ!")
        Msg2Player("DiÒu cña b¹n ®ang bay rÊt tèt, cè g¾ng ®iÒu khiÓn cho nã bay cao thªm nhÐ!")
    end
end
