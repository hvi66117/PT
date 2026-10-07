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

function main()
    local mapid, px, py = GetWorldPos()
    local item = taskItem[1].Item

    if (mapid ~= 75) then
        Talk(1, "no", "Kh«ng thÓ sö dông Khu Ma phï t¹i ®©y.")
        return
    end

    if (GetTaskByte(Task_Type, 1) == 1) then
        if (GetTaskByte(Task_Process, 1) ~= 5) then
            Talk(1, "no", "Khu Ma phï dïng ®Ó hµng phôc Thõa Hoµng ®¹i v­¬ng, ph¸ gi¶i Kim Cang BÊt Ho¹i cña chóng, hiÖn Thõa Hoµng ®¹i v­¬ng ch­a xuÊt hiÖn, ch­a cÇn sö dông.")
            return
        end
        local npcindex = GetTask(Task_Free_Time)
        if (GetNpcID(npcindex) ~= GetTask(Task_MonsterID)) then
            Talk(1, "no", "Thõa Hoµng ®¹i v­¬ng ®· biÕn mÊt, lµm l¹i cã thÓ dô Thõa Hoµng ®¹i v­¬ng xuÊt hiÖn l¹i!")
            return
        end
        if (GetIBBuffCount() >= 32) then
            Talk(1, "no", "B¹n ®ang cã qu¸ nhiÒu tr¹ng th¸i, l¸t sau thö l¹i.")
            return
        end

        ClearItem(item[1], item[2], item[3], item[4])
        AddIBBuff(buffID)
        AddNpc(blastID, 1, SubWorld, px * 32, py * 32)

        SetNpcTask(npcindex, 1, px)
        SetNpcTask(npcindex, 2, py)

        SetTaskWord(Task_Coordinate, 1, px)
        SetTaskWord(Task_Coordinate, 2, py)

        SetNpcTimer(npcindex, "\\script\\ontimer\\¸Ä±ä·ÀÓù.lua", 5)
        Msg2Player("Phãng thÝch Táa Yªu trËn, hµng phôc Thõa Hoµng ®¹i v­¬ng trong trËn nµy sÏ dÔ dµng h¬n!")
    elseif (GetTaskByte(Task_Type, 1) == 2) then
        if (GetTaskByte(Task_Process, 1) ~= 5) then
            Talk(1, "no", "Khu Ma phï dïng ®Ó hµng phôc Lª Linh Thi chó, ph¸ gi¶i Kim Cang BÊt Ho¹i cña chóng, hiÖn Lª Linh Thi chó ch­a xuÊt hiÖn, ch­a cÇn sö dông.")
            return
        end

        local npcindex = GetTask(Task_Free_Time)
        if (GetNpcID(npcindex) ~= GetTask(Task_MonsterID)) then
            Talk(1, "no", "Thõa Hoµng ®¹i v­¬ng ®· biÕn mÊt")
            return
        end
        if (GetIBBuffCount() >= 32) then
            Talk(1, "no", "B¹n ®ang cã qu¸ nhiÒu tr¹ng th¸i, l¸t sau thö l¹i.")
            return
        end

        ClearItem(item[1], item[2], item[3], item[4])
        AddIBBuff(buffID)
        AddNpc(blastID, 1, SubWorld, px * 32, py * 32)

        SetNpcTask(npcindex, 1, px)
        SetNpcTask(npcindex, 2, py)

        SetTaskWord(Task_Coordinate, 1, px)
        SetTaskWord(Task_Coordinate, 2, py)

        SetNpcTimer(npcindex, "\\script\\ontimer\\¸Ä±ä·ÀÓù.lua", 5)
        Msg2Player("Phãng thÝch Táa Yªu trËn, hµng phôc Lª Linh Thi chó trong trËn nµy sÏ dÔ dµng h¬n!")
    end
end

function no()
    CloseDialog()
end
