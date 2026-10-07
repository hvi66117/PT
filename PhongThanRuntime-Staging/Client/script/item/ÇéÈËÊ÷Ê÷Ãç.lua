task_grouptree = 1314
partner_ID = 1315
chocolate_All = 1317
refreshDay = 1318
task_get_chocolate = 1316

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

    if (HaveNormalItem(6, 1, 445, 1) == 0) then
        return
    end

    local nWorldID, nX, nY = GetWorldPos()
    if (nWorldID ~= 17) then
        Talk(1, "no", "T«i kh«ng ph¶i lµ lo¹i c©y tÇm th­êng, chØ cã ®­îc trång ë <c=g>Kú S¬n<c> th× míi lín ®­îc!")
        return
    end

    local H, M, S = GetHMS()
    if Check_NoonActive_ON(4) > 0 then
        if (H < 11 or H >= 14) then
            return
        end
    else
        if ((GetWeekDay() ~= 4) or (H < 20) or (H >= 23)) then
            Talk(1, "no", "Chñ nh©n h×nh nh­ ®· trång sai giê råi! Xin xem l¹i thêi gian ho¹t ®éng!")
            return
        end
    end

    MsgBox("Chñ nh©n quyÕt ®Þnh trång t«i ë ®©y ­?", "throwTree", "no")

end

CareerAry = { [0] = "Gi¸p sÜ", [1] = "§¹o sÜ", [2] = "DÞ nh©n" }

function throwTree()

    CloseDialog()

    if (HaveNormalItem(6, 1, 445, 1) <= 0) then
        return
    end

    local nWorldID, nX, nY = GetWorldPos()

    local npcindex = AddNpc(815, 1, SubWorld, nX * 32, nY * 32)
    SetNpcName(npcindex, "<c=g>" .. GetName() .. "<c>-MÇm c©y")
    SetNpcTimer(npcindex, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 3600)
    SetNpcScript(npcindex, "\\script\\item\\ÇéÈËÊ÷.lua")

    SetTask(task_get_chocolate, npcindex)
    SetTask(refreshDay, GetNpcID(npcindex))
    SetTaskByte(partner_ID, 2, 2)

    SetNpcTask(npcindex, 2, GetPlayerID())

    ClearItem(6, 1, 445, 1)

    Msg2Player("B¹n ®· trång thµnh c«ng 1 MÇm c©y!")
    TaskNote(1029, 1, 0)

    Msg2CurMapAnnounce("<c=g>" .. CareerAry[GetSeries()] .. "<c><c=g><RoleName=\"" .. GetName() .. "\"><c> trång thµnh c«ng 1 MÇm c©y ë Kú S¬n!")
    WriteLog("ÈýÔÂáªÉ½: " .. GetName() .. "²Î¼Ó»î¶¯, ³É¹¦ÖÖÏÂÁËÊ÷Ãç")
end

function no()
    CloseDialog()
end
