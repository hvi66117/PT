Task_NotDieLamp = 1332
Task_LampID = 1335
Task_LampIdx = 1336

function main()
    local idx, x, y = GetWorldPos()

    if (idx ~= 73) then
        Talk(1, "no", "B¹n kh«ng ë BÊt Chu Thiªn quan")
        return
    end

    if (GetFightState() == 0) then
        Talk(1, "no", "B¹n kh«ng thÓ trång h¹t trong thµnh")
        return
    end

    local nTaskState = GetByte(GetTask(Task_NotDieLamp), 1)

    if (nTaskState == 0) then
        Talk(1, "no", GetName() .. "§©y lµ c¸i g× vËy? Liªn §¨ng Hé sø cã thÓ biÕt…")
        return
    end

    if (nTaskState ~= 1) then
        Talk(1, "no", GetName() .. "Ta kh«ng thÓ sö dông vËt phÈm nµy!")
        return
    end

    local newnpcidx = AddNpc(874, 1, SubWorld, (x + 1) * 32, y * 32)
    local newnpcid = GetNpcID(newnpcidx)
    SetTask(Task_LampID, newnpcid)
    SetTask(Task_LampIdx, newnpcidx)

    local playerid = GetPlayerID()
    local playeridx = PlayerIndex
    SetNpcTask(newnpcidx, 0, playeridx)
    SetNpcTask(newnpcidx, 1, playerid)

    x = (x + 1) / 8
    y = y / 16

    Msg2Player("B¹n ®· trång mÇm t¹i <HyperLinkWorldPos=\"²»ÖÜÌì¹Ø[73," .. x .. "," .. y .. "]\">!")

    if (HaveNormalItem(6, 1, 443, 0) > 0) then
        ClearItem(6, 1, 443, 0)
    end

    SetNpcName(newnpcidx, "Liªn ®¨ng")
    SetNpcScript(newnpcidx, "\\script\\item\\Á«µÆ.lua")
    AddIBBuff(534)
    SetNpcTimer(newnpcidx, "\\script\\ontimer\\É¾µô×Ô¼º.lua", 1800)
    SetTaskByte(Task_NotDieLamp, 1, 2)
    TaskNote(96, 1)
end;

function no()
    CloseDialog()
end
