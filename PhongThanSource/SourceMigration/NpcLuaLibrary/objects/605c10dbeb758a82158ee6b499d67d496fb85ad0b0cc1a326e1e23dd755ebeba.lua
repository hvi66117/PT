Task_Process = 1458

Task_Type = 1459
Task_Total_Times = 1460
Task_Accept_Day = 1461
Task_Coordinate = 1462
Task_MonsterID = 1463
Task_Free_Time = 1464

chenghuangNpcID = 1005
chenghuangID = 1003
lilingNpcID = 1006
lilingID = 1004
amberNum = 3
blastID = 1007
buffID = 682

questyKey = {
    [1] = { name = "Canh Håi Hån", key = 250 },
    [2] = { name = "Ng­ H×nh th¶o", key = 251 },
    [3] = { name = "Long Ng¹n th¶o", key = 252 }
}

taskItem = {
    [1] = { name = "Khu Ma phï", Item = { 6, 1, 517, 0 } },
    [2] = { name = "Hæ Ph¸ch Chi T©m", Item = { 3, 425, 0, 0 } },
    [3] = { name = "Hæ Ph¸ch Chi Hån", Item = { 3, 426, 0, 0 } },
    [4] = { name = "V« C¨n Hoa", Item = { 8, 683, 2, 0 } }
}

function OnDeath(npcindex)
    local mapid, x, y = GetNpcWorldPos(npcindex)
    if (GetTask(Task_MonsterID) == GetNpcID(npcindex) and GetTaskByte(Task_Process, 1) == 5) then
        local mapid, x, y = GetNpcWorldPos(npcindex)
        local blastX = GetTaskWord(Task_Coordinate, 1)
        local blastY = GetTaskWord(Task_Coordinate, 2)
        if ((blastX - x) ^ 2 + (blastY - y) ^ 2 < 500) and (HaveIBBuff(buffID) > 0) then
            SetTaskByte(Task_Process, 1, 6)
            AddEventItem(questyKey[3].key)

            TopMessage("NhËn ®­îc <c=yel>" .. questyKey[3].name)
            Msg2Player("§· hµn phôc Lª Linh Thi Phï Chó")
            TaskNote(1078, 3)
        elseif (((blastX - x) ^ 2 + (blastY - y) ^ 2 >= 500) and (HaveIBBuff(buffID)) > 0) then
            TopMessage("V× kh«ng cã Thiªn C­¬ng phï ph¸p, kh«ng thÓ lÊy ®­îc vËt g× h÷u dông tõ Lª Linh Thi chó")
            SetTaskByte(Task_Process, 1, 7)
            Msg2Player("V× kh«ng kÞp thêi sö dông Khu Ma phï, kh«ng thÓ lÊy ®­îc vËt g× h÷u dông tõ Lª Linh Thi chó.")
            TaskNote(1077, 6)
        else
            SetTaskByte(Task_Process, 1, 7)
            Msg2Player("V× kh«ng kÞp thêi sö dông Khu Ma phï, kh«ng thÓ lÊy ®­îc vËt g× h÷u dông tõ chç Thõa Hoµng ®¹i v­¬ng.")
            TaskNote(1077, 6)
        end
    end
    DelNpc(npcindex)
end

